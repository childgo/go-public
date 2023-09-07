#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/sync_getpagespeed.sh)

clear
PS3='Please enter your choice: '

options=(
"Total IP connected to Server 1"
"List of IP connected to Server 2"
"Lock Folder 3"
"Unlock Folder 4"
"check Lock 5"
"Restart Nginx 6"
"Reload Nginx 7" "nginx -t 8"
"Tail Nginx error Log 9"
"Tail Nginx access Log 10"
"Restart PHP 11"
"Nginx conf Path 12"
"Nginx Log Path 13"
"disk space used and available 14"
"pgrep -x inotify.alsco 15"
"Enable SELinux + PHP + Apache to write/access php file 16"
"check Nginx version 17"
"Check ALSCO IP Firewall Setting 18"
"CSF Firewall Setting 19"
"Check Rate Limit  Excess 20"
"clear the contents of ratelimit_tempIP_block 21"
"check SELinux 22"
"Grepping Access_Log logs for IP 23"
"Grepping Error_Log logs for IP 24"
"IP Trace 25"
"Broadcasting server IP 26"
"Update GEO-IP Database 27"
"ALSCO Centos7 Repository Build 28"
"Generate Cloudflare IP List for CSF 29"

"Quit")


select opt in "${options[@]}"
do
case $opt in

########################################################
"Total IP connected to Server 1")

#clear;while x=0; do clear;date;echo "";echo "[Total Number]";echo "-------------------";echo "Port[80]"; netstat -plan | grep :80 | wc -l;echo "Port[443]";netstat -plan | grep :443 | wc -l;echo "Port[3306]";netstat -plan | grep :3306 | wc -l; sleep 5;done

clear
while true; do
    echo "[Port: 80]"
    ss -ant '( sport = :80 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    printf '\n\n\n'

    echo "[Port: 443]"
    ss -ant '( sport = :443 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    printf '\n\n\n'
    
   echo "[Port: 3306]"
    ss -ant '( sport = :3306 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    printf '\n\n\n'

    
    echo "System Load Averages:"
    uptime | awk '{print "1-minute load average: "$10"\n5-minute load average: "$11"\n15-minute load average: "$12}'
    sleep 5
    
    clear
done


;;

########################################################

########################################################


"List of IP connected to Server 2")
clear;while x=0; do clear;date;echo "";echo "[Total Number]";echo "-------------------";netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n; sleep 15;done;;
########################################################

"Lock Folder 3")
echo "chattr -R +i /var/www/html/"
chattr -R +i /var/www/html/
echo ""
echo "Checking..."
lsattr /var/www/html/
;;
########################################################
"Unlock Folder 4")
echo "chattr -R -i /var/www/html/"
chattr -R -i /var/www/html/
echo ""
echo "Checking..."
lsattr /var/www/html/
;;
########################################################
"check Lock 5")
echo "lsattr /var/www/html/"
lsattr /var/www/html/
;;
########################################################
"Restart Nginx 6")
echo "systemctl restart nginx"
systemctl restart nginx
;;
########################################################
"Reload Nginx 7")
echo "systemctl reload nginx"
systemctl reload nginx
;;
########################################################
"nginx -t 8")
echo "nginx -t"
nginx -t
;;
########################################################
"Tail Nginx error Log 9")
echo "tail -f /var/log/nginx/error.log"
echo "tail -f /var/log/nginx/alsco_error.log"
echo "tail -f /var/log/nginx/alsco_error.log | grep 50.253.239.118"
echo ""
tail -f /var/log/nginx/alsco_error.log
;;
########################################################
"Tail Nginx access Log 10")
echo "tail -f /var/log/nginx/access.log"
echo "tail -f /var/log/nginx/access.log | grep 50.253.239.118"

echo ""


tail -f /var/log/nginx/access.log
;;
########################################################
"Restart PHP 11")
echo "service php-fpm restart"
service php-fpm restart
;;
########################################################
"Nginx conf Path 12")
echo "cd /etc/nginx/conf.d"
cd /etc/nginx/conf.d
pwd
;;
########################################################
"Nginx Log Path 13")
echo "cd /var/log/nginx/"
cd /var/log/nginx/
pwd
;;
########################################################
"disk space used and available 14")
echo "command: df"
df

