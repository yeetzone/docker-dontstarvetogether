#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file="$STORAGE_PATH/$CLUSTER_NAME/$SHARD_NAME/worldgenoverride.lua"

validate_enum "WORLD_PRESET" SURVIVAL_TOGETHER SURVIVAL_TOGETHER_CLASSIC SURVIVAL_DEFAULT_PLUS DST_CAVE DST_CAVE_PLUS COMPLETE_DARKNESS MOD_MISSING

if [[ -n "$WORLD_PRESET" ]]; then
	echo "return { override_enabled = true, preset = \"$WORLD_PRESET\" }" > "$file"
elif [[ -n "$WORLD_CONFIGURATION" ]]; then
	echo "$WORLD_CONFIGURATION" > "$file"
fi
