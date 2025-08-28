#!/bin/bash
# Test script for CharConverter samples

echo "CharConverter サンプルファイルテスト"
echo "======================================="

cd "$(dirname "$0")/.."

# Test basic hiragana conversion
echo "1. ひらがな変換テスト..."
java -cp lib/groovy-all-2.4.21.jar groovy.ui.GroovyMain CharConverter.groovy \
    test-samples/basic-mapping.txt \
    test-samples/basic-input.txt \
    test-samples/basic-output.txt

if [ $? -eq 0 ]; then
    echo "✓ ひらがな変換テスト成功"
    echo "出力内容:"
    cat test-samples/basic-output.txt
    echo ""
else
    echo "✗ ひらがな変換テスト失敗"
fi

# Test kanji conversion
echo "2. 漢字変換テスト..."
java -cp lib/groovy-all-2.4.21.jar groovy.ui.GroovyMain CharConverter.groovy \
    test-samples/kanji-mapping.txt \
    test-samples/kanji-input.txt \
    test-samples/kanji-output.txt

if [ $? -eq 0 ]; then
    echo "✓ 漢字変換テスト成功"
    echo "出力内容:"
    cat test-samples/kanji-output.txt
    echo ""
else
    echo "✗ 漢字変換テスト失敗"
fi

# Test English conversion
echo "3. 英字変換テスト..."
java -cp lib/groovy-all-2.4.21.jar groovy.ui.GroovyMain CharConverter.groovy \
    test-samples/english-mapping.txt \
    test-samples/english-input.txt \
    test-samples/english-output.txt

if [ $? -eq 0 ]; then
    echo "✓ 英字変換テスト成功"
    echo "出力内容:"
    cat test-samples/english-output.txt
    echo ""
else
    echo "✗ 英字変換テスト失敗"
fi

# Test mixed character conversion
echo "4. 混合文字変換テスト..."
java -cp lib/groovy-all-2.4.21.jar groovy.ui.GroovyMain CharConverter.groovy \
    test-samples/mixed-mapping.txt \
    test-samples/mixed-input.txt \
    test-samples/mixed-output.txt

if [ $? -eq 0 ]; then
    echo "✓ 混合文字変換テスト成功"
    echo "出力内容:"
    cat test-samples/mixed-output.txt
    echo ""
else
    echo "✗ 混合文字変換テスト失敗"
fi

# Test empty mapping
echo "5. 空マッピングテスト..."
java -cp lib/groovy-all-2.4.21.jar groovy.ui.GroovyMain CharConverter.groovy \
    test-samples/empty-mapping.txt \
    test-samples/empty-test-input.txt \
    test-samples/empty-test-output.txt

if [ $? -eq 0 ]; then
    echo "✓ 空マッピングテスト成功"
    echo "出力内容:"
    cat test-samples/empty-test-output.txt
    echo ""
else
    echo "✗ 空マッピングテスト失敗"
fi

echo "テスト完了"