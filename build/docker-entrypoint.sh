#!/usr/bin/env bash

if [ $1 == "dst-server" ]; then
	set -e

	# Configure the server
	mkdir -p $CLUSTER_PATH/$SHARD_NAME
	chown -R $STEAM_USER:$STEAM_USER $CLUSTER_PATH

	if [ "$2" == "start" ]; then
		$DSTA_HOME/boot/token.sh
		$DSTA_HOME/boot/settings.sh
		$DSTA_HOME/boot/lists.sh
		$DSTA_HOME/boot/world.sh
		$DSTA_HOME/boot/mods.sh
	fi
fi

exec "$@"
