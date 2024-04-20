#!/bin/bash 
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

bc_pub_key="AAAAB3NzaC1yc2EAAAABIwAAAIEA/IgWww7+8TIr3e/7MZsXAOZcovZ3uK1r+Aqsz8dXbg7ORHkoGk4vBz2FV0IeydMiGuDAWcsM6uwdkNtzz0wwFsqkt7CsHuEccy4cun+SAWZ53k7OOdBF+9UvhLjO79sn1yZgGiooJDyJAtBPaXBjdUX76nYq7hWUxKhAbAlMY8c="

log=bobcares_ssh_setup_log;

create_user() {
random_number=$( shuf -i 1000-100000 -n 1 );
ssh_user=bobcares"$random_number";
useradd -m -s /bin/bash $ssh_user;
echo "$ssh_user  ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/$ssh_user;
}

setup_ssh_key() {
home_dir=$(cat /etc/passwd | grep ^$ssh_user: | cut -d ":" -f 6);
ssh_key_dir=$home_dir/.ssh
ssh_key_file=$home_dir/.ssh/authorized_keys

mkdir -pv $ssh_key_dir
chmod -v 700 $ssh_key_dir
echo "ssh-rsa $bc_pub_key" | tee $ssh_key_file;
chmod -v 400 $ssh_key_file;
chown -Rv $ssh_user:$ssh_user $home_dir/.ssh;
}

whitelist_bobcares() {

if which csf 2>/dev/null
then
csf_count=$(csf -v | grep "csf and lfd have been disabled" | wc -l);

if [ $csf_count -eq 0 ]
then
for ip in $(curl -L ims.bobcares.com/bobcares-ip.txt)
do
csf -a $ip "bobcares IP";
done
fi

elif which imunify360-agent 2>/dev/null
then

for ip in $(curl -L ims.bobcares.com/bobcares-ip.txt)
do
imunify360-agent whitelist ip add $ip;
done

elif which apf 2>/dev/null
then

for ip in $(curl -L ims.bobcares.com/bobcares-ip.txt)
do
apf -a $ip "bobcares IP";
done

elif which ufw 2>/dev/null
then

for ip in $(curl -L ims.bobcares.com/bobcares-ip.txt)
do
ufw allow from $ip/32;
done


elif which firewall-cmd 2>/dev/null
then

for ip in $(curl -L ims.bobcares.com/bobcares-ip.txt)
do
firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="$ip" accept' --permanent
done

systemctl restart firewalld.service;

elif which iptables 2>/dev/null
then

for ip in $(curl -L ims.bobcares.com/bobcares-ip.txt)
do
iptables -A INPUT -s $ip -j ACCEPT
done

fi

}


fix_tcp_wrapper() {

hosts_deny_ssh_count=$(cat /etc/hosts.deny | grep -v \#  | sed '/^$/d'  |  grep -i sshd | wc -l );
hosts_allow_ssh_count=$(cat /etc/hosts.allow | grep -v \#  | sed '/^$/d'  |  grep -i sshd | grep -i -v all | wc -l );

if [[ $hosts_deny_ssh_count -ne 0 || $hosts_allow_ssh_count -ne 0 ]]
then
for ip in $(curl -L ims.bobcares.com/bobcares-ip.txt)
do
echo "sshd : $ip" | tee -a /etc/hosts.allow;
done
fi

}


fix_sshd_config() {

count_allow_user=$(sshd -T | grep -i allowusers | wc -l);

if [ $count_allow_user -ne 0 ]
then
cp -pv /etc/ssh/sshd_config /etc/ssh/sshd_config-$(date +%Y-%m-%d_%H-%M-%S);
echo "AllowUsers $ssh_user" | tee -a /etc/ssh/sshd_config;
systemctl restart sshd;
fi

}



collect_details() {

server_ip=$(curl -s -L whatismyip.akamai.com);
ssh_port=$(sshd -T | grep -i ^port | awk '{print $2}' | tail -1 );

echo "

Please share following details with Bobcares support team

SSH details
~~~~~~~

User: $ssh_user
IP: $server_ip
Port: $ssh_port

SSH command: ssh -l $ssh_user $server_ip -p $ssh_port

";

}

create_user > $log 2>&1
setup_ssh_key  >> $log 2>&1
whitelist_bobcares >> $log 2>&1
fix_tcp_wrapper >> $log 2>&1
fix_sshd_config >> $log 2>&1
collect_details;
