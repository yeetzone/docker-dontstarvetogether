#!/usr/bin/env bats

load test_helper
source $BUILD/static/boot/functions.sh

@test "Test validate_bool 1" {
	export FOO=""
	run validate_bool FOO
	assert_success
}

@test "Test validate_bool 2" {
	export FOO="true"
	run validate_bool FOO
	assert_success
}

@test "Test validate_bool 3" {
	export FOO="false"
	run validate_bool FOO
	assert_success
}

@test "Test validate_bool 4" {
	export FOO="bar"
	run validate_bool FOO
	assert_failure
}

@test "Test validate_int 1" {
	export FOO=""
	run validate_int FOO 1 10
	assert_success
}

@test "Test validate_int 2" {
	export FOO="1"
	run validate_int FOO 1 10
	assert_success
}

@test "Test validate_int 3" {
	export FOO="5"
	run validate_int FOO 1 10
	assert_success
}

@test "Test validate_int 4" {
	export FOO="10"
	run validate_int FOO 1 10
	assert_success
}

@test "Test validate_int 5" {
	export FOO="0"
	run validate_int FOO 1 10
	assert_failure
}

@test "Test validate_int 6" {
	export FOO="11"
	run validate_int FOO 1 10
	assert_failure
}

@test "Test validate_int 7" {
	export FOO="1100"
	run validate_int FOO 1 10
	assert_failure
}

@test "Test validate_port 1" {
	export FOO=""
	run validate_port FOO
	assert_success
}

@test "Test validate_port 2" {
	export FOO="1"
	run validate_port FOO
	assert_success
}

@test "Test validate_port 3" {
	export FOO="10999"
	run validate_port FOO
	assert_success
}

@test "Test validate_port 4" {
	export FOO="65535"
	run validate_port FOO
	assert_success
}

@test "Test validate_port 5" {
	export FOO="0"
	run validate_port FOO
	assert_failure
}

@test "Test validate_port 6" {
	export FOO="65536"
	run validate_port FOO
	assert_failure
}

@test "Test validate_port 7" {
	export FOO="655350"
	run validate_port FOO
	assert_failure
}

@test "Test validate_option 1" {
	export FOO=""
	run validate_option FOO a b c
	assert_success
}

@test "Test validate_option 2" {
	export FOO="a"
	run validate_option FOO a b c
	assert_success
}

@test "Test validate_option 3" {
	export FOO="b"
	run validate_option FOO a b c
	assert_success
}

@test "Test validate_option 4" {
	export FOO="c"
	run validate_option FOO a b c
	assert_success
}

@test "Test validate_option 5" {
	export FOO="d"
	run validate_option FOO a b c
	assert_failure
}

@test "Test validate_option 6" {
	export FOO="1"
	run validate_option FOO a b c
	assert_failure
}

@test "Test validate_option 7" {
	export FOO="1"
	run validate_option FOO 1 2 3
	assert_success
}

@test "Test validate_option 8" {
	export FOO="2"
	run validate_option FOO 1 2 3
	assert_success
}

@test "Test validate_option 9" {
	export FOO="3"
	run validate_option FOO 1 2 3
	assert_success
}

@test "Test validate_option 10" {
	export FOO="4"
	run validate_option FOO 1 2 3
	assert_failure
}

@test "Test validate_option 11" {
	export FOO="a"
	run validate_option FOO 1 2 3
	assert_failure
}
