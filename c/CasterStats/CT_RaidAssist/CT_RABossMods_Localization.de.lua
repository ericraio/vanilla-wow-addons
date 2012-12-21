if (GetLocale()=="deDE") then
	-- BossMod extensions:
	-- Raid zones
	CT_RABOSS_LOCATIONS_MOLTENCORE 		= "Geschmolzener Kern";
	CT_RABOSS_LOCATIONS_BLACKWINGSLAIR 		= "Pechschwingenhort";
	CT_RABOSS_LOCATIONS_ONYXIASLAIR 		= "Onyxias Hort";
	CT_RABOSS_LOCATIONS_ZULGURUB 		= "Zul'Gurub";
	CT_RABOSS_LOCATIONS_OUTDOOR 	= "Wildnis";
	CT_RABOSS_LOCATIONS_OTHER 	= "Sonstiges";
	
	-- Raidzones
	CT_RABOSS_MINIMAPLOC_MOLTENCORE 		= "Geschmolzener Kern";
	CT_RABOSS_MINIMAPLOC_BLACKWINGSLAIR 		= "Pechschwingenhort";
	CT_RABOSS_MINIMAPLOC_ONYXIASLAIR 		= "Onyxias Hort";
	CT_RABOSS_MINIMAPLOC_ZULGURUB 		= "Zul'Gurub";
	CT_RABOSS_MINIMAPLOC_OUTDOOR 	= "Wildnis";
	CT_RABOSS_MINIMAPLOC_OTHER 	= "Sonstiges";

	-- Common strings
	CT_RABOSS_REQ_LEADER_OR_PROM 	= "|c00FF0000Ben\195\182tigt Leiter oder bef\195\182rdert Status.|r";
	CT_RABOSS_ANNOUNCE				= "Schlachtgruppe melden";
	CT_RABOSS_ANNOUNCE_INFO			= "Meldet den Alarm der ganzen Schlachtgruppe. ";


	-- Majordomo
	CT_RABOSS_DOMO_INFO 				= "Zeigt Warnungen f\195\188r die periodisch auftretenden Schadensschilde und Magiereflektion an";
	CT_RABOSS_DOMO_REFLECTWARN 		= "*** MAGIE REFLEKTION F\195\156R 10 SEKUNDEN ***";
	CT_RABOSS_DOMO_DMGSHIELDWARN 	= "*** SCHADENSSCHILD F\195\156R 10 SEKUNDEN ***";
	CT_RABOSS_DOMO_5SECWARN 			= "*** 5 SEKUNDEN BIS F\195\159HIGKEIT ***";
	CT_RABOSS_DOMO_SHIELDS 			= { "MAGIE REFLEKTION", "SCHADENSSCHILD" };
	CT_RABOSS_DOMO_SHIELD_DOWN		= " AUS ***";
	
	CT_RABOSS_DOMO_REFLECT_GAIN = "bekommt Magiereflexion";
	CT_RABOSS_DOMO_DMGSHIELD_GAIN = "bekommt Schadenschild";
	CT_RABOSS_DOMO_REFLECT_FADE = "Magiereflexion schwindet";
	CT_RABOSS_DOMO_DMGSHIELD_FADE = "Schadenschild schwindet";

	-- Baron Geddon
	CT_RABOSS_BARON_INFO 			= "Zeigt eine Warnung an, falls Ihr oder ein benachbarter Spieler die Bombe seid";
	CT_RABOSS_ALERT_NEARBY			= "Warnung f\195\188r nahe Spieler";
	CT_RABOSS_ALERT_NEARBY_INFO		= "Warnt Euch, wenn ein Spieler aus der N\195\164he die Bombe ist."
	CT_RABOSS_TELL_TARGET			= "Ziel benachrichtigen";
	CT_RABOSS_TELL_TARGET_INFO		= "Sendet eine Nachricht an Spieler, die von der lebenden Bombe betroffen sind.";
	CT_RABOSS_BARON_BOMBWARNYOU		= "*** IHR SEID DIE BOMBE ***";
	CT_RABOSS_BARON_BOMBWARNTELL		= "DU BIST DIE BOMBE!";
	CT_RABOSS_BARON_BOMBWARNRAID     = " IST DIE BOMBE";
	
	CT_RABOSS_BARON_AFFLICT_BOMB 		= "^([^%s]+) ([^%s]+) von Lebende Bombe betroffen";
	CT_RABOSS_BARON_AFFLICT_SELF_MATCH1 	= "Ihr";
	CT_RABOSS_BARON_AFFLICT_SELF_MATCH2	= "seid";


	-- Magmadar
	CT_RABOSS_MAGMADAR_INFO			= "Warnungen f\195\188r Magmadars Raserei und AE Furcht.";
	CT_RABOSS_MAGMADAR_TRANQSHOT		= "*** RASEREI - EINLULLENDER SCHUSS NUTZEN ***";
	CT_RABOSS_MAGMADAR_5SECWARN		= "*** 5 SEKUNDEN BIS AE FURCHT ***";
	CT_RABOSS_MAGMADAR_30SECWARN		= "*** AE FURCHT - 30 Sekunden zur n\195\164chsten ***";
	
	CT_RABOSS_MAGMADAR_FRENZY 		= "ger\195\164t in t\195\182dliche Raserei!";
	CT_RABOSS_MAGMADAR_PANIC 		= "von Panik";


	-- Gehennas
	CT_RABOSS_GEHENNAS_INFO			= "Warnung f\195\188r Gehennas AE Anti-Heil Fluch";
	CT_RABOSS_GEHENNAS_5SECWARN		= "*** 5 SEKUNDEN BIS AE FLUCH ***";
	CT_RABOSS_GEHENNAS_30SECWARN		= "*** AE FLUCH - 30 Sekunden zum n\195\164chsten ***";
	
	CT_RABOSS_GEHENNAS_CURSE			= "von Gehennas";


	-- Ragnaros
	CT_RABOSS_RAGNAROS_INFO			= "Warnung f\195\188r Ragnaros 'Zorn von Ragnaros' Knockback und Alarm f\195\188r S\195\182hne der Flamme.";
	CT_RABOSS_RAGNAROS_EMERGE		= "*** Ragnaros ist aufgetaucht.  3 Minuten bis zum Untertauchen. ***";
	CT_RABOSS_RAGNAROS_60SECSSONS	= "*** 60 Sekunden bis Ragnaros untertaucht & S\195\182hne der Flamme. ***";
	CT_RABOSS_RAGNAROS_20SECSSONS	= "*** 20 Sekunden bis Ragnaros untertaucht & S\195\182hne der Flamme. ***";
	CT_RABOSS_RAGNAROS_5SECSKNOCKB	= "*** 5 SEKUNDEN BIS AE KNOCKBACK ***";
	CT_RABOSS_RAGNAROS_KNOCKB		= "*** AE Knockback ***";
	CT_RABOSS_RAGNAROS_SUBMERGE		= "*** Ragnaros immun f\195\188r 90 Sekunden - S\195\182hne der Flamme kommen ***";
	CT_RABOSS_RAGNAROS_15SECSUP		= "*** 15 Sekunden bis Ragnaros wieder auftaucht. ***";
	
	CT_RABOSS_RAGNAROS_START 		= "^UND JETZT ZU EUCH";
	CT_RABOSS_RAGNAROS_KNOCKBACK 	= "^SP\195\156RT";


	-- Shazzrah
	CT_RABOSS_SHAZZRAH_INFO			= "Warnung f\195\188r Shazzrahs Blinzeln und Magieunterdr\195\188ckung";
	CT_RABOSS_SHAZZRAH_30SECSBLINK	= "*** BLINZELN - 30 BIS N\195\150CHTES ***";
	CT_RABOSS_SHAZZRAH_5SECSBLINK	= "*** 5 SEKUNDEN BIS BLINZELN ***";
	CT_RABOSS_SHAZZRAH_SELFBUFF		= "*** SELBSTBUFF - MAGIEBANNEN ***";
	
    CT_RABOSS_SHAZZRAH_BLINK		= "Shazzrah wirkt Portal von Shazzrah";                  
    CT_RABOSS_SHAZZRAH_DEADENMAGIC	= "Shazzrah bekommt Magie";


	-- Lucifron
	CT_RABOSS_LUCIFRON_INFO			= "Warnung f\195\188r Lucifrons Fluch und, falls aktiv, seine Drohende Verdammnis F\195\164higkeit";
	CT_RABOSS_LUCIFRON_DOOMMENU		= "Vor Drohender Verdammnis warnen";
	CT_RABOSS_LUCIFRON_DOOMMENU_INFO	= "Warnt sowohl vor Lucifrons Fluch wie vor Drohender Verdammnis";
	CT_RABOSS_LUCIFRON_5SECSCURSE	= "*** 5 SEKUNDEN BIS AE FLUCH ***";
	CT_RABOSS_LUCIFRON_5SECSDOOM		= "*** 5 SEKUNDEN BIS DROHENDE VERDAMMNIS***";
	CT_RABOSS_LUCIFRON_30SECSCURSE	= "*** AE FLUCH - 15 Sekunden zum n\195\164chsten ***";
	CT_RABOSS_LUCIFRON_30SECSDOOM	= "*** DROHENDE VERDAMMNIS - 15 Sekunden Pause ***";


	-- Onyxia
	CT_RABOSS_ONYXIA_INFO			= "Zeigt eine Warnung an, falls Onyxia in Phase 2 eine tiefen Atemzug nimmt.";
	CT_RABOSS_ONYXIA_DEEPBREATH		= "*** ONYXIA TIEFER ATEM - AUF DIE SEITEN ***"
	
	
	-- Azuregos
	CT_RABOSS_AZUREGOS_INFO			= "Warnung vor Azuregos Teleport & Magieschild F\195\164higkeiten.";
	CT_RABOSS_AZUREGOS_SHIELDWARN	= "*** MAGIESCHILD AKTIV - KEINE ZAUBER BENUTZEN ***";
	CT_RABOSS_AZUREGOS_SHIELDDOWN	= "*** MAGIESCHILD AUS ***";
	CT_RABOSS_AZUREGOS_PORTWARN		= "*** TELEPORT ***";
	
	-- Bloodlord Mandokir
	CT_RABOSS_MANDOKIR_INFO 			= "Zeigt eine Meldung, wenn jemand von Mandokir beobachtet wird.";
	CT_RABOSS_MANDOKIR_TELL_TARGET		= "Ziel benachrichtigen";
	CT_RABOSS_MANDOKIR_TELL_TARGET_INFO	= "Sendet eine Nachricht an das Ziel, dass es beobachtet wird";
	CT_RABOSS_MANDOKIR_WATCHWARNYOU		= "*** DU WIRST BEOBACHTET ***";
	CT_RABOSS_MANDOKIR_WATCHWARNTELL	= "DU WIRST BEOBACHTET!";
	CT_RABOSS_MANDOKIR_WATCHWARNRAID    = " WIRD BEOBACHTET";
	CT_RABOSS_MANDOKIR_REGEXP			= "([^%s]+)! Ich behalte Euch im Auge!$";

	-- Mar'li
	CT_RABOSS_MARLI_INFO			= "Zeigt eine Warnung, wenn Hohepriesterin Mar'li Spinnen beschwört."
	CT_RABOSS_MARLI_REGEXP			= "Helft mir, meine Brut!$"
	CT_RABOSS_MARLI_ADDS			= "SPINNEN"
end