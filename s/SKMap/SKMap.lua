--[[

	SKMap Lua file
]]

-- Configuration variables

-- Local variables
-- any variables declared local will not be available for use outside this module

SKM_VERSION = "1.6";
SKM_LOADED_MSG = "SKMap "..SKM_VERSION.." AddOn loaded"

SKM_TITLE = "SKMap "..SKM_VERSION;



StaticPopupDialogs["SKMAP_CONFIRM"] = {
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnShow = nil,
	OnAccept = nil,
	OnCancel = function() SKMap_DeleteButton_Cancel() end,
	hasMoneyFrame = nil,
	showAlert = 1,
	exclusive = 1,
	whileDead = 1,
	interruptCinematic = 1,
	timeout = 0
};


-- complete list of recorded global settings
SKM_OPTION_LIST = {
	"ShowTargetInfo",
	"SmallTargetInfo",
	"WarSoundWarning",
	"WarFloatingMessage",
	"WarAutoTarget",
	"RecordPlayerKill",
	"RecordCreatureKill",
	"RecordPlayerDeath",
	"DisplayKillRecord",
	"DisplayCreatureKillRecord",
	"DisplayDeathRecord",
	"MapDisplayRecords",
	"CreatureKillRecordsByZone",
	"IgnoreLowerEnemies",
	"IgnoreLevelThreshold",
	"ShowTargetGuildInfo",
	"ShowTargetClassInfo",
	"ShowWorldMapControl",
	"ShowMinimapButton",
	"MinimapButtonPosition",
	"MinimapButtonOffset",
	"IgnoreNoPvPFlag",
	"StoreEnemyPlayers",
	"StoreDuels",
	"AssistKillStat",
	"LockedTargetInfo",
	"TooltipTargetInfo",
	"WarEnableFilter",
	"WarFilterDelay",
	"WarChatMessage",
	"WarShowNote",
	"DataCleanUp",
	"DataCleanUpInterval",
	"CleanInactiveEnemies",
	"CleanInactiveEnemiesDelay",
	"SharedWarMode",
	"TooltipPlayerNote",
	"EnemyListAutoUpdate",
	"EnemyListAutoUpdateDelay",
	"CleanEmptyGuilds",
	"RecordPlayerDeathNonPvP",
	"ReportPlayerDeath",
	"EnemyList_SortType",
	"EnemyList_SortTypes",
	"EnemyList_ReverseSort",
	"GuildList_SortType",
	"GuildList_SortTypes",
	"GuildList_ReverseSort",
	"DuelList_SortType",
	"DuelList_SortTypes",
	"DuelList_ReverseSort"
};




SKM_MAX_CREEP_RECORD_BY_ZONE = 100;


local SKM_TAB_SUBFRAMES = { "SKMap_ListFrame", "SKMap_DuelFrame", "SKMap_ReportFrame", "SKMap_OptionsFrame" };

local SKM_OptionsFrameCheckButtons = {
	[1]  = { Option = "ShowTargetInfo", Text = SKM_UI_STRINGS.Options_Check_ShowTargetInfo, Tooltip = SKM_UI_STRINGS.Options_Tooltip_ShowTargetInfo };
	[2]  = { Option = "SmallTargetInfo", Text = SKM_UI_STRINGS.Options_Button_SmallTargetInfo, Tooltip = SKM_UI_STRINGS.Options_Tooltip_SmallTargetInfo };
	[3]  = { Option = "MapDisplayRecords", Text = SKM_UI_STRINGS.Options_Button_MapDisplayRecords, Tooltip = SKM_UI_STRINGS.Options_Tooltip_MapDisplayRecords };
	[4]  = { Option = "WarSoundWarning", Text = SKM_UI_STRINGS.Options_Button_WarSoundWarning, Tooltip = SKM_UI_STRINGS.Options_Tooltip_WarSoundWarning };
	[5]  = { Option = "WarFloatingMessage", Text = SKM_UI_STRINGS.Options_Button_WarFloatingMessage, Tooltip = SKM_UI_STRINGS.Options_Tooltip_WarFloatingMessage };
	[6]  = { Option = "WarAutoTarget", Text = SKM_UI_STRINGS.Options_Button_WarAutoTarget, Tooltip = SKM_UI_STRINGS.Options_Tooltip_WarAutoTarget };
	[7]  = { Option = "RecordPlayerDeath", Text = SKM_UI_STRINGS.Options_Button_RecordPlayerDeath, Tooltip = SKM_UI_STRINGS.Options_Tooltip_RecordPlayerDeath };
	[8]  = { Option = "DisplayDeathRecord", Text = SKM_UI_STRINGS.Options_Button_DisplayDeathRecord, Tooltip = SKM_UI_STRINGS.Options_Tooltip_DisplayDeathRecord };
	[9]  = { Option = "RecordPlayerKill", Text = SKM_UI_STRINGS.Options_Button_RecordPlayerKill, Tooltip = SKM_UI_STRINGS.Options_Tooltip_RecordPlayerKill };
	[10] = { Option = "DisplayKillRecord", Text = SKM_UI_STRINGS.Options_Button_DisplayKillRecord, Tooltip = SKM_UI_STRINGS.Options_Tooltip_DisplayKillRecord };
	[11] = { Option = "RecordCreatureKill", Text = SKM_UI_STRINGS.Options_Button_RecordCreatureKill, Tooltip = SKM_UI_STRINGS.Options_Tooltip_RecordCreatureKill };
	[12] = { Option = "DisplayCreatureKillRecord", Text = SKM_UI_STRINGS.Options_Button_DisplayCreatureKillRecord, Tooltip = SKM_UI_STRINGS.Options_Tooltip_DisplayCreatureKillRecord };
	[13] = { Option = "IgnoreLowerEnemies", Text = SKM_UI_STRINGS.Options_Button_IgnoreLowerEnemies, Tooltip = SKM_UI_STRINGS.Options_Tooltip_IgnoreLowerEnemies };
	[14] = { Option = "ShowTargetGuildInfo", Text = SKM_UI_STRINGS.Options_Button_ShowTargetGuildInfo, Tooltip = SKM_UI_STRINGS.Options_Tooltip_ShowTargetGuildInfo };
	[15] = { Option = "ShowWorldMapControl", Text = SKM_UI_STRINGS.Options_Button_ShowWorldMapControl, Tooltip = SKM_UI_STRINGS.Options_Tooltip_ShowWorldMapControl };
	[16] = { Option = "ShowTargetClassInfo", Text = SKM_UI_STRINGS.Options_Button_ShowTargetClassInfo, Tooltip = SKM_UI_STRINGS.Options_Tooltip_ShowTargetClassInfo };
	[17] = { Option = "ShowMinimapButton", Text = SKM_UI_STRINGS.Options_Button_ShowMinimapButton, Tooltip = SKM_UI_STRINGS.Options_Tooltip_ShowMinimapButton };
	[18] = { Option = "IgnoreNoPvPFlag", Text = SKM_UI_STRINGS.Options_Button_IgnoreNoPvPFlag, Tooltip = SKM_UI_STRINGS.Options_Tooltip_IgnoreNoPvPFlag };
	[19] = { Option = "StoreEnemyPlayers", Text = SKM_UI_STRINGS.Options_Button_StoreEnemyPlayers, Tooltip = SKM_UI_STRINGS.Options_Tooltip_StoreEnemyPlayers };
	[20] = { Option = "StoreDuels", Text = SKM_UI_STRINGS.Options_Button_StoreDuels, Tooltip = SKM_UI_STRINGS.Options_Tooltip_StoreDuels };
	[21] = { Option = "LockedTargetInfo", Text = SKM_UI_STRINGS.Options_Button_LockedTargetInfo, Tooltip = SKM_UI_STRINGS.Options_Tooltip_LockedTargetInfo };
	[22] = { Option = "TooltipTargetInfo", Text = SKM_UI_STRINGS.Options_Button_TooltipTargetInfo, Tooltip = SKM_UI_STRINGS.Options_Tooltip_TooltipTargetInfo };
	[23] = { Option = "WarEnableFilter", Text = SKM_UI_STRINGS.Options_Button_WarEnableFilter, Tooltip = SKM_UI_STRINGS.Options_Tooltip_WarEnableFilter };
	[24] = { Option = "WarChatMessage", Text = SKM_UI_STRINGS.Options_Button_WarChatMessage, Tooltip = SKM_UI_STRINGS.Options_Tooltip_WarChatMessage };
	[25] = { Option = "WarShowNote", Text = SKM_UI_STRINGS.Options_Button_WarShowNote, Tooltip = SKM_UI_STRINGS.Options_Tooltip_WarShowNote };
	[26] = { Option = "DataCleanUp", Text = SKM_UI_STRINGS.Options_Button_DataCleanUp, Tooltip = SKM_UI_STRINGS.Options_Tooltip_DataCleanUp };
	[27] = { Option = "CleanInactiveEnemies", Text = SKM_UI_STRINGS.Options_Button_CleanInactiveEnemies, Tooltip = SKM_UI_STRINGS.Options_Tooltip_CleanInactiveEnemies };
	[28] = { Option = "SharedWarMode", Text = SKM_UI_STRINGS.Options_Button_SharedWarMode, Tooltip = SKM_UI_STRINGS.Options_Tooltip_SharedWarMode };
	[29] = { Option = "TooltipPlayerNote", Text = SKM_UI_STRINGS.Options_Button_TooltipPlayerNote, Tooltip = SKM_UI_STRINGS.Options_Tooltip_TooltipPlayerNote };
	[30] = { Option = "EnemyListAutoUpdate", Text = SKM_UI_STRINGS.Options_Button_EnemyListAutoUpdate, Tooltip = SKM_UI_STRINGS.Options_Tooltip_EnemyListAutoUpdate };
	[31] = { Option = "CleanEmptyGuilds", Text = SKM_UI_STRINGS.Options_Button_CleanEmptyGuilds, Tooltip = SKM_UI_STRINGS.Options_Tooltip_CleanEmptyGuilds };
	[32] = { Option = "RecordPlayerDeathNonPvP", Text = SKM_UI_STRINGS.Options_Button_RecordPlayerDeathNonPvP, Tooltip = SKM_UI_STRINGS.Options_Tooltip_RecordPlayerDeathNonPvP };
	[33] = { Option = "ReportPlayerDeath", Text = SKM_UI_STRINGS.Options_Button_ReportPlayerDeath, Tooltip = SKM_UI_STRINGS.Options_Tooltip_ReportPlayerDeath };

};

local SKM_OptionsFrameSliders = {
	[1] = { Option = "CreatureKillRecordsByZone", valueStep = 1, minValue = 0, maxValue = SKM_MAX_CREEP_RECORD_BY_ZONE, Text = SKM_UI_STRINGS.Options_Slider_CreatureKillRecordsByZone, Tooltip = SKM_UI_STRINGS.Options_Tooltip_CreatureKillRecordsByZone };
	[2] = { Option = "IgnoreLevelThreshold", valueStep = 1, minValue = 0, maxValue = 100, Text = SKM_UI_STRINGS.Options_Slider_IgnoreLevelThreshold, Tooltip = SKM_UI_STRINGS.Options_Tooltip_IgnoreLevelThreshold };
	[3] = { Option = "MinimapButtonPosition", valueStep = 1, minValue = 0, maxValue = 100, Text = SKM_UI_STRINGS.Options_Slider_MinimapButtonPosition, Tooltip = SKM_UI_STRINGS.Options_Tooltip_MinimapButtonPosition };
	[4] = { Option = "MinimapButtonOffset", valueStep = 1, minValue = 50, maxValue = 120, Text = SKM_UI_STRINGS.Options_Slider_MinimapButtonOffset, Tooltip = SKM_UI_STRINGS.Options_Tooltip_MinimapButtonOffset };
	[5] = { Option = "WarFilterDelay", valueStep = 1, minValue = 1, maxValue = 60, Text = SKM_UI_STRINGS.Options_Slider_WarFilterDelay, Tooltip = SKM_UI_STRINGS.Options_Tooltip_WarFilterDelay };
	[6] = { Option = "DataCleanUpInterval", valueStep = 1, minValue = 1, maxValue = 100, Text = SKM_UI_STRINGS.Options_Slider_DataCleanUpInterval, Tooltip = SKM_UI_STRINGS.Options_Tooltip_DataCleanUpInterval };
	[7] = { Option = "CleanInactiveEnemiesDelay", valueStep = 1, minValue = 1, maxValue = 150, Text = SKM_UI_STRINGS.Options_Slider_CleanInactiveEnemiesDelay, Tooltip = SKM_UI_STRINGS.Options_Tooltip_CleanInactiveEnemiesDelay };
	[8] = { Option = "EnemyListAutoUpdateDelay", valueStep = 1, minValue = 0, maxValue = 300, Text = SKM_UI_STRINGS.Options_Slider_EnemyListAutoUpdateDelay, Tooltip = SKM_UI_STRINGS.Options_Tooltip_EnemyListAutoUpdateDelay };

};

local SKM_OptionFrameLabels = {
	[1] = { Text = SKM_UI_STRINGS.Options_Label_General };
	[2] = { Text = SKM_UI_STRINGS.Options_Label_Map };
	[3] = { Text = SKM_UI_STRINGS.Options_Label_War };
	[4] = { Text = SKM_UI_STRINGS.Options_Label_Record };
	[5] = { Text = SKM_UI_STRINGS.Options_Label_Minimap };
	[6] = { Text = SKM_UI_STRINGS.Options_Label_Cleanup };
};


-- new option management
SKM_OptionsList = {
	[1] = {
		Title = SKM_OptionFrameLabels[1];
		Lines = {
			[1] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[1];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[19];
				};
			};
			[2] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[21];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[18];
				};
			};
			[3] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[2];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[13];
				};
			};
			[4] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[16];
				};
				Right = {
					Type = _SKM._slider;
					Offset = 40;
					Value = SKM_OptionsFrameSliders[2];
				};
			};
			[5] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[14];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[20];
				};
			};
			[6] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[22];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[30];
				};
			};
			[7] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[29];
				};
				Right = {
					Type = _SKM._slider;
					Offset = 30;
					Value = SKM_OptionsFrameSliders[8];
				};
			};
			[8] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[33];
				};
				Right = nil;	
			};
		};
	};

	[2] = {
		Title = SKM_OptionFrameLabels[2];
		Lines = {
			[1] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[3];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[15];
				};
			};
		};
	};

	[3] = {
		Title = SKM_OptionFrameLabels[3];
		Lines = {
			[1] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[4];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[23];
				};
			};
			[2] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[5];
				};
				Right = {
					Type = _SKM._slider;
					Offset = 30;
					Value = SKM_OptionsFrameSliders[5];
				};
			};
			[3] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[24];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[6];
				};
			};
			[4] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[25];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[28];
				};
			};

		};
	};

	[4] = {
		Title = SKM_OptionFrameLabels[4];
		Lines = {
			[1] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[7];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[11];
				};
			};
			[2] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[32];
				};
				Right = {
					Type = _SKM._slider;
					Offset = 30;
					Value = SKM_OptionsFrameSliders[1];
				};
			};
			[3] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[8];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[12];
				};
			};
			[4] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[9];
				};
			};
			[5] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[10];
				};
			};
		};
	};

	[5] = {
		Title = SKM_OptionFrameLabels[5];
		Lines = {
			[1] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[17];
				};
				Right = {
					Type = _SKM._slider;
					Offset = 30;
					Value = SKM_OptionsFrameSliders[3];
				};
			};
			[2] = {
				Right = {
					Type = _SKM._slider;
					Offset = 30;
					Value = SKM_OptionsFrameSliders[4];
				};
			};
		};
	};

	[6] = {
		Title = SKM_OptionFrameLabels[6];
		Lines = {
			[1] = {
				Left = {
					Type = _SKM._checkButton;
					Offset = 20;
					Value = SKM_OptionsFrameCheckButtons[26];
				};
				Right = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[27];
				};
			};
			[2] = {
				Left = {
					Type = _SKM._slider;
					Offset = 30;
					Value = SKM_OptionsFrameSliders[6];
				};
				Right = {
					Type = _SKM._slider;
					Offset = 40;
					Value = SKM_OptionsFrameSliders[7];
				};
			};
			[3] = {
				Left = nil;
				Right = {
					Type = _SKM._checkButton;
					Offset = 30;
					Value = SKM_OptionsFrameCheckButtons[31];
				};
			};
		};
	};

}

SKM_List_Options = { };


SKM_LISTFRAME_ROWS = 13;
SKM_LISTFRAME_ROWHEIGHT = 16;

SKM_DUELFRAME_ROWS = 13;
SKM_DUELFRAME_ROWHEIGHT = 16;

SKM_OPTIONFRAME_ROWS = 11;
SKM_OPTIONFRAME_ROWHEIGHT = 30;

-- lists contents
SKM_List_Content = { };
SKM_GuildList_Content = { };
SKM_DuelList_Content = { };

-- enemy list sort options
--SKM_List_SortType = "Name";
--SKM_List_SortTypes = { SKM_List_SortType };
--SKM_List_ReverseSort = false;

-- guild list sort options
--SKM_GuildList_SortType = "Name";
--SKM_GuildList_SortTypes = { SKM_GuildList_SortType };
--SKM_GuildList_ReverseSort = false;

-- duel list sort options
--SKM_DuelList_SortType = "Name";
--SKM_DuelList_SortTypes = { SKM_DuelList_SortType };
--SKM_DuelList_ReverseSort = false;

-- which of the two lists is currently active
SKM_List_ActiveList = _SKM._players;

-- remember the selected player or guild from the lists
SKM_List_SelectedPlayer = nil;
SKM_List_SelectedGuild = nil;

SKM_EditNoteContext = { List = nil, Element = nil };

SKM_LISTFRAME_DETAIL_ROWS = 8;
SKM_DUELFRAME_DETAIL_ROWS = 8;

SKM_BOOKFRAME_ROWS = 20;
SKM_BOOKFRAME_COLUMNS = 4;

SKM_BookPages = { };
SKM_BookCurPage = nil;
SKM_CurrentBook = nil;

SKM_BOOK_SEPARATOR = "_________________________________________________________________";


SKM_ActivePopup = false;



local SKMap_Original_ChatFrame_OnEvent;


--Stolen from TextFilter.lua
function SKMap_FilterChatEvent(event)
	chatEvents = {
		--possible filtered events
		"CHAT_MSG_SAY",
		"CHAT_MSG_YELL",
		"CHAT_MSG_PARTY",
		"CHAT_MSG_RAID",
		"CHAT_MSG_WHISPER",
		"CHAT_MSG_WHISPER_INFORM",
		"CHAT_MSG_EMOTE",
		"CHAT_MSG_TEXT_EMOTE",
		"CHAT_MSG_GUILD",
		"CHAT_MSG_OFFICER",
		"GUILD_MOTD",
		"CHAT_MSG_CHANNEL",
		"CHAT_MSG_SYSTEM",
	};
	for key,value in chatEvents do
		if(event == value) then
			return true;
		end
	end
	return false;
