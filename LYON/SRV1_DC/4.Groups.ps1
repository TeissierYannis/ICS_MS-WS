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
$GL = ""

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
        Get-ADUser -Filter $filter | Add-ADPrincipalGroupMembership -MemberOf $group 
    }
}