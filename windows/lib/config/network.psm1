Import-Module "$PSScriptRoot/../utilities"

function configureWiredNetwork([string] $ip, [string] $gateway) {
  netsh.exe interface ipv4 set address "Ethernet" static $ip "255.255.255.0" $gateway | Out-Null
  netsh.exe interface ipv4 add dnsservers "Ethernet" "8.8.8.8" index=1 | Out-Null
  netsh.exe interface ipv4 add dnsservers "Ethernet" "8.8.4.4" index=2 | Out-Null
}

function configureNotWiredNetwork {
  netsh.exe wlan connect "WIFI ALUNOS IESPES 5G"
}
