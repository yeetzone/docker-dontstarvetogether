#!/usr/bin/env bash

create_list(){
	list=$1
	file=$2
	if [ -n "$list" ] && [ ! -f $file ]; then
		echo $list | tr , '\n' > $file
		chown $STEAM_USER:$STEAM_USER $file
	fi
}

# Create the adminlist.txt file.
create_list "$ADMINLIST" "$CLUSTER_PATH/$SHARD_NAME/save/adminlist.txt"

# Create the whitelist.txt file.
create_list "$WHITELIST" "$CLUSTER_PATH/$SHARD_NAME/save/whitelist.txt"

# Create the blocklist.txt file.
create_list "$BLOCKLIST" "$CLUSTER_PATH/$SHARD_NAME/save/blocklist.txt"
