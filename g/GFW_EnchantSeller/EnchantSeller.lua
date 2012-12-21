------------------------------------------------------
-- EnchantSeller.lua
------------------------------------------------------
FES_VERSION = "11200.1";
------------------------------------------------------

FES_Config = { };
FES_Config.Enabled = true;
FES_Config.Markup = 20;
FES_Config.SpamWithPrices = true;
FES_Config.MinPriceForSpam = 100000;
FES_Config.Channel = "Trade";

FES_EnchantHistory = { };
-- Has the following internal structure:
--		REALM = {
--			PLAYER = { -- 
--				ENCHANT_NAME = 
--					PRICE, -- price can be number (copper) or list of item names (starting with number if money is also traded)
--			}
--		}

-- Variables
FES_Trade = { };
FES_Realm = nil;
FES_Player = nil;

-- constants
local GOOD_ENCHANT_HISTORY = 10; -- used for producing confidence ratings in average/median prices from your enchant history

function FES_CraftFrame_SetSelection(id)
	FES_Orig_CraftFrame_SetSelection(id);
	
	if ( not id ) then
		return;
	end
	local name, rank, maxRank = GetCraftDisplaySkillLine();
	if not (name) then
		return;
	end
	local craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(id);
	if ( trainingPointCost and trainingPointCost > 0 ) then
		return;
	end
	if ( craftType == "header" ) then
		return;
	end
	
	local allCount, myCount, allMeanPrice, allMedianPrice = FES_EnchantPriceInfo(craftName);
	local costText;
	if (allCount > 0) then
		costText = "Median price: " .. GFWUtils.TextGSC(allMedianPrice);
		costText = costText .. " Average: " .. GFWUtils.TextGSC(allMeanPrice);
		costText = costText .. GRAY_FONT_COLOR_CODE.." ("..myCount.."/"..allCount.." trades)"..FONT_COLOR_CODE_CLOSE;
	else
		costText = GRAY_FONT_COLOR_CODE.."No trade data"..FONT_COLOR_CODE_CLOSE;
	end
	
	CraftCost:SetTextColor(1.0, 1.0, 0.6);
	CraftCost:SetJustifyH("LEFT");
	CraftCost:SetText(costText);
	CraftCost:Show();
end

function FES_OnLoad()

	-- Register for Events
	this:RegisterEvent("TRADE_ACCEPT_UPDATE");
	this:RegisterEvent("TRADE_CLOSED");
	this:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
	this:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	
	-- Register Slash Commands
	SLASH_FES1 = "/enchantseller";
	SLASH_FES2 = "/es";
	SlashCmdList["FES"] = function(msg)
		FES_ChatCommandHandler(msg);
	end
	
	GFWUtils.Print("Fizzwidget Enchant Seller "..FES_VERSION.." initialized!");

end

function FES_CheckSetup()

	if (FES_Realm == nil) then
		FES_Realm = GetCVar("realmName");
	end
	if (FES_Player == nil) then
		FES_Player = UnitName("player");
	end
	if (FES_EnchantHistory == nil) then
		FES_EnchantHistory = { };
	end

end

