#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/select.sh)

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
"Restart PHP and Session Path  11"
"Nginx conf Path 12"
"Nginx Log Path 13"
"disk space used and available 14"
"Cookie List 15"
"Inotify and Enable SELinux + PHP + Apache to write/access php 16"
"check Linux and Nginx version 17"
"Check ALSCO IP Firewall Setting 18"
"CSF Firewall Setting 19"
"Check Rate Limit  Excess 20"
"clear the contents of ratelimit_tempIP_block 21"
"check SELinux 22"
"Generate WeDos IP List for Nginx and csf 23"
"Check SG Domains Files Counts 24"
"IP Trace 25"
"Broadcasting server IP 26"
"Update GEO-IP Database 27"
"ALSCO Centos7 Repository Build 28"
"Generate Cloudflare IP List for CSF 29"
"Seucre Gateway Log Parsing  logs 30"
"Delete all Nginx Logs 31"
"Free RAM Loop 32"
"AlmaLinux9 Network Tools 33"
"Change Root Password 34"
"Clear All SSH History 35"

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
    echo "Total Port 80 connections regardless of state:" $(netstat -an | grep :80 | wc -l)
    printf '\n\n\n'

    echo "[Port: 443]"
    ss -ant '( sport = :443 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo "Total  Port 443 connections regardless of state:" $(netstat -an | grep :443 | wc -l)
    printf '\n\n\n'
    
   echo "[Port: 3306]"
    ss -ant '( sport = :3306 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo "Total Port 3306 connections regardless of state:" $(netstat -an | grep :3306 | wc -l)
    printf '\n\n\n'


    echo "[Port: 22]"
    ss -ant '( sport = :22 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo "Total Port 22 connections regardless of state:" $(netstat -an | grep :22 | wc -l)
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

echo "chattr -R +i /home/www/html/alscocloud/process/"
chattr -R +i /home/www/html/alscocloud/process/

echo "chattr -R +i /home/www/html/msg/"
chattr -R +i /home/www/html/msg/


echo ""
echo "Checking..."
lsattr /var/www/html/
;;
########################################################
"Unlock Folder 4")
echo "chattr -R -i /var/www/html/"
chattr -R -i /var/www/html/

#StorageBox
echo "chattr -R -i /home/www/html/alscocloud/process/"
chattr -R -i /home/www/html/alscocloud/process/

echo "chattr -R -i /home/www/html/msg/"
chattr -R -i /home/www/html/msg/

echo ""
echo "Checking..."
lsattr /var/www/html/
;;
########################################################
"check Lock 5")
echo "lsattr /var/www/html/"
lsattr /var/www/html/

echo "lsattr /home/www/html/msg/"
lsattr /home/www/html/msg/

echo "lsattr /home/www/html/alscocloud/process/"
lsattr /home/www/html/alscocloud/process/

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


echo "Select the error log monitoring option:"
options=("All Nginx Error Logs" "Filter Logs for IP 50.253.239.118" "Filter Logs for IP 96.78.250.86" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "All Nginx Error Logs")
            cmd="tail -f /var/log/nginx/alsco_error.log"
            echo "Executing: $cmd"
            eval $cmd
            break
            ;;
        
        "Filter Logs for IP 50.253.239.118")
            cmd="tail -f /var/log/nginx/alsco_error.log | grep --color 50.253.239.118"
            echo "Executing: $cmd"
            eval $cmd
            break
            ;;
        "Filter Logs for IP 96.78.250.86")
            cmd="tail -f /var/log/nginx/alsco_error.log | grep --color 96.78.250.86"
            echo "Executing: $cmd"
            eval $cmd
            break
            ;;
        "Quit")
            echo "Exiting script."
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo ""
;;
########################################################
"Tail Nginx access Log 10")
echo "Select the log monitoring option:"
options=("All Logs" "Filter for IP 96.78.250.86" "Filter for IP 50.253.239.118" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "All Logs")
            cmd="tail -f /var/log/nginx/access.log"
            echo "Executing: $cmd"
            eval $cmd
            break
            ;;
        "Filter for IP 96.78.250.86")
            cmd="tail -f /var/log/nginx/access.log | grep --color 96.78.250.86"
            echo "Executing: $cmd"
            eval $cmd
            break
            ;;
        "Filter for IP 50.253.239.118")
            cmd="tail -f /var/log/nginx/access.log | grep --color 50.253.239.118"
            echo "Executing: $cmd"
            eval $cmd
            break
            ;;
        "Quit")
            echo "Exiting script."
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done


