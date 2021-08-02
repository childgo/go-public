#!/bin/bash
clear


find /home/*/public_html/ -type f -perm 000;
#find /home/*/public_html/ -type f -perm 000 -iname ".*" -ls


echo "Please Enter your WebSite UserName"
read user
IP="$user"
echo "the user name is:"
echo "$IP"


find /home/$IP/public_html/ -type f -perm 000 -exec chmod 644 {} \; -exec chown $IP {} \; -exec chgrp $IP {} \; 
