
-- Title: TitanRepair v0.2
-- Notes: Adds Durability Info to Titan Panel, also reminds you to repair
-- Author: lua@lumpn.de

TITAN_REPAIR_ID = "Repair";

REPAIR_INDEX = 0;
REPAIR_MONEY = 0;
REPAIR_ITEM_STATUS = {};
REPAIR_ITEM_STATUS[1] = { val = 0, max = 0, cost = 0, name = INVTYPE_HEAD, slot = "Head" };
REPAIR_ITEM_STATUS[2] = { val = 0, max = 0, cost = 0, name = INVTYPE_SHOULDER, slot = "Shoulder" };
REPAIR_ITEM_STATUS[3] = { val = 0, max = 0, cost = 0, name = INVTYPE_CHEST, slot = "Chest" };
REPAIR_ITEM_STATUS[4] = { val = 0, max = 0, cost = 0, name = INVTYPE_WAIST, slot = "Waist" };
REPAIR_ITEM_STATUS[5] = { val = 0, max = 0, cost = 0, name = INVTYPE_LEGS, slot = "Legs" };
REPAIR_ITEM_STATUS[6] = { val = 0, max = 0, cost = 0, name = INVTYPE_FEET, slot = "Feet" };
REPAIR_ITEM_STATUS[7] = { val = 0, max = 0, cost = 0, name = INVTYPE_WRIST, slot = "Wrist" };
REPAIR_ITEM_STATUS[8] = { val = 0, max = 0, cost = 0, name = INVTYPE_HAND, slot = "Hands" };
REPAIR_ITEM_STATUS[9] = { val = 0, max = 0, cost = 0, name = INVTYPE_WEAPONMAINHAND, slot = "MainHand" };
REPAIR_ITEM_STATUS[10] = { val = 0, max = 0, cost = 0, name = INVTYPE_WEAPONOFFHAND, slot = "SecondaryHand" };
REPAIR_ITEM_STATUS[11] = { val = 0, max = 0, cost = 0, name = INVTYPE_RANGED, slot = "Ranged" };
REPAIR_ITEM_STATUS[12] = { val = 0, max = 0, cost = 0, name = INVENTORY_TOOLTIP };


StaticPopupDialogs["REPAIR_CONFIRMATION"] = {
	text = TEXT(REPAIR_LOCALE["confirmation"]),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		TitanRepair_RepairItems();
	end,
	OnShow = function()
		MoneyFrame_Update(this:GetName().."MoneyFrame", REPAIR_MONEY);
	end,	
	hasMoneyFrame = 1,
	timeout = 0,
};


function TitanPanelRepairButton_OnLoad()
	-- register plugin
	this.registry = { 
		id = TITAN_REPAIR_ID,
		builtIn = 1,
		version = "0.3.1800",
		menuText = REPAIR_LOCALE["menu"],
		buttonTextFunction = "TitanPanelRepairButton_GetButtonText",
		tooltipTitle = REPAIR_LOCALE["tooltip"],
		tooltipTextFunction = "TitanPanelRepairButton_GetTooltipText",
		icon = "Interface\\AddOns\\Titan\\Artwork\\TitanRepair",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowItemName = TITAN_NIL,
			ShowUndamaged = TITAN_NIL,
			ShowPopup = TITAN_NIL,
			ShowPercentage = TITAN_NIL,
			ShowColoredText = TITAN_NIL,
			RepairInventory = TITAN_NIL
		}
	};

	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_CLOSED");
end


