#Aggiorna Java:
#Requisiti: 
# 1: salvare l'offline installer dell'ultima versione di Java in \\10.1.1.9\netlogon\updater\java sovrascrivento il file java.exe
# 2: Modificare la versione di Java nel file version.txt rispettando la formattazione (es Java 8.111 = 8111 - Java 8.090 = 8090)


$path = "C:\PCupdater\Java\version.txt"
$installer_path = "\\10.1.1.9\netlogon\updater\java\version.txt"
$log = "C:\PCupdater\log.txt"
$installing_version = Get-Content $installer_path

#Se la variabile todo diventa 1 Java viene installato
$todo = 0

#Se esiste C:\PCupdater\Java\version.txt vuol dire che Java è già stato installato sul PC almeno una volta, se non esiste installa Java.
if (Test-Path $path) {
    $installed_version = Get-Content $path
    #Verifica che la versione da installare sia più aggiornata rispetto a quella già installata, se si setta todo=1
    if ([int]$installed_version -lt [int]$installing_version){
        $todo = 1
    }
} else { $todo = 1 }

#Se il PC è il SEDE146 (Fabio Griffini) non fa niente
$pc_name = hostname
If ($pc_name -eq "SEDE146"){
    $todo = 0
    }

if ($todo -eq 1){
    $installer_path = "\\10.1.1.9\netlogon\updater\java\*"
    $path = "C:\PCupdater\Java\"
    if (!(Test-Path $path)){ 
        mkdir C:\PCupdater\Java\
		} 
    $log_string = (Get-Date -format g) + ": Java: copied."
    Add-Content $log $log_string
    Copy-Item $installer_path $path
    $log_string = (Get-Date -format g) + ": Java: start installer."
    Add-Content $log $log_string
	$path = "C:\PCupdater\Java\java.exe"
	Start-Process $path INSTALLCFG=C:\PCupdater\Java\java_config -NoNewWindow -Wait
    $log_string = (Get-Date -format g) + ": Java: installed."
    Add-Content $log $log_string
}