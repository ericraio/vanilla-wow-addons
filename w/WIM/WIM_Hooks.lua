WIM_ButtonsHooked = false;
WIM_TradeSkillIsHooked = false;
WIM_CraftSkillIsHooked = false;

function WIM_HookTradeSkill()
	if(WIM_TradeSkillIsHooked == true and WIM_CraftSkillIsHooked == true) then
		return;
	end
	
	if(WIM_TradeSkillIsHooked == false and TradeSkillFrame ~= nil) then
		WIM_TradeSkillSkillIcon_OnClick_orig = TradeSkillSkillIcon:GetScript("OnClick");
		TradeSkillSkillIcon:SetScript("OnClick", function() WIM_TradeSkillSkillIcon_OnClick_orig(); WIM_TradeSkillSkillIcon_OnClick(); end);
		
		for i=1, 8 do 
			WIM_TradeSkillReagent_OnClick_orig = getglobal("TradeSkillReagent"..i):GetScript("OnClick");
			getglobal("TradeSkillReagent"..i):SetScript("OnClick", function() WIM_TradeSkillReagent_OnClick_orig(); WIM_TradeSkillReagent_OnClick(); end);
		end
		WIM_TradeSkillIsHooked = true;
	end
	
	if(WIM_CraftSkillIsHooked == false and CraftFrame ~= nil) then
		WIM_CraftIcon_OnClick_orig = CraftIcon:GetScript("OnClick");
		CraftIcon:SetScript("OnClick", function() WIM_CraftIcon_OnClick_orig(); WIM_CraftIcon_OnClick(); end);
		
		for i=1, 8 do 
			WIM_CraftReagent_OnClick_orig = getglobal("CraftReagent"..i):GetScript("OnClick");
			getglobal("CraftReagent"..i):SetScript("OnClick", function() WIM_CraftReagent_OnClick_orig(); WIM_CraftReagent_OnClick(); end);
		end
		
		WIM_CraftSkillIsHooked = true;
	end
end

function WIM_CraftIcon_OnClick(arg1)
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			WIM_EditBoxInFocus:Insert(GetCraftItemLink(GetCraftSelectionIndex()));
		end
	end
end

function WIM_CraftReagent_OnClick(arg1)
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			WIM_EditBoxInFocus:Insert(GetCraftReagentItemLink(GetCraftSelectionIndex(), this:GetID()));
		end
	end
end


function WIM_TradeSkillSkillIcon_OnClick(agr1)
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			WIM_EditBoxInFocus:Insert(GetTradeSkillItemLink(TradeSkillFrame.selectedSkill));
		end
	end
end

function WIM_TradeSkillReagent_OnClick(arg1)
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			WIM_EditBoxInFocus:Insert(GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, this:GetID()));
		end
	end
end


function WIM_PaperDollItemSlotButton_OnClick(arg1)
	if(arg1 == "LeftButton" and IsShiftKeyDown()) then
		if(WIM_EditBoxInFocus) then
			WIM_EditBoxInFocus:Insert(GetInventoryItemLink("player", this:GetID()));
		end
	end
	WIM_PaperDollItemSlotButton_OnClick_orig(arg1);
end

function WIM_FriendsFrame_OnEvent()
  if(event == "WHO_LIST_UPDATE") then
	local numWhos, totalCount = GetNumWhoResults();
	if(numWhos > 0) then
		local name, guild, level, race, class, zone = GetWhoInfo(1);
		if(WIM_Windows[name] and name ~= "" and name ~= nil) then
			if(WIM_Windows[name].waiting_who) then
				WIM_Windows[name].waiting_who = false;
				WIM_Windows[name].class = class;
				WIM_Windows[name].level = level;
				WIM_Windows[name].race = race;
				WIM_Windows[name].guild = guild;
				WIM_SetWhoInfo(name);
				SetWhoToUI(0);
				return;
			end
		end
	end
  end
  WIM_FriendsFrame_OnEvent_orig(event);
end


