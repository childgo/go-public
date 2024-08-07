
#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync/sync_php.sh)
##rsync -avz  --delete --progress -e "ssh -p 1111" /home/php83/php-8.3/ root@66.66.66.66:/home/repolin/public_html/Linux/AlmaLinux9/Secure_Gateway_php83/



# Exit immediately if a command exits with a non-zero status
set -e

# Install necessary packages
sudo dnf install -y yum-utils createrepo rsync

# Clear DNF cache and update metadata
sudo dnf clean all
sudo dnf makecache

# Reset PHP module and enable PHP 8.3 from Remi repository
sudo dnf module reset php -y
sudo dnf module enable php:remi-8.3 -y

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

# Sync only PHP 8.3 packages
PHP_REPO_DIR=$DIR/php-8.3
if [ ! -d "$PHP_REPO_DIR" ]; then
    mkdir -p $PHP_REPO_DIR
fi

# Sync PHP 8.3 repository
sudo dnf reposync --repo=remi-modular --newest-only --download-metadata --download-path=$PHP_REPO_DIR --delete

# Create repository metadata for PHP 8.3
sudo createrepo_c $PHP_REPO_DIR/

echo "PHP 8.3 repository has been synced."
