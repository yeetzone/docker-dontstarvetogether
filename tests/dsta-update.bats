#!/usr/bin/env bats

load test_helper

@test "dontstarvetogether update" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update
	assert_success
	assert_line "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dontstarvetogether update --all" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --all
	assert_success
	assert_line "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dontstarvetogether update --game" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --game
	assert_success
	assert_line "Success! App '343050' already up to date."
	refute_line --partial "DownloadMods"
}

@test "dontstarvetogether update --mods" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --mods
	assert_success
	refute_line "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dontstarvetogether update -- too much flags 1" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --game --mods
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dontstarvetogether update -- too much flags 2" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --all --game
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dontstarvetogether update -- repeat flags" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --game --game
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dontstarvetogether update -- Unknown argument" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update foo
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}

@test "dontstarvetogether update -- Unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether update --foo
	assert_failure
	cat $FIXTURE_ROOT/update | assert_output
}
