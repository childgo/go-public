#!/bin/bash
clear
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/roundcube/roundcube_skin.sh)








#######################################################
#Start Unlocking Files...
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/about.html
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/securegateway_seal.svg
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/logo.svg
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/favicon.ico

#storageBox
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/compose.html
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/secure_gateway_icon.png
chattr -i /usr/local/cpanel/base/3rdparty/roundcube/StorageBox_Insert.php


#WebMail Logo in frontEnd
chattr -i /usr/local/cpanel/base/unprotected/cpanel/templates/login.tmpl
chattr -i /usr/local/cpanel/base/unprotected/cpanel/images/alsco_securegateway_webmail.svg
chattr -i /usr/local/cpanel/base/frontend/jupiter/images/roundcube.png


#change password webmail logo
chattr -i /usr/local/cpanel/base/unprotected/cpanel/images/webmail-logo.svg
echo "The unlocking of files is complete...."
sleep 5
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





#=========================================================================
#=======================Start edit config.inc.php=======================#
# define the file path
filepath="/usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php"


#Remove config['skins_allowed']
sed -i "/\$config\['skins_allowed'\]/d" $filepath

#Add New config['skins_allowed']
sed -i "/\$config = \[\];/a \$config\['skins_allowed'\] = \['elastic'\];" $filepath

#Set identities_level to [3] to prevent add more identities to emaails
sed -i "s/\$config\['identities_level'\].*/\$config['identities_level'] = 3;/" /usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php



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
#=========================================================================












#=============================================================================================================
#Download Images
#=============================================================================================================
# Define the URLs and filenames
url1="https://github.com/childgo/go-public/raw/master/whm/roundcube/securegateway_seal.svg"
url2="https://github.com/childgo/go-public/raw/master/whm/roundcube/logo.svg"
url3="https://github.com/childgo/go-public/raw/master/whm/roundcube/favicon.ico"

filename1="securegateway_seal.svg"
filename2="logo.svg"
filename3="favicon.ico"

# Define the folder path
folderpath="/usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images"

# Download the images and overwrite if they exist
wget -q -O "${folderpath}/${filename1}" "${url1}" && echo "Downloaded ${filename1}"
wget -q -O "${folderpath}/${filename2}" "${url2}" && echo "Downloaded ${filename2}"
wget -q -O "${folderpath}/${filename3}" "${url3}" && echo "Downloaded ${filename3}"

#=============================================================================================================





#=============================================================================================================
#Webmail Logo in frontEnd
folderpath_logo_sg="/usr/local/cpanel/base/unprotected/cpanel/images/"
url_webmail_logo_sg="https://github.com/childgo/go-public/raw/master/whm/roundcube/alsco_securegateway_webmail.svg"
webmail_filename_logo="alsco_securegateway_webmail.svg"
wget -q -O "${folderpath_logo_sg}/${webmail_filename_logo}" "${url_webmail_logo_sg}" && echo "Downloaded ${webmail_filename_logo}"



# Define the file path
FILE_PATH_webmailLogo="/usr/local/cpanel/base/unprotected/cpanel/templates/login.tmpl"

# Check if the file exists
if [[ -f "$FILE_PATH_webmailLogo" ]]; then
    # Use sed to modify the file content within the specified block
    sed -i "/SET app_images = {/,/};/{s/'webmaild' *=> *'webmail-logo.svg'/'webmaild'  => 'alsco_securegateway_webmail.svg'/}" "$FILE_PATH_webmailLogo"
    echo "File modified successfully."
else
    echo "File does not exist."
fi

#Chanage webmail logo in change password page, 
mv /usr/local/cpanel/base/unprotected/cpanel/images/webmail-logo.svg /usr/local/cpanel/base/unprotected/cpanel/images/webmail-logo.svg1
cp /usr/local/cpanel/base/unprotected/cpanel/images/alsco_securegateway_webmail.svg /usr/local/cpanel/base/unprotected/cpanel/images/webmail-logo.svg
#=============================================================================================================




#=============================================================================================================
# Change footer
# Define the file path
footer_file_path="/usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html"

# Check if the file exists and is writable
if [ ! -f "${footer_file_path}" ] || [ ! -w "${footer_file_path}" ]; then
    echo "Error: File does not exist or is not writable."
    exit 1
fi

