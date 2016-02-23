#!/usr/bin/env bash

clean() {
	rm -f $log_txt $log_chat_txt $aux $aux1
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
}
trap clean EXIT

log_txt=`mktemp`
uuidgen > $log_txt
log_chat_txt=`mktemp`
uuidgen > $log_chat_txt
aux=`mktemp`
aux1=`mktemp`

container_id=`docker run -d $1 sleep infinity || exit 1`
docker exec $container_id mkdir /var/lib/dsta/cluster/shard
docker exec $container_id chown steam:steam /var/lib/dsta/cluster/shard
docker cp $log_txt $container_id:/var/lib/dsta/cluster/shard/server_log.txt
docker cp $log_chat_txt $container_id:/var/lib/dsta/cluster/shard/server_log_chat.txt
docker exec $container_id dst-server log > $aux
diff $log_txt $aux || exit 1
docker exec $container_id dst-server log --server > $aux
diff $log_txt $aux || exit 1
docker exec $container_id dst-server log --chat > $aux
diff $log_chat_txt $aux || exit 1

cat > $log_txt <<- EOF
usage: dst-server log [--server|--chat]
EOF
docker exec $container_id dst-server log --server --chat 2> $aux && exit 1
diff $log_txt $aux || exit 1
docker exec $container_id dst-server log --type 2> $aux && exit 1
diff $log_txt $aux || exit 1
docker exec $container_id dst-server log asd 2> $aux && exit 1
diff $log_txt $aux || exit 1
docker exec $container_id dst-server log --type=chat 2> $aux && exit 1
diff $log_txt $aux || exit 1
docker rm -fv $container_id > /dev/null

echo -n "" > $log_txt
docker run --rm -e SERVER_NAME=foo $1 dst-server log > $aux 2> $aux1
diff $log_txt $aux || exit 1
diff $log_txt $aux1 || exit 1
docker run --rm -e SERVER_NAME=foo $1 dst-server log --server > $aux 2> $aux1
diff $log_txt $aux || exit 1
diff $log_txt $aux1 || exit 1
docker run --rm -e SERVER_NAME=foo $1 dst-server log --chat > $aux 2> $aux1
diff $log_txt $aux || exit 1
diff $log_txt $aux1 || exit 1
