------------------------------------------------------
-- AutoCraft.lua
-- Originally based on BetterTradeSkill by Matt Perry (http://somewhere.fscked.org)
------------------------------------------------------
FAC_VERSION = "11200.1";
------------------------------------------------------

FAC_Config = {};
FAC_Config.AutoIterate = false;

local P = {};
AutoCraft = P;

P.OrderedQueue = {};
P.QueuedReagents = {};
P.ManuallyPaused = false;
P.SkillCache = {};
P.ReagentCache = {};
P.NoOverride = true;
P.TradeSkillsSeen = {};

local MAX_QUEUE_BUTTONS = 10;
local CACHE_TIME = 5;	-- We cache the returns from our hooked GetTradeSkillInfo because it can be called many times a second without actually having any relevant conditions be different. This keeps us from repeatedly recalculating it when not needed.
local QUEUE_ADVANCE_DELAY = 1; -- In 1.8 we seem to have problems if we try to advance the queue too soon after finishing an item (if the item we just finished is needed to craft the next item in the queue, WoW thinks we don't have it yet and thus can't craft the next item). May have something to do with lag. So, we wait this many seconds before trying to advance the queue.
local TRADESKILL_UPDATE_TIME = 5;

function P.GetTradeSkillInfo(index)
	if (P.SkillCache[index] and (GetTime() - P.SkillCache[index].time < CACHE_TIME)) then
		local info = P.SkillCache[index].info;
		return info.skillName, info.difficulty, info.numAvailable, info.isExpanded, info.itemName;
	end
		
	local skillName, difficulty, numAvailable, isExpanded = P.Orig_GetTradeSkillInfo(index);

	if (skillName == nil or difficulty == "header") then
		-- something calls us a lot when the TradeSkillFrame is first shown, and Orig_GetTradeSkillInfo returns bogus at that time.
		-- just pass along bogus returns so we don't get bogged down in calculation or cache checks;
		-- we'll get called again and be able to use the right info soon enough.
		return skillName, difficulty, numAvailable, isExpanded, nil;
	end
	
	-- Adjustment #1: recalculate numAvailable based on our altered GetTradeSkillReagentInfo (normally its value is calculated by the client)
	local reagentTally = {};
	for reagentIndex = 1, GetTradeSkillNumReagents(index) do
		local reagentName, _, reagentCount, playerReagentCount = P.GetTradeSkillReagentInfo(index, reagentIndex);
		local completeItemsWorth = math.max(math.floor(playerReagentCount / reagentCount), 0); 
		table.insert(reagentTally, completeItemsWorth); -- how many could we make if this were the only reagent in question?
	end
	numAvailable = (math.min(unpack(reagentTally)) or 0); -- this is how many we can really make if we include already-queued reagents
	
	-- Adjustment #2 (TODO): how many of this item could we make if we were to make/buy the reagents right now?
	
	-- For testing
	--numAvailable = math.random(5);
	
	local itemName = P.GetTradeItemName(index);
	if (skillName ~= nil) then
		P.SkillCache[index] = { time=GetTime(), info={ skillName=skillName, difficulty=difficulty, numAvailable=numAvailable, isExpanded=isExpanded, itemName=itemName } };
	end
	
	return skillName, difficulty, numAvailable, isExpanded, itemName;
end

function P.GetTradeSkillReagentInfo(skillIndex, reagentIndex)
	local index = skillIndex.."."..reagentIndex;
	if (P.ReagentCache[index] and (GetTime() - P.ReagentCache[index].time < CACHE_TIME)) then
		local info = P.ReagentCache[index].info;
		return info.reagentName, info.reagentTexture, info.reagentCount, info.playerReagentCount;
	end

	local reagentName, reagentTexture, reagentCount, playerReagentCount = P.Orig_GetTradeSkillReagentInfo(skillIndex, reagentIndex);
	
	if (reagentName == nil or reagentTexture == nil) then
		-- something calls us a lot when the TradeSkillFrame is first shown, and Orig_GetTradeSkillReagentInfo returns bogus then.
		-- just pass along bogus returns so we don't get bogged down in calculation or cache checks;
		-- we'll get called again and be able to use the right info soon enough.
		return reagentName, reagentTexture, reagentCount, playerReagentCount;
	end
	
	-- Adjustment #1: if you've queued some of this item, add them to effective "inventory" for determining what you can make from it.
	playerReagentCount = playerReagentCount + P.NumOfItemInQueue(reagentName);

	-- Adjustment #2: if your queue contains items that use this reagent, subtract the amount that will be used from your "inventory".
	for _, queueEntry in P.OrderedQueue do
		local perItemCount = queueEntry.reagentsPerItem[reagentName];
		if (perItemCount ~= nil) then
			playerReagentCount = playerReagentCount - ((queueEntry.numQueued - queueEntry.numProduced) * perItemCount);
		end
	end
	playerReagentCount = math.max(playerReagentCount, 0);
	
	if (reagentName ~= nil) then
		P.ReagentCache[index] = { time=GetTime(), info={ reagentName=reagentName, reagentTexture=reagentTexture, reagentCount=reagentCount,  playerReagentCount=playerReagentCount } };
	end

	return reagentName, reagentTexture, reagentCount, playerReagentCount;
end

function P.GetTradeSkillTools(skillIndex)
	local toolInfo = {P.Orig_GetTradeSkillTools(skillIndex)};
	local newToolInfo = {};
	for index = 1, table.getn(toolInfo) do
		local item = toolInfo[index];
		if (item and type(item) == "string") then
			table.insert(newToolInfo, item);
			if (toolInfo[index+1] == 1 or P.NumOfItemInQueue(item) > 0) then
				table.insert(newToolInfo, 1);
			end
		end
	end
	return unpack(newToolInfo);
end

function P.TradeSkillFrame_Update()
	P.Orig_TradeSkillFrame_Update();

	local skillName = GetTradeSkillLine();
	if (P.TradeSkillsSeen[skillName] == nil) then
		P.TradeSkillsSeen[skillName] = GetTime();
		--GFWUtils.Print("Disabling TradeSkillFrame overrides.");
		P.NoOverride = true;
	end
	if (P.NoOverride or FAC_Config.NoOverride) then return; end
	
	local numTradeSkills = GetNumTradeSkills();
	local skillOffset = FauxScrollFrame_GetOffset(TradeSkillListScrollFrame);
	for i=1, TRADE_SKILLS_DISPLAYED, 1 do
		local skillIndex = i + skillOffset;
		local skillName, skillType, numAvailable, isExpanded = P.GetTradeSkillInfo(skillIndex);
		local skillButton = getglobal("TradeSkillSkill"..i);
		if ( skillIndex <= numTradeSkills and skillName ) then	
			if ( numAvailable == 0 ) then
				skillButton:SetText(" "..skillName);
			else
				skillButton:SetText(" "..skillName.." ["..numAvailable.."]");
			end
		end
	end
end

function P.TradeSkillFrame_SetSelection(id)
	P.Orig_TradeSkillFrame_SetSelection(id);
	
	local skillName = GetTradeSkillLine();
	if (P.TradeSkillsSeen[skillName] == nil) then
		P.TradeSkillsSeen[skillName] = GetTime();
		--GFWUtils.Print("Disabling TradeSkillFrame overrides.");
		P.NoOverride = true;
	end
	if (P.NoOverride or FAC_Config.NoOverride) then return; end
	
	local creatable = 1;
	local numReagents = GetTradeSkillNumReagents(id);
	for i=1, numReagents, 1 do
		local reagentName, reagentTexture, reagentCount, playerReagentCount = P.GetTradeSkillReagentInfo(id, i);
		local reagent = getglobal("TradeSkillReagent"..i)
		local name = getglobal("TradeSkillReagent"..i.."Name");
		local count = getglobal("TradeSkillReagent"..i.."Count");
		if ( reagentName and reagentTexture ) then
			if ( playerReagentCount < reagentCount ) then
				SetItemButtonTextureVertexColor(reagent, 0.5, 0.5, 0.5);
				name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				creatable = nil;
			else
				SetItemButtonTextureVertexColor(reagent, 1.0, 1.0, 1.0);
				name:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			if ( playerReagentCount >= 100 ) then
				playerReagentCount = "*";
			end
			count:SetText(playerReagentCount.." /"..reagentCount);
		end
	end
	local spellFocus = BuildColoredListString(P.GetTradeSkillTools(id));
	if ( spellFocus ) then
		TradeSkillRequirementText:SetText(spellFocus);
	end
	
	if (creatable) then
		AutoCraftQueue:Enable();
		AutoCraftQueueAll:Enable();
	else
		AutoCraftQueue:Disable();
		AutoCraftQueueAll:Disable();
	end
end

function P.Load()
	if (not P.Loaded) then
		-- Attach our UI elements to the TradeSkillFrame now that it's loaded.
		AutoCraftBackground:SetParent(TradeSkillFrame);
		AutoCraftBackground:SetPoint("TOPLEFT", 0, 0);	
		AutoCraftBackground:SetHeight(TradeSkillFrame:GetHeight() + 48); 
			-- reset this in case someone (say, EnhancedTradeSkill) resized TradeSkillFrame on us
		AutoCraftBackground:Show();	
		AutoCraftQueue:SetParent(TradeSkillFrame);	
		AutoCraftQueue:SetPoint("TOPLEFT", TradeSkillCreateButton, "TOPLEFT", 0, 0);	
		AutoCraftQueue:Show();	
		AutoCraftQueueAll:SetParent(TradeSkillFrame);	
		AutoCraftQueueAll:SetPoint("TOPLEFT", TradeSkillCreateAllButton, "TOPLEFT", 0, 0);	
		AutoCraftQueueAll:Show();	
		AutoCraftBuy:SetParent(TradeSkillFrame);	
		AutoCraftBuy:SetPoint("TOPLEFT", TradeSkillCancelButton, "TOPLEFT", 0, 0);	
		AutoCraftBuy:Show();	
		AutoCraftQueueEverything:SetParent(TradeSkillFrame);	
		AutoCraftQueueEverything:Show();	
		AutoCraftRunQueue:SetParent(TradeSkillFrame);	
		AutoCraftRunQueue:Show();	
		AutoCraftClear:SetParent(TradeSkillFrame);	
		AutoCraftClear:Show();	
		AutoCraftRunAutomatically:SetParent(TradeSkillFrame);	
		AutoCraftRunAutomatically:Show();	
		AutoCraftRunAutomaticallyText:SetText(FAC_RUN_AUTOMATICALLY_CHECKBUTTON);
		AutoCraftRunAutomatically:SetChecked(FAC_Config.AutoIterate);

		-- Hide the old Create buttons so I can put my buttons in  their place.  
		-- Not sure if this will always work, but it does at the moment.
		TradeSkillCreateButton:Hide();
		TradeSkillCreateAllButton:Hide();
		TradeSkillCancelButton:Hide();

		-- we don't actually hook these anymore, but we keep the "aliases" around to be clearly readable when we're calling originals.
		P.Orig_GetTradeSkillTools = GetTradeSkillTools;
		P.Orig_GetTradeSkillReagentInfo = GetTradeSkillReagentInfo;
		P.Orig_GetTradeSkillInfo = GetTradeSkillInfo;

		-- we do hook these, however.
		P.Orig_TradeSkillFrame_SetSelection = TradeSkillFrame_SetSelection;
		TradeSkillFrame_SetSelection = P.TradeSkillFrame_SetSelection;
		P.Orig_TradeSkillFrame_Update = TradeSkillFrame_Update;
		TradeSkillFrame_Update = P.TradeSkillFrame_Update;
		
		P.Loaded = true;
		GFWUtils.Print("Fizzwidget AutoCraft "..FAC_VERSION.." initialized!");
	end
end

function P.NumOfItemInQueue(itemName)
	for _, queueEntry in P.OrderedQueue do
		if (queueEntry.item == itemName) then
			local numPerCraft = (queueEntry.numPerCraft or 0);
			local numQueued = (queueEntry.numQueued or 0);
			if (numPerCraft > 1) then
				return numQueued * numPerCraft;
			else
				return numQueued;
			end
		end
	end
	return 0;
end

function P.OnUpdate(elapsed)
	if (P.NoOverride and P.Loaded and TradeSkillFrame and TradeSkillFrame:IsVisible()) then
		local skillName = GetTradeSkillLine();
		if (P.TradeSkillsSeen[skillName] and (GetTime() - P.TradeSkillsSeen[skillName] > TRADESKILL_UPDATE_TIME)) then
			P.NoOverride = false;
			--GFWUtils.Print("Enabling TradeSkillFrame overrides.");
			TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
			TradeSkillFrame_Update();
		end
	end
	if (not CastingBarFrame:IsVisible()) then
		P.CastingOtherSpell = false;
		P.CraftingQueuedItem = false;
	end
	if (P.AdvanceQueueTime ~= nil and GetTime() >= P.AdvanceQueueTime) then
		P.Iterate();
		P.AdvanceQueueTime = nil;
	end
end

function P.OnLoad()
	-- we do most of our loading once the TradeSkillFrame loads (which is on-demand now).

	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("CHAT_MSG_SPELL_TRADESKILLS");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_CLOSED");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("TRADE_SKILL_UPDATE");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");

	if ( IsAddOnLoaded("Blizzard_TradeSkillUI") ) then
	--	P.Load();
	end

