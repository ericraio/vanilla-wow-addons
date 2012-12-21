------------------------------------------------------
-- AdSpace.lua
------------------------------------------------------
FAS_VERSION = "11200.2";
------------------------------------------------------

FAS_SPECIAL_VENDOR_COLOR = {r=1.0, g=0.5, b=0.25};
FAS_INDENT = "  ";

FAS_AllClasses = { "PALADIN", "SHAMAN", "MAGE", "PRIEST", "WARLOCK", "WARRIOR", "HUNTER", "ROGUE", "DRUID", "ANY" };

-- Configuration
FAS_Config = { };

FAS_Config_Default = { };
FAS_Config_Default.ShowCost = false;
FAS_Config_Default.PostToRaid = true;

FAS_Config_Default.Recipes = true;
FAS_Config_Default.Librams = true;
FAS_Config_Default.Darkmoon = true;
FAS_Config_Default.AD = true;
FAS_Config_Default.ZG = true;
FAS_Config_Default.AQ20 = true;
FAS_Config_Default.AQ40 = true;

FAS_OptionsText = {
	["Recipes"] = FAS_OPTION_RECIPES,
	["ShowCost"] = FAS_OPTION_RECIPE_COST,
	["Librams"] = FAS_OPTION_LIBRAM,
	["Darkmoon"] = FAS_OPTION_DARKMOON,
	["AD"] = FAS_OPTION_AD,
	["ZG"] = FAS_OPTION_ZG.." "..GFWUtils.Gray(FAS_OPTION_ZG_FACTION),
	["AQ20"] = FAS_OPTION_AQ20.." "..GFWUtils.Gray(FAS_OPTION_AQ20_FACTION),
	["AQ40"] = FAS_OPTION_AQ40.." "..GFWUtils.Gray(FAS_OPTION_AQ40_FACTION),
	["PostToRaid"] = FAS_OPTION_POST_RAID,
};

