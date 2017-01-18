@echo Off
pushd %~dp0
setlocal

:Build

pushd demo

call bundle install
if %ERRORLEVEL% neq 0 goto BuildFail

call bundle exec jekyll build
if %ERRORLEVEL% neq 0 goto BuildFail

popd

goto BuildSuccess

:BuildFail
echo.
echo *** build.demo.cmd FAILED ***
goto End

:BuildSuccess
echo.
echo *** build.demo.cmd SUCCEEDED ***
goto End

:End
echo.
popd
exit /B %ERRORLEVEL%
