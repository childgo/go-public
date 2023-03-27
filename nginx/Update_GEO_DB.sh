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

cd /usr/share/GeoIP/
pwd


wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-City.mmdb -O new-GeoLite2-City.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-ASN.mmdb -O new-GeoLite2-ASN.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoLite2-Country.mmdb -O new-GeoLite2-Country.mmdb
wget https://alscoip.com/GEO_Maxmind_Database/GeoIP2-ISP.mmdb -O new-GeoIP2-ISP.mmdb





#Get Size for each file
Size_GeoLite2_City=$(wc -c "/usr/share/GeoIP/new-GeoLite2-City.mmdb" | awk '{print $1}')
Size_GeoLite2_ASN=$(wc -c "/usr/share/GeoIP/new-GeoLite2-ASN.mmdb" | awk '{print $1}')
Size_GeoLite_Country=$(wc -c "/usr/share/GeoIP/new-GeoLite2-Country.mmdb" | awk '{print $1}')
Size_GeoIP_ISP=$(wc -c "/usr/share/GeoIP/new-GeoIP2-ISP.mmdb" | awk '{print $1}')





Myfile1_Path="/usr/share/GeoIP/GeoLite2-City.mmdb"
Myfile2_Path="/usr/share/GeoIP/GeoLite2-ASN.mmdb"
Myfile3_Path="/usr/share/GeoIP/GeoLite2-Country.mmdb"
Myfile4_Path="/usr/share/GeoIP/GeoIP2-ISP.mmdb"




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
if(($Size_GeoIP_ISP>90000)); then
    echo "GeoIP2-ISP not less 90KB";
else
    echo "${RED}${bold}Error file [new-GeoIP2-ISP.mmdb] is less 90KB${NC}"
    exit
fi




echo ""
echo ""
#Start Delete Files
rm $Myfile1_Path
rm $Myfile2_Path
rm $Myfile3_Path
rm $Myfile4_Path


################################################
################################################
echo "#########################################"

mv new-GeoLite2-City.mmdb GeoLite2-City.mmdb
mv new-GeoLite2-ASN.mmdb GeoLite2-ASN.mmdb
mv new-GeoLite2-Country.mmdb GeoLite2-Country.mmdb
mv new-GeoIP2-ISP.mmdb GeoIP2-ISP.mmdb



echo "${RED}${bold}$Myfile1_Path" $(date -r $Myfile1_Path)${NC}
echo "${RED}${bold}$Myfile2_Path" $(date -r $Myfile2_Path)${NC}
echo "${RED}${bold}$Myfile3_Path" $(date -r $Myfile3_Path)${NC}
echo "${RED}${bold}$Myfile4_Path" $(date -r $Myfile4_Path)${NC}


echo "#########################################"
echo "#########################################"





echo "Done"
############################################################################################################
############################################################################################################





nginx -t
systemctl restart nginx
