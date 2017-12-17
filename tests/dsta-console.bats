#!/usr/bin/env bats

load test_helper

SLEEP_TIME=10

@test "dst-server console redirect" {
	fixtures dsta-console

	docker run -d --name $CONTAINER $IMAGE
	docker exec -i $CONTAINER dst-server console <"$FIXTURE_ROOT/commands.txt"
	sleep $SLEEP_TIME
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"

	grep -F "RemoteCommandInput: \"foo bar\"" "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"bar\"" "$TMP/server_log.txt"
}

@test "dst-server console - redirect" {
	fixtures dsta-console

	docker run -d --name $CONTAINER $IMAGE
	docker exec -i $CONTAINER dst-server console - <"$FIXTURE_ROOT/commands.txt"
	sleep $SLEEP_TIME
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"

	grep -F "RemoteCommandInput: \"foo bar\"" "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"bar\"" "$TMP/server_log.txt"
}

@test "dst-server console command" {
	docker run -d --name $CONTAINER $IMAGE
	docker exec -i $CONTAINER dst-server console "asdf"
	sleep $SLEEP_TIME
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"

	grep -F "RemoteCommandInput: \"asdf\"" "$TMP/server_log.txt"
}

@test "dst-server console command with redirect" {
	fixtures dsta-console

	docker run -d --name $CONTAINER $IMAGE
	docker exec -i $CONTAINER dst-server console "asdf" - "aaaaa" <"$FIXTURE_ROOT/commands.txt"
	sleep $SLEEP_TIME
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"

	grep -F "RemoteCommandInput: \"asdf\"" "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"foo bar\"" "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"bar\"" "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"aaaaa\"" "$TMP/server_log.txt"
}

@test "dst-server console command with redirect but not -" {
	fixtures dsta-console

	docker run -d --name $CONTAINER $IMAGE
	docker exec -i $CONTAINER dst-server console "asdf" "aaaaa" <"$FIXTURE_ROOT/commands.txt"
	sleep $SLEEP_TIME
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"

	grep -F "RemoteCommandInput: \"asdf\"" "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"aaaaa\"" "$TMP/server_log.txt"
	run grep -F "RemoteCommandInput: \"foo bar\"" "$TMP/server_log.txt"
	assert_failure
	run grep -F "RemoteCommandInput: \"bar\"" "$TMP/server_log.txt"
	assert_failure
}
