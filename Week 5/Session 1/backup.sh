#!/bin/bash
# Script to backup multiple directories

# Function to perform backup
backup_directory() {
    src_dir="$1"
    dest_dir="$2"
    timestamp=$(date +"%Y%m%d_%H%M%S")
    backup_file="${dest_dir}/$(basename "$src_dir")_${timestamp}.tar.gz"
    tar -czf "$backup_file" "$src_dir"
    echo "Backup of '$src_dir' completed: $backup_file"
}

echo "Enter destination backup directory (e.g., /backup):"
read dest_dir

# Create destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Loop through directories to backup
echo "Enter directories to backup, separated by spaces (e.g., /etc /var/log):"
read -a directories

for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        backup_directory "$dir" "$dest_dir"
    else
        echo "Directory '$dir' does not exist, skipping."
    fi
done
