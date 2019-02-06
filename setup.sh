#!/bin/sh

###
### プロジェクトをセットアップするスクリプト
###
### 【実行方法】
###   $ ./setup.sh
###

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# フックスクリプトの場所を変更する
git config core.hooksPath 'hooks'

# シンボリックリンクを有効にする
git config core.symlinks true
