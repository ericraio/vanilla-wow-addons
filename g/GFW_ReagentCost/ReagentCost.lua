------------------------------------------------------
-- ReagentCost.lua
------------------------------------------------------
FRC_VERSION = "11200.1";
------------------------------------------------------

FRC_Config = { };
FRC_Config.Enabled = true;
FRC_Config.MinProfitRatio = 0;
FRC_Config.MinProfitMoney = nil;
FRC_Config.AutoLoadPriceSource = nil;

FRC_ReagentLinks = { };

local MIN_SCANS = 35; -- times an item must be seen at auction to be considered a good sample (equates to 100% on our confidence scale)
local MIN_CONFIDENCE = 5; -- cutoff so we don't report items we have little data on as potentially profitable
local MIN_OVERRIDE_CONFIDENCE = 90; -- cutoff for trusting an item's market price versus the price of its components

-- Anti-freeze code borrowed from ReagentInfo (in turn, from Quest-I-On):
-- keeps WoW from locking up if we try to scan the tradeskill window too fast.
FRC_TradeSkillLock = { };
FRC_TradeSkillLock.NeedScan = false;
FRC_TradeSkillLock.Locked = false;
FRC_TradeSkillLock.EventTimer = 0;
FRC_TradeSkillLock.EventCooldown = 0;
FRC_TradeSkillLock.EventCooldownTime = 1;
FRC_CraftLock = { };
FRC_CraftLock.NeedScan = false;
FRC_CraftLock.Locked = false;
FRC_CraftLock.EventTimer = 0;
FRC_CraftLock.EventCooldown = 0;
FRC_CraftLock.EventCooldownTime = 1;

function FRC_CraftFrame_SetSelection(id)
	FRC_Orig_CraftFrame_SetSelection(id);
	
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

	local costText;
	if (FRC_Config.Enabled) then
		local itemLink = GetCraftItemLink(id);
		if not (itemLink) then
			itemLink = craftName; -- Some enchanting formulae produce items (runed rods), most don't. Enchants don't link, items do.
		end
		itemLink = FRC_NormalizeLink(itemLink);
		local materialsTotal, confidenceScore = FRC_MaterialsCost(name, itemLink);
		costText = GFWUtils.LtY("(Total cost: ");
		if (materialsTotal == nil) then
			if (FRC_PriceSource == "Auctioneer" and not IsAddOnLoaded("Auctioneer")) then
				costText = costText .. GFWUtils.Gray("[Auctioneer not loaded]");
			else
				costText = costText .. GFWUtils.Gray("Unknown [insufficient data]");
			end
		else
			costText = costText .. GFWUtils.TextGSC(materialsTotal) ..GFWUtils.Gray(" Confidence: "..confidenceScore.."%");
		end
		costText = costText ..GFWUtils.LtY(")");

		CraftReagentLabel:SetText(SPELL_REAGENTS.." "..costText);
		CraftReagentLabel:Show();
	end
	
end

function FRC_TradeSkillFrame_SetSelection(id)
	FRC_Orig_TradeSkillFrame_SetSelection(id);
	
	if ( not id ) then
		return;
	end
	local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(id);
	if ( skillType == "header" ) then
		return;
	end
	local skillLineName, skillLineRank, skillLineMaxRank = GetTradeSkillLine();
	
	local costText;
	if (FRC_Config.Enabled) then
		local link = GetTradeSkillItemLink(id);
		if (link == nil) then return; end
		link = FRC_NormalizeLink(link);
		
		local materialsTotal, confidenceScore = FRC_MaterialsCost(skillLineName, GetTradeSkillItemLink(id));
		costText = GFWUtils.LtY("(Total cost: ");
		if (materialsTotal == nil) then
			if (FRC_PriceSource == "Auctioneer" and not IsAddOnLoaded("Auctioneer")) then
				costText = costText .. GFWUtils.Gray("[Auctioneer not loaded]");
			else
				costText = costText .. GFWUtils.Gray("Unknown [insufficient data]");
			end
		else
			costText = costText .. GFWUtils.TextGSC(materialsTotal) ..GFWUtils.Gray(" Confidence: "..confidenceScore.."%");
		end
		costText = costText ..GFWUtils.LtY(")");

		TradeSkillReagentLabel:SetText(SPELL_REAGENTS.." "..costText);
		TradeSkillReagentLabel:Show();
	end
	
end

function FRC_TradeSkillFrame_Update()
	FRC_Orig_TradeSkillFrame_Update();
	
	FRC_ScanTradeSkill();
end

function FRC_CraftFrame_Update()
	FRC_Orig_CraftFrame_Update();
	
	FRC_ScanCraft();
end

function FRC_OnLoad()
	
	-- Register Slash Commands
	SLASH_FRC1 = "/reagentcost";
	SLASH_FRC2 = "/rc";
	SlashCmdList["FRC"] = function(msg)
		FRC_ChatCommandHandler(msg);
	end
	
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("Auctioneer");
	if (loadable or IsAddOnLoaded("Auctioneer")) then
		FRC_PriceSource = "Auctioneer";
	elseif (KC_Auction ~= nil) then
		FRC_PriceSource = "KC_Items";
	elseif (AuctionMatrix_Version ~= nil) then			
		FRC_PriceSource = "AuctionMatrix";
    elseif (WOWEcon_Enabled ~= nil) then
		FRC_PriceSource = "WOWEcon_PriceMod";
	end
	
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_UPDATE");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	
	GFWUtils.Print("Fizzwidget Reagent Cost "..FRC_VERSION.." initialized!");

end

