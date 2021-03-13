#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file_setup="$STEAM_PATH/mods/dedicated_server_mods_setup.lua"
file_configuration="$STORAGE_PATH/$CLUSTER_NAME/$SHARD_NAME/modoverrides.lua"
file_settings="$STEAM_PATH/mods/modsettings.lua"

IFS=","

# Install regular mods.
if [[ -n "$MODS" ]]; then
	rm -f "$file_setup"

	for mod in $MODS; do
		echo "ServerModSetup(\"$mod\")" >> "$file_setup"
	done

	rm -f "$file_configuration"

	if [[ -n "$MODS_CONFIGURATION" ]]; then
		echo "$MODS_CONFIGURATION" > "$file_configuration"
	else
		echo "return {" > "$file_configuration"

		for mod in $MODS; do
			echo "  [\"workshop-$mod\"] = { enabled = true }," >> "$file_configuration"
		done

		echo "}" >> "$file_configuration"
	fi
fi

# Install mods for development.
if [[ -n "$MODS_FORCE" ]]; then
	rm -f "$file_settings"

	for mod in $MODS_FORCE; do
		echo "ForceEnableMod(\"$mod\")" >> "$file_settings"
	done
fi
