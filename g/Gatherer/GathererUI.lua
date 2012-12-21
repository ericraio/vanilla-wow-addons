--[[
	GUI for Gatherer (by Jet, original idea and most of the base UI code came from bcui_TrackingMenu)
	Version: <%version%>
	Revision: $Id: GathererUI.lua,v 1.21 2006/01/04 12:36:44 islorgris Exp $
]]

-- Counter for fixed item count
fixedItemCount = 0;
gathererFixItems = 0;

-- Number of buttons for the menu defined in the XML file.
GathererUI_NUM_BUTTONS = 7;

-- Constants used in determining menu width/height.
GathererUI_BORDER_WIDTH = 15;
GathererUI_BUTTON_HEIGHT = 12;
GATHERERUI_SUBFRAMES = { "GathererUI_FiltersOptionsBorderFrame",
						 "GathererUI_GathererOptionsBorderFrame",
						 "GathererUI_DisplayOptionsBorderFrame" };

-- List of toggles to display.
GathererUI_QuickMenu = {
	{name=GATHERER_TEXT_TOGGLE_MINIMAP, option="useMinimap"},
	{name=GATHERER_TEXT_TOGGLE_MAINMAP, option="useMainmap"},
	{name=GATHERER_TEXT_TOGGLE_HERBS, option="herbs"},
	{name=GATHERER_TEXT_TOGGLE_MINERALS, option="mining"},
	{name=GATHERER_TEXT_TOGGLE_TREASURE, option="treasure"},
	{name=GATHERER_TEXT_TOGGLE_REPORT, option="report" },
	{name=GATHERER_TEXT_TOGGLE_SEARCH, option="search" },
};


-- ******************************************************************
function GathererUI_OnLoad()
	-- Register for the neccessary events.
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	
	-- Create the slash commands to show/hide the menu.
	SlashCmdList["GathererUI_SHOWMENU"] = GathererUI_ShowMenu;
	SLASH_GathererUI_SHOWMENU1 = "/GathererUI_showmenu";
	SlashCmdList["GathererUI_HIDEMENU"] = GathererUI_HideMenu;
	SLASH_GathererUI_HIDEMENU1 = "/GathererUI_hidemenu";
	
	-- Create the slash commands to show/hide the options window.
	SlashCmdList["GathererUI_SHOWOPTIONS"] = GathererUI_ShowOptions;
	SLASH_GathererUI_SHOWOPTIONS1 = "/GathererUI_showoptions";
	SlashCmdList["GathererUI_HIDEOPTIONS"] = GathererUI_HideOptions;
	SLASH_GathererUI_HIDEOPTIONS1 = "/GathererUI_hideoptions";

end

-- ***********************************************************
-- Tab selection code
function ToggleGathererUI_Dialog(tab)
	local subFrame = getglobal(tab);
	if ( subFrame ) then
		PanelTemplates_SetTab(GathererUI_DialogFrame, subFrame:GetID());
		if ( GathererUI_DialogFrame:IsVisible() ) then
				PlaySound("igCharacterInfoTab");
				GathererUI_DialogFrame_ShowSubFrame(tab);
		else
			GathererUI_DialogFrame:Show();
			GathererUI_DialogFrame_ShowSubFrame(tab);
		end
	end
end

function GathererUI_DialogFrame_ShowSubFrame(frameName)
	for index, value in GATHERERUI_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show()
		else
			getglobal(value):Hide();	
		end	
	end 
end
function GathererUIFrameTab_OnClick()
	if ( this:GetName() == "GathererUI_DialogFrameTab1" ) then
		ToggleGathererUI_Dialog("GathererUI_FiltersOptionsBorderFrame");
	elseif ( this:GetName() == "GathererUI_DialogFrameTab2" ) then
		ToggleGathererUI_Dialog("GathererUI_GathererOptionsBorderFrame");
	elseif ( this:GetName() == "GathererUI_DialogFrameTab3" ) then
		ToggleGathererUI_Dialog("GathererUI_DisplayOptionsBorderFrame");
	end
	PlaySound("igCharacterInfoTab");
end

-- ******************************************************************
function GathererUI_ShowMenu(x, y, anchor)
	if (GathererUI_Popup:IsVisible()) then
		GathererUI_Hide();
		return;
	end

	if (x == nil or y == nil) then
		-- Get the cursor position.  Point is relative to the bottom left corner of the screen.
		x, y = GetCursorPosition();
	end

	if (anchor == nil) then
		anchor = "center";
	end
	
	-- Adjust for the UI scale.
	x = x / UIParent:GetEffectiveScale();
	y = y / UIParent:GetEffectiveScale();

	-- Adjust for the height/width/anchor of the menu.
	if (anchor == "topright") then
		x = x - GathererUI_Popup:GetWidth();
		y = y - GathererUI_Popup:GetHeight();
	elseif (anchor == "topleft") then
		y = y - GathererUI_Popup:GetHeight();
	elseif (anchor == "bottomright") then
		x = x - GathererUI_Popup:GetWidth();
	elseif (anchor == "bottomleft") then
		-- do nothing.
	else
		-- anchor is either "center" or not a valid value.
		x = x - GathererUI_Popup:GetWidth() / 2;
		y = y - GathererUI_Popup:GetHeight() / 2;
	end

	-- Clear the current anchor point, and set it to be centered under the mouse.
	GathererUI_Popup:ClearAllPoints();
	GathererUI_Popup:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
	GathererUI_Show();
