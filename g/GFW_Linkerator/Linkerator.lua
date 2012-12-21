------------------------------------------------------
-- Linkerator.lua
-- Link scanning code based on LootLink 1.9. Thanks Telo!
------------------------------------------------------
FLT_VERSION = "11000.2";
------------------------------------------------------

FLT_ItemLinks = { };

local ChatMessageTypes = {
	"CHAT_MSG_SYSTEM",
	"CHAT_MSG_SAY",
	"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_YELL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_RAID",
	"CHAT_MSG_LOOT",
};

local INVENTORY_SLOT_LIST = {
	{ name = "HeadSlot" },
	{ name = "NeckSlot" },
	{ name = "ShoulderSlot" },
	{ name = "BackSlot" },
	{ name = "ChestSlot" },
	{ name = "ShirtSlot" },
	{ name = "TabardSlot" },
	{ name = "WristSlot" },
	{ name = "HandsSlot" },
	{ name = "WaistSlot" },
	{ name = "LegsSlot" },
	{ name = "FeetSlot" },
	{ name = "Finger0Slot" },
	{ name = "Finger1Slot" },
	{ name = "Trinket0Slot" },
	{ name = "Trinket1Slot" },
	{ name = "MainHandSlot" },
	{ name = "SecondaryHandSlot" },
	{ name = "RangedSlot" },
};

-- Anti-freeze code borrowed from ReagentInfo (in turn, from Quest-I-On):
-- keeps WoW from locking up if we try to scan the tradeskill window too fast.
FLT_TradeSkillLock = { };
FLT_TradeSkillLock.NeedScan = false;
FLT_TradeSkillLock.Locked = false;
FLT_TradeSkillLock.EventTimer = 0;
FLT_TradeSkillLock.EventCooldown = 0;
FLT_TradeSkillLock.EventCooldownTime = 1;
FLT_CraftLock = { };
FLT_CraftLock.NeedScan = false;
FLT_CraftLock.Locked = false;
FLT_CraftLock.EventTimer = 0;
FLT_CraftLock.EventCooldown = 0;
FLT_CraftLock.EventCooldownTime = 1;

function FLT_OnLoad()
	--GFWUtils.Debug = 1;
	-- Register Slash Commands
	SLASH_FLT1 = "/linkerator";
	SLASH_FLT2 = "/link";
	SlashCmdList["FLT"] = function(msg)
		FLT_ChatCommandHandler(msg);
	end
	
	for index, value in ChatMessageTypes do
		this:RegisterEvent(value);
	end

	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		INVENTORY_SLOT_LIST[index].id = GetInventorySlotInfo(INVENTORY_SLOT_LIST[index].name);
	end
		
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_UPDATE");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("QUEST_COMPLETE");
	this:RegisterEvent("QUEST_DETAIL");
	this:RegisterEvent("QUEST_FINISHED");
	this:RegisterEvent("QUEST_PROGRESS");
	this:RegisterEvent("QUEST_GREETING");
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	
	GFWUtils.Print("Fizzwidget Linkerator "..FLT_VERSION.." initialized!");
	
end

function FLT_OnUpdate(elapsed)
	-- If it's been more than a second since our last tradeskill update,
	-- we can allow the event to process again.
	FLT_TradeSkillLock.EventTimer = FLT_TradeSkillLock.EventTimer + elapsed;
	if (FLT_TradeSkillLock.Locked) then
		FLT_TradeSkillLock.EventCooldown = FLT_TradeSkillLock.EventCooldown + elapsed;
		if (FLT_TradeSkillLock.EventCooldown > FLT_TradeSkillLock.EventCooldownTime) then

			FLT_TradeSkillLock.EventCooldown = 0;
			FLT_TradeSkillLock.Locked = false;
		end
	end
	FLT_CraftLock.EventTimer = FLT_CraftLock.EventTimer + elapsed;
	if (FLT_CraftLock.Locked) then
		FLT_CraftLock.EventCooldown = FLT_CraftLock.EventCooldown + elapsed;
		if (FLT_CraftLock.EventCooldown > FLT_CraftLock.EventCooldownTime) then

			FLT_CraftLock.EventCooldown = 0;
			FLT_CraftLock.Locked = false;
		end
	end
	
	if (FLT_TradeSkillLock.NeedScan) then
		FLT_TradeSkillLock.NeedScan = false;
		FLT_ScanTradeSkill();
	end
	if (FLT_CraftLock.NeedScan) then
		FLT_CraftLock.NeedScan = false;
		FLT_ScanCraft();
	end
