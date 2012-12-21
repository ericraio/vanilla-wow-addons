-- ## Tracks battleground queues and statistics.
-- ##
-- ## This mod was adapted from TitanBG 1600 developed by Sphiromi.
-- ##
-- ## Name    : TitanBG (Updated)
-- ## Author  : Maina (Chromaggus), Sphiromi
-- ## Version : 1.2.3
-- ##
-- ## Version 1.2.3
-- ##     * Added a slash command to toggle the options menu. This command is /titabg or /tbg.
-- ##     * Fixed a problem with timers being cleared when moving around Stormpike Graveyard in Alterac Valley.
-- ##     * Fixed a problem with the Warsong Gulch flag tracker incorrectly extracting names containing special characters.
-- ##     * Fixed a problem with the Warsong Gulch flag tracker throwing errors in German and French clients, as a result of incorrect class name translations.
-- ##     * Fixed a problem with incorrect slash commands throwing errors.
-- ##
-- ## Version 1.2.2.1
-- ##     * Fixed a problem with the Warsong Gulch flag tracker not displaying the player occasionally.
-- ##     * Fixed a problem with player statistics not being correctly tracked.
-- ##
-- ## Version 1.2.2
-- ##     * Fixed a problem with the join battleground popup not joining when the accept button is clicked in the German client.
-- ##     * Fixed a problem with errors being generated when non-standard characters are used in player names in Warsong Gulch.
-- ##     * Fixed a problem with changing battlegrounds from Arathi Basin to another, occasionally throwing arithmetic errors.
-- ##     * Fixed a problem with nil value errors occuring when the current flag carrier leaves Warsong Gulch.
-- ##     * Fixed a problem with the Warsong Gulch flag runner name occasionally not being hidden when the flag is dropped or captured.
-- ##     * Fixed a problem with unassociated popups being modified to contain battleground information, if the original battleground ready popup was hidden.
-- ##     * Fixed a problem where the time left before the battleground queue expires would still show, even if it was disabled, while auto joining.
-- ##     * Updated the French translation.
-- ##     * Updated existing Warlock coloring to appear lighter.
-- ##
-- ## Version 1.2.1
-- ##     * Added an option to choose if you still wish to automatically release if you have a Soulstone or Shaman Ressurect available.
-- ##     * Fixed a problem with the player statistics not showing.
-- ##     * Fixed a problem with the 'BattlefieldMinimapCloseButton' frame not existing.
-- ##     * Fixed a problem with the Blizzard instance array throwing nil value errors.
-- ##     * Fixed a problem with the Warsong Gulch flag tracker throwing nil value errors.
-- ##     * Updated options to use a stand alone frame.
-- ##     * Updated the French translation.
-- ##
-- ## Version 1.2.0
-- ##     * Added the ability to overwrite similar settings in other addons.
-- ##     * Added the ability to play custom sounds when a battleground is ready.
-- ##     * Added the ability to play the battleground ready sound periodically or only once.
-- ##     * Added the ability to automatically show the battleground minimap, when entering a battleground.
-- ##     * Added the ability to show the battleground minimap while not in a battleground.
-- ##     * Added the ability to display players in the battleground on the button.
-- ##     * Added the ability to display the instance number of the battleground ready to be joined in the button and tooltip.
-- ##     * Added the ability to display the amount of time before a battleground queue expires in the button and tooltip.
-- ##     * Added the ability to show the active battleground and queue information in separate tooltips while in a battleground.
-- ##     * Added the ability to hide active information while in a battleground, when a queue is ready to be joined.
-- ##     * Added the ability to track who is carrying the Warsong Gulch flag and the ability to target them easily.
-- ##     * Added, to the Arathi Basin estimations, the ability to calculate the amount of nodes the enemy needs to capture in order to win.
-- ##     * Added, to the Arathi Basin estimations, the ability to calculate the approximate amount of time before the amount of nodes needed increases.
-- ##     * Added the ability to invert the on screen capture timers, so that they are displayed bottom to top, rather than top to bottom.
-- ##     * Fixed a problem with the auto join timer counting down, even if not enabled.
-- ##     * Fixed a problem with the addon performing various actions even when not enabled.
-- ##     * Fixed a problem with the French translation causing errors.
-- ##     * Updated the battleground ready popup to display the auto join time and the time until the queue expires.
-- ##     * Removed the battleground raid invitation system.
-- ##     * Removed the ability to auto accept raid invites in a battleground.
-- ##
-- ## Version 1.1.2
-- ##     * Added a French translation, provided by Triel on Curse Gaming.
-- ##     * Fixed a problem with the Arathi Basin estimators not working for languages other than English, even before the patch.
-- ##     * Fixed a problem with the recent patch causing Arathi Basin estimations to throw an error.
-- ##     * Fixed a problem with new installations of the addon throwing nil value errors.
-- ##     * Updated on the screen timers to be unlocked when the user first installs the addon. An explanation has been added to the frame to make this process clearer.
-- ##     * Updated it so that on the screen capture timers can now be clicked through.
-- ##     * Updated to World of Warcraft patch 1.12.
-- ##
-- ## Version 1.1.1
-- ##     * !! WARNING !! This version will reset all previous settings.
-- ##
-- ##     * Added the option to display queue times on the Titan Panel, in the format of [Time in Queue/Estimated Wait Time].
-- ##     * Added the ability for the addon to estimate who will win an Arathi Basin.
-- ##     * Added the ability for the addon to estimate the final score in Arathi Basin (with an accuracy of within 10 points).
-- ##     * Added the ability for the addon to estimate how long the battle will take in Arathi Basin.
-- ##     * Added the ability for the addon to estimate how many nodes your team needs to capture in order to win, if they are losing, in Arathi Basin.
-- ##     * Added the ability for the addon to remember how many open battlegrounds existed for each battleground when the user last checked.
-- ##     * Added French localization to the .xml file.
-- ##     * Fixed a problem with existing queues being abandoned when the addon is first loaded.
-- ##     * Fixed a problem with the bonus honor not being displayed correctly.
-- ##     * Fixed a problem with it only displaying four timers on the screen, when there should have been five.
-- ##     * Fixed problems with abnormal behaviour when hiding or showing various UI elements.
-- ##     * Updated German translation to include previously missing variables.
-- ##     * Updated saved variable names for consistency.
-- ##
-- ## Version 1.1.0.1
-- ##     * Emergency fix for the errors caused by version 1.1.0.
-- ##
-- ## Version 1.1.0
-- ##     * Added statistics and capture tracking for Arathi Basin, previously not implemented.
-- ##     * Added statistics tracking for Warsong Gulch, previously implemented but not printed.
-- ##     * Added an on the screen display of the capture timers for Alterac Valley and Arathi Basin.
-- ##     * Added German translation, provided by Szeraxenia on Der Rat von Dalaran.
-- ##     * Added showing of ready to join queues in the button text, when already in a battleground.
-- ##     * Fixed the auto join timer.
-- ##     * Fixed minor issues with disbanding a raid, or leaving a raid group on completion.
-- ##     * Updated statistics and capture tracking code.
-- ##     * Updated 'Location Statistics' to 'Player Objective Statistics' for clarification.
-- ##
-- ## Version 1.0.2
-- ##     * Updated the capture timers to correspond to faction colour. Red will now indicate it is going to be captured by the Horde. Blue indicates it will be captured by the Alliance.
-- ##     * Updated all code, so that the localization file can be easily modified into other languages.
-- ##     * Updated various display functions to include faster processing.
-- ##
-- ## Version 1.0.1
-- ##     * Added function to determine if the user is currently interacting with a battleground in any fashion.
-- ##     * Fixed issue with the showing and hiding of the minimap button when not in the queue.
-- ##     * Updated toc files to the current patch.
-- ##
-- ## Version 1.0.0
-- ##     * Removed auto ressurect ability, implemented by Blizzard.
-- ##     * Removed sound to be played on queue pop, implemented by Blizzard.
-- ##     * Added auto invite and mass invite abilities.
-- ##     * Added auto remove ability.
-- ##     * Added auto promote ability.
-- ##     * Added auto free for all looting ability.
-- ##     * Added hide join battleground popup.
-- ##     * Fixed auto join ability.
-- ##     * Fixed auto release ability.
-- ##     * Fixed hide minimap button.
-- ##     * Updated addon to work with multiple queues.
-- ##     * Updated and reorganised menus and options.

-- Addon information variables.
TITAN_TITANBG_ID     = "TitanBG";
TITANBG_ARTWORK_PATH = "Interface\\AddOns\\Titan\\TitanBG\\Artwork\\TitanBG";
TITAN_TITANBG_FREQ   = 0.5;

-- Checking variables.

	-- Status of battlegrounds. Must be exactly as returned by the first variable of GetBattlefieldStatus(i).
	TITANBG_BG_STATUS_NONE    = "none";
	TITANBG_BG_STATUS_QUEUED  = "queued";
	TITANBG_BG_STATUS_CONFIRM = "confirm";
	TITANBG_BG_STATUS_ACTIVE  = "active";

	-- Faction names. EXACTLY as returned by UnitFactionGroup("player") or UnitFactionGroup("target").
	TITANBG_HORDE    = "Horde";
	TITANBG_ALLIANCE = "Alliance";

-- Colors and icons.
TITANBG_ICON_CAP_BLANK     = {0.75, 0.875, 0.125, 0.25};
TITANBG_ICON_BUTTON_SPACER = "*";

TITANBG_COLOR_BLUE         = "|cff0097d0";
TITANBG_COLOR_RED          = RED_FONT_COLOR_CODE;
TITANBG_COLOR_GREEN        = GREEN_FONT_COLOR_CODE;
TITANBG_COLOR_GREY         = "|cffb6b6b6";
TITANBG_COLOR_WHITE        = HIGHLIGHT_FONT_COLOR_CODE;
TITANBG_COLOR_YELLOW       = NORMAL_FONT_COLOR_CODE;
TITANBG_COLOR_YELLOW_LIGHT = LIGHTYELLOW_FONT_COLOR_CODE;
TITANBG_COLOR_PURPLE       = "|cffd94fff";

TITANBG_COLOR_CLASS = {
	["WARRIOR"] = { color = "|cffbba58d", },
	["DRUID"]   = { color = "|cffffad0f", },
	["MAGE"]    = { color = "|cff3fd7ff", },
	["WARLOCK"] = { color = "|cffc783ff", },
	["ROGUE"]   = { color = "|cffffe92f", },
	["HUNTER"]  = { color = "|cff70ce56", },
	["PRIEST"]  = { color = "|cffffffff", },
	["PALADIN"] = { color = "|cfffe9ee9", },
	["SHAMAN"]  = { color = "|cfffe9ee9", },
};

-- Sounds
TITANBG_SOUNDS_BGWARNING = {
	[1] = { name = TITANBG_SOUND_DEFAULT,   file = "", },

	[2] = { name = TITANBG_SOUND_BELL,      file = "Sound\\Doodad\\BoatDockedWarning.wav", },
	[3] = { name = TITANBG_SOUND_CHIME,     file = "Sound\\Spells\\ShaysBell.wav", },
	[4] = { name = TITANBG_SOUND_CRASH,     file = "Sound\\Doodad\\ArcaneCrystalOpen.wav", },
	[5] = { name = TITANBG_SOUND_CYMBAL,    file = "Sound\\interface\\LevelUp.wav", },
	[6] = { name = TITANBG_SOUND_HORN,      file = "Sound\\Doodad\\DwarfHorn.wav", },
	[7] = { name = TITANBG_SOUND_LIGHTNING, file = "Sound\\Doodad\\BlastedLandsLightningbolt01Stand-Bolt.wav", },
	[8] = { name = TITANBG_SOUND_TRUMPET,   file = "Sound\\interface\\levelup2.wav", },
	[9] = { name = TITANBG_SOUND_WHISTLE,   file = "Sound\\Spells\\PetCall.wav", },
};

-- Player information variables.
local _player_name          = UNKNOWNOBJECT;
local _player_faction       = TITANBG_HORDE;
local _player_enemy_faction = TITANBG_HORDE;
local _player_zone          = UNKNOWN;
local _player_realm         = UNKNOWNOBJECT;

-- Auto join and leave.
local _autojoin_bg     = ""; -- Which battleground we are auto joining.
local _autojoin_time   = 0;
local _autojoin_paused = 0;
local _autojoin_delay  = 10; -- Delay until the battleground is joined, in seconds.

local _autoleave_time   = 0;
local _autoleave_paused = 0;
local _autoleave_delay  = 10; -- Delay until the battleground is joined, in seconds.

-- Capture delays.
local _capture_delay_av = 300; -- Alterac Valley.
local _capture_delay_ab = 60;  -- Arathi Basin.

-- Battleground information variables.
	local _active_init_stored = false; -- If the active nodes have been stored on load.

	      _bgs    = { };   -- Battleground infromation.
	      _active = { };   -- Information on the current active battleground.

	local _update_number      = 0;     -- The id number of the last battleground information update.
	local _display_queue_tt   = false; -- Display the secondary tooltip, or the primary one.

	local _timetonodeincrease  = 0;  -- Amount of seconds until the nodes needing to be captured increases.
	local _bgready_sound_delay = 20; -- Number of seconds between battleground ready sounds if repetitive.

	local _popups = { }; -- Popups that appear on the screen containing queue information.

-- Friend's list tracking in active battlegrounds.
local _friendlist   = { };
local _friendasked  = false;
local _friendstring = "";

-- Indicates the addon was successfully loaded.
      _addon_loaded = false;
      _vars_loaded  = false;
local _titan_loaded = false;

-- Tracking variables.
local _blizzard_releasesoul    = false;
local _blizzard_interactbg     = false;
local _blizzard_manualshowbg   = nil; -- "SHOW": Show battlemap. "HIDE": Don't show battlemap.
local _titan_titanbg_leftclick = false;

-- Arathi Basin time until number of nodes required increases.
local _ab_timeinc_check = false;
local _ab_timeinc_sec    = 0;
local _ab_timeinc_update = 0;
local _ab_timeing_update_delay = 0.05;

-- #####################
-- ## EVENT FUNCTIONS ##
-- #####################


