#Set SD location as $Import 
#Set Temp Destination as $Source
#Set Final Destination as $Destination
#Import Files to HD for renaming while maintaining original copy
Clear-Host

$date = Get-Date -Format 'dddd MM-dd-yyyy'
Start-Transcript -Path "F:\$date.txt" -NoClobber -Append

$Import = "C:\Users\IchibanDeath\Desktop\New Directory"
$Source = "F:\Test\"
$Destination = "F:\Testing\"

#Test if $Source Exists, if not Create directory for Files to be transferred to
if(!(Test-Path -Path $Source))  {  
 New-Item -ItemType directory -Path $Source
 Write-Host "Folder path has been created successfully at: " $Source    
 }
else { 
Write-Host "The given folder path $Source already exists"; 
}
#Test if $Destination Exists, if not Create directory for Files final destination
if(!(Test-Path -Path $Destination))  {  
  New-Item -ItemType directory -Path $Destination
  Write-Host "Folder path has been created successfully at: $Destination "}
 else { 
 Write-Host "The given folder path $Destination already exists"; 
 }
 
#Copy Items from $Import location
Get-ChildItem -Path $Import -Filter *.mp3 | Copy-Item -Destination $Source
#Rename Files adding Dashes between MM DD YYYY and HHMMSS
Get-ChildItem -Path $Source -Filter *.mp3 | Rename-Item -NewName {$_.Name -Replace ('^\n*(\d{2})(\d{2})(\d{4})(\d{6}).(?:...)(\d{3})\w','TC $1-$2-$3-$4')}

#Move files into $Destination\Year\Month created - Need to add

$Files = Get-ChildItem -Path $Source -Filter *.mp3

Foreach($File in $Files){
	$FileBaseName = $File.BaseName.Trim(14)
    $FileExtension = $File.Extension
    $myList = @("a","b","c","d","e","f","g","h","i","j")
	$i = 0
	$Destination = "F:\Testing\"
	$FileName = "{0}{1}{2}" -f $FileBaseName.Trim(15) + $myList[$i] + $FileExtension
	While (Test-Path -Path $Source "$Destination\$Filename"){
		$i++
		$FileName = "{0}{1}{2}" -f $FileBaseName + $myList[$i] + $FileExtension
	}
	Remove-Variable i -ErrorAction SilentlyContinue
	$NewFileDestination = "{0}{1}" -f $Destination + $FileName
	Move-item $File.FullName -Destination $NewFileDestination -Verbose
}

Write-Host "Above Files Copied to $Destination"
Read-Host -Prompt "Press Enter to exit"