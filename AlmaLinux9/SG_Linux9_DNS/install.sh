#!/bin/bash
clear
# Define variables
ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH="/opt/SecureGateway_DNS.py"
ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF="/etc/resolv.conf"
ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_URL="https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/Magic_SG.sh"

echo "🔥 Setting up ALSCO Secure Gateway DNS Cluster..."

# Step 1: Download the SecureGateway_DNS.py script
echo "⚙️ Downloading Python script from $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_URL..."
sudo curl -o $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_URL

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to download the script!"
    exit 1
fi

# Step 2: Add execution permissions to the script
echo "🔑 Adding execution permissions to $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH..."
sudo chmod +x $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH

# Step 3: Empty /etc/resolv.conf and set nameserver 127.0.0.1
echo "📝 Configuring DNS resolver in $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF..."
echo "nameserver 127.0.0.1" | sudo tee $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF > /dev/null

# Step 4: Lock /etc/resolv.conf to prevent changes
echo "🔒 Locking $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF to prevent changes..."
sudo chattr +i $ALSCO_SecureGateway_DNS_Clusrer_RESOLV_CONF

# Step 5: Restart NetworkManager to apply changes
echo "🔄 Restarting NetworkManager..."
sudo systemctl restart NetworkManager

# Step 6: Run the SecureGateway_DNS.py script
echo "🚀 Running SecureGateway_DNS..."
sudo python3 $ALSCO_SecureGateway_DNS_Clusrer_SCRIPT_PATH &

echo "✅ ALSCO Secure Gateway DNS Setup Completed Successfully!"