-- ## Events occuring when caught in game by the system.
function TitanPanelTitanBGButton_OnEvent(event, arg1)
	if (event == "ADDON_LOADED") then

		-- If the addon is being loaded for the first time, make sure sv_menu exists.
		if (sv_menu == nil) then sv_menu = {}; end

		if (sv_menu["ShowLabelText"] == nil) then sv_menu["ShowLabelText"]= true; end

		if (sv_menu["D_B_Spacers"] == nil)      then sv_menu["D_B_Spacers"]      = true; end
		if (sv_menu["D_B_Time"] == nil)         then sv_menu["D_B_Time"]         = true; end
		if (sv_menu["D_B_Kills"] == nil)        then sv_menu["D_B_Kills"]        = true; end
		if (sv_menu["D_B_KillingBlows"] == nil) then sv_menu["D_B_KillingBlows"] = true; end
		if (sv_menu["D_B_Deaths"] == nil)       then sv_menu["D_B_Deaths"]       = true; end
		if (sv_menu["D_B_Honor"] == nil)        then sv_menu["D_B_Honor"]        = true; end
		if (sv_menu["D_B_Standing"] == nil)     then sv_menu["D_B_Standing"]     = true; end
		if (sv_menu["D_B_Players"] == nil)      then sv_menu["D_B_Players"]      = true; end

		if (sv_menu["D_BG_SeperateActiveQueue"] == nil) then sv_menu["D_BG_SeperateActiveQueue"] = false; end
		if (sv_menu["D_TT_QueueTimers"] == nil)         then sv_menu["D_TT_QueueTimers"]         = true;  end
		if (sv_menu["D_B_QueueExpire"] == nil)          then sv_menu["D_B_QueueExpire"]          = true;  end
		if (sv_menu["D_TT_RememberOpenBgs"] == nil)     then sv_menu["D_TT_RememberOpenBgs"]     = false; end
		if (sv_menu["D_TT_ABWinEstimates"] == nil)      then sv_menu["D_TT_ABWinEstimates"]      = true;  end
		if (sv_menu["D_TT_PlayerStats"] == nil)         then sv_menu["D_TT_PlayerStats"]         = true;  end
		if (sv_menu["D_TT_LocationStats"] == nil)       then sv_menu["D_TT_LocationStats"]       = false; end
		if (sv_menu["D_TT_Friends"] == nil)             then sv_menu["D_TT_Friends"]             = false; end
		if (sv_menu["D_TT_Capture"] == nil)             then sv_menu["D_TT_Capture"]             = true;  end
		if (sv_menu["D_TT_FlagTracker"] == nil)         then sv_menu["D_TT_FlagTracker"]         = true;  end

		if (sv_menu["D_OS_PanelLock"] == nil) then sv_menu["D_OS_PanelLock"] = false; end

		if (sv_menu["D_OS_CaptureShow"] == nil)  then sv_menu["D_OS_CaptureShow"]  = true;  end
		if (sv_menu["D_NT_TimersInvert"] == nil) then sv_menu["D_NT_TimersInvert"] = false; end

		if (sv_menu["D_OS_WSG_Show"] == nil)        then sv_menu["D_OS_WSG_Show"]        = true;  end
		if (sv_menu["D_OS_WSG_Click"] == nil)       then sv_menu["D_OS_WSG_Click"]       = true;  end
		if (sv_menu["D_OS_WSG_ColorClass"] == nil)  then sv_menu["D_OS_WSG_ColorClass"]  = true;  end
		if (sv_menu["D_OS_WSG_TextClass"] == nil)   then sv_menu["D_OS_WSG_TextClass"]   = true;  end
		if (sv_menu["D_OS_WSG_Invert"] == nil)      then sv_menu["D_OS_WSG_Invert"]      = false; end
		if (sv_menu["D_OS_WSG_AttachScore"] == nil) then sv_menu["D_OS_WSG_AttachScore"] = false; end

		if (sv_menu["I_OverwriteOtherSettings"] == nil) then sv_menu["I_OverwriteOtherSettings"] = true;  end
		if (sv_menu["B_HideMinimapButton"] == nil)      then sv_menu["B_HideMinimapButton"]      = false; end
		if (sv_menu["D_S_Sound"] == nil)                then sv_menu["D_S_Sound"]                = false; end
		if (sv_menu["D_S_PlayWhatSound"] == nil)        then sv_menu["D_S_PlayWhatSound"]        = 1;     end
		if (sv_menu["D_S_RepeatSound"] == nil)          then sv_menu["D_S_RepeatSound"]          = false; end
		if (sv_menu["B_AutoShowBGMinimap"] == nil)      then sv_menu["B_AutoShowBGMinimap"]      = true;  end
		if (sv_menu["B_HideJoinPopup"] == nil)          then sv_menu["B_HideJoinPopup"]          = false; end
		if (sv_menu["B_AutoJoinBG"] == nil)             then sv_menu["B_AutoJoinBG"]             = false; end
		if (sv_menu["B_AutoLeaveBG"] == nil)            then sv_menu["B_AutoLeaveBG"]            = false; end
		if (sv_menu["B_AutoRelease"] == nil)            then sv_menu["B_AutoRelease"]            = false; end
		if (sv_menu["B_ReleaseCheck"] == nil)           then sv_menu["B_ReleaseCheck"]           = true; end
		if (sv_menu["B_ReplaceActive"] == nil)          then sv_menu["B_ReplaceActive"]          = true;  end

		if (sv_menu["D_POP_QueueExpire"] == nil) then sv_menu["D_POP_QueueExpire"] = true; end

		-- Indicate the addon has finished loading.
		_addon_loaded = true;

		-- Reset storage values.
		if (sv_menu["AddonEnabled"]) then
			TitanPanelTitanBG_ZonesChanged();
		end

	elseif (event == "VARIABLES_LOADED") then

		-- If the battlefield minimap hasn't been loaded, load it.
		if (not BattlefieldMinimap) then BattlefieldMinimap_LoadUI(); end

		TitanPanelTitanBG_StoreFunctions();
		TitanPanelTitanBG_HookFunctions();

		_vars_loaded = true;

	-- Store player information variables.
	elseif (event == "PLAYER_ENTERING_WORLD") then
		TitanPanelTitanBG_ResetPlayerInformation();

	elseif (event == "FRIENDLIST_UPDATE") then
		local nFriends = GetNumFriends();
		_friendlist = { };
		local indexf;
		for indexf=1, nFriends do
			local fname,_,_,_,_ = GetFriendInfo(indexf);
			_friendlist[fname] = 1;
		end

	-- ## Alliance message for Warsong Gulch.
	elseif (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" and _player_zone == TITANBG_BG_WSG) then
		_active.stats.wsg.alliance.msg = arg1;

	-- ## Horde message for Warsong Gulch.
	elseif (event == "CHAT_MSG_BG_SYSTEM_HORDE" and _player_zone == TITANBG_BG_WSG) then
		_active.stats.wsg.horde.msg = arg1;

	-- ## Hide join popup and minimap button.
	elseif (event == "UPDATE_BATTLEFIELD_STATUS" and sv_menu["AddonEnabled"]) then
		TitanPanelTitanBG_ToggleMiniMapIcon();
		TitanPanelTitanBG_HideBattlegroundReadyPopup();

	-- ## Actions taken the the user changes zones.
	elseif (event == "ZONE_CHANGED_NEW_AREA" and sv_menu["AddonEnabled"]) then
		TitanPanelTitanBG_ZonesChanged();

	-- If the user opens the battlefield queue window.
	elseif (event == "BATTLEFIELDS_SHOW" and sv_menu["AddonEnabled"]) then
		TitanPanelTitanBG_StoreActiveInstanceInformation();
	end
end


-- ## Performed periodically on shedule.
function TitanPanelTitanBGButton_CheckEvents()

	-- If the addon is being shown on titan panel, indicate such.
	if (not _titan_loaded and _vars_loaded and TitanPanelSettings) then
		_titan_loaded = true;

		-- Check if the addon is being displayed in Titan.
		if (TitanPanel_IsPluginShown(TITAN_TITANBG_ID)) then
			sv_menu["AddonEnabled"] = true;
		else
			sv_menu["AddonEnabled"] = false;
		end

		TitanPanelTitanBG_HookFunctions();
	end

	-- Update the stored battleground information.
	TitanPanelTitanBG_StoreBattlegroundInformation();

	-- Update non titan display of captures and flags.
	if (_addon_loaded and TitanPanelTitanBG_IsBattleground(_player_zone)) then
		TitanPanelTitanBG_NT_UpdateCaptures();
		TitanPanelTitanBG_NT_UpdateFlags();
	end

	-- Check if the battleground minimap needs to be shown.
	if (_addon_loaded) then
		TitanPanelTitanBG_ToggleBattlefieldMinimap();
		TitanPanelTitanBG_ChangeAttachFlagTracker();
	end
end


-- ## Performs periodic updates.
function TitanPanelTitanBG_OnUpdate()

	-- Check how much time the losing team has before they have to capture another node.
	if (_player_zone == TITANBG_BG_AB and _addon_loaded and sv_menu["AddonEnabled"]) then

		-- Checks the amount of time until the amount of nodes needing to be captured increases.
		-- Cannot be done as a basic loop as it can lock up the game.
		if (GetTime() - _ab_timeinc_update >= _ab_timeing_update_delay) then
			_ab_timeinc_update = GetTime();

			if (not _ab_timeinc_check) then
				 _ab_timeinc_sec   = 0;
				 _ab_timeinc_check = true;
			end

			_ab_timeinc_sec = _ab_timeinc_sec + 30;

			local winner, win_time = TitanPanelTitanBG_AB_GetWinner(_active.stats.ab.bases_alliance, _active.stats.ab.bases_horde);

			if (winner ~= nil) then
				local complete = false;

				-- If the player's faction isn't going to win.
				if (winner ~= UnitFactionGroup("player")) then
					local bases    = TitanPanelTitanBG_AB_NodesRequiredToWin(_player_faction);
					      complete = TitanPanelTitanBG_AB_TimeLeftToCapture(_player_faction, bases, _ab_timeinc_sec);

				-- Otherwise, if their faction is going to win.
				else
					local bases    = TitanPanelTitanBG_AB_NodesRequiredToWin(_player_enemy_faction);
					      complete = TitanPanelTitanBG_AB_TimeLeftToCapture(_player_enemy_faction, bases, _ab_timeinc_sec);
				end

				if (complete) then
					_ab_timeinc_check   = false;
					_timetonodeincrease = _ab_timeinc_sec;
				end

				if (win_time < _ab_timeinc_sec) then
					_ab_timeinc_check   = false;
					_timetonodeincrease = win_time;
				end
			end
		end
	end
end


-- ############################
-- ## BATTLEGROUND FUNCTIONS ##
-- ############################


-- ## Performed when the user changes zones.
function TitanPanelTitanBG_ZonesChanged()
	local zone = GetRealZoneText();

	if (zone ~= _player_zone) then
		_player_zone = zone;

		-- Reset any existing active battleground information.
		TitanPanelTitanBG_ResetActiveInformation();

		-- If this is a battleground.
		if (TitanPanelTitanBG_IsBattleground(_player_zone)) then

			-- Store any existing captures.
			_active.captures = { };
			TitanPanelTitanBG_CheckMap(_player_zone, true);

			_active_init_stored = true;

			_autojoin_bg     = "";
		    _autojoin_time   = 0;
		    _autojoin_paused = 0;

		    _autoleave_time   = 0;
		    _autoleave_paused = 0;
		end

		-- Reset basic battleground data.
		TitanPanelTitanBG_ResetBattlegroundInformation();

		-- Reset zone data.
		_blizzard_manualshowbg = nil;
		_display_queue_tt      = false;
		_ab_timeinc_check      = false;

		-- Check if the battleground minimap needs to be shown.
		if (_addon_loaded) then

			-- Hide and show items as necessary.
			TitanPanelTitanBG_ToggleLockCaptures();
			TitanPanelTitanBG_ToggleMiniMapIcon();
			TitanPanelTitanBG_HideBattlegroundReadyPopup();
			TitanPanelTitanBG_ToggleClickFlagRunner();
			TitanPanelTitanBG_InvertFlagTracker();

			-- Update non titan display of captures and flags.
			TitanPanelTitanBG_NT_UpdateCaptures(true);
			TitanPanelTitanBG_NT_UpdateFlags();
		end
	end
end


-- ## Determines if a given zone is a battleground.
function TitanPanelTitanBG_IsBattleground(zone)
	if (zone == TITANBG_BG_AV or zone == TITANBG_BG_AB or zone == TITANBG_BG_WSG) then
		return true;
	else
		return false;
	end
end


-- ## Stores information on a battleground and performs any actions based on this information that require periodic checks.
function TitanPanelTitanBG_StoreBattlegroundInformation()
	if (_update_number > 1000) then _update_number = 0; end

	_bgs.queue = 0;

	-- Perform battlefield actions.
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status, name, instance = GetBattlefieldStatus(i);

		-- If this battleground is active, collect information on this battleground.
		if (status == TITANBG_BG_STATUS_ACTIVE) then

			-- Update friend information.
			if (not _friendasked) then
				ShowFriends();
				_friendasked = true;
			end

			if (GetBattlefieldWinner() ~= nil) then

				-- If a battleground is finished, get ready to leave it.
				if (sv_menu["B_AutoLeaveBG"] and _autoleave_time == 0) then
					_autoleave_time   = GetTime() + _autoleave_delay;
				    _autoleave_paused = 0;
				end

				-- If paused, update timer.
				if (_autoleave_paused > 0 and sv_menu["B_AutoLeaveBG"]) then
					_autoleave_time = _autoleave_paused + GetTime();
				end

				-- Auto leave a battleground if complete.
				if (TitanPanelTitanBG_IsBattleground(_player_zone) and sv_menu["B_AutoLeaveBG"] and math.floor(_autoleave_time - GetTime()) <= 0) then
					TitanPanelTitanBG_AcceptBattlefieldPort(i, nil, true);
					_autoleave_time   = 0;
				    _autoleave_paused = 0;
				end
			end

			TitanPanelTitanBG_StoreActiveInformation(name, status, instance, i);

		-- Otherwise, if this battleground is waiting for confirmation, perform auto join.
		elseif (status == TITANBG_BG_STATUS_CONFIRM) then

			-- If a battleground is ready for confirmation, start the auto join timer.
			if (sv_menu["B_AutoJoinBG"] and (_autojoin_bg == "" or _autojoin_bg == nil)) then
				_autojoin_bg     = name;
				_autojoin_time   = GetTime() + _autojoin_delay;
			    _autojoin_paused = 0;
			end

			-- If paused, update timer.
			if (_autojoin_paused > 0 and sv_menu["B_AutoJoinBG"]) then
				_autojoin_time = _autojoin_paused + GetTime();
			end

			-- Auto join a battleground if not already in a battleground.
			if (not TitanPanelTitanBG_IsBattleground(_player_zone) and _autojoin_bg == name and math.floor(_autojoin_time - GetTime()) <= 0) then
				TitanPanelTitanBG_AutoJoinBattleground(i);
			end
		end

		-- If this is a battleground, store status infromation.
		if (TitanPanelTitanBG_IsBattleground(name)) then
			if (status == TITANBG_BG_STATUS_QUEUED or status == TITANBG_BG_STATUS_CONFIRM) then
				_bgs.queue = _bgs.queue + 1;
			end

			-- Check if a new sound needs to be played.
			if (_bgs.names[name].status ~= status and status == TITANBG_BG_STATUS_CONFIRM) then
				_bgs.names[name].sound       = true;
				_bgs.names[name].sound_timer = 0;

			elseif (status ~= TITANBG_BG_STATUS_CONFIRM) then
				_bgs.names[name].sound       = false;
				_bgs.names[name].sound_timer = 0;
			end

			-- Play a new sound for this battleground.
			if (_bgs.names[name].sound and sv_menu["D_S_PlayWhatSound"] > 0) then
				local PlayReadySound = function()
					if (sv_menu["D_S_PlayWhatSound"] == 1) then
						PlaySound("PVPTHROUGHQUEUE", true);
					else
						PlaySoundFile(TITANBG_SOUNDS_BGWARNING[sv_menu["D_S_PlayWhatSound"]].file);
					end
				end

				-- If repeat the sound periodically.
				if (sv_menu["D_S_RepeatSound"]) then
					if (GetTime() - _bgs.names[name].sound_timer >= _bgready_sound_delay) then
						_bgs.names[name].sound_timer = GetTime();

						PlayReadySound();
					end
				else
					PlayReadySound();
					_bgs.names[name].sound = false;
				end
			end

			_bgs.names[name].index    = i;
			_bgs.names[name].status   = status;
			_bgs.names[name].instance = instance;
			_bgs.names[name].update   = _update_number;

			if (status == TITANBG_BG_STATUS_CONFIRM) then
				_bgs.names[name].expires = GetBattlefieldPortExpiration(i) / 1000;
			else
				_bgs.names[name].expires = 0;
			end

			_bgs.blizzard[i] = name;

		-- Otherwise, this slot is not being used by blizzard.
		else
			if (_bgs.blizzard[i]) then
				_bgs.blizzard[i] = nil;
			end
		end
	end

	-- Reset all the battlegrounds that were not updated.
	for i = 1, table.getn(_bgs.index) do
		if (_bgs.names[_bgs.index[i]].update ~= _update_number) then
			_bgs.names[_bgs.index[i]].index       = 0;
			_bgs.names[_bgs.index[i]].status      = TITANBG_BG_STATUS_NONE;
			_bgs.names[_bgs.index[i]].instance    = 0;

			_bgs.names[_bgs.index[i]].update      = nil;
			_bgs.names[_bgs.index[i]].expires     = 0;

			_bgs.names[_bgs.index[i]].sound       = false;
			_bgs.names[_bgs.index[i]].sound_timer = 0;

			if (_autojoin_bg == _bgs.index[i]) then
				_autojoin_bg     = "";
				_autojoin_time   = 0;
				_autojoin_paused = 0;
			end
		end
	end

	local i = 1;

	-- Process battleround popups.
	if (_titan_loaded and _addon_loaded and not sv_menu["B_HideJoinPopup"]) then
		while (i <= table.getn(_popups)) do

			if ((_popups[i].dialog.text_arg1 == _popups[i].text_arg1 and _popups[i].dialog.text_arg2 == _popups[i].text_arg2) and _popups[i].which == "CONFIRM_BATTLEFIELD_ENTRY" and (_bgs.blizzard[_popups[i].data] and _bgs.names[_bgs.blizzard[_popups[i].data]].status == TITANBG_BG_STATUS_CONFIRM)) then
				local expire = "";

				-- Check if the queue expire time is to be shown.
				if (sv_menu["D_POP_QueueExpire"]) then
					expire = " (" .. TITANBG_COLOR_RED .. SecondsToTime(GetBattlefieldPortExpiration(_popups[i].data) / 1000) .. TITANBG_COLOR_GREEN .. ")";
				end

				-- If the user is not already in a battleground and is autojoining.
				if (TitanPanelTitanBG_IsBattleground(_player_zone) == false and sv_menu["B_AutoJoinBG"] and _autojoin_time > GetTime() and string.find(_popups[i].text_arg1, _autojoin_bg)) then
					local autojoin = SecondsToTime(_autojoin_time - GetTime());

					if (_autojoin_paused > 0) then
						autojoin = autojoin .. TITANBG_COLOR_WHITE .. "(" .. TITANBG_TOOLTIP_PAUSED .. ")";
						getglobal(_popups[i].dialog:GetName().."Button2"):SetText(TITANBG_TOOLTIP_UNPAUSE);
					else
						getglobal(_popups[i].dialog:GetName().."Button2"):SetText(KEY_PAUSE);
					end

					_popups[i].text:SetText(TITANBG_COLOR_GREEN .. string.gsub(string.gsub(TITANBG_AUTOJOIN, "{bg}", TITANBG_COLOR_WHITE .. _popups[i].text_arg1 .. TITANBG_COLOR_GREEN, 1), "{time}", TITANBG_COLOR_YELLOW .. autojoin .. TITANBG_COLOR_GREEN .. expire, 1));

				-- If the user is in a battleground or is not autojoining.
				else
					_popups[i].text:SetText(TITANBG_COLOR_GREEN .. string.gsub(string.gsub(TITANBG_CONFIRMJOIN, "{bg}", TITANBG_COLOR_WHITE .. _popups[i].text_arg1 .. TITANBG_COLOR_GREEN, 1), "{time}", TITANBG_COLOR_GREEN .. expire, 1));
				end
			else
				table.remove(_popups, i);
				i = i - 1;
			end

			i = i + 1;
		end
	end

	_update_number = _update_number + 1;
end


-- ## Stores information about the instances that were active when a user looked at the queue window.
function TitanPanelTitanBG_StoreActiveInstanceInformation()
	local name, _, _, _, _, _, _, _, _ = GetBattlefieldInfo();
	local instances                    = GetNumBattlefields();
	local bg                           = _bgs.names[name];

	if (bg ~= nil) then
		bg.open_instances = instances;
		bg.open_age       = GetTime();
	end
end


-- ## Indicates if the person is currently in a battleground queue or in a battleground.
function TitanPanelTitanBG_InBGQueue()
	local in_queue = false;

	-- Loop through and check on the status of the battlegrounds.
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status, _, _ = GetBattlefieldStatus(i);

		-- If the user is in a queue or in a battleground.
		if (status ~= TITANBG_BG_STATUS_NONE) then

			in_queue = true;
			break;
		end
	end

	return in_queue;
end


-- ## Collects information on a specified battleground.
function TitanPanelTitanBG_StoreActiveInformation(bg_name, bg_status, bg_instance, bg_i)

	-- Request new data for GetBattlefieldScore().
	RequestBattlefieldScoreData();

	-- Run checks on the battlefield map information.
	if (_active_init_stored) then
		TitanPanelTitanBG_CheckMap(bg_name, false);
	end

	-- Clear the friend's list string.
	_friendstring = "";

	_active.stats.bg.name     = bg_name;
	_active.stats.bg.index    = bg_i;
	_active.stats.bg.instance = bg_instance;
	_active.stats.bg.run      = GetBattlefieldInstanceRunTime();
	_active.stats.bg.total    = 0;
	_active.stats.bg.horde    = 0;
	_active.stats.bg.alliance = 0;

	-- Loop through all the players.
	for i = 1, 80 do
		local name, killingblows, kills, deaths, honor, faction, rank, race, class = GetBattlefieldScore(i);

		local player_id   = "";
		local player_name = "";
		local server      = "";

		if (name ~= nil) then
			_active.stats.bg.total = _active.stats.bg.total + 1;

			if (string.find(name, "-")) then
				server      = string.sub(name, string.find(name, "-") + 1, string.len(name));
				player_name = string.sub(name, 1, string.find(name, "-") - 1);
			else
				player_name = name;
				server      = _player_realm;
			end

			if (faction == 0) then
				_active.stats.bg.horde = _active.stats.bg.horde + 1;
				player_id              = player_name .. "|Horde";
			else
				_active.stats.bg.alliance = _active.stats.bg.alliance + 1;
				player_id                 = player_name .. "|Alliance";
			end

			local player = TitanBG_GetPlayerData(player_id);

			-- Store the player information.
			if (not player and player_name ~= "" and player_name ~= nil) then
				player = { id      = player_id,
					       name    = player_name,
						   server  = server,
						   faction = faction,
					       class   = class,
					       rank    = rank, };

				table.insert(_active.stats.wsg.players, player);
			end
		end

		-- If this is the current player.
		if (player_name == _player_name) then

			_active.stats.player.standing      = i;
			_active.stats.player.kills         = kills;
			_active.stats.player.deaths        = deaths;
			_active.stats.player.killing_blows = killingblows;
			_active.stats.player.honor         = honor;

		-- Create the friend's list string.
		elseif ( _friendlist[name] and sv_menu["D_TT_Friends"] ) then
			_friendstring = _friendstring.."\n"..name.."\t";
			_friendstring = _friendstring..TitanUtils_GetHighlightText("#: ")..TitanUtils_GetGreenText(i)..", ";
			_friendstring = _friendstring..TitanUtils_GetHighlightText(TITANBG_S_KILLINGBLOWS)..TitanUtils_GetGreenText(killingblows)..", ";
			_friendstring = _friendstring..TitanUtils_GetHighlightText(TITANBG_S_KILLS)..TitanUtils_GetGreenText(kills)..", ";
			_friendstring = _friendstring..TitanUtils_GetHighlightText(TITANBG_S_DEATHS)..TitanUtils_GetRedText(deaths);
		end
	end

	-- How many battleground statistics are there.
	local sColumns = GetNumBattlefieldStats();

	-- Loop through the statistics.
	for j = 1, MAX_NUM_STAT_COLUMNS do

		if (j <= sColumns) then
			local cData = GetBattlefieldStatData(_active.stats.player.standing, j);

			-- Collect player capture stats on Alterac Valley.
			if (bg_name == TITANBG_BG_AV) then

				if (j == 1) then
					_active.stats.av.gy_assulted      = cData;
				elseif (j == 2) then
					_active.stats.av.gy_defended      = cData;
				elseif (j == 3) then
					_active.stats.av.towers_assaulted = cData;
				elseif (j == 4) then
					_active.stats.av.towers_defended  = cData;
				elseif (j == 5) then
					_active.stats.av.mines_captured   = cData;
				elseif (j == 6) then
					_active.stats.av.leaders_killed   = cData;
				elseif (j == 7) then
					_active.stats.av.secondary_obj    = cData;
				end

			-- Collect player capture stats on Warsong Gulch.
			elseif (name == TITANBG_BG_WSG) then

				if (j == 1) then
					_active.stats.wsg.flag_captures = cData;
				elseif (j == 2) then
					_active.stats.wsg.flag_returns  = cData;
				end

			-- Collect player capture stats on Arathi Basin.
			elseif (name == TITANBG_BG_AB) then

				if (j == 1) then
					_active.stats.ab.bases_assulted = cData;
				elseif (j == 2) then
					_active.stats.ab.bases_defended = cData;
				end
			end
		end
	end
end


-- ## Returns data on a player in the battleground.
-- ##
-- ## Variables
-- ##     * id: Is the player 'name|faction'. For example, 'Maina|Alliance'.
function TitanBG_GetPlayerData(id)
	for i = 1, table.getn(_active.stats.wsg.players) do
		if (_active.stats.wsg.players[i].id == id) then
			return _active.stats.wsg.players[i];
		end
	end

	return nil;
end


-- ## Checks on the location in the battleground and their capture status.
function TitanPanelTitanBG_CheckMap(bg_name, just_entered)
	local marks = GetNumMapLandmarks();
	local delay = 0;

	-- Reset base owned tracking variables.
	_active.stats.ab.bases_alliance = 0;
	_active.stats.ab.bases_horde    = 0;

	-- If this is a cap on enter, reset capture information.
	if (just_entered) then
		_active.captures = { };
	end

	-- Determine delay based on battleground.
	if (bg_name == TITANBG_BG_AV) then
		delay = _capture_delay_av;
	elseif (bg_name == TITANBG_BG_AB) then
		delay = _capture_delay_ab;
	end

	for i = 1, marks, 1 do
		local name, _, txture, _, _ = GetMapLandmarkInfo(i);
		local owned                 = TitanPanelTitanBG_OwnedBy(txture);

		-- Determine who this item is owned by and if we are in ab, increase the count for that faction.
		if (bg_name == TITANBG_BG_AB) then
			if (owned == "Alliance") then
				_active.stats.ab.bases_alliance = _active.stats.ab.bases_alliance + 1;
			elseif (owned == "Horde") then
				_active.stats.ab.bases_horde = _active.stats.ab.bases_horde + 1;
			end
		end

		-- Set up the local capture information.
		local c = {
			name         = "",    -- What is the name of this item.
			cap          = 0,     -- Time when the point will be capped. If zero, capped on enter.
			who          = "",    -- Who the point will be capped by.
			t            = 15,    -- The texture of the cap.
		};

		-- Store data.
		c.name = name;
		c.who  = TitanPanelTitanBG_CappedBy(txture);
		c.t    = txture;

		-- Location of the capture in the capture's list.
		local loc = -1;

		-- Loop through and find the capture if it is in the list.
		if (table.getn(_active.captures) > 0) then
			for j = 1, table.getn(_active.captures) do

				if (_active.captures[j].name == c.name) then
					loc = j;
					break;
				end
			end
		end

		-- If this is a new item being contested, store data.
		if (loc == -1 and c.who ~= "") then

			-- If the time capped is known, store the time to cap.
			if (not just_entered) then
				c.cap = GetTime() + delay;
			end

			table.insert(_active.captures, c);

		-- Otherwise, remove any item not contested.
		elseif (loc > -1 and (c.who == "" or (c.who ~= "" and _active.captures[loc].who ~= c.who))) then
			table.remove(_active.captures, loc);
		end
	end

	-- If this is Warsong Gulch, collect flag information.
	if (_player_zone == TITANBG_BG_WSG) then
		_active.stats.wsg.alliance.flag = GetWorldStateUIInfo(1);
		_active.stats.wsg.horde.flag    = GetWorldStateUIInfo(2);

		-- Collect alliance flag information.
		if (_active.stats.wsg.alliance.msg ~= "") then

			-- Flag picked up. The faction the message is for is the same as the faction of the player carrying the flag.
			-- "The Horde flag was picked up by Maina!".
			if (string.find(_active.stats.wsg.alliance.msg, TITANBG_WSG_PICKEDUP)) then
				_active.stats.wsg.alliance.msg    = string.gsub(_active.stats.wsg.alliance.msg, TITANBG_WSG_PICKEDUP, "");
				_active.stats.wsg.alliance.player = string.sub(_active.stats.wsg.alliance.msg, string.find(_active.stats.wsg.alliance.msg, "([^%p^%s]+)"));

			-- Flag dropped. The faction the message is for is the faction that owns the flag. The player dropping the flag is the enemy.
			-- "The Alliance flag was dropped by Maina!".
			elseif (string.find(_active.stats.wsg.alliance.msg, TITANBG_WSG_DROPPED)) then
				_active.stats.wsg.horde.player = "";

			-- Flag captured. The faction the message is for is the same as the faction of the player carrying the flag.
			-- "Maina captured the Horde flag!".
			elseif (string.find(_active.stats.wsg.alliance.msg, TITANBG_WSG_CAPTURED)) then
				_active.stats.wsg.alliance.player = "";
			end

			_active.stats.wsg.alliance.msg = "";
		end

		-- Collect horde flag information.
		if (_active.stats.wsg.horde.msg ~= "") then

			-- Flag picked up. The faction the message is for is the same as the faction of the player carrying the flag.
			-- "The Alliance flag was picked up by Maina!".
			if (string.find(_active.stats.wsg.horde.msg, TITANBG_WSG_PICKEDUP)) then
				_active.stats.wsg.horde.msg = string.gsub(_active.stats.wsg.horde.msg, TITANBG_WSG_PICKEDUP, "");
				_active.stats.wsg.horde.player = string.sub(_active.stats.wsg.horde.msg, string.find(_active.stats.wsg.horde.msg, "([^%p^%s]+)"));

			-- Flag dropped. The faction the message is for is the faction that owns the flag. The player dropping the flag is the enemy.
			-- "The Horde flag was dropped by Maina!".
			elseif (string.find(_active.stats.wsg.horde.msg, TITANBG_WSG_DROPPED)) then
				_active.stats.wsg.alliance.player = "";

			-- Flag captured. The faction the message is for is the same as the faction of the player carrying the flag.
			-- "Maina captured the Alliance flag!".
			elseif (string.find(_active.stats.wsg.horde.msg, TITANBG_WSG_CAPTURED)) then
				_active.stats.wsg.horde.player = "";
			end

			_active.stats.wsg.horde.msg = "";
		end
	end
end


-- TEXTURE KEY (Alterac Valley)
--
-- Mine
--     0: None
--     1: Horde
--     2: Alliance
--
-- Graveyard
--      7: Free
--     12: Horde
--      3: Contested (Horde, Assulted by the Alliance)
--     14: Alliance
--     13: Contested (Alliance, Assulted by the Horde)
--
-- Tower
--      9: Horde
--      8: Contested (Horde, Assulted by the Alliance)
--     10: Alliance
--     11: Contested (Alliance, Assulted by the Horde)

-- TEXTURE KEY (Arathi Basin)
--
-- Lumber Mill
--     21: None
--     25: Horde
--     22: Contested (Horde, Assulted by the Alliance)
--     23: Alliance
--     24: Contested (Alliance, Assulted by the Horde)
--
-- Mine
--     16: None
--     20: Horde
--     17: Contested (Horde, Assulted by the Alliance)
--     18: Alliance
--     19: Contested (Alliance, Assulted by the Horde)
--
-- Blacksmith
--     26: None
--     30: Horde
--     27: Contested (Horde, Assulted by the Alliance)
--     28: Alliance
--     29: Contested (Alliance, Assulted by the Horde)
--
-- Farm
--     31: None
--     35: Horde
--     32: Contested (Horde, Assulted by the Alliance)
--     33: Alliance
--     34: Contested (Alliance, Assulted by the Horde)
--
-- Stables
--     36: None
--     40: Horde
--     37: Contested (Horde, Assulted by the Alliance)
--     38: Alliance
--     39: Contested (Alliance, Assulted by the Horde)


-- ## Determines who the point will be capped by. If not under contestation, return a zero length string.
function TitanPanelTitanBG_CappedBy(t)
	local capped = "";

	if (t == 3 or t == 8 or t == 22 or t == 17 or t == 27 or t == 32 or t == 37) then
		capped = "Alliance";
	elseif (t == 13 or t == 11 or t == 24 or t == 19 or t == 29 or t == 34 or t == 39) then
		capped = "Horde";
	end

	return capped;
end


-- ## Determines who owns the point, if it is not under contestation. Otherwise, returns a zero length string.
function TitanPanelTitanBG_OwnedBy(t)
	local owned = "";

	if (t == 2 or t == 14 or t == 10 or t == 23 or t == 18 or t == 28 or t == 33 or t == 38) then
		owned = "Alliance";
	elseif (t == 1 or t == 12 or t == 9 or t == 25 or t == 20 or t == 30 or t == 35 or t == 40) then
		owned = "Horde";
	end

	return owned;
end


-- ## Automatically joins a battleground.
function TitanPanelTitanBG_AutoJoinBattleground(i)
	if (sv_menu["B_AutoJoinBG"]) then
		TitanPanelTitanBG_AcceptBattlefieldPort(i, 1, true);
		_autojoin_bg   = "";
		_autojoin_time = 0;
	end
end


-- ## Determines who is likely to win the Arathi Basin game.
-- ##
-- ## Variables
-- ##     * b_alliance: Number of bases held by the Alliance.
-- ##     *    b_horde: Number of bases held by the Horde.
-- ##     *    a_extra: Extra resources to add to the alliance side when performing a future prediction check.
-- ##     *    h_extra: Extra resources to add to the horde side when performing a future prediction check.
-- ##
-- ## Returns
-- ##     * The team that will win. Nil/"Horde"/"Alliance".
-- ##     * The amount of time it will take them to win. Nil/time in seconds.
-- ##     * Final score held by the Alliance.
-- ##     * Final score held by the Horde.
function TitanPanelTitanBG_AB_GetWinner(b_alliance, b_horde, a_extra, h_extra)

	-- Get the amount of resources held by the teams.
	local a_resources, h_resources = TitanPanelTitanBG_AB_GetResources();

--	-- If we are checking possible future scenarios, add the extra resources.
	if (a_extra ~= nil and h_extra ~= nil) then
		a_resources = a_resources + a_extra;
		h_resources = h_resources + h_extra;
	end

	-- Get the amount of resources per second.
	local a_res_sec = TitanPanelTitanBG_AB_GetResourcesPerSecond(b_alliance);
	local h_res_sec = TitanPanelTitanBG_AB_GetResourcesPerSecond(b_horde);

	-- The amount of time left until the team gathers 2000 resources.
	local a_timeleft = -1;
	local h_timeleft = -1;

	-- Catch division by zero exceptions.
	if (a_res_sec > 0) then
		a_timeleft = (2000 - a_resources) / a_res_sec;
	end

	if (h_res_sec > 0) then
		h_timeleft = (2000 - h_resources) / h_res_sec;
	end

	-- Determine final scores at the end.
	local a_final = a_resources;
	local h_final = h_resources;

	if (a_res_sec > 0) then
		a_final = math.floor((a_final + (math.floor(h_timeleft / 30) * (a_res_sec * 30))) / 10) * 10;
	end

	if (h_res_sec > 0) then
		h_final = math.floor((h_final + (math.floor(a_timeleft / 30) * (h_res_sec * 30))) / 10) * 10;
	end

	-- Unknown who will win.
	if (a_timeleft == -1 and h_timeleft == -1) then
		return nil, nil, nil, nil;

	-- Alliance will win.
	elseif ((a_timeleft > -1 and a_timeleft < h_timeleft) or (a_timeleft > -1 and h_timeleft == -1)) then
		return "Alliance", a_timeleft, 2000, h_final;

	-- Horde will win.
	elseif ((h_timeleft > -1 and h_timeleft < a_timeleft) or (h_timeleft > -1 and a_timeleft == -1)) then
		return "Horde", h_timeleft, a_final, 2000;
	end

	-- Otherwise return unknown.
	return nil, nil, nil, nil;
end


-- ## Determines how many resources per second a team gets with the amount of bases they're holding.
function TitanPanelTitanBG_AB_GetResourcesPerSecond(bases)
	if (bases == 1) then
		return (25.0 / 30.0);
	elseif (bases == 2) then
		return (300.0 / 9.0) / 30.0;
	elseif (bases == 3) then
		return 50.0  / 30.0;
	elseif (bases == 4) then
		return 100.0 / 30.0;
	elseif (bases == 5) then
		return 900.0 / 30.0;
	else
		return 0;
	end
end

-- ## Gets the current resources for both factions.
function TitanPanelTitanBG_AB_GetResources()
	local a_resources = 0;
	local h_resources = 0;

	-- Get the amount of resources owned by each team.
	local _, a_text, _, _, _, _ = GetWorldStateUIInfo(1);
	local _, h_text, _, _, _, _ = GetWorldStateUIInfo(2);

	-- Extract the resources.
	if (a_text and h_text and _player_zone == TITANBG_BG_AB and string.find(a_text, TITANBG_AB_RESOURCES_DP) and string.find(h_text, TITANBG_AB_RESOURCES_DP)) then
		a_resources = string.sub(a_text, string.find(a_text, TITANBG_AB_RESOURCES_DP) + 11, string.find(a_text, "/") - 1);
		h_resources = string.sub(h_text, string.find(h_text, TITANBG_AB_RESOURCES_DP) + 11, string.find(h_text, "/") - 1);
	end

	return a_resources, h_resources;
end


-- ## Determines how many nodes are required to win.
-- ##
-- ## Returns
-- ##     * TITANBG_AB_IMPOSSIBLE: If not possible to win.
-- ##                          OR: Number of nodes required to win.
function TitanPanelTitanBG_AB_NodesRequiredToWin(faction, a_resources, h_resources)
	local nodes = TITANBG_AB_IMPOSSIBLE;
	local bases = 0;

	-- Determine which faction we are checking is.
	if (faction == TITANBG_ALLIANCE) then
		bases = _active.stats.ab.bases_alliance;
	else
		bases = _active.stats.ab.bases_horde;
	end

	-- Try different base numbers.
	for i = 1, (5 - bases) do
		local winner = nil;

		if (faction == TITANBG_ALLIANCE) then
			winner = TitanPanelTitanBG_AB_GetWinner(bases + i, _active.stats.ab.bases_horde - i, a_resources, h_resources);
		else
			winner = TitanPanelTitanBG_AB_GetWinner(_active.stats.ab.bases_alliance - i, bases + i, a_resouces, h_resources);
		end

		-- If the winner is the faction, then stop.
		if (winner == faction) then
			nodes = i;
			break;
		end
	end

	return nodes;
end

-- ## Determines how long it will take until the amount of nodes needing to be captured in order to win increases.
-- ##
-- ## Variables
-- ##     * faction: The faction we are checking.
-- ##     * initial: The number of nodes that need to be captured by the faction in order to win.
function TitanPanelTitanBG_AB_TimeLeftToCapture(faction, initial, seconds)
	local nodes       = nil;
	local complete    = false;

	local a_resources = 0;
	local h_resources = 0;

	-- Get the amount of resources per second.
	local a_res_sec = TitanPanelTitanBG_AB_GetResourcesPerSecond(_active.stats.ab.bases_alliance);
	local h_res_sec = TitanPanelTitanBG_AB_GetResourcesPerSecond(_active.stats.ab.bases_horde);

	-- Get the amount of resources produced in this time period.
	a_resources = a_res_sec * seconds;
	h_resources = h_res_sec * seconds;

	-- Check the amount of nodes
	nodes = TitanPanelTitanBG_AB_NodesRequiredToWin(faction, a_resources, h_resources);

	if (nodes ~= initial) then
		complete = true;
	end

	return complete;
end


-- ######################
-- ## ACTION FUNCTIONS ##
-- ######################


-- ## Events that occur when the user clicks on the addon.
function TitanPanelTitanBGButton_OnClick(button)
	if (button == "LeftButton") then

		-- Check on auto join pauses.
		if (not TitanPanelTitanBG_IsBattleground(_player_zone)) then

			-- If the user want to pause the auto join timer.
			if (sv_menu["B_AutoJoinBG"] and _autojoin_paused == 0) then
				_autojoin_paused = _autojoin_time - GetTime();

			-- If the user wants to unpause the auto join timer.
			elseif (sv_menu["B_AutoJoinBG"] and _autojoin_paused > 0) then
				_autojoin_paused = 0;
			end

		-- Check on auto leave pauses.
		elseif (GetBattlefieldWinner() ~= nil) then

			-- If the user want to pause the auto leave timer.
			if (sv_menu["B_AutoLeaveBG"] and _autoleave_paused == 0) then
				_autoleave_paused = _autoleave_time - GetTime();

			-- If the user wants to unpause the auto leave timer.
			elseif (sv_menu["B_AutoLeaveBG"] and _autoleave_paused > 0) then
				_autoleave_paused = 0;
			end
		end

		-- Show the battlemap.
		if (IsShiftKeyDown() and not IsControlKeyDown()) then
			if ((sv_menu["B_AutoShowBGMinimap"] and BattlefieldMinimap:IsShown()) or (not TitanPanelTitanBG_IsBattleground(_player_zone) and BattlefieldMinimap:IsShown())) then
				_blizzard_manualshowbg = "HIDE";
			elseif ((not sv_menu["B_AutoShowBGMinimap"] and not BattlefieldMinimap:IsShown()) or (not TitanPanelTitanBG_IsBattleground(_player_zone) and not BattlefieldMinimap:IsShown())) then
				_blizzard_manualshowbg = "SHOW";
			else
				_blizzard_manualshowbg = nil;
			end

			TitanPanelTitanBG_ToggleBattlefieldMinimap();
		end

		-- If the user is in a battleground.
		if (TitanPanelTitanBG_IsBattleground(_player_zone) and (GetBattlefieldWinner() == nil or not WorldStateScoreFrame:IsVisible()) and not IsControlKeyDown() and not IsShiftKeyDown()) then
			ToggleWorldStateScoreFrame();
		end

		_titan_titanbg_leftclick = true;
	end
end


-- ## Toggles a specified variable in the menu.
function TitanPanelTitanBGButton_ToggleVar()
	TitanToggleVar(TITAN_TITANBG_ID, this.value);
	TitanPanelButton_UpdateButton(TITAN_TITANBG_ID);
end


-- ## Releases a player's corpse.
function TitanPanelTitanBG_RepopMe()
	if ((sv_menu["B_AutoRelease"] and TitanPanelTitanBG_IsBattleground(_player_zone) and UnitIsDeadOrGhost("player")) or _blizzard_releasesoul) then
		if ((sv_menu["B_ReleaseCheck"] and not HasSoulstone()) or not sv_menu["B_ReleaseCheck"]) then
			Hook_RepopMe();
		end
	end
end


-- ## Ports a user into the battleground, or leaves the queue.
function TitanPanelTitanBG_AcceptBattlefieldPort(index, accept, titanbg)

	-- Check if called by a blizzard drop down menu functions.
	if (this.arg1) then
		index   = this.arg1;
		accept  = this.arg2;
		titanbg = true;
	end

	-- If called by a Blizzard or a TitanBG function, then perform this action.
	if (_blizzard_interactbg or titanbg) then
		TitanPanelRightClickMenu_Close();
		Hook_AcceptBattlefieldPort(index, accept);
	end
end


-- ## Toggles the locking of the capture timers on the screen.
function TitanPanelTitanBG_ToggleLockCaptures()

	-- Lock the on screen capture timers.
	if (sv_menu["D_OS_PanelLock"] or not sv_menu["AddonEnabled"]) then
		TitanPanelTitanBG_Display_Capture:Hide();

	-- Unlock the on screen capture timers.
	else
		TitanPanelTitanBG_Display_Capture:Show();
	end
end


-- ## Hides or shows the battleground mini map button.
function TitanPanelTitanBG_ToggleMiniMapIcon()

	-- Hide the mini map button if the user wants it hidden.
	if ((sv_menu["B_HideMinimapButton"] and TitanPanelTitanBG_InBGQueue() and sv_menu["AddonEnabled"]) or (not sv_menu["AddonEnabled"] and not TitanPanelTitanBG_InBGQueue())) then
		MiniMapBattlefieldFrame:Hide();
	elseif (TitanPanelTitanBG_InBGQueue()) then
		MiniMapBattlefieldFrame:Show();
	end
end


-- ## Hides or shows the battleground minimap.
function TitanPanelTitanBG_ToggleBattlefieldMinimap()

	-- If this is a battleground or a world pvp area, determine if the battlemap needs to be shown or hidden.
	if (sv_menu["AddonEnabled"]) then
		local showmap = sv_menu["B_AutoShowBGMinimap"];

		-- Check if the user has changed the settings for this zone manually.
		if (_blizzard_manualshowbg) then
			if (_blizzard_manualshowbg == "SHOW") then
				showmap = true;
			elseif (_blizzard_manualshowbg == "HIDE") then
				showmap = false;
			end
		end

		-- If the battlefield minimap hasn't been loaded, load it.
		if (not BattlefieldMinimap) then BattlefieldMinimap_LoadUI(); end

		-- If we want to show the battlemap.
		if (showmap and not BattlefieldMinimap:IsShown() and sv_menu["AddonEnabled"] and (TitanPanelTitanBG_IsBattleground(_player_zone) or (not TitanPanelTitanBG_IsBattleground(_player_zone) and _blizzard_manualshowbg ~= nil))) then
			BattlefieldMinimap:Show();

		-- If we want to hide the battlemap.
		elseif ((not showmap and BattlefieldMinimap:IsShown()) or (not TitanPanelTitanBG_IsBattleground(_player_zone) and _blizzard_manualshowbg == nil)) then
			if (BattlefieldMinimap) then
				BattlefieldMinimap:Hide();
			end
		end
	end
end


-- ## Enables and disables click targetting of the flag runner.
function TitanPanelTitanBG_ToggleClickFlagRunner()
	if (sv_menu["D_OS_WSG_Click"]) then
		TitanPanelTitanBG_Display_Flag_1:EnableMouse(true);
		TitanPanelTitanBG_Display_Flag_2:EnableMouse(true);

		TitanPanelTitanBG_Display_Flag_1_Button:EnableMouse(true);
		TitanPanelTitanBG_Display_Flag_2_Button:EnableMouse(true);
	else
		TitanPanelTitanBG_Display_Flag_1:EnableMouse(false);
		TitanPanelTitanBG_Display_Flag_2:EnableMouse(false);

		TitanPanelTitanBG_Display_Flag_1_Button:EnableMouse(false);
		TitanPanelTitanBG_Display_Flag_2_Button:EnableMouse(false);
	end
end

-- Changes the attachment points of the flag tracker.
function TitanPanelTitanBG_InvertFlagTracker()
	if (not sv_menu["D_OS_WSG_Invert"]) then
		TitanPanelTitanBG_Display_Flag_1:ClearAllPoints();
		TitanPanelTitanBG_Display_Flag_2:ClearAllPoints();

		TitanPanelTitanBG_Display_Flag_1:SetPoint("TOPLEFT", "TitanPanelTitanBG_Display_Capture", "TOPLEFT");
		TitanPanelTitanBG_Display_Flag_2:SetPoint("TOPLEFT", "TitanPanelTitanBG_Display_Flag_1", "BOTTOMLEFT");
	else
		TitanPanelTitanBG_Display_Flag_1:ClearAllPoints();
		TitanPanelTitanBG_Display_Flag_2:ClearAllPoints();

		TitanPanelTitanBG_Display_Flag_1:SetPoint("BOTTOMLEFT", "TitanPanelTitanBG_Display_Flag_2", "TOPLEFT");
		TitanPanelTitanBG_Display_Flag_2:SetPoint("BOTTOMLEFT", "TitanPanelTitanBG_Display_Capture", "BOTTOMLEFT");

	end
end


-- Attaches the flag tracker to the score frame.
function TitanPanelTitanBG_ChangeAttachFlagTracker()
	if (_player_zone == TITANBG_BG_WSG) then
		if (not sv_menu["D_OS_WSG_AttachScore"]) then
			TitanPanelTitanBG_Display_Flag_1_Button:ClearAllPoints();
			TitanPanelTitanBG_Display_Flag_2_Button:ClearAllPoints();

			TitanPanelTitanBG_Display_Flag_1_Button:SetPoint("TOPLEFT", "TitanPanelTitanBG_Display_Flag_1_Icon", "TOPRIGHT", 0, -2);
			TitanPanelTitanBG_Display_Flag_2_Button:SetPoint("TOPLEFT", "TitanPanelTitanBG_Display_Flag_2_Icon", "TOPRIGHT", 0, -2);

		else
			if (AlwaysUpFrame1DynamicIconButton ~= nil and AlwaysUpFrame2DynamicIconButton ~= nil) then
				TitanPanelTitanBG_Display_Flag_1_Button:ClearAllPoints();
				TitanPanelTitanBG_Display_Flag_2_Button:ClearAllPoints();

				TitanPanelTitanBG_Display_Flag_1_Button:SetPoint("TOPLEFT", "AlwaysUpFrame1DynamicIconButton", "TOPRIGHT", 2, -4);
				TitanPanelTitanBG_Display_Flag_2_Button:SetPoint("TOPLEFT", "AlwaysUpFrame2DynamicIconButton", "TOPRIGHT", 2, -4);
			end
		end
	end
end

-- ## Overwrites the similar settings in other addons.
function TitanPanelTitanBG_ToggleOverwriteOtherSettings()

	-- If we are overwriting the settings of other addons.
	if (sv_menu["I_OverwriteOtherSettings"] and sv_menu["AddonEnabled"]) then

		-- Blizzard
		WorldStateFrame_ToggleMinimap = TitanPanelTitanBG_ToggleBattlefieldMinimap;
		RepopMe                       = TitanPanelTitanBG_RepopMe;
		AcceptBattlefieldPort         = TitanPanelTitanBG_AcceptBattlefieldPort;

		-- TITAN HONOR PLUS
			-- Auto battleground minimap.
			if (TitanPanelHonorPlus_ToggleVar_AutoBGMap) then
				TitanPanelHonorPlus_ToggleVar_AutoBGMap = function()
					TitanPanelTitanBG_MessagePopup(TITANBG_MESSAGE_ACTIONOVERWRITTEN, 140);
					Hook_TitanPanelHonorPlus_ToggleVar_AutoBGMap();
				end
			end

			-- Auto join battleground.
			if (TitanPanelHonorPlus_ToggleVar_AutoJoinBG) then
				TitanPanelHonorPlus_ToggleVar_AutoJoinBG = function()
					TitanPanelTitanBG_MessagePopup(TITANBG_MESSAGE_ACTIONOVERWRITTEN, 140);
					Hook_TitanPanelHonorPlus_ToggleVar_AutoJoinBG();
				end

				TitanHonorPlus_CheckBGConfirm     = function() end
				TitanHonorPlus_StaticPopup_OnHide = function() end
			end

			-- Auto release on death.
			if (TitanPanelHonorPlus_ToggleVar_AutoRelease) then
				TitanPanelHonorPlus_ToggleVar_AutoRelease = function()
					TitanPanelTitanBG_MessagePopup(TITANBG_MESSAGE_ACTIONOVERWRITTEN, 140);
					Hook_TitanPanelHonorPlus_ToggleVar_AutoRelease();
				end
			end

	-- If we don't want to overwrite the settings of other addons.
	else

		-- Blizzard
		WorldStateFrame_ToggleMinimap = Hook_WorldStateFrame_ToggleMinimap;
		RepopMe                       = Hook_RepopMe;
		AcceptBattlefieldPort         = Hook_AcceptBattlefieldPort;

		-- TITAN HONOR PLUS
			-- Auto battleground minimap.
			if (Hook_TitanPanelHonorPlus_ToggleVar_AutoBGMap) then
				TitanPanelHonorPlus_ToggleVar_AutoBGMap = Hook_TitanPanelHonorPlus_ToggleVar_AutoBGMap;
			end

			-- Auto join battleground.
			if (Hook_TitanPanelHonorPlus_ToggleVar_AutoJoinBG) then
				TitanPanelHonorPlus_ToggleVar_AutoJoinBG = Hook_TitanPanelHonorPlus_ToggleVar_AutoJoinBG;
				TitanHonorPlus_CheckBGConfirm            = Hook_TitanHonorPlus_CheckBGConfirm;
				TitanHonorPlus_StaticPopup_OnHide        = Hook_TitanHonorPlus_StaticPopup_OnHide;
			end

			-- Auto release on death.
			if (Hook_TitanPanelHonorPlus_ToggleVar_AutoRelease) then
				TitanPanelHonorPlus_ToggleVar_AutoRelease = Hook_TitanPanelHonorPlus_ToggleVar_AutoRelease;
			end
	end
end


-- ## Hides the battleground ready popup.
function TitanPanelTitanBG_HideBattlegroundReadyPopup()
	if (sv_menu["B_HideJoinPopup"]) then
		StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
	end
end


-- #####################
-- ## TITAN FUNCTIONS ##
-- #####################

-- ## Creates the text located on the titan bar.
function TitanPanelTitanBGButton_SetButtonText(id)
	TitanPanelTitanBGButton_CheckEvents();

	local text = ""; -- The tooltip text.

	local active = ""; -- Active battleground data.
	local ready  = ""; -- Ready battleground data.
	local queue  = ""; -- Queue battleground data.

	local spacer = TITANBG_COLOR_BLUE .. TITANBG_ICON_BUTTON_SPACER;

	-- If the user wants to display the label text, display it.
	if (sv_menu["ShowLabelText"]) then

		-- Loop through and process all the battlegrounds.
		for i = 1, table.getn(_bgs.index) do
			if (_bgs.names[_bgs.index[i]].status ~= TITANBG_BG_STATUS_NONE) then

				-- Get active battleground text.
				if (_bgs.names[_bgs.index[i]].status == TITANBG_BG_STATUS_ACTIVE) then
					active = active .. TitanPanelTitanBGButton_GetButtonText(_bgs.names[_bgs.index[i]]);

				-- Ready battleground data.
				elseif (_bgs.names[_bgs.index[i]].status == TITANBG_BG_STATUS_CONFIRM) then
					if (ready ~= "") then ready = ready .. "   "; end

					ready = ready .. TitanPanelTitanBGButton_GetButtonText(_bgs.names[_bgs.index[i]]);

				-- Queue data.
				else
					if (queue ~= "") then queue = queue .. "   "; end

					queue = queue .. TitanPanelTitanBGButton_GetButtonText(_bgs.names[_bgs.index[i]]);
				end
			end
		end

		-- If this is a battleground, don't display generic queue information.
		if (TitanPanelTitanBG_IsBattleground(_player_zone)) then
			queue = "";

			-- If a queue is ready and the user wants to active information hidden.
			if (sv_menu["B_ReplaceActive"] and ready ~= "") then
				active = "";
			end
		end

		if (active ~= "" and ready ~= "")                  then ready = "   " .. ready; end
		if ((active ~= "" or ready ~= "") and queue ~= "") then queue = "   " .. queue; end

		if (sv_menu["D_B_Spacers"]) then
			text = (spacer .. " " .. active .. ready .. queue .. " " .. spacer);
		else
			text = (active .. ready .. queue);
		end

		-- If nothing is going on, show place holder.
		if (active == "" and ready == "" and queue == "") then
			text = TITANBG_COLOR_YELLOW .. TITANBG_MENU_HEADER;
		end
	end

	-- Return the button text.
	return text;
end

function TitanPanelTitanBGButton_GetButtonText(bg)
	local text      = "";
	local short     = TITANBG_COLOR_GREEN .. bg.short;

	-- If the user is queued for a BG.
	if (bg.status == TITANBG_BG_STATUS_QUEUED) then

		-- If the user wants to go into the first BG available.
		if (bg.instance == 0) then
			text = short .. ": " .. TITANBG_COLOR_WHITE .. TITANBG_FIRST_AVAILABLE;

		-- If the user wants to go into a specific bg.
		else
			text = short .. ": " .. TITANBG_COLOR_WHITE .. bg.instance;
		end

		-- If the user wants to display the time in the queue and wait time, show it.
		if (sv_menu["D_B_Time"]) then

			local wait_time = GetBattlefieldEstimatedWaitTime(bg.index);
			local in_queue  = SecondsToTimeAbbrev(GetBattlefieldTimeWaited(bg.index) / 1000);

			-- Unavailable.
			if (wait_time == 0) then
				wait_time = TITANBG_COLOR_RED .. "?";

			-- Time.
			else
				wait_time = SecondsToTimeAbbrev(wait_time / 1000, 1);
			end

			text = text .. TITANBG_COLOR_YELLOW .. " [" .. TITANBG_COLOR_WHITE .. in_queue .. TITANBG_COLOR_YELLOW .. "/" .. wait_time .. TITANBG_COLOR_YELLOW .."]";
		end

	-- If the user can join a battleground on confirmation.
	elseif (bg.status == TITANBG_BG_STATUS_CONFIRM) then

		-- If auto joining and not currently in a battleground.
		if (not TitanPanelTitanBG_IsBattleground(_player_zone) and sv_menu["B_AutoJoinBG"] and _autojoin_time > GetTime() and _autojoin_bg == bg.name) then
			text = short .. " " .. bg.instance ..": " .. TITANBG_COLOR_GREEN .. SecondsToTime(_autojoin_time - GetTime());

			if (_autojoin_paused > 0) then
				text = text .. TITANBG_COLOR_WHITE .. " (" .. TITANBG_COLOR_GREEN .. TITANBG_BUTTON_PAUSED .. TITANBG_COLOR_WHITE .. ")";
			end

		-- If currently in a battleground or not auto joining.
		else
			text = short .. " " .. bg.instance ..": " .. TITANBG_COLOR_GREEN .. TITANBG_LABEL_READY;
		end

		if (sv_menu["D_B_QueueExpire"]) then
			text = text .. TITANBG_COLOR_YELLOW .." (" .. TITANBG_COLOR_RED .. SecondsToTime(bg.expires) .. TITANBG_COLOR_YELLOW ..")";
		end

	-- If the user is currently in a battleground.
	elseif (bg.status == TITANBG_BG_STATUS_ACTIVE) then
		text = short .. " " .. bg.instance;

		if (sv_menu["D_B_Players"] and _active.stats.bg.total > 0) then
			text = text .. TITANBG_COLOR_WHITE .. "  (".. TITANBG_COLOR_BLUE .. _active.stats.bg.alliance .. TITANBG_COLOR_WHITE .. ":" .. TITANBG_COLOR_RED .. _active.stats.bg.horde .. TITANBG_COLOR_WHITE .. ")";
		end

		text = text .. TITANBG_COLOR_YELLOW .. ":   ";

		if (sv_menu["D_B_Standing"] and _active.stats.player.standing ~= nil) then
			text = text .. TITANBG_COLOR_YELLOW .. TITANBG_S_STANDING     .. TITANBG_COLOR_WHITE .. _active.stats.player.standing      .. " ";
		end

		if (sv_menu["D_B_KillingBlows"] and _active.stats.player.killing_blows ~= nil) then
			text = text .. TITANBG_COLOR_YELLOW .. TITANBG_S_KILLINGBLOWS .. TITANBG_COLOR_GREEN .. _active.stats.player.killing_blows .. " ";
		end

		if (sv_menu["D_B_Kills"] and _active.stats.player.kills ~= nil) then
			text = text .. TITANBG_COLOR_YELLOW .. TITANBG_S_KILLS        .. TITANBG_COLOR_GREEN .. _active.stats.player.kills         .. " ";
		end

		if (sv_menu["D_B_Deaths"] and _active.stats.player.deaths ~= nil) then
			text = text .. TITANBG_COLOR_YELLOW .. TITANBG_S_DEATHS       .. TITANBG_COLOR_RED   .. _active.stats.player.deaths        .. " ";
		end

		if (sv_menu["D_B_Honor"] and _active.stats.player.honor ~= nil) then
			text = text .. TITANBG_COLOR_YELLOW .. TITANBG_S_HONOR        .. TITANBG_COLOR_WHITE .. _active.stats.player.honor         .. " ";
		end

		-- If the player is auto leaving the battleground.
		if (sv_menu["B_AutoLeaveBG"] and _autoleave_time > GetTime()) then
			text = short .. " " .. bg.instance ..": " .. TITANBG_COLOR_RED .. SecondsToTime(_autoleave_time - GetTime());

			if (_autoleave_paused > 0) then
				text = text .. TITANBG_COLOR_WHITE .. " (" .. TITANBG_COLOR_RED .. TITANBG_BUTTON_PAUSED .. TITANBG_COLOR_WHITE .. ")";
			end
		end
	end

	return text;
end


-- ## Creates the text located on the titan bar.
function TitanPanelTitanBGButton_SetTooltipText(id)
	local text = ""; -- The tooltip text.

	local active = ""; -- Active battleground data.
	local ready  = ""; -- Ready battleground data.
	local queue  = ""; -- Queue battleground data.
	local empty  = ""; -- Irrelevant battleground data.
	local hint   = ""; -- Any hints to add to the end.

	-- Loop through and process all the battlegrounds.
	for i = 1, table.getn(_bgs.index) do

		-- No battleground interaction.
		if (_bgs.names[_bgs.index[i]].status == TITANBG_BG_STATUS_NONE) then
			if (empty ~= "") then empty = empty .. "\n"; end

			empty = empty .. TitanPanelTitanBGButton_GetTooltipText(_bgs.names[_bgs.index[i]]);

		-- Active battleground data.
		elseif (_bgs.names[_bgs.index[i]].status == TITANBG_BG_STATUS_ACTIVE) then
			if (active ~= "") then active = active .. "\n\n"; end

			active = active .. TitanPanelTitanBGButton_GetTooltipText(_bgs.names[_bgs.index[i]]);

		-- Ready battleground data.
		elseif (_bgs.names[_bgs.index[i]].status == TITANBG_BG_STATUS_CONFIRM) then
			if (ready ~= "") then ready = ready .. "\n"; end

			ready = ready .. TitanPanelTitanBGButton_GetTooltipText(_bgs.names[_bgs.index[i]]);

		-- Queue data.
		else
			if (queue ~= "") then queue = queue .. "\n\n"; end

			queue = queue .. TitanPanelTitanBGButton_GetTooltipText(_bgs.names[_bgs.index[i]]);
		end
	end

	-- Show hints.
	if (not TitanPanelTitanBG_IsBattleground(_player_zone)) then
		hint = hint .. "\n";

		if (not TitanPanelTitanBG_IsBattleground(_player_zone) and _autojoin_time > 0 and ready ~= "" and sv_menu["B_AutoJoinBG"]) then
			hint = hint .. "\n" .. TITANBG_COLOR_RED .. TITANBG_AUTOJOIN_HINT;
		end

		hint = hint .. "\n"  .. TITANBG_COLOR_RED .. TITANBG_MINIMAP_HINT;
	end

	-- If the user wants two tooltips.
	if (sv_menu["D_BG_SeperateActiveQueue"] and TitanPanelTitanBG_IsBattleground(_player_zone)) then
		hint = hint .. "\n\n"  .. TITANBG_COLOR_RED .. TITANBG_TOOLTIP_HINT;

		if (_display_queue_tt) then
			if (ready ~= "" and queue ~= "")                  then queue = "\n\n"  .. queue; end
			if ((ready ~= "" or queue ~= "") and empty ~= "") then empty = "\n\n"  .. empty; end

			text = "\n" .. ready .. queue .. empty .. hint;
		else
			text = "\n" .. active .. hint;
		end

	-- If the user wants to display everthing in one tooltip.
	else
		if (ready ~= "" and active ~= "")                                 then active = "\n\n" .. active; end
		if ((ready ~= "" or active ~= "") and queue ~= "")                then queue = "\n\n"  .. queue;  end
		if ((ready ~= "" or active ~= "" or queue ~= "") and empty ~= "") then empty = "\n\n"  .. empty;  end

		text = "\n" .. ready .. active .. queue .. empty .. hint;
	end

	return text;
end


-- ## Creates the tooltip text for the addon.
function TitanPanelTitanBGButton_GetTooltipText(bg)
	local text = "";

	-- If the user is not queued for the battleground.
	if (bg.status == TITANBG_BG_STATUS_NONE) then
		text = text .. TITANBG_COLOR_GREY .. string.gsub(TITANBG_NOT_IN_QUEUE_LONG, "{bg}", bg.name, 1);

	-- If the user is queued for the battleground.
	elseif (bg.status == TITANBG_BG_STATUS_QUEUED) then
		local wait_time = GetBattlefieldEstimatedWaitTime(bg.index);
		local in_queue  = GetBattlefieldTimeWaited(bg.index);

		text = text .. TITANBG_COLOR_GREEN .. string.upper(bg.name) .. "\n";

		if (bg.instance ~= 0) then
			text = text .. TITANBG_COLOR_GREY .. string.gsub(TITANBG_QUEUED_PREF, "{bg}", bg.name .. " " .. bg.instance, 1);
		else
			text = text .. TITANBG_COLOR_GREY .. string.gsub(TITANBG_QUEUED_NOPREF, "{bg}", bg.name, 1);
		end

		-- If the user knows how many active battlegrounds there were previously.
		if (bg.open_age > 0 and sv_menu["D_TT_RememberOpenBgs"]) then
			local age = "";

			-- If older than 10 minutes, display age.
			if (GetTime() - bg.open_age >= 300) then
				age = TITANBG_COLOR_YELLOW .. " [" .. TITANBG_COLOR_WHITE .. SecondsToTimeAbbrev(GetTime() - bg.open_age) .. TITANBG_COLOR_YELLOW .. "]";
			end

			text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_ACTIVE_INSTANCES .. "\t" .. TITANBG_COLOR_WHITE .. bg.open_instances .. age;
		end

		if (sv_menu["D_TT_QueueTimers"]) then
			text = text .. "\n\n" .. TITANBG_COLOR_YELLOW .. TITANBG_ESTIMATED_WAIT;

			if (wait_time == 0) then
				text = text .. "\t" .. TITANBG_COLOR_RED .. QUEUE_TIME_UNAVAILABLE .. ".";
			elseif (wait_time < 60000) then
				text = text .. "\t" .. TITANBG_COLOR_GREEN .. TITANBG_LESS_THAN_ONE_MIN;
			else
				text = text .. "\t" .. TITANBG_COLOR_WHITE .. SecondsToTime(wait_time / 1000, 1);
			end

			text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_TIME_IN_QUEUE .. "\t" .. TITANBG_COLOR_WHITE .. SecondsToTime(in_queue / 1000);

			-- Estimated time remaining.
			if (wait_time > in_queue) then
				text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_ESTIMATED_REMAINING .. "\t" .. TITANBG_COLOR_WHITE .. SecondsToTime((wait_time - in_queue) / 1000);
			end
		end

	-- If the user can now accept to go into the battleground.
	elseif (bg.status == TITANBG_BG_STATUS_CONFIRM) then
		local expire = "";

		-- Check if the queue expire time is to be shown.
		if (sv_menu["D_POP_QueueExpire"]) then
			expire = " (" .. TITANBG_COLOR_RED .. SecondsToTime(bg.expires) .. TITANBG_COLOR_GREEN .. ")";
		end

		-- If the user is not already in a battleground and is autojoining.
		if (TitanPanelTitanBG_IsBattleground(_player_zone) == false and sv_menu["B_AutoJoinBG"] and _autojoin_time > GetTime() and _autojoin_bg == bg.name) then
			local autojoin = SecondsToTime(_autojoin_time - GetTime());

			if (_autojoin_paused > 0) then
				autojoin = autojoin .. TITANBG_COLOR_WHITE .. "(" .. TITANBG_TOOLTIP_PAUSED .. ")";
			end

			text = text .. TITANBG_COLOR_GREEN .. string.gsub(string.gsub(TITANBG_AUTOJOIN, "{bg}", TITANBG_COLOR_WHITE .. bg.name .. TITANBG_COLOR_GREEN, 1), "{time}", TITANBG_COLOR_YELLOW .. autojoin .. TITANBG_COLOR_GREEN .. expire, 1);

		-- If the user is in a battleground or is not autojoining.
		else
			text = text .. TITANBG_COLOR_GREEN .. string.gsub(string.gsub(TITANBG_CONFIRMJOIN, "{bg}", TITANBG_COLOR_WHITE .. bg.name .. TITANBG_COLOR_GREEN, 1), "{time}", TITANBG_COLOR_GREEN .. expire, 1);
		end

	-- If the battleground is currently active.
	elseif (bg.status == TITANBG_BG_STATUS_ACTIVE) then
		text = TITANBG_COLOR_GREEN  .. string.upper(bg.name) .. "\n" .. text;

		-- If the player is auto leaving the battleground.
		if (sv_menu["B_AutoLeaveBG"] and _autoleave_time > GetTime()) then
			local autoleave = SecondsToTime(_autoleave_time - GetTime());

			if (_autoleave_paused > 0) then
				autoleave = autoleave .. TITANBG_COLOR_WHITE .. "(" .. TITANBG_TOOLTIP_PAUSED .. ")";
			end

			text = text .. TITANBG_COLOR_RED .. string.gsub(TITANBG_AUTOLEAVE, "{time}", autoleave .. TITANBG_COLOR_RED, 1) .. "\n\n";
		end

		text = text .. TITANBG_COLOR_YELLOW .. bg.name .. " "  .. bg.instance .. ":";

		-- Print the instance and the run time.
		if (_active.stats.bg.run > 0) then
			text = text .. "\t" .. TITANBG_COLOR_WHITE .. SecondsToTime(_active.stats.bg.run/1000, 1);
		else
			text = text .. "\t" .. TITANBG_COLOR_RED   .. TITANBG_INSTANCE_RUN_TIME_NA;
		end

		-- Print the number of players.
		if (_active.stats.bg.total > 0) then
			text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYERS .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.bg.total;

			text = text .. TITANBG_COLOR_YELLOW .. " [" .. TITANBG_COLOR_BLUE .. _active.stats.bg.alliance .. TITANBG_COLOR_YELLOW .. "]";
			text = text .. TITANBG_COLOR_YELLOW .. " [" .. TITANBG_COLOR_RED  .. _active.stats.bg.horde    .. TITANBG_COLOR_YELLOW .. "]";
		end

		-- If this is Arathi Basin, print who is likely to win this battleground.
		if (bg.name == TITANBG_BG_AB and sv_menu["D_TT_ABWinEstimates"] and GetBattlefieldWinner() == nil) then
			local winner, win_time, alliance_score, horde_score, nodes = TitanPanelTitanBG_AB_GetWinner(_active.stats.ab.bases_alliance, _active.stats.ab.bases_horde);

			text = text .. "\n\n" .. TITANBG_COLOR_WHITE .. TITANBG_WIN_ESTIMATE;

			-- If unknown.
			if (winner == nil) then
				text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_AB_WINNER .. "\t" .. TITANBG_COLOR_WHITE .. TITANBG_AB_WINNER_UNKNOWN;

			-- If Horde.
			elseif (winner == "Horde") then
				text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_AB_WINNER .. "\t" .. TITANBG_COLOR_RED .. FACTION_HORDE;

			-- If Alliance.
			elseif (winner == "Alliance") then
				text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_AB_WINNER .. "\t" .. TITANBG_COLOR_BLUE .. FACTION_ALLIANCE;
			end

			if (winner ~= nil) then
				text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_AB_FINAL_SCORE .. "\t" .. TITANBG_COLOR_BLUE  .. alliance_score .. TITANBG_COLOR_WHITE .. " : " .. TITANBG_COLOR_RED .. horde_score;
				text = text .. "\n" .. TITANBG_COLOR_YELLOW .. TITANBG_AB_TIME_LEFT   .. "\t" .. TITANBG_COLOR_WHITE .. SecondsToTimeAbbrev(win_time);

				-- Determine number of bases the player needs to win.

				-- If the player's faction isn't going to win.
				if (winner ~= UnitFactionGroup("player")) then
					local bases = TitanPanelTitanBG_AB_NodesRequiredToWin(_player_faction);
					       text = text .. "\n\n" .. TITANBG_COLOR_YELLOW .. TITANBG_AB_TO_WIN  .. "\t" .. TITANBG_COLOR_WHITE .. bases;

				-- Otherwise, if their faction is going to win.
				else
					local bases = TitanPanelTitanBG_AB_NodesRequiredToWin(_player_enemy_faction);
						  text  = text .. "\n\n" .. TITANBG_COLOR_YELLOW .. TITANBG_AB_TO_WIN_ENEMY .. "\t" .. TITANBG_COLOR_WHITE .. bases;
				end

				-- Time left until the number of nodes needed increases.
				if (_timetonodeincrease > 0) then
					text = text .. TITANBG_COLOR_YELLOW .. " (" .. TITANBG_COLOR_RED .. SecondsToTimeAbbrev(_timetonodeincrease) .. TITANBG_COLOR_YELLOW .. ")";
				end
			end
		end

		-- Print information on the user.
		if (sv_menu["D_TT_PlayerStats"]) then
			text = text .. "\n\n" .. TITANBG_COLOR_WHITE  .. TITANBG_PLAYER_STATS;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_STANDING     .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.player.standing;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_KILLINGBLOWS .. "\t" .. TITANBG_COLOR_GREEN .. _active.stats.player.killing_blows;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_KILLS        .. "\t" .. TITANBG_COLOR_GREEN .. _active.stats.player.kills;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_DEATHS       .. "\t" .. TITANBG_COLOR_RED   .. _active.stats.player.deaths;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_BONUSHONOR   .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.player.honor;
		end

		-- Print information on the locations in Alterac Valley.
		if (sv_menu["D_TT_LocationStats"] and bg.name == TITANBG_BG_AV) then
			text = text .. "\n\n" .. TITANBG_COLOR_WHITE  .. TITANBG_LOCATION_STATS;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_GYASSAULTED .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.av.gy_assulted;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_GYDEFENDED  .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.av.gy_defended;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_TASSAULTED  .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.av.towers_assaulted;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_TDEFENDED   .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.av.towers_defended;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_MCAPTURED   .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.av.mines_captured;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_LKILLED     .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.av.leaders_killed;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_SECOBJ      .. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.av.secondary_obj;

		-- Print information on the locations in Warsong Gulch.
		elseif (sv_menu["D_TT_LocationStats"] and bg.name == TITANBG_BG_WSG) then
			text = text .. "\n\n" .. TITANBG_COLOR_WHITE  .. TITANBG_LOCATION_STATS;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_FCAPTURED.. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.wsg.flag_captures;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_FRETURNED.. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.wsg.flag_returns;

		-- Print information on the locations in Arathi Basin.
		elseif (sv_menu["D_TT_LocationStats"] and bg.name == TITANBG_BG_AB) then
			text = text .. "\n\n" .. TITANBG_COLOR_WHITE  .. TITANBG_LOCATION_STATS;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_BSASSULTED.. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.ab.bases_assulted;
			text = text .. "\n"   .. TITANBG_COLOR_YELLOW .. TITANBG_PLAYER_BSDEFENDED.. "\t" .. TITANBG_COLOR_WHITE .. _active.stats.ab.bases_defended;
		end

		-- Print information on friends.
		if ( sv_menu["D_TT_Friends"] and _friendstring ~= "" ) then
			text = text .. "\n\n" .. TITANBG_COLOR_WHITE .. TITANBG_FRIENDS;
			text = text .. _friendstring;
		end

		-- Print information on incoming captures.
		if (sv_menu["D_TT_Capture"] and _active.captures ~= nil and table.getn(_active.captures) > 0 and GetBattlefieldWinner() == nil) then
			local capInfo = "";

			for i = 1, table.getn(_active.captures) do
				local eta = "";

				-- If the capture was done while the player was not there, show unknown.
				if (_active.captures[i].cap == 0) then
					eta = TITANBG_CAPTURE_UNKNOWN;

				-- Otherwise, show the timer.
				else
					eta = SecondsToTime(_active.captures[i].cap - GetTime());

					-- If there is a capture imminent, indicate.
					if (eta == "") then
						eta = TITANBG_CAPTURE_IMINENT;
					end
				end

				-- If not unknown, display timers.
				if (eta ~= TITANBG_CAPTURE_UNKNOWN) then

					if (_active.captures[i].who == "Horde") then
						capInfo = capInfo .. "\n" .. TITANBG_COLOR_YELLOW .. _active.captures[i].name .. "\t" .. TITANBG_COLOR_RED  .. eta;
					elseif (_active.captures[i].who == "Alliance") then
						capInfo = capInfo .. "\n" .. TITANBG_COLOR_YELLOW .. _active.captures[i].name .. "\t" .. TITANBG_COLOR_BLUE .. eta;
					end
				end
			end

			-- If any valid captures, print them.
			if (capInfo ~= "") then
				text = text .. "\n\n" .. TITANBG_COLOR_WHITE .. TITANBG_CAPTURE_TIMERS .. capInfo;
			end
		end

		-- Print information on flag caps.
		if (sv_menu["D_TT_FlagTracker"] and ((_active.stats.wsg.horde.player ~= "" and _active.stats.wsg.horde.player ~= nil) or (_active.stats.wsg.alliance.player ~= "" and _active.stats.wsg.alliance.player ~= nil)) and GetBattlefieldWinner() == nil) then
			text = text .. "\n\n" .. TITANBG_COLOR_WHITE .. TITANBG_FLAG_TRACKER;

			if (_active.stats.wsg.alliance.player ~= "" and _active.stats.wsg.alliance.player ~= nil) then
				local player = TitanBG_GetPlayerData(_active.stats.wsg.alliance.player .. "|Alliance");

				if (player) then
					text = text .. "\n" .. TITANBG_COLOR_YELLOW .. "(" ..  TITANBG_COLOR_RED .. TITANBG_FLAG .. TITANBG_COLOR_YELLOW .. ") " .. TITANBG_COLOR_BLUE .. _active.stats.wsg.alliance.player .. "\t" .. TITANBG_COLOR_WHITE .. player.class;
				end
			end

			if (_active.stats.wsg.horde.player ~= "" and _active.stats.wsg.horde.player ~= nil) then
				local player = TitanBG_GetPlayerData(_active.stats.wsg.horde.player .. "|Horde");

				if (player) then
					text = text .. "\n" .. TITANBG_COLOR_YELLOW .. "(" ..  TITANBG_COLOR_BLUE .. TITANBG_FLAG .. TITANBG_COLOR_YELLOW .. ") " .. TITANBG_COLOR_RED .. _active.stats.wsg.horde.player .. "\t" .. TITANBG_COLOR_WHITE .. player.class;
				end
			end
		end

		-- Show hints.
		text = text .. "\n\n".. TITANBG_COLOR_RED .. TITANBG_SCOREFRAME_HINT;
		text = text .. "\n"  .. TITANBG_COLOR_RED .. TITANBG_MINIMAP_HINT;
	end

	return text;
end


-- #######################
-- ## DISPLAY FUNCTIONS ##
-- #######################


-- ## Prints a message to the user's console.
function TitanPanelTitanBG_Print(s)
	if (s == nil)   then s = "nil";   end
	if (s == true)  then s = "true";  end
	if (s == false) then s = "false"; end

	DEFAULT_CHAT_FRAME:AddMessage("[TITANBG]: " .. s);
end

-- ## Prints a message to a popup frame.
function TitanPanelTitanBG_MessagePopup(s, height)
	if (s == nil)   then s = "nil";   end
	if (s == true)  then s = "true";  end
	if (s == false) then s = "false"; end

	TitanPanelTitanBG_Message:SetHeight(height);
	TitanPanelTitanBG_Message_Text:SetText(s);
	TitanPanelTitanBG_Message:Show();
end


-- ## Updates the on the screen display of the capture timers.
function TitanPanelTitanBG_NT_UpdateCaptures(hide)
	local caps     = 0;
	local display  = 5;
	local shown    = 1;
	local i        = 1;

	-- Hide all of the frames first.
	if (hide) then
		for i = 1, 5 do
			getglobal("TitanPanelTitanBG_Display_Capture_" .. i):Hide();
		end
	end

	if (sv_menu["AddonEnabled"] and (_player_zone == TITANBG_BG_AV or _player_zone == TITANBG_BG_AB) and GetBattlefieldWinner() == nil) then
		if (_active.captures ~= nil) then
			caps = table.getn(_active.captures); -- Number of captures.

			if (table.getn(_active.captures) > 5) then
				display = caps;
			end
		end

		-- If the player is printing the timers upside down.
		if (sv_menu["D_NT_TimersInvert"]) then
			local temp = i;

			i       = display;
			display = temp;
		end

		while ((not sv_menu["D_NT_TimersInvert"] and i <= display) or (sv_menu["D_NT_TimersInvert"] and i >= display)) do
			local frame = "TitanPanelTitanBG_Display_Capture_" .. shown;

			-- If this slot is not active, turn it off.
			if (_active.captures[i] == nil or not sv_menu["D_OS_CaptureShow"]) then

				-- Blank out the points.
				getglobal(frame .. "_Icon"):SetTexCoord(TITANBG_ICON_CAP_BLANK[1], TITANBG_ICON_CAP_BLANK[2], TITANBG_ICON_CAP_BLANK[3], TITANBG_ICON_CAP_BLANK[4]);
				getglobal(frame .. "_Point"):SetText("");
				getglobal(frame .. "_Time"):SetText("");

				-- Hide the frame.
				getglobal(frame):Hide();

				shown = shown + 1;

			-- Update this slot with a timer if this is a valid capture.
			else

				local eta = "";

				-- If the capture was done while the player was not there, show unknown.
				if (_active.captures[i].cap == 0) then
					eta = TITANBG_CAPTURE_UNKNOWN;

				-- Otherwise, show the timer.
				else
					eta = SecondsToTime(_active.captures[i].cap - GetTime());

					-- If there is a capture imminent, indicate.
					if (eta == "") then
						eta = TITANBG_CAPTURE_IMINENT;
					end
				end

				-- If not unknown, display timers.
				if (eta ~= TITANBG_CAPTURE_UNKNOWN) then
					local tOne, tTwo, tThree, tFour = WorldMap_GetPOITextureCoords(_active.captures[i].t);

					-- Update the points.
					getglobal(frame .. "_Icon"):SetTexCoord(tOne, tTwo, tThree, tFour);
					getglobal(frame .. "_Point"):SetText(_active.captures[i].name);
					getglobal(frame .. "_Time"):SetText(eta);

					-- Show the frame.
					getglobal(frame):Show();

					shown = shown + 1;
				end
			end

			if (shown == 6) then
				break;
			end

			if (not sv_menu["D_NT_TimersInvert"]) then
				i = i + 1;
			else
				i = i - 1;
			end
		end
	end
end

-- ## Updates the on the screen display of the Warsong Gulch flag tracker.
function TitanPanelTitanBG_NT_UpdateFlags()
	local i = 1;

	if (sv_menu["D_OS_WSG_Invert"]) then i = 2; end

	TitanPanelTitanBG_Display_Flag_1_ButtonText:SetText("");
	TitanPanelTitanBG_Display_Flag_2_ButtonText:SetText("");

	TitanPanelTitanBG_Display_Flag_1:Hide();
	TitanPanelTitanBG_Display_Flag_2:Hide();

	if (sv_menu["D_OS_WSG_Show"] and sv_menu["AddonEnabled"] and _player_zone == TITANBG_BG_WSG) then

		-- Collect alliance flag information.
		if (_active.stats.wsg.alliance.player ~= "" and _active.stats.wsg.alliance.player ~= nil) then
			local color  = "";
			local class  = "";
			local player = TitanBG_GetPlayerData(_active.stats.wsg.alliance.player .. "|Alliance");

			if (player) then
				if (sv_menu["D_OS_WSG_AttachScore"]) then
					i = 1;
				end

				if (sv_menu["D_OS_WSG_ColorClass"]) then
					color = TITANBG_COLOR_CLASS[TITANBG_CLASS[player.class]].color;
				end

				if (sv_menu["D_OS_WSG_TextClass"]) then
					class = TITANBG_COLOR_WHITE .. " (" .. player.class .. ")";
				end

				-- Set icon.
				if (sv_menu["D_OS_WSG_AttachScore"]) then
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Icon"):Hide();
				else
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Icon"):SetTexture("Interface\\WorldStateFrame\\HordeFlag");
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Icon"):Show();
				end

				-- Set text.
				getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_ButtonText"):SetText(color .. _active.stats.wsg.alliance.player .. class);
				getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Button"):SetWidth(getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_ButtonText"):GetWidth());

				-- Set on click script.
				if (sv_menu["D_OS_WSG_Click"]) then
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Button"):SetScript("OnClick", function()
						TargetByName(_active.stats.wsg.alliance.player, true);
					end);
				end

				getglobal("TitanPanelTitanBG_Display_Flag_" .. i):Show();

				if (sv_menu["D_OS_WSG_Invert"]) then
					i = i - 1;
				else
					i = i + 1;
				end
			end
		end

		-- Collect horde flag information.
		if (_active.stats.wsg.horde.player ~= "" and _active.stats.wsg.horde.player ~= nil) then
			local color = "";
			local class = "";
			local player = TitanBG_GetPlayerData(_active.stats.wsg.horde.player .. "|Horde");

			if (player) then
				if (sv_menu["D_OS_WSG_AttachScore"]) then
					i = 2;
				end

				if (sv_menu["D_OS_WSG_ColorClass"]) then
					color = TITANBG_COLOR_CLASS[TITANBG_CLASS[player.class]].color;
				end

				if (sv_menu["D_OS_WSG_TextClass"]) then
					class = TITANBG_COLOR_WHITE .. " (" ..player.class .. ")";
				end

				-- Set icon.
				if (sv_menu["D_OS_WSG_AttachScore"]) then
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Icon"):Hide();
				else
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Icon"):SetTexture("Interface\\WorldStateFrame\\AllianceFlag");
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Icon"):Show();
				end

				-- Set text.
				getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_ButtonText"):SetText(color ..  _active.stats.wsg.horde.player .. class);
				getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Button"):SetWidth(getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_ButtonText"):GetWidth());

				-- Set on click script.
				if (sv_menu["D_OS_WSG_Click"]) then
					getglobal("TitanPanelTitanBG_Display_Flag_" .. i .. "_Button"):SetScript("OnClick", function()
						TargetByName(_active.stats.wsg.horde.player, true);
					end);
				end

				getglobal("TitanPanelTitanBG_Display_Flag_" .. i):Show();

				if (sv_menu["D_OS_WSG_Invert"]) then
					i = i - 1;
				else
					i = i + 1;
				end
			end
		end
	end
