------------------------------------------------------
-- HuntersHelper_Tests.lua
-- testing functions for verifying our tables
------------------------------------------------------

function FHH_RunAllTests()
	local testNum = 1;
	local errorCount = 0;
	while (errorCount == 0 and getglobal("FHH_Test"..testNum) ~= nil) do
		local testFunc = getglobal("FHH_Test"..testNum)
		errorCount = testFunc();
		testNum = testNum + 1;
	end
end

function FHH_Test1()
	-- 1: make sure all spell-indexed tables have the same spells
	local errorCount = 0;
	for spellID in FHH_SpellInfo do
		if (FHH_RequiredLevel[spellID] == nil) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(spellID).." present in FHH_SpellInfo but not FHH_RequiredLevel.");
			errorCount = errorCount + 1;
		end
		if (FHH_LearnableBy[spellID] == nil) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(spellID).." present in FHH_SpellInfo but not FHH_LearnableBy.");
			errorCount = errorCount + 1;
		end
	end
	for spellID in FHH_RequiredLevel do
		if (FHH_SpellInfo[spellID] == nil) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(spellID).." present in FHH_RequiredLevel but not FHH_SpellInfo.");
			errorCount = errorCount + 1;
		end
		if (FHH_LearnableBy[spellID] == nil) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(spellID).." present in FHH_RequiredLevel but not FHH_LearnableBy.");
			errorCount = errorCount + 1;
		end
	end
	for spellID in FHH_LearnableBy do
		if FHH_SpellInfo[spellID] == nil then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(spellID).." present in FHH_LearnableBy but not FHH_SpellInfo.");
			errorCount = errorCount + 1;
		end
		if FHH_RequiredLevel[spellID] == nil then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(spellID).." present in FHH_LearnableBy but not FHH_RequiredLevel.");
			errorCount = errorCount + 1;
		end
	end
	if (errorCount == 0) then
		GFWUtils.Print("Test 1 passed; all spell-indexed tables have the same set of indices.");
	end
	return errorCount;
end

function FHH_Test2()
	-- 2: check spell ranks from FHH_SpellInfo against FHH_RequiredLevel
	local errorCount = 0;
	for spellID, ranksTable in FHH_SpellInfo do
		if (type(ranksTable) == "table" and table.getn(ranksTable) ~= table.getn(FHH_RequiredLevel[spellID])) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ").."FHH_SpellInfo and FHH_RequiredLevel do not cover the same set of ranks for "..GFWUtils.Hilite(spellID)..".");
			errorCount = errorCount + 1;
		end
	end
	if (errorCount == 0) then
		GFWUtils.Print("Test 2 passed; all spell ranks match in FHH_SpellInfo and FHH_RequiredLevel.");
	end
	return errorCount;
end

function FHH_Test3()	
	-- 3: make sure every beast listed in FHH_SpellInfo has info in FHH_BeastLevels
	local errorCount = 0;
	for spellID, ranksTable in FHH_SpellInfo do
		if (type(ranksTable) == "table") then
			for rankNum, zonesTable in ranksTable do
				for zoneName, beastsTable in zonesTable do
					for _, beastName in beastsTable do
						local beastLevelInfo = FHH_BeastLevels[beastName];
						if (beastLevelInfo == nil) then
							GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." listed in FHH_SpellInfo but not FHH_BeastLevels.");
							errorCount = errorCount + 1;
							if (FHH_Config.tempBeastLevels == nil) then
								FHH_Config.tempBeastLevels = {};
							end
							FHH_Config.tempBeastLevels[beastName] = { min=1, max=1 }; -- use a saved var to build dummy table for easy editing
						else
							if (beastLevelInfo.min == nil or tonumber(beastLevelInfo.min) == nil or beastLevelInfo.min < 1 or beastLevelInfo.min > 60) then
								GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." has illegal minimum level listed in FHH_BeastLevels.");
								errorCount = errorCount + 1;
							end
							if (beastLevelInfo.max ~= nil and (tonumber(beastLevelInfo.max) == nil or beastLevelInfo.max < 1 or beastLevelInfo.max > 60)) then
								GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." has illegal maximum level listed in FHH_BeastLevels.");
								errorCount = errorCount + 1;
							end
						end
					end
				end
			end
		end
	end
	if (errorCount == 0) then
		GFWUtils.Print("Test 3 passed; all beasts in FHH_SpellInfo have levels in FHH_BeastLevels.");
	end
	return errorCount;
end

