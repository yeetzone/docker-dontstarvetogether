#!/usr/bin/env bash

export LEVELDATA_OVERRIDES=$(< leveldataoverride.lua)
docker-compose up -d
