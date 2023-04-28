clear
PS3='Please enter your choice: '
options=("Total IP connected to Server 1"
"List of IP connected to Server 2"
"Number of IP per Domain 3"
"Clear mod_security Database 4"
"Rebuild httpd conf and Restart Httpd 5"
"Monitor Webmail 2096 Port and Load 6"
"Clear All Domains Log And Fix Disk Space Quota 7"
"Full Backup Immediately 8"
"Clear All Mail In Queue 9"
"Update cPanel License 10"
"Report How Many Emails Sent From Server 11"
"check_cpanel_rpms Script 12"
"Start delete all email messages in the Trash folders 13"
"Analyze and Repair all MySql 14"
"optimize all MySql 15"
"Remove all Block ip in CSF 16"
"Restart MySQL 17"
"Restart SMTP 18"
"Restart IMAP/POP3 19"
"Restart DNS 20"
"Clear all error log 21"
"display all files and folders sorted by MegaBytes 22"
"find files in the "home" directory that are 500000k or larger 23"
"server disk space 24"
"Broadcasting server IP 25"
"cPanel fix quotas 26"
"Rebuild and reload DNS Zone 27"
"Create Email 28"
"delete Email  29"
"view cronjob 30"
"Apache graceful restart 31"
"empty alscogatewaytmp 32"
"Fix Quotas 33"
"Change Email Password 34"
"Find cPanel User for Domain 35"
"Option 36"
"Quit")
select opt in "${options[@]}"
do
case $opt in

########################################################
"Total IP connected to Server 1")
#clear;while x=0; do clear;date;echo "";echo "   [Total Number]";echo "-------------------";echo Port[80]; netstat -plan | grep :80 | wc -l;  echo Port[443]; netstat -plan | grep :443 | wc -l;echo Port[3306]; netstat -plan | grep :3306 | wc -l; sleep 5;done ;;

#clear;while x=0; do clear;date;echo "";echo "   [Total Number]";echo "-------------------";echo Port[80]; netstat -plan | grep :80 | wc -l;  echo Port[443]; netstat -plan | grep :443 | wc -l; echo Port[3306]; netstat -plan | grep :3306 | wc -l;echo Port[2096]; netstat -plan | grep :2096 | wc -l; echo Port[2095]; netstat -plan | grep :2095 | wc -l; echo Port[2086]; netstat -plan | grep :2086 | wc -l;echo Port[2087]; netstat -plan | grep :2087 | wc -l; sleep 5;done ;;

clear;while x=0; do clear;date;echo "";echo "   [Total Number]";echo "-------------------";echo Port[80]; netstat -plan | grep :80 | wc -l;  echo Port[443]; netstat -plan | grep :443 | wc -l; echo Port[3306]; netstat -plan | grep :3306 | wc -l;echo Port[2096-Webmail - SSL]; netstat -plan | grep :2096 | wc -l; echo Port[2095-Webmail]; netstat -plan | grep :2095 | wc -l; echo Port[2086-WHM]; netstat -plan | grep :2086 | wc -l;echo Port[2087-WHM - SSL]; netstat -plan | grep :2087 | wc -l;echo Port[2082-cPanel]; netstat -plan | grep :2082 | wc -l;echo Port[2083-cPanel - SSL]; netstat -plan | grep :2083 | wc -l;echo Port[25 - SMTP]; netstat -plan | grep :25 | wc -l;echo Port[587 - SMTP Alternate]; netstat -plan | grep :587 | wc -l;echo Port[465-SMTP - SSL]; netstat -plan | grep :465 | wc -l;echo Port[110-POP3]; netstat -plan | grep :110 | wc -l;echo Port[995-POP3 - SSL]; netstat -plan | grep :995 | wc -l;echo Port[143-IMAP]; netstat -plan | grep :143 | wc -l;echo Port[993-IMAP - SSL]; netstat -plan | grep :993 | wc -l;echo Port[21-FTP]; netstat -plan | grep :21 | wc -l;echo Port[22-SFTP/SSH]; netstat -plan | grep :22 | wc -l; sleep 10;done ;;########################################################

"List of IP connected to Server 2")
clear;while x=0; do clear;date;echo "";echo "  [Total Number]";echo "-------------------";netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n; sleep 15;done;;
########################################################

