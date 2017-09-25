#!/bin/sh

###
### プロジェクトをセットアップするスクリプト
###   $ ./setup.sh
###

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

## フックスクリプトにシンボリックリンクをはる
HOOK_DIR=$DIR/hooks
TARGET_DIR=$DIR/.git/hooks
(
  cd "$HOOK_DIR"
  for hook in *; do
    ln -s -f -t "$TARGET_DIR" "../../hooks/$hook"
  done
)
