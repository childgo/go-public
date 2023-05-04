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

Port_80_Connection=$(netstat -plan | grep :80 | wc -l)
echo "Port_80_Connection: $Port_80_Connection"



Port_443_Connection=$(netstat -plan | grep :443 | wc -l)
echo "Port_443_Connection: $Port_443_Connection"


Port_3306_Connection=$(netstat -plan | grep :3306 | wc -l)
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
#Network is up or down
Network_up_down="1"
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
  -d "CSF_firewall_status=$CSF_firewall_status" \
  -d "CSF_TCP4=$CSF_TCP4" \
  -d "CSF_TCP6=$CSF_TCP6" \
  -d "Hosts_Allow=$Hosts_Allow" \
  -d "cmd_uptime=$cmd_uptime" \
  -d "cmd_hostnamectl=$cmd_hostnamectl" \
  -d "network_up_down=$Network_up_down" \
  -d "date_auto=$date_auto" \
  -d "time_auto=$time_auto" \
  -d "Package_ID=$Package_ID"




exit


