

dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm;sleep 3;
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm;sleep 3;
dnf module list php;sleep 3;

dnf module install php:remi-8.2;sleep 3;
dnf -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-json;sleep 3;


sudo systemctl start php-fpm;sleep 3;
sudo systemctl enable php-fpm;sleep 3;
service php-fpm restart;sleep 3;

#yum remove httpd

php -v;sleep 3;





