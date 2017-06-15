#Takes emailaddress and convert to userid
#Firstname.lastname@domain.tld to firlas

Write-host "
NameStandards
Example email mattias.grondahl@domain.local
1 = 3+3 matgro
2 = 3+2 matgr
3 = 2+3 magro
"
$namestandard = Read-Host "Select NameStandard"

#Create outputfile
New-Item C:\temp\text.txt -type file
   

#$Emails = Import-CSV C:\temp\email.csv
$Emails = Get-Content -Path "C:\temp\email.txt"
ForEach ($email in $Emails) { 
#write-host "$email"
sleep 1

　
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
Add-content C:\temp\text.txt "$userid"
sleep 1
}