function FES_OnEvent(event, arg1)

	if (event == "ADDON_LOADED" and (arg1 == "Blizzard_CraftUI" or IsAddOnLoaded("Blizzard_CraftUI"))) then
		if (FES_Orig_CraftFrame_SetSelection == nil) then
			-- Overrides for displaying info in CraftFrame
			FES_Orig_CraftFrame_SetSelection = CraftFrame_SetSelection;
			CraftFrame_SetSelection = FES_CraftFrame_SetSelection;

			GFWUtils.Print("Enchant Seller CraftFrame hooks installed.");
		end
	end
	
	if ( event == "TRADE_ACCEPT_UPDATE") then
	
		local name, texture, numItems, isUsable, _, enchantment = GetTradePlayerItemInfo(7);
		FES_Trade.PlayerEnchant = enchantment;		
		local name, texture, numItems, isUsable, _, enchantment = GetTradeTargetItemInfo(7);
		FES_Trade.TargetEnchant = enchantment;

		FES_Trade.PlayerMoney = GetPlayerTradeMoney();
		FES_Trade.TargetMoney = GetTargetTradeMoney();
		FES_Trade.PlayerItems= { };
		FES_Trade.TargetItems= { };
		
		for i=1, 6 do
			local name, texture, numItems, isUsable, enchantment = GetTradePlayerItemInfo(i);
			if (name) then
				if (numItems > 1) then
					table.insert(FES_Trade.PlayerItems, numItems.."x["..name.."]");
				else
					table.insert(FES_Trade.PlayerItems, "["..name.."]");
				end
			end
			local name, texture, numItems, isUsable, enchantment = GetTradeTargetItemInfo(i);
			if (name) then
				if (numItems > 1) then
					table.insert(FES_Trade.TargetItems, numItems.."x["..name.."]");
				else
					table.insert(FES_Trade.TargetItems, "["..name.."]");
				end
			end
		end
		return;
		
	elseif ( event == "TRADE_CLOSED") then
		
		if (FES_Trade.PlayerEnchant == nil and FES_Trade.TargetEnchant == nil) then 
			-- nothing is being enchanted, so we dont care about saving info; clear state until another trade happens
			FES_Trade = { };
			return; 
		end
		
		FES_CheckSetup();
		if (FES_EnchantHistory[FES_Realm] == nil) then
			FES_EnchantHistory[FES_Realm] = { };
		end
		
		if (FES_Trade.TargetEnchant) then
		
			if (FES_EnchantHistory[FES_Realm][FES_Player] == nil) then
				FES_EnchantHistory[FES_Realm][FES_Player] = { };
			end
			if not (FES_EnchantHistory[FES_Realm][FES_Player][FES_Trade.TargetEnchant]) then
				FES_EnchantHistory[FES_Realm][FES_Player][FES_Trade.TargetEnchant] = { };
			end
			
			if (table.getn(FES_Trade.TargetItems) > 0 and FES_Trade.TargetMoney > 0) then
				table.insert(FES_Trade.TargetItems, 1, FES_Trade.TargetMoney);
				table.insert(FES_EnchantHistory[FES_Realm][FES_Player][FES_Trade.TargetEnchant], FES_Trade.TargetItems);
			elseif(table.getn(FES_Trade.TargetItems) > 0) then
				table.insert(FES_EnchantHistory[FES_Realm][FES_Player][FES_Trade.TargetEnchant], FES_Trade.TargetItems);
			elseif(FES_Trade.TargetMoney > 0) then
				table.insert(FES_EnchantHistory[FES_Realm][FES_Player][FES_Trade.TargetEnchant], FES_Trade.TargetMoney);
			else
				-- enchanting for free!
				table.insert(FES_EnchantHistory[FES_Realm][FES_Player][FES_Trade.TargetEnchant], 0);
			end
			
			FES_Trade = { };
			return;
		end
		if (FES_Trade.PlayerEnchant) then
		
			if (FES_EnchantHistory[FES_Realm]["_RECEIVED"] == nil) then
				FES_EnchantHistory[FES_Realm]["_RECEIVED"] = { };
			end
			if not (FES_EnchantHistory[FES_Realm]["_RECEIVED"][FES_Trade.PlayerEnchant]) then
				FES_EnchantHistory[FES_Realm]["_RECEIVED"][FES_Trade.PlayerEnchant] = { };
			end
			if (table.getn(FES_Trade.PlayerItems > 0) and FES_Trade.PlayerMoney > 0) then
				table.insert(FES_Trade.PlayerItems, 1, FES_Trade.PlayerMoney);
				table.insert(FES_EnchantHistory[FES_Realm]["_RECEIVED"][FES_Trade.PlayerEnchant], FES_Trade.PlayerItems);
			elseif(table.getn(FES_Trade.PlayerItems) > 0) then
				table.insert(FES_EnchantHistory[FES_Realm]["_RECEIVED"][FES_Trade.PlayerEnchant], FES_Trade.PlayerItems);
			elseif(FES_Trade.PlayerMoney > 0) then
				table.insert(FES_EnchantHistory[FES_Realm]["_RECEIVED"][FES_Trade.PlayerEnchant], FES_Trade.PlayerMoney);
			else
				-- enchanting for free!
				table.insert(FES_EnchantHistory[FES_Realm]["_RECEIVED"][FES_Trade.PlayerEnchant], 0);
			end
			
			FES_Trade = { };
			return;
		end
		
		return;

	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_UPDATE" ) then
				
		local name, rank, maxRank = GetCraftDisplaySkillLine();
		if not (name) then
			return;
		end
		
		FES_PriceCache = { };
		FES_EnchantInfo = { };
		FES_AvailableEnchantsCount = 0;
		for id=1, GetNumCrafts() do
			craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(id);
			local itemLink = GetCraftItemLink(id);
			if not (itemLink) then
				itemLink = craftName; -- Some enchanting formulae produce items, most don't. Enchants don't link, items do.
			end
			local slot, stat, bonus = FES_Parse(craftName, GetCraftDescription(id));
			if (slot and stat) then
				if not (FES_EnchantInfo[slot]) then 
					FES_EnchantInfo[slot] = { };
				end
				if not (FES_EnchantInfo[slot][stat]) then 
					FES_EnchantInfo[slot][stat] = { };
				end
				table.insert(FES_EnchantInfo[slot][stat], {name=craftName, bonus=bonus});
			end
			if (numAvailable > 0) then
				local nicePrice, confidence, matsCost;
				
				if( FRC_PriceSource ~= nil) then
					matsCost, confidence = FRC_MaterialsCost(name, itemLink);
					if (matsCost == nil) then
						return; -- FRC doesn't have data yet.
					end
					local markedUpPrice = matsCost * (1 + (FES_Config.Markup / 100));
					nicePrice = math.floor(markedUpPrice / 500) * 500; -- round down to nearest multiple of 5 silver
				else
					local allCount, myCount, allMeanPrice, allMedianPrice = FES_EnchantPriceInfo(craftName);
					if (allCount > 0) then
						nicePrice = math.floor(allMeanPrice / 500) * 500; -- round down to nearest multiple of 5 silver
						confidence = math.floor((allCount / GOOD_ENCHANT_HISTORY) * 100);
					else
						nicePrice = 0;
						confidence = 0;
					end
				end
				FES_PriceCache[craftName] = {price=nicePrice, conf=confidence};
				FES_AvailableEnchantsCount = FES_AvailableEnchantsCount + 1;
			end
		end
		
		for aSlot, statTable in FES_EnchantInfo do
			table.sort(statTable, FES_SortBonus);
		end
		return;
		
	end
	
