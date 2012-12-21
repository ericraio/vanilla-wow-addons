-- Constants
TITAN_PANEL_UPDATE_BUTTON = 1;
TITAN_PANEL_UDPATE_TOOLTIP = 2;
TITAN_PANEL_UPDATE_ALL = 3;
TITAN_PANEL_LABEL_SEPARATOR = "  "

TITAN_PANEL_BUTTON_TYPE_TEXT = 1;
TITAN_PANEL_BUTTON_TYPE_ICON = 2;
TITAN_PANEL_BUTTON_TYPE_COMBO = 3;
TITAN_PANEL_BUTTON_TYPE_CUSTOM = 4;

TITAN_RIDER_ID = "Rider";
TITAN_RIDER_FREQUENCY = 1;
TITAN_RIDER_ATTACKBUTTON = 0;

TITAN_RIDER_IS_MOUNTED = false;
TITAN_DOUBLE_CHECK = false;

TITAN_RIDER_LOCALE = {
	menu = "Rider",
	tooltip = "Rider",
	button = "Rider"
};

TITAN_RIDER_HINT = "You are currently: ";
TITAN_RIDER_OPTIONS_SHOWSTATE = "Show player state";
TITAN_RIDER_STATES = {"On foot", "On mount", "In flight", "Sheeped"};
TITAN_RIDER_ITEMS = 3;
TITAN_RIDER_ITEM_NAMES = {nil,"Carrot on a Stick",nil};
TITAN_RIDER_ITEM_DESCS = {"Mithril Spurs",nil,"Minor Mount Speed Increase"};
TITAN_RIDER_ITEM_SLOTS = {"FeetSlot","Trinket0Slot","HandsSlot"}
CURRENTSTATE = TitanGetVar(TITAN_RIDER_ID,"PlayerState");

function TitanPanelRiderButton_OnLoad()
	-- register plugin
	this.registry = { 
		id = TITAN_RIDER_ID,
		menuText = TITAN_RIDER_LOCALE["menu"],
		buttonTextFunction = "TitanPanelRiderButton_GetButtonText",
		tooltipTitle = TITAN_RIDER_LOCALE["tooltip"],
		tooltipTextFunction = "TitanPanelRiderButton_GetTooltipText",
		frequency = TITAN_RIDER_FREQUENCY, 
		icon = "Interface\\AddOns\\Titan\\Artwork\\TitanRider",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = TITAN_NIL,
			ShowState = 1,
			PlayerState = 1,
			RiderItems = {"FeetSlot","Trinket0Slot","HandsSlot"}
		}
	};
	this:RegisterEvent("VARIABLES_LOADED")		-- configuration loading
	this:RegisterEvent("PLAYER_AURAS_CHANGED")	-- mount buff check
	this:RegisterEvent("ACTIONBAR_UPDATE_USABLE")	-- flight path check
	this:RegisterEvent("PLAYER_REGEN_DISABLED")	-- combat check
	this:RegisterEvent("PLAYER_REGEN_ENABLED")	-- combat check
	this:RegisterEvent("DELETE_ITEM_CONFIRM")		-- delete check
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_UNGHOST");
	 
end

function TitanPanelRiderButton_GetButtonText(id)
	local retstr = "";

	-- supports turning off labels
	if (TitanGetVar(TITAN_RIDER_ID, "ShowLabelText")) then	
		retstr = TITAN_RIDER_LOCALE["button"];
		if TitanGetVar(TITAN_RIDER_ID,"ShowState") then
			retstr = retstr .. ": ";
		end
	end

	if TitanGetVar(TITAN_RIDER_ID,"ShowState") then
		if (TitanGetVar(TITAN_RIDER_ID, "ShowColoredText")) then	
			retstr = retstr .. TitanUtils_GetGreenText(TITAN_RIDER_STATES[TitanGetVar(TITAN_RIDER_ID,"PlayerState")]);
		else
			retstr = retstr .. TitanUtils_GetNormalText(TITAN_RIDER_STATES[TitanGetVar(TITAN_RIDER_ID,"PlayerState")]);
		end
	end

	-- This is a double check to ENSURE all riding equipment is removed as there are cases it will skip or miss the equip swap
	local EquipGear = 0;
	if TITAN_RIDER_IS_MOUNTED == false and combat_flag == false and TITAN_DOUBLE_CHECK == true then
		TitanRider_SwitchGear()
	end

	return retstr;