end

-- ******************************************************************
function GathererUI_HideMenu()
	GathererUI_Hide();
end

-- ******************************************************************
function GathererUI_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		local playerName = UnitName("player");
		if ((playerName) and (playerName ~= UNKNOWNOBJECT)) then Gather_Player = playerName; end;
		GathererUI_InitializeOptions();
		GathererUI_InitializeMenu();
		return;
	end
	if ( event == "UNIT_NAME_UPDATE" ) then
		if ((arg1) and (arg1 == "player")) then
			local playerName = UnitName("player");
			if ((playerName) and (playerName ~= UNKNOWNOBJECT)) then
				Gather_Player = playerName;
				GathererUI_InitializeMenu();
			end
		end
	end
end

-- ******************************************************************
function GathererUI_InitializeOptions()

	-- flag to determine if we show the menu when the mouse is over the icon.
	if (GatherConfig.ShowOnMouse == nil) then
		GatherConfig.ShowOnMouse = 1;
	end
	
	-- flag to determine if we show the menu when the icon is clicked.
	if (GatherConfig.ShowOnClick == nil) then
		GatherConfig.ShowOnClick = 0;
	end
	
	-- flag to determine if we show the menu when the bound key is pressed.
	if (GatherConfig.ShowOnButton == nil) then
		GatherConfig.ShowOnButton = 0;
	end
	
	-- flag to determine if we hide the menu when the mouse is not over the icon.
	if (GatherConfig.HideOnMouse == nil) then
		GatherConfig.HideOnMouse = 1;
	end
	
	-- flag to determine if we hide the menu when the icon is clicked.
	if (GatherConfig.HideOnClick == nil) then
		GatherConfig.HideOnClick = 0;
	end
	
	-- flag to determine if we hide the menu when the bound key is pressed.
	if (GatherConfig.HideOnButton == nil) then
		GatherConfig.HideOnButton = 0;
	end
	
	-- position of the icon around the border of the minimap.
	if (GatherConfig.Position == nil) then
		GatherConfig.Position = 12;
	end
	
	-- radius from the minimap center
	if (GatherConfig.Radius == nil) then
		GatherConfig.Radius = 80;
	end

	if (GatherConfig.rareOre == nil) then
		GatherConfig.rareOre = 0;
	end

	if (GatherConfig.NoIconOnMinDist == nil) then
		GatherConfig.NoIconOnMinDist = 0;
	end
	
	if (GatherConfig.HideIcon == nil) then
		GatherConfig.HideIcon = 0;
	end
	
	if (GatherConfig.HideMiniNotes == nil) then
		GatherConfig.HideMiniNotes = 0;
	end
	
	if (GatherConfig.ToggleWorldNotes == nil) then
		GatherConfig.ToggleWorldNotes = 0;
	end
	
	if (GatherConfig.IconSize == nil ) then
		GatherConfig.IconSize = 12;
	end

	if (not GatherConfig.users) then
			GatherConfig.users = {};
		end
	
	if (not GatherConfig.users[Gather_Player]) then
		GatherConfig.users[Gather_Player] = {};
	end

	if (GatherConfig.users[Gather_Player].filterRecording == nil ) then
		GatherConfig.users[Gather_Player].filterRecording = {};
	end

	if (GatherConfig.showWorldMapFilters == nil ) then
		GatherConfig.showWorldMapFilters = 0;
	elseif ( GatherConfig.showWorldMapFilters == 1 ) then
		GathererWD_DropDownFilters:Show();
	else
		GathererWD_DropDownFilters:Hide();
	end
	
	if ( GatherConfig.disableWMFreezeWorkaround and GatherConfig.disableWMFreezeWorkaround == true )
	then
		GatherConfig.disableWMFreezeWorkaround = 1;
	end
	
	if ( not GatherConfig.disableWMFreezeWorkaround ) then
		GatherConfig.disableWMFreezeWorkaround = 1;
		Gatherer_WorldMapDisplay:Show();
		Gatherer_WorldMapDisplay:SetText("Hide Items");
	end

	if ( GatherConfig.disableWMFreezeWorkaround == 1 ) then
		Gatherer_WorldMapDisplay:Show();
	else
		Gatherer_WorldMapDisplay:Hide();	
	end
	
	if ( GatherConfig.useMainmap)
	then
		Gatherer_WorldMapDisplay:SetText("Hide Items");
		GathererMapOverlayFrame:Show();
	else
		Gatherer_WorldMapDisplay:SetText("Show Items");
		GathererMapOverlayFrame:Hide();
	end
		
	
	-- UI related
	GathererUI_CheckShowOnMouse:SetChecked(GatherConfig.ShowOnMouse);
	GathererUI_CheckHideOnMouse:SetChecked(GatherConfig.HideOnMouse);
	GathererUI_CheckShowOnClick:SetChecked(GatherConfig.ShowOnClick);
	GathererUI_CheckHideOnClick:SetChecked(GatherConfig.HideOnClick);
	GathererUI_CheckHideIcon:SetChecked(GatherConfig.HideIcon);
	GathererUI_CheckHideOnButton:SetChecked(GatherConfig.HideOnButton);
	GathererUI_IconFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (GatherConfig.Radius * cos(GatherConfig.Position)), (GatherConfig.Radius * sin(GatherConfig.Position)) - 52);
	
	-- Gatherer related
	GathererUI_CheckNoMinIcon:SetChecked(GatherConfig.NoIconOnMinDist);
	GathererUI_CheckRareOre:SetChecked(GatherConfig.rareOre);
	GathererUI_CheckMapMinder:SetChecked(GatherConfig.mapMinder);
	GathererUI_CheckHideMiniNotes:SetChecked(GatherConfig.HideMiniNotes);
	GathererUI_CheckToggleWorldNotes:SetChecked(GatherConfig.ToggleWorldNotes);
	GathererUI_CheckToggleWorldFilters:SetChecked(GatherConfig.showWorldMapFilters);
	GathererUI_CheckHerbRecord:SetChecked(GatherConfig.users[Gather_Player].filterRecording[1]);
	GathererUI_CheckOreRecord:SetChecked(GatherConfig.users[Gather_Player].filterRecording[2]);
	GathererUI_CheckTreasureRecord:SetChecked(GatherConfig.users[Gather_Player].filterRecording[0]);
	GathererUI_CheckDisableWMFix:SetChecked(GatherConfig.disableWMFreezeWorkaround);
