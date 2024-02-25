#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/sync_mirror_centos7.sh)
sudo dnf install dnf-plugins-core createrepo_c -y


##specify all local repositories in a single variable

LOCAL_REPOS="base extras updates centosplus"

ALSCO_Path='/home/repolin/public_html/Linux/CentOS_7/Centos7_Sync_Repository/'



##a loop to update repos one at a time
for REPO in ${LOCAL_REPOS}; do

reposync -g -l -d -m --repoid=$REPO --newest-only --download-metadata --download_path=$ALSCO_Path/



if [[ $REPO = 'base' || $REPO = 'epel' ]]; then
        createrepo -g comps.xml $ALSCO_Path/$REPO/
else
        createrepo $ALSCO_Path/$REPO/
fi



done
cd /home/repolin/public_html/
pwd
chown -R repolin *
chgrp -R repolin *

du -h $ALSCO_Path --max-depth=0
