------------------------
------------------------
--                    --
--  TitanAtlas        --
--  11/21/2005        --
--  Dan Gilbert
--  loglow@gmail.com  --
--                    --
------------------------
------------------------



-----------------------
-- support for myAddOns
-----------------------
TitanAtlasDetails = {
	name = "TitanAtlas",
	version = "1.3",
	releaseDate = "November 21, 2005",
	author = "Dan Gilbert / Adsertor",
	email = "loglow@gmail.com",
	website = "http://www.ocdproductions.net/Atlas/",
	category = MYADDONS_CATEGORY_MAP
};



-- Constants
TITAN_PANEL_UPDATE_BUTTON = 1;
TITAN_PANEL_UDPATE_TOOLTIP = 2;
TITAN_PANEL_UPDATE_ALL = 3;
TITAN_PANEL_LABEL_SEPARATOR = "  "

TITAN_PANEL_BUTTON_TYPE_TEXT = 1;
TITAN_PANEL_BUTTON_TYPE_ICON = 2;
TITAN_PANEL_BUTTON_TYPE_COMBO = 3;
TITAN_PANEL_BUTTON_TYPE_CUSTOM = 4;

TITAN_ATLAS_ID = "Atlas";
TITAN_ATLAS_FREQUENCY = 1;


ATLAS_LOCALE = {
	menu = "Atlas",
	tooltip = "Atlas",
	button = "Atlas"
};

ATLAS_HINT = "Hint: Left-click to open Atlas.";
ATLAS_OPTIONS_SHOWMAPNAME = "Show Map Name";


function TitanOptionSlider_TooltipText(text, value) 
	return text .. GREEN_FONT_COLOR_CODE .. value .. FONT_COLOR_CODE_CLOSE;
end

function TitanPanelAtlasButton_OnLoad()
	-- register plugin
	this.registry = { 
		id = TITAN_ATLAS_ID,
		menuText = ATLAS_LOCALE["menu"],
		buttonTextFunction = "TitanPanelAtlasButton_GetButtonText",
		tooltipTitle = ATLAS_LOCALE["tooltip"],
		tooltipTextFunction = "TitanPanelAtlasButton_GetTooltipText",
		frequency = TITAN_ATLAS_FREQUENCY, 
		icon = "Interface\\AddOns\\TitanAtlas\\Images\\TitanAtlasIcon",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = TITAN_NIL
		}
	};
	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_INDOORS");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("MINIMAP_ZONE_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
end

function TitanPanelAtlasButton_OnEvent()
	if(event == "VARIABLES_LOADED") then
		-----------------------
		-- support for myAddOns
		-----------------------
 		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(TitanAtlasDetails);
		end
	end

	if(event == "ZONE_CHANGED_NEW_AREA") then
			Atlas_OnShow();
	end
	this.zoneText = GetZoneText();
	this.subZoneText = GetSubZoneText();
end

function TitanPanelAtlasButton_GetButtonText(id)
	local retstr = "";

	-- supports turning off labels
	if (TitanGetVar(TITAN_ATLAS_ID, "ShowLabelText")) then	
		retstr = ATLAS_LOCALE["button"];
		if (AtlasOptions.AtlasMapName) then
			retstr = retstr .. ": ";
		end
	end

	if (AtlasOptions.AtlasMapName) then
		local zoneName = AtlasText[ATLAS_DROPDOWN_LIST[AtlasOptions.AtlasZone]]["ZoneName"];
		if (TitanGetVar(TITAN_ATLAS_ID, "ShowColoredText")) then	
			retstr = retstr .. TitanUtils_GetGreenText(zoneName);
		else
			retstr = retstr .. TitanUtils_GetNormalText(zoneName);
		end
	end

	return retstr;
end

function TitanPanelAtlasButton_GetTooltipText()
	local retstr = "You are in " .. this.zoneText;
	if(this.subZoneText ~= "") then
		 retstr = retstr .. " (" .. this.subZoneText .. ")";
	end
	retstr = retstr .. ".\n" .. TitanUtils_GetGreenText(ATLAS_HINT);
	return retstr;
end

function TitanPanelRightClickMenu_PrepareAtlasMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ATLAS_ID].menuText);
	
	info = {};
	info.text = ATLAS_OPTIONS_SHOWBUT;
	info.func = AtlasButton_Toggle;
	info.value = ATLAS_OPTIONS_SHOWBUT;
	info.checked = AtlasOptions.AtlasButtonShown;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};
	info.text = ATLAS_OPTIONS_AUTOSEL;
	info.func = AtlasOptions_AutoSelectToggle;
	info.value = ATLAS_OPTIONS_AUTOSEL;
	info.checked = AtlasOptions.AtlasAutoSelect;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};
	info.text = ATLAS_OPTIONS_SHOWMAPNAME;
	info.func = AtlasOptions_MapNameToggle;
	info.value = ATLAS_OPTIONS_SHOWMAPNAME;
	info.checked = AtlasOptions.AtlasMapName;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};

	TitanPanelRightClickMenu_AddSpacer();	

	TitanPanelRightClickMenu_AddToggleIcon(TITAN_ATLAS_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ATLAS_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_ATLAS_ID);
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ATLAS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitalPanelAtlasButton_OnClick(button)
	if ( button == "LeftButton" ) then
		Atlas_Toggle();
	end
end

function DebugReport(msg, color, bSecondChatWindow)
	local r = 0.50;
	local g = 0.50;
	local b = 1.00;

	if (color) then
		r = color.r;
		g = color.g;
		b = color.b;
	end

	local frame = DEFAULT_CHAT_FRAME;
	if (bSecondChatWindow) then
		frame = ChatFrame2;
	end

	if (frame) then
		frame:AddMessage(msg,r,g,b);
	end
end
