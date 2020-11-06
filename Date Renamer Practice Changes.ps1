#Set SD location as $Import 
#Set Temp Destination as $Path
#Set Final Destination as $NewPath

#Import Files to HD for renaming while maintaining original copy
$date = Get-Date -Format 'dddd MM-dd-yyyy'
Start-Transcript -Path "F:\$date.txt" -NoClobber -Append


$Import = 'C:\Users\IchibanDeath\Desktop\New Directory'
$Path = 'F:\Test'
$NewPath = 'F:\Testing'

#Test if $Path Exists, if not Create directory for Files to be transferred to
if(!(Test-Path -path $Path))  {  
 New-Item -ItemType directory -Path $Path
 Write-Host "Folder path has been created successfully at: " $Path    
 }
else { 
Write-Host "The given folder path $Path already exists"; 
}

#Copy Items from $Import location
Get-ChildItem -Path $Import -Filter '*.mp3' | Copy-Item -Destination $Path

#Rename Files adding Dashes between MM DD YYYY and HHMMSS

Get-ChildItem -Path $Path -Filter '*.mp3' | Rename-Item -NewName {$_.Name -Replace ('^\n*(\d{2})(\d{2})(\d{4})(\d{6})','TC $1-$2-$3-')}

#Test if $NewPath exists and create if false
if(!(Test-Path -path $NewPath))  {  
 New-Item -ItemType directory -Path $NewPath
 Write-Host "Folder path has been created successfully at: " $NewPath    
 }
else { 
Write-Host "The given folder path $NewPath already exists"; 
}
#Move files into $NewPath\Year\Month created
#Running in to problems with moving the files after they have been renamed - Likely due to 

function fcopy ($SourceDir,$DestinationDir)
{
	Get-ChildItem $SourceDir -Recurse | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object ($_) {
    $SourceFile = $_.FullName
    $Year = $_.LastWriteTime.Year
    $Month = $_.LastWriteTime.Month
    $Monthname = (Get-Culture).DateTimeFormat.GetMonthName($Month)
    $NewPath = 'F:\Testing'
    $ArchDir = "$NewPath\$Year\$Monthname\"
    #Array for iterate for same date, still trying to figure out how to get first file of a certain date to take the 'a'

    $myList = @("a","b","c","d","e","f","g","h","i","j")
    $DestinationFile = $DestinationDir + $_
  
    if (Test-Path $DestinationFile) {
			$i = 0
			while (Test-Path $DestinationFile) { $i += 1
				$DestinationFile = $DestinationDir + $_.basename + $myList[$i] + $_.extension
			}
    } else {
			Copy-Item -Path $SourceFile -Destination $DestinationFile -Verbose -Force
		}
		Copy-Item -Path $SourceFile -Destination $DestinationFile -Verbose -Force
	}
}
fcopy -SourceDir "F:\Test\" -DestinationDir '$ArchDir'

#Would like to add a list of files renamed and where they moved to instead of just Enter to exit

Read-Host -Prompt "Press Enter to exit"