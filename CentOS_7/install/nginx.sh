#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/install/index_server_default_page.html)

clear

yum update;sleep 3;
yum -y update;sleep 3;
yum install wget nano inotify-tools rsync sshpass;sleep 3;
yum install epel-release;sleep 3;
yum install nginx;sleep 3;
systemctl start nginx;sleep 3;
systemctl enable nginx;sleep 3;
systemctl status nginx;sleep 3;
firewall-cmd --zone=public --permanent --add-service=http;sleep 3;
firewall-cmd --zone=public --permanent --add-service=https;sleep 3;
firewall-cmd --reload;sleep 3;
systemctl reload nginx;sleep 3;
systemctl restart nginx;sleep 3;
reboot;sleep 3;
