#!/bin/bash
# Script to monitor system performance using a case statement
echo "Choose an option:"
echo "1. Show top CPU-consuming processes"
echo "2. Show memory usage"
echo "3. Show disk usage"
echo "4. Show system load averages"
read option
case "$option" in
    1)
        echo "Top 5 CPU-consuming processes:"
        ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
        ;;
    2)
        echo "Memory usage:"
        free -h
        ;;
    3)
        echo "Disk usage:"
        df -h
        ;;
    4)
        echo "System load averages:"
        uptime
        ;;
    *)
        echo "Invalid option. Please choose 1, 2, 3, or 4."
        ;;
esac
