#!/bin/bash

#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/sync_getpagespeed.sh)
#rsync -avz  --delete --progress -e "ssh -p 111" /home/final/Linux/cento7/ root@50.50.50.50:/home/repolin/public_html/Linux/Nginx_Centos7/

# Update all packages
dnf -y update;sleep 3

# Install EPEL repository and createrepo package
dnf -y install epel-release createrepo;sleep 3

# Install yum-utils and moreutils packages
dnf -y install yum-utils moreutils;sleep 3

# Install additional packages
dnf -y install wget nano inotify-tools perl ipset unzip net-tools perl-libwww-perl;sleep 3

# Install further Perl modules and bind-utils
dnf -y install perl-LWP-Protocol-https perl-GDGraph bind-utils;sleep 3




LOCAL_REPOS_Nginx="
nginx
nginx-all-modules
nginx-owasp-crs
nginx-mod-http-image-filter
nginx-mod-http-perl
nginx-mod-http-xslt-filter
nginx-mod-mail
nginx-mod-stream
nginx-module-dyups
nginx-module-fips-check
nginx-module-security-selinux
nginx-module-nps-selinux
nginx-module-pagespeed-selinux
nginx-module-rtmp-selinux
nginx-module-security
nginx-cloudflare-ips-v4
nginx-cloudflare-ips-v6
nginx-mod-module-proxy-connect
nginx-module-nbr
syslog-ng



nginx-module-accept-language
nginx-module-accept-language-debuginfo

nginx-module-ajp
nginx-module-ajp-debuginfo

nginx-module-array-var
nginx-module-array-var-debuginfo

nginx-module-auth-digest
nginx-module-auth-digest-debuginfo

nginx-module-auth-ldap
nginx-module-auth-ldap-debuginfo

nginx-module-auth-pam
nginx-module-auth-pam-debuginfo

nginx-module-aws-auth
nginx-module-aws-auth-debuginfo

nginx-module-bot-verifier
nginx-module-bot-verifier-debuginfo

nginx-module-brotli
nginx-module-brotli-debuginfo

nginx-module-cache-purge
nginx-module-cache-purge-debuginfo

nginx-module-captcha
nginx-module-captcha-debuginfo

nginx-module-combined-upstreams
nginx-module-combined-upstreams-debuginfo

nginx-module-concat
nginx-module-concat-debuginfo

nginx-module-cookie-flag
nginx-module-cookie-flag-debuginfo

nginx-module-cookie-limit
nginx-module-cookie-limit-debuginfo

nginx-module-coolkit
nginx-module-coolkit-debuginfo

nginx-module-dav-ext
nginx-module-dav-ext-debuginfo

nginx-module-doh
nginx-module-doh-debuginfo

nginx-module-dynamic-etag
nginx-module-dynamic-etag-debuginfo

nginx-module-dynamic-limit-req
nginx-module-dynamic-limit-req-debuginfo

nginx-module-echo
nginx-module-echo-debuginfo

nginx-module-encrypted-session
nginx-module-encrypted-session-debuginfo

nginx-module-execute
nginx-module-execute-debuginfo
nginx-module-f4fhds
nginx-module-f4fhds-debuginfo

nginx-module-fancyindex
nginx-module-fancyindex-debuginfo

nginx-module-flv
nginx-module-flv-debuginfo

nginx-module-form-input
nginx-module-form-input-debuginfo

nginx-module-geoip
nginx-module-geoip-debuginfo

nginx-module-geoip2
nginx-module-geoip2-debuginfo

nginx-module-google
nginx-module-google-debuginfo

nginx-module-graphite
nginx-module-graphite-debuginfo

nginx-module-headers-more
nginx-module-headers-more-debuginfo

nginx-module-hmac-secure-link
nginx-module-hmac-secure-link-debuginfo

nginx-module-html-sanitize
nginx-module-html-sanitize-debuginfo

nginx-module-iconv
nginx-module-iconv-debuginfo

nginx-module-image-filter
nginx-module-image-filter-debuginfo

nginx-module-immutable
nginx-module-immutable-debuginfo

nginx-module-ipscrub
nginx-module-ipscrub-debuginfo

nginx-module-jpeg
nginx-module-jpeg-debuginfo

nginx-module-js-challenge
nginx-module-js-challenge-debuginfo

nginx-module-json
nginx-module-json-debuginfo

nginx-module-json-var
nginx-module-json-var-debuginfo

nginx-module-jwt
nginx-module-jwt-debuginfo

nginx-module-length-hiding
nginx-module-length-hiding-debuginfo

nginx-module-let
nginx-module-let-debuginfo

