#!/usr/bin/env bash

config_path=$1
gosu steam mkdir "$config_path/save"

create_list(){
	list=$1
	file=$2
	if [ -n "$list" ] && [ ! -f $file ]; then
		echo $list | tr , '\n' > $file
		chown steam:steam $file
	fi
}

# Create the adminlist.txt file.
create_list "$ADMINLIST" "$config_path/save/adminlist.txt"

# Create the whitelist.txt file.
create_list "$WHITELIST" "$config_path/save/whitelist.txt"

# Create the blocklist.txt file.
create_list "$BLOCKLIST" "$config_path/save/blocklist.txt"
