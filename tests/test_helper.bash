#!/usr/bin/env bash

load dependencies/load

export BUILD="$BATS_TEST_DIRNAME/../build"
export IMAGE="dstacademy/dontstarvetogether"
export CONTAINER="dstacademy-test"
export TMP="$BATS_TEST_DIRNAME/tmp"

fixtures() {
  FIXTURE_ROOT="$BATS_TEST_DIRNAME/fixtures/$1"
  RELATIVE_FIXTURE_ROOT="$(bats_trim_filename "$FIXTURE_ROOT")"
}

setup() {
	mkdir "$TMP"

	docker build -t $IMAGE $BUILD
}

teardown() {
	docker rm -fv "$CONTAINER" >/dev/null
	rm -rf "$TMP"
}

wait_until_initializing() {
	docker logs --follow $CONTAINER | sed '/Starting Up$/ q' >/dev/null
}

wait_until_loaded() {
	docker logs --follow $CONTAINER | sed '/LOADING LUA SUCCESS$/ q' >/dev/null
}
