#!/bin/bash
# Script to delete a user
echo "Enter the username to delete:"
read username
sudo userdel -r "$username"
echo "User '$username' has been deleted."
