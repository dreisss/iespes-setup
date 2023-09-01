Import-Module "$PSScriptRoot/lib/index"

if (-not(isRunningAsAdmin)) {
  Start-Process powershell -Verb "RunAs" -ArgumentList ('-NoExit -NoProfile -ExecutionPolicy Bypass File "{0}" -Elevated' -f ($MyInvocation.MyCommand.Definition))
  exit
}

$predefinedOperations = @(
  @{
    "number"   = 0
    "name"     = "Initial setup"
    "function" = {}
  },
  @{
    "number"   = 1
    "name"     = "Choose a specific function"
    "function" = {}
  },
  @{
    "number"   = 2
    "name"     = "Stop running script"
    "function" = {
      Write-Host ""
      printInfo "Exiting..."
      Write-Host ""
      exit
    }
  }
)

while ($true) {
  printInfo  "Choose an operation to perform:"

  foreach ($operation in $predefinedOperations) {
    printOperation $(formatNumber($operation.number)) "$($operation.name)"
  }

  [int] $requestedOperation = readValue "Operation number"

  if (($requestedOperation -lt 0) -or ($requestedOperation -gt $predefinedOperations.Count - 1)) {
    printError "Invalid operation number. Try again..."
  }
  else {
    $predefinedOperations[$requestedOperation].function.Invoke()
  }

  Write-Host ""
}
