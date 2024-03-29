#!/bin/bash

#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/sync_getpagespeed.sh)
#rsync -avz  --delete --progress -e "ssh -p 111" /home/final/Linux/cento7/ root@50.50.50.50:/home/repolin/public_html/Linux/Nginx_Centos7/

##specify all local repositories in a single variable

yum -y update;sleep 3;
yum install epel-release createrepo;sleep 3;
yum-utils moreutils
yum -y install wget nano inotify-tools perl ipset unzip net-tools perl-libwww-perl;sleep 3;
yum -y install perl-LWP-Protocol-https perl-GDGraph bind-utils;sleep 3;



LOCAL_REPOS_Nginx="
nginx
nginx-all-modules
nginx-owasp-crs
nginx-mod-http-image-filter
nginx-mod-http-perl
nginx-mod-http-xslt-filter
nginx-mod-mail
nginx-mod-stream
nginx-module-accept-language
nginx-module-ajp
nginx-module-array-var
nginx-module-auth-ldap
nginx-module-json-var
nginx-module-auth-pam
nginx-module-aws-auth
nginx-module-bot-verifier
nginx-module-brotli
nginx-module-cache-purge
nginx-module-captcha
nginx-module-combined-upstreams
nginx-module-concat
nginx-module-cookie-flag
nginx-module-cookie-limit
nginx-module-coolkit
nginx-module-doh
nginx-module-dynamic-etag
nginx-module-dynamic-limit-req
nginx-module-dyups
nginx-module-echo
nginx-module-encrypted-session
nginx-module-execute
nginx-module-f4fhds
nginx-module-fancyindex
nginx-module-fips-check
nginx-module-flv
nginx-module-form-input
nginx-module-substitutions
nginx-module-geoip
nginx-module-geoip2
nginx-module-google
nginx-module-graphite
nginx-module-headers-more
nginx-module-hmac-secure-link
nginx-module-html-sanitize
nginx-module-iconv
nginx-module-image-filter
nginx-module-immutable
nginx-module-ipscrub
nginx-module-jpeg
nginx-module-js-challenge
nginx-module-jwt
nginx-module-length-hiding
nginx-module-log-zmq
nginx-module-lua
nginx-module-memc
nginx-module-naxsi
nginx-module-nbr
nginx-module-nchan
nginx-module-ndk
nginx-module-njs
nginx-module-nps
nginx-module-nps-selinux
nginx-module-pagespeed
nginx-module-pagespeed-selinux
nginx-module-passenger
nginx-module-perl
nginx-module-phantom-token
nginx-module-php7
nginx-module-php73
nginx-module-php74
nginx-module-postgres
nginx-module-pta
nginx-module-push-stream
nginx-module-rdns
nginx-module-redis2
nginx-module-rtmp
nginx-module-rtmp-selinux
nginx-module-secure-token
nginx-module-security-headers
nginx-module-security
nginx-module-security-selinux
nginx-module-set-misc
nginx-module-shibboleth
nginx-module-slowfs
nginx-module-small-light
nginx-module-srcache
nginx-module-statsd
nginx-module-sticky
nginx-module-stream-lua	
nginx-module-stream-upsync
nginx-module-sysguard
nginx-module-testcookie
nginx-module-traffic-accounting
nginx-module-ts
nginx-module-untar
nginx-module-upload
nginx-module-upstream-fair
nginx-module-upsync
nginx-module-vts
nginx-module-waf
nginx-module-webp
nginx-module-xslt
nginx-module-zip
nginx-cloudflare-ips-v4
nginx-cloudflare-ips-v6
nginx-module-vod
nginx-mod-module-proxy-connect
syslog-ng

"




LOCAL_REPOS_Tools="
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
yum install nload
nano
createrepo
htop
tmpwatch
e2fsprogs
libselinux-python
inotify-tools
selinux-policy-targeted
lua-cjson
libmaxminddb-devel
jq
wget
perl
ipset
unzip
net-tools
perl-libwww-perl
perl-LWP-Protocol-https
perl-GDGraph
bind-utils
rsync
lftp
mariadb-server
mariadb
mysql-connector-odbc
MySQL-python
httrack
goaccess
iftop
iptraf
sshpass
sysbench
tcptrack
iptraf
xmail
imapsync
traceroute
lsyncd
"

#==============================================
##a loop to update repos one at a time
for REPO in ${LOCAL_REPOS_Nginx}; do
repotrack -a x86_64 -p /home/final/Linux/cento7/Nginx/$REPO $REPO
done
#==============================================




#==============================================
##a loop to update repos one at a time
for REPO in ${LOCAL_REPOS_Tools}; do
repotrack -a x86_64 -p /home/final/Linux/cento7/Tools/$REPO $REPO
done
#==============================================
