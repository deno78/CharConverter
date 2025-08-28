@echo off
rem CharConverter 実行用バッチファイル
rem Groovy 2.4.21を使用してCharConverter.groovyを実行します
rem 使用方法: run.bat <文字設定ファイル> <入力ファイル> <出力ファイル>

setlocal

rem パラメータチェック
if "%~3"=="" (
    echo 使用方法: %0 ^<文字設定ファイル^> ^<入力ファイル^> ^<出力ファイル^>
    echo.
    echo 例: %0 mapping.txt input.txt output.txt
    pause
    exit /b 1
)

rem 現在のディレクトリを取得
set BASE_DIR=%~dp0

rem パラメータを設定
set MAPPING_FILE=%~1
set INPUT_FILE=%~2
set OUTPUT_FILE=%~3

rem Groovy jarファイルのパス
set GROOVY_JAR=%BASE_DIR%lib\groovy-all-2.4.21.jar

rem Javaがインストールされているかチェック
java -version >nul 2>&1
if errorlevel 1 (
    echo エラー: Javaがインストールされていません。
    echo Java 8以降をインストールしてください。
    pause
    exit /b 1
)

rem 入力ファイルが存在するかチェック
if not exist "%MAPPING_FILE%" (
    echo エラー: 文字設定ファイルが見つかりません。
    echo パス: %MAPPING_FILE%
    pause
    exit /b 1
)

if not exist "%INPUT_FILE%" (
    echo エラー: 入力ファイルが見つかりません。
    echo パス: %INPUT_FILE%
    pause
    exit /b 1
)

rem Groovy jarファイルが存在するかチェック
if not exist "%GROOVY_JAR%" (
    echo エラー: Groovy jarファイルが見つかりません。
    echo パス: %GROOVY_JAR%
    pause
    exit /b 1
)

rem CharConverter.groovyが存在するかチェック
if not exist "%BASE_DIR%CharConverter.groovy" (
    echo エラー: CharConverter.groovyが見つかりません。
    pause
    exit /b 1
)

echo CharConverter を実行中...
echo 文字設定ファイル: %MAPPING_FILE%
echo 入力ファイル: %INPUT_FILE%
echo 出力ファイル: %OUTPUT_FILE%
echo.

rem Groovyスクリプトを実行
java -cp "%GROOVY_JAR%" groovy.ui.GroovyMain "%BASE_DIR%CharConverter.groovy" "%MAPPING_FILE%" "%INPUT_FILE%" "%OUTPUT_FILE%"

echo.
echo 実行完了。何かキーを押してください...
pause >nul