function TitanPanelRepairButton_OnEvent()
	if (event == "MERCHANT_SHOW") then
		if TitanGetVar(TITAN_REPAIR_ID,"ShowPopup") == 1 then
			local repairCost, canRepair = GetRepairAllCost();
			if (canRepair) then
				if (TitanGetVar(TITAN_REPAIR_ID, "RepairInventory")) then
					repairCost = repairCost + TitanRepair_GetRepairInvCost();
				end
				if (repairCost > 0) then
					REPAIR_MONEY = repairCost;
					StaticPopup_Show("REPAIR_CONFIRMATION");
				end
			end
		end
	end
	
	if ( event == "MERCHANT_CLOSED" ) then
		StaticPopup_Hide("REPAIR_CONFIRMATION");
	end

	if ( event == "UPDATE_INVENTORY_ALERTS" ) then
		local min_status = 1.0;
		local min_val = 0;
		local min_max = 0;
		local min_index = 0;
		
		for index, value in INVENTORY_ALERT_STATUS_SLOTS do
	
			local act_status, act_val, act_max, act_cost = TitanRepair_GetStatus(index);
			if ( act_status < min_status ) then
				min_status = act_status;
				min_val = act_val;
				min_max = act_max;
				min_index = index;
			end
	
			REPAIR_ITEM_STATUS[index].val = act_val;
			REPAIR_ITEM_STATUS[index].max = act_max;
			REPAIR_ITEM_STATUS[index].cost = act_cost;
	
		end
	
		REPAIR_INDEX = min_index;
	
		TitanPanelButton_UpdateButton(TITAN_REPAIR_ID);
		TitanPanelButton_UpdateTooltip();
	end

	if (event == "BAG_UPDATE") then
		
		local min_status = 1.0;
		local min_val = 0;
		local min_max = 0;
		
		REPAIR_ITEM_STATUS[12].cost = 0;
		
		for bag = 0, 4 do	
			for slot = 1, GetContainerNumSlots(bag) do
		
				local act_status, act_val, act_max, act_cost = TitanRepair_GetStatus(slot, bag);
				if (act_status < min_status) then
					min_status = act_status;
					min_val = act_val;
					min_max = act_max;
					
					if((REPAIR_INDEX > 0) and (act_status < TitanRepair_GetStatusPercent(REPAIR_ITEM_STATUS[REPAIR_INDEX].val, REPAIR_ITEM_STATUS[REPAIR_INDEX].max))) then
						REPAIR_INDEX = 12;
					end

					REPAIR_ITEM_STATUS[12].val = act_val;
					REPAIR_ITEM_STATUS[12].max = act_max;
				end
				REPAIR_ITEM_STATUS[12].cost = REPAIR_ITEM_STATUS[12].cost + act_cost;
			end
		end
		
		TitanPanelButton_UpdateButton(TITAN_REPAIR_ID);
		TitanPanelButton_UpdateTooltip();
	end
end

function TitanRepair_GetStatusPercent(val, max)

	if (max > 0) then
		return (val / max);
	end
	
	return 1.0;
	
end;


function TitanRepair_GetStatus(index, bag)

	local val = 0;
	local max = 0;
	local cost = 0;
	
	local hasItem, repairCost
	if (bag) then
		local _, lRepairCost = TRTooltip:SetBagItem(bag, index);
		repairCost = lRepairCost;
		hasItem = 1;
	else
		local slotName = REPAIR_ITEM_STATUS[index].slot .. "Slot";

		local id = GetInventorySlotInfo(slotName);
		local lHasItem, _, lRepairCost = TRTooltip:SetInventoryItem("player", id);
		hasItem = lHasItem;
		repairCost = lRepairCost;
	end
	
	TRTooltip:Hide();
	
	if (hasItem) then
		
		if (repairCost) then
			cost = repairCost;
		end

		for i = 1, 30 do
			local text = getglobal("TRTooltipTextLeft" .. i):GetText();
			if (text) then
				
				-- find durability
				local _, _, f_val, f_max = string.find(text, REPAIR_LOCALE["pattern"]);
				if (f_val) then
					val = tonumber(f_val);
					max = tonumber(f_max);
				end
				
			end
			
		end
		
	end
	
	return TitanRepair_GetStatusPercent(val, max), val, max, cost;
	
end


function TitanRepair_GetStatusStr(index, short)

	-- skip if fully repaired
	if (index == 0) then
		return TitanUtils_GetHighlightText("100%");
	end
	
	local valueText = "";
	local item_status = REPAIR_ITEM_STATUS[index];
	local item_frac = TitanRepair_GetStatusPercent(item_status.val, item_status.max);
	
	-- skip if empty slot
	if (item_status.max == 0) then
		return nil;
	end
	
	-- percent or value
	if (TitanGetVar(TITAN_REPAIR_ID,"ShowPercentage") or short) then
		valueText = string.format("%d%%", item_frac * 100);
	else
		valueText = string.format("%d / %d", item_status.val, item_status.max);	
	end

	-- color
	if (TitanGetVar(TITAN_REPAIR_ID, "ShowColoredText")) then
		if (item_frac == 0.0) then
			valueText = TitanUtils_GetRedText(valueText);
		elseif (item_frac < 0.2) then
			valueText = TitanUtils_GetNormalText(valueText);
		elseif (item_frac < 0.9) then 
			valueText = TitanUtils_GetGreenText(valueText);
		else
			valueText = TitanUtils_GetHighlightText(valueText);
		end
	else
		valueText = TitanUtils_GetHighlightText(valueText);
	end
	
	-- name
	if (not short or TitanGetVar(TITAN_REPAIR_ID, "ShowItemName")) then
		valueText = valueText .. " " .. item_status.name;
	end
	
	-- add repair cost
	local item_cost = TitanRepair_GetCostStr(item_status.cost);
	if (not short and item_cost) then
		valueText = valueText .. "\t" .. item_cost;
	end
	
	return valueText;
	
