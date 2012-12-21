-- Warrior Data

function SetWrangler_MakeWarriorData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_WARRIOR];
	classData.aSetData						= {};

	------------------------------------
	--  Warrior Set 1
	------------------------------------
	setIndex = 1;
	setName = "Battlegear of Valor";
	setTabName = "Valor";
	setInfo = "Dungeon 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +40 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Chance on melee attack to heal you for 88 to 132.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3622\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."110\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."56\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."131\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."35\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."595\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16731:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Darkmaster Gandling (6.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16730:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."General Drakkisath (5.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16732:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_STRAT_UD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_UD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Rivendare (5.8%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16737:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_STRAT_LIVE;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_LIVE.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ramstein the Gorger (11.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16734:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Kirtonos the Herald (10.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16736:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Highlord Omokk (7.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16735:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Quartermaster Zigris (0.8%)\n"
				  .."Blackhand Iron Guard (3.2%)\n"
				  .."Scarshield Legionnaire (1.0%)\n"
				  .."Firebrand Grunt (0.6%)\n"
				  .."Smolderthorn Axe Thrower (1.8%)\n"
				  .."Bloodaxe Warmonger (1.0%)\n";
				  classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16733:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_LBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_LBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Warchief Rend Blackhand (11.8%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	-- Warrior Set 2
	------------------------------------
	setIndex = 2;
	setName = "Battlegear of Heroism";
	setTabName = "Heroism";
	setInfo = "Dungeon 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Chance on melee attack to heal you for 88 to 132.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +40 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3887\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."138\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."50\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."150\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."15\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."To Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."665\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21999:0:0:0";
	partInfo	= Unknown
	partStats	= Unknown
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21997:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22000:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21998:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21995:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21994:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21996:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22001:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	

	------------------------------------
	--  Warrior Set 3
	------------------------------------
	setIndex = 3;
	setName = "Battlegear of Might";
	setTabName = "Might";
	setInfo = "Tier 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the block value of your shield by 30.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Gives you a 20% chance to generate an additional Rage point whenever damage is dealt to you.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the threat generated by Sunder Armor by 15%.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4306\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."143\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."189\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."34\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."24\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Block: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."5\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."41\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Dodge: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Parry: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."To Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."725\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16866:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Garr (8.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16865:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Golemagg the Incinerator (10.8%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16867:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Magmadar (13.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16863:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lucifron (11.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16862:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gehennas (10.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16864:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Molten Destroyer (0.3%)\n"
				  .."Flameguard (0.1%)\n"
				  .."Molten Giant (0.2%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.1%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Lava Surger (0.1%)\n"
				  .."Ancient Core Hound (0.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16861:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Molten Destroyer (0.1%)\n"
				  .."Flameguard (0.1%)\n"
				  .."Molten Giant (0.2%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.4%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Lava Surger (0.1%)\n"
				  .."Ancient Core Hound (0.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16868:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Sulfuron Harbinger (14.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	-- Warrior Set 4
	------------------------------------
	setIndex = 4;
	setName = "Battlegear of Wrath";
	setTabName = "Wrath";
	setInfo = "Tier 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the attack power granted by Battle Shout by 30.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20% chance after using an offensive ability requiring rage that your next offensive ability requires 5 less rage to use.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4% chance to parry the next attack after a block.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4925\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."127\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."231\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."40\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Nature: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Frost: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Arcane: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Block: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Block Amt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."41\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."61\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Dodge: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Parry: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."725"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16963:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_OL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_OL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Onyxia's Lair (11.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16966:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Nefarian (19.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16962:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ragnaros (16.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16964:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Firemaw (6.6%)\n"
				  .."Ebonroc (3.4%)\n"
				  .."Flamegor (3.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16965:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Broodlord Lashlayer (22.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16960:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Vaelastrasz the Corrupt (14.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16959:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Razorgore the Untamed (13.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16961:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Chromaggus (14.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	-- Warrior Set 5
	------------------------------------
	setIndex = 5;
	setName = "Dreadnaught's Battlegear";
	setTabName = "Dreadnaught";
	setInfo = "Tier 3 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the damage done by your Revenge ability by 75.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to hit with Taunt and Challenging Shout by 5%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to hit with Sunder Armor, Heroic Strike, Revenge, and Shield Slam by 5%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When your health drops below 20%, for the next 5 seconds healing spells cast on you help you to Cheat Death, increasing healing done by up to 160.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."5672\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."0\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."269\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."147\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Dodge: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."81\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Block Value: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."92\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Shield Block: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."6%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."NA"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22418:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Dreadnaught Helmet";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Helmet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 15\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22416:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Dreadnaught Breastplate";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Breastplate: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 25\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22417:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Dreadnaught Legplates";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Legplates: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22421:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - ".."Dreadnaught Gauntlets";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Gauntlets: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22420:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Dreadnaught Sabatons";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Sabatons: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22422:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Dreadnaught Waistguard";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Waistguard: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22423:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Dreadnaught Bracers";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Bracers: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 6\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[8]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22419:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Dreadnuaght Spaulders";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Pauldrons: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcanite Bar: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Plate Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	-- Warrior  Set 6,7
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=6,7 do
		if (i == 6) then
			setName = "Lieutenant Commander's Battlearmor";
			setTabName = "Lt Commander";
			
			handsLink		= "item:23286:0:0:0";
			feetLink		= "item:23287:0:0:0";
			chestLink		= "item:23300:0:0:0";
			legsLink		= "item:23301:0:0:0";
			shoulderLink	= "item:23315:0:0:0";
			headLink		= "item:23314:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Alliance)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Champion's Battlearmor";
			setTabName = "Champion";

			handsLink		= "item:22868:0:0:0";
			feetLink		= "item:22858:0:0:0";
			chestLink		= "item:22872:0:0:0";
			legsLink		= "item:22873:0:0:0";
			shoulderLink	= "item:23243:0:0:0";
			headLink		= "item:23244:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Horde)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end

		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +40 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the cooldown of your Intercept ability by 5 sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
				  			  
				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3375\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."98\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."9\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."122\n"..SW_LINK_COLOR_CLOSE;
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
	--  Warrior Set 8,9
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=8,9 do
		if (i == 8) then
			setName = "Field Marshal's Battlegear";
			setTabName = "Field Marshal";
			
			handsLink		= "item:16484:0:0:0";
			feetLink		= "item:16483:0:0:0";
			chestLink		= "item:16477:0:0:0";
			legsLink		= "item:16479:0:0:0";
			shoulderLink	= "item:16480:0:0:0";
			headLink		= "item:16478:0:0:0";
			
			setInfo = "PvP Tier 2 Set - (Alliance)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Warlord's Battlegear";
			setTabName = "Warlord";

			handsLink		= "item:16548:0:0:0";
			feetLink		= "item:16545:0:0:0";
			chestLink		= "item:16541:0:0:0";
			legsLink		= "item:16543:0:0:0";
			shoulderLink	= "item:16544:0:0:0";
			headLink		= "item:16542:0:0:0";
			setInfo = "PvP Tier 2 Set - (Horde)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
			
		end
		
		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the cooldown of your Intercept ability by 5 sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +40 Attack Power.\n\n"..SW_LINK_COLOR_CLOSE

				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4087\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."120\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."42\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."165\n"..SW_LINK_COLOR_CLOSE;
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
	end

	------------------------------------
	--  Set 10
	------------------------------------
	setIndex = 10;
	setName = "Vindicator's Battlegear";
	setTabName = "Vindicator";
	setInfo = "Zul'Gurub";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your chance to block attacks with a shield by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Decreases the cooldown of Intimidating Shout by 15 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Decrease the rage cost of Whirlwind by 3.\n\n"..SW_LINK_COLOR_CLOSE
					  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1534\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."61\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."34\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."58\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."%Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."1\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Block: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."255\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19577:0:0:0";
	partLink2	= "item:19576:0:0:0";
	partLink3	= "item:19575:0:0:0";
	partLink4	= "item:19574:0:0:0";
	partInfo	= SW_TEXT_NECK.." - ".."Reputation with Zandalar Tribe.";
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN.."Exalted with the Zandalar Tribe\n\nA new trinket will be awarded for each rank of reputation with the Zandalar Tribe.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_OTHER.."\n\n";
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_NECK]	= SetWrangler_MakePartData(partLink, partStats, partInfo, nil, partLink2, partLink3, partLink4);

	partLink	= "item:19951:0:0:0";
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

	partLink	= "item:19822:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Paragons of Power: The Vindicator's Breastplate";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vilebranch Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bloodscalp Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Kossack: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19823:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Paragons of Power: The Vindicator's Belt";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Sandfury Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Skullsplitter Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Girdle: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Green Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19824:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Paragons of Power: The Vindicator's Armguards";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Gurubashi Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Witherbark Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Armsplints: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Yellow Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	--  Set 11
	------------------------------------
	setIndex = 11;
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
	--  Set 12
	------------------------------------
	setIndex = 12;
	setName = "The Defiler's Resolution";
	setTabName = "Resolution (H)";
	setInfo = "Battleground Set - (Horde)";
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

	partLink	= "item:20212:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Honored with The Defilers\nHorde - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20208:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Revered with The Defilers\nHorde - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:20204:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_AB;
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN
				  .."Exalted with The Defilers\nHorde - ("..SW_AREA_AB..")\n";
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	------------------------------------
	-- Warrior AQ20 Set 13
	------------------------------------
	setIndex = 13;
	setName = "Battlegear of Unyielding Strength";
	setTabName = "Unyielding Strength";
	setInfo = "AQ20 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." -2 Rage cost to Intercept.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."15\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."52\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."32\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."41\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21392:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Sickle of Unyielding Strength ";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Spiked Hilt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Alabaster Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Exalted\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21393:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - ".."Signet of Unyielding Strength";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Magisterial Ring: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Lambent Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21394:0:0:0";
	partInfo	= SW_TEXT_BACK.." - ".."Drape of Unyielding Strength";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Marital Drape: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Onyx Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Revered\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Warrior AQ20 Set
	------------------------------------
	
	
	------------------------------------
	-- Warrior AQ Set
	------------------------------------
	setIndex = 14;
	setName = "Conqueror's Battlegear";
	setTabName = "Conqueror";
	setInfo = "AQ40 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Decreases the rage cost of all Warrior shouts by 35%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increase the Slow effect and damage of Thunder Clap by 50%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."3783\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Strength: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."137\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."96\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."140\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Defense: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."26\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."To Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."2\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."560\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21329:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Conqueror's Crown";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vek'nilash's Circlet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Sun: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21331:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Conqueror's Breastplate";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Carapace of the Old God: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of War: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21332:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Conqueror's Legguards";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Ouro's Intact Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Death: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21333:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Conqueror's Greaves";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Command: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of War: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21330:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Conqueror's Spaulders";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Command: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Night: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]  = SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Warrior AQ Set
	------------------------------------
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end