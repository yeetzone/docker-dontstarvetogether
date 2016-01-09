#!/usr/bin/env bash

clean() {
  rm -f $log_txt
  if [ -n "$container_id" ]
  then
    docker rm -fv $container_id > /dev/null
  fi
}
trap clean EXIT

log_txt=`mktemp`
container_id=`docker run -e MODS=492173795 -e UPDATE_ON_BOOT=false -d $1 || exit 1`
sleep 30 # We need to wait for the server to start
docker cp $container_id:/home/steam/dst/log.txt $log_txt
if grep -Fq "Failed to create mod folder [../mods/" $log_txt
then
  exit 1
fi
