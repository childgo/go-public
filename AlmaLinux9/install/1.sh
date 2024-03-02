#!/bin/bash

# Install DNF plugins core
sudo dnf install -y dnf-plugins-core

# Add EPEL and Remi Repository for dependency resolution
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# Enable PHP 8.3 module
sudo dnf module enable -y php:remi-8.3

# Create a directory to download packages
mkdir -p ~/php83-packages
cd ~/php83-packages

# Define a list of base PHP packages and common extensions to download
php_packages=(
  php
  php-fpm
  php-cli
  php-common
  php-mysqlnd
  php-pgsql
  php-zip
  php-gd
  php-mbstring
  php-curl
  php-xml
  php-pear
  php-bcmath
  php-json
  php-intl
)

# Download the defined PHP packages and their dependencies
for package in "${php_packages[@]}"
do
  echo "Resolving and downloading $package and its dependencies..."
  sudo dnf repoquery --requires --resolve --recursive $package --arch=x86_64,noarch | while read dep
  do
    echo "Downloading $dep..."
    sudo dnf download "$dep"
  done
  # Additionally, download the package itself if not already resolved as a dependency
  sudo dnf download $package
done

echo "All packages and dependencies for PHP 8.3 are downloaded in ~/php83-packages"
