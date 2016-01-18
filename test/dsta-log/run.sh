#!/usr/bin/env bash

clean() {
  rm -f $log_txt $log_chat_txt $aux
  if [ -n "$container_id" ];  then
    docker rm -fv $container_id > /dev/null
  fi
}
trap clean EXIT

log_txt=`mktemp`
uuidgen > $log_txt
log_chat_txt=`mktemp`
uuidgen > $log_chat_txt
aux=`mktemp`
container_id=`docker run -d $1 sleep infinity || exit 1`
docker cp $log_txt $container_id:/var/lib/dsta/config/log.txt
docker cp $log_chat_txt $container_id:/var/lib/dsta/config/log_chat.txt
docker exec $container_id dst-server log > $aux
cmp --silent $log_txt $aux || exit 1
docker exec $container_id dst-server log --server > $aux
cmp --silent $log_txt $aux || exit 1
docker exec $container_id dst-server log --chat > $aux
cmp --silent $log_chat_txt $aux || exit 1

cat > $log_txt <<- EOF
usage: dst-server log [--server|--chat]
EOF
docker exec $container_id dst-server log --server --chat 2> $aux && exit 1
cmp --silent $log_txt $aux || exit 1
docker exec $container_id dst-server log --type 2> $aux && exit 1
cmp --silent $log_txt $aux || exit 1
docker exec $container_id dst-server log asd 2> $aux && exit 1
cmp --silent $log_txt $aux || exit 1
docker exec $container_id dst-server log --type=chat 2> $aux && exit 1
cmp --silent $log_txt $aux || exit 1
