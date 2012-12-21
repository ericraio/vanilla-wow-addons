--[[

	Set Wrangler
	
]]

--------------------------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------------------------
SW_NUM_CLASSES		= table.getn(SW_TEXT_CLASSNAMES);
SW_NUM_SET_TABS		= 10;
SW_NUM_BUTTONS		= 8;
SW_MAX_CACHE_ATTEMPTS = 50;

SW_ITEMS_ON_LINE	= 2;

SW_PART_HEAD		= 1;
SW_PART_SHOULD		= 2;
SW_PART_CHEST		= 3;
SW_PART_LEGS		= 4;
SW_PART_HANDS		= 5;
SW_PART_FEET		= 6;
SW_PART_BELT		= 7;
SW_PART_WRISTS		= 8;
SW_PART_BACK		= 9;
SW_PART_TRINKET		= 10;
SW_PART_FINGER		= 11;
SW_PART_HAND		= 12;
SW_PART_OHAND		= 13;
SW_PART_OFFHAND		= 14;

SW_PART_ZG_TRINK	= 1;
SW_PART_ZG_NECK		= 2;
SW_PART_ZG_CHEST	= 3;
SW_PART_ZG_BELT		= 4;
SW_PART_ZG_WRISTS	= 5;

SW_CACHE_TIMER			= 0.5;

SW_DEFAULT_ICON			= "Interface/Icons/INV_Misc_QuestionMark";
SW_VERSION				= "12";

SW_WHISPER_MAX		= 17;

SW_MAX_TABS			= 8;

--------------------------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------------------------
gaClassSetData		= {};
gSelectedClass		= 0;
gSelectedSet		= 0;
gSelectedPart		= 0;

gLinkToIndex		= 1;

gDoCacheTimer		= 0;
gCacheTimer			= 0;
gCacheAttempts		= 0;
gCacheData			= {};
gCacheData.itemLink = "";
gCacheData.callback	= "";
gWhisperLowerBound	= 1;

gTabSet				= 0;

gLocalPartData		= {};

local function dout(msg)
	if( DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,1.0,0,0);
	end
end

--------------------------------------------------------------------------------------------------
-- Class level functions
--------------------------------------------------------------------------------------------------
function SetWrangler_LoadClass(classId,setId)
	SetWrangler_HideInfoIcons();
	
	if (setId == nil) then
		gSelectedSet = 1;
		setId = 1;
	end
	
	gTabSet	= 0;
	SetWrangler_SetTabText(classId);
	SetWrangler_LoadSetDropDown();
	SetWrangler_UpdateClassTabs(classId);
	SetWrangler_LoadSet(setId);
	
	-- Page numbers
	SetWranglerTabPageText:SetText(SW_TEXT_PAGE.." "..(gTabSet+1).."/"..gaClassSetData[gSelectedClass].numTabSets);
end

function SetWrangler_UpdateClassTabs(classId)
	local tabFrame;
	
	for i=1,SW_NUM_CLASSES do
		tabFrame = getglobal("SetWranglerFrameTab"..i);
		
		if (i == classId) then
			PanelTemplates_SelectTab(tabFrame);
		else
			PanelTemplates_DeselectTab(tabFrame);	
		end	
	end	
end

function SetWrangler_SetClassTabs()
	local tabFrame;
	
	for i=1,table.getn(gaClassSetData) do
		--dout("Setting tab: "..i..": "..gaClassSetData[i].sName);
		tabFrame = getglobal("SetWranglerFrameTab"..i);
		
		tabFrame:SetText(gaClassSetData[i].sName);
		PanelTemplates_TabResize(1,tabFrame);
		getglobal(tabFrame:GetName().."HighlightTexture"):SetWidth(tabFrame:GetTextWidth() + 35);

		tabFrame:Show();
	end	
end

--------------------------------------------------------------------------------------------------
-- Set level functions
--------------------------------------------------------------------------------------------------
function SetWrangler_LoadSet(setId, leaveChecks)
	-- disable other tabs until set is loaded
		
	--dout("Load Set: "..setId);
	local setSize = table.getn(gaClassSetData[gSelectedClass].aSetData);

	-- Check everything
	if (setSize == 0) then
		SetWrangler_LoadEmptySet();
	else
		if (leaveChecks == nil) then
			SetWrangler_SetChecks(1);
		end

		-- Hide the info icon
		SetWranglerRankIcon:Hide();

		SetWrangler_UpdateSetTabs(setId);
	
		-- Title Text
		nameLocationText = getglobal("SetWranglerButtonTitle".."ButtonTextNameLocation");
		infoText = getglobal("SetWranglerButtonTitle".."ButtonTextInfo");
			
		SetWranglerButtonTitleButtonTextNameLocation:SetText(gaClassSetData[gSelectedClass].aSetData[setId].sName);
		infoText:SetText(gaClassSetData[gSelectedClass].aSetData[setId].setInfo);

		-- Set the set stats
		SetWranglerFrameInfoText:SetText(gaClassSetData[gSelectedClass].aSetData[setId].setStats);

		for i=1,SW_NUM_BUTTONS do
			swButton = getglobal("SetWranglerSetTabFrameButton"..i);
			swButton:Hide();
		end
		
		for i=1,table.getn(gaClassSetData[gSelectedClass].aSetData[setId].aPartData) do
			nameLocationText = getglobal("SetWranglerSetTabFrameButton"..i.."ButtonTextNameLocation");
			infoText = getglobal("SetWranglerSetTabFrameButton"..i.."ButtonTextInfo");
			icon = getglobal("SetWranglerSetTabFrameButton"..i.."Icon");
			
			-- Set the text
			infoText:SetText(gaClassSetData[gSelectedClass].aSetData[setId].aPartData[i].itemInfo);

			-- Set the icon
			link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[i].itemLink
			
			if (string.find(link,"item:") ~= nil) then
				checkButton = getglobal("SetWranglerSetTabFrameButton"..i.."CheckButton");
				state = checkButton:GetChecked();
				
				if (state ~= nil) then
					if (SetWranglerOptions.useLocalCacheOnly == nil and SetWranglerOptions.disconnectFree == nil) then
						SetWrangler_CacheItem(link,SetWrangler_LoadSet);
						--dout("caching");
					end
				end
				local nm,_,rarity,_,_,_,_,_,tex = GetItemInfo(link);

				if (tex ~= nil) then
					icon:SetNormalTexture(tex);
				else
					icon:SetNormalTexture(SW_DEFAULT_ICON);
				end

				if (nm ~= nil) then
					nameLocationText:SetText(SW_LINK_COLOR_OPEN..SW_LINK_COLORS[rarity]..nm..SW_LINK_COLOR_CLOSE);
				elseif (SetWranglerOptions.disconnectFree == nil) then
					nameLocationText:SetText("Link not cached locally...");
				else
					local index = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[i].itemLink;
					index = string.gsub(index,"item:","");
					nameLocationText:SetText(SW_LINK_COLOR_OPEN..SWLocalSetData[index]["c"]..SWLocalSetData[index]["i"]..SW_LINK_COLOR_CLOSE);
				end
			else
				icon:SetNormalTexture(SW_DEFAULT_ICON);
				nameLocationText:SetText("Invalid link...");
			end

			swButton = getglobal("SetWranglerSetTabFrameButton"..i);
			swButton:Show();
		end
	end
