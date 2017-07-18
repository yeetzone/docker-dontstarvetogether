#!/usr/bin/env bash

clean() {
	rm -f $aux $token1 $token2
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id >/dev/null
	fi
	docker volume rm $volume >/dev/null 2>/dev/null || exit 0
}
trap clean EXIT

volume="boot-token"
aux=`mktemp`
token1=`mktemp`
token2=`mktemp`

printf "token-1" > $token1
printf "token-2" > $token2

container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e TOKEN="token-1" $1 dst-server start --update=none || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/cluster_token.txt $aux || exit 1
diff $token1 $aux || exit 1
docker rm -fv $container_id > /dev/null
docker volume rm $volume > /dev/null

container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e TOKEN="token-2" $1 dst-server start --update=none --keep-configuration=token || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/cluster_token.txt $aux || exit 1
diff $token2 $aux || exit 1
docker rm -fv $container_id > /dev/null

container_id=`docker run -d -v $volume:/var/lib/dsta/cluster $1 dst-server start --update=none --keep-configuration=token,whitelist || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/cluster_token.txt $aux || exit 1
diff $token2 $aux || exit 1
docker rm -fv $container_id > /dev/null # No remove volume

container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e TOKEN="token-1" $1 dst-server start --update=none --keep-configuration=whitelist || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/cluster_token.txt $aux || exit 1
diff $token1 $aux || exit 1
docker rm -fv $container_id > /dev/null # No remove volume

container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e TOKEN="token-3" $1 dst-server start --update=none --keep-configuration=token,whitelist || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/cluster_token.txt $aux || exit 1
diff $token1 $aux || exit 1
docker rm -fv $container_id > /dev/null

container_id=`docker run -d -v $volume:/var/lib/dsta/cluster $1 dst-server start --update=none || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/cluster_token.txt 2>/dev/null $aux && exit 1
docker rm -fv $container_id > /dev/null
docker volume rm $volume > /dev/null
