#!/bin/bash
# Script to add a new user
echo "Enter the username to add:"
read username
sudo useradd "$username"
echo "User '$username' has been created."