echo ""
;;
########################################################
"Restart PHP and Session Path  11")

echo -e "\n\n\n"
echo "service php-fpm restart"
service php-fpm restart

echo -e "\n\n\n"
echo -e "php.ini path is in '/etc/php.ini'"



echo -e "\n\n\n"
echo -e "php-fpm path is in '/var/log/php-fpm/error.log'"


echo -e "\n\n\n"
session_path="/var/lib/php/session"
echo -e "Php Session path is: $session_path/\n"


echo -e "\n\n\n"
echo "Verify that the change was successful. ...."
grep -r "session.cookie_httponly" /etc/php.ini
grep -r "session.cookie_samesite" /etc/php.ini
grep -r "memory_limit" /etc/php.ini
grep -r "post_max_size" /etc/php.ini
grep -r "upload_max_filesize" /etc/php.ini

echo -e "\n\n\n"

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


echo "----------------------------------------"
echo "command: df"
df
echo "----------------------------------------"
printf '\n\n\n'


echo "----------------------------------------"
echo "command: df -h"
df -h
echo "----------------------------------------"

printf '\n\n\n'



echo "----------------------------------------"
echo "Check Ram"
echo "----------------------------------------"
echo "free -m -h"
free -m -h
printf '\n\n\n'

echo "----------------------------------------"
echo "Check inode"
df -i
echo "----------------------------------------"


;;
########################################################
"Cookie List 15")

while true; do
    echo "Choose an option:"
    echo "a) List all cookies"
    echo "b) Delete all cookies"
    echo "q) Quit"
    read -p "Enter your choice (a/b/q): " choice

    case $choice in
        a)
            # List all cookies








#==========================================
#Start Here
current_date=$(date +%s)

# Current date/time minus 8 hours
current_date_decrease=$(date --date '-8 hours' +%s)

# Function to calculate time difference in hours and minutes
calculate_time_difference() {
    local start_time=$1
    local end_time=$2
    local time_diff=$((end_time - start_time))
    local hours=$((time_diff / 3600))
    local minutes=$(( (time_diff % 3600) / 60 ))
    echo "$hours:$minutes"
}

# Color codes for formatting
RED='\033[0;31m'
BLUE='\033[0;34m'
ORANGE='\033[0;33m'
NC='\033[0m' # No color

# First loop to find all files that end in .map
find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f -name '*.map' -print0 | 
    while IFS= read -r -d '' filepath; do 
        # Remove empty/blank lines from a file in Unix
        ex -s +'v/\S/d' -cwq "$filepath"

        # Read each line from the file
        while read -r ONELINE; do
            # Extract the timestamp enclosed in double quotes
            cookie_time=$(echo "$ONELINE" | awk -F'-' '{print $2}' | tr -d '"')
            real_cookie_alsco_time=$(date +'%Y-%m-%d %H:%M:%S' -d "@$cookie_time")
            real_current_alsco_time=$(date +'%Y-%m-%d %H:%M:%S' -d "@$current_date")

            # Extract the domain (last part of the file path)
            domain=$(basename "$(dirname "$filepath")")

            if [ "$current_date_decrease" -gt "$cookie_time" ]; then
                # Calculate the time elapsed since deletion
                time_deleted=$(calculate_time_difference "$cookie_time" "$current_date_decrease")
                # Delete lines with the specified cookie_time
                sed -i "/$cookie_time/d" "$filepath"
                echo -e "${RED}Domain: $domain | ${BLUE}Deleted: $cookie_time $time_deleted${NC} | Current Time: $real_current_alsco_time | Cookie Time: $real_cookie_alsco_time"
                echo ""

            else
                # Calculate the remaining time until deletion
                remaining_time=$(calculate_time_difference "$current_date_decrease" "$cookie_time")
                # Calculate how long ago the cookie was created
                cookie_created_time=$(calculate_time_difference "$cookie_time" "$current_date")
                # Format the message with domain, cookie created time in blue, and remaining time in orange
                echo -e "${RED}Domain: $domain${NC} | Keep: $cookie_time | Current Time: $real_current_alsco_time | Cookie Time: $real_cookie_alsco_time | Remaining Time Until Delete: ${ORANGE}$remaining_time${NC} |Cookie Created Before: ${BLUE} $cookie_created_time${NC}"
                echo ""
            fi
        done < "$filepath"
    done