end

-- ******************************************************************
function GathererUI_InitializeMenu()

	GathererUI_IconFrame.haveAbilities = true;

	if ( GatherConfig and GatherConfig.HideIcon and GatherConfig.HideIcon == 1 ) then
		GathererUI_IconFrame:Hide();
	else
		GathererUI_IconFrame:Show();
	end
		

	-- Set the text for the buttons while keeping track of how many
	-- buttons we actually need.
	local count = 0;
	for quickoptionpos, quickoptiondata in GathererUI_QuickMenu do
		quickoptions = quickoptiondata.name;
		gathermap_id = quickoptiondata.option;
		count = count + 1;
		local button = getglobal("GathererUI_PopupButton"..count);
		Gatherer_Value="rien";
		if ( gathermap_id =="useMinimap" ) then
			Gatherer_Value = "off";
			if (GatherConfig.useMinimap) then Gatherer_Value = "on"; end
			button.SpellID = "toggle"
		elseif (  gathermap_id == "useMainmap" ) then
			Gatherer_Value = "off";
			if (GatherConfig.useMainmap) then Gatherer_Value = "on"; end
			button.SpellID = "mainmap toggle";
		elseif ( gathermap_id == "report" ) then
			button.SpellID = "report";
			Gatherer_Value = "";
		elseif ( gathermap_id == "search" ) then
			button.SpellID = "search";
			Gatherer_Value = "";
		else
			Gatherer_Value = Gatherer_GetFilterVal(gathermap_id);
			button.SpellID = gathermap_id.." toggle";
		end

		if ( Gatherer_Value ~= "" ) then
			button:SetText(quickoptions.."["..Gatherer_Value.."]");
		else
			button:SetText(quickoptions);
		end
		button:Show();
	end
	
	-- Set the width for the menu.
	local width = GathererUI_TitleButton:GetWidth();
	for i = 1, count, 1 do
		local button = getglobal("GathererUI_PopupButton"..i);
		local w = button:GetTextWidth();
		if (w > width) then
			width = w;
		end
	end
	GathererUI_Popup:SetWidth(width + 2 * GathererUI_BORDER_WIDTH);

	-- By default, the width of the button is set to the width of the text
	-- on the button.  Set the width of each button to the width of the
	-- menu so that you can still click on it without being directly
	-- over the text.
	for i = 1, count, 1 do
		local button = getglobal("GathererUI_PopupButton"..i);
		button:SetWidth(width);
	end

	-- Hide the buttons we don't need.
	for i = count + 1, GathererUI_NUM_BUTTONS, 1 do
		local button = getglobal("GathererUI_PopupButton"..i);
		button:Hide();
	end
	
	-- Set the height for the menu.
	GathererUI_Popup:SetHeight(GathererUI_BUTTON_HEIGHT + ((count + 1) * GathererUI_BUTTON_HEIGHT) + (3 * GathererUI_BUTTON_HEIGHT));
end

-- ******************************************************************
function GathererUI_ButtonClick()

	Gatherer_Command(this.SpellID);
	GathererUI_InitializeMenu();	
	
end

-- ******************************************************************
function GathererUI_Show()
	-- Check to see if the aspect menu is shown.  If so, hide it before
	-- showing the tracking menu.
	if (GathererUI_Popup) then
		if (GathererUI_Popup:IsVisible()) then
			GathererUI_Hide();
		end
	end

	GathererUI_Popup:Show();
end

-- ******************************************************************
function GathererUI_Hide()
	GathererUI_Popup:Hide();
end

-- ******************************************************************
function GathererUI_ShowOptions()
	GathererUI_DialogFrame:Show();
--	ToggleGathererUI_Dialog(GATHERERUI_SUBFRAMES[PanelTemplates_GetSelectedTab(GathererUI_DialogFrame)]);
end

