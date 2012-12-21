------------------------------------------------------
-- HuntersHelper.lua
------------------------------------------------------
FHH_VERSION = "11000.1";
------------------------------------------------------

-- Saved configuration & info
FHH_Config = { };
FHH_Config.Tooltip = true;

--FHH_AbilityInfo = { };
-- Has the following internal structure:
--		REALM_PLAYER = {
--			SKILL
--		}

-- Runtime state
FHH_State = { };
FHH_State.RealmPlayer = nil;
FHH_State.TamingCritter = nil;
FHH_State.TamingType = nil;

-- Constants
MAX_REPORTED_ZONES = 4;


function FHH_OnLoad()

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

	-- Register Slash Commands
	SLASH_FHH1 = "/huntershelper";
	SLASH_FHH2 = "/hh";
	SlashCmdList["FHH"] = function(msg)
		FHH_ChatCommandHandler(msg);
	end
	
	GFWUtils.Print("Fizzwidget Hunter's Helper "..FHH_VERSION.." initialized!");
	
end

function FHH_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	--DevTools_Dump({event=event, arg1=arg1, arg2=arg2, arg3=arg3, arg4=arg4, arg5=arg5, arg6=arg6, arg7=arg7, arg8=arg8, arg9=arg9});

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		
		_, realClass = UnitClass("player");
		if (realClass == "HUNTER") then
			-- only do stuff related to taming and checking hunter spells if you're a hunter.
			this:RegisterEvent("UNIT_AURA");
			this:RegisterEvent("UNIT_NAME_UPDATE");
			this:RegisterEvent("CRAFT_SHOW");
			this:RegisterEvent("CHAT_MSG_SYSTEM");

			if (FHH_State.RealmPlayer == nil) then
				FHH_State.RealmPlayer = GetCVar("realmName") .. "." .. UnitName("player");
			end
			if (FHH_AbilityInfo == nil or FHH_AbilityInfo[FHH_State.RealmPlayer] == nil or GFWTable.Count(FHH_AbilityInfo[FHH_State.RealmPlayer]) == 0) then
				
				if (realClass == "HUNTER" and UnitLevel("player") > 9) then
					GFWUtils.Print("Hunter's Helper needs to collect info about what pet skills you already know; please open your Beast Training window. (Info on future skills will be collected as they are learned.)");
				end
			end
		end
		
	elseif ( event == "UPDATE_MOUSEOVER_UNIT" ) then
	
		if ( UnitExists("mouseover") and not UnitPlayerControlled("mouseover") and FHH_Config.Tooltip ) then

			local _, myClass = UnitClass("player");
			if (FHH_Config.Tooltip == "hunter" and myClass ~= "HUNTER") then return; end
			
			FHH_ModifyTooltip("mouseover");

		end
		
	elseif ( event == "UNIT_AURA" ) then
	
		if ( arg1 == "player" and FHH_HasTameEffect("player") ) then
			FHH_State.TamingCritter = UnitName("target");
			local unlocalizedCreepName = GFWTable.KeyOf(FHH_Localized, FHH_State.TamingCritter);
			if (unlocalizedCreepName) then
				FHH_State.TamingCritter = unlocalizedCreepName;
			end
			FHH_State.TamingType = UnitClassification("target");
		end
			
	elseif ( event == "UNIT_NAME_UPDATE" ) then
	
		if ( arg1 == "pet" and FHH_State.TamingCritter ) then
			local loyaltyDescription = GetPetLoyalty();
			if (loyaltyDescription) then
				local _, _, loyaltyLevel = string.find(loyaltyDescription, "(%d+)");
				if (tonumber(loyaltyLevel) and tonumber(loyaltyLevel) > 1) then
					GFWUtils.Print("Got "..event.." but pet's loyalty > 1; ignoring.");
					FHH_State.TamingCritter = nil;
					FHH_State.TamingType = nil;
					return;
				end		
			end
			if (UnitName("pet") ~= UnitCreatureFamily("pet")) then
				GFWUtils.Print("Got "..event.." but pet's UnitName() ~= UnitCreatureFamily(); ignoring.");
				FHH_State.TamingCritter = nil;
				FHH_State.TamingType = nil;
				return;
			end
			--GFWUtils.Print(event..": checking newly tamed pet");
			FHH_CheckPetSpells();
			FHH_State.TamingCritter = nil;
			FHH_State.TamingType = nil;
		end

	elseif ( event == "CRAFT_SHOW" ) then

		-- Beast Training uses the CraftFrame; we can tell it's not really a craft because it doesn't have a skill-level bar.
		local name, rank, maxRank = GetCraftDisplaySkillLine();
		if ( name ) then return; end
		
		FHH_ScanCraftFrame();

	elseif ( event == "CHAT_MSG_SYSTEM" ) then

		local pattern = GFWUtils.FormatToPattern(ERR_LEARN_SPELL_S); -- "You have learned a new spell: %s."
		local _, _, compositeSpellName = string.find(arg1, pattern);
		if (compositeSpellName == nil) then return; end
		
		local _, _, spellName, rankNum = string.find(compositeSpellName, "(.+) %(.+ (%d+)%)");
		if (spellName and rankNum and spellName ~= "" and rankNum ~= "" ) then
			spellName = string.gsub(spellName, "^%s+", ""); -- strip leading spaces
			spellName = string.gsub(spellName, "%s+$", ""); -- and trailing spaces
			local spellID = FHH_SpellIDforName(spellName);
			if (FHH_NewInfo and FHH_NewInfo.SpellIDAliases and FHH_NewInfo.SpellIDAliases[spellID]) then
				spellID = FHH_NewInfo.SpellIDAliases[spellID];
			end
			if (spellID and (FHH_RequiredLevel[spellID] or (FHH_NewInfo and FHH_NewInfo.RequiredLevel and FHH_NewInfo.RequiredLevel[spellID]))) then
				-- only track spells we know are hunter pet spells
				if (FHH_AbilityInfo == nil) then
					FHH_AbilityInfo = {};
				end
				if (FHH_AbilityInfo[FHH_State.RealmPlayer] == nil or table.getn(FHH_AbilityInfo[FHH_State.RealmPlayer]) == 0) then
					FHH_AbilityInfo[FHH_State.RealmPlayer] = { };
				end
				table.insert(FHH_AbilityInfo[FHH_State.RealmPlayer], spellName.." "..rankNum);
				table.sort(FHH_AbilityInfo[FHH_State.RealmPlayer]);
			end
		end
		
	end

