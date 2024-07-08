#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Log file
LOGFILE="/var/log/php_repo_sync.log"
exec > >(tee -a ${LOGFILE}) 2>&1

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

# Specify all local repositories in a single variable
LOCAL_REPOS="baseos appstream extras crb epel remi remi-modular"

# Update the path where you want to sync the repositories
ALSCO_Path='/home/php83'

# Enable and configure EPEL repository
sudo dnf install -y /path/to/epel-release-latest-9.noarch.rpm

# Enable and configure Remi repository
sudo dnf install -y /path/to/remi-release-9.rpm

# Enable the Remi repository for PHP 8.3
sudo dnf module enable php:remi-8.3 -y

# Loop to update each repository one at a time
for REPO in ${LOCAL_REPOS}; do
    echo "Syncing repository: $REPO"
    
    # Create directory for the repository if it doesn't exist
    REPO_DIR=$ALSCO_Path/$REPO
    if [ ! -d "$REPO_DIR" ]; then
        mkdir -p $REPO_DIR
    fi

    # Use dnf reposync to sync the repository
    sudo dnf reposync --repo=$REPO --newest-only --download-metadata --download-path=$REPO_DIR --delete
    
    # Check if the repository requires group metadata (e.g., comps.xml). This is common for 'baseos' and 'appstream'.
    if [[ $REPO = 'baseos' || $REPO = 'appstream' ]]; then
        COMPS_FILE="$REPO_DIR/comps.xml"
        if [ -f "$COMPS_FILE" ]; then
            sudo createrepo_c -g "$COMPS_FILE" $REPO_DIR/
        else
            echo "Group file $COMPS_FILE doesn't exist, skipping group metadata creation."
            sudo createrepo_c $REPO_DIR/
        fi
    else
        sudo createrepo_c $REPO_DIR/
    fi
done

# Sync PHP 8.3 packages
PHP_REPO_DIR=$ALSCO_Path/php-8.3
if [ ! -d "$PHP_REPO_DIR" ]; then
    mkdir -p $PHP_REPO_DIR
fi

# Sync PHP 8.3 repository
sudo dnf reposync --repo=remi --newest-only --download-metadata --download-path=$PHP_REPO_DIR --delete

# Create repository metadata for PHP 8.3
sudo createrepo_c $PHP_REPO_DIR/

echo "All specified repositories and PHP 8.3 have been synced."
