#!/bin/bash

# Packages for which dependencies will be downloaded
PACKAGES="php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-json"

# Directory to store downloaded packages
download_dir="/home/final/php_dependencies"

# Create download directory if it doesn't exist
mkdir -p "$download_dir" || { echo "Failed to create download directory"; exit 1; }

# Download dependencies for each package
for PACKAGE in $PACKAGES; do
    sudo repotrack -a x86_64 -p "$download_dir" "$PACKAGE" || { echo "Failed to download dependencies for $PACKAGE"; exit 1; }
done

echo "Downloaded all dependencies successfully to $download_dir"
