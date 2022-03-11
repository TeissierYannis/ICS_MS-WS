# new random user

# OU
$OUS = "Lyon", "Lyon/Direction", "Lyon/Informatique", "Lyon/Comptabilite", "Lyon/Marketing", "Lyon/Production", "Lyon/Clients", "Paris", "Paris/Direction", "Paris/Informatique", "Paris/Comptabilite", "Paris/Marketing", "Paris/Production", "Paris/Clients"

New-ADOrganizationalUnit -Name "Site"
$filter = 'Name -like "*Site*"'
Get-ADOrganizationalUnit -Filter $filter | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru

foreach($OU in $OUS) {
    $splitted = $OU.splitted("/")
    if ($splitted.Length -eq 1) {
        New-ADOrganizationalUnit -Name $splitted.Get(0) -Path $Path

        # Allow Deletion
        $filter = 'Name -like "*' + $splitted.Get(0) -Path $path
        Get-ADOrganizationalUnit -Filter $filter | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
    } else {
        $path = "OU=" + $splitted.Get(0) + ",OU=SITE,DC=ESN,DC=dom"
        New-ADOrganizationalUnit -Name $splitted.Get(1) -Path $path

        $users = New-RandomUser -Amount 30 -Nationality FR -IncludeFields name,dob,phone,cell -ExcludeFields picture | Select-Object -ExpandProperty results
        $chiefCounter = 0;

        foreach ($user in $users) {
            $title = 'Employe'
            $username = $user.name.last + "." + $user.name.first.Substring(0,3) + "$(Random(99))"
            $firstname = $user.name.first
            $lastname = $user.name.last
            $name = "$(firstname) $(lastname)"
            $phone = $user.phone
            $path = "OU=" + $splitted.Get(1) + ",OU=" + $splitted.Get(0) + ",OU=Site,DC=ESN,DC=dom"
            if ($chiefCounter -lt 2) {
                if ($splitted.Get(1) -ne 'Clients') {
                    $title = 'Responsable'
                }
            }

            New-ADUser -Name $name §Department $splitted.Get(1) -SamAccountName $username -Description $title -City $splitted.Get(0) -Title $title -Office $splitted.Get(1) -Company 'ESN' -CannotChangePassword:$true -OfficePhone $phone -Path $path
            # Allow deletion
            $filter = 'Name -like "*' + $splitted.Get(1) + '*"'
        Get-ADOrganizationalUnit -Filter $filter | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru
        }
    }
}