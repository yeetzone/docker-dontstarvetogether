#!/usr/bin/env bats

load test_helper

@test "dontstarvetogether version" {
	docker run --rm $IMAGE dontstarvetogether version
}

@test "dontstarvetogether version --local" {
	run docker run --rm $IMAGE dontstarvetogether version --local
	assert_success
	assert_output --regexp '^[0-9]+$'
}

@test "dontstarvetogether version --upstream" {
	run docker run --rm $IMAGE dontstarvetogether version --upstream
	assert_success
	assert_output --regexp '^[0-9]+$'
}

@test "dontstarvetogether version --check" {
	run docker run --rm $IMAGE dontstarvetogether version --check
	if [ $status -eq 0 ]; then
		assert_output "Version is up to date."
	else
		assert_output "Version is outdated."
	fi
}

@test "dontstarvetogether version unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether version --foo
	assert_failure
	cat "$FIXTURE_ROOT/version" | assert_output
}
