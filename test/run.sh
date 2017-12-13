#!/usr/bin/env bash

echoerr() { echo "$@" 1>&2; }
build_error() {
	echoerr Error building the image
	exit 1
}

cd "$( dirname "$0" )"

# Build the image
image_name=dstacademy/dontstarvetogether
docker build -t $image_name ../build || build_error

tests=`mktemp`
if [ $# -eq 0 ]; then
	find . -mindepth 2 -maxdepth 2 -type f -name run.sh > $tests
else
	for test_name in "$@"
	do
		echo "./$test_name/run.sh" >> $tests
	done
fi
test_count=`wc -l < $tests`
i=1
error_count=0

# Run the tests
while read -u 3 t
do
	test_name=`echo $t | cut -d'/' -f2`
	echo "Running $test_name [$i/$test_count]"
	if ! $t $image_name; then
		echoerr "[FAIL] $test_name"
		((error_count++))
	fi
	((i++))
done 3< $tests

rm $tests # TODO trap signal

if [ $error_count -ne 0 ]; then
	echoerr "Failed $error_count/$test_count tests."
	exit 1
fi
