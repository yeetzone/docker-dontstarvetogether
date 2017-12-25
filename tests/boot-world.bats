#!/usr/bin/env bats

load test_helper

@test "set LEVELDATA_OVERRIDES creates leveldataoverride.lua" {
	fixtures boot-world

	docker run -d -e LEVELDATA_OVERRIDES="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo"
}

@test "no keep and not provide LEVELDATA_OVERRIDES doesn't create leveldataoverride.lua" {
	docker run -d --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	assert_failure
}

@test "overwrite LEVELDATA_OVERRIDES" {
	fixtures boot-world
	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e LEVELDATA_OVERRIDES="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e LEVELDATA_OVERRIDES="foo2" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo2"
}

@test "keep world and set LEVELDATA_OVERRIDES" {
	fixtures boot-world
	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e LEVELDATA_OVERRIDES="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e LEVELDATA_OVERRIDES="foo2" --name $CONTAINER $IMAGE --keep=world
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo"
}

@test "keep world but not set LEVELDATA_OVERRIDES" {
	fixtures boot-world
	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e LEVELDATA_OVERRIDES="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster --name $CONTAINER $IMAGE --keep=world
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo"
}

@test "not keep world and not set LEVELDATA_OVERRIDES" {
	fixtures boot-world
	VOLUME="test-keep-token"

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e LEVELDATA_OVERRIDES="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	diff "$TMP/leveldataoverride.lua" "$FIXTURE_ROOT/foo"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/shard/leveldataoverride.lua "$TMP/leveldataoverride.lua"
	assert_failure
}
