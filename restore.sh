#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source_file="$repo_dir/karabiner.json"
target_dir="$HOME/.config/karabiner"
target_file="$target_dir/karabiner.json"

jq empty "$source_file"
mkdir -p "$target_dir"
cp "$source_file" "$target_file"

printf 'Restored %s\n' "$target_file"
printf 'Restart Karabiner-Elements if it does not reload automatically.\n'
