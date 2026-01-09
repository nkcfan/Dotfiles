SETLOCAL enabledelayedexpansion

REM Start key agent and load all the keys
set "agent=kageant.exe"
set keylist=
pushd %USERPROFILE%\.ssh\
FOR /f "tokens=*" %%f IN ('DIR /B *.ppk') DO CALL SET "keylist=%%keylist%% %%~dpnXf"
popd
"%agent%" %keylist%

REM Set env var
setx XDG_CONFIG_HOME "%%USERPROFILE%%\.config"

REM Set path
setx PATH "%PATH%;%%USERPROFILE%%\bin"
