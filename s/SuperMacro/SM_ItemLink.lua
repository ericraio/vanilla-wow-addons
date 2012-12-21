function SuperMacroFrame_InsertText(text)
	if ( SM_VARS.tabShown=="regular" ) then
		SuperMacroFrameText:Insert(text);
	elseif ( SM_VARS.tabShown=="super") then
		SuperMacroFrameSuperText:Insert(text);
	end
end

function SuperMacroFrame_InsertItemText(link)
	if ( not link ) then return end;
	if ( IsAltKeyDown() ) then
		SuperMacroFrame_InsertText(link);
		return 1;
	end
	if ( IsShiftKeyDown() ) then
		local item=ItemLinkToName(link);
		if ( IsControlKeyDown() ) then
			SuperMacroFrame_InsertText('"'..item..'"');
		else
			SuperMacroFrame_InsertText(item);
		end
		return 1;
	end
end

-- Alt = [link]
-- Shift = item name
-- Ctrl-shift ="item name"

local oldContainerFrameItemButton_OnClick = ContainerFrameItemButton_OnClick;
function ContainerFrameItemButton_OnClick(button, ignoreShift)
	if ( button=="LeftButton" and not ignoreShift and SuperMacroFrame:IsVisible() ) then
		local link = GetContainerItemLink(this:GetParent():GetID(), this:GetID());
		if ( not SuperMacroFrame_InsertItemText(link) ) then
			
	oldContainerFrameItemButton_OnClick(button, ignoreShift);
		end
		return;
	end
	oldContainerFrameItemButton_OnClick(button, ignoreShift);
end

local oldPaperDollItemSlotButton_OnClick = PaperDollItemSlotButton_OnClick;
function PaperDollItemSlotButton_OnClick(button, ignoreShift)
	if ( button=="LeftButton" and not ignoreShift and SuperMacroFrame:IsVisible() ) then
		local link = GetInventoryItemLink("player", this:GetID());
		if ( not SuperMacroFrame_InsertItemText(link) ) then
			
	oldPaperDollItemSlotButton_OnClick(button, ignoreShift);
		end
		return;
	end
	oldPaperDollItemSlotButton_OnClick(button, ignoreShift);
end

local oldBagSlotButton_OnClick = BagSlotButton_OnClick;
function BagSlotButton_OnClick()
	if ( arg1=="LeftButton" and SuperMacroFrame:IsVisible() ) then
		this:SetChecked(not this:GetChecked());
		local link = GetInventoryItemLink("player", this:GetID());
		if ( not SuperMacroFrame_InsertItemText(link) ) then
			oldBagSlotButton_OnClick();
		end
		return;
	end
	oldBagSlotButton_OnClick();
end

local oldBagSlotButton_OnShiftClick = BagSlotButton_OnShiftClick;
function BagSlotButton_OnShiftClick()
	if ( SuperMacroFrame:IsVisible() ) then
		this:SetChecked(not this:GetChecked());
		local link = GetInventoryItemLink("player", this:GetID());
		if ( not SuperMacroFrame_InsertItemText(link) ) then
			oldBagSlotButton_OnShiftClick();
		end
		return;
	end
	oldBagSlotButton_OnShiftClick();
end

--Trade skill and craft frames
-- Alt = [link]
-- Ctrl-Alt = all reagent links
-- Shift = item name
-- Ctrl-shift ="item name"

