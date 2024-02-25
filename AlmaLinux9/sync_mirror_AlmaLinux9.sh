#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync_mirror_AlmaLinux9.sh)
sudo dnf update -y
sudo dnf install createrepo
dnf config-manager --set-enabled crb

#yum -y install epel-release createrepo yum-utils
#yum install createrepo
yum install rsync

sudo dnf install dnf-plugins-core createrepo_c -y



####################################################################################################################


# Define the path
DIR="/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/"

# Check if the directory exists
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
LOCAL_REPOS="baseos appstream extras"

# Update the path where you want to sync the repositories
ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/'

# Loop to update each repository one at a time
for REPO in ${LOCAL_REPOS}; do
    echo "Syncing repository: $REPO"
    
    # Use dnf reposync to sync the repository
    dnf reposync --repo=$REPO --newest-only --download-metadata --download-path=$ALSCO_Path/ --delete
    
    # Check if the repository requires group metadata (e.g., comps.xml). This is common for 'baseos' and 'appstream'.
    if [[ $REPO = 'baseos' || $REPO = 'appstream' ]]; then
        # Assuming comps.xml is located at the root of the repository directory for 'baseos' and 'appstream'
        createrepo_c -g comps.xml $ALSCO_Path/$REPO/
    else
        createrepo_c $ALSCO_Path/$REPO/
    fi
done

echo "All specified repositories have been synced."





#cd /home/repolin/public_html/
#pwd
#chown -R repolin *
#chgrp -R repolin *

#du -h $ALSCO_Path --max-depth=0
#du -h /home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/ --max-depth=0