local function FAS_Tooltip_Hook(frame, name, link, source)
	
	if (link) then
		local _, _, itemID  = string.find(link, "item:(%d+):%d+:%d+:%d+");
		itemID = tonumber(itemID);
		local itemInfo = FAS_ItemInfo[itemID];

		if (FAS_Config.Recipes and itemInfo) then
			if (source == "MERCHANT") then
				return false; -- kinda silly to show merchants who sell this when we're seeing this at a merchant
			end
			local myFaction = UnitFactionGroup("player");
			local vendors = GFWTable.Merge(FAS_VendorInfo[myFaction][itemID], FAS_VendorInfo["Neutral"][itemID]);
			local note = itemInfo.note;
			
			local color;
			local intro;
			if (note) then
				color = FAS_SPECIAL_VENDOR_COLOR;
			else
				color = GFW_FONT_COLOR;
			end
			if (FAS_Config.ShowCost) then
				intro = string.format(SOLD_FOR_PRICE_BY, GFWUtils.TextGSC(itemInfo.b));
			else
				intro = SOLD_BY;
			end
					
			if (table.getn(vendors) > 1) then
				frame:AddLine(intro..":", color.r, color.g, color.b);
				for i, aVendor in vendors do
					local vendorLoc = FAS_VendorLocations[aVendor];
					if (vendorLoc) then
						local vendorName = FAS_Localized[aVendor] or aVendor;
						local vendorLocation = FAS_Localized[vendorLoc] or vendorLoc;
						frame:AddLine(FAS_INDENT..string.format(VENDOR_LOCATION_FORMAT, vendorName, vendorLocation), color.r, color.g, color.b);
					else
						GFWUtils.PrintOnce(GFWUtils.Red("AdSpace "..FAS_VERSION.." error: ").."Can't find location for "..aVendor..". Please report to gazmik@fizzwidget.com.", 60);
						return false;
					end
				end
			elseif (table.getn(vendors) == 1) then
				local vendorLoc = FAS_VendorLocations[vendors[1]];
				if (vendorLoc) then
					local vendorName = FAS_Localized[vendors[1]] or vendors[1];
					local vendorLocation = FAS_Localized[vendorLoc] or vendorLoc;
					frame:AddLine(intro.." "..string.format(VENDOR_LOCATION_FORMAT, vendorName, vendorLocation), color.r, color.g, color.b);
				else
					GFWUtils.PrintOnce(GFWUtils.Red("AdSpace "..FAS_VERSION.." error: ").."Can't find location for "..vendorName..". Please report to gazmik@fizzwidget.com.", 60);
					return false;
				end
			else
				local found = false;
				for _, faction in {"Alliance", "Horde", "Neutral"} do
					if (FAS_VendorInfo[faction][itemID]) then
						found = true;
					end
				end
				if not (found) then
					GFWUtils.PrintOnce(GFWUtils.Red("AdSpace "..FAS_VERSION.." error: ")..link.."("..itemID..") is listed but has no vendors. Please report to gazmik@fizzwidget.com.", 60);
					return false;
				end
			end
			if (note ~= "") then
				frame:AddLine(note, color.r, color.g, color.b);
			end
			return true;
		end
		
		local libramInfo = FAS_LibramInfo[itemID];
		if (FAS_Config.Librams and libramInfo) then
			local color = FAS_SPECIAL_VENDOR_COLOR;
			local returnToName = FAS_Localized[libramInfo.name] or libramInfo.name;
			local returnToLocation = FAS_Localized[FAS_VendorLocations[libramInfo.name]] or FAS_VendorLocations[libramInfo.name];
			local bonus = FAS_Localized[libramInfo.bonus] or libramInfo.bonus;
			frame:AddLine(RETURN_TO.." "..string.format(VENDOR_LOCATION_FORMAT, returnToName, returnToLocation), color.r, color.g, color.b);
			frame:AddLine(string.format(ARCANUM_FORMAT, bonus), color.r, color.g, color.b);
			return true;
		end

		local darkmoonInfo = FAS_DarkmoonInfo[itemID];
		if (FAS_Config.Darkmoon and darkmoonInfo) then
			local color = FAS_SPECIAL_VENDOR_COLOR;
			frame:AddLine(darkmoonInfo, color.r, color.g, color.b);
			return true;
		end

		local tokenInfo = FAS_TokenInfo[itemID];
		if ((FAS_Config.ZG or FAS_Config.AQ20 or FAS_Config.AQ40) and  tokenInfo) then
			local color = FAS_SPECIAL_VENDOR_COLOR;
			local addedLines;
			for _, faction in FAS_TokenFactions do
				local _, _, factionAbbrev = string.find(faction, "(.-)_FACTION");
				if (FAS_Config[factionAbbrev]) then
					local reportLines = {};
					for _, class in FAS_AllClasses do
						if (not (class == "SHAMAN" and UnitFactionGroup("player") == "Alliance") and 
						    not (class == "PALADIN" and UnitFactionGroup("player") == "Horde")) then
							for _, rewardID in tokenInfo do
								local reward = FAS_TokenRewards[rewardID];
								if (reward and reward.class == class and reward.faction == faction) then
									local repNeeded;
									if (reward.rep) then
										repNeeded = getglobal("FACTION_STANDING_LABEL"..reward.rep);
									end
									local reportLine = "";
									reportLine = reportLine .. reward.type;
									if (repNeeded) then
										reportLine = reportLine .. " ("..repNeeded..")";
									end
									reportLine = reportLine .. ", ";
									if (reportLines[class]) then
										reportLines[class] = reportLines[class] .. reportLine;
									else
										reportLines[class] = reportLine;
									end
								end
							end
							if (reportLines[class]) then
								reportLines[class] = string.gsub(reportLines[class], ", $", "");
							end
						end
					end
					if (GFWTable.Count(reportLines) > 0) then
						frame:AddLine(string.format(FAS_FACTION_REWARDS, getglobal(faction)), color.r, color.g, color.b);
						addedLines = true;
						for class, reportLine in reportLines do
							frame:AddLine("  "..getglobal(class)..": "..reportLine, color.r, color.g, color.b);
						end
					end
				end
			end
			if (addedLines) then
				return true;
			end
		end

		for key, tokenSetList in FAS_FactionTokenSets do
			if (FAS_Config[key]) then
				for _, coinSet in tokenSetList do
					local found;
					local otherCoins = {};
					for _, coinID in coinSet do
						if (itemID == coinID) then
							found = true;
						else
							local itemText = FAS_TokenNames[coinID];
							itemText = FAS_Localized[itemText] or itemText;
							table.insert(otherCoins, itemText);
						end
					end
					if (found) then
						local color = FAS_SPECIAL_VENDOR_COLOR;
						frame:AddLine(FAS_TURNIN.." "..getglobal(key.."_FACTION"), color.r, color.g, color.b);
						if (table.getn(otherCoins) > 0) then
							frame:AddDoubleLine(" ", FAS_WITH.." "..table.concat(otherCoins, ", "), color.r, color.g, color.b, color.r, color.g, color.b);
						end
						return true;
					end
				end
			end
		end
	end
	
