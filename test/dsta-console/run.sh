#!/usr/bin/env bash

clean() {
	rm -f $file1
	if [ -n "`docker ps -qf id=$container_id`" ]; then
		docker rm -fv $container_id > /dev/null
	fi
}
trap clean EXIT

file1=`mktemp`

container_id=`docker run -d $1 dst-server start --update=none || exit 1`
docker exec -i $container_id dst-server console < dsta-console/commands1.txt || exit 1
docker exec -i $container_id dst-server console - < dsta-console/commands2.txt || exit 1
docker exec -i $container_id dst-server console "asdf" || exit 1
docker exec -i $container_id dst-server console "abcde" - "aaaaa" < dsta-console/commands3.txt || exit 1
docker exec -i $container_id dst-server console "xyz as" "1234" < dsta-console/commands4.txt || exit 1
sleep 20
docker cp $container_id:/var/lib/dsta/config/log.txt $file1
docker rm -fv $container_id > /dev/null

grep -Fq "ConsoleInput: \"foo 1\"" $file1 || exit 1
grep -Fq "ConsoleInput: \"bar1\"" $file1 || exit 1

grep -Fq "ConsoleInput: \"foo 2\"" $file1 || exit 1
grep -Fq "ConsoleInput: \"bar2\"" $file1 || exit 1

grep -Fq "ConsoleInput: \"asdf\"" $file1 || exit 1

grep -Fq "ConsoleInput: \"abcde\"" $file1 || exit 1
grep -Fq "ConsoleInput: \"foo 3\"" $file1 || exit 1
grep -Fq "ConsoleInput: \"bar3\"" $file1 || exit 1
grep -Fq "ConsoleInput: \"aaaaa\"" $file1 || exit 1

grep -Fq "ConsoleInput: \"xyz as\"" $file1 || exit 1
grep -Fq "ConsoleInput: \"1234\"" $file1 || exit 1
grep -Fq "ConsoleInput: \"foo 4\"" $file1 && exit 1
grep -Fq "ConsoleInput: \"bar4\"" $file1 && exit 1
exit 0
