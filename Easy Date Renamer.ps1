
Start-Transcript

#Import Files to HD
#Set SD location as 
#Set Destination as $Path

$import = 'H:\Upgrade'
$Path = 'F:\Test'
$NewPath = 'F:\Testing'

Get-ChildItem -Path $import | Copy-Item -Destination $Path


Get-ChildItem -Path $Path *.mp3 | Rename-Item -NewName {$_.Name -Replace ('^\n*(\d{2})(\d{2})(\d{4})(\d{4})','TC $1-$2-$3-$4-')
  | Rename-Item -NewName -WhatIf ($_.BaseName.Trim(0,12))

}

  Get-ChildItem -File -Path $Path |
    ForEach-Object {

        $Year = $_.LastWriteTime.Year
        $Month = $_.LastWriteTime.Month
        $Monthname = (Get-Culture).DateTimeFormat.GetMonthName($Month)
        $ArchDir = "$NewPath\$Year\$Monthname"
        $filename = $_.Name

        if (-not (Test-Path -Path $ArchDir)) { New-Item -ItemType "directory" -Path $ArchDir | Out-Null }
        Move-Item -Path $filename -Destination $ArchDir -WhatIf
        }


Read-Host -Prompt "Press Enter to exit"