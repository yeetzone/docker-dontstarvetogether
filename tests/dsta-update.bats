#!/usr/bin/env bats

load test_helper

@test "dst-server update" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update
	assert_success
	assert_line "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dst-server update --all" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --all
	assert_success
	assert_line "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dst-server update --game" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --game
	assert_success
	assert_line "Success! App '343050' already up to date."
	refute_line --partial "DownloadMods"
}

@test "dst-server update --mods" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --mods
	assert_success
	refute_line "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dst-server update -- too much flags 1" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --game --mods
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dst-server update -- too much flags 2" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --all --game
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dst-server update -- repeat flags" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --game --game
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dst-server update -- Unknown argument" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update foo
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dst-server update -- Unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server update --foo
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}
