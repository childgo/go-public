#!/bin/bash
# ^ that line is important
clear

#Install Repo
#bash <(curl -s https://repo.alscoip.com/alsco_repo.alsco)


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
