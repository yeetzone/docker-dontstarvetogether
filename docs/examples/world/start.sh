#!/usr/bin/env bash

export WORLD_OVERRIDES=$(< worldgenoverride.lua)
docker-compose up -d