end

function SetWrangler_GetItemInfo(link)
	local part = gLocalPartData[link];
	
	local name, tex;
	
	if (part ~= nil) then
		name = SW_LINK_COLOR_OPEN..part.color[1]..part.line[1]..SW_LINK_COLOR_CLOSE;
		tex = part.tex;
	else
		name = "Invalid link...";
		tex = nil;
	end
	
	return name,tex;
end


function SetWrangler_SetChecks(state)
	SetWranglerButtonTitleCheckButton:SetChecked(state);
	
	local checkButton;

	for i=1,table.getn(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData) do
		checkButton = getglobal("SetWranglerSetTabFrameButton"..i.."CheckButton");
		checkButton:SetChecked(state);
	end
end

function SetWrangler_LoadEmptySet()
	SetWranglerButtonTitleCheckButton:SetChecked(nil);
	
	nameLocationText = getglobal("SetWranglerButtonTitle".."ButtonTextNameLocation");
	infoText = getglobal("SetWranglerButtonTitle".."ButtonTextInfo");
		
	SetWranglerButtonTitleButtonTextNameLocation:SetText("Unknown Set");
	infoText:SetText("Ensure case is handled in SetWranglerData.lua");
	
	for i=1,SW_NUM_BUTTONS do
		swButton = getglobal("SetWranglerSetTabFrameButton"..i);
		swButton:Hide();
	end
end

function SetWrangler_UpdateSetTabs(setId)
	local tabFrame;
	
	setId = setId - (gTabSet * SW_MAX_TABS);

	for i=1, SW_MAX_TABS do
		tabFrame = getglobal("SetWranglerSetTabFrameTab"..i);
		
		if (i == setId) then
			PanelTemplates_SelectTab(tabFrame);
		else
			PanelTemplates_DeselectTab(tabFrame);	
		end	
	end	
end


function SetWrangler_SetTabText(classId)
	if (classId == nil) then
		classId = gSelectedClass;
	end
	
	local startIndex = (gTabSet * SW_MAX_TABS) + 1;
	local endIndex	= startIndex + SW_MAX_TABS - 1;
	
	if (table.getn(gaClassSetData[classId].aSetData) < endIndex) then
		endIndex = table.getn(gaClassSetData[classId].aSetData);
	end
	
	local tabFrame;

	for i=1,SW_NUM_SET_TABS do
		tabFrame = getglobal("SetWranglerSetTabFrameTab"..i);
		tabFrame:Hide();
	end
	
	local tabIndex = 1;
	
	for i=startIndex,endIndex do
		tabFrame = getglobal("SetWranglerSetTabFrameTab"..tabIndex);
		tabIndex = tabIndex + 1;

		tabFrame:SetText(gaClassSetData[classId].aSetData[i].sTabName);
		PanelTemplates_TabResize(0,tabFrame);
		getglobal(tabFrame:GetName().."HighlightTexture"):SetWidth(tabFrame:GetTextWidth() + 31);
		
		if (SetWranglerOptions.useDropDown == nil) then
			tabFrame:Show();
		end
	end
	
	-- button disable / enable
	--dout(gaClassSetData[classId].numTabSets.." == "..(gTabSet + 1));
	if (gaClassSetData[classId].numTabSets == (gTabSet + 1)) then
		SetWranglerTabButtonNext:Disable();
	else
		SetWranglerTabButtonNext:Enable();
	end
	
	if (gTabSet == 0) then
		SetWranglerTabButtonBack:Disable();
	else
		SetWranglerTabButtonBack:Enable();
	end
end


--------------------------------------------------------------------------------------------------
-- Utility functions
--------------------------------------------------------------------------------------------------
function SetWrangler_Toggle()
  if SetWranglerFrame:IsVisible() then
    HideUIPanel(SetWranglerFrame);
  else
    ShowUIPanel(SetWranglerFrame);
  end
end

function SetWrangler_StartCacheTimer(itemLink, callback)
	gDoCacheTimer = 1;
	gCacheTimer = 0;
	--gCacheAttempts = 0;
	
	gCacheData.itemLink = itemLink;
	gCacheData.callback	= callback;
end

function SetWrangler_MakeTextLink(itemLink)
	local iName,iLink,iRarity,_,iType,_,_,iEquip = GetItemInfo(itemLink);

	local textLink = nil;
		
	if (iName == nil) then
		--dout("Failed to cache item link");
	else
		--dout("Creating a link for: "..iName);
		
		-- New link
		textLink = SW_LINK_COLOR_OPEN;
		textLink = textLink..SW_LINK_COLORS[iRarity];
		textLink = textLink..SW_LINK_HYPERLINK_OPEN;
		textLink = textLink..itemLink;
		textLink = textLink..SW_LINK_LINK_OPEN;
		textLink = textLink..iName;
		textLink = textLink..SW_LINK_LINK_CLOSE;
		textLink = textLink..SW_LINK_COLOR_CLOSE;
	end

	return textLink;
end

