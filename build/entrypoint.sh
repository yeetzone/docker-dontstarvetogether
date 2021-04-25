#!/usr/bin/env bash

set -ex

if [[ "${1:0:1}" = '-' ]]; then
	set -- dontstarvetogether "$@"
fi

if [[ "$1" = 'dontstarvetogether' ]]; then
	mkdir -p "$STORAGE_PATH/$CLUSTER_NAME/$SHARD_NAME"
	chown -R "$STEAM_USER":"$STEAM_USER" "$STORAGE_PATH"
	chown -R "$STEAM_USER":"$STEAM_USER" "$STEAM_PATH"

	gosu "$STEAM_USER" "$STEAM_HOME/scripts/boot/token.sh"
	gosu "$STEAM_USER" "$STEAM_HOME/scripts/boot/settings.sh"
	gosu "$STEAM_USER" "$STEAM_HOME/scripts/boot/lists.sh"
	gosu "$STEAM_USER" "$STEAM_HOME/scripts/boot/world.sh"
	gosu "$STEAM_USER" "$STEAM_HOME/scripts/boot/mods.sh"

	set -- gosu "$STEAM_USER" "$@"
fi

exec "$@"
