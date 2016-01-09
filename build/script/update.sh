#!/usr/bin/env bash

steamcmd \
  +@ShutdownOnFailedCommand 1 \
  +login anonymous \
  +force_install_dir /opt/dst \
  +app_update 343050 validate \
  +quit
