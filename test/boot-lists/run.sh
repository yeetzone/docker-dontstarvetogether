#!/usr/bin/env bash

clean() {
	rm -f $aux $adminlist $whitelist $blocklist
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
}
trap clean EXIT

aux=`mktemp`
adminlist=`mktemp`
whitelist=`mktemp`
blocklist=`mktemp`

printf "foo\nbar\nxy_:z\n" > $adminlist
printf "foo\n" > $whitelist
printf "foo\nbar\n" > $blocklist

container_id=`docker run -d -e ADMINLIST="foo,bar,xy_:z" -e WHITELIST="foo" -e BLOCKLIST="foo,bar" $1 || exit 1`
sleep 5
docker cp $container_id:/var/lib/dsta/config/save/adminlist.txt $aux || exit 1
diff $adminlist $aux || exit 1
docker cp $container_id:/var/lib/dsta/config/save/whitelist.txt $aux || exit 1
diff $whitelist $aux || exit 1
docker cp $container_id:/var/lib/dsta/config/save/blocklist.txt $aux || exit 1
diff $blocklist $aux || exit 1
docker rm -fv $container_id > /dev/null

container_id=`docker run -d -e BLOCKLIST="foo,bar" $1 || exit 1`
sleep 5
docker cp $container_id:/var/lib/dsta/config/save/adminlist.txt $aux 2> /dev/null && exit 1
docker cp $container_id:/var/lib/dsta/config/save/whitelist.txt $aux 2> /dev/null && exit 1
docker cp $container_id:/var/lib/dsta/config/save/blocklist.txt $aux || exit 1
diff $blocklist $aux || exit 1
docker rm -fv $container_id > /dev/null