function FRC_OnUpdate(elapsed)
	-- If it's been more than a second since our last tradeskill update,
	-- we can allow the event to process again.
	FRC_TradeSkillLock.EventTimer = FRC_TradeSkillLock.EventTimer + elapsed;
	if (FRC_TradeSkillLock.Locked) then
		FRC_TradeSkillLock.EventCooldown = FRC_TradeSkillLock.EventCooldown + elapsed;
		if (FRC_TradeSkillLock.EventCooldown > FRC_TradeSkillLock.EventCooldownTime) then

			FRC_TradeSkillLock.EventCooldown = 0;
			FRC_TradeSkillLock.Locked = false;
		end
	end
	FRC_CraftLock.EventTimer = FRC_CraftLock.EventTimer + elapsed;
	if (FRC_CraftLock.Locked) then
		FRC_CraftLock.EventCooldown = FRC_CraftLock.EventCooldown + elapsed;
		if (FRC_CraftLock.EventCooldown > FRC_CraftLock.EventCooldownTime) then

			FRC_CraftLock.EventCooldown = 0;
			FRC_CraftLock.Locked = false;
		end
	end
	
	if (FRC_TradeSkillLock.NeedScan) then
		FRC_TradeSkillLock.NeedScan = false;
		FRC_ScanTradeSkill();
	end
	if (FRC_CraftLock.NeedScan) then
		FRC_CraftLock.NeedScan = false;
		FRC_ScanCraft();
	end
end

