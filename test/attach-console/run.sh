#!/usr/bin/env bash

clean() {
	rm -f $file1
	if [ -n "$container_id" ] && [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id >/dev/null
	fi
}
trap clean EXIT

file1=`mktemp`

timeout --kill-after 1 20 docker run -i --rm $1 dst-server start --update=none >/dev/null <<-EOF
	c_shutdown(true)
EOF

if [[ $? -ne 0 ]]; then
	exit 1
fi

container_id=`docker run -id $1 dst-server start --update=none || exit 1`
docker attach $container_id <<-EOF
	c_shutdown(true)
EOF
timeout --kill-after 1 20 docker wait $container_id >/dev/null || exit 1
docker cp $container_id:/var/lib/dsta/cluster/shard/server_log.txt $file1
docker rm -fv $container_id >/dev/null

grep -Fq "RemoteCommandInput: \"c_shutdown(true)\"" $file1 || exit 1
