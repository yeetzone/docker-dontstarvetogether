#!/usr/bin/env bash

source "$(dirname "$0")/functions.sh"

create_list() {
	list=$1
	file=$2
	must_keep=$3

	if [[ -f $file ]] && [[ "$must_keep" = "0" ]]; then
		return
	fi

	rm -f "$file"

	if [[ -n "$list" ]]; then
		echo "$list" | tr , '\n' >"$file"
		chown "$STEAM_USER":"$STEAM_USER" "$file"
	fi
}

# Create the adminlist.txt file.
create_list "$ADMINLIST" "$CLUSTER_PATH/adminlist.txt" "$(containsElement adminlist "$@" && echo 0 || echo 1)"

# Create the whitelist.txt file.
create_list "$WHITELIST" "$CLUSTER_PATH/whitelist.txt" "$(containsElement whitelist "$@" && echo 0 || echo 1)"

# Create the blocklist.txt file.
create_list "$BLOCKLIST" "$CLUSTER_PATH/blocklist.txt" "$(containsElement blocklist "$@" && echo 0 || echo 1)"
