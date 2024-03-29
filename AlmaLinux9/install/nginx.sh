#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/install/nginx.sh)
clear
sudo dnf clean all; sleep 1;
sudo dnf clean metadata; sleep 1;
sudo dnf makecache; sleep 1;



#------------------------------------------------------------------------------------------------------------------
#Clean Repo
repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
#find "$repo_dir" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_Nginx.repo' ! -name 'ALSCO_AlmaLinux9.repo' -exec rm -f {} \;
#------------------------------------------------------------------------------------------------------------------

dnf install -y --nogpgcheck wget nano inotify-tools rsync sshpass;sleep 3;
dnf install -y --nogpgcheck epel-release;sleep 3;
dnf install -y --nogpgcheck nginx;sleep 3;


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
#find "$repo_dir" -type f -name '*.repo' ! -name 'ALSCO_SecureGateway_Nginx.repo' ! -name 'ALSCO_AlmaLinux9.repo' -exec rm -f {} \;
dnf clean all

#------------------------------------------------------------------------------------------------------------------



#reboot;sleep 3;

