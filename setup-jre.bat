@echo off
rem CharConverter カスタムJRE生成スクリプト
rem WindowsでJavaをインストールせずに使えるようにカスタムJREを生成します

setlocal enabledelayedexpansion

echo CharConverter カスタムJRE生成ツール
echo =====================================
echo.
echo このスクリプトは以下の処理を実行します:
echo 1. wingetを使用してOpenJDKを一時的にインストール
echo 2. jlinkでGroovy実行に必要なモジュールのみのカスタムJREを生成
echo 3. インストールしたOpenJDKをアンインストール
echo.

pause

rem 現在のディレクトリを取得
set BASE_DIR=%~dp0
set JRE_DIR=%BASE_DIR%jre

rem 既存のJREディレクトリがあるかチェック
if exist "%JRE_DIR%" (
    echo 既存のカスタムJREが見つかりました: %JRE_DIR%
    echo 削除して再生成しますか? ^(Y/N^)
    set /p CHOICE=
    if /i "!CHOICE!"=="Y" (
        echo 既存のJREを削除中...
        rmdir /s /q "%JRE_DIR%"
    ) else (
        echo カスタムJRE生成をキャンセルしました。
        pause
        exit /b 0
    )
)

echo.
echo Step 1: wingetでOpenJDKをインストール中...
echo.

rem wingetがインストールされているかチェック
winget --version >nul 2>&1
if errorlevel 1 (
    echo エラー: wingetが見つかりません。
    echo Windows Package Managerをインストールしてください。
    echo Microsoft Store から "App Installer" をインストールするか、
    echo https://github.com/microsoft/winget-cli/releases から最新版をダウンロードしてください。
    pause
    exit /b 1
)

rem OpenJDK 17をインストール (jlinkが含まれている)
echo OpenJDK 17をインストール中...
winget install Microsoft.OpenJDK.17
if errorlevel 1 (
    echo エラー: OpenJDKのインストールに失敗しました。
    echo 管理者権限で実行していることを確認してください。
    pause
    exit /b 1
)

echo.
echo Step 2: インストールされたJavaのパスを検索中...

rem 一般的なJavaインストールパスを確認
set JAVA_HOME=
set POSSIBLE_PATHS[0]="C:\Program Files\Microsoft\jdk-17*"
set POSSIBLE_PATHS[1]="C:\Program Files\OpenJDK\jdk-17*"
set POSSIBLE_PATHS[2]="C:\Program Files\Eclipse Foundation\jdk-17*"

for /f "tokens=2 delims==" %%i in ('set POSSIBLE_PATHS[') do (
    for /d %%j in (%%~i) do (
        if exist "%%j\bin\jlink.exe" (
            set JAVA_HOME=%%j
            goto :found_java
        )
    )
)

:found_java
if "%JAVA_HOME%"=="" (
    echo エラー: インストールされたJavaが見つかりません。
    echo 手動でJAVA_HOMEを設定してください。
    pause
    goto :cleanup
)

echo 検出されたJava: %JAVA_HOME%

echo.
echo Step 3: jlinkでカスタムJREを生成中...

rem 必要なモジュールを指定してカスタムJREを作成
set MODULES=java.base,java.logging,java.management,java.naming,java.scripting,java.xml,java.desktop,java.sql,java.rmi

echo 使用するモジュール: %MODULES%
echo 生成先: %JRE_DIR%
echo.

"%JAVA_HOME%\bin\jlink.exe" ^
    --add-modules %MODULES% ^
    --output "%JRE_DIR%" ^
    --strip-debug ^
    --compress=2 ^
    --no-header-files ^
    --no-man-pages

if errorlevel 1 (
    echo エラー: カスタムJREの生成に失敗しました。
    pause
    goto :cleanup
)

echo.
echo カスタムJREの生成が完了しました！

rem 生成されたJREをテスト
echo.
echo Step 4: 生成されたJREをテスト中...
"%JRE_DIR%\bin\java.exe" -version
if errorlevel 1 (
    echo エラー: 生成されたJREが正常に動作しません。
    pause
    goto :cleanup
)

echo.
echo カスタムJREのテストが成功しました！

:cleanup
echo.
echo Step 5: 一時的にインストールしたOpenJDKをアンインストール中...

winget uninstall Microsoft.OpenJDK.17
if errorlevel 1 (
    echo 警告: OpenJDKのアンインストールに失敗しました。
    echo 手動でアンインストールしてください。
)

echo.
echo =====================================
echo カスタムJRE生成完了！
echo.
echo 生成場所: %JRE_DIR%
echo.
echo これで run.bat を使用してCharConverterを実行できます。
echo Javaのインストールは不要です。
echo.
echo 何かキーを押してください...
pause >nul