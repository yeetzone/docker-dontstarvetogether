#!/bin/bash

echoerr() { echo "$@" 1>&2; }
build_error() {
  echoerr Error building the image
  exit 1
}

cd "$( dirname "$0" )"

# Build the image
image_name=dstacademy/server
docker build -t $image_name ../build || build_error

bin="find -mindepth 2 -maxdepth 2 -type f -name run.sh"
test_count=`$bin | wc -l`
i=1
error_count=0

# Run the tests
while read t
do
  test_name=`echo $t | cut -d'/' -f2`
  echo "Running $test_name [$i/$test_count]"
  if ! $t $image_name
  then
    echoerr "[FAIL] $test_name"
    ((error_count++))
  fi
  ((i++))
done <<< "`$bin`"

if [ $error_count -ne 0 ]
then
  exit 1
fi