#==========================================








            
            ;;
        b)
            # Delete all cookies
            find /etc/nginx/conf.d/alsco_data_cookie_and_ip/ -type f -name '*.map' -exec cp /dev/null {} \;
            echo "All cookies deleted."
            ;;
        q)
            echo "Exiting the script."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select 'a', 'b', or 'q'."
            ;;
    esac
done






;;
########################################################
"Inotify and Enable SELinux + PHP + Apache to write/access php 16")
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
"check Linux and Nginx version 17")

echo "============================================="
echo "Check Linux Verstion  [cat /etc/almalinux-release]"
cat /etc/almalinux-release
echo "============================================="

echo ""
echo "============================================="
echo "View system info (like OS, kernel, architecture): [hostnamectl]"
hostnamectl
echo ""
echo "============================================="

echo "View Nginx info [nginx -v]"
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
"Generate WeDos IP List for Nginx and csf 23")
echo ""

# URL containing the IP ranges
URL="https://ips.wedos.global/ips.txt"


echo "----------------------------------------"
echo "This is for Nginx"
# Use curl to download the IP ranges, and format them using awk
curl -s $URL | awk '{print "set_real_ip_from " $1 ";"}'
echo "----------------------------------------"



echo "----------------------------------------"
echo "This is for CSF port80"
# Use curl to download the IP ranges, and format them using awk
curl -s $URL | awk '{print "tcp|in|d=80|s=" $1 ";"}'
echo "----------------------------------------"




echo "----------------------------------------"
echo "This is for CSF port443"
curl -s $URL | awk '{print "tcp|in|d=443|s=" $1 ";"}'
# Output the formatted IP ranges
echo "----------------------------------------"

;;
########################################################
"Check SG Domains Files Counts 24")
echo ""
clear

# Paths
conf_path="/etc/nginx/conf.d/"
folder_path="/etc/nginx/conf.d/alsco_data_cookie_and_ip/"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Get list of domain names from conf files
conf_files=$(ls $conf_path | grep ".conf$" | grep -vE "^(0-setting.conf|default.conf|php-fpm.conf)$")
domain_names_from_files=()
full_file_names=()
for file in $conf_files; do
  domain=$(echo $file | sed -e 's/^[0-9]*-//' -e 's/.conf$//')
  domain_names_from_files+=("$domain")
  full_file_names+=("$file")
done

# Get list of domain names from folders, excluding 'ALSCO-Setting'
domain_names_from_folders=($(ls -d $folder_path*/ | grep -v "ALSCO-Setting" | sed -e "s|$folder_path||" -e 's|/||'))

# Print total domains
echo -e "${GREEN}Total domains from files in $conf_path: ${#domain_names_from_files[@]}${NC}"
echo ""
echo -e "${GREEN}Total domains from folders in $folder_path: ${#domain_names_from_folders[@]}${NC}"

# Find domains that exist in folders but not in files
echo -e "${RED}Domains in folders but not in files:${NC}"
for folder_domain in "${domain_names_from_folders[@]}"; do
  if [[ ! " ${domain_names_from_files[@]} " =~ " ${folder_domain} " ]]; then
    echo -e "${RED}$folder_domain${NC}"
  fi
done

# Find domains that exist in files but not in folders
echo -e "${RED}Domains in files but not in folders:${NC}"
for index in "${!domain_names_from_files[@]}"; do
  if [[ ! " ${domain_names_from_folders[@]} " =~ " ${domain_names_from_files[$index]} " ]]; then
    echo -e "${RED}${full_file_names[$index]}${NC}"
  fi
done



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
ALSCO_Path="/etc/yum.repos.d/ALSCO_CentOS7.repo"