-- ******************************************************************
function GathererUI_HideOptions()
	GathererUI_DialogFrame:Hide();
end

-- ******************************************************************
function GathererUI_OnUpdate(dummy)
	-- Check to see if the mouse is still over the menu or the icon.
	
	if (GatherConfig.HideOnMouse == 1 and GathererUI_Popup:IsVisible()) then
		if (not MouseIsOver(GathererUI_Popup) and not MouseIsOver(GathererUI_IconFrame)) then
			-- If not, hide the menu.
			GathererUI_Hide();
		end
	end

end

-- ******************************************************************
function GathererUI_IconFrameOnEnter()
	-- Set the anchor point of the menu so it shows up next to the icon.
	GathererUI_Popup:ClearAllPoints();
	GathererUI_Popup:SetPoint("TOPRIGHT", "GathererUI_IconFrame", "TOPLEFT");

	-- Show the menu.
	if (GatherConfig.ShowOnMouse == 1) then
		GathererUI_Show();
	end
end

-- ******************************************************************
function GathererUI_IconFrameOnClick()
	if (GathererUI_Popup:IsVisible()) then
		if (GatherConfig.HideOnClick == 1) then
			GathererUI_Hide();
		end
	else
		if (GatherConfig.ShowOnClick == 1) then
			GathererUI_Show();
		end
	end

end

-- ******************************************************************
function GathererUIDropDownTheme_Initialize()
	local index, value;
	info = {};
	local gathererThemeList = { "shaded", "iconic", "original" }
	
	for index, value in gathererThemeList do
		info.text = value;
		info.checked = nil;
		info.func = GathererUIDropDownTheme_OnClick;
		UIDropDownMenu_AddButton(info);
		if (GatherConfig.iconSet == info.text) then
			UIDropDownMenu_SetText(info.text, GathererUI_DropDownTheme);
		end
	end
end

function GathererUIDropDownHerbs_Initialize(submenu)
	local index, value;
	info = {};

	local varMenuVal1, varMenuVal2;
	value = Gatherer_GetFilterVal("herbs");
	if ( value == "on" ) then
		varMenuVal1 = "auto";
		varMenuVal2 = "off";
	elseif ( value == "off" ) then
		varMenuVal1 = "auto";
		varMenuVal2 = "on";
	else
		varMenuVal1 = "on";
		varMenuVal2 = "off";
	end
	UIDropDownMenu_SetText(value, GathererUI_DropDownHerbs);

	local gathererFilters = { 
				  varMenuVal1, varMenuVal2,  
				  HERB_PEACEBLOOM, HERB_SILVERLEAF, HERB_EARTHROOT, 
				  HERB_STRANGLEKELP, HERB_BRUISEWEED, HERB_WILDSTEELBLOOM, HERB_GRAVEMOSS, HERB_KINGSBLOOD, 
				  HERB_LIFEROOT, HERB_FADELEAF, HERB_KHADGARSWHISKER, HERB_FIREBLOOM, HERB_GOLDTHORN, 
				  HERB_BLINDWEED, HERB_SUNGRASS, HERB_GHOSTMUSHROOM, HERB_GOLDENSANSAM, 
				  HERB_GROMSBLOOD, HERB_WINTERSBITE, HERB_ARTHASTEAR, HERB_BLACKLOTUS, HERB_DREAMFOIL, 
				  HERB_ICECAP, HERB_MOUNTAINSILVERSAGE, HERB_PLAGUEBLOOM, 
				};

	if ( UIDROPDOWNMENU_MENU_VALUE == HERB_MAGEROYAL ) then
		GathererUIDropDownHerbSub_Initialize(HERB_MAGEROYAL);
		return;
	end
		
	if ( UIDROPDOWNMENU_MENU_VALUE == HERB_BRIARTHORN ) then
		GathererUIDropDownHerbSub_Initialize(HERB_BRIARTHORN);
		return;
	end
		
	if ( UIDROPDOWNMENU_MENU_VALUE == HERB_PURPLELOTUS ) then
		GathererUIDropDownHerbSub_Initialize(HERB_PURPLELOTUS);
		return;
	end

	for index, value in gathererFilters do
		info = {};
		info.text = value;
		info.value = value;
		info.checked = nil;
		info.func = GathererUIDropDownFilterHerbs_OnClick;

		if ( index > 2 and GatherConfig ) then
			info.keepShownOnClick = 1;
			if ( GatherConfig.users[Gather_Player] and
				GatherConfig.users[Gather_Player].interested and
				GatherConfig.users[Gather_Player].interested[1] and
				GatherConfig.users[Gather_Player].interested[1][value] == true ) then
				info.checked = 1;
			end

			info.textR = 1;
			info.textG = 1;
			info.textB = 1;
		else
			info.textR = 1;
			info.textG = 1;
			info.textB = 255;
			info.checked = nil;
		end

		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
		
	info = {};
	info.text = HERB_MAGEROYAL;
	info.value = HERB_MAGEROYAL;
	info.hasArrow = 1;
	info.func = nil;

	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};
	info.text = HERB_BRIARTHORN;
	info.value = HERB_BRIARTHORN;
	info.hasArrow = 1;
	info.func = nil;
			
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};
	info.text = HERB_PURPLELOTUS;
	info.value = HERB_PURPLELOTUS;
	info.hasArrow = 1;
	info.func = nil;
			
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function GathererUIDropDownHerbSub_Initialize(submenu)
	local value, info;
	if ( UIDROPDOWNMENU_MENU_VALUE == HERB_MAGEROYAL or UIDROPDOWNMENU_MENU_VALUE == HERB_BRIARTHORN )
	then
		value=HERB_SWIFTTHISTLE;
	elseif ( UIDROPDOWNMENU_MENU_VALUE == HERB_PURPLELOTUS ) then
		value=HERB_WILDVINE;
	else
		return;
	end
	
	info = {};
	info.text = UIDROPDOWNMENU_MENU_VALUE;
	info.value = UIDROPDOWNMENU_MENU_VALUE;
	info.checked = nil;
	info.func = GathererUIDropDownFilterHerbs_OnClick;

	if ( GatherConfig ) then
		info.keepShownOnClick = 1;
		if ( GatherConfig.users[Gather_Player] and
			GatherConfig.users[Gather_Player].interested and
			GatherConfig.users[Gather_Player].interested[1] and
			GatherConfig.users[Gather_Player].interested[1][UIDROPDOWNMENU_MENU_VALUE] == true ) then
			info.checked = 1;
		end
		info.textR = 1;
		info.textG = 1;
		info.textB = 1;
	else
		info.textR = 1;
		info.textG = 1;
		info.textB = 255;
		info.checked = nil;
	end
	
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
    --	add additional button
	info = {};
	info.text = value;
	info.value = value;
	info.checked = nil;
	info.func = GathererUIDropDownFilterHerbs_OnClick;

	if ( GatherConfig ) then
		info.keepShownOnClick = 1;
		if ( GatherConfig.users[Gather_Player] and
			GatherConfig.users[Gather_Player].interested and
			GatherConfig.users[Gather_Player].interested[1] and
			GatherConfig.users[Gather_Player].interested[1][value] == true ) then
			info.checked = 1;
		end
		info.textR = 1;
		info.textG = 1;
		info.textB = 1;
	else
		info.textR = 1;
		info.textG = 1;
		info.textB = 255;
		info.checked = nil;
	end
	
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
end