end

function P.OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	if (event == "ADDON_LOADED" and (arg1 == "Blizzard_TradeSkillUI" or IsAddOnLoaded("Blizzard_TradeSkillUI"))) then
		P.Load();
	end
	if (not P.Loaded) then 
		-- all the other events we care about only have relevance once we're fully in action and attached to the TradeSkill UI
		return; 
	end

	--DevTools_Dump({event=event, arg1=arg1, arg2=arg2, arg3=arg3, arg4=arg4, arg5=arg5, arg6=arg6, arg7=arg7, arg8=arg8, arg9=arg9});
	if (event == "CHAT_MSG_SPELL_TRADESKILLS") then
		if (FAC_CreateItemPattern == nil) then
			FAC_CreateItemPattern = GFWUtils.FormatToPattern(TRADESKILL_LOG_FIRSTPERSON);
		end
		for item in string.gfind(arg1, FAC_CreateItemPattern) do
			P.HandleCreated(item);
			return;
		end
	elseif (event == "TRADE_SKILL_CLOSE" or event == "MERCHANT_SHOW" or event == "MERCHANT_CLOSED") then
		P.UpdateDisplay();
	elseif (event == "TRADE_SKILL_SHOW") then
		P.UpdateDisplay();
		AutoCraftRunAutomaticallyText:SetText(FAC_RUN_AUTOMATICALLY_CHECKBUTTON);
		AutoCraftRunAutomatically:SetChecked(FAC_Config.AutoIterate);
		-- if we've just switched to the tradeskill window needed for the head of the queue, start iterating again
		if (not P.ManuallyPaused and P.OrderedQueue[1] ~= nil and P.OrderedQueue[1].skill == GetTradeSkillLine()) then
			P.Iterate();
		end
	elseif (event == "TRADE_SKILL_UPDATE") then
		P.UpdateDisplay();
	elseif (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
		P.CastingOtherSpell = false;
		P.CraftingQueuedItem = false;
		if (P.Unqueueing or P.CastingOtherSpell) then
			P.Unqueueing = false; 
			P.Iterate();
			return;
		end
		P.UpdateDisplay();
	elseif (event == "SPELLCAST_STOP") then
		if (P.CastingOtherSpell) then
			P.CastingOtherSpell = false;
			P.Iterate();
			P.UpdateDisplay();
		end
	elseif (event == "SPELLCAST_START") then
		if (P.OrderedQueue[1] and CastingBarText:GetText() == P.OrderedQueue[1].recipe) then
			P.CraftingQueuedItem = true;
			P.CastingOtherSpell = false;
		else
			P.CraftingQueuedItem = false;
			P.CastingOtherSpell = true;
		end
		P.UpdateDisplay();
	end
end

function P.Queue_OnClick()
	local id = tonumber(this:GetID());
	if (P.OrderedQueue[id]) then
		table.remove(P.OrderedQueue, id);
		if (id == 1 and P.CraftingQueuedItem) then
			P.Unqueueing = true;
			SpellStopCasting();
		end
		TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
		TradeSkillFrame_Update();	
		P.UpdateDisplay();
		P.Queue_UpdateTooltip(id);
	end
end

function P.Queue_OnEvent()
	P.Queue_UpdateTooltip(tonumber(this:GetID()));
end

function P.Queue_UpdateTooltip(id)
	local button = getglobal("QueuedSkillIcon"..id);
	if (button:IsVisible()) then
		GameTooltip:SetOwner(button, "ANCHOR_TOPLEFT");
		if ( id == 1 and P.CraftingQueuedItem) then
			GameTooltip:SetText(NORMAL_FONT_COLOR_CODE..FAC_CREATING..FONT_COLOR_CODE_CLOSE, 1.0, 1.0, 1.0);
		else
			GameTooltip:SetText(NORMAL_FONT_COLOR_CODE..FAC_QUEUED..FONT_COLOR_CODE_CLOSE, 1.0, 1.0, 1.0);
		end
		if (id == MAX_QUEUE_BUTTONS and table.getn(P.OrderedQueue) > MAX_QUEUE_BUTTONS) then
			GameTooltip:AppendText(string.format(FAC_ADDITIONAL_ENTRIES, table.getn(P.OrderedQueue) - MAX_QUEUE_BUTTONS + 1));
			for index = MAX_QUEUE_BUTTONS, table.getn(P.OrderedQueue) do
				local num = P.OrderedQueue[index].numQueued - P.OrderedQueue[index].numProduced;
				GameTooltip:AppendText("\n"..num .."x ".. P.OrderedQueue[index].item);
			end
			GameTooltip:AddLine(string.format(FAC_CLICK_TO_CANCEL_FORMAT, P.OrderedQueue[MAX_QUEUE_BUTTONS].item));
		else
			local num = P.OrderedQueue[id].numQueued - P.OrderedQueue[id].numProduced;
			GameTooltip:AppendText(num .."x ".. P.OrderedQueue[id].item);
			GameTooltip:AddLine(FAC_CLICK_TO_CANCEL);
		end
		GameTooltip:Show();
	end
end

function P.QueueEverything()
	local numSkills = GetNumTradeSkills();
	local startIndex, stopIndex, increment;
	if (IsAltKeyDown()) then
		startIndex = 1;
		stopIndex = numSkills;
		increment = 1;
	else
		startIndex = numSkills;
		stopIndex = 1;
		increment = -1;
	end
	for index = startIndex, stopIndex, increment do
		local recipeName, _, numAvailable, _, itemName = P.GetTradeSkillInfo(index);
		if (numAvailable > 0) then
			P.AddToQueue(recipeName, itemName, index, numAvailable);
		end
	end
	TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
	TradeSkillFrame_Update();	
	if (table.getn(P.OrderedQueue) == 0) then
		GFWUtils.Print(FAC_NOTHING_TO_QUEUE);
	end
end

-- TODO: option-click for "buy all" equivalent to "queue all"
function P.BuyReagents(amount)
	local index = GetTradeSkillSelectionIndex();
	
	--if (IsAltKeyDown()) then
	--	amount = TradeSkillFrame.numAvailable;
	--end
	
	for reagentIndex = 1, GetTradeSkillNumReagents(index) do
		local reagentName, _, reagentCount, playerReagentCount = P.GetTradeSkillReagentInfo(index, reagentIndex);
		local amountNeeded = (reagentCount * amount) - playerReagentCount;
		
		for merchantIndex = 1, GetMerchantNumItems() do
			local name, _, price, numPerBuy, numAvailable, _ = GetMerchantItemInfo(merchantIndex);
			if (name == reagentName) then
				if (numAvailable >= 0 and (numAvailable * numPerBuy) < amountNeeded) then
					amountNeeded = numAvailable * numPerBuy;
				end
				local amountToBuy = math.ceil(amountNeeded / numPerBuy);
				if (amountToBuy > 0) then
					if (numPerBuy > 1) then
						GFWUtils.Print(string.format(FAC_BUYING_SETS_FORMAT, amountToBuy, name));
						while (amountToBuy > 0 ) do
							local amountBuyingNow = 1; -- dumb workaround for the API not telling us max stack size for things that come in multi-packs
							BuyMerchantItem(merchantIndex, amountBuyingNow);
							amountToBuy = amountToBuy - amountBuyingNow;
						end
					else
						while (amountToBuy > 0 ) do
							local maxPerBuy = GetMerchantItemMaxStack(merchantIndex);
							local amountBuyingNow = math.min(amountToBuy, maxPerBuy);
							GFWUtils.Print(string.format(FAC_BUYING_FORMAT, amountBuyingNow, name));
							BuyMerchantItem(merchantIndex, amountBuyingNow);
							amountToBuy = amountToBuy - amountBuyingNow;
						end
					end
				elseif (numAvailable == 0) then
					GFWUtils.Print(string.format(FAC_NOT_AVAILABLE_FORMAT, name));
				else
					GFWUtils.Print(string.format(FAC_ALREADY_ENOUGH_FORMAT, name, amount, P.GetTradeItemName(index)));
				end
				break;
			end
		end
	end
end

function P.Queue(amount)
	local index = GetTradeSkillSelectionIndex();
	local recipeName, _, numAvailable, _, itemName = P.GetTradeSkillInfo(index);

	if (amount > numAvailable) then amount = numAvailable; end

	if (amount > 0) then
		P.AddToQueue(recipeName, itemName, index, amount);
	end
	TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
	TradeSkillFrame_Update();
	P.UpdateDisplay();
end

function P.AddToQueue(recipeName, item, index, amount)

	local alreadyQueued = false;
	GFWUtils.Print(FAC_QUEUEING .. GFWUtils.Hilite(amount .. " x ") .. GetTradeSkillItemLink(index));
	for _, queueEntry in P.OrderedQueue do
		if (item == queueEntry.item) then
			queueEntry.numQueued = queueEntry.numQueued + amount;
			alreadyQueued = true;
		end
	end
	if (not alreadyQueued) then
		local reagentsPerItem = {};
		for reagentIndex = 1, GetTradeSkillNumReagents(index) do
			local reagentName, _, reagentCount, _ = P.GetTradeSkillReagentInfo(index, reagentIndex);
			reagentsPerItem[reagentName] = reagentCount;
		end
		local minMade, maxMade = GetTradeSkillNumMade(index);
		local numPerCraft = math.min((minMade or 0), (maxMade or 0)); 
		-- assume recipes that make a variable number of items will always produce the minimum, so we can't end up over-queueing.

		table.insert(P.OrderedQueue, {recipe=recipeName, item=item, numQueued=amount, numProduced=0, icon=GetTradeSkillIcon(index), skill=GetTradeSkillLine(), reagentsPerItem=reagentsPerItem, numPerCraft=numPerCraft});
	end

	TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
	TradeSkillFrame_Update();
	P.UpdateDisplay();
	if (FAC_Config.AutoIterate) then
		P.ManuallyPaused = false;
		P.Iterate();
	else
		P.ManuallyPaused = true;
	end
	P.UpdateDisplay();
end

function P.UpdateDisplay()
	
	-- we clear these out in case relevant inventory has (actually or effectively) changed.
	P.SkillCache = {};
	P.ReagentCache = {};

	if (MerchantFrame:IsVisible()) then
		AutoCraftBuy:Enable();
	else
		AutoCraftBuy:Disable();
	end
	
	if (table.getn(P.OrderedQueue) > 0) then
		if (P.CraftingQueuedItem) then
			QueueMessageText:Hide();
			QueueMessageText:SetText("");
			AutoCraftRunQueue:SetText(FAC_PAUSE_QUEUE_BUTTON);
		else
			if (not P.ManuallyPaused and P.OrderedQueue[1] ~= nil and P.OrderedQueue[1].skill ~= GetTradeSkillLine()) then
				QueueMessageText:SetText(FAC_QUEUE_PAUSED..": "..string.format(FAC_SWITCH_WINDOW_FORMAT, P.OrderedQueue[1].skill));
			elseif (P.CastingOtherSpell) then
				if (CastingBarText:GetText() ~= nil) then
					QueueMessageText:SetText(FAC_QUEUE_PAUSED..": "..string.format(FAC_WAITING_SPELL_FORMAT, CastingBarText:GetText()));
				end
			else
				QueueMessageText:SetText(FAC_QUEUE_PAUSED);
			end
			QueueMessageText:Show();
			AutoCraftRunQueue:SetText(FAC_RUN_QUEUE_BUTTON);
		end

		AutoCraftRunQueue:Enable();
		AutoCraftClear:Enable();
	else
		QueueMessageText:Hide();
		QueueMessageText:SetText("");
		AutoCraftRunQueue:SetText(FAC_RUN_QUEUE_BUTTON);
		AutoCraftRunQueue:Disable();
		AutoCraftClear:Disable();
	end
	
	for i = 1, MAX_QUEUE_BUTTONS do
		button = getglobal("QueuedSkillIcon"..i);
		currentItem = P.OrderedQueue[i];
		if (currentItem == nil) then
			button:Hide();
		else
			if (i == MAX_QUEUE_BUTTONS and table.getn(P.OrderedQueue) > MAX_QUEUE_BUTTONS) then
				SetItemButtonTexture(button, "Interface\\Icons\\INV_Misc_QuestionMark");
				SetItemButtonCount(button, (table.getn(P.OrderedQueue) - MAX_QUEUE_BUTTONS - 1));
			else
				SetItemButtonTexture(button, currentItem.icon);
				SetItemButtonCount(button, (currentItem.numQueued - currentItem.numProduced));
			end
			button:Show();
		end
	end
end

function P.StartStop()
	if (P.CraftingQueuedItem == true) then
		P.ManuallyPaused = true;
		SpellStopCasting();
		P.UpdateDisplay();
	else
		P.ManuallyPaused = false;
		P.Iterate();
		P.UpdateDisplay();
	end
end

function P.Clear()
	if (table.getn(P.OrderedQueue) > 0) then
		if (P.CraftingQueuedItem and not P.ManuallyPaused) then
			SpellStopCasting();
		end
		P.OrderedQueue = {};
		TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
		TradeSkillFrame_Update();	
		P.UpdateDisplay();
	end
end

function P.Iterate()	
	if (P.CraftingQueuedItem or P.CastingOtherSpell) then return; end
	if (table.getn(P.OrderedQueue) > 0) then
		local index = P.GetTradeRecipeIndex(P.OrderedQueue[1].recipe);
		if (index >= 0) then
			if (P.OrderedQueue[1].skill == GetTradeSkillLine()) then
				DoTradeSkill(index, (P.OrderedQueue[1].numQueued - P.OrderedQueue[1].numProduced));
				P.UpdateDisplay();
				return;
			end
		end
		P.ManuallyPaused = false;
		P.UpdateDisplay();
	end
end

function P.HandleCreated(item)
	if (P.OrderedQueue[1] and item == P.OrderedQueue[1].item) then
		P.OrderedQueue[1].numProduced = P.OrderedQueue[1].numProduced + 1;
		if (P.OrderedQueue[1].numProduced >= P.OrderedQueue[1].numQueued) then
			P.CraftingQueuedItem = false; -- this will get set back to true when we get the SPELLCAST_START event
			table.remove(P.OrderedQueue, 1);
		end
		TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
		TradeSkillFrame_Update();	
		P.UpdateDisplay();
		--P.Iterate();
		if (table.getn(P.OrderedQueue) > 0) then
			P.AdvanceQueueTime = GetTime() + QUEUE_ADVANCE_DELAY;
		end
	end
end

function P.GetTradeItemName(index)
	local linktext = GetTradeSkillItemLink(index);
	if (linktext) then
		local _,_,item = string.find(linktext, "^.*%[(.*)%].*$");
		return item;
	else
		local item, difficulty, amount = P.Orig_GetTradeSkillInfo(index);
		return item;
	end
end

-- find the trade skill index based on the skill name (recipe name), as indices are subject to change.
function P.GetTradeRecipeIndex(recipeName)
	local numSkills = GetNumTradeSkills();
	for index = 1, numSkills do
		local skillName = P.Orig_GetTradeSkillInfo(index);
		if (skillName == recipeName) then
			return index;
		end
	end
	return -1;
end
