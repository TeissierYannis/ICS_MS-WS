$Name = "SRV1-L"

$IP = "172.31.1.2"
$Prefix = "24"
$Gateway = "172.31.1.254"
$DNS = "1172.31.1.1"

Rename-Computer -NewName $NameComputer -Force

New-NetIPAddress -IPAddress $IP -PrefixLength $Prefix -InterfaceIndex (Get-NetAdapter).ifIndex -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -ServerAddresses ($DNS)

Restart-Computer
