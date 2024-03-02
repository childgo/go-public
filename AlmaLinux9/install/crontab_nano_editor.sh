#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/install/crontab_nano_editor.sh)

clear


#Install Nano
dnf install nano




#Setting nano as default editor


cat <<EOF >>~/.bash_profile
export VISUAL="nano"
export EDITOR="nano"
EOF

exit 0

echo "Done"