function SM_TradeSkillSkillButton_OnClick(button)
	old_SM_TradeSkillSkillButton_OnClick(button);
	local index = TradeSkillFrame.selectedSkill;
	local link = GetTradeSkillItemLink(index);
	if ( link ) then
		if ( SuperMacroFrame:IsVisible() and IsAltKeyDown() ) then
			if ( IsControlKeyDown() ) then
				for i=1, GetTradeSkillNumReagents(index) do
					local link = GetTradeSkillReagentItemLink(index, i);
					local reagentName, reagentTexture, reagentCount = GetTradeSkillReagentInfo( index, i);
					SuperMacroFrame_InsertText(" "..reagentCount.."x"..link);				
				end
			else
				SuperMacroFrame_InsertText(link);
			end
			return;
		end
		if ( SuperMacroFrame:IsVisible() and IsShiftKeyDown() ) then
			SuperMacroFrame_InsertItemText(link);
		end
		if ( ChatFrameEditBox:IsVisible() and IsShiftKeyDown() ) then
			if ( IsControlKeyDown() ) then
				for i=1, GetTradeSkillNumReagents(index) do
					local link = GetTradeSkillReagentItemLink(index, i);
					local reagentName, reagentTexture, reagentCount = GetTradeSkillReagentInfo( index, i);
					ChatFrameEditBox:Insert(" "..reagentCount.."x"..link);
				end
			else
				ChatFrameEditBox:Insert(link);
			end
			return;
		end
	end
end

function SM_CraftButton_OnClick(button)
	old_SM_CraftButton_OnClick(button);
	local index = GetCraftSelectionIndex();
	local link = GetCraftItemLink(index);
	--[[
	if ( not link ) then
		link = GetCraftInfo(index);
	end
	--]]
	if ( link ) then
		if ( SuperMacroFrame:IsVisible() and IsAltKeyDown() ) then
			if ( IsControlKeyDown() ) then
				for i=1, GetCraftNumReagents(index) do
					local link = GetCraftReagentItemLink(index, i);
					local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo( index, i);
					SuperMacroFrame_InsertText(" "..reagentCount.."x"..link);
				end	
			else
				SuperMacroFrame_InsertText(link);
			end
			return;
		end
		if ( SuperMacroFrame:IsVisible() and IsShiftKeyDown() ) then
			SuperMacroFrame_InsertItemText(link);
		end
		if ( ChatFrameEditBox:IsVisible() and IsShiftKeyDown() ) then
			if ( IsControlKeyDown() ) then
				for i=1, GetCraftNumReagents(index) do
					local link = GetCraftReagentItemLink(index, i);
					local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo( index, i);
					ChatFrameEditBox:Insert(" "..reagentCount.."x"..link);
				end	
			else
				ChatFrameEditBox:Insert(link);
			end
			return;
		end
	end
end

function SM_TradeSkillItem_OnClick()
	local old_SM_TradeSkillReagent_OnClick = TradeSkillReagent1:GetScript("OnClick");
	for i=1, 8 do
		local item = getglobal("TradeSkillReagent"..i);
		item:SetScript("OnClick", function()
			if ( SuperMacroFrame:IsVisible()) then
				local link = GetTradeSkillReagentItemLink( TradeSkillFrame.selectedSkill, this:GetID());
				if ( link ) then
					SuperMacroFrame_InsertItemText(link);
					return;
				end
			end
			if ( old_SM_TradeSkillReagent_OnClick ) then
				old_SM_TradeSkillReagent_OnClick();
			end
		end);
	end
	local old_SM_TradeSkillSkillIcon_OnClick = TradeSkillSkillIcon:GetScript("OnClick");
	TradeSkillSkillIcon:SetScript("OnClick", function()
		local index = TradeSkillFrame.selectedSkill;
		local link = GetTradeSkillItemLink(index);
		if ( link ) then
			if ( SuperMacroFrame:IsVisible() and IsAltKeyDown() ) then
				if ( IsControlKeyDown() ) then
					for i=1, GetTradeSkillNumReagents(index) do
						local link = GetTradeSkillReagentItemLink(index, i);
						local reagentName, reagentTexture, reagentCount = GetTradeSkillReagentInfo( index, i);
						SuperMacroFrame_InsertText(" "..reagentCount.."x"..link);				
					end
				else
					SuperMacroFrame_InsertText(link);
				end
				return;
			end
			local inserted;
			if ( SuperMacroFrame:IsVisible() and IsShiftKeyDown() ) then
				inserted=SuperMacroFrame_InsertItemText(link);
			end
    			if ( ChatFrameEditBox:IsVisible() and IsShiftKeyDown() ) then
    				if ( IsControlKeyDown() ) then
    					for i=1, GetTradeSkillNumReagents(index) do
    						local link = GetTradeSkillReagentItemLink(index, i);
    						local reagentName, reagentTexture, reagentCount = GetTradeSkillReagentInfo( index, i);
    						ChatFrameEditBox:Insert(" "..reagentCount.."x"..link);				
    					end
    				else
    					ChatFrameEditBox:Insert(link);
    				end
    				return;
    			end
			if ( inserted ) then return end;
		end
		if ( old_SM_TradeSkillSkillIcon_OnClick )then
			old_SM_TradeSkillSkillIcon_OnClick();
		end
	end);
