#!/usr/bin/env bats

setup() {
  source main.sh '.'
}

@test 'split_camel_case() splits string at upper case character' {
  run split_camel_case 'HelloWorld'
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Hello World" ]
}

@test 'upper_case() converts all characters of a string to upper case' {
  run upper_case 'hello'
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = 'HELLO' ]
}

@test 'upper_case_first() converts the first character of a string to upper case' {
  run upper_case_first 'hello'
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = 'Hello' ]
}
