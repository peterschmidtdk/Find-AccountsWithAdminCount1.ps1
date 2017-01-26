# Import the PS Module for AD
Import-Module ActiveDirectory
# Gets the list of users from the below OU and dumps them to a CSV file for review
$admincount = get-aduser –SearchBase “DC=Accounts,DC=dev,DC=local” -PropertiesadminCount -Filter * -ResultSetSize $null | where {$_.admincount -gt 0} | export-csvc:\admin-count.csv
# Sets the admin count back to 0 for anyone found in the above search
$admincount | select SamAccountName,distinguishedname,admincount | ForEach-Object {set-aduser -identity $_.samaccountname -replace @{admincount=0}}
