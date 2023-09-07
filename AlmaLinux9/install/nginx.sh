#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/install/nginx.sh)


clear
yum update;sleep 3;
yum -y update;sleep 3;


#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------

yum install wget nano inotify-tools rsync sshpass;sleep 3;
yum install epel-release;sleep 3;
yum install nginx;sleep 3;
systemctl start nginx;sleep 3;
systemctl enable nginx;sleep 3;
#systemctl status nginx;sleep 3;
firewall-cmd --zone=public --permanent --add-service=http;sleep 3;
firewall-cmd --zone=public --permanent --add-service=https;sleep 3;
firewall-cmd --reload;sleep 3;
systemctl reload nginx;sleep 3;
systemctl restart nginx;sleep 3;




#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------



reboot;sleep 3;

