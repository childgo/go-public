#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/install.sh)
clear

#Uninstall
chattr -i /etc/resolv.conf && systemctl restart NetworkManager


# Define variables
ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH="/opt/SecureGateway_DNS.py"
ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF="/etc/resolv.conf"
ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_URL="https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/Magic_SG.sh"

echo "🔥 Setting up ALSCO Secure Gateway DNS Cluster..."

# Step 1: Kill any existing instances of SecureGateway_DNS.py
echo "❌ Stopping any running instances of SecureGateway_DNS.py..."
sudo pkill -f "$ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH"

# Step 2: Download the SecureGateway_DNS.py script
echo "⚙️ Downloading Python script from $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_URL..."
sudo curl -o $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_URL

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to download the script!"
    exit 1
fi

# Step 3: Add execution permissions to the script
echo "🔑 Adding execution permissions to $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH..."
sudo chmod +x $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH

# Step 4: Empty /etc/resolv.conf and set nameserver 127.0.0.1
echo "📝 Configuring DNS resolver in $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF..."
echo "nameserver 127.0.0.1" | sudo tee $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF > /dev/null

# Step 5: Lock /etc/resolv.conf to prevent changes
echo "🔒 Locking $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF to prevent changes..."
sudo chattr +i $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF

# Step 6: Restart NetworkManager to apply changes
echo "🔄 Restarting NetworkManager..."
sudo systemctl restart NetworkManager

# Step 7: Start SecureGateway_DNS.py
echo "🚀 Starting SecureGateway_DNS..."
nohup sudo python3 $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH > /var/log/SecureGateway_DNS.log 2>&1 &

echo "✅ ALSCO Secure Gateway DNS Setup Completed Successfully!"























##=================================================================================
#systemd service, ensuring it starts automatically on reboot and runs continuously.
##=================================================================================

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


##=================================================================================
#systemd service, ensuring it starts automatically on reboot and runs continuously.
##=================================================================================

