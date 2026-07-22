$fullname = Read-Host "Enter full name"
$user = Get-ADUser -Filter 'Name -like $fullname -and Name -notlike "*Admin*"' -Properties SamAccountName | Select-Object -ExpandProperty SamAccountName
Get-ADUser -Identity $user -Properties MemberOf | 
    Select-Object -ExpandProperty MemberOf | 
    ForEach-Object { ($_ -split ',')[0] -replace 'CN=', '' }