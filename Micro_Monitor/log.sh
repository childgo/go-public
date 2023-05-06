#!/bin/bash
clear



Package_ID=$(date '+%Y-%m-%d---%H-%M-%S')

date_auto=$(date +%Y-%m-%d)
time_auto=$(date +%H:%M:%S)




echo ""
########################################################################
#Working with Server Info
########################################################################

Server_IP=`hostname -I |  awk {'print $1'}`
echo "Server_IP: $Server_IP"


Hostname=$(hostname)
echo "Hostname: $Hostname"
echo -e "\n\n"


cmd_uptime=$(uptime)
echo "uptime: $cmd_uptime"
echo -e "\n\n"




cmd_hostnamectl=$(hostnamectl)
echo "cmd_hostnamectl: $cmd_hostnamectl"






echo -e "\n\n"

########################################################################
#End,Working with Server Info
########################################################################










########################################################################
#Working with Concurrent Connections
########################################################################

Port_80_Connection=$(netstat -an | grep :80 | grep ESTABLISHED | wc -l)
echo "Port_80_Connection: $Port_80_Connection"



Port_443_Connection=$(netstat -an | grep :443 | grep ESTABLISHED | wc -l)
echo "Port_443_Connection: $Port_443_Connection"


Port_3306_Connection=$(netstat -an | grep :3306 | grep ESTABLISHED | wc -l)
echo "Port_3306_Connection: $Port_3306_Connection"

########################################################################
#End,Working with RAM
########################################################################








echo ""
echo ""
echo ""





########################################################################
#Working with RAM
########################################################################
#here i am working with RAM [free -m]


RAM_Full_Command=$(free -m)
echo "$RAM_Full_Command"

echo ""
echo ""
echo ""



RAM_Mem_Total=$(free -m | awk '/^Mem:/ {print $2}')
echo "RAM_Mem_Total: $RAM_Mem_Total"


RAM_Mem_Used=$(free -m | awk '/^Mem:/ {print $3}')
echo "RAM Mem Used: $RAM_Mem_Used"


RAM_Mem_Free=$(free -m | awk '/^Mem:/ {print $4}')
echo "RAM_Mem_Free: $RAM_Mem_Free"


RAM_Mem_shared=$(free -m | awk '/^Mem:/ {print $5}')
echo "RAM_Mem_shared: $RAM_Mem_shared"



RAM_Mem_buff_cache=$(free -m | awk '/^Mem:/ {print $6}')
echo "RAM_Mem_buff_cache: $RAM_Mem_buff_cache"


RAM_Mem_available=$(free -m | awk '/^Mem:/ {print $7}')
echo "RAM_Mem_available: $RAM_Mem_available"

echo ""



RAM_Swap_total=$(free -m | awk '/^Swap:/ {print $2}')
echo "RAM_Swap_total: $RAM_Swap_total"

RAM_Swap_used=$(free -m | awk '/^Swap:/ {print $3}')
echo "RAM_Swap_used: $RAM_Swap_used"

RAM_Swap_Free=$(free -m | awk '/^Swap:/ {print $4}')
echo "RAM_Swap_Free: $RAM_Swap_Free"


########################################################################
#End,Working with RAM
########################################################################


echo ""
echo ""
echo ""



















########################################################################
#Working with CPU
########################################################################


CPU_Total=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
echo "CPU_Total: $CPU_Total"




CPU_load=$(cat /proc/loadavg | awk '{print $1}')
echo "CPU_load: $CPU_load"

echo -e "\n\n"

########################################################################
#End,Working with CPU
########################################################################








########################################################################
#Working with CSF
########################################################################

CSF_firewall_status=$(/usr/sbin/csf -e)
echo "CSF_firewall_status: $CSF_firewall_status"



CSF_TCP4_IN=$(grep -r "TCP_IN =" /etc/csf/csf.conf)
CSF_TCP4_OUT=$(grep -r "TCP_OUT =" /etc/csf/csf.conf)
CSF_TCP4=$CSF_TCP4_IN"\n"$CSF_TCP4_OUT
echo "CSF_TCP4: $CSF_TCP4"




CSF_TCP6_IN=$(grep -r "TCP6_IN =" /etc/csf/csf.conf)
CSF_TCP6_OUT=$(grep -r "TCP6_OUT =" /etc/csf/csf.conf)
CSF_TCP6=$CSF_TCP6_IN"\n"$CSF_TCP6_OUT
echo "CSF_TCP6: $CSF_TCP6"


