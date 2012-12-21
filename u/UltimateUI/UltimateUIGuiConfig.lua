--[[
 The Original UltimateUI UI Configuration values
 
 This is the simplest example of how UltimateUIMaster can be used. 
 Simply include this lua file in UltimateUIIncludes.xml file,
 then register it under the proper event handlers.
 
 
 Original code by Justin Crites (Xiphoris)
 Registration design by Alex Brazie (AlexanderYoshi)
]]--

-- allows you to scroll text in chat with the mouse wheel
-- readded OnMouseWheel link in ChatFrame.xml, and made it optional.
UltimateUI_UseMouseWheelToScrollChat = false;

function UltimateUI_ChangeUseMouseWheelToScrollChat(value)
	if ( ( value == 1 ) or ( value == true ) ) then 
		UltimateUI_UseMouseWheelToScrollChat = true;
	else
		UltimateUI_UseMouseWheelToScrollChat = false;
	end
end


UltimateUI_ShiftToSell = false;

function UltimateUI_ContainerFrameItemButton_OnClick(button, ignoreShift)
	if ( button == "RightButton" ) then
		if ( UltimateUI_ShiftToSell == true ) then
			if (  MerchantFrame:IsVisible() ) then
				if ( IsShiftKeyDown() ) then
					UseContainerItem(this:GetParent():GetID(), this:GetID());
				end
			else
					UseContainerItem(this:GetParent():GetID(), this:GetID());					
			end
		else 
			UseContainerItem(this:GetParent():GetID(), this:GetID());
		end
	else
		return true;
	end

	return false;
end
-- Sea.util.hook("ContainerFrameItemButton_OnClick", "UltimateUI_ContainerFrameItemButton_OnClick", "hide");

-- Adds ALT Invites to WhoLinks
function UltimateUI_SetItemRef (link) 
	if ( strsub(link, 1, 6) == "Player" ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			if ( IsAltKeyDown() ) then
				InviteByName(name);
				return false;
			else					
			end
		end
	end
	return true;
end
-- Sea.util.hook("SetItemRef", "UltimateUI_SetItemRef", "hide");

--[[
function UltimateUI_SetPaperDollScale(scale,toggle) 
	if ( scale == 0 or toggle==0 ) then scale=1; end
	PaperDollFrame:SetScale(scale);
end
]]--

function UltimateUI_TurnOnFPSMove(toggle)
	-- Move the FPS
	if (toggle == 1) then
		FramerateLabel:ClearAllPoints();
		FramerateLabel:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, 0);
	else
		FramerateLabel:ClearAllPoints();
		FramerateLabel:SetPoint("BOTTOM", "WorldFrame", "BOTTOM", 0, 64);
	end
end


-- Begin Keypad stuff

UltimateUI_UseAbbreviatedShortcutNames = 0;

function UltimateUI_UpdateAllButtonHotKeys()
	if ( SideBarButton_UpdateAllHotkeys ) then
		SideBarButton_UpdateAllHotkeys();
	end
	if ( PopBar_Update ) then
		PopBar_Update(true);
	end
	if ( SecondActionButton_UpdateAllHotkeys ) then
		SecondActionButton_UpdateAllHotkeys();
	end
	local button = nil;
	local actionButtonFormatStr = "ActionButton%d";
	local bonusActionButtonFormatStr = "BonusActionButton%d";
	for i = 1, 12 do
		button = getglobal(format(actionButtonFormatStr, i));
		if ( button ) then
			if ( SideBarButton_UpdateHotkeys ) then
				SideBarButton_UpdateHotkeys(nil, button);
			end
		end
		button = getglobal(format(bonusActionButtonFormatStr, i));
		if ( button ) then
			if ( SideBarButton_UpdateHotkeys ) then
				SideBarButton_UpdateHotkeys(nil, button);
			end
		end
	end
end

