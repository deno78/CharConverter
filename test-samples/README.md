# CharConverter テストサンプル

このディレクトリには、CharConverterの単体テストおよび受け入れテスト用のサンプルファイルが含まれています。

## ファイル構成

### 文字変換設定ファイル（マッピングファイル）

1. **basic-mapping.txt** - ひらがな変換のサンプル
   - あ→い、か→き、さ→し、た→ち、な→に

2. **kanji-mapping.txt** - 漢字変換のサンプル
   - 人→大、本→木、日→月、山→川、水→火

3. **english-mapping.txt** - 英字変換のサンプル
   - A→B、E→F、I→J、O→P、U→V

4. **mixed-mapping.txt** - 混合文字変換のサンプル
   - ひらがな、漢字、英字の組み合わせ

5. **empty-mapping.txt** - 空のマッピングファイル（エラーケーステスト用）

### 入力ファイル

1. **basic-input.txt** - ひらがなを含むテスト文章
2. **kanji-input.txt** - 漢字を含むテスト文章
3. **english-input.txt** - 英字を含むテスト文章
4. **mixed-input.txt** - 混合文字を含むテスト文章
5. **empty-test-input.txt** - 空マッピングテスト用の入力文章

### テストスクリプト

- **run-tests.sh** - Linux/Mac用のテスト実行スクリプト
- **run-tests.bat** - Windows用のテスト実行スクリプト

## 使用方法

### 個別テスト実行例

```bash
# ひらがな変換テスト
java -cp lib/groovy-all-2.4.21.jar groovy.ui.GroovyMain CharConverter.groovy \
    test-samples/basic-mapping.txt \
    test-samples/basic-input.txt \
    test-samples/basic-output.txt

# 漢字変換テスト  
java -cp lib/groovy-all-2.4.21.jar groovy.ui.GroovyMain CharConverter.groovy \
    test-samples/kanji-mapping.txt \
    test-samples/kanji-input.txt \
    test-samples/kanji-output.txt
```

### Windows用バッチファイルでのテスト実行例

```cmd
run.bat test-samples\basic-mapping.txt test-samples\basic-input.txt test-samples\basic-output.txt
run.bat test-samples\kanji-mapping.txt test-samples\kanji-input.txt test-samples\kanji-output.txt
```

### 一括テスト実行

```bash
# Linux/Mac
./test-samples/run-tests.sh

# Windows
test-samples\run-tests.bat
```

## 期待される結果

各テストケースは以下のような変換を行います：

1. **basic-mapping** - ひらがなのあかさたな行が次の文字に変換される
2. **kanji-mapping** - 指定された漢字が別の漢字に変換される
3. **english-mapping** - 英語の母音文字が次のアルファベットに変換される
4. **mixed-mapping** - 複数の文字種が同時に変換される
5. **empty-mapping** - 何も変換されず、元の文字がそのまま出力される

## 注意事項

- すべてのファイルはUTF-8エンコーディングで保存されています
- テスト実行後、対応する出力ファイル（*-output.txt）が生成されます
- 出力ファイルの内容を確認して、期待通りの変換が行われているかテストしてください