#!/usr/bin/env bash

clean() {
	rm -f $aux $file1 $file2
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
}
trap clean EXIT

aux=`mktemp`
file1=`mktemp`
file2=`mktemp`

echo "foo" > $file1
cat <<- EOF > $file2
return {
  id = "bar",
  version = 3,
}
EOF

container_id=`docker run -d -e LEVELDATA_OVERRIDES="foo" $1 dst-server start --update=none || exit 1`
sleep 5
docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
diff $file1 $aux || exit 1
docker rm -fv $container_id > /dev/null

container_id=`docker run -d -e LEVELDATA_OVERRIDES="foo" -e WORLD_PRESET="bar" $1 dst-server start --update=none || exit 1`
sleep 5
docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
diff $file1 $aux || exit 1
docker rm -fv $container_id > /dev/null

container_id=`docker run -d -e WORLD_PRESET="bar" $1 dst-server start --update=none || exit 1`
sleep 5
docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
diff $file2 $aux || exit 1
docker rm -fv $container_id > /dev/null

container_id=`docker run -d $1 dst-server start --update=none || exit 1`
sleep 5
docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux 2> /dev/null && exit 1
docker rm -fv $container_id > /dev/null
