#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/NewInstall.sh)
# =============================================================================
#  ALSCO SecureGateway DNS - Smart Manager
#  Usage:
#    bash sg_manager.sh install    → Full install + enable service
#    bash sg_manager.sh enable     → Start + enable service
#    bash sg_manager.sh disable    → Stop + disable service
#    bash sg_manager.sh status     → Show current status
#    bash sg_manager.sh uninstall  → Full removal
#    bash sg_manager.sh            → Interactive menu
# =============================================================================

SCRIPT_PATH="/opt/SecureGateway_DNS.py"
SERVICE_NAME="SecureGateway_DNS"
SERVICE_PATH="/etc/systemd/system/${SERVICE_NAME}.service"
RESOLV_CONF="/etc/resolv.conf"
LOG_FILE="/var/log/SecureGateway_DNS.log"
GITHUB_RAW="https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/SecureGateway_DNS.py"

# ---------- Colors ----------
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

# ---------- Helpers ----------
info()    { echo -e "${CYAN}ℹ  $*${RESET}"; }
success() { echo -e "${GREEN}✅ $*${RESET}"; }
warn()    { echo -e "${YELLOW}⚠  $*${RESET}"; }
error()   { echo -e "${RED}❌ $*${RESET}"; }
header()  { echo -e "\n${BOLD}${CYAN}$*${RESET}\n"; }

check_root() {
    if [ "$EUID" -ne 0 ]; then
        error "Please run as root: sudo bash $0 $1"
        exit 1
    fi
}

# ---------- Status Check ----------
get_status() {
    SERVICE_ACTIVE=$(systemctl is-active "$SERVICE_NAME" 2>/dev/null)
    SERVICE_ENABLED=$(systemctl is-enabled "$SERVICE_NAME" 2>/dev/null)
    SCRIPT_EXISTS="no"; [ -f "$SCRIPT_PATH" ] && SCRIPT_EXISTS="yes"
    PORT_OWNER=$(ss -tulnp 2>/dev/null | grep ':53 ' | awk '{print $NF}' | grep -oP '(?<=\().*(?=,)' | head -1)
    [ -z "$PORT_OWNER" ] && PORT_OWNER="none"
}

show_status() {
    get_status
    header "═══  SecureGateway DNS Status  ═══"
    echo -e "  Script installed : $([ "$SCRIPT_EXISTS" = "yes" ] && echo "${GREEN}Yes${RESET}" || echo "${RED}No${RESET}")"
    echo -e "  Service active   : $([ "$SERVICE_ACTIVE" = "active" ] && echo "${GREEN}active${RESET}" || echo "${RED}${SERVICE_ACTIVE}${RESET}")"
    echo -e "  Service enabled  : $([ "$SERVICE_ENABLED" = "enabled" ] && echo "${GREEN}enabled${RESET}" || echo "${YELLOW}${SERVICE_ENABLED}${RESET}")"
    echo -e "  Port 53 owner    : ${CYAN}${PORT_OWNER}${RESET}"
    echo ""
}

# ---------- Free Port 53 ----------
free_port_53() {
    info "Checking port 53..."
    for SVC in pdns named dnsmasq systemd-resolved; do
        if systemctl is-active "$SVC" &>/dev/null; then
            warn "Stopping $SVC..."
            systemctl stop "$SVC" && systemctl disable "$SVC"
            success "Stopped and disabled $SVC"
        fi
    done
    # Hard kill anything still on 53
    PIDS=$(lsof -ti :53 2>/dev/null)
    if [ -n "$PIDS" ]; then
        warn "Force-killing remaining processes on port 53: $PIDS"
        kill -9 $PIDS 2>/dev/null
    fi
    sleep 1
}

# ---------- Deploy Script ----------
deploy_script() {
    info "Deploying SecureGateway_DNS.py to $SCRIPT_PATH ..."

    # Try GitHub first
    if curl -sf --connect-timeout 10 -o "$SCRIPT_PATH" "$GITHUB_RAW"; then
        # Verify it's actually Python, not a 404 page
        if head -1 "$SCRIPT_PATH" | grep -q "404\|Not Found"; then
            warn "GitHub returned 404, using bundled script..."
            write_bundled_script
        else
            success "Downloaded from GitHub"
        fi
    else
        warn "GitHub unreachable, using bundled script..."
        write_bundled_script
    fi

    chmod +x "$SCRIPT_PATH"
}

