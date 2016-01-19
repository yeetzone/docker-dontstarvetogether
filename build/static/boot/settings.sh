#!/usr/bin/env bash

config_path=$1
file_settings="$config_path/settings.ini"
if [ -f $file_settings ]; then
	exit 0
fi

if [ -z "$DEFAULT_SERVER_NAME" ]; then
	selectRandomLine(){
		mapfile list < $1
		echo ${list[$RANDOM % ${#list[@]}]}
	}

	DEFAULT_SERVER_NAME="`selectRandomLine /usr/local/lib/dsta/data/adjectives.txt` `selectRandomLine /usr/local/lib/dsta/data/names.txt`"
	echo "'$DEFAULT_SERVER_NAME' has been set as the server's name."
fi

cat <<- EOF > $file_settings
	[network]
	default_server_name = $SERVER_NAME_PREFIX $DEFAULT_SERVER_NAME
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
	steam_group_id = $STEAM_GROUP_ID
	steam_group_only = $STEAM_GROUP_ONLY
	steam_group_admins = $STEAM_GROUP_ADMINS

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

chown steam:steam $file_settings
