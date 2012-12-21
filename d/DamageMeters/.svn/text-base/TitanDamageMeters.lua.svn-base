--[[
	Titan Plugin For DamageMeters 4.1.3
	Author: SeraphTC, with additions by Dandelion

	Code Changes By Dandelion (15/05/2006)

	TitanDamageMeters.Lua Changes:
	Changed the way Titan is detected to avoid falsely detecting it when Bhaldie Infobar is loaded.

	Code Change By SeraphTC (28/01/2006)
	
	TitanDamageMeters.Lua Changes:
	Moved the call for TitanPanelButton_OnLoad(); inside the 'if damagemeters loaded' statement to prevent errors when titan panel was not loaded.
	Changed the titan menu category from a non-existant TMSP variable (oops!  missed that last time!) to 'Information' where it belongs.
	Improved the feedback from IsDMLoaded() and prevent it being called twice (no need to call it from the right-side button when it will have already
	been called from the left-side button).
	Removed TITAN_DAMAGEMETERS_TPLOADED as we dont use it!
	Renamed TITAN_DAMAGEMETERS_LOADED to TITAN_AND_DAMAGEMETERS_LOADED as it contains the status of both titan and damagemeters
	Moved the 'Glue' functions to the end of the file above the 'Utility' functions to help keep things tidy :) 
	(makes sense to have the dedicated plugin code all together and called functions together at the end).

	Code Tidied By SeraphTC (23/01/2006)

	TitanDamageMeters.Lua Changes:
	Added TITAN_DAMAGEMETERS_TPLOADED variable to check for loaded status of Titan Panel
	Changed value of TITAN_DAMAGEMETERSRIGHT_MENU_TEXT from "Damage Meters" to "Damage Meters (Right)"
	Removed the TITAN_DAMAGEMETERS_VERSION variable and use DamageMeters_VERSIONSTRING instead (no point in duplicating values)
	Removed LeftTag and RightTag variables as completely unused.
	Removed Add/Ignore a Prefix on the menu/tooltip text depending on the availability of catagories, 
	as we dont check for this here!
	Renamed GetStatus() function to IsDMLoaded() to prevent possible conflicts with TMSP
	Removed IsAddonLoaded line from IsDMLoaded() as we dont use it!
	Removed Titan existance checking from onload statement and incorporated it with IsDMLoaded().  This way we have one function
	that handles both checks, will print error messages to the chat pane and will return 1 of 4 values for 
	future internal debugging.
	(GetAddonInfo provides a more reliable result with its "enabled" value)
	Removed the old refs to TitanPanelDamageMetersButton_xxxx function calls - may as well use the internal DamageMeters functions
	and save duplication!
	Added tests to see if damage meters and titan are loaded to most functions before any code is called - this should prevent WoW from returning
	nil value errors if either mod is not loaded.
	Added a TitanDMPrintD() - a stripped out version of DMPrintD from damagemeters, so that we can easily print to the chatchannel if damagemeters 
	is not running. (This will only be called from IsDMLoaded() but is a very quick way to prevent errors).
	(Dand) Added checks before calling TitanPanel base functions in two places that check that Titan is loaded.
	TitanDamageMeters.xml Changes:
	Removed reference to TitanDamageMetersFunctions.lua as we dont use it.

	File Structure Changes:
	Removed TitanDamageMetersFunctions.lua as not used.


	
]]--

-- Set Labels and ID
TITAN_DAMAGEMETERS_ID =  "DamageMeters";
TITAN_DAMAGEMETERSRIGHT_ID = "DamageMetersRight";
TITAN_DAMAGEMETERS_MENU_TEXT = "Damage Meters";
TITAN_DAMAGEMETERSRIGHT_MENU_TEXT = "Damage Meters (Right)";
TITAN_DAMAGEMETERS_BUTTON_LABEL =  "Damage Meters";
TITAN_DAMAGEMETERS_TOOLTIP = "Show Damage Meters";
TITAN_DAMAGEMETERS_ICONPATH = "Interface\\Addons\\DamageMeters\\Artwork\\TitanDamageMeters"
TITAN_AND_DAMAGEMETERS_LOADED = nil;

-- OnLoad Statement