function SetWrangler_CacheItem(itemLink,callback)
	local attempts = 0;
	local name = GetItemInfo(itemLink);

	if (name == nil) then
		--dout("Caching: "..itemLink);

		ShowUIPanel(SWCacheTooltip);
		if ( not SWCacheTooltip:IsVisible() ) then
			SWCacheTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
		end

		SWCacheTooltip:SetHyperlink(itemLink);
				
		SetWrangler_StartCacheTimer(itemLink,callback);
	else
		--dout(itemLink.." is already cached");
	end
end

function SetWrangler_LoadPlayerClass()
	local playerClass = UnitClass("player");

	if (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_DRUID]) then
		gSelectedClass = SW_CLASS_DRUID;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_HUNTER]) then
		gSelectedClass = SW_CLASS_HUNTER;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_MAGE]) then
		gSelectedClass = SW_CLASS_MAGE;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_PALADIN]) then
		gSelectedClass = SW_CLASS_PALADIN;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_PRIEST]) then
		gSelectedClass = SW_CLASS_PRIEST;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_ROGUE]) then
		gSelectedClass = SW_CLASS_ROGUE;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_SHAMAN]) then
		gSelectedClass = SW_CLASS_SHAMAN;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_WARLOCK]) then
		gSelectedClass = SW_CLASS_WARLOCK;
		gSelectedSet = 1;
	elseif (playerClass == SW_TEXT_CLASSNAMES[SW_CLASS_WARRIOR]) then
		gSelectedClass = SW_CLASS_WARRIOR;
		gSelectedSet = 1;
	end

	SetWrangler_LoadClass(gSelectedClass, gSelectedSet);
end


function SetWrangler_Init(opposite)
	local faction = UnitFactionGroup("player");
	if (opposite == nil) then
		if (string.lower(faction) == SW_TEXT_ALLIANCE) then
			gPlayerFaction = SW_TEXT_ALLIANCE;
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			gPlayerFaction = SW_TEXT_HORDE;
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end
	else
		if (string.lower(faction) == SW_TEXT_ALLIANCE) then
			gPlayerFaction = SW_TEXT_HORDE;
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		else
			gPlayerFaction = SW_TEXT_ALLIANCE;
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;	
		end
	end
	
	for i=1,table.getn(SW_TEXT_CLASSNAMES) do
		gaClassSetData[i] = SetWrangler_MakeMasterData(i);
	end
	
	SetWrangler_SetClassTabs();
	
	-- Set arrow text
	SetWranglerTabButtonNext:SetText(">>");
	SetWranglerTabButtonBack:SetText("<<");
end

function SetWrangler_LoadSetDropDown()
	UIDropDownMenu_Initialize(SetWranglerSetDropDown, SetWranglerSetDropDownOnInit);
	UIDropDownMenu_SetWidth(150, SetWranglerSetDropDown);
	
	SetWrangler_UpdateSetDropDown();
end

function SetWrangler_UpdateSetDropDown()
	UIDropDownMenu_SetSelectedValue(SetWranglerSetDropDown, gSelectedSet);
	UIDropDownMenu_SetText(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].sTabName,SetWranglerSetDropDown);
end

--------------------------------------------------------------------------------------------------
-- Handler functions
--------------------------------------------------------------------------------------------------

function SetWranglerOnLoad()
	UIPanelWindows["SetWranglerFrame"] = { area = "left", pushable = 9, whileDead = 1 }; 

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");

	-- Register our slash command
	SLASH_SETWRANGLER1 = "/setwrangler";
	SLASH_SETWRANGLER2 = "/sw";
	SlashCmdList["SETWRANGLER"] = function(msg)
		SetWrangler_SlashCommandHandler(msg);
	end

	UIDropDownMenu_Initialize(SetWranglerLinkDropDown, SetWranglerDropDownOnInit);
	UIDropDownMenu_SetWidth(60, SetWranglerLinkDropDown);
	
	UIDropDownMenu_Initialize(SetWranglerRightClickMenu, SetWranglerRightClickMenu_AddItems, "MENU");
end


function SetWrangler_OnShow()
	SetWranglerFrameTitleText:SetText(BINDING_HEADER_SETWRANGLER.." v"..SW_VERSION.."");
	
	-- Load the player's class
	SetWrangler_LoadPlayerClass();
	
	-- Page numbers
	SetWranglerTabPageText:SetText(SW_TEXT_PAGE.." "..(gTabSet+1).."/"..gaClassSetData[gSelectedClass].numTabSets);
	
	-- temp
	--SetWrangler_Init();
	--

	gLinkToIndex = 1;
	UIDropDownMenu_SetSelectedValue(SetWranglerLinkDropDown, gLinkToIndex);
	UIDropDownMenu_SetText(SW_TEXT_LINK_OPTIONS[gLinkToIndex],SetWranglerLinkDropDown);
	
	--UIDropDownMenu_SetSelectedValue(SetWranglerSetDropDown, gSelectedSet);
	--UIDropDownMenu_SetText(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].sTabName,SetWranglerLinkDropDown);
	
	if (SetWranglerOptions.disconnectFree ~= nil) then
		SetWranglerPreviewButton:Disable();
		SetWranglerLinkButton:Disable();
	else
		SetWranglerPreviewButton:Enable();
		SetWranglerLinkButton:Enable();
	end
end

function SetWranglerOnEvent(event)
	if( event == "VARIABLES_LOADED" ) then
		if (SetWranglerOptions == nil) then
			SetWranglerOptions = {};
			SetWranglerOptions.useLocalCacheOnly = 1;
			SetWranglerOptions.useDropDown = nil;
		end
		
		-- Set the check
		SetWranglerLocalCacheCheckButton:SetChecked(SetWranglerOptions.useLocalCacheOnly);
		
		-- set the set drop down
		if (SetWranglerOptions.useDropDown ~= nil) then
			SetWrangler_ShowTabNav(false);
			SetWrangler_ShowDropDownNav(true);
		end
		
		-- see if we need to load local data
		if (SetWranglerOptions.disconnectFree ~= nil) then
			SetWrangler_LoadLocalData();
		end
	elseif( event == "PLAYER_LOGIN" ) then
		SetWrangler_Init(SetWranglerOptions.viewOpposingFaction);
	end
