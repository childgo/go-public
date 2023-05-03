clear
PS3='Please enter your choice: '
options=("Monitor Webmail 2096 Port and Load 1"
"Start delete all email messages in the Trash folders 2"
"Fix A Corrupted RoundCube SQLite Database 3"
"Clear All Mail In Queue 4"
"Report How Many Emails Sent From Server 5"
"Change Email Password 6"
"Create Email 7"
"Delete Email 8"
"Delete Emails Older Than [X] Days 9"



"Quit")
select opt in "${options[@]}"
do
case $opt in

########################################################
"Monitor Webmail 2096 Port and Load 1")
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
"Start delete all email messages in the Trash folders 2")
clear

echo "Start delete all email messages in the Trash folders of cPanel email account"
echo "find /home/*/mail/*/*/.Trash/{cur,new} -type f -exec rm -f '{}' \;"
echo "..."
find /home/*/mail/*/*/.Trash/{cur,new} -type f -exec rm -f '{}' \;
echo "Done"
;;
########################################################


########################################################
"Fix A Corrupted RoundCube SQLite Database 3")
clear



#===Color Setting
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
bold=$(tput bold)
#===Color Setting End






# Ask for email address
read -p "Enter email address: " email_address



#Extract Username 
Only_Account=$(echo $email_address | cut -d "@" -f1)

#Extract Domain
Only_Domain=$(echo $email_address | cut -d "@" -f2)

#Get Domain Owner
User_Domain=$(awk -F ': ' '$1 == "'$Only_Domain'" {print $2}' /etc/trueuserdomains)


# Change directory
cd /home/$User_Domain/etc/$Only_Domain/
cwd=$(pwd)


# Print username and domain and email
printf '\n\n\n'
echo "EMail: ${RED}${bold} $email_address ${NC}"
echo "Username: ${RED}${bold} $Only_Account ${NC}"
echo "Domain: ${RED}${bold} $Only_Domain ${NC}"
echo "cPanel User: ${RED}${bold} $User_Domain ${NC}"
echo "The current path is ${RED}${bold} $cwd ${NC}"
printf '\n\n\n'


#######################################################
#Ask me if i want to contine 
echo "Do you want to continue install a new skin now? [y/n]"
read choice

if [ "$choice" == "n" ]; then
  echo "Exiting..."
  exit 0
else
  echo "Continuing..."
fi
#######################################################






# Rename file
mv -v $Only_Account.rcube.db $Only_Account.rcube.db.bak




# Sleep for 3 seconds
sleep 3
printf '\n\n\n'


/scripts/restartsrv_cpsrvd --hard

;;
########################################################


########################################################
"Clear All Mail In Queue 4")
clear
exim -bp | awk '/^ *[0-9]+[mhd]/{print "exim -Mrm " $3}' | bash
;;
########################################################



########################################################
"Report How Many Emails Sent From Server 5")
clear
perl <(curl -s https://raw.githubusercontent.com/cPanelTechs/SSE/master/sse.pl) -s
;;
########################################################






########################################################
"Change Email Password 6")
clear


#===Color Setting
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
bold=$(tput bold)
#===Color Setting End




echo "please Type Email Account ID,followed by [ENTER]:"
read alsco_get_email_id

#Get Only Domain from Email Account
alsco_get_domain=$(cut -d "@" -f2 <<< "$alsco_get_email_id")

#Get cPanel User from Domain
alsco_get_user=$(/scripts/whoowns $alsco_get_domain)

#=================================
#Start Generate Password
#=================================
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
#echo "New Password for Email: [$alsco_get_email_id] is: [$final_email_password]"
echo "Email: ${RED}${bold} $alsco_get_email_id ${NC}"
echo "New Password: ${RED}${bold} $final_email_password ${NC}"


echo " "
echo "======================================================================"

echo " "

;;
########################################################





########################################################
"Create Email 7")
clear
/scripts/addpop
;;
########################################################


########################################################
"Delete Email 8")
clear
/scripts/delpop
;;
########################################################



########################################################
"Delete Emails Older Than [X] Days 9")
clear

#===Color Setting
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
bold=$(tput bold)
#===Color Setting End


echo "please Type the Domain,followed by [ENTER]:"
read dom
Only_Domain="$dom"

echo "please Type days,followed by [ENTER]:"
read tim
TIM="$tim"


#Get Domain Owner
User_Domain=$(awk -F ': ' '$1 == "'$Only_Domain'" {print $2}' /etc/trueuserdomains)


# Change directory
cd /home/$User_Domain/mail/$Only_Domain/
cwd=$(pwd)



# Print username and domain and email
printf '\n\n\n'
echo "Domain: ${RED}${bold} $Only_Domain ${NC}"
echo "cPanel User: ${RED}${bold} $User_Domain ${NC}"
echo "Days : ${RED}${bold} $tim ${NC}"
echo "The current path is ${RED}${bold} $cwd ${NC}"
printf '\n\n\n'


#######################################################
#Ask me if i want to contine 
echo "Do you want to continue install a new skin now? [y/n]"
read choice

if [ "$choice" == "n" ]; then
  echo "Exiting..."
  exit 0
else
  echo "Continuing..."
fi
#######################################################


echo "The current Size is:"
du -h /home/$User_Domain --max-depth=0

echo "The current Total Files:"
find /home/$User_Domain/ -type f | wc -l
echo ""
echo ""

source=("cur" ".Drafts" ".Junk" ".Sent" ".Trash" "new" "tmp")
for ((i=0; i < ${#source[@]}; i++))
do


find /home/$User_Domain/mail/$Only_Domain/*/${source[$i]} -mtime +$TIM -type f -delete

done


echo "The New Size is:"
du -h /home/$User_Domain --max-depth=0

echo "The New Total Files Number is:"
find /home/$User_Domain/ -type f | wc -l
echo ""
echo ""
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