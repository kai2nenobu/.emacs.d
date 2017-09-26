#!/bin/sh

###
### プロジェクトをセットアップするスクリプト
###   $ ./setup.sh
###

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

force=false
while getopts :f OPT; do
  case $OPT in
    f|+f)
      force=true
      ;;
    *)
      echo "usage: `basename $0` [+-f} [--] ARGS..."
      exit 2
  esac
done
shift `expr $OPTIND - 1`
OPTIND=1

## フックスクリプトにシンボリックリンクをはる
hook_dir=$DIR/hooks
target_dir=$DIR/.git/hooks
(
  cd "$hook_dir"
  for hook in *; do
    target_hook=${target_dir}/${hook}
    if [ $force = "false" ] && [ -e "$target_hook" ]; then
      echo "${target_hook} already exists. If you want to overwite, Add \"-f\" option." 2>&1
      exit 1
    fi
    rm -rf "$target_hook"
    ln -s -f -t "$target_dir" "../../hooks/$hook"
  done
)
