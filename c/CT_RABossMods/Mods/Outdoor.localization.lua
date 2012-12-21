-- Azuregos
CT_RABOSS_AZUREGOS_INFO			= "Warns for Azuregos' Teleport and Magic Shield abilities.";
CT_RABOSS_AZUREGOS_SHIELDWARN	= "*** MAGIC SHIELD UP - DO NOT CAST SPELLS ***";
CT_RABOSS_AZUREGOS_SHIELDDOWN	= "*** MAGIC SHIELD DOWN ***";
CT_RABOSS_AZUREGOS_PORTWARN		= "*** TELEPORT ***";

CT_RABOSS_AZUREGOS_REFLECTION 		=  "^Azuregos gains Reflection";
CT_RABOSS_AZUREGOS_REFLECTION_END 	= "^Reflection fades from Azuregos";
CT_RABOSS_AZUREGOS_TELEPORT 		= "Come, little ones";

-- Emeriss
CT_RABOSS_EMERISS_INFO 			= "Displays a warning when you or nearby players are afflicted by Volatile Infection.";
CT_RABOSS_EMERISS_ALERT_NEARBY			= "Alert for nearby players";
CT_RABOSS_EMERISS_ALERT_NEARBY_INFO		= "Alert you when nearby players are afflicted by Volatile Infection"
CT_RABOSS_EMERISS_TELL_TARGET			= "Send tells to targets";
CT_RABOSS_EMERISS_TELL_TARGET_INFO		= "Sends a tell to players that are afflicted by Volatile Infection";
CT_RABOSS_EMERISS_BOMBWARNYOU		= "*** YOU ARE AFFLICTED BY VOLATILE INFECTION ***";
CT_RABOSS_EMERISS_BOMBWARNTELL		= "YOU ARE AFFLICTED BY VOLATILE INFECTION!";
CT_RABOSS_EMERISS_BOMBWARNRAID     = " IS AFFLICTED BY VOLATILE INFECTION";

CT_RABOSS_EMERISS_AFFLICT_BOMB 		= "^([^%s]+) ([^%s]+) afflicted by Volatile Infection";
CT_RABOSS_EMERISS_AFFLICT_SELF_MATCH1 = "You";
CT_RABOSS_EMERISS_AFFLICT_SELF_MATCH2	= "are";

CT_RABOSS_EMERISS_BREATHMENU		= "Warn for Noxious Breath";
CT_RABOSS_EMERISS_BREATHMENU_INFO= "Warns for Noxious Breath";
CT_RABOSS_EMERISS_5SECSBREATH	= "*** 5 SECONDS UNTIL NOXIOUS BREATH ***";
CT_RABOSS_EMERISS_30SECSBREATH	= "*** NOXIOUS BREATH - 30 seconds till next ***";

CT_RABOSS_EMERISS_BREATH	= "afflicted by Noxious Breath";

if ( GetLocale() == "deDE" ) then
	-- Azuregos
	CT_RABOSS_AZUREGOS_INFO			= "Warnung vor Azuregos Teleport & Magieschild F\195\164higkeiten.";
	CT_RABOSS_AZUREGOS_SHIELDWARN	= "*** MAGIESCHILD AKTIV - KEINE ZAUBER BENUTZEN ***";
	CT_RABOSS_AZUREGOS_SHIELDDOWN	= "*** MAGIESCHILD AUS ***";
	CT_RABOSS_AZUREGOS_PORTWARN		= "*** TELEPORT ***";
	
    CT_RABOSS_AZUREGOS_REFLECTION 		    = "bekommt 'Reflexion'";
    CT_RABOSS_AZUREGOS_REFLECTION_END 	    = "^Reflexion schwindet von Azuregos";
    CT_RABOSS_AZUREGOS_TELEPORT 		    = "wirkt Arkanes Vakuum";
end