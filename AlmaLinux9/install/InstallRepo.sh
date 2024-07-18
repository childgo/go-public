#!/bin/bash

# Delete all files in /etc/yum.repos.d/
rm -f /etc/yum.repos.d/*

# Create new repo files with the embedded content
cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_AlmaLinux9.repo
# Content from ALSCO_SecureGateway_AlmaLinux9.repo
[AlmaLinux9-base]
name=AlmaLinux 9 - Base
baseurl=http://repo.example.com/almalinux/9/base
enabled=1
gpgcheck=1
gpgkey=http://repo.example.com/RPM-GPG-KEY-AlmaLinux
EOF

cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Module.repo
# Content from ALSCO_SecureGateway_Module.repo
[Module-Stream]
name=Module Stream
baseurl=http://repo.example.com/module/stream
enabled=1
gpgcheck=1
gpgkey=http://repo.example.com/RPM-GPG-KEY-ModuleStream
EOF

cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Others_Requires.repo
# Content from ALSCO_SecureGateway_Others_Requires.repo
[Others-Requires]
name=Others Requires
baseurl=http://repo.example.com/others/requires
enabled=1
gpgcheck=1
gpgkey=http://repo.example.com/RPM-GPG-KEY-OthersRequires
EOF

cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_php83.repo
# Content from ALSCO_SecureGateway_php83.repo
[PHP-8.3]
name=PHP 8.3 Repository
baseurl=http://repo.example.com/php/8.3
enabled=1
gpgcheck=1
gpgkey=http://repo.example.com/RPM-GPG-KEY-PHP83
EOF

cat <<EOF > /etc/yum.repos.d/ALSCO_SecureGateway_Tools.repo
# Content from ALSCO_SecureGateway_Tools.repo
[Tools]
name=Tools Repository
baseurl=http://repo.example.com/tools
enabled=1
gpgcheck=1
gpgkey=http://repo.example.com/RPM-GPG-KEY-Tools
EOF

echo "Repository files have been created with the updated content."

