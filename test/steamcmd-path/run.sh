#!/usr/bin/env bash

clean() {
	rm -f $file1
}
trap clean EXIT

file1=`mktemp`
docker run --rm $1 steamcmd +quit > $file1 || exit 1
