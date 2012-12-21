------------------------------------------------------
-- DisenchantPredictor.lua
------------------------------------------------------
FDP_VERSION = "11200.1";
------------------------------------------------------

-- constants
local FDP_DUST = 1;
local FDP_ESSENCE = 2;
local FDP_SHARD = 3;

-- Configuration
FDP_Config = { };
FDP_Config.Tooltip = true;
FDP_Config.Reagents = true;
FDP_Config.Items = true;
FDP_Config.Verbose = true;
FDP_Config.AutoLoot = true;

FDP_ItemIDs = {
	["DUST_STRANGE"]			= 10940;
	["DUST_SOUL"]				= 11083;
	["DUST_VISION"]				= 11137;
	["DUST_DREAM"]				= 11176;
	["DUST_ILLUSION"]			= 16204;

	["ESSENCE_MAGIC_LESSER"]	= 10938;
	["ESSENCE_MAGIC_GREATER"]	= 10939;
	["ESSENCE_ASTRAL_LESSER"]	= 10998;
	["ESSENCE_ASTRAL_GREATER"]	= 11082;
	["ESSENCE_MYSTIC_LESSER"]	= 11134;
	["ESSENCE_MYSTIC_GREATER"]	= 11135;
	["ESSENCE_NETHER_LESSER"]	= 11174;
	["ESSENCE_NETHER_GREATER"]	= 11175;
	["ESSENCE_ETERNAL_LESSER"]	= 16202;
	["ESSENCE_ETERNAL_GREATER"]	= 16203;

	["SHARD_GLIMMER_SMALL"]		= 10978;
	["SHARD_GLIMMER_LARGE"]		= 11084;
	["SHARD_GLOWING_SMALL"]		= 11138;
	["SHARD_GLOWING_LARGE"]		= 11139;
	["SHARD_RADIANT_SMALL"]		= 11177;
	["SHARD_RADIANT_LARGE"]		= 11178;
	["SHARD_BRILLIANT_SMALL"]	= 14343;
	["SHARD_BRILLIANT_LARGE"]	= 14344;

	["NEXUS_CRYSTAL"]			= 20725;
}

-- formula for dust by level: max(1, ceil((level - 10) / 10))
FDP_DustNames = {
	"DUST_STRANGE",		-- 1-20
	"DUST_SOUL",		-- 21-30
	"DUST_VISION",		-- 31-40
	"DUST_DREAM",		-- 41-50
	"DUST_ILLUSION",	-- 51-60
}

-- formula for essence by level: max(1, ceil((level - 5) / 5))
FDP_EssenceNames = {
	"ESSENCE_MAGIC_LESSER",		-- 1-10
	"ESSENCE_MAGIC_GREATER",	-- 11-15
	"ESSENCE_ASTRAL_LESSER",	-- 16-20
	"ESSENCE_ASTRAL_GREATER",	-- 21-25
	"ESSENCE_MYSTIC_LESSER",	-- 26-30
	"ESSENCE_MYSTIC_GREATER",	-- 31-35
	"ESSENCE_NETHER_LESSER",	-- 36-40
	"ESSENCE_NETHER_GREATER",	-- 41-45
	"ESSENCE_ETERNAL_LESSER",	-- 46-50
	"ESSENCE_ETERNAL_GREATER",	-- 51-55 (51-60 is the same)
	"ESSENCE_ETERNAL_GREATER",	-- 56-60 (51-60 is the same)
}
	
-- formula for shard by level: max(1, ceil((level - 15) / 5))
FDP_ShardNames = {
	"SHARD_GLIMMER_SMALL",		-- 1-20
	"SHARD_GLIMMER_LARGE",		-- 21-25
	"SHARD_GLOWING_SMALL",		-- 26-30
	"SHARD_GLOWING_LARGE",		-- 31-35
	"SHARD_RADIANT_SMALL",		-- 36-40
	"SHARD_RADIANT_LARGE",		-- 41-45
	"SHARD_BRILLIANT_SMALL",	-- 46-50
	"SHARD_BRILLIANT_LARGE",	-- 51-55 (51-60 is the same)
	"SHARD_BRILLIANT_LARGE",	-- 56-60 (51-60 is the same)
}

FDP_DustLevels = {
	"1-20", "21-30", "31-40", "41-50", "51-60",
}

