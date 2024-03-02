#!/bin/bash

# Define the directory where you want to download the packages
DOWNLOAD_PATH='/home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway/php8.3_install/'

# Ensure the target directory exists
mkdir -p "$DOWNLOAD_PATH"

# Temporarily add the EPEL and Remi repositories for the session
sudo dnf install -y --downloadonly --downloaddir="$DOWNLOAD_PATH" https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# Enable Remi's PHP 8.3 repository
sudo dnf module enable php:remi-8.3 -y

# List of PHP 8.3 packages to download
PHP_PACKAGES=(
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

# Download PHP 8.3 packages and their dependencies
echo "Downloading PHP 8.3 packages and dependencies..."
for PACKAGE in "${PHP_PACKAGES[@]}"; do
    sudo dnf download --resolve --destdir="$DOWNLOAD_PATH" $PACKAGE
done

echo "PHP 8.3 packages and dependencies have been downloaded to $DOWNLOAD_PATH."