end

function TitanPanelRiderButton_GetTooltipText()
	local retstr = "";
	retstr = retstr .. TitanUtils_GetGreenText(TITAN_RIDER_HINT..TITAN_RIDER_STATES[TitanGetVar(TITAN_RIDER_ID,"PlayerState")]);
	return retstr;
end

function TitanPanelRightClickMenu_PrepareRiderMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_RIDER_ID].menuText);
	
	TitanPanelRightClickMenu_AddSpacer();	

	TitanPanelRightClickMenu_AddToggleIcon(TITAN_RIDER_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_RIDER_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_RIDER_ID);
	
	info = {};
	info.text = TITAN_RIDER_OPTIONS_SHOWSTATE;
	info.func = TitanRider_StateToggle;
	info.value = TITAN_RIDER_OPTIONS_SHOWSTATE;
	info.checked = TitanGetVar(TITAN_RIDER_ID,"ShowState");
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_RIDER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitalPanelRiderButton_OnClick(button)
	if ( button == "LeftButton" ) then
		--Nothing so far
	end
end

function TitanPanelRiderButton_OnEvent()
	if(event == "VARIABLES_LOADED") then
		combat_flag = false;
	end

	if event == "PLAYER_REGEN_DISABLED" then
		combat_flag = true
	end
	  
	if event == "PLAYER_REGEN_ENABLED" then
		combat_flag = false
	end

	if event == "PLAYER_ENTERING_WORLD" then
		combat_flag = false
	end

	if event == "PLAYER_UNGHOST" then
		combat_flag = false
	end

	if combat_flag == false then
		TitanSetVar(TITAN_RIDER_ID,"PlayerState",TitanRider_PlayerMounted());
		if CURRENTSTATE ~= TitanGetVar(TITAN_RIDER_ID,"PlayerState") then
			CURRENTSTATE = TitanGetVar(TITAN_RIDER_ID,"PlayerState");
			TitanRider_SwitchGear();
		end
	end
end

function TitanRider_StateToggle()
	TitanToggleVar(TITAN_RIDER_ID, "ShowState");
end

function TitanRider_PlayerMounted()
	local playerClass = UnitClass("player");
	local onflight = false
	TITAN_DOUBLE_CHECK = false;

	for i = 1,16 do
		local buff_texture = UnitBuff("player", i)
		local debuff_texture = UnitDebuff("player", i)
		if debuff_texture and string.find(debuff_texture, "Polymorph") then
			TITAN_RIDER_IS_MOUNTED = false;
			return 4;
		end
		if playerClass == "Paladin" or playerClass == "Warlock" then
			if buff_texture and string.find(buff_texture, "Spell_Nature_Swiftness") then
				TITAN_RIDER_IS_MOUNTED = true;
				TITAN_DOUBLE_CHECK = true;
				return 2;
			end
		end
		if buff_texture and ( string.find(buff_texture, "Mount") or string.find(buff_texture, "Foot_Kodo") or ( detectedIcon ~= nil and string.find(buff_texture, detectedIcon) ) ) then
			-- Make sure it isn't "Aspect of the xxx" or "Tiger's Fury"
			local BuffName = TitanRider_GetBuffName(i);
			local Skip = false;
			if BuffName and ( string.find(BuffName, "Aspect") or string.find(BuffName, "Aspekt") or string.find(BuffName, "Tiger's Fury") ) then
				Skip = true
			end
			if Skip == false then
				TITAN_RIDER_IS_MOUNTED = true;
				TITAN_DOUBLE_CHECK = true;
				return 2;
			end
		end
	end
	
	onflight = UnitOnTaxi("player")
	if onflight == 1 then
		TITAN_RIDER_IS_MOUNTED = true;
		TITAN_DOUBLE_CHECK = true;
		return 3;
	else
		TITAN_RIDER_IS_MOUNTED = false;
		return 1;
	end
end

function TitanRider_GetBuffName(buffIndex)
	local x, y = GetPlayerBuff(buffIndex, "HELPFUL");
	TitanRiderTooltip:SetUnitBuff("player", buffIndex);
  local Bname = TitanRiderTooltipTextLeft1:GetText();

	if ( Bname ~= nil ) then
		return Bname;
	end
	return nil;
end

function TitanRider_SwitchGear()
	if (TITAN_RIDER_IS_MOUNTED) then
		TitanRider_EquipRidingGear();
	else 
		if (UnitHealth ("player") > 1) then
			TitanRider_RemoveRidingGear();
		end
	end			
