#!/bin/bash
clear

#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/emails_files_count.sh)



# Function to count files in a directory and print in same line
count_files() {
    echo -n "Count in $1: "
    find "$1" -type f | wc -l
}





echo "Part1 [00.00.53.62]"
count_files "/home/soc"
count_files "/home/gcans"
count_files "/home/icaagov"
count_files "/home/industry"
count_files "/home/motgov"
echo -e "\n\n\n\n"





echo "Part2 [00.00.53.63]"
count_files "/home/iraqair"
count_files "/home/oilgov"
count_files "/home/iqpost"
echo -e "\n\n\n\n"







echo "Part3 [00.00.53.16]"
count_files "/home/emailmoelc"
count_files "/home/moi"
count_files "/home/resmoelc"
echo -e "\n\n\n\n"






echo "Part4 [00.00.52.29]"
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



