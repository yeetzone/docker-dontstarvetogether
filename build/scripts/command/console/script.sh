#!/usr/bin/env bash

if [[ "$1" = "--help" ]]; then
	cat "$STEAM_HOME/scripts/command/console/help.txt"
	exit 0
elif [[ $# -eq 0 ]]; then
	cat < /proc/self/fd/0 > "$STEAM_HOME/console"
else
	for command in "$@"; do
		if [[ "$command" = "-" ]]; then
			cat < /proc/self/fd/0 > "$STEAM_HOME/console"
		else
			echo "$command" > "$STEAM_HOME/console"
		fi
	done
fi
