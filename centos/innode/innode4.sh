#!/bin/bash
# ^ that line is important
clear


#!/bin/bash
while :
do
	echo "Press [CTRL+C] to stop.."
	echo "Server Ip:" $(hostname -i)
	echo "Server Host:" $(hostname -f)
	usr=$1
	cd $usr
	echo "Detailed Inode usage: $(pwd)" ; for d in `find -maxdepth 1 -type d |cut -d\/ -f2 |grep -xv . |sort`; do c=$(find $d |wc -l) ; printf "$c\t\t- $d\n" ; done ; printf "Total: \t\t$(find $(pwd) | wc -l)\n"
	echo "Total Size:" $(du -h $usr --max-depth=0)
	echo "======================="
	echo "======================="
	#end command


	sleep 8
        clear
done
