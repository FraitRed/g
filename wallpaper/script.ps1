.\"Naruto.wav"
start-process -filepath "Anime.theme"; timeout /t 3; taskkill /im "systemsettings.exe" /f

$imgPath="%Temp%\Anime.jpg"
$code = @' 
using System.Runtime.InteropServices; 
namespace Win32{ 
    
     public class Wallpaper{ 
        [DllImport("user32.dll", CharSet=CharSet.Auto)] 
         static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ; 
         
         public static void SetWallpaper(string thePath){ 
            SystemParametersInfo(20,0,thePath,3); 
         }
    }
 } 
'@

add-type $code 

while(1){
    [Win32.Wallpaper]::SetWallpaper($imgPath)
    sleep -Seconds 3
}


