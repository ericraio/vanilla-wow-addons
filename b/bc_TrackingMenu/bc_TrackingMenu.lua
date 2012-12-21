--[[

See the ReadMe.txt file for more information.

]]

bcTM_Config = {}
bcTM_Config.ShowOnMouse = 1
bcTM_Config.ShowOnClick = 0
bcTM_Config.ShowOnButton = 0
bcTM_Config.HideOnMouse = 1
bcTM_Config.HideOnClick = 0
bcTM_Config.HideOnButton = 0
bcTM_Config.HideOnCast = 0
bcTM_Config.Position = 40
bcTM_Config.BlinkOnInactive = 1
bcTM_Config.HideWhileDead = 1
bcTM_Config.BlinkDuration = 1.0
bcTM_Config.BlinkDelay = 5

-- Number of buttons for the menu defined in the XML file.
BCTM_NUM_BUTTONS = 12;

-- Constants used in determining menu width/height.
BCTM_BORDER_WIDTH = 15;
BCTM_BUTTON_HEIGHT = 12;

BCTM_BLINK_CHECK_INTERVAL = 2;    -- how often, in seconds, to check to see if we need to be blinking, or hiding the icon while dead.

bcTM_BlinkLastChecked = 0;
bcTM_BlinkEnabled = false;
bcTM_BlinkReset = true;
bcTM_FadeOut = true;
bcTM_CurrentBlinkDelay = 0;

-- List of tracking abilities to look for.
bcTM_TrackingAbilities = {
	[BCTM_TEXT_FIND_HERBS] = 0,
	[BCTM_TEXT_FIND_MINERALS] = 0,
	[BCTM_TEXT_FIND_TREASURE] = 0,
	[BCTM_TEXT_TRACK_BEASTS] = 0,
	[BCTM_TEXT_TRACK_HUMANOIDS] = 0,
	[BCTM_TEXT_TRACK_HIDDEN] = 0,
	[BCTM_TEXT_TRACK_ELEMENTALS] = 0,
	[BCTM_TEXT_TRACK_UNDEAD] = 0,
	[BCTM_TEXT_TRACK_DEMONS] = 0,
	[BCTM_TEXT_TRACK_GIANTS] = 0,
	[BCTM_TEXT_TRACK_DRAGONKIN] = 0,
	[BCTM_TEXT_SENSE_UNDEAD] = 0,
	[BCTM_TEXT_SENSE_DEMONS] = 0,
}

