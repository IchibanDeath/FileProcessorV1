#Set SD location as $Import 
#Set Temp Destination as $Path
#Set Final Destination as $NewPath

#Import Files to HD for renaming while maintaining original copy
$date = Get-Date -Format 'dddd MM-dd-yyyy'
$i = 0  
Start-Transcript -Path "F:\$date$i.txt"

$Import = 'H:\Upgrade'
$Path = 'F:\Test'
$NewPath = 'F:\Testing'

#Test if $Path Exists, if not Create directory for Files to be transferred to

if(!(Test-Path -path $Path))  
{  
 New-Item -ItemType directory -Path $Path
 Write-Host "Folder path has been created successfully at: " $Path    
 }
else 
{ 
Write-Host "The given folder path $Path already exists"; 
}

#Copy Items from $Import location

Get-ChildItem -Path $Import -Filter '*.mp3' | Copy-Item -Destination $Path

#Rename Files adding Dashes between MM DD YYYY and HHMMSS 
#Still working on how to trim either right after or in the same operation to delete everything after YYYY
#Will need to handle duplicate files from the same date (Would like a, b, c- instead of 1, 2, 3-)

Get-ChildItem -Path $Path -Filter '*.mp3' | Rename-Item -NewName {$_.Name -Replace ('^\n*(\d{2})(\d{2})(\d{4})(\d{4})','TC $1-$2-$3-$4-')}

#Test if $NewPath exists and create if false

if(!(Test-Path -path $NewPath))  
{  
 New-Item -ItemType directory -Path $NewPath
 Write-Host "Folder path has been created successfully at: " $NewPath    
 }
else 
{ 
Write-Host "The given folder path $NewPath already exists"; 
}


#Move files into $NewPath\Year\Month created
#Running in to problems with moving the files after they have been renamed - Likely due to 

  Get-ChildItem -File -Path $Path -Filter '*.mp3' |
    ForEach-Object {

        $Year = $_.LastWriteTime.Year
        $Month = $_.LastWriteTime.Month
        $Monthname = (Get-Culture).DateTimeFormat.GetMonthName($Month)
        $ArchDir = "$NewPath\$Year\$Monthname\"

        if (-not (Test-Path -Path $ArchDir)) { New-Item -ItemType "directory" -Path $ArchDir | Out-Null }
        Move-Item -Path $Path\*.mp3 -Destination $ArchDir -Verbose
        }


#Would like to add a list of files renamed and where they moved to instead of just Enter to exit
Read-Host -Prompt "Press Enter to exit"