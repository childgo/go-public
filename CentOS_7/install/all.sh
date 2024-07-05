#!/bin/bash


#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/install/all.sh)

clear
PS3='Please enter your choice: '

options=(
"Install Nginx and Update 1"
"Install CSF Firewall 2"
"Install php73 3"
"Install MySql 4"
"Install Nano Editor 5"
"Install GEO_Maxmind 6"
"Install ModSec and LUA 7"
"Change Default  HomePage 8"
"Restart Nginx 9"
"nginx -t 10"


"Quit")


select opt in "${options[@]}"
do
case $opt in

########################################################
"Install Nginx and Update 1")

clear

#------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------



yum -y update;sleep 3;
yum -y install wget nano inotify-tools rsync sshpass;sleep 3;
yum -y install epel-release;sleep 3;
yum -y install nginx;sleep 3;
systemctl start nginx;sleep 3;
systemctl enable nginx;sleep 3;
systemctl status nginx;sleep 3;
firewall-cmd --zone=public --permanent --add-service=http;sleep 3;
firewall-cmd --zone=public --permanent --add-service=https;sleep 3;
firewall-cmd --reload;sleep 3;
systemctl reload nginx;sleep 3;
systemctl restart nginx;sleep 3;


#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------



#reboot;sleep 3;
;;
########################################################




########################################################
"Install CSF Firewall 2")


clear

systemctl disable firewalld;sleep 3;
systemctl stop firewalld;sleep 3;
yum clean all;sleep 3;
yum -y update;sleep 3;
yum -y install wget nano inotify-tools rsync sshpass iftop htop;sleep 3;
yum -y install perl tar ipset unzip net-tools perl-libwww-perl;sleep 3;
yum -y install perl-LWP-Protocol-https perl-GDGraph bind-utils;sleep 3;
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
sed -i 's/^LF_IPSET =.*/LF_IPSET = "1"/' /etc/csf/csf.conf



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

echo ""
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
;;
########################################################
"Install php73 3")

clear
#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------




#sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm;sleep 3;
sudo yum -y install epel-release yum-utils;sleep 3;
sudo yum-config-manager --disable remi-php54;sleep 3;
sudo yum-config-manager --enable remi-php73;sleep 3;
sudo yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-json;sleep 3;
php -v;sleep 3;
service php-fpm restart;sleep 3;
sudo systemctl start php-fpm;sleep 3;
sudo systemctl enable php-fpm;sleep 3;
yum remove httpd


#======================================================================
#php changing setting
#======================================================================
echo "Start php Value...."
sed -i 's/session.cookie_httponly =/session.cookie_httponly = true/' /etc/php.ini
sed -i 's/session.cookie_samesite =/session.cookie_samesite = true/' /etc/php.ini


service php-fpm restart;sleep 3;

echo ""
echo "Verify that the change was successful. ...."
grep -r "session.cookie_httponly" /etc/php.ini
grep -r "session.cookie_samesite" /etc/php.ini



#remove php
#yum -y remove php*

#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------
;;
########################################################
"Install MySql 4")


#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------




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
;;
########################################################
"Install Nano Editor 5")


#!/bin/bash
clear


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
"Install GEO_Maxmind 6")

#----------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#----------------------------


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

#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------


;;



########################################################
"Install ModSec and LUA 7")

#----------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#----------------------------



yum -y install nginx-module-security
yum -y install nginx-owasp-crs


mkdir /alscogatewaytmp
chmod 1777 /alscogatewaytmp


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


# Change the permissions of all files ending in .alsco or .sh to 700
find /alscospider -type f \( -name "*.alsco" -o -name "*.sh" \) -exec chmod 0700 {} \;

# Change the permissions of all files ending in .py to 0755
find /alscospider -type f -name "*.py" -exec chmod 0755 {} \;





#install lua
sudo yum -y install nginx-module-lua



#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------


;;
########################################################
"Change Default  HomePage 8")

clear
  
truncate -s 0 /usr/share/nginx/html/index.html
echo "<html><head><title></title><meta http-equiv=\"refresh\" content=\"0; URL=https://google.com/\" /></head><body></body></html>" > /usr/share/nginx/html/index.html


cat /usr/share/nginx/html/index.html

echo "....."
echo "....."
echo "....."

echo "Done....."
;;
########################################################
"Restart Nginx 9")

echo "systemctl restart nginx"
systemctl restart nginx

;;
########################################################
"nginx -t 10")

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