end


-- #############################
-- ## INITALISATION FUNCTIONS ##
-- #############################


-- ## Performed when the addon is loaded.
function TitanPanelTitanBGButton_OnLoad()
	this.registry = {
		id                  = TITAN_TITANBG_ID,
		menuText            = TITAN_TITANBG_ID,
		tooltipTitle        = TITANBG_TOOLTIP,
		buttonTextFunction  = "TitanPanelTitanBGButton_SetButtonText",
		tooltipTextFunction = "TitanPanelTitanBGButton_SetTooltipText",
		icon                = TITANBG_ARTWORK_PATH,
		iconWidth           = 16,
		frequency           = TITAN_TITANBG_FREQ;

		savedVariables = {
			ShowIcon = 1,
		}
	};

	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("FRIENDLIST_UPDATE");
	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	this:RegisterEvent("ZONE_CHANGED_INDOORS");
	this:RegisterEvent("BATTLEFIELDS_SHOW");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");

	-- Register slash commands.
	SLASH_TITANBG1 = "/titanbg";
	SLASH_TITANBG2 = "/tbg";

	-- Register slash command handler.
	SlashCmdList["TITANBG"] = function(command)
		if (not command or command == "") then
			TitanBG_Menu_Toggle();
		elseif (string.find(command, " ")) then
			local c   = string.sub(command, 0, string.find(command, " ") - 1);
			local val = string.sub(command, string.find(command, " ") + 1, string.len(command));

			if (string.lower(c) == "flag") then
				if ((string.lower(val) == "a" or string.lower(val) == "alliance") and _active.stats.wsg.alliance.player ~= "" and _active.stats.wsg.alliance.player ~= nil) then
					TargetByName(_active.stats.wsg.alliance.player, true);
				elseif ((string.lower(val) == "h" or string.lower(val) == "horde") and _active.stats.wsg.horde.player ~= "" and _active.stats.wsg.horde.player ~= nil) then
					TargetByName(_active.stats.wsg.horde.player, true);
				end
			end
		end
	end

	-- Store any existing captures if the player is in a battleground.
	if (TitanPanelTitanBG_IsBattleground(_player_zone)) then
		_active_init_stored = false;
		TitanPanelTitanBG_CheckMap(_player_zone, true);
		_active_init_stored = true;
	end

	-- Shows the status of each queue point returned by the server. If the slot is not taken up by a battleground,
	-- it will return the zone the user is currently in.
	-- !! DEBUG START

	--	DEFAULT_CHAT_FRAME:AddMessage("Printing queue status ... ");

	--	for i = 1, MAX_BATTLEFIELD_QUEUES do
	--		local _, name, _ = GetBattlefieldStatus(i);

	--		DEFAULT_CHAT_FRAME:AddMessage("BG = " .. name);
	--	end

	-- !! DEBUG END
