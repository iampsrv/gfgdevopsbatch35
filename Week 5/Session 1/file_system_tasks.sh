#!/bin/bash
# Script for basic file system tasks using a case statement
echo "Choose an option:"
echo "1. Create a directory"
echo "2. Set permissions"
echo "3. Check disk usage"
read option
case "$option" in
    1)
        echo "Enter the directory name:"
        read dirname
        mkdir -p "$dirname"
        echo "Directory '$dirname' created."
        ;;
    2)
        echo "Enter the file or directory path:"
        read path
        echo "Enter the permissions (e.g. 755):"
        read perms
        chmod "$perms" "$path"
        echo "Permissions set for '$path'."
        ;;
    3)
        echo "Disk usage report:"
        df -h
        ;;
    *)
        echo "Invalid option. Please choose 1, 2, or 3."
        ;;
esac