end

function SetWrangler_OnInfoButtonEnter()
	GameTooltip:SetOwner(this, "ANCHOR_NONE");
	GameTooltip:SetPoint("TOPLEFT",this, "BOTTOMLEFT",32,0);
	
	local link = nil;
		
	if (this:GetID() == 1) then
		link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink2;
	elseif (this:GetID() == 2) then
		link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink3;
	elseif (this:GetID() == 3) then
		link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink4;
	else
		link = "";
	end
	
	if (SetWranglerOptions.disconnectFree == nil) then -- do normal method
		
		if (string.find(link,"item:") ~= nil) then
			if (GetItemInfo(link)) then
				GameTooltip:SetHyperlink(link);
				GameTooltip:Show();
			end
		end
	else
		local index = string.gsub(link,"item:","");
		SetWrangler_SetLocalTooltip(index);
	end
end

function SetWrangler_OnButtonEnter()
	GameTooltip:SetOwner(this, "ANCHOR_NONE");
	GameTooltip:SetPoint("TOPLEFT",this, "BOTTOMLEFT",32,0);
	
	if (SetWranglerOptions.disconnectFree == nil) then -- do normal method
		local link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[this:GetParent():GetID()].itemLink;

		if (string.find(link,"item:") ~= nil) then
			if (GetItemInfo(link)) then
				GameTooltip:SetHyperlink(link);
				GameTooltip:Show();
			end
		end
	else -- Do disconnect free local method
		local index = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[this:GetParent():GetID()].itemLink;
		index = string.gsub(index,"item:","");
		SetWrangler_SetLocalTooltip(index);
	end

	this:GetParent():LockHighlight();
end

function SetWrangler_SetLocalTooltip(index)
	local ttText = SWLocalSetData[index]["t"];
	local token = "";
		
	if (ttText ~= nil) then
		local color = SWLocalSetData[index]["c"];
		
		--dout(ttText);
		token,ttText = SetWrangler_GetToken(ttText);
		GameTooltip:AddLine(SW_LINK_COLOR_OPEN..color..token..SW_LINK_COLOR_CLOSE);
		
		-- Binding
		token,ttText = SetWrangler_GetToken(ttText);
		GameTooltip:AddLine(SW_LINK_COLOR_OPEN.."ffffff"..token..SW_LINK_COLOR_CLOSE);
				
		-- Spot and type
		leftToken,ttText = SetWrangler_GetToken(ttText);
		rightToken,ttText = SetWrangler_GetToken(ttText);
		GameTooltip:AddDoubleLine(leftToken,rightToken,1,1,1,1,1,1);
		
		-- The bonuses
		token,ttText = SetWrangler_GetToken(ttText);
		--dout(token.." ("..SetWrangler_SafeLen(token)..")");
		local lineColor = "ffffff";
		while (SetWrangler_IsEmpty(token) == false) do
			if (string.find(token,"Equip:") ~= nil or string.find(token,"Passive:") ~= nil or string.find(token,"Use:") ~= nil) then
				lineColor = SW_GREEN;
			end
			
			GameTooltip:AddLine(SW_LINK_COLOR_OPEN..lineColor..token..SW_LINK_COLOR_CLOSE);
			token,ttText = SetWrangler_GetToken(ttText);
			--dout(token.." ("..SetWrangler_SafeLen(token)..")");
			
		end
		
		local firstTime = true;
		
		-- Set the set text
		token,ttText = SetWrangler_GetToken(ttText);
		while (SetWrangler_SafeLen(token) > 0) do
			if (firstTime == true) then
				GameTooltip:AddLine(" ");
				firstTime = false;
			end
			GameTooltip:AddLine(SW_GOLD_OPEN..token..SW_LINK_COLOR_CLOSE);
			token,ttText = SetWrangler_GetToken(ttText);
		end
		
		firstTime = true;
		
		-- Set the descriptive text
		token,ttText = SetWrangler_GetToken(ttText);
		while (SetWrangler_SafeLen(token) > 0) do
			if (firstTime == true) then
				GameTooltip:AddLine(" ");
				firstTime = false;
			end
			GameTooltip:AddLine(SW_GREEN_OPEN..token..SW_LINK_COLOR_CLOSE);
			token,ttText = SetWrangler_GetToken(ttText);
		end
						
		GameTooltip:SetWidth(200);
		GameTooltip:Show();
	end
end

function SetWrangler_GetToken(ttText)
	if (ttText == nil) then
		return nil,nil;
	end
	
	local lineEnd = string.find(ttText,"·");
	
	if (lineEnd == nil) then
		return "";
	end
	
	if (lineEnd > 35) then
		for i=35, SetWrangler_SafeLen(ttText) do
			--dout(string.byte(token,i));
			local char = string.byte(ttText,i);
			
			if (char > 127 or char == 32) then
				lineEnd = i;
				i = SetWrangler_SafeLen(ttText);
			end
		end
	end
	
	local token = string.sub(ttText,1,lineEnd);
	ttText = string.sub(ttText,lineEnd+1);
	
	return token,ttText;
end

function SetWrangler_SafeLen(str)
	if (str == nil) then
		return 0;
	end
	
	return string.len(str);
end

function SetWrangler_IsEmpty(token)
	if (SetWrangler_SafeLen(token) == 0) then
		return true;
	end
	
	for i=1, SetWrangler_SafeLen(token) do
		--dout(string.byte(token,i));
		local char = string.byte(token,i);
		
		if (char ~= 32 and char ~= 10 and char < 127) then
			return false;
		end
	end
	
	return true;
end

function SetWrangler_OnUpdate(elapse)
	if (gDoCacheTimer == 1) then
		--dout("Update: "..gCacheTimer);
		gCacheTimer = gCacheTimer + elapse;

		if (gCacheTimer > SW_CACHE_TIMER) then
			gDoCacheTimer = 0;
			gCacheAttempts = gCacheAttempts + 1;

			if (gCacheAttempts <= SW_MAX_CACHE_ATTEMPTS) then
				gCacheData.callback(gSelectedSet,1);
			else
				nameLocationText:SetText("Failed to load link...");
			end
		end
	end	
