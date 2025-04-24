
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/whm/install_csf_all.sh)
clear

#Install ALL
#[ConfigServer Security and Firewall]
#Installtion [ConfigServer Explorer]
#Installtion [ConfigServer Mail Manage]
#Installtion [ConfigServer Mail Manage]






#======================================================================
#Installation CSF [ConfigServer Security and Firewall]
#======================================================================
echo "Installtion [ConfigServer Security and Firewall]"







systemctl disable firewalld;sleep 3;
systemctl stop firewalld;sleep 3;
dnf clean all;sleep 3;
dnf -y update;sleep 3;
dnf -y install wget nano inotify-tools rsync sshpass iftop htop createrepo traceroute;sleep 3;
dnf -y install perl tar ipset tcpdump unzip net-tools perl-libwww-perl;sleep 3;
dnf -y install perl-LWP-Protocol-https perl-GDGraph bind-utils;sleep 3;
dnf -y install epel-release createrepo;sleep 3;
dnf -y install bind-utils -y;sleep 3;
dnf -y install nc -y;sleep 3;
dnf -y install nmap-ncat -y;sleep 3;


cd /opt;sleep 3;
wget https://download.configserver.com/csf.tgz;sleep 3;
tar -xzf csf.tgz;sleep 3;
cd csf;sleep 3;
sh install.sh;sleep 3;
rm -rf /opt/csf;sleep 3;
rm -rf /opt/csf.tgz;sleep 3;
cd ~;sleep 3;

systemctl enable csf;sleep 3;
systemctl enable lfd;sleep 3;
#service csf start;sleep 3;
#service lfd start;sleep 3;
#perl /usr/local/csf/bin/csftest.pl;sleep 3;



#======================================================================
#CSF Setting
#======================================================================
echo "Start changing CSF from '1' to '0' to activate it...."
sed -i 's/TESTING = "1"/TESTING = "0"/' /etc/csf/csf.conf
echo "Verify that the change was successful. ...."
grep -r "TESTING =" /etc/csf/csf.conf



#Start changing  protocal
echo "Start changing  protocal...."

sed -i 's/TCP_IN =.*/TCP_IN =""/' /etc/csf/csf.conf
sed -i 's/TCP_OUT =.*/TCP_OUT ="80,443,53"/' /etc/csf/csf.conf
sed -i 's/UDP_IN =.*/UDP_IN ="53"/' /etc/csf/csf.conf
sed -i 's/UDP_OUT =.*/UDP_OUT ="53"/' /etc/csf/csf.conf



sed -i 's/TCP6_IN =.*/TCP6_IN =""/' /etc/csf/csf.conf
sed -i 's/TCP6_OUT =.*/TCP6_OUT =""/' /etc/csf/csf.conf
sed -i 's/UDP6_IN =.*/UDP6_IN =""/' /etc/csf/csf.conf
sed -i 's/UDP6_OUT .*/UDP6_OUT =""/' /etc/csf/csf.conf



#Enable IPSET [Change LF_IPSET from 0 to 1]
echo "Change LF_IPSET from 0 to 1, becuase 1 mean enable"
sed -i 's/^LF_IPSET =.*/LF_IPSET = "1"/' /etc/csf/csf.conf
grep -r "LF_IPSET =" /etc/csf/csf.conf
echo ""
echo ""

echo "Verify that the change was successful. ...."
grep -r "TCP_IN =" /etc/csf/csf.conf
grep -r "TCP_OUT =" /etc/csf/csf.conf
grep -r "UDP_IN =" /etc/csf/csf.conf
grep -r "UDP_OUT =" /etc/csf/csf.conf
echo ""

grep -r "TCP6_IN =" /etc/csf/csf.conf
grep -r "TCP6_OUT =" /etc/csf/csf.conf
grep -r "UDP6_IN =" /etc/csf/csf.conf
grep -r "UDP6_OUT =" /etc/csf/csf.conf

echo "Change LF_IPSET from 0 to 1, becuase 1 mean enable"
grep -r "LF_IPSET =" /etc/csf/csf.conf


echo ""
#======================================================================


systemctl enable csf
systemctl enable lfd
service csf start
service lfd start
perl /usr/local/csf/bin/csftest.pl



#======================================================================
#Uninstall CSF Firewall
#cd /etc/csf
#sh uninstall.sh










#======================================================================
#Installtion [ConfigServer Explorer]
#======================================================================
echo "Installtion [ConfigServer Explorer]"
cd /usr/src ;sleep 3;
rm -fv /usr/src/cse.tgz;sleep 3;
wget https://download.configserver.com/cse.tgz;sleep 3;
tar -xzf cse.tgz;sleep 3;
cd cse;sleep 3;
sh install.sh;sleep 3;
rm -Rfv /usr/src/cse*;sleep 3;
#======================================================================
#End [ConfigServer Explorer]
#======================================================================





#======================================================================
#Installtion [ConfigServer Mail Manage]
#======================================================================
echo "Installtion [ConfigServer Mail Manage]"
cd /usr/src;sleep 3;
rm -fv /usr/src/cmm.tgz;sleep 3;
wget http://download.configserver.com/cmm.tgz;sleep 3;
tar -xzf cmm.tgz;sleep 3;
cd cmm;sleep 3;
sh install.sh;sleep 3;
rm -Rfv /usr/src/cmm*;sleep 3;
#======================================================================
#End [ConfigServer Mail Manage]
#======================================================================


#======================================================================
#Installtion [ConfigServer Mail Manage]
#======================================================================
echo "Installtion [ConfigServer Mail Manage]"
cd /usr/src;sleep 3;
rm -fv /usr/src/cmq.tgz;sleep 3;
wget http://download.configserver.com/cmq.tgz;sleep 3;
tar -xzf cmq.tgz;sleep 3;
cd cmq;sleep 3;
sh install.sh;sleep 3;
rm -Rfv /usr/src/cmq*;sleep 3;
#======================================================================
#End [ConfigServer Mail Manage]
#======================================================================



echo "============================
echo "Finish ALL"
echo "============================



