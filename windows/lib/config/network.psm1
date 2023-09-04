Import-Module "$PSScriptRoot/../utilities"

function configureWiredNetwork([string] $ip) {
  printInfo "Configuring wired network..."

  try {
    $gateway = "$($ip.Substring(0, $ip.LastIndexOf("."))).1"

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

function configureNetwork {
  printInfo "Configuring network..."

  $ip = readValue "IP (Empty to Wired Network)" "   "

  if ($ip -eq "") {
    configureNotWiredNetwork
  }
  else {
    configureWiredNetwork $ip 
  }

  printSuccess "Network configured."
}


function tryNetworkConnection {
  printInfo "Trying network connection..."

  if (isNetworkAvailable) {
    printSuccess "Network connection successful."
  }
  else {
    printError "Network connection failed. Trying to connect..."

    configureNetwork

    if (isNetworkAvailable) {
      printSuccess "Network connection successful."
    }
    else {
      printError "Network connection failed."
      exit
    }
  }
}
