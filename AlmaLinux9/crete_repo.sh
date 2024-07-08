#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Log file
LOGFILE="/var/log/getpagespeed_metadata.log"
exec > >(tee -a ${LOGFILE}) 2>&1

# Define the path for the GetPageSpeed repositories for Enterprise Linux 9
GETPAGESPEED_Path='/home/repolin/public_html/Linux9/SecureGateway_Module/'

# Specify the GetPageSpeed repositories
GETPAGESPEED_REPOS="getpagespeed-extras getpagespeed-extras-noarch getpagespeed-extras-varnish60 getpagespeed-extras-nginx-mod getpagespeed-extras-mainline getpagespeed-extras-cmake-latest getpagespeed-extras-tengine getpagespeed-extras-angie"

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
