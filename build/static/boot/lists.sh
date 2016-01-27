#!/usr/bin/env bash

gosu $STEAM_USER mkdir "$CONFIG_PATH/save"

create_list(){
	list=$1
	file=$2
	if [ -n "$list" ] && [ ! -f $file ]; then
		echo $list | tr , '\n' > $file
		chown $STEAM_USER:$STEAM_USER $file
	fi
}

# Create the adminlist.txt file.
create_list "$ADMINLIST" "$CONFIG_PATH/save/adminlist.txt"

# Create the whitelist.txt file.
create_list "$WHITELIST" "$CONFIG_PATH/save/whitelist.txt"

# Create the blocklist.txt file.
create_list "$BLOCKLIST" "$CONFIG_PATH/save/blocklist.txt"
