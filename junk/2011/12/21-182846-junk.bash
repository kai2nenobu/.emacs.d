#!/bin/bash
# bash で1文字ずつ処理する試行錯誤
# むちゃくちゃ bash 依存してるけどまあいいか

echo "amms e@ms" |
while read line; do
    printf "%s " $(echo $line | cut -d ' ' -f 1)
    ph=$(echo $line | cut -d ' ' -f 2)
    for ((i=0; i<${#ph}; i++)); do
        printf "%s " ${ph:i:1}
    done
done