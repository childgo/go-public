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
"Update GEO-IP Database 26"

"Quit")


select opt in "${options[@]}"
do
case $opt in

########################################################
"Total IP connected to Server 1")

clear;while x=0; do clear;date;echo "";echo "[Total Number]";echo "-------------------";echo "Port[80]"; netstat -plan | grep :80 | wc -l;echo "Port[443]";netstat -plan | grep :443 | wc -l;echo "Port[3306]";netstat -plan | grep :3306 | wc -l; sleep 5;done


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
#. /alscospider/setting-conf.alsco
#echo ". /alscospider/setting-conf.alsco"


#Enable Write On conf.d files
sudo chcon -t httpd_sys_rw_content_t /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -R
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.map')
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.ip.alsco')
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.ipsetting.alsco')
chown apache $(find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f  -name '*.ratelimit_tempIP_block.alsco')
echo "Done"

;;
########################################################
"check Nginx version 17")
echo "nginx -v"
nginx -v
echo ""
echo "nginx -V"
nginx -V
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
echo "traceroute -I 185.52.101.72"
echo ""
traceroute -I 50.253.239.118

;;

########################################################
"Update GEO-IP Database 26")
bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/nginx/Update_GEO_DB.sh)
;;

########################################################

"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
