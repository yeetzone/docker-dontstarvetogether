#!/usr/bin/env bash

usage() {
	cat "$DSTA_HOME/doc/update.usage"
}

if [[ $# -eq 0 ]]; then
	update=3
elif [[ "$1" = "--help" ]]; then
	usage
	exit 0
elif [[ $# -eq 1 ]]; then
	case "$1" in
		--all)
			update=3
			;;
		--game)
			update=1
			;;
		--mods)
			update=2
			;;
	esac
fi

if [[ -z "$update" ]]; then
	usage 1>&2
	exit 1
fi

if (((update & 1) != 0)); then
	"$DSTA_HOME/dst/update.sh"
fi

if (((update & 2) != 0)); then
	dontstarve_dedicated_server_nullrenderer -only_update_server_mods
fi
