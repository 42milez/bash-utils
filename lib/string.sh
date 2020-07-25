#!/usr/bin/env bash

split_camel_case() {
  exit_on_argc_invalid 1 "$#"
  echo "$1" | perl -F'([A-Z][a-z0-9]+)' -ane '@F = grep { /\S/ } @F ; print join(" ", @F)'
}

upper_case() {
  exit_on_argc_invalid 1 "$#"
  perl -e "print uc($1)"
}

upper_case_first() {
  exit_on_argc_invalid 1 "$#"
  perl -e "print ucfirst($1)"
}
