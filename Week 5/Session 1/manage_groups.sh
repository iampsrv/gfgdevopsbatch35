#!/bin/bash
# Script to add or delete a group using a case statement
echo "Do you want to add or delete a group? (add/delete)"
read action
echo "Enter the group name:"
read groupname
case "$action" in
    add)
        sudo groupadd "$groupname"
        echo "Group '$groupname' has been added."
        ;;
    delete)
        sudo groupdel "$groupname"
        echo "Group '$groupname' has been deleted."
        ;;
    *)
        echo "Invalid action. Please choose 'add' or 'delete'."
        ;;
esac
