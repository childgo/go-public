#!/bin/bash
clear
curl -X POST -d "timestamp=$(date '+%Y-%m-%d %H:%M:%S')&output=$(hostname | tr -d '\n')" "https://monitor.cdn-today.com/micro_post/api.php"


#code here
