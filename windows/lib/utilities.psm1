# =============================================================================> Printing
function printInfo([string] $text, [string] $space = "") {
  Write-Host "$space[!] $text" -ForegroundColor "Blue"
}

function printSuccess([string] $text, [string] $space = "") {
  Write-Host "$space[+] $text" -ForegroundColor "Green"
}

function printError([string] $text, [string] $space = "") {
  Write-Host "$space[-] $text" -ForegroundColor "Red"
}

function printOperation([string] $number, [string] $text) {
  Write-Host "   [$number] $text" -ForegroundColor "Cyan"
}

function readValue([string] $text, [string] $space = "") {
  return Read-Host "$space[?] $text"
}

# =============================================================================> Other
function isRunningAsAdmin {
  $currentProcess = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  return $currentProcess.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function isNetworkAvailable {
  return Test-Connection -Quiet "google.com.br"
}

function formatNumber([string] $number) {
  return $number.PadLeft(2, "0")
}

function setRegistryValue([string] $path, [string] $name, [string] $value, [string] $type = "DWord") {
  printInfo "Setting registry value $name to $value on $path" "   "

  try {
    Set-ItemProperty -Force -Type $type -Value $value -Name $name $path
    printSuccess "Registry value $name set to $value on $path." "   "
  }
  catch {
    printError "Failed to set registry value $name to $value on $path" "   "
  }
}
