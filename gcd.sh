#!/bin/bash

# 引数の数が2でない場合はエラー終了 
if [ $# -ne 2 ]; then
    echo "Error: Input 2 arguments" 1>&2
    exit 1
fi

# 引数が数値かどうかを expr コマンドで判定 
expr $1 + $2 > /dev/null 2>&1
if [ $? -ge 2 ]; then
    echo "Error: Input natural number" 1>&2
    exit 1
fi

# 自然数（1以上）かどうかの判定
if [ $1 -le 0 ] || [ $2 -le 0 ]; then
    echo "Error: Input natural numbers greater than 0" 1>&2
    exit 1
fi

a=$1
b=$2

# ユークリッドの互除法による最大公約数の計算
while [ $b -ne 0 ]
do
    tmp=$((a % b))
    a=$b
    b=$tmp
done

echo $a