end


function SKMap_ChatFrame_OnEvent(event)
	SKMap_Original_ChatFrame_OnEvent(event); -- call the real ChatFrame_OnEvent function

	--if we haven't already done so, hook the AddMessage function
	if (not this.SKMap_ChatColor_Original_AddMessage) then
		this.SKMap_ChatColor_Original_AddMessage = this.AddMessage;
		this.AddMessage = SKMap_ChatColor_AddMessage;
	end
end


-- test
SKM_Karma = {
	["Tanae"] = { [_SKM._name] = "Tanae" };
	--["Lumen"] = { [_SKM._name] = "Lumen" };
	["Tyronia"] = { [_SKM._name] = "Tyronia" };
};


function SKMap_KarmaNameColor(sMsg)
	local sNewMsg = sMsg;
	local idx, val;
	for idx, val in SKM_Karma do
		local sName = val[_SKM._name];
		local red=255;
		local green=0;
		local blue=0;
		local sRep = string.format("|c00%02x%02x%02x%s|r", red, green, blue, sName);
		sNewMsg = string.gsub(sNewMsg, sName, sRep);
	end
	return sNewMsg;
end


function SKMap_ChatColor_AddMessage(this, msg, r, g, b, id)
	local FName = "SKMap_ChatColor_AddMessage";

	local sNewMsg = msg;

	if (SKMap_FilterChatEvent(event)) then
		--hmm, don't use SkM_Trace here or this would generate an infinite loop and a stack overflow :)
		--SkM_Trace(FName, 1, "r="..snil(r)..", g="..snil(g)..", b="..snil(b)..", msg="..snil(msg));
		--UIErrorsFrame:AddMessage("r="..snil(r)..", g="..snil(g)..", b="..snil(b)..", msg="..snil(msg), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

		for sStart, sPlayer, sEnd in string.gfind(msg, "(.*)|Hplayer:(.+)%[(.+)") do
			sNewMsg = sStart.."|Hplayer:"..sPlayer.."["..SKMap_KarmaNameColor(sEnd);
			this:SKMap_ChatColor_Original_AddMessage(sNewMsg, r, g, b, id);
			return;
		end

		-- pattern "|Hplayer:"... not found, so just replace in whole message
		sNewMsg = SKMap_KarmaNameColor(sNewMsg);
	end

	this:SKMap_ChatColor_Original_AddMessage(sNewMsg, r, g, b, id);
end



-- --------------------------------------------------------------------------------------
-- SKMap_OnLoad
-- --------------------------------------------------------------------------------------
-- Global OnLoad event for the loading frame.
-- Declare slash handlers.
-- Register all events we need.
-- Initialize module.
-- --------------------------------------------------------------------------------------
function SKMap_OnLoad()

	SlashCmdList["SKMAPCOMMAND"] = SKMap_SlashHandler;
	SLASH_SKMAPCOMMAND1 = "/skm";
	--SLASH_SKMAPCOMMAND2 = nil;


	-- Hook ChatFrame_OnEvent so we can hook AddMessage
	--SKMap_Original_ChatFrame_OnEvent = ChatFrame_OnEvent;
	--ChatFrame_OnEvent = SKMap_ChatFrame_OnEvent;


-- to respond to events (in OnEvent) you must first register to receive them
-- with this:RegisterEvent("EVENT_NAME").  A list of events can be found
-- at the cosmos site.  You can get to it directly by going through WoWWiki.com

-- If we've saved config variables, we'll almost always want to respond to
-- the variables loaded event.  Prior to this, the saved variables are NOT in
-- memory, don't try to use them.
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("PLAYER_ALIVE");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("CLOSE_WORLD_MAP");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");

	this:RegisterEvent("DUEL_FINISHED");
	this:RegisterEvent("DUEL_REQUESTED");	-- does not seem to be triggered at all !!
	this:RegisterEvent("CHAT_MSG_SYSTEM");



	--this:RegisterEvent("CHAT_MSG_CHANNEL");
	--this:RegisterEvent("GUILD_ROSTER_UPDATE");
	--this:RegisterEvent("GUILD_ROSTER_SHOW");
	--this:RegisterEvent("PLAYER_GUILD_UPDATE");


	-- to catch the ESC key
	tinsert(UISpecialFrames,"SKMapFrame");

	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(SKM_LOADED_MSG);
	end

	-- module initializations
	SkM_Initialize();

	--UIErrorsFrame:AddMessage(SKM_LOADED_MSG, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end


-- --------------------------------------------------------------------------------------
-- SKMap_OnEvent
-- --------------------------------------------------------------------------------------
-- Global OnEvent events caught by the loading frame
-- --------------------------------------------------------------------------------------
function SKMap_OnEvent()
	local FName = "SKMap_OnEvent";

	-- whatever the event is, check that data has been initialized
	-- (this doesn't do anything if it's the case)
	SkM_InitData(false);

	--SkM_Trace(FName, 0, event.." : arg1 = "..snil(arg1));

	-- This is called when one of the events we registered for actually fires
	-- the specific event is in the variable event
	if (event == "VARIABLES_LOADED") then

		if( DEFAULT_CHAT_FRAME ) then
			--DEFAULT_CHAT_FRAME:AddMessage("SKMap variables loaded");
		end

		SkM_Initialize();
		SkM_DataCleanUp();
		SkM_DataFixMapIndexes();
		SkM_DataModelMigration();
		SkM_MapShiftMigration();

		-- if the option has not been set at all yet, don't touch minimap icon
		if (SkM_GetOption("ShowMinimapButton") ~= nil) then
			SKMap_SetMiniMapIcon();
		end


	elseif (event == "UNIT_NAME_UPDATE") then

		-- ok, character has been loaded, here we can query his level !
		if (arg1 == SKM_UNIT_PLAYER) then
			SKM_Context.PlayerLevel = UnitLevel(SKM_UNIT_PLAYER);
		end

	elseif (event == "WORLD_MAP_UPDATE") then
		SkM_WorldMapUpdate();

	elseif ( event == "CLOSE_WORLD_MAP" ) then
		SkM_CloseWorldMap();

	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		SkM_BuildGroupList();

	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
		SkM_UpdateUnitData();
		SkM_SetTargetInfo();

	elseif ( event == "UPDATE_MOUSEOVER_UNIT" ) then
		SkM_MouseOverUnit();

	elseif (event == "UNIT_HEALTH") then
		if (arg1 == SKM_UNIT_TARGET) then
			SkM_TargetHealthUpdated();
		end

	elseif (event == "CHAT_MSG_COMBAT_XP_GAIN") then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_XpGain(arg1);

	elseif (event == "PLAYER_DEAD") then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_PlayerDeath();

	elseif (event == "PLAYER_ALIVE") then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_PlayerAlive();

	elseif (event == "PLAYER_LEVEL_UP") then
		SkM_PlayerLevelUp();

	elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_HostileDeath(arg1);

	elseif (	event == "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS" -- friend hits an enemy
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_FriendCombatHit(arg1);

	elseif (	event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" -- friend damages an enemy with a spell
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_FriendCombatSpell(arg1);

	elseif (	event == "CHAT_MSG_COMBAT_SELF_HITS" -- player hits an enemy
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_SelfCombatHit(arg1);

	elseif ( 	event == "CHAT_MSG_SPELL_SELF_DAMAGE" -- player damages an enemy with a spell
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_SelfCombatSpell(arg1);

	elseif (	event == "CHAT_MSG_COMBAT_PET_HITS"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_PetCombatHit(arg1);

	elseif ( 	event == "CHAT_MSG_SPELL_PET_DAMAGE"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_PetCombatSpell(arg1);

	elseif (	event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_EnemyCombatHit(arg1);

	elseif ( 	event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_EnemyCombatSpell(arg1);

	elseif (	event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_CreatureCombatHit(arg1);

	elseif ( 	event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_CreatureCombatSpell(arg1);

	elseif (	event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_EnemyDot(arg1);

	elseif (	event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
	) then
		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseCombatChat_SelfDot(arg1);

	elseif ( event == "CHAT_MSG_SYSTEM") then
		--SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_ParseDuelResult(arg1);

--	elseif (	event == "DUEL_FINISHED" or event == "DUEL_REQUESTED" or event == "DUEL_INBOUNDS" or event == "DUEL_OUTOFBOUNDS"
--		        or event == "CHAT_MSG" or event == "CHAT_MSG_SYSTEM"
--
--	) then
--		SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
--

	elseif (	event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
		SkM_Trace(FName, 0, event.." : arg1 = "..snil(arg1));

		SkM_ParseCombatChat_HonorKill(arg1);


	elseif (event == "GUILD_ROSTER_SHOW" or event == "GUILD_ROSTER_UPDATE" or event == "PLAYER_GUILD_UPDATE") then
	  SkM_Trace(FName, 1, event.." : arg1 = "..snil(arg1));
		SkM_BuildGuildList();

	else
		SkM_Trace(FName, 1, "Non handled event : "..event..", arg1 = "..snil(arg1));
	end

end


function SKMap_MiniMapIcon(frame, pPos, pRadius)
	frame:ClearAllPoints();
	frame:SetFrameLevel(Minimap:GetFrameLevel() + 10);
	frame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (pRadius * cos(pPos)), (pRadius * sin(pPos)) - 52);
end


function SKMap_MoveMiniMapIcon(iValue, iOffsetValue)
	local iPosition;

	if (not iValue) or (not iOffsetValue) then
		return;
	end

	iPosition = math.floor( (iValue / 100) * (377 - 256) ) + 256;

	--SKMap_MiniMapIcon(SKMapMinimapButton, iPosition, SKM_Config.MinimapButtonOffset);
	SKMap_MiniMapIcon(SKMapMinimapButton, iPosition, iOffsetValue);
end


function SKMap_SetMiniMapIcon(iPosition, iOffset)
	if (not SkM_GetOption("ShowMinimapButton")) then
		SKMapMinimapButton:Hide();
	else
		SKMapMinimapButton:Show();
		local iValue, iOffsetValue;
		if (iPosition) then
			iValue = iPosition;
		else
			iValue = SkM_GetOption("MinimapButtonPosition");
		end
		if (iOffset) then
			iOffsetValue = iOffset;
		else
			iOffsetValue = SkM_GetOption("MinimapButtonOffset");
		end
		SKMap_MoveMiniMapIcon(iValue, iOffsetValue);
	end
end


function SKMap_WorldMapPOI_OnEnter(id)
	local FName = "SKMap_OnEnter";

	SkM_InitData(false);
	SkM_WorldMapEnterPOI(id);
end

function SKMap_WorldMapPOI_OnLeave(id)
	local FName = "SKMap_OnLeave";

	SkM_InitData(false);
	SkM_WorldMapLeavePOI(id);
end



function SKMap_SlashHandler(msg)
	-- This function is called when a user types one of your slash commands
	-- the text they enter after the command comes in msg

	SkM_InitData(false);

	if ( ( not msg) or ( strlen(msg) <= 0 ) ) then
		SKMap_ToggleUI();
		return;
	end

	--UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);


	local sCmd, sParams = SkM_ExtractParam(msg);
	local sParamStr = sParams;

	if ( (sCmd) and (string.len(sCmd) > 0) ) then
		sCmd = string.lower(sCmd);
	else
		sCmd = "";
	end

	local iNbParam = 0;
	local sParam = {};
	while (sParams ~= "") do
		iNbParam = iNbParam + 1;
		sParam[iNbParam], sParams = SkM_ExtractParam(sParams);
	end

	if (SkM_IdentifyCommand(sCmd, "debug")) then
		local iLevel = -1;
		if (iNbParam == 0) then
			SkM_SetDebugLevel(iLevel);
		else

			if (sParam[1] == "startrec") then
				SkM_StartDebugRecord();
			elseif (sParam[1] == "stoprec") then
				SkM_StopDebugRecord();
			elseif (sParam[1] == "clearrec") then
				SkM_ClearDebugRecord();

			else
				if (sParam[1] ~= "off") then
					iLevel = tonumber(sParam[1]);
				end
				SkM_SetDebugLevel(iLevel);
			end

		end


	elseif (SkM_IdentifyCommand(sCmd, "war")) then
		if (iNbParam == 1) then
			local sName = sParam[1];
			SkM_UnknownEnemyWar(sName, true, true);
		else
			SkM_ChatMessageCol("Usage : /skm war <player name>");
		end

	elseif (SkM_IdentifyCommand(sCmd, "peace")) then
		if (iNbParam == 1) then
			local sName = sParam[1];
			SkM_UnknownEnemyWar(sName, false, true);
		else
			SkM_ChatMessageCol("Usage : /skm peace <player name>");
		end

	elseif (SkM_IdentifyCommand(sCmd, "swar")) then
		if (iNbParam == 0) then
			SkM_ShowUnknownEnemyWar();
		else
			SkM_ChatMessageCol("Usage : /skm swar");
		end

	elseif (SkM_IdentifyCommand(sCmd, "cwar")) then
		if (iNbParam == 0) then
			SkM_ClearUnknownEnemyWar();
		else
			SkM_ChatMessageCol("Usage : /skm cwar");
		end

	elseif (SkM_IdentifyCommand(sCmd, "inf")) then
		if (iNbParam >= 1) and (iNbParam <= 3) then
			local sName = sParam[1];
			local bMatchFullName = false;
			local bMatchSpecialChar = false;
			if (iNbParam >= 2) then
				if (sParam[2] == "1") then
					bMatchFullName = true;
				end
			end
			if (iNbParam >= 3) then
				if (sParam[3] == "1") then
					bMatchSpecialChar = true;
				end
			end
			SkM_GetEnemyInfo(sName, bMatchFullName, bMatchSpecialChar);
		else
			SkM_ChatMessageCol("Usage : /skm inf <player name> [<full name match> [<special char match>]]");
		end

	else
		SkM_ChatMessageCol("Unknown command");
	end

end


function SKMap_ToggleUI(tab)
	local FName = "SKMap_ToggleUI";
	SkM_InitData(false);

	if (not SKMapFrame) then
		SkM_ChatMessageCol("Error : SKMapFrame not loaded");
		return;
	end

	if (not tab) then
		if (SKMapFrame:IsVisible()) then
			HideUIPanel(SKMapFrame);
			--SKMapFrame:Hide();
		else
			ShowUIPanel(SKMapFrame);
			--SKMapFrame:Show();

			local selectedFrameName = SKM_TAB_SUBFRAMES[SKMapFrame.selectedTab];
			SkM_Trace(FName, 1, "Selected frame name = "..snil(selectedFrameName));

			local selectedFrame = getglobal(selectedFrameName);

-- NCHNCH : the following line sometimes generates error because selectedFrame is nil !!!
-- then it's required to ReloadUI();
-- see if there's a solution !
			if ( not selectedFrame:IsVisible() ) then
				selectedFrame:Show()
			end
		end
	else

		local subFrame = getglobal(tab);
		if ( subFrame ) then
			PanelTemplates_SetTab(SKMapFrame, subFrame:GetID());
			if ( SKMapFrame:IsVisible() ) then
				if ( subFrame:IsVisible() ) then
					HideUIPanel(SKMapFrame);
				else
					PlaySound("igCharacterInfoTab");
					SKMap_ShowSubFrame(tab);
				end
			else
				ShowUIPanel(SKMapFrame);
				SKMap_ShowSubFrame(tab);
			end
		end
	end

end


function SKMap_ShowSubFrame(frameName)
	local FName = "SKMap_ShowSubFrame";

	for index, value in SKM_TAB_SUBFRAMES do
		MyFrame = getglobal(value);
		if (MyFrame) then
			if ( value == frameName ) then
				MyFrame:Show();
			else
				MyFrame:Hide();
			end
		end
	end
end


function SKMapFrame_OnLoad()
  	-- Tab Handling code
  	PanelTemplates_SetNumTabs(this, 4);
  	PanelTemplates_SetTab(this, 1);
  	--PanelTemplates_DisableTab(this, 4);
end


function SKMapFrame_OnShow()
  	PlaySound("igCharacterInfoOpen");
end


function SKMapFrame_OnHide()
  	PlaySound("igCharacterInfoClose");
end


function SKMapTab_OnClick()
	local FName = "SKMapTab_OnClick";

	local TabName = this:GetName();

	SkM_Trace(FName, 1, "Tab Name = "..snil(TabName));

	if (TabName == "SKMapFrameTab1") then
		SKMap_ToggleUI("SKMap_ListFrame");
	elseif (TabName == "SKMapFrameTab2") then
		SKMap_ToggleUI("SKMap_DuelFrame");
	elseif (TabName == "SKMapFrameTab3") then
		SKMap_ToggleUI("SKMap_ReportFrame");
	elseif (TabName == "SKMapFrameTab4") then
		SKMap_ToggleUI("SKMap_OptionsFrame");
	else
		SkM_Trace(FName, 1, "Unknown tab : "..snil(TabName));
	end

	PlaySound("igCharacterInfoTab");
end


function SKMap_SetCheckOption(i, OptionDef, Column)
	local MyCheckButton = getglobal("SKMap_Options_Button"..i..Column.."Check");
	local CheckText = getglobal("SKMap_Options_Button"..i..Column.."Check".."Text");

	local Option = OptionDef.Value;

	local bValue = SkM_GetOption(Option.Option);
	CheckText:SetText(Option.Text);
	MyCheckButton.tooltipText = Option.Tooltip;

	if (bValue) then
		checked = 1;
	else
		checked = 0;
	end
	MyCheckButton:SetChecked(checked);

	--SKMapSmallTargetInfoFrame:SetPoint("TOPLEFT","SKMapTargetInfoFrame","TOPLEFT",0,0);
	MyCheckButton:SetPoint("TOPLEFT", "SKMap_Options_Button"..i..Column, "TOPLEFT", OptionDef.Offset, 1);

	MyCheckButton:Show();
end

function SKMap_SetSliderOption(i, OptionDef, Column)
	local MySlider = getglobal("SKMap_Options_Button"..i..Column.."Slider");
	local SliderText = getglobal("SKMap_Options_Button"..i..Column.."Slider".."Text");

	local Option = OptionDef.Value;
	local iValue = ifnil(SkM_GetOption(Option.Option), 0);

	MySlider:SetMinMaxValues(Option.minValue, Option.maxValue);
	MySlider:SetValueStep(Option.valueStep);
	MySlider:SetValue(iValue);
	MySlider.tooltipText = Option.Tooltip;
	SliderText:SetText(iValue);

	MySlider:SetPoint("TOPLEFT", "SKMap_Options_Button"..i..Column, "TOPLEFT", OptionDef.Offset, 1);

	MySlider:Show();
end



function HideLineOption(i)
	local OptionLabel = getglobal("SKMap_Options_Button"..i.."Label");
	local MySlider = getglobal("SKMap_Options_Button"..i.."Slider");
	local MyCheckButton = getglobal("SKMap_Options_Button"..i.."Check");
	local MyIconTexture = getglobal("SKMap_Options_Button"..i.."IconTexture");

	OptionLabel:Hide();
	MySlider:Hide();
	MyCheckButton:Hide();
	MyIconTexture:Hide();

	local OptionLabelR = getglobal("SKMap_Options_Button"..i.."R".."Label");
	local MySliderR = getglobal("SKMap_Options_Button"..i.."R".."Slider");
	local MyCheckButtonR = getglobal("SKMap_Options_Button"..i.."R".."Check");
	local MyIconTextureR = getglobal("SKMap_Options_Button"..i.."R".."IconTexture");

	OptionLabelR:Hide();
	MySliderR:Hide();
	MyCheckButtonR:Hide();
	MyIconTextureR:Hide();
end

function SKMap_GetOptionLineCount()
	local iCount = 0;
	for i=1,table.getn(SKM_OptionsList),1 do
		if (SKM_OptionsList[i].Expanded) then
			iCount = iCount + table.getn(SKM_OptionsList[i].Lines) + 2;
		else
			iCount = iCount + 1;
		end
	end
	return iCount;
end

function SKMap_OptionsFrame_Load()
	local FName = "SKMap_OptionsFrame_Load";

	SkM_Trace(FName, 4, "Loading frame options values");

	local iScrollOffset = FauxScrollFrame_GetOffset(SKMap_OptionsScrollFrame);

	SkM_Trace(FName, 0, "Scroll offset = "..snil(iScrollOffset));

	local iSkipped = 0;

	SKM_List_Options = { };

	local i;
	for i=1,SKM_OPTIONFRAME_ROWS, 1 do
		HideLineOption(i);
	end

	local iOptionCateg = 1;
	local iOptionElem = 0;
	local i = 0;
	while (true) do
		i = i + 1;
		if (i > SKM_OPTIONFRAME_ROWS) then
			do break end;
		end


		if (iOptionCateg > table.getn(SKM_OptionsList)) then
			do break end;
		end

		if (iOptionCateg <= table.getn(SKM_OptionsList)) then

			-- initially set all categories to expanded mode
			if (SKM_OptionsList[iOptionCateg].Expanded == nil) then
				SKM_OptionsList[iOptionCateg].Expanded = true;
			end

			local bSkip = false;

			if (iSkipped < iScrollOffset) then
				iSkipped = iSkipped + 1;
				i = i - 1;
				bSkip = true;
			end

			if (iOptionElem == -1) then
				-- skip line
				iOptionElem = iOptionElem + 1;
			elseif (iOptionElem == 0) then

				if (not bSkip) then
					-- set category label
					local OptionLabel = getglobal("SKMap_Options_Button"..i.."Label");
					local MyIconTexture = getglobal("SKMap_Options_Button"..i.."IconTexture");

					OptionLabel:SetText(SKM_OptionsList[iOptionCateg].Title.Text);
					OptionLabel:Show();

					local sTexture;
					if (SKM_OptionsList[iOptionCateg].Expanded) then
						--sTexture = SKM_Config.IconPath.."\\"..SKM_Config.Buttons.CollapseButton;
						sTexture = "Interface\\Buttons\\UI-MinusButton-Up"
					else
						--sTexture = SKM_Config.IconPath.."\\"..SKM_Config.Buttons.ExpandButton;
						sTexture = "Interface\\Buttons\\UI-PlusButton-Up"
					end
					MyIconTexture:SetTexture(sTexture);

					--MyIconTexture:SetTexture("Interface\\Buttons\\UI-MinusButton-Up");
					--MyIconTexture:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");

					MyIconTexture:Show();

					SKM_List_Options[i] = { };
					SKM_List_Options[i].Category = iOptionCateg;
				end

				if (SKM_OptionsList[iOptionCateg].Expanded) then
					iOptionElem = iOptionElem + 1;
				else
					iOptionCateg = iOptionCateg + 1;
				end

			else

				local Line = SKM_OptionsList[iOptionCateg].Lines[iOptionElem];
				if (Line and (not bSkip)) then

					SKM_List_Options[i] = { };

					if (Line.Left) then
						SKM_List_Options[i].Left = Line.Left.Value.Option;

						if (Line.Left.Type == _SKM._checkButton) then
							SKMap_SetCheckOption(i, Line.Left, "");
						elseif (Line.Left.Type == _SKM._slider) then
							SKMap_SetSliderOption(i, Line.Left, "");
						end

					end
					if (Line.Right) then
						SKM_List_Options[i].Right = Line.Right.Value.Option;

						if (Line.Right.Type == _SKM._checkButton) then
							SKMap_SetCheckOption(i, Line.Right, "R");
						elseif (Line.Right.Type == _SKM._slider) then
							SKMap_SetSliderOption(i, Line.Right, "R");
						end
					end

				end
				iOptionElem = iOptionElem + 1;

				if (iOptionElem > table.getn(SKM_OptionsList[iOptionCateg].Lines)) then
					iOptionElem = -1;
					iOptionCateg = iOptionCateg + 1;
				end


			end

		end
	end

	local iLineCount = SKMap_GetOptionLineCount() + 1;
	SkM_Trace(FName, 3, "Option Lines = "..snil(iLineCount));

	FauxScrollFrame_Update(SKMap_OptionsScrollFrame, iLineCount, SKM_OPTIONFRAME_ROWS, SKM_OPTIONFRAME_ROWHEIGHT);
end



function SKMap_OptionsFrame_Load_old()
	local FName = "SKMap_OptionsFrame_Load";

	SkM_Trace(FName, 2, "Loading frame options values");

	-- check buttons
	for idx, val in SKM_OptionsFrameCheckButtons do
		local bValue = SkM_GetOption(val.Option);

		SkM_Trace(FName, 3, "Option : "..snil(val.Option)..", Value = "..snil(bValue));

		local MyButton = getglobal("SKMap_OptionsFrameCheckButton"..idx);
		local ButtonText = getglobal("SKMap_OptionsFrameCheckButton"..idx.."Text");
		local checked;

		ButtonText:SetText(val.Text);
		MyButton.tooltipText = val.Tooltip;

		if (bValue) then
			checked = 1;
		else
			checked = 0;
		end

		MyButton:SetChecked(checked);

	end

	-- sliders
	for idx, val in SKM_OptionsFrameSliders do
		local iValue = ifnil(SkM_GetOption(val.Option), 0);

		local MySlider = getglobal("SKMap_OptionsFrameSlider"..idx);
		local SliderText = getglobal("SKMap_OptionsFrameSlider"..idx.."Text");

		MySlider:SetMinMaxValues(val.minValue, val.maxValue);
		MySlider:SetValueStep(val.valueStep);
		MySlider:SetValue(iValue);
		MySlider.tooltipText = val.Tooltip;
		SliderText:SetText(iValue);

	end

	-- labels
	for idx, val in SKM_OptionFrameLabels do

		local MyLabel = getglobal("SKMap_OptionsFrameLabel"..idx.."Text");

		MyLabel:SetText(val.Text);
	end

end



-- obsolete in 1.1.4
function SKMap_OptionsFrame_Save()
	local FName = "SKMap_OptionsFrame_Save";
	local MyButton;

	SkM_Trace(FName, 1, "Saving options");

	-- check buttons
	for idx, val in SKM_OptionsFrameCheckButtons do
		local MyButton = getglobal("SKMap_OptionsFrameCheckButton"..idx);

		if (not MyButton:GetChecked()) then
			SkM_SetOption(val.Option, false);
		else
			SkM_SetOption(val.Option, true);
		end
	end

	-- sliders
	for idx, val in SKM_OptionsFrameSliders do
		local MySlider = getglobal("SKMap_OptionsFrameSlider"..idx);
		local iValue = MySlider:GetValue();

		SkM_SetOption(val.Option, iValue);
	end

end


function SKMap_OptionsFrame_Cancel()
	SKMap_OptionsFrame_Load();
end


-- obsolete since 1.1.4
function SKMap_SetSliderTextToValue()
	local FName = "SKMap_SetSliderTextToValue";

	local SliderName = this:GetName();
	SkM_Trace(FName, 4, "Slider name = "..SliderName);

	local MySlider = getglobal(SliderName);
	local SliderText = getglobal(SliderName.."Text");

	iValue = MySlider:GetValue();
	SliderText:SetText(iValue);


	if (SliderName == "SKMap_OptionsFrameSlider3") then
		SkM_SetOption("MinimapButtonPosition", iValue);
		--SKMap_SetMiniMapIcon(iValue);
		SKMap_SetMiniMapIcon();
	end

	if (SliderName == "SKMap_OptionsFrameSlider4") then
		SkM_SetOption("MinimapButtonOffset", iValue);
		--SKMap_SetMiniMapIcon(iValue);
		SKMap_SetMiniMapIcon();
	end

end


function SKMap_MinimapOption()
	local FName = "SKMap_MinimapOption";

	local OptionName = this:GetName();
	SkM_Trace(FName, 4, "Option name = "..OptionName);

	local MyButton = getglobal(OptionName);

	if (not MyButton:GetChecked()) then
		SkM_SetOption("ShowMinimapButton", false);

	else
		SkM_SetOption("ShowMinimapButton", true);
	end
	SKMap_SetMiniMapIcon();

end


function SKMap_ListFrame_Load()
	local FName = "SKMap_ListFrame_Load";

	SkM_Trace(FName, 1, "Loading ListFrame");

	local idx = 1;
	local MyButton = getglobal("SKMap_ListFrameCheckButton"..idx);
	local ButtonText = getglobal("SKMap_ListFrameCheckButton"..idx.."Text");
	ButtonText:SetText(SKM_UI_STRINGS.List_Button_FilterNoWar);
	MyButton.tooltipText = SKM_UI_STRINGS.List_Tooltip_FilterNoWar;

	if (SKM_List_ActiveList == _SKM._players) then

		if (SKMap_PlayerListUpdateNeeded()) then
			SKMap_SetListContent();
			SKMap_ListFrame_UpdateList();
			SKMap_ListFrame_SortList();
		end

	elseif (SKM_List_ActiveList == _SKM._guilds) then
		SKMap_SetGuildListContent();
		SKMap_ListFrame_UpdateGuildList();
		SKMap_ListFrame_SortGuildList();
	end


end


function SKMap_Column_SetWidth(width, frame)
	if ( not frame ) then
		frame = this;
	end
	frame:SetWidth(width);
	getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
end



function SKMap_ListFrame_UpdateList()
	local FName = "SKMap_ListFrame_UpdateList";

	local iScrollOffset = FauxScrollFrame_GetOffset(SKMap_ListScrollFrame);

	SkM_Trace(FName, 4, "Scrollbar offset = "..snil(iScrollOffset));


	local iEnemyCount = table.getn(SKM_List_Content);
	SkM_Trace(FName, 4, "Enemy Count = "..snil(iEnemyCount));

	local iEnemyIndex = iScrollOffset + 1;

	SkM_Trace(FName, 4, "Enemy Index = "..snil(iEnemyIndex));

	local i;
	for i=1, SKM_LISTFRAME_ROWS, 1 do
		local RowButton = getglobal("SKMap_ListFrameButton"..i);

		if (iEnemyIndex <= iEnemyCount) then

			RowButtonName = getglobal("SKMap_ListFrameButton"..i.."Name");
			RowButtonGuild = getglobal("SKMap_ListFrameButton"..i.."Guild");
			RowButtonLevel = getglobal("SKMap_ListFrameButton"..i.."Level");
			RowButtonRace = getglobal("SKMap_ListFrameButton"..i.."Race");
			RowButtonClass = getglobal("SKMap_ListFrameButton"..i.."Class");
			RowButtonKill = getglobal("SKMap_ListFrameButton"..i.."Kill");
			RowButtonDeath = getglobal("SKMap_ListFrameButton"..i.."Death");
			RowButtonMet = getglobal("SKMap_ListFrameButton"..i.."Met");
			RowButtonLastSeen = getglobal("SKMap_ListFrameButton"..i.."LastSeen");
			RowButtonAtWar = getglobal("SKMap_ListFrameButton"..i.."AtWar");

			local sName = ifnil(SKM_List_Content[iEnemyIndex][_SKM._name], "??");
			local sGuild = ifnil(SKM_List_Content[iEnemyIndex][_SKM._guild], "??");
			local sLevel = ifnil(SKM_List_Content[iEnemyIndex][_SKM._level], "??");

			local sRace = ifnil(SKM_List_Content[iEnemyIndex][_SKM._race], "??");
			local sClass = ifnil(SKM_List_Content[iEnemyIndex][_SKM._class], "??");
			local sLastSeen = ifnil(SKM_List_Content[iEnemyIndex][_SKM._lastView], "??");

			local bAtWar = SKM_List_Content[iEnemyIndex][_SKM._atWar];

			local sGuild = SKM_List_Content[iEnemyIndex][_SKM._guild];

			local Guild;
			if (sGuild ~= nil) and (sGuild ~= "") then
				Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuild];
			end

			local bGuildWar;
			if (Guild) then
				bGuildWar = Guild[_SKM._atWar];
			end

			if (bAtWar) then
				sName = SKM_Config.Col_PlayerWar..sName;
			end
			if (bGuildWar) then
				sGuild = SKM_Config.Col_PlayerWar..sGuild;
			end

			local sWar = "";
			-- 0.08.1 Begin of modification: localization
			if (bAtWar and bGuildWar) then
				sWar = SKM_Config.Col_PlayerWar..SKMAP_COLUMN_ATWAR_ALL;
			elseif (bAtWar) then
				sWar = SKM_Config.Col_PlayerWar..SKMAP_COLUMN_ATWAR_PLAYER;
			elseif (bGuildWar) then
				sWar = SKM_Config.Col_PlayerWar..SKMAP_COLUMN_ATWAR_GUILD;
			end
			-- 0.08.1 End of modification: localization


			local iKill = ifnil(SKM_List_Content[iEnemyIndex][_SKM._playerKill], 0) + ifnil(SKM_List_Content[iEnemyIndex][_SKM._playerAssistKill], 0) + ifnil(SKM_List_Content[iEnemyIndex][_SKM._playerFullKill], 0);
			local iDeath = ifnil(SKM_List_Content[iEnemyIndex][_SKM._enemyKillPlayer], 0);
			local iMet = ifnil(SKM_List_Content[iEnemyIndex][_SKM._meetCount], 0);

			if (sLevel == -1) then
				sLevel = "++";
			end

			RowButtonName:SetText(sName);
			RowButtonGuild:SetText(sGuild);
			RowButtonLevel:SetText(sLevel);
			RowButtonRace:SetText(sRace);
			RowButtonClass:SetText(sClass);

			RowButtonKill:SetText(iKill);
			RowButtonDeath:SetText(iDeath);
			RowButtonMet:SetText(iMet);
			RowButtonLastSeen:SetText(sLastSeen);
			RowButtonAtWar:SetText(sWar);

			RowButton:Show();

			iEnemyIndex = iEnemyIndex + 1;
		else
			RowButton:Hide();
		end
	end

	FauxScrollFrame_Update(SKMap_ListScrollFrame, iEnemyCount, SKM_LISTFRAME_ROWS, SKM_LISTFRAME_ROWHEIGHT);
end


function SKMap_List_CompareElem(v1, v2, ReverseSort)
	local FName = "SKMap_List_CompareElem";

	SkM_Trace(FName, 4, "v1 = "..snil(v1));
	SkM_Trace(FName, 4, "v2 = "..snil(v2));

	if (v1 == nil) and (v2 ~= nil) then
		return true;
	elseif (v2 == nil) and (v1 ~= nil) then
		return false;
	elseif (v1 ~= nil) and (v2 ~= nil) then

		if (ReverseSort) then
			if (v1 < v2) then
				return false;
			elseif (v2 < v1) then
				return true;
			end
		else
			if (v1 < v2) then
				return true;
			elseif (v2 < v1) then
				return false;
			end
		end
	end

	return;
end


function SKMap_ListFrame_SubSort(e1, e2, SortType, ReverseSort)
	local FName = "SKMap_ListFrame_SubSort";

	SkM_Trace(FName, 4, "SortType = "..snil(SortType));

	if (SortType == "Name") then
		--local sName1 = string.upper(e1[_SKM._name]);
		local sName1 = SkM_NormalizeString(e1[_SKM._name]);
		--local sName2 = string.upper(e2[_SKM._name]);
		local sName2 = SkM_NormalizeString(e2[_SKM._name]);
		local bCmp = SKMap_List_CompareElem(sName1, sName2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Guild") then
		-- some dumb people started their guild name with a lowercase character. convert it to upper
		-- before sorting
		--local sGuild1 = string.upper(ifnil(e1[_SKM._guild], "??"));
		local sGuild1 = SkM_NormalizeString(ifnil(e1[_SKM._guild], "??"));
		--local sGuild2 = string.upper(ifnil(e2[_SKM._guild], "??"));
		local sGuild2 = SkM_NormalizeString(ifnil(e2[_SKM._guild], "??"));
		local bCmp = SKMap_List_CompareElem(sGuild1, sGuild2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Level") then
		local iLevel1 = ifnil(e1[_SKM._level], 0);
		local iLevel2 = ifnil(e2[_SKM._level], 0);
		if (iLevel1 == -1) then
			iLevel1 = 500;
		end
		if (iLevel2 == -1) then
			iLevel2 = 500;
		end
		local bCmp = SKMap_List_CompareElem(iLevel1, iLevel2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Race") then
		local bCmp = SKMap_List_CompareElem(ifnil(e1[_SKM._race], ""), ifnil(e2[_SKM._race], ""), ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Class") then
		local bCmp = SKMap_List_CompareElem(ifnil(e1[_SKM._class], ""), ifnil(e2[_SKM._class], ""), ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Kill") then
		local iKill1 = ifnil(e1[_SKM._playerKill], 0) + ifnil(e1[_SKM._playerAssistKill], 0) + ifnil(e1[_SKM._playerFullKill], 0);
		local iKill2 = ifnil(e2[_SKM._playerKill], 0) + ifnil(e2[_SKM._playerAssistKill], 0) + ifnil(e2[_SKM._playerFullKill], 0);

		local bCmp = SKMap_List_CompareElem(iKill1, iKill2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Death") then
		local iDeath1 = ifnil(e1[_SKM._enemyKillPlayer], 0);
		local iDeath2 = ifnil(e2[_SKM._enemyKillPlayer], 0);

		local bCmp = SKMap_List_CompareElem(iDeath1, iDeath2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Met") then
		local iMet1 = ifnil(e1[_SKM._meetCount], 0);
		local iMet2 = ifnil(e2[_SKM._meetCount], 0);

		local bCmp = SKMap_List_CompareElem(iMet1, iMet2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "LastSeen") then
		local sDate1 = SkM_GetSortableDate(e1[_SKM._lastView]);
		local sDate2 = SkM_GetSortableDate(e2[_SKM._lastView]);

		local bCmp = SKMap_List_CompareElem(ifnil(sDate1, ""), ifnil(sDate2, ""), ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "AtWar") then
		local sWar1 = "";
		local sWar2 = "";
		if (e1[_SKM._atWar]) or (e1[_SKM._guildAtWar]) then
			sWar1 = "WAR";
		end
		if (e2[_SKM._atWar]) or (e2[_SKM._guildAtWar]) then
			sWar2 = "WAR";
		end

		local bCmp = SKMap_List_CompareElem(sWar1, sWar2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Members") then
		local iMembers1 = ifnil(e1[_SKM._members], 0);
		local iMembers2 = ifnil(e2[_SKM._members], 0);

		local bCmp = SKMap_List_CompareElem(iMembers1, iMembers2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Win") then
		local iWin1 = ifnil(e1[_SKM._win], 0);
		local iWin2 = ifnil(e2[_SKM._win], 0);

		local bCmp = SKMap_List_CompareElem(iWin1, iWin2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Loss") then
		local iLoss1 = ifnil(e1[_SKM._loss], 0);
		local iLoss2 = ifnil(e2[_SKM._loss], 0);

		local bCmp = SKMap_List_CompareElem(iLoss1, iLoss2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Duel") then
		local iDuel1 = ifnil(e1[_SKM._duel], 0);
		local iDuel2 = ifnil(e2[_SKM._duel], 0);

		local bCmp = SKMap_List_CompareElem(iDuel1, iDuel2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "LastDuel") then
		local sDate1 = SkM_GetSortableDate(e1[_SKM._lastDuel]);
		local sDate2 = SkM_GetSortableDate(e2[_SKM._lastDuel]);

		local bCmp = SKMap_List_CompareElem(ifnil(sDate1, ""), ifnil(sDate2, ""), ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	elseif (SortType == "Score") then
		local iScore1 = ifnil(e1[_SKM._score], 0);
		local iScore2 = ifnil(e2[_SKM._score], 0);

		local bCmp = SKMap_List_CompareElem(iScore1, iScore2, ReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end

	end
	return nil;
end


function SKMap_ListFrame_Sort(e1, e2)
	local FName = "SKMap_ListFrame_Sort";

	SkM_Trace(FName, 4, "Begin");

	if (e1 == nil) then
		if (e2 == nil) then
			return false;
		else
			return true;
		end
	elseif (e2 == nil) then
		return false;
	end

	--local iSortTypes = table.getn(SKM_List_SortTypes);
	local iSortTypes = table.getn( SkM_GetOption("EnemyList_SortTypes") );

	local i;
	for i=1, iSortTypes, 1 do
		local bReverseSort = false;
		--if (i == 1) and (SKM_List_ReverseSort == true) then
		if (i == 1) and ( SkM_GetOption("EnemyList_ReverseSort") ) then
			bReverseSort = true;
		end
		--local bCmp = SKMap_ListFrame_SubSort(e1, e2, SKM_List_SortTypes[i], bReverseSort);
		local bCmp = SKMap_ListFrame_SubSort(e1, e2, SkM_GetOption("EnemyList_SortTypes")[i], bReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end
	end
	return false;
end


function SKMap_ListFrame_SortList(sSortType)
	local FName = "SKMap_ListFrame_SortList";

	if (sSortType) then
		--if (sSortType == SKM_List_SortType) then
		if (sSortType == SkM_GetOption("EnemyList_SortType")) then
			--if (SKM_List_ReverseSort) then
			if ( SkM_GetOption("EnemyList_ReverseSort") ) then
				--SKM_List_ReverseSort = false;
				SkM_SetOption("EnemyList_ReverseSort", false);
			else
				--SKM_List_ReverseSort = true;
				SkM_SetOption("EnemyList_ReverseSort", true);
			end
		else
			--SKM_List_SortType = sSortType;
			SkM_SetOption("EnemyList_SortType", sSortType);

			--SKM_List_SortTypes = removefromlist(sSortType, SKM_List_SortTypes);
			SKM_Settings.EnemyList_SortTypes = removefromlist(sSortType, SkM_GetOption("EnemyList_SortTypes") );
			--table.insert(SKM_List_SortTypes, 1, sSortType);
			table.insert(SKM_Settings.EnemyList_SortTypes, 1, sSortType);
		end
	end

	if (SKM_List_Content) then
		table.sort(SKM_List_Content, SKMap_ListFrame_Sort);
	end

	SKMap_ListFrame_UpdateList();
end


function SKMap_SetListContent()
	local FName = "SKMap_SetListContent";

	SKM_List_Content = { };

	local idx, val;
	for idx, val in SKM_Data[_RealmName][_PlayerName].EnemyHistory do
		local Elem = copytable(val);

		if (Elem[_SKM._guild] == "not in a guild") then
			SKM_Data[_RealmName][_PlayerName].EnemyHistory[idx][_SKM._guild] = "";
		end

		Elem[_SKM._class] = SkM_GetClassText(Elem[_SKM._class]);
		Elem[_SKM._race] = SkM_GetRaceText(Elem[_SKM._race]);

		-- also retrieve guild "at war" status
		local Guild;
		if (Elem[_SKM._guild] ~= nil) and (Elem[_SKM._guild] ~= "") then
			Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[val[_SKM._guild]];
		end
		if (Guild) and (Guild[_SKM._atWar]) then
			Elem[_SKM._guildAtWar] = true;
		end

		-- check if element has to be filtered out or not
		local bFilter = false;
		if (SKM_Config.FilterNotAtWar == true) then
			if ( not ((Elem[_SKM._atWar]) or (Elem[_SKM._guildAtWar])) ) then
				bFilter = true;
			end
		end

		if (bFilter == false) then
			table.insert(SKM_List_Content, Elem);
		end
	end

end


function SKMap_ListFrame_SelectElement(sPlayerName)
	local FName = "SKMap_ListFrame_SelectElement";

	local sName;

	if (sPlayerName ~= nil) then
		sName = sPlayerName;
	else
		local id = this:GetID();
		local iScrollOffset = FauxScrollFrame_GetOffset(SKMap_ListScrollFrame);
		local iEnemyCount = table.getn(SKM_List_Content);

		SkM_Trace(FName, 3, "Scroll offset = "..iScrollOffset);
		SkM_Trace(FName, 3, "Line id = "..id);

		local iEnemyIndex = iScrollOffset + id;
		SkM_Trace(FName, 3, "Enemy Index = "..iEnemyIndex);

		if (iEnemyIndex <= iEnemyCount) then
			sName = SKM_List_Content[iEnemyIndex][_SKM._name];
		end

	end

	local Enemy;
	if (sName ~= nil) then
		Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
	end

	local Lines = { };

	if (Enemy ~= nil) then
		SKM_List_SelectedPlayer = sName;

		local Guild;

		local sGuild = ifnil(Enemy[_SKM._guild], "??");
		local sLevel = ifnil(Enemy[_SKM._level], "??");
		local sRace = ifnil(SkM_GetRaceText(Enemy[_SKM._race]), "??");
		local sClass = ifnil(SkM_GetClassText(Enemy[_SKM._class]), "??");
		local sLastSeen = ifnil(Enemy[_SKM._lastView], "??");

		local iKill = ifnil(Enemy[_SKM._playerKill], 0);
		local iAssistKill = ifnil(Enemy[_SKM._playerAssistKill], 0);
		local iFullKill = ifnil(Enemy[_SKM._playerFullKill], 0);
		local iTotalKill = iKill + iAssistKill + iFullKill;
		local iDeath = ifnil(Enemy[_SKM._enemyKillPlayer], 0);
		local iMet = ifnil(Enemy[_SKM._meetCount], 0);
		local iLoneWolf = ifnil(Enemy[_SKM._loneWolfKill], 0);
		local iBGKill = ifnil(Enemy[_SKM._playerBGKill], 0);
		local iBGDeath = ifnil(Enemy[_SKM._enemyKillBG], 0);

		if (sLevel == -1) then
			sLevel = "++";
		end

		local bAtWar;
		if (Enemy[_SKM._atWar]) then
			bAtWar = true;
		else
			bAtWar = false;
		end

		SKMap_ListFrame_ShowWarButton(bAtWar);

		local bGuildWar;
		if (Enemy[_SKM._guild] ~= nil) and (Enemy[_SKM._guild] ~= "") then
			Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuild];
		end
		if (Guild ~= nil) then
			bGuildWar = Guild[_SKM._atWar];
			SKMap_ListFrame_ShowPlayerGuildButton:Show();
		else
			SKMap_ListFrame_ShowPlayerGuildButton:Hide();
		end

		SKMap_ListFrame_EditNote:Show();
		SKMap_ListFrame_ReportButton:Show();
		SKMap_ListFrame_DeleteButton:Show();
		SKMap_ListFrame_BackToPlayersButton:Hide();

		-- line 1 : player name and (optional) war status
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Player; -- 0.08.2 Add localization
		if (Enemy[_SKM._rank]) then
			sLine = sLine..SKM_Config.Col_Rank..Enemy[_SKM._rank].." ";
		end
		if (bAtWar) then
			sLine = sLine..SKM_Config.Col_PlayerWar;
		else
			sLine = sLine..SKM_Config.Col_Label;
		end
		sLine = sLine..sName..SKM_Config.Col_Label;
		if (bAtWar) then
			sLine = sLine.."  -  "..SKM_Config.Col_PlayerWar..SKM_UI_STRINGS.Small_Target_War;
			if (Enemy[_SKM._warDate]) then
				--local sDisplayDate = string.sub(Enemy[_SKM._warDate], 1, 10);
				local sDisplayDate = Enemy[_SKM._warDate];
				sLine = sLine.." "..SKM_UI_STRINGS.Since..sDisplayDate;
			end
		end

		table.insert(Lines, sLine);


		-- line 2 (optional) : player guild and (optional) war status
		if (Guild ~= nil) then

			local sLine = "";
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Guild; -- 0.08.2 Add localization

			if (bGuildWar) then
				sLine = sLine..SKM_Config.Col_PlayerWar;
			else
				sLine = sLine..SKM_Config.Col_Label;
			end

			sLine = sLine..sGuild..SKM_Config.Col_Label;
			if (bGuildWar) then
				sLine = sLine.."  -  "..SKM_Config.Col_PlayerWar..SKM_UI_STRINGS.Small_Target_War;
				if (Guild[_SKM._warDate]) then
					--local sDisplayDate = string.sub(Guild[_SKM._warDate], 1, 10);
					local sDisplayDate = Guild[_SKM._warDate];
					sLine = sLine.." "..SKM_UI_STRINGS.Since..sDisplayDate;
				end
				--sLine = sLine..SKM_Config.Col_Label.."]";
			end

			table.insert(Lines, sLine);
		end


		-- line 3 (optional, not shown if info not available) : level race class
		if (Enemy[_SKM._level] ~= nil) and (Enemy[_SKM._race] ~= nil) and (Enemy[_SKM._class] ~= nil) then

			local sLine = "";
			sLine = sLine..SKM_Config.Col_Label..SKM_UI_STRINGS.List_Frame_Level..sLevel.." "..sRace.." "..sClass; -- 0.08.2 Add localization

			table.insert(Lines, sLine);
		end


		-- line 4 : last seen time and location
		if (Enemy[_SKM._lastView] ~= nil) then

			local sLine = "";

			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Last_Seen; -- 0.08.2 Add localization
			sLine = sLine..SKM_Config.Col_Label..Enemy[_SKM._lastView];

			if (Enemy[_SKM._continent] ~= nil) and (Enemy[_SKM._zone] ~= nil) then
				--local sZoneText = SKM_Context.Zones[Enemy[_SKM._continent]][Enemy[_SKM._zone]];
				local sZoneText = SkM_GetZoneTextFromIndex(Enemy[_SKM._continent], Enemy[_SKM._zone]);
				sLine = sLine.." - "..sZoneText;
			elseif (Enemy[_SKM._zoneName] ~= nil) then
				sLine = sLine.." - "..Enemy[_SKM._zoneName];
			end

			table.insert(Lines, sLine);
		end


		-- line 5 : last update time (optional, only if different from last seen time)
--		if (Enemy[_lastUpdate] ~= nil) and (not Enemy[_lastUpdate] == Enemy[_SKM._lastView]) then
--			local sLine = "";
--			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Last_Updated; -- 0.08.2 Add localization
--			sLine = sLine..SKM_Config.Col_Label..Enemy[_lastUpdate];
--			table.insert(Lines, sLine);
--		end


		-- line 6 : meet and death counts
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Met..SKM_Config.Col_PlayerMet..iMet; -- 0.08.2 Add localization
		sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Death..SKM_Config.Col_PlayerDeath .. iDeath; -- 0.08.2 Add localization
		sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_LoneWolf..SKM_Config.Col_LoneWolfKill .. iLoneWolf;

		table.insert(Lines, sLine);


		-- line 7 : kill counts
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Kill..SKM_Config.Col_PlayerTotalKill..iTotalKill; -- 0.08.2 Add localization
		sLine = sLine.."   "..SKM_Config.Col_Label.."( ";
		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Full..SKM_Config.Col_PlayerFullKill..iFullKill; -- 0.08.2 Add localization
		sLine = sLine..SKM_Config.Col_Label.." + "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Standard..SKM_Config.Col_PlayerKill..iKill; -- 0.08.2 Add localization
		sLine = sLine..SKM_Config.Col_Label.." + "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Assist..SKM_Config.Col_PlayerAssistKill..iAssistKill..SKM_Config.Col_Label.." )"; -- 0.08.2 Add localization

		table.insert(Lines, sLine);


		-- Line : honor kills and remaining potential kills today
		local sLine = "";

		if (ifnil(Enemy[_SKM._honorKill], 0) > 0) then
			local iRemaining = SkM_GetHonorRemainingKills(sName);
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_HonorKill..SKM_Config.Col_HonorKill..Enemy[_SKM._honorKill];
			if (iRemaining == 0) then
				sLine = sLine..SKM_Config.Col_Label.."   ( "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_RemainHonor..SKM_Config.Col_Honorless..iRemaining..SKM_Config.Col_Label.." )";
			else
				sLine = sLine..SKM_Config.Col_Label.."   ( "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_RemainHonor..SKM_Config.Col_HonorKill..iRemaining..SKM_Config.Col_Label.." )";
			end
			sLine = sLine.."     ";
		end

		if (iBGKill > 0 or iBGDeath > 0) then
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_BGKill..SKM_Config.Col_BGKill .. iBGKill;
			sLine = sLine.."     ";
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_BGDeath..SKM_Config.Col_BGDeath .. iBGDeath;
		end

		if (sLine ~= "") then
			table.insert(Lines, sLine);
		end

		-- line 8 : player notes
		if (Enemy[_SKM._playerNote] ~= nil) and (Enemy[_SKM._playerNote] ~= "") then
			local sLine = "";

			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Note; -- 0.08.2 Add localization
			sLine = sLine..SKM_Config.Col_Label..Enemy[_SKM._playerNote];

			table.insert(Lines, sLine);
		end


		local i;
		for i=1, SKM_LISTFRAME_DETAIL_ROWS, 1 do
			local ButtonText = getglobal("SKMap_ListFrameDetailButton"..i.."Text");

			if (i <= getn(Lines)) then
				SkM_Trace(FName, 2, i.." : "..Lines[i]);

				if (ButtonText) then
					ButtonText:SetText(Lines[i]);
				end
			else
				ButtonText:SetText("");
			end
		end
	end

end


function SKMap_ListFrame_ClearDetail()
	local i;
	for i=1, SKM_LISTFRAME_DETAIL_ROWS, 1 do
		local ButtonText = getglobal("SKMap_ListFrameDetailButton"..i.."Text");
		if (ButtonText) then
			ButtonText:SetText("");
		end
	end

	SKMap_ListFrameTruceButton:Hide();
	SKMap_ListFrameWarButton:Hide();

	SKMap_ListFrame_ShowPlayerGuildButton:Hide();
	SKMap_ListFrame_BackToPlayersButton:Hide();
	SKMap_ListFrame_EditNote:Hide();
	SKMap_ListFrame_ReportButton:Hide();
	SKMap_ListFrame_DeleteButton:Hide();
end


function SKMap_ListFrame_GuildSort(e1, e2)
	local FName = "SKMap_ListFrame_GuildSort";

	SkM_Trace(FName, 4, "Begin");

	if (e1 == nil) then
		if (e2 == nil) then
			return false;
		else
			return true;
		end
	elseif (e2 == nil) then
		return false;
	end

	--local iSortTypes = table.getn(SKM_GuildList_SortTypes);
	local iSortTypes = table.getn( SkM_GetOption("GuildList_SortTypes") );

	local i;
	for i=1, iSortTypes, 1 do
		local bReverseSort = false;
		--if (i == 1) and (SKM_GuildList_ReverseSort) then
		if (i == 1) and ( SkM_GetOption("GuildList_ReverseSort") ) then
			bReverseSort = true;
		end
		--local bCmp = SKMap_ListFrame_SubSort(e1, e2, SKM_GuildList_SortTypes[i], bReverseSort);
		local bCmp = SKMap_ListFrame_SubSort(e1, e2, SkM_GetOption("GuildList_SortTypes")[i], bReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end
	end
	return false;
end


function SKMap_ListFrame_SortGuildList(sSortType)
	local FName = "SKMap_ListFrame_SortGuildList";

	SkM_Trace(FName, 3, "Sort by : "..snil(sSortType));

	if (sSortType) then
		--if (sSortType == SKM_GuildList_SortType) then
		if (sSortType == SkM_GetOption("GuildList_SortType") ) then

			--if (SKM_GuildList_ReverseSort) then
			if ( SkM_GetOption("GuildList_ReverseSort") ) then
				--SKM_GuildList_ReverseSort = false;
				SkM_SetOption("GuildList_ReverseSort", false);
			else
				--SKM_GuildList_ReverseSort = true;
				SkM_SetOption("GuildList_ReverseSort", true);
			end
		else
			--SKM_GuildList_SortType = sSortType;
			SkM_SetOption("GuildList_SortType", sSortType);

			--SKM_GuildList_SortTypes = removefromlist(sSortType, SKM_GuildList_SortTypes);
			SKM_Settings.GuildList_SortTypes = removefromlist(sSortType, SkM_GetOption("GuildList_SortTypes") );
			--table.insert(SKM_GuildList_SortTypes, 1, sSortType);
			table.insert(SKM_Settings.GuildList_SortTypes, 1, sSortType);
		end
	end

	if (SKM_GuildList_Content) then
		SkM_Trace(FName, 3, "Now sorting guild list");
		table.sort(SKM_GuildList_Content, SKMap_ListFrame_GuildSort);
	end

	SKMap_ListFrame_UpdateGuildList();
end


function SKMap_ListFrame_UpdateGuildList()
	local FName = "SKMap_ListFrame_UpdateGuildList";

	local iScrollOffset = FauxScrollFrame_GetOffset(SKMap_ListGuildScrollFrame);

	SkM_Trace(FName, 4, "Scrollbar offset = "..snil(iScrollOffset));

	local iGuildCount = table.getn(SKM_GuildList_Content);
	SkM_Trace(FName, 4, "Guild Count = "..snil(iGuildCount));

	local iIndex = iScrollOffset + 1;

	SkM_Trace(FName, 4, "Guild Index = "..snil(iIndex));

	local i;
	for i=1, SKM_LISTFRAME_ROWS, 1 do
		local RowButton = getglobal("SKMap_ListFrameGuildButton"..i);

		if (iIndex <= iGuildCount) then

			RowButtonName = getglobal("SKMap_ListFrameGuildButton"..i.."Name");
			RowButtonMembers = getglobal("SKMap_ListFrameGuildButton"..i.."Members");
			RowButtonKill = getglobal("SKMap_ListFrameGuildButton"..i.."Kill");
			RowButtonDeath = getglobal("SKMap_ListFrameGuildButton"..i.."Death");
			RowButtonMet = getglobal("SKMap_ListFrameGuildButton"..i.."Met");
			RowButtonLastSeen = getglobal("SKMap_ListFrameGuildButton"..i.."LastSeen");
			RowButtonAtWar = getglobal("SKMap_ListFrameGuildButton"..i.."AtWar");

			local sName = ifnil(SKM_GuildList_Content[iIndex][_SKM._name], "??");
			local sLastSeen = ifnil(SKM_GuildList_Content[iIndex][_SKM._lastView], "??");

			local bAtWar = SKM_GuildList_Content[iIndex][_SKM._atWar];

			local sWar = "";
			if (bAtWar) then
				sName = SKM_Config.Col_PlayerWar..sName;
				sWar = SKM_Config.Col_PlayerWar..SKMAP_COLUMN_ATWAR_GUILD; -- 0.08.1 Add localization
			end

			local iKill = ifnil(SKM_GuildList_Content[iIndex][_SKM._playerKill], 0) + ifnil(SKM_GuildList_Content[iIndex][_SKM._playerAssistKill], 0) + ifnil(SKM_GuildList_Content[iIndex][_SKM._playerFullKill], 0);
			local iDeath = ifnil(SKM_GuildList_Content[iIndex][_SKM._enemyKillPlayer], 0);
			local iMet = ifnil(SKM_GuildList_Content[iIndex][_SKM._meetCount], 0);
			local iMembers = ifnil(SKM_GuildList_Content[iIndex][_SKM._members], 0);

			RowButtonName:SetText(sName);
			RowButtonMembers:SetText(iMembers);
			RowButtonKill:SetText(iKill);
			RowButtonDeath:SetText(iDeath);
			RowButtonMet:SetText(iMet);
			RowButtonLastSeen:SetText(sLastSeen);
			RowButtonAtWar:SetText(sWar);

			RowButton:Show();

			iIndex = iIndex + 1;
		else
			RowButton:Hide();
		end

	end

	FauxScrollFrame_Update(SKMap_ListGuildScrollFrame, iGuildCount, SKM_LISTFRAME_ROWS, SKM_LISTFRAME_ROWHEIGHT);
end


function SKMap_SetGuildListContent()
	local FName = "SKMap_SetGuildListContent";

	SKM_GuildList_Content = { };

	local idx, val;
	for idx, val in  SKM_Data[_RealmName][_PlayerName].GuildHistory do
		local Elem = copytable(val);

		Elem[_SKM._members] = SkM_CountGuildMembers(idx);

		-- check if element has to be filtered out or not
		local bFilter = false;
		if (SKM_Config.FilterNotAtWar == true) then
			if ( not (Elem[_SKM._atWar]) ) then
				bFilter = true;
			end
		end

		if (bFilter == false) then
			table.insert(SKM_GuildList_Content, Elem);
		end

	end

end


function SKMap_ListFrame_SelectGuild(sGuildName)
	local FName = "SKMap_ListFrame_SelectGuild";

	local sName;

	if (sGuildName ~= nil) then
		sName = sGuildName;
	else
		local id = this:GetID();
		local iScrollOffset = FauxScrollFrame_GetOffset(SKMap_ListGuildScrollFrame);
		local iGuildCount = table.getn(SKM_GuildList_Content);

		SkM_Trace(FName, 3, "Scroll offset = "..iScrollOffset);
		SkM_Trace(FName, 3, "Line id = "..id);

		local iGuildIndex = iScrollOffset + id;
		SkM_Trace(FName, 3, "Guild Index = "..iGuildIndex);

		if (iGuildIndex <= iGuildCount) then
			sName = SKM_GuildList_Content[iGuildIndex][_SKM._name];
		end
	end

	local Guild;
	if (sName ~= nil) and (sName ~= "") then
		Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[sName];
	end



	local Lines = { };

	if (Guild ~= nil) then
		SKM_List_SelectedGuild = sName;

		local sLastSeen = ifnil(Guild[_SKM._lastView], "??");

		local iKill = ifnil(Guild[_SKM._playerKill], 0);
		local iAssistKill = ifnil(Guild[_SKM._playerAssistKill], 0);
		local iFullKill = ifnil(Guild[_SKM._playerFullKill], 0);
		local iTotalKill = iKill + iAssistKill + iFullKill;
		local iDeath = ifnil(Guild[_SKM._enemyKillPlayer], 0);
		local iMet = ifnil(Guild[_SKM._meetCount], 0);
		local iLoneWolf = ifnil(Guild[_SKM._loneWolfKill], 0);

		local iBGKill = ifnil(Guild[_SKM._playerBGKill], 0);
		local iBGDeath = ifnil(Guild[_SKM._enemyKillBG], 0);

		local iMembers = SkM_CountGuildMembers(sName);

		local bAtWar;
		if (Guild[_SKM._atWar]) then
			bAtWar = true;
		else
			bAtWar = false;
		end

		SKMap_ListFrame_ShowWarButton(bAtWar);

		SKMap_ListFrame_ShowPlayerGuildButton:Hide();
		SKMap_ListFrame_BackToPlayersButton:Hide();
		SKMap_ListFrame_EditNote:Show();
		SKMap_ListFrame_ReportButton:Show();
		SKMap_ListFrame_DeleteButton:Hide();


		-- line 1 : guild name and (optional) war status
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle.."Guild :  ";
		if (bAtWar) then
			sLine = sLine..SKM_Config.Col_PlayerWar;
		else
			sLine = sLine..SKM_Config.Col_Label;
		end
		sLine = sLine..sName..SKM_Config.Col_Label;
		if (bAtWar) then
			sLine = sLine.."  -  "..SKM_Config.Col_PlayerWar..SKM_UI_STRINGS.Small_Target_War;
			if (Guild[_SKM._warDate]) then
				--local sDisplayDate = string.sub(Enemy[_SKM._warDate], 1, 10);
				local sDisplayDate = Guild[_SKM._warDate];
				sLine = sLine.." "..SKM_UI_STRINGS.Since..sDisplayDate;
			end
		end

		table.insert(Lines, sLine);


		-- Line 2 : members
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Guild_Member; -- 0.08.2 Add localization
		sLine = sLine..SKM_Config.Col_Label..iMembers;

		table.insert(Lines, sLine);


		-- line 3 : last seen time and last player viewed
		if (Guild[_SKM._lastView] ~= nil) then

			local sLine = "";

			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Last_Seen; -- 0.08.2 Add localization

			if (Guild[_SKM._lastPlayerViewed] ~= nil) then
				sLine = sLine..SKM_Config.Col_Label..Guild[_SKM._lastPlayerViewed].." - ";
			end

			sLine = sLine..SKM_Config.Col_Label..Guild[_SKM._lastView];

			table.insert(Lines, sLine);
		end


		-- line 4 : meet and death counts
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Met..SKM_Config.Col_PlayerMet..iMet; -- 0.08.2 Add localization
		sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Death..SKM_Config.Col_PlayerDeath .. iDeath; -- 0.08.2 Add localization
		sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_LoneWolf..SKM_Config.Col_LoneWolfKill .. iLoneWolf;

		table.insert(Lines, sLine);


		-- line 5 : kill counts
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Kill..SKM_Config.Col_PlayerTotalKill..iTotalKill; -- 0.08.2 Add localization
		sLine = sLine.."   "..SKM_Config.Col_Label.."( ";
		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Full..SKM_Config.Col_PlayerFullKill..iFullKill; -- 0.08.2 Add localization
		sLine = sLine..SKM_Config.Col_Label.." + "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Standard..SKM_Config.Col_PlayerKill..iKill; -- 0.08.2 Add localization
		sLine = sLine..SKM_Config.Col_Label.." + "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Assist..SKM_Config.Col_PlayerAssistKill..iAssistKill..SKM_Config.Col_Label.." )"; -- 0.08.2 Add localization

		table.insert(Lines, sLine);


		-- Line : honor kills
		local sLine = "";

		if (ifnil(Guild[_SKM._honorKill], 0) > 0) then
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_HonorKill..SKM_Config.Col_HonorKill..Guild[_SKM._honorKill];
			sLine = sLine.."     ";
		end

		if (iBGKill > 0 or iBGDeath > 0) then
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_BGKill..SKM_Config.Col_BGKill .. iBGKill;
			sLine = sLine.."     ";
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_BGDeath..SKM_Config.Col_BGDeath .. iBGDeath;
		end

		if (sLine ~= "") then
			table.insert(Lines, sLine);
		end



		-- line 6 : player notes
		if (Guild[_SKM._playerNote] ~= nil) and (Guild[_SKM._playerNote] ~= "") then
			local sLine = "";

			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Note; -- 0.08.2 Add localization
			sLine = sLine..SKM_Config.Col_Label..Guild[_SKM._playerNote];

			table.insert(Lines, sLine);
		end


		local i;
		for i=1, SKM_LISTFRAME_DETAIL_ROWS, 1 do
			local ButtonText = getglobal("SKMap_ListFrameDetailButton"..i.."Text");

			if (i <= getn(Lines)) then
				SkM_Trace(FName, 2, i.." : "..Lines[i]);

				if (ButtonText) then
					ButtonText:SetText(Lines[i]);
				end
			else
				ButtonText:SetText("");
			end
		end
	end

end


function SKMap_ListFrame_ToggleLists()
	local FName = "SKMap_ListFrame_ToggleLists";

	if (SKM_List_ActiveList == _SKM._players) then

		SKM_List_ActiveList = _SKM._guilds;

		SKMap_ListFrame_Load();

		SKMap_ListFrameMainList:Hide();
		SKMap_ListFrameGuildList:Show();

		SKMap_ListFrame_UpdateListButton:Hide();

		SKMap_ListFrame_ToggleButton:SetText(SKMAP_PLAYERS);

		if (SKM_List_SelectedGuild ~= nil) then
			SKMap_ListFrame_SelectGuild(SKM_List_SelectedGuild);
		else
			SKMap_ListFrame_ClearDetail();
		end

	else

		SKM_List_ActiveList = _SKM._players;

		SKMap_ListFrame_Load();

		SKMap_ListFrameGuildList:Hide();
		SKMap_ListFrameMainList:Show();

		SKMap_ListFrame_UpdateListButton:Show();

		SKMap_ListFrame_ToggleButton:SetText(SKMAP_GUILDS);

		if (SKM_List_SelectedPlayer ~= nil) then
			SKMap_ListFrame_SelectElement(SKM_List_SelectedPlayer);
		else
			SKMap_ListFrame_ClearDetail();
		end

	end

end


function SKMap_ListFrame_Filter()
	local FName = "SKMap_ListFrame_Filter";

	local MyButton = getglobal("SKMap_ListFrameCheckButton1");

	SKM_Config.FilterNotAtWar = false;
	if (MyButton:GetChecked()) then
		SKM_Config.FilterNotAtWar = true;
	end

	SKMap_ListFrame_Load();
end


function SKMap_ListDetail_SetWar()
	local FName = "SKMap_ListDetailWar";

	if (SKM_List_ActiveList == _SKM._players) then
		if (SKM_List_SelectedPlayer ~= nil) then
			local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[SKM_List_SelectedPlayer];
			if (Enemy) then
				local bWar;
				if (Enemy[_SKM._atWar]) then
					bWar = false;
				else
					bWar = true;
				end

				local sDate = SkM_GetDate();

				SkM_UpdateEnemy_SetWar(SKM_List_SelectedPlayer, bWar, sDate);
				SKMap_ListFrame_ShowWarButton(bWar);

				SKMap_ListFrame_UpdateList();
				SKMap_ListFrame_SelectElement(SKM_List_SelectedPlayer);
			end
		end
	else
		if (SKM_List_SelectedGuild ~= nil) and (SKM_List_SelectedGuild ~= "") then
			local Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[SKM_List_SelectedGuild];
			if (Guild) then
				local bWar;
				if (Guild[_SKM._atWar]) then
					bWar = false;
				else
					bWar = true;
				end

				local sDate = SkM_GetDate();

				SkM_UpdateGuild_SetWar(SKM_List_SelectedGuild, bWar, sDate);
				SKMap_ListFrame_ShowWarButton(bWar);

				SKMap_ListFrame_UpdateGuildList();
				SKMap_ListFrame_SelectGuild(SKM_List_SelectedGuild);
			end
		end
	end

end


function SKMap_ListFrame_ShowWarButton(bWar)
	local FName = "SKMap_ListFrame_ShowWarButton";

	SkM_Trace(FName, 2, "War = "..snil(bWar));

	if (bWar == nil) then
		SKMap_ListFrameTruceButton:Hide();
		SKMap_ListFrameWarButton:Hide();
	elseif (bWar == true) then
		SKMap_ListFrameTruceButton:Show();
		SKMap_ListFrameWarButton:Hide();

	elseif (bWar == false) then
		SKMap_ListFrameTruceButton:Hide();
		SKMap_ListFrameWarButton:Show();
	end
end



function SKMap_List_ShowPlayerGuild()
	if (SKM_List_ActiveList == _SKM._players) then
		if (SKM_List_SelectedPlayer ~= nil) then
			local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[SKM_List_SelectedPlayer];
			if (Enemy) then
				local sGuild = Enemy[_SKM._guild];
				if (sGuild ~= nil) and (sGuild ~= "") then
					local Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuild];
					if (Guild) then
						SKM_List_SelectedGuild = sGuild;
						SKMap_ListFrame_ToggleLists();
						SKMap_ListFrame_BackToPlayersButton:Show();

					end
				end
			end
		end
	end
end


function SKMap_List_BackToPlayers()
	SKMap_ListFrame_ToggleLists();
end


function SKMap_Report_WriteBook(Lines)
	local FName = "SKMap_Report_WriteBook";

	local i, j;
	local iNbLines = table.getn(Lines);
	for i=1, SKM_BOOKFRAME_ROWS, 1 do

		local ButtonText = getglobal("SKMap_ReportFrameBookButton"..i.."Text");
		local ButtonCols = { };

		for j=1, SKM_BOOKFRAME_COLUMNS, 1 do
			local ButtonCol = getglobal("SKMap_ReportFrameBookButton"..i.."Col"..j);
			table.insert(ButtonCols, ButtonCol);
		end

		if (i <= iNbLines) then
			local CurrentLine = Lines[i];

			if (type(CurrentLine) == "string" ) then
				ButtonText:SetText(Lines[i]);
				ButtonText:Show();
				for j=1, SKM_BOOKFRAME_COLUMNS, 1 do
					ButtonCols[j]:SetText("");
					ButtonCols[j]:Hide();
				end

			elseif (type(CurrentLine) == "table" ) then

				local iNbCols = table.getn(Lines[i]);

				for j=1, SKM_BOOKFRAME_COLUMNS, 1 do
					if (j <= iNbCols) then
						ButtonCols[j]:SetText(Lines[i][j]);
					else
						ButtonCols[j]:SetText("");
					end
					ButtonCols[j]:Show();
				end

				ButtonText:SetText("");
				ButtonText:Hide();

			else
				-- unknown variable type !!!
				SkM_Trace(FName, 1, "Unknown variable type for line "..i);
			end


		else
			-- no more to write, hide our text strings
			ButtonText:SetText("");
			ButtonText:Hide();
			for j=1, SKM_BOOKFRAME_COLUMNS, 1 do
				ButtonCols[j]:SetText("");
				ButtonCols[j]:Hide();
			end

		end
	end
end


function SKMap_ReportFrame_Load()
	local FName = "SKMap_ReportFrame_Load";

	local idx = 1;
	local MyButton = getglobal("SKMap_ReportFrameCheckButton"..idx);
	local ButtonText = getglobal("SKMap_ReportFrameCheckButton"..idx.."Text");
	ButtonText:SetText(SKM_UI_STRINGS.Report_Button_UseAssist);
	MyButton.tooltipText = SKM_UI_STRINGS.Report_Tooltip_UseAssist;

	local checked;
	local bValue = SkM_GetOption("AssistKillStat");
	if (bValue) then
		checked = 1;
	else
		checked = 0;
	end

	MyButton:SetChecked(checked);

	--SkM_ComputeStatistics();
	--SKMap_Report_LoadBook(SKM_CurrentBook);
end


function SKMap_Book_PrevPage()
	local FName = "SKMap_Book_PrevPage";

	if (not SKM_BookCurPage) or (not SKM_BookPages) then
		return;
	end

	local iPages = table.getn(SKM_BookPages);

	if (iPages < 1) then
		return;
	end

	if (SKM_BookCurPage > 1) then
		SKM_BookCurPage = SKM_BookCurPage - 1;
	end

	SKMap_Book_ShowCurrentPage();
end


function SKMap_Book_NextPage()
	local FName = "SKMap_Book_NextPage";

	if (not SKM_BookCurPage) or (not SKM_BookPages) then
		return;
	end

	local iPages = table.getn(SKM_BookPages);

	if (iPages < 1) then
		return;
	end

	if (SKM_BookCurPage < iPages) then
		SKM_BookCurPage = SKM_BookCurPage + 1;
	end

	SKMap_Book_ShowCurrentPage();
end


function SKMap_Book_HidePage()
	local FName = "SKMap_Book_HidePage";

	SKMap_ReportFrame_PrevPageButton:Hide();
	SKMap_ReportFrame_NextPageButton:Hide();
	SKMap_ReportFrame_PageText:Hide();

	local i;
	for i=1, SKM_BOOKFRAME_ROWS, 1 do
		local ButtonText = getglobal("SKMap_ReportFrameBookButton"..i.."Text");
		if (ButtonText) then
			ButtonText:SetText("");
		end

		local j;
		for j=1, SKM_BOOKFRAME_COLUMNS, 1 do
			local ButtonCol = getglobal("SKMap_ReportFrameBookButton"..i.."Col"..j);
			if (ButtonCol) then
				ButtonCol:SetText("");
			end
		end
	end

end


function SKMap_Book_ShowCurrentPage()
	local FName = "SKMap_Book_ShowCurrentPage";

	if (not SKM_BookPages) then
		SKMap_Book_HidePage();
		return;
	end

	local iPages = table.getn(SKM_BookPages);
	if (iPages < 1) then
		SKMap_Book_HidePage();
		return;
	end

	local sPageText = "";

	if (not SKM_BookCurPage) then
		SKM_BookCurPage = 1;
	elseif (SKM_BookCurPage > iPages) then
		SKM_BookCurPage = iPages;
	end

	sPageText = SKM_UI_STRINGS.Book_Page.." "..SKM_BookCurPage.." / "..iPages;

	if (SKM_BookCurPage == 1) then
		SKMap_ReportFrame_PrevPageButton:Disable();
	else
		SKMap_ReportFrame_PrevPageButton:Enable();
	end

	if (SKM_BookCurPage == iPages) then
		SKMap_ReportFrame_NextPageButton:Disable();
	else
		SKMap_ReportFrame_NextPageButton:Enable();
	end

	SKMap_ReportFrame_PageText:SetText(sPageText);

	SKMap_ReportFrame_PrevPageButton:Show();
	SKMap_ReportFrame_NextPageButton:Show();
	SKMap_ReportFrame_PageText:Show();

	SKMap_Report_WriteBook(SKM_BookPages[SKM_BookCurPage]);
end


function SKMap_BuildBook(p_BookHeader, p_BookText)
	local FName = "SKMap_BuildBook";

	SKM_BookPages = { };

	local iHeaderLn = 0;
	if (p_BookHeader) then
		SkM_Trace(FName, 3, "Book Header not nil : "..getn(p_BookHeader));
		iHeaderLn = getn(p_BookHeader);
	end

	local iTextLn = 0;
	if (p_BookText) then
		SkM_Trace(FName, 3, "Book Text not nil : "..getn(p_BookText));
		iTextLn = getn(p_BookText);
	end

	if (iHeaderLn >= SKM_BOOKFRAME_ROWS) then
		SkM_Trace(FName, 1, "Too many header lines : "..iHeaderLn..", Book rows = "..SKM_BOOKFRAME_ROWS);
		return;
	end

	SkM_Trace(FName, 3, "Header lines = "..iHeaderLn..", Text lines = "..iTextLn);

	local CurrentPage = { };
	local i, j;

	if (iTextLn > 0) then

		for i=1, iTextLn, 1 do
			local CurrentLine = p_BookText[i];

			if (table.getn(CurrentPage) == 0) then
				if (iHeaderLn > 0) then

					-- beginning a new page : write header
					for j=1, iHeaderLn, 1 do
						table.insert(CurrentPage, p_BookHeader[j]);
					end
				end
			end

			if ( (type(CurrentLine) == "string") or (type(CurrentLine) == "number") ) then
				-- basic line, insert it as is
				table.insert(CurrentPage, CurrentLine);

			elseif (type(CurrentLine) == "table" ) then
				if (CurrentLine.Type == nil) then
					-- table with no type specified, it is a list of columns
					-- insert it as is
					table.insert(CurrentPage, CurrentLine);

				else
					if (CurrentLine.Type == "Line") then
						-- standard line or list of columns, insert value as is
						table.insert(CurrentPage, CurrentLine.Value);

					elseif (CurrentLine.Type == "NextPage") then
						-- directive specifying to start the following page
						table.insert(SKM_BookPages, CurrentPage);
						CurrentPage = { };

					elseif (CurrentLine.Type == "MultiLine") then
						-- directive specifying a group of undivisible lines,
						-- check if there's enough space on current page
						local iNbLines = CurrentLine.Value;
						if (table.getn(CurrentPage) + iNbLines > SKM_BOOKFRAME_ROWS) then
							table.insert(SKM_BookPages, CurrentPage);
							CurrentPage = { };
						end

					else
						-- unknown case, skip
						SkM_Trace(FName, 1, "Unknown type : "..snil(CurrentLine.Type));
					end

				end
			end

			if (table.getn(CurrentPage) == SKM_BOOKFRAME_ROWS) then
				table.insert(SKM_BookPages, CurrentPage);
				CurrentPage = { };
			end

		end

	else
		if (iHeaderLn > 0) then
			-- text empty, but there is a header : create a single page with the header
			for j=1, iHeaderLn, 1 do
				table.insert(CurrentPage, p_BookHeader[j]);
			end
		end

	end

	-- insert last page
	if (table.getn(CurrentPage) > 0) then
		table.insert(SKM_BookPages, CurrentPage);
		CurrentPage = { };
	end

	if (table.getn(SKM_BookPages) > 0) then
		SKM_BookCurPage = 1;
	else
		SKM_BookCurPage = 0;
	end

end


function SKMap_Report_LoadBook(sBookType)
	local FName = "SKMap_Report_LoadBook";


	SkM_Trace(FName, 2, "Loading book type = "..snil(sBookType));

	SKM_CurrentBook = sBookType;

	if (sBookType == _SKM._bookCredits) then
		SKMap_BuildBook(nil, SKMAP_CREDITS);

	elseif (sBookType == _SKM._bookGeneralStat) then
		SKMap_BuildBook_GeneralStat();

	elseif (sBookType == _SKM._bookClassStat) then
		SKMap_BuildBook_CategoryStat("ClassList", SKM_UI_STRINGS.Book_ClassStat_Header, SKM_UI_STRINGS.Book_Label_Class);

	elseif (sBookType == _SKM._bookRaceStat) then
		SKMap_BuildBook_CategoryStat("RaceList", SKM_UI_STRINGS.Book_RaceStat_Header, SKM_UI_STRINGS.Book_Label_Race);

	elseif (sBookType == _SKM._bookPlayerStat) then
		SKMap_BuildBook_CategoryStat("EnemyList", SKM_UI_STRINGS.Book_EnemyStat_Header, SKM_UI_STRINGS.Book_Label_Enemy);

	elseif (sBookType == _SKM._bookGuildStat) then
		SKMap_BuildBook_CategoryStat("GuildList", SKM_UI_STRINGS.Book_GuildStat_Header, SKM_UI_STRINGS.Book_Label_Guild);

	elseif (sBookType == _SKM._bookMapStat) then
		SKMap_BuildBook_CategoryStat("ZoneList", SKM_UI_STRINGS.Book_ZoneStat_Header, SKM_UI_STRINGS.Book_Label_Zone);

	elseif (sBookType == _SKM._bookDateStat) then
		SKMap_BuildBook_CategoryStat("DateList", SKM_UI_STRINGS.Book_DateStat_Header, SKM_UI_STRINGS.Book_Label_Date);

	elseif (sBookType == _SKM._bookBGDateStat) then
		SKMap_BuildBook_CategoryStat("BGDateList", SKM_UI_STRINGS.Book_BGDateStat_Header, SKM_UI_STRINGS.Book_Label_Date);

	elseif (sBookType == _SKM._bookBGMapStat) then
		SKMap_BuildBook_CategoryStat("BGZoneList", SKM_UI_STRINGS.Book_BGZoneStat_Header, SKM_UI_STRINGS.Book_Label_Zone);

	elseif (sBookType == _SKM._bookBGDateMapStat) then
		SKMap_BuildBook_CategoryStat("BGDateZoneList", SKM_UI_STRINGS.Book_BGDateZoneStat_Header, SKM_UI_STRINGS.Book_Label_DateZone);

	else
		SkM_Trace(FName, 1, "Unknown book type");
		SKM_CurrentBook = nil;
		SKMap_BuildBook(nil, nil);
	end

	SKMap_Book_ShowCurrentPage();
end


function SKMap_BuildBook_GeneralStat()
	local FName = "SKMap_BuildBook_GeneralStat";

	-- recompute statistics to be sure they're up to date
	SkM_ComputeStatistics();

	-- preparing header
	local BookHeader = { };
	table.insert(BookHeader, SKM_UI_STRINGS.Book_GeneralStat_Header);
	table.insert(BookHeader, "");
	table.insert(BookHeader, SKM_BOOK_SEPARATOR);
	table.insert(BookHeader, "");

	-- book content
	local BookText = { };

	local iKill = ifnil(SKM_Context.Statistics.Globals.Kill, 0);
	local iDeath = ifnil(SKM_Context.Statistics.Globals.Death, 0);
	local sRatio;
	if (iDeath + iKill > 0) then
		sRatio = math.floor( 100 * iKill / (iDeath + iKill) ) .. " %";
	end

	local Line = { SKM_UI_STRINGS.Book_TotalKill, iKill };
	table.insert(BookText, Line);

	local Line = { SKM_UI_STRINGS.Book_TotalDeath, iDeath };
	table.insert(BookText, Line);

	table.insert(BookText, "");

	local Line = { SKM_UI_STRINGS.Book_TotalRatio, sRatio };
	table.insert(BookText, Line);

	table.insert(BookText, "");

	local Line = { SKM_UI_STRINGS.Book_AverageKillLevel, SKM_Context.Statistics.Globals.KillAverageLevel };
	table.insert(BookText, Line);

	local Line = { SKM_UI_STRINGS.Book_AverageDeathLevel, SKM_Context.Statistics.Globals.DeathAverageLevel };
	table.insert(BookText, Line);

	table.insert(BookText, "");

	local Line = { SKM_UI_STRINGS.Book_EnemyPlayers, SKM_Context.Statistics.Globals.EnemyPlayers };
	table.insert(BookText, Line);

	local Line = { SKM_UI_STRINGS.Book_EnemyGuilds, SKM_Context.Statistics.Globals.EnemyGuilds };
	table.insert(BookText, Line);

	table.insert(BookText, "");

	local Line = { SKM_UI_STRINGS.Book_MapRecords, SKM_Context.Statistics.Globals.MapRecords };
	table.insert(BookText, Line);

	SKMap_BuildBook(BookHeader, BookText);
end


function SKMap_BuildBook_EnemyStat()
	local FName = "SKMap_BuildBook_EnemyStat";

	-- recompute statistics to be sure they're up to date
	SkM_ComputeStatistics();

	-- preparing header
	local BookHeader = { };
	table.insert(BookHeader, SKM_UI_STRINGS.Book_EnemyStat_Header);
	table.insert(BookHeader, "");

	local sLine = { SKM_UI_STRINGS.Book_Label_Enemy, SKM_UI_STRINGS.Book_Label_Kill, SKM_UI_STRINGS.Book_Label_Death, SKM_UI_STRINGS.Book_Label_Ratio };
	table.insert(BookHeader, sLine);

	table.insert(BookHeader, SKM_BOOK_SEPARATOR);
	table.insert(BookHeader, "");


	-- book content
	local BookText = { };

	local  val;
	local i;
	for i=1, getn(SKM_Context.Statistics.EnemyList), 1 do
		val = SKM_Context.Statistics.EnemyList[i];
		local sEnemy = val.Key;
		local iDeath = val.Death;
		local iKill = val.Kill;

		local sRatio;
		if (iDeath + iKill > 0) then
			sRatio = math.floor( 100 * iKill / (iDeath + iKill) ) .. " %";
		end

		local Line = { sRace, iKill, iDeath, sRatio };

		table.insert(BookText, Line);
	end

	if (getn(BookText) == 0) then
		table.insert(BookText, SKM_UI_STRINGS.Book_NoData);
	end

	SKMap_BuildBook(BookHeader, BookText);
end


function SKMap_BuildBook_CategoryStat(sCategory, sTitle, sLabel)
	local FName = "SKMap_BuildBook_CategoryStat";

	-- recompute statistics to be sure they're up to date
	SkM_ComputeStatistics();

	-- preparing header
	local BookHeader = { };
	table.insert(BookHeader, sTitle);
	table.insert(BookHeader, "");

	local sLine = { sLabel, SKM_UI_STRINGS.Book_Label_Kill, SKM_UI_STRINGS.Book_Label_Death, SKM_UI_STRINGS.Book_Label_Ratio };
	table.insert(BookHeader, sLine);

	table.insert(BookHeader, SKM_BOOK_SEPARATOR);
	table.insert(BookHeader, "");



	-- book content
	local BookText = { };

	local  val;
	local i;
	for i=1, getn(SKM_Context.Statistics[sCategory]), 1 do
		val = SKM_Context.Statistics[sCategory][i];
		local sElem = val.Key;

		local iDeath = val.Death;
		local iKill = val.Kill;

		local sRatio;
		if (iDeath + iKill > 0) then
			sRatio = math.floor( 100 * iKill / (iDeath + iKill) ) .. " %";
		end

		local Line = { sElem, iKill, iDeath, sRatio };

		table.insert(BookText, Line);
	end

	if (getn(BookText) == 0) then
		table.insert(BookText, SKM_UI_STRINGS.Book_NoData);
	end

	SKMap_BuildBook(BookHeader, BookText);
end


function SKMap_ReportButton_OnClick()

	if (SKM_List_ActiveList == _SKM._players) then

		if (SKM_List_SelectedPlayer ~= nil) then
			SKMap_Report_EnemyRecords(SKM_List_SelectedPlayer);
			SKMap_ToggleUI("SKMap_ReportFrame");
		end

	elseif (SKM_List_ActiveList == _SKM._guilds) then

		if (SKM_List_SelectedGuild ~= nil) then
			SKMap_Report_EnemyGuildRecords(SKM_List_SelectedGuild);
			SKMap_ToggleUI("SKMap_ReportFrame");
		end
	end

end


function SKMap_Report_EnemyRecords(sName)
	local FName = "SKMap_Report_EnemyRecords";

	SKM_CurrentBook = nil;

	-- preparing header
	local BookHeader = { };
	table.insert(BookHeader, string.format("%s vs %s", _PlayerName, sName));
	table.insert(BookHeader, "");
	table.insert(BookHeader, SKM_BOOK_SEPARATOR);
	table.insert(BookHeader, "");

	-- book content
	local BookText = { };

	local i;

	local iNbNotes = table.getn(SKM_Data[_RealmName][_PlayerName].GlobalMapData);
	for i=iNbNotes, 1, -1 do
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[i];

		local StoredInfo = Note[_SKM._storedInfo];

		if (StoredInfo) and (StoredInfo[_SKM._name] == sName) then

			if   (StoredInfo[_SKM._type] == _SKM._playerKill)
			  or (StoredInfo[_SKM._type] == _SKM._playerFullKill)
			  or (StoredInfo[_SKM._type] == _SKM._playerAssistKill and SkM_GetOption("AssistKillStat"))
			  or (StoredInfo[_SKM._type] == _SKM._playerDeathPvP)
			then
				table.insert(BookText, {Type = "MultiLine", Value = 3 } );

				--local sZoneText = SKM_Context.Zones[Note[_SKM._continent]][Note[_SKM._zone]];
				local sZoneText = SkM_GetZoneTextFromIndex(Note[_SKM._continent], Note[_SKM._zone]);
				local sDate = StoredInfo[_SKM._date];
				table.insert(BookText, sDate.." - "..sZoneText);

				local sLine;
				if (StoredInfo[_SKM._type] == _SKM._playerAssistKill) then
					sLine = string.format(SKM_UI_STRINGS.Book_Format_AssistKill, sName);
				elseif (StoredInfo[_SKM._type] == _SKM._playerKill) then
					sLine = string.format(SKM_UI_STRINGS.Book_Format_Kill, sName);
				elseif (StoredInfo[_SKM._type] == _SKM._playerFullKill) then
					if (StoredInfo[_SKM._loneWolfKill]) then
						sLine = string.format(SKM_UI_STRINGS.Book_Format_LoneWolfKill, sName);
					else
						sLine = string.format(SKM_UI_STRINGS.Book_Format_FullKill, sName);
					end
				elseif (StoredInfo[_SKM._type] == _SKM._playerDeathPvP) then
					sLine = string.format(SKM_UI_STRINGS.Book_Format_Death, sName);
				end
				table.insert(BookText, sLine);

				table.insert(BookText, "");
			end

		end
	end

	if (getn(BookText) == 0) then
		table.insert(BookText, SKM_UI_STRINGS.Book_NoData);
	end

	SKMap_BuildBook(BookHeader, BookText);

	SKMap_Book_ShowCurrentPage();
end


function SKMap_Report_EnemyGuildRecords(sGuildName)
	local FName = "SKMap_Report_EnemyGuildRecords";

	SKM_CurrentBook = nil;

	-- preparing header
	local BookHeader = { };

	table.insert(BookHeader, string.format("%s vs <%s>", _PlayerName, sGuildName));
	table.insert(BookHeader, "");
	table.insert(BookHeader, SKM_BOOK_SEPARATOR);
	table.insert(BookHeader, "");

	-- book content
	local BookText = { };

	local i;
	local iNbNotes = table.getn(SKM_Data[_RealmName][_PlayerName].GlobalMapData);
	for i=iNbNotes, 1, -1 do
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[i];

		local StoredInfo = Note[_SKM._storedInfo];

		local sName;
		local Enemy;
		local sPlayerGuild;

		if (StoredInfo) then
			sName = StoredInfo[_SKM._name];
		end

		if (sName) then
			Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
			if (Enemy) then
				sPlayerGuild = Enemy[_SKM._guild];
			end
		end

		if (sPlayerGuild == sGuildName) then

			if   (StoredInfo[_SKM._type] == _SKM._playerKill)
			  or (StoredInfo[_SKM._type] == _SKM._playerFullKill)
			-- or (StoredInfo[_SKM._type] == _SKM._playerAssistKill)
			  or (StoredInfo[_SKM._type] == _SKM._playerDeathPvP)
			then
				table.insert(BookText, {Type = "MultiLine", Value = 3 } );

				--local sZoneText = SKM_Context.Zones[Note[_SKM._continent]][Note[_SKM._zone]];
				local sZoneText = SkM_GetZoneTextFromIndex(Note[_SKM._continent], Note[_SKM._zone]);
				local sDate = StoredInfo[_SKM._date];
				table.insert(BookText, sDate.." - "..sZoneText);

				local sLine;
				if (StoredInfo[_SKM._type] == _SKM._playerKill) then
					sLine = string.format(SKM_UI_STRINGS.Book_Format_Kill, sName);
				elseif (StoredInfo[_SKM._type] == _SKM._playerFullKill) then
					if (StoredInfo[_SKM._loneWolfKill]) then
						sLine = string.format(SKM_UI_STRINGS.Book_Format_LoneWolfKill, sName);
					else
						sLine = string.format(SKM_UI_STRINGS.Book_Format_FullKill, sName);
					end
				elseif (StoredInfo[_SKM._type] == _SKM._playerDeathPvP) then
					sLine = string.format(SKM_UI_STRINGS.Book_Format_Death, sName);
				end
				table.insert(BookText, sLine);

				table.insert(BookText, "");
			end

		end
	end

	if (getn(BookText) == 0) then
		table.insert(BookText, SKM_UI_STRINGS.Book_NoData);
	end

	SKMap_BuildBook(BookHeader, BookText);

	SKMap_Book_ShowCurrentPage();
end


function SKMap_DeleteButton_Accept(ActiveList, sName)
	local FName = "SKMap_DeleteButton_Accept";

	SkM_Trace(FName, 2, "Delete confirmed : list = "..snil(ActiveList)..", Name = "..snil(sName));

	if (sName ~= nil) then

		if (ActiveList == _SKM._players) then
			SkM_DeleteEnemy(sName);

			if (SKM_List_SelectedPlayer == sName) then
				SKM_List_SelectedPlayer = nil;
				if (SKM_List_ActiveList == _SKM._players) then
					SKMap_ListFrame_ClearDetail();
				end
			end
		end

		SKMap_ListFrame_Load();
	end

	SKM_ActivePopup = false;
end


function SKMap_DeleteButton_Cancel()
	SKM_ActivePopup = false;
end


function SKMap_DeleteButton_OnClick()
	local FName = "SKMap_DeleteButton_OnClick";

	SkM_Trace(FName, 1, "Delete requested");

	if (SKM_ActivePopup) then
		return;
	end

	local sName;
	local ActiveList = SKM_List_ActiveList;

	if (SKM_List_ActiveList == _SKM._players) then
		sName = SKM_List_SelectedPlayer;
	end

	if (sName == nil) then
		return;
	end

	local sPlayerColor = SKM_Config.Col_LabelTitle;
	local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[SKM_List_SelectedPlayer];
	if (Enemy) and (Enemy[_SKM._atWar]) then
		sPlayerColor = SKM_Config.Col_PlayerWar;
	end

	local dialogdef = StaticPopupDialogs["SKMAP_CONFIRM"];

	dialogdef.text  = string.format(SKM_UI_STRINGS.List_ConfirmDeletePlayer, SKM_Config.Col_Label, sPlayerColor, sName, SKM_Config.Col_Label);

	--dialogdef.OnAccept = function() SKMap_DeleteButton_Accept(SKM_List_ActiveList, sName) end;
	dialogdef.OnAccept = function() SKMap_DeleteButton_Accept(ActiveList, sName) end;

	SKM_ActivePopup = true;
	StaticPopup_Show("SKMAP_CONFIRM");
end


function SKMap_EditBox_Accept()
	local FName = "SKMap_EditBox_Accept";

	SkM_Trace(FName, 1, "Edit accepted");

	local MyEditBox = getglobal(this:GetParent():GetName().."EditBox");
	if (MyEditBox) then
		local sValue = MyEditBox:GetText();

		SkM_Trace(FName, 2, "Value : "..snil(sValue));

		local sName = SKM_EditNoteContext.Element;

		if (SKM_EditNoteContext.List == _SKM._players) then
			SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._playerNote] = sValue;
		elseif (SKM_EditNoteContext.List == _SKM._guilds) then
			SKM_Data[_RealmName][_PlayerName].GuildHistory[sName][_SKM._playerNote] = sValue;
		elseif (SKM_EditNoteContext.List == _SKM._duels) then
			SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._playerNote] = sValue;
		end

	end

	local bVisible, sFrame = SKMap_IsUIVisible();

	if (sFrame == "SKMap_ListFrame") and (SKM_List_ActiveList == SKM_EditNoteContext.List) then
	--if (SKM_List_ActiveList == SKM_EditNoteContext.List) then

		if (SKM_EditNoteContext.List == _SKM._players) and (SKM_EditNoteContext.Element == SKM_List_SelectedPlayer) then
			SKMap_ListFrame_SelectElement(SKM_EditNoteContext.Element);
		elseif (SKM_EditNoteContext.List == _SKM._guilds) and (SKM_EditNoteContext.Element == SKM_List_SelectedGuild) then

			SKMap_ListFrame_SelectGuild(SKM_EditNoteContext.Element);
		end

	elseif (sFrame == "SKMap_DuelFrame") then
		SKMap_DuelFrame_SelectElement(SKM_EditNoteContext.Element);
	end

	SKM_EditNoteContext = { };


	SKMapStaticPopupEdit:Hide();
	SKM_ActivePopup = false;
end

function SKMap_EditBox_Cancel()
	local FName = "SKMap_EditBox_Cancel";

	SkM_Trace(FName, 1, "Edit canceled");

	SKMapStaticPopupEdit:Hide();
	SKM_ActivePopup = false;
end


function SKMap_EditBox_Clear()
	local sPopupEdit = "SKMapStaticPopupEdit";
	local MyEditBox = getglobal(sPopupEdit.."EditBox");
	MyEditBox:SetText("");
end


function SKMap_EditBox_OnShow()
	local FName = "SKMap_EditBox_OnShow";

	SkM_Trace(FName, 3, "OnShow");

	getglobal(this:GetName().."EditBox"):SetFocus();
end


function SKMap_EditNote()
	local FName = "SKMap_EditNote";

	SkM_Trace(FName, 1, "Edit Note");

	if (SKM_ActivePopup) then
		return;
	end

	local sPopupEdit = "SKMapStaticPopupEdit";
	local MyEditBox = getglobal(sPopupEdit.."EditBox");
	local MyTitle = getglobal(sPopupEdit.."Title");
	local MyPrompt = getglobal(sPopupEdit.."Prompt");

	MyTitle:SetText(SKM_UI_STRINGS.List_EditNote_Title);

	local bVisible, sFrame = SKMap_IsUIVisible();

	if (sFrame == "SKMap_ListFrame") then

		if (SKM_List_ActiveList == _SKM._players) then
			if (SKM_List_SelectedPlayer == nil) then
				SkM_Trace(FName, 2, "No selected player !");
				return;
			end

			local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[SKM_List_SelectedPlayer];
			if (Enemy == nil) then
				SkM_Trace(FName, 2, "Enemy not found : "..snil(SKM_List_SelectedPlayer));
				return;
			end

			local sPlayerColor = SKM_Config.Col_LabelTitle;
			if (Enemy) and (Enemy[_SKM._atWar]) then
				sPlayerColor = SKM_Config.Col_PlayerWar;
			end

			MyPrompt:SetText(string.format(SKM_UI_STRINGS.List_EditPlayerNote_Prompt, SKM_Config.Col_Label, sPlayerColor, SKM_List_SelectedPlayer, SKM_Config.Col_Label));

			MyEditBox:SetText(ifnil(Enemy[_SKM._playerNote], ""));

			SKM_EditNoteContext = { List = _SKM._players, Element = SKM_List_SelectedPlayer };

			SKM_ActivePopup = true;
			SKMapStaticPopupEdit:Show();

		elseif (SKM_List_ActiveList == _SKM._guilds) then
			if (SKM_List_SelectedGuild == nil) then
				return;
			end

			local Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[SKM_List_SelectedGuild];
			if (Guild == nil) then
				return;
			end

			local sGuildColor = SKM_Config.Col_LabelTitle;
			if (Guild) and (Guild[_SKM._atWar]) then
				sGuildColor = SKM_Config.Col_PlayerWar;
			end

			MyPrompt:SetText(string.format(SKM_UI_STRINGS.List_EditGuildNote_Prompt, SKM_Config.Col_Label, sGuildColor, SKM_List_SelectedGuild, SKM_Config.Col_Label));

			MyEditBox:SetText(ifnil(Guild[_SKM._playerNote], ""));

			SKM_EditNoteContext = { List = _SKM._guilds, Element = SKM_List_SelectedGuild };

			SKM_ActivePopup = true;
			SKMapStaticPopupEdit:Show();
		end

	elseif (sFrame == "SKMap_DuelFrame") then

		if (SKM_DuelList_SelectedPlayer == nil) then
			SkM_Trace(FName, 2, "No selected player !");
			return;
		end

		local Enemy = SKM_Data[_RealmName][_PlayerName].DuelHistory[SKM_DuelList_SelectedPlayer];
		if (Enemy == nil) then
			SkM_Trace(FName, 2, "Enemy not found : "..snil(SKM_DuelList_SelectedPlayer));
			return;
		end

		local sPlayerColor = SKM_Config.Col_LabelTitle;

		MyPrompt:SetText(string.format(SKM_UI_STRINGS.List_EditPlayerNote_Prompt, SKM_Config.Col_Label, sPlayerColor, SKM_DuelList_SelectedPlayer, SKM_Config.Col_Label));

		MyEditBox:SetText(ifnil(Enemy[_SKM._playerNote], ""));

		SKM_EditNoteContext = { List = _SKM._duels, Element = SKM_DuelList_SelectedPlayer };

		SKM_ActivePopup = true;
		SKMapStaticPopupEdit:Show();
	end

end


function SKMap_WorldControlHide_OnClick()
	local FName = "SKMap_WorldControlHide_OnClick";

	SkM_SetOption("ShowWorldMapControl", false);
	SKMapWorldMapControl:Hide();
end


function SKMap_WorldControlShowRecords_OnClick()
	local FName = "SKMap_WorldControlShowRecords_OnClick";

	local idx=1;
	local MyButton = getglobal("SKMapWorldMapControl_CheckButton"..idx);

	if (not MyButton:GetChecked()) then
		SkM_SetOption("MapDisplayRecords", false);
	else
		SkM_SetOption("MapDisplayRecords", true);
	end

	SkM_MainDraw();
end




function SKMap_IsUIVisible()
	local bVisible = false;
	local sSubFrame = nil;

	if (SKMapFrame:IsVisible()) then
		bVisible = true;

		for idx, val in SKM_TAB_SUBFRAMES do
			local tabFrame = getglobal(val);
			if (tabFrame:IsVisible()) then
				sSubFrame = val;
			end
		end
	end

	return bVisible, sSubFrame;
end


function SKMap_DuelFrame_Load()
	local FName = "SKMap_DuelFrame_Load";

	SkM_Trace(FName, 1, "Loading DuelFrame");

	SKMap_SetDuelListContent();
	SKMap_DuelFrame_UpdateList();
	SKMap_DuelFrame_SortList();

end


function SKMap_SetDuelListContent()
	local FName = "SKMap_SetDuelListContent";

	SKM_DuelList_Content = { };

	local idx, val;
	for idx, val in  SKM_Data[_RealmName][_PlayerName].DuelHistory do
		local Elem = copytable(val);

		Elem[_SKM._class] = SkM_GetClassText(Elem[_SKM._class]);
		Elem[_SKM._race] = SkM_GetRaceText(Elem[_SKM._race]);

		if (Elem[_SKM._duel]) then
			Elem[_SKM._score] = math.floor(100 * 100 * ifnil(Elem[_SKM._win], 0)/Elem[_SKM._duel]) / 100;
		end
		table.insert(SKM_DuelList_Content, Elem);
	end

end


function SKMap_DuelFrame_UpdateList()
	local FName = "SKMap_DuelFrame_UpdateList";

	local iScrollOffset = FauxScrollFrame_GetOffset(SKMap_DuelScrollFrame);

	SkM_Trace(FName, 4, "Scrollbar offset = "..snil(iScrollOffset));

	local iEnemyCount = table.getn(SKM_DuelList_Content);
	SkM_Trace(FName, 4, "Enemy Count = "..snil(iEnemyCount));

	local iEnemyIndex = iScrollOffset + 1;

	SkM_Trace(FName, 4, "Enemy Index = "..snil(iEnemyIndex));

	local i;
	for i=1, SKM_DUELFRAME_ROWS, 1 do
		local RowButton = getglobal("SKMap_DuelFrameButton"..i);

		if (iEnemyIndex <= iEnemyCount) then

			RowButtonName = getglobal("SKMap_DuelFrameButton"..i.."Name");
			RowButtonGuild = getglobal("SKMap_DuelFrameButton"..i.."Guild");
			RowButtonLevel = getglobal("SKMap_DuelFrameButton"..i.."Level");
			RowButtonRace = getglobal("SKMap_DuelFrameButton"..i.."Race");
			RowButtonClass = getglobal("SKMap_DuelFrameButton"..i.."Class");

			RowButtonWin = getglobal("SKMap_DuelFrameButton"..i.."Win");
			RowButtonLoss = getglobal("SKMap_DuelFrameButton"..i.."Loss");
			RowButtonDuel = getglobal("SKMap_DuelFrameButton"..i.."Duel");
			RowButtonLastDuel = getglobal("SKMap_DuelFrameButton"..i.."LastDuel");
			RowButtonScore = getglobal("SKMap_DuelFrameButton"..i.."Score");

			local sName = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._name], "??");
			local sLevel = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._level], "??");
			local sRace = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._race], "??");
			local sClass = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._class], "??");
			local sLastDuel = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._lastDuel], "??");


			local sGuild = SKM_DuelList_Content[iEnemyIndex][_SKM._guild];

			local iWin = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._win], 0);
			local iLoss = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._loss], 0);

			local iDuel = ifnil(SKM_DuelList_Content[iEnemyIndex][_SKM._duel], 0);

			if (sLevel == -1) then
				sLevel = "++";
			end

			local iScore = SKM_DuelList_Content[iEnemyIndex][_SKM._score];

			RowButtonName:SetText(sName);
			RowButtonGuild:SetText(sGuild);
			RowButtonLevel:SetText(sLevel);
			RowButtonRace:SetText(sRace);
			RowButtonClass:SetText(sClass);
			RowButtonWin:SetText(iWin);
			RowButtonLoss:SetText(iLoss);
			RowButtonDuel:SetText(iDuel);
			RowButtonLastDuel:SetText(sLastDuel);
			RowButtonScore:SetText(iScore);

			RowButton:Show();

			iEnemyIndex = iEnemyIndex + 1;
		else
			RowButton:Hide();
		end
	end

	FauxScrollFrame_Update(SKMap_DuelScrollFrame, iEnemyCount, SKM_DUELFRAME_ROWS, SKM_DUELFRAME_ROWHEIGHT);
end


function SKMap_DuelFrame_SortList(sSortType)
	local FName = "SKMap_DuelFrame_SortList";

	if (sSortType) then
		--if (sSortType == SKM_DuelList_SortType) then
		if (sSortType == SkM_GetOption("DuelList_SortType") ) then
			--if (SKM_DuelList_ReverseSort) then
			if ( SkM_GetOption("DuelList_ReverseSort") ) then
				--SKM_DuelList_ReverseSort = false;
				SkM_SetOption("DuelList_ReverseSort", false);
			else
				--SKM_DuelList_ReverseSort = true;
				SkM_SetOption("DuelList_ReverseSort", true);
			end
		else
			--SKM_DuelList_SortType = sSortType;
			SkM_SetOption("DuelList_SortType", sSortType);

			--SKM_DuelList_SortTypes = removefromlist(sSortType, SKM_DuelList_SortTypes);
			SKM_Settings.DuelList_SortTypes = removefromlist(sSortType, SkM_GetOption("DuelList_SortTypes") );
			--table.insert(SKM_DuelList_SortTypes, 1, sSortType);
			table.insert(SKM_Settings.DuelList_SortTypes, 1, sSortType);
		end
	end

	if (SKM_DuelList_Content) then
		table.sort(SKM_DuelList_Content, SKMap_DuelFrame_Sort);
	end

	SKMap_DuelFrame_UpdateList();
end



function SKMap_DuelFrame_Sort(e1, e2)
	local FName = "SKMap_DuelFrame_Sort";

	SkM_Trace(FName, 4, "Begin");

	if (e1 == nil) then
		if (e2 == nil) then
			return false;
		else
			return true;
		end
	elseif (e2 == nil) then
		return false;
	end

	--local iSortTypes = table.getn(SKM_DuelList_SortTypes);
	local iSortTypes = table.getn( SkM_GetOption("DuelList_SortTypes") );

	local i;
	for i=1, iSortTypes, 1 do
		local bReverseSort = false;
		--if (i == 1) and (SKM_DuelList_ReverseSort == true) then
		if (i == 1) and ( SkM_GetOption("DuelList_ReverseSort") ) then
			bReverseSort = true;
		end
		--local bCmp = SKMap_ListFrame_SubSort(e1, e2, SKM_DuelList_SortTypes[i], bReverseSort);
		local bCmp = SKMap_ListFrame_SubSort(e1, e2, SkM_GetOption("DuelList_SortTypes")[i], bReverseSort);
		if (bCmp ~= nil) then
			return bCmp;
		end
	end
	return false;

end


function SKMap_DuelFrame_SelectElement(sPlayerName)
	local FName = "SKMap_DuelFrame_SelectElement";

	local sName;

	if (sPlayerName ~= nil) then
		sName = sPlayerName;
	else
		local id = this:GetID();
		local iScrollOffset = FauxScrollFrame_GetOffset(SKMap_DuelScrollFrame);
		local iEnemyCount = table.getn(SKM_DuelList_Content);

		SkM_Trace(FName, 3, "Scroll offset = "..iScrollOffset);
		SkM_Trace(FName, 3, "Line id = "..id);

		local iEnemyIndex = iScrollOffset + id;
		SkM_Trace(FName, 3, "Enemy Index = "..iEnemyIndex);

		if (iEnemyIndex <= iEnemyCount) then
			sName = SKM_DuelList_Content[iEnemyIndex][_SKM._name];
		end

	end

	local Enemy;
	if (sName ~= nil) then
		Enemy = SKM_Data[_RealmName][_PlayerName].DuelHistory[sName];
	end

	local Lines = { };

	if (Enemy ~= nil) then
		SKM_DuelList_SelectedPlayer = sName;

		local Guild;

		local sGuild = Enemy[_SKM._guild];
		local sLevel = ifnil(Enemy[_SKM._level], "??");
		local sRace = ifnil(SkM_GetRaceText(Enemy[_SKM._race]), "??");
		local sClass = ifnil(SkM_GetClassText(Enemy[_SKM._class]), "??");
		local sLastDuel = ifnil(Enemy[_SKM._lastDuel], "??");

		local iWin = ifnil(Enemy[_SKM._win], 0);
		local iLoss = ifnil(Enemy[_SKM._loss], 0);
		local iDuel = ifnil(Enemy[_SKM._duel], 0);

		local iScore = math.floor(100 * 100 * ifnil(Enemy[_SKM._win], 0)/Enemy[_SKM._duel]) / 100;

		if (sLevel == -1) then
			sLevel = "++";
		end


		SKMap_DuelFrame_EditNote:Show();
		--SKMap_DuelFrame_ReportButton:Show();
		SKMap_DuelFrame_DeleteButton:Show();


		-- line 1 : player name
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Player;
		sLine = sLine..SKM_Config.Col_Label;
		sLine = sLine..sName..SKM_Config.Col_Label;


		table.insert(Lines, sLine);


		-- line 2 (optional) : player guild
		if (sGuild ~= nil) and (sGuild ~= "") then

			local sLine = "";
			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Guild;
			sLine = sLine..SKM_Config.Col_Label;
			sLine = sLine..sGuild..SKM_Config.Col_Label;

			table.insert(Lines, sLine);
		end


		-- line 3 (optional, not shown if info not available) : level race class
		if (Enemy[_SKM._level] ~= nil) and (Enemy[_SKM._race] ~= nil) and (Enemy[_SKM._class] ~= nil) then

			local sLine = "";
			sLine = sLine..SKM_Config.Col_Label..SKM_UI_STRINGS.List_Frame_Level..sLevel.." "..sRace.." "..sClass; -- 0.08.2 Add localization

			table.insert(Lines, sLine);
		end


		-- line 4 : last duel time
		if (Enemy[_SKM._lastDuel] ~= nil) then

			local sLine = "";

			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Last_Duel;
			sLine = sLine..SKM_Config.Col_Label..Enemy[_SKM._lastDuel];

			if (Enemy[_SKM._continent] ~= nil) and (Enemy[_SKM._zone] ~= nil) then
				--local sZoneText = SKM_Context.Zones[Enemy[_SKM._continent]][Enemy[_SKM._zone]];
				local sZoneText = SkM_GetZoneTextFromIndex(Enemy[_SKM._continent], Enemy[_SKM._zone]);
				sLine = sLine.." - "..sZoneText;
			end

			table.insert(Lines, sLine);
		end


		-- line 6 : meet and death counts
		local sLine = "";

		sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Duel..SKM_Config.Col_Label..iDuel;
		sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Win..SKM_Config.Col_DuelWin .. iWin;
		sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Loss..SKM_Config.Col_DuelLoss .. iLoss;
		sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Score..SKM_Config.Col_Label .. iScore;

		table.insert(Lines, sLine);



		-- line 8 : player notes
		if (Enemy[_SKM._playerNote] ~= nil) and (Enemy[_SKM._playerNote] ~= "") then
			local sLine = "";

			sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Note; -- 0.08.2 Add localization
			sLine = sLine..SKM_Config.Col_Label..Enemy[_SKM._playerNote];

			table.insert(Lines, sLine);
		end


		local i;
		for i=1, SKM_DUELFRAME_DETAIL_ROWS, 1 do
			local ButtonText = getglobal("SKMap_DuelFrameDetailButton"..i.."Text");

			if (i <= getn(Lines)) then
				SkM_Trace(FName, 2, i.." : "..Lines[i]);

				if (ButtonText) then
					ButtonText:SetText(Lines[i]);
				end
			else
				ButtonText:SetText("");
			end
		end
	end

end


function SKMap_DuelEditNote()
	local FName = "SKMap_DuelEditNote";

	if (SKM_ActivePopup) then
		return;
	end

	local sPopupEdit = "SKMapStaticPopupEdit";
	local MyEditBox = getglobal(sPopupEdit.."EditBox");
	local MyTitle = getglobal(sPopupEdit.."Title");
	local MyPrompt = getglobal(sPopupEdit.."Prompt");

	MyTitle:SetText(SKM_UI_STRINGS.List_EditNote_Title);


	if (SKM_DuelList_SelectedPlayer == nil) then
		SkM_Trace(FName, 2, "No selected player !");
		return;
	end

	local Enemy = SKM_Data[_RealmName][_PlayerName].DuelHistory[SKM_DuelList_SelectedPlayer];
	if (Enemy == nil) then
		SkM_Trace(FName, 2, "Enemy not found : "..snil(SKM_DuelList_SelectedPlayer));
		return;
	end

	local sPlayerColor = SKM_Config.Col_LabelTitle;

	MyPrompt:SetText(string.format(SKM_UI_STRINGS.List_EditPlayerNote_Prompt, SKM_Config.Col_Label, sPlayerColor, SKM_List_SelectedPlayer, SKM_Config.Col_Label));

	MyEditBox:SetText(ifnil(Enemy[_SKM._playerNote], ""));

	SKM_EditNoteContext = { List = _SKM._duels, Element = SKM_DuelList_SelectedPlayer };

	SKM_ActivePopup = true;
	SKMapStaticPopupEdit:Show();

end


function SKMap_DeleteDuel_Accept(sName)
	local FName = "SKMap_DeleteDuel_Accept";

	SkM_Trace(FName, 2, "Delete confirmed : Name = "..snil(sName));

	if (sName ~= nil) then

		SkM_DeleteDuelEnemy(sName);

		if (SKM_DuelList_SelectedPlayer == sName) then
			SKM_DuelList_SelectedPlayer = nil;
			SKMap_DuelFrame_ClearDetail();
		end

		SKMap_DuelFrame_Load();
	end

	SKM_ActivePopup = false;
end


function SKMap_DeleteDuel_OnClick()
	local FName = "SKMap_DeleteDuel_OnClick";

	SkM_Trace(FName, 1, "Delete requested");

	if (SKM_ActivePopup) then
		return;
	end

	local sName;
	local ActiveList = SKM_List_ActiveList;

	sName = SKM_DuelList_SelectedPlayer;

	if (sName == nil) then
		return;
	end

	local sPlayerColor = SKM_Config.Col_LabelTitle;
	local Enemy = SKM_Data[_RealmName][_PlayerName].DuelHistory[SKM_DuelList_SelectedPlayer];

	local dialogdef = StaticPopupDialogs["SKMAP_CONFIRM"];

	dialogdef.text  = string.format(SKM_UI_STRINGS.Duel_ConfirmDeletePlayer, SKM_Config.Col_Label, sPlayerColor, sName, SKM_Config.Col_Label);

	dialogdef.OnAccept = function() SKMap_DeleteDuel_Accept(sName) end;

	SKM_ActivePopup = true;
	StaticPopup_Show("SKMAP_CONFIRM");
end


function SKMap_DuelFrame_ClearDetail()
	local i;
	for i=1, SKM_DUELFRAME_DETAIL_ROWS, 1 do
		local ButtonText = getglobal("SKMap_DuelFrameDetailButton"..i.."Text");
		if (ButtonText) then
			ButtonText:SetText("");
		end
	end

	SKMap_DuelFrame_EditNote:Hide();
	--SKMap_DuelFrame_ReportButton:Hide();
	SKMap_DuelFrame_DeleteButton:Hide();
end


function SKMap_ReportFrame_UseAssist()
	local FName = "SKMap_ReportFrame_UseAssist";

	local MyButton = getglobal("SKMap_ReportFrameCheckButton1");

	--SKM_Config.FilterNotAtWar = false;
	--if (MyButton:GetChecked()) then
	--	SKM_Config.FilterNotAtWar = true;
	--end

	local idx=1;
	local MyButton = getglobal("SKMap_ReportFrameCheckButton"..idx);

	if (not MyButton:GetChecked()) then
		SkM_SetOption("AssistKillStat", false);
	else
		SkM_SetOption("AssistKillStat", true);
	end

	if (SKM_CurrentBook ~= nil) then
		SKMap_Report_LoadBook(SKM_CurrentBook);

		SKMap_ReportFrame_Load();
	end
end


function SKMap_TargetFrame_OnDragStart()

	if (not SkM_GetOption("LockedTargetInfo")) then
		if (SkM_GetOption("SmallTargetInfo")) then
			SKMapSmallTargetInfoFrame:StartMoving();
		else
			SKMapTargetInfoFrame:StartMoving();
		end
	end
end


function SKMap_TargetFrame_OnDragStop()
	--TargetLogHistoryFrame:StopMovingOrSizing();

	if (SkM_GetOption("SmallTargetInfo")) then
		SKMapSmallTargetInfoFrame:StopMovingOrSizing();
	else
		SKMapTargetInfoFrame:StopMovingOrSizing();
	end
end


function SKMap_Frame_MouseUp()
	local FName = "SKMap_Frame_MouseUp";

	if ( this.isMoving ) then
		this:StopMovingOrSizing();
		this.isMoving = false;

		local frameName = this:GetName();

		if (frameName == "SKMapTargetInfoFrame" ) then
			SKMapSmallTargetInfoFrame:ClearAllPoints();
			SKMapSmallTargetInfoFrame:SetPoint("TOPLEFT","SKMapTargetInfoFrame","TOPLEFT",0,0);
		elseif (frameName == "SKMapSmallTargetInfoFrame" ) then
			SKMapTargetInfoFrame:ClearAllPoints();
			SKMapTargetInfoFrame:SetPoint("TOPLEFT","SKMapSmallTargetInfoFrame","TOPLEFT",0,0);
		end

	end
end

function SKMap_Frame_MouseDown(bLocked)
 --if ( ( ( not this.isLocked ) or ( this.isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then
	if (not bLocked) and ( arg1 == "LeftButton" ) then
  	this:StartMoving();
  	this.isMoving = true;
	end
end

--/script SKMapTargetInfoFrame:SetPoint("TOPLEFT","TargetFrame","TOPRIGHT",-32,-52);
--/script SKMapSmallTargetInfoFrame:SetPoint("TOPLEFT","TargetFrame","TOPRIGHT",-32,-52);


function SKMap_TooltipAddLines(Lines)
	local i;
	for i=1, table.getn(Lines), 1 do
		GameTooltip:AddLine(Lines[i]);
	end

  --GameTooltip:SetHeight( GameTooltip:GetHeight() + GameTooltip:GetHeight() / GameTooltip:NumLines() );
  GameTooltip:Show();
end


function SKMap_TooltipEnemyInfo(sName)
	local FName = "SKMap_TooltipEnemyInfo";

	local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
	if (not Enemy) then
		SkM_Trace(FName, 2, "Unknown enemy : "..snil(sName));
		return false;
	end

	local iKill = ifnil(Enemy[_SKM._playerKill], 0);
	local iAssistKill = ifnil(Enemy[_SKM._playerAssistKill], 0);
	local iFullKill = ifnil(Enemy[_SKM._playerFullKill], 0);
	local iTotalKill = iKill + iAssistKill + iFullKill;
	local iDeath = ifnil(Enemy[_SKM._enemyKillPlayer], 0);
	local iMet = ifnil(Enemy[_SKM._meetCount], 0);
	local iLoneWolf = ifnil(Enemy[_SKM._loneWolfKill], 0);

	local iHonorKill = ifnil(Enemy[_SKM._honorKill], 0);
	local iRemaining = SkM_GetHonorRemainingKills(sName);

	local Lines = { };


	local sLine = "";
	sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Met..SKM_Config.Col_PlayerMet..iMet; -- 0.08.2 Add localization
	sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Death..SKM_Config.Col_PlayerDeath .. iDeath; -- 0.08.2 Add localization
	--sLine = sLine.."     "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_LoneWolf..SKM_Config.Col_LoneWolfKill .. iLoneWolf;

	table.insert(Lines, sLine);


	local sLine = "";
	sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Kill..SKM_Config.Col_PlayerTotalKill..iTotalKill;
	--sLine = sLine.."   "..SKM_Config.Col_Label.."( ";
	--sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Full..SKM_Config.Col_PlayerFullKill..iFullKill;
	--sLine = sLine..SKM_Config.Col_Label.." + "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Standard..SKM_Config.Col_PlayerKill..iKill; -- 0.08.2 Add localization
	--sLine = sLine..SKM_Config.Col_Label.." + "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Assist..SKM_Config.Col_PlayerAssistKill..iAssistKill..SKM_Config.Col_Label.." )"; -- 0.08.2 Add localization

	local sKillDetail = SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.Small_Target_Honor..SKM_Config.Col_HonorKill..iHonorKill.."  ";
	if (iRemaining == 0) then
		sKillDetail = sKillDetail..SKM_Config.Col_Label.."( "..SKM_Config.Col_Honorless..SKM_UI_STRINGS.Small_Target_NoHonor..SKM_Config.Col_Label.." )";
	else
		sKillDetail = sKillDetail..SKM_Config.Col_Label.."( "..SKM_Config.Col_HonorKill..iRemaining..SKM_Config.Col_Label.." )";
	end
	sLine	= sLine.."     "..sKillDetail;

	table.insert(Lines, sLine);


	if (Enemy[_SKM._atWar] == true) then
		local sLine = "";
		sLine = sLine..SKM_Config.Col_PlayerWar.. SKM_UI_STRINGS.Small_Target_War;
		if (Enemy[_SKM._warDate]) then
				local sDisplayDate = string.sub(Enemy[_SKM._warDate], 1, 10);
				sLine = sLine..SKM_Config.Col_PlayerWar .. SKM_UI_STRINGS.Since .. sDisplayDate;
		end


		table.insert(Lines, sLine);
	end

	SKMap_TooltipAddLines(Lines);
end


function SKMap_TooltipEnemyNote(sName)
	local FName = "SKMap_TooltipEnemyNote";

	local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
	if (not Enemy) then
		SkM_Trace(FName, 2, "Unknown enemy : "..snil(sName));
		return false;
	end


	local Lines = { };
	if (Enemy[_SKM._playerNote] ~= nil) and (Enemy[_SKM._playerNote] ~= "") then
		local sLine = Enemy[_SKM._playerNote];
		SkM_TableInsertMaxLengthLine(Lines, sLine, SKM_Config.MaxFormatLineLength, SKM_Config.FormatLineThreshold, SKM_Config.Col_Label);
	end

	SKMap_TooltipAddLines(Lines);
end


function SKMap_OptionsFrame_ScrollUpdate()
	SKMap_OptionsFrame_Load();
end


function SKMap_GetOptionLine(elemID)
	local lineID = elemID;
	if (not SKM_List_Options) then
		return nil;
	end

	if (lineID > 100) then
		lineID = lineID - 100;

		if (SKM_List_Options[lineID]) and (SKM_List_Options[lineID].Right) then

			return SKM_List_Options[lineID].Right;

		end
	else
		if (SKM_List_Options[lineID]) and (SKM_List_Options[lineID].Left) then
			return SKM_List_Options[lineID].Left;
		end
	end
	return nil;
end

function SKMap_OptionChecked()
	local FName = "SKMap_OptionChecked";
	--local id = this:GetID();
	local id = this:GetParent():GetID();
	SkM_Trace(FName, 3, "id = "..snil(id));

	local sOption = SKMap_GetOptionLine(id);
	SkM_Trace(FName, 2, "Option = "..snil(sOption));

	local OptionName = this:GetName();
	local MyButton = getglobal(OptionName);

	if (not MyButton:GetChecked()) then
		SkM_SetOption(sOption, false);
	else
		SkM_SetOption(sOption, true);
	end

	if (sOption == "ShowMinimapButton") then
		SKMap_SetMiniMapIcon();
	end
end

function SKMap_OptionSliderChange()
	local FName = "SKMap_OptionSliderChange";
	--local id = this:GetID();
	local id = this:GetParent():GetID();
	local sOption = SKMap_GetOptionLine(id);

	local SliderName = this:GetName();
	SkM_Trace(FName, 4, "Slider name = "..SliderName);

	local MySlider = getglobal(SliderName);
	local SliderText = getglobal(SliderName.."Text");

	iValue = MySlider:GetValue();
	SliderText:SetText(iValue);

	SkM_SetOption(sOption, iValue);

	if (sOption == "MinimapButtonPosition") or (sOption == "MinimapButtonOffset") then
		SKMap_SetMiniMapIcon();
	end

end


function SKMap_IconButtonClicked()
	--local id = this:GetID();
	local id = this:GetParent():GetID();
	local iCateg = SKM_List_Options[id].Category;
	if (iCateg) then
		if (SKM_OptionsList[iCateg].Expanded == true) then
			SKM_OptionsList[iCateg].Expanded = false
		else
			SKM_OptionsList[iCateg].Expanded = true;
		end
		SKMap_OptionsFrame_Load();
	end
end


function SKMap_OptionExpandAll()
	local i;
	for i=1,table.getn(SKM_OptionsList),1 do
		SKM_OptionsList[i].Expanded = true;
	end
	SKMap_OptionsFrame_Load();
end

function SKMap_OptionCollapseAll()
	local i;
	for i=1,table.getn(SKM_OptionsList),1 do
		SKM_OptionsList[i].Expanded = false;
	end
	SKMap_OptionsFrame_Load();
end



function SKMap_EnemyList_ResetSort()

	if (SKM_List_ActiveList == _SKM._players) then
		SKM_Settings.EnemyList_SortType = SKM_Config.EnemyList_SortType;
		SKM_Settings.EnemyList_SortTypes = SKM_Config.EnemyList_SortTypes;
		SKM_Settings.EnemyList_ReverseSort = SKM_Config.EnemyList_ReverseSort;

		SKMap_ListFrame_SortList();
	elseif (SKM_List_ActiveList == _SKM._guilds) then
		SKM_Settings.GuildList_SortType = SKM_Config.GuildList_SortType;
		SKM_Settings.GuildList_SortTypes = SKM_Config.GuildList_SortTypes;
		SKM_Settings.GuildList_ReverseSort = SKM_Config.GuildList_ReverseSort;

		SKMap_ListFrame_SortGuildList();
	end
end

function SKMap_DuelList_ResetSort()
	SKM_Settings.DuelList_SortType = SKM_Config.DuelList_SortType;
	SKM_Settings.DuelList_SortTypes = SKM_Config.DuelList_SortTypes;
	SKM_Settings.DuelList_ReverseSort = SKM_Config.DuelList_ReverseSort;

	SKMap_DuelFrame_SortList();
end




-- check if the enemy players list displayed in the GUI has to be generated
-- or if it is not required.
function SKMap_PlayerListUpdateNeeded()
	local bUpdate = false;
	local curTime = GetTime();

	if (SKM_Context.LastPlayerListUpdate == nil) then
		bUpdate = true;
	else
		if (SKM_Context.PlayerDataChanged) then
			if (SkM_GetOption("EnemyListAutoUpdate"))
			and ((curTime - SKM_Context.LastPlayerListUpdate) > SkM_GetOption("EnemyListAutoUpdateDelay")) then
				bUpdate = true;
			end
		end
	end

	if (bUpdate) then
		SKM_Context.LastPlayerListUpdate = curTime;
		SKM_Context.PlayerDataChanged = false;
	end
	return bUpdate;
end


function SKMap_ListFrame_UpdateListButtonClick()
	local curTime = GetTime();

	if (SKM_List_ActiveList == _SKM._players) then

		SKM_Context.LastPlayerListUpdate = curTime;
		SKM_Context.PlayerDataChanged = false;

		SKMap_SetListContent();
		SKMap_ListFrame_UpdateList();
		SKMap_ListFrame_SortList();
	end
end