end


-- ## Resets battleground status information to original values.
function TitanPanelTitanBG_ResetBattlegroundInformation()

	-- Battleground information variables.
 	_bgs = {
 		queue = 0; -- The number of battegrounds that are in queue or active status.

 		-- Table which links the blizzard battleground index to the correct information.
 		blizzard = {
 			[1] = nil,
 			[2] = nil,
 			[3] = nil,
 		};

 		-- Allows looping of the battlegrounds numerically.
 		index   = {
 			[1] = TITANBG_BG_AV,
 			[2] = TITANBG_BG_WSG,
 			[3] = TITANBG_BG_AB,
 		};

		-- Battleground information stored by name.
 		names = {
			[TITANBG_BG_AV]  = {
				index    = 0,
				short    = TITANBG_BG_AV_SHORT,
				name     = TITANBG_BG_AV,
				status   = TITANBG_BG_STATUS_NONE,
				instance = 0,
				expires  = 0,

				open_instances = 0,
				open_age       = 0,

				update = nil,

				sound       = false;
				sound_timer = 0;
			},

			[TITANBG_BG_WSG] = {
				index    = 0,
				short    = TITANBG_BG_WSG_SHORT,
				name     = TITANBG_BG_WSG,
				status   = TITANBG_BG_STATUS_NONE,
				instance = 0,
				expires  = 0,

				open_instances = 0,
				open_age       = 0,

				update = nil,

				sound       = false;
				sound_timer = 0;
			},

			[TITANBG_BG_AB]  = {
				index    = 0,
				short    = TITANBG_BG_AB_SHORT,
				name     = TITANBG_BG_AB,
				status   = TITANBG_BG_STATUS_NONE,
				instance = 0,
				expires  = 0,

				open_instances = 0,
				open_age       = 0,

				update = nil,

				sound       = false;
				sound_timer = 0;
			},
		}
	};
