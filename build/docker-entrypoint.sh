#!/usr/bin/env bash

if [ $1 == "dst-server" ]; then
	set -e

	# Configure the server
	chown steam:steam $CONFIG_PATH

	$DSTA_HOME/boot/settings.sh
	$DSTA_HOME/boot/lists.sh
	$DSTA_HOME/boot/world.sh
	$DSTA_HOME/boot/mods.sh
fi

exec "$@"
