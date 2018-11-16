#!/bin/bash
#
# Extract all global symbols from assembly files and format them into a macro file
#
# Arguments: OUTFILE.ASM GOTHIC-BASE-VERSION(1 or 2) SOURCE.ASM [SOURCE.ASM ...]
#
function usage {
    echo "Usage: ${0##*/} OUTFILE.ASM GOTHIC-BASE-VERSION(1 or 2) SOURCE.ASM [SOURCE.ASM ...]"
    exit
}

# Path to getAddress.sh
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
getAddress=$dir/getAddress.sh

# Sanity check
[ -z $1 ]    && usage
[ -z $1 ]    && usage
[ -z $3 ]    && usage
[ $2 -lt 1 ] && usage
[ $2 -gt 2 ] && usage
gothic=$2

# Write file header
outfile=$1
echo "; This file was auto generated. Do not modify!" > "$outfile"

function processfile {
    # Parse file name
    filefull=./$1
    filepath=${filefull%/*}/
    filename=${1##*/}
    fileextn=${filename##*.}
    filebase=${filename%.$fileextn}

    # Assertions on file name
    shopt -s nocasematch
    [ ! "$fileextn" = "asm" ] && echo "$filename: Incorrect file extension. *.asm expected." \
        && shopt -u nocasematch && exit 2
    shopt -u nocasematch
    [ ! -f "$filefull" ] && echo "File '$filefull' not found." && exit 3

    nasm -DGOTHIC_BASE_VERSION=$gothic -I"$filepath" -f elf32 -o temp.o "$filefull" || exit 4

    # Retrieve address
    address=$("$getAddress" "$filefull" $gothic)
    [ "$?" -ne 0 ] && echo "$filename: $getAddress failed." && exit 5
    [ -z "$address" ] && echo "$filename: $getAddress failed to execute." && exit 6

    # Retrieve all external symbols from functions elf
    symbols=$(objdump -t temp.o --adjust-vma=$address -j .text | grep " g  ")
    [ $? -ne 0 ] && echo "$filename: objdump failed." && exit 7

    # Reformat names and addresses into NASM macro syntax
    while read -r line; do
        echo -e "%define $(echo $line | cut -d' ' -f5) 0x$(echo $line | cut -d' ' -f1)" >> "$outfile"
    done <<< "$symbols"

    # Clean up temporary file
    rm temp.o
}

# Iterate over source files
count=0
for n in "$@"
do
    count=$[$count+1]
    [ $count -gt 2 ] && processfile $n
done

exit
