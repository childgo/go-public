#!/bin/bash


#bash <(curl -s https://repo.alscoip.com/NDC/start.alsco)

clear

# ANSI color code for green
GREEN="\e[32m"
# ANSI color code for reset
RESET="\e[0m"

# Print the ASCII art in green
echo -e "${GREEN}"
cat << "EOF"
 ____                              ____       _                           
/ ___|  ___  ___ _   _ _ __ ___   / ___| __ _| |_ _____      ____ _ _   _ 
\___ \ / _ \/ __| | | | '__/ _ \ | |  _ / _` | __/ _ \ \ /\ / / _` | | | |
 ___) |  __/ (__| |_| | | |  __/ | |_| | (_| | ||  __/\ V  V / (_| | |_| |
|____/ \___|\___|\__,_|_|  \___|  \____|\__,_|\__\___| \_/\_/ \__,_|\__, |
                                                                    |___/ 
EOF
echo -e "${RESET}"




PS3='Please enter your choice: '

options=(
"Install ALSCO Repo 1"
"Install WebServer and Update 2"
"Install Firewall 3"
"Install php83 4"
"Install Database 5"
"Install nano and Increase inotify Limits 6"
"Install GEO_Maxmind 7"
"Install SecureGateway MSec and LUA 8"
"Change Default  HomePage 9"
"Check and restart SG WebServer 10"
"nginx -t 11"


"Quit")


select opt in "${options[@]}"
do
case $opt in






########################################################
"Install ALSCO Repo 1")

cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_AlmaLinux9.repo
# Content from ALSCO_SecureGateway_AlmaLinux9.repo
[ALSCO_Secure_Gateway-baseos]
name=ALSCO_Secure_Gateway-BaseOS
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/baseos/
enabled=1
gpgcheck=0

[ALSCO_Secure_Gateway-appstream]
name=ALSCO_Secure_Gateway-AppStream
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/appstream/
enabled=1
gpgcheck=0

[ALSCO_Secure_Gateway-extras]
name=ALSCO_Secure_Gateway-Extras
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/extras/
enabled=1
gpgcheck=0

[ALSCO_Secure_Gateway-crb]
name=ALSCO_Secure_Gateway-CRB
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/crb/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_AlmaLinux9.repo
EOF








cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Module.repo
# Content from ALSCO_SecureGateway_Module.repo
[ALSCO_Secure_Gateway_ModulesSpeed-extras]
name=ALSCO_Secure_Gateway Modules extras for Enterprise
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Module/getpagespeed-extras/
enabled=1
gpgcheck=0
repo_gpgcheck=0
module_hotfixes=1
priority=9

[ALSCO_Secure_Gateway_ModulesSpeed-noarch]
name=ALSCO_Secure_Gateway Modules noarch for Enterprise
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Module/getpagespeed-extras-noarch/
enabled=1
gpgcheck=0
repo_gpgcheck=0
module_hotfixes=1
priority=9
#Finish Content from ALSCO_SecureGateway_Module.repo
EOF








cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Others_Requires.repo
# Content from ALSCO_SecureGateway_Others_Requires.repo
[ALSCO-Secure_Gateway_Others_Requires]
name=ALSCO-Secure_Gateway_Others_Requires
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Others_Requires/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_Others_Requires.repo
EOF











cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_php83.repo
# Content from ALSCO_SecureGateway_php83.repo
[ALSCO_Secure_Gateway-php8.3]
name=ALSCO_Secure_Gateway-php8.3
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/Secure_Gateway_php83/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_php83.repo
EOF










cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Tools.repo
# Content from ALSCO_SecureGateway_Tools.repo
[ALSCO_Secure_Gateway_Tools]
name=ALSCO_Secure_Gateway_Tools
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Tools/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_Tools.repo
EOF

echo "Repository files have been created with the updated content."



;;
########################################################





########################################################
"Install WebServer and Update 2")

clear
dnf -y update;sleep 3;

#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End




dnf install -y wget nano inotify-tools rsync sshpass;sleep 3;
dnf install -y epel-release;sleep 3;
dnf install -y nginx;sleep 3;

systemctl start nginx;sleep 3;
systemctl enable nginx;sleep 3;

firewall-cmd --zone=public --permanent --add-service=http;sleep 3;
firewall-cmd --zone=public --permanent --add-service=https;sleep 3;
firewall-cmd --reload;sleep 3;
systemctl reload nginx;sleep 3;
systemctl restart nginx;sleep 3;

#reboot;sleep 3;
systemctl status nginx;sleep 3;











#----Create Folders
# Create /etc/nginx/modsec/
if [ ! -d "/etc/nginx/modsec/" ]; then
    mkdir -p "/etc/nginx/modsec/"
    echo "Created directory: /etc/nginx/modsec/"
else
    echo "Directory already exists: /etc/nginx/modsec/"
fi

# Create /etc/nginx/conf.d/alsco_global_settings/
if [ ! -d "/etc/nginx/conf.d/alsco_global_settings/" ]; then
    mkdir -p "/etc/nginx/conf.d/alsco_global_settings/"
    echo "Created directory: /etc/nginx/conf.d/alsco_global_settings/"
else
    echo "Directory already exists: /etc/nginx/conf.d/alsco_global_settings/"
fi

# Create /etc/nginx/conf.d/alsco_data_cookie_and_ip/
if [ ! -d "/etc/nginx/conf.d/alsco_data_cookie_and_ip/" ]; then
    mkdir -p "/etc/nginx/conf.d/alsco_data_cookie_and_ip/"
    echo "Created directory: /etc/nginx/conf.d/alsco_data_cookie_and_ip/"
else
    echo "Directory already exists: /etc/nginx/conf.d/alsco_data_cookie_and_ip/"
fi

# Create /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/
if [ ! -d "/etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/" ]; then
    mkdir -p "/etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/"
    echo "Created directory: /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/"
else
    echo "Directory already exists: /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/"
fi

echo "All directories are created or already exist."
#----End Create Folders





#----Create Files
# Create /etc/nginx/conf.d/0-setting.conf
if [ ! -f "/etc/nginx/conf.d/0-setting.conf" ]; then
    touch "/etc/nginx/conf.d/0-setting.conf"
    echo "Created file: /etc/nginx/conf.d/0-setting.conf"
else
    echo "File already exists: /etc/nginx/conf.d/0-setting.conf"
fi

# Create /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco
if [ ! -f "/etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco" ]; then
    mkdir -p "/etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/"
    touch "/etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco"
    echo "Created file: /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco"
else
    echo "File already exists: /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco"
fi

echo "All files are created or already exist."
#----End Create Files








#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End
;;
########################################################









########################################################
"Install Firewall 3")



