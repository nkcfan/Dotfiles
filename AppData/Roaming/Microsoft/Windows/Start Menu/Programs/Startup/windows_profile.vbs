' ref: https://superuser.com/a/140077/662568

Set oShell = CreateObject ("Wscript.Shell")
Dim strArgs
strArgs = "cmd /c %HOMEDRIVE%%HOMEPATH%\bin\windows_profile.cmd"
oShell.Run strArgs, 0, false
