#!/usr/bin/env bash

file_leveldata_override="$CLUSTER_PATH/$SHARD_NAME/leveldataoverride.lua"

if [ -f $file_leveldata_override ]; then
	exit 0
fi

if [ -n "$LEVELDATA_OVERRIDES" ]; then
	echo "$LEVELDATA_OVERRIDES" > $file_leveldata_override
elif [ -n "$WORLD_PRESET" ]; then
	source "`dirname "$0"`/functions.sh"

	validate_option "WORLD_PRESET" SURVIVAL_TOGETHER SURVIVAL_TOGETHER_CLASSIC SURVIVAL_DEFAULT_PLUS COMPLETE_DARKNESS DST_CAVE

	cat <<- EOF > $file_leveldata_override
return {
  id = "$WORLD_PRESET",
  version = 3,
}
EOF
fi

if [ -f $file_leveldata_override ]; then
	chown $STEAM_USER:$STEAM_USER $file_world_override
fi
