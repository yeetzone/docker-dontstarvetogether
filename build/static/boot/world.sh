#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file_leveldata_override="$CLUSTER_PATH/$SHARD_NAME/leveldataoverride.lua"

if [[ -f "$file_leveldata_override" ]] && containsElement "world" "$@"; then
	exit 0
fi

rm -f "$file_leveldata_override"

if [[ -n "$LEVELDATA_OVERRIDES" ]]; then
	echo "$LEVELDATA_OVERRIDES" > "$file_leveldata_override"
fi

if [[ -f "$file_leveldata_override" ]]; then
	chown "$STEAM_USER":"$STEAM_USER" "$file_leveldata_override"
fi
