#!/usr/bin/env bash
#shellcheck disable=SC1090,SC2086

bulk_source() {
  exit_on_argc_invalid 1 $#

  local DIRECTORY=$1

  while IFS= read -r -d '' file; do
    source $file
  done < <(find $DIRECTORY -name '*.sh' -print0)
}

read_yaml() {
  exit_on_argc_invalid 2 $#

  local FILE_PATH=$1
  local KEY=$2

  # https://github.com/mikefarah/yq
  cat <$FILE_PATH | yq r - $KEY
}
