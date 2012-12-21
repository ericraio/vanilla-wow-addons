-- Warlock Data

function SetWrangler_MakeWarlockData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_WARLOCK];
	classData.aSetData						= {};

	------------------------------------
	--  Set Warlock Set 1
	------------------------------------
	setIndex = 1;
	setName = "Dreadmist Raiment";
	setTabName = "Dreadmist";
	setInfo = "Dungeon 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage done to Demons by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When struck in combat has a chnace of causing the attacker to flee in terror for 2 seconds.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistance.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."491\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."114\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."118\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."95\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."375\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16698:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Darkmaster Gandling (7.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16700:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."General Drakkisath (7.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16699:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_STRAT_UD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_UD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Rivendare (6.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16705:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lorekeeper Polkelt (3.0%)\n"
				  .."Scholomance Necromancer (2.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16704:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_STRAT_UD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_UD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baroness Anastari (12.5%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16702:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Thuzadin Necromancer (0.9%)\n"
				  .."Thuzadin Shadowcaster (0.8%)\n"
				  .."Crimson Sorcerer (2.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16703:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Quartermaster Zigris (0.5%)\n"
				  .."Blackhand Dreadweaver (3.3%)\n"
				  .."Firebrand Darkweaver (1.0%)\n"
				  .."Smolderthorn Seer (1.6%)\n"
				  .."Scarshield Warlock (1.2%)\n"
				  .."Bloodaxe Summoner (1.0%)\n";
				  classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16701:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Jandice Barov (11.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	-- Warlock Set 2
	------------------------------------
	setIndex = 2;
	setName = "Deathmist Raiment";
	setTabName = "Deathmist";
	setInfo = "Dungeon 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When struck in combat has a chance of causing the attacker to flee in terror for 2 seconds. \n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."528\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."157\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."138\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."420\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22074:0:0:0";
	partInfo	= Unknown
	partStats	= Unknown
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22075:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22072:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22077:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22076:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22070:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22071:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22073:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	

	------------------------------------
	--  Warlock Set 3
	------------------------------------
	setIndex = 3;
	setName = "Felheart Raiment";
	setTabName = "Felheart";
	setInfo = "Tier 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Health or Mana gained from Drain Life and Drain Mana increased by 15%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your pet gains 15 stamina and 100 spell resistance against all schools of magic.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Mana cost of Shadow spells reduced by 15%.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."584\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."180\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."126\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."85\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."34\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."24\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."HP Regen: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."14\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."450\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16808:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Garr (7.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16809:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Golemagg the Incinerator (12.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16810:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Magmadar (15.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16805:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lucifron (7.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16803:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Shazzrah (10.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16806:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Molten Destroyer (0.4%)\n"
				  .."Flameguard (0.1%)\n"
				  .."Molten Giant (0.1%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.1%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Lava Surger (0.3%)\n"
				  .."Ancient Core Hound (0.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16804:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Molten Destroyer (0.1%)\n"
				  .."Flameguard (0.1%)\n"
				  .."Molten Giant (0.1%)\n"
				  .."Lava Annihilator (0.2%)\n"
				  .."Firelord (0.1%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Lava Surger (0.3%)\n"
				  .."Ancient Core Hound (0.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16807:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Geddon (15.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	-- Warlock Set 4
	------------------------------------
	setIndex = 4;
	setName = "Nemesis Raiment";
	setTabName = "Nemesis";
	setInfo = "Tier 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your pet gains 20 stamina and 130 spell resistance against all schools of magic.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the threat generated by your Destruction spells by 20%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."666\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."171\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."112\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."42\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."40\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Nature: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Frost: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Arcane: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."450\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16929:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_OL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_OL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Onyxia's Lair (14.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16931:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Nefarian (10.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16930:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ragnaros (15.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16928:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Firemaw (7.7%)\n"
				  .."Ebonroc (5.7%)\n"
				  .."Flamegor (6.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16927:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Broodlord Lashlayer (16.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16933:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Vaelastrasz the Corrupt (25.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16934:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Razorgore the Untamed (12.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16932:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Chromaggus (9.8%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	------------------------------------
	-- Warlock Set 5
	------------------------------------
	setIndex = 5;
	setName = "Plagueheart Raiment";
	setTabName = "Plagueheart";
	setInfo = "Tier 3 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your Shadow Bolts now have a chance to heal you for 270-330.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage caused by your Corruption by 12%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your spell critical hits generate 25% less threat. In addition, Corruption, Immolate, Curse of Agony, and Siphon Life generate 25% less threat.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces health cost of your Life Tap by 12%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."764\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."0\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."198\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."167\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."0\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."% To Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."% Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."7%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Damage: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."+272\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."NA"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22506:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Plagueheart Circlet";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Circlet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 15\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22504:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Plagueheart Robe";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Robe: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 25\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22505:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Plagueheart Leggings";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Leggings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22509:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - ".."Plagueheart Gloves";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Gloves: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22508:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Plagueheart Sandals";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Sandals: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22510:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Plagueheart Belt";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Belt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcane Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22511:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Plagueheart Bindings";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Bindings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcane Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 6\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[8]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22507:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Plagueheart Shoulderpads";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Shoulderpads: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	-- Warlock Set 6,7
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=6,7 do
		if (i == 6) then
			setName = "Lieutenant Commander's Dreadgear";
			setTabName = "Lt Commander";
			
			handsLink		= "item:23282:0:0:0";
			feetLink		= "item:23283:0:0:0";
			chestLink		= "item:23297:0:0:0";
			legsLink		= "item:23296:0:0:0";
			shoulderLink	= "item:23311:0:0:0";
			headLink		= "item:23310:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Alliance)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Champion's Dreadgear";
			setTabName = "Champion";

			handsLink		= "item:22865:0:0:0";
			feetLink		= "item:22855:0:0:0";
			chestLink		= "item:22884:0:0:0";
			legsLink		= "item:22881:0:0:0";
			shoulderLink	= "item:23256:0:0:0";
			headLink		= "item:23255:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Horde)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end
		
		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the casting time of your Immolate spell by 0.2  sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
				  			  
				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."458\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."110\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."81\n"..SW_LINK_COLOR_CLOSE;
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
	end

	------------------------------------
	--  Warlock Set 8,9
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=8,9 do
		if (i == 8) then
			setName = "Field Marshal's Threads";
			setTabName = "Field Marshal";
			
			handsLink		= "item:17584:0:0:0";
			feetLink		= "item:17583:0:0:0";
			chestLink		= "item:17581:0:0:0";
			legsLink		= "item:17579:0:0:0";
			shoulderLink	= "item:17580:0:0:0";
			headLink		= "item:17578:0:0:0";
			
			setInfo = "PvP Tier 2 Set - (Alliance)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Warlord's Threads";
			setTabName = "Warlord";

			handsLink		= "item:17588:0:0:0";
			feetLink		= "item:17586:0:0:0";
			chestLink		= "item:17592:0:0:0";
			legsLink		= "item:17593:0:0:0";
			shoulderLink	= "item:17590:0:0:0";
			headLink		= "item:17591:0:0:0";
			
			setInfo = "PvP Tier 2 Set - (Horde)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end
		
		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the casting time of your Immolate spell by 0.2  sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE

				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."738\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."154\n"..SW_LINK_COLOR_CLOSE
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
		partInfo	= SW_TEXT_LEGS.." - "..SW_TEXT_CHEST.." - "..SW_TEXT_RANK_NAMES[SW_RANK_12_INDEX];
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
	end
	
	------------------------------------
	--  Set 10
	------------------------------------
	setIndex = 10;
	setName = "Demoniac's Threads";
	setTabName = "Demoniac";
	setInfo = "Zul'Gurub";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 12.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the damage of Corruption by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Decreases the cooldown of Death Coil by 15%.\n\n"..SW_LINK_COLOR_CLOSE
					  			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."214\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."79\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."23\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."180\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19605:0:0:0";
	partLink2	= "item:19604:0:0:0";
	partLink3	= "item:19603:0:0:0";
	partLink4	= "item:19602:0:0:0";
	partInfo	= SW_TEXT_NECK.." - ".."Reputation with Zandalar Tribe.";
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN.."Exalted with the Zandalar Tribe\n\nA new trinket will be awarded for each rank of reputation with the Zandalar Tribe.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_OTHER.."\n\n";
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_NECK]	= SetWrangler_MakePartData(partLink, partStats, partInfo, nil, partLink2, partLink3, partLink4);

	partLink	= "item:19957:0:0:0";
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

	partLink	= "item:20033:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Paragons of Power: The Demoniac's Robes";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Skullsplitter Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bloodscalp Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Kossack: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19849:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Paragons of Power: The Demoniac's Mantle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Witherbark Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Hakkari Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Sash: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Orange Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19848:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Paragons of Power: The Demoniac's Wraps";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vilebranch Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gurubashi Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Stanchion: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Red Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Set 11
	------------------------------------
	setIndex = 11;
	setName = "The Highlander's Intent";
	setTabName = "Intent (A)";
	setInfo = "Battleground Set - (Alliance)";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +5 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike with spells by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."496\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."41\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."31\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."130\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:20061:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Exalted with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20054:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Revered with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20047:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Honored with The League of Arathor\nAlliance - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	--  Set 12
	------------------------------------
	setIndex = 12;
	setName = "The Defiler's Intent";
	setTabName = "Intent (H)";
	setInfo = "Battleground Set - (Horde)";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +5 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike with spells by 1%.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."496\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."41\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."31\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."130\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:20176:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Honored with The Defilers\nHorde - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20159:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Revered with The Defilers\nHorde - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20163:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Exalted with The Defilers\nHorde - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	-- Warlock AQ20 Set 13
	------------------------------------
	setIndex = 13;
	setName = "Implements of Unspoken Names";
	setTabName = "Unspoken Names";
	setInfo = "AQ20 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5% Increase damage from your Summoned Pets Melee attacks and Damage spells.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."52\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."16\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."29\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21416:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Kris of Unspoken Names ";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Ornate Hilt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Onyx Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Exalted\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21417:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - ".."Ring of Unspoken Names";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Ceremonial Ring: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Jasper Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21418:0:0:0";
	partInfo	= SW_TEXT_BACK.." - ".."Shroud of Unspoken Names";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Regal Drape: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Amber Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Revered\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Warlock AQ20 Set
	------------------------------------
	
	
	------------------------------------
	-- Warlock AQ Set
	------------------------------------
	setIndex = 14;
	setName = "Doomcaller's Attire";
	setTabName = "Doomcaller";
	setInfo = "AQ40 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5% increased damage on your Immolate spell.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the mana cost of Shadow Bolt by 15%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."511\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."118\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."92\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."29\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."345\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21337:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Doomcaller's Circlet";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vek'nilash's Circlet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Death: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21334:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Doomcaller's Robes";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Husk of the Old God: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Night: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21336:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Doomcaller's Trousers";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Skin of the Great Sandworm: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Rebirth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21338:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Doomcaller's Footwraps";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Dominance: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Night: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21335:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Doomcaller's Mantle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Dominance: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Sage: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]  = SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Warlock AQ Set
	------------------------------------
	
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end