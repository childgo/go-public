#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/sync_php73.sh)
clear



# Download specified tools
LOCAL_REPOS_PHP73_Tools="
mysqltuner-cron
mysqltuner
ngxtop
remote_syslog2
fail2ban
closure-compiler
policycoreutils-python
setroubleshoot-server
selinux-policy-doc
attr
maldet
fcgiwrap
conntrack-tools
fds
closure-compiler
cloud-utils-growpart
mutt
zip
epel-release
yum-utils
lsyncd
"

# Create directory for downloaded tools if it doesn't exist
download_dir="/home/final/php73"
mkdir -p "$download_dir"

# Download the specified tools
for REPO in ${LOCAL_REPOS_PHP73_Tools}; do
    repotrack -a x86_64 -p "$download_dir" "$REPO"
done
