-- Majordomo
CT_RABOSS_DOMO_INFO 				= "Displays warnings for the damage shield & magic reflection buffs that are peridiocally cast.";
CT_RABOSS_DOMO_REFLECTWARN 		= "*** MAGIC REFLECTION FOR 10 SECONDS ***";
CT_RABOSS_DOMO_DMGSHIELDWARN 	= "*** DAMAGE SHIELD FOR 10 SECONDS ***";
CT_RABOSS_DOMO_5SECWARN 			= "*** 5 SECONDS UNTIL POWERS ***";
CT_RABOSS_DOMO_SHIELDS 			= { "MAGIC REFLECTION", "DAMAGE SHIELD" };
CT_RABOSS_DOMO_SHIELD_DOWN		= " DOWN ***";

CT_RABOSS_DOMO_REFLECT_GAIN 		= "gains Magic Reflection";
CT_RABOSS_DOMO_DMGSHIELD_GAIN 	= "gains Damage Shield";
CT_RABOSS_DOMO_REFLECT_FADE 		= "Magic Reflection fades";
CT_RABOSS_DOMO_DMGSHIELD_FADE 	= "Damage Shield fades";


-- Baron Geddon
CT_RABOSS_BARON_INFO 			= "Displays a warning when you or nearby players are the bomb.";
CT_RABOSS_BARON_ALERT_NEARBY			= "Alert for nearby players";
CT_RABOSS_BARON_ALERT_NEARBY_INFO		= "Alert you when nearby players are afflicted by Living Bomb"
CT_RABOSS_BARON_TELL_TARGET			= "Send tells to targets";
CT_RABOSS_BARON_TELL_TARGET_INFO		= "Sends a tell to players that are afflicted by Living Bomb";
CT_RABOSS_BARON_BOMBWARNYOU		= "*** YOU ARE THE BOMB ***";
CT_RABOSS_BARON_BOMBWARNTELL		= "YOU ARE THE BOMB!";
CT_RABOSS_BARON_BOMBWARNRAID     = " IS THE BOMB";

CT_RABOSS_BARON_AFFLICT_BOMB 		= "^([^%s]+) ([^%s]+) afflicted by Living Bomb";
CT_RABOSS_BARON_AFFLICT_SELF_MATCH1 = "You";
CT_RABOSS_BARON_AFFLICT_SELF_MATCH2	= "are";


-- Magmadar
CT_RABOSS_MAGMADAR_INFO			= "Warnings for Magmadar's Frenzy and AE Fear attacks.";
CT_RABOSS_MAGMADAR_TRANQSHOT		= "*** FRENZY ALERT - HUNTER TRANQ SHOT NOW! ***";
CT_RABOSS_MAGMADAR_5SECWARN		= "*** 5 SECONDS UNTIL AE FEAR ***";
CT_RABOSS_MAGMADAR_30SECWARN		= "*** AE FEAR ALERT - 30 seconds till next ***";

CT_RABOSS_MAGMADAR_FRENZY 		= "%s goes into a killing frenzy!";
CT_RABOSS_MAGMADAR_PANIC 		= "by Panic.";


-- Gehennas
CT_RABOSS_GEHENNAS_INFO			= "Warning for Gehennas's AE Anti-Heal Curse.";
CT_RABOSS_GEHENNAS_5SECWARN		= "*** 5 SECONDS UNTIL AE CURSE ***";
CT_RABOSS_GEHENNAS_30SECWARN	= "*** AE CURSE ALERT - 30 seconds till next ***";

CT_RABOSS_GEHENNAS_CURSE		= "afflicted by Gehennas";


-- Ragnaros
CT_RABOSS_RAGNAROS_INFO			= "Warns for Ragnaros' Wrath of Ragnaros knockback, and alerts you of the Sons of Flame.";
CT_RABOSS_RAGNAROS_EMERGE		= "*** Ragnaros has Emerged. 3 minutes until submerge. ***";
CT_RABOSS_RAGNAROS_60SECSSONS	= "*** 60 seconds until Ragnaros submerge & sons of flame. ***";
CT_RABOSS_RAGNAROS_20SECSSONS	= "*** 20 seconds until Ragnaros submerge & sons of flame. ***";
CT_RABOSS_RAGNAROS_5SECSKNOCKB	= "*** 5 SECONDS UNTIL AE Knockback ***";
CT_RABOSS_RAGNAROS_KNOCKB		= "*** AE Knockback ***";
CT_RABOSS_RAGNAROS_SUBMERGE		= "*** Ragnaros Down for 90 Seconds. Incoming Sons of Flame ***";
CT_RABOSS_RAGNAROS_15SECSUP		= "*** 15 seconds until Ragnaros emerges. ***";

