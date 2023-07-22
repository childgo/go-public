#!/bin/bash
# ^ that line is important
clear

#this is nginx package | to install repo
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/nginx/install/build_alsco_repositories.sh)

cd /etc/yum.repos.d/
pwd
rm -rf *
echo "Old Rrepository found and deleted";
ls -al
#########################################################################################################
#########################################################################################################
#Install Centos7 Repo
ALSCO_Path="/etc/yum.repos.d/alsco_CentOS7.repo"

cat <<EOF >>/etc/yum.repos.d/alsco_CentOS7.repo

[ALSCO-local-base]
name=CentOS Base
baseurl=https://repo.alscoip.com/Linux/Centos7-Sync/base/
gpgcheck=0
enabled=1

[ALSCO-local-centosplus]
name=CentOS CentOSPlus
baseurl=https:/repo.alscoip.com/Linux/Centos7-Sync/centosplus/
gpgcheck=0
enabled=0

[ALSCO-local-extras]
name=CentOS Extras
baseurl=https://repo.alscoip.com/Linux/Centos7-Sync/extras/
gpgcheck=0
enabled=1

[ALSCO-local-updates]
name=CentOS Updates
baseurl=https://repo.alscoip.com/Linux/Centos7-Sync/updates/
gpgcheck=0
enabled=1

EOF
#########################################################################################################
#########################################################################################################

#Install Ngnix Reop
ALSCO_Path="/etc/yum.repos.d/ALSCO_Nginx.repo"


cat <<EOF >>/etc/yum.repos.d/ALSCO_Nginx.repo
[ALSCO-Nginx]
name=RHEL Apache
baseurl=https://repo.alscoip.com/Linux/Nginx_Centos7/
enabled=1
gpgcheck=0
EOF
#########################################################################################################
#########################################################################################################


#Some Code

yum clean all
yum clean headers
yum clean metadata
yum clean packages


echo "";
echo "";
echo "";

cd /etc/yum.repos.d/
pwd
echo "List ALL";
ls
