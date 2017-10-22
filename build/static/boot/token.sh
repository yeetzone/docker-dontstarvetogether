#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

file_token="$CLUSTER_PATH/cluster_token.txt"

if [[ -f "$file_token" ]] && containsElement "token" $@; then
	exit 0
fi

if [[ -n "$TOKEN" ]]; then
	printf "$TOKEN" > "$file_token"
	chown "$STEAM_USER":"$STEAM_USER" "$file_token"
else
	rm -f "$file_token"
fi
