#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source_file="$HOME/.config/karabiner/karabiner.json"
target_file="$repo_dir/karabiner.json"

jq empty "$source_file"
cp "$source_file" "$target_file"

printf 'Updated %s from %s\n' "$target_file" "$source_file"
