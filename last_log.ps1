# Import Active Directory module
Import-Module ActiveDirectory
# Get the current date and time
$currentDateTime = Get-Date
# Define the time span to check (2 minutes)
$timeSpan = New-TimeSpan -Minutes 2

# Calculate the cutoff date and time
$cutoffDateTime = $currentDateTime - $timeSpan

# Get all users who haven't logged in within the last 2 minutes
$users = Get-ADUser -Filter * -Properties LastLogonTimestamp | Where-Object {
    $_.LastLogonTimestamp -ne $null -and ($_.LastLogonTimestamp -lt $cutoffDateTime)
}

# Output the list of users
$users | Select-Object Name, LastLogonTimestamp
