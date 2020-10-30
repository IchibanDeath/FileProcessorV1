Start-Transcript

#Set SD location as $Import 
#Set Destination as $Path

#Import Files to HD

$import = 'H:\Upgrade'
$Path = 'F:\Test'
$NewPath = 'F:\Testing'

#Copy Items from SDcard/$Import

Get-ChildItem -Path $import | Copy-Item -Destination $Path

#Rename Files adding Dashes between MM DD YYYY and HHMMSS 
#Still working on how to trim either right after or in the same operation

Get-ChildItem -Path $Path *.mp3 | Rename-Item -NewName {$_.Name -Replace ('^\n*(\d{2})(\d{2})(\d{4})(\d{4})','TC $1-$2-$3-$4-')}

#Move files into $NewPath\Year\Month created
#Running in to problems with moving the files after they have been renamed - Likely due to 

  Get-ChildItem -File -Path $Path |
    ForEach-Object {

        $Year = $_.LastWriteTime.Year
        $Month = $_.LastWriteTime.Month
        $Monthname = (Get-Culture).DateTimeFormat.GetMonthName($Month)
        $ArchDir = "$NewPath\$Year\$Monthname"
        $filename = $_.Name

        if (-not (Test-Path -Path $ArchDir)) { New-Item -ItemType "directory" -Path $ArchDir | Out-Null }
        Move-Item -Path $Path -Destination $ArchDir -WhatIf
        }


#Would like to add a list of files renamed and where they moved to instead of just Enter to exit
Read-Host -Prompt "Press Enter to exit"