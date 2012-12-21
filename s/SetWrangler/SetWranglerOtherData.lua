function SetWrangler_MakeOtherData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_OTHER];
	classData.aSetData						= {};
	
	
	------------------------------------
	--  Set 1
	------------------------------------
	setIndex = 1;
	setName = "Black Dragon Mail";
	setTabName = "Black Dragon";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to hit by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Fire Resistance.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1200\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."35\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."55\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Attack Pwr: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."172\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."350\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:15051:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15050:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15052:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16984:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	--  Set 2
	------------------------------------
	setIndex = 2;
	setName = "Blood Tiger Harness";
	setTabName = "Blood Tiger";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike with spells by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."317\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."28\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."23\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."160\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19689:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19688:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 3
	------------------------------------
	setIndex = 3;
	setName = "Bloodsoul Embrace";
	setTabName = "Bloodsoul";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Restores 12 mana per 5 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."905\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."43\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."40\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."230\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19691:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19690:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19692:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 4
	------------------------------------
	setIndex = 4;
	setName = "Bloodvine Garb";
	setTabName = "Bloodvine";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike with spells by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  		  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."235\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."35\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."185\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19682:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Tailors\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19683:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Tailors\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19684:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Tailors\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 5
	------------------------------------
	setIndex = 5;
	setName = "Blue Dragon Mail";
	setTabName = "Blue Dragon";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +4 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 28.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."910\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."69\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."33\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Arcane: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."26\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."280\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:15049:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15048:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20295:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 6
	------------------------------------
	setIndex = 6;
	setName = "The Darksoul";
	setTabName = "Darksoul";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increased Defense +20.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1965\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."78\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."To Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."315\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19695:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19693:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19694:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 7
	------------------------------------
	setIndex = 7;
	setName = "Devilsaur Armor";
	setTabName = "Devilsaur Armor";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to hit by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."251\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."21\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."110\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:15062:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15063:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 8
	------------------------------------
	setIndex = 8;
	setName = "The Gladiator";
	setTabName = "Gladiator";
	setInfo = "Lesser Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Armor\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increased Defense +2\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Attack Power\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike by 1%\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1384\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."25\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."22\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."87\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."44\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."13\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."400\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:11729:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_BRD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gorosh the Dervish (7.3%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:11726:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_BRD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gorosh the Dervish (7.3%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:11728:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_BRD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gorosh the Dervish (13.4%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:11730:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_BRD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gorosh the Dervish (18.5%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:11731:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_BRD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gorosh the Dervish (21.6%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	--  Set 9
	------------------------------------
	setIndex = 9;
	setName = "Green Dragon Mail";
	setTabName = "Green Dragon";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Restores 3 mana per 5 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Allows 15% of your Mana regeneration to continue while casting.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."801\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."25\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."61\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Nature: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."31\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."250\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:15045:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15046:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20296:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 10
	------------------------------------
	setIndex = 10;
	setName = "Imperial Plate";
	setTabName = "Imperial";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +100 Armor\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +28 Attack Power\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +18 Stamina\n\n"..SW_LINK_COLOR_CLOSE
			 
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2809\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."100\n"..SW_LINK_COLOR_CLOSE			 
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."11\n"..SW_LINK_COLOR_CLOSE			  
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."475\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:12427:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:12428:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:12422:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:12429:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:12426:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:12424:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:12425:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Blacksmiths\n";
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Set 11
	------------------------------------
	setIndex = 11;
	setName = "Ironfeather Armor";
	setTabName = "Ironfeather";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 20.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."282\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."32\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."36\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."160\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:15067:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15066:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 12
	------------------------------------
	setIndex = 12;
	setName = "Prayer of the Primal";
	setTabName = "Primal";
	setInfo = "ZG Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases healing done by spells and effects by up to 33.\n\n"..SW_LINK_COLOR_CLOSE
				  
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19920:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."High Priestess Jeklik (6.1%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:19863:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Bloodlord Mandokir (6.1%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 13
	------------------------------------
	setIndex = 13;
	setName = "Primal Batskin";
	setTabName = "Primal Batskin";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Minor increase to running and swimming speed.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."373\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."56\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."22\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."To Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."170\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19685:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19686:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19687:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 14
	------------------------------------
	setIndex = 14;
	setName = "Chain of the Scarlet Crusade";
	setTabName = "Scarlet Crusade";
	setInfo = "Lesser Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increased Defense +1.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +5 Shadow Resistance.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +15 Attack Power when fighting Undead.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to hit by 1%.\n\n"..SW_LINK_COLOR_CLOSE


			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1001\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."44\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."12\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."56\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."375\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:10328:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_SM;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SM.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Scarlet Champion (0.3%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:10330:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_SM;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SM.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Herod (13.2%)\n"
				  .."Scarlet Commander Mograine (12.4%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:10331:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_SM;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SM.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Scarlet Centurion (1.6%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:10332:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_SM;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SM.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
		          .."Scarlet Gallant (0.1%)\n"
				  .."Scarlet Monk (0.1%)\n"
				  .."Scarlet Centurion (0.1%)\n"
				  .."Scarlet Diviner (0.1%)\n"
				  .."Scarlet Defender (0.1%)\n"
				  .."Scarlet Myrmidon (0.1%)\n"
				  .."Scarlet Beastmaster (0.1%)\n"
				  .."Scarlet Chaplain (0.1%)\n"
				  .."Scarlet Guardsman (0.1%)\n"
				  .."Scarlet Protector (0.1%)\n"
				  .."Scarlet Wizard (0.1%)\n"
				  .."Scarlet Adept (0.1%)\n"
				  .."Scarlet Tracking Hound (0.1%)\n"
				  .."Scarlet Soldier (0.1%)\n"
				  .."Scarlet Conjuror (0.1%)\n"
				  .."Scarlet Evoker (0.1%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:10329:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_SM;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SM.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Scarlet Myrmidon (1.5%)\n"
				  .."Scarlet Defender (1.5%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:10333:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_SM;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SM.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Scarlet Guardsman (1.6%)\n"
				  .."Scarlet Protector (1.6%)\n";
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	--  Set 15
	------------------------------------
	setIndex = 15;
	setName = "Stormshroud Armor";
	setTabName = "Stormshroud";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5% chance of dealing 15 to 25 Lightning damage on a successful melee attack.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2% chance on melee attack of restoring 30 energy.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."427\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."12\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."5\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."235\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:15058:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15056:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15057:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 16
	------------------------------------
	setIndex = 16;
	setName = "Twilight Trappings";
	setTabName = "Twilight";
	setInfo = "Lesser Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Bestows the wearer with the evil aura of a Twilight's Hammer cultist.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."198\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."160\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:20408:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_SIL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SIL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Twilight Overlord (3.8%)\n"
				  .."Twilight Flamereaver (4.4)\n"
				  .."Twilight Master (3.7%)\n"
				  .."Twilight Stonecaller (4.9%)\n"
				  .."Twilight Geolord (4.0%)\n"
				  .."Twilight Avenger (3.9%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20406:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_SIL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SIL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Twilight Overlord (3.8%)\n"
				  .."Twilight Flamereaver (4.4)\n"
				  .."Twilight Master (3.7%)\n"
				  .."Twilight Stonecaller (4.9%)\n"
				  .."Twilight Geolord (4.0%)\n"
				  .."Twilight Avenger (3.9%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20407:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_SIL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SIL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Twilight Overlord (3.8%)\n"
				  .."Twilight Flamereaver (4.4)\n"
				  .."Twilight Master (3.7%)\n"
				  .."Twilight Stonecaller (4.9%)\n"
				  .."Twilight Geolord (4.0%)\n"
				  .."Twilight Avenger (3.9%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 17
	------------------------------------
	setIndex = 17;
	setName = "Volcanic Armor";
	setTabName = "Volcanic";
	setInfo = "Crafted Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5% chance of dealing 15 to 25 Fire damage on a successful melee attack.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."639\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."58\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."200\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:15055:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15053:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:15054:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_AH;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Crafted by Leatherworkers\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 18
	------------------------------------
	setIndex = 18;
	setName = "Zanzil's Concentration";
	setTabName = "Zanzil";
	setInfo = "ZG Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to hit with spells by 1%..\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 6.\n\n"..SW_LINK_COLOR_CLOSE
				  
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19905:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."High Priest Venoxis (6.4%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:19893:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Bloodlord Mandokir (9.6%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 19
	------------------------------------
	setIndex = 19;
	setName = "Major Mojo Infusion";
	setTabName = "Mojo";
	setInfo = "ZG Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +30 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
				  
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19925:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."High Priestess Mar'li (8.2%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:19898:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."High Priest Thekal (8.3%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	-----------------------------------
	--  Set 20
	-----------------------------------
	setIndex = 20;
	setName = "Defias Leather";
	setTabName = "Defias";
	setInfo = "Defias Set";
	setStats = SW_TEXT_BONUS_HEADER.."\n\n"
			   ..SW_GOLD_OPEN.."2"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."3"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +5 Arcane Resistance.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."4"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increased Daggers +1.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."5"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			   
			   ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."9\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."299\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."24\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."15\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);
	
	partLink	= "item:10399:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_VC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_VC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Edwin VanCleef (14.63%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10400:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_VC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_VC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Defias Overseer (1.64%)\n"
				  .."Defias Taskmaster (1.68%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10401:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_VC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_VC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Defias Overseer (1.77%)\n"
				  .."Defias Taskmaster (1.72%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10402:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_VC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_VC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Defias Strip Miner (1.23%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10403:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_VC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_VC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Captain Greenskin (24.07%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	-----------------------------------
	--  Set 21
	-----------------------------------
	setIndex = 21;
	setName = "Embrace of the Viper";
	setTabName = "Viper";
	setInfo = "Viper Set";
	setStats = SW_TEXT_BONUS_HEADER.."\n\n"
			   ..SW_GOLD_OPEN.."2"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage done by Nature Spells and effects by up to 7.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."3"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increased Staves +2.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."4"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases Healing done by spells and effects by up 2 11.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."5"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Intellect.\n\n"..SW_LINK_COLOR_CLOSE
			   
			   ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."18\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."310\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."7\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."11\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."9\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);
	
	partLink	= "item:6473:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_WC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_WC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lord Pythas (1.9%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10410:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_WC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_WC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lord Cobrahn (15.92%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10413:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_WC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_WC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Druid of the Fang (1.21%%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10411:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_WC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_WC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lord Serpentis (18.98%%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:10412:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_WC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_WC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lady Anacondra (8.82%%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 22
	------------------------------------
	setIndex = 22;
	setName = "Shard of the Gods";
	setTabName = "Gods";
	setInfo = "God Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Regen: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."16 Mana Regen per 5 secs.\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Regen: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."16 Health Regen per 5 secs.\n"..SW_LINK_COLOR_CLOSE;
				  
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:17082:0:0:0";
	partInfo	= SW_TEXT_TRINKET.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ragnaros (4.57%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:17064:0:0:0";
	partInfo	= SW_TEXT_TRINKET.." - "..SW_AREA_OL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_OL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Onyxia (3.86%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 23
	------------------------------------
	setIndex = 23;
	setName = "Overlords Resolution";
	setTabName = "Overlord";
	setInfo = "Overlord Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases Chance to Dodge by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."8\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."21\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."9\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defence: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."7\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Block with Shield: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Dodge: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE;
				  
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19873:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Bloodlord Mandokir (11.31%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:19912:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_ZG;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_ZG.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."High Priestess Arlokk (15.68%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 24
	------------------------------------
	setIndex = 24;
	setName = "Regalia of Undead Cleansing";
	setTabName = "Undead Cleansing";
	setInfo = "Cloth Undead";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your damage aginst Undead by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."184\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."28\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Spell Damage to Undead: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."109\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:23091:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Bone Witch (20.68%)\n"
				  .."Lumbering Horror (22.01%)\n"
				  .."Spirit of the Damned (20.42%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23084:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Argent Dawn Gloves";  -- quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				   ..SW_GOLD_OPEN.."Necrotic Runes: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 30\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23085:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Shadow of Doom (6.35%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 25
	------------------------------------
	setIndex = 25;
	setName = "Undead Slayer Armor";
	setTabName = "Undead Slayer";
	setInfo = "Leather Undead";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your damage aginst Undead by 3%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."363\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."45\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Attack Power to Undead: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."186\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:23093:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Bone Witch (20.82%)\n"
				  .."Lumbering Horror (19.50%)\n"
				  .."Spirit of the Damned (21.54%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23081:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Argent Dawn Gloves";  -- quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				   ..SW_GOLD_OPEN.."Necrotic Runes: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 30\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23089:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Shadow of Doom (6.33%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 26
	------------------------------------
	setIndex = 26;
	setName = "Garb of the Undead Slayer";
	setTabName = "Undead Slayer";
	setInfo = "Mail Undead";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your damage aginst Undead by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."763\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."45\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Attack Power to Undead: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."186\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:23092:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Bone Witch (20.63%)\n"
				  .."Lumbering Horror (20.04%)\n"
				  .."Spirit of the Damned (18.74%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23082:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Argent Dawn Gloves";  -- quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				   ..SW_GOLD_OPEN.."Necrotic Runes: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 30\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23088:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Shadow of Doom (7.19%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	--  Set 27
	------------------------------------
	setIndex = 27;
	setName = "Battlegear of the Undead Slayer";
	setTabName = "Undead Slayer";
	setInfo = "Plate Undead";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your damage aginst Undead by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1354\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."45\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Attack Power to Undead: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."186\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:23090:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Bone Witch (20.68%)\n"
				  .."Lumbering Horror (18.81%)\n"
				  .."Spirit of the Damned (19.72%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23078:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Argent Dawn Gloves";  -- quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				   ..SW_GOLD_OPEN.."Necrotic Runes: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 30\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:23087:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_EPL;
	partStats	= SW_TEXT_INFO.."\n"
				  ..SW_WHITE_OPEN
				  .."Shadow of Doom (6.33%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	-----------------------------------
	--  Set 28
	-----------------------------------
	setIndex = 28;
	setName = "Ironweave Battlesuit";
	setTabName = "Ironweave";
	setInfo = "Ironweave Set";
	setStats = SW_TEXT_BONUS_HEADER.."\n\n"
			   ..SW_GOLD_OPEN.."4"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your chance to resist Silence and Interupt effects by 10%.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."8"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			   
			   ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."299\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."97\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."154\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);
	
	partLink	= "item:22306:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Mor Grayhoof (22.31%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:22313:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Halycon (17.60%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:22304:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_DME;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_DME.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Isalien (18.78%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:22303:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Kormok (24.21%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:22311:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."The Beast (12.51%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:22302:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lord Valthalak (26.90%)\n";
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	partLink	= "item:22305:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_BRD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Arena (29.69%)\n"
				  .."Deep Stinger (0.03%)\n"
				  .."Korv (20.00%)\n"
				  .."Lefty (33.33%)\n"
				  .."Malgen Longspear (40.00%)\n"
				  .."Rotfang (9.09%)\n"
				  .."Snokh Blackspine (20.00%)\n"
				  .."Theldren (0.87%)\n"
				  .."Volida (9.09%)\n";
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	partLink	= "item:22301:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_STRAT_LIVE;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_LIVE.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Sothos and Jarien's Heirlooms (19.34%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	-----------------------------------
	--  Set 29
	-----------------------------------
	setIndex = 29;
	setName = "The Postmaster";
	setTabName = "Postmaster";
	setInfo = "Postmaster Set";
	setStats = SW_TEXT_BONUS_HEADER.."\n\n"
			   ..SW_GOLD_OPEN.."2"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +50 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."3"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Fire Resistance.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."3"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Arcane Resistance.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."4"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage healing done by spells and effects by up to 12.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."5"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Run Speed +5%.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."5"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Intellect.\n\n"..SW_LINK_COLOR_CLOSE
			   
			   ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."293\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."83\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."63\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."55\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);
	
	partLink	= "item:13388:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Postmaster Malown (14.75%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:13389:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Postmaster Malown (16.36%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:13392:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Postmaster Malown (12.49%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:13391:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Postmaster Malown (10.49%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:13390:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Postmaster Malown (7.21%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	-----------------------------------
	--  Set 30
	-----------------------------------
	setIndex = 30;
	setName = "Cadaverous Garb";
	setTabName = "Cadaverous";
	setInfo = "Cadaverous Set";
	setStats = SW_TEXT_BONUS_HEADER.."\n\n"
			   ..SW_GOLD_OPEN.."2"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Defence +3.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."3"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."4"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +15 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."5"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." %Hit +2%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			   ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."8\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."644\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."59\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);
	
	partLink	= "item:14637:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (2.33%)\n"
				  .."Instructor Malicia (1.23%)\n"
				  .."Lady Illucia Barov (0.76%)\n"
				  .."Lord Alexei Barov (3.67%)\n"
				  .."Lore Keeper Polket (0.39%\n"
				  .."The Ravenian (1.10%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14636:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (2.24%)\n"
				  .."Instructor Malicia (0.90%)\n"
				  .."Lady Illucia Barov (0.88%)\n"
				  .."Lord Alexei Barov (2.72%)\n"
				  .."Lore Keeper Polket (0.51%\n"
				  .."The Ravenian (0.83%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14640:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (2.07%)\n"
				  .."Instructor Malicia (0.95%)\n"
				  .."Lady Illucia Barov (0.98%)\n"
				  .."Lord Alexei Barov (2.39%)\n"
				  .."Lore Keeper Polket (0.46%)\n"
				  .."The Ravenian (1.02%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14638:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (2.34%)\n"
				  .."Instructor Malicia (1.06%)\n"
				  .."Lady Illucia Barov (0.92%)\n"
				  .."Lord Alexei Barov (2.31%)\n"
				  .."Lore Keeper Polket (0.44%\n"
				  .."The Ravenian (0.73%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14641:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (2.03%)\n"
				  .."Instructor Malicia (0.68%)\n"
				  .."Lady Illucia Barov (0.69%)\n"
				  .."Lord Alexei Barov (2.35%)\n"
				  .."Lore Keeper Polket (0.31%\n"
				  .."The Ravenian (0.86%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	-----------------------------------
	--  Set 31
	-----------------------------------
	setIndex = 31;
	setName = "Bloodmail Regalia";
	setTabName = "Bloodmail";
	setInfo = "Bloodmail Set";
	setStats = SW_TEXT_BONUS_HEADER.."\n\n"
			   ..SW_GOLD_OPEN.."2"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases Defence +3.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."3"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +10 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."4"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +15 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."5"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your chance to parry an attack by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			   ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."33\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1349\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."59\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."62\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."55\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);
	
	partLink	= "item:14611:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (0.79%)\n"
				  .."Instructor Malicia (0.27%)\n"
				  .."Lady Illucia Barov (0.41%)\n"
				  .."Lord Alexei Barov (1.05%)\n"
				  .."Lore Keeper Polket (0.20%\n"
				  .."The Ravenian (0.02%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14614:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (0.77%)\n"
				  .."Instructor Malicia (0.38%)\n"
				  .."Lady Illucia Barov (0.32%)\n"
				  .."Lord Alexei Barov (0.83%)\n"
				  .."Lore Keeper Polket (0.17%\n"
				  .."The Ravenian (0.12%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14615:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (0.85%)\n"
				  .."Instructor Malicia (0.27%)\n"
				  .."Lady Illucia Barov (0.28%)\n"
				  .."Lord Alexei Barov (1.12%)\n"
				  .."Lore Keeper Polket (0.21%)\n"
				  .."The Ravenian (0.09%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14612:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (0.74%)\n"
				  .."Instructor Malicia (0.27%)\n"
				  .."Lady Illucia Barov (0.47%)\n"
				  .."Lord Alexei Barov (1.24%)\n"
				  .."Lore Keeper Polket (0.15%\n"
				  .."The Ravenian (0.07%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14616:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (0.62%)\n"
				  .."Instructor Malicia (0.38%)\n"
				  .."Lady Illucia Barov (0.32%)\n"
				  .."Lord Alexei Barov (0.83%)\n"
				  .."Lore Keeper Polket (0.17%\n"
				  .."The Ravenian (0.12%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	-----------------------------------
	--  Set 32
	-----------------------------------
	setIndex = 32;
	setName = "Deathbone Guardian";
	setTabName = "Deathbone";
	setInfo = "Deathbone Set";
	setStats = SW_TEXT_BONUS_HEADER.."\n\n"
			   ..SW_GOLD_OPEN.."2"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Defence +3.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."3"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +50 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."4"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +15 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."5"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your chance to parry an attack by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			   ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2388\n"..SW_LINK_COLOR_CLOSE
			   ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."70\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);
	
	partLink	= "item:14624:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (1.35%)\n"
				  .."Instructor Malicia (0.50%)\n"
				  .."Lady Illucia Barov (0.50%)\n"
				  .."Lord Alexei Barov (1.79%)\n"
				  .."Lore Keeper Polket (0.24%\n"
				  .."The Ravenian (0.98%)\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14620:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (1.40%)\n"
				  .."Instructor Malicia (0.49%)\n"
				  .."Lady Illucia Barov (0.55%)\n"
				  .."Lord Alexei Barov (1.75%)\n"
				  .."Lore Keeper Polket (0.18%\n"
				  .."The Ravenian (1.02%)\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14622:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (1.52%)\n"
				  .."Instructor Malicia (0.43%)\n"
				  .."Lady Illucia Barov (0.58%)\n"
				  .."Lord Alexei Barov (1.94%)\n"
				  .."Lore Keeper Polket (0.27%)\n"
				  .."The Ravenian (0.78%)\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14623:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (1.39%)\n"
				  .."Instructor Malicia (0.69%)\n"
				  .."Lady Illucia Barov (0.76%)\n"
				  .."Lord Alexei Barov (1.94%)\n"
				  .."Lore Keeper Polket (0.31%\n"
				  .."The Ravenian (0.82%)\n";
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:14621:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Doctor Theolen Krastinov (1.48%)\n"
				  .."Instructor Malicia (0.54%)\n"
				  .."Lady Illucia Barov (0.57%)\n"
				  .."Lord Alexei Barov (1.93%)\n"
				  .."Lore Keeper Polket (0.29%\n"
				  .."The Ravenian (0.91%)\n";
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
    ---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end