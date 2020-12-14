clear

PS3='Please enter your choice: '

options=("Grep WHM root IP login for 2020 1" "search for python files 2" "Grep words and exclude some files extension 3" "find files older than 20 days 4" "grep SecRuleEngine Off from userdata 5" "find every symbolic link on a server 6" "List all connected SSH sessions 7" "find all hidden files 8" "check all immutable files 9" "Option 10" "Quit")

select opt in "${options[@]}"
do
case $opt in

########################################################
"Grep WHM root IP login for 2020 1")
echo "grep  2020 //usr/local/cpanel/logs/access_log | grep -E '\sroot\s' | cut -f1 -d\  | sort -u"
grep  2020 //usr/local/cpanel/logs/access_log | grep -E '\sroot\s' | cut -f1 -d\  | sort -u
;;
########################################################

"search for python files 2")
echo "find /home/*/www/ -name *.py"
find /home/*/www/ -name *.py
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
"Option 10")
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
