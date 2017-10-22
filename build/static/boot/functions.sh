#!/usr/bin/env bash

warning() {
	echo "[WARNING] $1" 1>&2
}

validate_bool() {
	local v=${!1}
	if [[ -n "$v" ]] && [[ "$v" != "true" ]] && [[ "$v" != "false" ]]; then
		warning "$1 must be \"true\" or \"false\"."
		return 1
	fi
}

validate_int() {
	local v=${!1}
	if [[ -n "$v" ]] && [[ "$v" -lt "$2" ]] || [[ "$v" -gt "$3" ]]; then
		warning "$1 must be between $2 and $3."
		return 1
	fi
}

validate_port() {
	return $(validate_int "$1" "1" "65535")
}

# http://stackoverflow.com/a/8574392/842697
containsElement() {
  local e
  for e in "${@:2}"; do [[ "$e" = "$1" ]] && return 0; done
  return 1
}

validate_option() {
	local v=${!1}
	if [[ -n "$v" ]] && ! containsElement "$v" "${@:2}"; then
		warning "$1 must be one of these: ${*:2}."
		return 1
	fi
}

conf() {
	[[ -n "$2" ]] && echo "$1 = $2"
}
