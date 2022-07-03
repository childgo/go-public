#!/bin/bash
# ^ that line is important
clear

#this is nginx package | to install repo
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/nginx/alsco_nginx_repo.sh)


ALSCO_Path="/etc/yum.repos.d/alsco.repo"





if [ -f "$ALSCO_Path" ] ; then
    rm "$ALSCO_Path"
    echo "Old Rrepository found and deleted";
    echo""
fi





cat <<EOF >>/etc/yum.repos.d/alsco.repo
[ALSCO]
name=RHEL Apache
baseurl=http://repo.alscoip.com/Linux/centos7/repository/
enabled=1
gpgcheck=0
EOF