end

function TitanRider_EquipRidingGear()
	local EquipGear = 0;
	for EquipGear = 1, TITAN_RIDER_ITEMS do
		--if (TitanGetVarTable(TITAN_RIDER_ID,"RiderItems",EquipGear) == TITAN_RIDER_ITEM_SLOTS[EquipGear] or TitanGetVarTable(TITAN_RIDER_ID,"RiderItems",EquipGear) == "-none-") then
		local bagNum, itemInBagNum = TitanRider_FindInventoryItemWithText(TITAN_RIDER_ITEM_NAMES[EquipGear], TITAN_RIDER_ITEM_DESCS[EquipGear]);

		if (bagNum ~= nil) then
			local newItemLink = GetContainerItemLink (bagNum, itemInBagNum);
			local normalItemLink   = GetInventoryItemLink("player", GetInventorySlotInfo(TITAN_RIDER_ITEM_SLOTS[EquipGear]));
	
			if (normalItemLink ~= nil) then
				local gearBagNum, gearItemInBagNum, tempstr;
	
				_, _, tempstr = string.find (normalItemLink,   "%[(.+)%]");
				TitanSetVarTable(TITAN_RIDER_ID,"RiderItems", EquipGear, tempstr);
			else
				TitanSetVarTable(TITAN_RIDER_ID,"RiderItems", EquipGear, "-none-");
			end
	
			if (CursorHasItem()) then PickupSpell(1, "spell"); end
			PickupContainerItem (bagNum, itemInBagNum);
			AutoEquipCursorItem();
		else
			TitanSetVarTable(TITAN_RIDER_ID,"RiderItems",EquipGear,"-none-");
		end
		--end
	end
end

function TitanRider_RemoveRidingGear()
	local EquipGear = 0;
	for EquipGear = 1, TITAN_RIDER_ITEMS do
		if (TitanGetVarTable(TITAN_RIDER_ID,"RiderItems",EquipGear) ~= TITAN_RIDER_ITEM_SLOTS[EquipGear]) then
			local bagNum, itemInBagNum = TitanRider_FindInventoryItemWithText(TitanGetVarTable(TITAN_RIDER_ID,"RiderItems",EquipGear));

			if (bagNum ~= nil) then
				local normalItemLink = GetContainerItemLink(bagNum, itemInBagNum);
				if (CursorHasItem()) then PickupSpell(1, "spell"); end
				PickupContainerItem (bagNum, itemInBagNum);
				AutoEquipCursorItem();
			end
			local newItemLink = GetInventoryItemLink("player", GetInventorySlotInfo(TITAN_RIDER_ITEM_SLOTS[EquipGear]));
			if newItemLink == normalItemLink then
				TitanSetVarTable(TITAN_RIDER_ID,"RiderItems",EquipGear,TITAN_RIDER_ITEM_SLOTS[EquipGear]);
				TITAN_DOUBLE_CHECK = false;
			end
		end
	end
end

function TitanRider_FindInventoryItemWithText(name, description)
	local bagNum;
	
	for bagNum = 0, 4 do
		local itemInBagNum;
		for itemInBagNum = 1, GetContainerNumSlots (bagNum) do
			local i;
			local text = TitanRider_GetItemName(bagNum, itemInBagNum);
			--Loop through tooltip
			for i = 1, 15, 1 do
				local field = getglobal("TitanRiderTooltipTextLeft" .. i);
				if (field ~= nil) then
					local text = field:GetText();
					if (i == 1) then
						if ((name ~= nil) and (text ~= name)) then
							break;
						else
							if (description == nil) then
								return bagNum, itemInBagNum;
							end
						end
					else
						if (text == description) then
							return bagNum, itemInBagNum;
						end
					end
				end
			end
		end
	end
	return nil;
end

function TitanRider_GetItemName(bag, slot)
	local bagNumber = bag;
	local name = "";
	if ( type(bagNumber) ~= "number" ) then
		bagNumber = tonumber(bag);
	end
	--if (bagNumber <= QM_NIL) then
	--	TitanRiderTooltip:SetInventoryItem("player", slot);
	--else
		TitanRiderTooltip:SetBagItem(bag, slot);
	--end
	name = TitanRiderTooltipTextLeft1:GetText();
	if name == nil then
		name = "";
	end
	return name;
end