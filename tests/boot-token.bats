#!/usr/bin/env bats

load test_helper

@test "set token creates cluster_token.txt" {
	fixtures boot-token

	docker run -d -e TOKEN="token-1" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
}

@test "not keep and not provide token" {
	fixtures boot-token

	docker run -d --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	assert_failure
}

@test "overwrite token" {
	fixtures boot-token

	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-1" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-2" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token2"
}

@test "keep token" {
	fixtures boot-token

	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-1" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-2" --name $CONTAINER $IMAGE --keep-configuration=token
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
}

@test "multiple keep values" {
	fixtures boot-token

	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-1" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-2" --name $CONTAINER $IMAGE --keep-configuration=token,whitelist
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
}

@test "keep but not the token" {
	fixtures boot-token

	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-1" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-2" --name $CONTAINER $IMAGE --keep-configuration=whitelist
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token2"
}

@test "not keep and not provide token" {
	fixtures boot-token

	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e TOKEN="token-1" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	diff "$TMP/cluster_token.txt" "$FIXTURE_ROOT/token1"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/cluster_token.txt "$TMP/cluster_token.txt"
	assert_failure
}
