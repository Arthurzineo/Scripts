
# Definir os parametros para o programa funcionar. 
$LoopDuration = New-TimeSpan -Seconds 120
$Delay = New-TimeSpan -Seconds 5
$analise = 83



$StartTime = Get-Date


do {
    # Get the current memory usage and timestamp
    $CompObject = Get-WmiObject -Class WIN32_OperatingSystem
    $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory) * 100) / $CompObject.TotalVisibleMemorySize)
    $Timestamp = Get-Date

    # Get the top 5 processes using the most memory
    $Top5Processes = Get-Process | Sort-Object -Descending -Property WS | Select-Object -First 5 | Select-Object -Property Name, WS | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 | Out-String


$OutputFile = "C:\temp\MemoryUsage.csv"
$OutputHeader = "MemoryUsagePercentage", "Timestamp", "Top5Processes"
$OutputObject = New-Object -TypeName PSObject -Property @{
    "MemoryUsagePercentage" = $Memory
    "Timestamp" = $Timestamp
    "Top5Processes" = $Top5Processes
}
$OutputObject | Export-Csv -Path $OutputFile -NoTypeInformation -Append

    # Wait for the delay period
    Start-Sleep -Seconds $Delay.TotalSeconds

} until ((Get-Date) - $StartTime -ge $LoopDuration)

continue 

Start-Sleep -Seconds 60

Set-ExecutionPolicy Unrestricted -force
$csv = Import-Csv "C:\Temp\MemoryUsage.csv"
$results = @()

foreach ($linha in $csv) {
    $calc = $linha.memoryusagePercentage
    $memoryUsage = $calc.Substring(0,2)
    
    if ([int]($memoryUsage) -gt $analise) {
        "Aviso alto uso de memoria: ($memoryUsage%)"
        
        $result = New-Object -TypeName PSObject -Property @{
            ServerName = $linha.ServerName
            MemoryUsagePercentage = $linha.MemoryUsagePercentage
            Timestamp = $linha.Timestamp
            Warning = "Memory usage is above $analise+1 %"
        }
        
        $results += $result
    }
}

if ($results.Count -gt 0) {
    $results | Export-Csv -Path "C:\Temp\MemoryUsageWarnings.csv" -NoTypeInformation
}
exit