function GathererUIDropDownOre_Initialize(submenu)
	local index, value;
	info = {};

	local varMenuVal1, varMenuVal2;
	value = Gatherer_GetFilterVal("mining");
	if ( value == "on" ) then
		varMenuVal1 = "auto";
		varMenuVal2 = "off";
	elseif ( value == "off" ) then
		varMenuVal1 = "auto";
		varMenuVal2 = "on";
	else
		varMenuVal1 = "on";
		varMenuVal2 = "off";
	end
	UIDropDownMenu_SetText(value, GathererUI_DropDownOre);

	local gathererFilters = { 
				  varMenuVal1, varMenuVal2,  
				  ORE_COPPER, 
				  ORE_TIN, ORE_SILVER, 
				  ORE_IRON, ORE_GOLD, 
				  ORE_MITHRIL, ORE_TRUESILVER, 
				  ORE_THORIUM, ORE_RTHORIUM,
				  ORE_DARKIRON,
				}

	for index, value in gathererFilters do
		info = {};
		info.text = value;
		info.value = value;
		info.checked = nil;
		info.func = GathererUIDropDownFilterOre_OnClick;

		if ( index > 2 and GatherConfig ) then
			info.keepShownOnClick = 1;
			if ( GatherConfig.users[Gather_Player] and
				GatherConfig.users[Gather_Player].interested and
				GatherConfig.users[Gather_Player].interested[2] and
				GatherConfig.users[Gather_Player].interested[2][value] == true ) then
				info.checked = 1;
			end
			info.textR = 1;
			info.textG = 1;
			info.textB = 1;
		else
			info.textR = 1;
			info.textG = 1;
			info.textB = 255;
			info.checked = nil;
		end

		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
end

function GathererUIDropDownTreasure_Initialize(submenu)
	local index, value;
	info = {};

	local varMenuVal1, varMenuVal2;
	value = Gatherer_GetFilterVal("treasure");
	if ( value == "on" ) then
		varMenuVal1 = "auto";
		varMenuVal2 = "off";
	elseif ( value == "off" ) then
		varMenuVal1 = "auto";
		varMenuVal2 = "on";
	else
		varMenuVal1 = "on";
		varMenuVal2 = "off";
	end
	UIDropDownMenu_SetText(value, GathererUI_DropDownTreasure);

	local gathererFilters = { 
				  varMenuVal1, varMenuVal2,  
				  TREASURE_BOX, TREASURE_CHEST, TREASURE_CRATE, 
				  TREASURE_BARREL, TREASURE_CASK,
				  TREASURE_CLAM, TREASURE_FOOTLOCKER, TREASURE_BLOODPETAL,
				  TREASURE_BLOODHERO, TREASURE_POWERCRYST, TREASURE_UNGOROSOIL,
				  TREASURE_SHELLFISHTRAP,
				}

	for index, value in gathererFilters do
		info = {}
		info.text = value;
		info.checked = nil;
		info.func = GathererUIDropDownFilterTreasure_OnClick;

		if ( index > 2 and GatherConfig ) then
			info.keepShownOnClick = 1;
			if ( GatherConfig.users[Gather_Player] and
				GatherConfig.users[Gather_Player].interested and
				GatherConfig.users[Gather_Player].interested[0] and
				GatherConfig.users[Gather_Player].interested[0][value] == true ) then
				info.checked = 1;
			end
			info.textR = 1;
			info.textG = 1;
			info.textB = 1;
		else
			info.textR = 1;
			info.textG = 1;
			info.textB = 255;
			info.checked = nil;
		end

		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end	
