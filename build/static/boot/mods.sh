#!/usr/bin/env bash

file_mods_setup="$DST_HOME/mods/dedicated_server_mods_setup.lua"
file_mods_settings="$DST_HOME/mods/modsettings.lua"
file_mods_overrides="$CONFIG_PATH/modoverrides.lua"

IFS=","

# Install and enable regular mods from the Steam workshop.
if [ -n "$MODS" ] && [ ! -f $file_mods_overrides ]; then
	echo "" >> $file_mods_setup
	echo "" >> $file_mods_setup

	for mod in $MODS; do
		echo "ServerModSetup(\"$mod\")" >> $file_mods_setup
	done

	if [ -n "$MODS_OVERRIDES" ]; then
		echo "$MODS_OVERRIDES" > $file_mods_overrides
	else
		echo "return {" > $file_mods_overrides

		for mod in $MODS; do
			echo "  [\"workshop-$mod\"] = { enabled = true }," >> $file_mods_overrides
		done

		echo "}" >> $file_mods_overrides
	fi

	chown steam:steam $file_mods_overrides
fi

# Enable mods forcefully for mod development.
if [ -n "$MODS_FORCE" ]; then
	for mod in $MODS_FORCE; do
		echo "ForceEnableMod(\"$mod\")" >> $file_mods_settings
	done

	chown steam:steam $file_mods_settings
fi
