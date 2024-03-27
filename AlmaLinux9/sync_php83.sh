#!/bin/bash

# Target directory for downloading packages
ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway/php8.3_install/'

# Ensure the target directory exists
mkdir -p "$ALSCO_Path"

# Temporary directory for repo packages
temp_dir=$(mktemp -d)

# Download EPEL and Remi repository RPMs
echo "Downloading EPEL and Remi repository packages..."
dnf download --destdir="$temp_dir" epel-release
dnf download --destdir="$temp_dir" https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf download --destdir="$temp_dir" https://rpms.remirepo.net/enterprise/remi-release-9.2.rpm

# Install downloaded repository packages locally to fetch PHP packages
echo "Installing repository packages locally to enable PHP 8.3 module..."
rpm -ivh --nodeps "$temp_dir"/*.rpm

# Enable PHP 8.3 module from Remi repository
dnf module enable php:remi-8.3 -y

# List of PHP packages to download
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
    php-devel
    php-xdebug
    php-pcov
)

# Download yum-utils for the repoquery command
echo "Downloading yum-utils..."
dnf download --resolve --destdir="$ALSCO_Path" yum-utils

# Download PHP 8.3 packages and their dependencies
echo "Downloading PHP 8.3 packages and dependencies..."
for PACKAGE in "${PHP_PACKAGES[@]}"; do
    dnf download --resolve --destdir="$ALSCO_Path" "$PACKAGE"
done

# Cleanup: Remove temporary directory
rm -rf "$temp_dir"

echo "PHP 8.3 packages and dependencies have been downloaded to $ALSCO_Path."
