#!/bin/bash

# テスト実行用の関数
test_case() {
    expected=$1
    input1=$2
    input2=$3
    result=$(./gcd.sh $input1 $input2 2>/dev/null)
    
    if [ "$result" = "$expected" ]; then
        echo "Test Passed: Input($input1, $input2) -> Expected($expected)"
    else
        echo "Test Failed: Input($input1, $input2) -> Expected($expected), but got($result)"
        exit 1
    fi
}

# エラー系のテスト関数
test_error() {
    ./gcd.sh $@ >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Test Passed: Error case ($@) caught."
    else
        echo "Test Failed: Error case ($@) was not caught."
        exit 1
    fi
}

# 1. 正常系テスト
test_case 2 2 4
test_case 3 9 12
test_case 1 7 13

# 2. 異常系テスト
test_error 1         # 引数が1つ
test_error a b       # 文字列
test_error -1 5      # 負の数
test_error           # 引数なし

echo "All tests passed!"
exit 0
