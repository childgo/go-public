#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/install.sh)
clear

set -e

SCRIPT_PATH="/opt/SecureGateway_DNS.py"
SERVICE_PATH="/etc/systemd/system/SecureGateway_DNS.service"
SCRIPT_URL="https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/SecureGateway_DNS.py"
RESOLV_CONF="/etc/resolv.conf"

echo "Setting up ALSCO Secure Gateway DNS..."

echo "Stopping DNS services that may use port 53..."
systemctl stop SecureGateway_DNS.service 2>/dev/null || true
systemctl disable SecureGateway_DNS.service 2>/dev/null || true
pkill -f SecureGateway_DNS.py 2>/dev/null || true

systemctl stop pdns 2>/dev/null || true
systemctl disable pdns 2>/dev/null || true
systemctl mask pdns 2>/dev/null || true
pkill -f pdns_server 2>/dev/null || true

echo "Installing required packages..."
dnf install -y python3 curl bind-utils

echo "Unlocking resolv.conf if locked..."
chattr -i "$RESOLV_CONF" 2>/dev/null || true

echo "Downloading SecureGateway_DNS.py..."
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

echo "Configuring local resolver..."
cat > "$RESOLV_CONF" <<EOF
nameserver 127.0.0.1
options timeout:2 attempts:2
EOF

chattr +i "$RESOLV_CONF"

echo "Testing DNS..."
dig +short +noedns @127.0.0.1 gmail.com A || true
dig +short +noedns @127.0.0.1 gmail.com NS || true

echo "Service status:"
systemctl status SecureGateway_DNS.service --no-pager

echo "Done."
