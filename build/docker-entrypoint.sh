#!/usr/bin/env bash

# Exit immediately on non-zero return codes.
set -e

# Run start command if only options given.
if [[ "${1:0:1}" = '-' ]]; then
	set -- dst-server start "$@"
fi

# Run boot scripts before starting the server.
if [[ "$1" = 'dst-server' ]]; then

	# Prepare the shard directory.
	mkdir -p "$CLUSTER_PATH/$SHARD_NAME"
	chown -R "$STEAM_USER":"$STEAM_USER" "$CLUSTER_PATH"

	# Run via steam user if the command is `dst-server`.
	set -- gosu "$STEAM_USER" "$@"
fi

# Execute the command.
exec "$@"