end

-- World Map functions
-- World Map filters dropdown Load
function Gatherer_WorldMapFilter_Load()
	local index;
	local info = {};

	UIDropDownMenu_SetText(GATHERER_FILTERDM_TEXT, GathererWD_DropDownFilters);

	if ( UIDROPDOWNMENU_MENU_VALUE == "Herb" )
	then
		GathererUIDropDownHerbs_Initialize("Herb");
		return;
	elseif ( UIDROPDOWNMENU_MENU_VALUE == "Ore" )
	then
		GathererUIDropDownOre_Initialize("Ore");
		return;
	elseif ( UIDROPDOWNMENU_MENU_VALUE == "Treasure" )
	then
		GathererUIDropDownTreasure_Initialize("Treasure");
		return;
	elseif( UIDROPDOWNMENU_MENU_VALUE == HERB_PURPLELOTUS or
			UIDROPDOWNMENU_MENU_VALUE == HERB_BRIARTHORN or
			UIDROPDOWNMENU_MENU_VALUE == HERB_MAGEROYAL )
	then
		GathererUIDropDownHerbSub_Initialize(UIDROPDOWNMENU_MENU_VALUE);
		return;
	end
	


	info.text= GATHERER_TEXT_TOGGLE_HERBS.."["..Gatherer_GetFilterVal("herbs").."]";
	info.value= "Herb"
	info.hasArrow = 1;
	info.func = nil;
	info.notCheckable=1;
	UIDropDownMenu_AddButton(info);

	info.text= GATHERER_TEXT_TOGGLE_MINERALS.."["..Gatherer_GetFilterVal("ore").."]";
	info.value= "Ore"
	info.hasArrow = 1;
	info.func = nil;
	info.notCheckable=1;
	UIDropDownMenu_AddButton(info);

	info.text= GATHERER_TEXT_TOGGLE_TREASURE.."["..Gatherer_GetFilterVal("treasure").."]";
	info.value= "Treasure"
	info.hasArrow = 1;
	info.func = nil;
	info.notCheckable=1;
	UIDropDownMenu_AddButton(info);
end

-- ******************************************************************
function GathererUIDropDownTheme_OnClick()
	local cmd;

	UIDropDownMenu_SetSelectedID(GathererUI_DropDownTheme, this:GetID());
	cmd = UIDropDownMenu_GetText(GathererUI_DropDownTheme);
	
	Gatherer_Command("theme "..cmd);
end

function GathererUIDropDownFilterHerbs_OnClick()

	if ( this:GetID() < 3 and (this.value == "on" or this.value == "off" or this.value == "auto")) then
		cmd = UIDropDownMenu_SetText(this.value, GathererUI_DropDownHerbs);

		Gatherer_Command("herbs "..this.value);
		GathererUI_InitializeMenu();	
	else
		if ( not GatherConfig.users[Gather_Player].interested ) then
			GatherConfig.users[Gather_Player].interested = {}; 
		end
		if ( not GatherConfig.users[Gather_Player].interested[1] ) then
			GatherConfig.users[Gather_Player].interested[1] = {};
		end

		if ( this.checked ) then
			GatherConfig.users[Gather_Player].interested[1][this.value] = nil;
		else
			GatherConfig.users[Gather_Player].interested[1][this.value] = true;
		end
	end
	GatherMain_Draw();
end

function GathererUIDropDownFilterOre_OnClick()

	if ( this:GetID() < 3 ) then
		UIDropDownMenu_SetText(this.value, GathererUI_DropDownOre);

		Gatherer_Command("mining "..this.value);
		GathererUI_InitializeMenu();
	else
		if ( not GatherConfig.users[Gather_Player].interested ) then 
			GatherConfig.users[Gather_Player].interested = {}; 
		end
		if ( not GatherConfig.users[Gather_Player].interested[2] ) then
			GatherConfig.users[Gather_Player].interested[2] = {};
		end
		

		if ( this.checked ) then
			GatherConfig.users[Gather_Player].interested[2][this.value] = nil;
		else
			GatherConfig.users[Gather_Player].interested[2][this.value] = true;
		end		
	end
	GatherMain_Draw();
end

