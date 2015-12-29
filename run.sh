#!/usr/bin/env bash

# Update game and mods.
/home/steam/steamcmd/steamcmd.sh \
  +@ShutdownOnFailedCommand 1 \
  +@NoPromptForPassword 1 \
  +login anonymous \
  +force_install_dir /home/steam/steamapps/DST \
  +app_update 343050 validate \
  +quit

# Create the settings.ini file.
FILE_SETTINGS="/home/steam/.klei/DoNotStarveTogether/settings.ini"
if [ ! -f $FILE_SETTINGS ]; then
cat <<- EOF > $FILE_SETTINGS
	[network]
	default_server_name = $DEFAULT_SERVER_NAME
	default_server_description = $DEFAULT_SERVER_DESCRIPTION
	server_port = $SERVER_PORT
	server_password = $SERVER_PASSWORD
	offline_server = $OFFLINE_SERVER
	max_players = $MAX_PLAYERS
	whitelist_slots = $WHITELIST_SLOTS
	pvp = $PVP
	game_mode = $GAME_MODE
	server_intention = $SERVER_INTENTION
	enable_autosaver = $ENABLE_AUTOSAVER
	tick_rate = $TICK_RATE
	connection_timeout = $CONNECTION_TIMEOUT
	enable_vote_kick = $ENABLE_VOTE_KICK
	pause_when_empty = $PAUSE_WHEN_EMPTY
	steam_authentication_port = $STEAM_AUTHENTICATION_PORT
	steam_master_server_port = $STEAM_MASTER_SERVER_PORT

	[account]
	server_token = $SERVER_TOKEN

	[misc]
	console_enabled = $CONSOLE_ENABLED
	autocompiler_enabled = $AUTOCOMPILER_ENABLED
	mods_enabled = $MODS_ENABLED

	[shard]
	shard_enable = $SHARD_ENABLE
	shard_name = $SHARD_NAME
	shard_id = $SHARD_ID
	is_master = $IS_MASTER
	master_ip = $MASTER_IP
	master_port = $MASTER_PORT
	bind_ip = $BIND_IP
	cluster_key = $CLUSTER_KEY

	[steam]
	disablecloud = $DISABLECLOUD
EOF
fi

# Enable caves.
FILE_WORLD="/home/steam/.klei/DoNotStarveTogether/worldgenoverride.lua"
if [ -n "$WORLD_PRESET" ] && [ ! -f $FILE_WORLD ]; then
cat <<- EOF > $FILE_WORLD
	return {
	    override_enabled = true,
	    preset = "$WORLD_PRESET",
	}
EOF
fi

# Run the DST executable.
/home/steam/steamapps/DST/bin/dontstarve_dedicated_server_nullrenderer $@
