#!/usr/bin/env bash

clean() {
	rm -f $file1 $file2
	if [ -n "`docker ps -qf name=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
}
trap clean EXIT

container_id=`uuidgen`
file1=`mktemp`
file2=`mktemp`

docker run --name "$container_id" $1 dst-server start > $file2 &
sleep 40
if [ -z "`docker ps -qf name=$container_id`" ]; then
	exit 1
fi
grep -Fq "Success! App '343050' already up to date." $file2 && exit 1
grep -Fq "DownloadMods" $file2 && exit 1
docker rm -fv $container_id > /dev/null

docker run --name "$container_id" $1 dst-server start --update=all > $file2 &
sleep 40
if [ -z "`docker ps -qf name=$container_id`" ]; then
	exit 1
fi
grep -Fq "Success! App '343050' already up to date." $file2 || exit 1
grep -Fq "DownloadMods" $file2 || exit 1
docker rm -fv $container_id > /dev/null

docker run --name "$container_id" $1 dst-server start --update=none > $file2 &
sleep 20
if [ -z "`docker ps -qf name=$container_id`" ]; then
	exit 1
fi
grep -Fq "Success! App '343050' already up to date." $file2 && exit 1
grep -Fq "DownloadMods" $file2 && exit 1
docker rm -fv $container_id > /dev/null

docker run --name "$container_id" $1 dst-server start --update=game > $file2 &
sleep 40
if [ -z "`docker ps -qf name=$container_id`" ]; then
	exit 1
fi
grep -Fq "Success! App '343050' already up to date." $file2 || exit 1
grep -Fq "DownloadMods" $file2 && exit 1
docker rm -fv $container_id > /dev/null

docker run --name "$container_id" $1 dst-server start --update=mods > $file2 &
sleep 20
if [ -z "`docker ps -qf name=$container_id`" ]; then
	exit 1
fi
grep -Fq "Success! App '343050' already up to date." $file2 && exit 1
grep -Fq "DownloadMods" $file2 || exit 1
docker rm -fv $container_id > /dev/null

# Errors
cat > $file1 <<- EOF
usage: dst-server start [--update=all|none|game|mods]
                        [--keep-configuration=<value[,otherValue>]...>]

   --update=none
      Update nothing, just start the server. This is the default behaviour.
   --update=all
      Update the game and the mods before launch the server.
   --update=game
      Update just the game (no the mods) and launch the server.
   --update=mods
      Update the mods and launch the server.
   --keep-configuration
      Select which configuration you don't want to overwrite.
      You must provide one or more of these values separated by commas:
      - token
      - cluster
      - server
      - world
      - adminlist
      - blocklist
      - whitelist
      - mods
EOF
docker run --rm $1 dst-server start foo >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server start --update=foo >/dev/null  2> $file2 && exit 1
diff $file1 $file2 || exit 1