end

function FHH_ChatCommandHandler(msg)

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Hunter's Helper "..FHH_VERSION..":");
		GFWUtils.Print("/huntershelper /hh <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("on").." | "..GFWUtils.Hilite("off").." | "..GFWUtils.Hilite("onlyhunter").." - Turn display of beast abilities in tooltips on or off, or make them only appear if you're playing a hunter.");
		GFWUtils.Print("- "..GFWUtils.Hilite("status").." - Check current settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("find <ability> <rank>").." - List where beasts with a given ability (e.g. Bite 6) can be found.");
		return;
	end

	if (msg == "version") then
		GFWUtils.Print("Fizzwidget Hunter's Helper "..FHH_VERSION);
		return;
	end
		
	if (msg == "onlyhunter") then
		FHH_Config.Tooltip = "hunter";
		GFWUtils.Print("Hunter's Helper is enabled; beast tooltips will display ability info only when playing a Hunter character.");
		return;
	end
	if (msg == "on") then
		FHH_Config.Tooltip = true;
		GFWUtils.Print("Hunter's Helper is enabled; beast tooltips will display ability info.");
		return;
	end
	if (msg == "off") then
		FHH_Config.Tooltip = nil;
		GFWUtils.Print("Hunter's Helper is disabled; no extra info added to tooltips.");
		return;
	end

	-- Check Status
	if ( msg == "status" ) then
		if ( FHH_Config.Tooltip == "hunter" ) then
			GFWUtils.Print("Hunter's Helper is enabled; beast tooltips will display ability info only when playing as a Hunter.");
		elseif ( FHH_Config.Tooltip ) then
			GFWUtils.Print("Hunter's Helper is enabled; beast tooltips will display ability info.");
		else
			GFWUtils.Print("Hunter's Helper is disabled; no extra info added to tooltips.");
		end
		return;
	end
	
	if (msg == "reset") then
		FHH_Config = { };
		FHH_Config.Tooltip = true;
		FHH_AbilityInfo = nil;				
		FHH_NewInfo = nil;	
				
		GFWUtils.Print("Hunter's Helper has been reset to default options and all stored data cleared.");
		return;
	end
		
	if (msg == "test") then
		FHH_RunAllTests();
		return;
	end
		
	if (msg == "dynamic") then
		FHH_SpellNamesToIDs = {};
		FHH_SpellIDsToNames = {};
		FHH_LearnableBy = {};
		FHH_RequiredLevel = {};
		FHH_SpellInfo = {};
		FHH_BeastInfo = {};
		FHH_BeastLevels = {};
		GFWUtils.Print("Hunter's Helper: only consulting dynamic tables until next reload.");
		return;
	end
		
	local _, _, cmd, spellName, rankNum = string.find(msg, "(find%w*) ([^%d]+) *(%d*)");
	if (cmd == "find" or cmd == "findall") then
		if (spellName == nil or spellName == "") then
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/hh find <ability> <rank>"));
			return;
		end
		
		spellName = string.gsub(spellName, "^%s+", ""); -- strip leading spaces
		spellName = string.gsub(spellName, "%s+$", ""); -- and trailing spaces
		spellName = string.lower(spellName);
		local spellID;
		
		-- first, look up the input against our spell ID keys
		if (FHH_SpellIDsToNames[spellName]) then
			spellID = spellName;
		end
		if (spellID == nil and FHH_NewInfo and FHH_NewInfo.SpellIDsToNames and FHH_NewInfo.SpellIDsToNames[spellName]) then
			spellID = spellName;
		end

		-- failing that, try looking it up as a proper name, case insensitively
		if (spellID == nil) then
			for properName in FHH_SpellNamesToIDs do
				if (string.lower(properName) == spellName) then
					spellID = FHH_SpellNamesToIDs[properName];
				end
			end
			if (spellID == nil and FHH_NewInfo and FHH_NewInfo.SpellNamesToIDs) then
				for properName in FHH_NewInfo.SpellNamesToIDs do
					if (string.lower(properName) == spellName) then
						spellID = FHH_NewInfo.SpellNamesToIDs[properName];
					end
				end
			end
		end
		
		if (spellID == nil) then
			GFWUtils.Print(GFWUtils.Hilite(spellName).." is not a known beast ability.");
			return;
		end
		FHH_Find(spellID, rankNum);
		return;
	end
	
	-- if we got all the way to here, we got invalid input.
	FHH_ChatCommandHandler("help");
	
end

function FHH_ModifyTooltip(unit)
	local creepName = UnitName(unit);
	local creepLevel = UnitLevel(unit);
	local creepFamily = UnitCreatureFamily(unit);
	local creepType = UnitClassification(unit);
	local abilitiesLine;

	local unlocalizedCreepName = GFWTable.KeyOf(FHH_Localized, creepName);
	if (unlocalizedCreepName) then
		creepName = unlocalizedCreepName;
	end
	
	-- if this beast is in our database, make sure we have the right level range & type info
	FHH_CheckBeastLevel(creepName, creepLevel, creepType);

	-- if this is a Beast Lore tooltip, parse out and use its tamed abilities info
	if (FHH_TAMED_ABILS_PATTERN == nil) then
		FHH_TAMED_ABILS_PATTERN = GFWUtils.FormatToPattern(PET_SPELLS_TEMPLATE);
	end
	for lineNum = 1, GameTooltip:NumLines() do
		local lineText = getglobal("GameTooltipTextLeft"..lineNum):GetText();
		if (lineText) then 
			if (string.find(lineText, LIGHTYELLOW_FONT_COLOR_CODE)) then
				return; -- if we've already added a line to this tooltip, we should stop.
			end
			local _, _, beastLoreInfo = string.find(lineText, FHH_TAMED_ABILS_PATTERN);
			if (beastLoreInfo) then
				abilitiesLine = lineNum;
				local beastLoreList = GFWUtils.Split(beastLoreInfo, ", ");
				local beastSpellTable = {};
				for _, niceSpellName in beastLoreList do
					local _, _, spellName, rankNum = string.find(niceSpellName, "^(.+) %(.+ (%d+)%)$");
					if (spellName == nil or spellName == "" or tonumber(rankNum) == nil) then
						GFWUtils.PrintOnce(GFWUtils.Red("Hunter's Helper Error: ").."Can't parse spell "..GFWUtils.Hilite(niceSpellName).." from "..GFWUtils.Hilite(critter)..".");
					else
						spellName = string.gsub(spellName, "^%s+", ""); -- strip leading spaces
						spellName = string.gsub(spellName, "%s+$", ""); -- and trailing spaces
						local spellID = FHH_SpellIDforName(spellName);
						if (FHH_NewInfo and FHH_NewInfo.SpellIDAliases and FHH_NewInfo.SpellIDAliases[spellID]) then
							spellID = FHH_NewInfo.SpellIDAliases[spellID];
						end
						if (spellID == nil) then
							spellID = FHH_RecordNewSpellID(spellName, true);
						end
						beastSpellTable[spellID] = tonumber(rankNum);
					end
				end
				FHH_CheckSpellTables(creepName, beastSpellTable, creepLevel, creepFamily);
			end
		end
	end

	-- look up the list of abilities we think this critter has
	local abilitiesList = nil;
	if (FHH_NewInfo and FHH_NewInfo.BeastInfo and FHH_NewInfo.BeastInfo[creepName]) then
		abilitiesList = FHH_NewInfo.BeastInfo[creepName];
	elseif (FHH_BeastInfo[creepName]) then
		abilitiesList = FHH_BeastInfo[creepName];
		if (FHH_NewInfo and FHH_NewInfo.BadBeastInfo and FHH_NewInfo.BadBeastInfo[creepName]) then
			local newAbilitiesList = {};
			for spellID, rankNum in abilitiesList do
				if (FHH_NewInfo.BadBeastInfo[creepName][spellID] ~= rankNum) then
					newAbilitiesList[spellID] = rankNum;
				end
			end
			abilitiesList = newAbilitiesList;
		end
	end
			
	if (abilitiesList and GFWTable.Count(abilitiesList) > 0) then
	
		-- build textual description from that list (with color coding if you're a hunter)
		local coloredList = {};
		local _, myClass = UnitClass("player");
		for spellName, rankNum in abilitiesList do
			if (myClass == "HUNTER" and FHH_AbilityInfo and FHH_AbilityInfo[FHH_State.RealmPlayer] and GFWTable.Count(FHH_AbilityInfo[FHH_State.RealmPlayer]) > 0) then
				local playerRanks = FHH_AbilityInfo[FHH_State.RealmPlayer][spellName];
				if (playerRanks and GFWTable.IndexOf(playerRanks, rankNum) ~= 0) then
					table.insert(coloredList, GRAY_FONT_COLOR_CODE..FHH_SpellDescription(spellName, rankNum)..FONT_COLOR_CODE_CLOSE);
				else
					table.insert(coloredList, GREEN_FONT_COLOR_CODE..FHH_SpellDescription(spellName, rankNum)..FONT_COLOR_CODE_CLOSE);
				end
			else
				table.insert(coloredList, FHH_SpellDescription(spellName, rankNum));
			end
		end
		local abilitiesText = table.concat(coloredList, ", ");
		abilitiesText = string.gsub(abilitiesText, "( %d+)", " ("..RANK.."%1)");
	
		-- add it to the tooltip (or, if Beast Lore, replace its line with our color-coded one)
		if (abilitiesLine) then
			local lineText = getglobal("GameTooltipTextLeft"..abilitiesLine);
			lineText:SetText(GFWUtils.LtY(string.format(PET_SPELLS_TEMPLATE, abilitiesText)));
		else
			GameTooltip:AddLine(GFWUtils.LtY(string.format(PET_SPELLS_TEMPLATE, abilitiesText)), 1.0, 1.0, 1.0);
			GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
			local width = 20 + getglobal(GameTooltip:GetName().."TextLeft"..GameTooltip:NumLines()):GetWidth();
			if ( GameTooltip:GetWidth() < width ) then
				GameTooltip:SetWidth(width);
			end
		end
	end

end

function FHH_ScanCraftFrame()
	local numCrafts = GetNumCrafts();
	if not ( numCrafts > 0 )then return; end

	if (FHH_AbilityInfo == nil) then
		FHH_AbilityInfo = {};
	end
	if (FHH_AbilityInfo[FHH_State.RealmPlayer] == nil or table.getn(FHH_AbilityInfo[FHH_State.RealmPlayer]) == 0) then
		FHH_AbilityInfo[FHH_State.RealmPlayer] = { };
	end

	for i=1, numCrafts do
		local craftName, craftSubSpellName, _, _, _, _, requiredLevel = GetCraftInfo(i);
		local _, _, rankNum = string.find(craftSubSpellName, "(%d)");
		if (rankNum and tonumber(rankNum)) then
			rankNum = tonumber(rankNum);
		end
		local craftIcon = GetCraftIcon(i);
		if (craftIcon) then 
			craftIcon = string.gsub(craftIcon, "^Interface\\Icons\\", "");
		end			
	
		local spellID = FHH_SpellIDforIcon(craftIcon, craftName);
		local nameSpellID = FHH_SpellIDforName(craftName);
		if (spellID and nameSpellID and spellID ~= nameSpellID) then
			if (FHH_NewInfo == nil) then
				FHH_NewInfo = {};
			end
			if (FHH_NewInfo.SpellIDAliases == nil) then
				FHH_NewInfo.SpellIDAliases = {};
			end
			FHH_NewInfo.SpellIDAliases[nameSpellID] = spellID;
		end
	
		if (FHH_AbilityInfo[FHH_State.RealmPlayer][spellID] == nil) then
			FHH_AbilityInfo[FHH_State.RealmPlayer][spellID] = {};
		end			
		if (GFWTable.IndexOf(FHH_AbilityInfo[FHH_State.RealmPlayer][spellID], rankNum) == 0) then
			table.insert(FHH_AbilityInfo[FHH_State.RealmPlayer][spellID], rankNum)
		end;
	
		if ( requiredLevel and requiredLevel > 0 ) then
			FHH_RecordNewRequiredLevel(spellID, tonumber(rankNum), requiredLevel, true);
		end
	end
	FHH_ProcessAliases();
end

function FHH_Find(spellID, rankNum)
	local niceSpellName = FHH_SpellIDsToNames[spellID];
	if (niceSpellName == nil and FHH_NewInfo and FHH_NewInfo.SpellIDsToNames and FHH_NewInfo.SpellIDsToNames[spellID]) then
		niceSpellName = FHH_NewInfo.SpellIDsToNames[spellID];
	end
	
	local spellInfo = FHH_SpellInfo[spellID];
	local newSpellInfo;
	if (FHH_NewInfo and FHH_NewInfo.SpellInfo) then
		newSpellInfo = FHH_NewInfo.SpellInfo[spellID];
	end
	if (spellInfo == nil or (type(spellInfo) == "table" and GFWTable.Count(spellInfo) == 0)) then
		if (newSpellInfo == nil or GFWTable.Count(newSpellInfo) == 0) then
			GFWUtils.Print("No info available for ".. GFWUtils.Hilite(niceSpellName)..".");
			return;
		else
			spellInfo = newSpellInfo;
		end
	end
	local rankTable = FHH_RequiredLevel[spellID];
	local newRankTable;
	if (FHH_NewInfo and FHH_NewInfo.RequiredLevel) then
		newRankTable = FHH_NewInfo.RequiredLevel[spellID];
	end
	if (rankTable == nil or GFWTable.Count(rankTable) == 0) then
		if (newRankTable == nil or GFWTable.Count(newRankTable) == 0) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper "..FHH_VERSION.." error:").." found "..GFWUtils.Hilite(niceSpellName).." but can't find rank info. Please report to gazmik@fizzwidget.com");
			return;
		else
			rankTable = newRankTable;
		end
	end
	
	rankNum = tonumber(rankNum);
	if (rankNum) then
		if not (rankTable[rankNum]) then
			GFWUtils.Print(GFWUtils.Hilite(niceSpellName).." is not known to have a rank "..GFWUtils.Hilite(rankNum)..".");
			return;
		end
		
		-- report minimum pet level for ability
		local minLevel = rankTable[rankNum];
		local petLevel = 60;
		if (UnitExists("pet")) then
			petLevel = tonumber(UnitLevel("pet"));
		end
		if (minLevel == nil) then
			minLevel = newRankTable[rankNum];
		end
		if (minLevel == nil) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper "..FHH_VERSION.." error:").." can't find required level for "..GFWUtils.Hilite(niceSpellName.." "..rankNum)..". Please report to gazmik@fizzwidget.com");
		else
			if (type(minLevel) == "string") then
				GFWUtils.Print(GFWUtils.Hilite(niceSpellName.." "..rankNum).." requires at least pet level "..GFWUtils.Hilite(minLevel)..". (Assumed because it was found on a beast of this level that you tamed. Open you Beast Training window and Hunter's Helper can collect more accurate information.)");
			elseif (petLevel >= minLevel) then
				GFWUtils.Print(GFWUtils.Hilite(niceSpellName.." "..rankNum).." requires pet level "..GFWUtils.Hilite(minLevel)..".");
			else
				GFWUtils.Print(GFWUtils.Hilite(niceSpellName.." "..rankNum).." requires pet level "..GFWUtils.Red(minLevel)..".");
			end
		end
	else
		local knownRanks = {};
		for rankNum in rankTable do
			table.insert(knownRanks, rankNum);
		end
		local newRanks = {};
		for rankNum in (newRankTable or {}) do
			table.insert(newRanks, rankNum);
		end
		local allRanks = GFWTable.Merge(knownRanks, newRanks);
		GFWUtils.Print("Ranks known about for "..GFWUtils.Hilite(niceSpellName)..": "..table.concat(allRanks, " "));
		if (type(spellInfo) ~= "string") then
			GFWUtils.Print("Type "..GFWUtils.Hilite("/hh find "..spellID).." and a number to get info about that rank.");
		end
	end

	-- report available creature families
	local families = FHH_LearnableBy[spellID];
	if (type(families) == "table" and FHH_NewInfo and FHH_NewInfo.LearnableBy and FHH_NewInfo.LearnableBy[spellID]) then
		families = GFWTable.Merge(families, FHH_NewInfo.LearnableBy[spellID]);
		if (table.getn(GFWTable.Diff(families, FHH_AllFamilies)) == 0 ) then
			families = FHH_ALL_FAMILIES;
		end
	end
	if (families or (type(families) == "table" and table.getn(families) == 0)) then
		if (type(families) == "string") then
			GFWUtils.Print(GFWUtils.Hilite(niceSpellName).." is learnable by "..GFWUtils.Hilite(families)..".");
		else
			local listText = table.concat(families, ", ");
			GFWUtils.Print(GFWUtils.Hilite(niceSpellName).." is learnable by: "..GFWUtils.Hilite(listText)..".");
		end
	end

	-- case 1: first levels of Growl are innate
	if (spellID == "growl" and rankNum and rankNum <= 2) then
		GFWUtils.Print("You should already know "..GFWUtils.Hilite(niceSpellName.." "..rankNum).." if you've learned Beast Training.");
		return;
	end
	
	-- case 2: spells taught by trainers, for which rank doesn't matter
	if (type(spellInfo) == "string") then
		local spellSummary = niceSpellName;
		if (rankNum) then
			spellSummary = spellSummary.." "..rankNum;
		end
		GFWUtils.Print(GFWUtils.Hilite(spellSummary).." is learned from "..spellInfo..".");
		return;
	end
	
	if (rankNum == nil) then return; end
	
	--case 3: lookup by spell and rank, report by zone (sanity check first)
	local spellRankInfo = spellInfo[rankNum];
	local maxZones = MAX_REPORTED_ZONES;
	if (cmd == "findall") then
		maxZones = 100; -- arbitrarily high so we find everything.
	end
	if (spellRankInfo == nil ) then
		GFWUtils.Print("Hunter's Helper doesn't know about any creatures with "..GFWUtils.Hilite(niceSpellName.." "..rankNum)..".");
		return;
	end
	GFWUtils.Print(GFWUtils.Hilite(niceSpellName.." "..rankNum).." can be learned from:");
	local numReportedZones = 0;
	local zoneName = GFWZones.UnlocalizedZone(GetRealZoneText());
	local critterList = {};
	if (spellRankInfo[zoneName] and table.getn(spellRankInfo[zoneName]) > 0) then
		critterList = GFWTable.Merge(critterList, spellRankInfo[zoneName]);
	end
	if (FHH_NewInfo and FHH_NewInfo.SpellInfo and FHH_NewInfo.SpellInfo[spellID] and FHH_NewInfo.SpellInfo[spellID][rankNum] and FHH_NewInfo.SpellInfo[spellID][rankNum][zoneName]) then
		critterList = GFWTable.Merge(critterList, FHH_NewInfo.SpellInfo[spellID][rankNum][zoneName]);
	end
	if (table.getn(critterList) > 0) then
		GFWUtils.Print(GFWZones.LocalizedZone(zoneName)..": "..GFWUtils.Hilite(FHH_CreatureListString(critterList)));
		numReportedZones = numReportedZones + 1;
	end
	
	local zoneConnections = GFWZones.ConnectionsForZone(zoneName);
	
	if (zoneConnections == nil) then
		-- player is in an unknown zone; instead of doing nothing, let's pick a known zone to start searching from.
		local _, race = UnitRace("player");
		if (race == "Night Elf") then
			zoneName = "Teldrassil";
		elseif (race == "Dwarf") then
			zoneName = "Dun Morogh";
		elseif (race == "Gnome") then
			zoneName = "Dun Morogh";
		elseif (race == "Human") then
			zoneName = "Elwynn Forest";
		elseif (race == "Tauren") then
			zoneName = "Mulgore";
		elseif (race == "Orc") then
			zoneName = "Durotar";
		elseif (race == "Troll") then
			zoneName = "Durotar";
		elseif (race == "Scourge") then
			zoneName = "Tirisfal Glades";
		else
			-- unlikely, but in case we can't parse the race name...
			local faction = UnitFactionGroup("player");
			if (faction == "Alliance") then
				zoneName = "Ironforge";
			elseif (faction == "Horde") then
				zoneName = "Orgrimmar";
			else
				-- on the off chance we can't even parse a major-faction name...
				zoneName = "Stranglethorn Vale";
			end
		end
		zoneConnections = GFWZones.ConnectionsForZone(zoneName);
	end
	
	for _, zones in zoneConnections do
		for _, zoneName in zones do
			local critterList = {};
			if (spellRankInfo[zoneName] and table.getn(spellRankInfo[zoneName]) > 0) then
				critterList = GFWTable.Merge(critterList, spellRankInfo[zoneName]);
			end
			if (FHH_NewInfo and FHH_NewInfo.SpellInfo and FHH_NewInfo.SpellInfo[spellID] and FHH_NewInfo.SpellInfo[spellID][rankNum] and FHH_NewInfo.SpellInfo[spellID][rankNum][zoneName]) then
				critterList = GFWTable.Merge(critterList, FHH_NewInfo.SpellInfo[spellID][rankNum][zoneName]);
			end
			if (table.getn(critterList) > 0) then
				GFWUtils.Print(GFWZones.LocalizedZone(zoneName)..": "..GFWUtils.Hilite(FHH_CreatureListString(critterList)));
				numReportedZones = numReportedZones + 1;
				if (numReportedZones >= maxZones) then return; end
			end
		end
	end
	
	if (numReportedZones == 0) then
		-- if we get here, we think we know about the spell but can't find beasts with it in our table. this shouldn't happen.
		GFWUtils.Print(GFWUtils.Red("Hunter's Helper "..FHH_VERSION.." error:").." got spell info for "..GFWUtils.Hilite(niceSpellName.." "..rankNum).." but no zone info. Please report to gazmik@fizzwidget.com.");
	end
end

function FHH_CreatureListString(critterList)
	local listString = ""
	for _, name in critterList do
		local info = FHH_BeastLevels[name];
		if (info == nil and FHH_NewInfo and FHH_NewInfo.BeastLevels) then
			info = FHH_NewInfo.BeastLevels[name];
		end
		if (info == nil) then
			listString = listString..", ";
		else
			local unlocalizedName = FHH_Localized[name];
			if (unlocalizedName) then
				name = unlocalizedName;
			end
			listString = listString .. name .. " ";
			local myLevel = UnitLevel("player");
			local minLevel = info.min;
			local maxLevel = info.max;
			if (info.min > UnitLevel("player")) then
				minLevel = RED_FONT_COLOR_CODE..info.min..FONT_COLOR_CODE_CLOSE;
			end
			if (info.max and info.max > UnitLevel("player")) then
				maxLevel = RED_FONT_COLOR_CODE..info.max..FONT_COLOR_CODE_CLOSE;
			end
			if (info.min == info.max or info.max == nil) then			
				listString = listString.."("..minLevel;
			else
				listString = listString.."("..minLevel.."-"..maxLevel;
			end
			if (info.type == nil) then
				listString = listString.."), ";
			else
				listString = listString.." "..info.type.."), ";
			end				
		end
	end
	listString = string.gsub(listString, ", $", "");
	return listString;
end

function FHH_HasTameEffect(unit)

	local i = 1;
	local buff;
	buff = UnitBuff(unit, i);
	while buff do
		if ( string.find(buff, "Ability_Hunter_BeastTaming") ) then
			return true;
		end
		i = i + 1;
		buff = UnitBuff(unit, i);
	end
	return false;

end

function FHH_SpellIDforName(spellName)
	local spellID = FHH_SpellNamesToIDs[spellName];
	if (spellID == nil and FHH_NewInfo and FHH_NewInfo.SpellNamesToIDs) then
		spellID = FHH_NewInfo.SpellNamesToIDs[spellName];
	end
	return spellID;
end

function FHH_SpellIDforIcon(spellIcon, spellName)
	local spellID = FHH_SpellIcons[spellIcon];
	if (spellID == nil and FHH_NewInfo and FHH_NewInfo.SpellIcons) then
		spellID = FHH_NewInfo.SpellIcons[spellIcon];
	end
	if (spellID == nil) then
		spellID = FHH_SpellIDforName(spellName);
	end	
	if (spellID == nil) then
		spellID = FHH_RecordNewSpellIcon(spellIcon, spellName);
	end
	return spellID;
end

function FHH_CheckPetSpells()
	local currentPetSpells = { };
	local i = 1;
	local spellName, spellRank = GetSpellName(i, BOOKTYPE_PET);
	local spellIcon = GetSpellTexture(i, BOOKTYPE_PET);
	while spellName do
		local _, _, rankNum = string.find(spellRank, "(%d+)");
		if (spellIcon) then 
			spellIcon = string.gsub(spellIcon, "^Interface\\Icons\\", "");
		end			
		local spellID = FHH_SpellIDforIcon(spellIcon, spellName);
		local nameSpellID = FHH_SpellIDforName(spellName);
		if (spellID and nameSpellID and spellID ~= nameSpellID) then
			if (FHH_NewInfo == nil) then
				FHH_NewInfo = {};
			end
			if (FHH_NewInfo.SpellIDAliases == nil) then
				FHH_NewInfo.SpellIDAliases = {};
			end
			FHH_NewInfo.SpellIDAliases[nameSpellID] = spellID;
		end

		currentPetSpells[spellID] = tonumber(rankNum);
		i = i + 1;
		spellName, spellRank = GetSpellName(i, BOOKTYPE_PET);
		spellIcon = GetSpellTexture(i, BOOKTYPE_PET);
	end
	
	if (GFWTable.Count(currentPetSpells) > 0) then
		FHH_ProcessAliases();
		FHH_CheckSpellTables(FHH_State.TamingCritter, currentPetSpells);
	else
		--GFWUtils.Print("pet has no spells");
	end
end

function FHH_SpellDescription(spellID, rankNum)
	local niceSpellName = FHH_SpellIDsToNames[spellID];
	if (niceSpellName == nil and FHH_NewInfo and FHH_NewInfo.SpellIDsToNames and FHH_NewInfo.SpellIDsToNames[spellID]) then
		niceSpellName = FHH_NewInfo.SpellIDsToNames[spellID];
	end
	if (niceSpellName == nil) then
		niceSpellName = spellID;
	end
	return niceSpellName.." "..rankNum;
end

function FHH_SpellDescriptions(spellList)
	local descriptions = {};
	for spellID, rankNum in spellList do
		table.insert(descriptions, FHH_SpellDescription(spellID, rankNum));
	end
	return descriptions;
end

function FHH_SpellDescripionList(spellList)
	return table.concat(FHH_SpellDescriptions(spellList), ", ");
end

function FHH_CheckSpellTables(critter, spellList, level, family)
	
	if ( spellList == nil or GFWTable.Count(spellList) == 0 ) then return; end

	-- process any recently learned spellID aliases so we record data correctly.
	local newSpellList = {};
	local changed = false;
	for spellID, rankNum in spellList do
		if (FHH_NewInfo and FHH_NewInfo.SpellIDAliases and FHH_NewInfo.SpellIDAliases[spellID]) then
			spellID = FHH_NewInfo.SpellIDAliases[spellID];
			changed = true;
		end
		newSpellList[spellID] = rankNum;
	end
	if (changed) then
		spellList = newSpellList;
	end	

	if (level == nil) then
		level = UnitLevel("pet");
	end
	if (family == nil) then
		family = UnitCreatureFamily("pet");
	end
	
	if ( FHH_BeastInfo[critter] ) then
	
		-- record any spells the critter has that our built-in table doesn't know about 
		local unknownPetSpells = { };
		for spellID, rankNum in spellList do
			if ( FHH_BeastInfo[critter][spellID] == nil ) then
				unknownPetSpells[spellID] = rankNum;
			end
		end
		if ( GFWTable.Count(unknownPetSpells) > 0 ) then
			if (FHH_NewInfo == nil) then
				FHH_NewInfo = {};
			end
			if (FHH_NewInfo.BeastInfo == nil) then
				FHH_NewInfo.BeastInfo = {};
			end
			FHH_NewInfo.BeastInfo[critter] = spellList; -- we want to remember the entire current spells list
		end
		
		-- record any spells our built-in table thinks the critter has, but the critter actually doesn't
		local wrongPetSpells = { };
		for spellID, rankNum in FHH_BeastInfo[critter] do
			if ( spellList[spellID] ~= rankNum ) then
				wrongPetSpells[spellID] = rankNum;
			end
		end
		if ( GFWTable.Count(wrongPetSpells) > 0 ) then
			if (FHH_NewInfo == nil) then
				FHH_NewInfo = {};
			end
			if (FHH_NewInfo.BadBeastInfo == nil) then
				FHH_NewInfo.BadBeastInfo = {};
			end
			FHH_NewInfo.BadBeastInfo[critter] = wrongPetSpells;
		end
		
		if (FHH_NewInfo and (( FHH_NewInfo.BeastInfo and FHH_NewInfo.BeastInfo[critter]) or (FHH_NewInfo.BadBeastInfo and FHH_NewInfo.BadBeastInfo[critter]))) then
			local details = "(expected "..FHH_SpellDescripionList(FHH_BeastInfo[critter]).."; found "..FHH_SpellDescripionList(spellList)..").";
			GFWUtils.PrintOnce("Hunter's Helper "..FHH_VERSION.." has incorrect data on "..GFWUtils.Hilite(critter.." "..details).." Please submit a correction to gazmik@fizzwidget.com.)", 60);
		end
		
	else
	
		-- this pet is entirely new to our list
		if (FHH_NewInfo == nil) then
			FHH_NewInfo = {};
		end
		if (FHH_NewInfo.BeastInfo == nil) then
			FHH_NewInfo.BeastInfo = {};
		end
		FHH_NewInfo.BeastInfo[critter] = spellList;
		FHH_CheckBeastLevel(critter, level, FHH_State.TamingType);
		
		local details = "(found "..FHH_SpellDescripionList(spellList).." in "..GetRealZoneText()..").";
		GFWUtils.PrintOnce("Hunter's Helper "..FHH_VERSION.." has no data on "..GFWUtils.Hilite(critter.." "..details).." Please submit a correction to gazmik@fizzwidget.com.)", 60);

	end
	
	for spellID, rankNum in spellList do
		FHH_RecordNewSpellInfo(spellID, rankNum, critter);
		FHH_RecordNewRequiredFamily(spellID, family);
		FHH_RecordNewRequiredLevel(spellID, rankNum, level);
	end

end

function FHH_RecordNewSpellInfo(spellID, rankNum, critter)
	if (FHH_SpellInfo[spellID] and FHH_SpellInfo[spellID][rankNum]) then
		for zoneName, beastsTable in FHH_SpellInfo[spellID][rankNum] do
			for _, aBeast in beastsTable do
				if (aBeast == critter) then
					return; -- we've already recorded this in our static data
				end
			end
		end
	end
	
	if (FHH_NewInfo == nil) then
		FHH_NewInfo = {};
	end
	if (FHH_NewInfo.SpellInfo == nil) then
		FHH_NewInfo.SpellInfo = {};
	end
	if (FHH_NewInfo.SpellInfo[spellID] == nil) then
		FHH_NewInfo.SpellInfo[spellID] = {};
	end
	if (FHH_NewInfo.SpellInfo[spellID][rankNum] == nil) then
		FHH_NewInfo.SpellInfo[spellID][rankNum] = {};
	end
	local currentZone = GFWZones.UnlocalizedZone(GetRealZoneText());
	if (FHH_NewInfo.SpellInfo[spellID][rankNum][currentZone] == nil) then
		FHH_NewInfo.SpellInfo[spellID][rankNum][currentZone] = {};
	end
	if (not GFWTable.KeyOf(FHH_NewInfo.SpellInfo[spellID][rankNum][currentZone], critter)) then
		table.insert(FHH_NewInfo.SpellInfo[spellID][rankNum][currentZone], critter);
	end
end

function FHH_RecordNewRequiredFamily(spellID, family)
	if (FHH_LearnableBy[spellID] and GFWTable.KeyOf(FHH_LearnableBy[spellID], family)) then
		return; -- we've already recorded this in our static data
	end
	
	if (FHH_NewInfo == nil) then
		FHH_NewInfo = {};
	end
	if (FHH_NewInfo.LearnableBy == nil) then
		FHH_NewInfo.LearnableBy = {};
	end
	if (FHH_NewInfo.LearnableBy[spellID] == nil) then
		FHH_NewInfo.LearnableBy[spellID] = {};
	end
	if (not GFWTable.KeyOf(FHH_NewInfo.LearnableBy[spellID], family)) then
		table.insert(FHH_NewInfo.LearnableBy[spellID], family);
	end
end

function FHH_RecordNewRequiredLevel(spellID, rankNum, level, verified)	
	if (FHH_RequiredLevel[spellID] and FHH_RequiredLevel[spellID][rankNum]) then
		return; -- we've already recorded this in our static data
	end
	
	if (FHH_NewInfo == nil) then
		FHH_NewInfo = {};
	end
	if (FHH_NewInfo.RequiredLevel == nil) then
		FHH_NewInfo.RequiredLevel = {};
	end
	if (FHH_NewInfo.RequiredLevel[spellID] == nil) then
		FHH_NewInfo.RequiredLevel[spellID] = {};
	end
	if (verified) then
		FHH_NewInfo.RequiredLevel[spellID][rankNum] = level;
	elseif (FHH_NewInfo.RequiredLevel[spellID][rankNum] == nil) then
		FHH_NewInfo.RequiredLevel[spellID][rankNum] = tostring(level);
	else
		local existingRank = FHH_NewInfo.RequiredLevel[spellID][rankNum];
		if (type(existingRank) == "string") then
			-- we don't have a certain answer yet, we'll use what we just got to refine it
			FHH_NewInfo.RequiredLevel[spellID][rankNum] = tostring(math.min(level, tonumber(existingRank)));
		end
	end
end

function FHH_CheckBeastLevel(creepName, creepLevel, creepType)
	if (creepLevel < 1) then
		return; -- UnitLevel sometimes returns -1 for common mobs (maybe a WDB cache thing) so we toss nonsensical values.
	end

	if (FHH_NewInfo and FHH_NewInfo.BeastLevels and FHH_NewInfo.BeastLevels[creepName]) then
		FHH_NewInfo.BeastLevels[creepName].min = math.min(FHH_NewInfo.BeastLevels[creepName].min, creepLevel);
		FHH_NewInfo.BeastLevels[creepName].max = math.max(FHH_NewInfo.BeastLevels[creepName].max, creepLevel);
		if (FHH_NewInfo.BeastLevels[creepName].type and creepType ~= "normal") then
			FHH_NewInfo.BeastLevels[creepName].type = creepType;
		end
	elseif (FHH_BeastLevels[creepName]) then
		if (creepLevel < FHH_BeastLevels[creepName].min or (FHH_BeastLevels[creepName].max and creepLevel > FHH_BeastLevels[creepName].max)) then
			if (FHH_NewInfo == nil) then
				FHH_NewInfo = {};
			end
			if (FHH_NewInfo.BeastLevels == nil) then
				FHH_NewInfo.BeastLevels = {};
			end
			FHH_NewInfo.BeastLevels[creepName] = {};
			FHH_NewInfo.BeastLevels[creepName].min = math.min(FHH_BeastLevels[creepName].min, creepLevel);
			FHH_NewInfo.BeastLevels[creepName].max = math.max(FHH_BeastLevels[creepName].max or FHH_BeastLevels[creepName].min, creepLevel);
		end
		if (creepType ~= "normal" and creepType ~= FHH_BeastLevels[creepName].type) then
			if (FHH_NewInfo == nil) then
				FHH_NewInfo = {};
			end
			if (FHH_NewInfo.BeastLevels == nil) then
				FHH_NewInfo.BeastLevels = {};
			end
			if (FHH_NewInfo.BeastLevels[creepName] == nil) then
				FHH_NewInfo.BeastLevels[creepName] = {};
			end
			FHH_NewInfo.BeastLevels[creepName].min = math.min(FHH_BeastLevels[creepName].min, creepLevel);
			FHH_NewInfo.BeastLevels[creepName].max = math.max(FHH_BeastLevels[creepName].max or FHH_BeastLevels[creepName].min, creepLevel);
			FHH_NewInfo.BeastLevels[creepName].type = creepType;
		end
	end
end

function FHH_RecordNewSpellID(spellName)
	-- we have a new spell on our hands; we'll use its lowercase name as a key for now.
	spellID = string.lower(spellName);
	if (FHH_NewInfo == nil) then
		FHH_NewInfo = {};
	end
	if (FHH_NewInfo.SpellNamesToIDs == nil) then
		FHH_NewInfo.SpellNamesToIDs = {};
	end
	if (FHH_NewInfo.SpellIDsToNames == nil) then
		FHH_NewInfo.SpellIDsToNames = {};
	end
	FHH_NewInfo.SpellNamesToIDs[spellName] = spellID;
	FHH_NewInfo.SpellIDsToNames[spellID] = spellName;
	return spellID;
end

function FHH_RecordNewSpellIcon(spellIcon, spellName)
	spellID = FHH_RecordNewSpellID(spellName);
	if (FHH_NewInfo == nil) then
		FHH_NewInfo = {};
	end
	if (FHH_NewInfo.SpellIcons == nil) then
		FHH_NewInfo.SpellIcons = {};
	end
	FHH_NewInfo.SpellIcons[spellIcon] = spellID;
	return spellID;
end

function FHH_ProcessAliases()
	if (FHH_NewInfo and FHH_NewInfo.SpellIDAliases) then
		for oldID, newID in FHH_NewInfo.SpellIDAliases do
			
			if (FHH_NewInfo.SpellNamesToIDs) then
				local newNamesToIDs = {};
				local changed = false;
				for name, id in FHH_NewInfo.SpellNamesToIDs do
					if (id == oldID) then
						newNamesToIDs[name] = newID;
						changed = true;
					else
						newNamesToIDs[name] = id;
					end
				end
				if (changed) then
					FHH_NewInfo.SpellNamesToIDs = newNamesToIDs;
				end
			end

			if (FHH_NewInfo.BeastInfo) then
				for beast, spellList in FHH_NewInfo.BeastInfo do
					if (spellList[oldID]) then
						spellList[newID] = spellList[oldID];
						spellList[oldID] = nil;
					end
				end
			end

			if (FHH_NewInfo.BadBeastInfo) then
				for beast, spellList in FHH_NewInfo.BadBeastInfo do
					if (spellList[oldID]) then
						spellList[newID] = spellList[oldID];
						spellList[oldID] = nil;
					end
				end
			end
			
			if (FHH_AbilityInfo) then
				for realmPlayer, abilityTable in FHH_AbilityInfo do
					if (abilityTable[oldID]) then
						abilityTable[newID] = abilityTable[oldID];
						abilityTable[oldID] = nil;
					end
				end
			end

			if (FHH_NewInfo.SpellIDsToNames and FHH_NewInfo.SpellIDsToNames[oldID]) then
				FHH_NewInfo.SpellIDsToNames[newID] = FHH_NewInfo.SpellIDsToNames[oldID];
				FHH_NewInfo.SpellIDsToNames[oldID] = nil;
			end
						
			if (FHH_NewInfo.RequiredLevel and FHH_NewInfo.RequiredLevel[oldID]) then
				FHH_NewInfo.RequiredLevel[newID] = FHH_NewInfo.RequiredLevel[oldID];
				FHH_NewInfo.RequiredLevel[oldID] = nil;				
			end

			if (FHH_NewInfo.LearnableBy and FHH_NewInfo.LearnableBy[oldID]) then
				FHH_NewInfo.LearnableBy[newID] = FHH_NewInfo.LearnableBy[oldID];
				FHH_NewInfo.LearnableBy[oldID] = nil;				
			end

			if (FHH_NewInfo.SpellInfo and FHH_NewInfo.SpellInfo[oldID]) then
				FHH_NewInfo.SpellInfo[newID] = FHH_NewInfo.SpellInfo[oldID];
				FHH_NewInfo.SpellInfo[oldID] = nil;				
			end
		end
	end
end

