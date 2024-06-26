#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/mysql.sh)

while true; do
  mysql -e "SHOW GLOBAL STATUS LIKE 'Queries';"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Connections';"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Threads_connected';"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Threads_running';"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Slow_queries';"
  sleep 60
  clear
done
