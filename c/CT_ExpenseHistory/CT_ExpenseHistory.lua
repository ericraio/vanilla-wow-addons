tinsert(UISpecialFrames, "CT_ExpenseHistoryFrame");
CT_EH_History = { };
CT_EH_DISPLAYTHRESHOLD = 100; -- 1 Silver
CT_EH_NUMCLASSPILES = 8;
CT_EH_Version = 1.2;
CT_EH_LogSort = {
	["curr"] = 1,
	["way"] = 1 -- Desc
};

function CT_EH_Sort(t1, t2)
	if ( t1 and t2 ) then
		return t1[1] >= t2[1]
	end
end

function CT_EH_SortLogBy(id)
	if ( CT_EH_LogSort["curr"] == id ) then
		CT_EH_LogSort["way"] = abs(CT_EH_LogSort["way"]-1);
	else
		CT_EH_LogSort["curr"] = id;
		CT_EH_LogSort["way"] = 1;
	end
	CT_EH_UpdateLog();
end
function CT_EH_UpdateSummary()
	local _, _, currPlayer, currServer = string.find( CT_ExpenseHistoryFrame.currPlayer or "", "^(.+)@(.+)$");
	if ( currPlayer ) then
		currPlayer = currPlayer .. " @ " .. currServer;
	end
	UIDropDownMenu_SetSelectedName(CT_ExpenseHistoryFrameDropDown, ( currPlayer or CT_EH_ALLCHARACTERS ) );
	UIDropDownMenu_SetWidth(200, CT_ExpenseHistoryFrameDropDown);
	CT_ExpenseHistoryFrameDropDownText:SetText(( currPlayer or CT_EH_ALLCHARACTERS ));
	CT_ExpenseHistoryFrameRecordingText:SetText(format(CT_EH_RECORDINGFROM, date("%m/%d/%Y", CT_EH_History["startUsage"])));
	
	local classCoords = {
		["WARRIOR"]	= {0, 0.25, 0, 0.25},
		["MAGE"]	= {0.25, 0.49609375, 0, 0.25},
		["ROGUE"]	= {0.49609375, 0.7421875, 0, 0.25},
		["DRUID"]	= {0.7421875, 0.98828125, 0, 0.25},
		["HUNTER"]	= {0, 0.25, 0.25, 0.5},
		["SHAMAN"]	= {0.25, 0.49609375, 0.25, 0.5},
		["PRIEST"]	= {0.49609375, 0.7421875, 0.25, 0.5},
		["WARLOCK"]	= {0.7421875, 0.98828125, 0.25, 0.5},
		["PALADIN"]	= {0, 0.25, 0.5, 0.75}
	};
	local costsTable, totalRepair, numRepairs, totalFlight, totalReagent, totalAmmo, totalMail, totalCost, highCost = CT_EH_GetStats(CT_ExpenseHistoryFrame.currPlayer);
	local allCostsTable, _, _, _, _, _, _, _, allHighCost = CT_EH_GetStats(nil);
	table.sort(
		allCostsTable,
		function(a1, a2)
			if ( a1 and a2 ) then
				return a1[1] > a2[1];
			end
		end
	);
	
	-- Summaries
	local numDays = ( time() - CT_EH_History["startUsage"] ) / (24*3600);
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryAverageRepairMoney", floor(totalRepair/numRepairs+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryAvgExpensesPerDayMoney", floor(totalCost/numDays+0.5) );
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryTotalCostMoney", floor(totalCost+0.5));
	
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryAvgExpensesFlightsMoney", floor(totalFlight/numDays+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryAvgExpensesRepairsMoney", floor(totalRepair/numDays+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryAvgExpensesReagentsMoney", floor(totalReagent/numDays+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryAvgExpensesAmmoMoney", floor(totalAmmo/numDays+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryAvgExpensesMailMoney", floor(totalMail/numDays+0.5));
	
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryTotalCostFlightsMoney", floor(totalFlight+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryTotalCostRepairsMoney", floor(totalRepair+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryTotalCostReagentsMoney", floor(totalReagent+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryTotalCostAmmoMoney", floor(totalAmmo+0.5));
	MoneyFrame_Update("CT_ExpenseHistoryFrameSummaryTotalCostMailMoney", floor(totalMail+0.5));
	
	local i = 0;
	CT_ExpenseHistoryFrame.numPiles = 0;
	for playerIndex, val in allCostsTable do
		if ( val[1] >= CT_EH_DISPLAYTHRESHOLD ) then
			i = i + 1;
			if ( i <= CT_EH_NUMCLASSPILES ) then
				local v, formattedCost, class, playerName = val[1], val[2], val[3], val[4];
				local height = 120*(v/allHighCost);
				if ( height < 2 ) then
					height = 2; -- So we can at least see the bar
				end
				CT_ExpenseHistoryFrame.numPiles = i;
				getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i).name = playerName;
				getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i):Show();
				if ( not CT_ExpenseHistoryFrame.isAnimated ) then
					getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "Pile"):SetHeight(height);
				end
				getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "Pile").goalHeight = height;
				getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "PileNumber"):SetText(formattedCost);
				getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "Texture"):SetTexCoord(classCoords[class][1], classCoords[class][2], classCoords[class][3], classCoords[class][4]);
				getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "PileBackground"):SetVertexColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b);
			end
		end
	end
	for i = i+1, CT_EH_NUMCLASSPILES, 1 do
		getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i):Hide();
	end