function UltimateUI_SetUseAbbreviatedShortcutNames(toggle)
	if ( UltimateUI_UseAbbreviatedShortcutNames ~= toggle ) then
		UltimateUI_UseAbbreviatedShortcutNames = toggle;
		UltimateUI_UpdateAllButtonHotKeys();
	end
end

UltimateUI_ShortcutAbbreviations = {
	["Shift"] = "S",
	["Alt"] = "A",
	["Ctrl"] = "C",
	["Control"] = "C",
	["shift"] = "S",
	["alt"] = "A",
	["ctrl"] = "C",
	["control"] = "C",
	["SHIFT"] = "S",
	["ALT"] = "A",
	["CTRL"] = "C",
	["CONTROL"] = "C"
};

-- Begin Keypad stuff
old_KeyBindingFrame_GetLocalizedName = KeyBindingFrame_GetLocalizedName;
--[[
function KeyBindingFrame_GetLocalizedName(name, prefix)
       -- call the previous routine
       local text = old_KeyBindingFrame_GetLocalizedName(name, prefix);

       -- now rename the numeric keypad names
       -- Sea.io.print("MyKeyBindingFrame_GetLocalizedName: "..text..".");
       if (text == "NUMPADEQUALS") then
               text = "KP =";
       elseif(string.find(text,"Num Pad ")) then
       		local startpos, endpos = string.find(text,"Num Pad ");
       		if (startpos and (startpos > 1)) then
       			text = string.sub(text, 1, startpos - 1).."KP "..string.sub(text, endpos + 1, strlen(text));
       		else
       			text = "KP"..string.sub(text, 8);
       		end               
       end
		if ( UltimateUI_UseAbbreviatedShortcutNames == 1 ) then
			for str, repl in UltimateUI_ShortcutAbbreviations do
				text = string.gsub(text, str, repl);
			end
		end

       return text;
end
]]--
-- End Keypad stuff

function UltimateUI_ShiftSell(toggle)
	if ( toggle ~= 0 ) then
		UltimateUI_ShiftToSell = true;
	else
		UltimateUI_ShiftToSell = false;
	end
end

-- Quest Scroll speed
function UltimateUI_SetQuestTextScrollSpeed(toggle, speed)
	if ( toggle ~= 0 ) then 
		--setglobal('QUEST_FADING_ENABLE',true);
		setglobal('QUEST_DESCRIPTION_GRADIENT_CPS',speed);
	else
		--setglobal('QUEST_FADING_ENABLE',false);
		setglobal('QUEST_DESCRIPTION_GRADIENT_CPS',600000);
	end
end


function UltimateUI_ResetPartyFrames()
	local lastFrame = PartyMemberFrame1;
	lastFrame:ClearAllPoints();
	lastFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -128);
	local newFrame = nil;
	for i = 2, MAX_PARTY_MEMBERS do
		newFrame = getglobal(string.format("PartyMemberFrame%d", i));
		if ( newFrame ) then
			newFrame:ClearAllPoints();
			newFrame:SetPoint("TOPLEFT", lastFrame:GetName(), "BOTTOMLEFT", 0, -10);
		end
		lastFrame = newFrame;
	end
end