function TitanPanelDamageMetersButton_OnLoad()
	
	TITAN_AND_DAMAGEMETERS_LOADED = IsDMLoaded();
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then		-- Only continue if DamageMeters AND Titan Panel are loaded
		this.registry = { 
			id = TITAN_DAMAGEMETERS_ID,
			category = "Information",
			version = DamageMeters_VERSIONSTRING,
			menuText = TITAN_DAMAGEMETERS_MENU_TEXT, 
			buttonTextFunction = "TitanPanelDamageMetersButton_GetButtonText", 
			tooltipTitle = TITAN_DAMAGEMETERS_TOOLTIP,
			tooltipTextFunction = "TitanPanelDamageMetersButton_GetTooltipText", 
			icon = TITAN_DAMAGEMETERS_ICONPATH,
			iconWidth = 16,
			frequency = 1, -- PC: Added.
			savedVariables = {
				ShowIcon = 1,
				ShowLabelText = 1,
				shownRanks = {},
				shownLeaders = {},
				shownValues = {}
			}
		};
		
		TitanPanelButton_OnLoad();  -- Dand: added.  TitanPanelButton_OnLoad not defined if Titan not loaded.
					    -- SeraphTC - moved this here instead of in its own 'If' statement - no point in doing 2x checks for the same thing in one function ;)
	end
end

-- OnLoad Statement For Right Side Icon
-- No ButtonTextFunction is required here, as Right Side menu's use the Icon Template and have no button text

function TitanPanelDamageMetersRightButton_OnLoad()
						
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		this.registry = { 
			id = TITAN_DAMAGEMETERSRIGHT_ID,
			category = "Information",
			version = DamageMeters_VERSIONSTRING,
			menuText = TITAN_DAMAGEMETERSRIGHT_MENU_TEXT,
			tooltipTitle = TITAN_DAMAGEMETERS_TOOLTIP,
			tooltipTextFunction = "TitanPanelDamageMetersButton_GetTooltipText", 
			icon = TITAN_DAMAGEMETERS_ICONPATH,
			iconWidth = 16,
			savedVariables = {
				ShowIcon = 1,
			}
		};
		
		TitanPanelButton_OnLoad();  -- Dand: added.  TitanPanelButton_OnLoad not defined if Titan not loaded.
					    -- SeraphTC - moved this here instead of in its own 'If' statement - no point in doing 2x checks for the same thing in one function ;)
	end
end


-- Update Button OnEvent

function TitanPanelDamageMetersButton_OnEvent()
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		TitanPanelButton_UpdateButton(TITAN_DAMAGEMETERS_ID);
	end
end

function TitanPanelDamageMetersButton_OnClick(button)
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		if (button == "LeftButton") then
			DamageMeters_ToggleShow();
		end
	end
end

-- Get Button Text

function TitanPanelDamageMetersButton_GetButtonText(id)
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		local button, id = TitanUtils_GetButton(id, true);
		local retstr = "";

		-- supports turning off labels
		if (TitanGetVar(TITAN_DAMAGEMETERS_ID, "ShowLabelText")) then
			retstr = "";

			local quant;

			-- Values.
			local shownValues = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownValues");
			for quant = 1, DamageMeters_Quantity_MAX do
				if (shownValues[quant]) then
					--local quantColorCode = DamageMeters_quantityColorCodeDefault[quant];
					local quantColorCode = "|cFFFFD040";
					retstr = string.format("%s "..quantColorCode.."%s=|cFFFFFFFF%s"..FONT_COLOR_CODE_CLOSE, retstr, DM_QUANTDEFS[quant].titanAbbrev, TitanPanelDamageMeters_GetValue(quant));
				end
			end

			-- Ranks.
			local playerRanks = DamageMeters_rankTables[DMT_ACTIVE][UnitName("Player")];
			if (nil ~= playerRanks and table.getn(playerRanks) > 0) then
				local shownRanks = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownRanks");
				for quant = 1, DamageMeters_Quantity_MAX do
					if (shownRanks[quant]) then
						local rank = playerRanks[quant];
						if (nil == rank) then
							rank = "-";
						else
							rank = tostring(rank);
						end
						--Dand: These colors don't all look good: using the regular text color instead.
						--local quantColorCode = DamageMeters_quantityColorCodeDefault[quant];
						local quantColorCode = "|cFFFFD040";
						retstr = string.format("%s "..quantColorCode.."%s#=|cFFFFFFFF%s"..FONT_COLOR_CODE_CLOSE, retstr, DM_QUANTDEFS[quant].titanAbbrev, rank);
					end
				end
			end

			-- Leaders.
			local shownLeaders = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownLeaders");
			for quant = 1, DamageMeters_Quantity_MAX do
				if (shownLeaders[quant]) then
					--local quantColorCode = DamageMeters_quantityColorCodeDefault[quant];
					local quantColorCode = "|cFFFFD040";
					retstr = string.format("%s "..quantColorCode.."%sL=|cFFFFFFFF%s"..FONT_COLOR_CODE_CLOSE, retstr, DM_QUANTDEFS[quant].titanAbbrev, TitanPanelDamageMeters_GetLeaderName(quant));
				end
			end

			if (retstr == "") then
				retstr = TITAN_DAMAGEMETERS_BUTTON_LABEL;
			end
		end
	
		return retstr
	end