function GathererUIDropDownFilterTreasure_OnClick()

	if ( this:GetID() < 3 ) then
		UIDropDownMenu_SetText(this.value, GathererUI_DropDownTreasure);

		Gatherer_Command("treasure "..this.value);
		GathererUI_InitializeMenu();	
	else
		if ( not GatherConfig.users[Gather_Player].interested ) then 
			GatherConfig.users[Gather_Player].interested = {}; 
		end
		if ( not GatherConfig.users[Gather_Player].interested[0] ) then
			GatherConfig.users[Gather_Player].interested[0] = {};
		end


		if ( this.checked ) then
			GatherConfig.users[Gather_Player].interested[0][this.value] = nil;
		else
			GatherConfig.users[Gather_Player].interested[0][this.value] = true;
		end		
	end
	GatherMain_Draw();
end

function GathererUI_OnEnterPressed_HerbSkillEditBox()
	if ( GathererUI_HerbSkillEditBox:GetNumber() > 300 ) then
		GathererUI_HerbSkillEditBox:SetNumber(300);
	end
	if ( GathererUI_HerbSkillEditBox:GetNumber() < 0 ) then
		GathererUI_HerbSkillEditBox:SetNumber(0);
	end
	
	GatherConfig.users[Gather_Player].minSetHerbSkill = GathererUI_HerbSkillEditBox:GetNumber();
end

function GathererUI_OnEnterPressed_OreSkillEditBox()
	if ( GathererUI_OreSkillEditBox:GetNumber() > 300 ) then
		GathererUI_OreSkillEditBox:SetNumber(300);
	end
	if ( GathererUI_OreSkillEditBox:GetNumber() < 0 ) then
		GathererUI_OreSkillEditBox:SetNumber(0);
	end
	GatherConfig.users[Gather_Player].minSetOreSkill = GathererUI_OreSkillEditBox:GetNumber();
end

function GathererUI_OnEnterPressed_IconSizeEditBox()
	if (GatherConfig) then
		if ( GathererUI_WorldMapIconSize:GetNumber() < 8 or GathererUI_WorldMapIconSize:GetNumber() > 16 ) then
			if ( GatherConfig.IconSize ) then
				GathererUI_WorldMapIconSize:SetNumber(GatherConfig.IconSize)
			else	
				GathererUI_WorldMapIconSize:SetNumber(12);
			end
		end
					
		GatherConfig.IconSize = GathererUI_WorldMapIconSize:GetNumber();
	end
end

function GathererUI_OnEnterPressed_IconAlphaEditBox()
	if (GatherConfig) then
		if ( GathererUI_WorldMapIconAlpha:GetNumber() < 20 or GathererUI_WorldMapIconAlpha:GetNumber() > 100 ) then
			if ( GatherConfig.IconAlpha ) then
				GathererUI_WorldMapIconAlpha:SetNumber(GatherConfig.IconAlpha/100)
			else	
				GathererUI_WorldMapIconAlpha:SetNumber(80);
			end
		end
					
		GatherConfig.IconAlpha = GathererUI_WorldMapIconAlpha:GetNumber();
	end
end-- *******************************************************************
-- Zone Rematch Section: Handle with care

function GathererUI_ZoneRematch(sourceZoneMapping, destZoneMapping)
	local zone_swap=0;
	local new_idx_z, gatherType;
	NewGatherItems = {}
	fixedItemCount = 0;

	Gatherer_ChatPrint(GATHERER_TEXT_APPLY_REMATCH.." "..sourceZoneMapping.." -> "..destZoneMapping);

	for idx_c, rec_continent in GatherItems do
		if (idx_c ~= 0) then NewGatherItems[idx_c]= {}; end
		for idx_z, rec_zone in rec_continent do
			if ( idx_c ~= 0 and idx_z ~= 0) then
				new_idx_z= GathererUI_ZoneMatchTable[sourceZoneMapping][destZoneMapping][idx_c][idx_z];
				if ( idx_z ~= new_idx_z ) then zone_swap = zone_swap + 1; end;

				NewGatherItems[idx_c][new_idx_z] = {};
				for myItems, rec_gatheritem in rec_zone do
					local fixedItemName;
					if (gathererFixItems == 1) then 
						fixedItemName = GathererUI_FixItemName(myItems); 
					else
						fixedItemName= myItems;
					end
					NewGatherItems[idx_c][new_idx_z][fixedItemName] = {};
					for idx_item, myGather in rec_gatheritem do
						local myGatherType, myIcon;
						if ( type(myGather.gtype) == "number" ) then
							myGatherType = myGather.gtype;
						else
							myGatherType = Gather_DB_TypeIndex[myGather.gtype];
						end
						if ( type(myGather.icon) == "number" ) then
							myIcon= myGather.icon;
						else
							myIcon= Gatherer_GetDB_IconIndex(myGather.icon, myGatherType);
						end
						-- convertion of rich thorium veins to new format
						if ( myGatherType == 2 and myIcon == 8 ) then
							myIcon = Gatherer_GetDB_IconIndex(Gatherer_FindOreType(fixedItemName), myGatherType);
						end
						
						NewGatherItems[idx_c][new_idx_z][fixedItemName][idx_item] = { x=myGather.x, y=myGather.y, gtype=myGatherType, icon=myIcon, count=myGather.count };
						fixedItemCount = fixedItemCount + 1;
					end
				end
			end
		end
	end
	Gatherer_ChatPrint("Zone swapping completed ("..zone_swap.." done, "..fixedItemCount.." items accounted for).")
end

