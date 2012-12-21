-- Weapons Data

function SetWrangler_MakeWeaponData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_WEAPONS];
	classData.aSetData						= {};


	------------------------------------
	--  Set 1
	------------------------------------
	setIndex = 1;
	setName = "The Twin Blades of Hakkari";
	setTabName = "Blades of Hakkari";
	setInfo = "Weapon Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increased Swords +6.\n\n"..SW_LINK_COLOR_CLOSE
					  
			  ..SW_GOLD_OPEN.."Attack Pwr: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."68\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."210\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19865:0:0:0";
	partInfo	= SW_TEXT_HAND.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Hakkar (2.4%)"
				  .."Bloodlord Mandokir (2.7%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19866:0:0:0";
	partInfo	= SW_TEXT_OHAND.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Hakkar (2.4%)"
				  .."Bloodlord Mandokir (2.7%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 2
	------------------------------------
	setIndex = 2;
	setName = "Dal'Rend's Arms";
	setTabName = "Dal'Rend";
	setInfo = "Weapon Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +50 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."100\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."7\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."180\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:12940:0:0:0";
	partInfo	= SW_TEXT_HAND.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Warchief Rend Blackhand (3.3%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:12939:0:0:0";
	partInfo	= SW_TEXT_OHAND.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Warchief Rend Blackhand (9.2%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 3
	------------------------------------
	setIndex = 3;
	setName = "Primal Blessing";
	setTabName = "Primal Blessing";
	setInfo = "Weapon Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Grants a small chance when ranged or melee damage is dealt to infuse the wielder with a blessing from the Primal Gods. Ranged and melee attack power increased by 300 for 12 seconds.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."13\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."150\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19896:0:0:0";
	partInfo	= SW_TEXT_HAND.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."High Priest Thekal (1.2%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19910:0:0:0";
	partInfo	= SW_TEXT_OHAND.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."High Priestess Arlokk (0.9%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Set 4
	------------------------------------
	setIndex = 4;
	setName = "Spider's Kiss";
	setTabName = "Spider's Kiss";
	setInfo = "Weapon Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Chance on Hit: Immobilizes the target and lowers their armor by 100 for 10 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."155\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:13218:0:0:0";
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Crystal Fang (%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:13183:0:0:0";
	partInfo	= SW_TEXT_ONEHAND.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Mother Smolderweb (0.9%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 5
	------------------------------------
	setIndex = 5;
	setName = "Spirit of Eskhandar";
	setTabName = "Spirit of Eskhandar";
	setInfo = "Weapon Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1% Chance on Melee Critical hit to call forth Eskhandar to protect you in Battle for 2 minutes.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."8\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."51\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."37\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Chance on Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."Increase Attack Speed by 30% for 5 seconds.\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Chance on Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."Slows Enemy movement by 60% and causes them t0 bleed for 150 damage over 30 seconds\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:18203:0:0:0";
	partInfo	= SW_TEXT_HAND.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Magmadar (17.41%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:18202:0:0:0";
	partInfo	= SW_TEXT_OHAND.." - "..SW_AREA_AZ;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_AZ.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Azuregos (12.72%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:18204:0:0:0";
	partInfo	= SW_TEXT_BACK.." - "..SW_AREA_BL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lord Kazzak (9.02%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:18205:0:0:0";
	partInfo	= SW_TEXT_NECK.." - "..SW_AREA_OL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_OL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Onyxia (14.71%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 6
	------------------------------------
	setIndex = 6;
	setName = "Legendary";
	setTabName = "Legendary";
	setInfo = "Legendary Weapons";
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo);

	partLink	= "item:19019:0:0:0";
	partInfo	= SW_TEXT_ONEHAND.."\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partInfo);
	
	partLink	= "item:17182:0:0:0";
	partInfo	= SW_TEXT_HAND.."\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partInfo);
	
	partLink	= "item:22631:0:0:0";
	partInfo	= SW_TEXT_HAND.."\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partInfo);
	
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end