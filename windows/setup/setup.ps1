function create_console([string] $color) {
  class Console {
    [string] $color;
    Console([string] $color) { $this.color = $color; }
    puts([string] $text) { Write-Host "$text " -ForegroundColor $this.color; }
    alert([string] $text) { Write-Host "# $text " -ForegroundColor $this.color -BackgroundColor "Black"; }
    error([string] $text) { Write-Host "$text " -ForegroundColor "Red"; }
    success([string] $text) { Write-Host "$text " -ForegroundColor "Green"; }
    alert_error([string] $text) { Write-Host "# $text " -ForegroundColor "Red" -BackgroundColor "Black"; }
  }
  return New-Object Console($color);
}

function create_network_manager([object] $data) {
  class NetworkManager {
    [string] $ip; [string] $gateway;
    NetworkManager([object] $data) { 
      if (-not($data.is_notebook)) {
        $this.ip = "192.168.$($data.laboratory_number).$($data.computer_number + 1)";
        $this.gateway = "192.168.$($data.laboratory_number).1";
      }
    }

    [bool] verify_connection() { return Test-Connection "google.com.br" -Quiet; }
    [void] configure_notebook() { netsh.exe wlan connect "IESPES-HP2G"; }
    [void] configure_desktop() {
      netsh.exe interface ipv4 set address "Ethernet" static $this.ip "255.255.255.0" $this.gateway | Out-Null;
      netsh.exe interface ipv4 add dnsservers "Ethernet" "8.8.8.8" index=1 | Out-Null;
      netsh.exe interface ipv4 add dnsservers "Ethernet" "8.8.4.4" index=2 | Out-Null;
    }
    [void] configure() { if ($this.ip) { $this.configure_desktop(); } else { $this.configure_notebook(); } }
  }
  return New-Object NetworkManager($data);
}


$console = create_console("Blue");

# ===================================================================> Utilities
function isRunningAsAdmin {
  $currentProcess = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  return $currentProcess.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function isNetworkAvailable {
  return Test-Connection -Quiet "google.com.br"
}

# =====================================================================> Network
function setNetworkConfigNotebook {
  $console.puts("Wi-fi not connected. Press any key when connected:")
  [System.Console]::ReadKey($true) | Out-Null
}

function setNetworkConfigDesktop {
  $ipAddress = "192.168.$($labinNumber).$($computerNumber + 1)"
  $defaultGateway = "192.168.$($labinNumber).1"
  $ServerAddresses = @("8.8.8.8", "8.8.4.4")

  New-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily "ipv4" -IPAddress $ipAddress -PrefixLength 24 -DefaultGateway $defaultGateway | Out-Null
  Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $ServerAddresses | Out-Null
}

function setNetworkConfig {
  if ($isNotebook) { setNetworkConfigNotebook } else { setNetworkConfigDesktop }
}

function verifyNetworkConnection {
  if (-not(isNetworkAvailable)) {
    $console.error("Test failed! Trying setup network...")
    setNetworkConfig
    $console.puts("Configured network configuration. Testing connection again...")

    if (-not(isNetworkAvailable)) {
      $console.alert_error("Test failed! Breaking script...")
      exit
    }
  }

  $console.success("Test successful! Continuing running scripts...")
  Start-Sleep -Seconds 5
}

# =================================================================> Sub-Scripts
function downloadScripts {
  $console.puts("Downloading utilities module file...")
  (New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/dreisss/iespes-extra/develop/scripts/powershell/setup/src/utilities.psm1", "$env:TEMP/utilities.psm1")

  foreach ($file in @("general", "apps", "optimize", "style", "permissions", "other")) {
    $console.puts("Downloading $file.ps1 file...")
    (New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/dreisss/iespes-extra/develop/scripts/powershell/setup/src/$file.ps1", "$env:TEMP/$file.ps1")
  }
}

function runScripts {
  foreach ($file in @("general", "apps", "optimize", "style", "permissions", "other")) {
    $console.alert("Running $file.ps1 file...")
    powershell.exe -file "$env:TEMP/$file.ps1" $isNotebook $labinNumber $computerNumber
  }
}

function removeScripts {
  $console.puts("Removing utilities.psm1 file...")
  Remove-Item "$env:TEMP/utilities.psm1"

  foreach ($file in @("general", "apps", "optimize", "style", "permissions", "other")) {
    $console.puts("Removing $file.ps1 file...")
    Remove-Item "$env:TEMP/$file.ps1"
  }
}

# =====================================================================> Running
# if (-not(isRunningAsAdmin)) {
#   Start-Process powershell -Verb RunAs -ArgumentList ('-Noprofile -ExecutionPolicy Bypass -File "{0}" -Elevated' -f ($myinvocation.MyCommand.Definition))
#   exit
# }

$console.alert("Starting running script")
[bool] $isNotebook = (Read-Host "   Is a notebook? (y, N)").Equals("y")
[int] $labinNumber = Read-Host "   Laboratory number"
[int] $computerNumber = Read-Host "   Computer number"

$console.alert("Verifying network connection")
verifyNetworkConnection

$console.alert("Downloading other configuration scripts")
downloadScripts

$console.alert("Running other configuration scripts")
runScripts

$console.alert("Removing other configuration scripts")
removeScripts

$console.alert("Setting execution policy to restricted")
Set-ExecutionPolicy "Restricted" -Scope "LocalMachine" -Force

$console.alert("Finished script execution")
