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

@test "dst-server help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server help
	assert_success
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

@test "dst-server --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server --help
	assert_success
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

@test "dst-server with unknown argument" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server foo
	assert_failure
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

@test "dst-server with unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server --foo
	assert_failure
	cat "$FIXTURE_ROOT/dst-server" | assert_output
}

#####
# dst-server start
#####
@test "dst-server help start" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server help start
	assert_success
	cat "$FIXTURE_ROOT/start" | assert_output
}

@test "dst-server --help start" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server --help start
	assert_success
	cat "$FIXTURE_ROOT/start" | assert_output
}

@test "dst-server start --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server start --help
	assert_success
	cat "$FIXTURE_ROOT/start" | assert_output
}

#####
# dst-server update
#####
@test "dst-server help update" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server help update
	assert_success
	cat "$FIXTURE_ROOT/update" | assert_output
}

@test "dst-server --help update" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server --help update
	assert_success
	cat "$FIXTURE_ROOT/update" | assert_output
}

@test "dst-server update --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --help
	assert_success
	cat "$FIXTURE_ROOT/update" | assert_output
}

#####
# dst-server log
#####
@test "dst-server help log" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server help log
	assert_success
	cat "$FIXTURE_ROOT/log" | assert_output
}

@test "dst-server --help log" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server --help log
	assert_success
	cat "$FIXTURE_ROOT/log" | assert_output
}

@test "dst-server log --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server log --help
	assert_success
	cat "$FIXTURE_ROOT/log" | assert_output
}

#####
# dst-server console
#####
@test "dst-server help console" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server help console
	assert_success
	cat "$FIXTURE_ROOT/console" | assert_output
}

@test "dst-server --help console" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server --help console
	assert_success
	cat "$FIXTURE_ROOT/console" | assert_output
}

@test "dst-server console --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server console --help
	assert_success
	cat "$FIXTURE_ROOT/console" | assert_output
}

#####
# dst-server version
#####
@test "dst-server help version" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server help version
	assert_success
	cat "$FIXTURE_ROOT/version" | assert_output
}

@test "dst-server --help version" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server --help version
	assert_success
	cat "$FIXTURE_ROOT/version" | assert_output
}

@test "dst-server version --help" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server version --help
	assert_success
	cat "$FIXTURE_ROOT/version" | assert_output
}
