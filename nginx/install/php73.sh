sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm;sleep 3;
sudo yum -y install epel-release yum-utils;sleep 3;
sudo yum-config-manager --disable remi-php54;sleep 3;
sudo yum-config-manager --enable remi-php73;sleep 3;
sudo yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-json;sleep 3;
php -v;sleep 3;
service php-fpm restart;sleep 3;
sudo systemctl start php-fpm;sleep 3;
sudo systemctl enable php-fpm;sleep 3;