CT_RABOSS_RAGNAROS_START 		= "^NOW FOR YOU,";
CT_RABOSS_RAGNAROS_KNOCKBACK 	= "^TASTE";
CT_RABOSS_RAGNAROS_SONS 		= "^COME FORTH,";


-- Shazzrah
CT_RABOSS_SHAZZRAH_INFO			= "Warning for Shazzrah's Blink ability and the Deaden Magic buff.";
CT_RABOSS_SHAZZRAH_30SECSBLINK	= "*** BLINK - 30 SECONDS TO NEXT ***";
CT_RABOSS_SHAZZRAH_5SECSBLINK	= "*** 5 SECONDS TO BLINK ***";
CT_RABOSS_SHAZZRAH_SELFBUFF		= "*** SELF BUFF - DISPEL MAGIC ***";

CT_RABOSS_SHAZZRAH_BLINK 		= "Shazzrah gains Blink";
CT_RABOSS_SHAZZRAH_DEADENMAGIC 	= "Shazzrah gains Deaden Magic";


-- Lucifron
CT_RABOSS_LUCIFRON_INFO			= "Warning for Lucifron's Curse and, if you so choose, his Impending Doom ability.";
CT_RABOSS_LUCIFRON_DOOMMENU		= "Warn for Impending Doom";
CT_RABOSS_LUCIFRON_DOOMMENU_INFO= "Warns for Impending Doom as well as Lucifron's Curse";
CT_RABOSS_LUCIFRON_5SECSCURSE	= "*** 5 SECONDS UNTIL AE CURSE ***";
CT_RABOSS_LUCIFRON_5SECSDOOM	= "*** 5 SECONDS UNTIL IMPENDING DOOM ***";
CT_RABOSS_LUCIFRON_30SECSCURSE	= "*** AE CURSE ALERT - 20 seconds till next ***";
CT_RABOSS_LUCIFRON_30SECSDOOM	= "*** IMPENDING DOOM - 20 seconds till next ***";

CT_RABOSS_LUCIFRON_CURSE 		= "afflicted by Lucifron";
CT_RABOSS_LUCIFRON_DOOM 		= "afflicted by Impending Doom";

