clear
PS3='Please enter your choice: '
options=("Total IP connected to Server 1" "List of IP connected to Server 2" "Lock Folder 3" "Unlock Folder 4" "check Lock 5" "Restart Nginx 6" "Reload Nginx 7" "nginx -t 8"  "Tail Nginx error Log 9" "Tail Nginx access Log 10" "Restart PHP 11" "Nginx conf Path 12" "Nginx Log Path 13" "disk space used and available 14" "pgrep -x inotify.alsco 15" "Enable SELinux + PHP + Apache to write/access php file 16"
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

;;
########################################################
"Unlock Folder 4")
echo "chattr -R -i /var/www/html/"
chattr -R -i /var/www/html/

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
tail -f /var/log/nginx/error.log
;;
########################################################
"Tail Nginx access Log 10")
echo "tail -f /var/log/nginx/access.log"


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
echo ". /alscospider/setting-conf.alsco"
. /alscospider/setting-conf.alsco
echo ". /alscospider/setting-conf.alsco"
;;
########################################################
"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