cat <<EOF >>/etc/yum.repos.d/ALSCO_CentOS7.repo
[ALSCO-local-base]
name=CentOS Base
baseurl=https://repo.alscoip.com/Linux/CentOS_7_Final/Centos7_Sync_Repository/base/
gpgcheck=0
enabled=1
[ALSCO-local-centosplus]
name=CentOS CentOSPlus
baseurl=https://repo.alscoip.com/Linux/CentOS_7_Final/Centos7_Sync_Repository/centosplus/
gpgcheck=0
enabled=0
[ALSCO-local-extras]
name=CentOS Extras
baseurl=https://repo.alscoip.com/Linux/CentOS_7_Final/Centos7_Sync_Repository/extras/
gpgcheck=0
enabled=1
[ALSCO-local-updates]
name=CentOS Updates
baseurl=https://repo.alscoip.com/Linux/CentOS_7_Final/Centos7_Sync_Repository/updates/
gpgcheck=0
enabled=1
EOF



#Start Install ALSCO_Nginx Repo
ALSCO_Path="/etc/yum.repos.d/ALSCO_Nginx.repo"

cat <<EOF >>/etc/yum.repos.d/ALSCO_Nginx.repo
[ALSCO-Nginx-SecureGateway]
name=RHEL Apache
baseurl=https://repo.alscoip.com/Linux/CentOS_7_Final/Nginx_SecureGateway/
enabled=1
gpgcheck=0
EOF



#Start Install ALSCO_PHP73 Repo
ALSCO_Path="/etc/yum.repos.d/ALSCO_PHP73.repo"
cat <<EOF >>/etc/yum.repos.d/ALSCO_PHP73.repo
[ALSCO-PHP-SecureGateway]
name=RHEL Apache
baseurl=https://repo.alscoip.com/Linux/CentOS_7_Final/Secure_Gateway_PHP73/
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




################################################################################################################
################################################################################################################

"Seucre Gateway Log Parsing  logs 30")
clear
LOG_FILE="/var/log/nginx/full_alsco_access.log"


echo -e "---------------------------------------------------------------------------"
#Top Domain Request Counter
echo -e "\e[1;31m Domain Request Counter\e[0m"
awk -F'"' '/ALSCO_Domain/ {split($4, a, "\\["); split(a[2], b, "]"); print b[1]}' "$LOG_FILE" | sort | uniq -c | sort -nr
echo -e "-----------------------------------------\n\n\n"



echo -e "---------------------------------------------------------------------------"
#Top IP Request Counter
echo -e "\e[1;31m IP Request Counter\e[0m"
echo "These are the top 30 IPs with the highest number of requests:" && \
awk -F'"' '/ALSCO_IP/ {split($2, a, "\\["); split(a[2], b, "]"); print b[1]}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 30
echo -e "-----------------------------------------\n\n\n"



echo -e "---------------------------------------------------------------------------"
#Top Countries Request Counter
echo -e "\e[1;31m Countries Request Counter\e[0m"
echo "These are the top countries with the highest number of requests:" && \
awk -F'"' '/ALSCO_Countryname/ {split($22, a, "\\]"); gsub(/.*\[/, "", a[1]); print a[1]}' "$LOG_FILE" | sort | uniq -c | sort -nr
echo -e "-----------------------------------------\n\n\n"







#######################################################
#Ask me if i want to contine 
echo "Do you want to continue? [y/n]"
read choice

if [ "$choice" == "n" ]; then
  echo "Exiting..."
  exit 0
else
  echo "Continuing..."
fi
#######################################################




sleep 5


# Count the occurrences of each domain and sort them in descending order
awk -F'"' '/ALSCO_Domain/ {split($4, a, "\\["); split(a[2], b, "]"); print b[1]}' "$LOG_FILE" | \
sort | uniq -c | sort -nr | \
while read -r count domain; do

    echo "====================================="
    echo -e "\e[1;31mDomain: $domain (Requests: $count)\e[0m" # Domain name in bold red
    
    # Top 30 IPs for the domain
    echo "Top 30 IPs for $domain:"
    awk -F'"' -v domain="$domain" '$4 ~ domain {split($2, a, "\\["); split(a[2], b, "]"); print b[1]}' "$LOG_FILE" | \
    sort | uniq -c | sort -nr | head -n 30


    # Top 30 countries for the domain
    echo "Top 30 countries for $domain:"
    awk -F'"' -v domain="$domain" '$4 ~ domain {split($22, a, "\\["); split(a[2], b, "]"); print b[1]}' "$LOG_FILE" | \
    sort | uniq -c | sort -nr | head -n 30


    # Top 30 URLs for the domain
    echo "Top 30 URLs for $domain:"
    awk -F'"' -v domain="$domain" '$4 ~ domain {split($8, a, "\\["); split(a[2], b, "]"); print b[1]}' "$LOG_FILE" | \
    sort | uniq -c | sort -nr | head -n 30



    echo "=====================================\n\n\n"

