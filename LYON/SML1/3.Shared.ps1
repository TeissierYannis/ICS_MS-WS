$root = "C:\SML1"

New-Item -type directory -path $root

New-SMBShare –Name "SML1_SHARED" –Path "C:\SML1" –FullAccess "Authenticated Users"

# Show NTFS Permissions
#((Get-Item C:\SML1).GetAccessCntrol('Access')).Access

$Acl = (Get-Item $root).GetAccessControl('Access')
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Total_Ressources", "FullControl", "ContainerInherit,ObjectInherit",'None','Allow')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl

#(FileSystemRights  : CreateFiles, AppendData, DeleteSubdirectoriesAndFiles, ReadAndExecute, Synchronize)
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Total_Ressources", "CreateFiles", "ContainerInherit,ObjectInherit",'None','Deny')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Total_Ressources", "AppendData", "ContainerInherit,ObjectInherit",'None','Deny')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Total_Ressources", "DeleteSubdirectoriesAndFiles", "ContainerInherit,ObjectInherit",'None','Deny')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Total_Ressources", "ReadAndExecute", "ContainerInherit,ObjectInherit",'None','Allow')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Total_Ressources", "Synchronize", "ContainerInherit,ObjectInherit",'None','Allow')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl

$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Refuser_Ressources", "CreateFiles", "ContainerInherit,ObjectInherit",'None','Deny')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Refuser_Ressources", "AppendData", "ContainerInherit,ObjectInherit",'None','Deny')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Refuser_Ressources", "DeleteSubdirectoriesAndFiles", "ContainerInherit,ObjectInherit",'None','Deny')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Refuser_Ressources", "ReadAndExecute", "ContainerInherit,ObjectInherit",'None','Deny')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_Refuser_Ressources", "Synchronize", "ContainerInherit,ObjectInherit",'None','Allow')
$Acl.SetAccessRule($Ar)
Set-Acl -Path $root -AclObject $Acl