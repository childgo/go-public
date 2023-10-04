#!/bin/bash
# ^ that line is important
clear

#royal_program_list='file,block,topic,article,menu,multimenu,headline,album,video,setting,theme,program,myaccount';
royal_program_list='account,file,block,topic,article,page,multimenu,headline,album,video,ads,header,footer,structure,setting,program';


#============================================================================
#Start Generate Password
#============================================================================
lowercase_first_letters=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 2 | head -n 1)
lowercase_second_letters=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 2 | head -n 1)
lowercase_third_letters=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 2 | head -n 1)

uppercase_first_letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 3 | head -n 1)
uppercase_second_letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 3 | head -n 1)
uppercase_third_letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 3 | head -n 1)

numbers_first_only=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)
numbers_second_only=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)
numbers_third_only=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)

special_first_characters=$(cat /dev/urandom | tr -dc '!@#' | fold -w 2 | head -n 1)
special_second_characters=$(cat /dev/urandom | tr -dc '!@#' | fold -w 2 | head -n 1)
special_third_characters=$(cat /dev/urandom | tr -dc '!@#' | fold -w 2 | head -n 1)


#Mysql and cPanel Password
final_mysql_password=$lowercase_first_letters$uppercase_first_letters$special_second_characters$numbers_second_only$lowercase_second_letters
final_cpanel_password=$lowercase_second_letters$special_third_characters$numbers_first_only$uppercase_third_letters$lowercase_third_letters

#echo "Lowercase_letters:" $lowercase_letters
#echo "Uppercase_letters:" $uppercase_letters
#echo "Numbers_only:" $numbers_only
#echo "Special characters:" $special_characters
echo "Final Mysql Password:" $final_mysql_password
echo "Final cPanel Password:" $final_cpanel_password



echo "=================================================================="
#Royal Arabic User and Password
final_royal_arabic_user=ar_$lowercase_first_letters$uppercase_second_letters$numbers_first_only$lowercase_third_letters
final_royal_arabic_password=ar_$lowercase_third_letters$special_first_characters$uppercase_second_letters$numbers_first_only$lowercase_first_letters

#echo "Royal Arabic user:" $final_royal_arabic_user
#echo "Royal Arabic Password:" $final_royal_arabic_password
#echo "=================================================================="



#Royal English User and Password
final_royal_english_user=en_$lowercase_third_letters$uppercase_first_letters$numbers_third_only$lowercase_second_letters
final_royal_english_password=en_$lowercase_first_letters$uppercase_first_letters$special_second_characters$numbers_third_only$lowercase_first_letters

#echo "Royal English user:" $final_royal_english_user
#echo "Royal English Password:" $final_royal_english_password
#echo "=================================================================="



#Royal French User and Password
final_royal_french_user=fr_$lowercase_third_letters$uppercase_first_letters$numbers_third_only$lowercase_second_letters
final_royal_french_password=fr_$lowercase_third_letters$uppercase_second_letters$numbers_third_only$special_third_characters$lowercase_second_letters

#echo "Royal French user:" $final_royal_french_user
#echo "Royal French Password:" $final_royal_french_password
#echo "=================================================================="




#============================================================================
#Start Create New cPanel Account
#============================================================================
echo "please Type the Domain,followed by [ENTER]:"
read dom
DOM="$dom"

echo "please Type the User,followed by [ENTER]:"
read usr
USR="$usr"


#Start Create cPanel Account
/scripts/createacct $DOM $USR $final_cpanel_password



#Set a PHP version for a vhost
whmapi1 php_set_vhost_versions version=ea-php74 vhost=$DOM


#============================================================================
#Start Copy Files
#============================================================================
ROYAL_ORIGINAL_Files="royal"
ROYAL_ORIGINAL_DataBase="royal_royal_db"



