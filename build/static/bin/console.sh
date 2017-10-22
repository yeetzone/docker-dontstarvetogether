#!/usr/bin/env bash

usage() {
	cat "$DSTA_HOME/doc/console.usage"
}

if [[ "$1" = "--help" ]]; then
	usage
	exit 0
elif [[ $# -eq 0 ]]; then
	cat < /proc/self/fd/0 > "$DSTA_HOME/console"
else
	for command in "$@"; do
		if [[ "$command" = "-" ]]; then
			cat < /proc/self/fd/0 > "$DSTA_HOME/console"
		else
			echo "$command" > "$DSTA_HOME/console"
		fi
	done
fi