-- ******************************************************************
function bcWrite(msg)
	if (msg and DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

-- ******************************************************************
function bcTM_Report()
	bcWrite(BCTM_TEXT_TITLE_BUTTON);
	bcWrite(BCTM_TEXT_TOOLTIP);
	bcWrite(BCTM_TEXT_FIND_HERBS);
	bcWrite(BCTM_TEXT_FIND_MINERALS);
	bcWrite(BCTM_TEXT_FIND_TREASURE);
	bcWrite(BCTM_TEXT_TRACK_BEASTS);
	bcWrite(BCTM_TEXT_TRACK_HUMANOIDS);
	bcWrite(BCTM_TEXT_TRACK_HIDDEN);
	bcWrite(BCTM_TEXT_TRACK_ELEMENTALS);
	bcWrite(BCTM_TEXT_TRACK_UNDEAD);
	bcWrite(BCTM_TEXT_TRACK_DEMONS);
	bcWrite(BCTM_TEXT_TRACK_GIANTS);
	bcWrite(BCTM_TEXT_TRACK_DRAGONKIN);
	bcWrite(BCTM_TEXT_SENSE_UNDEAD);
	bcWrite(BCTM_TEXT_SENSE_DEMONS);
	bcWrite(BCTM_TEXT_CONFIG_TITLE);
	bcWrite(BCTM_TEXT_SHOWONMOUSE);
	bcWrite(BCTM_TEXT_HIDEONMOUSE);
	bcWrite(BCTM_TEXT_SHOWONCLICK);
	bcWrite(BCTM_TEXT_HIDEONCLICK);
	bcWrite(BCTM_TEXT_SHOWONBUTTON);
	bcWrite(BCTM_TEXT_HIDEONBUTTON);
	bcWrite(BCTM_TEXT_HIDEONCAST);
	bcWrite(BCTM_TEXT_BUTTONUNBOUND);
	bcWrite(BCTM_TEXT_POSITION);
	bcWrite(BCTM_TEXT_POSITION_TIP);
	bcWrite(BINDING_HEADER_BCTM_BINDINGS_HEADER);
	bcWrite(BINDING_NAME_BCTM_BINDING_TOGGLE_MENU);
end

-- ******************************************************************
function bcTM_OnLoad()
	-- Register for the neccessary events.
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");
	
	-- Create a slash command to list out the values of the localized strings.
	SlashCmdList["BCTM_REPORT"] = bcTM_Report;
	SLASH_BCTM_REPORT1 = "/bctm_report";
	
	-- Create the slash commands to show/hide the menu.
	SlashCmdList["BCTM_SHOWMENU"] = bcTM_ShowMenu;
	SLASH_BCTM_SHOWMENU1 = "/bctm_showmenu";
	SlashCmdList["BCTM_HIDEMENU"] = bcTM_HideMenu;
	SLASH_BCTM_HIDEMENU1 = "/bctm_hidemenu";
	
	-- Create the slash command to output the cursor position.
	SlashCmdList["BCTM_GETLOC"] = bcTM_GetLocation;
	SLASH_BCTM_GETLOC1 = "/bctm_getloc";

	-- Create the slash commands to show/hide the options window.
	SlashCmdList["BCTM_SHOWOPTIONS"] = bcTM_ShowOptions;
	SLASH_BCTM_SHOWOPTIONS1 = "/bctm_showoptions";
	SlashCmdList["BCTM_HIDEOPTIONS"] = bcTM_HideOptions;
	SLASH_BCTM_HIDEOPTIONS1 = "/bctm_hideoptions";
	
	-- Let the user know the mod loaded.
	-- if ( DEFAULT_CHAT_FRAME ) then 
		-- bcWrite("BC Tracking Menu loaded");
	-- end
end

-- ******************************************************************
function bcTM_GetLocation()
	local x, y = GetCursorPosition();
	bcWrite("Cursor location: "..x..", "..y);
end

-- ******************************************************************
function bcTM_ShowMenu(x, y, anchor)
	if (bcTM_Popup:IsVisible()) then
		bcTM_Hide();
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
	x = x / UIParent:GetScale();
	y = y / UIParent:GetScale();

	-- Adjust for the height/width/anchor of the menu.
	if (anchor == "topright") then
		x = x - bcTM_Popup:GetWidth();
		y = y - bcTM_Popup:GetHeight();
	elseif (anchor == "topleft") then
		y = y - bcTM_Popup:GetHeight();
	elseif (anchor == "bottomright") then
		x = x - bcTM_Popup:GetWidth();
	elseif (anchor == "bottomleft") then
		-- do nothing.
	else
		-- anchor is either "center" or not a valid value.
		x = x - bcTM_Popup:GetWidth() / 2;
		y = y - bcTM_Popup:GetHeight() / 2;
	end

	-- Clear the current anchor point, and set it to be centered under the mouse.
	bcTM_Popup:ClearAllPoints();
	bcTM_Popup:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
	bcTM_Show();
end

-- ******************************************************************
function bcTM_HideMenu()
	bcTM_Hide();
end

-- ******************************************************************
function bcTM_OnEvent()
	if (event == "PLAYER_AURAS_CHANGED") then
		-- When the user changes their active tracking ability, do the following.
		
		-- Hide the default tracking icon.
		if (MiniMapTrackingFrame) then
			MiniMapTrackingFrame:Hide();
		end
		
		-- Get the icon for the currently active tracking ability.
		local icon = GetTrackingTexture();
		if ( icon ) then
			-- Set our icon to match the active ability.
			bcTM_IconTexture:SetTexture(icon);
		else
			-- No ability active... Set our icon to something else.
			bcTM_IconTexture:SetTexture("Interface\\Icons\\INV_Misc_Map_01");
		end
		
		return;
	end
	
	if (event == "VARIABLES_LOADED") then
		bcTM_InitializeOptions();
		bcTM_InitializeMenu();
		return;
	end
	
	if (event == "SPELLS_CHANGED" or event == "LEARNED_SPELL_IN_TAB") then
		-- When the player learns a new spell, re-initialize the menu's contents.
		bcTM_InitializeMenu();
		return;
	end
end

-- ******************************************************************
function bcTM_InitializeOptions()
	bcTM_CheckShowOnMouse:SetChecked(bcTM_Config.ShowOnMouse);
	bcTM_CheckHideOnMouse:SetChecked(bcTM_Config.HideOnMouse);
	bcTM_CheckShowOnClick:SetChecked(bcTM_Config.ShowOnClick);
	bcTM_CheckHideOnClick:SetChecked(bcTM_Config.HideOnClick);
	bcTM_CheckShowOnButton:SetChecked(bcTM_Config.ShowOnButton);
	bcTM_CheckHideOnButton:SetChecked(bcTM_Config.HideOnButton);
	bcTM_CheckHideOnCast:SetChecked(bcTM_Config.HideOnCast);
	bcTM_CheckBlinkOnInactive:SetChecked(bcTM_Config.BlinkOnInactive);
	bcTM_CheckHideWhileDead:SetChecked(bcTM_Config.HideWhileDead);
	bcTM_IconFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(bcTM_Config.Position)), (80 * sin(bcTM_Config.Position)) - 52);