if ( GetLocale() == "deDE" ) then
	-- Majordomo
	CT_RABOSS_DOMO_INFO 				= "Zeigt Warnungen f\195\188r die periodisch auftretenden Schadensschilde und Magiereflektion an";
	CT_RABOSS_DOMO_REFLECTWARN 		    = "*** MAGIE REFLEKTION F\195\156R 10 SEKUNDEN ***";
	CT_RABOSS_DOMO_DMGSHIELDWARN 	    = "*** SCHADENSSCHILD F\195\156R 10 SEKUNDEN ***";
	CT_RABOSS_DOMO_5SECWARN 			= "*** 5 SEKUNDEN BIS Port ***";
	CT_RABOSS_DOMO_SHIELDS 			    = { "MAGIE REFLEKTION", "SCHADENSSCHILD" };
	CT_RABOSS_DOMO_SHIELD_DOWN		    = " AUS ***";
	
	CT_RABOSS_DOMO_REFLECT_GAIN         = "bekommt 'Magiereflexion'";               --work
	CT_RABOSS_DOMO_DMGSHIELD_GAIN       = "bekommt 'Schadenschild'";                --work
	CT_RABOSS_DOMO_REFLECT_FADE         = "Magiereflexion schwindet von";           --work
	CT_RABOSS_DOMO_DMGSHIELD_FADE       = "Schadenschild schwindet von";            --work

	-- Baron Geddon
	CT_RABOSS_BARON_INFO 			    = "Zeigt eine Warnung an, falls Ihr oder ein benachbarter Spieler die Bombe seid";
	CT_RABOSS_ALERT_NEARBY			    = "Warnung f\195\188r nahe Spieler";
	CT_RABOSS_ALERT_NEARBY_INFO		    = "Warnt Euch, wenn ein Spieler aus der N\195\164he die Bombe ist."
	CT_RABOSS_TELL_TARGET			    = "Ziel benachrichtigen";
	CT_RABOSS_TELL_TARGET_INFO		    = "Sendet eine Nachricht an Spieler, die von der lebenden Bombe betroffen sind.";
	CT_RABOSS_BARON_BOMBWARNYOU		    = "*** IHR SEID DIE BOMBE ***";
	CT_RABOSS_BARON_BOMBWARNTELL		= "DU BIST DIE BOMBE!";
	CT_RABOSS_BARON_BOMBWARNRAID        = " IST DIE BOMBE";
	
	CT_RABOSS_BARON_AFFLICT_BOMB 		    = "^([^%s]+) ([^%s]+) von Lebende Bombe betroffen";     --work
	CT_RABOSS_BARON_AFFLICT_SELF_MATCH1 	= "Ihr";                                                --work
	CT_RABOSS_BARON_AFFLICT_SELF_MATCH2	    = "seid";                                               --work


	-- Magmadar
	CT_RABOSS_MAGMADAR_INFO			= "Warnungen f\195\188r Magmadars Raserei und AE Furcht.";
	CT_RABOSS_MAGMADAR_TRANQSHOT	= "*** RASEREI - EINLULLENDER SCHUSS NUTZEN ***";
	CT_RABOSS_MAGMADAR_5SECWARN		= "*** 5 SEKUNDEN BIS AE FURCHT ***";
	CT_RABOSS_MAGMADAR_30SECWARN	= "*** AE FURCHT - 30 Sekunden zur n\195\164chsten ***";
	
	CT_RABOSS_MAGMADAR_FRENZY 		= "ger\195\164t in t\195\182dliche Raserei!";           --work
	CT_RABOSS_MAGMADAR_PANIC 		= "von Panik";                                          --work

	-- Gehennas
	CT_RABOSS_GEHENNAS_INFO			= "Warnung f\195\188r Gehennas AE Anti-Heil Fluch";
	CT_RABOSS_GEHENNAS_5SECWARN		= "*** 5 SEKUNDEN BIS AE FLUCH ***";
	CT_RABOSS_GEHENNAS_30SECWARN	= "*** AE FLUCH - 30 Sekunden zum n\195\164chsten ***";
	
	CT_RABOSS_GEHENNAS_CURSE		= "von Gehennas";                                       --work


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
    CT_RABOSS_RAGNAROS_SONS 		= "^VORW\195\164RTS,";


	-- Lucifron
	CT_RABOSS_LUCIFRON_INFO			    = "Warnung f\195\188r Lucifrons Fluch und, falls aktiv, seine Drohende Verdammnis F\195\164higkeit";
	CT_RABOSS_LUCIFRON_DOOMMENU		    = "Vor Drohender Verdammnis warnen";
	CT_RABOSS_LUCIFRON_DOOMMENU_INFO	= "Warnt sowohl vor Lucifrons Fluch wie vor Drohender Verdammnis";
	CT_RABOSS_LUCIFRON_5SECSCURSE	    = "*** 5 SEKUNDEN BIS AE FLUCH ***";
	CT_RABOSS_LUCIFRON_5SECSDOOM		= "*** 5 SEKUNDEN BIS DROHENDE VERDAMMNIS***";
	CT_RABOSS_LUCIFRON_30SECSCURSE	    = "*** AE FLUCH - 15 Sekunden zum n\195\164chsten ***";
	CT_RABOSS_LUCIFRON_30SECSDOOM	    = "*** DROHENDE VERDAMMNIS - 15 Sekunden Pause ***";

	CT_RABOSS_LUCIFRON_CURSE 		    = "von Lucifron";
	CT_RABOSS_LUCIFRON_DOOM 		    = "Drohende Verdammnis betroffen";
end