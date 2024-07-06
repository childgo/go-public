#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/sync_php73.sh)
clear

sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm;sleep 3;


# Download specified tools
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
download_dir="/home/final/php73"
mkdir -p "$download_dir"

# Download the specified tools
for REPO in ${LOCAL_REPOS_PHP73_Tools}; do
    repotrack -a x86_64 -p "$download_dir" "$REPO"
done