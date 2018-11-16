#!/bin/bash
#
# Read global version information from the macro file
#
# Arguments: None
#

# Macro file
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
filefull=$dir/src/inc/macros.mac

# Assertions on file name
[ ! -f "$filefull" ] && echo "File '$filefull' not found." && exit 1

# Grep hex string from comment
cat $filefull \
    | grep -ioP "[[:blank:]]*.define[[:blank:]]+NINJA_VERSION[[:blank:]]+'v[\w\.-]+'" \
    | grep -ioP "(?<=')v[\w\.-]+(?=')"
