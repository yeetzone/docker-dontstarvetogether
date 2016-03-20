#!/usr/bin/env bash

file_token="$CLUSTER_PATH/cluster_token.txt"

if [[ -n "$TOKEN" ]] && [[ ! -f "$file_token" ]]; then
	echo "$TOKEN" > $file_token

	chown $STEAM_USER:$STEAM_USER $file_token
fi
