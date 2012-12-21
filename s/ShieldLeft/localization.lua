SL_MODNAME = "ShieldLeft";
SL_VERSION = "11000.2";
SL_RELEASEDATE	= "04/02/2006";

-- Version : English
SL_MSG_HELP = "You can use the following slash commands to control ShieldLeft:\n" ..
		"|c00FFFFFF/shieldleft info|r - shows the max. shield and all saved values for mobs.\n" ..
		"|c00FFFFFF/shieldleft check|r - rechecks the max. shield after learning a new rank.\n" ..
		"|c00FFFFFF/shieldleft verbose|r - toggles verbose mode.\n" ..
		"|c00FFFFFF/shieldleft reset|r - resets all saved data.\n" ..
		"Note that you can also use |c00FFFFFF/sl|r.";
SL_MSG_CLICKTODRAG = "Click to drag";
SL_MSG_LOADED = "ShieldLeft " .. SL_VERSION .. " loaded. Write /shieldleft for more info.";
SL_MSG_SHIELDLEFT = "Shield: |c00FFFFFF";

SL_MSG_NEWCRITTER = "new critter: ";
SL_MSG_NEWSPELLFOR = "new spell for ";
SL_MSG_NEWMAXSHIELD = "new max. shield: ";
SL_MSG_CHECKINGSPELLS = "checking spells...";
SL_MSG_MAXSHIELD = "max. shield: ";
SL_MSG_STATSRESET = "all stats are reset.";
SL_MSG_ON					= "|cff00ff00ON|r";
SL_MSG_OFF				= "|cffff0000OFF|r";
SL_MSG_VERBOSEON		= "verbose output is "..SL_MSG_ON;
SL_MSG_VERBOSEOFF		= "verbose output is "..SL_MSG_OFF;
SL_MSG_DEBUGON		= "debug output is "..SL_MSG_ON;
SL_MSG_DEBUGOFF		= "debug output is "..SL_MSG_OFF;

-- chat messages

-- meelee damage
SL_HITSYOUABSORBED = "(.+) hits you for (%d+) %((%+) absorbed%)%.";
SL_CRITSYOUABSORBED = "(.+) crits you for (%d+) %((%+) absorbed%)%.";
SL_HITSYOUBLOCKED = "(.+) hits you for (%d+)%. %((%+) blocked%)";
SL_CRITSYOUBLOCKED = "(.+) crits you for (%d+)%. %((%+) blocked%)";
SL_HITSYOUFOR = "(.+) hits you for (%d+)%.";
SL_CRITSYOUFOR = "(.+) crits you for (%d+)%.";
SL_ABSORBALL = "(.+) attacks%. You absorb all the damage%.";

-- ranged damage
SL_RANGED_HITSYOUABSORBED = "(.+)'s (.+) hits you for (%d+) %((%d+) absorbed%)%.";
SL_RANGED_CRITSYOUABSORBED = "(.+)'s (.+) crits you for (%d+) %((%d+) absorbed%)%.";
SL_RANGED_HITSYOU = "(.+)'s (.+) hits you for (%d+)%.";
SL_RANGED_HITSYOU2 = "(.+)'s (.+) hits you for (%d+)%.";
SL_RANGED_CRITSYOU = "(.+)'s (.+) crits you for (%d+)%.";
SL_RANGED_YOUABSORB = "You absorb (.+)'s (.+)%.";

-- self damage
SL_YOURHITSYOU = "Your (.+) hits you for (%d+)%.";
SL_YOUABSORBYOUR = "You absorb your (.+)%.";
SL_YOUSUFFER = "You suffer (%d+) .+ from (.+)'s (.+)%.";


-- settings depending on the class
SL_SHIELD_PRIEST = "Power Word: Shield";
SL_ABSORBING_PRIEST = "absorbing (%d+) damage";
SL_YOUGAINSHIELD_PRIEST = "You gain " .. SL_SHIELD_PRIEST .. ".";
SL_YOULOOSESHIELD_PRIEST = SL_SHIELD_PRIEST .. " fades from you.";

SL_SHIELD_WARLOCK = "Sacrifice";
SL_ABSORBING_WARLOCK = "will absorb (%d+) damage";
SL_YOUGAINSHIELD_WARLOCK = "You gain " .. SL_SHIELD_WARLOCK .. ".";
SL_YOULOOSESHIELD_WARLOCK = SL_SHIELD_WARLOCK .. " fades from you.";

SL_SHIELD_MAGE = "Mana Shield";
SL_ABSORBING_MAGE = "Absorbs (%d+) physical damage";
SL_YOUGAINSHIELD_MAGE = "You gain " .. SL_SHIELD_MAGE .. ".";
SL_YOULOOSESHIELD_MAGE = SL_SHIELD_MAGE .. " fades from you.";


-- Version : French
-- Last Update : 
if ( GetLocale() == "frFR" ) then
end


-- Version : German (by VincentGdG)
-- ä = \195\164
-- ö = \195\182
-- ü = \195\188
-- Ä = \195\132
-- Ö = \195\150
-- Ü = \195\156
-- ß = \195\159
if ( GetLocale() == "deDE" ) then

SL_RELEASEDATE	= "02.04.2006";