function WIM_SetItemRef (link, text, button)
	if (WIM_isLinkURL(link)) then
		WIM_DisplayURL(link);
		return;
	end
	if (strsub(link, 1, 6) ~= "player") and ( IsShiftKeyDown() ) and ( not ChatFrameEditBox:IsVisible() ) then
		local itemName = gsub(text, ".*%[(.*)%].*", "%1");
		if(WIM_EditBoxInFocus) then
			WIM_EditBoxInFocus:Insert(text);
		end
	end
end

function WIM_ItemButton_OnClick(button, ignoreModifiers)
	if ( button == "LeftButton" ) and (not ignoreModifiers) and ( IsShiftKeyDown() ) and ( not ChatFrameEditBox:IsVisible() ) and (GameTooltipTextLeft1:GetText()) then
		if(WIM_EditBoxInFocus) then
			WIM_EditBoxInFocus:Insert(GetContainerItemLink(this:GetParent():GetID(), this:GetID()));
		end
	end
end

function WIM_SetUpHooks()
	if(WIM_ButtonsHooked) then
		return;
	end

	--Hook FriendsFrame_OnEvent
	WIM_FriendsFrame_OnEvent_orig = FriendsFrame_OnEvent;
	FriendsFrame_OnEvent = WIM_FriendsFrame_OnEvent;
	
	--Hook ChatFrame_OnEvent
	WIM_ChatFrame_OnEvent_orig = ChatFrame_OnEvent;
	ChatFrame_OnEvent = function(event) if(WIM_ChatFrameSupressor_OnEvent(event)) then WIM_ChatFrame_OnEvent_orig(event); end; end;
	
	--Hook SetItemRef
	WIM_SetItemRef_orig = SetItemRef;
	SetItemRef = function(link, text, button) if(not WIM_isLinkURL(link)) then WIM_SetItemRef_orig(link, text, button); end; WIM_SetItemRef(link, text, button); end;

	--Hook Paper Doll Button
	WIM_PaperDollItemSlotButton_OnClick_orig = PaperDollItemSlotButton_OnClick;
	PaperDollItemSlotButton_OnClick = WIM_PaperDollItemSlotButton_OnClick;
	
	--Hook ContainerFrameItemButton_OnClick
	WIM_ContainerFrameItemButton_OnClick_orig = ContainerFrameItemButton_OnClick;
	ContainerFrameItemButton_OnClick = function(button, ignoreModifiers) WIM_ContainerFrameItemButton_OnClick_orig(button, ignoreModifiers); WIM_ItemButton_OnClick(button, ignoreModifiers); end;
	
	if (AllInOneInventoryFrameItemButton_OnClick) then
		--Hook ContainerFrameItemButton_OnClick
		WIM_AllInOneInventoryFrameItemButton_OnClick_orig = AllInOneInventoryFrameItemButton_OnClick;
		AllInOneInventoryFrameItemButton_OnClick = function(button, ignoreModifiers) WIM_AllInOneInventoryFrameItemButton_OnClick_orig(button, ignoreModifiers); WIM_ItemButton_OnClick(button, ignoreModifiers); end;
	end
	
	if (EngInventory_ItemButton_OnClick) then
		--Hook ContainerFrameItemButton_OnClick
		WIM_EngInventory_ItemButton_OnClick_orig = EngInventory_ItemButton_OnClick;
		EngInventory_ItemButton_OnClick = function(button, ignoreModifiers) WIM_EngInventory_ItemButton_OnClick_orig(button, ignoreModifiers); WIM_ItemButton_OnClick(button, ignoreModifiers); end;
	end
	
	if (BrowseButton) then
		--Hook BrowseButtons
		for i=1, 8 do
			local frame = getglobal("BrowseButton"..i.."Item");
			local oldFunc = frame:GetScript("OnClick");
			frame:SetScript("OnClick", function() oldFunc(); WIM_ItemButton_OnClick(arg1); end);
		end
	end
	WIM_ButtonsHooked = true;
end
