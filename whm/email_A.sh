#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/whm/emails_files_count.sh)

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

# Function to count files in a directory and print with formatting
count_files() {
    count=$(find "$1" -type f 2>/dev/null | wc -l)
    formatted_count=$(format_number "$count")
    echo "Count in $1: $formatted_count"
}

# Function to count and display files in /www, /etc, /mail
count_core_dirs() {
    echo -e "\n${CYAN}Now counting core system folders:${NC}"
    dirs=("/www" "/etc" "/mail")
    total=0

    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            count=$(find "$dir" -type f 2>/dev/null | wc -l)
            total=$((total + count))
            formatted=$(format_number "$count")
            echo -e "${YELLOW}Files in $dir:${NC} ${GREEN}$formatted${NC}"
        else
            echo -e "${RED}Directory $dir does not exist.${NC}"
        fi
    done

    formatted_total=$(format_number "$total")
    echo -e "\n${CYAN}Total files across /www, /etc, and /mail:${NC} ${GREEN}$formatted_total${NC}\n"
}

# Prompt user for group selection
echo "Select a group to print file counts for:"
echo "1) Group1_53_62"
echo "2) Group2_53_63"
echo "3) Group3_53_16"
echo "4) Group4_52.29"
echo "5) Group5_101_62"
read -p "Enter your choice (1/2/3/4/5): " group_choice

case $group_choice in
    1)
        echo "User selected Group1_53_62 [00.00.53.62]"
        count_files "/home/soc"
        count_files "/home/gcans"
        count_files "/home/icaagov"
        count_files "/home/motgov"
        ;;
    2)
        echo "User selected Group2_53_63 [00.00.53.63]"
        count_files "/home/iraqair"
        count_files "/home/oilgov"
        count_files "/home/iqpost"
        ;;
    3)
        echo "User selected Group3_53_16 [00.00.53.16]"
        count_files "/home/emailmoelc"
        count_files "/home/moi"
        count_files "/home/resmoelc"
        ;;
    4)
        echo "User selected Group4_52.29 [00.00.52.29]"
        count_files "/home/mohgov"
        count_files "/home/tocoil"
        count_files "/home/nrcoil"
        count_files "/home/mowr"
        count_files "/home/industry"
        count_files "/home/idcgov"
        count_files "/home/mod"
        count_files "/home/mcbpcgov"
        count_files "/home/oecoil"
        count_files "/home/ifargov"
        count_files "/home/bsroti"
        count_files "/home/oilprdc"
        count_files "/home/nanepedu"
        count_files "/home/heesco"
        count_files "/home/mrcoil"
        count_files "/home/research"
        count_files "/home/fbsamail"
        count_files "/home/sgcoil"
        count_files "/home/ngcoil"
        count_files "/home/mdocoil"
        count_files "/home/gfcoil"
        count_files "/home/opdcoil"
        count_files "/home/iotcoil"
        count_files "/home/rafidain"
        count_files "/home/otibaiji"
        count_files "/home/opcoil"
        count_files "/home/kotioil"
        count_files "/home/motioil"
        count_files "/home/ismamo"
        count_files "/home/council"
        count_files "/home/icts"
        count_files "/home/nocoil"
        count_files "/home/kroil"
        count_files "/home/damanmoh"
        count_files "/home/scp"
        count_files "/home/agricult"
        count_files "/home/phdiq"
        ;;
    5)
        echo "User selected Group5_101_62 [00.00.101.62]"
        count_files "/home/cou3333ncil"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Run the core directory count at the end
count_core_dirs

echo -e "\n\n"