# Define the new content
footer_new_content=$(cat <<'END'
<roundcube:if condition="!env:framed || env:extwin" />
</div>
<roundcube:if condition="config:support_url" />
<a href="<roundcube:var name='config:support_url' />" target="_blank" id="supportlink" class="hidden"><roundcube:label name="support" /></a>
<roundcube:endif />
<roundcube:endif />

<roundcube:object name="message" id="messagestack" />

<script src="/deps/bootstrap.bundle.min.js"></script>
<script src="/ui.js"></script>



<br><br><br>
<style>
@media (max-width: 768px) {
  #securegateway-seal {
    display: none !important;
  }
}
</style>
<div id="securegateway-seal" style="position: fixed; z-index: 1000; width: 150px; height: 65px; bottom: 5px; right: 2px;">
  <img class="img-responsive" alt="Secure Gateway" src="/images/securegateway_seal.svg" width="150" height="66" />
</div>
</body>
</html>
END
)

# Create a backup of the original file
cp "${footer_file_path}" "${footer_file_path}.bak"

# Replace the entire content of the file with the new content
if printf "%s" "${footer_new_content}" > "${footer_file_path}"; then
    echo "Footer content replaced successfully."
else
    echo "Error: Failed to replace footer content."
fi

sleep 3
#=============================================================================================================






#=============================================================================================================
# Change about page
# Define the file path
about_file_path="/usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/about.html"

# Check if the file exists and is writable
if [ ! -f "${about_file_path}" ] || [ ! -w "${about_file_path}" ]; then
    echo "Error: File does not exist or is not writable."
    exit 1
fi

# Define the new content
about_new_content=$(cat <<'END'
<roundcube:include file="includes/layout.html" />

<h1 class="voice"><roundcube:label name="about" /></h1>

<div class="frame-content">
    <roundcube:object name="aboutcontent" />

        <!-- Section about Email Secure Gateway by ALSCO -->
    <div class="email-secure-gateway">
        <p style="text-align: justify;">In the evolving landscape of digital communication, ALSCO&reg; presents its groundbreaking technology, the Email Secure Gateway&reg;. This innovative solution is engineered to elevate email services by integrating unparalleled security measures.</p>
        <p style="text-align: justify;">Acting as a vigilant sentry, the Email Secure Gateway&reg; meticulously scans incoming and outgoing emails. Its advanced algorithms are adept at identifying and neutralizing a myriad of threats, from phishing attempts to malware intrusions, ensuring each correspondence is safe and secure.</p>
        <p style="text-align: justify;">Recognizing the crucial importance of data integrity, this technology seamlessly filters the continuous stream of information, guaranteeing that only legitimate and safe content reaches the user. The user experience is further enhanced by maintaining efficiency and speed, ensuring that security measures don't impede communication flow.</p>
        <p style="text-align: justify;">Email Secure Gateway&reg; by ALSCO stands tall, a digital gatekeeper, adept and wise, filtering the flux of data, where safety and efficiency harmonize. It's a guardian against threats, unseen but known, ensuring the integrity of each message, as if it were its own.</p>
    </div>
    <!-- End of Section -->
</div>
<roundcube:include file="includes/footer.html" />
END
)

# Create a backup of the original file
cp "${about_file_path}" "${about_file_path}.bak"

# Replace the entire content of the file with the new content
if printf "%s" "${about_new_content}" > "${about_file_path}"; then
    echo "About page content replaced successfully."
else
    echo "Error: Failed to replace about page content."
fi

sleep 3
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
#Fix compose html formatted messages by default
CONFIG_FILE_1="/usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php"

# Use sed to replace the line
sed -i "/^\$config\['htmleditor'\]/c\$config\['htmleditor'\] = 1;" "$CONFIG_FILE_1"
#=============================================================================================================

















#=============================================================================================================
#Lock Files
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/config/config.inc.php
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/includes/footer.html
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/about.html
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/securegateway_seal.svg
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/logo.svg
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/images/favicon.ico


#storageBox
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/skins/elastic/templates/compose.html
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/secure_gateway_icon.png
chattr +i /usr/local/cpanel/base/3rdparty/roundcube/StorageBox_Insert.php



#WebMail Logo in frontEnd
chattr +i /usr/local/cpanel/base/unprotected/cpanel/templates/login.tmpl
chattr +i /usr/local/cpanel/base/unprotected/cpanel/images/alsco_securegateway_webmail.svg
chattr +i /usr/local/cpanel/base/frontend/jupiter/images/roundcube.png



#change password webmail logo
chattr +i /usr/local/cpanel/base/unprotected/cpanel/images/webmail-logo.svg
#=============================================================================================================



