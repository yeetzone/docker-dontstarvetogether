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
container_id=`docker run -e MODS=492173795 -d $1 || exit 1`
sleep 20 # We need to wait for the server to start
docker cp $container_id:/var/lib/dsta/config/log.txt $log_txt || exit 1
if grep -Fq "Failed to create mod folder [../mods/" $log_txt
then
  exit 1
fi
