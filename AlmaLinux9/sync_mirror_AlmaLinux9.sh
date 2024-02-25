#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync_mirror_AlmaLinux9.sh)


#yum -y install epel-release createrepo yum-utils
yum install createrepo
yum install rsync




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



##specify all local repositories in a single variable

LOCAL_REPOS="base extras updates centosplus"

ALSCO_Path='/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/'

## Loop to update repos one at a time
for REPO in ${LOCAL_REPOS}; do
    dnf reposync --repo=$REPO --newest-only --download-metadata --download-path=$ALSCO_Path/ --delete

    # Check if the repository is 'base' or 'epel' to handle comps.xml specifically
    if [[ $REPO = 'base' || $REPO = 'epel' ]]; then
        createrepo_c -g comps.xml $ALSCO_Path/$REPO/
    else
        createrepo_c $ALSCO_Path/$REPO/
    fi
done




done
cd /home/repolin/public_html/
pwd
chown -R repolin *
chgrp -R repolin *

du -h $ALSCO_Path --max-depth=0