end


-- Get Tooltip Text
-- NB: You can use XML to format the text in the str, eg:
-- \n = New Line
-- \t = Tab space
-- Others may work but I have not tested them yet.

function TitanPanelDamageMetersButton_GetTooltipText()
	return "Toggle Frame\tLeft-Click"
end

-- Setup Right Click Menu

function TitanPanelRightClickMenu_PrepareDamageMetersMenu()
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
			if (UIDROPDOWNMENU_MENU_VALUE == "Values") then
				local quant;
				for quant = 1, DamageMeters_Quantity_MAX do
					info = {};
					info.text = DamageMeters_GetQuantityString(quant, true);
					info.value = quant;
					info.func = TitanPanelDamageMeters_SetValueOption;
					info.checked = TitanPanelDamageMeters_IsValueShown(quant);
					info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
				end
			end

			if (UIDROPDOWNMENU_MENU_VALUE == "Ranks") then
				local quant;
				for quant = 1, DamageMeters_Quantity_MAX do
					info = {};
					info.text = DamageMeters_GetQuantityString(quant, true);
					info.value = quant;
					info.func = TitanPanelDamageMeters_SetRankOption;
					info.checked = TitanPanelDamageMeters_IsRankShown(quant);
					info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
				end
			end

			if (UIDROPDOWNMENU_MENU_VALUE == "Leaders") then
				local quant;
				for quant = 1, DamageMeters_Quantity_MAX do
					info = {};
					info.text = DamageMeters_GetQuantityString(quant, true);
					info.value = quant;
					info.func = TitanPanelDamageMeters_SetLeaderOption;
					info.checked = TitanPanelDamageMeters_IsLeaderShown(quant);
					info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		else
			-- Menu title
			TitanPanelRightClickMenu_AddTitle(TITAN_DAMAGEMETERS_MENU_TEXT);
			TitanPanelRightClickMenu_AddCommand("Reset Window Position",TITAN_DAMAGEMETERS_ID, "DamageMeters_ResetPos");
			TitanPanelRightClickMenu_AddCommand("Clear List",TITAN_DAMAGEMETERS_ID, "DamageMeters_Clear");

			-- 	A blank line in the menu
			TitanPanelRightClickMenu_AddSpacer();

			-- 	Generic function to toggle icon
			TitanPanelRightClickMenu_AddToggleIcon(TITAN_DAMAGEMETERS_ID);
			-- 	Generic function to toggle label text
			TitanPanelRightClickMenu_AddToggleLabelText(TITAN_DAMAGEMETERS_ID);

			-- 	A blank line in the menu
			TitanPanelRightClickMenu_AddSpacer();

			-- Value menu
			info = {};
			info.text = "Values";
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info);

			-- Rank menu
			info = {};
			info.text = "Ranks";
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info);

			-- Leaders menu
			info = {};
			info.text = "Leaders";
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info);

			-- 	A blank line in the menu
			TitanPanelRightClickMenu_AddSpacer();

			-- 	Generic function to hide the plugin
			TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_DAMAGEMETERS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
		end
	end
end

-- Setup Right Click Menu For Right Side Button

function TitanPanelRightClickMenu_PrepareDamageMetersRightMenu()
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		TitanPanelRightClickMenu_AddTitle(TITAN_DAMAGEMETERSRIGHT_MENU_TEXT);	

		TitanPanelRightClickMenu_AddCommand("Reset Window Position",TITAN_DAMAGEMETERS_ID, "DamageMeters_ResetPos");
		TitanPanelRightClickMenu_AddCommand("Clear List",TITAN_DAMAGEMETERS_ID, "DamageMeters_Clear");

		-- 	Generic function to hide the plugin
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_DAMAGEMETERSRIGHT_ID, TITAN_PANEL_MENU_FUNC_HIDE);
	end
