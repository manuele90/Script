#Scrivere qui la versione che si sta installando
$v_installing_p1 = 7
$v_installing_p2 = 2

#Scrivere qui il percorso dove potrebbe trovarsi il file
$path = "C:\Program Files\Notepad++\notepad++.exe"
$path_x86 = "C:\Program Files (x86)\Notepad++\notepad++.exe"

#Se la variabile doit diventa 1 il programma viene installato
$doit = 0
#Se la variabile notinstalled diventa 2 il programma non è installato
$notinstalled = 0

#Calcolo la versione installata e confronto
function Check-Version{
$v_installed_p1 = ($v_installed[0] -as [string]) -as [int]
$v_installed_p2 = ($v_installed[2] -as [string]) -as [int]
$v_installed = ($v_installed_p1 * 10) + $v_installed_p2

$v_installing = ($v_installing_p1 * 10) + $v_installing_p2

if ($v_installing -gt $v_installed) {
    $script:doit = 1
    }
    else { 
        $script:doit = 0
        }
}


if (Test-Path $path) {
    $v_installed = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($path).FileVersion
    Check-Version
    }
    else{
        $notinstalled = $notinstalled + 1
    }
if (Test-Path $path_x86){
    $v_installed = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($path_x86).FileVersion
    Check-Version
    }
    else{
        $notinstalled = $notinstalled + 1
    }
if ($notinstalled -eq 2) {
    $doit = 1
}
if ($doit -eq 1) {
    Write-Host pronto ad installare!
}



