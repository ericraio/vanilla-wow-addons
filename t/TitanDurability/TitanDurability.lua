TITAN_DURABILITY_ID = "Durability";
TITAN_DURABILITY_FREQUENCY = 1;

TITAN_DURABILITY_FORMAT = "%d%%";

-- Local variables
TitanDurability_totalRepairCost = 0;
TitanDurability_duraPercent = 0;
TitanDurability_duraCurr = 0;
TitanDurability_duraTotal = 0;
TitanDurability_itemstats = {};

function TitanPanelDurabilityButton_OnLoad()
	_, _, TITAN_DURABILITY_TEXT = string.find(DURABILITY_TEMPLATE, "(.+) %%[^%s]+ / %%[^%s]+")
	TITAN_DURABILITY_TOOLTIP_REPAIR = REPAIR_COST.. "\t";
	TITAN_DURABILITY_TOOLTIP_DURA = TITAN_DURABILITY_TEXT.. ":\t"
	TITAN_DURABILITY_LABEL = TITAN_DURABILITY_TEXT.. ": ";

	this.registry = { 
		id = TITAN_DURABILITY_ID,
		menuText = TITAN_DURABILITY_TEXT, 
		buttonTextFunction = "TitanPanelDurabilityButton_GetButtonText", 
		tooltipTitle = TITAN_DURABILITY_TEXT,
		tooltipTextFunction = "TitanPanelDurabilityButton_GetTooltipText", 
		frequency = TITAN_DURABILITY_FREQUENCY, 
		icon = "Interface\\Icons\\Trade_BlackSmithing.blp";	
		iconWidth = 16,		 
		savedVariables = {
			ShowLabelText = 1,
			ShowColoredText = 1,
			ShowIcon = 1,			
			iteminfo = 0,
			hideguy = 0,
		}
	};
	
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
end

function TitanPanelDurabilityButton_GetButtonText(id)
	if (not TitanDurability_duraPercent) then
		return TITAN_DURABILITY_NUDE;
	end
	if ( TitanGetVar(TITAN_DURABILITY_ID, "ShowColoredText") ) then	
		duraRichText = TitanPanelDurability_GetColoredText(TitanDurability_duraPercent);
	else
		local duraText = format(TITAN_DURABILITY_FORMAT,TitanDurability_duraPercent);
		duraRichText = TitanUtils_GetHighlightText(duraText);
	end
	
	return TITAN_DURABILITY_LABEL,duraRichText;
end

function TitanPanelDurabilityButton_GetTooltipText()
	local retstr = "\n";
	if (not TitanDurability_duraPercent) then
		retstr = retstr.. TITAN_DURABILITY_TOOLTIP_DURA.. GSC_NONE.. "\n";
	else	
		retstr = retstr.. TITAN_DURABILITY_TOOLTIP_DURA.. TitanPanelDurability_GetColoredText(TitanDurability_duraPercent).. "\n";
	end
	retstr = retstr.. TITAN_DURABILITY_TOOLTIP_REPAIR.. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost);
	
	if (TitanGetVar(TITAN_DURABILITY_ID, "iteminfo")) then
		local slots = {
			{"Head", HEADSLOT},
			{"Shoulder", SHOULDERSLOT},
			{"Chest", CHESTSLOT},
			{"Wrist", WRISTSLOT},
			{"Hands", HANDSSLOT},		
			{"Waist", WAISTSLOT},
			{"Legs", LEGSSLOT},
			{"Feet", FEETSLOT},
			{"MainHand", MAINHANDSLOT},
			{"SecondaryHand", SECONDARYHANDSLOT},
			{"Ranged", RANGEDSLOT},
		};

		retstr = retstr.. "\n";	
		for i,arr in slots do
			local stats = TitanDurability_itemstats[arr[1]]
			if (stats) then
				if (stats[1] == GSC_NONE) then
					retstr = retstr.. "\n".. arr[2]..":\t".. stats[1];
				else
					if ( TitanGetVar(TITAN_DURABILITY_ID, "ShowColoredText") ) then	
						retstr = retstr.. "\n".. arr[2]..":\t".. TitanPanelDurability_GetColoredText(stats[1]);
					else
						local duraText = TitanUtils_GetHighlightText(format(TITAN_DURABILITY_FORMAT,stats[1]));
						retstr = retstr.. "\n".. arr[2]..":\t".. duraText;
					end
				end
			end
		end
		retstr = retstr.. "\n";	
		for i,arr in slots do
			cost = TitanDurability_itemstats[arr[1]][2];
			if (cost ~= GSC_NONE) then
				retstr = retstr.. "\n".. arr[2]..":\t".. cost;
			end
		end
	end
	
	return retstr;
end

function TitanPanelDurabilityButton_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") 
		or (event == "UPDATE_INVENTORY_ALERTS") 
		then
		TitanPanelDurability_CalcValues();
	end
end

function TitanPanelRightClickMenu_PrepareDurabilityMenu()
	local id = "Durability";
	local info = {};

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_DURABILITY_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();		

	info = {};
	info.text = TITAN_DURABILITY_MENU_ITEMS;
	info.value = "iteminfo";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "iteminfo");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_DURABILITY_MENU_GUY;
	info.value = "hideguy";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "hideguy");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddToggleIcon(TITAN_DURABILITY_ID);	
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_DURABILITY_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_DURABILITY_ID);	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelDurability_Toggle()
	TitanToggleVar(TITAN_DURABILITY_ID, this.value);
	TitanPanelButton_UpdateButton(TITAN_DURABILITY_ID);
	
	if (this.value == "hideguy") then TitanPanelDurability_CalcValues(); end
end

