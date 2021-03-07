#!/usr/bin/env bash

file="$STORAGE_PATH/$CLUSTER_NAME/$SHARD_NAME/leveldataoverride.lua"

if [[ -n "$LEVELDATA_OVERRIDES" ]] && [[ ! -f "$file" ]]; then
	echo "$LEVELDATA_OVERRIDES" > "$file"
fi
