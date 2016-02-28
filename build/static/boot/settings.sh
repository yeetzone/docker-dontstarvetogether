#!/usr/bin/env bash

file_cluster="$CLUSTER_PATH/cluster.ini"
file_server="$CLUSTER_PATH/$SHARD_NAME/server.ini"

if [ -z "$NAME" ]; then
	selectRandomLine(){
		mapfile list < $1
		echo ${list[$RANDOM % ${#list[@]}]}
	}

	NAME="`selectRandomLine $DSTA_HOME/data/adjectives.txt` `selectRandomLine $DSTA_HOME/data/names.txt`"
	echo "'$NAME' has been set as the cluster's name."
fi

source "`dirname "$0"`/aux.sh"

validate_port "SERVER_PORT"
validate_bool "OFFLINE_ENABLE"
validate_int "MAX_PLAYERS" 1 64
validate_int "WHITELIST_SLOTS" 0 64
validate_bool "PVP_ENABLE"
validate_option "GAME_MODE" endless survival wilderness
validate_option "INTENTION" cooperative social competitive madness
validate_bool "AUTOSAVER_ENABLE"
validate_option "TICK_RATE" 15 20 30 60
validate_bool "VOTE_KICK_ENABLE"
validate_bool "PAUSE_WHEN_EMPTY"
validate_bool "LAN_ONLY"
validate_port "STEAM_AUTHENTICATION_PORT"
validate_port "STEAM_MASTER_SERVER_PORT"
validate_bool "STEAM_GROUP_ONLY"
validate_bool "STEAM_GROUP_ADMINS"

validate_bool "CONSOLE_ENABLE"
validate_int "MAX_SNAPSHOTS" 0 1024

validate_bool "SHARD_ENABLE"
validate_bool "SHARD_IS_MASTER"
validate_port "SHARD_MASTER_PORT"

if [[ ! -f $file_cluster ]]; then
	cat <<- EOF > $file_cluster
		[GAMEPLAY]
		game_mode = $GAME_MODE
		max_players = $MAX_PLAYERS
		pvp = $PVP_ENABLE
		pause_when_empty = $PAUSE_WHEN_EMPTY
		vote_kick_enabled = $VOTE_KICK_ENABLE

		[NETWORK]
		cluster_name = $NAME_PREFIX $NAME
		cluster_description = $DESCRIPTION
		cluster_intention = $INTENTION
		cluster_password = $PASSWORD
		autosaver_enabled = $AUTOSAVER_ENABLE
		tick_rate = $TICK_RATE
		offline_server = $OFFLINE_ENABLE
		whitelist_slots = $WHITELIST_SLOTS
		lan_only_cluster = $LAN_ONLY

		[MISC]
		console_enabled = $CONSOLE_ENABLE
		max_snapshots = $MAX_SNAPSHOTS

		[SHARD]
		shard_enabled = $SHARD_ENABLE
		bind_ip = $SHARD_BIND_IP
		master_ip = $SHARD_MASTER_IP
		master_port = $SHARD_MASTER_PORT
		cluster_key = $SHARD_CLUSTER_KEY

		[STEAM]
		steam_group_id = $STEAM_GROUP_ID
		steam_group_only = $STEAM_GROUP_ONLY
		steam_group_admins = $STEAM_GROUP_ADMINS
	EOF
	chown $STEAM_USER:$STEAM_USER $file_cluster
fi

if [[ ! -f $file_server ]]; then
	cat <<- EOF > $file_server
		[NETWORK]
		server_port = $SERVER_PORT

		[STEAM]
		master_server_port = $STEAM_MASTER_SERVER_PORT
		authentication_port = $STEAM_AUTHENTICATION_PORT

		[SHARD]
		is_master = $SHARD_IS_MASTER
		name = $SHARD_NAME
	EOF

	if [[ -n "$SHARD_ID" ]]; then
		echo "id = $SHARD_ID" >> $file_server
	fi

	chown $STEAM_USER:$STEAM_USER $file_server
fi
