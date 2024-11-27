clear

#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/email.sh)


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
"Remove all Block ip in CSF 10"
"List All Domains And Folder Size 11"
"server disk space 12"
"Reset Password for all emails account and save them to file 13"
"Create a list of emails accounts under a domain 14"
"Update All Emails Quota Under Domain 15"
"List All Emails Size Under Domain 16"
"Enable or Disable Email 2Auth 17"
"Check and empty Email Log 18"
"List all Emails Filters 19"
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
#below is old
#exim -bp | awk '/^ *[0-9]+[mhd]/{print "exim -Mrm " $3}' | bash

exim -bp | awk '/^ *[0-9]+[mhd]/{print "exim -Mrm " $3}' | bash

#this is new
exim -bp | awk '/^[0-9]/ {print $3}' | xargs -n 1 exim -Mrm

#restart the Exim mail service
service exim restart


#this below step force delete
#exim -bpc
#systemctl stop exim
#rm -rf /var/spool/exim/input/*
#systemctl start exim
#exim -bpc


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




########################################################
"Remove all Block ip in CSF 10")
clear
/usr/sbin/csf -df
echo "Done"

;;
########################################################




########################################################
"List All Domains And Folder Size 11")
#dnf install bc
#yum install bc

clear
# Function to calculate folder size in GB or MB
get_folder_size() {
    size_in_bytes=$(du -sb "$1" | awk '{ print $1 }')
    size_in_gb=$(echo "scale=2; $size_in_bytes / (1024*1024*1024)" | bc)

    if (( $(bc <<< "$size_in_gb >= 1") )); then
        echo "${size_in_gb}GB"
    else
        size_in_mb=$(echo "scale=2; $size_in_bytes / (1024*1024)" | bc)
        echo "${size_in_mb}MB"
    fi
}

# Function to count total files in a directory
count_files() {
    find "$1" -type f | wc -l
}

# Read domains and user associations from /etc/trueuserdomains
while IFS= read -r line; do
    user=$(echo "$line" | awk '{ print $2 }')
    domain=$(echo "$line" | awk '{ print $1 }')

    echo "Domain: $domain"

    # Calculate the total size of the user's path
    user_path="/home/$user"
    total_size=$(get_folder_size "$user_path")

    # Count total files in the user's path
    total_files=$(count_files "$user_path")

    echo "cPanel User: $user"
    echo "Total Size: $total_size"
    echo "Total Files: $total_files"
    echo "------------------------"
done < /etc/trueuserdomains



#Print total size
echo ""
output=$(du -s --block-size=1G /home)
# ANSI color codes
yellow='\033[1;33m'
reset='\033[0m'

# Print in yellow
echo -e "${yellow}The full size is: ${output} GB${reset}"




echo "Done"

;;
########################################################


########################################################
"server disk space 12")
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





########################################################
"Reset Password for all emails account and save them to file 13")

#!/bin/bash
clear

echo "Please Type Domain, followed by [ENTER]:"
read alsco_get_domain

# Get cPanel User from Domain
alsco_get_user=$(/scripts/whoowns $alsco_get_domain)

echo "Domain:" $alsco_get_domain
echo "cPanel User:" $alsco_get_user

# Confirm if the cPanel username is correct
echo "Is the cPanel username correct? Type 'yes' to continue or 'no' to exit:"
read confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Exiting script."
    exit 1
fi

# Define the output file based on the domain name
output_file="/alscospider/${alsco_get_domain}_email_accounts.txt"
> "$output_file" # This empties the file if it already exists or creates it if it doesn't

while IFS= read -r email; do
    password=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 1 | head -n 1)$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 4 | head -n 1)$(cat /dev/urandom | tr -dc '0-9' | fold -w 2 | head -n 1)$(cat /dev/urandom | tr -dc '@#!' | fold -w 2 | head -n 1)$(cat /dev/urandom | tr -dc 'a-z' | fold -w 1 | head -n 1)

    # Output the generated password
    echo "Email: $email, Password: $password"

    # Write the email and password to the output file
    echo "Email: $email, Password: $password" >> "$output_file"

    # Use the uapi command to change the password for the email
    uapi --output=jsonpretty --user=$alsco_get_user Email passwd_pop email="$email" password="$password"

    # Add any additional logic or commands here if needed for each email account
done < <(uapi --user=$alsco_get_user Email list_pops domain=$alsco_get_domain | grep -o 'email: [^ ]*' | awk '{print $2}')

