#!/usr/bin/env bash

file="$STORAGE_PATH/$CLUSTER_NAME/$SHARD_NAME/leveldataoverride.lua"

if [[ -n "$LEVELDATA" ]] && [[ ! -f "$file" ]]; then
  	data="$STEAM_HOME/data/world/$LEVELDATA.lua"

	if [[ -f "$data" ]]; then
		cp "$data" "$file"
	else
		echo "$LEVELDATA" > "$file"
	fi
fi