function FRC_OnEvent(event)
	
	if (event == "ADDON_LOADED" and (arg1 == "Blizzard_CraftUI" or IsAddOnLoaded("Blizzard_CraftUI"))) then
		if (FRC_Orig_CraftFrame_SetSelection == nil) then
			-- Overrides for displaying info in CraftFrame
			FRC_Orig_CraftFrame_SetSelection = CraftFrame_SetSelection;
			CraftFrame_SetSelection = FRC_CraftFrame_SetSelection;

			-- And for scanning, since it looks like doing it in event handlers is crashy/unreliable now.
			FRC_Orig_CraftFrame_Update = CraftFrame_Update;
			CraftFrame_Update = FRC_CraftFrame_Update;

			GFWUtils.Print("ReagentCost CraftFrame hooks installed.");
		end
	end

	if (event == "ADDON_LOADED" and (arg1 == "Blizzard_TradeSkillUI" or IsAddOnLoaded("Blizzard_TradeSkillUI"))) then
		if (FRC_Orig_TradeSkillFrame_SetSelection == nil) then
			-- Overrides for displaying info in TradeSkillFrame
			FRC_Orig_TradeSkillFrame_SetSelection = TradeSkillFrame_SetSelection;
			TradeSkillFrame_SetSelection = FRC_TradeSkillFrame_SetSelection;

			-- And for scanning, since it looks like doing it in event handlers is crashy/unreliable now.
			FRC_Orig_TradeSkillFrame_Update = TradeSkillFrame_Update;
			TradeSkillFrame_Update = FRC_TradeSkillFrame_Update;
		
			GFWUtils.Print("ReagentCost TradeSkillFrame hooks installed.");
		end
	end

	if ( event == "VARIABLES_LOADED" or event == "ADDON_LOADED" ) then

		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("Auctioneer");
		if ((loadable or IsAddOnLoaded("Auctioneer")) and FRC_PriceSource == nil) then
			FRC_PriceSource = "Auctioneer";
		end
		if (AUCTIONEER_VERSION ~= nil) then
			local _, _, major, minor = string.find(AUCTIONEER_VERSION, "^(%d+)%.(%d+)");
			major, minor = tonumber(major), tonumber(minor);
			if (major ~= nil and major >= 3 and minor ~= nil and minor >= 1) then
				FRC_PriceSource = "Auctioneer";
			end
		end
		return;
	end
	
	if ( event == "TRADE_SKILL_SHOW" or event == "CRAFT_SHOW" and FRC_Config.Enabled) then
	
		if (event == "CRAFT_SHOW" and GetCraftDisplaySkillLine() == nil) then
			-- Beast Training uses the CraftFrame; we can tell when it's up because it doesn't have a skill-level bar.
			-- We don't have anything to do in that case, so let's not try loading Auctioneer and stuff.
			return;		
		end
		
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("Auctioneer");
		if ((loadable or IsAddOnLoaded("Auctioneer")) and FRC_PriceSource == nil) then
			FRC_PriceSource = "Auctioneer";
		end
		if ( FRC_PriceSource == "Auctioneer" and FRC_Config.AutoLoadPriceSource) then
			if (not IsAddOnLoaded("Auctioneer")) then
				local loaded, reason = LoadAddOn("Auctioneer");
				if (not loaded) then
					GFWUtils.Print("Can't load Auctioneer: "..reason);
					return;
				end
			end
		end
		if ( FRC_PriceSource == nil) then
			GFWUtils.Print("ReagentCost: missing required dependency. Can't find Auctioneer, KC_Items, or AuctionMatrix.");
			return;
		end
	end

	if ( event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_UPDATE" ) then

		FRC_ScanTradeSkill();
		
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_UPDATE" ) then
	
		FRC_ScanCraft();
		
	end

end

function FRC_ChatCommandHandler(msg)

	if (FRC_PriceSource == nil) then
		GFWUtils.Print("Fizzwidget Reagent Cost is installed but non-functional; can't find Auctioneer, KC_Items (with auction module), or AuctionMatrix.");
		return;
	end

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Reagent Cost "..FRC_VERSION..":");
		GFWUtils.Print("/reagentcost (or /rc) <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("status").." - Check current settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("reset").." - Reset to default settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("on").." | "..GFWUtils.Hilite("off").." - Toggle displaying info in tradeskill windows.");
		if (FRC_PriceSource == "Auctioneer") then
			GFWUtils.Print("- "..GFWUtils.Hilite("autoload on").." | "..GFWUtils.Hilite("off").." - Control whether to automatically load Auctioneer when showing tradeskill windows.");
		end
		GFWUtils.Print("- "..GFWUtils.Hilite("report [<skillname>]").." - Output a list of the most profitable tradeskill items you can make. (Or only those produced through <skillname>.)");
		GFWUtils.Print("- "..GFWUtils.Hilite("minprofit <number>").." - When reporting, only show items whose estimated profit is <number> or greater. (In copper, so 1g == 10000.)");
		GFWUtils.Print("- "..GFWUtils.Hilite("minprofit <number>%").." - When reporting, only show items whose estimated profit exceeds its cost of materials by <number> percent or more.");
		return;
	end

	if (msg == "version") then
		GFWUtils.Print("Fizzwidget Reagent Cost "..FRC_VERSION);
		return;
	end
		
	-- Check Status
	if ( msg == "status" ) then
		if (FRC_Config.Enabled) then
			GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("is").." displaying materials cost in tradeskill windows.");
			if (FRC_Config.AutoLoadPriceSource) then
				GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("will").." automatically load Auctioneer to show prices in tradeskill windows.");
			else
				GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("will not").." automatically load Auctioneer; prices will not be shown in tradeskill windows until Auctioner is loaded some other way.");
			end
		else
			GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("is not").." displaying materials cost in tradeskill windows.");
		end
		if (FRC_Config.MinProfitMoney == nil) then
			GFWUtils.Print("Reports will only include items whose estimated profit exceeds materials cost by "..GFWUtils.Hilite(FRC_Config.MinProfitRatio.."%").." or more.");
		else
			GFWUtils.Print("Reports will only include items whose estimated profit is "..GFWUtils.TextGSC(FRC_Config.MinProfitMoney).." or greater.");
		end
		return;
	end

	-- Reset Variables
	if ( msg == "reset" ) then
		FRC_Config.Enabled = true;
		FRC_Config.MinProfitRatio = 0;
		FRC_Config.MinProfitMoney = nil;
		GFWUtils.Print("Reagent Cost configuration reset.");
		FRC_ChatCommandHandler("status");
		return;
	end
	
	-- Turn trade info gathering on
	if ( msg == "on" ) then
		FRC_Config.Enabled = true;
		GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("is").." displaying materials cost in tradeskill windows.");
		return;
	end
	
	-- Turn trade info gathering Off
	if ( msg == "off" ) then
		FRC_Config.Enabled = false;
		GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("is not").." displaying materials cost in tradeskill windows.");
		return;
	end

	if ( msg == "autoload on" ) then
		FRC_Config.AutoLoadPriceSource = true;
		GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("will").." automatically load Auctioneer to show prices in tradeskill windows.");
		return;
	end
	if ( msg == "autoload off" ) then
		FRC_Config.AutoLoadPriceSource = nil;
		GFWUtils.Print("Reagent Cost "..GFWUtils.Hilite("will not").." automatically load Auctioneer; prices will not be shown in tradeskill windows until Auctioner is loaded some other way.");
		return;
	end

	local _, _, cmd, args = string.find(msg, "(%w+) *(.*)");
	if ( cmd == "minprofit" ) then

		local _, _, number, isPercent = string.find(msg, "minprofit (-*%d+)(%%*)");
		if (number == nil) then
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/rc minprofit <number>[%]"));
			return;
		end
		if (isPercent == "%") then
			FRC_Config.MinProfitRatio = tonumber(number);
			FRC_Config.MinProfitMoney = nil;
			GFWUtils.Print("Reports will only include items whose estimated profit exceeds materials cost by "..GFWUtils.Hilite(FRC_Config.MinProfitRatio.."%").." or more.");
		else
			FRC_Config.MinProfitRatio = nil;
			FRC_Config.MinProfitMoney = tonumber(number);
			GFWUtils.Print("Reports will only include items whose estimated profit is "..GFWUtils.TextGSC(FRC_Config.MinProfitMoney).." or greater.");
		end
		return;
	end

	if ( ( cmd == "reagents" or cmd == "report" ) and FRC_PriceSource == "Auctioneer") then
		if (not IsAddOnLoaded("Auctioneer")) then
			local loaded, reason = LoadAddOn("Auctioneer");
			if (not loaded) then
				GFWUtils.Print("Can't load Auctioneer: "..reason);
				return;
			end
		end
	end

	if ( cmd == "reagents" or cmd == "report" ) then
		
		-- check second arg
		local _, _, arg1, moreArgs = string.find(args, "(%w+) *(.*)");
		local scope = "toon";
		if (arg1 == "all") then
			scope = "realm";
			args = moreArgs;
		elseif (arg1 == "allrealms") then
			scope = "all";
			args = moreArgs;
		end
		
		-- parse skill names from args
		local mySkills = { };
		if (args ~= nil and args ~= "") then
			for word in string.gfind(args, "[^%s]+") do
				local niceWord = string.upper(string.sub(word, 1, 1))..string.sub(word, 2);
				table.insert(mySkills, niceWord);
			end
		end
		
		-- if no args, use the skills this character knows
		if (table.getn(mySkills) == 0) then
			for skillIndex = 1, GetNumSkillLines() do
				local skillName, _, _, _, _, _, _, isAbandonable = GetSkillLineInfo(skillIndex);
				if (isAbandonable) then
					table.insert(mySkills, skillName);
				end
			end
		end
		
		local printList;
		if (cmd == "report") then
			printList = FRC_ReportForSkill;
		elseif (cmd == "reagents") then
			printList = FRC_ListAllReagents;
		end
		for _, skillName in mySkills do
			printList(skillName, scope);
		end
		
		return;
	end
	
	_, _, itemLink = string.find(msg, "(|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r)");
	if (itemLink ~= nil and itemLink ~= "") then
		itemLink = FRC_NormalizeLink(itemLink);
		if (not IsAddOnLoaded("Auctioneer")) then
			local loaded, reason = LoadAddOn("Auctioneer");
			if (not loaded) then
				GFWUtils.Print("Can't load Auctioneer: "..reason);
				return;
			end
		end
		local found = false;
		for skillName, skillTable in FRC_ReagentLinks do
			if (skillTable[itemLink] ~= nil) then
				for recipe, reagentList in skillTable[itemLink] do
					if (string.find(itemLink, "%["..recipe.."%]")) then
						GFWUtils.Print(itemLink.." ("..skillName.."):");
					else
						GFWUtils.Print(itemLink.." ("..skillName.." - "..recipe.."):");
					end
					found = true;
					for _, reagentInfo in reagentList do
						if (type(reagentInfo) == "table") then
							local price, confidence, isAdjusted = FRC_AdjustedCost(skillName, reagentInfo.link);						
							local adjustedText, confidenceText;
							if (isAdjusted) then
								adjustedText = "(based on component prices)";
							else
								adjustedText = "";
							end
							if (confidence < 0) then
								confidenceText = "from vendor";
							else
								confidenceText = confidence.."%"
							end
							if (price ~= nil) then
								GFWUtils.Print(GFWUtils.Hilite(reagentInfo.count.."x ")..reagentInfo.link..": "..GFWUtils.TextGSC(price * reagentInfo.count)..GFWUtils.Gray(" ("..confidenceText..") ")..adjustedText);
							else
								GFWUtils.Print(GFWUtils.Hilite(reagentInfo.count.."x ")..reagentInfo.link..": No price data");
							end
						end
					end
				
					local itemPrice, itemConfidence = FRC_TypicalItemPrice(itemLink);
					local materialsCost, matsConfidence = FRC_MaterialsCostForRecipe(skillName, itemLink, recipe);
					local profit = itemPrice - materialsCost;
					local profitText;
					if (profit > 0) then
						profitText = "profit ".. GFWUtils.TextGSC(profit);
					elseif (profit == 0) then
						profitText = GFWUtils.Hilite("(break-even)");
					else
						profitText = GFWUtils.Red("loss ").. GFWUtils.TextGSC(math.abs(profit));
					end
					if (materialsCost ~= nil) then
						GFWUtils.Print("Total materials: "..GFWUtils.TextGSC(materialsCost)..GFWUtils.Gray("("..matsConfidence..")"));
					else
						GFWUtils.Print("Total materials: data not available for one or more reagents");
					end
					if (itemPrice ~= nil) then
						GFWUtils.Print("Auction price: "..GFWUtils.TextGSC(itemPrice)..GFWUtils.Gray("("..itemConfidence..")").."; "..profitText);
					else
						GFWUtils.Print("Auction price: data not available");
					end
				end
			end
		end
		if (not found) then
			GFWUtils.Print(itemLink.." not found in tradeskill data.");
		end
		return;
	end

	
	-- If we get down to here, we got bad input.
	FRC_ChatCommandHandler("help");
