#!/bin/bash

# bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/install.sh)

clear

SCRIPT_PATH="/opt/SecureGateway_DNS.py"
SERVICE_PATH="/etc/systemd/system/SecureGateway_DNS.service"
RESOLV_CONF="/etc/resolv.conf"
RESOLV_BACKUP="/etc/resolv.conf.before-securegateway"
SCRIPT_URL="https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/SecureGateway_DNS.py"

pause() {
    echo
    read -p "Press Enter to continue..."
}

test_current_dns() {
    clear
    echo "=========================================="
    echo "1 - Test what DNS is currently working"
    echo "=========================================="
    echo

    echo "=== /etc/resolv.conf ==="
    cat "$RESOLV_CONF" 2>/dev/null || true
    echo

    echo "=== Port 53 Owner ==="
    ss -tulnp | grep ':53' || echo "No service is listening on port 53"
    echo

    echo "=== DNS-related services ==="
    systemctl list-units --type=service | egrep 'pdns|named|dnsmasq|unbound|resolved|SecureGateway' || echo "No known DNS service found"
    echo

    echo "=== Test default resolver ==="
    dig +short gmail.com A || true
    echo

    echo "=== Test local resolver 127.0.0.1 ==="
    dig +short +noedns @127.0.0.1 gmail.com A || true
    echo

    echo "=== Test local NS query ==="
    dig +short +noedns @127.0.0.1 gmail.com NS || true
    echo

    pause
}

install_securegateway_dns() {
    clear
    set -e

    echo "=========================================="
    echo "2 - Install ALSCO Secure Gateway DNS"
    echo "=========================================="
    echo

    echo "Backing up current resolv.conf..."
    chattr -i "$RESOLV_CONF" 2>/dev/null || true
    cp -a "$RESOLV_CONF" "$RESOLV_BACKUP" 2>/dev/null || true

    echo "Stopping PowerDNS..."
    systemctl stop pdns 2>/dev/null || true
    systemctl disable pdns 2>/dev/null || true
    systemctl mask pdns 2>/dev/null || true
    pkill -f pdns_server 2>/dev/null || true

    echo "Stopping old SecureGateway DNS..."
    systemctl stop SecureGateway_DNS.service 2>/dev/null || true
    systemctl disable SecureGateway_DNS.service 2>/dev/null || true
    pkill -f SecureGateway_DNS.py 2>/dev/null || true

    echo "Checking required commands..."
    for cmd in python3 curl dig ss systemctl; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "Missing command: $cmd"
            echo "Install it manually first, or fix DNF repos."
            exit 1
        fi
    done

    echo "Downloading Python DNS script..."
    curl -fsSL -o "$SCRIPT_PATH" "$SCRIPT_URL"
    chmod 755 "$SCRIPT_PATH"

    echo "Creating systemd service..."
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

    echo "Reloading systemd..."
    systemctl daemon-reload
    systemctl enable SecureGateway_DNS.service
    systemctl restart SecureGateway_DNS.service

    sleep 2

    echo "Setting resolver to local DNS..."
    cat > "$RESOLV_CONF" <<EOF
nameserver 127.0.0.1
options timeout:2 attempts:2
EOF

    chattr +i "$RESOLV_CONF"

    echo
    echo "Installation completed."
    echo

    test_securegateway_dns
}

test_securegateway_dns() {
    clear
    echo "=========================================="
    echo "3 - Test ALSCO Secure Gateway DNS"
    echo "=========================================="
    echo

    echo "=== Service Status ==="
    systemctl status SecureGateway_DNS.service --no-pager || true
    echo

    echo "=== Port 53 Owner ==="
    ss -tulnp | grep ':53' || echo "No service is listening on port 53"
    echo

    echo "=== resolv.conf ==="
    cat "$RESOLV_CONF" 2>/dev/null || true
    echo

    echo "=== Upstream configured in script ==="
    grep -i "UPSTREAM_DNS\|SecureGateway-dns-query" "$SCRIPT_PATH" 2>/dev/null || true
    echo

    echo "=== Test A record ==="
    dig +noedns @127.0.0.1 gmail.com A
    echo

    echo "=== Test NS record ==="
    dig +noedns @127.0.0.1 gmail.com NS
    echo

    echo "=== Test cPanel restore-related records ==="
    echo "--- ns.cmc.iq A ---"
    dig +short +noedns @127.0.0.1 ns.cmc.iq A || true
    echo

    echo "--- survey.moch.gov.iq NS ---"
    dig +noedns @127.0.0.1 survey.moch.gov.iq NS || true
    echo

    echo "--- survey.moch.gov.iq SOA ---"
    dig +noedns @127.0.0.1 survey.moch.gov.iq SOA || true
    echo

    echo "=== Recent Logs ==="
    journalctl -u SecureGateway_DNS.service -n 30 --no-pager || true
    echo

    pause
}

uninstall_securegateway_dns() {
    clear
    echo "=========================================="
    echo "4 - Uninstall ALSCO Secure Gateway DNS"
    echo "=========================================="
    echo

    echo "Stopping SecureGateway DNS..."
    systemctl stop SecureGateway_DNS.service 2>/dev/null || true
    systemctl disable SecureGateway_DNS.service 2>/dev/null || true
    pkill -f SecureGateway_DNS.py 2>/dev/null || true

    echo "Removing systemd service..."
    rm -f "$SERVICE_PATH"
    systemctl daemon-reload

    echo "Unlocking resolv.conf..."
    chattr -i "$RESOLV_CONF" 2>/dev/null || true

    if [ -f "$RESOLV_BACKUP" ]; then
        echo "Restoring previous resolv.conf backup..."
        cp -a "$RESOLV_BACKUP" "$RESOLV_CONF"
    else
        echo "No backup found. Setting default public resolvers..."
        cat > "$RESOLV_CONF" <<EOF
nameserver 1.1.1.1
nameserver 8.8.8.8
options timeout:2 attempts:2
EOF
    fi

    echo "Unmasking and restarting PowerDNS if available..."
    systemctl unmask pdns 2>/dev/null || true
    systemctl enable pdns 2>/dev/null || true
    systemctl restart pdns 2>/dev/null || true

    echo "Restarting NetworkManager..."
    systemctl restart NetworkManager 2>/dev/null || true

    echo "Removing script file..."
    rm -f "$SCRIPT_PATH"

    echo
    echo "Uninstall completed."
    echo

    echo "=== Current port 53 owner ==="
    ss -tulnp | grep ':53' || echo "No service is listening on port 53"
    echo

    echo "=== Current resolv.conf ==="
    cat "$RESOLV_CONF" 2>/dev/null || true
    echo

    pause
}

while true; do
    clear
    echo "=========================================="
    echo "ALSCO Secure Gateway DNS Manager"
    echo "=========================================="
    echo "1 - Test what DNS is working"
    echo "2 - Install ALSCO Secure Gateway DNS"
    echo "3 - Test all ALSCO Secure Gateway DNS"
    echo "4 - Uninstall everything and return server to default DNS"
    echo "0 - Exit"
    echo "=========================================="
    echo
    read -p "Select option: " choice

    case "$choice" in
        1) test_current_dns ;;
        2) install_securegateway_dns ;;
        3) test_securegateway_dns ;;
        4) uninstall_securegateway_dns ;;
        0) exit 0 ;;
        *) echo "Invalid option"; sleep 1 ;;
    esac
done
