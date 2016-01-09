#!/bin/sh

clean() {
  rm -f $file1
}
trap clean EXIT

file1=`mktemp`
docker run --rm $1 gosu steam steamcmd +quit > $file1 || exit 1
