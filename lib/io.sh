#!/usr/bin/env bash
#shellcheck disable=SC2086

readonly COLOR_ERROR='\033[0;31m[ERROR]\033[0;39m'
readonly COLOR_INFO='\033[0;32m[INFO]\033[0;39m'
readonly COLOR_WARN='\033[0;33m[WARN]\033[0;39m'

console() {
  exit_on_argc_invalid 2 $#

  local CALLER=${FUNCNAME[1]}

  if [[ $# -ne 2 ]]; then
    echo -e "$COLOR_ERROR $CALLER requires 1 argument"
    exit 1
  fi

  local MESSAGE=$1
  local WITHOUT_LINE_BREAK=$2

  if [[ -z $WITHOUT_LINE_BREAK ]]; then
    WITHOUT_LINE_BREAK=false
  fi

  if $WITHOUT_LINE_BREAK; then
    echo -e -n $MESSAGE
  else
    echo -e $MESSAGE
  fi
}

console_error() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$COLOR_ERROR $MESSAGE" false
}

console_error_nobr() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$COLOR_ERROR $MESSAGE" true
}

console_info() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$COLOR_INFO $MESSAGE" false
}

console_info_nobr() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$COLOR_INFO $MESSAGE" true
}

console_plain() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$MESSAGE" false
}

console_plain_nobr() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$MESSAGE" true
}

console_warn() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$COLOR_WARN $MESSAGE" false
}

console_warn_nobr() {
  exit_on_argc_invalid 1 $#
  local MESSAGE=$1
  console "$COLOR_WARN $MESSAGE" true
}

# https://stackoverflow.com/questions/2575037/how-to-get-the-cursor-position-in-bash
cursor_horizontal_position() {
  exec </dev/tty
  old_stty=$(stty -g)
  stty raw -echo min 0
  echo -en '\033[6n' >/dev/tty
  IFS=';' read -r -d R -a pos
  stty $old_stty
  local row=$((${pos[0]:2} - 1)) # strip off the esc-[
  #local col=$((${pos[1]} - 1))
  echo $row
}

line_break_on_cursor_moved() {
  if [[ $(cursor_horizontal_position) -ne 0 ]]; then
    echo ''
  fi
}

log() {
  exit_on_argc_invalid 2 $#
  local MESSAGE=$1
  local LOG_FILE_PATH=$2
  echo "[$(date)] $MESSAGE" >>$LOG_FILE_PATH
}
