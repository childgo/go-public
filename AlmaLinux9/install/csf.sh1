#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/install/csf.sh)

systemctl disable firewalld; sleep 3;
systemctl stop firewalld; sleep 3;
dnf clean all; sleep 3;
dnf -y update; sleep 3;

dnf install tar
dnf update; sleep 3;
dnf -y update; sleep 3;
dnf install wget nano inotify-tools rsync sshpass; sleep 3;
dnf install epel-release; sleep 3;
#dnf install nginx; sleep 3;

dnf install wget nano inotify-tools rsync sshpass; sleep 3;
dnf -y install perl tar ipset unzip net-tools perl-libwww-perl; sleep 3;
dnf -y install perl-LWP-Protocol-https perl-GDGraph bind-utils; sleep 3;


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



#Enable IPSET
sed -i 's/^LF_IPSET =.*/LF_IPSET = "1"/' /etc/csf/csf.conf

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
grep -r "UDP6_OUTT =" /etc/csf/csf.conf

echo ""
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


