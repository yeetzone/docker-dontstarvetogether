#!/usr/bin/env bash

source ../build/static/boot/aux.sh

export FOO=""
validate_bool FOO || exit 1
export FOO="true"
validate_bool FOO || exit 1
export FOO="false"
validate_bool FOO || exit 1
export FOO="bar"
validate_bool FOO 2> /dev/null && exit 1

export FOO=""
validate_int FOO 1 10 || exit 1
export FOO="1"
validate_int FOO 1 10 || exit 1
export FOO="5"
validate_int FOO 1 10 || exit 1
export FOO="10"
validate_int FOO 1 10 || exit 1
export FOO="0"
validate_int FOO 1 10 2> /dev/null && exit 1
export FOO="11"
validate_int FOO 1 10 2> /dev/null && exit 1
export FOO="1100"
validate_int FOO 1 10 2> /dev/null && exit 1

export FOO=""
validate_port FOO || exit 1
export FOO="1"
validate_port FOO || exit 1
export FOO="10999"
validate_port FOO || exit 1
export FOO="65535"
validate_port FOO || exit 1
export FOO="0"
validate_port FOO 2> /dev/null && exit 1
export FOO="65536"
validate_port FOO 2> /dev/null && exit 1
export FOO="655350"
validate_port FOO 2> /dev/null && exit 1

export FOO=""
validate_option FOO a b c || exit 1
export FOO="a"
validate_option FOO a b c || exit 1
export FOO="b"
validate_option FOO a b c || exit 1
export FOO="c"
validate_option FOO a b c || exit 1
export FOO="d"
validate_option FOO a b c 2> /dev/null && exit 1
export FOO="1"
validate_option FOO a b c 2> /dev/null && exit 1
export FOO="1"
validate_option FOO 1 2 3 || exit 1
export FOO="2"
validate_option FOO 1 2 3 || exit 1
export FOO="3"
validate_option FOO 1 2 3 || exit 1
export FOO="4"
validate_option FOO 1 2 3 2> /dev/null && exit 1
export FOO="a"
validate_option FOO 1 2 3 2> /dev/null && exit 1
exit 0
