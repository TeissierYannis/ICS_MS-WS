Remove-GPO -Name "AllowRunMenu"
Remove-GPO -Name "DisallowRunMenu"
#region Remove Run menu from Start Menu
New-GPO -Name "AllowRunMenu" -Comment "Allow Run Menu" | New-GPLink -Target "OU=Informatique,OU=Lyon,OU=Sites,DC=ESN,DC=dom" -LinkEnabled Yes
New-GPLink -Name "AllowRunMenu" -Target "OU=Informatique,OU=Paris,OU=Sites,DC=ESN,DC=dom" -LinkEnabled Yes
Set-GPRegistryValue -Name "AllowRunMenu" -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ValueName 'NoRun' -Disabled
#endregion

#region Remove Run menu from Start Menu
New-GPO -Name "DisallowRunMenu" -Comment "Disallow Run Menu" | New-GPLink -Target "DC=ESN,DC=dom" -LinkEnabled Yes
Set-GPRegistryValue -Name "DisallowRunMenu" -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ValueName 'NoRun' -Enabled
#endregion

# Set PAssword policy
Set-ADDefaultDomainPasswordPolicy -Identity ENS.dom -ComplexityEnabled $True -MaxPasswordAge 30.00:00:00 -MinPasswordAge 29.00:00:00 -MinPasswordLength 5 -PasswordHistoryCount 12
# End Password Policy for classic users
# Set Password Policy for IT
New-ADFineGrainedPasswordPolicy -Name "ITPasswordPolicy" -DisplayName "Specifics rules for IT teams password's" -ComplexityEnabled $true -Description "Specifics rules for IT teams password's" -MaxPasswordAge 30:00:00:00 -MinPasswordAge 29:00:00:00 -MinPasswordLength 9 -PasswordHistoryCount 12 -Precedence 100
Add-ADFineGrainedPasswordPolicySubject MaxPassword365Days -Subjects "Informatique"
# End Password Policy for IT