clear
#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End


systemctl disable firewalld;sleep 3;
systemctl stop firewalld;sleep 3;
dnf clean all;sleep 3;
dnf -y update;sleep 3;
dnf -y install wget nano inotify-tools rsync sshpass iftop htop createrepo traceroute;sleep 3;
dnf -y install perl tar ipset tcpdump unzip net-tools perl-libwww-perl;sleep 3;
dnf -y install perl-LWP-Protocol-https perl-GDGraph bind-utils;sleep 3;
dnf -y install epel-release createrepo;sleep 3;
dnf -y install bind-utils -y;sleep 3;
dnf -y install nc -y;sleep 3;
dnf -y install nmap-ncat -y;sleep 3;


cd /opt;sleep 3;
wget https://download.configserver.com/csf.tgz;sleep 3;
tar -xzf csf.tgz;sleep 3;
cd csf;sleep 3;
sh install.sh;sleep 3;
rm -rf /opt/csf;sleep 3;
rm -rf /opt/csf.tgz;sleep 3;
cd ~;sleep 3;

systemctl enable csf;sleep 3;
systemctl enable lfd;sleep 3;
#service csf start;sleep 3;
#service lfd start;sleep 3;
#perl /usr/local/csf/bin/csftest.pl;sleep 3;



#======================================================================
#CSF Setting
#======================================================================
echo "Start changing CSF from '1' to '0' to activate it...."
sed -i 's/TESTING = "1"/TESTING = "0"/' /etc/csf/csf.conf
echo "Verify that the change was successful. ...."
grep -r "TESTING =" /etc/csf/csf.conf



#Start changing  protocal
echo "Start changing  protocal...."

sed -i 's/TCP_IN =.*/TCP_IN =""/' /etc/csf/csf.conf
sed -i 's/TCP_OUT =.*/TCP_OUT ="80,443,53"/' /etc/csf/csf.conf
sed -i 's/UDP_IN =.*/UDP_IN ="53"/' /etc/csf/csf.conf
sed -i 's/UDP_OUT =.*/UDP_OUT ="53"/' /etc/csf/csf.conf



sed -i 's/TCP6_IN =.*/TCP6_IN =""/' /etc/csf/csf.conf
sed -i 's/TCP6_OUT =.*/TCP6_OUT =""/' /etc/csf/csf.conf
sed -i 's/UDP6_IN =.*/UDP6_IN =""/' /etc/csf/csf.conf
sed -i 's/UDP6_OUT .*/UDP6_OUT =""/' /etc/csf/csf.conf



#Enable IPSET [Change LF_IPSET from 0 to 1]
echo "Change LF_IPSET from 0 to 1, becuase 1 mean enable"
sed -i 's/^LF_IPSET =.*/LF_IPSET = "1"/' /etc/csf/csf.conf
grep -r "LF_IPSET =" /etc/csf/csf.conf
echo ""
echo ""