end

function SetWranglerFunctionButton_OnEnter()
	if( this:GetCenter() < GetScreenWidth() / 2 ) then
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	end	

	if (this == SetWranglerPreviewButton) then
		GameTooltip:SetText("Preview the checked items in the Dressing Room.");
	elseif (this == SetWranglerLinkButton) then
		GameTooltip:SetText("Link the checked items in the chat window.");
	elseif (this == SetWranglerLocalCacheCheckButton or this == SWOptionsLocalCacheCheckButton) then
		GameTooltip:SetText(SW_TEXT_CACHE_TT);
	elseif (this == SetWranglerTabButtonNext) then
		GameTooltip:SetText(SW_TEXT_TAB_NEXT);
	elseif (this == SetWranglerTabButtonBack) then
		GameTooltip:SetText(SW_TEXT_TAB_BACK);
	elseif (this == SWOptionsDropDownCheckButton) then
		GameTooltip:SetText(SW_TEXT_TAB_NAV);
	elseif (this == SWOptionsMOFakeButton) then
		GameTooltip:SetText(SW_TEXT_PMODE);
	elseif (this == SWOptionsDisconnectFreeCheckButton) then
		GameTooltip:SetText(SW_TEXT_DFMODE);
	end

end

function SetWrangler_SlashCommandHandler(msg)
	SetWrangler_Toggle();
end

--------------------------------------------------------------------------------------------------
-- OnClick Handlers
--------------------------------------------------------------------------------------------------
function SetWranglerOnEventOnClassClick(classId)
	gDoCacheTimer = 0;
	
	SetWrangler_HideInfoIcons();
	
	gSelectedClass = classId;

	if (classId <= table.getn(gaClassSetData)) then
		SetWrangler_LoadClass(classId);
	end
end


function SetWranglerOnEventOnSetClick(setId)
	gDoCacheTimer = 0;
	
	SetWrangler_HideInfoIcons();
	
	gSelectedSet = (gTabSet * SW_MAX_TABS) + setId;
	SetWrangler_LoadSet(gSelectedSet);
	SetWrangler_UpdateSetDropDown();
end

function SetWrangler_OnCheckButtonClick()
	local state = this:GetChecked();
	SetWrangler_SetChecks(state);
end

function SetWrangler_OnPreview()
	--ShowUIPanel(DressUpModel);
	-- Dummy link to open it or Undress will not work initially
	DressUpItemLink("");
	
	if (SetWranglerOptions.previewMode == 2) then -- get naked
		DressUpModel:Undress();
	elseif (SetWranglerOptions.previewMode == 3) then -- dress in current armor
		DressUpModel:Dress();
	end
	
	for i=1,table.getn(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData) do
		checkButton = getglobal("SetWranglerSetTabFrameButton"..i.."CheckButton");
		state = checkButton:GetChecked();

		if (state ~= nil) then
			if (GetItemInfo(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[i].itemLink) ~= nil) then
				DressUpItemLink(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[i].itemLink);		
			end
		end
	end
	--DressUpItemLink("item:4044:0:0:0");
	--DressUpItemLink("item:16793:0:0:0");
end

function SetWrangler_OnLink()
	--dout("Link");
	local numOnLine = 0;
	local line = "";
	
	local CHAT_SYSTEM = SW_TEXT_LINK_OPTIONS_SL[gLinkToIndex];
			
	SendChatMessage(BINDING_HEADER_SETWRANGLER.." "..SW_TEXT_LINKS,CHAT_SYSTEM,nil,nil);
	SendChatMessage(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].sName.." ("..gaClassSetData[gSelectedClass].sName..", "..gaClassSetData[gSelectedClass].aSetData[gSelectedSet].setInfo..")",CHAT_SYSTEM,nil,nil);
	for i=1,table.getn(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData) do
		checkButton = getglobal("SetWranglerSetTabFrameButton"..i.."CheckButton");
		state = checkButton:GetChecked();

		if (state ~= nil) then
			link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[i].itemLink
			
			if (GetItemInfo(link) ~= nil) then
				textLink = SetWrangler_MakeTextLink(link);
				
				if (textLink ~= nil and string.find(link,"item:") ~= nil) then
					line = line..textLink..", ";
					numOnLine = numOnLine + 1;
					
					val = math.mod(numOnLine,SW_ITEMS_ON_LINE);
					
					if (math.mod(numOnLine,SW_ITEMS_ON_LINE) == 0) then
						line = string.sub(line,1,string.len(line) - 2);
						SendChatMessage(line,CHAT_SYSTEM,nil,nil);
						numOnLine = 0;
						line = "";
					end
				end
			end
		end
	end
	
	if (numOnLine > 0) then
		line = string.sub(line,1,string.len(line) - 2);
		SendChatMessage(line,system,nil,whisperName);
	end
end

function SetWrangler_OnLocalCache()
	if (SetWranglerOptions.useLocalCacheOnly == nil) then
		SetWranglerOptions.useLocalCacheOnly = 1;
	else
		SetWranglerOptions.useLocalCacheOnly = nil;
		SetWrangler_HideInfoIcons();
		SetWrangler_LoadSet(gSelectedSet,1);
	end
end

function SetWranglerCommand_OnLink(system, whisperName)
	--dout("Link");
	
	local numOnLine = 0;
	local line = "";
				
	SendChatMessage(BINDING_HEADER_SETWRANGLER.." "..SW_TEXT_LINKS,system,nil,whisperName);
	SendChatMessage(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].sName.." ("..gaClassSetData[gSelectedClass].sName..", "..gaClassSetData[gSelectedClass].aSetData[gSelectedSet].setInfo..")",system,nil,whisperName);
	for i=1,table.getn(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData) do
		checkButton = getglobal("SetWranglerSetTabFrameButton"..i.."CheckButton");
		state = checkButton:GetChecked();

		if (state ~= nil) then
			link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[i].itemLink

			if (GetItemInfo(link) ~= nil) then
				textLink = SetWrangler_MakeTextLink(link);

				if (textLink ~= nil and string.find(link,"item:") ~= nil) then
					line = line..textLink..", ";
					numOnLine = numOnLine + 1;
					
					if (math.mod(numOnLine,SW_ITEMS_ON_LINE) == 0) then
						line = string.sub(line,1,string.len(line) - 2);
						SendChatMessage(line,system,nil,whisperName);
						numOnLine = 0;
						line = "";
					end
				end
			end
		end
	end
	
	if (numOnLine > 0) then
		line = string.sub(line,1,string.len(line) - 2);
		SendChatMessage(line,system,nil,whisperName);
	end