end

function FES_Parse(name, text)
	local slot, bonus, stat, type, proc;
	_, _, slot, special = string.find(name, "^Enchant (.+) %- (.+)");
	if not (slot) then
		return; -- must be a rod
	end
	text = string.lower(text);
	
	_, _, proc = string.find(text, "(often)");
	if not (bonus) then
		_, _, bonus, stat = string.find(text, "%d+%% chance .+ (%d+) points .+ (absorption)\.");
	end
	if not (bonus) then
		_, _, bonus, stat = string.find(text, "increase .+ (heal)ing .+ by (%d+)");
	end
	if not (bonus) then
		_, _, bonus, stat = string.find(text, "(%d+) points of (heal)ing");
	end
	if not (bonus) then
		_, _, bonus, stat = string.find(text, "give a*%s*%+*(%d+) (.+)\.");
	end
	if not (bonus) then
		_, _, bonus, stat = string.find(text, "grant a*%s*%+*(%d+) (.+)\.");
	end
	if not (bonus) then
		_, _, bonus, stat = string.find(text, "add a*%s*%+*(%d+) (.+)\.");
	end
	if not (bonus) then
		_, _, bonus, stat = string.find(text, "provide a*%s*%+*(%d+) .+ of (.+)\.");
	end
	if not (bonus) then
		_, _, stat, bonus = string.find(text, "increases* the (.+) of the %w+ by (%d+)\.");
	end
	if not (bonus) then
		_, _, stat, bonus = string.find(text, "the (.+) of the %w+ is increased* by (%d+)\.");
	end
	if not (bonus) then
		_, _, stat, bonus = string.find(text, "increases* the %w+'s (.+) by (%d+)\.");
	end
	if not (bonus) then
		_, _, stat, bonus = string.find(text, "increases* (.+) by (%d+)\.");
	end
	if not (bonus) then
		_, _, bonus, stat, type = string.find(text, "to do %+*(%d+) .+ (damage)(.*)\.");
	end
	if (special and (proc or not bonus)) then
		special = string.gsub(special, "^%s*Minor%s*", "");
		stat = nil;
		bonus = nil;
	end
	
	if (stat) then
		stat = string.gsub(stat, "^%s*to%s*", "");
		stat = string.gsub(stat, "^%s*the%s*", "");
		stat = string.gsub(stat, "^%s*additional%s*", "");
		stat = string.gsub(stat, "%s*skill%s*$", "");
		stat = string.gsub(stat, "%s*bonus%s*$", "");
		stat = string.gsub(stat, "()(resistance) to (%w+).*", "%3 %2");
		stat = string.gsub(stat, "^(all resistance)$", "%1s");
	end
	if (type and type ~= "") then
		type = string.gsub(type, "^%s*to%s*", "");
		type = string.gsub(type, "^%s*against%s*", "");
		stat = stat.."/"..type;
	end
	
	return slot, stat or special, bonus;
