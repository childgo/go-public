systemctl disable firewalld;sleep 3;
systemctl stop firewalld;sleep 3;
yum clean all;sleep 3;
yum -y update;sleep 3;
yum -y install wget nano inotify-tools perl ipset unzip net-tools perl-libwww-perl;sleep 3;
yum -y install perl-LWP-Protocol-https perl-GDGraph bind-utils;sleep 3;
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
service csf start;sleep 3;
service lfd start;sleep 3;
perl /usr/local/csf/bin/csftest.pl;sleep 3;



#======================================================================
#CSF Setting
#======================================================================
echo "Start changing CSF from '1' to '0' to activate it...."
sed -i 's/TESTING = "1"/TESTING = "0"/' /etc/csf/csf.conf
echo "Verify that the change was successful. ...."
grep -r "TESTING =" /etc/csf/csf.conf



#Start changing  protocal
echo "Start changing  protocal...."

sed -i 's/TCP_IN = "20,21,22,25,53,80,110,143,443,465,587,993,995"/TCP_IN = ""/' /etc/csf/csf.conf
sed -i 's/TCP_OUT = "20,21,22,25,53,80,110,113,443,587,993,995"/TCP_OUT = "80,443"/' /etc/csf/csf.conf

sed -i 's/UDP_IN = "20,21,53,80,443"/UDP_IN = ""/' /etc/csf/csf.conf
sed -i 's/UDP_OUT = "20,21,53,113,123"/UDP_OUT = ""/' /etc/csf/csf.conf

sed -i 's/TCP6_IN = "20,21,22,25,53,80,110,143,443,465,587,993,995"/TCP6_IN = ""/' /etc/csf/csf.conf
sed -i 's/TCP6_OUT = "20,21,22,25,53,80,110,113,443,587,993,995"/TCP6_OUT = ""/' /etc/csf/csf.conf

sed -i 's/UDP6_IN = "20,21,53,80,443"/UDP6_IN = ""/' /etc/csf/csf.conf
sed -i 's/UDP6_OUT = "20,21,53,113,123"/UDP6_OUT = ""/' /etc/csf/csf.conf


echo "Verify that the change was successful. ...."
grep -r "TCP_IN =" /etc/csf/csf.conf
grep -r "TCP_OUT =" /etc/csf/csf.conf
grep -r "UDP_IN =" /etc/csf/csf.conf
grep -r "UDP_OUT =" /etc/csf/csf.conf


grep -r "TCP6_IN =" /etc/csf/csf.conf
grep -r "TCP6_OUT =" /etc/csf/csf.conf
grep -r "UDP6_IN =" /etc/csf/csf.conf
grep -r "UDP6_OUTT =" /etc/csf/csf.conf
#======================================================================


systemctl enable csf
systemctl enable lfd
service csf start
service lfd start
perl /usr/local/csf/bin/csftest.pl





