function getPredefinedOperations {
  return @(
    @{
      "number"   = 0
      "name"     = "Stop running script"
      "function" = {
        printInfo "Exiting..."
        Write-Host ""
        exit
      }
    },
    @{
      "number"   = 1
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
        setGroupPolicies

        installChocolatey
        installWinget
        installDefaultApps
      }
    },
    @{
      "number"   = 2
      "name"     = "Default user setup"
      "function" = {
        setAccentColor
        setThemeColors

        optimizeComputer
        setPreferences
      }
    },
    @{
      "number"   = 3
      "name"     = "Update registry values"
      "function" = {
        printInfo "Updating user registry values..."
      }
    }
  )
}
