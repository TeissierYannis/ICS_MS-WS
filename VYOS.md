# VYOS

```
configure
```
```
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth1 address 172.31.1.254/24
set interfaces ethernet eth1 address 172.31.2.254/24
```
```
set nat source rule 100 outbound-interface eth0
set nat source rule 100 source address '172.31.1.0/24'
set nat source rule 100 translation address masquerade
```
```
set nat source rule 101 outbound-interface eth0
set nat source rule 100 source address '172.31.2.0/24'
set nat source rule 100 translation address masquerade
```

