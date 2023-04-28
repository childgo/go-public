#!/bin/bash
clear
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/roundcube/roundcube_skin.sh)








#######################################################
#Start Unlocking Files...
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/seal.png
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/logo.svg
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html
chattr +i /usr/local/cpanel/base/frontend/jupiter/images/roundcube.png
#End Unlocking Files
#######################################################



#######################################################
#Ask me if i want to contine 
echo "Do you want to continue install a new skin now? [y/n]"
read choice

if [ "$choice" == "n" ]; then
  echo "Exiting..."
  exit 0
else
  echo "Continuing..."
fi
#######################################################





=========================================================================
#=======================Start edit config.inc.php=======================#
# define the file path
filepath="/usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php"


#Remove config['skins_allowed']
sed -i "/\$config\['skins_allowed'\]/d" $filepath

#Add New config['skins_allowed']
sed -i "/\$config = \[\];/a \$config\['skins_allowed'\] = \['elastic'\];" $filepath




#Remove $config['skin']
sed -i "/\$config\['skin'\]/d" $filepath

#Add new $config['skin']
sed -i "/\$config = \[\];/a \$config\['skin'\] = 'elastic';" $filepath




#Remove the $config['plugins']
sed -i "/\$config\['plugins'\]/d" $filepath

#Add new $config['plugins']
sed -i "/\$config = \[\];/a \$config\['plugins'\] = array('cpanellogin','cpanellogout','archive','calendar', 'return_to_webmail','markasjunk','alsco_auth');" $filepath




# print the edited lines
echo "New lines:"
echo "==========="
grep -E "\$config\['skins_allowed'\]|\$config\['skin'\]|\$config\['plugins'\]" $filepath
#=======================Start edit config.inc.php=======================#
=========================================================================












#=============================================================================================================
#Download Images
#=============================================================================================================
# Define the URLs and filenames
url1="https://github.com/childgo/go-public/raw/master/whm/roundcube/seal.png"
url2="https://github.com/childgo/go-public/raw/master/whm/roundcube/logo.svg"
filename1="seal.png"
filename2="logo.svg"

# Define the folder path
folderpath="/usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images"

# Download the images and overwrite if they exist
wget -q -O "${folderpath}/${filename1}" "${url1}" && echo "Downloaded ${filename1}"
wget -q -O "${folderpath}/${filename2}" "${url2}" && echo "Downloaded ${filename2}"
#=============================================================================================================







#=============================================================================================================
#add seal to footer

# Define the file path
file_path="/usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html"

# Define the code to add
code_to_add="<br><br><p><div style=\"position: fixed; z-index: 1000; width: 150px; height: 65px; bottom: 5px; right: 2px;\"><img class=\"img-responsive\" alt=\"Secure Gateway\" src=\"/images/seal.png\" width=\"150\" height=\"66\" /></div></p>"

# Use sed to insert the code above </body>
sed -i "s|</body>|${code_to_add}</body>|" "${file_path}"
#=============================================================================================================





#=============================================================================================================
#Start changing the logo before open roundcube
file_path="/usr/local/cpanel/base/frontend/jupiter/images/roundcube.png"
url="https://github.com/childgo/go-public/raw/master/whm/roundcube/roundcube.png"

# Download the image
wget -O "${file_path}" "${url}"

# Print a message indicating the download is complete
echo "Image downloaded and saved to ${file_path}"
#=============================================================================================================






#=============================================================================================================
#Lock Files
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/seal.png
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/logo.svg
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html
chattr +i /usr/local/cpanel/base/frontend/jupiter/images/roundcube.png
#=============================================================================================================



