#!/usr/bin/env bats

load test_helper

@test "The image know how to run any kind of command" {
	docker run --rm $IMAGE echo OK >"$TMP/std_output"
	echo OK >"$TMP/std_output_expected"
	diff "$TMP/std_output" "$TMP/std_output_expected"
}

@test "docker-entrypoint.sh successed if the command successed" {
	run $BUILD/docker-entrypoint.sh true
	assert_success
}

@test "docker-entrypoint.sh fails if the command fails" {
	run $BUILD/docker-entrypoint.sh false
	assert_failure
}
