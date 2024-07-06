#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync_mirror_AlmaLinux9.sh)

# Update all packages
sudo dnf update -y

# Install necessary packages
sudo dnf install -y yum-utils
sudo dnf install -y createrepo
sudo dnf install -y rsync

# Enable CRB (CodeReady Builder) repository
sudo dnf config-manager --set-enabled crb

####################################################################################################################

# Define the path for the repository
DIR="/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/"

# Check if the directory exists, if not, create it
if [ -d "$DIR" ]; then
    echo "The directory $DIR already exists."
else
    echo "The directory $DIR does not exist. Creating now."
    mkdir -p $DIR
    if [ $? -eq 0 ]; then
        echo "The directory $DIR has been created."
    else
        echo "Failed to create the directory $DIR."
    fi
fi

####################################################################################################################

# Specify all local repositories in a single variable
LOCAL_REPOS="baseos appstream extras epel powertools"

# Update the path where you want to sync the repositories
ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/'

# Loop to update each repository one at a time
for REPO in ${LOCAL_REPOS}; do
    echo "Syncing repository: $REPO"
    
    # Use dnf reposync to sync the repository
    sudo dnf reposync --repo=$REPO --newest-only --download-metadata --download-path=$ALSCO_Path/ --delete
    
    # Check if the repository requires group metadata (e.g., comps.xml). This is common for 'baseos' and 'appstream'.
    if [[ $REPO = 'baseos' || $REPO = 'appstream' ]]; then
        # Assuming comps.xml is located at the root of the repository directory for 'baseos' and 'appstream'
        sudo createrepo_c -g $ALSCO_Path/$REPO/comps.xml $ALSCO_Path/$REPO/
    else
        sudo createrepo_c $ALSCO_Path/$REPO/
    fi
done

echo "All specified repositories have been synced."
