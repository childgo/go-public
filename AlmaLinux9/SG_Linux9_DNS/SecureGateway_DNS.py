#sudo su -c "curl -o /root/SecureGateway_DNS.py https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/SecureGateway_DNS.py && dnf install -y python3 && python3 /root/Magic_SG.py"

#For Test
#dig @127.0.0.1 gmail.com
#dig @127.0.0.1 msn.com

#--------------------------------------------------------------------------------
#Start Install
#--------------------------------------------------------------------------------
from __future__ import print_function

import socket
import struct
import subprocess
import json
import sys
import ipaddress
import re


if sys.version_info.major == 3:
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except AttributeError:
        pass  # Ignore if running on Python <3.7
elif sys.version_info.major == 2:
    import codecs
    sys.stdout = codecs.getwriter('utf-8')(sys.stdout)



# Configuration
ALSCO_Secure_Gateway_LISTEN_IP = "0.0.0.0"
ALSCO_Secure_Gateway_LISTEN_PORT = 53
ALSCO_Secure_Gateway_UPSTREAM_DNS = "http://66.111.53.72:80/SecureGateway-dns-query"

# Start UDP socket for DNS requests
try:
    ALSCO_Secure_Gateway_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    ALSCO_Secure_Gateway_sock.bind((ALSCO_Secure_Gateway_LISTEN_IP, ALSCO_Secure_Gateway_LISTEN_PORT))
except OSError as e:
    if "Address already in use" in str(e):
        print(u"\u26A0 Sorry, you need to close any service using port 53 before running this script.\n".format())

        print(u"\u26A0 Error: {}\n".format(e))



        print("To Check, Try: sudo netstat -tulnp | grep :53 , sudo lsof -i :53 , sudo ss -tulnp | grep :53 ")
        print("For PowerDNS, Try: sudo systemctl stop pdns.\n".format())
        print("For PowerDNS, Try: sudo systemctl disable pdns.\n".format())


        print("For BindDNS, Try: sudo systemctl stop named.\n".format())
        print("For BindDNS, Try: sudo systemctl disable named.\n".format())

        print("For dnsmasqDNS, Try: sudo systemctl stop dnsmasq.\n".format())
        print("For dnsmasqDNS, Try: sudo systemctl disable dnsmasq.\n".format())

    else:
        print(u"\n? Error: {}\n".format(e))

    sys.exit(1)

#print(f"\U0001F525 Secure Gateway by ALSCO DNS running on {ALSCO_Secure_Gateway_LISTEN_IP}:{ALSCO_Secure_Gateway_LISTEN_PORT}")
print(u"\U0001F525 Secure Gateway by ALSCO DNS running on {}:{}".format(ALSCO_Secure_Gateway_LISTEN_IP, ALSCO_Secure_Gateway_LISTEN_PORT))


# Function to extract domain name from raw DNS query







# Function to extract domain name from raw DNS query
def ALSCO_Secure_Gateway_extract_domain(ALSCO_Secure_Gateway_data):
    ALSCO_Secure_Gateway_domain = []
    ALSCO_Secure_Gateway_idx = 12  # DNS query name starts at byte 12

    # Ensure ALSCO_Secure_Gateway_length is an integer in both Python 2 & 3
    ALSCO_Secure_Gateway_length = ALSCO_Secure_Gateway_data[ALSCO_Secure_Gateway_idx]
    if isinstance(ALSCO_Secure_Gateway_length, str):  # Python 2
        ALSCO_Secure_Gateway_length = ord(ALSCO_Secure_Gateway_length)

    while ALSCO_Secure_Gateway_length:
        domain_part = ALSCO_Secure_Gateway_data[ALSCO_Secure_Gateway_idx+1:ALSCO_Secure_Gateway_idx+1+ALSCO_Secure_Gateway_length]
        
        # Ensure decoding only in Python 3
        if isinstance(domain_part, bytes):
            domain_part = domain_part.decode("utf-8")
        
        ALSCO_Secure_Gateway_domain.append(domain_part)
        
        ALSCO_Secure_Gateway_idx += ALSCO_Secure_Gateway_length + 1
        ALSCO_Secure_Gateway_length = ALSCO_Secure_Gateway_data[ALSCO_Secure_Gateway_idx]
        if isinstance(ALSCO_Secure_Gateway_length, str):  # Python 2
            ALSCO_Secure_Gateway_length = ord(ALSCO_Secure_Gateway_length)

    return ".".join(ALSCO_Secure_Gateway_domain)