echo "Process completed successfully!"
echo "The email accounts and passwords have been saved to: $output_file"


echo "Done"
;;
########################################################


#######################################################
"Create a list of emails accounts under a domain 14")



# Ask for the domain
echo "Please Type Domain, followed by [ENTER]:"
read alsco_get_domain

# Get cPanel User from Domain
alsco_get_user=$(/scripts/whoowns $alsco_get_domain)

echo "Domain:" $alsco_get_domain
echo "cPanel User:" $alsco_get_user

# Confirm if the cPanel username is correct
echo "Is the cPanel username correct? Type 'yes' to continue or 'no' to exit:"
read confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Exiting script."
    exit 1
fi

# Assuming continuation if 'yes'
PASSWORD="asaded@1ews" # Prompt for this or generate dynamically for better security
CPANEL_USER=$alsco_get_user

# List of email prefixes with dots replaced by hyphens
emails=(
    deputy.mgnt
    advisor.admin
    tech.advisor
    p.f.dep
    financial.dep
    ge.dsurvey
)

# Loop through the list and check if email exists before creating
for email in "${emails[@]}"; do
    email_prefix=${email//./-} # Correctly replace dots with hyphens in the email prefix
    full_email="$email_prefix@$alsco_get_domain"

    # Check if the email account already exists
    if uapi --user=$CPANEL_USER Email list_pops | grep -q "$full_email"; then
        echo "Error: The email $full_email already exists. Skipping creation."
    else
        # Email does not exist, proceed to create
        uapi --user=$CPANEL_USER Email add_pop email=$email_prefix domain=$alsco_get_domain password=$PASSWORD quota=250
        echo "Created $full_email with 250 MB quota."
    fi
done

echo "Process completed."
;;
########################################################





########################################################
"Update All Emails Quota Under Domain 15")
clear
echo "Please Type Domain, followed by [ENTER]:"
read alsco_get_domain

# Get cPanel User from Domain
alsco_get_user=$(/scripts/whoowns $alsco_get_domain)

echo "Domain:" $alsco_get_domain
echo "cPanel User:" $alsco_get_user

# Confirm if the cPanel username is correct
echo "Is the cPanel username correct? Type 'yes' to continue or 'no' to exit:"
read confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Exiting script."
    exit 1
fi

# Prompt for the new quota size
echo "Please enter the new quota size in MB, followed by [ENTER]:"
echo "Examples: 10240 = 10 GB, 20480 = 20 GB, 5120 = 5 GB"
read new_quota

# Validate the quota input
if ! [[ "$new_quota" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a valid number."
    exit 1
fi

# Fetch email accounts and update quotas
while IFS= read -r email; do
    username=$(echo $email | cut -d'@' -f1)
    # Use the uapi command to change the quota for the email
    /usr/local/cpanel/bin/uapi --user=$alsco_get_user Email edit_pop_quota email=$username domain=$alsco_get_domain quota=$new_quota

    # Output the email and updated quota
    echo "Updated quota for $email to $((new_quota / 1024)) GB"

done < <(uapi --user=$alsco_get_user Email list_pops domain=$alsco_get_domain | grep -o 'email: [^ ]*' | awk '{print $2}')

echo "Process completed successfully!"
echo "All email accounts under $alsco_get_domain have been updated to a quota of $((new_quota / 1024)) GB."

echo "Done"
;;
########################################################







########################################################
"List All Emails Size Under Domain 16")
clear

echo "Please Type Domain, followed by [ENTER]:"
read alsco_get_domain

# Get cPanel User from Domain
alsco_get_user=$(/scripts/whoowns $alsco_get_domain)

echo "Domain:" $alsco_get_domain
echo "cPanel User:" $alsco_get_user

# Confirm if the cPanel username is correct
echo "Is the cPanel username correct? Type 'yes' to continue or 'no' to exit:"
read confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Exiting script."
    exit 1
fi

# Function to convert human-readable sizes to a format for sorting
convert_to_sortable() {
    local size=$1
    echo $size | awk '/G/ { printf "%.0f\n", $1 * 1024 * 1024 } /M/ { printf "%.0f\n", $1 * 1024 } /K/ { printf "%.0f\n", $1 } !/[GMK]/ { print $1 * 1024 }'
}

# Fetch email account sizes and store them in an array
email_sizes=()
while IFS= read -r line; do
    email=$(echo $line | awk -F'email: ' '{print $2}' | awk '{print $1}')
    usage=$(echo $line | awk -F'humandiskused: ' '{print $2}')
    if [[ -n $usage && -n $email ]]; then
        sortable_size=$(convert_to_sortable "$usage")
        email_sizes+=("$sortable_size $usage $email")
    fi
done < <(/usr/local/cpanel/bin/uapi --user=$alsco_get_user Email list_pops_with_disk domain=$alsco_get_domain | grep -E 'email:|humandiskused:' | paste - -)

# Sort the email accounts by size in descending order
IFS=$'\n' sorted_email_sizes=($(sort -nr <<<"${email_sizes[*]}"))
unset IFS

# Output the sorted email account sizes
echo -e "Email Account Sizes for Domain: $alsco_get_domain\n"
echo -e "Disk Usage\t\tEmail Account"
for entry in "${sorted_email_sizes[@]}"; do
    usage=$(echo $entry | awk '{print $2 " " $3}')
    email=$(echo $entry | awk '{print $4}')
    printf "%-20s %s\n" "$usage" "$email"
done

echo -e "\nProcess completed successfully!"
echo "All email accounts under $alsco_get_domain have been listed by disk space usage."
echo "Done"
;;
########################################################




########################################################
"Enable or Disable Email 2Auth 17")

