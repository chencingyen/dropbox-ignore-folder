$global:arrDir = @()

function ListFolder($myDir){
    $folderFullPath = $myDir | Select-Object -ExpandProperty FullName
    $folderName = $myDir | Select-Object -ExpandProperty Name
    $folderList = Get-ChildItem $folderFullPath -Directory

    #Write-Host $folderFullPath $folderList.Length
    
    Write-Host "Scanning $folderFullPath"
    

    if($folderName -eq "node_modules"){
        $global:arrDir = $global:arrDir + $folderFullPath
        
    }else{
        $folderList | ForEach-Object { ListFolder($_) }
    }
}


write-host 'scanning folder for node_modules'
Get-ChildItem -Directory | ForEach-Object{
    ListFolder($_)
    #$_ | Select-Object -ExpandProperty FullName
}

write-host "`n`nList of all folder with node_modules"
$global:arrDir 

write-host "`n"

$global:arrDir | ForEach-Object{    
    Set-Content -Path $_  -Stream com.dropbox.ignored -Value 1
    Write-Host "Ignore folder $_ done"

}