#!/usr/bin/env bash

clean() {
	rm -f $file1 $file2
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
}
trap clean EXIT

file1=`mktemp`
file2=`mktemp`

container_id=`docker run -d $1 dst-server start || exit 1`
sleep 20
if [ -z "`docker ps -qf id=$container_id`" ]; then
	exit 1
fi
docker rm -fv $container_id > /dev/null

container_id=`docker run -d $1 dst-server start --update=all || exit 1`
sleep 20
if [ -z "`docker ps -qf id=$container_id`" ]; then
	exit 1
fi
docker rm -fv $container_id > /dev/null

container_id=`docker run -d $1 dst-server start --update=none || exit 1`
sleep 20
if [ -z "`docker ps -qf id=$container_id`" ]; then
	exit 1
fi
docker rm -fv $container_id > /dev/null

container_id=`docker run -d $1 dst-server start --update=game || exit 1`
sleep 20
if [ -z "`docker ps -qf id=$container_id`" ]; then
	exit 1
fi
docker rm -fv $container_id > /dev/null

container_id=`docker run -d $1 dst-server start --update=mods || exit 1`
sleep 20
if [ -z "`docker ps -qf id=$container_id`" ]; then
	exit 1
fi
docker rm -fv $container_id > /dev/null

# Errors
cat > $file1 <<- EOF
usage: dst-server start [--update=all|none|game|mods]

   --update=all
      Update the game and the mods before launch the server.
   --update=none
      Update nothing, just start the server.
   --update=game
      Update just the game (no the mods) and launch the server.
   --update=mods
      Update the mods and launch the server. This is the default behaviour.
EOF
docker run --rm $1 dst-server start foo >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server start --update=foo >/dev/null  2> $file2 && exit 1
diff $file1 $file2 || exit 1
