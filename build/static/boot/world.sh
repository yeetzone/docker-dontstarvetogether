#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file_leveldata_override="$CLUSTER_PATH/$SHARD_NAME/leveldataoverride.lua"

if [[ -f "$file_leveldata_override" ]] && containsElement "world" "$@"; then
	exit 0
fi

rm -f "$file_leveldata_override"

if [[ -n "$LEVELDATA_OVERRIDES" ]]; then
	echo "$LEVELDATA_OVERRIDES" > "$file_leveldata_override"
elif [[ -n "$WORLD_PRESET" ]]; then
	validate_option "WORLD_PRESET" SURVIVAL_TOGETHER SURVIVAL_TOGETHER_CLASSIC SURVIVAL_DEFAULT_PLUS COMPLETE_DARKNESS DST_CAVE DST_CAVE_PLUS

	if [[ "$WORLD_PRESET" = "DST_CAVE" ]] || [[ "$WORLD_PRESET" = "DST_CAVE_PLUS" ]]; then
		location="cave"
	else
		location="forest"
	fi

	cat <<- EOF > "$file_leveldata_override"
return {
  id = "$WORLD_PRESET",
  location = "$location",
  name="",
  desc="",
  overrides={},
}
EOF
fi

if [[ -f "$file_leveldata_override" ]]; then
	chown "$STEAM_USER":"$STEAM_USER" "$file_leveldata_override"
fi
