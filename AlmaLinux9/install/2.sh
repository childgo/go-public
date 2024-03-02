#!/bin/bash

# Define the directory where you want to download the packages
ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway/php8.3_install/'

# Ensure the target directory exists
mkdir -p "$ALSCO_Path"

# List of PHP packages you want to download
# Removed the specific package names since you want to capture whatever is currently installed
# Instead, we'll dynamically create this list based on installed PHP packages

# Get a list of installed PHP packages and download them
# This command lists installed PHP packages, filters for those matching your criteria, and stores them in an array
# Adjust the grep pattern if you're looking for a different PHP version pattern in your installed packages
PHP_PACKAGES=($(rpm -qa | grep '^php' | sed 's/-[0-9].*$//'))

echo "Downloading PHP packages..."

# Download each package found by the rpm command
for PACKAGE in "${PHP_PACKAGES[@]}"; do
    echo "Downloading $PACKAGE..."
    sudo dnf download --resolve --destdir="$ALSCO_Path" "$PACKAGE"
done

echo "PHP packages have been downloaded to $ALSCO_Path."
