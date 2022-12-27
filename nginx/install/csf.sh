systemctl disable firewalld;sleep 3;
systemctl stop firewalld;sleep 3;
yum clean all;sleep 3;
yum -y update;sleep 3;
yum -y install wget perl ipset unzip net-tools perl-libwww-perl;sleep 3;
yum -y install perl-LWP-Protocol-https perl-GDGraph bind-utils;sleep 3;
