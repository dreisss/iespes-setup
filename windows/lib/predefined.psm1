function getPredefinedOperations {
  return @(
    @{
      "number"   = 0
      "name"     = "Initial setup"
      "function" = {
        tryNetworkConnection

        renameComputer
        activateWindows
        createDefaultUser

        setAccentColor
        setThemeColors
        setWallpapers

        optimizeComputer
        setPreferences

        installChocolatey
        installWinget
        installDefaultApps
      }
    },
    @{
      "number"   = 1
      "name"     = "Stop running script"
      "function" = {
        printInfo "Exiting..."
        Write-Host ""
        exit
      }
    })
}
