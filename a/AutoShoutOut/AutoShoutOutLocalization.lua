
-- VERSION: 1.15.5

-- We use local vars instead of tables because of concatenation reasons
-- during the definition of some of the variables with values from other
-- variables, which doesn't work well when both variables are inside of
-- the same table!

-- If a variable/word exists more than once, we suffix the variable name 
-- with '_LABEL' for the word that has a Upper First Character (UFC).

-- Used http://www.google.com/translate_t for the initial translations.
-- Other players helped out to clean things up.  You can see their names
-- down below in the various language sections.


function ASO_Assign_Default_Localization()

	-- DEFAULT TO ENGLISH! - enUS
	
	ASO_LOCSTR_TITLE					= "Auto Shout Out"; -- v1.14.0

	-- Miscellaneous words
	ASO_LOCSTR_LOADING					= "Loading";
	ASO_LOCSTR_TRUE						= "true";
	ASO_LOCSTR_FALSE					= "false";
	ASO_LOCSTR_CHARACTER				= "Character"; -- v1.11.0
	ASO_LOCSTR_REALM					= "Realm"; -- v1.11.0
	
	ASO_LOCSTR_CONFIGS					= "Configurations"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_ACTIVE			= "Active"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_SOLO_LABEL		= "Solo"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_PARTY_LABEL		= "Party"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_RAID_LABEL		= "Raid"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_SOLO				= string.lower(ASO_LOCSTR_CONFIGS_SOLO_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_PARTY			= string.lower(ASO_LOCSTR_CONFIGS_PARTY_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_RAID				= string.lower(ASO_LOCSTR_CONFIGS_RAID_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_AUTOSWITCH		= "Auto Switch"; -- v1.12.0
	
	ASO_LOCSTR_DEBUG					= "debug";
	ASO_LOCSTR_DEBUG_LABEL				= "Debug";
	ASO_LOCSTR_STATUS					= "status";
	ASO_LOCSTR_RESET					= "reset"; -- v1.11.0
	ASO_LOCSTR_WARNMSGS					= "warnings"; -- v1.15.2

	ASO_LOCSTR_HEALTH					= "health";
	ASO_LOCSTR_LIFE						= "life";
	ASO_LOCSTR_MANA						= "mana";
	ASO_LOCSTR_ON						= "on";
	ASO_LOCSTR_OFF						= "off";
	ASO_LOCSTR_ALWAYS					= "always";
	ASO_LOCSTR_COMBAT					= "combat";
	
	ASO_LOCSTR_CLOSE					= "Close"; -- 1.7.0
	
	ASO_LOCSTR_HEALTH_LABEL				= "Health";
	ASO_LOCSTR_LIFE_LABEL				= "Life";
	ASO_LOCSTR_MANA_LABEL				= "Mana";
	
	ASO_LOCSTR_PETHEALTH				= "pethealth"; -- NO SPACE! -- 1.7.0
	ASO_LOCSTR_PETHEALTH_LABEL			= "Pet Health"; -- Space! -- 1.7.0

	ASO_LOCSTR_REZSTONE					= "soulstone"; -- NO SPACE! -- 1.15.0
	ASO_LOCSTR_REZSTONE_LABEL			= "Soulstone"; -- Space! -- 1.15.0
	ASO_LOCSTR_REZSTONE_WARNING			= "You have a 'Soulstone Resurrection' buff, but "..ASO_LOCSTR_TITLE.." is not currently set to notify you when it wears off!"; -- 1.15.0

	ASO_LOCSTR_SET_NOTIFY_PERCENT2		= "notification % must be between";
	ASO_LOCSTR_SET_NOTIFY_FREQUENCY2	= "notification frequency must be between";
	ASO_LOCSTR_NOTIFY_DURING_DUEL_OFF	= ASO_LOCSTR_TITLE .. " will not do notifications during a duel!"; -- v1.12.0
	
	ASO_LOCSTR_TABLE_INIT				= "is being initialized with default settings."; -- v1.11.0
	ASO_LOCSTR_CONFIRM_TABLE_INIT		= "Are you sure that you want to reset your "..ASO_LOCSTR_TITLE.." settings?"; -- v1.11.0
	
	ASO_LOCSTR_TARGET_ERROR				= "Unable to target"; -- v1.30.0
	ASO_LOCSTR_CHARNAME_ERROR			= "ERROR WHILE OBTAINING THE CHARACTER'S NAME!!!"; -- v1.13.3
	
	ASO_LOCSTR_GREETINGS				= "loaded.  Type '/aso' or '/autoshoutout' to change any settings.";
	
	ASO_LOCSTR_DEFAULT_MESSAGE_HEALTH	= "I am injured!";
	ASO_LOCSTR_DEFAULT_MESSAGE_LIFE		= "I AM ABOUT TO DIE!";
	ASO_LOCSTR_DEFAULT_MESSAGE_MANA		= "Out of mana!";
	ASO_LOCSTR_DEFAULT_MESSAGE_PETHEALTH= "My pet is injured!"; -- 1.7.0
	ASO_LOCSTR_DEFAULT_MESSAGE_REZSTONE = "No 'Soulstone Resurrection' buff!"; -- 1.15.0
	
	-- DoEmote command words...
	ASO_LOCSTR_DOEMOTE_HEALME 			= "healme"; -- v1.11.1
	ASO_LOCSTR_DOEMOTE_HELPME 			= "helpme"; -- v1.11.1
	ASO_LOCSTR_DOEMOTE_OOM 				= "oom"; -- v1.11.1
	
	ASO_LOCSTR_BANNER_DISPLAY_ERROR		= "Unable to show a message in your banner display area!" -- 1.10.0
	
	-- Debug messages
	ASO_LOCSTR_DEBUG_MSG2				= "type is 'pet' unit"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG3				= "type is 'player' unit"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG4				= "will receive the folloiwng message"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG5				= "Not ready to initialize yet!";
	ASO_LOCSTR_DEBUG_MSG6				= "The character's name is";
	ASO_LOCSTR_DEBUG_MSG7				= "registering with";
	ASO_LOCSTR_DEBUG_MSG8				= "You're dead!  Have a nice day.";
	ASO_LOCSTR_DEBUG_MSG9				= "Non-Mana Class!";
	ASO_LOCSTR_DEBUG_MSG10				= "Checking player's";
	ASO_LOCSTR_DEBUG_MSG11				= "is low!";
	ASO_LOCSTR_DEBUG_MSG12				= "is fine.";
	ASO_LOCSTR_DEBUG_MSG13				= "Checking to see if Player is in combat...";
	ASO_LOCSTR_DEBUG_MSG14				= "Unit IS in combat!";
	ASO_LOCSTR_DEBUG_MSG15				= "Unit is NOT in combat!";
	ASO_LOCSTR_DEBUG_MSG16				= "only in combat?";
	ASO_LOCSTR_DEBUG_MSG17				= "frequency duration has not been met for notification";
	ASO_LOCSTR_DEBUG_MSG18				= "check triggered!";
	ASO_LOCSTR_DEBUG_MSG19				= "Auto Configuration Switching is ON!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG20				= "Character is in a raid!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG21				= "Switching to 'Raid' configuration!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG22				= "Character is in a party!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG23				= "Switching to 'Party' configuration!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG24				= "Character is NOT in a party/raid!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG25				= "Switching to 'Solo' configuration!"; -- v1.12.0

	ASO_LOCSTR_OUTPUT_MSG1				= ASO_LOCSTR_TITLE.." status output has been turned"; -- v1.11.0
	ASO_LOCSTR_OUTPUT_MSG2				= ASO_LOCSTR_TITLE.." notifications have been turned"; -- v1.14.0
	ASO_LOCSTR_OUTPUT_MSG3				= ASO_LOCSTR_TITLE.."\n\nAll notifications have been turned off!\nTurn back on to be able to change settings."; -- v1.14.0
	ASO_LOCSTR_OUTPUT_MSG4				= ASO_LOCSTR_TITLE.." warning messages have been turned"; -- v1.15.2
	
	ASO_LOCSTR_COMBAT_MSG1				= ASO_LOCSTR_TITLE.." wants to do a notification for";
	ASO_LOCSTR_COMBAT_MSG2				= "Type '/aso "..ASO_LOCSTR_STATUS.."' to turn off these messages."; -- v1.15.3
	
	ASO_LOCSTR_MYADDONS_DESCRIPTION		= "Notifies others of your status"; -- Keep it short!
	
	-- THE BELOW CHANNEL NAMES *MUST* BE IN ALL UPPER CAPS OR ELSE ADD-ON WILL CONFUSE WITH CHARACTER NAMES!
	ASO_LOCSTR_LOCAL					= "LOCAL"; -- v1.9.0
	ASO_LOCSTR_BANNER					= "BANNER"; -- v1.10.0
	ASO_LOCSTR_SAY						= "SAY";
	ASO_LOCSTR_PARTY					= string.upper(ASO_LOCSTR_CONFIGS_PARTY_LABEL);
	ASO_LOCSTR_RAID						= string.upper(ASO_LOCSTR_CONFIGS_RAID_LABEL);
	-- THE ABOVE CHANNEL NAMES *MUST* BE IN ALL UPPER CAPS OR ELSE ADD-ON WILL CONFUSE WITH CHARACTER NAMES!

	-- UI localizations...
	ASO_LOCSTR_UI_Window_Title							= ASO_LOCSTR_TITLE;
	ASO_LOCSTR_UI_Event_List_Title						= "Events";
	ASO_LOCSTR_UI_NotifyPercentEditBoxLabel 			= "Notify Percentage: ";
	ASO_LOCSTR_UI_NotifyFrequencyEditBox				= "Notify Frequency:";
	ASO_LOCSTR_UI_IsCombatOnlyCheckButtonLabel			= "Notify Combat Only";
	ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel		= "Notify via Shouting";
	ASO_LOCSTR_UI_IsMessagingEnabledCheckButtonLabel	= "Notify via Messaging";
	ASO_LOCSTR_UI_MessageTargetEditBoxLabel				= "Target: ";
	ASO_LOCSTR_UI_MessageMessageEditBoxLabel			= "Message: ";
	ASO_LOCSTR_UI_TargetChannelsButton					= "Channels";
	ASO_LOCSTR_UI_ConfigurationsDropDownLabel			= "Active Configuration"; -- v1.11.0
	ASO_LOCSTR_UI_AutoSwitchCheckButtonLabel			= ASO_LOCSTR_CONFIGS_AUTOSWITCH; -- v1.12.0
	ASO_LOCSTR_UI_IsNotifyDuringDuelCheckButtonLabel	= "Notify During Duel"; -- v1.12.0
	
	ASO_LOCSTR_UI_TooltipText_ConfigurationsDropDown	= -- v1.15.0
		"A configuration is a grouping of settings\n" ..
		"for all of the available event types.  You\n" ..
		"can select which configuration is active\n" ..
		"by choosing it here.  When you change\n" ..
		"configurations, the settings below will\n" ..
		"change (if different between the various\n" ..
		"configurations).  Whichever configuration\n" ..
		"is active will determine which settings\n" ..
		"are used for notifications.";
		
	ASO_LOCSTR_UI_TooltipText_AutoSwitchCheckButton	= -- v1.15.0
		"If checked, the '" .. ASO_LOCSTR_UI_ConfigurationsDropDownLabel .. "'\n" ..
		"will change automatically, based on if\n" ..
		"the player is in a group, a raid, or solo";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton1	= -- Health -- v1.15.0
		"Notifications based on how much\n" ..
		"'" .. ASO_LOCSTR_HEALTH_LABEL .. "' you have left.  Uses the\n" ..
		"/healme vocal emote (if you have\n" ..
		"the '" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "' option\n" ..
		"checked).";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton2	= -- Life -- v1.15.0
		"Notifications based on how much\n" ..
		"'" .. ASO_LOCSTR_HEALTH_LABEL .. "' you have left.  Uses the\n" ..
		"/helpme vocal emote (if you have\n" ..
		"the '" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "' option\n" ..
		"checked).";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton3	= -- Mana -- v1.15.0
		"Notifications based on how much\n" ..
		"'" .. ASO_LOCSTR_MANA_LABEL .. "' you have left.  Uses the\n" ..
		"/oom vocal emote (if you have\n" ..
		"the '" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "' option\n" ..
		"checked).";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton4	= -- Pet Health -- v1.15.0
		"Notifications based on how much\n" ..
		"'" .. ASO_LOCSTR_HEALTH_LABEL .. "' you pet has left.  Does\n" ..
		"not use an emote.";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton5	= -- Soulstone -- v1.15.0
		"Notifications based on when a\n" ..
		"'Soulstone Resurrection' buff\n" ..
		"wears off.  Does not use a vocal\n" ..
		"emote.  You will be warned if a\n" ..
		"Warlock places the buff on you\n" ..
		"but ASO is not set to notify you\n" ..
		"when it wears off.";
		
	ASO_LOCSTR_UI_TooltipText_NotifyPercentEditBox	= -- v1.15.0
		"How low an event value has\n" ..
		"to get before a notification\n" ..
		"would be done";
		
	ASO_LOCSTR_UI_TooltipText_NotifyFrequencyEditBox	= -- v1.15.0
		"Minimum number of seconds\n" ..
		"between notifications for the\n" ..
		"selected event type";
		
	ASO_LOCSTR_UI_TooltipText_IsShoutEnabledCheckButton	= -- v1.15.0
		"If checked, vocal emote\n" ..
		"notifications will be done\n" ..
		"for the selected event";

	ASO_LOCSTR_UI_TooltipText_IsMessagingEnabledCheckButton	= -- v1.15.0
		"If checked text based message\n" ..
		"notifications will be done for\n" ..
		"the selected event";

	ASO_LOCSTR_UI_TooltipText_MessageTargetEditBox	= -- v1.15.0
		"Where text based message notifications\n" ..
		"will go to.  You can type in a player's\n" ..
		"name, or use the '" .. ASO_LOCSTR_UI_TargetChannelsButton .. "' button to\n" ..
		"select a chat or screen target area for\n" ..
		"the notification message to go to.";

	ASO_LOCSTR_UI_TooltipText_TargetChannelsButton	= -- v1.15.0
		"Cycles through the available chat or\n" ..
		"screen target areas that text based\n" ..
		"message notifications will go to";

	ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindowCloseButton	= -- v1.15.0
		"Any changes that you have\n" ..
		"made will be saved when\n" ..
		"you click on this button";

	ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindow_Close_Button = -- v1.15.0
		ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindowCloseButton;

	ASO_LOCSTR_UI_TooltipText_MessageMessageEditBox		=  -- v1.11.0
		"$HEALTH \n   Current health points remaining\n\n" ..
		"$HEALTHMAX \n   Max possible health points\n\n" ..
		"$HEALTHPERCENT \n   Current health points percentage left\n\n" ..
		"$MANA \n   Current mana points remaining\n\n" ..
		"$MANAMAX \n   Max possible mana points\n\n" ..
		"$MANAPERCENT \n   Current mana points percentage left\n\n" ..
		"$NAME \n   Name of the unit that the notification is about" ;
		
	ASO_LOCSTR_UI_MainWindowSize_Width					= 340; -- v1.11.1
	ASO_LOCSTR_UI_MainWindowSize_Height					= 325; -- v1.11.1
	ASO_LOCSTR_UI_TitleBoxSize_Width					= 255;
	ASO_LOCSTR_UI_MessageMessageEditBoxSize_Width		= 225; -- v1.11.1
	
	return;
	
end


---------------------
-- OTHER LANGUAGES...
---------------------

if (GetLocale() == "deDE") then -- deDE

	-- Thanks to jth (http://forums.curse-gaming.com/member.php?u=5486) for the German translations.
	-- Thanks to Drazul (http://forums.curse-gaming.com/member.php?u=6717) for the German translations.
	
	ASO_LOCSTR_TITLE					= "Automatische Mitteilungen"; -- v1.14.0

	-- Miscellaneous words
	ASO_LOCSTR_LOADING					= "Laden";
	ASO_LOCSTR_TRUE						= "richtig";
	ASO_LOCSTR_FALSE					= "falsch";
	ASO_LOCSTR_CHARACTER				= "Charakter"; -- v1.11.0
	ASO_LOCSTR_REALM					= "Realm"; -- v1.11.0
	
	ASO_LOCSTR_CONFIGS					= "Konfigurations"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_ACTIVE			= "Aktiv"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_SOLO_LABEL		= "Solo"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_PARTY_LABEL		= "Gruppe"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_RAID_LABEL		= "Schlachtzug"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_SOLO				= string.lower(ASO_LOCSTR_CONFIGS_SOLO_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_PARTY			= string.lower(ASO_LOCSTR_CONFIGS_PARTY_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_RAID				= string.lower(ASO_LOCSTR_CONFIGS_RAID_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_AUTOSWITCH		= "Automat. wechseln"; -- v1.12.0 'Auto Switch'
	
	ASO_LOCSTR_DEBUG					= "pr\195\188fen";
	ASO_LOCSTR_DEBUG_LABEL				= "Pr\195\188fen";
	ASO_LOCSTR_STATUS					= "status";
	ASO_LOCSTR_RESET					= "zur\195\188ckstellen"; -- v1.11.0
	ASO_LOCSTR_WARNMSGS					= "warnungen"; -- v1.15.2

	ASO_LOCSTR_HEALTH					= "gesundheit";
	ASO_LOCSTR_LIFE						= "leben";
	ASO_LOCSTR_MANA						= "mana";
	ASO_LOCSTR_ON 						= "an";
	ASO_LOCSTR_OFF 						= "aus";
	ASO_LOCSTR_ALWAYS 					= "immer";
	ASO_LOCSTR_COMBAT 					= "kampf";
	
	ASO_LOCSTR_CLOSE					= "Schlie\195\159\en"; -- 1.7.0
	
	ASO_LOCSTR_HEALTH_LABEL				= "Gesundheit";
	ASO_LOCSTR_LIFE_LABEL				= "Leben";
	ASO_LOCSTR_MANA_LABEL				= "Mana";

	ASO_LOCSTR_PETHEALTH				= "tier" .. ASO_LOCSTR_HEALTH; -- NO SPACE! -- 1.7.0
	ASO_LOCSTR_PETHEALTH_LABEL			= "Tier " .. ASO_LOCSTR_HEALTH_LABEL; -- Space! -- 1.7.0

	ASO_LOCSTR_REZSTONE					= "seelenstein"; -- NO SPACE! -- 1.15.0
	ASO_LOCSTR_REZSTONE_LABEL			= "Seelenstein"; -- Space! -- 1.15.0
	ASO_LOCSTR_REZSTONE_WARNING			= "Ihr habt 'Seelenstein-Auferstehung' bekommen, aber " .. ASO_LOCSTR_TITLE .. " wurde nicht konfiguriert um eine Warnung auszugeben wenn der Buff ausl\195\164uft!"; -- 1.15.0

	ASO_LOCSTR_SET_NOTIFY_PERCENT2		= "mitteilung % mu\195\159 sein zwischen";
	ASO_LOCSTR_SET_NOTIFY_FREQUENCY2	= "mitteilungsfrequenz mu\195\159 sein zwischen";
	ASO_LOCSTR_NOTIFY_DURING_DUEL_OFF	= ASO_LOCSTR_TITLE.." sendet w\195\164hrend eines Duells keine Nachrichten!"; -- v1.12.0

	ASO_LOCSTR_TABLE_INIT				= "wird mit den Standard-Einstellungen geladen."; -- v1.11.0
	ASO_LOCSTR_CONFIRM_TABLE_INIT		= "Sollen die "..ASO_LOCSTR_TITLE.." Einstellungen zur\195\188ckgesetzt werden?"; -- v1.11.0
	
	ASO_LOCSTR_TARGET_ERROR				= "Ziel kann nicht anvisiert werden"; -- v1.30.0
	
	ASO_LOCSTR_GREETINGS				= "geladen. Benutze '/aso' oder '/autoshoutout' zum konfigurieren.";
	
	ASO_LOCSTR_DEFAULT_MESSAGE_HEALTH 	= "Ich werde angegriffen!";
	ASO_LOCSTR_DEFAULT_MESSAGE_LIFE 	= "Helft mir! Ich sterbe!";
	ASO_LOCSTR_DEFAULT_MESSAGE_MANA 	= "Ich habe fast kein Mana mehr!";	
	ASO_LOCSTR_DEFAULT_MESSAGE_PETHEALTH= "Mein Haustier wird verletzt!"; -- 1.7.0
	ASO_LOCSTR_DEFAULT_MESSAGE_REZSTONE = "Kein 'Seelenstein-Auferstehung' Buff!"; -- 1.15.0
	
	-- DoEmote command words...
	ASO_LOCSTR_DOEMOTE_HEALME 			= "healme"; -- "heilmich"; -- v1.11.1
	ASO_LOCSTR_DOEMOTE_HELPME 			= "helpme"; -- "hilferufen"; -- v1.11.1
	ASO_LOCSTR_DOEMOTE_OOM 				= "oom"; -- v1.11.1
	
	ASO_LOCSTR_BANNER_DISPLAY_ERROR		= "Kann keine Nachrichten im oberen Bildschrimbereich anzeigen!" -- 1.10.0
	ASO_LOCSTR_CHARNAME_ERROR			= "FEHLER BEIM ERKENNEN DES CHARAKTERNAMEN!!!"; -- v1.13.3
	
	-- Debug messages
	ASO_LOCSTR_DEBUG_MSG2				= "Ist vom Typ 'Tier' Einheit"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG3				= "Ist vom Typ 'Spieler' Einheit"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG4				= "empf\195\164ngt die folgende Nachricht"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG5 				= "Noch nicht zum Initialisieren bereit!";
	ASO_LOCSTR_DEBUG_MSG6 				= "Der Name des Charakter ist";
	ASO_LOCSTR_DEBUG_MSG7 				= "registrieren mit";
	ASO_LOCSTR_DEBUG_MSG8 				= "Du bist tot!";
	ASO_LOCSTR_DEBUG_MSG9 				= "Keine Mana-Klasse!";
	ASO_LOCSTR_DEBUG_MSG10 				= "\195\188berpr\195\188fung";
	ASO_LOCSTR_DEBUG_MSG11 				= "ist niedrig!";
	ASO_LOCSTR_DEBUG_MSG12 				= "ist ok.";
	ASO_LOCSTR_DEBUG_MSG13 				= "\195\188berpr\195\188fung ob Spieler im Kampf ist...";
	ASO_LOCSTR_DEBUG_MSG14 				= "Spieler IST im Kampf!";
	ASO_LOCSTR_DEBUG_MSG15 				= "Spieler ist NICHT im Kampf.";
	ASO_LOCSTR_DEBUG_MSG16 				= "nur im Kampf?";
	ASO_LOCSTR_DEBUG_MSG17 				= "Frequenzdauer wurde nicht f\195\188r Mitteilung ermittelt";
	ASO_LOCSTR_DEBUG_MSG18 				= "\195\188berpr\195\188fung ausgel\195\182st!";
	ASO_LOCSTR_DEBUG_MSG19 				= "Automatische Konfigurationsauswahl ist AN!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG20 				= "Charakter ist in einem Schlachtzug!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG21 				= "Wechsle zu 'Schlachtzug' Konfiguration!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG22 				= "Charakter ist in einer Gruppe!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG23 				= "Wechsle zu 'Gruppe' Konfiguration!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG24 				= "Charakter ist NICHT in einer Gruppe/Schlachtzug!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG25 				= "Wechsle zu 'Solo' Konfiguration!"; -- v1.12.0

	ASO_LOCSTR_OUTPUT_MSG1				= ASO_LOCSTR_TITLE.." Statusmeldungen sind nun"; -- v1.11.0
	ASO_LOCSTR_OUTPUT_MSG2				= ASO_LOCSTR_TITLE.." Mitteilungen sind nun"; -- v1.14.0
	ASO_LOCSTR_OUTPUT_MSG3				= ASO_LOCSTR_TITLE.."\nAlle Mitteilungen sind nun ausgeschaltet!\nSchaltet ASO wieder ein um die Einstellungen ver\195\164ndern zu k\195\182nnen."; -- v1.14.0
	ASO_LOCSTR_OUTPUT_MSG4				= ASO_LOCSTR_TITLE.." warnmeldungen sind gedreht worden"; -- v1.15.2

	ASO_LOCSTR_COMBAT_MSG1 				= ASO_LOCSTR_TITLE.." m\195\182chte eine Mitteilung senden f\195\188r";
	ASO_LOCSTR_COMBAT_MSG2				= "Art '/aso "..ASO_LOCSTR_STATUS.."' diese Anzeigen weg drehen."; -- v1.15.3

	ASO_LOCSTR_MYADDONS_DESCRIPTION 	= "Informiert \195\188ber " .. ASO_LOCSTR_HEALTH_LABEL .. "/" .. ASO_LOCSTR_MANA_LABEL; -- Halten Sie es kurz!

	-- DIE UNTEN AUFGELISTETEN CHATKANAELE MUESSEN IN GROSSBUHSTABEN SEIN - SONST WIRD DAS ADDON SIE MIT CHARAKTERNAMEN VERWECHSELN!
	ASO_LOCSTR_LOCAL					= "LOKAL"; -- v1.9.0
	ASO_LOCSTR_BANNER					= "BANNER"; -- v1.10.0
	ASO_LOCSTR_SAY 						= "SAGEN";
	ASO_LOCSTR_PARTY 					= string.upper(ASO_LOCSTR_CONFIGS_PARTY_LABEL);
	ASO_LOCSTR_RAID 					= string.upper(ASO_LOCSTR_CONFIGS_RAID_LABEL);
	-- DIE OBEN AUFGELISTETEN CHATKANAELE MUESSEN IN GROSSBUHSTABEN SEIN - SONST WIRD DAS ADDON SIE MIT CHARAKTERNAMEN VERWECHSELN!

	-- UI localizations...
	ASO_LOCSTR_UI_Window_Title 							= ASO_LOCSTR_TITLE;
	ASO_LOCSTR_UI_Event_List_Title 						= "Typ";
	ASO_LOCSTR_UI_NotifyPercentEditBoxLabel 			= "Mitteilung ab %: ";
	ASO_LOCSTR_UI_NotifyFrequencyEditBox 				= "Mitteilung Frequenz:  ";
	ASO_LOCSTR_UI_IsCombatOnlyCheckButtonLabel 			= "Nur im Kampf";
	ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel 		= "Mitteilungen per Emote";
	ASO_LOCSTR_UI_IsMessagingEnabledCheckButtonLabel 	= "Mitteilungen per Nachricht";
	ASO_LOCSTR_UI_MessageTargetEditBoxLabel 			= "Ziel:";
	ASO_LOCSTR_UI_MessageMessageEditBoxLabel 			= "Nachricht:";
	ASO_LOCSTR_UI_TargetChannelsButton 					= "Chatkan\195\164le";
	ASO_LOCSTR_UI_ConfigurationsDropDownLabel			= "Aktive Konfiguration"; -- v1.11.0
	ASO_LOCSTR_UI_AutoSwitchCheckButtonLabel			= ASO_LOCSTR_CONFIGS_AUTOSWITCH; -- v1.12.0
	ASO_LOCSTR_UI_IsNotifyDuringDuelCheckButtonLabel	= "Im Duell senden"; -- v1.12.0
	
	ASO_LOCSTR_UI_TooltipText_ConfigurationsDropDown	= -- v1.15.0
		"Ein Konfigurationstyp enth\195\164lt alle Einstellungen,\n" ..
		"die f\195\188r diesen Typ gemacht werden k\195\182nnen. Man\n" ..
		"kann die Typen hier einstellen, und somit die\n" ..
		"aktive Konfiguration \195\164ndern.";
		
	ASO_LOCSTR_UI_TooltipText_AutoSwitchCheckButton	= -- v1.15.0
		"Wenn diese Option aktiviert ist, wird die\n" ..
		"'" .. ASO_LOCSTR_UI_ConfigurationsDropDownLabel .. "' automatisch\n" ..
		"gewechselt, wenn ihr in einer Gruppe,\n" ..
		"einem Schlachtzug oder Solo unterwegs\n" ..
		"seid.";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton1	= -- Health -- v1.15.0
		"Mitteilungen basierend auf\n" ..
		"der verbleibenden '" .. ASO_LOCSTR_HEALTH_LABEL .. "'\n" ..
		"die du noch hast. Benutzt das\n" ..
		"/heilmich-Sprachemote (wenn die\n" ..
		"Option'" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "'\n" ..
		"aktiviert ist).";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton2	= -- Life -- v1.15.0
		"Mitteilungen basierend auf\n" ..
		"der verbleibenden '" .. ASO_LOCSTR_HEALTH_LABEL .. "'\n" ..
		"die du noch hast. Benutzt das\n" ..
		"/hilferufen-Sprachemote (wenn die\n" ..
		"Option'" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "'\n" ..
		"aktiviert ist).";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton3	= -- Mana -- v1.15.0
		"Mitteilungen basierend auf\n" ..
		"der verbleibenden '" .. ASO_LOCSTR_MANA_LABEL .. "'\n" ..
		"die du noch hast. Benutzt das\n" ..
		"/oom-Sprachemote (wenn die\n" ..
		"Option'" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "'\n" ..
		"aktiviert ist).";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton4	= -- Pet Health -- v1.15.0
		"Mitteilungen basierend auf der \n" ..
		"verbleibenden '" .. ASO_LOCSTR_HEALTH_LABEL .. "'\n" ..
		"deines Tiers.  Benutzt kein\n" ..
		"Sprachemote";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton5	= -- Soulstone -- v1.15.0
		"Mitteilungen, wenn ein\n" ..
		"'Seelenstein Wiederbelebung'\n" ..
		"-Buff ausl\195\164uft. Benutzt kein\n" ..
		"Sprachemote.  ASO gibt eine\n" ..
		"Warnung aus, wenn du diesen Buff\n" ..
		"bekommst, die Benachrichtigung\n" ..
		"aber nicht eingeschaltet ist.";
		
	ASO_LOCSTR_UI_TooltipText_NotifyPercentEditBox	= -- v1.15.0
		"Der Wert an verbleibender\n" ..
		ASO_LOCSTR_MANA_LABEL.."/"..ASO_LOCSTR_HEALTH_LABEL.." in Prozent,\n" ..
		"ab dem ASO Mitteilungen\n" ..
		"senden soll";
		
	ASO_LOCSTR_UI_TooltipText_NotifyFrequencyEditBox	= -- v1.15.0
		"Wieviele Sekunden sollen\n" ..
		"mindestens zwischen zwei\n" ..
		"Mitteilungen des Event-Typs\n" ..
		"vergehen.";
		
	ASO_LOCSTR_UI_TooltipText_IsShoutEnabledCheckButton	= -- v1.15.0
		"Wenn diese Option aktiviert\n" ..
		"ist, wird die Mitteilung per\n" ..
		"Sprachemote gemacht";

	ASO_LOCSTR_UI_TooltipText_IsMessagingEnabledCheckButton	= -- v1.15.0
		"Wenn diese Option aktiviert\n" ..
		"ist, wird die Mitteilung per\n" ..
		"Textnachricht gemacht";

	ASO_LOCSTR_UI_TooltipText_MessageTargetEditBox	= -- v1.15.0
		"Hier wird das Ziel der Textnachrichten\n" ..
		"eingegeben.  Man kann den Namen\n" ..
		"eines Spielers eingeben, oder den\n" ..
		"Knopf '" .. ASO_LOCSTR_UI_TargetChannelsButton .. "' benutzen, um die\n" ..
		"Nachricht in verschiedene " .. ASO_LOCSTR_UI_TargetChannelsButton .. "\n" ..
		"zu schreiben.";

	ASO_LOCSTR_UI_TooltipText_TargetChannelsButton	= -- v1.15.0
		"W\195\164hlt die verschiedenen\n" .. 
		ASO_LOCSTR_UI_TargetChannelsButton .. " aus";

	ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindowCloseButton	= -- v1.15.0
		"Alle \195\132nderungen werden\n" ..
		"beim Schlie\195\159en gesichert";

	ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindow_Close_Button = -- v1.15.0
		ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindowCloseButton;

	ASO_LOCSTR_UI_TooltipText_MessageMessageEditBox		=  -- v1.11.0
		"Die Textnachricht, die in die " .. ASO_LOCSTR_UI_TargetChannelsButton .. "\n" ..
		"augegeben wird.  Folgende Schl\195\188sselw\195\182rter\n" ..
		"k\195\182nnen dabei verwendet werden:\n\n" ..
		"$HEALTH \n   Verbleibende Gesundheitspunkte\n\n" ..
		"$HEALTHMAX \n   Maximale Gesundheitspunkte\n\n" ..
		"$HEALTHPERCENT \n   Verbleibende Gesundheit in Prozent\n\n" ..
		"$MANA \n   Verbleibende Manapunkte\n\n" ..
		"$MANAMAX \n   Maximale Manapunkte\n\n" ..
		"$MANAPERCENT \n   Verbleibendes Mana in Prozent\n\n" ..
		"$NAME \n   Der Name vom Charakter bzw. Tier" ;
		
	ASO_LOCSTR_UI_MainWindowSize_Width					= 360; -- v1.11.1
	ASO_LOCSTR_UI_MainWindowSize_Height					= 325; -- v1.11.1
	ASO_LOCSTR_UI_TitleBoxSize_Width					= 410;
	ASO_LOCSTR_UI_MessageMessageEditBoxSize_Width		= 225; -- v1.11.1
	
	return;

	
elseif (GetLocale() == "frFR") then -- frFR

	-- Thanks to Methos (http://forums.curse-gaming.com/member.php?u=11256) for the French translations.

	ASO_LOCSTR_TITLE					= "Pousser un Cri Automatiquement"; -- Want 'Auto Shout Out' not 'Auto Shout' (different add-on) -- v1.14.0

	-- Miscellaneous words
	ASO_LOCSTR_LOADING 					= "Chargement";
	ASO_LOCSTR_TRUE 					= "vrai";
	ASO_LOCSTR_FALSE 					= "faux";
	ASO_LOCSTR_CHARACTER				= "Personnage"; -- v1.11.0
	ASO_LOCSTR_REALM					= "Royaume"; -- v1.11.0

	ASO_LOCSTR_CONFIGS					= "Configurations"; -- v1.11.0 Configurez ?
	ASO_LOCSTR_CONFIGS_ACTIVE			= "Actif"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_SOLO_LABEL		= "Solo"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_PARTY_LABEL		= "Groupe" -- v1.11.0
	ASO_LOCSTR_CONFIGS_RAID_LABEL		= "Raid"; -- v1.11.0
	ASO_LOCSTR_CONFIGS_SOLO				= string.lower(ASO_LOCSTR_CONFIGS_SOLO_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_PARTY			= string.lower(ASO_LOCSTR_CONFIGS_PARTY_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_RAID				= string.lower(ASO_LOCSTR_CONFIGS_RAID_LABEL); -- v1.11.0
	ASO_LOCSTR_CONFIGS_AUTOSWITCH		= "Commuter Automatiquement"; -- v1.12.0 'Auto Switch'
	
	ASO_LOCSTR_DEBUG 					= "corrige";
	ASO_LOCSTR_DEBUG_LABEL 				= "Corrige";
	ASO_LOCSTR_STATUS					= "statut";
	ASO_LOCSTR_RESET					= "recharger"; -- v1.11.0
	ASO_LOCSTR_WARNMSGS					= "avertissements"; -- v1.15.2

	ASO_LOCSTR_HEALTH 					= "sant\195\169";
	ASO_LOCSTR_LIFE 					= "vie";
	ASO_LOCSTR_MANA 					= "mana";
	ASO_LOCSTR_ON 						= "activ\195\169";
	ASO_LOCSTR_OFF 						= "d\195\169sactiv\195\169";
	ASO_LOCSTR_ALWAYS 					= "toujours";
	ASO_LOCSTR_COMBAT 					= "combat";

	ASO_LOCSTR_CLOSE 					= "Fermer"; -- 1.7.0

	ASO_LOCSTR_HEALTH_LABEL 			= "Sant\195\169";
	ASO_LOCSTR_LIFE_LABEL 				= "Vie";
	ASO_LOCSTR_MANA_LABEL 				= "Mana";

	ASO_LOCSTR_PETHEALTH 				= "familier" .. ASO_LOCSTR_HEALTH; -- PAS D'ESPACE ! -- 1.7.0
	ASO_LOCSTR_PETHEALTH_LABEL 			= ASO_LOCSTR_HEALTH_LABEL .. " du Familier "; -- Espace ! -- 1.7.0

	ASO_LOCSTR_REZSTONE					= "pierred'\195\162me"; -- NO SPACE! -- 1.15.0
	ASO_LOCSTR_REZSTONE_LABEL			= "Pierre d'\195\162me"; -- Space! -- 1.15.0
	ASO_LOCSTR_REZSTONE_WARNING			= "Vous aveze une 'Pierre de r\195\169surrection', mais "..ASO_LOCSTR_TITLE.." n'est pas configur\195\169 pour vous signaler quand elle n'est plus active !"; -- 1.15.0

	-- DoEmote command words...
	ASO_LOCSTR_DOEMOTE_HEALME 			= "healme"; -- "soin"; -- v1.11.1
	ASO_LOCSTR_DOEMOTE_HELPME 			= "helpme"; -- "aidemoi"; -- v1.11.1
	ASO_LOCSTR_DOEMOTE_OOM 				= "oom"; -- "pdm"; -- v1.11.1
	
	ASO_LOCSTR_SET_NOTIFY_PERCENT2 		= "le % pour l'avertissement doit \195\170tre entre";
	ASO_LOCSTR_SET_NOTIFY_FREQUENCY2 	= "la fr\195\169quence des avertissements doit \195\170tre entre";
	ASO_LOCSTR_NOTIFY_DURING_DUEL_OFF	= ASO_LOCSTR_TITLE.." ne fera pas d'avertissements pendant un duel"; -- v1.12.0

	ASO_LOCSTR_TABLE_INIT				= "a \195\169t\195\169 r\195\169initialis\195\169 avec les options par d\195\169faut."; -- v1.11.0
	ASO_LOCSTR_CONFIRM_TABLE_INIT		= "\195\138tes-vous s\195\187r de vouloir remettre \195\160 z\195\169ro votre configuration d'"..ASO_LOCSTR_TITLE.." ?"; -- v1.11.0
	
	ASO_LOCSTR_TARGET_ERROR				= "Impossible de viser"; -- v1.30.0
	
	ASO_LOCSTR_GREETINGS 				= "charg\195\169. Ecrivez '/aso' or '/autoshoutout' pour changer la configuration.";

	ASO_LOCSTR_DEFAULT_MESSAGE_HEALTH 	= "Je suis bless\195\169 !";
	ASO_LOCSTR_DEFAULT_MESSAGE_LIFE 	= "JE VAIS MOURIR !";
	ASO_LOCSTR_DEFAULT_MESSAGE_MANA 	= "Je n'ai plus de mana !";
	ASO_LOCSTR_DEFAULT_MESSAGE_PETHEALTH= "Mon familier est bless\195\169 !"; -- 1.7.0
	ASO_LOCSTR_DEFAULT_MESSAGE_REZSTONE = "Pas de buff 'Pierre de R\195\169surrection'!"; -- 1.15.0

	ASO_LOCSTR_BANNER_DISPLAY_ERROR 	= "Incapable de montrer un message dans votre zone de visualisation de banni\195\168re!" -- 1.10.0
	ASO_LOCSTR_CHARNAME_ERROR 			= "ERREUR EN OBTENANT LE NOM DU PERSONNAGE !!!"; -- v1.13.3
	
	-- Debug messages
	ASO_LOCSTR_DEBUG_MSG2 				= "le type est un 'familier'"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG3 				= "le type est un 'joueur'"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG4 				= "recevra le message suivant"; -- 1.7.0
	ASO_LOCSTR_DEBUG_MSG5 				= "n'est pas encore pr\195\170t \195\160 initialiser !";
	ASO_LOCSTR_DEBUG_MSG6 				= "Le nom du personnage est";
	ASO_LOCSTR_DEBUG_MSG7 				= "inscription \195\160";
	ASO_LOCSTR_DEBUG_MSG8 				= "Vous \195\170tes mort ! Passez une bonne journ\195\169e.";
	ASO_LOCSTR_DEBUG_MSG9 				= "Classe sans Mana !";
	ASO_LOCSTR_DEBUG_MSG10 				= "V\195\169rification du joueur";
	ASO_LOCSTR_DEBUG_MSG11 				= "est faible !";
	ASO_LOCSTR_DEBUG_MSG12 				= "est bonne.";
	ASO_LOCSTR_DEBUG_MSG13 				= "V\195\169rification pour voir si le joueur est en train de combattre...";
	ASO_LOCSTR_DEBUG_MSG14 				= "Le joueur COMBAT !";
	ASO_LOCSTR_DEBUG_MSG15 				= "Le joueur ne combat pas !";
	ASO_LOCSTR_DEBUG_MSG16 				= "seulement pendant le combat ?";
	ASO_LOCSTR_DEBUG_MSG17 				= "la dur\195\169e de fr\195\169quence n'a pas \195\169t\195\169 atteinte pour l'avertissement";
	ASO_LOCSTR_DEBUG_MSG18 				= "contr\195\180le activ\195\169 !";
	ASO_LOCSTR_DEBUG_MSG19 				= "La commutation automatique de la configuration est activ\195\160!"; -- v1.12.0***
	ASO_LOCSTR_DEBUG_MSG20 				= "Le personnage est dans un raid!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG21 				= "Changement de la configuration de 'raid'!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG22 				= "Le personnage est dans un groupe!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG23 				= "Changement de la configuration de 'groupe'!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG24 				= "Le personnage n'est pas dans un groupe/raid!"; -- v1.12.0
	ASO_LOCSTR_DEBUG_MSG25 				= "Changement de la configuration 'solo'!"; -- v1.12.0

	ASO_LOCSTR_OUTPUT_MSG1 				= "Le statut de "..ASO_LOCSTR_TITLE..", pendant un combat, a \195\169t\195\169 bascul\195\169 en"; -- v1.11.0
	ASO_LOCSTR_OUTPUT_MSG2 				= "Les avertissements de "..ASO_LOCSTR_TITLE.." ont \195\169t\195\169 bascul\195\169s en"; -- v1.14.0
	ASO_LOCSTR_OUTPUT_MSG3				= ASO_LOCSTR_TITLE.."\nTous les avis ont \195\169t\195\169 arr\195\170t\195\169s!\nRevenez dessus pour pouvoir changer des arrangements."; -- v1.14.0
	ASO_LOCSTR_OUTPUT_MSG4				= ASO_LOCSTR_TITLE.." des messages d'avertissement ont \195\169t\195\169 tourn\195\169s"; -- v1.15.2

	ASO_LOCSTR_COMBAT_MSG1 				= ASO_LOCSTR_TITLE.." veut avertir pour";
	ASO_LOCSTR_COMBAT_MSG2				= "Type '/aso "..ASO_LOCSTR_STATUS.."' pour arr\195\170ter ces messages."; -- v1.15.3

	ASO_LOCSTR_MYADDONS_DESCRIPTION 	= "Informe les autres de votre niveau de vie/mana"; -- Maintenez-le court!

	-- CI-DESSOUS LES NOMS DE CANAUX DOIVENT ETRE EN MAJUSCULES SINON L'ADD-ON LES CONFONDRA AVEC DES NOMS DE PERSONNAGES !***
	ASO_LOCSTR_LOCAL 					= "LOCAL"; -- v1.9.0
	ASO_LOCSTR_BANNER 					= "BANNI\195\136RE"; -- v1.10.0
	ASO_LOCSTR_SAY 						= "DIRE";
	ASO_LOCSTR_PARTY 					= string.upper(ASO_LOCSTR_CONFIGS_PARTY_LABEL);
	ASO_LOCSTR_RAID 					= string.upper(ASO_LOCSTR_CONFIGS_RAID_LABEL);
	-- CI-DESSUS LES NOMS DE CANAUX DOIVENT ETRE EN MAJUSCULES SINON L'ADD-ON LES CONFONDRA AVEC DES NOMS DE PERSONNAGES !***

	-- UI localizations...
	ASO_LOCSTR_UI_Window_Title 			= ASO_LOCSTR_TITLE;
	-- Yes I know what you mean but the difference between shout and sout out in french is hard to tell
	-- I don't realy like the way I've trasltated it. Maybe the translation is not short enough
	ASO_LOCSTR_UI_Event_List_Title 						= "\195\137v\195\169nements";
	ASO_LOCSTR_UI_NotifyPercentEditBoxLabel 			= "Pourcentage pour avertir:  ";
	ASO_LOCSTR_UI_NotifyFrequencyEditBox 				= "Fr\195\169quence des avertissements:"; -- "Fr\195\169quence pour avertir:";
	ASO_LOCSTR_UI_IsCombatOnlyCheckButtonLabel 			= "En combat seulement";
	ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel 		= "Avertir par cris";
	ASO_LOCSTR_UI_IsMessagingEnabledCheckButtonLabel 	= "Avertir par messages";
	ASO_LOCSTR_UI_MessageTargetEditBoxLabel 			= "Cible: ";
	ASO_LOCSTR_UI_MessageMessageEditBoxLabel 			= "Message: ";
	ASO_LOCSTR_UI_TargetChannelsButton 					= "Canaux";
	ASO_LOCSTR_UI_ConfigurationsDropDownLabel			= "Configuration Active"; -- v1.11.0
	ASO_LOCSTR_UI_AutoSwitchCheckButtonLabel			= ASO_LOCSTR_CONFIGS_AUTOSWITCH; -- v1.12.0
	ASO_LOCSTR_UI_IsNotifyDuringDuelCheckButtonLabel	= "Avertir pendant duel"; -- v1.12.0

	ASO_LOCSTR_UI_TooltipText_ConfigurationsDropDown	= -- v1.15.0
		"Une configuration est un groupe de\n" ..
		"paramettres pour tous les types\n" ..
		"d'\195\169v\195\169nements possibles. Vous pouvez\n" ..
		"s\195\169lectionner la configuration active en\n" ..
		"la choisissant ici. Quand vous changez de\n"..
		"configuration, les paramettres ci-dessous\n" ..
		"vont changer (s'ils sont diff\195\169rents pour\n" ..
		"les configurations vari\195\169es). Quelque soit\n" ..
		"la configuration active, elle d\195\169terminera\n" ..
		"quels paramettre utiliser pour avertir.";
		
	ASO_LOCSTR_UI_TooltipText_AutoSwitchCheckButton	= -- v1.15.0
		"Si s\195\169lectionn\195\169, la '" .. ASO_LOCSTR_UI_ConfigurationsDropDownLabel .. "'\n" ..
		"changera automatiquement, selon si le\n" ..
		"joueur est dans un groupe, un raid, ou solo";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton1	= -- Health -- v1.15.0
		"Avertissement bas\195\169 sur votre\n" ..
		"\195\169tat de '" .. ASO_LOCSTR_HEALTH_LABEL .. "'. Utilise l'\195\169mote\n" ..
		"vocale /soin (si vous avez activ\195\169\n" ..
		"l'option '" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "')";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton2	= -- Life -- v1.15.0
		"Avertissement bas\195\169 sur la '" .. ASO_LOCSTR_HEALTH_LABEL .. "'\n" ..
		"qu'il vous reste.  Utilise l'\195\169mote\n" ..
		"vocale /aidemoi (si vous avez\n" ..
		"activ\195\169 l'option '" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "')";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton3	= -- Mana -- v1.15.0
		"Avertissement bas\195\169 sur la\n" ..
		"'" .. ASO_LOCSTR_MANA_LABEL .. "' qu'il vous reste.\n" ..
		"Utilise l'\195\169mote vocale /soin\n" ..
		"(si vous avez activ\195\169 l'option\n" ..
		"'" .. ASO_LOCSTR_UI_IsShoutEnabledCheckButtonLabel .. "')";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton4	= -- Pet Health -- v1.15.0
		"Avertissement bas\195\169 sur la\n" ..
		"'" .. ASO_LOCSTR_HEALTH_LABEL .. "' qu'il reste \195\160 votre \n" ..
		"familier.  N'utilise pas\n" ..
		"d'emote.";
		
	ASO_LOCSTR_UI_TooltipText_EventList_GlobalButton5	= -- Soulstone -- v1.15.0
		"Avertissement bas\195\169 sur quand\n" ..
		"le buff 'Pierre de r\195\169surrection'\n" ..
		"n'est plus actif. N'utilise pas\n" ..
		"d'emote vocale. Vous serez\n" ..
		"averti si un d\195\169moniste place le\n" ..
		"buff sur vous mais ASO n'est\n" ..
		"pas configur\195\169 pour vous signaler\n" ..
		"quand il n'est plus actif.";
		
	ASO_LOCSTR_UI_TooltipText_NotifyPercentEditBox	= -- v1.15.0
		"La valeur que doit atteindre\n" ..
		"un \195\169v\195\169nement avant qu'un\n" ..
		"avertissement soit fait";
		
	ASO_LOCSTR_UI_TooltipText_NotifyFrequencyEditBox	= -- v1.15.0
		"Nombre minimum de secondes\n" ..
		"entre les avertissemenst pour\n" ..
		"l'\195\169v\195\169nement s\195\169lectionn\195\169";
		
	ASO_LOCSTR_UI_TooltipText_IsShoutEnabledCheckButton	= -- v1.15.0
		"Si coch\195\169, les avertissements\n" ..
		"par emote vocale seront effectu\195\169s\n" ..
		"pour l'\195\169v\195\169nement s\195\169lectionn\195\169.";

	ASO_LOCSTR_UI_TooltipText_IsMessagingEnabledCheckButton	= -- v1.15.0
		"Si coch\195\169, les messages\n" ..
		"d'avertissement seront effectu\195\169s\n" ..
		"pour l'\195\169v\195\169nement s\195\169lectionn\195\169.";

	ASO_LOCSTR_UI_TooltipText_MessageTargetEditBox	= -- v1.15.0
		"L'endroit o\195\185 le texte du message\n" ..
		"d'avertissement sera affich\195\169. Vous\n" ..
		"pouvez inscrire le nom d'un joueur,\n" ..
		"ou utiliser le bouton des '" .. ASO_LOCSTR_UI_TargetChannelsButton .. "'\n" ..
		"pour s\195\169lectionner un diaglogue ou\n" ..
		"une zone de l'\195\169cran o\195\185 sera affich\195\169\n" ..
		"le message d'avertissement.";

	ASO_LOCSTR_UI_TooltipText_TargetChannelsButton	= -- v1.15.0
		"permutte entre les diff\195\169rents\n" ..
		"emplacement de l'\195\169cran o\195\185 le\n" ..
		"texte du message d'avertisse-\n" ..
		"ment sera affich\195\169";

	ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindowCloseButton	= -- v1.15.0
		"Tous les changements\n" ..
		"que vous avez fait seront\n" ..
		"sauvegard\195\169s lorsque vous\n" ..
		"cliquez sur ce bouton";

	ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindow_Close_Button = -- v1.15.0
		ASO_LOCSTR_UI_TooltipText_AutoShoutOutWindowCloseButton;
		
	ASO_LOCSTR_UI_TooltipText_MessageMessageEditBox		=  -- v1.11.0
		"$HEALTH \n   Points de vie restant actuellement\n\n" ..
		"$HEALTHMAX \n   Points de vie maximum possibles\n\n" ..
		"$HEALTHPERCENT \n   Pourcentage de points de vie restant actuellement\n\n" ..
		"$MANA \n   Points de mana restant actuellement\n\n" ..
		"$MANAMAX \n   Points de mana maximum possibles\n\n" ..
		"$MANAPERCENT \n   Pourcentage de points de mana restant actuellement\n\n" ..
		"$NAME \n   Nom de l'unit\195\169 concern\195\169e par l'avertissement" ;
		
	ASO_LOCSTR_UI_MainWindowSize_Width					= 415; -- v1.11.1
	ASO_LOCSTR_UI_MainWindowSize_Height					= 325; -- v1.11.1
	ASO_LOCSTR_UI_TitleBoxSize_Width					= 490;
	ASO_LOCSTR_UI_MessageMessageEditBoxSize_Width		= 300; -- v1.11.1
	
	return;


elseif (GetLocale() == "koKR") then -- "koKR"
	
	-- TBD
	ASO_Assign_Default_Localization();
	
else

	ASO_Assign_Default_Localization();
	
end


