#!/bin/bash
# Script to create users from a CSV file with username, password, and group

echo "Enter the path to the CSV file:"
read csvfile

if [ ! -f "$csvfile" ]; then
    echo "File '$csvfile' does not exist."
    exit 1
fi

# Skip header row and process each line
tail -n +2 "$csvfile" | while IFS=, read username password group; do
    if [ -n "$username" ]; then
        # Create the group if it doesn't exist
        if ! getent group "$group" > /dev/null 2>&1; then
            sudo groupadd "$group"
            echo "Group '$group' created."
        fi

        # Create the user and assign the group
        sudo useradd -m -g "$group" "$username"
        echo "$password" | sudo passwd --stdin "$username" 2>/dev/null

        echo "User '$username' created with group '$group'."
    fi
done
