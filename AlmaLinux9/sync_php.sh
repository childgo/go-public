#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update all packages
sudo dnf update -y

# Install necessary packages
sudo dnf install -y yum-utils createrepo rsync

# Enable CRB (formerly known as PowerTools) repository
sudo dnf config-manager --set-enabled crb

####################################################################################################################

# Define the path for the repository
DIR="/home/php83"

# Check if the directory exists, if not, create it
if [ ! -d "$DIR" ]; then
    echo "The directory $DIR does not exist. Creating now."
    mkdir -p $DIR
    if [ $? -eq 0 ]; then
        echo "The directory $DIR has been created."
    else
        echo "Failed to create the directory $DIR."
        exit 1
    fi
else
    echo "The directory $DIR already exists."
fi

####################################################################################################################

# Update the path where you want to sync the repository
ALSCO_Path='/home/php83'

# Enable and configure EPEL repository
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Enable and configure Remi repository
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.2.rpm

# Install yum-utils
sudo dnf install -y yum-utils

# Reset PHP module and install PHP 8.3 from Remi repository
sudo dnf module reset php -y
sudo dnf module install php:remi-8.3 -y

# Install PHP
sudo dnf install -y php

# Sync PHP 8.3 packages
PHP_REPO_DIR=$ALSCO_Path/php-8.3
if [ ! -d "$PHP_REPO_DIR" ]; then
    mkdir -p $PHP_REPO_DIR
fi

# Sync PHP 8.3 repository
sudo dnf reposync --repo=remi --newest-only --download-metadata --download-path=$PHP_REPO_DIR --delete

# Create repository metadata for PHP 8.3
sudo createrepo_c $PHP_REPO_DIR/

echo "PHP 8.3 repository has been synced."
