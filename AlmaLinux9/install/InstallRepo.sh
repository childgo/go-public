#!/bin/bash

#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/install/InstallRepo.sh)
clear


# Delete all files in /etc/yum.repos.d/
rm -f /etc/yum.repos.d/*



cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_AlmaLinux9.repo
# Content from ALSCO_SecureGateway_AlmaLinux9.repo
[ALSCO_Secure_Gateway-baseos]
name=ALSCO_Secure_Gateway-BaseOS
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/baseos/
enabled=1
gpgcheck=0

[ALSCO_Secure_Gateway-appstream]
name=ALSCO_Secure_Gateway-AppStream
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/appstream/
enabled=1
gpgcheck=0

[ALSCO_Secure_Gateway-extras]
name=ALSCO_Secure_Gateway-Extras
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/extras/
enabled=1
gpgcheck=0

[ALSCO_Secure_Gateway-crb]
name=ALSCO_Secure_Gateway-CRB
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/crb/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_AlmaLinux9.repo
EOF








cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Module.repo
# Content from ALSCO_SecureGateway_Module.repo
[ALSCO_Secure_Gateway_ModulesSpeed-extras]
name=ALSCO_Secure_Gateway Modules extras for Enterprise
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Module/getpagespeed-extras/
enabled=1
gpgcheck=0
repo_gpgcheck=0
module_hotfixes=1
priority=9

[ALSCO_Secure_Gateway_ModulesSpeed-noarch]
name=ALSCO_Secure_Gateway Modules noarch for Enterprise
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Module/getpagespeed-extras-noarch/
enabled=1
gpgcheck=0
repo_gpgcheck=0
module_hotfixes=1
priority=9
#Finish Content from ALSCO_SecureGateway_Module.repo
EOF








cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Others_Requires.repo
# Content from ALSCO_SecureGateway_Others_Requires.repo
[ALSCO-Secure_Gateway_Others_Requires]
name=ALSCO-Secure_Gateway_Others_Requires
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Others_Requires/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_Others_Requires.repo
EOF











cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_php83.repo
# Content from ALSCO_SecureGateway_php83.repo
[ALSCO_Secure_Gateway-php8.3]
name=ALSCO_Secure_Gateway-php8.3
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/Secure_Gateway_php83/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_php83.repo
EOF










cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Tools.repo
# Content from ALSCO_SecureGateway_Tools.repo
[ALSCO_Secure_Gateway_Tools]
name=ALSCO_Secure_Gateway_Tools
baseurl=https://repo.alscoip.com/Linux/AlmaLinux9/SecureGateway_Tools/
enabled=1
gpgcheck=0
#Finish Content from ALSCO_SecureGateway_Tools.repo
EOF

echo "Repository files have been created with the updated content."

