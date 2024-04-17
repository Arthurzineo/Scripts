$webSite = Read-Host -Prompt "Digite o URL do site"

$user = "Prova"

$Sid = (Get-LocalUser -Name $user).SID.Value

$profile = Get-ItemPropertyValue "HKLM:\SOFTWARE\Microsoft\Windows\AssignedAccessConfiguration\Configs\$Sid" -Name DefaultProfileId

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\AssignedAccessConfiguration\Profiles\$profile\AllowedApps\App0"

Set-ItemProperty -Path $regPath -Name "Arguments" -Value "--no-first-run --kiosk $webSite --kiosk-idle-timeout-minutes=0 --edge-kiosk-type=fullscreen --disable-features=Translate,msWebOOUI,msPdfOOUI" 
