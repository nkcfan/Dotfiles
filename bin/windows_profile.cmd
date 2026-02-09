SETLOCAL enabledelayedexpansion

REM Set path
:: This script uses PowerShell to update the PATH to avoid the 1024 character limit of setx.
set "P_CODE=$old = [Environment]::GetEnvironmentVariable('Path', 'User'); $add = '%USERPROFILE%\scoop\shims;%USERPROFILE%\bin'; if ($old -notlike '*$add*') { if ($old -and ($old[-1] -ne ';')) { $old += ';' } [Environment]::SetEnvironmentVariable('Path', $old + $add, 'User'); Write-Host 'PATH updated successfully.' -f Green } else { Write-Host 'Entries already exist.' -f Yellow }"
powershell -NoProfile -ExecutionPolicy Bypass -Command "%P_CODE%"

REM Start key agent and load all the keys
set "agent=kageant.exe"
set keylist=
pushd %USERPROFILE%\.ssh\
FOR /f "tokens=*" %%f IN ('DIR /B *.ppk') DO CALL SET "keylist=%%keylist%% %%~dpnXf"
popd
"%agent%" %keylist%

REM Set env var
setx XDG_CONFIG_HOME "%%USERPROFILE%%\.config"

