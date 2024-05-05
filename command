$l = Invoke-WebRequest -Uri "https://github.com/FraitRed/g/blob/main/link"
$l.Content -match 'rawLines":..(.*?)..,'
$link = $Matches[1]
sleep -Seconds 5
[system.Diagnostics.Process]::Start("msedge",$link)
