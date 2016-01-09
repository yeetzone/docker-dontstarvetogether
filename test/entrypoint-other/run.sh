#!/usr/bin/env bash

clean() {
  rm -f $file1 $file2
}
trap clean EXIT

file1=`mktemp`
file2=`mktemp`
docker run --rm $1 echo OK > $file1 || exit 1
echo OK > $file2
cmp --silent $file1 $file2 || exit 1
