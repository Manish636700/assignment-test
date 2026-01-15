#!/bin/bash

LOG_FILE="$1"

if [ -z "$LOG_FILE" ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi 

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "unique IP addresses found in $LOG_FILE:"
echo "---------------------------------------"

awk '{print $1}' "$LOG_FILE" | \
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | \
sort -u | \
while read -r ip; do
    echo "$ip"
done