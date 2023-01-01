#!/bin/bash
clear
echo "#########################################33"


#####################################################
#####################################################
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
bold=$(tput bold)

#####################################################
#####################################################




Mypath_php_script="/var/www/html/verify/ASN-Maxmind/DataBase/"

cd $Mypath_php_script
echo "${RED}${bold}Current Path " $(pwd)${NC}
echo "#########################################33"
echo "#########################################33"

echo ""

#Unlock Path
chattr -R -i /var/www/html/


Myfile1_phpPath="/var/www/html/verify/ASN-Maxmind/DataBase/GeoLite2-City.mmdb"
Myfile2_phpPath="/var/www/html/verify/ASN-Maxmind/DataBase/GeoLite2-ASN.mmdb"
Myfile3_phpPath="/var/www/html/verify/ASN-Maxmind/DataBase/GeoLite2-Country.mmdb"
Myfile4_phpPath="/var/www/html/verify/ASN-Maxmind/DataBase/GeoIP2-ISP.mmdb"



wget https://alscoip.com/ASN-max/DataBase/GeoLite2-City.mmdb -O new-GeoLite2-City.mmdb
wget https://alscoip.com/ASN-max/DataBase/GeoLite2-ASN.mmdb -O new-GeoLite2-ASN.mmdb
wget https://alscoip.com/ASN-max/DataBase/GeoLite2-Country.mmdb -O new-GeoLite2-Country.mmdb
wget https://alscoip.com/ASN-max/DataBase/GeoIP2-ISP.mmdb -O new-GeoIP2-ISP.mmdb





#Get Size for each file
Size_GeoLite2_City=$(wc -c "/var/www/html/verify/ASN-Maxmind/DataBase/new-GeoLite2-City.mmdb" | awk '{print $1}')
Size_GeoLite2_ASN=$(wc -c "/var/www/html/verify/ASN-Maxmind/DataBase/new-GeoLite2-ASN.mmdb" | awk '{print $1}')
Size_GeoLite_Country=$(wc -c "/var/www/html/verify/ASN-Maxmind/DataBase/new-GeoLite2-Country.mmdb" | awk '{print $1}')
Size_GeoIP_ISP=$(wc -c "/var/www/html/verify/ASN-Maxmind/DataBase/new-GeoIP2-ISP.mmdb" | awk '{print $1}')




#Check if GeoLite2_City size less then 90kb
if(($Size_GeoLite2_City>90000)); then
    echo "GeoLite2-City not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoLite2-City.mmdb] is less 90KB${NC}"
    exit
fi





#Check if GeoLite2_ASN size less then 90kb
if(($Size_GeoLite2_ASN>90000)); then
    echo "GeoLite2-ASN not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoLite2-ASN.mmdb] is less 90KB${NC}"
    exit
fi




#Check if GeoLite_Country size less then 90kb
if(($Size_GeoLite_Country>90000)); then
    echo "GeoLite2-Country not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoLite2-Country.mmdb] is less 90KB${NC}"
    exit
fi




#Check if GeoIP_ISP size less then 90kb
if(($Size_GeoIP2-ISP>90000)); then
    echo "GeoIP2-ISP not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoIP2-ISP.mmdb] is less 90KB${NC}"
    exit
fi




echo ""
echo ""
#Start Delete Files
rm $Myfile1_phpPath
rm $Myfile2_phpPath
rm $Myfile3_phpPath
rm $Myfile4_phpPath


################################################
################################################
echo "#########################################"

mv new-GeoLite2-City.mmdb GeoLite2-City.mmdb
mv new-GeoLite2-ASN.mmdb GeoLite2-ASN.mmdb
mv new-GeoLite2-Country.mmdb GeoLite2-Country.mmdb
mv new-GeoIP2-ISP.mmdb GeoIP2-ISP.mmdb



echo "${RED}${bold}$Myfile1_phpPath" $(date -r $Myfile1_phpPath)${NC}
echo "${RED}${bold}$Myfile2_phpPath" $(date -r $Myfile2_phpPath)${NC}
echo "${RED}${bold}$Myfile3_phpPath" $(date -r $Myfile3_phpPath)${NC}
echo "${RED}${bold}$Myfile4_phpPath" $(date -r $Myfile4_phpPath)${NC}


echo "#########################################"
echo "#########################################"




#lock Path
chattr -R +i /var/www/html/

echo "lsattr /var/www/html/"
lsattr /var/www/html/

echo "Done"
############################################################################################################
############################################################################################################










#Part 2 repalce files in /usr/share/GeoIP/
echo "${GREEN}${bold}#########################################${NC}"
echo "${GREEN}${bold}Part2${NC}"
echo "${GREEN}${bold}#########################################${NC}"




Mypath_Nginx_script="/usr/share/GeoIP/"
cd $Mypath_Nginx_script
echo "${RED}${bold}Current Path " $(pwd)${NC}
echo "#########################################"




Myfile1_Nginx="/usr/share/GeoIP/GeoLite2-ASN.mmdb"
Myfile2_Nginx="/usr/share/GeoIP/GeoLite2-Country.mmdb"



wget https://alscoip.com/ASN-max/DataBase/GeoLite2-Country.mmdb -O new-GeoLite2-Country.mmdb
wget https://alscoip.com/ASN-max/DataBase/GeoLite2-ASN.mmdb -O new-GeoLite2-ASN.mmdb




rm $Myfile1_Nginx
rm $Myfile2_Nginx


mv new-GeoLite2-Country.mmdb GeoLite2-Country.mmdb
mv new-GeoLite2-ASN.mmdb GeoLite2-ASN.mmdb




echo "${RED}${bold}$Myfile1_Nginx" $(date -r $Myfile1_Nginx)${NC}
echo "${RED}${bold}$Myfile2_Nginx" $(date -r $Myfile2_Nginx)${NC}






echo "#########################################"
echo "#########################################"
echo "#########################################"
echo "#########################################"



nginx -t
systemctl restart nginx
