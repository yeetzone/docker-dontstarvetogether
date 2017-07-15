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
sleep 20
docker stop $container_id >/dev/null || exit 1
docker cp $container_id:/var/lib/dsta/cluster/shard/server_log.txt $file1
docker rm -fv $container_id > /dev/null
grep -q "Shutting down$" $file1 || exit 1

# Dirty console
container_id=`docker run -d $1 dst-server start --update=none || exit 1`
sleep 20
docker cp close-cleanly/commands.sh $container_id:/
docker exec $container_id /commands.sh || exit 1
docker stop $container_id >/dev/null || exit 1
docker cp $container_id:/var/lib/dsta/cluster/shard/server_log.txt $file1
docker rm -fv $container_id > /dev/null
grep -q "Shutting down$" $file1 || exit 1

# TERM
container_id=`docker run -d $1 dst-server start --update=none || exit 1`
sleep 20
docker exec $container_id bash -c "kill 1"
timeout --kill-after 1 12 docker wait $container_id > $file1
grep -q "^0$" $file1 || exit 1
docker cp $container_id:/var/lib/dsta/cluster/shard/server_log.txt $file1
docker rm -fv $container_id > /dev/null
grep -q "Shutting down$" $file1 || exit 1

# INT
container_id=`docker run -d $1 dst-server start --update=none || exit 1`
sleep 20
docker exec $container_id bash -c "kill -SIGINT 1"
timeout --kill-after 1 12 docker wait $container_id > $file1
grep -q "^0$" $file1 || exit 1
docker cp $container_id:/var/lib/dsta/cluster/shard/server_log.txt $file1
docker rm -fv $container_id > /dev/null
grep -q "Shutting down$" $file1 || exit 1