echo "----------------------------------------"
echo "Check Ram"
echo "----------------------------------------"
echo "free -m -h"
free -m -h
;;
########################################################
"pgrep -x inotify.alsco 15")
echo "pgrep -x \"inotify.alsco\""
echo "to kill process use, kill 1234"
echo "================"
pgrep -x "inotify.alsco"
;;
########################################################
"Enable SELinux + PHP + Apache to write/access php file 16")
#echo ". /alscospider/setting-conf.alsco"

#Enable Write On conf.d files
sudo chcon -t httpd_sys_rw_content_t /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -R
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.map')
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.ip.alsco')
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.ipsetting.alsco')
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.ratelimit_tempIP_block.alsco')
echo "Finish Write On conf.d......."
echo "Done"
echo ""
echo ""

echo "pgrep -x \"inotify.alsco\""
echo "to kill process use, kill 1234"
echo "================"
pgrep -x "inotify.alsco"
;;
########################################################
"check Nginx version 17")
echo "nginx -v"
nginx -v
echo ""
echo "============================================="
echo "nginx -V"
nginx -V
printf '\n\n\n'

echo "============================================="
echo "Below is Available Nginx Module"
echo "yum list available | grep nginx-module"
yum list available | grep nginx-module
echo "============================================="

printf '\n\n\n'
echo "============================================="
echo "Below is Installed Nginx Module"
echo "yum list installed | grep nginx"
yum list installed | grep nginx
echo "============================================="
printf '\n\n\n'
printf '\n\n\n'
printf '\n\n\n'


echo "============================================="
echo "Below is nginx-module-geoip"
echo "yum info nginx-module-geoip"
yum info nginx-module-geoip
echo "============================================="



printf '\n\n\n'
echo "============================================="
echo "Below is nginx-module-geoip2"
echo "yum info nginx-module-geoip2"
yum info nginx-module-geoip2
echo "============================================="

printf '\n\n\n'
echo "============================================="
echo "Below is Nginx-module-security Vertion"
echo "yum info nginx-module-security"
yum info nginx-module-security
echo "============================================="


printf '\n\n\n'
echo "============================================="
echo "Below nginx-owasp-crs Vertion"
echo "yum info nginx-owasp-crsy"
yum info nginx-owasp-crs
echo "============================================="



printf '\n\n\n'
echo "============================================="
echo "Below is libmodsecurity Vertion"
echo "yum info libmodsecurity"
yum info libmodsecurity
echo "============================================="



printf '\n\n\n'
echo "============================================="
echo "Below is Nginx Vertion"
echo "yum info nginx"
yum info nginx
echo "============================================="
printf '\n\n\n'
printf '\n\n\n'


echo "============================================="
echo "nginx -v | Get Nginx Vertion"
nginx -v
echo "============================================="

;;
########################################################
"Check ALSCO IP Firewall Setting 18")
echo "cd /etc/nginx/conf.d/alsco_data_cookie_and_ip"
echo "grep -r "allow all""
echo ""
clear
cd /etc/nginx/conf.d/alsco_data_cookie_and_ip
grep --color=always -r "allow all"
;;
########################################################
"CSF Firewall Setting 19")
clear
echo "grep --color=always -r "TESTING =" csf.conf"
echo "grep --color=always -r "TCP_IN =" csf.conf"
echo "----------------"
cd /etc/csf/
echo "--------------------------------"
grep --color=always -r "TESTING =" csf.conf
grep --color=always -r "TCP_IN =" csf.conf
grep --color=always -r "TCP_OUT =" csf.conf
grep --color=always -r "UDP_IN =" csf.conf
grep --color=always -r "UDP_OUT =" csf.conf
echo ""
echo ""
echo "--------------------------------"
echo "This is csf.allow "
cat csf.allow
echo "--------------------------------"
echo ""
echo "--------------------------------"
echo "This is csf.deny "
cat csf.deny
echo "--------------------------------"
echo "Check CSF Function in Server"