########################################################################
#End,Working with CSF
########################################################################



########################################################################
#Working with hosts.allow
########################################################################

grep --color=always -r "whostmgrd"  /etc/hosts.allow


Hosts_Allow=$(cat /etc/hosts.allow)

#escaped_change single quotes to the word {Single_Here_Quote}]
Hosts_Allow=$(echo "$Hosts_Allow" | sed "s/'/{Single_Quote_Here}/g")


echo "Hosts_Allow: $Hosts_Allow"

echo -e "\n\n"



########################################################################
#End,Working with hosts.allow
########################################################################












########################################################################
#Working with disk
########################################################################

server_disk_usage=$(df -h)
echo "server_disk_usage: $server_disk_usage"






########################################################################
#Working with disk
########################################################################
ssh_connnection_ip=$(who)
echo " "
echo "SSH Connnection IP: $ssh_connnection_ip"


########################################################################
#Network is up or down
Network_up_down="1"
########################################################################




########################################################################
#Start Get Port for each port
echo ""
echo ""


Port_21_Connection=$(netstat -an | grep :21 | grep ESTABLISHED | wc -l)
echo "Port_21_Connection: $Port_21_Connection"


Port_22_Connection=$(netstat -an | grep :22 | grep ESTABLISHED | wc -l)
echo "Port_22_Connection: $Port_22_Connection"


Port_25_Connection=$(netstat -an | grep :25 | grep ESTABLISHED | wc -l)
echo "Port_25_Connection: $Port_25_Connection"


Port_26_Connection=$(netstat -an | grep :26 | grep ESTABLISHED | wc -l)
echo "Port_26_Connection: $Port_26_Connection"


Port_53_Connection=$(netstat -an | grep :53 | grep ESTABLISHED | wc -l)
echo "Port_53_Connection: $Port_53_Connection"


Port_110_Connection=$(netstat -an | grep :110 | grep ESTABLISHED | wc -l)
echo "Port_110_Connection: $Port_110_Connection"


Port_143_Connection=$(netstat -an | grep :143 | grep ESTABLISHED | wc -l)
echo "Port_143_Connection: $Port_143_Connection"


Port_465_Connection=$(netstat -an | grep :465 | grep ESTABLISHED | wc -l)
echo "Port_465_Connection: $Port_465_Connection"


Port_587_Connection=$(netstat -an | grep :587 | grep ESTABLISHED | wc -l)
echo "Port_587_Connection: $Port_587_Connection"


Port_993_Connection=$(netstat -an | grep :993 | grep ESTABLISHED | wc -l)
echo "Port_993_Connection: $Port_993_Connection"


Port_995_Connection=$(netstat -an | grep :95 | grep ESTABLISHED | wc -l)
echo "Port_995_Connection: $Port_995_Connection"


Port_2082_Connection=$(netstat -an | grep :2082 | grep ESTABLISHED | wc -l)
echo "Port_2082_Connection: $Port_2082_Connection"


Port_2083_Connection=$(netstat -an | grep :2083 | grep ESTABLISHED | wc -l)
echo "Port_2083_Connection: $Port_2083_Connection"


Port_2086_Connection=$(netstat -an | grep :2086 | grep ESTABLISHED | wc -l)
echo "Port_2086_Connection: $Port_2086_Connection"


Port_2087_Connection=$(netstat -an | grep :2087 | grep ESTABLISHED | wc -l)
echo "Port_2087_Connection: $Port_2087_Connection"


Port_2095_Connection=$(netstat -an | grep :2095 | grep ESTABLISHED | wc -l)
echo "Port_2095_Connection: $Port_2095_Connection"


Port_2096_Connection=$(netstat -an | grep :2096 | grep ESTABLISHED | wc -l)
echo "Port_2096_Connection: $Port_2096_Connection"


Port_873_Connection=$(netstat -an | grep :873 | grep ESTABLISHED | wc -l)
echo "Port_873_Connection: $Port_873_Connection"


Port_5432_Connection=$(netstat -an | grep :5432 | grep ESTABLISHED | wc -l)
echo "Port_5432_Connection: $Port_5432_Connection"


echo ""
echo ""

########################################################################



