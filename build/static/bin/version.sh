#!/usr/bin/env bash

usage(){
	cat $DSTA_HOME/doc/version.usage
}

if [ "$1" == "--help" ]; then
	usage
	exit 0
elif [ $# -eq 1 ]; then
	case $1 in
		--upstream)
			rm -rf $STEAM_HOME/Steam/appcache/*
			steamcmd +login anonymous +app_info_update 1 +app_info_print 343050 +quit | grep -Po -m 1 "\"buildid\"\s*\"(.*)\"" | grep -Po "\d*"
			exit 0
			;;

		--check)
			version_local=$(dst-server version)
			version_upstream=$(dst-server version --upstream)

			if [ "$version_local" -eq "$version_upstream" ]; then
				echo "Version is up to date.";
				exit 0;
			else
				echo "Version is outdated.";
				exit 1;
			fi
			;;
	esac
else
	cat $DST_HOME/steamapps/appmanifest_343050.acf | grep -Po -m 1 "\"buildid\"\s*\"(.*)\"" | grep -Po "\d*"
	exit 0
fi
