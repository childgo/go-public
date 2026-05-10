#!/usr/bin/env python3
import socket
import struct
import json
from urllib.request import urlopen, Request
from urllib.parse import urlencode

LISTEN_IP = "0.0.0.0"
LISTEN_PORT = 53
UPSTREAM_DNS = "http://66.111.53.72/SecureGateway-dns-query"
TTL_DEFAULT = 300

QTYPE_MAP = {
    1: "A",
    2: "NS",
    5: "CNAME",
    6: "SOA",
    15: "MX",
    16: "TXT",
    28: "AAAA",
}

TYPE_NUM = {v: k for k, v in QTYPE_MAP.items()}


def parse_query(data):
    labels = []
    idx = 12

    while True:
        length = data[idx]

        if length == 0:
            idx += 1
            break

        labels.append(data[idx + 1:idx + 1 + length].decode("utf-8", "ignore"))
        idx += length + 1

    qtype, qclass = struct.unpack("!HH", data[idx:idx + 4])
    question = data[12:idx + 4]
    domain = ".".join(labels)

    return domain, qtype, qclass, question


def encode_domain(name):
    name = str(name).rstrip(".")
    result = b""

    if not name:
        return b"\x00"

    for part in name.split("."):
        b = part.encode("utf-8")
        result += struct.pack("!B", len(b)) + b

    return result + b"\x00"


def upstream_query(domain, qtype_name):
    url = UPSTREAM_DNS + "?" + urlencode({
        "name": domain,
        "type": qtype_name
    })

    req = Request(url, headers={"User-Agent": "SecureGateway-DNS/4.0"})
    raw = urlopen(req, timeout=10).read().decode("utf-8", "ignore")

    return json.loads(raw)


def make_rdata(record_type, data):
    data = str(data).strip().strip('"')

    if record_type == "A":
        try:
            return socket.inet_aton(data)
        except Exception:
            return None

    if record_type == "AAAA":
        try:
            return socket.inet_pton(socket.AF_INET6, data)
        except Exception:
            return None

    if record_type in ("NS", "CNAME"):
        return encode_domain(data)

    if record_type == "MX":
        parts = data.split()

        if len(parts) >= 2 and parts[0].isdigit():
            priority = int(parts[0])
            host = parts[1]
        else:
            priority = 10
            host = data

        return struct.pack("!H", priority) + encode_domain(host)

    if record_type == "TXT":
        text = data.encode("utf-8")

        if len(text) > 255:
            text = text[:255]

        return struct.pack("!B", len(text)) + text

    if record_type == "SOA":
        # Expected format:
        # ns1.example.com. hostmaster.example.com. 2026051001 3600 1800 1209600 300
        parts = data.split()

        if len(parts) < 7:
            return None

        try:
            mname = parts[0]
            rname = parts[1]
            serial = int(parts[2])
            refresh = int(parts[3])
            retry = int(parts[4])
            expire = int(parts[5])
            minimum = int(parts[6])

            return (
                encode_domain(mname) +
                encode_domain(rname) +
                struct.pack("!IIIII", serial, refresh, retry, expire, minimum)
            )
        except Exception:
            return None

    return None


def convert_answers(dns_json, requested_type):
    answers = []

    for item in dns_json.get("Answer", []):
        try:
            item_type_num = int(item.get("type", 0))
        except Exception:
            continue

        item_type = QTYPE_MAP.get(item_type_num)

        if not item_type:
            continue

        if item_type != requested_type and item_type != "CNAME":
            continue

        rdata = make_rdata(item_type, item.get("data", ""))

        if not rdata:
            continue

        try:
            ttl = int(item.get("TTL", TTL_DEFAULT))
        except Exception:
            ttl = TTL_DEFAULT

        answers.append({
            "type": item_type,
            "ttl": ttl,
            "rdata": rdata
        })

    return answers


def build_response(query, question, answers, rcode=0):
    transaction_id = query[:2]

    # 0x8180 = standard DNS response, recursion available, no error
    flags = 0x8180 | rcode

    response = (
        transaction_id +
        struct.pack("!H", flags) +
        struct.pack("!H", 1) +
        struct.pack("!H", len(answers)) +
        struct.pack("!H", 0) +
        struct.pack("!H", 0) +
        question
    )

    for answer in answers:
        response += b"\xc0\x0c"
        response += struct.pack("!H", TYPE_NUM[answer["type"]])
        response += struct.pack("!H", 1)
        response += struct.pack("!I", answer["ttl"])
        response += struct.pack("!H", len(answer["rdata"]))
        response += answer["rdata"]

    return response


def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((LISTEN_IP, LISTEN_PORT))

    print("Secure Gateway DNS running on {}:{}".format(LISTEN_IP, LISTEN_PORT), flush=True)

    while True:
        data, addr = sock.recvfrom(4096)

        try:
            domain, qtype_num, qclass, question = parse_query(data)
            qtype_name = QTYPE_MAP.get(qtype_num)

            if not qtype_name:
                print("Unsupported query type {} for {}".format(qtype_num, domain), flush=True)
                response = build_response(data, question, [], rcode=4)
                sock.sendto(response, addr)
                continue

            print("Query: {} type={}".format(domain, qtype_name), flush=True)

            dns_json = upstream_query(domain, qtype_name)
            answers = convert_answers(dns_json, qtype_name)

            print("Answer count: {}".format(len(answers)), flush=True)

            response = build_response(data, question, answers, rcode=0)
            sock.sendto(response, addr)

        except Exception as e:
            print("ERROR: {}".format(e), flush=True)

            try:
                response = build_response(data, data[12:], [], rcode=2)
                sock.sendto(response, addr)
            except Exception:
                pass


if __name__ == "__main__":
    main()