end

function CT_EH_UpdateLog()
	local entries = { };
	for k, v in CT_EH_History do
		if ( type(v) == "table" ) then
			for key, val in v do
				if ( type(val) == "table" ) then
					tinsert(entries, { val[3], k, val[2], val[1] });
				end
			end
		end
	end
	table.sort(
		entries,
		function(a1, a2)
			if ( a1 and a2 ) then
				if ( CT_EH_LogSort["way"] == 1 ) then
					if ( a1[CT_EH_LogSort["curr"]] == a2[CT_EH_LogSort["curr"]] ) then
						return a1[1] > a2[1];
					else
						return a1[CT_EH_LogSort["curr"]] > a2[CT_EH_LogSort["curr"]];
					end
				else
					if ( a1[CT_EH_LogSort["curr"]] == a2[CT_EH_LogSort["curr"]] ) then
						return a1[1] < a2[1];
					else
						return a1[CT_EH_LogSort["curr"]] < a2[CT_EH_LogSort["curr"]];
					end
				end
			end
		end
	);
	local numEntries = getn(entries);
	FauxScrollFrame_Update(CT_ExpenseHistoryFrameLogScrollFrame, numEntries, 22, 20);
	for i=1, 22, 1 do
		local line = getglobal("CT_ExpenseHistoryFrameLogLine" .. i);
		local dateText = getglobal("CT_ExpenseHistoryFrameLogLine" .. i .. "Date");
		local charText = getglobal("CT_ExpenseHistoryFrameLogLine" .. i .. "Char");
		local typeText = getglobal("CT_ExpenseHistoryFrameLogLine" .. i .. "Type");
		local costFrameName = "CT_ExpenseHistoryFrameLogLine" .. i .. "Cost";

		local index = i + FauxScrollFrame_GetOffset(CT_ExpenseHistoryFrameLogScrollFrame); 
		if ( index <= numEntries ) then
			local iStart, iEnd, charName, serverName = string.find(entries[index][2], "^(.+)@(.+)$");
			if ( strlen(charName)+strlen(serverName) > 16 ) then
				-- We have to cut it down
				if ( strlen(serverName) < 8 ) then
					charName = strsub(charName, 0, 16-strlen(serverName));
				elseif ( strlen(charName) < 8 ) then
					serverName = strsub(serverName, 0, 16-strlen(charName));
				else
					charName = strsub(charName, 0, 8);
					serverName = strsub(serverName, 0, 8);
				end
			end
			line:Show();
			dateText:SetText(date("%m/%d/%y", entries[index][1]));
			charText:SetText(charName .. "@" .. serverName);
			typeText:SetText(entries[index][3]);
			MoneyFrame_Update(costFrameName, entries[index][4]);
		else
			line:Hide();
		end
	end
end