end

function FAS_OnLoad()

	-- Register Slash Commands
	SLASH_FAS1 = "/adspace";
	SLASH_FAS2 = "/ads";
	SlashCmdList["FAS"] = function(msg)
		FAS_ChatCommandHandler(msg);
	end
	
	-- Register for Events
	this:RegisterEvent("ADDON_LOADED");

	GFWTooltip_AddCallback("GFW_AdSpace", FAS_Tooltip_Hook);

	table.insert(UISpecialFrames,"FAS_OptionsFrame");	

	GFWUtils.Print("Fizzwidget AdSpace "..FAS_VERSION.." initialized!");
end

function FAS_OnEvent(event, arg1)

	-- Save Variables
	if ( event == "ADDON_LOADED" ) then
		if (FAS_Config.Tooltip) then
			for key, value in FAS_Config_Default do
				if (FAS_Config[key] == nil) then
					FAS_Config[key] = FAS_Config_Default[key];
				end
			end
			FAS_Config.Tooltip = nil;
		end
		this:UnregisterEvent("ADDON_LOADED");
	end
end

function FAS_ChatCommandHandler(msg)

	if ( msg == "" ) then
		if FAS_OptionsFrame:IsVisible() then
			HideUIPanel(FAS_OptionsFrame);
		else
			ShowUIPanel(FAS_OptionsFrame);
		end
		return;
	end

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget AdSpace "..FAS_VERSION..":");
		GFWUtils.Print("/adspace (or /ads)");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("[item link]").." - Show info for an item in the chat window.");
		GFWUtils.Print("- "..GFWUtils.Hilite("status").." - Check current settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("recipes on").." | "..GFWUtils.Hilite("off").." - Show info for vendor-supplied recipes in tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("showcost on").." | "..GFWUtils.Hilite("off").." - Also show vendor prices for recipes.");
		GFWUtils.Print("- "..GFWUtils.Hilite("librams on").." | "..GFWUtils.Hilite("off").." - Show info for librams in tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("darkmoon on").." | "..GFWUtils.Hilite("off").." - Show info for Darkmoon Faire grey item turn-ins in tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("zg on").." | "..GFWUtils.Hilite("off").." - Show info for for special raid loot from Zul'Gurub (Zandalar Tribe rewards) in tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("aq20 on").." | "..GFWUtils.Hilite("off").." - Show info for for special raid loot from Ruins of Ahn'Qiraj (Cenarion Circle rewards) in tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("aq40 on").." | "..GFWUtils.Hilite("off").." - Show info for for special raid loot from Ahn'Qiraj (Brood of Nozdormu rewards) in tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("post on").." | "..GFWUtils.Hilite("off").." - Post to raid/party chat when getting raid loot info via "..GFWUtils.Hilite("/ads [item link]")..".");
		return;
	end
	
	if (msg == "version") then
		GFWUtils.Print("Fizzwidget AdSpace "..FAS_VERSION);
		return;
	end
	
	if ( msg == "status" ) then
		local gotSomething;
		if (FAS_Config.Recipes) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("vendor-supplied recipes").." in tooltips.");
			gotSomething = 1;
			if (FAS_Config.ShowCost) then
				GFWUtils.Print("Also showing vendor price for recipes.");
			end
		end
		if (FAS_Config.Librams) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("Librams").." in tooltips.");
			gotSomething = 1;
		end
		if (FAS_Config.Darkmoon) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("Darkmoon Faire grey item turn-ins").." in tooltips.");
			gotSomething = 1;
		end
		if (FAS_Config.ZG) then
			GFWUtils.Print("Showing info for special raid loot from "..GFWUtils.Hilite("Zul'Gurub (Zandalar Tribe rewards)").." in tooltips.");
			gotSomething = 1;
		end
		if (FAS_Config.AQ20) then
			GFWUtils.Print("Showing info for special raid loot from "..GFWUtils.Hilite("Ruins of Ahn'Qiraj (AQ20 Cenarion Circle rewards)").." in tooltips.");
			gotSomething = 1;
		end
		if (FAS_Config.AQ40) then
			GFWUtils.Print("Showing info for special raid loot from "..GFWUtils.Hilite("Ahn'Qiraj (AQ40 Brood of Nozdormu rewards)").." in tooltips.");
			gotSomething = 1;
		end
		if ((FAS_Config.ZG or FAS_Config.AQ20 or FAS_Config.AQ40) and FAS_Config.PostToRaid) then
			GFWUtils.Print("Will post to raid/party chat when showing info for raid loot via "..GFWUtils.Hilite("/ads [link]")..".");
		end
		if (not gotSomething) then
			GFWUtils.Print("Not adding any info to tooltips.");
		end
		return;
	end
	
	if (msg == "test") then
		local itemInfoCount = 0;
		for itemID in FAS_ItemInfo do
			local found = false;
			for _, faction in {"Alliance", "Horde", "Neutral"} do
				if (FAS_VendorInfo[faction][itemID]) then
					found = true;
				end
			end
			if not (found) then
				GFWUtils.Print("Item ID "..itemID.." not found in FAS_VendorInfo.");
			end
			itemInfoCount = itemInfoCount + 1;
		end
		GFWUtils.Print(itemInfoCount.." entries in FAS_ItemInfo.");
		for _, faction in {"Alliance", "Horde", "Neutral"} do
			local vendorInfoCount = 0;
			for itemID in FAS_VendorInfo[faction] do
				if (FAS_ItemInfo[itemID] == nil) then
					GFWUtils.Print("Item ID "..itemID.." not found in FAS_ItemInfo.");
				end
				vendorInfoCount = vendorInfoCount + 1;
			end
			GFWUtils.Print(vendorInfoCount.." entries in FAS_VendorInfo["..faction.."].");
		end
		return;
	end

	local _, _, cmd, args = string.find(msg, "^([%l%d']+) *(.*)");
	if (cmd) then cmd = string.lower(cmd); end
	
	if (cmd == "recipes" or cmd == "recipe") then
		if (args == "on") then
			FAS_Config.Recipes = true;
		elseif (args == "off") then
			FAS_Config.Recipes = nil;
		else
			FAS_Config.Recipes = not FAS_Config.Recipes;
		end
		if (FAS_Config.Recipes) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("vendor-supplied recipes").." in tooltips.");
		else
			GFWUtils.Print(GFWUtils.Red("Not").."showing info for "..GFWUtils.Hilite("vendor-supplied recipes").." in tooltips.");
		end
		return;
	end
	if (cmd == "showcost" or cmd == "cost") then
		if (args == "on") then
			FAS_Config.ShowCost = true;
		elseif (args == "off") then
			FAS_Config.ShowCost = nil;
		else
			FAS_Config.ShowCost = not FAS_Config.ShowCost;
		end
		if (FAS_Config.ShowCost) then
			GFWUtils.Print("Also showing vendor price for recipes.");
		else
			GFWUtils.Print(GFWUtils.Red("Not").."showing vendor price for recipes.");
		end
		return;
	end
	if (cmd == "librams" or cmd == "libram") then
		if (args == "on") then
			FAS_Config.Librams = true;
		elseif (args == "off") then
			FAS_Config.Librams = nil;
		else
			FAS_Config.Librams = not FAS_Config.Librams;
		end
		if (FAS_Config.Librams) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("Librams").." in tooltips.");
		else
			GFWUtils.Print(GFWUtils.Red("Not").."showing info for "..GFWUtils.Hilite("Librams").." in tooltips.");
		end
		return;
	end
	if (cmd == "darkmoon") then
		if (args == "on") then
			FAS_Config.Darkmoon = true;
		elseif (args == "off") then
			FAS_Config.Darkmoon = nil;
		else
			FAS_Config.Darkmoon = not FAS_Config.Darkmoon;
		end
		if (FAS_Config.Darkmoon) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("Darkmoon Faire grey item turn-ins").." in tooltips.");
		else
			GFWUtils.Print(GFWUtils.Red("Not").."showing info for "..GFWUtils.Hilite("Darkmoon Faire grey item turn-ins").." in tooltips.");
		end
		return;
	end
	if (cmd == "zg" or cmd == "zul'gurub" or cmd == "zulgurub" or cmd == "zandalar") then
		if (args == "on") then
			FAS_Config.ZG = true;
		elseif (args == "off") then
			FAS_Config.ZG = nil;
		else
			FAS_Config.ZG = not FAS_Config.ZG;
		end
		if (FAS_Config.ZG) then
			GFWUtils.Print("Showing info for special raid loot from"..GFWUtils.Hilite("Zul'Gurub (Zandalar Tribe rewards)").." in tooltips.");
		else
			GFWUtils.Print(GFWUtils.Red("Not").."showing info for special raid loot from"..GFWUtils.Hilite("Zul'Gurub (Zandalar Tribe rewards)").." in tooltips.");
		end
		return;
	end
	if (cmd == "aq20" or cmd == "cenarion") then
		if (args == "on") then
			FAS_Config.AQ20 = true;
		elseif (args == "off") then
			FAS_Config.AQ20 = nil;
		else
			FAS_Config.AQ20 = not FAS_Config.AQ20;
		end
		if (FAS_Config.AQ20) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("Ruins of Ahn'Qiraj (AQ20)").." special raid loot in tooltips.");
		else
			GFWUtils.Print(GFWUtils.Red("Not").."showing info for "..GFWUtils.Hilite("Ruins of Ahn'Qiraj (AQ20)").." special raid loot in tooltips.");
		end
		return;
	end
	if (cmd == "aq40" or cmd == "brood" or cmd == "nozdormu") then
		if (args == "on") then
			FAS_Config.AQ40 = true;
		elseif (args == "off") then
			FAS_Config.AQ40 = nil;
		else
			FAS_Config.AQ40 = not FAS_Config.AQ40;
		end
		if (FAS_Config.AQ40) then
			GFWUtils.Print("Showing info for "..GFWUtils.Hilite("Ahn'Qiraj (AQ40)").." special raid loot in tooltips.");
		else
			GFWUtils.Print(GFWUtils.Red("Not").."showing info for "..GFWUtils.Hilite("Ahn'Qiraj (AQ40)").." special raid loot in tooltips.");
		end
		return;
	end
	if (cmd == "post" or cmd == "raid" or cmd == "party") then
		if (args == "on") then
			FAS_Config.PostToRaid = true;
		elseif (args == "off") then
			FAS_Config.PostToRaid = nil;
		else
			FAS_Config.PostToRaid = not FAS_Config.PostToRaid;
		end
		if (FAS_Config.PostToRaid) then
			GFWUtils.Print("Will post to raid/party chat when getting info for raid loot via "..GFWUtils.Hilite("/ads [link]")".");
		else
			GFWUtils.Print("Will only print to chat window when getting info for raid loot via "..GFWUtils.Hilite("/ads [link]")".");
		end
		return;
	end
	
	if (args == nil or args == "") then
		args = msg;
	end
	local postedText;
	for itemLink in string.gfind(args, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r") do
		postedText = nil;
		local _, _, itemID  = string.find(itemLink, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[.-%]|h|r");
		if (itemID == nil or itemID == "") then
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/ads info <item link>"));
			return;
		end
		itemID = tonumber(itemID);
		
		local itemInfo = FAS_ItemInfo[itemID];
		if (itemInfo) then
			local myFaction = UnitFactionGroup("player");
			local vendors = GFWTable.Merge(FAS_VendorInfo[myFaction][itemID], FAS_VendorInfo["Neutral"][itemID]);
			local note = itemInfo.note;
			local intro = itemLink..": "..string.format(SOLD_FOR_PRICE_BY, GFWUtils.TextGSC(itemInfo.b));

			if (vendors == nil or vendors == {}) then
				GFWUtils.Print(GFWUtils.Red("AdSpace "..FAS_VERSION.." error: ")..itemLink.."("..itemID..") is listed but has no vendors. Please report to gazmik@fizzwidget.com.");
				return;
			end
			GFWUtils.Print(intro);
			for i, aVendor in vendors do
				local vendorName = FAS_Localized[aVendor] or aVendor;
				local vendorLocation = FAS_Localized[FAS_VendorLocations[aVendor]] or FAS_VendorLocations[aVendor];
				GFWUtils.Print(string.format(VENDOR_LOCATION_FORMAT, vendorName, vendorLocation));
			end
			if (note and note ~= "") then
				GFWUtils.Print(GFWUtils.Hilite(note));
			end
			postedText = 1;
		end
		
		local libramInfo = FAS_LibramInfo[itemID];
		if (libramInfo) then
			local returnToName = FAS_Localized[libramInfo.name] or libramInfo.name;
			local returnToLocation = FAS_Localized[FAS_VendorLocations[libramInfo.name]] or FAS_VendorLocations[libramInfo.name];
			local bonus = FAS_Localized[libramInfo.bonus] or libramInfo.bonus;
			GFWUtils.Print(itemLink..": "..RETURN_TO.." "..string.format(VENDOR_LOCATION_FORMAT, returnToName, returnToLocation));
			GFWUtils.Print(bonus);
			postedText = 1;
		end
		
		local darkmoonInfo = FAS_DarkmoonInfo[itemID];
		if (darkmoonInfo) then
			GFWUtils.Print(itemLink..": "..darkmoonInfo);
			postedText = 1;
		end

		local tokenInfo = FAS_TokenInfo[itemID];
		if (tokenInfo) then
			for _, faction in FAS_TokenFactions do
				local reportLines = {};
				for _, class in FAS_AllClasses do
					for _, rewardID in tokenInfo do
						local reward = FAS_TokenRewards[rewardID];
						if (reward and reward.class == class and reward.faction == faction) then
							local link = GFWUtils.ItemLink(rewardID);
							local repNeeded;
							if (reward.rep) then
								repNeeded = getglobal("FACTION_STANDING_LABEL"..reward.rep);
							end
							local reportLine = "";
							if (link) then
								reportLine = reportLine .. link .. " - ";
							end
							reportLine = reportLine .. reward.type;
							if (repNeeded) then
								reportLine = reportLine .. " ("..repNeeded..")";
							end
							reportLine = reportLine .. ", ";
							if (reportLines[class]) then
								reportLines[class] = reportLines[class] .. reportLine;
							else
								reportLines[class] = reportLine;
							end
						end
					end
					if (reportLines[class]) then
						reportLines[class] = string.gsub(reportLines[class], ", $", "");
					end
				end
				if (GFWTable.Count(reportLines) > 0) then
					local _, _, factionAbbrev = string.find(faction, "(.-)_FACTION");
					postedText = 1;
					if (FAS_Config[factionAbbrev]) then
						FAS_Post(itemLink..": "..string.format(FAS_FACTION_REWARDS, getglobal(faction)));
						for class, reportLine in reportLines do
							FAS_Post("   "..getglobal(class)..": "..reportLine);
						end
					else
						FAS_Post(itemLink..": "..string.format(FAS_FACTION_REWARDS_COUNT, GFWTable.Count(reportLines), getglobal(faction)));
					end
				end
			end
		end

		local rewardInfo = FAS_TokenRewards[itemID];
		if (rewardInfo) then
			local link = GFWUtils.ItemLink(itemID);
			FAS_Post(link..": "..string.format(ITEM_REQ_REPUTATION, getglobal(rewardInfo.faction), getglobal("FACTION_STANDING_LABEL"..rewardInfo.rep)));
			local reportLines = {};
			for tokenID, rewards in FAS_TokenInfo do
				if (GFWTable.KeyOf(rewards, itemID)) then
					local itemText = GFWUtils.ItemLink(tokenID);
					local itemQuality = FAS_TokenQuality[tokenID];
					if (itemText == nil) then
						itemText = FAS_TokenNames[tokenID];
						itemText = FAS_Localized[itemText] or itemText;
						local _, _, _, color = GetItemQualityColor(math.floor(itemQuality));
						itemText = color..itemText..FONT_COLOR_CODE_CLOSE;
					end
					if (rewardInfo == ENSCRIBE) then
						-- ZG enchants take 1 each of any reagent
						itemText = "1 x "..itemText;
					else
						-- other token quests take 1 epic only, or 5 of one green + 5 another green + 2 blue + 1 "special"
						if (itemQuality == 2) then
							itemText = "5 x "..itemText;
						elseif (itemQuality == 3) then
							itemText = "2 x "..itemText;					
						else
							itemText = "1 x "..itemText;
						end
					end
					table.insert(reportLines, itemText);
				end
			end
			table.sort(reportLines);
			for _, line in reportLines do
				FAS_Post(line);
			end	
			postedText = 1;
		end
		
		if (not postedText) then
			GFWUtils.Print("Nothing known about "..itemLink..".");
		end
	end
	if (postedText) then
		return;
	end
	-- if we made it down here, there were args we didn't understand... time to remind the user what to do.
	FAS_ChatCommandHandler("help");

end

function FAS_StripColor(text)
	if (string.find(text, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r")) then
		return text;
	else
		return string.gsub(text, "|c"..string.rep("%x", 8).."(.-)|r", "%1");
	end
end

function FAS_Post(msg)
	if (FAS_Config.PostToRaid and GetNumRaidMembers() > 0) then
		msg = FAS_StripColor(msg);
		SendChatMessage(msg, "RAID");	
	elseif (FAS_Config.PostToRaid and GetNumPartyMembers() > 0) then
		msg = FAS_StripColor(msg);
		SendChatMessage(msg, "PARTY");	
	else
		GFWUtils.Print(msg);
	end
end

function FAS_CheckMerchant(itemID)
	for merchantIndex = 1, GetMerchantNumItems() do
		local link = GetMerchantItemLink(merchantIndex);
		local _, _, merchantItemID  = string.find(link, "item:(%d+):%d+:%d+:%d+");
		if (tonumber(merchantItemID) == itemID) then
			return true;
		end
	end
	return false;
end

function FAS_OptionsShow()

	FAS_VersionText:SetText("v. "..FAS_VERSION);

	for option, description in FAS_OptionsText do
		local button = getglobal("FAS_OptionsButton_"..option);
		local text = getglobal("FAS_OptionsButton_"..option.."Text");
		
		if (button and text) then
			button:SetChecked(FAS_Config[option]);
			text:SetText(description);
		end
	end
	
end

function FAS_OptionsClick()
	local button = this:GetName();
	local option = string.gsub(button, "FAS_OptionsButton_", "");
	FAS_Config[option] = this:GetChecked();
end

-- private, for building localization tables
function FAS_Translate(langCode)

	tempTranslations = {};
	
	local localizedVendorInfo = getglobal("FAS_VendorInfo_"..langCode);
	local localizedVendorLocations = getglobal("FAS_VendorLocations_"..langCode);
	for faction, factionVendorList in FAS_VendorInfo do
		for itemID, vendorList in factionVendorList do
			local localizedVendors = localizedVendorInfo[faction][itemID];
			if (localizedVendors and type(localizedVendors) == "table") then
				for index, name in vendorList do
					local localizedName = localizedVendors[index];
					
					if (localizedName == nil) then break; end
					
					if (localizedName ~= name) then
						if (tempTranslations[name] == nil) then
							tempTranslations[name] = {};
						end
						table.insert(tempTranslations[name], localizedName);
					end
					
					local location = FAS_VendorLocations[name];
					local localizedLocation = localizedVendorLocations[localizedName];
					if (localizedLocation and localizedLocation ~= location) then
						if (tempTranslations[location] == nil) then
							tempTranslations[location] = {};
						end
						table.insert(tempTranslations[location], localizedLocation);
					end
				end
			end
		end
	end
	
	local localizedLibramInfo = getglobal("FAS_LibramInfo_"..langCode);
	for itemID, libramInfo in FAS_LibramInfo do
		local localizedInfo = localizedLibramInfo[itemID];
		if (localizedInfo and type(localizedInfo) == "table") then
					
			if (localizedInfo.name ~= libramInfo.name) then
				if (tempTranslations[libramInfo.name] == nil) then
					tempTranslations[libramInfo.name] = {};
				end
				table.insert(tempTranslations[libramInfo.name], localizedInfo.name);
			end
			if (localizedInfo.bonus ~= libramInfo.bonus) then
				if (tempTranslations[libramInfo.bonus] == nil) then
					tempTranslations[libramInfo.bonus] = {};
				end
				table.insert(tempTranslations[libramInfo.bonus], localizedInfo.bonus);
			end
			
			local location = FAS_VendorLocations[libramInfo.name];
			local localizedLocation = localizedVendorLocations[localizedInfo.name];
			if (localizedLocation and localizedLocation ~= location) then
				if (tempTranslations[location] == nil) then
					tempTranslations[location] = {};
				end
				table.insert(tempTranslations[location], localizedLocation);
			end
		end
	end
	
	FAS_Config[langCode] = {};
	for baseString, translations in tempTranslations do
		if (table.getn(translations) == 1) then
			FAS_Config[langCode][baseString] = translations[1];
		else
			local mergedTranslations = {}
			for _, translation in translations do
				if (GFWTable.KeyOf(mergedTranslations, translation) == nil) then
					table.insert(mergedTranslations, translation);
				end
			end
			if (table.getn(mergedTranslations) == 1) then
				FAS_Config[langCode][baseString] = mergedTranslations[1];
			else
				FAS_Config[langCode][baseString] = mergedTranslations;
			end
		end
	end

end

