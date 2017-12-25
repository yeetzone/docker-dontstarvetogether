#!/usr/bin/env bats

load test_helper

@test "Send console commands" {
	timeout --kill-after 1 20 docker run -i --name $CONTAINER $IMAGE <<-EOF
		c_shutdown(true)
	EOF
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt $TMP/server_log.txt

	grep -Fq "RemoteCommandInput: \"c_shutdown(true)\"" $TMP/server_log.txt
}

@test "Send console commands with docker attach" {
	docker run -id --name $CONTAINER $IMAGE
	docker attach $CONTAINER <<-EOF
		c_shutdown(true)
	EOF
	timeout --kill-after 1 20 docker wait $CONTAINER
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt $TMP/server_log.txt

	grep -Fq "RemoteCommandInput: \"c_shutdown(true)\"" $TMP/server_log.txt
}