function FHH_Test4()
	-- 4: make sure all appropriate info in FHH_SpellInfo is mirrored in FHH_BeastInfo
	local errorCount = 0;
	for spellID, ranksTable in FHH_SpellInfo do
		if (type(ranksTable) == "table") then
			for rankNum, zonesTable in ranksTable do
				local niceSpellName = FHH_SpellDescription(spellID, rankNum);
				for zoneName, beastsTable in zonesTable do
					for _, beastName in beastsTable do
						if (FHH_BeastInfo[beastName] == nil) then
							if (FHH_NewInfo == nil) then
								FHH_NewInfo = {};
							end
							if (FHH_NewInfo.BeastInfo == nil) then
								FHH_NewInfo.BeastInfo = {};
							end
							if (FHH_NewInfo.BeastInfo[beastName] == nil) then
								FHH_NewInfo.BeastInfo[beastName] = {};
							end
							FHH_NewInfo.BeastInfo[beastName][spellID] = rankNum;
							GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." not present in FHH_BeastInfo; added to FHH_NewInfo.BeastInfo with "..GFWUtils.Hilite(niceSpellName)..".");
							errorCount = errorCount + 1;
						elseif (FHH_BeastInfo[beastName][spellID] == nil or FHH_BeastInfo[beastName][spellID] ~= rankNum) then
							if (FHH_NewInfo == nil) then
								FHH_NewInfo = {};
							end
							if (FHH_NewInfo.BeastInfo == nil) then
								FHH_NewInfo.BeastInfo = {};
							end
							if (FHH_NewInfo.BeastInfo[beastName] == nil) then
								FHH_NewInfo.BeastInfo[beastName] = {};
							end
							FHH_NewInfo.BeastInfo[beastName][spellID] = rankNum;
							GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(niceSpellName).." not present in FHH_BeastInfo for "..GFWUtils.Hilite(beastName).."; added to FHH_NewInfo.BeastInfo.");
							errorCount = errorCount + 1;
						end
					end
				end
			end
		end
	end
	if (errorCount == 0) then
		GFWUtils.Print("Test 4 passed; all appropriate info from FHH_SpellInfo is mirrored in FHH_BeastInfo.");
	end
	return errorCount;
end

function FHH_Test5()
	-- 5: vice versa; make sure everything from FHH_BeastInfo is mirrored in FHH_SpellInfo
	local errorCount = 0;
	for beastName, spellsTable in FHH_BeastInfo do
		for spellID, rankNum in spellsTable do
			local niceSpellName = FHH_SpellDescription(spellID, rankNum);
			local spellTable = FHH_SpellInfo[spellID];
			if (spellTable == nil) then
				GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." has spell "..GFWUtils.Hilite(spellID).." which is unknown in FHH_SpellInfo.");
				errorCount = errorCount + 1;
			else
				local zonesTable = spellTable[rankNum];
				if (zonesTable == nil) then
					GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." has spell rank "..GFWUtils.Hilite(niceSpellName).." which is unknown in FHH_SpellInfo.");
					errorCount = errorCount + 1;
				else
					local foundBeast = false;
					for zoneName, beastsTable in zonesTable do
						for _, aBeast in beastsTable do
							if (aBeast == beastName) then
								foundBeast = true;
							end
						end
					end
					if (not foundBeast) then
						GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." not found in FHH_SpellInfo for spell "..GFWUtils.Hilite(niceSpellName)..".");
						errorCount = errorCount + 1;
					end
				end
			end
		end
	end
	if (errorCount == 0) then
		GFWUtils.Print("Test 5 passed; all appropriate info from FHH_BeastInfo is mirrored in FHH_SpellInfo.");
	end
	return errorCount;
end

function FHH_Test6()
	-- 6: make sure every beast listed in FHH_BeastInfo is in FHH_BeastLevels and vice versa
	local errorCount = 0;
	for beastName in FHH_BeastInfo do
		if (FHH_BeastLevels[beastName] == nil) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." is in FHH_BeastInfo but not FHH_BeastLevels.");
			errorCount = errorCount + 1;
		end
	end
	for beastName in FHH_BeastLevels do
		if (FHH_BeastInfo[beastName] == nil) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." is in FHH_BeastLevels but not FHH_BeastInfo.");
			errorCount = errorCount + 1;
		end
	end

	if (errorCount == 0) then
		GFWUtils.Print("Test 6 passed; beast-indexed tables (FHH_BeastInfo and FHH_BeastLevels) match all indices.");
	end
	return errorCount;
end

function FHH_Test7()
	-- 7: make sure every beast in FHH_BeastLevels is listed in FHH_SpellInfo
	local errorCount = 0;
	for beastName in FHH_BeastLevels do
		local foundBeast = false;
		for spellID, ranksTable in FHH_SpellInfo do
			if (type(ranksTable) == "table") then
				for rankNum, zonesTable in ranksTable do
					for zoneName, beastsTable in zonesTable do
						for _, aBeast in beastsTable do
							if (aBeast == beastName) then
								foundBeast = true;
							end
						end
					end
				end
			end
		end
		if (not foundBeast) then
			GFWUtils.Print(GFWUtils.Red("Hunter's Helper Error: ")..GFWUtils.Hilite(beastName).." is in FHH_BeastLevels but not FHH_SpellInfo.");
			errorCount = errorCount + 1;
		end
	end

	if (errorCount == 0) then
		GFWUtils.Print("Test 7 passed; every beast in FHH_BeastLevels is listed in FHH_SpellInfo.");
	end
	return errorCount;
end
