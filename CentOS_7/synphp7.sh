#!/bin/bash
# Download remi-release-7.rpm to the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REMIREPO_RPM="$SCRIPT_DIR/remi-release-7.rpm"
curl -o "$REMIREPO_RPM" https://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Install remi-release-7.rpm
sudo yum -y install "$REMIREPO_RPM"

# Download specified PHP tools
LOCAL_REPOS_PHP73_Tools="
    epel-release
    yum-utils
    php
    php-cli
    php-fpm
    php-mysqlnd
    php-zip
    php-devel
    php-gd
    php-mbstring
    php-curl
    php-xml
    php-pear
    php-bcmath
    php-json
"

# Create directory for downloaded tools if it doesn't exist
download_dir="/home/final/php73_final"
mkdir -p "$download_dir"

# Download the specified tools
for REPO in ${LOCAL_REPOS_PHP73_Tools}; do
    repotrack -a x86_64 -p "$download_dir" "$REPO"
done
