
$path = "C:\PCUpdater\remoteregistry.txt"
$log = "C:\PCupdater\log.txt"

if (!(Test-Path $path)){
    $log_string = (Get-Date -format g) + ": Remote Registry Service Enable"
    Add-Content $log $log_string
    Set-Service RemoteRegistry -startuptype "Automatic"
    Start-Service RemoteRegistry
    New-Item $path -type file
}