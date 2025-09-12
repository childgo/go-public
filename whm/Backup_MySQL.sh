#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/Backup_MySQL.sh)

#0 1 * * * /usr/bin/curl -s https://raw.githubusercontent.com/childgo/go-public/master/whm/Backup_MySQL.sh | /bin/bash


clear
# Get the current date in the format "2023-9-22"
date=$(date +%Y-%m-%d)

# Define the backup directory path
backup_root="/home/Backup_MySQL"
backup_dir="$backup_root/$date"

# Check if the backup directory exists, create it if not
if [ ! -d "$backup_dir" ]; then
    /usr/bin/mkdir -p -v "$backup_dir"
else
    echo "Backup directory $backup_dir already exists."
fi

# Loop through each database and create its backup
for DB in $(mysql -Be "show databases" | /usr/bin/grep -v 'row\|information_schema\|Database'); do
    echo "Generating MySQL backup of $DB"
    
    # Perform the database dump and save it as a compressed file
    if /usr/bin/mysqldump --skip-lock-tables --events --routines --triggers ${DB} | /usr/bin/gzip -9 > "$backup_dir/${DB}.sql.gz"; then
        echo "Backup of $DB completed."
    else
        echo "Backup of $DB failed."
    fi
done




# ----------------------------------------------------
# Backup important config directories (CSF + Apache2)
# ----------------------------------------------------

config_backup="$backup_dir/config_backup_${date}.zip"

echo "Zipping /etc/csf and /etc/apache2/conf.d into $config_backup"
if /usr/bin/zip -r "$config_backup" /etc/csf /etc/apache2/conf.d >/dev/null 2>&1; then
    echo "✅ Config backup created: $config_backup"
else
    echo "❌ Config backup failed" >&2
fi
# ----------------------------------------------------



# Delete folders older than 10 days
find "$backup_root" -type d -mtime +30 -exec rm -rf {} +

# Print completion message
echo "Complete."