end


-- ## Resets information on the current active battleground.
function TitanPanelTitanBG_ResetActiveInformation()
	_active = {
		stats = {

			bg = {
				name     = "",
				index    = "",
				instance = "",
				win      = "",
				run      = 0,
				total    = 0,
				horde    = 0,
				alliance = 0,
			},

			player = {
				standing      = 0,
				kills         = 0,
				deaths        = 0,
				killing_blows = 0,
				honor         = 0,

			},

			av = {
				gy_assulted     = 0,
				gy_defended     = 0,
				towers_assaulted = 0,
				towers_defended = 0,
				mines_captured  = 0,
				leaders_killed  = 0,
				secondary_obj   = 0,
			},

			wsg = {
				flag_captures = 0,
				flag_returns  = 0,

				alliance = { msg = "", flag = 1, player = "", },
				horde    = { msg = "", flag = 1, player = "", },

				players = { };
			},

			ab = {
				bases_assulted = 0,
				bases_defended = 0,

				bases_horde    = 0;
				bases_alliance = 0;
			},
		},

		captures = {
		},
	};
end

-- ## Resets player information.
function TitanPanelTitanBG_ResetPlayerInformation()
	_player_name = UnitName("player");

	if (UnitFactionGroup("player") == TITANBG_ALLIANCE) then
		_player_faction        = TITANBG_ALLIANCE;
		_player_enemy_faction  = TITANBG_HORDE;
	else
		_player_faction        = TITANBG_HORDE;
		_player_enemy_faction  = TITANBG_ALLIANCE;
	end

	_player_realm = GetRealmName();
