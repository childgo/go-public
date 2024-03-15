#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/emails_files_count.sh)

clear

# Function to count files in a directory and print in same line
count_files() {
    echo -n "Count in $1: "
    find "$1" -type f | wc -l
}

# Prompt user for group selection
echo "Select a group to print file counts for:"
echo "1) Group1_53_62"
echo "2) Group2_53_62"
echo "3) Group3_53_16"
echo "4) Group4_52.29"
read -p "Enter your choice (1/2/3/4): " group_choice

case $group_choice in
    1)
        echo "User selected Group1_53_62 [00.00.53.62]"
        count_files "/home/soc"
        count_files "/home/gcans"
        count_files "/home/icaagov"
        count_files "/home/industry"
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
        echo -e "\n\n\n\n"
        echo "Part4 [00.00.52.29]"
        count_files "/home/bsroti"
        count_files "/home/fbsamail"
        count_files "/home/gfcoil"
        count_files "/home/heesco"
        count_files "/home/idcgov"
        count_files "/home/ifargov"
        count_files "/home/iotcoil"
        count_files "/home/kotioil"
        count_files "/home/mcbpcgov"
        count_files "/home/mdocoil"
        count_files "/home/mod"
        count_files "/home/mrcoil"
        count_files "/home/nanepedu"
        count_files "/home/ngcoil"
        count_files "/home/oecoil"
        count_files "/home/opcoil"
        count_files "/home/opdcoil"
        count_files "/home/otibaiji"
        count_files "/home/oilprdc"
        count_files "/home/rafidain"
        count_files "/home/research"
        count_files "/home/sgcoil"
        count_files "/home/tocoil"
        count_files "/home/motioil"
        echo -e "\n\n\n\n"
        # Add additional directories for Group4 here if needed
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo -e "\n\n\n\n"