end

function FES_SortBonus(a, b)
	return a.bonus > b.bonus;
end

function FES_ChatCommandHandler(msg)

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Enchant Seller "..FES_VERSION..":");
		GFWUtils.Print("/enchantseller /es <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("status").." - Check current settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("reset").." - Reset to default settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("gatherinfo on").." | "..GFWUtils.Hilite("off").." - Toggle storing info when you trade enchants.");
		GFWUtils.Print("- "..GFWUtils.Hilite("price <enchant name>").." - Show price summary for an enchantment.");
		GFWUtils.Print("- "..GFWUtils.Hilite("spam").." - Send a message advertising your currently available enchantments.");
		GFWUtils.Print("- "..GFWUtils.Hilite("whisper <player> [<slot>]").." - Send full enchantments menu to <player> via whisper. If <slot> is included, list only the enchantments for it (e.g. '2h weapon', 'bracer', 'cloak').");
		GFWUtils.Print("- "..GFWUtils.Hilite("channel <name>").." - Set chat channel for use with 'spam'. (Can also be 'say', 'party', etc., or 'self' to echo to chat window silently.)");
		GFWUtils.Print("- "..GFWUtils.Hilite("showprices on").." | "..GFWUtils.Hilite("off").." - Include prices when advertising enchants.");
		GFWUtils.Print("- "..GFWUtils.Hilite("minprice <number>").." - Only advertise enchants you're selling for <number> or more. (In copper, so 1g = 10000.)");
		if (FRC_PriceSource ~= nil) then
			GFWUtils.Print("- "..GFWUtils.Hilite("markup <number>").." - Mark up materials cost by <number> percent when calculating enchant prices.");
		end
		return;
	end
	
	if (msg == "version") then
		GFWUtils.Print("Fizzwidget Enchant Seller "..FAS_VERSION);
		return;
	end
	
	-- Check Status
	if ( msg == "status" ) then
		if (FES_Config.Enabled) then
			GFWUtils.Print("Enchant Seller "..GFWUtils.Hilite("is").." gathering info when you trade.");
		else
			GFWUtils.Print("Enchant Seller "..GFWUtils.Hilite("is not").." gathering info when you trade.");
		end
		GFWUtils.Print("Typing "..GFWUtils.Hilite("/enchantseller spam").." will advertise enchantments to the "..GFWUtils.Hilite(FES_Config.Channel).." channel.");
		if (FES_Config.SpamWithPrices) then
			GFWUtils.Print("Enchant advertisements "..GFWUtils.Hilite("will").." include prices.");
		else
			GFWUtils.Print("Enchant advertisements "..GFWUtils.Hilite("will not").." include prices.");
		end
		GFWUtils.Print("Only enchantments priced at "..GFWUtils.Hilite(FES_AbbreviateMoney(FES_Config.MinPriceForSpam)).." or higher will be advertised.");
		if (FRC_PriceSource ~= nil) then
			GFWUtils.Print("Advertised prices will be marked up "..GFWUtils.Hilite(FES_Config.Markup.."%").." from the calculated materials cost.");
		else
			GFWUtils.Print("Fizzwidget ReagentCost is not installed; features based on calcuated materials cost are disabled.");
		end
		return;
	end

	-- Reset Variables
	if ( msg == "reset" ) then
		FES_Config.Enabled = true;
		FES_Config.Markup = 20;
		FES_Config.SpamWithPrices = true;
		FES_Config.MinPriceForSpam = 10000;
		FES_Config.Channel = "Trade";
		GFWUtils.Print("Enchant Seller configuration reset.");
		FES_ChatCommandHandler("status");
		return;
	end
	
	-- Turn trade info gathering on
	if ( msg == "gatherinfo on" ) then
		FES_Config.Enabled = true;
			GFWUtils.Print("Enchant Seller "..GFWUtils.Hilite("is").." gathering info when you trade.");
		return;
	end
	
	-- Turn trade info gathering Off
	if ( msg == "gatherinfo off" ) then
		FES_Config.Enabled = false;
			GFWUtils.Print("Enchant Seller "..GFWUtils.Hilite("is not").." gathering info when you trade.");
		return;
	end
	
	if ( string.sub(msg, 1, 5) == "price" ) then
		local enchantName = string.sub(msg, 7);
		local allCount, myCount, allMeanPrice, allMedianPrice = FES_EnchantPriceInfo(enchantName);
		if (allCount > 0) then
			if (myCount > 0) then
				GFWUtils.Print(GFWUtils.Hilite(enchantName)..": "..allCount.." sales (".. myCount.." by "..FES_Player..").");
			else
				GFWUtils.Print(GFWUtils.Hilite(enchantName)..": "..allCount.." sales.");
			end
			GFWUtils.Print("Median price: "..FES_GetGSC(allMedianPrice));
			GFWUtils.Print("Average price: "..FES_GetGSC(allMeanPrice));
		else
			GFWUtils.Print("No sales data for "..GFWUtils.Hilite(enchantName)..".");
		end
		return;
	end
		
	-- Turn showing prices in spam on
	if ( msg == "showprices on" ) then
		FES_Config.SpamWithPrices = true;
		GFWUtils.Print("Enchant advertisements "..GFWUtils.Hilite("will").." include prices.");
		return;
	end
	
	-- Turn showing prices in spam off
	if ( msg == "showprices off" ) then
		FES_Config.SpamWithPrices = false;
		GFWUtils.Print("Enchant advertisements "..GFWUtils.Hilite("will not").." include prices.");
		return;
	end

	if ( string.sub(msg, 1, 7) == "channel" ) then
		local channelName = string.sub(msg, 9);
		if (channelName) then
			FES_Config.Channel = channelName;
			GFWUtils.Print("Typing "..GFWUtils.Hilite("/enchantseller spam").." will advertise enchantments to the "..GFWUtils.Hilite(FES_Config.Channel).." channel.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/es channel <name>"));
		end
		return;
	end

	if ( string.sub(msg, 1, 6) == "markup" ) then
		local price = tonumber(string.sub(msg, 8));
		if (price) then
			FES_Config.Markup = price;
			GFWUtils.Print("Advertised prices will be marked up "..GFWUtils.Hilite(FES_Config.Markup.."%").." from the calculated materials cost.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/es markup <number>"));
		end
		return;
	end

	if ( string.sub(msg, 1, 8) == "minprice" ) then
		local price = tonumber(string.sub(msg, 10));
		if (price) then
			FES_Config.MinPriceForSpam = price;
			GFWUtils.Print("Only enchantments priced at "..GFWUtils.Hilite(FES_AbbreviateMoney(FES_Config.MinPriceForSpam)).." or higher will be advertised.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/es minprice <number>"));
		end
		return;
	end

	if ( string.sub(msg, 1, 4) == "spam") then
		local name, rank, maxRank = GetCraftDisplaySkillLine();
		if (not CraftFrame:IsVisible() or not name == "Enchanting") then
			GFWUtils.Print("Please open your Enchanting window so Enchant Seller can be sure to use the most current info.");
			return;
		end
	
		local spam = "Offering Enchants: ";
		local spamLines = { };
		local spamCount = 0;
		for aSlot, statTable in FES_EnchantInfo do
			local slotSpam = "";
			for aStat, enchants in statTable do
				local adStat = FES_Abbreviate(aStat);
				local doneAlready = false;
				for _, enchantInfo in enchants do
					priceInfo = FES_PriceCache[enchantInfo.name];
					if (priceInfo and ((priceInfo.conf > 0 and priceInfo.price >= FES_Config.MinPriceForSpam) or (priceInfo.price == 0)) and not doneAlready) then
						if (enchantInfo.bonus) then
							slotSpam = slotSpam .. "+"..enchantInfo.bonus .." ".. adStat;
						else
							slotSpam = slotSpam .. adStat;
						end
						if (FES_Config.SpamWithPrices and priceInfo.price > 0) then
							slotSpam = slotSpam ..": ".. FES_AbbreviateMoney(priceInfo.price);
						end
						slotSpam = slotSpam .. ", ";
						spamCount = spamCount + 1;
						doneAlready = true;
					end
				end
			end
			if (slotSpam ~= "") then
				slotSpam = string.gsub(slotSpam, ", $", "");
				if (string.len(spam .. aSlot.." ("..slotSpam.."), ") > 255) then
					table.insert(spamLines, spam);
					spam = "";
				end
				spam = spam .. aSlot.." ("..slotSpam.."), ";
			end
		end
		spam = string.gsub(spam, ", $", "");
		local addendum = "";
		if (FES_AvailableEnchantsCount > spamCount and not FES_Config.SpamWithPrices) then
			addendum  = " [PST for prices & lesser enchants]";
		elseif (FES_AvailableEnchantsCount > spamCount) then
			addendum  = " [PST for lesser enchants]";
		elseif ( not FES_Config.SpamWithPrices) then
			addendum  = " [PST for prices]";
		end
		if (string.len(spam .. addendum) > 255) then
			table.insert(spamLines, spam);
			spam = "";
		end
		spam = spam .. addendum;
		table.insert(spamLines, spam);

		for _, spamLine in spamLines do
			if (spamLine ~= "") then
				if (FES_Config.Channel == "self") then
					GFWUtils.Print(spamLine);
				elseif (FES_Config.Channel == "say" or FES_Config.Channel == "guild" or FES_Config.Channel == "party" or FES_Config.Channel == "raid") then
					SendChatMessage(spamLine, string.upper(FES_Config.Channel));
				else
					local channels = {GetChannelList()};
					local channelNum = math.floor(GFWTable.IndexOf(channels, FES_Config.Channel) / 2);
					if (channelNum == 0) then
						GFWUtils.Print("You need to be in a "..GFWUtils.Hilite(FES_Config.Channel).." channel in order to advertise in it.");
					else
						SendChatMessage(spamLine, "CHANNEL", nil, channelNum);
					end
				end
			end
		end
		return;
	end

	if ( string.sub(msg, 1, 7) == "whisper") then
		local _, _, player, slot = string.find(msg, "whisper (%w+)%s*(.*)");
		if (not player) then
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/es whisper <player> [<slot>]"));
			return;
		end
		local name, rank, maxRank = GetCraftDisplaySkillLine();
		if (not CraftFrame:IsVisible() or not name == "Enchanting") then
			GFWUtils.Print("Please open your Enchanting window so Enchant Seller can be sure to use the most current info.");
			return;
		end
		
		local linesSpammed = 0;
		for aSlot, statTable in FES_EnchantInfo do
			if (slot == "" or (slot ~= "" and string.lower(slot) == string.lower(aSlot))) then
				local slotSpam = "";
				for aStat, enchants in statTable do
					local adStat = FES_Abbreviate(aStat);
					for _, enchantInfo in enchants do
						priceInfo = FES_PriceCache[enchantInfo.name];
						if (priceInfo and priceInfo.conf > 0) then
							if (enchantInfo.bonus) then
								slotSpam = slotSpam .. "+"..enchantInfo.bonus .." ".. adStat;
							else
								slotSpam = slotSpam .. adStat;
							end
							slotSpam = slotSpam ..": ".. FES_AbbreviateMoney(priceInfo.price);
							slotSpam = slotSpam .. ", ";
						end
					end
				end
				if (slotSpam ~= "") then
					slotSpam = string.gsub(slotSpam, ", $", "");
					SendChatMessage( aSlot.." ("..slotSpam..")", "WHISPER", nil, player);
					linesSpammed = linesSpammed + 1;
				end
			end
		end
		if (linesSpammed == 0) then
			if (slot ~= nil and slot ~= "") then
				GFWUtils.Print("Couldn't find any currently available enchants for slot "..GFWUtils.Hilite("'"..slot.."'").." to advertise.");
			else
				GFWUtils.Print("Couldn't find any currently available enchants to advertise.");
			end
		end
		return;
	end