nginx-module-live-common
nginx-module-live-common-debuginfo

nginx-module-log-zmq
nginx-module-log-zmq-debuginfo

nginx-module-lua
nginx-module-lua-debuginfo

nginx-module-markdown
nginx-module-markdown-debuginfo
nginx-module-media-framework

nginx-module-memc
nginx-module-memc-debuginfo

nginx-module-naxsi
nginx-module-naxsi-debuginfo

nginx-module-nchan
nginx-module-nchan-debuginfo

nginx-module-ndk
nginx-module-ndk-debuginfo

nginx-module-njs
nginx-module-njs-debuginfo

nginx-module-nps
nginx-module-nps-debuginfo

nginx-module-ntlm
nginx-module-ntlm-debuginfo

nginx-module-pagespeed
nginx-module-pagespeed-debuginfo

nginx-module-passenger
nginx-module-passenger-debuginfo

nginx-module-perl
nginx-module-perl-debuginfo

nginx-module-phantom-token
nginx-module-phantom-token-debuginfo

nginx-module-php7
nginx-module-php7-debuginfo

nginx-module-php73
nginx-module-php73-debuginfo

nginx-module-php74
nginx-module-php74-debuginfo

nginx-module-postgres
nginx-module-postgres-debuginfo

nginx-module-pta
nginx-module-pta-debuginfo

nginx-module-push-stream
nginx-module-push-stream-debuginfo

nginx-module-rdns
nginx-module-rdns-debuginfo

nginx-module-redis2
nginx-module-redis2-debuginfo

nginx-module-replace-filter
nginx-module-replace-filter-debuginfo

nginx-module-rtmp
nginx-module-rtmp-debuginfo

nginx-module-secure-token
nginx-module-secure-token-debuginfo

nginx-module-security-debuginfo

nginx-module-security-headers
nginx-module-security-headers-debuginfo

nginx-module-set-misc
nginx-module-set-misc-debuginfo

nginx-module-shibboleth
nginx-module-shibboleth-debuginfo

nginx-module-slowfs
nginx-module-slowfs-debuginfo

nginx-module-small-light
nginx-module-small-light-debuginfo

nginx-module-spnego-http-auth
nginx-module-spnego-http-auth-debuginfo

nginx-module-srcache
nginx-module-srcache-debuginfo

nginx-module-statsd
nginx-module-statsd-debuginfo

nginx-module-sticky
nginx-module-sticky-debuginfo

nginx-module-stream-lua
nginx-module-stream-lua-debuginfo

nginx-module-stream-sts
nginx-module-stream-sts-debuginfo

nginx-module-stream-upsync
nginx-module-stream-upsync-debuginfo

nginx-module-sts
nginx-module-sts-debuginfo

nginx-module-substitutions
nginx-module-substitutions-debuginfo

nginx-module-sxg
nginx-module-sxg-debuginfo

nginx-module-sysguard
nginx-module-sysguard-debuginfo

nginx-module-testcookie
nginx-module-testcookie-debuginfo

nginx-module-traffic-accounting
nginx-module-traffic-accounting-debuginfo

nginx-module-ts
nginx-module-ts-debuginfo

nginx-module-untar
nginx-module-untar-debuginfo

nginx-module-upload
nginx-module-upload-debuginfo

nginx-module-upstream-fair
nginx-module-upstream-fair-debuginfo

nginx-module-upstream-jdomain
nginx-module-upstream-jdomain-debuginfo

nginx-module-upsync
nginx-module-upsync-debuginfo

nginx-module-vod
nginx-module-vod-debuginfo

nginx-module-vts
nginx-module-vts-debuginfo

nginx-module-waf
nginx-module-waf-debuginfo

nginx-module-webp
nginx-module-webp-debuginfo

nginx-module-xslt
nginx-module-xslt-debuginfo

nginx-module-xss
nginx-module-xss-debuginfo

nginx-module-zip
nginx-module-zip-debuginfo

nginx-module-zstd
nginx-module-zstd-debuginfo
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
htop
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
DESTDIR_Nginx=/home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway/Nginx
for REPO in $LOCAL_REPOS_Nginx; do
    dnf download --resolve --destdir=$DESTDIR_Nginx/$REPO $REPO
done
#==============================================




#==============================================
##a loop to update repos one at a time
DESTDIR_Tools=/home/repolin/public_html/Linux/AlmaLinux9/Nginx_SecureGateway/Tools
for REPO in $LOCAL_REPOS_Tools; do
    dnf download --resolve --destdir=$DESTDIR_Tools/$REPO $REPO
done
#==============================================
