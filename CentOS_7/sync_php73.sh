#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/sync_php73.sh)
clear



# Download specified tools
LOCAL_REPOS_PHP73_Tools="
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
