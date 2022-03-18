# Change ms-DS-MachineAccountQuota to zero -> Users cannot add computes
# Get config - 
Get-ADObject ((Get-ADDomain).distinguishedname) -Properties ms-DS-MachineAccountQuota
# Set config
Set-ADDomain (Get-ADDomain).distinguishedname -Replace @{"ms-ds-MachineAccountQuota"="0"}

# One subnet is not declared 172.31.1.1
New-ADReplicationSubnet -Name "172.31.1.0/24"

# Adminstrator flag this account is sensitive and cannot be delegated
Set-ADUser -Identity "Administrator" -AccountNotDelegated $true

#Recyble bin
Enable-ADOptionalFeature -Identity 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target ESN.dom