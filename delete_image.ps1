$dir = "c:\image\"
$old_file = (Get-Date).addDays(-2)
Get-ChildItem $dir | ForEach-Object {
    if ($_.creationtime -lt $old_file){
        $file = $dir + $_.name
        Remove-Item $file
       } 
    }