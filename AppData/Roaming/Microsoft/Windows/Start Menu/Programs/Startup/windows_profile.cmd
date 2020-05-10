SETLOCAL enabledelayedexpansion
set keylist=
pushd %USERPROFILE%\.ssh\
FOR /f "tokens=*" %%f IN ('DIR /B *.ppk') DO CALL SET "keylist=%%keylist%% %%~dpnXf"
popd
%ChocolateyInstall%\bin\kageant.exe %keylist%
