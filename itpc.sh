#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/itpc.sh)
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
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDuvW5ENCXDI5zbtNAfMvGSF0VSfue+JVuMPJY/DINJvVsVdkmhDH07LD/cH4vXSuXqBjs7rcNy8hnaByS65gaL9lqx1PXA9lUMgH7oOBFNK0sOqUh9M+Npn9dm8tNfw3IDyL+/21uNTWgTvdfjhPrPLK9e5FscwncLlvTCeZnemIuBVDtSudqOD8UD67aaGhd1upwYHNajdryVrO7zsbl4DZfz8aIoNhOVhaVHjRskOjGyKI5Zk9q19VfKgmlcZPpRM/b/sEuQWIzXP7RVlxKanfw+zU0lcJuih/gnWPlaG6s+VpRG2pMwXXV+tuSqx4507sbaug3/s0Eie0cGVjqhvpMSmsD2qnFVVX6dT/BE1KssILp4c+3IL6WFqnZZAOlpHLZXSebaT2mtnJgufVrhfUEi0x1ebapwc3+qyRFxfJ2dp+C/7zYJ1qcFBZSLnMMIFH/5w/1gL8YPABwNjMhs/eLonZPQU6mJTlFliSUCBRQCsyDGWsbPk5Nv03ZC/tukqpBkxfIjKkDm7kv24XC2OFr93lGZw8cKo86MgwgNKG5Auz2hC3DLEnngb1pRdTAoDfRXrsxPovIZwPyw7zaxwiLJfZ0UagA99lqE/D6y0uVgEcU0xP+BDUTEKI+WTgrLWHipaGel8IvYJWVWllQqBMu4KiW5aCj/RZ74DVWyw== pc@DESKTOP-8TV8970
"

# The user's home directory
HOME_DIR=$(eval echo ~$USER)

# Ensure that the .ssh directory exists and has correct permissions
mkdir -p "$HOME_DIR/.ssh"
chmod 700 "$HOME_DIR/.ssh"

# Append the public key to authorized_keys and set appropriate permissions
echo "$PUBLIC_KEY" >> "$HOME_DIR/.ssh/authorized_keys"
chmod 600 "$HOME_DIR/.ssh/authorized_keys"

echo "Public key added to $HOME_DIR/.ssh/authorized_keys"

