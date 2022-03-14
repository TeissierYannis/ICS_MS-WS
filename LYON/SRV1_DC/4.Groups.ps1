# Create "Jean Vien" & "Jean Peuplus"
New-ADUser -Name "Jean Vien" -SamAccountName "JVien" -CannotChangePassword:$true -Path "DC=ESN,DC=dom"
New-ADUser -Name "Jean Peuplus" -SamAccountName "JPeuplus" -CannotChangePassword:$true -Path "DC=ESN,DC=dom"
New-LocalGroup -Name "GL_ESN"
Add-LocalGroupMember -Group "GL_ESN" -Member "Jean Vien", "Jean Peuplus"

# Create groups group
New-ADOrganizationalUnit -Name 'Groups' -Path "DC=ESN,DC=dom"
$filter = 'Name -like "*Groups*"'
Get-ADOrganizationalUnit -Filter $filter | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
# Create global group
New-ADOrganizationalUnit -Name 'Global' -Path "OU=Groups,DC=ESN,DC=dom"
$filter = 'Name -like "*Global*"'
Get-ADOrganizationalUnit -Filter $filter | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
# Create local group
New-ADOrganizationalUnit -Name 'Local' -Path "OU=Groups,DC=ESN,DC=dom"
$filter = 'Name -like "*Local*"'
Get-ADOrganizationalUnit -Filter $filter | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru

$GG = "Responsables:title|Responsable", "Employe:title|Responsable,Employe", "Informatique:Department|Informatique", "Comptabilite:Deparment|Comptabilite", "Direction:Department|Direction", "Marketing:Department|Marketing", "Production:Department|Production"
$GL = "DL_Total_Ressources:Responsables,Direction", "DL_Lecture_Ressources:Informatique,Comptabilite,Marketing", "DL_Refuser_Ressources:Production"

foreach ($G in $GG) {
    $splitted = $G.Split(':')
    $group = $splitted[0]
    $splitted = $splitted[1].Split('|')
    $field = $splitted[0]
    $values = $splitted[1]
    $path = "OU=Global,OU=Groups,DC=ESN,DC=dom"
    New-ADGroup -name $group -GroupScope Global -Path $path

    foreach($v in $values) {
        $filter = $field + ' -eq "' + $v + '" -and department -ne "Clients"'
        if ($group -eq "Clients") {
            $filter = $field + ' -eq "' + $v + '"'
        }
        Get-ADUser -Filter $filter | Add-ADPrincipalGroupMembership -MemberOf $group 
    }
}

foreach ($G in $GL) {
    $splitted = $G.Split(':')
    $group = $splitted[0]
    $path = "OU=Global,OU=Groups,DC=ESN,DC=dom"
    New-ADGroup -name $group -GroupScope DomainLocal -Path $path
    foreach($v in $splitted[1].Split(',')) {
        $filter = 'Name -eq "' + $v + '"'
        Get-ADGroup -Filter $filter | Add-ADPrincipalGroupMembership -MemberOf $group
    }
}
Get-ADGroupMember Responsables | Get-ADUser -Properies Name,Department | Where {$_.Department -eq "Informatique"} | Add-ADPrincipalGroupMembership -MemberOf "Domain Admins"