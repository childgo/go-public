#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/install/mysql.sh)
clear

#Part1
yum -y install mariadb-server mariadb;sleep 3;
systemctl start mariadb;sleep 3;
systemctl enable mariadb;sleep 3;



#Allow remote MySQL from php(to check remote database)
sestatus;sleep 3;
getsebool -a | grep httpd;sleep 3;
setsebool httpd_can_network_connect_db 1;sleep 3;
setsebool -P httpd_can_network_connect_db 1;sleep 3;
setsebool -P httpd_can_network_connect 1;sleep 3;
getsebool -a | grep httpd_can_network_connect;sleep 3;




#checking
#systemctl status mariadb;sleep 3;
#mysql;sleep 3;
