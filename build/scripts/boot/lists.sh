#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file_admin="$STORAGE_PATH/$CLUSTER_NAME/adminlist.txt"
file_accept="$STORAGE_PATH/$CLUSTER_NAME/whitelist.txt"
file_block="$STORAGE_PATH/$CLUSTER_NAME/blocklist.txt"

# Create the adminlist file.
if [[ -n "$ADMINLIST" ]] && [[ ! -f "$file_admin" ]]; then
	create_list "$ADMINLIST" "$file_admin"
fi

# Create the acceptlist file.
if [[ -n "$WHITELIST" ]] && [[ ! -f "$file_accept" ]]; then
	create_list "$WHITELIST" "$file_accept"
fi

# Create the blocklist file.
if [[ -n "$BLOCKLIST" ]] && [[ ! -f "$file_block" ]]; then
	create_list "$BLOCKLIST" "$file_block"
fi