echo "Verify that the change was successful. ...."
grep -r "TCP_IN =" /etc/csf/csf.conf
grep -r "TCP_OUT =" /etc/csf/csf.conf
grep -r "UDP_IN =" /etc/csf/csf.conf
grep -r "UDP_OUT =" /etc/csf/csf.conf
echo ""

grep -r "TCP6_IN =" /etc/csf/csf.conf
grep -r "TCP6_OUT =" /etc/csf/csf.conf
grep -r "UDP6_IN =" /etc/csf/csf.conf
grep -r "UDP6_OUT =" /etc/csf/csf.conf

echo "Change LF_IPSET from 0 to 1, becuase 1 mean enable"
grep -r "LF_IPSET =" /etc/csf/csf.conf


echo ""
#======================================================================


systemctl enable csf
systemctl enable lfd
service csf start
service lfd start
perl /usr/local/csf/bin/csftest.pl



#======================================================================
#Uninstall CSF Firewall
#cd /etc/csf
#sh uninstall.sh



#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End
;;
########################################################
"Install php83 4")

clear
#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End



dnf -y install yum-utils
dnf -y module reset php; sleep 3;
dnf -y module install php:remi-8.3; sleep 3;

sudo dnf -y install php;sleep 3;
sudo dnf -y install php-cli;sleep 3;
sudo dnf -y install php-fpm;sleep 3;
sudo dnf -y install php-mysqlnd;sleep 3;
sudo dnf -y install php-zip;sleep 3;
sudo dnf -y install php-devel;sleep 3;
sudo dnf -y install php-gd;sleep 3;
sudo dnf -y install php-mbstring;sleep 3;
sudo dnf -y install php-curl;sleep 3;
sudo dnf -y install php-xml;sleep 3;
sudo dnf -y install php-pear;sleep 3;
sudo dnf -y install php-bcmath;sleep 3;
sudo dnf -y install php-json;sleep 3;
sudo dnf -y install php-ioncube-loader;sleep 3;


#Start Services
service php-fpm restart;sleep 3;
sudo systemctl start php-fpm;sleep 3;
sudo systemctl enable php-fpm;sleep 3;

#remove apache
sudo yum -y remove httpd


#======================================================================
#php changing setting
#======================================================================
echo "Start php Value...."
sed -i 's/session.cookie_httponly =/session.cookie_httponly = true/' /etc/php.ini
sed -i 's/session.cookie_samesite =/session.cookie_samesite = true/' /etc/php.ini

#restart php
service php-fpm restart;sleep 3;

echo ""
echo "Verify that the change was successful. ...."
grep -r "session.cookie_httponly" /etc/php.ini
grep -r "session.cookie_samesite" /etc/php.ini

php -v;sleep 3;


#remove php
#yum -y remove php*



#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End
;;
########################################################
"Install Database 5")


#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End


#Part1
yum -y install mariadb-server mariadb;sleep 3;
systemctl start mariadb;sleep 3;
systemctl enable mariadb;sleep 3;



#Allow remote MySQL from php(to check remote database)
sestatus;sleep 3;
getsebool -a | grep httpd;sleep 3;
setsebool httpd_can_network_connect_db 1;sleep 3;
setsebool -P httpd_can_network_connect_db 1;sleep 3;
setsebool -P httpd_can_network_connect 1;sleep 3;
getsebool -a | grep httpd_can_network_connect;sleep 3;




#checking
#systemctl status mariadb;sleep 3;
#mysql;sleep 3;



#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End
;;
########################################################
"Install nano and Increase inotify Limits 6")

#!/bin/bash
clear



#Increase inotify Limits 5
echo "fs.inotify.max_user_watches=1048576" | sudo tee -a /etc/sysctl.conf
echo "fs.inotify.max_user_instances=1024" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p


#Changing Timezone
timedatectl set-timezone Asia/Baghdad





#Install Nano
yum -y install nano



#Setting nano as default editor
cat <<EOF >>~/.bash_profile
export VISUAL="nano"
export EDITOR="nano"
EOF

exit 0

echo "Done"
;;
########################################################
"Install GEO_Maxmind 7")

clear
#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End


#Install GEO AND Maxmind
yum -y install nginx-module-geoip;sleep 2;
yum -y install nginx-module-geoip2;sleep 2;
yum -y install jq libmaxminddb-devel;sleep 2;


#Linux9
yum install oniguruma;sleep 2;

#Download DataBase
cd /usr/share/GeoIP/
pwd

wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-City.mmdb -O GeoLite2-City.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-ASN.mmdb -O GeoLite2-ASN.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-Country.mmdb -O GeoLite2-Country.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoIP2-ISP.mmdb -O GeoIP2-ISP.mmdb


sleep 2;

#Get Size for each file
Size_GeoLite2_City=$(wc -c "/usr/share/GeoIP/GeoLite2-City.mmdb" | awk '{print $1}')
Size_GeoLite2_ASN=$(wc -c "/usr/share/GeoIP/GeoLite2-ASN.mmdb" | awk '{print $1}')
Size_GeoLite_Country=$(wc -c "/usr/share/GeoIP/GeoLite2-Country.mmdb" | awk '{print $1}')
Size_GeoIP_ISP=$(wc -c "/usr/share/GeoIP/GeoIP2-ISP.mmdb" | awk '{print $1}')


nginx -t
systemctl restart nginx


sleep 2;
echo "==================================="
echo ""
echo "Check mmdblookup Command...."
echo ""
echo ""



#Checking
mmdblookup --file /usr/share/GeoIP/GeoLite2-City.mmdb --ip 66.111.53.5 country names en |awk -F'"' '{print $2}' | tr '\n' ' '
mmdblookup --file /usr/share/GeoIP/GeoLite2-ASN.mmdb --ip 66.111.53.5 | sed -e ':a;N;$!ba;s/\n/ /g' |sed -e 's/ <[a-z0-9_]\+>/,/g' |sed -e 's/,\s\+}/}/g' | jq '(.autonomous_system_number)'
mmdblookup --file /usr/share/GeoIP/GeoLite2-ASN.mmdb --ip 66.111.53.5 | sed -e ':a;N;$!ba;s/\n/ /g' |sed -e 's/ <[a-z0-9_]\+>/,/g' |sed -e 's/,\s\+}/}/g' | jq '(.autonomous_system_organization)' | sed -e 's/^"//' -e 's/"$//'
mmdblookup --file /usr/share/GeoIP/GeoLite2-Country.mmdb --ip 66.111.53.5 country iso_code |awk -F'"' '{print $2}' | tr '\n' ' '

#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End
;;



########################################################
"Install SecureGateway MSec and LUA 8")

clear
#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End

yum -y install nginx-module-security
yum -y install nginx-owasp-crs

mkdir /alscogatewaytmp
chmod 1777 /alscogatewaytmp

#for securegateway spider python3 to work
sudo dnf install -y python3-devel mysql-devel
pip3 install mysqlclient



chcon -t httpd_sys_rw_content_t /alscogatewaytmp -R
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/antivirus/final/spider6.py
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/browsers-id13.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/ip-white-id9.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/request_body_id14.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/spamlist-id12.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/sql-Injection-11.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/url-english-id10.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/sql-Injection_Public-25.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/ExcludeIP_SG_DDoS_Mitigation-id58.txt

#or
#chcon -t httpd_sys_rw_content_t /alscogatewaytmp -R; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/antivirus/final/spider6.py; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/browsers-id13.txt; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/ip-white-id9.txt; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/request_body_id14.txt; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/spamlist-id12.txt; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/sql-Injection-11.txt; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/url-english-id10.txt; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/sql-Injection_Public-25.txt; chcon -t httpd_sys_script_exec_t /alscospider/gateway_rules/ExcludeIP_SG_DDoS_Mitigation-id58.txt



# Change the permissions of all files ending in .alsco or .sh to 700
find /alscospider -type f \( -name "*.alsco" -o -name "*.sh" \) -exec chmod 0700 {} \;

# Change the permissions of all files ending in .py to 0755
find /alscospider -type f -name "*.py" -exec chmod 0755 {} \;


#install lua
sudo yum -y install nginx-module-lua



#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End
;;
########################################################
"Change Default  HomePage 9")

clear
  
truncate -s 0 /usr/share/nginx/html/index.html
echo "<html><head><title></title><meta http-equiv=\"refresh\" content=\"0; URL=https://google.com/\" /></head><body></body></html>" > /usr/share/nginx/html/index.html


cat /usr/share/nginx/html/index.html

echo "....."
echo "....."
echo "....."

echo "Done....."


#------Delete Unwanted .repo Files:
find "/etc/yum.repos.d/" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_AlmaLinux9.repo' ! -name 'ALSCO_SecureGateway_Module.repo' ! -name 'ALSCO_SecureGateway_Others_Requires.repo' ! -name 'ALSCO_SecureGateway_php83.repo' ! -name 'ALSCO_SecureGateway_Tools.repo' -exec rm -f {} \;
dnf clean all
#------End


;;
########################################################
"Check and restart SG WebServer 10")
nginx -t && systemctl restart nginx

;;
########################################################
"nginx -t 11")

echo "nginx -t"
nginx -t

;;
########################################################



"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
