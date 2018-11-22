#!/bin/bash
#
# Read starting address (ORG) from assembly file
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

# Grep addresses from org decorator
addr=$(cat $filefull \
    | grep -iP "[[:blank:]]*org[[:blank:]]+(\w+\()?[[:blank:]]*((0x)?[[:xdigit:]]{6,8})" \
    | grep -ioP "(?:0x)?[[:xdigit:]]{6,8}")

# None found
[ -z "$addr" ] && echo "Requested address not found" && exit 3

echo $addr | cut -d' ' -f$2

exit
