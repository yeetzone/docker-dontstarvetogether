#!/usr/bin/env bash

# Exit immediately on non-zero return codes.
set -e

# Run boot scripts before starting the server.
if [ $1 = 'dst-server' ]; then

	# Prepare the shard directory.
	mkdir -p $CLUSTER_PATH/$SHARD_NAME
	chown -R $STEAM_USER:$STEAM_USER $CLUSTER_PATH

	# Create configuration files.
	if [ "$2" = 'start' ]; then
		$DSTA_HOME/boot/token.sh
		$DSTA_HOME/boot/settings.sh
		$DSTA_HOME/boot/lists.sh
		$DSTA_HOME/boot/world.sh
		$DSTA_HOME/boot/mods.sh
	fi

	# Run as user `steam` if the command is `dst-server`.
	set -- gosu steam "$@"
fi

# Execute the command.
exec "$@"
