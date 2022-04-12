SETLOCAL enabledelayedexpansion

set "agent=kageant.exe"

set keylist=
pushd %USERPROFILE%\.ssh\
FOR /f "tokens=*" %%f IN ('DIR /B *.ppk') DO CALL SET "keylist=%%keylist%% %%~dpnXf"
popd
"%agent%" %keylist%
