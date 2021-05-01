#!/bin/bash
# ^ that line is important
clear
#pull all data from 162.144.49.210 to this local server

usr=$1

echo "Master server"
cd $usr
echo "Detailed Inode usage: $(pwd)" ; for d in `find -maxdepth 1 -type d |cut -d\/ -f2 |grep -xv . |sort`; do c=$(find $d |wc -l) ; printf "$c\t\t- $d\n" ; done ; printf "Total: \t\t$(find $(pwd) | wc -l)\n"
echo "Server Host:" $(hostname -f)
echo "Total Size:" $(du -h $usr --max-depth=0)


echo "======================="
echo "======================="
