#!/usr/bin/env bats

load test_helper

@test "Get the logs" {
	fixtures dsta-log

	docker run -d --name $CONTAINER $IMAGE sleep infinity
	docker exec $CONTAINER mkdir /var/lib/dsta/cluster/shard
	docker exec $CONTAINER chown steam:steam /var/lib/dsta/cluster/shard
	docker cp "$FIXTURE_ROOT/server_log.txt" $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt
	docker cp "$FIXTURE_ROOT/server_log_chat.txt" $CONTAINER:/var/lib/dsta/cluster/shard/server_log_chat.txt

	docker exec $CONTAINER dst-server log >"$TMP/server_log.txt"
	diff "$TMP/server_log.txt" "$FIXTURE_ROOT/server_log.txt"
	docker exec $CONTAINER dst-server log --server >"$TMP/server_log.txt"
	diff "$TMP/server_log.txt" "$FIXTURE_ROOT/server_log.txt"
	docker exec $CONTAINER dst-server log --chat >"$TMP/server_log_chat.txt"
	diff "$TMP/server_log_chat.txt" "$FIXTURE_ROOT/server_log_chat.txt"
}

@test "Empty logs when the files doesn't exist" {
	fixtures dsta-log

	docker run --rm -e NAME=foo $IMAGE dst-server log >"$TMP/std_output.txt" 2>"$TMP/err_output.txt"
	diff "$TMP/std_output.txt" "$FIXTURE_ROOT/empty-file"
	diff "$TMP/err_output.txt" "$FIXTURE_ROOT/empty-file"

	docker run --rm -e NAME=foo $IMAGE dst-server log --server >"$TMP/std_output.txt" 2>"$TMP/err_output.txt"
	diff "$TMP/std_output.txt" "$FIXTURE_ROOT/empty-file"
	diff "$TMP/err_output.txt" "$FIXTURE_ROOT/empty-file"

	docker run --rm -e NAME=foo $IMAGE dst-server log --chat >"$TMP/std_output.txt" 2>"$TMP/err_output.txt"
	diff "$TMP/std_output.txt" "$FIXTURE_ROOT/empty-file"
	diff "$TMP/err_output.txt" "$FIXTURE_ROOT/empty-file"
}

@test "dst-server log fails with double flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server log --server --chat
	assert_failure
	cat "$FIXTURE_ROOT/log" | assert_output
}

@test "dst-server log fails with unknown flag" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server log --type
	assert_failure
	cat "$FIXTURE_ROOT/log" | assert_output
}

@test "dst-server log fails with parameter" {
	fixtures dsta-help

	run docker run --rm $IMAGE dst-server log asd
	assert_failure
	cat "$FIXTURE_ROOT/log" | assert_output
}