done


#How this script works:
#It first counts and lists each domain with the number of requests.
#Then, for each domain, it lists the top 30 IP addresses and the top 30 countries based on the number of requests.
echo "#===End========================="
;;

################################################################################################################
################################################################################################################
"Delete all Nginx Logs 31")


#Ask me if i want to contine 
echo "Do you want to continue and delete all Nginx Log in /var/log/nginx/? [y/n]"
read choice

if [ "$choice" == "n" ]; then
  echo "Exiting..."
  exit 0
else
  echo "Continuing..."
fi


echo "find /var/log/nginx/ -type f -exec rm {} \;"
echo "nginx -t"
echo "systemctl restart nginx"
echo "nginx -t && systemctl restart nginx"

#Start Delete
find /var/log/nginx/ -type f -exec rm {} \;
rm -rf /alscospider/log_split_mysql/http_custom_log/log/*
rm -rf /alscospider/log_split_mysql/mod_sec_log/log/*


nginx -t && systemctl restart nginx

;;
################################################################################################################
################################################################################################################



################################################################################################################
################################################################################################################
"Free RAM Loop 32")
while true; do free -m; sleep 3; clear; done
;;

################################################################################################################
################################################################################################################




################################################################################################################
################################################################################################################
"AlmaLinux9 Network Tools 33")



while true; do
    clear
    echo "===================================="
    echo "   Network Management Utility      "
    echo "===================================="
    echo "1) Reload Network Connections (nmcli connection reload)"
    echo "2) Restart Network Manager (systemctl restart NetworkManager)"
    echo "3) Open Network Manager (nmtui)"
    echo "4) Test DNS with nslookup (nslookup gmail.com)"
    echo "5) Test DNS with dig (dig google.com)"
    echo "6) Test Local DNS Resolution (nslookup google.com @127.0.0.1)"
    echo "7) Exit"
    echo "===================================="
    read -p "Select an option [1-7]: " choice

    case $choice in
        1)
            echo "Executing: nmcli connection reload"
            nmcli connection reload
            ;;
        2)
            echo "Executing: systemctl restart NetworkManager"
            systemctl restart NetworkManager
            ;;
        3)
            echo "Executing: nmtui"
            nmtui
            ;;
        4)
            echo "Executing: nslookup gmail.com"
            nslookup gmail.com
            ;;
        5)
            echo "Executing: dig google.com"
            dig google.com
            ;;
        6)
            echo "Executing: nslookup google.com @127.0.0.1"
            nslookup google.com @127.0.0.1
            ;;
        7)
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid selection. Please choose a number between 1-7."
            ;;
    esac

    read -p "Press Enter to continue..."
done



;;




"Change Root Password 34")
echo "Command to be executed: sudo passwd root"
read -p "Do you want to change the root password? (yes/no): " answer

if [[ "$answer" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
    echo "Changing root password..."
    sudo passwd root
else
    echo "Password change skipped."
fi
;;


################################################################################################################
################################################################################################################




"Clear All SSH History 35")
echo "Clearing all SSH and bash history..."

history -c && > ~/.bash_history && unset HISTFILE && export HISTSIZE=0 && export HISTFILESIZE=0 && find /root /home -name ".bash_history" -exec rm -f {} \;


# Check root permission
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script as root."
  exit 1
fi

# Clear current session
history -c
unset HISTFILE
export HISTSIZE=0
export HISTFILESIZE=0

# Remove history files for all users
find /root /home -name ".bash_history" -exec rm -f {} \;

# Optional: wipe secure logs (auth log)
rm -f /var/log/secure*
journalctl --rotate
journalctl --vacuum-time=1s

echo "✅ SSH history and secure logs cleared."
;;



################################################################################################################
################################################################################################################


"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