end

function SM_CraftItem_OnClick()
	local old_SM_CraftReagent_OnClick = CraftReagent1:GetScript("OnClick");
	for i=1, 8 do
		local item = getglobal("CraftReagent"..i);
		item:SetScript("OnClick", function()
			if ( SuperMacroFrame:IsVisible() ) then
					local link = GetCraftReagentItemLink(GetCraftSelectionIndex(), this:GetID());
					if ( link ) then
						SuperMacroFrame_InsertItemText(link);
						return;
					end
			end
			if ( old_SM_CraftReagent_OnClick ) then
				old_SM_CraftReagent_OnClick();
 			end
		end);
	end
	local old_SM_CraftIcon_OnClick = CraftIcon:GetScript("OnClick");
	CraftIcon:SetScript("OnClick", function()
		local index = GetCraftSelectionIndex();
		local link = GetCraftItemLink(index);
		--[[
			if ( not link ) then
				link = GetCraftInfo(index);
			end
		--]]
		if ( link ) then
			if ( SuperMacroFrame:IsVisible() and IsAltKeyDown() ) then
				if ( IsControlKeyDown() ) then
					for i=1, GetCraftNumReagents(index) do
						local link = GetCraftReagentItemLink(index, i);
						local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo( index, i);
						SuperMacroFrame_InsertText(" "..reagentCount.."x"..link);				
					end
				else
					SuperMacroFrame_InsertText(link);
				end
				return;
			end
			local inserted;
			if ( SuperMacroFrame:IsVisible() and IsShiftKeyDown() ) then
				inserted=SuperMacroFrame_InsertItemText(link);
			end
			if ( ChatFrameEditBox:IsVisible() and IsShiftKeyDown() ) then
				if ( IsControlKeyDown() ) then
					for i=1, GetCraftNumReagents(index) do
						local link = GetCraftReagentItemLink(index, i);
						local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo( index, i);
						ChatFrameEditBox:Insert(" "..reagentCount.."x"..link);
					end	
				else
					ChatFrameEditBox:Insert(link);
				end
				return;
			end
			if ( inserted ) then return end;
		end
		if ( old_SM_CraftIcon_OnClick ) then
			old_SM_CraftIcon_OnClick();
		end
	end);
end

local oldSpellButton_OnClick = SpellButton_OnClick;
function SpellButton_OnClick(drag)
	local id = SpellBook_GetSpellID(this:GetID());
	if ( id > MAX_SPELLS ) then
		return;
	end
	if ( IsShiftKeyDown() and SuperMacroFrame:IsVisible() ) then
		local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
		if ( spellName and not IsSpellPassive(id, SpellBookFrame.bookType) ) then
			if ( subSpellName and (strlen(subSpellName) > 0) ) then
				spellName=spellName.."("..subSpellName..")";
			end
			if ( IsControlKeyDown() ) then
				SuperMacroFrame_InsertText('"'..spellName..'"');
			elseif ( IsAltKeyDown() ) then
				SuperMacroFrame_InsertText(spellName);
			else
				SuperMacroFrame_InsertText("\n"..TEXT(SLASH_CAST1).." "..spellName);
			end
		end
		this:SetChecked(not this:GetChecked());
		return;
	end
	oldSpellButton_OnClick(drag);
end