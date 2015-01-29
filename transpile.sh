#!/usr/bin/env bash
set -e

source=$1

[ -z "$source" ] && read source
[ -z "$source" ] && >&2 echo "No file specified" && exit 1

echo $source

source=$(readlink -f $source)
dir=$(dirname $source)

while [ -n "$dir" -a "$dir" != "/" ]; do
	watch="$dir/.watch"
	[ -f "$watch" ] && break
	
	dir=$(dirname $dir)
	watch=""
done

[ -z "$watch" ] && >&2 echo "Can't find .watch file for $source" && exit 1

dir=$(dirname $source)
filename=$(basename "$source")
ext="${filename##*.}"
filename="${filename%.*}"

source_r=$(echo $source | sed 's/[\/&]/\\&/g')
dir_r=$(echo $dir | sed 's/[\/&]/\\&/g')

cmd=$(cat $watch | grep -E "^$ext\:" | sed -E "s/[^:]+\://;s/\{\}/$source_r/g;s/%fe/$filename.$ext/g;s/%f/$filename/g;s/%w/$dir_r/g;")

[ -z "$cmd" ] && echo "No transpile options for .$ext" && exit 0

eval $cmd

