#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/Nginx_Select.sh)

# Define the base directory where the repositories will be synced
BASEDIR="/home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository"

# Define the repository IDs from the output of `yum repolist`
REPOS=("appstream" "baseos" "extras")

# Create the base directory if it doesn't exist
mkdir -p "$BASEDIR"

# Sync each repository and create the repository metadata
for REPO in "${REPOS[@]}"; do
    # Create a subdirectory for the repository if it doesn't exist
    REPODIR="$BASEDIR/$REPO"
    mkdir -p "$REPODIR"
    
    # Sync the repository
    reposync --repo="$REPO" --newest-only --delete --download-metadata --download-path="$BASEDIR"
    
    # Navigate to the repository directory
    pushd "$REPODIR"

    # Run createrepo to create the repository metadata
    createrepo .

    # Navigate back to the original directory
    popd
done

echo "All repositories have been synchronized and metadata has been created."
