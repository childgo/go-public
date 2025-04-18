#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/whm/emails_files_count.sh)


#Lists all cPanel account home paths
#awk -F: '$3 >= 1000 && $1 != "nobody" { print "/home/" $1 }' /etc/passwd | sort | awk '{ print; count++ } END { print "\nTotal accounts: " count }'



clear

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Function to format numbers with commas
format_number() {
    echo "$1" | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
}

# Count files in the root of user home
count_files() {
    count=$(find "$1" -type f 2>/dev/null | wc -l)
    formatted_count=$(format_number "$count")
    echo "Count in $1: $formatted_count"
}

# Count files in www, etc, mail inside user dirs
# Count www, etc, mail inside user dirs and group by user
count_user_internal_dirs() {
    echo -e "\n${CYAN}Now counting www, etc, mail folders inside user homes:${NC}"

    subdirs=("public_html" "etc" "mail")

    for user_dir in "$@"; do
        if [ ! -d "$user_dir" ]; then
            echo -e "${RED}User dir $user_dir not found. Skipping.${NC}"
            continue
        fi

        username=$(basename "$user_dir")
        domain="${username}.gov.iq"  # adjust this logic if domain differs per user

        echo -e "\n${CYAN}User: $username | Domain: $domain${NC}"

        user_total=0
        for sub in "${subdirs[@]}"; do
            full_path="$user_dir/$sub"
            if [ -d "$full_path" ]; then
                count=$(find "$full_path" -type f 2>/dev/null | wc -l)
                user_total=$((user_total + count))
                formatted=$(format_number "$count")
                echo -e "${YELLOW}Files in $full_path:${NC} ${GREEN}$formatted${NC}"
            else
                echo -e "${RED}Directory $full_path does not exist.${NC}"
            fi
        done

        formatted_total=$(format_number "$user_total")
        echo -e "${CYAN}Total is:${NC} ${GREEN}$formatted_total${NC}"
    done
}


# Prompt user for group selection
echo "Select a group to print file counts for:"
echo "1) Group1_53_62"
echo "2) Group2_53_63"
echo "3) Group3_53_16"
echo "4) Group4_52.29"
echo "5) Group5_53.47"
read -p "Enter your choice (1/2/3/4/5): " group_choice

case $group_choice in
    1)
        echo "User selected Group1_53_62 [00.00.53.62]"
        users=(/home/soc
               /home/gcans
               /home/icaagov)
        ;;
    2)
        echo "User selected Group2_53_63 [00.00.53.63]"
        users=(/home/iraqair
               /home/oilgov
               /home/iqpost)
        ;;
    3)
        echo "User selected Group3_53_16 [00.00.53.16]"
        users=(/home/emailmoelc
               /home/moi
               /home/resmoelc)
              
        ;;
    4)
        echo "User selected Group4_52.29 [00.00.52.29]"
        users=(/home/agricult
               /home/bsroti
               /home/council
               /home/cust0mzm
               /home/damanmoh
               /home/fbsamail
               /home/gcpi
               /home/gfcoil
               /home/heesco
               /home/icts
               /home/idcgov
               /home/ifargov
               /home/industry
               /home/iotcoil
               /home/ismamo
               /home/ismamot
               /home/kotioil
               /home/kroil
               /home/mcbpcgov
               /home/mdocoil
               /home/mocoil
               /home/mod
               /home/mohgov
               /home/motioil
               /home/mowr
               /home/mrcoil
               /home/najafmoh
               /home/nanepedu
               /home/ngcoil
               /home/nocoil
               /home/nrcoil
               /home/oecoil
               /home/officesupport
               /home/oilprdc
               /home/opcoil
               /home/opdcoil
               /home/otibaiji
               /home/phdiq
               /home/planmoh
               /home/research
               /home/scp
               /home/scrtiin
               /home/sgcoil
               /home/tocoil
               /home/trafficmoi)
        ;;
    5)
        echo "User selected Group5_101_62 [00.00.53.47]"
        users=(/home/motgov)
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Count files in base home folders
#for user in "${users[@]}"; do
    #count_files "$user"
#done

# Count files in www, etc, mail
count_user_internal_dirs "${users[@]}"

echo -e "\n\n"
