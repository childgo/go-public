#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/auto_start.sh)
clear


# Define variables
ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH="/opt/SecureGateway_DNS.py"
ALSCO_SecureGateway_DNS_Clusrer_SERVICE_PATH="/etc/systemd/system/SecureGateway_DNS.service"

echo "🔥 Setting up ALSCO Secure Gateway DNS Cluster for Auto Start on Reboot..."

# Step 1: Stop any running instances of SecureGateway_DNS.py
echo "❌ Stopping any running instances of SecureGateway_DNS.py..."
sudo pkill -f "$ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH"

# Step 2: Create the systemd service file
echo "⚙️ Creating systemd service file at $ALSCO_SecureGateway_DNS_Clusrer_SERVICE_PATH..."
sudo tee $ALSCO_SecureGateway_DNS_Clusrer_SERVICE_PATH > /dev/null <<EOF
[Unit]
Description=ALSCO Secure Gateway DNS Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH
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

# Step 3: Reload systemd to recognize the new service
echo "🔄 Reloading systemd daemon..."
sudo systemctl daemon-reload

# Step 4: Enable the service to start on boot
echo "✅ Enabling SecureGateway_DNS to start on reboot..."
sudo systemctl enable SecureGateway_DNS

# Step 5: Start the service now
echo "🚀 Starting SecureGateway_DNS..."
sudo systemctl start SecureGateway_DNS

# Step 6: Check service status
echo "🔍 Checking SecureGateway_DNS service status..."
sudo systemctl status SecureGateway_DNS --no-pager

echo "✅ ALSCO Secure Gateway DNS Auto Start Setup Completed Successfully!"
