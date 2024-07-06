#!/bin/bash

# Ensure the repository configuration is correctly set up
REPO_FILE="/mnt/data/remi-php73.repo"
sudo cp "$REPO_FILE" /etc/yum.repos.d/

# Clean and update YUM cache
sudo yum clean all
sudo yum makecache

# Directory to store the entire repository
REPO_DOWNLOAD_DIR="/home/final/remi-php73_repo"

# Create the download directory if it doesn't exist
mkdir -p "$REPO_DOWNLOAD_DIR"

# Use reposync to download the entire repository
sudo reposync -r remi-php73 -p "$REPO_DOWNLOAD_DIR"

# Create repository metadata
sudo createrepo "$REPO_DOWNLOAD_DIR/remi-php73"

echo "The entire remi-php73 repository has been downloaded to $REPO_DOWNLOAD_DIR"
