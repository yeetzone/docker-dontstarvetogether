#!/usr/bin/env bash

if [[ "$1" = "--help" ]]; then
	cat "$STEAM_HOME/scripts/command/update/help.txt"
	exit 0
elif [[ $# -eq 0 ]]; then
	exec steamcmd \
		+@ShutdownOnFailedCommand 1 \
		+login anonymous \
		+force_install_dir "$STEAM_PATH" \
		+app_update "$STEAM_APP" \
			$([ -n "$STEAM_BRANCH" ] && printf %s "-beta $STEAM_BRANCH") \
			$([ -n "$STEAM_PASSWORD" ] && printf %s "-betapassword $STEAM_PASSWORD") \
			validate \
		+quit
fi
