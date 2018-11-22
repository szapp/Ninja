#!/bin/bash
#
# Read original hex bytes from assembly file
#
# Arguments: SOURCE.ASM GOTHIC-BASE-VERSION(1 or 2)
#
function usage {
    echo "Usage: ${0##*/} SOURCE.ASM GOTHIC-BASE-VERSION(1 or 2)"
    exit
}

# Sanity check
[ -z $1 ]    && usage
[ -z $2 ]    && usage
[ $2 -lt 1 ] && usage
[ $2 -gt 2 ] && usage

# Parse file name
filefull=$1
filename=${1##*/}
fileextn=${filename##*.}
filebase=${filename%.$fileextn}

# Assertions on file name
shopt -s nocasematch
[ ! "$fileextn" = "asm" ] && echo "Incorrect file extension. *.asm expected." && shopt -u nocasematch && exit 1
shopt -u nocasematch
[ ! -f "$filefull" ] && echo "File '$filefull' not found." && exit 2

# Grep hex string from comment
cat $filefull \
    | grep -ioP "[[:blank:]]*;[[:blank:]]*orig[[:blank:]]+g$2:[[:blank:]]*(?:[[:xdigit:]]{2}[[:blank:]]*)+" \
    | grep -ioP "(?:[[:xdigit:]]{2}[[:blank:]]*)+"

exit 0
