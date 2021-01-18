#Start by Clearing Host and Saving Transcript
Clear-Host
$date = Get-Date -Format 'dddd MM-dd-yyyy'
Start-Transcript -Path "F:\New$date.txt" -NoClobber -Append
#Set locations - SD Card:Import
$Import = "C:\Users\IchibanDeath\Desktop\New Directory"
$Source = "F:\Test\"
$Destination = "F:\Testing"

#Test if $Source Exists, if not Create directory for Files to be transferred to
if(!(Test-Path -Path $Source))  {  
    New-Item -ItemType directory -Path $Source
    Write-Host "Folder path has been created successfully at: " $Source    
    }
   else { 
   Write-Host "The given folder path $Source already exists"; 
   }
   #Test if $Destination exists and create if false
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


#Move files into $NewPath\Year\Month created
#Running in to problems with moving the files after they have been renamed - Likely due to 

Get-ChildItem -File -Path $Source -Filter '*.mp3' |
ForEach-Object {

    $Year = $_.LastWriteTime.Year
    $Month = $_.LastWriteTime.Month
    $Monthname = (Get-Culture).DateTimeFormat.GetMonthName($Month)
    $ArchDir = "$Destination\$Year\$Monthname\"

    if (-not (Test-Path -Path $ArchDir)) { New-Item -ItemType "directory" -Path $ArchDir | Out-Null }
    Move-Item -Path $Source\*.mp3 -Destination $ArchDir -Verbose
    }


#Would like to add a list of files renamed and where they moved to instead of just Enter to exit
Read-Host -Prompt "Press Enter to exit"