

#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/roundcube_skin_unlock.sh)


clear
echo "======================="
echo "======================="
printf '\n\n\n'





echo "======================="
echo "Seal in footer"
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/seal.png
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/logo.svg
echo "======================="




echo "======================="
echo "Footer Page"
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html
echo "======================="
printf '\n\n\n'







echo "======================="
echo "About Page"
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/about.html
echo "======================="
printf '\n\n\n'





"======================="
echo "config.inc.php"
chattr -i  /usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php
"======================="
printf '\n\n\n'




"======================="
chattr -i /usr/local/cpanel/base/frontend/jupiter/images/roundcube.png
"======================="
printf '\n\n\n'


"======================="
chattr +i /usr/local/cpanel/base/unprotected/cpanel/templates/login.tmpl
chattr +i /usr/local/cpanel/base/unprotected/cpanel/images/gateway.png
"======================="
printf '\n\n\n'




"======================="
chattr -i /usr/local/cpanel/base/frontend/paper_lantern/images/roundcube.png
"======================="
printf '\n\n\n'