########################################################################
full_Concurrent_Connection=""
full_Concurrent_Connection+="[WebMail Secure Port: 2096]\n$(ss -ant '( sport = :2096 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[Webmail UnSecure Port: 2095]\n$(ss -ant '( sport = :2095 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[IMAP Secure Port: 993]\n$(ss -ant '( sport = :993 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[IMAP UnSecure Port: 143]\n$(ss -ant '( sport = :143 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[POP3 Secure Port: 995]\n$(ss -ant '( sport = :995 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[POP3 UnSecure Port: 110]\n$(ss -ant '( sport = :110 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[SMTP Secure Port: 465]\n$(ss -ant '( sport = :465 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[SMTP Secure Port: 587]\n$(ss -ant '( sport = :587 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[SMTP UnSecure Port: 25]\n$(ss -ant '( sport = :25 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[Traffic: 443]\n$(ss -ant '( sport = :443 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[Traffic Port: 80]\n$(ss -ant '( sport = :80 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[Traffic Port: 3306]\n$(ss -ant '( sport = :3306 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[Traffic Port: 53]\n$(ss -ant '( sport = :53 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[WHM Secure Port: 2087]\n$(ss -ant '( sport = :2087 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"
full_Concurrent_Connection+="[WHM UnSecure: 2086]\n$(ss -ant '( sport = :2086 )' | awk 'NR>1 {print $1}' | sort | uniq -c | sort -rn)\n"


#echo -e $full_Concurrent_Connection
########################################################################



















curl -A "My User Agent" -X POST https://monitor.cdn-today.com/micro_report/api.php \
  -d "Server_IP=$Server_IP" \
  -d "Hostname=$Hostname" \
  -d "CPU_Total=$CPU_Total" \
  -d "CPU_load=$CPU_load" \
  -d "RAM_Mem_Total=$RAM_Mem_Total" \
  -d "RAM_Mem_Used=$RAM_Mem_Used" \
  -d "RAM_Mem_Free=$RAM_Mem_Free" \
  -d "RAM_Mem_shared=$RAM_Mem_shared" \
  -d "RAM_Mem_buff_cache=$RAM_Mem_buff_cache" \
  -d "RAM_Mem_available=$RAM_Mem_available" \
  -d "RAM_Swap_total=$RAM_Swap_total" \
  -d "RAM_Swap_used=$RAM_Swap_used" \
  -d "RAM_Swap_Free=$RAM_Swap_Free" \
  -d "RAM_Full_Command=$RAM_Full_Command" \
  -d "Port_80_Connection=$Port_80_Connection" \
  -d "Port_443_Connection=$Port_443_Connection" \
  -d "Port_3306_Connection=$Port_3306_Connection" \
  -d "Port_21_Connection=$Port_21_Connection" \
  -d "Port_22_Connection=$Port_22_Connection" \
  -d "Port_25_Connection=$Port_25_Connection" \
  -d "Port_26_Connection=$Port_26_Connection" \
  -d "Port_53_Connection=$Port_53_Connection" \
  -d "Port_110_Connection=$Port_110_Connection" \
  -d "Port_143_Connection=$Port_143_Connection" \
  -d "Port_465_Connection=$Port_465_Connection" \
  -d "Port_587_Connection=$Port_587_Connection" \
  -d "Port_993_Connection=$Port_993_Connection" \
  -d "Port_995_Connection=$Port_995_Connection" \
  -d "Port_2082_Connection=$Port_2082_Connection" \
  -d "Port_2083_Connection=$Port_2083_Connection" \
  -d "Port_2086_Connection=$Port_2086_Connection" \
  -d "Port_2087_Connection=$Port_2087_Connection" \
  -d "Port_2095_Connection=$Port_2095_Connection" \
  -d "Port_2096_Connection=$Port_2096_Connection" \
  -d "Port_873_Connection=$Port_873_Connection" \
  -d "Port_5432_Connection=$Port_5432_Connection" \
  -d "CSF_firewall_status=$CSF_firewall_status" \
  -d "CSF_TCP4=$CSF_TCP4" \
  -d "CSF_TCP6=$CSF_TCP6" \
  -d "Hosts_Allow=$Hosts_Allow" \
  -d "cmd_uptime=$cmd_uptime" \
  -d "full_Concurrent_Connection=$full_Concurrent_Connection" \
  -d "server_disk_usage=$server_disk_usage" \
  -d "ssh_connnection_ip=$ssh_connnection_ip" \
  -d "cmd_hostnamectl=$cmd_hostnamectl" \
  -d "network_up_down=$Network_up_down" \
  -d "date_auto=$date_auto" \
  -d "time_auto=$time_auto" \
  -d "Package_ID=$Package_ID"



echo ""
exit


