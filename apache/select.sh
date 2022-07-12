clear
PS3='Please enter your choice: '
options=("Total IP connected to Server 1" "List of IP connected to Server 2" "Number of IP per Domain 3" "Clear mod_security Database 4" "Rebuild httpd conf and Restart Httpd 5" "Number of IP per Domain 6" "Clear All Domains Log And Fix Disk Space Quota 7" "Full Backup Immediately 8" "Clear All Mail In Queue 9" "Update cPanel License 10" "Report How Many Emails Sent From Server 11" "check_cpanel_rpms Script 12" "Repair all MySql 13" "analyze all MySql 14" "optimize all MySql 15" "Remove all Block ip in CSF 16" "Restart MySQL 17" "Restart SMTP 18" "Restart IMAP/POP3 19" "Restart DNS 20" "Clear all error log 21" "display all files and folders sorted by MegaBytes 22" "find files in the "home" directory that are 500000k or larger 23" "server disk space 24" "Broadcasting server IP 25" "cPanel fix quotas 26" "Rebuild and reload DNS Zone 27" "Create Email 28" "delete Email  29" "view cronjob 30" "Apache graceful restart 31" "empty alscogatewaytmp 32" "Fix Quotas 33" "Change Email Password 34" "Find cPanel User for Domain 35" "Option 36" "Quit")
select opt in "${options[@]}"
do
case $opt in

########################################################
"Total IP connected to Server 1")
clear;while x=0; do clear;date;echo "";echo "   [Total Number]";echo "-------------------";echo Port[80]; netstat -plan | grep :80 | wc -l;  echo Port[443]; netstat -plan | grep :443 | wc -l;echo Port[3306]; netstat -plan | grep :3306 | wc -l; sleep 5;done ;;
########################################################

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
"Number of IP per Domain 6")
echo "please Type the domain name,followed by [ENTER]:"
read usrdom
USRDOMn="$usrdom"

echo "please Type the User for the domain,followed by [ENTER]:"
read usrdomw
USRDOMnw="$usrdomw"
watch "tail -n 500  /home/$USRDOMnw/access-logs/$USRDOMn | cut -d' ' -f1 | sort | uniq -c | sort -gr"
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
"Repair all MySql 13")
mysqlcheck --all-databases -r
;;
########################################################
"analyze all MySql 14")
mysqlcheck --all-databases -a
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
df -i
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


echo "please Type Email Account ID you want to chanel,followed by [ENTER]:"
read alsco_get_email_id

#Get Only Domain from Email Account
alsco_get_domain=$(cut -d "@" -f2 <<< "$alsco_get_email_id")

#Get cPanel User from Domain
alsco_get_user=$(grep $alsco_get_domain /etc/trueuserdomains | awk '{print $2}' )


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

result_user=$(grep $USRDOMn /etc/trueuserdomains | awk '{print $2}' )


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
