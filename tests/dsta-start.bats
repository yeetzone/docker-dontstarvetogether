#!/usr/bin/env bats

load test_helper

@test "dontstarvetogether start" {
	docker run -d --name $CONTAINER $IMAGE dontstarvetogether start
	wait_until_loaded
	if [ -z "`docker ps -qf name=$container_id`" ]; then
		false
	fi
	run docker logs $CONTAINER
	refute_line --partial "Success! App '343050' already up to date."
	refute_line --partial "DownloadMods"
}

@test "dontstarvetogether start --update=none" {
	docker run -d --name $CONTAINER $IMAGE dontstarvetogether start --update=none
	wait_until_loaded
	if [ -z "`docker ps -qf name=$container_id`" ]; then
		false
	fi
	run docker logs $CONTAINER
	refute_line --partial "Success! App '343050' already up to date."
	refute_line --partial "DownloadMods"
}

@test "dontstarvetogether start --update=all" {
	docker run -d --name $CONTAINER $IMAGE dontstarvetogether start --update=all
	wait_until_loaded
	if [ -z "`docker ps -qf name=$container_id`" ]; then
		false
	fi
	run docker logs $CONTAINER
	assert_line --partial "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dontstarvetogether start --update=game" {
	docker run -d --name $CONTAINER $IMAGE dontstarvetogether start --update=game
	wait_until_loaded
	if [ -z "`docker ps -qf name=$container_id`" ]; then
		false
	fi
	run docker logs $CONTAINER
	assert_line --partial "Success! App '343050' already up to date."
	refute_line --partial "DownloadMods"
}

@test "dontstarvetogether start --update=mods" {
	docker run -d --name $CONTAINER $IMAGE dontstarvetogether start --update=mods
	wait_until_loaded
	if [ -z "`docker ps -qf name=$container_id`" ]; then
		false
	fi
	run docker logs $CONTAINER
	refute_line --partial "Success! App '343050' already up to date."
	assert_line --partial "DownloadMods"
}

@test "dontstarvetogether start fails with unknow value in flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether start --update=foo
	assert_failure
	cat "$FIXTURE_ROOT/start" | assert_output
}

@test "dontstarvetogether start fails with unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether start --game
	assert_failure
	cat "$FIXTURE_ROOT/start" | assert_output
}

@test "dontstarvetogether start fails with parameter" {
	fixtures dsta-help

	run docker run --rm $IMAGE dontstarvetogether start asd
	assert_failure
	cat "$FIXTURE_ROOT/start" | assert_output
}
