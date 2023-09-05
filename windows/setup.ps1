Import-Module "$PSScriptRoot/lib/index"

# if (-not(isRunningAsAdmin)) {
#   Start-Process powershell -Verb "RunAs" -ArgumentList ('-NoExit -NoProfile -ExecutionPolicy Bypass File "{0}" -Elevated' -f ($MyInvocation.MyCommand.Definition))
#   exit
# }

$predefinedOperations = getPredefinedOperations

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
    Write-Host ""
    $predefinedOperations[$requestedOperation].function.Invoke()
  }

  Write-Host ""
}
