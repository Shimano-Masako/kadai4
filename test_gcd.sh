#!/bin/bash
tmp=/tmp/$$

# エラー終了用関数（エラーメッセージ表示と一時ファイル削除） [cite: 2288, 2289, 2290]
ERROR_EXIT () {
    echo "$1" >&2
    rm -f $tmp-*
    exit 1
}

# -------------------------
# 1. 正常系の動作確認
# -------------------------
# 例：2と4を入力して2を出力するか
echo "2" > $tmp-ans
./gcd.sh 2 4 > $tmp-result
diff $tmp-ans $tmp-result || ERROR_EXIT "Test Failed: Input(2, 4) did not output 2"

# 例：3と9を入力して3を出力するか
echo "3" > $tmp-ans
./gcd.sh 3 9 > $tmp-result
diff $tmp-ans $tmp-result || ERROR_EXIT "Test Failed: Input(3, 9) did not output 3"

# -------------------------
# 2. 異常系の動作確認（エラー終了の確認）
# -------------------------
# 引数が少ない場合（3のみ入力）
./gcd.sh 3 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    ERROR_EXIT "Test Failed: No error message for single argument"
fi

# 文字を入力した場合
./gcd.sh a b > /dev/null 2>&1
if [ $? -eq 0 ]; then
    ERROR_EXIT "Test Failed: No error message for character input"
fi

# 負の数を入力した場合
./gcd.sh -2 4 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    ERROR_EXIT "Test Failed: No error message for negative numbers"
fi

# すべてのテストに成功した場合
echo "All tests passed!"
rm -f $tmp-*
exit 0
