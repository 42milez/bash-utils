#!/usr/bin/env bash

ExitOnFail() {
  COMMAND_STATUS=${1}
  MESSAGE=${2}

  if [[ ${COMMAND_STATUS} -ne 0 ]]; then
    if [[ -n ${MESSAGE} ]]; then
      LINE_BREAK_IF_CURSOR_MOVED
      ConsoleError "${MESSAGE}"
    fi
    exit 1
  fi
}

ExitOnArgcLessThan() {
  ARGC_REQUIRED=${1}
  ARGC_PASSED=${2}
  CALLER=${FUNCNAME[1]}

  if [[ ${ARGC_PASSED} -lt ${ARGC_REQUIRED} ]]; then
    if [[ ${ARGC_REQUIRED} -eq 1 ]]; then
      ConsoleError "${CALLER} requires at least 1 argument"
    else
      ConsoleError "${CALLER} requires at least ${ARGC_REQUIRED} arguments"
    fi
    exit 1
  fi
}

ExitOnArgcInvalid() {
  ARGC_REQUIRED=${1}
  ARGC_PASSED=${2}
  CALLER=${FUNCNAME[1]}

  if [[ ${ARGC_REQUIRED} -ne ${ARGC_PASSED} ]]; then
    if [[ ${ARGC_REQUIRED} -eq 1 ]]; then
      ConsoleError "${CALLER} requires 1 argument"
    else
      ConsoleError "${CALLER} requires ${ARGC_REQUIRED} arguments"
    fi
    exit 1
  fi
}
