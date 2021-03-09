#!/usr/bin/env bats

load test_helper

#####
# dst-server
#####
@test "dst-server" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server
	assert_failure
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

@test "dontstarvetogether help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether help
	assert_success
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

@test "dontstarvetogether --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether --help
	assert_success
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

@test "dontstarvetogether with unknown argument" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether foo
	assert_failure
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

@test "dontstarvetogether with unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether --foo
	assert_failure
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

#####
# dontstarvetogether start
#####
@test "dontstarvetogether help start" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether help start
	assert_success
	cat "$FIXTURE_ROOT/start" | assert_output
}

@test "dontstarvetogether --help start" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether --help start
	assert_success
	cat "$FIXTURE_ROOT/start" | assert_output
}

@test "dontstarvetogether start --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether start --help
	assert_success
	cat "$FIXTURE_ROOT/start" | assert_output
}

#####
# dontstarvetogether update
#####
@test "dontstarvetogether help update" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether help update
	assert_success
	cat "$FIXTURE_ROOT/update" | assert_output
}

@test "dontstarvetogether --help update" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether --help update
	assert_success
	cat "$FIXTURE_ROOT/update" | assert_output
}

@test "dontstarvetogether update --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --help
	assert_success
	cat "$FIXTURE_ROOT/update" | assert_output
}

#####
# dontstarvetogether log
#####
@test "dontstarvetogether help log" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether help log
	assert_success
	cat "$FIXTURE_ROOT/log" | assert_output
}

@test "dontstarvetogether --help log" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether --help log
	assert_success
	cat "$FIXTURE_ROOT/log" | assert_output
}

@test "dontstarvetogether log --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether log --help
	assert_success
	cat "$FIXTURE_ROOT/log" | assert_output
}

#####
# dontstarvetogether console
#####
@test "dontstarvetogether help console" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether help console
	assert_success
	cat "$FIXTURE_ROOT/console" | assert_output
}

@test "dontstarvetogether --help console" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether --help console
	assert_success
	cat "$FIXTURE_ROOT/console" | assert_output
}

@test "dontstarvetogether console --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether console --help
	assert_success
	cat "$FIXTURE_ROOT/console" | assert_output
}

#####
# dontstarvetogether version
#####
@test "dontstarvetogether help version" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether help version
	assert_success
	cat "$FIXTURE_ROOT/version" | assert_output
}

@test "dontstarvetogether --help version" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether --help version
	assert_success
	cat "$FIXTURE_ROOT/version" | assert_output
}

@test "dontstarvetogether version --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether version --help
	assert_success
	cat "$FIXTURE_ROOT/version" | assert_output
}