FDP_EssenceLevels = {
	"1-10", "11-15", "16-20", "21-25", "26-30", "31-35", "36-40", "41-45", "46-50", "51-60", "51-60",
}
	
FDP_ShardLevels = {
	"1-20", "21-25", "26-30", "31-35", "36-40", "41-45", "46-50", "51-60", "51-60",
}

FDP_WeaponTypes = { "INVTYPE_2HWEAPON", "INVTYPE_WEAPON", "INVTYPE_WEAPONMAINHAND", "INVTYPE_WEAPONOFFHAND", "INVTYPE_RANGED" };
FDP_ArmorTypes = { "INVTYPE_BODY", "INVTYPE_CHEST", "INVTYPE_CLOAK", "INVTYPE_FEET", "INVTYPE_FINGER", "INVTYPE_HAND", "INVTYPE_HEAD", "INVTYPE_HOLDABLE", "INVTYPE_LEGS", "INVTYPE_NECK", "INVTYPE_RANGED", "INVTYPE_ROBE", "INVTYPE_SHIELD", "INVTYPE_SHOULDER", "INVTYPE_TABARD", "INVTYPE_TRINKET", "INVTYPE_WAIST", "INVTYPE_WRIST", };

FDP_COLOR_ARTIFACT = "ffffcc9d"; -- untested, extrapolated from ITEM_QUALITY_COLORS
FDP_COLOR_LEGENDARY = "ffff8000"; -- untested, extrapolated from ITEM_QUALITY_COLORS
FDP_COLOR_EPIC = "ffa335ee";
FDP_COLOR_RARE = "ff0070dd";
FDP_COLOR_UNCOMMON = "ff1eff00";
FDP_COLOR_COMMON = "ffffffff";
FDP_COLOR_POOR = "ff9d9d9d";

FDP_QUALITY_COLORS = { 
	[0] = FDP_COLOR_POOR, 
	[1] = FDP_COLOR_COMMON,
	[2] = FDP_COLOR_UNCOMMON,
	[3] = FDP_COLOR_RARE,
	[4] = FDP_COLOR_EPIC,
	[5] = FDP_COLOR_LEGENDARY,
	[6] = FDP_COLOR_ARTIFACT,
};

