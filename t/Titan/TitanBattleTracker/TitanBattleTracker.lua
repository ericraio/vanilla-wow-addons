-- Addon information variables.
TITAN_TITANBT_ID        = "TitanBT";
TITANBT_MENU_TEXT       = "BattleTracker";
TITAN_TITANBT_FREQUENCY = 0.5;
TITANBT_ARTWORK_PATH    = "Interface\\AddOns\\Titan\\TitanBattleTracker\\Artwork\\TitanBT";
TITANBT_BLUETEXT        = "|cff0070dd"
TITANBT_NOTICK          = 0;

-- Game win/loss ratio stats

BTStats = {};

BTStats["AV"] = {};
BTStats["WSG"] = {};
BTStats["AB"] = {};

BTStats.AV.Games = 0;
BTStats.AB.Games = 0;
BTStats.WSG.Games = 0;

BTStats.AV.Wins = 0;
BTStats.AB.Wins = 0;
BTStats.WSG.Wins = 0;

BTStats.AV.Losses = 0;
BTStats.AB.Losses = 0;
BTStats.WSG.Losses = 0;

TitanBT_Vars = {};

TitanBT_Vars.ShowAVText = false;
TitanBT_Vars.ShowWSGText = false;
TitanBT_Vars.ShowABText = false;

TitanBT_Vars.Debug = false;

-- Indicates the addon was successfully loaded.
local _addon_loaded = false;


-- #####################
-- ## EVENT FUNCTIONS ##
-- #####################

-- ## Events occuring when caught in game by the system.
function TitanPanelTitanBTButton_OnEvent(event, arg1)
	if (event == "ADDON_LOADED") then

		-- Indicate the addon has finished loading.
		_addon_loaded = true;

	elseif ( event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" or event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE" or event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 ~= nil) then
			TitanBT_DebugPrint("Battleground Event {"..event.."} arg1 {"..arg1.."}");
			if ( event == "CHAT_MSG_MONSTER_YELL" ) then
				if ( arg2 ~= "Horde" and arg2 ~= "Alliance" and arg2 ~= "Herald" ) then
					TitanBT_DebugPrint("Event "..event.." arg2 {"..arg2.."} did not match");
					return;
				end
			end

			if ( string.find(arg1, TITANBT_NOTICE_GAMEOVER) ) then

				TitanBT_DebugPrint("arg1 {"..arg1.."} indicates this is a GAME OVER message");

				-- Only add to the correct one
				if ( GetRealZoneText() == TITANBT_BG_AV ) then
					BTStats.AV.Games = BTStats.AV.Games + 1;
				elseif ( GetRealZoneText() == TITANBT_BG_AB ) then
					BTStats.AB.Games = BTStats.AB.Games + 1;
				elseif ( GetRealZoneText() == TITANBT_BG_WSG ) then
					BTStats.WSG.Games = BTStats.WSG.Games + 1;
				end
	
				if ( string.find( arg1, (UnitFactionGroup("player")) ) ) then
					TitanPanelTitanBT_Print(string.format(TITANBT_GAMEWON, GetRealZoneText()));
					if ( GetRealZoneText() == TITANBT_BG_AV ) then
						BTStats.AV.Wins = BTStats.AV.Wins + 1;
					elseif ( GetRealZoneText() == TITANBT_BG_AB ) then
						BTStats.AB.Wins = BTStats.AB.Wins + 1;
					elseif ( GetRealZoneText() == TITANBT_BG_WSG ) then
						BTStats.WSG.Wins = BTStats.WSG.Wins + 1;
					end
				elseif ( string.find( arg1, (GetOpposingFaction()) ) ) then
					TitanPanelTitanBT_Print(string.format(TITANBT_GAMELOST, GetRealZoneText()));
					if ( GetRealZoneText() == TITANBT_BG_AV ) then
						BTStats.AV.Losses = BTStats.AV.Losses + 1;
					elseif ( GetRealZoneText() == TITANBT_BG_AB ) then
						BTStats.AB.Losses = BTStats.AB.Losses + 1;
					elseif ( GetRealZoneText() == TITANBT_BG_WSG ) then
						BTStats.WSG.Losses = BTStats.WSG.Losses + 1;
					end
				end
			end
		end
	end
end


function GetOpposingFaction()
	if ( (UnitFactionGroup("player")) == TITANBT_ALLIANCE ) then
		return TITANBT_HORDE;
	else
		return TITANBT_ALLIANCE;
	end
