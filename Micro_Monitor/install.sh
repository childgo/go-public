#!/bin/bash
clear
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/Micro_Monitor/install.sh)



echo "Start Installing..."



###########################################################
#Create SG_MyMonitor.timer
cat <<EOF > /etc/systemd/system/SG_Log.timer
[Unit]
Description=Run start.sg.x every 2 minutes

[Timer]
OnCalendar=*:0/2
Unit=SG_Log_Start.service

[Install]
WantedBy=multi-user.target
EOF


###########################################################





###########################################################
#Create SG_MyMonitor.timer
cat <<EOF > /etc/systemd/system/SG_Log_Start.service
[Unit]
Description=Start SG Service

[Service]
ExecStart=/bin/bash -c "curl -fsSL https://raw.githubusercontent.com/childgo/go-public/master/Micro_Monitor/log.sh | bash -s -- --no-repeat && curl -fsSL https://raw.githubusercontent.com/childgo/go-public/master/Micro_Monitor/extra.sh | bash -s -- --no-repeat"

#Restart=always

[Install]
WantedBy=multi-user.target


EOF
###########################################################



#Run Command
sudo systemctl daemon-reload
sudo systemctl start SG_Log.timer
sudo systemctl enable SG_Log.timer


#list all active timers in the systemd 
#systemctl list-timers --all



