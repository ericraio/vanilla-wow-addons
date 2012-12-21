function SetWrangler_MakeMasterData(classId)
	local classData = {};
	
	--============================================================================
	-- DRUID SETS
	--============================================================================
	if (classId == SW_CLASS_DRUID) then
		return SetWrangler_MakeDruidData();
	--============================================================================
	-- HUNTER SETS
	--============================================================================
	elseif (classId == SW_CLASS_HUNTER) then
		return SetWrangler_MakeHunterData();
	--============================================================================
	-- MAGE SETS
	--============================================================================
	elseif (classId == SW_CLASS_MAGE) then
		return SetWrangler_MakeMageData();
	--============================================================================
	-- PALADIN SETS
	--============================================================================
	elseif (classId == SW_CLASS_PALADIN) then
		return SetWrangler_MakePaladinData();
	--============================================================================
	-- PRIEST SETS
	--============================================================================
	elseif (classId == SW_CLASS_PRIEST) then
		return SetWrangler_MakePriestData();
	--============================================================================
	-- ROGUE SETS
	--============================================================================
	elseif (classId == SW_CLASS_ROGUE) then
		return SetWrangler_MakeRogueData();
	--============================================================================
	-- SHAMAN SETS
	--============================================================================
	elseif (classId == SW_CLASS_SHAMAN) then
		return SetWrangler_MakeShamanData();
	--============================================================================
	-- WARLOCK SETS
	--============================================================================
	elseif (classId == SW_CLASS_WARLOCK) then
		return SetWrangler_MakeWarlockData();
	--============================================================================
	-- WARRIOR SETS
	--============================================================================
	elseif (classId == SW_CLASS_WARRIOR) then
		return SetWrangler_MakeWarriorData();
	--============================================================================
	-- WARDROBE SETS
	--============================================================================
	elseif (classId == SW_CLASS_OTHER) then
		return SetWrangler_MakeOtherData();
	--============================================================================
	-- WEAPON SETS
	--============================================================================
	elseif (classId == SW_CLASS_WEAPONS) then
		return SetWrangler_MakeWeaponData();
	--============================================================================
	-- PVPA SETS
	--============================================================================
	elseif (classId == SW_CLASS_PVPA) then
		return SetWrangler_MakePVPAData();
		--============================================================================
	-- PVPH SETS
	--============================================================================
	elseif (classId == SW_CLASS_PVPH) then
		return SetWrangler_MakePVPHData();
	--============================================================================
	-- DEFAULT HANDLER
	--============================================================================
	else
		classData.sName							= "Unknown";
		classData.aSetData						= {};
	end

	return classData;
end


function SetWrangler_MakeSetData(name,tabName,info,stats)
	local setData = {};
	
	setData.sName = name;
	setData.sTabName = tabName;
	setData.setInfo = info;
	setData.setStats = stats;
	setData.aPartData = {};

	return setData;
end

function SetWrangler_MakePartData(link, stats, info, icon, link2, link3, link4)
	local partData = {};

	partData.itemLink = link;
	partData.itemStats = stats;
	partData.itemInfo = info;
	partData.itemInfoIcon = icon;
	partData.itemLink2 = link2;
	partData.itemLink3 = link3;
	partData.itemLink4 = link4;

	return partData;
end