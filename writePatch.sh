#!/bin/bash
#
# Write formatted patch file from all binary files
#
# Arguments: OUTFILE GOTHIC_BASE_VERSION(1 or 2) SOURCEDIR [INFILE]
#
function usage {
    echo "Usage: ${0##*/} OUTFILE GOTHIC_BASE_VERSION(1 or 2) SOURCEDIR [INFILE]"
    exit
}

# Path to sub scripts
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
getAddress=$dir/getAddress.sh
getOrigHex=$dir/getOrigHex.sh
getVersion=$dir/getVersion.sh

# Sanity check
[ -z $1 ]    && usage
[ -z $1 ]    && usage
[ -z $3 ]    && usage
[ $2 -lt 1 ] && usage
[ $2 -gt 2 ] && usage
gothic=$2

# Verify indir
indir=$3
[ "${indir: -1}" = "*" ] && indir=${indir:0:-1}
[ "${indir: -1}" = "/" ] && indir=${indir:0:-1}
[ ! -d "$indir" ] && echo "$3 is not a directory." && exit 1
indir="$indir/*"

# Verify outfile
outfile=./$1
outextn=${outfile##*.}
outpath=${outfile%/*}

shopt -s nocasematch
[ ! "$outextn" = "patch" ] && echo "$1: Incorrect file extension. *.patch expected." && shopt -u nocasematch && exit 2
shopt -u nocasematch
mkdir -p $outpath

# Verify inFILE if present
if [ ! -z $4 ]
then
    shopt -s nocasematch
    [ ! "${4##*.}" = "patch" ] && echo "$4: Incorrect file extension. *.patch expected." \
        && shopt -u nocasematch && exit 3
    shopt -u nocasematch
    [ ! -e "$4" ] && echo "$4: File not found." && exit 4
    cp "$4" "$outfile"
    echo "" >> "$outfile"
    echo "" >> "$outfile"
    echo "" >> "$outfile"
    echo "" >> "$outfile"
    echo "" >> "$outfile"
else
    touch "$outfile"
fi

# Get date
yearmonth=$(date +"%Y-%m")

# Get version
version=$("$getVersion")
[ "$?" -ne 0 ] && echo "$getVersion failed." && exit 6
[ -z "$version" ] && echo "$getVersion failed to execute." && exit 7

# Write outfile header
echo "////////////////////////////////"                          >> "$outfile"
[ $gothic -eq 1 ] && echo "// NINJA $version (GothicMOD.exe) //" >> "$outfile"
[ $gothic -eq 2 ] && echo "//  NINJA $version (Gothic2.exe)  //" >> "$outfile"
echo "// mud-freak (@szapp) $yearmonth //"                       >> "$outfile"
echo "// http://tiny.cc/GothicNinja //"                          >> "$outfile"
echo "////////////////////////////////"                          >> "$outfile"

function fileloop {
    # Parse file name
    filefull=$1
    filename=${1##*/}
    fileextn=${filename##*.}
    filebase=${filename%.$fileextn}
    fileobin=${dir}/bin/${filebase}_g${gothic}

    # Assertions on file name
    shopt -s nocasematch
    [ ! "$fileextn" = "asm" ] && shopt -u nocasematch && return 0
    shopt -u nocasematch
    [ ! -f "$filefull" ] && return 0
    [ ! -f "$fileobin" ] && echo "Warning: File '$fileobin' not found." && return 0

    # Retrieve address
    address=$("$getAddress" "$filefull" $gothic)
    [ -z "$address" ] && echo "$getAddress failed to execute." && return 1

    # Format binary to hex literals
    hexstr=$(hexdump -v -e '/1 "%02X "' "$fileobin")
    [ "$?" -ne 0 ] && echo "$filename: hexdump failed." && return 1
    [ -z "$hexstr" ] && echo "hexdump failed to execute." && return 1
    hexstr=${hexstr%* }

    # Retrieve original hex string, if present
    orghex=$("$getOrigHex" "$filefull" $gothic)
    [ "$?" -ne 0 ] && echo "$filename: $getOrigHex failed." && return 1

    # Write to output file
    echo ""                                        >> "$outfile"
    echo "[ninja_${version}_$filebase]"            >> "$outfile"
    echo "Addr = \"$address\""                     >> "$outfile"
    echo "Type = \"hex\""                          >> "$outfile"
    [ ! -z "$orghex" ] && echo "Org = \"$orghex\"" >> "$outfile"
    echo "New = \"$hexstr\""                       >> "$outfile"
}

# Process files
for f in `ls -v $indir`
do
    fileloop "$f" || exit 8
done

exit 0
