-- Mar'li
CT_RABOSS_MARLI_INFO			= "Displays a warning when High Priestess Mar'li summons spiders."
CT_RABOSS_MARLI_REGEXP			= "Aid me my brood!$"
CT_RABOSS_MARLI_ADDS			= "SPIDERS SPAWNED"

-- Bloodlord Mandokir
CT_RABOSS_MANDOKIR_INFO 			= "Displays a warning when you or nearby players are being watched.";
CT_RABOSS_MANDOKIR_TELL_TARGET		= "Send tells to targets";
CT_RABOSS_MANDOKIR_TELL_TARGET_INFO	= "Sends a tell to players that are being watched";
CT_RABOSS_MANDOKIR_WATCHWARNYOU		= "*** YOU ARE BEING WATCHED ***";
CT_RABOSS_MANDOKIR_WATCHWARNTELL	= "YOU ARE BEING WATCHED!";
CT_RABOSS_MANDOKIR_WATCHWARNRAID    = " IS BEING WATCHED";
CT_RABOSS_MANDOKIR_REGEXP			= "([^%s]+)! I'm watching you!$";

-- Jin'do the Hexxer
CT_RABOSS_JINDO_TELL_TARGET			= "Send tells to targets";
CT_RABOSS_JINDO_TELL_TARGET_INFO	= "Sends a tell to players that are afflicted by Delusions of Jin'do.";
CT_RABOSS_JINDO_ALERT_NEARBY		= "Alert for nearby players";
CT_RABOSS_JINDO_ALERT_NEARBY_INFO	= "Alert you when nearby players are afflicted by Delusions of Jin'do."

CT_RABOSS_JINDO_CURSEWARNYOU		= "*** YOU ARE CURSED ***";
CT_RABOSS_JINDO_CURSEWARNTELL		= "YOU ARE CURSED!";

CT_RABOSS_JINDO_AFFLICT_CURSE 		= "^([^%s]+) ([^%s]+) afflicted by Delusions of Jin'do";
CT_RABOSS_JINDO_AFFLICT_SELF_MATCH1 = "You";
CT_RABOSS_JINDO_AFFLICT_SELF_MATCH2	= "are";

-- Hakkar
CT_RABOSS_HAKKAR_ANNOUNCE_45 = "Display 45 sec. warning";
CT_RABOSS_HAKKAR_ANNOUNCE_45_INFO = "Displays a warning when half of the time has passed to the next life drain.";

CT_RABOSS_HAKKAR_TIMEWARN		= "*** %d SECONDS TO LIFE DRAIN ***";
CT_RABOSS_HAKKAR_LIFEDRAIN = "*** LIFE DRAIN - 90 SECONDS UNTIL NEXT ***";
CT_RABOSS_HAKKAR_AFFLICT_POISON 		= "^Hakkar suffers (.+) from (.+) Blood Siphon";

-- Arlokk
CT_RABOSS_ARLOKK_INFO = "Displays a warning when High Priestess Arlokk marks a target.";
CT_RABOSS_ARLOKK_TELL_TARGET = "Send tells to targets";
CT_RABOSS_ARLOKK_TELL_TARGET_INFO = "Sends a tell to players that are marked.";
CT_RABOSS_ARLOKK_WATCHWARNYOU = "*** YOU ARE MARKED ***";
CT_RABOSS_ARLOKK_WATCHWARNTELL = "YOU ARE MARKED!";
CT_RABOSS_ARLOKK_WATCHWARNRAID = " IS MARKED";
CT_RABOSS_ARLOKK_REGEXP = "Feast on ([^%s]+), my pretties!$";

if ( GetLocale() == "deDE" ) then
	-- Mar'li
	CT_RABOSS_MARLI_INFO			= "Zeigt eine Warnung, wenn Hohepriesterin Mar'li Spinnen beschwört."
	CT_RABOSS_MARLI_REGEXP			= "Helft mir, meine Brut!$"
	CT_RABOSS_MARLI_ADDS			= "*** SPINNEN SPAWNED ***"
    
    CT_RABOSS_MARLI_YELL            = "Helft mir, meine Brut!";

    
    -- Jin'do the Hexxer
    CT_RABOSS_JINDO_TELL_TARGET			= "Send tells to targets";
    CT_RABOSS_JINDO_TELL_TARGET_INFO	= "Sends a tell to players that are afflicted by Delusions of Jin'do.";
    CT_RABOSS_JINDO_ALERT_NEARBY		= "Alert for nearby players";
    CT_RABOSS_JINDO_ALERT_NEARBY_INFO	= "Alert you when nearby players are afflicted by Delusions of Jin'do."
    
    CT_RABOSS_JINDO_CURSEWARNYOU		= "*** DU BIST VERFLUCHT ***";
    CT_RABOSS_JINDO_CURSEWARNTELL		= "IST VERFLUCHT! NICHT DISPELEN!";
    
    CT_RABOSS_JINDO_AFFLICT_CURSE 		= "^([^%s]+) ([^%s]+) von Irrbilder von Jin'do betroffen";      --work
    CT_RABOSS_JINDO_AFFLICT_SELF_MATCH1 = "Ihr";                                                        --work 
    CT_RABOSS_JINDO_AFFLICT_SELF_MATCH2	= "seid";                                                       --work 
    
    
    -- Hakkar
    CT_RABOSS_HAKKAR_AFFLICT_POISON = "^Hakkar erleidet (.+) Naturschaden von (.+) %(durch Bluttrinker%)";
	
    
    -- Arlokk
    CT_RABOSS_ARLOKK_INFO               = "Displays a warning when High Priestess Arlokk marks a target for her panthers.";
    CT_RABOSS_ARLOKK_TELL_TARGET        = "Send tells to targets";
    CT_RABOSS_ARLOKK_TELL_TARGET_INFO   = "Sends a tell to players that are marked for a feast";
    CT_RABOSS_ARLOKK_WATCHWARNYOU       = "*** DU BIST MAKIERT ***";
    CT_RABOSS_ARLOKK_WATCHWARNTELL      = "DU BIST MAKIERT!";
    CT_RABOSS_ARLOKK_WATCHWARNRAID      = " IST MAKIERT";
    CT_RABOSS_ARLOKK_REGEXP             = "Labt euch an ([^%s]+), meine";
	
	
	-- Bloodlord Mandokir
	CT_RABOSS_MANDOKIR_INFO 			= "Zeigt eine Meldung, wenn jemand von Mandokir beobachtet wird.";
	CT_RABOSS_MANDOKIR_TELL_TARGET		= "Ziel benachrichtigen";
	CT_RABOSS_MANDOKIR_TELL_TARGET_INFO	= "Sendet eine Nachricht an das Ziel, dass es beobachtet wird";
	CT_RABOSS_MANDOKIR_WATCHWARNYOU		= "*** DU WIRST BEOBACHTET ***";
	CT_RABOSS_MANDOKIR_WATCHWARNTELL	= "DU WIRST BEOBACHTET!";
	CT_RABOSS_MANDOKIR_WATCHWARNRAID    = " WIRD BEOBACHTET";
	CT_RABOSS_MANDOKIR_REGEXP			= "([^%s]+)! Ich behalte Euch im Auge!$";
end