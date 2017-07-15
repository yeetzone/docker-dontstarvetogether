#!/usr/bin/env bash

clean() {
	rm -f $file1
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
}
trap clean EXIT

file1=`mktemp`

container_id=`docker run -d $1 dst-server start --update=none || exit 1`
docker cp console/commands.sh $container_id:/
docker exec $container_id /commands.sh || exit 1
sleep 20
docker cp $container_id:/var/lib/dsta/cluster/shard/server_log.txt $file1
grep -Fq "RemoteCommandInput: \"foo\"" $file1 || exit 1
grep -Fq "RemoteCommandInput: \"bar\"" $file1 || exit 1
docker rm -fv $container_id > /dev/null
