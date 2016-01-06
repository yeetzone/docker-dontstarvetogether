#!/bin/sh

gosu steam /var/lib/steam/steamcmd/steamcmd.sh \
	+@ShutdownOnFailedCommand 1 \
	+login anonymous \
	+force_install_dir /var/lib/steam/DoNotStarveTogether \
	+app_update 343050 validate \
	+quit \