end

function FLT_OnEvent(event)
	if( event == "PLAYER_TARGET_CHANGED" ) then
		if( UnitIsUnit("target", "player") ) then
			return;
		elseif( UnitIsPlayer("target") ) then
			FLT_Inspect("target");
		end
	elseif( event == "PLAYER_ENTERING_WORLD" ) then
		FLT_ScanInventory();
		FLT_Inspect("player");
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	elseif( event == "PLAYER_LEAVING_WORLD" ) then
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	elseif( event == "UNIT_INVENTORY_CHANGED" ) then
		if( arg1 == "player" ) then
			FLT_ScanInventory();
			FLT_Inspect("player");
		end
	elseif( event == "MERCHANT_SHOW" ) then
		for i=1, GetMerchantNumItems() do
			local link = GetMerchantItemLink(i);
			if ( link ) then
				FLT_ProcessLinks(link);
			end
		end
	elseif( event == "BANKFRAME_OPENED" ) then
		FLT_ScanBank();
	elseif( event == "AUCTION_ITEM_LIST_UPDATE" ) then
		FLT_ScanAuction();
	elseif ( event == "QUEST_COMPLETE" or event == "QUEST_DETAIL" or event == "QUEST_FINISHED" or event == "QUEST_PROGRESS" or event == "QUEST_GREETING") then
		FLT_ScanQuestgiver();
	elseif ( event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_UPDATE" ) then
		FLT_ScanTradeSkill();
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_UPDATE" ) then
		FLT_ScanCraft();
	elseif (event == "CHAT_MSG_CHANNEL") then
		--DevTools_Dump({event=event, args={arg1=arg1,arg2=arg2,arg3=arg3,arg4=arg4,arg5=arg5,arg6=arg6,arg7=arg7,arg8=arg8,arg9=arg9,}});
		if (FLT_Debug) then
			debugprofilestart();
		end
		local gotLink = FLT_ProcessLinks(arg1);
		if (FLT_Debug) then
			local parseTime = debugprofilestop();
			if (gotLink) then
				FLT_MaxFoundTime = math.max((FLT_MaxFoundTime or 0), parseTime);
			else
				FLT_MaxNotFoundTime = math.max((FLT_MaxNotFoundTime or 0), parseTime);
			end
		end
	else
		FLT_ProcessLinks(arg1);
	end
end

function FLT_ChatCommandHandler(msg)

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Linkerator "..FLT_VERSION..":");
		GFWUtils.Print("/linkerator (or /link) <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("<item name>").." - Print a hyperlink to the chat window for an item known by name.");
		GFWUtils.Print("- "..GFWUtils.Hilite("<item id #>").." - Print a hyperlink to the chat window for a generic item whose ID number is known.");
		GFWUtils.Print("- "..GFWUtils.Hilite("<code>").." - Print a hyperlink to the chat window for an item whose complete link code is known.");
		return;
	end
	
	if (msg == "version") then
		GFWUtils.Print("Fizzwidget Linkerator "..FLT_VERSION);
		return;
	end
	
	if (msg == "list") then
		local totalCount, knownCount = 0, 0;
		for name, linkInfo in FLT_ItemLinks do
			if (type(linkInfo) == "string") then
				totalCount = totalCount + 1;
				local link = FLT_GetItemLink(linkInfo);
				if (link) then
					GFWUtils.Print(link);
					knownCount = knownCount + 1;
				else
					GFWUtils.Print(name.." ("..linkInfo.."; not cached)");
				end
			elseif (type(linkInfo) == "table") then
				for _, linkID in linkInfo do
					totalCount = totalCount + 1;
					local link = FLT_GetItemLink(linkID);
					if (link) then
						GFWUtils.Print(link);
						knownCount = knownCount + 1;
					else
						GFWUtils.Print(name.." ("..linkID.."; not cached)");
					end
				end
			end
		end
		GFWUtils.Print(GFWUtils.Hilite(totalCount).." items in history, "..GFWUtils.Hilite(knownCount).." known to client.");
		return;
	end
	
	if (msg == "count") then
		local totalCount, knownCount = 0, 0;
		for name, linkInfo in FLT_ItemLinks do
			if (type(linkInfo) == "string") then
				totalCount = totalCount + 1;
				local link = FLT_GetItemLink(linkInfo);
				if (link) then
					knownCount = knownCount + 1;
				end
			elseif (type(linkInfo) == "table") then
				for _, linkID in linkInfo do
					totalCount = totalCount + 1;
					local link = FLT_GetItemLink(linkID);
					if (link) then
						knownCount = knownCount + 1;
					end
				end
			end
		end
		GFWUtils.Print(GFWUtils.Hilite(totalCount).." items in history, "..GFWUtils.Hilite(knownCount).." known to client.");
		return;
	end
	
	if (FLT_Debug and msg == "time") then
		GFWUtils.Print(string.format("Max parse time "..GFWUtils.Hilite("%.2f").." ms (no links found)", FLT_MaxNotFoundTime * 1000));
		GFWUtils.Print(string.format("Max parse time "..GFWUtils.Hilite("%.2f").." ms (links found)", FLT_MaxFoundTime * 1000));
		return;
	end
	
	if (msg == "debug") then
		if (FLT_Debug) then
			FLT_Debug = nil;
			GFWUtils.Print("Linkerator debugging messages off.");
		else
			FLT_Debug = 1;
			GFWUtils.Print("Linkerator debugging messages on.");
		end
		return;
	end
	
	if (msg == "import") then
		local lootLinkCount = 0;
		if (ItemLinks and type(ItemLinks) == "table") then
			for itemName, lootLinkInfo in ItemLinks do
				if (lootLinkInfo.i and type(lootLinkInfo.i) == "string") then
					local itemLink = "item:"..lootLinkInfo.i;
					local addedLink = FLT_AddLink(itemName, itemLink);
					if (addedLink) then
						lootLinkCount = lootLinkCount + 1;
					end
				end
			end
		end
		GFWUtils.Print(GFWUtils.Hilite(lootLinkCount).. " items imported from LootLink.");
	end
	
	local itemLink;
	if (msg and msg ~= "") then
		_, _, itemLink = string.find(msg, "(item:%d+:%d+:%d+:%d+)");
	end
	if (tonumber(msg)) then
		--DevTools_Dump({msg=msg});
		local link = FLT_GetItemLink(msg, 1);
		if (link) then
			GFWUtils.Print("Item ID "..msg..": "..link);
		else
			GFWUtils.Print("Item ID "..msg.." is unknown to this WoW client.");
		end
		return;
	elseif (itemLink) then
		--DevTools_Dump({msg=msg, itemLink=itemLink});
		local link = FLT_GetItemLink(itemLink, 1);
		if (link) then
			GFWUtils.Print(itemLink..": "..link);
		else
			GFWUtils.Print(itemLink.." is unknown to this WoW client.");
		end
		return;
	elseif (msg and msg ~= "") then
		local foundLinks = FLT_GetLinkByName(msg, true);
		if (foundLinks) then
			if (type(foundLinks) == "string") then
				if (FLT_Debug) then
					local _, _, linkInfo = string.find(foundLinks, "(item:%d+:%d+:%d+:%d+)");
					GFWUtils.Print(foundLinks.." ("..linkInfo..")");
				else
					GFWUtils.Print(foundLinks);
				end
			elseif (type(foundLinks) == "table") then
				for _, aLink in foundLinks do
					if (FLT_Debug) then
						local _, _, linkInfo = string.find(aLink, "(item:%d+:%d+:%d+:%d+)");
						GFWUtils.Print(aLink.." ("..linkInfo..")");
					else
						GFWUtils.Print(aLink);
					end
				end
			else
				GFWUtils.Print(GFWUtils.Red("Linkerator error: ").."Unexpected result from FLT_GetLinkByName().");
			end
		else
			local foundCount = 0;
			msg = string.lower(msg);
			for itemName, linkInfo in FLT_ItemLinks do
				if (string.find(itemName, msg)) then
					if (type(linkInfo) == "string") then
						local link = FLT_GetItemLink(linkInfo);
						if (link) then
							if (FLT_Debug) then
								GFWUtils.Print(link.." ("..linkInfo..")");
							else
								GFWUtils.Print(link);
							end
							foundCount = foundCount + 1;
						end
					elseif (type(linkInfo) == "table") then
						for _, aLink in linkInfo do
							local link = FLT_GetItemLink(aLink);
							if (link) then
								if (FLT_Debug) then
									GFWUtils.Print(link.." ("..aLink..")");
								else
									GFWUtils.Print(link);
								end
								foundCount = foundCount + 1;
							end
						end
					end
				end
			end
			if (foundCount > 0) then
				GFWUtils.Print(GFWUtils.Hilite(foundCount).." links found for '"..GFWUtils.Hilite(msg).."'");
			else
				GFWUtils.Print("Could not find '"..GFWUtils.Hilite(msg).."' in Linkerator's item history.");
			end
		end
		return;
	end
	
	-- If we're this far, we probably have bad input.
	FDP_ChatCommandHandler("help");
end

function FLT_GetItemLink(linkInfo, shouldAdd)
	local sName, sLink, iQuality, iLevel, sType, sSubType, iCount = GetItemInfo(linkInfo);
	if (sName) then
		local _, _, _, color = GetItemQualityColor(iQuality);
		local linkFormat = "%s|H%s|h[%s]|h|r";
		if (shouldAdd) then
			FLT_AddLink(sName, sLink); -- add it to our name index if we're getting it from another source
		end
		return string.format(linkFormat, color, sLink, sName);
	else
		return nil;
	end
end

function FLT_GetLinkByName(text, returnAll)
	local _, _, name, property = string.find(text, "(.+)%((.-)%)" );
	local linkInfo = FLT_ItemLinks[string.lower(text)];
	local allResults = {};
	if (linkInfo == nil and name and property) then
		name = string.lower(string.gsub(name, " +$", ""));
		property = string.lower(property);
		linkInfo = FLT_ItemLinks[string.lower(name)];
	end
	if (linkInfo) then
		if (type(linkInfo) == "string") then
			local link = FLT_GetItemLink(linkInfo);
			if (link) then return link; end
		elseif (type(linkInfo) == "table" and name and property) then
			for _, itemLink in linkInfo do
				local _, _, _, _, type, subType, _, equipLoc = GetItemInfo(itemLink);
				if ((type and string.find(string.lower(type), property)) 
				 or (subType and string.find(string.lower(subType), property))
				 or (getglobal(equipLoc) and string.find(string.lower(getglobal(equipLoc)), property))) then
					local link = FLT_GetItemLink(itemLink);
					if (link and returnAll) then 
						table.insert(allResults, link);
					elseif (link) then
						return link; 
					end
				end
			end
			for _, itemLink in linkInfo do
				if (FLT_FindInItemTooltip(property, itemLink)) then
					if (returnAll) then 
						table.insert(allResults, FLT_GetItemLink(itemLink));
					else
						return FLT_GetItemLink(itemLink); 
					end
				end
			end 
		elseif (type(linkInfo) == "table") then
			for _, itemLink in linkInfo do
				local link = FLT_GetItemLink(itemLink);
				if (link and returnAll) then 
					table.insert(allResults, link);
				elseif (link) then
					return link; 
				end
			end
		else
			GFWUtils.Print(GFWUtils.Red("Linkerator error: ").."Corrupt table entry for "..GFWUtils.Hilite(name)..".");
		end
	elseif (string.find(text, "^(item:%d+:%d+:%d+:%d+)$")) then
		local link = FLT_GetItemLink(text);
		if (link) then return link; end
	elseif (string.find(text, "^#%d+$")) then
		local link = FLT_GetItemLink(string.sub(text,2));
		if (link) then return link; end
	end
	if (returnAll and table.getn(allResults) > 0) then
		return allResults;
	end
end

function FLT_ProcessLinks(text)
	local lastLink;
	if ( text ) then
		local link, name;
		for link, name in string.gfind(text, "|c%x+|H(item:%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
			if (link and name and name ~= "") then
				lastLink = FLT_AddLink(name, link);
			end
		end
	end
	return lastLink;
end

function FLT_AddLink(name, link)
	local cleanLink = string.gsub(link, "item:(%d+):%d+:(%d+):%d+", "item:%1:0:%2:0"); -- strip uniqID, enchant
	name = string.lower(name); -- so we can do case-insensitive lookups
	local existingLink = FLT_ItemLinks[name];
	if (existingLink and existingLink ~= cleanLink) then
		if (type(existingLink) == "string") then
			FLT_ItemLinks[name] = {};
			table.insert(FLT_ItemLinks[name], existingLink);
			table.insert(FLT_ItemLinks[name], cleanLink);
			if (FLT_Debug) then GFWUtils.Print("Added "..(FLT_GetItemLink(cleanLink) or name).." ("..cleanLink.."); changed to table"); end
		elseif (type(existingLink) == "table") then
			if (GFWTable.KeyOf(existingLink, cleanLink) == nil) then
				FLT_ItemLinks[name] = GFWTable.Merge(existingLink, {cleanLink});
				if (FLT_Debug) then GFWUtils.Print("Added "..(FLT_GetItemLink(cleanLink) or name).." ("..cleanLink.."); table count is now "..GFWTable.Count(FLT_ItemLinks[name])); end
			end
		else
			GFWUtils.PrintOnce("Corrupt entry for "..GFWUtils.Hilite(name).."; replacing with "..FLT_GetItemLink(cleanLink)..".", 60);
			FLT_ItemLinks[name] = cleanLink;
		end
	elseif (existingLink == nil) then
		FLT_ItemLinks[name] = cleanLink;
		if (FLT_Debug) then GFWUtils.Print("Added "..(FLT_GetItemLink(cleanLink) or name).." ("..cleanLink..")"); end
	end
	return cleanLink;
end

function FLT_InspectSlot(unit, id)
	local link = GetInventoryItemLink(unit, id);
	if ( link ) then
		FLT_ProcessLinks(link);
	end
end

function FLT_Inspect(who)
	local index;
	
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		FLT_InspectSlot(who, INVENTORY_SLOT_LIST[index].id)
	end
end

function FLT_ScanTradeSkill()
	if (not TradeSkillFrame or not TradeSkillFrame:IsVisible() or FLT_TradeSkillLock.Locked) then return; end
	-- This prevents further update events from being handled if we're already processing one.
	-- This is done to prevent the game from freezing under certain conditions.
	FLT_TradeSkillLock.Locked = true;

	local skillLineName, skillLineRank, skillLineMaxRank = GetTradeSkillLine();
	if not (skillLineName) then
		FLT_TradeSkillLock.NeedScan = true;
		return; -- apparently sometimes we're called too early, this is nil, and all hell breaks loose.
	end

	for id = 1, GetNumTradeSkills() do 
		local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(id);
		if ( skillType ~= "header" ) then				
			local itemLink = GetTradeSkillItemLink(id);
			if (itemLink == nil) then
				FLT_TradeSkillLock.NeedScan = true;
			else
				FLT_ProcessLinks(itemLink);
				for i=1, GetTradeSkillNumReagents(id), 1 do
					local link = GetTradeSkillReagentItemLink(id, i);
					if (link == nil) then
						FLT_TradeSkillLock.NeedScan = true;
						break;
					else
						FLT_ProcessLinks(link);
					end
				end
			end
		end
	end

end

function FLT_ScanCraft()
	if (not CraftFrame or not CraftFrame:IsVisible() or FLT_CraftLock.Locked) then return; end
	-- This prevents further update events from being handled if we're already processing one.
	-- This is done to prevent the game from freezing under certain conditions.
	FLT_CraftLock.Locked = true;

	-- This is used only for Enchanting
	local skillLineName, rank, maxRank = GetCraftDisplaySkillLine();
	if not (skillLineName) then
		return; -- Hunters' Beast Training also uses the CraftFrame, but doesn't have a SkillLine.
	end

	for id = GetNumCrafts(), 1, -1 do
		if ( craftType ~= "header" ) then
			local itemLink = GetCraftItemLink(id);
			if (itemLink == nil) then
				FLT_TradeSkillLock.NeedScan = true;
			else
				FLT_ProcessLinks(itemLink);
				
				for i=1, GetCraftNumReagents(id), 1 do
					local link = GetCraftReagentItemLink(id, i);
					if (link == nil) then
						FLT_CraftLock.NeedScan = true;
						break;
					else
						FLT_ProcessLinks(link);
					end
				end
			end
		end
	end
end

function FLT_ScanQuestgiver()
	local link;
	for i = 1, GetNumQuestItems() do
		link = GetQuestItemLink("required", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	for i = 1, GetNumQuestChoices() do
		link = GetQuestItemLink("choice", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	for i = 1, GetNumQuestRewards() do
		link = GetQuestItemLink("reward", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
end

function FLT_ScanInventory()
	local bagid, size, slotid, link;
	
	for bagid = 0, 4, 1 do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					FLT_ProcessLinks(link);
				end
			end
		end
	end
end

function FLT_ScanAuction()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local auctionid, link;

	if( numBatchAuctions > 0 ) then
		for auctionid = 1, numBatchAuctions do
			link = GetAuctionItemLink("list", auctionid);
			if( link ) then
				FLT_ProcessLinks(link);
			end
		end
	end
end

function FLT_ScanBank()
	local index, bagid, size, slotid, link;
	local lBankBagIDs = { BANK_CONTAINER, 5, 6, 7, 8, 9, 10, };
	
	for index, bagid in lBankBagIDs do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					FLT_ProcessLinks(link);
				end
			end
		end
	end
end

function FLT_LinkifyName(head, text, tail)
	if (head ~= "|h" and tail ~= "|h") then -- only linkify things text that isn't linked already
		local link = FLT_GetLinkByName(text);
		if (link) then return link; end
	end
	return head.."["..text.."]"..tail;
end

function FLT_FindInItemTooltip(text, link)
	LinkeratorTip:ClearLines();
	LinkeratorTip:SetHyperlink(link);
	for lineNum = 1, LinkeratorTip:NumLines() do
		local leftText = getglobal("LinkeratorTipTextLeft"..lineNum):GetText();
		if (leftText and string.find(string.lower(leftText), text)) then return true; end
		local rightText = getglobal("LinkeratorTipTextRight"..lineNum):GetText();
		if (rightText and string.find(string.lower(rightText), text)) then return true; end
	end
	for lineNum = 1, LinkeratorTip:NumLines() do
		-- for some reason ClearLines alone isn't clearing the right-side text
		getglobal("LinkeratorTipTextLeft"..lineNum):SetText(nil);
		getglobal("LinkeratorTipTextRight"..lineNum):SetText(nil);
	end
end

function FLT_ParseChatMessage(text)
	return string.gsub(text, "([|]?[h]?)%[(.-)%]([|]?[h]?)", FLT_LinkifyName);
end

-- Hooks

FLT_Orig_ChatEdit_OnTextChanged = ChatEdit_OnTextChanged;
function ChatEdit_OnTextChanged()
    local text = this:GetText();
	if (string.find(text, "^/script") or string.find(text, "^/dump")) then
		-- don't parse
	else
	    text = FLT_ParseChatMessage(text);    
		this:SetText(text);
	end
	FLT_Orig_ChatEdit_OnTextChanged(this);
end

FLT_Orig_QuestLog_UpdateQuestDetails = QuestLog_UpdateQuestDetails;
function QuestLog_UpdateQuestDetails()
	for i = 1, GetNumQuestLogChoices() do
		link = GetQuestLogItemLink("choice", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	for i = 1, GetNumQuestLogRewards() do
		link = GetQuestLogItemLink("reward", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	FLT_Orig_QuestLog_UpdateQuestDetails();
end
