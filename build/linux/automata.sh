#!/bin/sh
printf '\033c\033]0;%s\a' automata
base_path="$(dirname "$(realpath "$0")")"
"$base_path/automata.x86_64" "$@"
