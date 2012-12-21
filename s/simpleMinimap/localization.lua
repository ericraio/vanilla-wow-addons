--[[ simpleMinimap localization file ]]--

-- english defaults
sm_HELP = {
  "/smm show X :: show button X",
  "/smm hide X :: hide button X",
  " >> X can be 'location', 'time', or 'zoom'",
  "/smm alpha N :: set minimap alpha to N (0~1)",
  "/smm scale N :: set minimap scale to N (>0)",
  "/smm lock :: lock minimap movement and hide movers",
  "/smm ping :: toggle minimap ping tooltips",
  "/smm skin :: cycle to next minimap skin",
  "/smm reset :: reset minimap to defaults",
}

-- german localization
if (GetLocale()=="deDE") then
  sm_HELP = {
    "/smm show X :: Zeige Button X",
    "/smm hide X :: Verstecke Button X",
    " >> X kann 'location', 'time', oder 'zoom' sein",
    "/smm alpha N :: Setze Minimap Transparenz zu N (0~1)",
    "/smm scale N :: Setze Minimap Skalierung zu (>0)",
    "/smm lock :: Minimap und Buttons fixieren oder freigeben",
    "/smm ping :: Minimap Ping Tooltips wechseln",
    "/smm skin :: Minimap Skins wechseln",
    "/smm reset :: Minimap auf Standard zur\195\188cksetzen",
  }
end
