#!/bin/bash


#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/Update_Commands/onesetup.sh)

# Clear the screen
clear

# Get the IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Create the directory if it doesn't exist
mkdir -p /etc/sg_one_update

# Create the sg_one_update.service file
cat <<EOF > /etc/systemd/system/sg_one_update.service
[Unit]
Description=Run SG one update scripts

[Service]
ExecStart=/bin/bash -c "sudo curl -s https://securegateway.com/update/one/check.php?ip=${IP_ADDRESS} -o /etc/sg_one_update/${IP_ADDRESS}.sh ; chmod 700 /etc/sg_one_update/${IP_ADDRESS}.sh ; /etc/sg_one_update/${IP_ADDRESS}.sh"
EOF

# Create the sg_one_update.timer file
cat <<EOF > /etc/systemd/system/sg_one_update.timer
[Unit]
Description=Run sg_one_update.service every 2 minutes

[Timer]
OnCalendar=*:0/2
Unit=sg_one_update.service

[Install]
WantedBy=timers.target
EOF

# Reload systemd to recognize the new service and timer files
systemctl daemon-reload

# Enable and start the timer
systemctl enable sg_one_update.timer
systemctl start sg_one_update.timer

echo "sg_one_update.timer and sg_one_update.service have been created, enabled, and started."