end


-- ## Stores the original functions.
function TitanPanelTitanBG_StoreFunctions()

	-- Hook battlemap showing and hiding function to TitanBG.
	Hook_WorldStateFrame_ToggleMinimap = WorldStateFrame_ToggleMinimap;
	Hook_RepopMe                       = RepopMe;
	Hook_DialogDeathAccept             = StaticPopupDialogs["DEATH"].OnAccept;
	Hook_DialogDeathCancel             = StaticPopupDialogs["DEATH"].OnCancel;
	Hook_DialogBattlefieldEntryAccept  = StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnAccept;
	Hook_DialogDeathOnShow             = StaticPopupDialogs["DEATH"].OnShow;
	Hook_AcceptBattlefieldPort         = AcceptBattlefieldPort;
	Hook_PlaySound                     = PlaySound;
	Hook_StaticPopup_Show              = StaticPopup_Show;
	Hook_MiniMapBattlefieldFrame       = MiniMapBattlefieldFrame:GetScript("OnClick");

	-- If the battlefield minimap hasn't been loaded, load it.
	if (not BattlefieldMinimap) then BattlefieldMinimap_LoadUI(); end
	if (BattlefieldMinimapCloseButton) then
		Hook_BattlefieldMinimapCloseButton = BattlefieldMinimapCloseButton:GetScript("OnClick");
	end

	Hook_StaticPopup1Button2OnClick    = StaticPopup1Button2:GetScript("OnClick");

	-- Hook functions from other addons that may be overwritten.
		-- Titan Panel
		Hook_TitanPanel_AddButton     = TitanPanel_AddButton;
		Hook_TitanPanel_RemoveButton  = TitanPanel_RemoveButton;
		Hook_TitanPanelButton_OnClick = TitanPanelButton_OnClick;

		-- Titan Honor Plus
		Hook_TitanPanelHonorPlus_ToggleVar_AutoBGMap  = TitanPanelHonorPlus_ToggleVar_AutoBGMap;
		Hook_TitanPanelHonorPlus_ToggleVar_AutoJoinBG = TitanPanelHonorPlus_ToggleVar_AutoJoinBG;
		Hook_TitanHonorPlus_CheckBGConfirm            = TitanHonorPlus_CheckBGConfirm;
		Hook_TitanHonorPlus_StaticPopup_OnHide        = TitanHonorPlus_StaticPopup_OnHide;
		Hook_TitanPanelHonorPlus_ToggleVar_AutoRelease = TitanPanelHonorPlus_ToggleVar_AutoRelease;
