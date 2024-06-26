#set-ExecutionPolicy -ExecutionPolicy Unrestricted -force


$sname = 'Prova' ;


$sessionInfo = query session | Out-String ;
$loggedIn = $sessionInfo -match $sname ;
$lines = $sessionInfo -split "`n";
$filteredSessions = $lines | Where-Object { $_ -match $sname };
#if your language is different see the name of the active user status and change
$filteredSessionsEN = $filteredSessions -match 'ACTIVE';
$filteredSessions = $filteredSessions -match 'ATIVO';

# for PT-BR OS or ENOS

if($filteredSessions -OR $filteredSessionsEN){
    
   exit;
}
else{
    if($loggedIn){
    
    $sessionID = ((quser /server:$env:COMPUTERNAME | Where-Object { $_ -match $sname }) -split ' +')[2];
    logoff $sessionID;
    exit;
    }
    else {
	  
  	    exit;
    }
}
exit;
