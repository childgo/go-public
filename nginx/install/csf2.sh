systemctl disable firewalld;sleep 3;
systemctl stop firewalld;sleep 3;
yum clean all;sleep 3;
yum -y update;sleep 3;
yum -y install wget perl ipset unzip net-tools perl-libwww-perl;sleep 3;
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
