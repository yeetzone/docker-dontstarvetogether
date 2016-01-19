#!/usr/bin/env bash

config_path=$1

file_mods="/opt/dst/mods/dedicated_server_mods_setup.lua"
file_mods_overrides="$config_path/modoverrides.lua"
if [ -f $file_mods_overrides ]; then
	exit 0
fi

if [ -n "$MODS" ]; then
	IFS=","
	echo "" >> $file_mods
	echo "" >> $file_mods
	for mod in $MODS; do
		echo "ServerModSetup(\"$mod\")" >> $file_mods
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
