#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file_cluster="$CLUSTER_PATH/cluster.ini"
file_server="$CLUSTER_PATH/$SHARD_NAME/server.ini"

validate_option "LANGUAGE" \
	brazilian bulgarian czech danish dutch english finnish french german \
	greek hungarian italian japanese korean norwegian polish portuguese \
	romanian russian schinese spanish swedish tchinese thai turkish ukrainian
validate_port "SERVER_PORT"
validate_bool "OFFLINE_ENABLE"
validate_int "MAX_PLAYERS" 1 64
validate_int "WHITELIST_SLOTS" 0 64
validate_bool "PVP_ENABLE"
validate_option "GAME_MODE" endless survival wilderness
validate_option "INTENTION" cooperative social competitive madness
validate_bool "AUTOSAVER_ENABLE"
validate_option "TICK_RATE" 15 20 30 60
validate_bool "VOTE_ENABLE"
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

if [[ -f "$file_cluster" ]] && containsElement "cluster" "$@"; then
	true # no-op
else
	if [[ -z "$NAME" ]]; then
		selectRandomLine() {
			mapfile list < "$1"
			echo "${list[$RANDOM % ${#list[@]}]}"
		}

		NAME="$(selectRandomLine "$DSTA_HOME"/data/adjectives.txt) $(selectRandomLine "$DSTA_HOME"/data/names.txt)"
		echo "'$NAME' has been set as the cluster's name."
	fi

	exec 4>&1 1>"$file_cluster"

	echo "[NETWORK]"
	conf "cluster_name" "$NAME_PREFIX $NAME"
	conf "cluster_description" "$DESCRIPTION"
	conf "cluster_intention" "$INTENTION"
	conf "cluster_password" "$PASSWORD"
	conf "autosaver_enabled" "$AUTOSAVER_ENABLE"
	conf "lan_only_cluster" "$LAN_ONLY"
	conf "offline_cluster" "$OFFLINE_ENABLE"
	conf "tick_rate" "$TICK_RATE"
	conf "whitelist_slots" "$WHITELIST_SLOTS"
	conf "enable_vote_kick" "$VOTE_KICK_ENABLE"

	if [[ -n "$GAME_MODE" ]] || [[ -n "$MAX_PLAYERS" ]] || [[ -n "$PVP_ENABLE" ]] || [[ -n "$PAUSE_WHEN_EMPTY" ]] || [[ -n "$VOTE_ENABLE" ]]; then
		echo
		echo "[GAMEPLAY]"
		conf "game_mode" "$GAME_MODE"
		conf "max_players" "$MAX_PLAYERS"
		conf "pvp" "$PVP_ENABLE"
		conf "pause_when_empty" "$PAUSE_WHEN_EMPTY"
		conf "vote_enabled" "$VOTE_ENABLE"
	fi

	if [[ -n "$CONSOLE_ENABLE" ]] || [[ -n "$MAX_SNAPSHOTS" ]] || [[ -n "$LANGUAGE" ]]; then
		echo
		echo "[MISC]"
		conf "console_enabled" "$CONSOLE_ENABLE"
		conf "max_snapshots" "$MAX_SNAPSHOTS"
		conf "language_code" "$LANGUAGE"
	fi

	if [[ -n "$SHARD_ENABLE" ]]; then
		echo
		echo "[SHARD]"
		conf "shard_enabled" "$SHARD_ENABLE"
	fi

	if [[ -n "$STEAM_GROUP_ID" ]] || [[ -n "$STEAM_GROUP_ONLY" ]] || [[ -n "$STEAM_GROUP_ADMINS" ]]; then
		echo
		echo "[STEAM]"
		conf "steam_group_id" "$STEAM_GROUP_ID"
		conf "steam_group_only" "$STEAM_GROUP_ONLY"
		conf "steam_group_admins" "$STEAM_GROUP_ADMINS"
	fi

	exec 1>&4 4>&-

	chown "$STEAM_USER":"$STEAM_USER" "$file_cluster"
fi

if [[ -f "$file_server" ]] && containsElement "server" "$@"; then
	true # no-op
else
	exec 4>&1 1>"$file_server"

	echo "[NETWORK]"
	conf "server_port" "$SERVER_PORT"

	if [[ -n "$SHARD_ENABLE" ]]; then
		echo
		echo "[SHARD]"
		conf "is_master" "$SHARD_IS_MASTER"
		conf "bind_ip" "$SHARD_BIND_IP"
		conf "master_ip" "$SHARD_MASTER_IP"
		conf "master_port" "$SHARD_MASTER_PORT"
		conf "cluster_key" "$SHARD_CLUSTER_KEY"
		conf "name" "$SHARD_NAME"
		conf "id" "$SHARD_ID"
	fi

	if [[ -n "$STEAM_MASTER_SERVER_PORT" ]] || [[ -n "$STEAM_AUTHENTICATION_PORT" ]]; then
		echo
		echo "[STEAM]"
		conf "master_server_port" "$STEAM_MASTER_SERVER_PORT"
		conf "authentication_port" "$STEAM_AUTHENTICATION_PORT"
	fi

	exec 1>&4 4>&-

	chown "$STEAM_USER":"$STEAM_USER" "$file_server"
fi
