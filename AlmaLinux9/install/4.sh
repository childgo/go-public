#!/bin/bash

# Define package URLs
PACKAGES=(
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-common-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-bcmath-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-cli-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-devel-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-fpm-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-gd-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-intl-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-mbstring-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-mysqlnd-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-opcache-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-pecl-pcov-1.0.11-3.el9.remi.8.3.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-pecl-xdebug3-3.3.1-1.el9.remi.8.3.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-pecl-zip-1.22.3-1.el9.remi.8.3.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/php-xml-8.3.3-1.el9.remi.x86_64.rpm"
"https://repo.alscoip.com/Linux/AlmaLinux9/Nginx_SecureGateway/PHP_V8.3_install1/yum-utils-4.3.0-11.el9_3.alma.1.noarch.rpm"
)

# Install all packages using dnf
for PACKAGE_URL in "${PACKAGES[@]}"; do
    dnf install "$PACKAGE_URL" -y
done
