# Adicionar a funcao de MessageBox
Add-Type -AssemblyName PresentationFramework `

#-------Variaveis---------#
$nameservice = 
$servico = Get-Service -Name $nameservice ` 
$status = $servico.status ` 
#O arquivo a seguir starCentral vai ser o responsavel por remover do sch o criado no else a baixo no codigo#
$schAction = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument '-NoProfile -WindowStyle Hidden -File "C:\Temp\scripts\StartCentral.txt"'

$schTrigger = New-ScheduledTaskTrigger -AtStartup 
$schPrincipal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest `


#--------------------------#
  

	if ($status -eq "Running")
{
	exit
}
else 
{ 
#-----------Registrar um novo agendador de tarefas para abrir o programa----------------#
 Register-ScheduledTask -Action $schAction -Trigger $schTrigger -TaskName "AbrirKSC" -Description "Abrir o KSC14 na inicializacao" -Principal $schPrincipal `
#-------------------------------------------#
# esse timeout de 300 segundo é uma segurança para dar tempo de cancelar a o restart ou remover do gerenciador de tarefas em caso de problemas #
Restart-Computer -Timeout 300 `

#--------- Mensagem para o Restart---------#
 [System.Windows.MessageBox]::Show("O Servidor sera reeniciado em breve!","Alerta", "OK","Warning") `
#------------------------------------------#

}

