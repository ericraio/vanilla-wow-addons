-- ## Many thanks to the following people for this translation ..
-- ##     * Szeraxenia on Der Rat von Dalaran

if (GetLocale() == "deDE") then

	-- ###############
	-- ## MENU TEXT ##
	-- ###############

	TITANBG_MENU_SHOW_OPTIONS = "Show Options";

	TITANBG_MENU_HEADER           = "Titan Battleground";
	TITANBG_MENU_HEADER_INTERFACE = "Interface";
	TITANBG_MENU_HEADER_WORLD     = "World";

	TITANBG_MENU_GENERAL_OPTIONS = "General Options";
	TITANBG_MENU_DISP_OPTIONS    = "Anzeige-Optionen";


	-- General Options
		-- Battleground
		TITANBG_MENU_AUTOJOIN     = "Automatisch beitreten";
		TITANBG_MENU_AUTOLEAVE    = "Auto leave the battleground on completion?";
		TITANBG_MENU_AUTORELEASE  = "Geist automatisch freilassen";
		TITANBG_MENU_RELEASECHECK = "Do not automatically release if a Soulstone or Shaman Ressurect is available?";

		-- Interface
		TITANBG_MENU_OVERWRITESIMILAR = "Overwrite similar settings in other addons?";

		TITANBG_MENU_HIDEMINIMAPBUTTON = "Minimap-Symbol verbergen";
		TITANBG_MENU_AUTOSHOWBATTLEMAP = "Automatically show the battleground minimap?";

		TITANBG_MENU_HIDEJOINPOPUP  = "Betreten-Dialog verbergen";
		TITANBG_MENU_REPEATSOUND    = "Periodically repeat the battleground ready sound?";
		TITANBG_MENU_PLAYWHICHSOUND = "Play which sound when the battleground is ready?";

	-- Display Options
		TITANBG_MENU_B_SPACERS = "Display spacer characters around the button text?";

		-- World
		TITANBG_MENU_B_TIME     = "Zeige (Rest)Zeit in Warteschlange";
		TITANBG_MENU_B_TIMELEFT = "Display the amount of time left before the battleground expires?";

		TITANBG_MENU_TT_QUEUETIMERS = "Zeige Schlachtfeld-Wartezeiten";
		TITANBG_MENU_TT_REMBGSOPEN  = "Zeige Anzahl der Schlachtfelder";

		-- Battleground
		TITANBG_MENU_BUTTON_OPTIONS = "Panel-Optionen";
		TITANBG_PANEL_HIDEACTIVE    = "Hide active battleground information when another battleground is ready to be joined?";
		TITANBG_PANEL_P             = "Display players?";
		TITANBG_PANEL_S             = "Platzierung anzeigen";
		TITANBG_PANEL_K             = "Ehrenhafte Siege anzeigen";
		TITANBG_PANEL_KB            = "Todesst\195\182sse anzeigen";
		TITANBG_PANEL_D             = "Tode anzeigen";
		TITANBG_PANEL_H             = "Bonusehre anzeigen";

		TITANBG_MENU_TT_OPTIONS        = "Tooltip-Optionen";
		TITANBG_MENU_TT_TWOTOOLTIPS    = "Separate active battleground and queue information into different tooltips?";
		TITANBG_MENU_TT_AB_WINESTIMATE = "Zeige Gewinn-Voraussage im Arathibecken";
		TITANBG_MENU_TT_WSG_FLAG       = "Display the Warsong Gulch flag tracker?";
		TITANBG_MENU_SHOWSTATS         = "Ehrenstatistik anzeigen";
		TITANBG_MENU_SHOWLOCATIONSTATS = "Spielerstatistik anzeigen";
		TITANBG_MENU_SHOWFRIENDS       = "Freunde anzeigen";
		TITANBG_MENU_SHOWCAPTURE       = "Stoppuhr anzeigen"

		TITANBG_MENU_PANEL_OPTIONS    = "Stoppuhr-Optionen";
		TITANBG_MENU_PANEL_LOCK       = "Lock the screen panel display?";
		TITANBG_MENU_PANEL_CAP_SHOW   = "On-Screen anzeigen";
		TITANBG_MENU_PANEL_CAP_INVERT = "Invert the on the screen capture timers?";

		TITANBG_MENU_PANEL_WSG_SHOW       = "Show on the screen Warsong Gulch flag tracker?";
		TITANBG_MENU_PANEL_WSG_CLICK      = "Allow name click targetting of flag runners?";
		TITANBG_MENU_PANEL_WSG_COLORCLASS = "Color on the screen flag runner names by class?";
		TITANBG_MENU_PANEL_WSG_TEXTCLASS  = "Display class text next to the flag runner name?";
		TITANBG_MENU_PANEL_WSG_INVERT     = "Invert the on the screen flag tracker?";
		TITANBG_MENU_PANEL_WSG_ATTACH     = "Attach the on screen flag tracker to the score frame?";

		TITANBG_MENU_POPUP_OPTIONS  = "PopUp Options";
		TITANBG_MENU_POPUP_EXPIRE   = "Modify the battleground ready popup to display the time until the queue expires?";

	-- Queue Options
	TITANBG_MENU_QUEUE_OPTIONS = "Warteschlangen-Optionen";


	-- ###################
	-- ## BUTTON LABELS ##
	-- ###################

	TITANBG_BUTTON_PAUSED = "P";

	-- Queue
	TITANBG_FIRST_AVAILABLE = "Erstes";
	TITANBG_LABEL_READY     = "Bereit";

	-- Battleground
	TITANBG_S_STANDING     = "Pl: ";
	TITANBG_S_KILLINGBLOWS = "TS: ";
	TITANBG_S_KILLS        = "ES: ";
	TITANBG_S_DEATHS       = "To: ";
	TITANBG_S_HONOR        = "BE: ";

	-- XML
	TITANBG_DRAGGABLE_OS_CAP         = "TitanBG Screen Information\nDraggable Frame";
	TITANBG_DRAGGABLE_OS_CAPINSTRUCT = "To hide this frame, tick the '" .. TITANBG_MENU_PANEL_LOCK .. "' option under '" .. TITANBG_MENU_DISP_OPTIONS .. " / " .. CHAT_MSG_BATTLEGROUND .. "'.";

	-- ####################
	-- ## TOOLTIP LABELS ##
	-- ####################

	TITANBG_TOOLTIP         = "Schlachtfeld-Information";
	TITANBG_TOOLTIP_PAUSED  = "Paused";
	TITANBG_TOOLTIP_UNPAUSE = "Resume";

	-- Not in the Queue.
		TITANBG_NOT_IN_QUEUE_LONG = "Not in the queue for {bg}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.

	-- Waiting
		TITANBG_TIME_IN_QUEUE       = "Zeit in Warteschlange: ";
		TITANBG_ESTIMATED_REMAINING = "Erwartete Restzeit: ";
		TITANBG_ESTIMATED_WAIT      = "Erwartete Wartezeit: ";
		TITANBG_LESS_THAN_ONE_MIN   = "Weniger als eine Minute.";
		TITANBG_QUEUED_NOPREF       = "You are currently queued for the next available {bg}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.
		TITANBG_QUEUED_PREF         = "You are currently queued for {bg}.";                    -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.
		TITANBG_ACTIVE_INSTANCES    = "Aktive Instanzen:";

	-- Ready
		TITANBG_CONFIRMJOIN    = "Ihr k\195\182nnt jetzt {bg} beitreten{time}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name. The {time} part of the string will be replaced by the time left before the queue expires (if applicable).
		TITANBG_AUTOJOIN       = "Automatically joining {bg} in {time}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name. The {time} part of the string will always be replaced by the join time and the time left before the queue expires (if applicable).
		TITANBG_AUTOJOIN_HINT  = "Tipp: LINKSklick um automatisches Beitreten anzuhalten/fortzusetzen.";

	-- Battleground
		TITANBG_AUTOLEAVE = "Automatically leaving the battleground in {time}."; -- !! NOTE: The {time} part of the string will be replaced by the join time.

		TITANBG_NO_INFORMATION       = "Sammle Informationen";
		TITANBG_INSTANCE_RUN_TIME_NA = "Nicht verf\195\188gbar."
		TITANBG_PLAYERS              = "Gesamtzahl Spieler:";

		TITANBG_AB_WINNER         = "Erwarteter Gewinner:";
		TITANBG_AB_FINAL_SCORE    = "Erwartete Gesamtpunktzahl:";
		TITANBG_AB_TIME_LEFT      = "Erwartete Restzeit:";
		TITANBG_AB_TO_WIN         = "Ben\195\182tigte Basen f\195\188r Sieg:";
		TITANBG_AB_TO_WIN_ENEMY   = "Number of Nodes the Enemy Has to Capture to Win:";
		TITANBG_AB_IMPOSSIBLE     = "Unm\195\182glich.";
		TITANBG_AB_WINNER_UNKNOWN = "Unbekannt.";

		TITANBG_PLAYER_STATS         = "Ehrenstatistik";
		TITANBG_PLAYER_STANDING      = "Platzierung:";
		TITANBG_PLAYER_KILLINGBLOWS  = "Todesst\195\182sse:";
		TITANBG_PLAYER_KILLS         = "Ehrenhafte Siege:";
		TITANBG_PLAYER_DEATHS        = "Tode:";

		TITANBG_LOCATION_STATS       = "Spielerstatistik";
		TITANBG_PLAYER_GYASSAULTED   = "Friedh\195\182fe eingenommen:";
		TITANBG_PLAYER_GYDEFENDED    = "Friedh\195\182fe verteidigt:";
		TITANBG_PLAYER_TASSAULTED    = "T\195\188rme zerst\195\182rt:";
		TITANBG_PLAYER_TDEFENDED     = "T\195\188rme verteidigt:";
		TITANBG_PLAYER_MCAPTURED     = "Minen eingenommen:";
		TITANBG_PLAYER_LKILLED       = "Anf\195\188hrer get\195\182tet:";
		TITANBG_PLAYER_SECOBJ        = "Sekund\195\164rziele:";
		TITANBG_PLAYER_FCAPTURED     = "Flaggen errungen:";
		TITANBG_PLAYER_FRETURNED     = "Flaggen zur\195\188ckgebracht:";
		TITANBG_PLAYER_BSASSULTED    = "Basen eingenommen:";
		TITANBG_PLAYER_BSDEFENDED    = "Basen verteidigt:";
		TITANBG_PLAYER_BONUSHONOR    = "Bonusehre:";

		TITANBG_FRIENDS = "Freunde";

		TITANBG_CAPTURE_TIMERS  = "Stoppuhr";
		TITANBG_CAPTURE_UNKNOWN = "Unbekannt.";
		TITANBG_CAPTURE_IMINENT = "Bevorstehend.";

		TITANBG_WIN_ESTIMATE = "Winner Estimates";
		TITANBG_FLAG_TRACKER = "Flag Status";
		TITANBG_FLAG         = "Flag";

		TITANBG_SCOREFRAME_HINT = "Tipp: LINKSklick um die Punktetafel ein-/auszublenden.";
		TITANBG_MINIMAP_HINT    = "Tipp: SHIFT-Klick um die Schlachtfeld-Minikarte ein-/auszublenden.";
		TITANBG_TOOLTIP_HINT    = "Hint: CTRL click to change tooltip information.";


	-- ######################
	-- ## TITANBG MESSAGES ##
	-- ######################

	TITANBG_MESSAGE_NOTICE = TITAN_TITANBG_NAME .. " " .. TITANBG_VERSION  .. ". Developed by " .. TITANBG_AUTHOR .. ".";

	TITANBG_MESSAGE_CHANGEOVERWRITTEN = "To control this setting, use TitanBG or uncheck '" .. TITANBG_MENU_OVERWRITESIMILAR .. "' under '" .. TITANBG_MENU_GENERAL_OPTIONS .. "'.";
	TITANBG_MESSAGE_ACTIONOVERWRITTEN = "This setting is being overwritten by TitanBG and will not be used.\n\n|cffffffff" .. TITANBG_MESSAGE_CHANGEOVERWRITTEN;

	-- ##################
	-- ## NOMENCLATURE ##
	-- ##################

	-- Short names for the battlegrounds.
	TITANBG_BG_AV_SHORT  = "AT";
	TITANBG_BG_WSG_SHORT = "WSS";
	TITANBG_BG_AB_SHORT  = "AB";

	-- Sound file names.
	TITANBG_SOUND_DEFAULT   = "Default";
	TITANBG_SOUND_CRASH     = "Crash";
	TITANBG_SOUND_LIGHTNING = "Lightning";
	TITANBG_SOUND_BELL      = "Bell";
	TITANBG_SOUND_HORN      = "Horn";
	TITANBG_SOUND_CYMBAL    = "Cymbal";
	TITANBG_SOUND_WHISTLE   = "Whistle";
	TITANBG_SOUND_CHIME     = "Chime";
	TITANBG_SOUND_TRUMPET   = "Trumpet";

	-- ################
	-- ## REFERENCES ##
	-- ################

	-- This section has special requirements, as the translations reference Blizzard terminology.
	-- Please pay marked attention to the comments.

	-- Translate the section within the [""] only.
	-- Class names must be exactly as returned by UnitClass().
	TITANBG_CLASS = {
		["Druide"]       = "DRUID",
		["J\195\164ger"] = "HUNTER",
		["Magier"]       = "MAGE",
		["Paladin"]      = "PALADIN",
		["Priester"]     = "PRIEST",
		["Schurke"]      = "ROGUE",
		["Schamane"]     = "SHAMAN",
		["Hexenmeister"] = "WARLOCK",
		["Krieger"]      = "WARRIOR",
	};

	-- Arathi Basin text, displayed at the top of the screen, listing the amount of resources captured by each faction. For example 'Resources: 0/2000'.
	-- Must be displayed exactly how it appears on the screen.
	TITANBG_AB_RESOURCES_DP = "Ressourcen:";

	-- These must be exactly as printed by the system while in Warsong Gulch.
	-- These are used for pattern matching and should not include the player's name or any text following or preceding it as applicable.
	TITANBG_WSG_PICKEDUP = "hat die [fF]lagge der %a+ aufgenommen!";   -- Name preceeding.
	TITANBG_WSG_DROPPED  = "hat die [fF]lagge der %a+ fallen lassen!"; -- Name preceeding.
	TITANBG_WSG_CAPTURED = "hat die [fF]lagge der %a+ errungen!";      -- Name preceeding.

	-- !! WARNING !!
	-- These must apear exactly as sent by the system.
	-- This can be tested by making certain the lines between !! DEBUG START and !! DEBUG END
	-- are not commented (do not have a preceeding --) and typing '/console reloadui' into the chat window.

	-- 'BG = ' will display the name of the battleground. If the slot isn't taken up by a battleground,
	-- then it will display the zone you are currently in.

	-- Please make certain the text appears EXACTLY as printed. Do not insert capitals where they are not necessary,
	-- nor not include capitals when they are listed.

		-- Battleground Names
		TITANBG_BG_AV  = "Alteractal";
		TITANBG_BG_WSG = "Warsongschlucht";
		TITANBG_BG_AB  = "Arathibecken";

	-- !! END WARNING !!
end