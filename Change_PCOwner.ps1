#Importazione modulo per consultare l'AD tramite Poweshell
Import-Module ActiveDirectory

#Aquisizione utenza attualmente collegata al PC (non posso usare %username% perchè il servizio parte con l'utenza Staff)
$user = Get-WMIObject -class Win32_ComputerSystem | select -expand username
$user = [string]$user
$part = $user.split("\")
$user = $part[1]

$disp_name = Get-ADUser $user -Properties DisplayName | select -expand DisplayName

$registryPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\"
$name = "RegisteredOwner"
$value = $disp_name
Set-ItemProperty -Path $registryPath -Name $name -Value $value
