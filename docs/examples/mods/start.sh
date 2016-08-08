#!/usr/bin/env bash

export MODS_OVERRIDES=$(< modoverrides.lua)
docker-compose up -d
