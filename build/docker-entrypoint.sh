#!/usr/bin/env bash

if [ $1 == "dst-server" ]; then
  set -e

  # Configure the server
  storage_path="/var/lib/dsta"
  config_dir="config"
  config_path="$storage_path/$config_dir"
  dsta_home="/usr/local/lib/dsta"

  chown steam:steam $config_path

  $dsta_home/boot/settings.sh $config_path
  $dsta_home/boot/lists.sh $config_path
  $dsta_home/boot/world.sh $config_path
  $dsta_home/boot/mods.sh $config_path
fi

exec "$@"
