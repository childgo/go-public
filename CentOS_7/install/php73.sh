#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/install/php73.sh)

clear

#sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm;sleep 3;
sudo yum -y install epel-release yum-utils;sleep 3;
sudo yum-config-manager --disable remi-php54;sleep 3;
sudo yum-config-manager --enable remi-php73;sleep 3;
sudo yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-json;sleep 3;
php -v;sleep 3;
service php-fpm restart;sleep 3;
sudo systemctl start php-fpm;sleep 3;
sudo systemctl enable php-fpm;sleep 3;
yum remove httpd


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
