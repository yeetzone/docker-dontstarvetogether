#!/usr/bin/env bats

load test_helper

@test "close cleanly after docker stop" {
	docker run -d --name $CONTAINER $IMAGE
	wait_until_loaded
	docker stop $CONTAINER
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"
	grep -q "Shutting down$" "$TMP/server_log.txt"
}

@test "close cleanly after docker stop with dirty console" {
	fixtures close-cleanly

	docker run -d --name $CONTAINER $IMAGE
	wait_until_loaded
	docker cp "$FIXTURE_ROOT/commands.sh" $CONTAINER:/
	docker exec $CONTAINER /commands.sh
	docker stop $CONTAINER
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"
	grep -q "Shutting down$" "$TMP/server_log.txt"
}

@test "close cleanly after kill 1" {
	fixtures close-cleanly

	docker run -d --name $CONTAINER $IMAGE
	wait_until_loaded
	docker exec $CONTAINER bash -c "kill 1"
	timeout --kill-after 1 12 docker wait $CONTAINER
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"
	grep -q "Shutting down$" "$TMP/server_log.txt"
}

@test "close cleanly after kill -SIGINT 1" {
	fixtures close-cleanly

	docker run -d --name $CONTAINER $IMAGE
	wait_until_loaded
	docker exec $CONTAINER bash -c "kill -SIGINT 1"
	timeout --kill-after 1 12 docker wait $CONTAINER
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"
	grep -q "Shutting down$" "$TMP/server_log.txt"
}
