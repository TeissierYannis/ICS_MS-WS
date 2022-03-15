$root = "C:\SHARED"
$dirs = "COMMUN", "INFORMATIQUE", "COMPTABILITE", "CLIENTS", "RESPONSABLE", "MARKETING", "PRODUCTION"

foreach($dir in $dirs) {
    New-Item -type directory -path $root\$dir
}

New-SMBShare –Name "Shared" –Path "C:\Shared" –ContinuouslyAvailable –FullAccess domain\admingroup -ChangeAccess domain\deptusers -ReadAccess "domain\authenticated users"