end

function FES_Abbreviate(term)
	term = string.lower(term);
	if (term == "strength") then
		return "Str";
	elseif (term == "agility") then
		return "Agi";
	elseif (term == "stamina") then
		return "Stam";
	elseif (term == "intellect") then
		return "Int";
	elseif (term == "spirit") then
		return "Spi";
	elseif (term == "defense") then
		return "Def";
	elseif (term == "speed") then
		return "+run speed";
	else
		if (string.find(term, "damage")) then
			term = string.gsub(term, "damage", "dmg");
		end
		if (string.find(term, "/%w+$")) then
			term = string.gsub(term, "/(%w+)$", " vs %1");
		end
		if (string.find(term, "attack power")) then
			term = string.gsub(term, "attack power", "AP");
		end
		if (string.find(term, "resistance")) then
			term = string.gsub(term, "resistance", "resist");
		end
		return term;
	end
end

function FES_EnchantPriceInfo(enchantName)
	
	FES_CheckSetup();
	
	local myPrices = FES_MyPricesForEnchant(enchantName);
	local myCount = table.getn(myPrices);
	local allPrices = FES_AllRealmPricesForEnchant(enchantName);
	local allCount = table.getn(allPrices);
	
	local allMeanPrice = GFWTable.Mean(allPrices);
	local allMedianPrice = GFWTable.Median(allPrices);
	
	return allCount, myCount, allMeanPrice, allMedianPrice;
