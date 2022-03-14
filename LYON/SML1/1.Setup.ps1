$Name = "SML1"

$IP = "172.31.1.3"
$Prefix = "24"
$Gateway = "172.31.1.254"
$DNS = "172.31.1.1"

Rename-Computer -NewName $Name -Force

New-NetIPAddress -IPAddress $IP -PrefixLength $Prefix -InterfaceIndex (Get-NetAdapter).ifIndex -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -ServerAddresses ($DNS)

Restart-Computer
