#!/bin/bash

# Define the directory where you want to download the packages
ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway/php8.3_install/'

# Ensure the target directory exists
mkdir -p "$ALSCO_Path"

# List of PHP packages you want to download
# Directly specifying the packages as per your command
PHP_PACKAGES=(
    php
    php-fpm
    php-mysqlnd
    php-gd
    php-cli
    php-curl
    php-mbstring
    php-bcmath
    php-zip
    php-opcache
    php-xml
    php-json
    php-intl
)

echo "Downloading PHP packages..."

# Download each specified package
for PACKAGE in "${PHP_PACKAGES[@]}"; do
    echo "Downloading $PACKAGE..."
    sudo dnf download --resolve --destdir="$ALSCO_Path" "$PACKAGE"
done

echo "PHP packages have been downloaded to $ALSCO_Path."
