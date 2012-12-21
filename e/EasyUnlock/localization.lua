EU_LOCKBOXES = {
    ["Battered Junkbox"] = 75,
    ["Worn Junkbox"] = 125,
    ["Sturdy Junkbox"] = 175,
    ["Heavy Junkbox"] = 250,
    ["Ornate Bronze Lockbox"] = 0,
    ["Heavy Bronze Lockbox"] = 0,
    ["Iron Lockbox"] = 75,
    ["Strong Iron Lockbox"] = 125,
    ["Steel Lockbox"] = 175,
    ["Reinforced Steel Lockbox"] = 225,
    ["Mithril Lockbox"] = 225,
    ["Thorium Lockbox"] = 225,
    ["Eternium Lockbox"] = 225,
    ["Small Locked Chest"] = 0,
    ["Ironbound Locked Chest"] = 175,
    ["Reinforced Locked Chest"] = 250,
    ["Sturdy Locked Chest"] = 75,
    ["Battered Chest"] = 0
}

EU_UNLOCKBUTTON = "Unlock";
EU_SKILLTAB_LOCKPICKING = "Lockpicking";
EU_PICKLOCK_ABILITY = "Pick Lock";

EU_TOO_LOW_LOCKPICKING = "Sorry but I can't open %s - I have %s lockpicking although I need %s.";

EU_TOOLTIP_LOCKED = "Locked";

EA_COMPAT_LW_UNSUPPORTED = "[EasyUnlock] Update Link Wrangler to v1.39 or newer to enable lockpicking info on tooltips.";
--
-- German localization - Credits to to schr0nz.
--

if(GetLocale() == "deDE") then
    EU_LOCKBOXES = {
    ["Ramponierte Plunderkiste"] = 75,
    ["Abgenutzte Plunderkiste"] = 125,
    ["Stabile Plunderkiste"] = 175,
    ["Schwere Plunderkiste"] = 250,
    ["Verschn\195\182rkelte bronzene Schlie\195\159kassette"] = 0,
    ["Schwere bronzene Schlie\195\159kassette"] = 0,
    ["Eisenschlie\195\159kassette"] = 75,
    ["Starke Eisenschlieﬂkassette"] = 125,
    ["Stahlschlie\195\159kassette"] = 175,
    ["Verst\195\164rkte Stahlschlie\195\159kassette"] = 225,
    ["Mithrilschlie\195\159kassette"] = 225,
    ["Thoriumschlie\195\159kassette"] = 225,
    ["Eterniumschlie\195\159kassette"] = 225,
    ["Kleine verschlossene Truhe"] = 0,
    ["Mit Eisenbeschl\195\164gen verschlossene Truhe"] = 175,
    ["Verst\195\164rkte verschlossene Truhe"] = 250,
    ["Stabile verschlossene Truhe"] = 75,
    ["Ramponierte Truhe"] = 0
}
    
    EU_UNLOCKBUTTON = "Knacken";
    EU_SKILLTAB_LOCKPICKING = "Schlossknacken";
    EU_PICKLOCK_ABILITY = "Schloss knacken";
    
    EU_TOO_LOW_LOCKPICKING = "Sorry, ich kann die %s nicht \195\182ffnen - Ich habe erst %s'er Skill. Ich br\195\164uchte %s."; 
 
    EU_TOOLTIP_LOCKED = "Verschlossen";
    
    -- Thanks soulcore @ Quakenet #wow.de
    EA_COMPAT_LW_UNSUPPORTED = "Aktualisiere Link Wrangler auf Version 1.39 oder neuer um Schl\195\182sser knacken Infos im Tooltip zu aktivieren";
end