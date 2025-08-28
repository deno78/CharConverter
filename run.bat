@echo off
rem CharConverter 実行用バッチファイル
rem Groovy 2.4.21を使用してCharConverter.groovyを実行します

setlocal

rem 現在のディレクトリを取得
set BASE_DIR=%~dp0

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
echo.

rem Groovyスクリプトを実行
java -cp "%GROOVY_JAR%" groovy.ui.GroovyMain "%BASE_DIR%CharConverter.groovy"

echo.
echo 実行完了。何かキーを押してください...
pause >nul