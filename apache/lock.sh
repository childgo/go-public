clear
PS3='Please enter your choice: '
options=("Lock All public_html 1" "Un-Lock All public_html 2" "Check All public_html 3" "Un-Lock Only one public_html 4" "Option 5" "Quit")
select opt in "${options[@]}"
do
case $opt in

########################################################
"Lock All public_html 1")

clear
chattr -R +i /home/*/public_html/
chattr -R +i /home/*/www/.htaccess
chattr -R +i /home/*/www/*/.htaccess
chattr -R +i /home/*/www/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R +i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess












echo "Finish Lock"



;;
########################################################

"Un-Lock All public_html 2")

clear
echo "----Start unlock"
chattr -R -i /home/*/public_html/
chattr -R -i /home/*/www/.htaccess
chattr -R -i /home/*/www/*/.htaccess
chattr -R -i /home/*/www/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
echo "-----------Finish Unlock"


;;
########################################################

"Check All public_html 3")

echo "----Start checking----"

lsattr /home/*/public_html/
lsattr /home/*/www/.htaccess
lsattr /home/*/www/*/.htaccess
lsattr /home/*/www/*/*/.htaccess
lsattr /home/*/www/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
lsattr /home/*/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
echo "----Finish Checking"

;;
########################################################
"Un-Lock Only one public_html 4")

echo "please Type the User,followed by [ENTER]:"
read usr
USR="$usr"




chattr -R -i /home/$USR/public_html/

chattr -R -i /home/$USR/public_html/
chattr -R -i /home/$USR/www/.htaccess
chattr -R -i /home/$USR/www/*/.htaccess
chattr -R -i /home/$USR/www/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess
chattr -R -i /home/$USR/www/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/.htaccess


echo "Finish"

;;
########################################################
"Option 5")
echo "test"
;;
########################################################
"Quit")
break
;;
########################################################
        *) echo invalid option;;
    esac
done
