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






#SIZE_GeoLite2-City="$(du -sb $Myfile1_phpPath | awk '{ print $1 }')"
#SIZE_GeoLite2-ASN="$(du -sb $Myfile2_phpPath | awk '{ print $1 }')"
#SIZE_GeoLite2-Country="$(du -sb $Myfile3_phpPath | awk '{ print $1 }')"
#SIZE_GeoIP2-ISP="$(du -sb $Myfile4_phpPath | awk '{ print $1 }')"


echo "step0"

SIZE_GeoLite2-City=$(cat $SIZE_GeoLite2-City | wc -c)
SIZE_GeoLite2-ASN=$(cat $SIZE_GeoLite2-ASN | wc -c)
SIZE_GeoLite2-Country=$(cat $SIZE_GeoLite2-Country | wc -c)
SIZE_GeoIP2-ISP=$(cat $SIZE_GeoIP2-ISP | wc -c)



echo "step1"

#Check if GeoLite2-City size less then 90kb
if (($SIZE_GeoLite2-City<90000)) ; then
    echo "Error file [GeoLite2-City] is less then 90KB";
    #exit 0
else
    echo "GeoLite2-City not less 90KB";

fi





#Check if SIZE_GeoLite2-ASN size less then 90kb
if (($SIZE_GeoLite2-ASN<90000)) ; then
    echo "Error file [GeoLite2-ASN] is less then 90KB";
    code 0
else
    echo "GeoLite2-ASN not less 90KB";

fi




#Check if GeoLite2-Country size less then 90kb
if (($SIZE_GeoLite2-Country<90000)) ; then
    echo "Error file [GeoLite2-Country] is less then 90KB";
    code 0
else
    echo "GeoLite2-Country not less 90KB";

fi




#Check if GeoIP2-ISP size less then 90kb
if (($SIZE_GeoIP2-ISP<90000)) ; then
    echo "Error file [GeoIP2-ISP] is less then 90KB";
    code 0
else
    echo "GeoIP2-ISP not less 90KB";

fi




echo ""
echo ""

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
