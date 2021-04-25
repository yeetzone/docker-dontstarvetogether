#!/usr/bin/env bash

if [[ "$1" = "--help" ]]; then
	cat "$STEAM_HOME/scripts/command/start/help.txt"
	exit 0
else
	while [[ "$#" -gt 0 ]]
	do
		case "$1" in
			--update)
				dontstarvetogether update
				;;
		esac
		shift
	done
fi

sleep infinity > "$STEAM_HOME/console" &

exec dontstarve_dedicated_server_nullrenderer \
	-skip_update_server_mods \
	-ugc_directory "$STEAM_PATH/ugc_mods/" \
	-persistent_storage_root "$(dirname "$STORAGE_PATH")" \
	-conf_dir "$(basename "$STORAGE_PATH")" \
	-cluster "$CLUSTER_NAME" \
	-shard "$SHARD_NAME" \
	-backup_log_count "$BACKUP_LOG_COUNT"
