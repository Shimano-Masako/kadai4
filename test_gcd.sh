#!/bin/bash

tmp=/tmp/$$

# 回答準備（正解データの作成）
echo "2" > $tmp-ans-normal
echo "input 2 argments" > $tmp-args
echo "input natural number" > $tmp-nat

ERROR_EXIT () {
    echo "$1" >&2
    rm -f $tmp-*
    exit 1
}

# ---------------------------------------------
# テスト開始
# ---------------------------------------------

# テスト1：正常系（2と4を入力して2が出力されるか）
./gcd.sh 2 4 > $tmp-result
diff $tmp-ans-normal $tmp-result || ERROR_EXIT "error in test1: normal calculation failed"

# テスト2：異常系（引数の数が足りない）
# 実行が失敗（0以外を返す）することを確認し、エラー出力(2>)を保存
./gcd.sh 3 2> $tmp-result && ERROR_EXIT "error in test2-1: should fail but succeeded"
diff $tmp-args $tmp-result || ERROR_EXIT "error in test2-2: wrong error message"

# テスト3：異常系（文字を入力した場合）
./gcd.sh a b 2> $tmp-result && ERROR_EXIT "error in test3-1: should fail but succeeded"
diff $tmp-nat $tmp-result || ERROR_EXIT "error in test3-2: wrong error message"

# テスト4：異常系（負の数を入力した場合）
./gcd.sh -2 4 2> $tmp-result && ERROR_EXIT "error in test4-1: should fail but succeeded"
diff $tmp-nat $tmp-result || ERROR_EXIT "error in test4-2: wrong error message"

# 全テスト通過時の処理
echo "All tests OK"
rm -f $tmp-*
exit 0
