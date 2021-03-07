#!/usr/bin/env bash

file="$STORAGE_PATH"/$CLUSTER_NAME/cluster_token.txt

if [[ -n "$TOKEN" ]] && [[ ! -f "$file" ]]; then
	echo "$TOKEN" > "$file"
fi