# ---------- Bundled Script (fallback) ----------
write_bundled_script() {
    info "Writing bundled SecureGateway_DNS.py..."
    cat > "$SCRIPT_PATH" << 'PYEOF'
from __future__ import print_function
import socket, struct, subprocess, json, sys, re

if sys.version_info.major == 3:
    try: sys.stdout.reconfigure(encoding='utf-8')
    except AttributeError: pass
elif sys.version_info.major == 2:
    import codecs
    sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

LISTEN_IP   = "0.0.0.0"
LISTEN_PORT = 53
UPSTREAM    = "http://66.111.53.72:80/SecureGateway-dns-query"

try:
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((LISTEN_IP, LISTEN_PORT))
except OSError as e:
    print(u"\u26A0 Error: {}".format(e))
    sys.exit(1)

print(u"\U0001F525 Secure Gateway by ALSCO DNS running on {}:{}".format(LISTEN_IP, LISTEN_PORT))

def extract_domain(data):
    parts, idx = [], 12
    length = data[idx]
    if isinstance(length, str): length = ord(length)
    while length:
        part = data[idx+1:idx+1+length]
        if isinstance(part, bytes): part = part.decode("utf-8")
        parts.append(part)
        idx += length + 1
        length = data[idx]
        if isinstance(length, str): length = ord(length)
    return ".".join(parts)

def is_valid_ipv4(ip):
    return bool(re.match(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$", ip))

def build_response(query, ip):
    tid   = query[:2]
    flags = struct.pack("!H", 0x8180)
    qdc   = query[4:6]
    anc   = struct.pack("!H", 1)
    nsc   = arc = struct.pack("!H", 0)
    question = query[12:]
    name  = struct.pack("!BB", 0xc0, 0x0c)
    tc    = struct.pack("!HH", 1, 1)
    ttl   = struct.pack("!I", 300)
    rdl   = struct.pack("!H", 4)
    rdata = socket.inet_aton("0.0.0.0" if not is_valid_ipv4(ip) else ip)
    return tid+flags+qdc+anc+nsc+arc+question+name+tc+ttl+rdl+rdata

while True:
    data, addr = sock.recvfrom(512)
    domain = extract_domain(data)
    print(u"\U0001F50D Query: {}".format(domain))
    try:
        proc = subprocess.Popen(
            ["curl", "-s", "{}?name={}&type=A".format(UPSTREAM, domain)],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, _ = proc.communicate()
        if isinstance(out, bytes): out = out.decode('utf-8')
        dns_data = json.loads(out)
        ip = dns_data.get("Answer", [{}])[0].get("data", "0.0.0.0")
    except Exception as e:
        ip = "0.0.0.0"
        print(u"\U0001F6A8 Error: {}".format(e))
    print(u"\u2705 {} -> {}".format(domain, ip))
    sock.sendto(build_response(data, ip), addr)
PYEOF
    success "Bundled script written"
}

# ---------- Create systemd Service ----------
create_service() {
    info "Creating systemd service..."
    cat > "$SERVICE_PATH" << EOF
[Unit]
Description=ALSCO Secure Gateway DNS Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 ${SCRIPT_PATH}
Restart=always
RestartSec=5
User=root
Group=root
WorkingDirectory=/opt
StandardOutput=journal
StandardError=journal
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    success "Systemd service created"
}

# ---------- Configure resolv.conf ----------
configure_dns() {
    info "Configuring /etc/resolv.conf..."
    chattr -i "$RESOLV_CONF" 2>/dev/null
    echo "nameserver 127.0.0.1" > "$RESOLV_CONF"
    chattr +i "$RESOLV_CONF"
    systemctl restart NetworkManager 2>/dev/null || true
    success "resolv.conf locked to 127.0.0.1"
}

# ---------- INSTALL ----------
do_install() {
    check_root install
    header "🔥 Installing ALSCO SecureGateway DNS..."
    free_port_53
    deploy_script
    create_service
    configure_dns
    systemctl enable "$SERVICE_NAME"
    systemctl start  "$SERVICE_NAME"
    sleep 2
    show_status
    info "Testing DNS resolution..."
    if dig @127.0.0.1 gmail.com +short +time=3 &>/dev/null; then
        success "DNS test passed! gmail.com resolved successfully."
    else
        warn "DNS test inconclusive. Check: journalctl -u $SERVICE_NAME -n 20"
    fi
    success "Installation complete!"
}

# ---------- ENABLE ----------
do_enable() {
    check_root enable
    header "▶  Enabling SecureGateway DNS..."
    free_port_53
    if [ ! -f "$SCRIPT_PATH" ]; then
        warn "Script not found, deploying first..."
        deploy_script
    fi
    if [ ! -f "$SERVICE_PATH" ]; then
        create_service
    fi
    configure_dns
    systemctl enable "$SERVICE_NAME"
    systemctl start  "$SERVICE_NAME"
    sleep 1
    show_status
    success "SecureGateway DNS enabled!"
}

# ---------- DISABLE ----------
do_disable() {
    check_root disable
    header "⏹  Disabling SecureGateway DNS..."
    systemctl stop    "$SERVICE_NAME" 2>/dev/null || true
    systemctl disable "$SERVICE_NAME" 2>/dev/null || true
    # Restore resolv.conf to public DNS
    info "Restoring /etc/resolv.conf to public DNS..."
    chattr -i "$RESOLV_CONF" 2>/dev/null
    printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > "$RESOLV_CONF"
    systemctl restart NetworkManager 2>/dev/null || true
    show_status
    success "SecureGateway DNS disabled. Using 8.8.8.8 now."
}

# ---------- UNINSTALL ----------
do_uninstall() {
    check_root uninstall
    header "🗑  Uninstalling SecureGateway DNS..."
    systemctl stop    "$SERVICE_NAME" 2>/dev/null || true
    systemctl disable "$SERVICE_NAME" 2>/dev/null || true
    rm -f "$SERVICE_PATH"
    systemctl daemon-reload
    rm -f "$SCRIPT_PATH"
    rm -f "$LOG_FILE"
    chattr -i "$RESOLV_CONF" 2>/dev/null
    printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > "$RESOLV_CONF"
    systemctl restart NetworkManager 2>/dev/null || true
    success "Uninstall complete. All files removed."
}

# ---------- Interactive Menu ----------
show_menu() {
    clear
    get_status
    echo -e "${BOLD}${CYAN}"
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║   ALSCO SecureGateway DNS Manager    ║"
    echo "  ╚══════════════════════════════════════╝"
    echo -e "${RESET}"
    echo -e "  Service : $([ "$SERVICE_ACTIVE" = "active" ] && echo "${GREEN}● RUNNING${RESET}" || echo "${RED}● STOPPED${RESET}")   Enabled: $([ "$SERVICE_ENABLED" = "enabled" ] && echo "${GREEN}YES${RESET}" || echo "${RED}NO${RESET}")"
    echo -e "  Port 53 : ${CYAN}${PORT_OWNER}${RESET}"
    echo ""
    echo "  ┌─────────────────────────────────────┐"
    echo "  │  1) Install (full setup)            │"
    echo "  │  2) Enable  (start service)         │"
    echo "  │  3) Disable (stop service)          │"
    echo "  │  4) Status                          │"
    echo "  │  5) Uninstall (remove everything)   │"
    echo "  │  6) Exit                            │"
    echo "  └─────────────────────────────────────┘"
    echo ""
    read -rp "  Choose [1-6]: " CHOICE
    case "$CHOICE" in
        1) do_install   ;;
        2) do_enable    ;;
        3) do_disable   ;;
        4) show_status  ;;
        5) do_uninstall ;;
        6) exit 0       ;;
        *) warn "Invalid choice" ;;
    esac
}

# ---------- Entry Point ----------
case "${1,,}" in
    install)   do_install   ;;
    enable)    do_enable    ;;
    disable)   do_disable   ;;
    status)    show_status  ;;
    uninstall) do_uninstall ;;
    *)         show_menu    ;;
esac
