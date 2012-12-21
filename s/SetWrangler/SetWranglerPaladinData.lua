-- Paladin Data

function SetWrangler_MakePaladinData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_PALADIN];
	classData.aSetData						= {};

	------------------------------------
	-- Paladin Set 1
	------------------------------------
	setIndex = 1;
	setName = "Lightforge Armor";
	setTabName = "Lightforge";
	setInfo = "Dungeon 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +40 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Chance on Melee attack to increase your damage and healing done by magical spells and effects by up to 95 for 10 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3622\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."94\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."22\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."116\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."68\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."69\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."595\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16727:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Darkmaster Gandling (4.6%)";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16726:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."General Drakkisath (4.2%)";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16728:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_STRAT_UD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_UD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Rivendare (4.9%)";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16724:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_BRD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Emperor Dagran Thaurissan (8.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16725:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_STRAT_LIVE;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_LIVE.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Balnazzar (9.9%)";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16723:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Crimson Gallant (2.0%)\n"
				  .."Rockwing Screecher (1.8%)\n"
				  .."Rockwing Gargoyle (2.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16722:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lord Alexei Barov (2.5%)\n"
				  .."Risen Warrior (2.5%)\n"
				  .."Risen Protector (1.7%)\n";
				  classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16729:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."The Beast (12.9%)";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	-- Paladin Set 2
	------------------------------------
	setIndex = 2;
	setName = "Soulforge Armor";
	setTabName = "Soulforge";
	setInfo = "Dungeon 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Chance on melee attack to increase your damage and healing done by magical spells and effects by up to 95 for 10 seconds.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +40 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3887\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."98\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."106\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."104\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."44\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."665\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22091:0:0:0";
	partInfo	= Unknown
	partStats	= Unknown
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22089:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22092:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22090:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22087:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22086:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22088:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22093:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Paladin Set 3
	------------------------------------
	setIndex = 3;
	setName = "Lawbringer Armor";
	setTabName = "Lawbringer";
	setInfo = "Tier 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the chance of triggering a Judgement of Light heal by 10%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike with spells by 1%, Improves your chance to get a critical strike by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Gives the Paladin a chance on every melee hit to heal your party for 189 to 211.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4306\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."74\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."153\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."134\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."92\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."34\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."24\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."725\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16854:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Garr (5.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16853:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Golemagg the Incinerator (11.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16855:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Magmadar (10.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16860:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gehennas (8.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16859:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lucifron (4.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16858:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Flameguard (0.3%)\n"
				  .."Molten Giant (0.1%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.1%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Ancient Core Hound (0.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16857:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Molten Giant (0.4%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.1%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Ancient Core Hound (0.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16856:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Geddon (7.5%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Paladin Set 4
	------------------------------------
	setIndex = 4;
	setName = "Judgement Armor";
	setTabName = "Judgement";
	setInfo = "Tier 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the radius of a Paladin's auras by 10.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 47.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Inflicts 60 to 66 additional Holy damage on the target of a Paladin's Judgement.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4925\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."92\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."155\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."148\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."50\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."40\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Nature: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Frost: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Arcane: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."725\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16955:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_OL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_OL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Onyxia (10.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16958:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Nefarian (7.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16954:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ragnaros (8.8%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16956:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Firemaw (1.1%)\n"
				  .."Ebonroc (4.6%)\n"
				  .."Flamegor (7.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16957:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Broodlord Lashlayer (14.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16952:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Vaelastrasz the Corrupt (14.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16951:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Razorgore the Untamed (18.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16953:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Chromaggus (15.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	------------------------------------
	--  Paladin Set 5
	------------------------------------
	setIndex = 5;
	setName = "Redemption Armor";
	setTabName = "Redemption";
	setInfo = "Tier 3 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the amount healed by your Judgement of Light by 20.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces cooldown on your Lay on Hands by 12 min.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your Flash of Light and Holy Light spells have a chance to imbue your target with Holy Power.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your Cleanse spell also heals the target for 200.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."5672\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."0\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."191\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."192\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical Spell: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."5%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Healing: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."351\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Regen: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."52 mana/5 sec\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."NA"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22428:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Redemption Headpiece";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Headpiece: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 15\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22425:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Redemption Tunic";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Tunic: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 25\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22427:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Redemption Legguards";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Legguards: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22426:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - ".."Redemption Handguards";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Handguards: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22430:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Redemption Boots";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Boots: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22431:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Redemption Girdle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Girdle: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22424:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Redemption Wristguards";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Wristguards: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 6\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[8]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22429:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Redemption Spaulders";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Spaulders: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	-- Paladin  Set 6
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	setName = "Lieutenant Commander's Redoubt";
	setTabName = "Lt Commander";
		
	handsLink		= "item:23274:0:0:0";
	feetLink		= "item:23275:0:0:0";
	chestLink		= "item:23272:0:0:0";
	legsLink		= "item:23273:0:0:0";
	shoulderLink	= "item:23277:0:0:0";
	headLink		= "item:23276:0:0:0";
		
	setIndex = 6;
	setInfo = "PvP Tier 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the cooldown of your Hammer of Justice by 10 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
		  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3375\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."91\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."93\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."56\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partIcon	= SW_RANK_ICONS[SW_RANK_7_INDEX];
	partInfo	= SW_TEXT_HANDS.." - "..SW_TEXT_RANK_NAMES[SW_RANK_7_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_7_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_7_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(handsLink, partStats, partInfo, partIcon);

	partIcon	= SW_RANK_ICONS[SW_RANK_7_INDEX];
	partInfo	= SW_TEXT_FEET.." - "..SW_TEXT_RANK_NAMES[SW_RANK_7_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_7_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_7_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(feetLink, partStats, partInfo, partIcon);
	
	partIcon	= SW_RANK_ICONS[SW_RANK_8_INDEX];
	partInfo	= SW_TEXT_CHEST.." - "..SW_TEXT_RANK_NAMES[SW_RANK_8_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_8_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_8_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(chestLink, partStats, partInfo, partIcon);

	partIcon	= SW_RANK_ICONS[SW_RANK_8_INDEX];
	partInfo	= SW_TEXT_LEGS.." - "..SW_TEXT_RANK_NAMES[SW_RANK_8_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_8_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_8_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(legsLink, partStats, partInfo, partIcon);
	
	partIcon	= SW_RANK_ICONS[SW_RANK_10_INDEX];
	partInfo	= SW_TEXT_HEAD.." - "..SW_TEXT_RANK_NAMES[SW_RANK_10_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_10_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_10_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(headLink, partStats, partInfo, partIcon);

	partIcon	= SW_RANK_ICONS[SW_RANK_10_INDEX];
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_TEXT_RANK_NAMES[SW_RANK_10_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_10_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_10_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(shoulderLink, partStats, partInfo, partIcon);


	------------------------------------
	-- Paladin Set 7
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	setName = "Field Marshal's Aegis";
	setTabName = "Field Marshal";
	
	handsLink		= "item:16471:0:0:0";
	feetLink		= "item:16472:0:0:0";
	chestLink		= "item:16473:0:0:0";
	legsLink		= "item:16475:0:0:0";
	shoulderLink	= "item:16476:0:0:0";
	headLink		= "item:16474:0:0:0";
		
	setIndex = 7;
	setInfo = "PvP Tier 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the cooldown of your Hammer of Justice by 10 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
	
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3897\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."111\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."111\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."103\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partIcon	= SW_RANK_ICONS[SW_RANK_12_INDEX];
	partInfo	= SW_TEXT_HANDS.." - "..SW_TEXT_RANK_NAMES[SW_RANK_12_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_12_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_12_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(handsLink, partStats, partInfo, partIcon);

	partIcon	= SW_RANK_ICONS[SW_RANK_12_INDEX];
	partInfo	= SW_TEXT_FEET.." - "..SW_TEXT_RANK_NAMES[SW_RANK_12_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_12_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_12_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(feetLink, partStats, partInfo, partIcon);
	
	partIcon	= SW_RANK_ICONS[SW_RANK_13_INDEX];
	partInfo	= SW_TEXT_CHEST.." - "..SW_TEXT_RANK_NAMES[SW_RANK_13_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_13_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_13_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(chestLink, partStats, partInfo, partIcon);

	partIcon	= SW_RANK_ICONS[SW_RANK_12_INDEX];
	partInfo	= SW_TEXT_LEGS.." - "..SW_TEXT_RANK_NAMES[SW_RANK_12_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_12_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_12_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(legsLink, partStats, partInfo, partIcon);
	
	partIcon	= SW_RANK_ICONS[SW_RANK_13_INDEX];
	partInfo	= SW_TEXT_HEAD.." - "..SW_TEXT_RANK_NAMES[SW_RANK_13_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_13_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_13_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(headLink, partStats, partInfo, partIcon);

	partIcon	= SW_RANK_ICONS[SW_RANK_13_INDEX];
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_TEXT_RANK_NAMES[SW_RANK_13_INDEX];
	partStats	= SW_TEXT_RANK_HEADER.."\n\n"
				  ..SW_WHITE_OPEN.."       "
				  ..SW_TEXT_RANK_NAMES[SW_RANK_13_INDEX] 
				  .." (Rank "
				  ..SW_TEXT_RANK_NUMBERS[SW_RANK_13_INDEX]..")\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(shoulderLink, partStats, partInfo, partIcon);


	------------------------------------
	--  Set 8
	------------------------------------
	setIndex = 8;
	setName = "Freethinker's Armor";
	setTabName = "Freethinker";
	setInfo = "Zul'Gurub";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Restores 4 mana per 5 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the casting time of your Holy Light spell by 0.1 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the duration of all Blessings by 10%.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1444\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."53\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."13\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."61\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."40\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."16\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."255\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19588:0:0:0";
	partLink2	= "item:19586:0:0:0";
	partLink3	= "item:19585:0:0:0";
	partLink4	= "item:19579:0:0:0";
	partInfo	= SW_TEXT_NECK.." - ".."Reputation with Zandalar Tribe.";
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN.."Exalted with the Zandalar Tribe\n\nA new trinket will be awarded for each rank of reputation with the Zandalar Tribe.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_OTHER.."\n\n";
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_NECK]	= SetWrangler_MakePartData(partLink, partStats, partInfo, nil, partLink2, partLink3, partLink4);

	partLink	= "item:19952:0:0:0";
	partInfo	= SW_TEXT_TRINKET.." - ".."Created.  Click to see details."; -- 
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Combine the following:\n\n"
				  .."* Punctured Voodoo Doll\n"
				  .."* Gri'lek's Blood\n"
				  .."* Renataki's Tooth\n"
				  .."* Wushoolay's Mane\n"
				  .."* Hazza'rah's Dream Thread\n\n"
				  .."Doll parts are scattered throughout Zul'Gurub.  The other parts are dropped by the bosses at the Edge of Madness.";
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_TRINK]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19825:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Paragons of Power: The Freethinker's Breastplate";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vilebranch Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Sandfury Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Tabard: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19826:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Paragons of Power: The Freethinker's Belt";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Bloodscalp Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Skullsplitter Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Shawl: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Purple Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19827:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Paragons of Power: The Freethinker's Armguards";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Zulian Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Witherbark Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Bindings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Red Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Set 9
	------------------------------------
	setIndex = 9;
	setName = "The Highlander's Resolution";
	setTabName = "Resolution (A)";
	setInfo = "Battleground Set - (Alliance)";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +5 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1374\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."49\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."29\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."42\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."210\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:20057:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Exalted with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20048:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Revered with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20041:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Honored with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Set 10
	------------------------------------
	setIndex = 10;
	setName = "The Highlander's Resolve";
	setTabName = "Resolve (A)";
	setInfo = "Battleground Set - (Alliance)";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +5 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1374\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."47\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."29\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."29\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."28\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."210\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:20058:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Exalted with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20049:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Revered with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20042:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Honored with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	-- Paladin AQ20 Set 11
	------------------------------------
	setIndex = 11;
	setName = "Battlegear of Eternal Justice";
	setTabName = "Eternal Justice";
	setInfo = "AQ20 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20% Chance to gain 100 Mana when you cast a Judgement.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."52\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."31\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."35\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."32\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21395:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Blade of Eternal Justice ";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Spiked Hilt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Amber Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Exalted\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21396:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - ".."Ring of Eternal Justice";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Magisterial Ring: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Vermillion Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21397:0:0:0";
	partInfo	= SW_TEXT_BACK.." - ".."Cape of Eternal Justice";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Regal Drape: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Obsidian Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Revered\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Paladin AQ20 Set
	------------------------------------

	------------------------------------
	-- Paladin AQ Set
	------------------------------------
	setIndex = 12;
	setName = "Avenger's Battlegear";
	setTabName = "Avenger";
	setInfo = "AQ40 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the duration of your Judgements by 20%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 71.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3783\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."100\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."63\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."101\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."95\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."44\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."560\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21387:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Avenger's Crown";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vek'lor's Diadem: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Rebirth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21389:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Avenger's Breastplate";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Carapace of the Old God: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Sage: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21390:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Avenger's Legguards";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Skin of the Great Sandworm: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Strife: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21388:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Avenger's Greaves";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Dominance: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Sage: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21391:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Avenger's Pauldrons";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Dominance: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Life: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]  = SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Paladin AQ Set
	------------------------------------
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end