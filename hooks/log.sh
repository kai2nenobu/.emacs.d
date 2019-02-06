#!/bin/bash

quoted=()
for t in "$0" "$@"; do
  quoted+=("$(printf %q "$t")")
done

log="${TMPDIR:-/tmp}/git-hooks.log"
{
  ts=$(date +%Y-%m-%dT%H:%M:%S.%3N%z)
  printf "%s cd %q && " "$ts" "$PWD"
  for e in $(compgen -e GIT_); do
    printf '%q=%q ' "$e" "${!e}"
  done
  printf "%s\n" "${quoted[*]}"
} >> "$log"

# 作業のじゃまをしないようキッチリ0で終了する
exit 0
