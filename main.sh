#!/usr/bin/env bash
#shellcheck disable=SC1090,SC2086

readonly LIBRARY_ROOT=$1

source $LIBRARY_ROOT/config.sh
source $LIBRARY_ROOT/lib/file.sh
source $LIBRARY_ROOT/lib/handler.sh
source $LIBRARY_ROOT/lib/io.sh
source $LIBRARY_ROOT/lib/string.sh