function CT_EH_GetStats(player)
	local classFileNames = {
		[CT_EH_WARRIOR] = "WARRIOR",
		[CT_EH_MAGE] = "MAGE",
		[CT_EH_ROGUE] = "ROGUE",
		[CT_EH_DRUID] = "DRUID",
		[CT_EH_HUNTER] = "HUNTER",
		[CT_EH_SHAMAN] = "SHAMAN",
		[CT_EH_PRIEST] = "PRIEST",
		[CT_EH_WARLOCK] = "WARLOCK",
		[CT_EH_PALADIN] = "PALADIN"
	};
	local costs, totalRepair, numRepair, totalFlight, totalReagents, totalAmmo, totalMail, totalCost, highCost = { }, 0, 0, 0, 0, 0, 0, 0, 0;
	for key, tbl in CT_EH_History do
		if ( ( key == player or not player ) and type(tbl) == "table" ) then
			local total, totalRep, numRep, totalFli, totalReg, totalAmm, totalMai = CT_EH_GetMoney(key);
			local _, _, playerName, server = string.find(key, "^(.+)@(.+)$");
			local formattedCost;
			if ( total < 100 ) then
				formattedCost = total .. "c";
			elseif ( total < (100*100) ) then
				formattedCost = floor(total/100) .. "s";
			else
				formattedCost = floor(total/(100*100)) .. "g";
			end
			if ( ( total or 0 ) > highCost ) then
				highCost = total;
			end
			totalRepair = totalRepair + totalRep;
			numRepair = numRepair + numRep;
			totalFlight = totalFlight + totalFli;
			totalReagents = totalReagents + totalReg;
			totalAmmo = totalAmmo + totalAmm;
			totalMail = totalMail + totalMai;
			totalCost = totalCost + total;
			tinsert(costs, { total, formattedCost, classFileNames[CT_EH_History[key].class], playerName .. " @ " .. server });
		end
	end
	return costs, totalRepair, numRepair, totalFlight, totalReagents, totalAmmo, totalMail, totalCost, highCost;
end

function CT_EH_StartAnimate()
	for i = 1, CT_ExpenseHistoryFrame.numPiles, 1 do
		local pile = getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "Pile");
		if ( pile:GetParent():IsVisible() ) then
			CT_ExpenseHistoryFrame.isAnimated = 1;
			getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "Pile"):SetHeight(0);
		end
	end
end

function CT_EH_ProcessAnimation(elapsed)
	this.elapsed = this.elapsed - elapsed;
	if ( this.elapsed <= 0 ) then
		if ( this.isAnimated ) then
			local keepAnimating = false;
			for i = 1, CT_ExpenseHistoryFrame.numPiles, 1 do
				local pile = getglobal("CT_ExpenseHistoryFrameSummaryDiagramClass" .. i .. "Pile");
				local height = pile:GetHeight();
				if ( ( height or 0 ) < pile.goalHeight ) then
					pile:SetHeight(height+(1*((0.017-this.elapsed)/0.017)));
					keepAnimating = true;
				end
			end
			if ( not keepAnimating ) then
				CT_ExpenseHistoryFrame.isAnimated = nil;
			end
		end
		this.elapsed = 0.017;
	end
end

function CT_EH_GetMoney(name)
	local total, totalRep, numRep, totalFli, totalReg, totalAmm, totalMai = 0, 0, 0, 0, 0, 0, 0;
	if ( name and CT_EH_History[name] ) then
		for k, v in CT_EH_History[name] do
			if ( k ~= "class" and k ~= "key" ) then
				total = total + v[1];
				if ( v[2] == CT_EH_REPAIR ) then
					totalRep = totalRep + v[1];
					numRep = numRep + 1;
				elseif ( v[2] == CT_EH_FLIGHT ) then
					totalFli = totalFli + v[1];
				elseif ( v[2] == CT_EH_REAGENT ) then
					totalReg = totalReg + v[1];
				elseif ( v[2] == CT_EH_AMMO ) then
					totalAmm = totalAmm + v[1];
				elseif ( v[2] == CT_EH_MAIL ) then
					totalMai = totalMai + v[1];
				end
			end
		end
	end
	return total, totalRep, numRep, totalFli, totalReg, totalAmm, totalMai;
end

function CT_EH_OnShow()
	PlaySound("UChatScrollButton");
	PanelTemplates_SetTab(CT_ExpenseHistoryFrame, 1);
	CT_ExpenseHistoryFrameSummary:Show();
	CT_ExpenseHistoryFrameLog:Hide();
	CT_EH_UpdateSummary();
	CT_EH_StartAnimate();
end

function CT_EH_OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		local player = UnitName("player") .. "@" .. GetCVar("realmName");
		-- Initialize
		if ( not CT_EH_History["startUsage"] ) then
			CT_EH_History["startUsage"] = time();
		elseif ( not CT_EH_History["version"] ) then
			-- We used version 1.0 previously
			CT_EH_History["startUsage"] = CT_EH_History["startUsage"] * (24*3600);
		end
		CT_EH_History["version"] = CT_EH_Version;
		if ( not CT_EH_History[player] ) then
			CT_EH_History[player] = { 
				["class"] = UnitClass("player"),
				["key"] = player
			};
		end
	end
