@echo off
rem CharConverter サンプルファイルテスト（Windows版）
setlocal

echo CharConverter サンプルファイルテスト
echo =======================================
echo.

rem 現在のディレクトリを取得
set BASE_DIR=%~dp0..
set GROOVY_JAR=%BASE_DIR%\lib\groovy-all-2.4.21.jar

rem カスタムJREのパス
set CUSTOM_JRE=%BASE_DIR%\jre
set JAVA_CMD=java

rem カスタムJREが存在するかチェック
if exist "%CUSTOM_JRE%\bin\java.exe" (
    echo カスタムJREを使用します: %CUSTOM_JRE%
    set JAVA_CMD="%CUSTOM_JRE%\bin\java.exe"
) else (
    echo システムのJavaを使用します
)

rem 1. ひらがな変換テスト
echo 1. ひらがな変換テスト...
%JAVA_CMD% -cp "%GROOVY_JAR%" groovy.ui.GroovyMain "%BASE_DIR%\CharConverter.groovy" test-samples\basic-mapping.txt test-samples\basic-input.txt test-samples\basic-output.txt

if %errorlevel% equ 0 (
    echo ✓ ひらがな変換テスト成功
    echo 出力内容:
    type test-samples\basic-output.txt
    echo.
) else (
    echo ✗ ひらがな変換テスト失敗
)

rem 2. 漢字変換テスト
echo 2. 漢字変換テスト...
%JAVA_CMD% -cp "%GROOVY_JAR%" groovy.ui.GroovyMain "%BASE_DIR%\CharConverter.groovy" test-samples\kanji-mapping.txt test-samples\kanji-input.txt test-samples\kanji-output.txt

if %errorlevel% equ 0 (
    echo ✓ 漢字変換テスト成功
    echo 出力内容:
    type test-samples\kanji-output.txt
    echo.
) else (
    echo ✗ 漢字変換テスト失敗
)

rem 3. 英字変換テスト
echo 3. 英字変換テスト...
%JAVA_CMD% -cp "%GROOVY_JAR%" groovy.ui.GroovyMain "%BASE_DIR%\CharConverter.groovy" test-samples\english-mapping.txt test-samples\english-input.txt test-samples\english-output.txt

if %errorlevel% equ 0 (
    echo ✓ 英字変換テスト成功
    echo 出力内容:
    type test-samples\english-output.txt
    echo.
) else (
    echo ✗ 英字変換テスト失敗
)

rem 4. 混合文字変換テスト
echo 4. 混合文字変換テスト...
%JAVA_CMD% -cp "%GROOVY_JAR%" groovy.ui.GroovyMain "%BASE_DIR%\CharConverter.groovy" test-samples\mixed-mapping.txt test-samples\mixed-input.txt test-samples\mixed-output.txt

if %errorlevel% equ 0 (
    echo ✓ 混合文字変換テスト成功
    echo 出力内容:
    type test-samples\mixed-output.txt
    echo.
) else (
    echo ✗ 混合文字変換テスト失敗
)

rem 5. 空マッピングテスト
echo 5. 空マッピングテスト...
%JAVA_CMD% -cp "%GROOVY_JAR%" groovy.ui.GroovyMain "%BASE_DIR%\CharConverter.groovy" test-samples\empty-mapping.txt test-samples\empty-test-input.txt test-samples\empty-test-output.txt

if %errorlevel% equ 0 (
    echo ✓ 空マッピングテスト成功
    echo 出力内容:
    type test-samples\empty-test-output.txt
    echo.
) else (
    echo ✗ 空マッピングテスト失敗
)

echo テスト完了
echo.
echo 何かキーを押してください...
pause >nul