end


-- Glue

function TitanDMPrintD(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg,0.50,0.50,1.00);
end

function IsDMLoaded()	-- Renamed from GetStatus() to prevent possible conflicts with Titan Mod Support Project Core Functions

	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("DamageMeters")
	local _, _, _, titanEnabled, _, _, _ = GetAddOnInfo("Titan")

	-- Dand: Some mod called Bhaldie Infobar actually defines this function. :|
	-- Seems generally better to use the GetAddOnInfo function anyway.
	--if not TitanPanelButton_UpdateButton then	-- If Titan is not running
	if not titanEnabled then	-- If Titan is not running
		if not (enabled == 1) then						-- If DamageMeters is not running
			TitanDMPrintD("DamageMeters: DamageMeters Not Loaded.");	-- Print in the chat channel
			TitanDMPrintD("DamageMeters: Titan Not Loaded.");		-- for both mods
			return 0;							-- Return 0
		else
			TitanDMPrintD("DamageMeters: Titan Not Loaded.");		-- Otherwise just let us know that Titan is not running
			TitanDMPrintD("DamageMeters: Titan Plugin Not Available");	-- the plugin will not be available
			TitanDMPrintD("DamageMeters: DamageMeters Loaded OK.");		-- but that DamageMeters loaded ok,
			return 1;							-- and return 1
		end

	elseif (enabled == 1) then			-- Otherwise Titan is running, so check DamageMeters
		TitanDMPrintD("DamageMeters: Titan Loaded OK.");		-- and if its running print in the chat channel
		TitanDMPrintD("DamageMeters: Titan Plugin Available");		-- for the plugin
		TitanDMPrintD("DamageMeters: DamageMeters Loaded OK.");		-- and for both mods
		return 2;							-- return 2
	else						-- otherwise Titan is running but DamageMeters is not
		TitanDMPrintD("DamageMeters: DamageMetersNot Loaded.");		-- so let us know
		return 3;							-- and return 3
	end
end

-- Utility functions

function TitanPanelDamageMeters_SetValueOption()
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		shownValues = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownValues");
		if (shownValues) then
			if (nil ~= shownValues[this.value]) then
				shownValues[this.value] = not shownValues[this.value];
			else
				shownValues[this.value] = true;
			end
		end	
	end
end

function TitanPanelDamageMeters_SetRankOption()
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		shownRanks = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownRanks");
		if (shownRanks) then
			if (nil ~= shownRanks[this.value]) then
				shownRanks[this.value] = not shownRanks[this.value];
			else
				shownRanks[this.value] = true;
			end
		end	
	end
end

function TitanPanelDamageMeters_SetLeaderOption()
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		shownLeaders = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownLeaders");
		if (shownLeaders) then
			if (nil ~= shownLeaders[this.value]) then
				shownLeaders[this.value] = not shownLeaders[this.value];
			else
				shownLeaders[this.value] = true;
			end
		end	
	end
end

function TitanPanelDamageMeters_IsValueShown(quant)
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		shownValues = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownValues");
		if (shownValues) then
			if (shownValues[quant]) then
				return shownValues[quant];
			end
		end
	
		return false;
	end
end

function TitanPanelDamageMeters_IsRankShown(quant)
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		shownRanks = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownRanks");
		if (shownRanks) then
			if (shownRanks[quant]) then
				return shownRanks[quant];
			end
		end
	
		return false;
	end
end

function TitanPanelDamageMeters_IsLeaderShown(quant)
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		shownLeaders = TitanGetVar(TITAN_DAMAGEMETERS_ID, "shownLeaders");
		if (shownLeaders) then
			if (shownLeaders[quant]) then
				return shownLeaders[quant];
			end
		end
	
		return false;
	end
end

function TitanPanelDamageMeters_GetValue(quantity)
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		return DamageMeters_GetQuantityValueString(quantity, UnitName("Player"));
	end
end

function TitanPanelDamageMeters_GetLeaderName(quant)
	if (TITAN_AND_DAMAGEMETERS_LOADED == 2) then
		for player, struct in DamageMeters_rankTables[DMT_ACTIVE] do
			if (struct[quant] == 1) then
				return player;
			end
		end

		return "-";
	end
end