local function FDP_Tooltip_Hook(frame, name, link)
	if ( FDP_Config.Tooltip and link ~= nil) then
		
		local _, _, itemID = string.find(link, "item:(%d+):%d+:%d+:%d+");
		if (itemID == nil or tonumber(itemID) == nil) then return false; end
		itemID = tonumber(itemID);
		if (GFWTable.KeyOf(FDP_Exceptions, itemID)) then
			return false;
		end

		if (FDP_Config.Reagents) then
			if (FDP_TooltipForReagent(frame, itemID)) then
				return true;
			end
		end
		
		if (FDP_Config.Items) then
			local color, level, kind = FDP_ItemInfoForLink(link);
			if (level ~= nil and level > 0 and kind ~= nil) then
				local dustIndex, essenceIndex, shardIndex = FDP_DisenchantByLevel(level);
				local dustName, essenceName, shardName, crystalName;
				if (color == FDP_COLOR_EPIC and level > 50 ) then
					crystalName  = FDP_DisplayName("NEXUS_CRYSTAL");
					frame:AddLine(FDP_CAN_DIS_TO.." "..crystalName, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
					return true;
				elseif (color == FDP_COLOR_RARE) then
					shardName  = FDP_DisplayName(FDP_ShardNames[shardIndex]);
					if (level > 50) then
						crystalName  = FDP_DisplayName("NEXUS_CRYSTAL");
						if (FDP_Config.Verbose) then
							frame:AddLine(FDP_CAN_DIS_TO, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
							frame:AddLine("  "..shardName.." "..FDP_MOST_LIKELY, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
							frame:AddLine("  "..crystalName.." "..FDP_RARELY, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
						else
							frame:AddLine(FDP_CAN_DIS_TO_SHORT, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
							frame:AddDoubleLine(" ", shardName..crystalName);
						end
					else
						frame:AddLine(FDP_CAN_DIS_TO.." "..shardName, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
					end
					return true;
				elseif (color == FDP_COLOR_UNCOMMON) then
					dustName = FDP_DisplayName(FDP_DustNames[dustIndex]);
					essenceName = FDP_DisplayName(FDP_EssenceNames[essenceIndex]);
					shardName  = FDP_DisplayName(FDP_ShardNames[shardIndex]);
					if (FDP_Config.Verbose) then
						frame:AddLine(FDP_CAN_DIS_TO, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
						frame:AddLine("  "..dustName.." "..FDP_MOST_LIKELY, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
						if (kind == "WEAPON") then
							frame:AddLine("  "..essenceName.." "..FDP_JUST_LIKELY, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
						else
							frame:AddLine("  "..essenceName.." "..FDP_OCCASIONALLY, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);		
						end
						frame:AddLine("  "..shardName.." "..FDP_RARELY, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
					else
						frame:AddDoubleLine(FDP_CAN_DIS_TO_SHORT, shardName, GFW_FONT_COLOR.r, GFW_FONT_COLOR.g, GFW_FONT_COLOR.b);
						frame:AddDoubleLine(" ", essenceName..dustName);
					end
					return true;
				end
			end
		end
	end
	return false;
end

function FDP_TooltipForReagent(frame, itemID)
	
	local identifier = GFWTable.KeyOf(FDP_ItemIDs, itemID);
	if (identifier == nil) then 
		return false; -- not an itemID we care about
	end
	if (identifier == "NEXUS_CRYSTAL") then 
		frame:AddLine(FDP_NEXUS_CAN_DIS_FROM_1, 0.7,0.7,0.7);
		frame:AddLine(FDP_NEXUS_CAN_DIS_FROM_2, 0.7,0.7,0.7);
		return true;
	end
	
	local kind, levelRange;
	local namesTables = {FDP_DustNames, FDP_EssenceNames, FDP_ShardNames};
	local levelTables = {FDP_DustLevels, FDP_EssenceLevels, FDP_ShardLevels};
	for tableID, aTable in namesTables do
		local index = GFWTable.KeyOf(aTable, identifier);
		if (index ~= nil) then
			levelRange = levelTables[tableID][index];
			kind = tableID;
			break;
		end
	end

	if (kind ~= nil) then
		frame:AddLine(string.format(FDP_CAN_DIS_FROM_FORMAT, levelRange), 0.7,0.7,0.7);
		if (FDP_Config.Verbose) then
			if (kind == FDP_SHARD) then
				frame:AddLine(FDP_SHARD_VERBOSE, 0.7,0.7,0.7);
			elseif (kind == FDP_ESSENCE) then
				frame:AddLine(FDP_ESSENCE_VERBOSE, 0.7,0.7,0.7);
			elseif (kind == FDP_DUST) then
				frame:AddLine(FDP_DUST_VERBOSE, 0.7,0.7,0.7);
			end
		end
		return true;
	end
end

function FDP_OnLoad()

	-- Register Slash Commands
	SLASH_FDP1 = "/enchant";
	SLASH_FDP2 = "/disenchant";
	SLASH_FDP3 = "/ench";
	SLASH_FDP4 = "/dis";
	SLASH_FDP5 = "/de";
	SLASH_FDP6 = "/dp";
	SlashCmdList["FDP"] = function(msg)
		FDP_ChatCommandHandler(msg);
	end
		
	GFWTooltip_AddCallback("GFW_DisenchantPredictor", FDP_Tooltip_Hook);
	
	DisenchantPredictorFrame:RegisterEvent("LOOT_OPENED");	

	GFWUtils.Print("Fizzwidget Disenchant Predictor "..FDP_VERSION.." initialized!");
end

local LootOpenedTime = 0;
local MIN_TRY_AGAIN_TIME = 1;

function FDP_OnEvent(event, arg1)
	if (event == "LOOT_OPENED") then
		if (GetTime() - LootOpenedTime < MIN_TRY_AGAIN_TIME) then
			return; -- UIParent likes to get lost in infinite recursion...
		end
		LootOpenedTime = GetTime();

		if (FDP_Config.AutoLoot and LootFrame:IsVisible()) then
			for slot = 1, GetNumLootItems() do
				if (LootSlotIsCoin(slot)) then
					return; -- coins don't come from disenchanting.
				else
					local link = GetLootSlotLink(slot);
					if (link == nil) then 
						return; 
					end
					local _, _, itemID = string.find(link, "item:(%d+):%d+:%d+:%d+");
					if (itemID == nil or tonumber(itemID) == nil) then 
						return; 
					end
					itemID = tonumber(itemID);
					local identifier = GFWTable.KeyOf(FDP_ItemIDs, itemID);
					if (identifier == nil) then 
						return; -- if it's not one of our known disenchanted reagents, we probably didn't get here by disenchanting.
					end
				end
			end
			CloseLoot(); -- closing the loot window, if it's from disenchanting, automatically loots the items.
		end
	end
end

function FDP_ChatCommandHandler(msg)

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Disenchant Predictor "..FDP_VERSION..":");
		GFWUtils.Print("/enchant (or /ench or /disenchant or /dis or /de)");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - "..FDP_HELP_HELP);
		GFWUtils.Print("- "..GFWUtils.Hilite("status").." - "..FDP_HELP_STATUS);
		GFWUtils.Print("- "..GFWUtils.Hilite("reagents on").." | "..GFWUtils.Hilite("off").." - "..FDP_HELP_REAGENTS);
		GFWUtils.Print("- "..GFWUtils.Hilite("items on").." | "..GFWUtils.Hilite("off").." - "..FDP_HELP_ITEMS);
		GFWUtils.Print("- "..GFWUtils.Hilite("tooltip on").." | "..GFWUtils.Hilite("off").." - "..FDP_HELP_TOOLTIP);
		GFWUtils.Print("- "..GFWUtils.Hilite("verbose on").." | "..GFWUtils.Hilite("off").." - "..FDP_HELP_VERBOSE);
		GFWUtils.Print("- "..GFWUtils.Hilite("autoloot on").." | "..GFWUtils.Hilite("off").." - "..FDP_HELP_AUTOLOOT);
		GFWUtils.Print("- "..GFWUtils.Hilite(FDP_CMD_NUMBER).." - "..FDP_HELP_NUMBER);
		GFWUtils.Print("- "..GFWUtils.Hilite(FDP_CMD_LINK).." - "..FDP_HELP_LINK);
		return;
	end
	
	if (msg == "version") then
		GFWUtils.Print("Fizzwidget Disenchant Predictor "..FDP_VERSION);
		return;
	end
	
	if (msg == "reagents on") then
		FDP_Config.Reagents = true;
		FDP_Config.Tooltip = true;
		GFWUtils.Print(FDP_STATUS_REAGENTS_ON);
		return;
	end
	if (msg == "reagents off") then
		FDP_Config.Reagents = false;
		GFWUtils.Print(FDP_STATUS_REAGENTS_OFF);
		return;
	end
	if (msg == "items on") then
		FDP_Config.Items = true;
		FDP_Config.Tooltip = true;
		GFWUtils.Print(FDP_STATUS_ITEMS_ON);
		return;
	end
	if (msg == "items off") then
		FDP_Config.Items = false;
		GFWUtils.Print(FDP_STATUS_ITEMS_OFF);
		return;
	end
	if (msg == "tooltip on") then
		FDP_Config.Tooltip = true;
		GFWUtils.Print(FDP_STATUS_TOOLTIP_ON);
		return;
	end
	if (msg == "tooltip off") then
		FDP_Config.Tooltip = false;
		GFWUtils.Print(FDP_STATUS_TOOLTIP_OFF);
		return;
	end
	if (msg == "verbose on") then
		FDP_Config.Verbose = true;
		GFWUtils.Print(FDP_STATUS_VERBOSE_ON);
		return;
	end
	if (msg == "verbose off") then
		FDP_Config.Verbose = false;
		GFWUtils.Print(FDP_STATUS_VERBOSE_OFF);
		return;
	end
	if (msg == "autoloot on") then
		FDP_Config.AutoLoot = true;
		GFWUtils.Print(FDP_STATUS_AUTOLOOT_ON);
		return;
	end
	if (msg == "autoloot off") then
		FDP_Config.AutoLoot = false;
		GFWUtils.Print(FDP_STATUS_AUTOLOOT_OFF);
		return;
	end
	
	if ( msg == "status" ) then
		if ( FDP_Config.Tooltip and (FDP_Config.Items or FDP_Config.Reagents)) then
			if (FDP_Config.Items) then
				GFWUtils.Print(FDP_STATUS_ITEMS_ON);
			else
				GFWUtils.Print(FDP_STATUS_ITEMS_OFF);				
			end
			if (FDP_Config.Reagents) then
				GFWUtils.Print(FDP_STATUS_REAGENTS_ON);
				if ( FDP_Config.Verbose ) then
					GFWUtils.Print(FDP_STATUS_VERBOSE_ON);
				else
					GFWUtils.Print(FDP_STATUS_VERBOSE_OFF);
				end
			else
				GFWUtils.Print(FDP_STATUS_REAGENTS_OFF);				
			end
		else
			GFWUtils.Print(FDP_STATUS_TOOLTIP_OFF);
		end
		if ( FDP_Config.AutoLoot ) then
			GFWUtils.Print(FDP_STATUS_AUTOLOOT_ON);
		else
			GFWUtils.Print(FDP_STATUS_AUTOLOOT_OFF);
		end
		return;
	end

	if ( tonumber(msg) ~= nil ) then
		local level = tonumber(msg);
		if (level < 1 or level > 60) then
			GFWUtils.Print(FDP_ERROR_ITEMLEVEL);
		end
		local dustIndex, essenceIndex, shardIndex = FDP_DisenchantByLevel(level);
		GFWUtils.Print(string.format(FDP_ITEM_DIS_BY_LEVEL_FORMAT, GFWUtils.Hilite(level)));
		GFWUtils.Print(FDP_DisplayName(FDP_DustNames[dustIndex]).." "..FDP_DUST_BY_LEVEL_INFO);
		GFWUtils.Print(FDP_DisplayName(FDP_EssenceNames[essenceIndex]).." "..FDP_ESSENCE_BY_LEVEL_INFO);
		GFWUtils.Print(FDP_DisplayName(FDP_ShardNames[shardIndex]).." "..FDP_SHARD_BY_LEVEL_INFO);
		return;
	end
	
	local _, _, link  = string.find(msg, "(.c%x+.Hitem:%d+:%d+:%d+:%d+.h%[[^]]+%].h.r)");
	if (link ~= nil and link ~= "") then

		local _, _, itemID = string.find(link, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[.-%]|h|r");
		if (itemID == nil or tonumber(itemID) == nil) then 
			GFWUtils.Print(string.format(FDP_ERROR_ITEMID_FORMAT, link));
			return; 
		end
		itemID = tonumber(itemID);
		
		local identifier = GFWTable.KeyOf(FDP_ItemIDs, itemID);
		if (identifier == "NEXUS_CRYSTAL") then 
			GFWUtils.Print(link..": "..FDP_NEXUS_CAN_DIS_FROM_1.." "..FDP_NEXUS_CAN_DIS_FROM_2);
			return;
		elseif (identifier ~= nil) then 
			local kind, levelRange;
			local namesTables = {FDP_DustNames, FDP_EssenceNames, FDP_ShardNames};
			local levelTables = {FDP_DustLevels, FDP_EssenceLevels, FDP_ShardLevels};
			for tableID, aTable in namesTables do
				local index = GFWTable.KeyOf(aTable, identifier);
				if (index ~= nil) then
					levelRange = levelTables[tableID][index];
					kind = tableID;
					break;
				end
			end
			if (kind ~= nil) then
				GFWUtils.Print(link..": "..string.format(FDP_CAN_DIS_FROM_FORMAT, levelRange));
				if (FDP_Config.Verbose) then
					if (kind == FDP_SHARD) then
						GFWUtils.Print(FDP_SHARD_VERBOSE);
					elseif (kind == FDP_ESSENCE) then
						GFWUtils.Print(FDP_ESSENCE_VERBOSE);
					elseif (kind == FDP_DUST) then
						GFWUtils.Print(FDP_DUST_VERBOSE);
					end
				end
				return;
			end
		end
		
		if (GFWTable.KeyOf(FDP_Exceptions, itemID)) then
			GFWUtils.Print(string.format(FDP_CANT_DIS_EXCEPTION_FORMAT, link));
			return;
		end
		local color, level, kind = FDP_ItemInfoForLink(link);
		local colorName;
		if (color ~= FDP_COLOR_UNCOMMON and color ~= FDP_COLOR_RARE and color ~= FDP_COLOR_EPIC) then
			GFWUtils.Print(string.format(FDP_CANT_DIS_QUALITY_FORMAT, link));
			return;
		end
		
		if (level ~= nil and level > 0) then
			local dustIndex, essenceIndex, shardIndex = FDP_DisenchantByLevel(level);
			local dustName, essenceName, shardName, crystalName;
			if (color == FDP_COLOR_EPIC and kind ~= nil and level > 50) then
				crystalName = FDP_DisplayName("NEXUS_CRYSTAL");
				GFWUtils.Print(link ..": "..FDP_CAN_DIS_TO.." ".. crystalName);
				return;
			elseif (color == FDP_COLOR_RARE and kind ~= nil) then
				shardName = FDP_DisplayName(FDP_ShardNames[shardIndex]);
				if (level > 50) then
					crystalName = FDP_DisplayName("NEXUS_CRYSTAL");
					GFWUtils.Print(link ..": "..FDP_CAN_DIS_TO);
					GFWUtils.Print(" - "..shardName.." "..FDP_MOST_LIKELY);
					GFWUtils.Print(" - "..crystalName.." "..FDP_RARELY);
				else
					GFWUtils.Print(link ..": "..FDP_CAN_DIS_TO.." "..shardName);
				end
				return;
			elseif (color == FDP_COLOR_UNCOMMON and kind ~= nil) then
				dustName = FDP_DisplayName(FDP_DustNames[dustIndex]);
				essenceName = FDP_DisplayName(FDP_EssenceNames[essenceIndex]);
				shardName = FDP_DisplayName(FDP_ShardNames[shardIndex]);
				GFWUtils.Print(link ..": "..FDP_CAN_DIS_TO);
				GFWUtils.Print(" - "..dustName.." "..FDP_MOST_LIKELY);
				if (kind == "WEAPON") then
					GFWUtils.Print(" - "..essenceName.." "..FDP_JUST_LIKELY);
				else
					GFWUtils.Print(" - "..essenceName.." "..FDP_OCCASIONALLY);		
				end
				GFWUtils.Print(" - "..shardName.." "..FDP_RARELY);
				return;
			end
		else
			if (kind == nil) then
				GFWUtils.Print(string.format(FDP_CANT_DIS_TYPE_FORMAT, link));
				return;
			else
				if (color == FDP_COLOR_EPIC) then
					crystalName = FDP_DisplayName("NEXUS_CRYSTAL");
					GFWUtils.Print(string.format(FDP_NOLEVEL_PURPLE_FORMAT, link, crystalName));
				elseif (color == FDP_COLOR_RARE) then
					GFWUtils.Print(string.format(FDP_NOLEVEL_BLUE_FORMAT, link));
				else -- must be green
					GFWUtils.Print(string.format(FDP_NOLEVEL_GREEN_FORMAT, link));
					if (kind == "WEAPON") then
						GFWUtils.Print(FDP_GENERAL_WEAPON_RULE);
					else
						GFWUtils.Print(FDP_GENERAL_OTHER_RULE);
					end
				end
				return;
			end
		end
		GFWUtils.Print(string.format(FDP_BAIL_FORMAT, link));
		return;
	end
	
	-- If we're this far, we probably have bad input.
	FDP_ChatCommandHandler("help");
end

function FDP_DisenchantByLevel(level)
    local dustIndex = math.max(1, math.ceil((level - 10) / 10));
    local essenceIndex = math.max(1, math.ceil((level - 5) / 5));
    local shardIndex = math.max(1, math.ceil((level - 15) / 5));
    return dustIndex, essenceIndex, shardIndex;
end

-- returns a link if possible, colored localized name otherwise.
function FDP_DisplayName(identifier)
	local itemID = FDP_ItemIDs[identifier];
	if (itemID == nil) then
		return getglobal(identifier); -- shouldn't happen anyways, right?
	end
	
	local colorCode;
	if (identifier == "NEXUS_CRYSTAL") then
		colorCode = FDP_COLOR_EPIC;
	else
		local namesTables = {FDP_DustNames, FDP_EssenceNames, FDP_ShardNames};
		local kind;
		for tableID, aTable in namesTables do
			local index = GFWTable.KeyOf(aTable, identifier);
			if (index ~= nil) then
				kind = tableID;
				break;
			end
		end
		if (kind == FDP_SHARD) then
			colorCode = FDP_COLOR_RARE;
		elseif (kind == FDP_ESSENCE) then
			colorCode = FDP_COLOR_UNCOMMON;
		elseif (kind == FDP_DUST) then
			colorCode = FDP_COLOR_COMMON;
		end
	end
	
	local itemLink = "item:"..itemID..":0:0:0";	
	local localizedName = GetItemInfo(itemLink);
	if (localizedName) then
		return "|c"..colorCode.."|H"..itemLink.."|h["..localizedName.."]|h|r";
	else
		localizedName = getglobal(identifier);
		return "|c"..colorCode..localizedName.."|r";
	end
end

function FDP_ItemInfoForLink(itemLink)
	
	_, _, link = string.find(itemLink, "(item:%d+:%d+:%d+:%d+)");
	if (link == nil or link == "") then 
		return nil; 
	end
	
	local name, link, quality, level, type, subType, stackCount, equipLoc, icon = GetItemInfo(link);	
	local color = FDP_QUALITY_COLORS[quality];
	local skill, kind;
		
	if (GFWTable.KeyOf(FDP_WeaponTypes, equipLoc)) then
		kind = "WEAPON";
	end
	if (GFWTable.KeyOf(FDP_ArmorTypes, equipLoc)) then
		kind = "ARMOR";
	end
	
--[[
	if (kind and level == 0) then
		skill = FDP_TooltipInfoForLink(link);
	end
]]	
	return color, level, kind, skill;
end

function FDP_TooltipInfoForLink(link)
	FDPHiddenTooltip:ClearLines();
	FDPHiddenTooltip:SetHyperlink(link);
	local level, skill, kind;
	if (FDP_ITEM_DURATION_DAYS == nil) then
		FDP_ITEM_DURATION_DAYS = GFWUtils.FormatToPattern(ITEM_DURATION_DAYS);
	end
	if (FDP_ITEM_DURATION_HOURS == nil) then
		FDP_ITEM_DURATION_HOURS = GFWUtils.FormatToPattern(ITEM_DURATION_HOURS);
	end
	if (FDP_ITEM_DURATION_MIN == nil) then
		FDP_ITEM_DURATION_MIN = GFWUtils.FormatToPattern(ITEM_DURATION_MIN);
	end
	if (FDP_ITEM_DURATION_SEC == nil) then
		FDP_ITEM_DURATION_SEC = GFWUtils.FormatToPattern(ITEM_DURATION_SEC);
	end
	if (FDP_ITEM_MIN_LEVEL == nil) then
		FDP_ITEM_MIN_LEVEL = GFWUtils.FormatToPattern(ITEM_MIN_LEVEL);
	end
	if (FDP_ITEM_MIN_SKILL == nil) then
		FDP_ITEM_MIN_SKILL = GFWUtils.FormatToPattern(ITEM_MIN_SKILL);
	end
	for lineNum = 1, FDPHiddenTooltip:NumLines() do
		local leftText = getglobal("FDPHiddenTooltipTextLeft"..lineNum):GetText();
		if (string.find(leftText, FDP_ITEM_DURATION_DAYS) or string.find(leftText, FDP_ITEM_DURATION_HOURS) or string.find(leftText, FDP_ITEM_DURATION_MIN) or string.find(leftText, FDP_ITEM_DURATION_SEC)) then
			return nil; -- items with a duration can't be disenchanted even if we might otherwise think they can.
		end
		local _, _, skillName, skillString = string.find(leftText, FDP_ITEM_MIN_SKILL);
		if (levelString == nil and skillString ~= nil and tonumber(skillString) ~= nil) then
			if (lineNum < 4) then
				kind = "RECIPE"; 
				-- if it's got a skill level on one of the first couple of lines and no armor slot or speed, it's very likely a recipe
			end
			if (skill ~= nil) then
				kind = "RECIPE"; -- if it lists a required skill level more than once, it's almost certainly a recipe
			end
			skill = tonumber(skillString);
		end
	end
	for lineNum = 1, FDPHiddenTooltip:NumLines() do
		-- for some reason ClearLines alone isn't clearing the right-side text
		getglobal("FDPHiddenTooltipTextLeft"..lineNum):SetText(nil);
		getglobal("FDPHiddenTooltipTextRight"..lineNum):SetText(nil);
	end
	--DevTools_Dump({skill=skill, level=level});
	if (kind == "RECIPE") then
		return nil; -- if there's both a skill requirement and a level requirement, it's probably a recipe (which can't be DE'ed)
	end
	return skill;
end

------------------------------------------------------
-- Runtime loading
------------------------------------------------------

FDP_OnLoad();