function TitanPanelDurability_CalcValues()
	-- hide Durability "guy"
	if (TitanGetVar(TITAN_DURABILITY_ID, "hideguy")) then
		if (DurabilityFrame:IsVisible()) then
			DurabilityFrame:Hide();
		end
	end

	local slotnames = {
		"Head",
		"Shoulder",
		"Chest",
		"Wrist",
		"Hands",		
		"Waist",
		"Legs",
		"Feet",
		"MainHand",
		"SecondaryHand",
		"Ranged",
	};
	
	local id, hasItem, repairCost;
	local itemName, durability, tmpText, midpt, lval, rval;

	TitanDurability_totalRepairCost = 0;
	TitanDurability_duraPercent = 0;
	TitanDurability_duraCurr = 0;
	TitanDurability_duraTotal = 0;

	for i,slotName in slotnames do
		id, _ = GetInventorySlotInfo(slotName.. "Slot");
		TPDurTooltip:Hide()
		TPDurTooltip:SetOwner(this, "ANCHOR_LEFT");
		hasItem, _, repairCost = TPDurTooltip:SetInventoryItem("player", id);

		if ( not hasItem ) then
			TPDurTooltip:ClearLines()
		else 
			itemName = TPDurTooltipTextLeft1:GetText(); 
	
			--Search for durability line
			for i=2, 15, 1 do
				tmpText = getglobal("TPDurTooltipTextLeft"..i);
				lval = nil;
				rval = nil;
				if (tmpText:GetText()) then
					
					local searchstr = string.gsub(DURABILITY_TEMPLATE, "%%d", "(.+)")
					_, _, lval, rval = string.find(tmpText:GetText(), searchstr);
				end
				if (lval and rval) then	break; end
			end
		end
		if (lval and rval) then
			local currpercent;
			if (rval == 0) then
				currpercent = GSC_NONE;
			else
				currpercent = math.floor(lval / rval * 100);
			end
			TitanDurability_itemstats[slotName] = {currpercent, TitanPanelDurability_GetTextGSC(repairCost)};
			TitanDurability_duraCurr = TitanDurability_duraCurr + lval;
			TitanDurability_duraTotal = TitanDurability_duraTotal + rval;
			TitanDurability_totalRepairCost = TitanDurability_totalRepairCost + repairCost
			lval = 0;
			rval = 0;
		else
			TitanDurability_itemstats[slotName] = {GSC_NONE, GSC_NONE};
		end
	end
	TPDurTooltip:Hide()
	if (TitanDurability_duraTotal == 0) then
		TitanDurability_duraPercent = nil
	else
		TitanDurability_duraPercent = math.floor(TitanDurability_duraCurr / TitanDurability_duraTotal * 100);
	end
end

-------------------------------------------------------------------------------
-- Gold formatting code, shamelessly "borrowed" from Auctioneer
-------------------------------------------------------------------------------

function TitanPanelDurability_GetGSC(money)
	local neg = false;
	if (money == nil) then money = 0; end
	if (money < 0) then 
		neg = true;
		money = money * -1;
	end
	local g = math.floor(money / 10000);
	local s = math.floor((money - (g*10000)) / 100);
	local c = math.floor(money - (g*10000) - (s*100));
	return g,s,c,neg;
end

GSC_GOLD="ffd100";
GSC_SILVER="e6e6e6";
GSC_COPPER="c8602c";
GSC_START="|cff%s%d|r";
GSC_PART=".|cff%s%02d|r";
GSC_NONE="|cffa0a0a0"..NONE.."|r";

function TitanPanelDurability_GetTextGSC(money)
	local g, s, c, neg = TitanPanelDurability_GetGSC(money);
	local gsc = "";
	if (g > 0) then
		gsc = format(GSC_START, GSC_GOLD, g);
		gsc = gsc..format(GSC_PART, GSC_SILVER, s);
		gsc = gsc..format(GSC_PART, GSC_COPPER, c);
	elseif (s > 0) then
		gsc = format(GSC_START, GSC_SILVER, s);
		if (c > 0) then
			gsc = gsc..format(GSC_PART, GSC_COPPER, c);
		end
	elseif (c > 0) then
		gsc = gsc..format(GSC_START, GSC_COPPER, c);
	else
		gsc = GSC_NONE;
	end
	
	if (neg) then gsc = "(".. gsc.. ")"; end

	return gsc;
end

function TitanPanelDurability_GetColoredText(percent)
	local green = GREEN_FONT_COLOR;		-- 0.1, 1.00, 0.1
	local yellow = NORMAL_FONT_COLOR;	-- 1.0, 0.82, 0.0
	local red = RED_FONT_COLOR;				-- 1.0, 0.10, 0.1
	
	percent = percent / 100;
	local color = {};
	
	if (percent == 1.0) then
		color = green;
	elseif (percent == 0.5) then
		color = yellow;
	elseif (percent == 0.0) then
		color = red;
	elseif (percent > 0.5) then
		local pct = (1.0 - percent) * 2;
		color.r =(yellow.r - green.r)*pct + green.r;
		color.g = (yellow.g - green.g)*pct + green.g;
		color.b = (yellow.b - green.b)*pct + green.b;
	elseif (percent < 0.5) then
		local pct = (0.5 - percent) * 2;
		color.r = (red.r - yellow.r)*pct + yellow.r;
		color.g = (red.g - yellow.g)*pct + yellow.g;
		color.b = (red.b - yellow.b)*pct + yellow.b;
	end
	
	local txt = format(TITAN_DURABILITY_FORMAT,percent*100);	
	local colortxt = TitanUtils_GetColoredText(txt, color);

	return colortxt;
end
