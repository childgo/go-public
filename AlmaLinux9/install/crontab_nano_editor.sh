#!/bin/bash
clear


#Install Nano
yum install nano




#Setting nano as default editor


cat <<EOF >>~/.bash_profile
export VISUAL="nano"
export EDITOR="nano"
EOF

exit 0

echo "Done"
