#!/usr/bin/env bash

SplitCamelCase() {
  ExitOnArgcInvalid 1 ${#}

  echo "${1}" | perl -F'([A-Z][a-z0-9]+)' -ane '@F = grep { /\S/ } @F ; print join(" ", @F)'
}

UpperCase() {
  ExitOnArgcInvalid 1 ${#}

  perl -e "print uc(${1})"
}

UpperCaseFirst() {
  ExitOnArgcInvalid 1 ${#}

  perl -e "print ucfirst(${1})"
}
