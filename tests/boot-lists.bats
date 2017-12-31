#!/usr/bin/env bats

load test_helper

export VOLUME="test-keep-lists"

#####
# Adminlist
#####
@test "load ADMINLIST in correct format" {
	load_list_in_correct_format ADMINLIST adminlist
}

@test "set ADMINLIST creates file" {
	set_variable_creates_file ADMINLIST adminlist
}

@test "no set ADMINLIST does't create file" {
	no_set_varibale_doesnt_create_file ADMINLIST adminlist
}

@test "overwrite ADMINLIST" {
	overwrite_list ADMINLIST adminlist
}

@test "keep ADMINLIST" {
	keep_list ADMINLIST adminlist
}

@test "no keep and no provide ADMINLIST" {
	no_keep_and_not_provide ADMINLIST adminlist
}

#####
# Whitelist
#####
@test "load WHITELIST in correct format" {
	load_list_in_correct_format WHITELIST whitelist
}

@test "set WHITELIST creates file" {
	set_variable_creates_file WHITELIST whitelist
}

@test "no set WHITELIST does't create file" {
	no_set_varibale_doesnt_create_file WHITELIST whitelist
}

@test "overwrite WHITELIST" {
	overwrite_list WHITELIST whitelist
}

@test "keep WHITELIST" {
	keep_list WHITELIST whitelist
}

@test "no keep and no provide WHITELIST" {
	no_keep_and_not_provide WHITELIST whitelist
}

#####
# Blocklist
#####
@test "load BLOCKLIST in correct format" {
	load_list_in_correct_format BLOCKLIST blocklist
}

@test "set BLOCKLIST creates file" {
	set_variable_creates_file BLOCKLIST blocklist
}

@test "no set BLOCKLIST does't create file" {
	no_set_varibale_doesnt_create_file BLOCKLIST blocklist
}

@test "overwrite BLOCKLIST" {
	overwrite_list BLOCKLIST blocklist
}

@test "keep BLOCKLIST" {
	keep_list BLOCKLIST blocklist
}

@test "no keep and no provide BLOCKLIST" {
	no_keep_and_not_provide BLOCKLIST blocklist
}

load_list_in_correct_format() {
	fixtures boot-lists

	docker run -d -e $1="foo,bar,xy_:z" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	diff "$TMP/$2.txt" "$FIXTURE_ROOT/list.txt"
	wait_until_loaded
	docker cp $CONTAINER:/var/lib/dsta/cluster/shard/server_log.txt "$TMP/server_log.txt"
	grep -E "$2\.txt.*\(Success\)" "$TMP/server_log.txt"
}

set_variable_creates_file() {
	fixtures boot-lists

	docker run -d -e $1="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	diff "$TMP/$2.txt" "$FIXTURE_ROOT/foo.txt"
}

no_set_varibale_doesnt_create_file() {
	docker run -d --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	assert_failure
}

overwrite_list() {
	fixtures boot-lists

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e $1="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	diff "$TMP/$2.txt" "$FIXTURE_ROOT/foo.txt"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e $1="bar" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	diff "$TMP/$2.txt" "$FIXTURE_ROOT/bar.txt"
}

keep_list() {
	fixtures boot-lists

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e $1="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	diff "$TMP/$2.txt" "$FIXTURE_ROOT/foo.txt"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e $1="bar" --name $CONTAINER $IMAGE --keep-configuration=$2
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	diff "$TMP/$2.txt" "$FIXTURE_ROOT/foo.txt"
}

no_keep_and_not_provide() {
	fixtures boot-lists

	docker run -d -v $VOLUME:/var/lib/dsta/cluster -e $1="foo" --name $CONTAINER $IMAGE
	wait_until_initializing
	docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	diff "$TMP/$2.txt" "$FIXTURE_ROOT/foo.txt"
	docker rm -f $CONTAINER

	docker run -d -v $VOLUME:/var/lib/dsta/cluster --name $CONTAINER $IMAGE
	wait_until_initializing
	run docker cp $CONTAINER:/var/lib/dsta/cluster/$2.txt "$TMP/$2.txt"
	assert_failure
}
