#!/usr/bin/env bats

load test_helper

@test "correct dedicated_server_mods_setup.lua installing one mod" {
	fixtures build-mods/one-mod

	docker build --build-arg MODS="378160973" -t $IMAGE $BUILD
	docker create --name $CONTAINER $IMAGE
	docker cp $CONTAINER:/opt/dst/mods/dedicated_server_mods_setup.lua "$TMP/dedicated_server_mods_setup.lua"
	diff --strip-trailing-cr "$TMP/dedicated_server_mods_setup.lua" "$FIXTURE_ROOT/dedicated_server_mods_setup.lua"
}

@test "correct dedicated_server_mods_setup.lua installing two mods" {
	fixtures build-mods/two-mods

	docker build --build-arg MODS="378160973,380423963" -t $IMAGE $BUILD
	docker create --name $CONTAINER $IMAGE
	docker cp $CONTAINER:/opt/dst/mods/dedicated_server_mods_setup.lua "$TMP/dedicated_server_mods_setup.lua"
	diff --strip-trailing-cr "$TMP/dedicated_server_mods_setup.lua" "$FIXTURE_ROOT/dedicated_server_mods_setup.lua"
}
