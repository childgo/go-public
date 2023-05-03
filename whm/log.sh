clear
PS3='Please enter your choice: '
options=("tail all Apache error log 1" "tail all mod_security Apache error log 2" "tail all mod_security Apache error log for specific domain 3" "tail all Apache error log for specific domain 4" "tail-Grep Apache error_log for specific IP 5" "tail-Grep access_log log for specific IP 6" "watch tail specific domain from access-logs 7" "grep any word from error log 8" "grep ModSecurity and count every hit 9" "grep any word and count every hit 10" "read input - output speed 11" "display only active Internet connections to the server at port80 12" "List count of connections by state, Detect if you are having SYN flood: 13" "Detect if you are having SYN flood 14" "block ip using csf firewall 15" "Unblock all IP in csf 16" "grep all post from one domain 17" "search in email_exim 18" "grep POST in all server 19" "grep file name from domain log 20" "count mod security per rule per domain 21" "tail mysql error 22" "tail IMAP and POP3 login attempts 23" "search in IMAP and POP3 login attempts 24" "tail login attempts for the SSH daemon 25" "tail login attempts and general error messages in ftp and dns 26" "tail logs of a user's activities while they are logged into the cPanel 27" "Find the number of requests per IP address 28" "Find the most popular URLs requested 29" "tail exim_mainlog 30" "Apache-Here is how you get all of the IP's connecting to the server 31" "Apache-Here is how you get only the top 10 IP's 32" "Apache-Here is how you get all of the IP's with the pages 33" "Apache-Here is how you get only the top 10 IP's with the pages 34" "Apache- apachectl fullstatus 35" "General server info 36" "Apache- maxrequestworkers 37" "Apache-grep maxrequestworkers 38" "Apache-grep scoreboard 39" "Apache-grep maxclients 40" "mysqladmin proc 41" "apache-systemctl status httpd 42" "grep TCP_IN 43" "SSH last login 44"  "apache-most page is requested by users 45" "Option 46" "Quit")
select opt in "${options[@]}"
do
case $opt in

########################################################
"tail all Apache error log 1")
tail -f /etc/apache2/logs/error_log
;;
########################################################

"tail all mod_security Apache error log 2")
tail -f /etc/apache2/logs/error_log | grep ModSecurity
;;
########################################################

"tail all mod_security Apache error log for specific domain 3")
read -p 'Domain: ' domain
tail -f /etc/apache2/logs/error_log | grep ModSecurity | grep $domain
;;
########################################################
"tail all Apache error log for specific domain 4")
read -p 'Domain: ' domain
tail -f /etc/apache2/logs/error_log | grep $domain
;;
########################################################
"tail-Grep Apache error_log for specific IP 5")
read -p 'ip: ' ip
tail -f /usr/local/apache/logs/error_log | grep $ip
;;
########################################################
"tail-Grep access_log log for specific IP 6")
read -p 'ip: ' ip
tail -f /usr/local/apache/logs/access_log | grep $ip
;;
########################################################
"watch tail specific domain from access-logs 7")
read -p 'Username: ' cpuser
read -p 'Domain: ' domain
watch "tail -n 500  /home/$cpuser/access-logs/$domain | cut -d' ' -f1 | sort | uniq -c | sort -gr"
;;
########################################################
"grep any word from error log 8")
read -p 'word: ' word
grep $word /usr/local/apache/logs/error_log
;;
########################################################
"grep ModSecurity and count every hit 9")
grep ModSecurity /usr/local/apache/logs/error_log | sed -e 's#^.*\[id "\([0-9]*\).*hostname "\([a-z0-9\-\_\.]*\)"\].*uri "#\1 \2 #' | cut -d\" -f1 | sort -n | uniq -c | sort -n
;;
########################################################

