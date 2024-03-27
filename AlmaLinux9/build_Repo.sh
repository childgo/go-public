#rsync -avz  --delete --progress -e "ssh -p 1222" /home/repolin/public_html/Linux/AlmaLinux9 root@66.111.00.00:/home/repolin/public_html/Linux/AlmaLinux9
createrepo /home/repolin/public_html/Linux/AlmaLinux9/AlmaLinux9_Sync_Repository/
createrepo /home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway
chgrp -R repolin *
chown -R repolin *
