SETLOCAL enabledelayedexpansion
set keylist=
pushd %USERPROFILE%\.ssh\
FOR /f "tokens=*" %%f IN ('DIR /B *.ppk') DO SET keylist=%keylist% %%~dpnxf
popd
%ChocolateyInstall%\bin\pageant.exe %keylist%