end

function SetWrangler_HideInfoIcons()
	-- Hide the info icons
	SetWranglerSetTabFrameInfoIcon1:Hide();
	SetWranglerSetTabFrameInfoIcon2:Hide();
	SetWranglerSetTabFrameInfoIcon3:Hide();
end

function SetWrangler_LoadInfoIcons()
	local part = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart];
	
	SetWrangler_HideInfoIcons();
	
	for i=1,3 do
		local link = nil;
		
		if (i == 1) then
			link = part.itemLink2;
		elseif (i == 2) then
			link = part.itemLink3;
		elseif (i == 3) then
			link = part.itemLink4;
		end
		
		local button = getglobal("SetWranglerSetTabFrameInfoIcon"..i);
		local title = getglobal("SetWranglerInfoIconTitle"..i);
		if (link ~= nil) then
			if (string.find(link,"item:") ~= nil) then
				if (SetWranglerOptions.useLocalCacheOnly == nil) then
					SetWrangler_CacheItem(link,SetWrangler_LoadInfoIcons);
				end
				
				local nm,_,rarity,_,_,_,_,_,tex = GetItemInfo(link);
				
				if (tex ~= nil) then
					button:SetNormalTexture(tex);
				else
					button:SetNormalTexture(SW_DEFAULT_ICON);
				end
				
				if (nm ~= nil) then
					title:SetText(SW_LINK_COLOR_OPEN..SW_LINK_COLORS[rarity]..nm..SW_LINK_COLOR_CLOSE);
				elseif (SetWranglerOptions.disconnectFree == nil) then
					title:SetText("Link not cached locally...");
				else
					local index = string.gsub(link,"item:","");
					title:SetText(SW_LINK_COLOR_OPEN..SWLocalSetData[index]["c"]..SWLocalSetData[index]["i"]..SW_LINK_COLOR_CLOSE);
				end
			else
				--dout("default tex");
				button:SetNormalTexture(SW_DEFAULT_ICON);
			end
			
			button:Show();
		end
	end
end


function SetWranglerItem_OnClick(button)
	gDoCacheTimer = 0;
	
	local partIndex = this:GetID();

	if (partIndex == 500) then -- then icon button
		partIndex = this:GetParent():GetID();
	end

	gSelectedPart = partIndex;
	
	if (button == "LeftButton") then
		if (IsShiftKeyDown()) then
			if (SetWranglerOptions.disconnectFree == nil) then
				link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink
				
				if (link ~= nil) then
					if (GetItemInfo(link) ~= nil) then 
						textLink = SetWrangler_MakeTextLink(link);
						
						if ( not ChatFrameEditBox:IsVisible() ) then
							ChatFrame_OpenChat(textLink);
						else
							ChatFrameEditBox:SetText(ChatFrameEditBox:GetText()..textLink);
						end
					end
				end
			end
		else
			-- see if the part has an info icon
			local part = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[partIndex];
			infoIcon = part.itemInfoIcon;
			if (infoIcon ~= nil) then
				SetWranglerRankIcon:SetTexture(infoIcon);
				SetWranglerRankIcon:Show();	
			else
				SetWranglerRankIcon:Hide();
			end
			
			SetWranglerFrameInfoText:SetText(part.itemStats);
			
			SetWrangler_LoadInfoIcons();
		end
	else
		if (SetWranglerOptions.disconnectFree == nil) then
			gWhisperLowerBound = 1;
			
			xOffset = 72;
			yOffset = (this:GetHeight() / 2);
			
			ToggleDropDownMenu(1, nil, SetWranglerRightClickMenu, "SetWranglerSetTabFrameButton"..partIndex, xOffset, yOffset);
		end
	end
end

function SetWranglerTitleButton_OnClick(button)
	SetWrangler_HideInfoIcons();
	
	-- Set the set stats
	gSelectedPart = 0;

	if (button == "LeftButton") then
		SetWranglerRankIcon:Hide();
		SetWranglerFrameInfoText:SetText(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].setStats);
	else
		gWhisperLowerBound = 1;
		xOffset = 40;
		yOffset = (this:GetHeight() / 2);
		
		ToggleDropDownMenu(1, nil, SetWranglerRightClickMenu, "SetWranglerButtonTitle", xOffset, yOffset);
	end
end

function SetWranglerRightClickMenu_OnClick()
	ToggleDropDownMenu(1, nil, SetWranglerRightClickMenu, "SetWranglerSetTabFrame", 100, 420);

	if (this.value == "preview") then
		if (gSelectedPart > 0) then
			if (GetItemInfo(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink) ~= nil) then
				DressUpItemLink(gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink);
			end
		else -- do whole set
			SetWrangler_OnPreview();
		end
	else
		local CHAT_SYSTEM, link;
		
		if (this.value == 1) then
			CHAT_SYSTEM = SW_TEXT_LINK_OPTIONS_SL[1];
		elseif (this.value == 2) then
			CHAT_SYSTEM = SW_TEXT_LINK_OPTIONS_SL[2];
		elseif (this.value == 3) then
			CHAT_SYSTEM = SW_TEXT_LINK_OPTIONS_SL[3];
		elseif (this.value == 4) then
			CHAT_SYSTEM = SW_TEXT_LINK_OPTIONS_SL[4];
		elseif (this.value == 5) then
			CHAT_SYSTEM = SW_TEXT_LINK_OPTIONS_SL[5];
		elseif (this.value == 6) then
			CHAT_SYSTEM = SW_TEXT_LINK_OPTIONS_SL[6];
		end

		if (gSelectedPart > 0) then
			link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink;
			
			if (string.find(link,"item:") ~= nil) then
							
				SendChatMessage(BINDING_HEADER_SETWRANGLER.." "..SW_TEXT_LINKS,CHAT_SYSTEM);
							
				textLink = SetWrangler_MakeTextLink(link);

				if (GetItemInfo(link) ~= nil) then
					if (textLink ~= nil) then
						SendChatMessage(textLink,CHAT_SYSTEM);
					end
				end
			end
		else -- link set
			SetWranglerCommand_OnLink(CHAT_SYSTEM);
		end
	end
