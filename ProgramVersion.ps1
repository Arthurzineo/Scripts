$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion 
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion


$version = $INSTALLED | Where-Object -Property DisplayName -EQ 'Agente de Rede do Kaspersky Security Center'
$version = $version.DisplayVersion
$version = $version | Select-Object -First 1

if ($version -like '14.0.0.10902'){
 exit
}




Ver tudo ==
$INSTALLED | ?{ $_.DisplayName -ne $null } | sort-object -Property DisplayName -Unique | Format-Table -AutoSize