end

function FRC_ListAllReagents(skillName, scope)
	local itemsTable = FRC_ReagentLinks[skillName];
	if (itemsTable == nil) then
		if (ReagentData == nil) then
			GFWUtils.Print("Nothing for "..GFWUtils.Hilite(skillName)..".");
		elseif (ReagentData['reversegathering'][skillName] ~= nil) then
			-- do nothing; don't want to barf errors about gathering skills...
		elseif (ReagentData['reverseprofessions'][skillName] ~= nil) then
			GFWUtils.Print("ReagentCost doesn't have information on "..GFWUtils.Hilite(skillName)..". Please open your "..GFWUtils.Hilite(skillName).." window before requesting a report.");
		else
			GFWUtils.Print(GFWUtils.Hilite(skillName).." is not a known profession.");
		end
	else
		local realm = GetRealmName();
		local player = UnitName("player");
		for anItem, recipesTable in itemsTable do
			for recipe, reagentList in recipesTable do
				local known;
				if (scope == "toon") then
					if (FRC_KnownRecipes and FRC_KnownRecipes[realm] and FRC_KnownRecipes[realm][player]) then
						known = GFWTable.KeyOf(FRC_KnownRecipes[realm][player], anItem);
					end
				elseif (scope == "realm") then
					if (FRC_KnownRecipes and FRC_KnownRecipes[realm]) then
						for player, items in FRC_KnownRecipes[realm] do
							if (GFWTable.KeyOf(FRC_KnownRecipes[realm][player], anItem)) then
								known = true;
								break;
							end
						end				
					end
				else
					known = true;
				end				
		
				if (known) then
					local itemString;
					if (string.find(anItem, "%["..recipe.."%]")) then
						itemString = anItem..": ";
					else
						itemString = anItem.." ("..recipe.."): ";
					end
					for _, aReagent in reagentsTable do
						itemString = itemString .. aReagent.count .. "x" .. aReagent.link .. ", ";
					end
					itemString = string.gsub(itemString, ", $", "");
					GFWUtils.Print(itemString);
				end
			end
		end
	end
end