"Number of IP per Domain 3")
service httpd fullstatus | grep "GET" | awk '{print $13}' | sort | uniq -c | sort -n
apachectl fullstatus | grep "GET" | awk '{print $13}' | sort | uniq -c | sort -n
;;
########################################################
"Clear mod_security Database 4")
mv /var/cpanel/modsec/modsec.sqlite /var/cpanel/modsec/modsec.sqlite-bak
/scripts/setup_modsec_db

#delete files in /var/log/apache2/modsec_audit/
echo "delete files in /var/log/apache2/modsec_audit/"
find /var/log/apache2/modsec_audit/ | wc -l
rm -rf /var/log/apache2/modsec_audit/*
find /var/log/apache2/modsec_audit/ | wc -l

;;
########################################################
"Rebuild httpd conf and Restart Httpd 5")
/scripts/rebuildhttpdconf
/scripts/restartsrv_httpd
;;
########################################################
"Monitor Webmail 2096 Port and Load 6")
clear


while true; do

    
    echo "System Load Averages:"
    uptime | awk '{print "1-minute load average: "$10"\n5-minute load average: "$11"\n15-minute load average: "$12}'
    
    echo ""
    echo "[WebMail Secure Port: 2096]"
    ss -ant '( sport = :2096 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[Webmail UnSecure Port: 2095]"
    ss -ant '( sport = :2095 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[IMAP Secure Port: 993]"
    ss -ant '( sport = :993 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[IMAP UnSecure Port: 143]"
    ss -ant '( sport = :143 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[POP3 Secure Port: 995]"
    ss -ant '( sport = :995 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[POP3 UnSecure Port: 110]"
    ss -ant '( sport = :110 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[SMTP Secure Port: 465]"
    ss -ant '( sport = :465 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[SMTP Secure Port: 587]"
    ss -ant '( sport = :587 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    echo "[SMTP UnSecure Port: 25]"
    ss -ant '( sport = :25 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    
    echo "[Traffic: 443]"
    ss -ant '( sport = :443 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
        echo "[Traffic Port: 80]"
    ss -ant '( sport = :80 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn
    echo ""
    
    
    sleep 5
    clear
done



;;
########################################################
"Clear All Domains Log And Fix Disk Space Quota 7")
find /home/ -name "*.gz" -type f -delete
/scripts/fixquotas
;;

########################################################

"Full Backup Immediately 8")
/usr/local/cpanel/bin/backup --force
;;
########################################################


"Clear All Mail In Queue 9")
exim -bp | awk '/^ *[0-9]+[mhd]/{print "exim -Mrm " $3}' | bash
;;
########################################################
"Update cPanel License 10")
/usr/local/cpanel/cpkeyclt
;;
########################################################
"Report How Many Emails Sent From Server 11")
perl <(curl -s https://raw.githubusercontent.com/cPanelTechs/SSE/master/sse.pl) -s
;;
########################################################
"check_cpanel_rpms Script 12")
/scripts/check_cpanel_rpms --fix
;;
########################################################
"Start delete all email messages in the Trash folders 13")
clear
echo "Start delete all email messages in the Trash folders of cPanel email account"
echo "find /home/*/mail/*/*/.Trash/{cur,new} -type f -exec rm -f '{}' \;"
echo "..."
find /home/*/mail/*/*/.Trash/{cur,new} -type f -exec rm -f '{}' \;
echo "Done"
;;
########################################################
"Analyze and Repair all MySql 14")
clear
echo "mysqlcheck --all-databases -a"
echo "mysqlcheck --all-databases -r"
echo ""
mysqlcheck --all-databases -a
mysqlcheck --all-databases -r
echo "Done"
;;
########################################################
"optimize all MySql 15")
mysqlcheck --all-databases -o
;;
########################################################
"Remove all Block ip in CSF 16")
/usr/sbin/csf -df
;;
########################################################
"Restart MySQL 17")
/scripts/restartsrv_mysql
;;
########################################################
"Restart SMTP 18")
/scripts/restartsrv_exim
;;
########################################################
"Restart IMAP/POP3 19")
/scripts/restartsrv_dovecot 
;;
########################################################
"Restart DNS 20")
/scripts/rebuilddnsconfig
;;
########################################################
"Clear all error log 21")
echo "find /home -type f -name error_log -exec rm -f {} \;"
find /home -type f -name error_log -exec rm -f {} \;
;;
########################################################
"display all files and folders sorted by MegaBytes 22")
cd ..
cd ..
du --max-depth=1 | sort -n | awk 'BEGIN {OFMT = "%.0f"} {print $1/1024,"MB", $2}'
;;
########################################################
"find files in the "home" directory that are 500000k or larger 23")
find /home -type f -size +500000k -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
;;
########################################################
"server disk space 24")
df -h
echo "----------------------------------------"
echo "----------------------------------------"

