TITAN_TITANBG_NAME = "TitanBG (Updated)";
TITANBG_VERSION    = "1.2.2";
TITANBG_AUTHOR     = "Maina (Chromaggus)";

if (GetLocale() == "enUS") then

	-- ###############
	-- ## MENU TEXT ##
	-- ###############

	TITANBG_MENU_SHOW_OPTIONS = "Show Options";

	TITANBG_MENU_HEADER           = "Titan Battleground";
	TITANBG_MENU_HEADER_INTERFACE = "Interface";
	TITANBG_MENU_HEADER_WORLD     = "World";

	TITANBG_MENU_GENERAL_OPTIONS = "General Options";
	TITANBG_MENU_DISP_OPTIONS    = "Display Options";

	-- General Options
		-- Battleground
		TITANBG_MENU_AUTOJOIN     = "Auto join the battleground?";
		TITANBG_MENU_AUTOLEAVE    = "Auto leave the battleground on completion?";
		TITANBG_MENU_AUTORELEASE  = "Auto release on death?";
		TITANBG_MENU_RELEASECHECK = "Do not automatically release if a Soulstone or Shaman Ressurect is available?";

		-- Interface
		TITANBG_MENU_OVERWRITESIMILAR = "Overwrite similar settings in other addons?";

		TITANBG_MENU_HIDEMINIMAPBUTTON = "Hide the minimap battleground icon?";
		TITANBG_MENU_AUTOSHOWBATTLEMAP = "Automatically show the battleground minimap?";

		TITANBG_MENU_HIDEJOINPOPUP  = "Hide the battleground ready popup?";
		TITANBG_MENU_REPEATSOUND    = "Periodically repeat the battleground ready sound?";
		TITANBG_MENU_PLAYWHICHSOUND = "Play which sound when the battleground is ready?";

	-- Display Options
		TITANBG_MENU_B_SPACERS = "Display spacer characters around the button text?";

		-- World
		TITANBG_MENU_B_TIME     = "Display the time in queue and the estimated wait time?";
		TITANBG_MENU_B_TIMELEFT = "Display the amount of time left before the battleground expires?";

		TITANBG_MENU_TT_QUEUETIMERS = "Display the battleground queue times?";
		TITANBG_MENU_TT_REMBGSOPEN  = "Display the amount of battlegrounds available?";

		-- Battleground
		TITANBG_MENU_BUTTON_OPTIONS = "Button";
		TITANBG_PANEL_HIDEACTIVE    = "Hide active battleground information when another battleground is ready to be joined?";
		TITANBG_PANEL_P             = "Display players?";
		TITANBG_PANEL_S             = "Display standing?";
		TITANBG_PANEL_K             = "Display kills?";
		TITANBG_PANEL_KB            = "Display killing blows?";
		TITANBG_PANEL_D             = "Display deaths?";
		TITANBG_PANEL_H             = "Display honor bonus?";

		TITANBG_MENU_TT_OPTIONS        = "Tooltip";
		TITANBG_MENU_TT_TWOTOOLTIPS    = "Separate active battleground and queue information into different tooltips?";
		TITANBG_MENU_TT_AB_WINESTIMATE = "Display Arathi Basin win estimations?";
		TITANBG_MENU_TT_WSG_FLAG       = "Display the Warsong Gulch flag tracker?";
		TITANBG_MENU_SHOWSTATS         = "Display player statistics?";
		TITANBG_MENU_SHOWLOCATIONSTATS = "Display player objective statistics?";
		TITANBG_MENU_SHOWFRIENDS       = "Display friends?";
		TITANBG_MENU_SHOWCAPTURE       = "Display capture timers?";

		TITANBG_MENU_PANEL_OPTIONS    = "Panel";
		TITANBG_MENU_PANEL_LOCK       = "Lock the screen panel display?";
		TITANBG_MENU_PANEL_CAP_SHOW   = "Show on the screen capture timers?";
		TITANBG_MENU_PANEL_CAP_INVERT = "Invert the on the screen capture timers?";

		TITANBG_MENU_PANEL_WSG_SHOW       = "Show on the screen Warsong Gulch flag tracker?";
		TITANBG_MENU_PANEL_WSG_CLICK      = "Allow name click targetting of flag runners?";
		TITANBG_MENU_PANEL_WSG_COLORCLASS = "Color on the screen flag runner names by class?";
		TITANBG_MENU_PANEL_WSG_TEXTCLASS  = "Display class text next to the flag runner name?";
		TITANBG_MENU_PANEL_WSG_INVERT     = "Invert the on the screen flag tracker?";
		TITANBG_MENU_PANEL_WSG_ATTACH     = "Attach the on screen flag tracker to the score frame?";

		TITANBG_MENU_POPUP_OPTIONS = "PopUp";
		TITANBG_MENU_POPUP_EXPIRE  = "Modify the battleground ready popup to display the time until the queue expires?";

	-- Queue Options
	TITANBG_MENU_QUEUE_OPTIONS = "Queue Options";

	-- ###################
	-- ## BUTTON LABELS ##
	-- ###################

	TITANBG_BUTTON_PAUSED = "P";

	-- Queue
	TITANBG_FIRST_AVAILABLE = "Any";
	TITANBG_LABEL_READY     = "Ready";

	-- Battleground
	TITANBG_S_STANDING     = "S: ";
	TITANBG_S_KILLINGBLOWS = "KB: ";
	TITANBG_S_KILLS        = "K: ";
	TITANBG_S_DEATHS       = "D: ";
	TITANBG_S_HONOR        = "H: ";

	-- XML
	TITANBG_DRAGGABLE_OS_CAP         = "TitanBG Screen Information\nDraggable Frame";
	TITANBG_DRAGGABLE_OS_CAPINSTRUCT = "To hide this frame, tick the '" .. TITANBG_MENU_PANEL_LOCK .. "' option under '" .. TITANBG_MENU_DISP_OPTIONS .. " / " .. CHAT_MSG_BATTLEGROUND .. "'.";

	-- ####################
	-- ## TOOLTIP LABELS ##
	-- ####################

	TITANBG_TOOLTIP         = "Battleground Information";
	TITANBG_TOOLTIP_PAUSED  = "Paused";
	TITANBG_TOOLTIP_UNPAUSE = "Resume";

	-- Not in the Queue.
		TITANBG_NOT_IN_QUEUE_LONG = "Not in the queue for {bg}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.

	-- Waiting
		TITANBG_TIME_IN_QUEUE       = "Time in queue: ";
		TITANBG_ESTIMATED_REMAINING = "Estimated time remaining: ";
		TITANBG_ESTIMATED_WAIT      = "Estimated wait time: ";
		TITANBG_LESS_THAN_ONE_MIN   = "Less than one minute.";
		TITANBG_QUEUED_NOPREF       = "You are currently queued for the next available {bg}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.
		TITANBG_QUEUED_PREF         = "You are currently queued for {bg}.";                    -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.
		TITANBG_ACTIVE_INSTANCES    = "Active instances:";

	-- Ready
		TITANBG_CONFIRMJOIN    = "You are now eligible to enter {bg}{time}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name. The {time} part of the string will be replaced by the time left before the queue expires.
		TITANBG_AUTOJOIN       = "Automatically joining {bg} in {time}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name. The {time} part of the string will be replaced by the join time.
		TITANBG_AUTOJOIN_HINT  = "Hint: LEFT click to pause/resume the auto join timer.";

	-- Battleground
		TITANBG_AUTOLEAVE = "Automatically leaving the battleground in {time}."; -- !! NOTE: The {time} part of the string will be replaced by the join time.

		TITANBG_NO_INFORMATION       = "Collecting Information";
		TITANBG_INSTANCE_RUN_TIME_NA = "Not Available.";
		TITANBG_PLAYERS              = "Total Players:";

		TITANBG_AB_WINNER         = "Estimated Winner:";
		TITANBG_AB_FINAL_SCORE    = "Estimated Final Score:";
		TITANBG_AB_TIME_LEFT      = "Estimated Time Remaining:";
		TITANBG_AB_TO_WIN         = "Number of Nodes You Have to Capture to Win:";
		TITANBG_AB_TO_WIN_ENEMY   = "Number of Nodes the Enemy Has to Capture to Win:";
		TITANBG_AB_IMPOSSIBLE     = "Impossible.";
		TITANBG_AB_WINNER_UNKNOWN = "Unknown.";

		TITANBG_PLAYER_STATS        = "Player Statistics";
		TITANBG_PLAYER_STANDING     = "Standing:";
		TITANBG_PLAYER_KILLINGBLOWS = "Killing Blows:";
		TITANBG_PLAYER_KILLS        = "Kills:";
		TITANBG_PLAYER_DEATHS       = "Deaths:";

		TITANBG_LOCATION_STATS     = "Player Objective Statistics";
		TITANBG_PLAYER_GYASSAULTED = "Graveyards Assaulted:";
		TITANBG_PLAYER_GYDEFENDED  = "Graveyards Defended:";
		TITANBG_PLAYER_TASSAULTED  = "Towers Assaulted:";
		TITANBG_PLAYER_TDEFENDED   = "Towers Defended:";
		TITANBG_PLAYER_MCAPTURED   = "Mines Captured:";
		TITANBG_PLAYER_LKILLED     = "Leaders Killed:";
		TITANBG_PLAYER_SECOBJ      = "Secondary Objectives:";
		TITANBG_PLAYER_FCAPTURED   = "Flags Captured:";
		TITANBG_PLAYER_FRETURNED   = "Flags Returned:";
		TITANBG_PLAYER_BSASSULTED  = "Bases Assaulted:";
		TITANBG_PLAYER_BSDEFENDED  = "Bases Defended:";
		TITANBG_PLAYER_BONUSHONOR  = "Bonus Honor:";

		TITANBG_FRIENDS = "Friends";

		TITANBG_CAPTURE_TIMERS  = "Capture Timers";
		TITANBG_CAPTURE_UNKNOWN = "Unknown.";
		TITANBG_CAPTURE_IMINENT = "Ready";

		TITANBG_WIN_ESTIMATE = "Winner Estimates";
		TITANBG_FLAG_TRACKER = "Flag Status";
		TITANBG_FLAG         = "Flag";

		TITANBG_SCOREFRAME_HINT = "Hint: LEFT click to toggle score frame.";
		TITANBG_MINIMAP_HINT    = "Hint: SHIFT click to toggle the battleground minimap.";
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
	TITANBG_BG_AV_SHORT  = "AV";
	TITANBG_BG_WSG_SHORT = "WSG";
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
		["Druid"]   = "DRUID",
		["Hunter"]  = "HUNTER",
		["Mage"]    = "MAGE",
		["Paladin"] = "PALADIN",
		["Priest"]  = "PRIEST",
		["Rogue"]   = "ROGUE",
		["Shaman"]  = "SHAMAN",
		["Warlock"] = "WARLOCK",
		["Warrior"] = "WARRIOR",
	};

	-- Arathi Basin text, displayed at the top of the screen, listing the amount of resources captured by each faction. For example 'Resources: 0/2000'.
	-- Must be displayed exactly how it appears on the screen.
	TITANBG_AB_RESOURCES_DP = "Resources:";

	-- These must be exactly as printed by the system while in Warsong Gulch.
	-- These are used for pattern matching and should not include the player's name or any text following or preceding it as applicable.
	TITANBG_WSG_PICKEDUP = "The [%a]+ [fF]lag was picked up by"; -- Name following.
	TITANBG_WSG_DROPPED  = "The [%a]+ [fF]lag was dropped by";   -- Name following.
	TITANBG_WSG_CAPTURED = "captured the [%a]+ [fF]lag!";        -- Name preceeding.

	-- !! WARNING !!
	-- These must apear exactly as sent by the system.
	-- This can be tested by making certain the lines between !! DEBUG START and !! DEBUG END
	-- are not commented (do not have a preceeding --) and typing '/console reloadui' into the chat window.

	-- 'BG = ' will display the name of the battleground. If the slot isn't taken up by a battleground,
	-- then it will display the zone you are currently in.

	-- Please make certain the text appears EXACTLY as printed. Do not insert capitals where they are not necessary,
	-- nor not include capitals when they are listed.

		-- Battleground Names
		TITANBG_BG_AV  = "Alterac Valley";
		TITANBG_BG_WSG = "Warsong Gulch";
		TITANBG_BG_AB  = "Arathi Basin";

	-- !! END WARNING !!
end