end

-- #####################
-- ## TITAN FUNCTIONS ##
-- #####################

-- ## Creates the text located on the titan bar.
function TitanPanelTitanBTButton_GetButtonText(id)
	local text = "";

	if ( not TitanBT_Vars.ShowABText and not TitanBT_Vars.ShowABText and not TitanBT_Vars.ShowWSGText ) then
		text = text..TITANBT_S_NULL;
	else
		text = text..TITANBT_S_SHORT;
	end

	if ( TitanBT_Vars.ShowAVText ) then
		text = text..TITANBT_S_AV..BTStats.AV.Games.."/"..TitanUtils_GetGreenText(BTStats.AV.Wins).."/"..TitanUtils_GetRedText(BTStats.AV.Losses)
	end
	if ( TitanBT_Vars.ShowABText ) then
		text = text..TITANBT_S_AB..BTStats.AB.Games.."/"..TitanUtils_GetGreenText(BTStats.AB.Wins).."/"..TitanUtils_GetRedText(BTStats.AB.Losses)
	end
	if ( TitanBT_Vars.ShowWSGText ) then
		text = text..TITANBT_S_WSG..BTStats.WSG.Games.."/"..TitanUtils_GetGreenText(BTStats.WSG.Wins).."/"..TitanUtils_GetRedText(BTStats.WSG.Losses)
	end

	return text;
end


-- ## Creates the tooltip text for the addon.
function TitanPanelTitanBTButton_GetTooltipText()
	local tt;
	tt = TITANBT_BLUETEXT .. TITANBT_TT_HeaderLeft .. "\t" .. TITANBT_TT_HeaderRight;

-- ## Alterac Valley
	tt = tt .. "\n" .. TITANBT_TT_AV .. "\t" .. BTStats.AV.Games .. "/" .. TitanUtils_GetGreenText(BTStats.AV.Wins) .. "/" .. TitanUtils_GetRedText(BTStats.AV.Losses);

-- ## Arathi Basin
	tt = tt .. "\n" .. TITANBT_TT_AB .. "\t" .. BTStats.AB.Games .. "/" .. TitanUtils_GetGreenText(BTStats.AB.Wins) .. "/" .. TitanUtils_GetRedText(BTStats.AB.Losses);

-- ## Warsong Gulch
	tt = tt .. "\n" .. TITANBT_TT_WSG .. "\t" .. BTStats.WSG.Games .. "/" .. TitanUtils_GetGreenText(BTStats.WSG.Wins) .. "/" .. TitanUtils_GetRedText(BTStats.WSG.Losses);

	return "\n" .. tt;
end


-- #######################
-- ## DISPLAY FUNCTIONS ##
-- #######################


-- ## Prints a message to the user's console.
function TitanPanelTitanBT_Print(string)
	DEFAULT_CHAT_FRAME:AddMessage("[TitanBT]: " .. string);
end

-- ## Prints a message to the user's console.
function TitanBT_DebugPrint(string)
	if ( TitanBT_Vars.Debug ) then
		DEFAULT_CHAT_FRAME:AddMessage("[TitanBT Debug]: " .. string);
	end
end

-- #############################
-- ## INITALISATION FUNCTIONS ##
-- #############################


-- ## Performed when the addon is loaded.
function TitanPanelTitanBTButton_OnLoad()
	this.registry = {
		id                  = TITAN_TITANBT_ID,
		menuText            = TITANBT_MENU_TEXT,
		buttonTextFunction  = "TitanPanelTitanBTButton_GetButtonText",
		tooltipTitle        = TITANBT_TOOLTIP,
		tooltipTextFunction = "TitanPanelTitanBTButton_GetTooltipText",
		icon                = TITANBT_ARTWORK_PATH,
		iconWidth           = 16,
		frequency           = TITAN_TITANBT_FREQUENCY,
		savedVariables = {
			ShowIcon      = 1,
		}
	};

	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
end

-- ####################
-- ## MENU FUNCTIONS ##
-- ####################