Auth_PHP_FILE="/usr/local/cpanel/base/3rdparty/roundcube/plugins/alsco_auth/.db_info.php"



# Get the current value of Auth_Working
current_value=$(grep -oP '\$Auth_Working = "\K(Yes|No)' "$Auth_PHP_FILE")

# Print the current value
echo -e "Current value of Auth_Working is: ${RED}$current_value${NC}"

echo " "


# Prompt user for the desired value
read -p "Enter the new value for Auth_Working (Yes/No): " new_value

# Validate input
if [[ "$new_value" != "Yes" && "$new_value" != "No" ]]; then
    echo "Invalid input. Please enter 'Yes' or 'No'."
    exit 1
fi

# Use sed to change Auth_Working value to the user's choice
sed -i "s/\$Auth_Working = \"Yes\";/\$Auth_Working = \"$new_value\";/; s/\$Auth_Working = \"No\";/\$Auth_Working = \"$new_value\";/;" "$Auth_PHP_FILE"

echo "Auth_Working has been changed to $new_value in $PHP_FILE"

;;
########################################################


########################################################
"Check and empty Email Log 18")
clear

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# List of files to check
files=(
    "/usr/local/cpanel/logs/cphulkd.log"
    "/usr/local/cpanel/logs/login_log"
    "/var/log/maillog"
    "/usr/local/cpanel/logs/session_log"
    "/var/log/exim_mainlog"
)

# Loop through each file and display its size in MB
for file in "${files[@]}"
do
    if [ -f "$file" ]; then
        size=$(du -m "$file" | cut -f1)
        echo -e "${GREEN}Size of $file: ${RED}${size}MB${NC}"
    else
        echo -e "${RED}$file does not exist.${NC}"
    fi
done

# Ask the user if they want to empty the files
read -p "Do you want to empty all the files? (yes/no): " choice

if [[ "$choice" == "yes" || "$choice" == "y" ]]; then
    # Empty all files using sudo truncate
    for file in "${files[@]}"
    do
        if [ -f "$file" ]; then
            sudo truncate -s 0 "$file"
            echo -e "${GREEN}$file has been emptied.${NC}"
        fi
    done

    # Restart email-related services
    echo -e "${GREEN}Restarting email-related services...${NC}"
    
    sudo systemctl restart exim         # Restart SMTP
    sudo systemctl restart dovecot      # Restart IMAP and POP3
    sudo systemctl restart cpanel       # Restart cPanel services if necessary
    
    echo -e "${GREEN}Email services have been restarted.${NC}"
else
    echo -e "${GREEN}Files have been kept unchanged.${NC}"
fi



;;
########################################################



########################################################
"List all Emails Filters 19")

echo "Start"
for user in $(ls /var/cpanel/users); do echo "Filters for user: $user"; [ -d "/etc/vfilters" ] && for file in /etc/vfilters/*; do echo "Filters for domain $(basename $file):"; cat $file; done; done


;;
########################################################



########################################################
"Option 20")
echo "Done"


;;
########################################################



"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