function FRC_ReportForSkill(skillName, scope)
	local knownItems = 0;
	local reliableItems = 0;
	local shownItems = 0;
	local itemsTable = FRC_ReagentLinks[skillName];
	
	if (itemsTable == nil) then
		if (ReagentData == nil) then
			GFWUtils.Print("Nothing for "..GFWUtils.Hilite(skillName)..".");
		elseif (ReagentData['reversegathering'][skillName] ~= nil) then
			-- do nothing; don't want to barf errors about gathering skills...
			if (skillName == ReagentData['gathering']['mining']) then
				-- ...except for Mining, which is also a production skill as far as we're concerned.
				GFWUtils.Print("ReagentCost doesn't have information on "..GFWUtils.Hilite(skillName)..". Please open your "..GFWUtils.Hilite(skillName).." window before requesting a report.");
			end
		elseif (ReagentData['reverseprofessions'][skillName] ~= nil) then
			GFWUtils.Print("ReagentCost doesn't have information on "..GFWUtils.Hilite(skillName)..". Please open your "..GFWUtils.Hilite(skillName).." window before requesting a report.");
		else
			GFWUtils.Print(GFWUtils.Hilite(skillName).." is not a known profession.");
		end
		return;
	end
	
	local reportTable = { }; -- separate report for each skill

	-- first, build a table that includes current Auctioneer prices for composite items
	local realm = GetRealmName();
	local player = UnitName("player");
	for anItem in itemsTable do
		local known;
		if (scope == "toon") then
			if (FRC_KnownRecipes and FRC_KnownRecipes[realm] and FRC_KnownRecipes[realm][player]) then
				known = GFWTable.KeyOf(FRC_KnownRecipes[realm][player], anItem);
			end
		elseif (scope == "realm") then
			if (FRC_KnownRecipes and FRC_KnownRecipes[realm]) then
				for player, items in FRC_KnownRecipes[realm] do
					if (GFWTable.KeyOf(FRC_KnownRecipes[realm][player], anItem)) then
						known = true;
						break;
					end
				end				
			end
		else
			known = true;
		end				

		if (known) then
			-- parse out a link so that we ignore non-auctionable craft recipes (i.e. enchants)
			_, _, itemLink = string.find(anItem, "(|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r)");
			if (itemLink ~= nil and itemLink ~= "") then
				itemLink = FRC_NormalizeLink(itemLink);
				for recipe in FRC_ReagentLinks[skillName][itemLink] do
					knownItems = knownItems + 1;
					local itemPrice, itemConfidence = FRC_TypicalItemPrice(itemLink);
					local materialsCost, matsConfidence = FRC_MaterialsCostForRecipe(skillName, itemLink, recipe);
		
					if (itemConfidence == nil) then itemConfidence = 0; end
					if (matsConfidence == nil) then matsConfidence = 0; end
		
					if (itemConfidence >= MIN_CONFIDENCE and matsConfidence >= MIN_CONFIDENCE) then
						reliableItems = reliableItems + 1;
						local profit = itemPrice - materialsCost;
						table.insert(reportTable, {link=itemLink, recipe=recipe, matsCost=materialsCost, matsConf=matsConfidence, itemPrice=itemPrice, itemConf=itemConfidence, profit=profit});
					end
				end
			end
		end
	end
	

	if (knownItems == 0) then 
		GFWUtils.Print("ReagentCost doesn't have information on "..GFWUtils.Hilite(skillName)..". Please open your "..GFWUtils.Hilite(skillName).." window before requesting a report.");
		return;
	end
	
	if (reliableItems == 0) then 
		GFWUtils.Print("None of the "..GFWUtils.Hilite(knownItems).." items you can make with "..GFWUtils.Hilite(skillName).." have reliable auction price data. (They may not be tradeable.)");
		return;
	end
	
	GFWUtils.Print("Most profitable recipes for "..GFWUtils.Hilite(skillName)..":");

	if (reliableItems > 1) then
		table.sort(reportTable, FRC_SortProfit);
	end
	
	-- and report those that meet our minimum requirements
	for _, reportInfo in reportTable do
		if (FRC_Config.MinProfitRatio and (reportInfo.profit / reportInfo.matsCost * 100) >= FRC_Config.MinProfitRatio) then
			shownItems = shownItems + 1;
			FRC_PrintReportLine(reportInfo);
		elseif (FRC_Config.MinProfitMoney and reportInfo.profit >= FRC_Config.MinProfitMoney) then
			shownItems = shownItems + 1;
			FRC_PrintReportLine(reportInfo);
		end
	end
	GFWUtils.Print(GFWUtils.Hilite(knownItems).." recipes known, "..GFWUtils.Hilite(reliableItems).." with auction data, "..GFWUtils.Hilite(shownItems).." above profit threshold.");

end

function FRC_ScanTradeSkill()
	if (not TradeSkillFrame or not TradeSkillFrame:IsVisible() or FRC_TradeSkillLock.Locked) then return; end
	-- This prevents further update events from being handled if we're already processing one.
	-- This is done to prevent the game from freezing under certain conditions.
	FRC_TradeSkillLock.Locked = true;

	local skillLineName, skillLineRank, skillLineMaxRank = GetTradeSkillLine();
	if not (skillLineName) then
		FRC_TradeSkillLock.NeedScan = true;
		return; -- apparently sometimes we're called too early, this is nil, and all hell breaks loose.
	end
	if (FRC_ReagentLinks == nil) then
		FRC_ReagentLinks = { };
	end
	if (FRC_ReagentLinks[skillLineName] == nil) then
		FRC_ReagentLinks[skillLineName] = { };
	end

	local realm = GetRealmName();
	local player = UnitName("player");
	if (FRC_KnownRecipes == nil) then
		FRC_KnownRecipes = {};
	end
	if (FRC_KnownRecipes[realm] == nil) then
		FRC_KnownRecipes[realm] = {};
	end
	FRC_KnownRecipes[realm][player] = {};
	for id = GetNumTradeSkills(), 1, -1 do 
		-- loop from the bottom up, since the reagents we make for compound items are usually below the recipes that need them
		local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(id);
		if ( skillType ~= "header" ) then				
			local itemLink = GetTradeSkillItemLink(id);
			if (itemLink == nil) then
				FRC_TradeSkillLock.NeedScan = true;
			else
				table.insert(FRC_KnownRecipes[realm][player], itemLink);
				
				FRC_ReagentLinks[skillLineName][itemLink] = { };
				FRC_ReagentLinks[skillLineName][itemLink][skillName] = { };
				for i=1, GetTradeSkillNumReagents(id), 1 do
					local link = GetTradeSkillReagentItemLink(id, i);
					if (link == nil) then
						FRC_ReagentLinks[skillLineName][itemLink][skillName] = nil;
						FRC_TradeSkillLock.NeedScan = true;
						break;
					else
						local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i);
						table.insert(FRC_ReagentLinks[skillLineName][itemLink][skillName], {link=link, count=reagentCount});
					end
				end
			end
		end
	end

