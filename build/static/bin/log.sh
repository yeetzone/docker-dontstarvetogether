#!/usr/bin/env bash

usage() {
	cat "$DSTA_HOME/doc/log.usage"
}

if [[ $# -eq 0 ]]; then
	log="$CLUSTER_PATH/$SHARD_NAME/server_log.txt"
elif [[ "$1" = "--help" ]]; then
	usage
	exit 0
elif [[ $# -eq 1 ]]; then
	case "$1" in
		--server)
			log="$CLUSTER_PATH/$SHARD_NAME/server_log.txt"
			;;
		--chat)
			log="$CLUSTER_PATH/$SHARD_NAME/server_log_chat.txt"
			;;
	esac
fi

if [[ -n "$log" ]]; then
	if [[ -f "$log" ]]; then
		exec cat "$log"
	fi
else
	usage 1>&2
	exit 1
fi