perl /usr/local/csf/bin/csftest.pl
;;
########################################################
"Check Rate Limit  Excess 20")
clear
echo "grep --color=always -r "limiting requests" /var/log/nginx/error.log"
echo "grep --color=always -r "zone=mobile_Auth_ratelimit" /etc/nginx/conf.d/0-setting.conf"
echo ""
echo "#Rule Setting======================================================"
grep --color=always -r "zone=mobile_Auth_ratelimit" /etc/nginx/conf.d/0-setting.conf
echo "#Rule Setting======================================================"

echo ""
echo ""
grep --color=always -r "limiting requests" /var/log/nginx/error.log
;;
########################################################

"clear the contents of ratelimit_tempIP_block 21")
clear
cat /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco
echo""
echo "truncate -s 0 /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco"
truncate -s 0 /etc/nginx/conf.d/alsco_data_cookie_and_ip/ALSCO-Setting/.ratelimit_tempIP_block.alsco
echo "Done"
;;

########################################################
"check SELinux 22")
clear
echo "sestatus"

sestatus
echo "==============="
echo "cat /etc/selinux/config"
echo "==============="
cat /etc/selinux/config

echo "Done"
;;

########################################################
"Grepping Access_Log logs for IP 23")
echo "tail -f /var/log/nginx/access.log | grep  --color  50.253.239.118"
echo ""
tail -f /var/log/nginx/access.log | grep --color '50.253.239.118'

;;
########################################################
"Grepping Error_Log logs for IP 24")
echo "tail -f /var/log/nginx/alsco_error.log | grep  --color '50.253.239.118'"
echo ""
tail -f /var/log/nginx/alsco_error.log | grep --color '50.253.239.118'

;;
########################################################
"IP Trace 25")
echo "yum install traceroute"
echo "traceroute -I 185.52.101.72"
echo "traceroute -I alscoip.com"

echo ""
traceroute -I 50.253.239.118

;;
########################################################
"Broadcasting server IP 26")
curl https://cpanel.net/showip.shtml
;;
################################################################################################################
################################################################################################################
"Update GEO-IP Database 27")
clear
#===Color Setting
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
bold=$(tput bold)
#===Color Setting End



cd /usr/share/GeoIP/
pwd

wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-City.mmdb -O new-GeoLite2-City.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-ASN.mmdb -O new-GeoLite2-ASN.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-Country.mmdb -O new-GeoLite2-Country.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoIP2-ISP.mmdb -O new-GeoIP2-ISP.mmdb



#Get Size for each file
Size_GeoLite2_City=$(wc -c "/usr/share/GeoIP/new-GeoLite2-City.mmdb" | awk '{print $1}')
Size_GeoLite2_ASN=$(wc -c "/usr/share/GeoIP/new-GeoLite2-ASN.mmdb" | awk '{print $1}')
Size_GeoLite_Country=$(wc -c "/usr/share/GeoIP/new-GeoLite2-Country.mmdb" | awk '{print $1}')
Size_GeoIP_ISP=$(wc -c "/usr/share/GeoIP/new-GeoIP2-ISP.mmdb" | awk '{print $1}')



Myfile1_Path="/usr/share/GeoIP/GeoLite2-City.mmdb"
Myfile2_Path="/usr/share/GeoIP/GeoLite2-ASN.mmdb"
Myfile3_Path="/usr/share/GeoIP/GeoLite2-Country.mmdb"
Myfile4_Path="/usr/share/GeoIP/GeoIP2-ISP.mmdb"




#Check if GeoLite2_City size less then 90kb
if(($Size_GeoLite2_City>90000)); then
    echo "GeoLite2-City not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoLite2-City.mmdb] is less 90KB${NC}"
    exit
fi


