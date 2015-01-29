#!/usr/bin/env bash
set -e

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

dir=$(pwd)
dir="${1:-$dir}"

watch_dirs=$(find $dir -name .watch | sed 's/\/.watch//g;' | xargs echo)

inotifywait -m -r -e create,moved_to,modify --format "%w%f" $watch_dirs | xargs -P 0 -I '{}' $script_dir/transpile.sh {}

