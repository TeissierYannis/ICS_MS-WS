# Change ms-DS-MachineAccountQuota to zero -> Users cannot add computes
# Get config - 
Get-ADObject ((Get-ADDomain).distinguishedname) -Properties ms-DS-MachineAccountQuota
# Set config
Set-ADDomain (Get-ADDomain).distinguishedname -Replace @{"ms-ds-MachineAccountQuota"="0"}

# One subnet is not declared 172.31.1.1
New-ADReplicationSubnet -Name "172.31.1.0/24"

# Adminstrator flag this account is sensitive and cannot be delegated
Get-ADGroupMember -Identity "Domain Admins" | Set-ADUser -AccountNotDelegated $true

#Recyble bin
Enable-ADOptionalFeature -Identity 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target ESN.dom

# Spooler is remotly accessible (CVE Details : CVE-2021-34527 (RCE) : https://www.ghacks.net/2021/07/03/workaround-for-the-windows-print-spooler-remote-code-execution-vulnerability/)
Stop-Service -Name Spooler -Force
Set-Service -Name Spooler -StartupType Disabled

# Backup AD
Install-WindowsFeature Windows-Server-Backup

$disks = Get-WBDisk
$backupPolicy = New-WBPolicy
Add-WBSystemState -Policy $backupPolicy
Add-WBBareMetalRecovery -Policy $backupPolicy
# TAke the second disk
$backupTarget = New-WBBackupTarget -Disk $disks[1]
Add-WBBackupTarget -Policy $backupPolicy -Target $backupTarget
Set-WBSchedule -Policy $backupPolicy -Schedule 09:00
Set-WBPolicy -force -policy $backupPolicy

# Move admins to protected users
$users = Get-ADGroupMember "Domain Admins"
Add-ADGroupMember -Identity "Protected Users" -Members $users