end

-- Data collection
CT_EH_oldUseContainerItem = UseContainerItem;
function CT_EH_newUseContainerItem(bag, slot)
	if ( InRepairMode() ) then
		local hasCooldown, repairCost = CT_EHTooltip:SetBagItem(bag,slot);
		if (repairCost and repairCost > 0 and repairCost <= GetMoney() and MerchantFrame.repairCost ) then
			MerchantFrame.repairCost = MerchantFrame.repairCost + repairCost;
		end
	end
	CT_EH_oldUseContainerItem(bag, slot);
end
UseContainerItem = CT_EH_newUseContainerItem;
CT_EH_oldPickupContainerItem = PickupContainerItem;
function CT_EH_newPickupContainerItem(bag, slot)
	if ( InRepairMode() ) then
		local hasCooldown, repairCost = CT_EHTooltip:SetBagItem(bag,slot);
		if (repairCost and repairCost > 0 and repairCost <= GetMoney() and MerchantFrame.repairCost ) then
			MerchantFrame.repairCost = MerchantFrame.repairCost + repairCost;
		end
	end
	CT_EH_oldPickupContainerItem(bag, slot);
end
PickupContainerItem = CT_EH_newPickupContainerItem;

CT_EH_oldRepairAllItems = RepairAllItems;
function CT_EH_newRepairAllItems()
	local repairAllCost, canRepair = GetRepairAllCost();
	if ( canRepair and repairAllCost <= GetMoney() ) then
		if ( MerchantFrame.repairCost ) then
			MerchantFrame.repairCost = MerchantFrame.repairCost + repairAllCost;
		end
	end
	CT_EH_oldRepairAllItems();
end
RepairAllItems = CT_EH_newRepairAllItems;

SlashCmdList["EXPENSEHISTORY"] = function()
	if ( CT_ExpenseHistoryFrame:IsVisible() ) then
		HideUIPanel(CT_ExpenseHistoryFrame);
	else
		ShowUIPanel(CT_ExpenseHistoryFrame);
	end
end

SLASH_EXPENSEHISTORY1 = "/expensehistory";
SLASH_EXPENSEHISTORY2 = "/eh";

function CT_EH_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_EH_DropDown_Initialize);
end

function CT_EH_DropDown_Initialize()
	local dropdown, info;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	info = { };
	info.text = "All Characters";
	info.value = nil;
	info.checked = ( not CT_ExpenseHistoryFrame.currPlayer );
	info.func = CT_EH_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	for k, v in CT_EH_History do
		if ( type(v) == "table" ) then
			local total = CT_EH_GetMoney(k);
			if ( total >= CT_EH_DISPLAYTHRESHOLD ) then
				local _, _, playerName, server = string.find(k, "^(.+)@(.+)$");
				info = { };
				info.text = playerName .. " @ " .. server;
				info.value = k;
				info.checked = ( CT_ExpenseHistoryFrame.currPlayer == k );
				info.func = CT_EH_DropDown_OnClick;
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function CT_EH_DropDown_OnClick()
	if ( this:GetID() == 1 ) then
		CT_ExpenseHistoryFrame.currPlayer = nil;
	else
		CT_ExpenseHistoryFrame.currPlayer = this.value;
	end
	CT_EH_UpdateSummary();
	CT_EH_UpdateLog();
end

function CT_EH_Tab_OnClick()
	if ( this:GetID() == 1 ) then
		getglobal("CT_ExpenseHistoryFrameSummary"):Show();
		getglobal("CT_ExpenseHistoryFrameLog"):Hide();
		CT_EH_UpdateSummary();
	elseif ( this:GetID() == 2 ) then
		getglobal("CT_ExpenseHistoryFrameSummary"):Hide();
		getglobal("CT_ExpenseHistoryFrameLog"):Show();
		CT_EH_UpdateLog();
	end
	PlaySound("igCharacterInfoTab");
	PanelTemplates_SetTab(CT_ExpenseHistoryFrame, this:GetID());
end

-- Find out if vendor is reagent vendor
function CT_EH_IsVendor(tbl)
	for i = 1, GetMerchantNumItems(), 1 do
		local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i);
		if ( name and tbl[strlower(name)] ) then
			return true;
		end
	end
	return false;
end