SL_MSG_HELP = "Du kannst folgende Slash-Kommandos benutzen:\n" ..
		"|c00FFFFFF/shieldleft info|r - zeigt das max. Schild und alle gespeicherten Werte der Mobs.\n" ..
		"|c00FFFFFF/shieldleft check|r - scannt den max. Schild-Spruch neu, z.B. nach dem Lernen eines neuen Rangs.\n" ..
		"|c00FFFFFF/shieldleft verbose|r - schaltet Ausgaben um\n" ..
		"|c00FFFFFF/shieldleft reset|r - setzt alle gespeicherten Daten zur\195\188ck.\n" ..
		"Du kannst auch |c00FFFFFF/sl|r benutzen.";
SL_MSG_CLICKTODRAG = "Klicken zum Ziehen";
SL_MSG_LOADED = "ShieldLeft " .. SL_VERSION .. " geladen. Tippe /shieldleft f\195\188r weitere Infos.";
SL_MSG_SHIELDLEFT = "Schild \195\188brig: |c00FFFFFF";

SL_MSG_NEWCRITTER = "neuer Feind: ";
SL_MSG_NEWSPELLFOR = "neuer Spruch f\195\188r ";
SL_MSG_NEWMAXSHIELD = "neuer max. Schild: ";
SL_MSG_CHECKINGSPELLS = "untersuche Spr\195\188che...";
SL_MSG_MAXSHIELD = "max. Schild: ";
SL_MSG_STATSRESET = "Alle Daten wurden gel\195\182scht.";
SL_MSG_ON					= "|cff00ff00AN|r";
SL_MSG_OFF				= "|cffff0000AUS|r";
SL_MSG_VERBOSEON		= "ausf\195\188hrliche Ausgaben sind "..SL_MSG_ON;
SL_MSG_VERBOSEOFF		= "ausf\195\188hrliche Ausgaben sind "..SL_MSG_OFF;
SL_MSG_DEBUGON		= "Debug-Ausgaben sind "..SL_MSG_ON;
SL_MSG_DEBUGOFF		= "Debug-Ausgaben sind "..SL_MSG_OFF;

-- chat messages

-- meelee damage
SL_HITSYOUABSORBED = "(.+) trifft Euch f\195\188r (%d+) Schaden%.%((%d+) absorbiert%)";
SL_CRITSYOUABSORBED = "(.+) trifft Euch kritisch. Schaden: (%d+)%.%((%d+) absorbiert%)";
SL_HITSYOUBLOCKED = "(.+) trifft Euch f\195\188r (%d+) Schaden%.%((%d+) geblockt%)";
SL_CRITSYOUBLOCKED = "(.+) trifft Euch kritisch. Schaden: (%d+)%.%((%d+) geblockt%)";
SL_HITSYOUFOR = "(.+) trifft Euch f\195\188r (%d+) Schaden%.";
SL_CRITSYOUFOR = "(.+) trifft Euch kritisch. Schaden: (%d+)%.";
SL_ABSORBALL = "(.+) greift an%. Ihr absorbiert allen Schaden%.";

-- ranged damage
SL_RANGED_HITSYOUABSORBED = "(.+)s (.+) trifft Euch f\195\188r (%d+) .+ Schaden%.%((%d+) absorbiert%)";
SL_RANGED_CRITSYOUABSORBED = "(.+)s (.+) trifft Euch kritisch. Schaden: (%d+)%.%((%d+) absorbiert%)";
SL_RANGED_HITSYOU = "(.+)s (.+) trifft Euch f\195\188r (%d+) .+ Schaden%.";
SL_RANGED_HITSYOU2 = "(.+) trifft Euch %(mit (.+)%). Schaden: (%d+)%.";
SL_RANGED_CRITSYOU = "(.+)s (.+) trifft Euch kritisch. Schaden: (%d+)%.";
SL_RANGED_YOUABSORB = "Ihr absorbiert (.+)s (.+)";

-- self damage
SL_YOURHITSYOU = "Euer (.+) trifft Euch f\195\188r (%d+)%.";
SL_YOUABSORBYOUR = "Ihr absorbiert Euer (.+)%.";
SL_YOUSUFFER = "Ihr erleidet (%d+) .+ durch (.+)s (.+)%.";

-- settings depending on the class
SL_SHIELD_PRIEST = "Machtwort: Schild";
SL_ABSORBING_PRIEST = "absorbiert dabei (%d+) Punkt";
SL_YOUGAINSHIELD_PRIEST = "Ihr bekommt '" .. SL_SHIELD_PRIEST .. "'.";
SL_YOULOOSESHIELD_PRIEST = "'" .. SL_SHIELD_PRIEST .. "' schwindet von Euch.";

SL_SHIELD_WARLOCK = "Opferung";
SL_ABSORBING_WARLOCK = "lang (%d+) Punkt";
SL_YOUGAINSHIELD_WARLOCK = "Ihr bekommt '" .. SL_SHIELD_WARLOCK .. "'.";
SL_YOULOOSESHIELD_WARLOCK = "'" .. SL_SHIELD_WARLOCK .. "' schwindet von Euch.";

SL_SHIELD_MAGE = "Manaschild";
SL_ABSORBING_MAGE = "Absorbiert (%d+) Punkt";
SL_YOUGAINSHIELD_MAGE = "Ihr bekommt '" .. SL_SHIELD_MAGE .. "'.";
SL_YOULOOSESHIELD_MAGE = "'" .. SL_SHIELD_MAGE .. "' schwindet von Euch.";

end
