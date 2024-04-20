#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/Install_Auth.sh)
#ims.bobcares.com/key2

echo -e "============================================================================================="
#This is logo Print Part
# ANSI color code for green
GREEN="\e[32m"
# ANSI color code for reset
RESET="\e[0m"

# Print the ASCII art in green
echo -e "${GREEN}"
cat << "EOF"
 ____                              ____       _                           
/ ___|  ___  ___ _   _ _ __ ___   / ___| __ _| |_ _____      ____ _ _   _ 
\___ \ / _ \/ __| | | | '__/ _ \ | |  _ / _` | __/ _ \ \ /\ / / _` | | | |
 ___) |  __/ (__| |_| | | |  __/ | |_| | (_| | ||  __/\ V  V / (_| | |_| |
|____/ \___|\___|\__,_|_|  \___|  \____|\__,_|\__\___| \_/\_/ \__,_|\__, |
                                                                    |___/ 
EOF
echo -e "${RESET}"
echo -e "============================================================================================="


####This Is for development
SG_home_dir=$(cat /etc/passwd | grep ^$(whoami): | cut -d ":" -f 6);
SG_ssh_key_dir=$SG_home_dir/.ssh
SG_ssh_key_file=$SG_home_dir/.ssh/authorized_keys
####This Is for development



# The public key you provided
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpqCdFKFBv+7RpSPZzahMdoJywonhbrfov/QC+nn5G8Df3R3VmlY41u3t4KN8nr1TkRNXsFYeu23fyXxNQhXCjz/X9HW/TF/god2CLmRUXMEFT6H1foDYQB0nZ1sEKwzAA9NvxPlTBIdTwqXa6qx6whEL0Mh3xmNVzKu/y1uonepw3pt190z/mLdLz17rmf8d+gzYQVC0W0K2MgCy6B9amA0xd8k9/P1Dz46HdA68aatWl7Hhgxxe6vxCfUqYntVPr5Jheq0xbI+D0o1lbzsi1HcKGyh6VPxMU9wMyUIAlPjDVDaOm0n/kepj3zXsIrXvzOIajH3K+adhJx6Jdg8ZbfSMy0zl18O0q2KQKEXrRIbp42H44g9vG8+YPZyMdNHl2g6i8+Di0X5cl8NZIbmb6Qll9v7EJPvHpxAIZlzX3+b5wuP9STcT49WgcIWbWEC3AHj+7qg/AkLn/Jc3wxiUb2yxee9My7gcfBlmmqAqQeteZjLZBI9U5pESa4HNsGkD8euXksEjitW7Nv+FWRoAvykeki7Tw2GPbFX4ivWWb1C//sPb55RK9K71fjYiThmuZYz9UwK8GaI413o1UcVi4sgEZ+6J6iC3EUSvVRY40gGcjx/DuGDwMWRhFQ7HSl66SXhsYX43UkzFbkh6cdQcCJ/sABNqyyQecYwR9aOW7kQ== mk@DESKTOP-960UH8F"

# The user's home directory
HOME_DIR=$(eval echo ~$USER)

# Ensure that the .ssh directory exists and has correct permissions
mkdir -p "$HOME_DIR/.ssh"
chmod 700 "$HOME_DIR/.ssh"

# Append the public key to authorized_keys and set appropriate permissions
echo "$PUBLIC_KEY" >> "$HOME_DIR/.ssh/authorized_keys"
chmod 600 "$HOME_DIR/.ssh/authorized_keys"

echo "Public key added to $HOME_DIR/.ssh/authorized_keys"

