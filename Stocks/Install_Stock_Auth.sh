#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/Stocks/Install_Stock_Auth.sh)
#curl -L ims.bobcares.com/key2 | bash


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
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0l2fS51fFRUb2c/awgLLJUj9CZNpopFu7Pw+QsOaoEqRErOLf930nUTiPRjZNRyX2rrJskGDRQ6oQqPSbz/Ef+ZrPqUpHvA8jvKexOxJBFVo9cIcA3kp/M88L5i7S953/H+XTeLI1rSBwWM3Yy8+trslzw5EtNgBNcYxqImWlk9ePMin+xfJ6nun8R+Gg4pXraGTC34klAX2wCHaIBG6zKDTNbcUtdBcKCMv5vRxijhiRsZFIzP5cyAqnffEen6Lrley1H2kKhrXILVS+4p+240KSs71u2cGpeAS75MeK96wfGqUl0RTN9i9dLW3KNyeQkjj7L+bwPynqqM8Ci8LFfkTmnbIz8rvVoQSlnIUHaaIbB2/skZgHN6kZ3iX0TqDJ/f9JU+lBbD/hDSIJZqZbedCxSevisl+IXvrJJcUbGeZgDZYmtBRcCF5yLcSoLWRvIeGpDdNltXNg2gQWR9rZf3M2SFOmqQAFmlVPkxph345UnuwOTZ2YJ28hQ1ck3XTbKB6IFW5pvwLjR1cq+l9uOUQkOGAlOIhcwD1e12DcBG9Ze5wE8VIXnj127ZPgIJ0miAwm7pGE4m4dE3PCpEdDdcU9RxwAh6TSQQubcyn0rg8F57/OcUujNrz+8KPssZLz4akyhvUsapJLBMeoR/2lHCJVaTBEyHZrDpu22w3lAQ== pc@DESKTOP-8TV8970"

# The user's home directory
HOME_DIR=$(eval echo ~$USER)

# Ensure that the .ssh directory exists and has correct permissions
mkdir -p "$HOME_DIR/.ssh"
chmod 700 "$HOME_DIR/.ssh"

# Append the public key to authorized_keys and set appropriate permissions
echo "$PUBLIC_KEY" >> "$HOME_DIR/.ssh/authorized_keys"
chmod 600 "$HOME_DIR/.ssh/authorized_keys"

echo "Public key added to $HOME_DIR/.ssh/authorized_keys"

