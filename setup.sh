#!/bin/sh

###
### プロジェクトをセットアップするスクリプト
###   $ ./setup.sh
###

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

## フックスクリプトにシンボリックリンクをはる
hook_dir=$DIR/hooks
target_dir=$DIR/.git/hooks
(
  cd "$hook_dir"
  for hook in *; do
    ln -s -f -t "$target_dir" "../../hooks/$hook"
  done
)