cp -R /home/$ROYAL_ORIGINAL_Files/public_html/* /home/$USR/public_html

#============================================================================
#Start Change Ownership and Group File

#============================================================================

pwd
cd /home/$USR/public_html/
pwd
chown -R $USR *
chgrp -R $USR *

#============================================================================
#Start Create MySQL
#============================================================================

echo "------------------------------------------"
echo " Start create MySQL "
echo "------------------------------------------"


DB_NAME_ROYAL=""$USR"_"royal""
DB_USER_ROYAL=""$USR"_"royal""
DB_PASS_ROYAL="$final_mysql_password"

# create a database
uapi --user=$USR Mysql create_database name=$DB_NAME_ROYAL

#create the MySQL user and password
uapi --user=$USR Mysql create_user name=$DB_USER_ROYAL password=$DB_PASS_ROYAL

# add the user to the database
uapi --user=$USR Mysql set_privileges_on_database user=$DB_USER_ROYAL database=$DB_NAME_ROYAL privileges=ALL%20PRIVILEGES




#============================================================================
#============================================================================
# Start Edit "alscoconfig.php" file
#============================================================================


echo '<?php
$host_aa = "localhost"; 
$dbname_bb  = "'$DB_NAME_ROYAL'";  
$user_cc = "'$DB_USER_ROYAL'"; 
$password_dd = "'$DB_PASS_ROYAL'";   
?>'>/home/$USR/public_html/config/db.php



#============================================================================
# Start import MySQL database.
#============================================================================

echo "------------------------------------------"
echo " start import mysql "
echo "------------------------------------------"

#Export Main DataBase
mysqldump $ROYAL_ORIGINAL_DataBase> /alscospider/today/royal_db_backup.sql


#Import DataBase
mysql -p$DB_PASS_ROYAL -u $DB_USER_ROYAL $DB_NAME_ROYAL < /alscospider/today/royal_db_backup.sql



#update usera and password in database
#mysql -u $DB_USER_ROYAL -p$DB_PASS_ROYAL $DB_NAME_ROYAL -e "UPDATE account SET username = '$final_royal_arabic_user', password = '$final_royal_arabic_password' where language = 'ar' ";


#update footer
mysql -u $DB_USER_ROYAL -p$DB_PASS_ROYAL $DB_NAME_ROYAL -e "UPDATE setting SET footer_gateway = 'off' ";


#update log
mysql -u $DB_USER_ROYAL -p$DB_PASS_ROYAL $DB_NAME_ROYAL -e "UPDATE setting SET statistics_status = 'off' ";


#Insert Arabic Info
mysql -u $DB_USER_ROYAL -p$DB_PASS_ROYAL $DB_NAME_ROYAL -e "INSERT INTO account (name, level, phone, username, password, program, power, language) VALUES ('name_ar', 'client', '96411111111','$final_royal_arabic_user', '$final_royal_arabic_password','$royal_program_list','full','ar')";

#Insert English Info
mysql -u $DB_USER_ROYAL -p$DB_PASS_ROYAL $DB_NAME_ROYAL -e "INSERT INTO account (name, level, phone, username, password, program, power, language) VALUES ('name_en', 'client', '96411111111','$final_royal_english_user', '$final_royal_english_password','$royal_program_list','full','en')";

#Insert French Info
mysql -u $DB_USER_ROYAL -p$DB_PASS_ROYAL $DB_NAME_ROYAL -e "INSERT INTO account (name, level, phone, username, password, program ,power, language) VALUES ('name_fr', 'client',  '96411111111','$final_royal_french_user', '$final_royal_french_password','$royal_program_list','full','fr')";

#update Cloud Storage
mysql -u "$DB_USER_ROYAL" -p"$DB_PASS_ROYAL" "$DB_NAME_ROYAL" -e "UPDATE cloud_setting SET url = 'https://api1.nodesbox.com/index.php?linkurl=external&token=efgf34835454543pdif&domain=$dom'";



#Delete DataBase
rm /alscospider/today/royal_db_backup.sql




echo ""
echo ""
echo ""
echo ""
echo ""



echo "=================================================================="
echo "Printing Result..."
echo "=================================================================="
echo "Domain:" $DOM
echo "cPanel_User: "$USR 
echo "cPanel_Pass: "$final_cpanel_password
echo "=================================================================="
echo "=================================================================="
echo "Arabic User:" $final_royal_arabic_user
echo "Arabic Password:" $final_royal_arabic_password
echo "=================================================================="
echo "English User:" $final_royal_english_user
echo "English Password:" $final_royal_english_password
echo "=================================================================="
echo "French User:" $final_royal_french_user
echo "French Password:" $final_royal_french_password
echo "=================================================================="





#============================================================================
# Start Sending E-mail
#============================================================================
receiver="a@gmail.com"
body=" 
Dear ALSC.
New Royal Domain Created in the Server

------------------------------------------
New WebSite has been created successfully
Domain Name: $DOM
Domain User: $USR
cPanel Pass: $final_cpanel_password
------------------------------------------


------------------------------------------
Database has been created successfully
Database Name: $DB_NAME_ROYAL
Database User: $DB_USER_ROYAL
Database Pass: $DB_PASS_ROYAL

------------------------------------------

Royal Arabic User: $final_royal_arabic_user
Royal Arabic Password: $final_royal_arabic_password

Royal English User: $final_royal_english_user
Royal English Password: $final_royal_english_password

Royal French User: $final_royal_french_user
Royal French Password: $final_royal_french_password



Regards
ALSCO Software
------------------------------------------"
#command to send the email
#echo "$body" | mail -s "Royal Domain Created [$DOM]" $receiver


#============================================================================
# Update CageFS for cloudLinux
#============================================================================

#cagefsctl --force-update

echo "------------------------------------------"
echo " Finish..."
echo "------------------------------------------"





#============================================================================
# The End
#============================================================================
