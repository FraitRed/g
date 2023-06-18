Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -Ep Bypass %Temp%\script.ps1", 0, false