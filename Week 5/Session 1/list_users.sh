#!/bin/bash
# Script to list all system users
echo "List of all users:"
cut -d: -f1 /etc/passwd