end

-- ## Overwrites the similar settings in other addons.
function TitanPanelTitanBG_HookFunctions()
	TitanPanelTitanBG_ToggleOverwriteOtherSettings();

	if (sv_menu["AddonEnabled"]) then

		-- Overwrite the Titan Panel show and hide functions for each addon, so that we know when our addon is enabled.
			TitanPanel_AddButton = function(id)
				if (id == TITAN_TITANBG_ID) then
					sv_menu["AddonEnabled"] = true;
					TitanPanelTitanBG_HookFunctions();
				end

				return Hook_TitanPanel_AddButton(id);
			end

			TitanPanel_RemoveButton = function(id)
				if (id == TITAN_TITANBG_ID) then
					sv_menu["AddonEnabled"] = false;
					TitanPanelTitanBG_HookFunctions();
				end

				return Hook_TitanPanel_RemoveButton(id);
			end

			-- Switch tooltip views if necessary.
			TitanPanelButton_OnClick = function(button, isChildButton)
				if (button == "RightButton" or (button == "LeftButton" and not _titan_titanbg_leftclick)) then
					return Hook_TitanPanelButton_OnClick(button, isChildButton);
				end

				local id = TitanUtils_Ternary(isChildButton, TitanUtils_GetParentButtonID(), TitanUtils_GetButtonID());

				if (id == TITAN_TITANBG_ID) then
					if (not IsShiftKeyDown() and IsControlKeyDown()) then
						if (_display_queue_tt) then
							_display_queue_tt = false;
						else
							_display_queue_tt = true;
						end

						TitanPanelButton_SetTooltip(TITAN_TITANBG_ID);
						GameTooltip:Show();
					end
				end

				_titan_titanbg_leftclick = false;
			end

		-- Hook blizzard functions.

			-- Do not play the battleground ready sound using this function.
			PlaySound = function(sound, titanbg)
				if (sound ~= "PVPTHROUGHQUEUE" or titanbg) then
					return Hook_PlaySound(sound);
				end
			end

			-- Allow modification of the ready queue popup.
			StaticPopup_Show = function(which, text_arg1, text_arg2, data)
				local dialog = nil;

				if (which ~= "CONFIRM_BATTLEFIELD_ENTRY" or (which == "CONFIRM_BATTLEFIELD_ENTRY" and not sv_menu["B_HideJoinPopup"])) then
					dialog           = Hook_StaticPopup_Show(which, text_arg1, text_arg2, data);
					dialog.text_arg1 = text_arg1;
					dialog.text_arg2 = text_arg2;
				end

				if (which == "CONFIRM_BATTLEFIELD_ENTRY" and dialog) then
					local text = getglobal(dialog:GetName() .. "Text");
					local pop  = { };

