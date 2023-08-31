# ===> Console
function printInfo([string] $text, [string] $space = "") {
  Write-Host "$space[!] $text" -ForegroundColor "Blue"
}

function printSuccess([string] $text, [string] $space = "") {
  Write-Host "$space[+] $text" -ForegroundColor "Green"
}

function printError([string] $text, [string] $space = "") {
  Write-Host "$space[-] $text" -ForegroundColor "Red"
}

# ===> Other
function formatNumber([string] $number) {
  return $number.PadLeft(2, "0")
}

function setRegistryValue([string] $path, [string] $name, [string] $value) {
  printInfo("Setting registry value $name to $value on $path") "   "

  try {
    Set-ItemProperty -Force -Type "DWord" -Value "$value" -Name "$name" "$path"
    printSuccess("Registry value $name set to $value on $path.") "   "
  }
  catch {
    printError("Failed to set registry value $name to $value on $path") "   "
  }
}