function UltimateUI_Registers()
	-- Register with the UltimateUIMaster
	UltimateUI_RegisterConfiguration(
		"UUI_COS",
		"SECTION",
		TEXT(ULTIMATEUI_CONFIG_SEP),
		TEXT(ULTIMATEUI_CONFIG_SEP_INFO)
		);
	UltimateUI_RegisterConfiguration(
		"UUI_UUI_DEFAULTSEPARATOR",
		"SEPARATOR",
		TEXT(ULTIMATEUI_CONFIG_SEP),
		TEXT(ULTIMATEUI_CONFIG_SEP_INFO)
		);
	UltimateUI_RegisterConfiguration(
		"UUI_UUI_QUESTSCROLL",
		"BOTH",
		ULTIMATEUI_CONFIG_QUESTSCROLL,
		ULTIMATEUI_CONFIG_QUESTSCROLL_INFO,
		UltimateUI_SetQuestTextScrollSpeed,
		0,
 		40,				--Default Value
 		40,				--Min value
 		400,			--Max value
 		ULTIMATEUI_CONFIG_QUESTSCROLL_CHARS,	--Slider Text
 		20,				--Slider Increment
 		1,				--Slider state text on/off
 		ULTIMATEUI_CONFIG_QUESTSCROLL_APPEND,			--Slider state text append
 		1				--Slider state text multiplier
		);

	UltimateUI_RegisterConfiguration(
		"UUI_UUI_SHIFTSELL",
		"CHECKBOX", 
		TEXT(ULTIMATEUI_CONFIG_S2SELL),
		TEXT(ULTIMATEUI_CONFIG_S2SELL_INFO),
		UltimateUI_ShiftSell,
		0
		);
	UltimateUI_RegisterConfiguration(
		"UUI_UUI_SCROLLCHATWITHMOUSEWHEEL",
		"CHECKBOX",
		TEXT(ULTIMATEUI_CONFIG_MWHEELCHAT),
		TEXT(ULTIMATEUI_CONFIG_MWHEELCHAT_INFO),
		UltimateUI_ChangeUseMouseWheelToScrollChat,
		0
		);
	UltimateUI_RegisterConfiguration(
		"UUI_UUI_FPSMOVE",
		"CHECKBOX",
		TEXT(ULTIMATEUI_CONFIG_FPSMOVE),
		TEXT(ULTIMATEUI_CONFIG_FPSMOVE_INFO),
		UltimateUI_TurnOnFPSMove,
		0
		);
	UltimateUI_RegisterConfiguration(
		"UUI_UUI_SHORTCUT_NAMES",
		"CHECKBOX",
		TEXT(ULTIMATEUI_CONFIG_SHORTCUT_NAMES),
		TEXT(ULTIMATEUI_CONFIG_SHORTCUT_NAMES_INFO),
		UltimateUI_SetUseAbbreviatedShortcutNames,
		UltimateUI_UseAbbreviatedShortcutNames
		);
	UltimateUI_RegisterConfiguration(
		"UUI_UUI_RESET_PARTY_FRAMES",
		"BUTTON",
		TEXT(ULTIMATEUI_CONFIG_RESET_PARTY_FRAMES),
		TEXT(ULTIMATEUI_CONFIG_RESET_PARTY_FRAMES_INFO),
		UltimateUI_ResetPartyFrames,
		0,
		0,
		0,
		0,
		TEXT(ULTIMATEUI_CONFIG_RESET_PARTY_FRAMES_TEXT)
		);
	

	--[[
	-- UltimateUI Help Button
	UltimateUI_RegisterButton ( 
		ULTIMATEUI_BUTTON_ULTIMATEUI_HELP, 
		ULTIMATEUI_BUTTON_ULTIMATEUI_HELP_SUB, 
		ULTIMATEUI_BUTTON_ULTIMATEUI_HELP_TIP, 
		"Interface\\Icons\\INV_Misc_Book_08", 
		function()
			LaunchURL("http://www.wowwiki.com/index.php/UltimateUI_Portal"); 		
		end
		);
	]]--
	-- UltimateUI Configuration Button
	UltimateUI_RegisterButton ( 
		ULTIMATEUI_BUTTON_ULTIMATEUI, 
		ULTIMATEUI_BUTTON_ULTIMATEUI_SUB, 
		ULTIMATEUI_BUTTON_ULTIMATEUI_TIP, 
		"Interface\\Icons\\Ability_Repair", 
		function()
			if (UltimateUIMasterFrame:IsVisible()) then 
				HideUIPanel(UltimateUIMasterFrame);
			else 
				PlaySound("igMainMenuOption");
				ShowUIPanel(UltimateUIMasterFrame);
				UltimateUIMasterFrame_Show();
			end
		end
		);

end
