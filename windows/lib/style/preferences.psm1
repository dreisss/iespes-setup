Import-Module "$PSScriptRoot/../utilities"

function setAccentColor {
  printInfo "Setting accent color..."

  [byte[]] $binaryPaletteCode = "94,e0,b1,00,75,c7,95,00,3d,ad,68,00,10,89,3e,00,0b,5c,2a,00,08,42,1e,00,05,2b,14,00,00,b7,c3,00".Split(',') | ForEach-Object { "0x$_" }

  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Accent" "AccentColorMenu" "0xff3e8910" "String"
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Accent" "AccentPalette" $binaryPaletteCode "Binary"
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Accent" "StartColorMenu" "0xff2a5c0b" "String"

  printSuccess "Accent color set."
}

function setThemeColors {
  printInfo "Setting theme colors..."

  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize" "SystemUsesLightTheme" 0
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize" "AppsUseLightTheme" 0
  setRegistryValue "HKCU:/Control Panel/Desktop" "FontSmoothing" 2 "String"

  printSuccess "Theme colors set."
}
