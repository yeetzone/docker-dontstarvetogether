#!/usr/bin/env bash

clean() {
	rm -f $aux $adminlist $whitelist $blocklist $foo $foo2
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id >/dev/null
	fi
	docker volume rm $volume >/dev/null 2>/dev/null || exit 0
}
trap clean EXIT

volume="boot-lists"
aux=`mktemp`
adminlist=`mktemp`
whitelist=`mktemp`
blocklist=`mktemp`
foo=`mktemp`
foo2=`mktemp`

printf "foo\nbar\nxy_:z\n" >$adminlist
printf "foo\n" >$whitelist
printf "foo\nbar\n" >$blocklist
printf "foo\n" >$foo
printf "foo2\n" >$foo2

container_id=`docker run -d -e ADMINLIST="foo,bar,xy_:z" -e WHITELIST="foo" -e BLOCKLIST="foo,bar" $1 dst-server start --update=none || exit 1`
sleep 20
docker cp $container_id:/var/lib/dsta/cluster/adminlist.txt $aux || exit 1
diff $adminlist $aux || exit 1
docker cp $container_id:/var/lib/dsta/cluster/whitelist.txt $aux || exit 1
diff $whitelist $aux || exit 1
docker cp $container_id:/var/lib/dsta/cluster/blocklist.txt $aux || exit 1
diff $blocklist $aux || exit 1
docker cp $container_id:/var/lib/dsta/cluster/shard/server_log.txt $aux || exit 1
cat $aux | grep "adminlist.txt" | grep -qF "(Success)" || exit 1
cat $aux | grep "whitelist.txt" | grep -qF "(Success)" || exit 1
cat $aux | grep "blocklist.txt" | grep -qF "(Success)" || exit 1
docker rm -fv $container_id >/dev/null

container_id=`docker run -d -e BLOCKLIST="foo,bar" $1 dst-server start --update=none || exit 1`
sleep 2
docker cp $container_id:/var/lib/dsta/cluster/adminlist.txt $aux 2>/dev/null && exit 1
docker cp $container_id:/var/lib/dsta/cluster/whitelist.txt $aux 2>/dev/null && exit 1
docker cp $container_id:/var/lib/dsta/cluster/blocklist.txt $aux || exit 1
diff $blocklist $aux || exit 1
docker rm -fv $container_id >/dev/null

test_lists_with_keep(){
	docker_image=$1
  variable=$2
	keep_flag=$3
	file_name=$3

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo" $docker_image dst-server start --update=none || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/$file_name.txt $aux || exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null
	docker volume rm $volume > /dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo2" $docker_image dst-server start --update=none --keep-configuration=$keep_flag || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/$file_name.txt $aux || exit 1
	diff $foo2 $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster $docker_image dst-server start --update=none --keep-configuration=$keep_flag || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/$file_name.txt $aux || exit 1
	diff $foo2 $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo" $docker_image dst-server start --update=none || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/$file_name.txt $aux || exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster -e $variable="foo2" $docker_image dst-server start --update=none --keep-configuration=$keep_flag || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/$file_name.txt $aux || exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null

	container_id=`docker run -d -v $volume:/var/lib/dsta/cluster $docker_image dst-server start --update=none || exit 1`
	sleep 2
	docker cp $container_id:/var/lib/dsta/cluster/$file_name.txt $aux 2>/dev/null && exit 1
	diff $foo $aux || exit 1
	docker rm -fv $container_id >/dev/null
	docker volume rm $volume > /dev/null
}

test_lists_with_keep $1 ADMINLIST adminlist
test_lists_with_keep $1 WHITELIST whitelist
test_lists_with_keep $1 BLOCKLIST blocklist