end

function FES_MyPricesForEnchant(enchantName)
	local myCashEnchants = { };
	if (FES_EnchantHistory[FES_Realm] and FES_EnchantHistory[FES_Realm][FES_Player]) then
		if (FES_EnchantHistory[FES_Realm][FES_Player][enchantName]) then
			for anIndex, aTrade in FES_EnchantHistory[FES_Realm][FES_Player][enchantName] do
				if (tonumber(aTrade) and aTrade > 0) then
					table.insert(myCashEnchants, aTrade);
				end
			end
		end
	end
	return myCashEnchants;
end

function FES_AllRealmPricesForEnchant(enchantName)
	
	local allCashEnchants = { };
	if (FES_EnchantHistory[FES_Realm]) then
		for aPlayer, playerEnchants in FES_EnchantHistory[FES_Realm] do
			if (playerEnchants[enchantName]) then
				for anIndex, aTrade in playerEnchants[enchantName] do
					if (tonumber(aTrade) and aTrade > 0) then
						table.insert(allCashEnchants, aTrade);
					end
				end
			end
		end
	end
	return allCashEnchants;
end

-- formats money text for gold / silver / copper, in simplified & abbreviated format
function FES_AbbreviateMoney(money)

	if (money == nil) then money = 0; end
	local g = math.floor(money / 10000);
	local s = math.floor((money - (g*10000)) / 100);
	local c = math.floor(money - (g*10000) - (s*100));

	if (g > 0) then
		if (s > 0) then
			if (math.mod(s, 10) == 0) then
				s = s / 10; -- okay, it's not really 's' anymore, but this makes "1.5g" instead of "1.50g" and that's good.
			end
			return g ..".".. s .."g";
		else
			return g .."g";
		end
	elseif (s > 0) then
		return s .."s";
	elseif (c > 0) then
		return c .."c";
	else
		return 0;
	end

end

