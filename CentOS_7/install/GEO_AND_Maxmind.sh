#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/install/GEO_AND_Maxmind.sh)
clear
#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------


#Install GEO AND Maxmind


yum install nginx-module-geoip;sleep 2;
yum install nginx-module-geoip2;sleep 2;
yum install jq libmaxminddb-devel;sleep 2;




#Download DataBase
cd /usr/share/GeoIP/
pwd

wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-City.mmdb -O GeoLite2-City.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-ASN.mmdb -O GeoLite2-ASN.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-Country.mmdb -O GeoLite2-Country.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoIP2-ISP.mmdb -O GeoIP2-ISP.mmdb


sleep 2;

#Get Size for each file
Size_GeoLite2_City=$(wc -c "/usr/share/GeoIP/GeoLite2-City.mmdb" | awk '{print $1}')
Size_GeoLite2_ASN=$(wc -c "/usr/share/GeoIP/GeoLite2-ASN.mmdb" | awk '{print $1}')
Size_GeoLite_Country=$(wc -c "/usr/share/GeoIP/GeoLite2-Country.mmdb" | awk '{print $1}')
Size_GeoIP_ISP=$(wc -c "/usr/share/GeoIP/GeoIP2-ISP.mmdb" | awk '{print $1}')


nginx -t
systemctl restart nginx


sleep 2;
echo "==================================="
echo ""
echo "Check mmdblookup Command...."
echo ""
echo ""



#Checking
mmdblookup --file /usr/share/GeoIP/GeoLite2-City.mmdb --ip 66.111.53.5 country names en |awk -F'"' '{print $2}' | tr '\n' ' '
mmdblookup --file /usr/share/GeoIP/GeoLite2-ASN.mmdb --ip 66.111.53.5 | sed -e ':a;N;$!ba;s/\n/ /g' |sed -e 's/ <[a-z0-9_]\+>/,/g' |sed -e 's/,\s\+}/}/g' | jq '(.autonomous_system_number)'
mmdblookup --file /usr/share/GeoIP/GeoLite2-ASN.mmdb --ip 66.111.53.5 | sed -e ':a;N;$!ba;s/\n/ /g' |sed -e 's/ <[a-z0-9_]\+>/,/g' |sed -e 's/,\s\+}/}/g' | jq '(.autonomous_system_organization)' | sed -e 's/^"//' -e 's/"$//'
mmdblookup --file /usr/share/GeoIP/GeoLite2-Country.mmdb --ip 66.111.53.5 country iso_code |awk -F'"' '{print $2}' | tr '\n' ' '

#------------------------------------------------------------------------------------------------------------------
#Clean Repo

repo_dir="/etc/yum.repos.d/"

# Delete all .repo files except for the specified ones
find "$repo_dir" -type f -name '*.repo' ! -name 'alsco_CentOS7.repo' ! -name 'ALSCO_Nginx.repo' -exec rm -f {} \;
yum clean all
#------------------------------------------------------------------------------------------------------------------