end

function FRC_ScanCraft()
	if (not CraftFrame or not CraftFrame:IsVisible() or FRC_CraftLock.Locked) then return; end
	-- This prevents further update events from being handled if we're already processing one.
	-- This is done to prevent the game from freezing under certain conditions.
	FRC_CraftLock.Locked = true;

	-- This is used only for Enchanting
	local skillLineName, rank, maxRank = GetCraftDisplaySkillLine();
	if not (skillLineName) then
		return; -- Hunters' Beast Training also uses the CraftFrame, but doesn't have a SkillLine.
	end
	if (FRC_ReagentLinks == nil) then
		FRC_ReagentLinks = { };
	end
	if (FRC_ReagentLinks[skillLineName] == nil) then
		FRC_ReagentLinks[skillLineName] = { };
	end

	local realm = GetRealmName();
	local player = UnitName("player");
	if (FRC_KnownRecipes == nil) then
		FRC_KnownRecipes = {};
	end
	if (FRC_KnownRecipes[realm] == nil) then
		FRC_KnownRecipes[realm] = {};
	end
	FRC_KnownRecipes[realm][player] = {};
	for id = GetNumCrafts(), 1, -1 do
		if ( craftType ~= "header" ) then
			craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(id);
			local itemLink = GetCraftItemLink(id);
			if (itemLink == nil) then
				itemLink = craftName; -- may be an item, may be a (currently unlinkable) enchant
			end
			if (itemLink == nil) then
				FRC_TradeSkillLock.NeedScan = true;
			else
				table.insert(FRC_KnownRecipes[realm][player], itemLink);
				
				FRC_ReagentLinks[skillLineName][itemLink] = { };
				FRC_ReagentLinks[skillLineName][itemLink][craftName] = { };
				for i=1, GetCraftNumReagents(id), 1 do
					local link = GetCraftReagentItemLink(id, i);
					if (link == nil) then
						FRC_ReagentLinks[skillLineName][itemLink][craftName] = nil;
						FRC_CraftLock.NeedScan = true;
						break;
					else
						local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(id, i);
						table.insert(FRC_ReagentLinks[skillLineName][itemLink][craftName], {link=link, count=reagentCount});
					end
				end
			end
		end
	end
end

function FRC_SortProfit(a, b)
	-- sort by ratio or actual amount based on which we're using as cutoff
	if (FRC_Config.MinProfitRatio ~= nil) then
		return (a.profit / a.matsCost) > (b.profit / b.matsCost);
	else
		return a.profit > b.profit;
	end
end

function FRC_PrintReportLine(reportInfo)
	local reportLine;
	if (string.find(reportInfo.link, "%["..reportInfo.recipe.."%]")) then
		reportLine = reportInfo.link..": ";
	else
		reportLine = reportInfo.link.." ("..reportInfo.recipe.."): ";
	end
	reportLine = reportLine .."materials cost ".. GFWUtils.TextGSC(reportInfo.matsCost) ..GFWUtils.Gray(" ("..reportInfo.matsConf.."%)")..", "
	reportLine = reportLine .."auction price ".. GFWUtils.TextGSC(reportInfo.itemPrice) ..GFWUtils.Gray(" ("..reportInfo.itemConf.."%)")..", "
	if (reportInfo.profit >= 0) then
		reportLine = reportLine .."profit ".. GFWUtils.TextGSC(reportInfo.profit);
	else
		reportLine = reportLine ..GFWUtils.Red("loss ").. GFWUtils.TextGSC(reportInfo.profit);
	end
	GFWUtils.Print(reportLine);
end

function FRC_AdjustedCost(skillName, itemLink)

	local itemPrice, itemConfidence = FRC_TypicalItemPrice(itemLink);
	if (FRC_RecursiveItems == nil) then
		FRC_RecursiveItems = {};
	end
	if (GFWTable.KeyOf(FRC_RecursiveItems, itemLink)) then
		-- avoid infinite recursion
		FRC_RecursiveItems = nil;
		return itemPrice, itemConfidence, false;
	else
		table.insert(FRC_RecursiveItems, itemLink);
	end
	
	-- don't calculate sub-reagent prices for the likes of alchemical transumutes
	-- (recipes that take one reagent also produced by the same skill and produce one other such reagent)
	if (FRC_ReagentLinks[skillName] and FRC_ReagentLinks[skillName][itemLink]) then
		for recipe, reagentsList in FRC_ReagentLinks[skillName][itemLink] do
			if (table.getn(reagentsList) == 1 ) then
				local reagentInfo = reagentsList[1];
				if (reagentInfo.count == 1 and FRC_ReagentLinks[skillName][reagentInfo.link]) then
					return itemPrice, itemConfidence, false;
				end
			end
		end
	end
	
	-- for all other recipes, calculate total cost of reagents which might be produced by the same skill,
	-- and use that amount if it's more reliable. 
	-- (e.g. engineering parts -> base reagents, bolts of cloth -> pieces of cloth)
	local subReagentsPrice, subReagentsConfidence = FRC_MaterialsCost(skillName, itemLink);
	if (subReagentsPrice and subReagentsConfidence) then
		if (not (itemPrice and itemConfidence)) then
			return subReagentsPrice, subReagentsConfidence, true;
		end
		if (subReagentsConfidence >= itemConfidence and itemConfidence < MIN_OVERRIDE_CONFIDENCE and subReagentsPrice < itemPrice) then
			return subReagentsPrice, subReagentsConfidence, true;
		end
	end
	return itemPrice, itemConfidence, false;
end

