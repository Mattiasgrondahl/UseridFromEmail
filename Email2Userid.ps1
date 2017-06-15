 <#

.SYNOPSIS
Convert an emailaddress to possible userid's 

.DESCRIPTION

Performs the following task
    - Takes an txt file with emailaddresses
    - Converts to possible userid's
    - Create a new file with userid's
    
            
.NOTES

        Author: Mattias Grondahl  Date  : June, 2017   

        This script is to make it guess userid's for external pentests

.PARAMETERS

    -path
        Enter Path to search from
        Example: ./Email2userid.ps1 -path C:\

    -output
        Enter where to output the results
        Example: ./Email2userid.ps1 -output C:\temp\output
           
.EXAMPLE 

#Run script with parameters
./Email2userid.ps1 -path C:\temp -output C:\temp\output

#Run the script interactive and ask for parameters
./Email2userid.ps1

#>

#Takes emailaddress and convert to userid
#Firstname.lastname@domain.tld to firlas

### Parameters

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False,Position=1)]
   [string]$path,
	
   [Parameter(Mandatory=$False,Position=2)]
   [string]$output
)

　
#Define Help Function
Function Help{
Write-host '#############################################################################################################' -ForegroundColor DarkYellow
Write-host '#                                                                                                           #' -ForegroundColor DarkYellow
Write-host '# Example: ./Email2userid.ps1 -path C:\temp\email.txt -output C:\temp\output                                          #' -ForegroundColor DarkYellow
Write-host '#                                                                                                           #' -ForegroundColor DarkYellow
Write-host '#############################################################################################################' -ForegroundColor DarkYellow
}

#Show Help
Help

#If no -path
if ($path -eq "") {
#$path = Read-Host "Enter the path to the email list:"
Write-host "No path defined entering interactive mode."
$path = Read-host "Enter path"
}

#If no -output
if ($output -eq "") {
Write-host "No output path defined!"
$output = Read-host "Enter output path"
}

#Display Confguration
$conf = " -path       = $path`r`n -output     = $output`r`n ErrorLog  = $output\Error.log`r`n"
Write-host "###################################################" -ForegroundColor DarkYellow
Write-host "#                                                 #" -ForegroundColor DarkYellow
Write-host "#                   Configuration                 #" -ForegroundColor DarkYellow
Write-host "#                                                 #" -ForegroundColor DarkYellow
Write-host "###################################################" -ForegroundColor DarkYellow
Write-host $conf -ForegroundColor Magent
sleep 2

#Confirm config
$confirm = Read-host "Do you want to continue with the current configuration Y/N"
    if ( $confirm -ne "Y" ) { exit }

#Create Output folder
if (Test-Path $output) {
}
Else {
New-Item $output -type Directory
Write-host "Created folder $output"
}

#Suppress Errors (set to Continue to show errors on run)
$ErrorActionPreference = "SilentlyContinue"
$Error.count
New-Item Errors.log -type file

　
　
Write-host "
NameStandards
Example email mattias.grondahl@domain.local
1 = 3+3 matgro
2 = 3+2 matgr
3 = 2+3 magro
"
$namestandard = Read-Host "Select NameStandard"

#Create outputfile
#New-Item C:\temp\text.txt -type file
   

#$Emails = Import-CSV C:\temp\email.csv
$Emails = Get-Content -Path $path

###For loop starts here

ForEach ($email in $Emails) { 
##Select Name Standard
if ($namestandard -eq 1) {
$nsfirst = $name.Substring(0,3)
$nslast = $name.Split('.')[1].Substring(0,3)
}

if ($namestandard -eq 2 ) {
$nsfirst = $name.Substring(0,3)
$nslast = $name.Split('.')[1].Substring(0,2)
}

if ($namestandard -eq 3) {
$nsfirst = $name.Substring(0,3)
$nslast = $name.Split('.')[1].Substring(0,2)
}

#remove @domain.com
$name = $email -replace "@.*"
$nsfirst
$nslast
$userid = (-join("$nsfirst", "$nslast"))
Write-Host "$userid"
Add-content $output\out.txt "$userid"
}
 
