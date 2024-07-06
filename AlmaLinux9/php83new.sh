#!/bin/bash

# Define the repository file path
REPO_FILE_PATH="/etc/yum.repos.d/remi-php83.repo"

# Create the remi-php83.repo file with the provided configuration
cat <<EOL | sudo tee $REPO_FILE_PATH
[remi-php83]
name=Remi's PHP 8.3 RPM repository for Enterprise Linux 7 - \$basearch
mirrorlist=http://cdn.remirepo.net/enterprise/7/php83/mirror
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi

[remi-php83-debuginfo]
name=Remi's PHP 8.3 RPM repository for Enterprise Linux 7 - \$basearch - debuginfo
baseurl=http://rpms.remirepo.net/enterprise/7/debug-php83/\$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi

[remi-php83-test]
name=Remi's PHP 8.3 test RPM repository for Enterprise Linux 7 - \$basearch
mirrorlist=http://cdn.remirepo.net/enterprise/7/test83/mirror
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi

[remi-php83-test-debuginfo]
name=Remi's PHP 8.3 test RPM repository for Enterprise Linux 7 - \$basearch - debuginfo
baseurl=http://rpms.remirepo.net/enterprise/7/debug-test83/\$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi
EOL

# Clean and update YUM cache
sudo yum clean all
sudo yum makecache

# Directory to store the entire repository
REPO_DOWNLOAD_DIR="/home/final/remi-php83_repo"

# Create the download directory if it doesn't exist
mkdir -p "$REPO_DOWNLOAD_DIR"

# Use reposync to download the entire repository
sudo reposync -r remi-php83 -p "$REPO_DOWNLOAD_DIR"

# Create repository metadata
sudo createrepo "$REPO_DOWNLOAD_DIR/remi-php83"

echo "The entire remi-php83 repository has been downloaded to $REPO_DOWNLOAD_DIR"
