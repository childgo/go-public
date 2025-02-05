#sudo su -c "curl -o /root/Magic_SG.py https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/SG_Linux9_DNS/Magic_SG.py && dnf install -y python3 && python3 /root/Magic_SG.py"

#For Test
#dig @127.0.0.1 gmail.com
#dig @127.0.0.1 msn.com

#--------------------------------------------------------------------------------
#Start Install
#--------------------------------------------------------------------------------

import socket
import struct
import subprocess
import json

# Configuration
ALSCO_Secure_Gateway_LISTEN_IP = "0.0.0.0"
ALSCO_Secure_Gateway_LISTEN_PORT = 53
ALSCO_Secure_Gateway_UPSTREAM_DNS = "http://66.111.53.76:80/SecureGateway-dns-query"

# Start UDP socket for DNS requests
ALSCO_Secure_Gateway_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
ALSCO_Secure_Gateway_sock.bind((ALSCO_Secure_Gateway_LISTEN_IP, ALSCO_Secure_Gateway_LISTEN_PORT))

print(f"\U0001F525 Secure Gateway by ALSCO DNS running on {ALSCO_Secure_Gateway_LISTEN_IP}:{ALSCO_Secure_Gateway_LISTEN_PORT}")

# Function to extract domain name from raw DNS query
def ALSCO_Secure_Gateway_extract_domain(ALSCO_Secure_Gateway_data):
    ALSCO_Secure_Gateway_domain = []
    ALSCO_Secure_Gateway_idx = 12  # DNS query name starts at byte 12
    ALSCO_Secure_Gateway_length = ALSCO_Secure_Gateway_data[ALSCO_Secure_Gateway_idx]

    while ALSCO_Secure_Gateway_length:
        ALSCO_Secure_Gateway_domain.append(ALSCO_Secure_Gateway_data[ALSCO_Secure_Gateway_idx+1:ALSCO_Secure_Gateway_idx+1+ALSCO_Secure_Gateway_length].decode("utf-8"))
        ALSCO_Secure_Gateway_idx += ALSCO_Secure_Gateway_length + 1
        ALSCO_Secure_Gateway_length = ALSCO_Secure_Gateway_data[ALSCO_Secure_Gateway_idx]

    return ".".join(ALSCO_Secure_Gateway_domain)

# Function to build a proper DNS response
def ALSCO_Secure_Gateway_build_dns_response(ALSCO_Secure_Gateway_query, ALSCO_Secure_Gateway_ip_address):
    ALSCO_Secure_Gateway_transaction_id = ALSCO_Secure_Gateway_query[:2]  # Keep transaction ID from original request
    ALSCO_Secure_Gateway_flags = struct.pack("!H", 0x8180)  # Standard response flags
    ALSCO_Secure_Gateway_qdcount = ALSCO_Secure_Gateway_query[4:6]  # Copy QDCOUNT (Question count)
    ALSCO_Secure_Gateway_ancount = struct.pack("!H", 1)  # 1 Answer record
    ALSCO_Secure_Gateway_nscount = ALSCO_Secure_Gateway_arcount = struct.pack("!H", 0)  # No authority/additional records

    # Question section (copied from request)
    ALSCO_Secure_Gateway_question = ALSCO_Secure_Gateway_query[12:]

    # Answer section
    ALSCO_Secure_Gateway_name = struct.pack("!B", 0xc0) + struct.pack("!B", 0x0c)  # Pointer to domain name
    ALSCO_Secure_Gateway_type_class = struct.pack("!H", 1) + struct.pack("!H", 1)  # Type A, Class IN
    ALSCO_Secure_Gateway_ttl = struct.pack("!I", 300)  # TTL of 300 seconds
    ALSCO_Secure_Gateway_rdlength = struct.pack("!H", 4)  # IPv4 address is 4 bytes
    ALSCO_Secure_Gateway_rdata = socket.inet_aton(ALSCO_Secure_Gateway_ip_address)  # Convert IP string to bytes

    ALSCO_Secure_Gateway_response = (
        ALSCO_Secure_Gateway_transaction_id + ALSCO_Secure_Gateway_flags + ALSCO_Secure_Gateway_qdcount +
        ALSCO_Secure_Gateway_ancount + ALSCO_Secure_Gateway_nscount + ALSCO_Secure_Gateway_arcount +
        ALSCO_Secure_Gateway_question + ALSCO_Secure_Gateway_name + ALSCO_Secure_Gateway_type_class +
        ALSCO_Secure_Gateway_ttl + ALSCO_Secure_Gateway_rdlength + ALSCO_Secure_Gateway_rdata
    )
    return ALSCO_Secure_Gateway_response

# Main loop to handle DNS queries
while True:
    ALSCO_Secure_Gateway_data, ALSCO_Secure_Gateway_addr = ALSCO_Secure_Gateway_sock.recvfrom(512)  # Receive DNS request
    ALSCO_Secure_Gateway_domain = ALSCO_Secure_Gateway_extract_domain(ALSCO_Secure_Gateway_data)

    print(f"\U0001F50D ALSCO Secure Gateway DNS Query: {ALSCO_Secure_Gateway_domain}")

    # Forward the query to the upstream DNS server via HTTP
    ALSCO_Secure_Gateway_response = subprocess.run(
        ["curl", "-s", f"{ALSCO_Secure_Gateway_UPSTREAM_DNS}?name={ALSCO_Secure_Gateway_domain}&type=A"],
        capture_output=True,
        text=True
    ).stdout

    # Parse the JSON response
    try:
        ALSCO_Secure_Gateway_dns_data = json.loads(ALSCO_Secure_Gateway_response)
        ALSCO_Secure_Gateway_ip_address = ALSCO_Secure_Gateway_dns_data["Answer"][0]["data"]  # Get the first A record
    except (KeyError, IndexError, json.JSONDecodeError):
        ALSCO_Secure_Gateway_ip_address = "0.0.0.0"  # Return a blank response if no record found

    print(f"\u2705 {ALSCO_Secure_Gateway_domain} -> {ALSCO_Secure_Gateway_ip_address}")

    # Send valid DNS response
    ALSCO_Secure_Gateway_dns_response = ALSCO_Secure_Gateway_build_dns_response(ALSCO_Secure_Gateway_data, ALSCO_Secure_Gateway_ip_address)
    ALSCO_Secure_Gateway_sock.sendto(ALSCO_Secure_Gateway_dns_response, ALSCO_Secure_Gateway_addr)