end

-- ******************************************************************
function bcTM_InitializeMenu()
	-- Reset the available abilities.
	for spell, id in ipairs(bcTM_TrackingAbilities) do
		if (id > 0) then
			bcTM_TrackingAbilities[spellName] = 0
		end
	end

	-- Calculate the total number of spells known by scanning the spellbook.
	local numTotalSpells = 0;
	for i=1, MAX_SKILLLINE_TABS do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		if (name) then
			numTotalSpells = numTotalSpells + numSpells
		end
	end

	bcTM_IconFrame.haveAbilities = false;
	
	-- Find the tracking abilities available.
	for i=1, numTotalSpells do
		local spellName, subSpellName = GetSpellName(i, SpellBookFrame.bookType);
		if (spellName) then
			if (bcTM_TrackingAbilities[spellName]) then
				bcTM_IconFrame.haveAbilities = true;
				bcTM_TrackingAbilities[spellName] = i
			end
		end
	end
	
	if (bcTM_IconFrame.haveAbilities) then
		bcTM_IconFrame:Show();
	end

	-- Set the text for the buttons while keeping track of how many
	-- buttons we actually need.
	local count = 0;
	for spell, id in bcTM_pairsByKeys(bcTM_TrackingAbilities) do
		if (id > 0) then
			count = count + 1;
			local button = getglobal("bcTM_PopupButton"..count);
			button:SetText(spell);
			button.SpellID = id;
			button:Show();
		end
	end
	
	-- Set the width for the menu.
	local width = bcTM_TitleButton:GetWidth();
	for i = 1, count, 1 do
		local button = getglobal("bcTM_PopupButton"..i);
		local w = button:GetTextWidth();
		if (w > width) then
			width = w;
		end
	end
	bcTM_Popup:SetWidth(width + 2 * BCTM_BORDER_WIDTH);

	-- By default, the width of the button is set to the width of the text
	-- on the button.  Set the width of each button to the width of the
	-- menu so that you can still click on it without being directly
	-- over the text.
	for i = 1, count, 1 do
		local button = getglobal("bcTM_PopupButton"..i);
		button:SetWidth(width);
	end

	-- Hide the buttons we don't need.
	for i = count + 1, BCTM_NUM_BUTTONS, 1 do
		local button = getglobal("bcTM_PopupButton"..i);
		button:Hide();
	end
	
	-- Set the height for the menu.
	bcTM_Popup:SetHeight(BCTM_BUTTON_HEIGHT + ((count + 1) * BCTM_BUTTON_HEIGHT) + (3 * BCTM_BUTTON_HEIGHT));
end

-- ******************************************************************
function bcTM_ButtonClick()
-- Cast the selected spell.
	CastSpell(this.SpellID, "spell");
	
	if (bcTM_Config.HideOnCast == 1) then
		bcTM_Hide();
	end
end

-- ******************************************************************
function bcTM_Show()
	-- Check to see if the aspect menu is shown.  If so, hide it before
	-- showing the tracking menu.
	if (bcAM_Popup) then
		if (bcAM_Popup:IsVisible()) then
			bcAM_Hide();
		end
	end

	bcTM_Popup:Show();
end

-- ******************************************************************
function bcTM_Hide()
	bcTM_Popup:Hide();
end

-- ******************************************************************
function bcTM_ShowOptions()
	bcTM_Options:Show();
end

-- ******************************************************************
function bcTM_HideOptions()
	bcTM_Options:Hide();
end

