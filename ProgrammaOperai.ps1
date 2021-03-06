#Dichiarazione Variabili

$log = "C:\PCupdater\log.txt"													#File di log
$enabled_users = "\\10.1.1.9\netlogon\updater\progoperai\pr_operai.txt"			#Utenti abilitati all'uso di Programma Operai

$interface1_users = "\\10.1.1.9\netlogon\updater\progoperai\interface1.txt"		#Utenti che utilizzano l'interfaccia 1
$interface1_path = "\\10.1.1.9\netlogon\updater\progOperai\Operai_test.accdb"	#Front End interfaccia 1

$installer_path = "\\10.1.1.9\netlogon\updater\Access_Runtime\*"				#File di installazione Access Runtime 2010
$local_path = "C:\PCupdater\AccessRuntime\"										#Directory di copia locale file di installazione
$install_arguments = "/config C:\PCupdater\AccessRuntime\config.xml"			#Parametri installazione Access Runtime 2010

$registry_path = "\\10.1.1.9\netlogon\updater\progOperai\"						#Directory registri configurazione ODBC


#Aquisizione utenza attualmente collegata al PC (non posso usare %username% perchè il servizio parte con l'utenza Staff)
$user = Get-WMIObject -class Win32_ComputerSystem | select username
$user = [string]$user
$part = $user.split("\")
$user = $part[1]
$part = $user.split("}")
$user = $part[0]

$frontend_destination = "C:\Users\" + $user + "\Desktop"						#Percorso dove salvare il Programma


#FASE 1: Verifica se l'utente necessita Access Runtime

If (Get-Content $enabled_users | Select-String $user -quiet){
 
	if (!(Test-Path "C:\Program Files\Microsoft Office\Office14\MSACCESS.EXE")) {
		if (!(Test-Path "C:\Program Files (x86)\Microsoft Office\Office14\MSACCESS.EXE")) {
			if (!(Test-Path $local_path)){ 
				mkdir $local_path
			}
		$log_string = (Get-Date -format g) + ": AccessRuntime: copied."
		Add-Content $log $log_string
		Copy-Item $installer_path $local_path -recurse -force
		$log_string = (Get-Date -format g) + ": AccessRuntime: start installer."
		Add-Content $log $log_string
		$local_path = $local_path + "setup.exe"
		Start-Process $path $install_arguments -NoNewWindow -Wait
		$log_string = (Get-Date -format g) + ": AccessRuntime: installed."
		Add-Content $log $log_string
		}
	}
    


#FASE 2: Configurazione ODBC per collegamento a file su AS400
   
    if ((Test-Path "C:\Program Files (x86)\")) {
        $registry_path = $registry_path + "Operai_64bit.reg"
        regedit /s $registry_path
    }
        Else{
            $registry_path = $registry_path + "Operai_32bit.reg"
            regedit /s $registry_path
        }
    


#FASE 3: Copia del corretto Front-End su Desktop
   
    If (Get-Content $interface1_users | Select-String $user -quiet){
        Copy-Item $interface1_path -destination $frontend_destination -force
        }
 } 