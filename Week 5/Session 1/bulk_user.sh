#!/bin/bash
# Script to create users from a CSV file

echo "Enter the path to the CSV file:"
read csvfile

if [ ! -f "$csvfile" ]; then
    echo "File '$csvfile' does not exist."
    exit 1
fi

# Skip header row (if present)
tail -n +2 "$csvfile" | while IFS=, read username; do
    if [ -n "$username" ]; then
        sudo useradd "$username"
        echo "User '$username' has been created."
    fi
done
