

-- Nightfall localization
--------------------------------------------------------------------------------

-- To localize this addon:
--   1: copy all the data to the language you're localizing to,
--   2: make sure the strings keep their order,
--   3: write a short comment somewhere in this file; let me know
--      under what name you want to be credited, and anything else
--      you'd like to add,
--   4: save and send this whole file to: silentaddons@gmail.com
--   5: Thank you :)


TNE_NightfallSettings_Labels = {
  [1] = "Nightfall",
  [2] = "Version",
}

TNE_NightfallSettings_ButtonStrings = {
  [1] = "Defaults",
  [2] = "Cancel",
  [3] = "Okey",
}

TNE_NightfallSettings_CheckButtonStrings = {
  [1] = "Enable Shadow Trance effect",
  [2] = "Use large effect",
  [3] = "Enable sound effect",
  [4] = "Enable Soul Shard creation effect",
}

TNE_NightfallSettings_CheckButtonTooltipStrings = {
  [1] = "Check to enable Shadow Trance effect.",
  [2] = "Check to use a larger effect for Shadow Trance.",
  [3] = "Check to play a sound effect when you gain Shadow Trance.",
  [4] = "Check to show an effect each time you create a shard.",
}

TNE_Nightfall_String_SoulShard = "Soul Shard"
TNE_Nightfall_String_ShadowTrance = "Shadow Trance"
TNE_Nightfall_String_YouCreate = "You create"


if (GetLocale() == "deDE") then 

  -- German localization (originally by Citanul of Krag'jin)
  -- Thanks to Gafarion (Alleria, EU) for adjustments

  TNE_NightfallSettings_Labels = {
    [1] = "Nightfall",
    [2] = "Version",
  }
  
  TNE_NightfallSettings_ButtonStrings = {
    [1] = "Standard",
    [2] = "Abbrechen",
    [3] = "OK",
  }
  
  TNE_NightfallSettings_CheckButtonStrings = {
    [1] = "Effekt fuer Schattentrance aktivieren",
    [2] = "Grossen Effekt verwenden",
    [3] = "Soundeffekt aktivieren",
    [4] = "Herstellungseffekt fuer Seelensplitter aktivieren",
  }
  
  TNE_NightfallSettings_CheckButtonTooltipStrings = {
    [1] = "Klicken um den Effekt fuer Schattentrance einzuschalten.",
    [2] = "Klicken um einen grossen Effekt fuer Schattentrance zu verwenden.",
    [3] = "Klicken um einen Soundeffekt abspielen zu lassen, wenn man in Schattentrance versetzt wird.",
    [4] = "Klicken um jedes Mal, wenn ein Seelensplitter hergestellt wird, einen Effekt anzeigen zu lassen.",
  }

  TNE_Nightfall_String_SoulShard = "Seelensplitter"
  TNE_Nightfall_String_ShadowTrance = "Schattentrance"
  TNE_Nightfall_String_YouCreate = "Ihr stellt her"

end

if (GetLocale() == "frFR") then

  TNE_Nightfall_String_SoulShard = "Fragment d'âme"
  TNE_Nightfall_String_ShadowTrance = "Transe de l'ombre"
  TNE_Nightfall_String_YouCreate = "Vous créez"

end

if (GetLocale() == "koKR") then

end
