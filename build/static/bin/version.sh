#!/usr/bin/env bash

usage() {
	cat "$DSTA_HOME/doc/version.usage"
}

local_version() {
	cat "$DST_HOME/steamapps/appmanifest_343050.acf" | clean_version
}

upstream_version() {
	rm -rf "$STEAM_HOME/Steam/appcache/*"
	steamcmd +login anonymous +app_info_update 1 +app_info_print 343050 +quit | clean_version
}

clean_version() {
	grep -Po -m 1 "\"buildid\"\s*\"(.*)\"" | grep -Po "\d*"
}

if [[ "$1" = "--help" ]]; then
	usage
	exit 0
elif [[ $# -eq 0 ]]; then
	echo "Local version:    $(local_version)"
	echo "Upstream version: $(upstream_version)"
	exit 0
elif [[ $# -eq 1 ]]; then
	case "$1" in
		--local)
			local_version
			exit 0
			;;

		--upstream)
			upstream_version
			exit 0
			;;

		--check)
			version_local=$(local_version)
			version_upstream=$(upstream_version)

			if [[ "$version_local" -eq "$version_upstream" ]]; then
				echo "Version is up to date."
				exit 0
			else
				echo "Version is outdated."
				exit 1
			fi
			;;
	esac
fi

usage 1>&2
exit 1
