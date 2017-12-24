#!/usr/bin/env bats

load test_helper

@test "Configure one mod" {
	fixtures boot-mods/foo

	docker run -d -e MODS="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/opt/dst/mods/dedicated_server_mods_setup.lua "$TMP/dedicated_server_mods_setup.lua"
	tail -n 2 "$TMP/dedicated_server_mods_setup.lua" >"$TMP/dedicated_server_mods_setup.lua-tail"
	diff "$TMP/dedicated_server_mods_setup.lua-tail" "$FIXTURE_ROOT/dedicated_server_mods_setup.lua-tail"
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/modoverrides.lua "$TMP/modoverrides.lua"
	diff "$TMP/modoverrides.lua" "$FIXTURE_ROOT/modoverrides.lua"
}

@test "Configure two mods" {
	fixtures boot-mods/foo-bar

	docker run -d -e MODS="foo,bar" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/opt/dst/mods/dedicated_server_mods_setup.lua "$TMP/dedicated_server_mods_setup.lua"
	tail -n 3 "$TMP/dedicated_server_mods_setup.lua" >"$TMP/dedicated_server_mods_setup.lua-tail"
	diff "$TMP/dedicated_server_mods_setup.lua-tail" "$FIXTURE_ROOT/dedicated_server_mods_setup.lua-tail"
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/modoverrides.lua "$TMP/modoverrides.lua"
	diff "$TMP/modoverrides.lua" "$FIXTURE_ROOT/modoverrides.lua"
}

@test "Configure two mods with mods overrides" {
	fixtures boot-mods/foo-bar-with-overrides

	docker run -d -e MODS="foo,bar" -e MODS_OVERRIDES="xyz" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/opt/dst/mods/dedicated_server_mods_setup.lua "$TMP/dedicated_server_mods_setup.lua"
	tail -n 3 "$TMP/dedicated_server_mods_setup.lua" >"$TMP/dedicated_server_mods_setup.lua-tail"
	diff "$TMP/dedicated_server_mods_setup.lua-tail" "$FIXTURE_ROOT/dedicated_server_mods_setup.lua-tail"
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/modoverrides.lua "$TMP/modoverrides.lua"
	diff "$TMP/modoverrides.lua" "$FIXTURE_ROOT/modoverrides.lua"
}

@test "modoverrides.lua is not created by default" {
	docker run -d --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/shard/modoverrides.lua "$TMP/modoverrides.lua"
	assert_failure
}

@test "Just set mods overrides doesn't create modoverrides.lua" {
	docker run -d -e MODS_OVERRIDES="xyz" --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/shard/modoverrides.lua "$TMP/modoverrides.lua"
	assert_failure
}