# Function to validate IPv4 addresses
def is_valid_ipv4(ip):
    ipv4_pattern = re.compile(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$")
    return bool(ipv4_pattern.match(ip))




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
    #ALSCO_Secure_Gateway_rdata = socket.inet_aton(ALSCO_Secure_Gateway_ip_address)  # Convert IP string to bytes
    ALSCO_Secure_Gateway_rdata = socket.inet_aton("0.0.0.0" if not is_valid_ipv4(ALSCO_Secure_Gateway_ip_address) else ALSCO_Secure_Gateway_ip_address)


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

    #print(f"\U0001F50D ALSCO Secure Gateway DNS Query: {ALSCO_Secure_Gateway_domain}")
    print(u"\U0001F50D ALSCO Secure Gateway DNS Query: {}".format(ALSCO_Secure_Gateway_domain))


    # Forward the query to the upstream DNS server via HTTP


    if sys.version_info.major == 3:
        proc = subprocess.Popen(
            ["curl", "-s", "{}?name={}&type=A".format(ALSCO_Secure_Gateway_UPSTREAM_DNS, ALSCO_Secure_Gateway_domain)],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        ALSCO_Secure_Gateway_response, _ = proc.communicate()
        ALSCO_Secure_Gateway_response = ALSCO_Secure_Gateway_response.decode('utf-8') if isinstance(ALSCO_Secure_Gateway_response, bytes) else ALSCO_Secure_Gateway_response
    else:
        proc = subprocess.Popen(
            ["curl", "-s", "{}?name={}&type=A".format(ALSCO_Secure_Gateway_UPSTREAM_DNS, ALSCO_Secure_Gateway_domain)],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        ALSCO_Secure_Gateway_response, _ = proc.communicate()




    # Parse the JSON response
    try:
        ALSCO_Secure_Gateway_dns_data = json.loads(ALSCO_Secure_Gateway_response)
        
        # Ensure "Answer" key exists and is not empty




        ALSCO_Secure_Gateway_ip_address = ALSCO_Secure_Gateway_dns_data.get("Answer", [{}])[0].get("data", "0.0.0.0")
        if ALSCO_Secure_Gateway_ip_address == "0.0.0.0":
            #print(u"\u26A0 No valid DNS record found for {}".format(ALSCO_Secure_Gateway_domain))
            print(u"\u26A0 No valid DNS record found for {}".format(ALSCO_Secure_Gateway_domain))






    except (json.JSONDecodeError, KeyError, IndexError, ValueError) as e:
        ALSCO_Secure_Gateway_ip_address = "0.0.0.0"
        #print(f"\U0001F6A8 JSON Parsing Error: {e}")
        print(u"\U0001F6A8 JSON Parsing Error: {}".format(e))




    #print(f"\u2705 {ALSCO_Secure_Gateway_domain} -> {ALSCO_Secure_Gateway_ip_address}")
    print(u"\u2705 {} -> {}".format(ALSCO_Secure_Gateway_domain, ALSCO_Secure_Gateway_ip_address))











    # Send valid DNS response
    ALSCO_Secure_Gateway_dns_response = ALSCO_Secure_Gateway_build_dns_response(ALSCO_Secure_Gateway_data, ALSCO_Secure_Gateway_ip_address)
    ALSCO_Secure_Gateway_sock.sendto(ALSCO_Secure_Gateway_dns_response, ALSCO_Secure_Gateway_addr)
