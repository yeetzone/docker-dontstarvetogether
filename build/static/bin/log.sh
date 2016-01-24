#!/usr/bin/env bash

usage(){
	cat $DSTA_HOME/doc/log.usage
}

if [ $# -eq 0 ]; then
	log=$CONFIG_PATH/log.txt
elif [ $1 == "--help" ]; then
	usage
	exit 0
elif [ $# -eq 1 ]; then
	case $1 in
		--server)
			log=$CONFIG_PATH/log.txt
			;;
		--chat)
			log=$CONFIG_PATH/log_chat.txt
			;;
	esac
fi

if [ -n "$log" ]; then
	exec cat $log
else
	usage 1>&2
	exit 1
fi