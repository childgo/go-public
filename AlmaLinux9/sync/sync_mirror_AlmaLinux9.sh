
#!/bin/bash

#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync/sync_mirror_AlmaLinux9.sh)
#rsync -avz  --delete --progress -e "ssh -p 111" /home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/ root@50.50.50.50:/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/


# Exit immediately if a command exits with a non-zero status
set -e

# Log file
LOGFILE="/var/log/repo_sync.log"
exec > >(tee -a ${LOGFILE}) 2>&1

# Update all packages
sudo dnf update -y

# Install necessary packages
sudo dnf install -y yum-utils createrepo rsync

# Enable CRB (formerly known as PowerTools) repository
sudo dnf config-manager --set-enabled crb

####################################################################################################################

# Define the path for the repository
DIR="/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/"

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
LOCAL_REPOS="baseos appstream extras crb"

# Update the path where you want to sync the repositories
ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/'

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

echo "All specified repositories have been synced."
