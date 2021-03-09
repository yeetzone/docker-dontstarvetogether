#!/usr/bin/env bash

if [[ "$1" = "--help" ]]; then
	cat "$STEAM_HOME/scripts/command/start/help.txt"
	exit 0
elif [[ $# -eq 0 ]]; then
  sleep infinity > "$STEAM_HOME/console" &

  exec dontstarve_dedicated_server_nullrenderer \
	  -persistent_storage_root "$(dirname "$STORAGE_PATH")" \
	  -conf_dir "$(basename "$STORAGE_PATH")" \
	  -cluster "$CLUSTER_NAME" \
	  -shard "$SHARD_NAME" \
	  -backup_log_count "$BACKUP_LOG_COUNT"
fi
