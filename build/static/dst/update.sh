#!/usr/bin/env bash

exec steamcmd \
	+@ShutdownOnFailedCommand 1 \
	+login anonymous \
	+force_install_dir "$DST_HOME" \
	+app_update 343050 \
		"$([ -n "$DST_BRANCH" ] && printf %s "-beta $DST_BRANCH")" \
		"$([ -n "$DST_BRANCH_PASSWORD" ] && printf %s "-betapassword $DST_BRANCH_PASSWORD")" \
	+quit