end

function SetWranglerWhisperRightClickMenu_OnClick()
	ToggleDropDownMenu(1, nil, SetWranglerRightClickMenu, "SetWranglerSetTabFrame", 100, 420);

	local whisper;
	
	if (this.value == 0) then
		whisper = UnitName("target");
	else
		whisper = this.value;
	end

	if (whisper ~= nil) and (string.len(whisper) > 0) then
		if (gSelectedPart > 0 and string.find(link,"item:") ~= nil) then
			link = gaClassSetData[gSelectedClass].aSetData[gSelectedSet].aPartData[gSelectedPart].itemLink;
			
			if (GetItemInfo(link) ~= nil) then
				textLink = SetWrangler_MakeTextLink(link);
				SendChatMessage(textLink,"WHISPER",nil,whisper);
			end
		else
			SetWranglerCommand_OnLink("WHISPER",whisper);
		end
	end
end

function SetWranglerMoreRightClickMenu_OnClick()
	--dout("inc and update");
	gWhisperLowerBound = gWhisperLowerBound + SW_WHISPER_MAX + 1;
	
	UIDropDownMenu_Initialize(SetWranglerRightClickMenu, SetWranglerRightClickMenu_AddItems, "MENU");
end


function SetWrangler_OnTabNavClick()
	if (this == SetWranglerTabButtonNext) then
		gTabSet = gTabSet + 1;
	elseif (this == SetWranglerTabButtonBack) then
		gTabSet = gTabSet - 1;
	end
	
	SetWrangler_UpdateSetTabs(gSelectedSet);
	SetWrangler_SetTabText();
	-- Page numbers
	SetWranglerTabPageText:SetText(SW_TEXT_PAGE.." "..(gTabSet+1).."/"..gaClassSetData[gSelectedClass].numTabSets);
end

function SetWrangler_OnOptions()
	ShowUIPanel(SWOptionsFrame);
end
--------------------------------------------------------------------------------------------------
-- Menu functions
--------------------------------------------------------------------------------------------------
function SetWranglerDropDownOnInit()
	SetWranglerDropDownAdd(SetWranglerDropDownDropDownOnSelect);
end

function SetWranglerSetDropDownOnInit()
	SetWranglerDropDownAddSets(SetWranglerSetDropDownOnSelect);
end


function SetWranglerDropDownDropDownOnSelect()
	UIDropDownMenu_SetSelectedValue(SetWranglerLinkDropDown, this.value);
	UIDropDownMenu_SetText(SW_TEXT_LINK_OPTIONS[this.value],SetWranglerLinkDropDown);
	gLinkToIndex = this.value;
end

function SetWranglerSetDropDownOnSelect()
	UIDropDownMenu_SetSelectedValue(SetWranglerSetDropDown, this.value);
	UIDropDownMenu_SetText(gaClassSetData[gSelectedClass].aSetData[this.value].sTabName,SetWranglerSetDropDown);
	
	gDoCacheTimer = 0;
	
	SetWrangler_HideInfoIcons();
	
	local setId = this.value;
	
	gSelectedSet = setId;
	
	-- set the correct tab set here
	gTabSet = math.ceil(setId / SW_MAX_TABS) - 1;
	SetWrangler_UpdateSetTabs(gSelectedSet);
	SetWrangler_SetTabText();
	
	SetWrangler_LoadSet(setId);
end

function SetWranglerDropDownAdd(func)
	for i=1,table.getn(SW_TEXT_LINK_OPTIONS) do
		info = {};
		info.text = SW_TEXT_LINK_OPTIONS[i];
		info.func = func;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end
end


function SetWranglerDropDownAddSets(func)
	--dout(gSelectedClass);
	for i=1,table.getn(gaClassSetData[gSelectedClass].aSetData) do
		info = {};
		info.text = gaClassSetData[gSelectedClass].aSetData[i].sTabName;
		info.func = func;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end
end


function SetWranglerRightClickMenu_AddItems()
	--dout("Init");
	
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		SetWranglerRightClickMenu_AddTitle(BINDING_HEADER_SETWRANGLER);
		SetWranglerRightClickMenu_AddCommand(SW_TEXT_PREVIEW, "preview", SetWranglerRightClickMenu_OnClick, nil);
		SetWranglerRightClickMenu_AddNest(SW_TEXT_LINK, "2")
	elseif (UIDROPDOWNMENU_MENU_LEVEL == 2) then
		for i=1,table.getn(SW_TEXT_LINK_OPTIONS) do
			SetWranglerRightClickMenu_AddCommand(SW_TEXT_LINK_OPTIONS[i], i, SetWranglerRightClickMenu_OnClick, nil, UIDROPDOWNMENU_MENU_LEVEL);		
		end

		SetWranglerRightClickMenu_AddNest(SW_TEXT_WHISPER, "3",2);
	elseif (UIDROPDOWNMENU_MENU_LEVEL == 3) then
		SetWranglerRightClickMenu_AddCommand(SW_LINK_COLOR_OPEN..SW_LINK_COLORS[3]..SW_TEXT_WHISPER_TARGET..SW_LINK_COLOR_CLOSE, 0, SetWranglerWhisperRightClickMenu_OnClick,nil, UIDROPDOWNMENU_MENU_LEVEL, 74, 133, 184);
		
		local bound = gWhisperLowerBound + SW_WHISPER_MAX;
		local addMore = 0;

		if (bound > GetNumFriends()) then
			bound = GetNumFriends();
		else
			addMore = 1;
		end
		
		--dout("low: "..gWhisperLowerBound);
		--dout("high: "..bound);
		
		for i=gWhisperLowerBound,bound do
			local name, level, class, area, connected = GetFriendInfo(i);
			if (connected == 1) then
				SetWranglerRightClickMenu_AddCommand(name, name, SetWranglerWhisperRightClickMenu_OnClick, nil, UIDROPDOWNMENU_MENU_LEVEL);
			else
				SetWranglerRightClickMenu_AddCommand(name, name, SetWranglerWhisperRightClickMenu_OnClick, 1, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end

		if (addMore == 1) then
			SetWranglerRightClickMenu_AddMoreCommand(SW_LINK_COLOR_OPEN..SW_LINK_COLORS[3]..SW_TEXT_MORE..SW_LINK_COLOR_CLOSE, 0, SetWranglerMoreRightClickMenu_OnClick,UIDROPDOWNMENU_MENU_LEVEL);
		end
	end
end


function SetWranglerRightClickMenu_AddTitle(title, level)
	if (title) then
		local info = {};
		info.text = title;
		info.notClickable = 1;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info, level);
	end
