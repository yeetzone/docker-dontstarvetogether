#!/usr/bin/env bash

usage(){
	cat $DSTA_HOME/doc/start.usage
}

if [ $# -eq 0 ]; then
	update=0
elif [ $1 == "--help" ]; then
	usage
	exit 0
elif [ $# -eq 1 ]; then
	case $1 in
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
	esac
fi

if [ -z "$update" ]; then
	usage 1>&2
	exit 1
fi

if (((update & 1) != 0)); then
	$DSTA_HOME/dst/update.sh
fi

if (((update & 2) == 0)); then
	flag="-skip_update_server_mods"
fi

$DSTA_HOME/boot/token.sh
$DSTA_HOME/boot/settings.sh
$DSTA_HOME/boot/lists.sh
$DSTA_HOME/boot/world.sh
$DSTA_HOME/boot/mods.sh

exec dontstarve_dedicated_server_nullrenderer $flag
