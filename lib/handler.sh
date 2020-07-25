#!/usr/bin/env bash
#shellcheck disable=SC2086

exit_on_fail() {
  local COMMAND_STATUS=$1
  local MESSAGE=$2

  if [[ $COMMAND_STATUS -ne 0 ]]; then
    if [[ -n $MESSAGE ]]; then
      line_break_on_cursor_moved
      console_error $MESSAGE
    fi
    exit 1
  fi
}

exit_on_argc_less_than() {
  local ARGC_REQUIRED=$1
  local ARGC_PASSED=$2
  local CALLER=${FUNCNAME[1]}

  if [[ $ARGC_PASSED -lt $ARGC_REQUIRED ]]; then
    if [[ $ARGC_REQUIRED -eq 1 ]]; then
      console_error "$CALLER requires at least 1 argument"
    else
      console_error "$CALLER requires at least $ARGC_REQUIRED arguments"
    fi
    exit 1
  fi
}

exit_on_argc_invalid() {
  local ARGC_REQUIRED=$1
  local ARGC_PASSED=$2
  local CALLER=${FUNCNAME[1]}

  if [[ $ARGC_REQUIRED -ne $ARGC_PASSED ]]; then
    if [[ $ARGC_REQUIRED -eq 1 ]]; then
      console_error "$CALLER requires 1 argument"
    else
      console_error "$CALLER requires $ARGC_REQUIRED arguments"
    fi
    exit 1
  fi
}
