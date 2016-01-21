#!/usr/bin/env bash

file_world_override="$CONFIG_PATH/worldgenoverride.lua"

if [ -f $file_world_override ]; then
	exit 0
fi

if [ -n "$WORLD_OVERRIDES" ]; then
	echo "$WORLD_OVERRIDES" > $file_world_override
elif [ -n "$WORLD_PRESET" ]; then
	cat <<- EOF > $file_world_override
return {
  override_enabled = true,
  preset = "$WORLD_PRESET",
}
EOF
fi

if [ -f $file_world_override ]; then
	chown steam:steam $file_world_override
fi