function FRC_MaterialsCost(skillName, itemLink)
	if (FRC_ReagentLinks[skillName] == nil) then
		return nil, nil;
	end
	if (FRC_ReagentLinks[skillName][itemLink] == nil) then
		return nil, nil;
	end

	local pricesPerRecipe = {};
	for recipe in FRC_ReagentLinks[skillName][itemLink] do
		if (type(recipe) == "string") then
			local cost, confidence = FRC_MaterialsCostForRecipe(skillName, itemLink, recipe);
			if (cost) then
				table.insert(pricesPerRecipe, {cost=cost, confidence=confidence});
			end
		end
	end
	if (table.getn(pricesPerRecipe) == 0) then
		return nil, nil;
	end
	
	local sortCost = function(a,b)
		return a.cost < b.cost;
	end
	local sortConfidence = function(a,b)
		return a.confidence > b.confidence;
	end
	table.sort(pricesPerRecipe, sortConfidence);
	table.sort(pricesPerRecipe, sortCost);
	
	return pricesPerRecipe[1].cost, pricesPerRecipe[1].confidence;
	
end

function FRC_MaterialsCostForRecipe(skillName, itemLink, recipeName)
	local materialsTotal = 0;
	local totalConfidence = 0;
	local numAuctionReagents = 0;
		
	if (FRC_ReagentLinks[skillName] == nil) then
		return nil, nil;
	end
	if (FRC_ReagentLinks[skillName][itemLink] == nil) then
		return nil, nil;
	end
	if (FRC_ReagentLinks[skillName][itemLink][recipeName] == nil) then
		return nil, nil;
	end
	
	for _, reagentInfo in FRC_ReagentLinks[skillName][itemLink][recipeName] do
		local price, confidence = FRC_AdjustedCost(skillName, reagentInfo.link)
		if (price == nil) then
			return nil, nil; -- if any of the reagents is missing price info, we can't calculate a total.
		end
		materialsTotal = materialsTotal + (price * reagentInfo.count);
		if (confidence >= 0) then
			totalConfidence = totalConfidence + confidence;
			numAuctionReagents = numAuctionReagents + 1;
		end		
	end
	local confidenceScore = math.floor((totalConfidence / numAuctionReagents) * 100) / 100;
	
	return materialsTotal, confidenceScore;

end

function FRC_TypicalItemPrice(itemLink)
	if (FRC_PriceSource == "Auctioneer") then
		if (not IsAddOnLoaded("Auctioneer")) then
			if (FRC_Config.AutoLoadPriceSource) then
				local loaded, reason = LoadAddOn("Auctioneer");
				if (not loaded) then
					GFWUtils.Print("Can't load Auctioneer: "..reason);
					return nil;
				end
			else
				return nil;
			end
		end	
		return FRC_AuctioneerItemPrice(itemLink);
	elseif (FRC_PriceSource == "KC_Items") then
		return FRC_KCItemPrice(itemLink);
	elseif (FRC_PriceSource == "AuctionMatrix") then
		return FRC_AuctionMatrixItemPrice(itemLink);
    elseif (FRC_PriceSource == "WOWEcon_PriceMod") then
		return FRC_WOWEcon_PriceModItemPrice(itemLink);
	else
		return nil; 
	end
end

function FRC_AuctioneerItemPrice(itemLink)
	local getUsableMedian = Auctioneer_GetUsableMedian;
	local getHistoricalMedian = Auctioneer_GetItemHistoricalMedianBuyout;
	local getVendorSellPrice = Auctioneer_GetVendorSellPrice;
	if (Auctioneer and Auctioneer.Statistic) then
		getUsableMedian = Auctioneer.Statistic.GetUsableMedian;
		getHistoricalMedian = Auctioneer.Statistic.GetItemHistoricalMedianBuyout;
	end
	if (Auctioneer and Auctioneer.API) then
		getVendorSellPrice = Auctioneer.API.GetVendorSellPrice;
	end
	if (not (getUsableMedian and getHistoricalMedian)) then
		GFWUtils.PrintOnce(GFWUtils.Red("ReagentCost error:").." missing expected Auctioneer API; can't calculate item prices.", 5);
		return nil, nil;
	end
	
	local _, _, itemID, randomProp, enchant = string.find(itemLink, "item:(%d+):(%d+):(%d+):%d+");
	local itemKey = itemID..":"..(randomProp or 0)..":"..(enchant or 0);	
	local medianPrice, medianCount = getUsableMedian(itemKey);
	if (medianPrice == nil) then
		medianPrice, medianCount = getHistoricalMedian(itemKey);
	end
	if (medianCount == nil) then medianCount = 0 end
	
	itemID = tonumber(itemID) or 0;
	local buyFromVendorPrice = 0;
	local sellToVendorPrice = 0;
	if (FRC_VendorPrices[itemID]) then
		buyFromVendorPrice = FRC_VendorPrices[itemID].b;
		sellToVendorPrice = FRC_VendorPrices[itemID].s;
	end
	if (sellToVendorPrice == 0) then
		if (getVendorSellPrice) then
			sellToVendorPrice = getVendorSellPrice(itemID) or 0;
		elseif (Auctioneer_BasePrices ~= nil and Auctioneer_BasePrices[itemID] ~= nil and Auctioneer_BasePrices[itemID].s ~= nil) then
			sellToVendorPrice = Auctioneer_BasePrices[itemID].s or 0;
		end
	end
		
	if (buyFromVendorPrice > 0) then
		return buyFromVendorPrice, -1; -- FRC_VendorPrices lists only the primarily-vendor-bought tradeskill items
	elseif (medianCount == 0 or medianPrice == nil) then
		return sellToVendorPrice * 3, 0; -- generally a good guess for auction price if we don't have real auction data
	else
		return medianPrice, math.floor((math.min(medianCount, MIN_SCANS) / MIN_SCANS) * 1000) / 10; 
	end
end

