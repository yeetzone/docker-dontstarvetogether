#!/usr/bin/env bash

exec steamcmd \
	+@ShutdownOnFailedCommand 1 \
	+login anonymous \
	+force_install_dir $DST_HOME \
	+app_update 343050 \
	+quit
