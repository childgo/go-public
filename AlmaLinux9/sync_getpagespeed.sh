#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync_getpagespeed.sh)
#rsync -avz  --delete --progress -e "ssh -p 1111" /home/repolin/public_html/Linux9/SecureGateway_Module/ root@66.66.66.66:/home/repolin/public_html/Linux/AlmaLinux9/SecureGateway_Module/



# Exit immediately if a command exits with a non-zero status
set -e

# Update all packages
sudo dnf update -y

# Install necessary packages
sudo dnf install -y yum-utils createrepo rsync

# Define the path for the GetPageSpeed repositories for Enterprise Linux 9
DIR="/home/repolin/public_html/Linux9/SecureGateway_Module/"

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

# Specify the GetPageSpeed repositories for Enterprise Linux 9
GETPAGESPEED_REPOS="getpagespeed-extras getpagespeed-extras-noarch getpagespeed-extras-varnish60 getpagespeed-extras-nginx-mod getpagespeed-extras-mainline getpagespeed-extras-cmake-latest getpagespeed-extras-tengine getpagespeed-extras-angie"

# Path for GetPageSpeed repositories
GETPAGESPEED_Path='/home/repolin/public_html/Linux9/SecureGateway_Module/'

# Loop to update each GetPageSpeed repository one at a time
for REPO in ${GETPAGESPEED_REPOS}; do
    echo "Syncing repository: $REPO"
    
    # Create directory for the repository if it doesn't exist
    REPO_DIR=$GETPAGESPEED_Path/$REPO
    if [ ! -d "$REPO_DIR" ]; then
        mkdir -p $REPO_DIR
    fi

    # Use dnf reposync to sync the repository
    sudo dnf reposync --repo=$REPO --newest-only --download-metadata --download-path=$REPO_DIR --delete
    
    # Create the repository metadata
    sudo createrepo_c $REPO_DIR/
done

echo "All specified GetPageSpeed repositories for Enterprise Linux 9 have been synced."

# Loop to create metadata for each GetPageSpeed repository one at a time
for REPO in ${GETPAGESPEED_REPOS}; do
    echo "Creating metadata for repository: $REPO"
    
    # Create directory for the repository if it doesn't exist
    REPO_DIR=$GETPAGESPEED_Path/$REPO
    if [ ! -d "$REPO_DIR" ]; then
        mkdir -p $REPO_DIR
    fi

    # Create the repository metadata
    sudo createrepo $REPO_DIR/
done

echo "Metadata for all specified GetPageSpeed repositories has been created."
