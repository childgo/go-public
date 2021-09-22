clear

PS3='Please enter your choice: '

options=("Grep WHM root IP login for 2021 1" "search for python and ini 2" "Grep words and exclude some files extension 3" "find files older than 20 days 4" "grep SecRuleEngine Off from userdata 5" "find every symbolic link on a server 6" "List all connected SSH sessions 7" "find all hidden files 8" "check all immutable files 9" "search for htaccess 10" "search for asp 11" "search for sh 12" "search for txt 13" "search for log 14" "grep TCP_IN 15" "grep Hosts.allow 16" "Option 16" "Quit")
select opt in "${options[@]}"
do
case $opt in

########################################################
"Grep WHM root IP login for 2021 1")
echo "grep  2021 //usr/local/cpanel/logs/access_log | grep -E '\sroot\s' | cut -f1 -d\  | sort -u"
grep  2021 //usr/local/cpanel/logs/access_log | grep -E '\sroot\s' | cut -f1 -d\  | sort -u
;;
########################################################

"search for python and ini 2")
echo "find /home/*/www/ -name *.py"
echo "find /home/*/www/ -name *.ini"
find /home/*/www/ -name *.py
echo ""
find /home/*/www/ -name *.ini




;;
########################################################

"Grep words and exclude some files extension 3")
echo "egrep -r --color \"base64_decode|mysql\" /home/*/www/ --exclude={error_log,*.xml,*.js,*.pdf,*.css,*.htm,*.txt,*.svg,*.html,*.jsx,*.md,*.inc}"
egrep -r --color "base64_decode|mysql" /home/*/www/ --exclude={error_log,*.xml,*.js,*.pdf,*.css,*.htm,*.txt,*.svg,*.html,*.jsx,*.md,*.inc}
;;
########################################################
"find files older than 20 days 4")
echo "find /home/*/public_html/* -type f -mtime -20 -printf "%T+\t%p\n" | sort -r"
find /home/*/public_html/* -type f -mtime -20 -printf "%T+\t%p\n" | sort -r

;;
########################################################
"grep SecRuleEngine Off from userdata 5")

echo "grep -r --color "SecRuleEngine Off" /etc/apache2/conf.d/userdata/"
echo "grep -r --color "SecFilterEngine Off" /etc/apache2/conf.d/userdata/"
grep -r --color "SecRuleEngine Off" /etc/apache2/conf.d/userdata/
grep -r --color "SecFilterEngine Off" /etc/apache2/conf.d/userdata/
;;
########################################################
"find every symbolic link on a server 6")
echo "find /home/*/public_html/* -type l -exec ls -l {} \;"
find /home/*/public_html/* -type l -exec ls -l {} \;
;;
########################################################
"List all connected SSH sessions 7")
echo "netstat -tnpa | grep 'ESTABLISHED.*sshd'"
echo "or"
echo "last | grep \"still logged in\""
echo ""

netstat -tnpa | grep 'ESTABLISHED.*sshd'
echo ""
last | grep "still logged in"
;;

########################################################
"find all hidden files 8")
echo "find /home/*/www/ -path '*/.*' -ls"
find /home/*/www/ -path '*/.*' -ls 


;;
########################################################
"check all immutable files 9")

lsattr /home/*/public_html/
lsattr /home/*/www/.htaccess
lsattr /home/*/www/*/.htaccess
lsattr /home/*/www/*/*/.htaccess
lsattr /home/*/www/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/.htaccess


;;
########################################################
"search for htaccess 10")
echo "find /home/*/www/ -name *.htaccess"
find /home/*/www/ -name *.htaccess

;;
########################################################
"search for asp 11")
echo "find /home/*/www/ -name *.asp"
echo "find /home/*/www/ -name *.aspx"

find /home/*/www/ -name *.asp
find /home/*/www/ -name *.aspx

;;
########################################################
"search for sh 12")
echo "find /home/*/www/ -name *.sh"
find /home/*/www/ -name *.sh

;;
########################################################
"search for txt 13")
echo "find /home/*/www/ -name *.txt"
find /home/*/www/ -name *.txt

;;
########################################################
"search for log 14")
echo "find /home/*/www/ -name *.log"
find /home/*/www/ -name *.log

;;
########################################################
"grep TCP_IN 15")
echo "egrep '^TCP_IN =' /etc/csf/csf.conf"
echo "egrep '^TCP_OUT =' /etc/csf/csf.conf"

egrep '^TCP_IN =' /etc/csf/csf.conf
egrep '^TCP_OUT =' /etc/csf/csf.conf

;;
########################################################

"grep Hosts.allow 16")
echo "grep "whostmgrd"  hosts.allow"
echo ""
echo ""
grep --color=always -r "whostmgrd"  /etc/hosts.allow
echo ""
grep --color=always -r "sshd"  /etc/hosts.allow
echo ""
grep --color=always -r "cpaneld"  /etc/hosts.allow
echo ""
grep --color=always -r "ftp"  /etc/hosts.allow
echo ""



;;



########################################################



"Option 16")
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
