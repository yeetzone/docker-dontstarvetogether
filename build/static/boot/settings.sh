#!/usr/bin/env bash

file_settings="$CONFIG_PATH/settings.ini"
if [ -f $file_settings ]; then
	exit 0
fi

if [ -z "$SERVER_NAME" ]; then
	selectRandomLine(){
		mapfile list < $1
		echo ${list[$RANDOM % ${#list[@]}]}
	}

	SERVER_NAME="`selectRandomLine $DSTA_HOME/data/adjectives.txt` `selectRandomLine $DSTA_HOME/data/names.txt`"
	echo "'$SERVER_NAME' has been set as the server's name."
fi

source "`dirname "$0"`/aux.sh"

validate_port "SERVER_PORT"
validate_bool "OFFLINE_ENABLE"
validate_int "MAX_PLAYERS" 1 64
validate_int "WHITELIST_SLOTS" 0 64
validate_bool "PVP_ENABLE" 1 64
validate_option "GAME_MODE" endless survival wilderness
validate_option "SERVER_INTENTION" cooperative social competitive madness
validate_bool "AUTOSAVER_ENABLE"
validate_option "TICK_RATE" 10 15 30 60
validate_int "CONNECTION_TIMEOUT" 1 3600000
validate_bool "VOTE_KICK_ENABLE"
validate_bool "PAUSE_WHEN_EMPTY"
validate_port "STEAM_AUTHENTICATION_PORT"
validate_port "STEAM_MASTER_SERVER_PORT"
validate_bool "STEAM_GROUP_ONLY"

validate_bool "CONSOLE_ENABLE"
validate_bool "AUTOCOMPILER_ENABLE"
validate_bool "MODS_ENABLE"

validate_bool "SHARD_ENABLE"
validate_bool "SHARD_IS_MASTER"
validate_port "SHARD_MASTER_PORT"

validate_bool "STEAM_CLOUD_DISABLE"

cat <<- EOF > $file_settings
	[network]
	default_server_name = $SERVER_NAME_PREFIX $SERVER_NAME
	default_server_description = $SERVER_DESCRIPTION
	server_port = $SERVER_PORT
	server_password = $SERVER_PASSWORD
	offline_server = $OFFLINE_ENABLE
	max_players = $MAX_PLAYERS
	whitelist_slots = $WHITELIST_SLOTS
	pvp = $PVP_ENABLE
	game_mode = $GAME_MODE
	server_intention = $SERVER_INTENTION
	enable_autosaver = $AUTOSAVER_ENABLE
	tick_rate = $TICK_RATE
	connection_timeout = $CONNECTION_TIMEOUT
	enable_vote_kick = $VOTE_KICK_ENABLE
	pause_when_empty = $PAUSE_WHEN_EMPTY
	steam_authentication_port = $STEAM_AUTHENTICATION_PORT
	steam_master_server_port = $STEAM_MASTER_SERVER_PORT
	steam_group_id = $STEAM_GROUP_ID
	steam_group_only = $STEAM_GROUP_ONLY
	steam_group_admins = $STEAM_GROUP_ADMINS

	[account]
	server_token = $SERVER_TOKEN

	[misc]
	console_enabled = $CONSOLE_ENABLE
	autocompiler_enabled = $AUTOCOMPILER_ENABLE
	mods_enabled = $MODS_ENABLE

	[shard]
	shard_enable = $SHARD_ENABLE
	shard_name = $SHARD_NAME
	shard_id = $SHARD_ID
	is_master = $SHARD_IS_MASTER
	master_ip = $SHARD_MASTER_IP
	master_port = $SHARD_MASTER_PORT
	bind_ip = $SHARD_BIND_IP
	cluster_key = $SHARD_CLUSTER_KEY

	[steam]
	disablecloud = $STEAM_CLOUD_DISABLE
EOF

chown steam:steam $file_settings
