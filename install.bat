@echo off
chcp 65001>nul

rem 相关变量
set SUBCONVERT_HOME=\path\to\subconverter
set SUBSCRIBE_URL=https://subscribe/url
set PROFILE_TOKEN=yourtoken

cd %CD%

rem 主循环

:main
  echo Usage: [ACTION]
  echo ACTION:
  echo    build:    Clone rules repo
  echo    config:   Modify some parameters.
  echo    install:  Copy files to subconverter dir
  echo    exit:     Exit
:input
  set /p a="输入相应的命令: "
  if /i '%a%'=='build' goto _build
  if /i '%a%'=='config' goto _config
  if /i '%a%'=='install' goto _install
  if /i '%a%'=='exit' goto _end
  echo 输入错误,请重新输入: & goto input

:_build
  rd /s/q Rules
  git clone https://github.com/L0snight/Rules.git --recursive
  echo Clone Rules repo finished
  echo.
  pause
  goto :main

:_config
  powershell -Command "(gc %SUBCONVERT_HOME%/pref-new.yml) -replace 'api_access_token.*','api_access_token: %PROFILE_TOKEN%' | Out-File -encoding UTF8 %SUBCONVERT_HOME%/pref-new.yml"
  powershell -Command "(gc profiles/clash.ini) -replace '^url=.*$','url=%SUBSCRIBE_URL%' | Out-File -encoding UTF8 profiles/clash.ini"
  echo Config finished
  echo.
  pause
  goto :main

:_install
  xcopy /s/e/y base "%SUBCONVERT_HOME%/base"
  xcopy /s/e/y config "%SUBCONVERT_HOME%/config"
  xcopy /s/e/y profiles "%SUBCONVERT_HOME%/profiles"
  md "%SUBCONVERT_HOME%/Rules"
  xcopy /s/e/y Rules "%SUBCONVERT_HOME%/Rules"
  md "%SUBCONVERT_HOME%/template"
  xcopy /s/e/y template "%SUBCONVERT_HOME%/template" 
  echo F | xcopy /y "%SUBCONVERT_HOME%\pref-new.yml" "%SUBCONVERT_HOME%\pref.yml"
  echo Install finished
  echo.
  pause
  goto :main

:_end
  goto:EOF