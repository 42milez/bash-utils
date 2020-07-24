#!/usr/bin/env bash
#shellcheck disable=SC1090

BulkSource() {
  ExitOnArgcInvalid 1 ${#}

  DIRECTORY=${1}

  while IFS= read -r -d "" file; do
    source "${file}"
  done < <(find "${DIRECTORY}" -name "*.bash" -print0)
}

ReadYaml() {
  ExitOnArgcInvalid 2 ${#}

  FILE_PATH=${1}
  KEY=${2}

  # https://github.com/mikefarah/yq
  cat <"${FILE_PATH}" | yq r - "${KEY}"
}
