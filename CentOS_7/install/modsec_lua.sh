#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/install/modsec_lua.sh)

clear
#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------



yum install nginx-module-security

yum -y install nginx-owasp-crs


mkdir /alscogatewaytmp
chmod 1777 /alscogatewaytmp


chcon -t httpd_sys_rw_content_t /alscogatewaytmp -R
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/antivirus/final/spider6.py
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/browsers-id13.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/ip-white-id9.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/request_body_id14.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/spamlist-id12.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/sql-Injection-11.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/url-english-id10.txt
chcon -t httpd_sys_script_exec_t  /alscospider/gateway_rules/sql-Injection_Public-25.txt



#############################################################################################

#install lua
sudo yum install nginx-module-lua