end


function TitanRepair_GetCostStr(cost)

	if (cost > 0) then
		return TitanUtils_GetHighlightText(format("%.2fg", cost / 10000));
	end
	
	return nil;
	
end


function TitanPanelRepairButton_GetButtonText(id)
	
	-- supports turning off labels
	return REPAIR_LOCALE["button"], TitanRepair_GetStatusStr(REPAIR_INDEX, 1);
end


function TitanPanelRepairButton_GetTooltipText()

	local out = "";
	local cost = 0;
	local sum = 0;
	
	for i = 1, table.getn(REPAIR_ITEM_STATUS) do
		local str = TitanRepair_GetStatusStr(i);
		cost = REPAIR_ITEM_STATUS[i].cost;
		sum = sum + cost;
		
		if ((str) and (TitanGetVar(TITAN_REPAIR_ID,"ShowUndamaged") or (cost > 0))) then
			out = out .. str .. "\n";
		end
	end
	
	if (sum > 0) then
		local costStr = TitanRepair_GetCostStr(sum);
		if (costStr) then
			out = out .. "\n" .. REPAIR_COST .. " " .. costStr;
		end
	else
		out = out .. "\n" .. REPAIR_LOCALE["nothing"];
	end
	
	return out;
	
end


function TitanPanelRightClickMenu_PrepareRepairMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_REPAIR_ID].menuText);
	
	local info = {};
	info.text = REPAIR_LOCALE["percentage"];
	info.func = TitanRepair_ShowPercentage;
	info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowPercentage");
	UIDropDownMenu_AddButton(info);

	local info = {};
	info.text = REPAIR_LOCALE["itemname"];
	info.func = TitanRepair_ShowItemName;
	info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowItemName");
	UIDropDownMenu_AddButton(info);

	local info = {};
	info.text = REPAIR_LOCALE["undamaged"];
	info.func = TitanRepair_ShowUndamaged;
	info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowUndamaged");
	UIDropDownMenu_AddButton(info);

	local info = {};
	info.text = REPAIR_LOCALE["popup"];
	info.func = TitanRepair_ShowPop;
	info.checked = TitanGetVar(TITAN_REPAIR_ID,"ShowPopup");
	UIDropDownMenu_AddButton(info);

	local info = {};
	info.text = REPAIR_LOCALE["repinventory"];
	info.func = TitanRepair_RepairInventory;
	info.checked = TitanGetVar(TITAN_REPAIR_ID,"RepairInventory");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_REPAIR_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_REPAIR_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_REPAIR_ID);
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_REPAIR_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end


function TitanRepair_ShowPercentage()
	TitanToggleVar(TITAN_REPAIR_ID, "ShowPercentage");
	TitanPanelButton_UpdateButton(TITAN_REPAIR_ID);
end


function TitanRepair_ShowItemName()
	TitanToggleVar(TITAN_REPAIR_ID, "ShowItemName");
	TitanPanelButton_UpdateButton(TITAN_REPAIR_ID);
end


function TitanRepair_ShowUndamaged()
	TitanToggleVar(TITAN_REPAIR_ID, "ShowUndamaged");
end

function TitanRepair_ShowPop()
	TitanToggleVar(TITAN_REPAIR_ID, "ShowPopup");
end

function TitanRepair_RepairInventory()
	TitanToggleVar(TITAN_REPAIR_ID, "RepairInventory");
end

function TitanRepair_RepairItems()
	RepairAllItems();

	if (not TitanGetVar(TITAN_REPAIR_ID, "RepairInventory")) then
		return;
	end
	
	ShowRepairCursor();
	local bag, slot
	for bag = 0, 4 do	
		for slot = 1, GetContainerNumSlots(bag) do
			local _, repairCost = TRTooltip:SetBagItem(bag, slot);
			if (repairCost and (repairCost > 0)) then
				UseContainerItem(bag,slot);
			end
		end
	end
	HideRepairCursor();
end


function TitanRepair_GetRepairInvCost()

	local result = 0;
	for bag = 0, 4 do	
		for slot = 1, GetContainerNumSlots(bag) do
			local _, repairCost = TRTooltip:SetBagItem(bag, slot);
			if (repairCost and (repairCost > 0)) then
				result = result + repairCost;
			end
		end
	end
	TRTooltip:Hide();
	
	return result;
end