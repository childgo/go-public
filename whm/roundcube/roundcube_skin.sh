#!/bin/bash
clear


#=======================Start edit config.inc.php=======================#
# define the file path
filepath="/usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php"


# remove the 'skins_allowed' line
sed -i "/\$config\['skins_allowed'\]/d" $filepath


# add the 'skins_allowed' line with value 'elastic'
sed -i "/\$config = \[\];/a \$config\['skins_allowed'\] = \['elastic'\];" $filepath








# remove the 'skin' line
sed -i "/\$config\['skin'\]/d" $filepath

# add the 'skin' line with value 'elastic'
sed -i "/\$config = \[\];/a \$config\['skin'\] = 'elastic';" $filepath









# remove the 'plugins' line
sed -i "/\$config\['plugins'\]/d" $filepath

# add the 'plugins' line with the specified plugins
sed -i "/\$config = \[\];/a \$config\['plugins'\] = array('cpanellogin','cpanellogout','archive','calendar', 'return_to_webmail','markasjunk','alsco_auth');" $filepath




# print the edited lines
echo "New lines:"
echo "==========="
grep -E "\$config\['skins_allowed'\]|\$config\['skin'\]|\$config\['plugins'\]" $filepath
#=======================Start edit config.inc.php=======================#



























#Download

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

























#add seal to footer

# Define the file path
file_path="/usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html"

# Define the code to add
code_to_add="<br><br><p><div style=\"position: fixed; z-index: 1000; width: 150px; height: 65px; bottom: 5px; right: 2px;\"><img class=\"img-responsive\" alt=\"Secure Gateway\" src=\"/images/seal.png\" width=\"150\" height=\"66\" /></div></p>"

# Use sed to insert the code above </body>
sed -i "s|</body>|${code_to_add}</body>|" "${file_path}"








