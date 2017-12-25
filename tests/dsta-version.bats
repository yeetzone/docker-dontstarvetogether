#!/usr/bin/env bats

load test_helper

@test "dst-server version" {
	docker run --rm $IMAGE dst-server version
}

@test "dst-server version --local" {
	run docker run --rm $IMAGE dst-server version --local
	assert_success
	assert_output --regexp '^[0-9]+$'
}

@test "dst-server version --upstream" {
	run docker run --rm $IMAGE dst-server version --upstream
	assert_success
	assert_output --regexp '^[0-9]+$'
}

@test "dst-server version --check" {
	run docker run --rm $IMAGE dst-server version --check
	if [ $status -eq 0 ]; then
		assert_output "Version is up to date."
	else
		assert_output "Version is outdated."
	fi
}

@test "dst-server version unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server version --foo
	assert_failure
	cat "$FIXTURE_ROOT/version" | assert_output
}