end

function SetWranglerRightClickMenu_AddNest(text, value, level)
	local info = {};
	info.text = text;
	--info.value = value;
	info.func = nil;
	info.hasArrow = 1;
	info.notCheckable = 1;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info, level);
end

function SetWranglerRightClickMenu_AddCommand(text, value, functionName, disabled, level, r, g, b)
	local info = {};
	info.text = text;
	info.value = value;
	info.func = functionName;
	info.notCheckable = 1;
	info.disabled = disabled;

	info.r = r;
	info.g = g;
	info.b = b;

	UIDropDownMenu_AddButton(info, level);
end

function SetWranglerRightClickMenu_AddMoreCommand(text, value, functionName, level)
	local info = {};
	info.text = text;
	info.value = value;
	info.func = functionName;
	info.notCheckable = 1;
	info.keepShownOnClick = 1;
	info.checked = nil;
	UIDropDownMenu_AddButton(info, level);
end

--------------------------------------------------------------------------------------------------
-- Options functions
--------------------------------------------------------------------------------------------------
function SWOptionsFrame_OnLoad()

end

function SWOptionsFrame_OnShow()
	SWOptionsLocalCacheCheckButton:SetChecked(SetWranglerLocalCacheCheckButton:GetChecked());
	SWOptionsDropDownCheckButton:SetChecked(SetWranglerOptions.useDropDown);
	SWOptionsDisconnectFreeCheckButton:SetChecked(SetWranglerOptions.disconnectFree);
		
	UIDropDownMenu_Initialize(SWOptionsPreviewModeDropDown, SetWrranglerPreviewModeDropDownOnInit);
	UIDropDownMenu_SetWidth(150, SWOptionsPreviewModeDropDown);
	
	if (SetWranglerOptions.previewMode == nil) then
		SetWranglerOptions.previewMode = 1;
	end
	
	UIDropDownMenu_SetSelectedValue(SWOptionsPreviewModeDropDown, SetWranglerOptions.previewMode);
	UIDropDownMenu_SetText(SW_TEXT_PREVIEW_OPTIONS[SetWranglerOptions.previewMode],SWOptionsPreviewModeDropDown);
end

function SWOptionsFrame_OnHide()

end

function SWOptionsFrame_OnOK()
	---
	SetWranglerOptions.useLocalCacheOnly = SWOptionsLocalCacheCheckButton:GetChecked();
	SetWranglerLocalCacheCheckButton:SetChecked(SetWranglerOptions.useLocalCacheOnly);
		
	---
	SetWranglerOptions.useDropDown = SWOptionsDropDownCheckButton:GetChecked();
	
	if (SetWranglerOptions.useDropDown ~= nil) then
		SetWrangler_ShowTabNav(false);
		SetWrangler_ShowDropDownNav(true);	
	else
		SetWrangler_ShowTabNav(true);
		SetWrangler_ShowDropDownNav(false);	
	end
	
	---
	SetWranglerOptions.disconnectFree = SWOptionsDisconnectFreeCheckButton:GetChecked();
	
	if (SetWranglerOptions.disconnectFree ~= nil) then
		SetWrangler_LoadLocalData();
		-- Disable the preview and link buttons
		SetWranglerPreviewButton:Disable();
		SetWranglerLinkButton:Disable();
		SetWranglerLocalCacheCheckButton:Hide();
	else
		SetWrangler_ClearLocalData();
		SetWranglerPreviewButton:Enable();
		SetWranglerLinkButton:Enable();
		SetWranglerLocalCacheCheckButton:Show();
	end
	---
	HideUIPanel(SWOptionsFrame);
	
	-- refresh the current set
	SetWrangler_LoadSet(gSelectedSet);
end

function SetWrangler_ShowTabNav(show)
	local tabFrame;

	if (show == false) then
		for i=1,SW_NUM_SET_TABS do
			tabFrame = getglobal("SetWranglerSetTabFrameTab"..i);
			tabFrame:Hide();
		end
		
		SetWranglerTabButtonNext:Hide();
		SetWranglerTabButtonBack:Hide();
		SetWranglerTabPageText:Hide();
	else
		SetWrangler_SetTabText(gSelectedClass);
				
		SetWranglerTabButtonNext:Show();
		SetWranglerTabButtonBack:Show();
		SetWranglerTabPageText:Show();
	end
end

function SetWrangler_ShowDropDownNav(show)
	if (show == false) then
		SetWranglerSetDropDown:Hide();
	else
		SetWranglerSetDropDown:Show();
	end
end


function SetWrranglerPreviewModeDropDownOnInit()
	SetWranglerPreviewModeDropDownAdd(SetWranglerPreviewModeDropDownOnSelect);
end

function SetWranglerPreviewModeDropDownAdd(func)
	for i=1,table.getn(SW_TEXT_PREVIEW_OPTIONS) do
		info = {};
		info.text = SW_TEXT_PREVIEW_OPTIONS[i];
		info.func = func;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end
end

function SetWranglerPreviewModeDropDownOnSelect()
	UIDropDownMenu_SetSelectedValue(SWOptionsPreviewModeDropDown, SetWranglerOptions.previewMode);
	UIDropDownMenu_SetText(SW_TEXT_PREVIEW_OPTIONS[this.value],SWOptionsPreviewModeDropDown);
	
	SetWranglerOptions.previewMode = this.value;
end