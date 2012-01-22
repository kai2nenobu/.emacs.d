#!/bin/bash
# Aurora 2 データベースの中身を詳細に調べるために試行錯誤

Aurora_dir=~/AURORA-2
speech_dir=${Aurora_dir}/speechdata

for file in $(find "$speech_dir/testa" -type f | grep -e 'FLR_.*\.wav' | sort -t '/' -k 8); do
    echo "Would you like to play ${file}?"
    aplay ${file} < /dev/null
    echo ""
done