df -i

echo "----------------------------------------"

echo "----------------------------------------"
echo "Check Ram"
echo "----------------------------------------"
echo "free -m -h"
free -m -h


;;
########################################################
"Broadcasting server IP 25")
curl https://cpanel.net/showip.shtml
;;
########################################################
"cPanel fix quotas 26")
/scripts/fixquotas
;;
########################################################
"Rebuild and reload DNS Zone 27")
/scripts/rebuilddnsconfig
;;
########################################################
"Create Email 28")
/scripts/addpop
;;
########################################################
"delete Email  29")
/scripts/delpop
;;
########################################################
"view cronjob 30")
ps auxfwww | grep CROND -A1
;;
########################################################
"Apache graceful restart 31")
apachectl graceful
;;
########################################################
"empty alscogatewaytmp 32")
du -msh /alscogatewaytmp/
rm /alscogatewaytmp/*
du -msh /alscogatewaytmp/
;;
########################################################
"Fix Quotas 33")
/scripts/fixquotas
;;
########################################################
"Change Email Password 34")

echo "please Type Email Account ID,followed by [ENTER]:"
read alsco_get_email_id

#Get Only Domain from Email Account
alsco_get_domain=$(cut -d "@" -f2 <<< "$alsco_get_email_id")

#Get cPanel User from Domain
alsco_get_user=$(/scripts/whoowns $alsco_get_domain)





#============================================================================
#Start Generate Password
#============================================================================
lowercase_first_letters=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 2 | head -n 1)
lowercase_second_letters=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 2 | head -n 1)
lowercase_third_letters=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 2 | head -n 1)

uppercase_first_letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 3 | head -n 1)
uppercase_second_letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 3 | head -n 1)
uppercase_third_letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 3 | head -n 1)

numbers_first_only=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)
numbers_second_only=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)
numbers_third_only=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)

special_first_characters=$(cat /dev/urandom | tr -dc '!@#' | fold -w 2 | head -n 1)
special_second_characters=$(cat /dev/urandom | tr -dc '!@#' | fold -w 2 | head -n 1)
special_third_characters=$(cat /dev/urandom | tr -dc '!@#' | fold -w 2 | head -n 1)


#Email Randon Password
final_email_password=$lowercase_first_letters$uppercase_first_letters$special_second_characters$numbers_second_only$lowercase_second_letters
#============================================================================
#End Generate Password
#============================================================================


uapi --output=jsonpretty --user=$alsco_get_user Email passwd_pop email=$alsco_get_email_id password=$final_email_password


#Start Restart exim and imap
/scripts/restartsrv_exim
/scripts/restartsrv_dovecot


echo "======================================================================"
echo " "
echo "Domain is [$alsco_get_domain] cPanel User is [$alsco_get_user] and E-Mail Account is: [$alsco_get_email_id]"
echo " "
echo "New Password for Email: [$alsco_get_email_id] is: [$final_email_password]"
echo " "
echo "======================================================================"

echo " "

;;
########################################################
"Find cPanel User for Domain 35")
echo "please Type the domain name,followed by [ENTER]:"
read usrdom
USRDOMn="$usrdom"


#grep $USRDOMn /etc/trueuserdomains

#result_user=$(grep $USRDOMn /etc/trueuserdomains | awk '{print $2}' )
result_user=$(/scripts/whoowns aqsaalmadenah.com)




echo "User are:  $result_user"

;;
########################################################
"Option 36")
echo "test"


;;
########################################################

"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
