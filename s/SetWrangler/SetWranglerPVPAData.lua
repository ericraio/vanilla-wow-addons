-- PVPA Data

function SetWrangler_MakePVPAData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_PVPA];
	classData.aSetData						= {};


	------------------------------------
	--  Set 1
	------------------------------------
	setIndex = 1;
	setName = "Grand Marshal Weapons";
	setTabName = "One Hand";
	setInfo = "PvP Weapons - (Alliance)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	
	partLink	= "item:18838:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18827:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:12584:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23451:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18865:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18843:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23456:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23454:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[8]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	------------------------------------
	--  Set 2
	------------------------------------
	setIndex = 2;
	setName = "Grand Marshal Weapons";
	setTabName = "Two Hand";
	setInfo = "PvP Weapons - (Alliance)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	partLink	= "item:18867:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18876:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23455:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18869:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18873:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18830:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_HAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	------------------------------------
	--  Set 3
	------------------------------------
	setIndex = 3;
	setName = "Grand Marshal Weapons";
	setTabName = "Ranged";
	setInfo = "PvP Weapons - (Alliance)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	partLink	= "item:18833:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_RANGE.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);

	partLink	= "item:18855:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_RANGE.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:18836:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_RANGE.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	------------------------------------
	--  Set 4
	------------------------------------
	setIndex = 4;
	setName = "Grand Marshal Weapons";
	setTabName = "Off Hand";
	setInfo = "PvP Weapons - (Alliance)";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	partLink	= "item:18825:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);

	partLink	= "item:18847:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23452:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	partLink	= "item:23453:0:0:0";
	partIcon	= SW_RANK_ICONS[SW_RANK_14_INDEX];
	partInfo	= SW_TEXT_OHAND.." - "..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
					  ..SW_WHITE_OPEN.."       "
					  ..SW_TEXT_RANK_NAMES_A[SW_RANK_14_INDEX]
					  .." (Rank "
					  ..SW_TEXT_RANK_NUMBERS[SW_RANK_14_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo, partIcon);
	
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end