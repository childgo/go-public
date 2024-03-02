#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/install/php8_3.sh)


#dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm;sleep 3;
#dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm;sleep 3;
dnf -y --nogpgcheck module list php;sleep 3;

dnf -y --nogpgcheck module install php:remi-8.3;sleep 3;
dnf -y -y --nogpgcheck install php php-cli php-fpm php-mysqlnd php-zip php-mbstring php-curl php-pear php-bcmath php-json;sleep 3;


sudo systemctl start php-fpm;sleep 3;
sudo systemctl enable php-fpm;sleep 3;
service php-fpm restart;sleep 3;

#yum remove httpd
php -v;sleep 3;


#Remove php
#dnf list installed php*
#sudo dnf remove php*



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




#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------
