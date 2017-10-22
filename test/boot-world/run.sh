#!/usr/bin/env bash

clean() {
	rm -f $aux $file1 $file2 $foo $foo2
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
	docker volume rm $volume >/dev/null 2>/dev/null || exit 0
}
trap clean EXIT

volume="boot-world"
aux=`mktemp`
file1=`mktemp`
file2=`mktemp`
foo=`mktemp`
foo2=`mktemp`

echo "foo" > $file1
cat <<- EOF > $file2
return {
  id = "bar",
  location = "forest",
  name="",
  desc="",
  overrides={},
}
EOF
printf "foo\n" >$foo
printf "foo2\n" >$foo2

container_id=`docker run -d -e LEVELDATA_OVERRIDES="foo" $1 dst-server start --update=none || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
diff $file1 $aux || exit 1
docker rm -fv $container_id > /dev/null

container_id=`docker run -d $1 dst-server start --update=none || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux 2> /dev/null && exit 1
docker rm -fv $container_id > /dev/null

test_world_with_keep(){
	docker_image=$1
  variable=$2
	keep_flag=$3

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo" $docker_image dst-server start --update=none || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null
	docker volume rm $volume > /dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo2" $docker_image dst-server start --update=none --keep-configuration=$keep_flag || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
	diff $foo2 $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster $docker_image dst-server start --update=none --keep-configuration=$keep_flag || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
	diff $foo2 $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo" $docker_image dst-server start --update=none || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo2" $docker_image dst-server start --update=none --keep-configuration=$keep_flag || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux || exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster $docker_image dst-server start --update=none || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/shard/leveldataoverride.lua $aux 2>/dev/null && exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null
	docker volume rm $volume > /dev/null
}

test_world_with_keep $1 LEVELDATA_OVERRIDES world