#Check if GeoLite2_ASN size less then 90kb
if(($Size_GeoLite2_ASN>90000)); then
    echo "GeoLite2-ASN not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoLite2-ASN.mmdb] is less 90KB${NC}"
    exit
fi



#Check if GeoLite_Country size less then 90kb
if(($Size_GeoLite_Country>90000)); then
    echo "GeoLite2-Country not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoLite2-Country.mmdb] is less 90KB${NC}"
    exit
fi



#Check if GeoIP_ISP size less then 90kb
if(($Size_GeoIP_ISP>90000)); then
    echo "GeoIP2-ISP not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoIP2-ISP.mmdb] is less 90KB${NC}"
    exit
fi



echo ""
echo ""
#Start Delete Files only if all new download is over 90KB
rm $Myfile1_Path
rm $Myfile2_Path
rm $Myfile3_Path
rm $Myfile4_Path


#Start rename files
mv new-GeoLite2-City.mmdb GeoLite2-City.mmdb
mv new-GeoLite2-ASN.mmdb GeoLite2-ASN.mmdb
mv new-GeoLite2-Country.mmdb GeoLite2-Country.mmdb
mv new-GeoIP2-ISP.mmdb GeoIP2-ISP.mmdb


#Print all files sizes
echo "${RED}${bold}$Myfile1_Path" $(date -r $Myfile1_Path)${NC}
echo "${RED}${bold}$Myfile2_Path" $(date -r $Myfile2_Path)${NC}
echo "${RED}${bold}$Myfile3_Path" $(date -r $Myfile3_Path)${NC}
echo "${RED}${bold}$Myfile4_Path" $(date -r $Myfile4_Path)${NC}


echo "Done"
nginx -t
systemctl restart nginx
echo ""
echo ""
;;
################################################################################################################
################################################################################################################
"ALSCO Centos7 Repository Build 28")
yum clean all
yum clean headers
yum clean metadata
yum clean packages

cd /etc/yum.repos.d/
pwd
rm -rf *
echo "We have discovered and removed an old repository";
ls -al



#Start Install Centos7 Repo
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



#Start Install ALSCO_Nginx Repo
ALSCO_Path="/etc/yum.repos.d/ALSCO_Nginx.repo"

cat <<EOF >>/etc/yum.repos.d/ALSCO_Nginx.repo
[ALSCO-Nginx]
name=RHEL Apache
baseurl=http://repo.alscoip.com/Linux/Nginx_Centos7/
enabled=1
gpgcheck=0
EOF


echo "";
echo "";
echo "";

cd /etc/yum.repos.d/
pwd
echo "List ALL";
ls

;;
########################################################
########################################################

"Generate Cloudflare IP List for CSF 29")
clear
# Retrieve the IP addresses from the URL
IPs4=$(curl -s https://www.cloudflare.com/ips-v4)
IPv6=$(curl -s https://www.cloudflare.com/ips-v6)


echo "#============================"
echo "#cloudflare HTTP/Port80"
#Loop through the IP4/Port80
for ip in $IPs4; do
  echo "tcp|in|d=80|s=$ip"
done


#Loop through the IP6/Port80
for ipv6 in $IPv6; do
  echo "tcp|in|d=80|s=$ipv6"
done
echo "#==End IP4=================="


echo "##cloudflare HTTPS/Port443"
#Loop through the IP4/Port443
for ip in $IPs4; do
  echo "tcp|in|d=443|s=$ip"
done


#Loop through the IP6/Port443
for ipv6 in $IPv6; do
  echo "tcp|in|d=443|s=$ipv6"
done
echo "#==End IP6=========================="


echo -e "\n\n\n"

echo "#This is for Nginx"
echo "#============================"
echo "# - IPv4"

#Loop through the IPv4
for ip in $IPs4; do
  echo "set_real_ip_from $ip;"
done


echo "# - IPv6"
# Loop through the IPv6
for ip in $IPv6; do
  echo "set_real_ip_from $ip;"
done

echo "real_ip_header     CF-Connecting-IP;"
echo "#===End========================="
;;
################################################################################################################


"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