-- ******************************************************************
function bcTM_OnUpdate(elapsed)
	-- Check to see if the mouse is still over the menu or the icon.
	if (bcTM_Config.HideOnMouse == 1 and bcTM_Popup:IsVisible()) then
		if (not MouseIsOver(bcTM_Popup) and not MouseIsOver(bcTM_IconFrame)) then
			-- If not, hide the menu.
			bcTM_Hide();
		end
	end

	bcTM_BlinkLastChecked = bcTM_BlinkLastChecked + elapsed;
	if (bcTM_BlinkLastChecked > BCTM_BLINK_CHECK_INTERVAL) then
		if (GetTrackingTexture() == nil and bcTM_Config.BlinkOnInactive == 1) then
			bcTM_BlinkEnabled = true;
		else
			bcTM_BlinkEnabled = false;
		end

		if (bcTM_Config.HideWhileDead == 1 and UnitIsDeadOrGhost("player")) then
			bcTM_IconFrame:Hide();
		elseif (bcTM_IconFrame.haveAbilities) then
			bcTM_IconFrame:Show();
		end

		bcTM_BlinkLastChecked = 0;
	end

	if (bcTM_BlinkEnabled and bcTM_IconFrame:IsVisible()) then
		bcTM_BlinkReset = false;
		bcTM_CurrentBlinkDelay = bcTM_CurrentBlinkDelay + elapsed;

		if (bcTM_CurrentBlinkDelay > bcTM_Config.BlinkDelay) then
			local alpha = bcTM_IconFrame:GetAlpha();

			if (alpha == 0 and bcTM_FadeOut) then
				bcTM_FadeOut = false;
			elseif (alpha == 1.0 and not bcTM_FadeOut) then
				bcTM_FadeOut = true;
			end

			if (alpha > 0 and bcTM_FadeOut) then
				-- decrease alpha
				alpha = alpha - (elapsed / (bcTM_Config.BlinkDuration / 2));
			else
				-- increase alpha
				alpha = alpha + (elapsed / (bcTM_Config.BlinkDuration / 2));
			end

			if (alpha < 0) then
				alpha = 0;
			elseif (alpha > 1) then
				alpha = 1.0;
			end

			bcTM_IconFrame:SetAlpha(alpha);

			if (alpha == 1.0 and not bcTM_FadeOut) then
				bcTM_CurrentBlinkDelay = 0;
			end
		end

	elseif (not bcTM_BlinkReset) then
		bcTM_IconFrame:SetAlpha(1.0);
		bcTM_CurrentBlinkDelay = 0;
		bcTM_BlinkReset = true;
	end

end

-- ******************************************************************
function bcTM_pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then return nil
			else return a[i], t[a[i]]
		end
	end
	return iter
end

-- ******************************************************************
function bcTM_IconFrameOnEnter()
	-- Set the anchor point of the menu so it shows up next to the icon.
	bcTM_Popup:ClearAllPoints();
	bcTM_Popup:SetPoint("TOPRIGHT", "bcTM_IconFrame", "TOPLEFT");

	-- Set the anchor and text for the tooltip.
	GameTooltip:SetOwner(bcTM_IconFrame, "ANCHOR_BOTTOMRIGHT");
	local icon = GetTrackingTexture();
	if ( icon ) then
		GameTooltip:SetTrackingSpell();
	else
		GameTooltip:SetText(BCTM_TEXT_TOOLTIP);
	end

	-- Show the menu.
	if (bcTM_Config.ShowOnMouse == 1) then
		bcTM_Show();
	end
end

-- ******************************************************************
function bcTM_IconFrameOnClick()
	if (bcTM_Popup:IsVisible()) then
		if (bcTM_Config.HideOnClick == 1) then
			bcTM_Hide();
		end
	else
		if (bcTM_Config.ShowOnClick == 1) then
			bcTM_Show();
		end
	end

end

-- ******************************************************************
-- Not yet fully implemented.
function bcTM_ButtonBindingOnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");

	local key1 = GetBindingKey("BCTM_BINDING_TOGGLE_MENU");

	if (key1) then
		this:SetText(key1);
	else
		this:SetText(BCTM_TEXT_BUTTONUNBOUND);
	end
end

-- ******************************************************************
-- Not yet fully implemented.
function bcTM_ButtonBindingOnClick()
	local key1, key2 = GetBindingKey("BCTM_BINDING_TOGGLE_MENU");
	
	if (this.selected == nil) then
		this.selected = true;
		this:SetText("Press a key to bind");
		
	else
		this.selected = nil;
		local key1, key2 = GetBindingKey("BCTM_BINDING_TOGGLE_MENU");
		this:SetText(key1);
	end

	if (key1) then
		bcWrite("key 1 = "..key1);
	end
	if (key2) then
		bcWrite("key 2");
	end
end

-- ******************************************************************
function bcTM_KeyBindingSpellCast(spellName)
	if (bcTM_TrackingAbilities[spellName] > 0) then
		CastSpell(bcTM_TrackingAbilities[spellName], "spell");
	end
end