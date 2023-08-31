Import-Module "$PSScriptRoot/../utilities"

function configureWiredNetwork([string] $ip, [string] $gateway) {
  printInfo "Configuring wired network..."

  try {
    netsh.exe interface ipv4 set address "Ethernet" static $ip "255.255.255.0" $gateway | Out-Null
    netsh.exe interface ipv4 add dnsservers "Ethernet" "8.8.8.8" index=1 | Out-Null
    netsh.exe interface ipv4 add dnsservers "Ethernet" "8.8.4.4" index=2 | Out-Null

    printSuccess "Wired network configured."
  }
  catch {
    printError "Failed to configure wired network."
  }
}

function configureNotWiredNetwork {
  printInfo "Configuring not wired network..."

  try {
    netsh.exe wlan connect "WIFI ALUNOS IESPES 5G"

    printSuccess "Not wired network configured."
  }
  catch {
    printError "Failed to configure not wired network."
  }
}
