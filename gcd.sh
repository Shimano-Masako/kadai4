#!/bin/bash

# 引数の数が2つでない場合はエラー
if [ $# -ne 2 ]; then
    echo "Usage: $0 <num1> <num2>" >&2
    exit 1
fi

# 自然数（正の整数）かどうかのチェック
expr "$1" + 0 >/dev/null 2>&1
res1=$?
expr "$2" + 0 >/dev/null 2>&1
res2=$?

if [ $res1 -ge 2 ] || [ $res2 -ge 2 ] || [ "$1" -lt 1 ] || [ "$2" -lt 1 ]; then
    echo "Error: Input must be natural numbers." >&2
    exit 1
fi

a=$1
b=$2

# ユークリッドの互除法
while [ $b -ne 0 ]
do
    tmp=$((a % b))
    a=$b
    b=$tmp
done

echo $a
