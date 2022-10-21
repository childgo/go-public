#!/bin/bash
# ^ that line is important
clear


echo "please Type the User,followed by [ENTER]:"
read usr
USR="$usr"

echo "please Type the Domain,followed by [ENTER]:"
read dom
DOM="$dom"

echo "please Type days,followed by [ENTER]:"
read tim
TIM="$tim"


echo "The current Size is:"
du -h /home/$usr --max-depth=0

echo "The current Total Files:"
find /home/$usr/ -type f | wc -l
echo ""
echo ""

source=("cur" ".Drafts" ".Junk" ".Sent" ".Trash" "new" "tmp")
for ((i=0; i < ${#source[@]}; i++))
do


find /home/$USR/mail/$DOM/*/${source[$i]} -mtime +$TIM -type f -delete

done


echo "The New Size is:"
du -h /home/$usr --max-depth=0

echo "The New Total Files Number is:"
find /home/$usr/ -type f | wc -l
echo ""
echo ""
