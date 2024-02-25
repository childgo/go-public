#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync_mirror_AlmaLinux9.sh)

ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/php83'

# Ensure the target directory exists
mkdir -p $ALSCO_Path

# Enable the EPEL and Remi repositories without installing them directly
# Note: This step is preparatory and assumes you want these repos enabled for context, but we'll manually specify packages to download.

# List of PHP packages you want to download
PHP_PACKAGES=(
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
)

# Download PHP 8.3 packages
echo "Downloading PHP 8.3 packages..."
for PACKAGE in "${PHP_PACKAGES[@]}"; do
    dnf download --resolve --destdir=$ALSCO_Path $PACKAGE
done

echo "PHP 8.3 packages have been downloaded to $ALSCO_Path."
