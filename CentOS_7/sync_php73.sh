#!/bin/bash
set -e

# Define PHP tools to download
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
download_dir="/home/final/ok-php73"
mkdir -p "$download_dir"

# Download the specified tools using repotrack
for REPO in ${LOCAL_REPOS_PHP73_Tools}; do
    sudo repotrack -a x86_64 -p "$download_dir" "$REPO"
done
