#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file_setup="$STEAM_PATH/mods/dedicated_server_mods_setup.lua"
file_settings="$STEAM_PATH/mods/modsettings.lua"
file_overrides="$STORAGE_PATH/$CLUSTER_NAME/$SHARD_NAME/modoverrides.lua"

IFS=","

# Install regular mods.
if [[ -n "$MODS" ]]; then
	rm -f "$file_setup"

	for mod in $MODS; do
		echo "ServerModSetup(\"$mod\")" >> "$file_setup"
	done

	rm -f "$file_overrides"

	if [[ -n "$MODS_OVERRIDES" ]]; then
		echo "$MODS_OVERRIDES" > "$file_overrides"
	else
		echo "return {" > "$file_overrides"

		for mod in $MODS; do
			echo "  [\"workshop-$mod\"] = { enabled = true }," >> "$file_overrides"
		done

		echo "}" >> "$file_overrides"
	fi
fi

# Install mods for development.
if [[ -n "$MODS_FORCE" ]]; then
	rm -f "$file_settings"

	for mod in $MODS_FORCE; do
		echo "ForceEnableMod(\"$mod\")" >> "$file_settings"
	done
fi
