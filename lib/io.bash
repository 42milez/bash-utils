#!/usr/bin/env bash

COLOR_ERROR='\033[0;31m[ERROR]\033[0;39m'
COLOR_INFO='\033[0;32m[INFO]\033[0;39m'
COLOR_WARN='\033[0;33m[WARN]\033[0;39m'

Console() {
  ExitOnArgcInvalid 2 ${#}

  CALLER=${FUNCNAME[1]}

  if [[ ${#} -ne 2 ]]; then
    echo -e "${COLOR_ERROR} ${CALLER} requires 1 argument"
    exit 1
  fi

  MESSAGE=${1}
  WITHOUT_LINE_BREAK=${2}

  if [[ -z ${WITHOUT_LINE_BREAK} ]]; then
    WITHOUT_LINE_BREAK=false
  fi

  if ${WITHOUT_LINE_BREAK}; then
    echo -e -n "${MESSAGE}"
  else
    echo -e "${MESSAGE}"
  fi
}

ConsoleError() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${COLOR_ERROR} ${MESSAGE}" false
}

ConsoleErrorNoBR() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${COLOR_ERROR} ${MESSAGE}" true
}

ConsoleInfo() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${COLOR_INFO} ${MESSAGE}" false
}

ConsoleInfoNoBR() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${COLOR_INFO} ${MESSAGE}" true
}

ConsolePlain() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${MESSAGE}" false
}

ConsolePlainNoBR() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${MESSAGE}" true
}

ConsoleWarn() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${COLOR_WARN} ${MESSAGE}" false
}

ConsoleWarnNoBR() {
  ExitOnArgcInvalid 1 ${#}
  MESSAGE=${1}
  Console "${COLOR_WARN} ${MESSAGE}" true
}

# https://stackoverflow.com/questions/2575037/how-to-get-the-cursor-position-in-bash
CursorHorizontalPosition() {
  exec </dev/tty
  oldstty=$(stty -g)
  stty raw -echo min 0
  echo -en '\033[6n' >/dev/tty
  IFS=';' read -r -d R -a pos
  stty $oldstty
  row=$((${pos[0]:2} - 1)) # strip off the esc-[
  col=$((${pos[1]} - 1))

  echo "${row}"
}

LineBreakOnCursorMoved() {
  if [[ $(CursorHorizontalPosition) -ne 0 ]]; then
    echo ''
  fi
}

Log() {
  ExitOnArgcInvalid 2 ${#}

  MESSAGE=${1}
  LOG_FILE_PATH=${2}

  echo "[$(date)] ${MESSAGE}" >>"${LOG_FILE_PATH}"
}
