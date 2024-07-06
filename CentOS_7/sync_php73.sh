#!/bin/bash

# Ensure the repository configuration is correctly set up
REPO_FILE="/mnt/data/remi-php73.repo"
sudo cp "$REPO_FILE" /etc/yum.repos.d/

# Enable necessary repositories
sudo yum install -y epel-release
sudo yum-config-manager --enable remi-php73
sudo yum-config-manager --enable remi-safe

# Clean and update YUM cache
sudo yum clean all
sudo yum makecache

# Install required dependencies manually
sudo yum install -y libzip libzip-devel libargon2 libargon2-devel oniguruma oniguruma-devel gd gd-devel

# Directory to store the entire repository
REPO_DOWNLOAD_DIR="/home/final/remi-php73_repo"

# Create the download directory if it doesn't exist
mkdir -p "$REPO_DOWNLOAD_DIR"

# Define packages to download
PACKAGES="php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-json"

# Use reposync to download the entire repository
sudo reposync -r remi-php73 -p "$REPO_DOWNLOAD_DIR"

# Download the specified packages and their dependencies using repotrack
for PACKAGE in $PACKAGES; do
    sudo repotrack -a x86_64 -p "$REPO_DOWNLOAD_DIR" "$PACKAGE"
done

# Create repository metadata
sudo createrepo "$REPO_DOWNLOAD_DIR/remi-php73"

echo "The entire remi-php73 repository and specified packages have been downloaded to $REPO_DOWNLOAD_DIR"