local CT_EH_oldMerchantFrame_OnShow = MerchantFrame:GetScript("OnShow");
local CT_EH_oldMerchantFrame_OnHide = MerchantFrame:GetScript("OnHide");
MerchantFrame:SetScript("OnShow", function()
	CT_EH_oldMerchantFrame_OnShow();
	if ( CT_EH_IsVendor(CT_EH_SCANFORREAGENTS) ) then
		MerchantFrame.reagentCost = 0;
	else
		MerchantFrame.reagentCost = nil;
	end
	if ( CT_EH_IsVendor(CT_EH_SCANFORAMMO) ) then
		MerchantFrame.ammoCost = 0;
	else
		MerchantFrame.ammoCost = nil;
	end
	local repairAllCost, canRepair = GetRepairAllCost();
	if ( canRepair ) then
		MerchantFrame.repairCost = 0;
	else
		MerchantFrame.repairCost = nil;
	end
end);
MerchantFrame:SetScript("OnHide", function()
	CT_EH_oldMerchantFrame_OnHide();
	if ( MerchantFrame.reagentCost and MerchantFrame.reagentCost > 0 ) then
		tinsert(CT_EH_History[UnitName("player") .. "@" .. GetCVar("realmName")], { MerchantFrame.reagentCost, CT_EH_REAGENT, time() });
	end
	if ( MerchantFrame.ammoCost and MerchantFrame.ammoCost > 0 ) then
		tinsert(CT_EH_History[UnitName("player") .. "@" .. GetCVar("realmName")], { MerchantFrame.ammoCost, CT_EH_AMMO, time() });
	end
	if ( MerchantFrame.repairCost and MerchantFrame.repairCost > 0 ) then
		tinsert(CT_EH_History[UnitName("player") .. "@" .. GetCVar("realmName")], { MerchantFrame.repairCost, CT_EH_REPAIR, time() });
	end
	MerchantFrame.repairCost = nil;
	MerchantFrame.reagentCost = nil;
	MerchantFrame.ammoCost = nil;
	CT_EH_UpdateSummary();
	CT_EH_UpdateLog();
end);

local CT_EH_oldBuyMerchantItem = BuyMerchantItem;
function BuyMerchantItem(id, qty)
	local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(id);
	local realPrice = price*(qty or 1);
	CT_EH_oldBuyMerchantItem(id, qty);
	if ( MerchantFrame.reagentCost and name and CT_EH_SCANFORREAGENTS[strlower(name)] and realPrice <= GetMoney() ) then
		MerchantFrame.reagentCost = MerchantFrame.reagentCost + realPrice;
	end
	if ( MerchantFrame.ammoCost and name and CT_EH_SCANFORAMMO[strlower(name)] and realPrice <= GetMoney() ) then
		MerchantFrame.ammoCost = MerchantFrame.ammoCost + realPrice;
	end
end

local CT_EH_oldSendMail = SendMail;
function SendMail(target, subject, body)
	CT_EH_oldSendMail(target, subject, body);
	local price = SendMailCostMoneyFrame.staticMoney;
	if ( price <= GetMoney() ) then
		tinsert(CT_EH_History[UnitName("player") .. "@" .. GetCVar("realmName")], { price, CT_EH_MAIL, time() });
		CT_EH_UpdateSummary();
		CT_EH_UpdateLog();
	end
end

CT_EH_oldTakeTaxiNode = TakeTaxiNode;
function CT_EH_newTakeTaxiNode(id)
	if ( GetMoney() >= TaxiNodeCost(id) ) then
		tinsert(CT_EH_History[UnitName("player") .. "@" .. GetCVar("realmName")], { TaxiNodeCost(id), CT_EH_FLIGHT, time() });
		CT_EH_UpdateSummary();
		CT_EH_UpdateLog();
	end
	CT_EH_oldTakeTaxiNode(id);
end

TakeTaxiNode = CT_EH_newTakeTaxiNode;

if ( CT_RegisterMod ) then
	CT_RegisterMod(CT_EH_MODINFO[1], CT_EH_MODINFO[2], 5, "Interface/Icons/INV_Misc_Note_05", CT_EH_MODINFO[3], "switch", "", function() if ( CT_ExpenseHistoryFrame:IsVisible() ) then HideUIPanel(CT_ExpenseHistoryFrame) else ShowUIPanel(CT_ExpenseHistoryFrame) end end);
else
	DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Expense History loaded. Type /expensehistory or /eh to display the window.", 1, 1, 0);
end