"grep any word and count every hit 10")
read -p 'word: ' word
grep $word /usr/local/apache/logs/error_log | sed -e 's#^.*\[id "\([0-9]*\).*hostname "\([a-z0-9\-\_\.]*\)"\].*uri "#\1 \2 #' | cut -d\" -f1 | sort -n | uniq -c | sort -n
;;
########################################################
"read input - output speed 11")
echo "the code is...iostat -xtc 1 10|awk '/iowait/{getline;print $4,"%io"}'"
iostat -xtc 1 10|awk '/iowait/{getline;print $4,"%io"}'
;;
########################################################
"display only active Internet connections to the server at port80 12")
echo "To display only active Internet connections to the server at port 80 
and sort the results,allow to recognize many connections coming from one IP"
netstat -an | grep :80 | sort | less
;;
########################################################
"List count of connections by state, Detect if you are having SYN flood: 13")
netstat -npt | awk '{print $6}' | sort | uniq -c | sort -nr | head
echo "SYN_RECV state it means your server has received the initial SYN packet, it has sent it's own SYN+ACK packet and is waiting on the ACK from the external machine to complete the TCP handshake."
echo ""
echo""
;;
########################################################
"Detect if you are having SYN flood 14")
netstat -npt  | grep SYN_RECV | awk '{print $5}' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
echo ""
echo "Detect if its from single IP(DOS attack) or multiple IPs(DDOS attack) by SYN_RECV"
echo "you should block the IP"
;;
########################################################
"block ip using csf firewall 15")
read -p 'ip: ' ip
read -p 'comment: ' comment
csf -d $ip $comment
;;
########################################################
"Unblock all IP in csf 16")


csf -tf
csf -df
echo "csf -tf Flush all IPs from the temporary IP entries"
echo "csf -df Flush all IPs from the temporary IP entries"
echo ""
echo ""
;;
########################################################
"grep all post from one domain 17")
read -p 'Domain: ' domain
grep POST /usr/local/apache/domlogs/$domain
;;
########################################################
"search in email_exim 18")

read -p 'email: ' email
exigrep $email /var/log/exim_mainlog

