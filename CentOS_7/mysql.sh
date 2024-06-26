#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/CentOS_7/mysql.sh)

while true; do
  echo "Timestamp: $(date)"
  echo "MySQL Queries:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Queries';"
  echo "MySQL Connections:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Connections';"
  echo "MySQL Threads Connected:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Threads_connected';"
  echo "MySQL Threads Running:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Threads_running';"
  echo "MySQL Slow Queries:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Slow_queries';"
  echo "MySQL Uptime:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Uptime';"
  echo "MySQL InnoDB Buffer Pool Usage:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_pages_free';"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_pages_total';"
  echo "MySQL Open Files Limit:"
  mysql -e "SHOW GLOBAL VARIABLES LIKE 'open_files_limit';"
  echo "MySQL Open Tables:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Open_tables';"
  echo "MySQL Table Locks Waited:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Table_locks_waited';"
  echo "MySQL Table Locks Immediate:"
  mysql -e "SHOW GLOBAL STATUS LIKE 'Table_locks_immediate';"
  echo "System CPU Usage:"
  top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "% CPU"}'
  echo "System Memory Usage:"
  free -m
  echo "Slow Queries (last 10 entries):"
  tail -n 10 /var/log/mysql/mysql-slow.log
  echo "-------------------------------"
  sleep 60
done