-- *******************************************************************
-- Zone Match UI functions
function GathererUI_ShowRematchDialog()
	if ( GathererUI_ZoneRematchDialog:IsVisible() ) then
		GathererUI_ZoneRematchDialog:Hide()
		GathererUI_DestinationZoneDropDown:Hide();
	else
		GathererUI_ZoneRematchDialog:Show()
	end

end

-- *******************************************************************
-- DropDown Menu functions
function GathererUIDropDownSourceZone_Initialize()
	local index;
	info = {};

	for index in GathererUI_ZoneMatchTable do
		info.text = index;
		info.checked = nil;
		info.func = GathererUIDropDownFilterSourceZone_OnClick;
		UIDropDownMenu_AddButton(info);
		if ( GatherConfig.DataBuild and GatherConfig.DataBuild == info.text ) then
			UIDropDownMenu_SetText(info.text, GathererUI_SourceZoneDropDown);
		end
	end	

end

function GathererUIDropDownDestionationZone_Initialize()
	local index, cmd;
	info = {};

	cmd = UIDropDownMenu_GetText(GathererUI_SourceZoneDropDown);
	if ( cmd ~= nil and cmd ~= "" ) then
		for index in GathererUI_ZoneMatchTable[cmd] do
			info.text = index;
			info.checked = nil;
			info.func = GathererUIDropDownFilterDestinationZone_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
end

-- *******************************************************************
-- OnClick in DropDown Menu functions
function GathererUIDropDownFilterSourceZone_OnClick()
	UIDropDownMenu_SetSelectedID(GathererUI_SourceZoneDropDown, this:GetID());

	GathererUI_DestinationZoneDropDown:Show();
end

function GathererUIDropDownFilterDestinationZone_OnClick()
	UIDropDownMenu_SetSelectedID(GathererUI_DestinationZoneDropDown, this:GetID());
end

-- *******************************************************************
-- Apply Button
function GathererUI_ShowRematchDialogApply()
	local source, dest;
	source = UIDropDownMenu_GetText(GathererUI_SourceZoneDropDown);
	dest = UIDropDownMenu_GetText(GathererUI_DestinationZoneDropDown);

	if( source and dest ) then
		-- hide Option dialog (since the position of the confirmation dialog can cause miss-click on stuff in there)
		GathererUI_HideOptions()
		-- add extra confirmation dialog
		StaticPopup_Show("CONFIRM_REMATCH");

		
	elseif ( not source ) then
		Gatherer_ChatPrint(GATHERER_TEXT_SRCZONE_MISSING);
	else
		Gatherer_ChatPrint(GATHERER_TEXT_DESTZONE_MISSING);
	end
end


StaticPopupDialogs["CONFIRM_REMATCH"] = {
	text = TEXT(GATHERER_TEXT_CONFIRM_REMATCH),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(DECLINE),
	OnAccept = function()
		Gatherer_ConfirmZoneRematch();
	end,
	timeout = 60,
	showAlert = 1,
};

function Gatherer_ConfirmZoneRematch()
	local source, dest;
	source = UIDropDownMenu_GetText(GathererUI_SourceZoneDropDown);
	dest = UIDropDownMenu_GetText(GathererUI_DestinationZoneDropDown);

		-- Swap tables and Recompute notes
		GathererUI_ZoneRematch(source, dest);
		GatherItems = NewGatherItems;
		GatherConfig.DataBuild = dest;

		GathererUI_ShowRematchDialog();

end

-- **************************************************************************
-- Help Page functions.
-- Update the help
function GathererUI_HelpFrame_Update()

	-- Check if an addon is selected
	GathererUI_HelpFrameName:SetText("Gatherer Help");

	local help = GathererHelp;
	local currentPage, totalPages;

	currentPage = help.currentPage;
	totalPages = 9;

	GathererUI_HelpFrameHelp:SetText(help[currentPage]);
	GathererUI_HelpFramePage:SetText("Page "..currentPage.."/"..totalPages);
	GathererUI_HelpFrame_UpdateButtons()
end

-- Enable/Disable the help buttons
function GathererUI_HelpFrame_UpdateButtons()

	-- Get the help
	local help = GathererHelp;
	
	-- Check if there is an help
	local currentPage = help.currentPage;
	local totalPages = 9;

	-- Check if the current help page is the first one
	if (currentPage == 1) then
		GathererUI_HelpFramePrevPageButton:Disable();
	else
		GathererUI_HelpFramePrevPageButton:Enable();
	end

	-- Check if the current help page is the last one
	if (currentPage == totalPages) then
		GathererUI_HelpFrameNextPageButton:Disable();
	else
		GathererUI_HelpFrameNextPageButton:Enable();
	end
end

-- Help previous page OnClick event
function GathererUI_HelpFramePrevPageButton_OnClick()

	-- Set the current page to previous page
	local help = GathererHelp;
	help.currentPage = help.currentPage - 1;
	
	-- Update the help
	GathererUI_HelpFrame_Update()

end

-- Help next page OnClick event
function GathererUI_HelpFrameNextPageButton_OnClick()

	-- Set the current page to next page
	local help = GathererHelp;
	help.currentPage = help.currentPage + 1;
	
	-- Update the help
	GathererUI_HelpFrame_Update();

end

