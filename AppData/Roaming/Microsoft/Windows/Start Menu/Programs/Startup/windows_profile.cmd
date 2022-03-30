SETLOCAL enabledelayedexpansion

set "agent=kageant.exe"
tasklist /nh /fi "imagename eq %agent%" | find /i "%agent%" > nul || (start "%agent%" "%agent%" && timeout /t 1 /nobreak)

set keylist=
pushd %USERPROFILE%\.ssh\
FOR /f "tokens=*" %%f IN ('DIR /B *.ppk') DO CALL SET "keylist=%%keylist%% %%~dpnXf"
popd
"%agent%" %keylist%
