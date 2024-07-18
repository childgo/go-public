#!/bin/bash

clear
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/Update_Commands/install.sh)

# Create the SG_update.service file
cat <<EOF > /etc/systemd/system/SG_update.service
[Unit]
Description=Run SG update scripts

[Service]
ExecStart=/bin/bash -c "/etc/sg_update/update1.sh ; /etc/sg_update/update2.sh ; /etc/sg_update/update3.sh ; /etc/sg_update/update4.sh ; /etc/sg_update/update5.sh"
EOF

# Create the SG_update.timer file
cat <<EOF > /etc/systemd/system/SG_update.timer
[Unit]
Description=Run SG_update.service every minute

[Timer]
OnCalendar=*:0/1
Unit=SG_update.service

[Install]
WantedBy=timers.target
EOF

# Reload systemd to recognize the new service and timer files
systemctl daemon-reload

# Enable and start the timer
systemctl enable SG_update.timer
systemctl start SG_update.timer

echo "SG_update.timer and SG_update.service have been created, enabled, and started."







#list all active timers in the systemd 
#systemctl list-timers --all

