-- PVPH Data

function SetWrangler_MakePVPHData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_PVPH];
	classData.aSetData						= {};


    ------------------------------------
	--  Set 1
	------------------------------------
	setIndex = 1;
	setName = "High Warlord Weapons";
	setTabName = "One Hand";
	setInfo = "PvP Weapons - (Horde)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	
	partLink	= "item:23464:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:16345:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18866:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18823:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23467:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18840:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18844:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23466:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[8]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	------------------------------------
	--  Set 2
	------------------------------------
	setIndex = 2;
	setName = "High Warlord Weapons";
	setTabName = "Two Hand";
	setInfo = "PvP Weapons - (Horde)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	partLink	= "item:18831:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23465:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18877:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18871:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18868:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18874:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	------------------------------------
	--  Set 3
	------------------------------------
	setIndex = 3;
	setName = "High Warlord Weapons";
	setTabName = "Ranged";
	setInfo = "PvP Weapons - (Horde)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	partLink	= "item:18837:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_RANGE.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);

	partLink	= "item:18835:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_RANGE.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18860:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_RANGE.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	------------------------------------
	--  Set 4
	------------------------------------
	setIndex = 4;
	setName = "High Warlord Weapons";
	setTabName = "Off Hand";
	setInfo = "PvP Weapons - (Horde)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	partLink	= "item:18848:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);

	partLink	= "item:18826:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23468:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23469:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_H[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end