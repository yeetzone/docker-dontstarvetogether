#!/usr/bin/env bash

usage() {
	cat "$DSTA_HOME/doc/start.usage"
}

update=0

if [[ $# -eq 0 ]]; then
	true # no-op
elif [[ "$1" = "--help" ]]; then
	usage
	exit 0
else
	while [[ "$#" -gt 0 ]]
	do
		key="$1"
		case "$key" in
			--update=all)
				update=3
				;;
			--update=none)
				update=0
				;;
			--update=game)
				update=1
				;;
			--update=mods)
				update=2
				;;
			--keep-configuration=*)
				keep="${key#*=}"
				keep="${keep//,/ }"
				;;
			*)
				usage 1>&2
				exit 1
				;;
		esac
		shift
	done
fi

if (((update & 1) != 0)); then
	"$DSTA_HOME/dst/update.sh"
fi

if (((update & 2) == 0)); then
	flag="-skip_update_server_mods"
fi

"$DSTA_HOME"/boot/token.sh "$keep"
"$DSTA_HOME"/boot/settings.sh "$keep"
"$DSTA_HOME"/boot/lists.sh "$keep"
"$DSTA_HOME"/boot/world.sh "$keep"
"$DSTA_HOME"/boot/mods.sh "$keep"

exec dontstarve_dedicated_server_nullrenderer "$flag"