#grep qmitc.com /var/log/exim_mainlog
;;
########################################################
"grep POST in all server 19")
grep POST /usr/local/apache/domlogs/*
;;
########################################################
"grep file name from domain log 20")
read -p 'Domain: ' domain
read -p 'file: ' file
grep $file /usr/local/apache/domlogs/$domain
;;
########################################################
"count mod security per rule per domain 21")
read -p 'Domain: ' domain

grep $domain /usr/local/apache/logs/error_log | sed -e 's#^.*\[id "\([0-9]*\).*hostname "\([a-z0-9\-\_\.]*\)"\].*uri "#\1 \2 #' | cut -d\" -f1 | sort -n | uniq -c | sort -n
;;
########################################################
"tail mysql error 22")
echo "please enter server hostname hostname.err"
read -p 'Hostname: ' hhostname
tail -f /var/lib/mysql/$hhostname.err
;;
########################################################
"tail IMAP and POP3 login attempts 23")
cd ..
echo "This file contains IMAP and POP3 login attempts, transactions, fatal errors, and Apache SpamAssassin™ scores."
tail -f /var/log/maillog
;;
########################################################
"search in IMAP and POP3 login attempts 24")
read -p 'word: ' word
grep $word /var/log/maillog

;;
########################################################
"tail login attempts for the SSH daemon 25")
tail -f /var/log/secure
;;
########################################################
"tail login attempts and general error messages in ftp and dns 26")
tail -f /var/log/secure
;;
########################################################
"tail logs of a user's activities while they are logged into the cPanel 27")
tail -f /usr/local/cpanel/logs/session_log
;;
########################################################
"Find the number of requests per IP address 28")
read -p 'Domain: ' domain
read -p 'user: ' user
awk '{printf "%s %s\n",$2,$1}' /home/$user/access-logs/$domain | sort | uniq -c | awk '{printf "%04d %s %s\n",$1,$2,$3}' | sort
;;
########################################################
"Find the most popular URLs requested 29")
read -p 'Domain: ' domain
read -p 'user: ' user
egrep -o "(GET|POST|HEAD) [^ ]*" /home/$user/access-logs/$domain| sort | uniq -c | sort -n


;;
########################################################
"tail exim_mainlog 30")
tail -f /var/log/exim_mainlog


;;
########################################################
"Apache-Here is how you get all of the IP's connecting to the server 31")
apachectl fullstatus | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk '{print $12}' | sort | uniq -c | sort -rnk1
;;
########################################################
"Apache-Here is how you get only the top 10 IP's 32")
apachectl fullstatus | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk '{print $12}' | sort | uniq -c | sort -rnk1 | head -10
;;
########################################################
"Apache-Here is how you get all of the IP's with the pages 33")
apachectl fullstatus | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk '{print $12" "$14" "$16}' | sort | uniq -c | sort -rnk1
;;
########################################################
"Apache-Here is how you get only the top 10 IP's with the pages 34")
apachectl fullstatus | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk '{print $12" "$16}' | sort | uniq -c | sort -rnk1 | head -10
;;
########################################################
"Apache- apachectl fullstatus 35")
apachectl fullstatus
;;
########################################################
"General server info 36")
echo -e "\nCentOS Version"; cat /etc/redhat-release; echo -e "\ncPanel Version"; cat /usr/local/cpanel/version; echo -e "\nApache version, MPM, and build date"; httpd -V | head -8;echo -e "\nPHP Handler Information"; /usr/local/cpanel/bin/rebuild_phpconf --current ; php -v | head -1 ; php -i | grep memory_limit|head -1 ;echo -e "\nMySQL Version Information";mysql --version; echo -e "\n MySQL Database Table usage by Storage Engine" ; mysql -e 'SELECT ENGINE,ROUND(SUM(data_length) /1024/1024, 1) AS "Data MB", ROUND(SUM(index_length)/1024/1024, 1) AS "Index MB", ROUND(SUM(data_length + index_length)/1024/1024, 1) AS "Total MB", COUNT(*) "Num Tables" FROM  INFORMATION_SCHEMA.TABLES WHERE  table_schema not in ("information_schema", "performance_schema") GROUP BY ENGINE;'; echo -e "\nMySQL connection limit versus actually used" ; mysql -e "show variables like '%max_connections%';show global status like '%max_u%';"; echo -e "\nCurrent MySQL Buffer Pool Size" ; mysql -e "show variables where variable_name like '%innodb_buffer_pool_size%' OR variable_name like '%key_buffer%';" | tail -2 | awk '{print $1,$2/1024/1024 "MB"}'; echo -e "\nDisk usage df -h";df -h ;[[ -f /usr/bin/lsblk ||  -f /bin/lsblk ]] && (echo -e "\nlsblk results"; lsblk) || (echo -e "\nOS too old for lsblk, or lsblk unavailable. Showing mount results instead";mount | grep "/dev/" | egrep -v "tmpfs|devpts"); echo -e "\nFdisk Information for drive sizes"; fdisk -l | grep "Disk /dev" |grep -v GPT;echo -e "\ncPanel accounts on the server";cat /etc/userdomains | awk '{print $NF}' | grep -v nobody | sort | uniq  | wc -l
;;
########################################################
"Apache- maxrequestworkers 37")
grep -ia maxrequestworkers /var/log/apache2/error_log | awk '{print $2" "$3" "substr($4, 1, 3)" "$11" "$12" "$13" "$14" "$15" "$16" "$17" "$18" "$19" "$20}' | uniq -c | tail
;;
########################################################
"Apache-grep maxrequestworkers 38")
grep -i maxrequestworkers /var/log/apache2/error_log |tail -1
;;
########################################################
"Apache-grep scoreboard 39")
grep -i scoreboard /var/log/apache2/error_log |tail -1
;;
########################################################
"Apache-grep maxclients 40")
grep -i maxclients /var/log/apache2/error_log |tail -1
;;
########################################################
"mysqladmin proc 41")
mysqladmin proc
;;
########################################################
"apache-systemctl status httpd 42")
systemctl status httpd
;;
########################################################
"grep TCP_IN 43")
egrep '^TCP_IN =' /etc/csf/csf.conf
;;
########################################################
"SSH last login 44")
last | head
;;
########################################################
"apache-most page is requested by users 45")
apachectl fullstatus | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk '{print $14" "$16}' | sort | uniq -c | sort -rnk1
;;
########################################################
"Option 46")
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
