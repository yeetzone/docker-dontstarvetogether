#!/usr/bin/env bash

gosu steam steamcmd \
  +@ShutdownOnFailedCommand 1 \
  +login anonymous \
  +force_install_dir /opt/steam/DoNotStarveTogether \
  +app_update 343050 validate \
  +quit
