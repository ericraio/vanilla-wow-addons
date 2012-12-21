

-- LowHealthWarning localization
--------------------------------------------------------------------------------

TNE_LowHealthSettings_Labels = {
  [1] = "Low Health Warning",
  [2] = "Version",
}

TNE_LowHealthSettings_Buttons = {
  [1] = "Defaults",
  [2] = "Cancel",
  [3] = "Okey",
}

TNE_LowHealthSettings_Sliders = {
  ["Sound"] = {
    [1] = { "Health", "Activate heartbeat when health is below: %d%%", },
  },
  ["Health"] = {
    [1] = { "Health", "Health: %d%%", },
    [2] = { "Critical health", "Critical health: %d%%", },
  },
  ["Mana"] = {
    [1] = { "Mana", "Mana: %d%%", },
    [2] = { "Critical mana", "Critical mana: %d%%", },
  },
}

TNE_LowHealthSettings_CheckButtons = {
  ["General"] = {
    [1] = { "Enable Low Health Warning", "Check to enable the addon.", },
  },
  ["Sound"] = {
    [1] = { "Enable heartbeat effect", "Check to enable a heartbeat sound effect.", },
    [2] = { "Only in combat", "Check to play sounds when in combat only.", },
  },
  ["Health"] = {
    [1] = { "Enable health effect", "Check to enable the health warning effect.", },
    [2] = { "Only in combat", "Check to display health warning in combat only.", },
    [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds. This will synchronize the flash with the heartbeat." },
    [4] = { "Emote when critical", "Check to automatically perform the /healme emote when your health is critical.", },
  },
  ["Mana"] = {
    [1] = { "Enable mana effect", "Check to enable the health warning effect.", },
    [2] = { "Only in combat", "Check to display mana warning in combat only.", },
    [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds.", },
  },
}

if (GetLocale() == "deDE") then 

  -- German localization originally by Myr of European Gul'dan

  TNE_LowHealthSettings_Labels = {
    [1] = "Low Health Warnung",
    [2] = "Version",
  }

  TNE_LowHealthSettings_Buttons = {
    [1] = "Standard",
    [2] = "Abbrechen",
    [3] = "Ok",
  }

  TNE_LowHealthSettings_Sliders = {
    ["Sound"] = { -- do not translate this line
      [1] = { "Leben", "Activate heartbeat when health is below: %d%%", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Leben", "Leben: %d%%", },
      [2] = { "Kritische Lebenspunkte", "Kritische Lebenspunkte: %d%%", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Mana", "Mana: %d%%", },
      [2] = { "Kritisches Mana", "Kritisches Mana: %d%%", },
    },
  }

  TNE_LowHealthSettings_CheckButtons = {
    ["General"] = { -- do not translate this line
      [1] = { "Enable Low Health Warning", "Check to enable the addon.", },
    },
    ["Sound"] = { -- do not translate this line
      [1] = { "Enable heartbeat effect", "Check to enable a heartbeat sound effect.", },
      [2] = { "Only in combat", "Check to play sounds when in combat only.", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Enable health effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display health warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds. This will synchronize the flash with the heartbeat." },
      [4] = { "Emote when critical", "Check to automatically perform the /healme emote when your health is critical.", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Enable mana effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display mana warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds.", },
    },
  }

end

if (GetLocale() == "frFR") then

  -- French localization originally by Trucifix

  TNE_LowHealthSettings_Labels = {
    [1] = "Low Health Warning",
    [2] = "Version",
  }

  TNE_LowHealthSettings_Buttons = {
    [1] = "D\195\169faults",
    [2] = "Annuler",
    [3] = "Ok",
  }

  TNE_LowHealthSettings_Sliders = {
    ["Sound"] = { -- do not translate this line
      [1] = { "Soin", "Activate heartbeat when health is below: %d%%", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Soin", "Soin: %d%%", },
      [2] = { "Soin critique", "Soin critique: %d%%", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Mana", "Mana: %d%%", },
      [2] = { "Mana critique", "Mana critique: %d%%", },
    },
  }

  TNE_LowHealthSettings_CheckButtons = {
    ["General"] = { -- do not translate this line
      [1] = { "Enable Low Health Warning", "Check to enable the addon.", },
    },
    ["Sound"] = { -- do not translate this line
      [1] = { "Enable heartbeat effect", "Check to enable a heartbeat sound effect.", },
      [2] = { "Only in combat", "Check to play sounds when in combat only.", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Enable health effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display health warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds. This will synchronize the flash with the heartbeat." },
      [4] = { "Emote when critical", "Check to automatically perform the /healme emote when your health is critical.", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Enable mana effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display mana warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds.", },
    },
  }

end

if (GetLocale() == "koKR") then

  -- Korean localization originally by Mars

  TNE_LowHealthSettings_Labels = {
    [1] = "Low Health Warning",
    [2] = "버젼",
  }

  TNE_LowHealthSettings_Buttons = {
    [1] = "기본값",
    [2] = "취소",
    [3] = "확인",
  }
  
  TNE_LowHealthSettings_Sliders = {
    ["Sound"] = { -- do not translate this line
      [1] = { "Health", "Activate heartbeat when health is below: %d%%", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Health", "Health: %d%%", },
      [2] = { "Critical health", "Critical health: %d%%", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Mana", "Mana: %d%%", },
      [2] = { "Critical mana", "Critical mana: %d%%", },
    },
  }

  TNE_LowHealthSettings_CheckButtons = {
    ["General"] = { -- do not translate this line
      [1] = { "Enable Low Health Warning", "Check to enable the addon.", },
    },
    ["Sound"] = { -- do not translate this line
      [1] = { "Enable heartbeat effect", "Check to enable a heartbeat sound effect.", },
      [2] = { "Only in combat", "Check to play sounds when in combat only.", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Enable health effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display health warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds. This will synchronize the flash with the heartbeat." },
      [4] = { "Emote when critical", "Check to automatically perform the /healme emote when your health is critical.", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Enable mana effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display mana warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds.", },
    },
  }

end