--					dialog:SetScript("OnHide", function()
--						while (i <= table.getn(_popups)) do
--							if (_popups[i].dialog.text_arg1 == this.text_arg1) then
--								table.remove(_popups, i);
--								break;
--							end
--						end
--					end);


					pop.dialog    = dialog;
					pop.text      = text;
					pop.which     = which;
					pop.data      = data;
					pop.text_arg1 = text_arg1;
					pop.text_arg2 = text_arg2;

					table.insert(_popups, pop);

					TitanPanelTitanBG_StoreBattlegroundInformation();
				end

				return dialog;
			end

			-- Allow blizzard functions to release or ressurect players, without being interfered with by the addon.
				StaticPopupDialogs["DEATH"].OnAccept = function()
					_blizzard_releasesoul = true;
					Hook_DialogDeathAccept();
					_blizzard_releasesoul = false;
				end

				StaticPopupDialogs["DEATH"].OnCancel = function(data, reason)
					_blizzard_releasesoul = true;
					Hook_DialogDeathCancel(data, reason);
					_blizzard_releasesoul = false;
				end

			-- Allow blizzard functions to join battlegrounds without interferance.
			StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnAccept = function(data)
				_blizzard_interactbg = true;
				Hook_DialogBattlefieldEntryAccept(data);
				_blizzard_interactbg = false;
			end

			-- Does not show the ressurect functions if it should be hidden.
			StaticPopupDialogs["DEATH"].OnShow = function()
				if (sv_menu["B_AutoRelease"] and TitanPanelTitanBG_IsBattleground(_player_zone)) then
					if ((sv_menu["B_ReleaseCheck"] and not HasSoulstone()) or not sv_menu["B_ReleaseCheck"]) then
						TitanPanelTitanBG_RepopMe();
					end
				else
					Hook_DialogDeathOnShow();
				end
			end

			-- When you shift click the battleground icon, shows or hides the battleground minimap for the duration
			-- of your stay in the zone.
			MiniMapBattlefieldFrame:SetScript("OnClick",
				function()
					if (IsShiftKeyDown()) then
						if ((sv_menu["B_AutoShowBGMinimap"] and BattlefieldMinimap:IsShown())  or (not TitanPanelTitanBG_IsBattleground(_player_zone) and BattlefieldMinimap:IsShown())) then
							_blizzard_manualshowbg = "HIDE";
						elseif ((not sv_menu["B_AutoShowBGMinimap"] and not BattlefieldMinimap:IsShown()) or (not TitanPanelTitanBG_IsBattleground(_player_zone) and not BattlefieldMinimap:IsShown())) then
							_blizzard_manualshowbg = "SHOW";
						else
							_blizzard_manualshowbg = nil;
						end
					end

					return Hook_MiniMapBattlefieldFrame();
				end
			);

			-- If the battlefield minimap hasn't been loaded, load it.
			if (not BattlefieldMinimap) then BattlefieldMinimap_LoadUI(); end
			if (BattlefieldMinimapCloseButton) then

				-- When you click the close button on the battleground minimap, closes the minimap for the duration of
				-- the player's stay in the zone.
				BattlefieldMinimapCloseButton:SetScript("OnClick",
					function()
						if ((sv_menu["B_AutoShowBGMinimap"] and BattlefieldMinimap:IsShown()) or (not TitanPanelTitanBG_IsBattleground(_player_zone) and attlefieldMinimap:IsShown())) then
							_blizzard_manualshowbg = "HIDE";
						else
							_blizzard_manualshowbg = nil;
						end

						return Hook_BattlefieldMinimapCloseButton();
					end
				);
			end

			-- When you press the 'Hide' button, it pauses the auto join timer.
			StaticPopup1Button2:SetScript("OnClick",
				function()

					-- If the user want to pause the auto join timer.
					if (sv_menu["B_AutoJoinBG"] and _autojoin_paused == 0) then
						_autojoin_paused = _autojoin_time - GetTime();
					end

					return Hook_StaticPopup1Button2OnClick();
				end
			);

		-- Run data collection.
		TitanPanelTitanBG_ZonesChanged();
	else

		-- Unhook other addon functions.
		TitanPanelButton_OnClick = Hook_TitanPanelButton_OnClick;

		-- Unhook blizzard functions.
		PlaySound = Hook_PlaySound;

		StaticPopup_Show = Hook_StaticPopup_Show;

		StaticPopupDialogs["DEATH"].OnAccept                     = Hook_DialogDeathAccept;
		StaticPopupDialogs["DEATH"].OnCancel                     = Hook_DialogDeathCancel;
		StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnAccept = Hook_DialogBattlefieldEntryAccept;
		StaticPopupDialogs["DEATH"].OnShow                       = Hook_DialogDeathOnShow;

		MiniMapBattlefieldFrame:SetScript("OnClick", Hook_MiniMapBattlefieldFrame);

		-- If the battlefield minimap hasn't been loaded, load it.
		if (not BattlefieldMinimap) then BattlefieldMinimap_LoadUI(); end
		if (BattlefieldMinimapCloseButton) then
			BattlefieldMinimapCloseButton:SetScript("OnClick", Hook_BattlefieldMinimapCloseButton);
		end

		StaticPopup1Button2:SetScript("OnClick", Hook_StaticPopup1Button2OnClick);

		-- Reset variables.
		_autojoin_bg     = "";
	    _autojoin_time   = 0;
	    _autojoin_paused = 0;

	    _autoleave_time   = 0;
	    _autoleave_paused = 0;

		-- Update interface.
		TitanPanelTitanBG_NT_UpdateCaptures(true);
		TitanPanelTitanBG_NT_UpdateFlags();
		TitanPanelTitanBG_ToggleMiniMapIcon();
		TitanPanelTitanBG_ToggleLockCaptures();

		BattlefieldFrame_UpdateStatus();
	end
end