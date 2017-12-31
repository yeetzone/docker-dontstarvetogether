#!/usr/bin/env bats

load test_helper

@test "write in /usr/local/share/dsta/console is like write in the console" {
	fixtures console

	docker run -d --name $CONTAINER $IMAGE
	docker cp "$FIXTURE_ROOT/commands.sh" $CONTAINER:/
	docker exec $CONTAINER /commands.sh
	wait_until_loaded
	sleep 1
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"foo bar\"" "$TMP/server_log.txt"
	grep -F "RemoteCommandInput: \"bar\"" "$TMP/server_log.txt"
}
