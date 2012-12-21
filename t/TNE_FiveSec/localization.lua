

-- FiveSec localization
--------------------------------------------------------------------------------

-- bar colors to customize rather than localize
TNE_FiveSec_BarColors = {}
TNE_FiveSec_BarColors["enabled"] = { r = 0.00, g = 1.0, b = 0.10 } -- green (mana regeneration enabled)
TNE_FiveSec_BarColors["disabled"] = { r = 0.00, g = 0.70, b = 1.00 } -- light blue (mana regeneration disabled)

TNE_FiveSec_RegenerationBuffs = {
  "Aura of the Blue Dragon", "Innervate", "Spirit Tap",
}

TNE_FiveSec_NEXT_TICK_IN = "Next tick in: "
TNE_FiveSec_DELAYED_BY_CHANNELING = "Delayed by channeling"
TNE_FiveSec_REGENERATION_IN = "%.1f sec" -- %d is seconds remaining
TNE_FiveSec_REGENERATION_IN_INT = "%d sec"

TNE_FiveSec_HELP_MOVING = "Movable frame ($vleft mouse button$ev)"
TNE_FiveSec_HELP_STANDARD_MODE = "Standard mode"
TNE_FiveSec_HELP_REVERSE_MODE = "Reverse mode"
TNE_FiveSec_HELP_RESET = "The bar position has been restored."
TNE_FiveSec_HELP_HIDDEN = "FiveSec hidden mode"
TNE_FiveSec_HELP_FRACTION = "Split seconds in timer"

TNE_FiveSec_CMD_UNKNOWN = "Unknown command. Use %s for help." -- %s is the help command
TNE_FiveSec_CMD_ADDON_STATUS = "Addon is %s. Use %s for help." -- first %s is enabled or disabled, second is the help command
TNE_FiveSec_CMD_HELP = "help"
TNE_FiveSec_CMD_DISABLED = "disabled"
TNE_FiveSec_CMD_ENABLED = "enabled" 
TNE_FiveSec_CMD_ON = "on"
TNE_FiveSec_CMD_OFF = "off"
TNE_FiveSec_CMD_MOVE = "move" -- to move the bar
TNE_FiveSec_CMD_ABOUT = "about" -- author and addon information
TNE_FiveSec_CMD_RESET = "reset" -- restore to defaults
TNE_FiveSec_CMD_HIDDEN = "hidden" -- invisible mode
TNE_FiveSec_CMD_FRACTION = "fraction" -- display timer with one decimal
TNE_FiveSec_CMD_MODE = "mode" -- as in 'state'
TNE_FiveSec_CMD_MODE_STANDARD = "standard" -- bar is increasing
TNE_FiveSec_CMD_MODE_REVERSE = "reverse" -- bar is decreasing


if (GetLocale() == "deDE") then 

  TNE_FiveSec_RegenerationBuffs = {
    "Aura des blauen Drachen", "Anregen", "Willensentzug",
  }

end

if (GetLocale() == "frFR") then

  TNE_FiveSec_RegenerationBuffs = {
    "Aura du dragon bleu", "Innervation", "Connexion spirituelle",
  }

end

if (GetLocale() == "koKR") then

end
