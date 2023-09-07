#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/install/GEO_AND_Maxmind.sh)


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



#======================================================================
#php changing setting
#======================================================================
echo "Start php Value...."
sed -i 's/session.cookie_httponly =/session.cookie_httponly = true/' /etc/php.ini
sed -i 's/session.cookie_samesite =/session.cookie_samesite = true/' /etc/php.ini


service php-fpm restart;sleep 3;

echo ""
echo "Verify that the change was successful. ...."
grep -r "session.cookie_httponly" /etc/php.ini
grep -r "session.cookie_samesite" /etc/php.ini


