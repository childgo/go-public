#!/bin/bash

# Define the download path
DOWNLOAD_PATH="/home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway/php8.3_install/"

# Ensure the target directory exists
mkdir -p "$DOWNLOAD_PATH"

# Clean all dnf caches
dnf clean all

# Install EPEL and Remi repository RPMs
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# Enable PHP 8.3 module from Remi's repository
dnf module enable -y php:remi-8.3

# The list of PHP packages to download
PHP_PACKAGES=(
    php-cli
    php-fpm
    php-mysqlnd
    php-zip
    php-mbstring
    php-curl
    php-xml
    php-pear
    php-bcmath
    php-json
    php-gd # Including php-gd in the list as mentioned
    gd # Assuming you want the gd library as well
)

# Download PHP packages
echo "Downloading PHP packages..."
for PACKAGE in "${PHP_PACKAGES[@]}"; do
    dnf download --resolve --destdir="$DOWNLOAD_PATH" $PACKAGE
done

echo "PHP packages have been downloaded to $DOWNLOAD_PATH."
