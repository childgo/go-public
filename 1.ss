#!/bin/bash
clear




#Start Install Centos7 Repo
SG_Path="/root/SSH_Login_Alert.sg"

cat <<EOF >>/root/SSH_Login_Alert.sg



linux_server_IP=$(curl https://cpanel.net/showip.shtml)
UserIP=$(echo $SSH_CLIENT | awk '{ print $1}')

PIC="2"
SOUND="police.caf"
URL="https://mobile.alscosupport.com/app/one/sendone.php"
DEVICE=$1
curl -A "Mozilla()" --max-time 5 ''$URL'?name='$DEVICE'&body='Login%20From-$UserIP'&sound='$SOUND'&link='en'&image='$PIC'&title='SSH%20Login%20Alert-$linux_server_IP'&category='Server_SSH_Login'&client_ip='$linux_server_IP''

EOF




# Backup .bashrc file
cp /root/.bashrc /root/.bashrc.bak

# Append the line in the end of .bashrc file
echo "exec ./../root/SSH_Login_Alert.sg &>/dev/null &" >> /root/.bashrc

# Reload .bashrc
source /root/.bashrc