function FRC_KCItemPrice(itemLink)
	local itemCode = KC_Common:GetCode(itemLink);
	local seen, avgstack, min, bidseen, bid, buyseen, buy = KC_Auction:GetItemData(itemCode);
	local _, _, itemID  = string.find(itemLink, ".Hitem:(%d+):%d+:%d+:%d+.h%[[^]]+%].h");
	itemID = tonumber(itemID) or 0;
	
	local buyFromVendorPrice = 0;
	local sellToVendorPrice = 0;
	if (FRC_VendorPrices[itemID]) then
		buyFromVendorPrice = FRC_VendorPrices[itemID].b;
		sellToVendorPrice = FRC_VendorPrices[itemID].s;
	end
	if (sellToVendorPrice == 0 and KC_SellValue ~= nil) then
		sellToVendorPrice = (KC_Common:GetItemPrices(itemCode) or 0);
	end
	
	--DevTools_Dump({itemLink=itemLink, itemID=itemID, buy=buy, buyseen=buyseen, buyFromVendorPrice=buyFromVendorPrice, sellToVendorPrice=sellToVendorPrice});

	if (buyFromVendorPrice ~= nil and buyFromVendorPrice > 0) then
		return buyFromVendorPrice, -1; -- FRC_VendorPrices lists only the primarily-vendor-bought tradeskill items
	elseif (buy ~= nil and buy > 0) then
		return buy, math.floor((math.min(buyseen, MIN_SCANS) / MIN_SCANS) * 1000) / 10;
	elseif (sellToVendorPrice ~= nil and sellToVendorPrice > 0) then
		return sellToVendorPrice * 3, 0; -- generally a good guess for auction price if we don't have real auction data
	else
		GFWUtils.DebugLog(itemLink.." not found in KC_Auction or vendor-reagent prices list");
		return nil, 0;
	end
end

function FRC_AuctionMatrixItemPrice(itemLink)
	local _, _, itemID, itemName  = string.find(itemLink, ".Hitem:(%d+):%d+:%d+:%d+.h%[([^]]+)%].h");
	local buyFromVendorPrice = 0;
	local sellToVendorPrice = 0;
	itemID = tonumber(itemID) or 0;
	if (FRC_VendorPrices[itemID]) then
		buyFromVendorPrice = FRC_VendorPrices[itemID].b;
		sellToVendorPrice = FRC_VendorPrices[itemID].s;
	end
		
	local buyout, times, storeStack;
	if (itemName ~= nil and itemName ~= "" and AMDB[itemName]) then
		buyout = tonumber(AM_GetMedian(itemName, "abuyout"));
		if (buyout == nil) then
			buyout = tonumber(AuctionMatrix_GetData(itemName, "abuyout"));
		end
		times = tonumber(AuctionMatrix_GetData(itemName, "times"));
		storeStack = tonumber(AuctionMatrix_GetData(itemName, "stack"));
		if (sellToVendorPrice == 0) then
			sellToVendorPrice = tonumber(AuctionMatrix_GetData(itemName, "vendor"));
		end
	end

	--DevTools_Dump({itemLink=itemLink, buyout=buyout, times=times, buyFromVendorPrice=buyFromVendorPrice, sellToVendorPrice=sellToVendorPrice});
		
	if (buyFromVendorPrice ~= nil and buyFromVendorPrice > 0) then
		return buyFromVendorPrice, -1; -- FRC_VendorPrices lists only the primarily-vendor-bought tradeskill items
	elseif (buyout ~= nil and times ~= nil and buyout > 0) then
		local buyoutForOne = buyout;
		if (storeStack ~= nil and storeStack > 0) then
			buyoutForOne = math.floor(buyout/storeStack);
		end
		return buyoutForOne, math.floor((math.min(times, MIN_SCANS) / MIN_SCANS) * 1000) / 10;
	elseif (sellToVendorPrice ~= nil and sellToVendorPrice > 0) then
		return sellToVendorPrice * 3, 0; -- generally a good guess for auction price if we don't have real auction data
	end
	
	GFWUtils.DebugLog(itemLink.." not found in AuctionMatrix or vendor-reagent prices list");
	return nil, 0;
end

function FRC_WOWEcon_PriceModItemPrice(itemLink)
    local medianPrice, medianCount, serverData = WOWEcon_GetAuctionPrice_ByLink(itemLink);
    if (medianCount == nil) then
		medianCount = 0;
	end
        
	local _, _, itemID  = string.find(itemLink, ".Hitem:(%d+):%d+:%d+:%d+.h%[[^]]+%].h");
	itemID = tonumber(itemID) or 0;
			
	local buyFromVendorPrice = 0;
	local sellToVendorPrice = 0;
	if (FRC_VendorPrices[itemID]) then
		buyFromVendorPrice = FRC_VendorPrices[itemID].b;
		sellToVendorPrice = FRC_VendorPrices[itemID].s;
	end
			
	if (sellToVendorPrice == 0) then
		sellToVendorPrice = WOWEcon_GetVendorPrice_ByLink(itemLink);
	end
			
	if (sellToVendorPrice == nil) then sellToVendorPrice = 0 end
			
	if (buyFromVendorPrice > 0) then
		return buyFromVendorPrice, -1; -- FRC_VendorPrices lists only the primarily-vendor-bought tradeskill items
	elseif (medianCount == 0 or medianPrice == nil) then
		return sellToVendorPrice * 3, 0; -- generally a good guess for auction price if we don't have real auction data
	else
		return medianPrice, math.floor((math.min(medianCount, MIN_SCANS) / MIN_SCANS) * 1000) / 10;
	end
end

function FRC_NormalizeLink(link)
	-- we don't care about variations in random-property items, enchants, or unique IDs...
	-- discarding them lets us use the link as both a printable link and a reliable index key.
	return string.gsub(link, "|c(%x+)|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r", "|c%1|Hitem:%2:0:0:0|h[%3]|h|r");
end
