#!/bin/bash

# bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/install.sh)

SCRIPT_PATH="/opt/SecureGateway_DNS.py"
SERVICE_PATH="/etc/systemd/system/SecureGateway_DNS.service"
SERVICE_NAME="SecureGateway_DNS.service"
RESOLV_CONF="/etc/resolv.conf"
RESOLV_BACKUP="/etc/resolv.conf.before-securegateway"
SCRIPT_URL="https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/SecureGateway_DNS.py"

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
NC="\033[0m"

ok() { echo -e "${GREEN}✅ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
err() { echo -e "${RED}❌ $1${NC}"; }
info() { echo -e "${CYAN}ℹ️  $1${NC}"; }

pause() {
    echo
    read -p "Press Enter to continue..."
}

is_installed() {
    systemctl list-unit-files | grep -q "^$SERVICE_NAME" && [ -f "$SCRIPT_PATH" ]
}

is_running() {
    systemctl is-active --quiet "$SERVICE_NAME"
}

test_current_dns() {
    clear
    echo -e "${BLUE}=== Current DNS Status ===${NC}"
    echo

    echo -e "${CYAN}--- /etc/resolv.conf ---${NC}"
    cat "$RESOLV_CONF" 2>/dev/null || true
    echo

    echo -e "${CYAN}--- Port 53 Owner ---${NC}"
    ss -tulnp | grep ':53' || warn "No service is listening on port 53"
    echo

    echo -e "${CYAN}--- DNS Services ---${NC}"
    systemctl list-units --type=service | egrep 'pdns|named|dnsmasq|unbound|resolved|SecureGateway' || warn "No known DNS service found"
    echo

    echo -e "${CYAN}--- Default DNS Test ---${NC}"
    dig +short gmail.com A || true
    echo

    echo -e "${CYAN}--- Local DNS Test ---${NC}"
    dig +short +noedns @127.0.0.1 gmail.com A || true
    echo

    pause
}

install_securegateway_dns() {
    clear
    echo -e "${BLUE}=== Install ALSCO Secure Gateway DNS ===${NC}"
    echo

    if is_installed; then
        err "Secure Gateway DNS is already installed."
        info "Use option 3 to test it, option 5 to restart it, or option 4 to uninstall it first."
        pause
        return
    fi

    info "Checking required commands..."
    for cmd in python3 curl dig ss systemctl; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            err "Missing command: $cmd"
            warn "Install required packages first."
            pause
            return
        fi
    done

    info "Backing up resolv.conf..."
    chattr -i "$RESOLV_CONF" 2>/dev/null || true
    cp -a "$RESOLV_CONF" "$RESOLV_BACKUP" 2>/dev/null || true

    info "Stopping PowerDNS..."
    systemctl stop pdns 2>/dev/null || true
    systemctl disable pdns 2>/dev/null || true
    systemctl mask pdns 2>/dev/null || true
    pkill -f pdns_server 2>/dev/null || true

    info "Stopping old SecureGateway DNS processes..."
    systemctl stop "$SERVICE_NAME" 2>/dev/null || true
    systemctl disable "$SERVICE_NAME" 2>/dev/null || true
    pkill -f SecureGateway_DNS.py 2>/dev/null || true

    info "Downloading Python DNS script..."
    curl -fsSL -o "$SCRIPT_PATH" "$SCRIPT_URL"
    chmod 755 "$SCRIPT_PATH"

    info "Creating systemd service..."
    cat > "$SERVICE_PATH" <<EOF
[Unit]
Description=ALSCO Secure Gateway DNS Service
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 $SCRIPT_PATH
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

    info "Reloading systemd..."
    systemctl daemon-reload
    systemctl enable "$SERVICE_NAME"
    systemctl restart "$SERVICE_NAME"

    sleep 2

    if is_running; then
        ok "Secure Gateway DNS service is running."
    else
        err "Secure Gateway DNS service failed to start."
        systemctl status "$SERVICE_NAME" --no-pager || true
        pause
        return
    fi

    info "Setting resolver to 127.0.0.1..."
    cat > "$RESOLV_CONF" <<EOF
nameserver 127.0.0.1
options timeout:2 attempts:2
EOF

    chattr +i "$RESOLV_CONF"

    ok "Install completed."
    pause
}

test_securegateway_dns() {
    clear
    echo -e "${BLUE}=== Test ALSCO Secure Gateway DNS ===${NC}"
    echo

    echo -e "${CYAN}--- Installed Check ---${NC}"
    if is_installed; then ok "Installed"; else err "Not installed"; fi
    echo

    echo -e "${CYAN}--- Running Check ---${NC}"
    if is_running; then ok "Service is running"; else err "Service is NOT running"; fi
    echo

    echo -e "${CYAN}--- Enabled on Boot Check ---${NC}"
    if systemctl is-enabled --quiet "$SERVICE_NAME"; then
        ok "Enabled on boot"
    else
        err "Not enabled on boot"
    fi
    echo

    echo -e "${CYAN}--- Port 53 Owner ---${NC}"
    ss -tulnp | grep ':53' || warn "No service is listening on port 53"
    echo

    echo -e "${CYAN}--- resolv.conf ---${NC}"
    cat "$RESOLV_CONF" 2>/dev/null || true
    echo

    echo -e "${CYAN}--- A Record Test ---${NC}"
    dig +short +noedns @127.0.0.1 gmail.com A || true
    echo

    echo -e "${CYAN}--- NS Record Test ---${NC}"
    dig +short +noedns @127.0.0.1 gmail.com NS || true
    echo

    echo -e "${CYAN}--- cPanel Related Test ---${NC}"
    dig +short +noedns @127.0.0.1 ns.cmc.iq A || true
    dig +noedns @127.0.0.1 survey.moch.gov.iq NS || true
    echo

    echo -e "${CYAN}--- Recent Logs ---${NC}"
    journalctl -u "$SERVICE_NAME" -n 25 --no-pager || true

    pause
}

uninstall_securegateway_dns() {
    clear
    echo -e "${BLUE}=== Uninstall ALSCO Secure Gateway DNS ===${NC}"
    echo

    info "Stopping SecureGateway DNS..."
    systemctl stop "$SERVICE_NAME" 2>/dev/null || true
    systemctl disable "$SERVICE_NAME" 2>/dev/null || true
    pkill -f SecureGateway_DNS.py 2>/dev/null || true

    info "Removing service file..."
    rm -f "$SERVICE_PATH"
    systemctl daemon-reload

    info "Unlocking resolv.conf..."
    chattr -i "$RESOLV_CONF" 2>/dev/null || true

    if [ -f "$RESOLV_BACKUP" ]; then
        info "Restoring previous resolv.conf..."
        cp -a "$RESOLV_BACKUP" "$RESOLV_CONF"
    else
        warn "No backup found. Setting fallback DNS."
        cat > "$RESOLV_CONF" <<EOF
nameserver 1.1.1.1
nameserver 8.8.8.8
options timeout:2 attempts:2
EOF
    fi

    info "Restoring PowerDNS if available..."
    systemctl unmask pdns 2>/dev/null || true
    systemctl enable pdns 2>/dev/null || true
    systemctl restart pdns 2>/dev/null || true

    info "Restarting NetworkManager..."
    systemctl restart NetworkManager 2>/dev/null || true

    info "Removing Python script..."
    rm -f "$SCRIPT_PATH"

    ok "Uninstall completed."
    pause
}

test_systemd_install() {
    clear
    echo -e "${BLUE}=== Test systemd Install / Reboot Safety ===${NC}"
    echo

    echo -e "${CYAN}--- Service File Exists ---${NC}"
    if [ -f "$SERVICE_PATH" ]; then ok "$SERVICE_PATH exists"; else err "$SERVICE_PATH missing"; fi
    echo

    echo -e "${CYAN}--- systemd Knows Service ---${NC}"
    systemctl status "$SERVICE_NAME" --no-pager || true
    echo

    echo -e "${CYAN}--- Enabled on Boot ---${NC}"
    if systemctl is-enabled --quiet "$SERVICE_NAME"; then
        ok "Service is enabled and should start after reboot."
    else
        err "Service is not enabled on boot."
    fi
    echo

    echo -e "${CYAN}--- Stop/Start Test ---${NC}"
    info "Stopping service..."
    systemctl stop "$SERVICE_NAME" || true
    sleep 2

    if is_running; then
        err "Service did not stop correctly."
    else
        ok "Service stopped correctly."
    fi

    info "Starting service..."
    systemctl start "$SERVICE_NAME" || true
    sleep 2

    if is_running; then
        ok "Service started correctly."
    else
        err "Service failed to start."
    fi
    echo

    echo -e "${CYAN}--- DNS After Restart ---${NC}"
    dig +short +noedns @127.0.0.1 gmail.com A || true
    echo

    pause
}

restart_service() {
    clear
    echo -e "${BLUE}=== Restart Secure Gateway DNS ===${NC}"
    echo

    systemctl restart "$SERVICE_NAME" || true
    sleep 2

    if is_running; then
        ok "Service restarted and is running."
    else
        err "Service failed to restart."
        systemctl status "$SERVICE_NAME" --no-pager || true
    fi

    pause
}

while true; do
    clear
    echo -e "${BLUE}==========================================${NC}"
    echo -e "${GREEN}ALSCO Secure Gateway DNS Manager${NC}"
    echo -e "${BLUE}==========================================${NC}"
    echo "1 - Test what DNS is working"
    echo "2 - Install ALSCO Secure Gateway DNS"
    echo "3 - Test all ALSCO Secure Gateway DNS"
    echo "4 - Uninstall everything and return server to default DNS"
    echo "5 - Test systemd install / reboot safety"
    echo "6 - Restart Secure Gateway DNS"
    echo "0 - Exit"
    echo -e "${BLUE}==========================================${NC}"
    echo
    read -p "Select option: " choice

    case "$choice" in
        1) test_current_dns ;;
        2) install_securegateway_dns ;;
        3) test_securegateway_dns ;;
        4) uninstall_securegateway_dns ;;
        5) test_systemd_install ;;
        6) restart_service ;;
        0) exit 0 ;;
        *) warn "Invalid option"; sleep 1 ;;
    esac
done