-- ## Creates the titan drop down menu for the addon.
function TitanPanelRightClickMenu_PrepareTitanBTMenu()

	local info = {};

	-- First Level Menu

	TitanPanelTitanBT_MenuAddHeader(TitanPlugins[TITAN_TITANBT_ID].menuText);

	-- Show Icon
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_TITANBT_ID);

	-- Show AV Label
	info       = {};
	info.text  = TITANBT_MENU_DISP_AV;
	info.value = "ShowAVText";
	info.func  = TitanPanelTitanBT_MenuClicked;
	TitanPanelTitanBT_MenuAddOption(info, nil);

	-- Show AB Label
	info       = {};
	info.text  = TITANBT_MENU_DISP_AB;
	info.value = "ShowABText";
	info.func  = TitanPanelTitanBT_MenuClicked;
	TitanPanelTitanBT_MenuAddOption(info, nil);

	-- Show WSG Label
	info       = {};
	info.text  = TITANBT_MENU_DISP_WSG;
	info.value = "ShowWSGText";
	info.func  = TitanPanelTitanBT_MenuClicked;
	TitanPanelTitanBT_MenuAddOption(info, nil);

	TitanPanelRightClickMenu_AddSpacer();

	-- Debug Mode
	info       = {};
	info.text  = TITANBT_MENU_OPTS_DEBUG;
	info.value = "Debug";
	info.func  = TitanPanelTitanBT_MenuClicked;
	TitanPanelTitanBT_MenuAddOption(info, nil);

	TitanPanelRightClickMenu_AddSpacer();

	-- Reset Stats
	info       = {};
	info.text  = TITANBT_MENU_FUNCS_RESET;
	info.value = "ResetStats";
	info.func  = TitanPanelTitanBT_ResetClicked;
	TitanPanelTitanBT_MenuAddOption(info, nil);	

	-- Hide
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_TITANBT_ID, TITAN_PANEL_MENU_FUNC_HIDE);

end


-- ## Adds a new header to the menu.
function TitanPanelTitanBT_MenuAddHeader(title, level)
	info              = {};
	info.text         = title;
	info.notClickable = 1;
	info.isTitle      = 1;
	UIDropDownMenu_AddButton(info, level);
end


-- ## Adds a new option to the menu.
function TitanPanelTitanBT_MenuAddOption(info, level)
	info.keepShownOnClick = 1;
	if (TitanBT_Vars[info.value]) then info.checked = 1; end
	UIDropDownMenu_AddButton(info, level);
end


-- ## Called when a menu item is clicked and requires action.
function TitanPanelTitanBT_MenuClicked()
	TitanPanelTitanBT_MenuToggleVar(this.value);
end

-- ## Called when the button is clicked.
function TitanPanelTitanBTButton_OnClick(button)
	if ( button ~= "LeftButton" ) then
		return;
	end

	local message = GetDataForChat();
	local numMembers = GetNumRaidMembers();
	if ( numMembers > 0 ) then
		SendChatMessage(message, "BATTLEGROUND");
	else
		TitanPanelTitanBT_Print(message);
	end
end

function GetDataForChat()
	local AV = "T:"..BTStats.AV.Games.."/W:"..BTStats.AV.Wins.."/L:"..BTStats.AV.Losses;
	local AB = "T:"..BTStats.AB.Games.."/W:"..BTStats.AB.Wins.."/L:"..BTStats.AB.Losses;
	local WSG = "T:"..BTStats.WSG.Games.."/W:"..BTStats.WSG.Wins.."/L:"..BTStats.WSG.Losses;
	local message = string.format(TITANBT_SEND_DATA, AV, AB, WSG);
	AV = nil;
	AB = nil;
	WSG = nil;
	return message;
end

-- ## Called when a menu item is clicked and requires action.
function TitanPanelTitanBT_ResetClicked()
	BTStats.AV.Games = 0;
	BTStats.AB.Games = 0;
	BTStats.WSG.Games = 0;
	BTStats.AV.Wins = 0;
	BTStats.AB.Wins = 0;
	BTStats.WSG.Wins = 0;
	BTStats.AV.Losses = 0;
	BTStats.AB.Losses = 0;
	BTStats.WSG.Losses = 0;
end


-- ## Toggles a specified variable in the menu, changing it from true to false and vice versa.
-- ##
-- ## Variables
-- ##     value: The value that UIDROPDOWNMENU_MENU_VALUE is set to when the button is clicked.
function TitanPanelTitanBT_MenuToggleVar(value)
	if (TitanBT_Vars[value]) then
		TitanBT_Vars[value] = false;
	else
		TitanBT_Vars[value] = true;
	end
end