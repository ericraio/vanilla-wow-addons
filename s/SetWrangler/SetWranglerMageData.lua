-- Mage Data

function SetWrangler_MakeMageData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_MAGE];
	classData.aSetData						= {};

	------------------------------------
	-- Mage Set 1
	------------------------------------
	setIndex = 1;
	setName = "Magister's Regalia";
	setTabName = "Magister";
	setInfo = "Dungeon 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damge and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When struck in combat has a chance of freezing the attacker in place for 3 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."491\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."66\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."167\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."79\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."375\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16686:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Darkmaster Gandling (6.2%)";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16688:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."General Drakkisath (5.5%)";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16687:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_STRAT_UD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_UD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Rivendare (6.5%)";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16684:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Scholomance Adept (2.3%)\n"
				  .."Doctor Theolen Krastinov (2.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16682:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_STRAT_LIVE;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_LIVE.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Postmaster Malown (9.5%)";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16685:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Thuzadin Shadowcaster (0.8%)\n"
				  .."Thuzadin Necromancer (0.7%)\n"
				  .."Crimson Battle Mage (2.5%)\n"
				  .."Smolderthorn Mystic (0.9%)\n"
				  .."Firebrand Legionnaire (1.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16683:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Rage Talon Fire Tongue (2.9%)\n"
				  .."Scarshield Spellbinder (0.7%)\n"
				  .."Firebrand Invoker (0.6%)\n"
				  .."Bloodaxe Evoker (0.8%)\n"
				  .."Quartermaster Zigris (0.6%)\n";
				  classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16689:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ras Frostwhisper (10.9%)";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	
	------------------------------------
	-- Mage Set 2
	------------------------------------
	setIndex = 2;
	setName = "Sorcerer's Regalia";
	setTabName = "Sorcerer";
	setInfo = "Dungeon 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When struck in combat has a chance of freezing the attacker in place for 3 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."528\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."104\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."145\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."72\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."420\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22065:0:0:0";
	partInfo	= Unknown
	partStats	= Unknown
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22069:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22067:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22066:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22064:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22062:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22063:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22068:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	

	------------------------------------
	--  Mage Set 3
	------------------------------------
	setIndex = 3;
	setName = "Arcanist Regalia";
	setTabName = "Arcanist";
	setInfo = "Tier 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 18.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Decreases the magical resistances of your spell targets by 10.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Decreases the threat generated by your spells by 15%.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."584\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."112\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."195\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."82\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."34\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."27\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."450\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16795:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Garr (6.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16798:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Golemagg the Incinerator (13.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16796:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Magmadar (13.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16801:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Shazzrah (11.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16800:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Lucifron (7.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16802:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Molten Giant (0.2%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.4%)\n"
				  .."Lava Elemental (0.2%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Ancient Core Hound (0.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16799:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Molten Giant (0.1%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.2%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.2%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Ancient Core Hound (0.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16797:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Geddon (16.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	--  Mage Set 4
	------------------------------------
	setIndex = 4;
	setName = "Netherwind Regalia";
	setTabName = "Netherwind";
	setInfo = "Tier 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the threat generated by your Scorch,  Arcane Missiles, Fireball, and Frostbolt spells.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the radius of Arcane Explosion, Flamestrike, and Blizzard by 25%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 10% chance after casting Arcane Missiles, Fireball, or Frostbolt that your next spell with a casting time under 10 seconds cast instantly.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."666\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."116\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."167\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."79\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."40\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Nature: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Frost: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Arcane: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."450\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16914:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_OL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_OL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Onyxia (12.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16916:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Nefarian (23.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16915:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ragnaros (24.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16913:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ebonroc (8.0%)\n"
				  .."Flamegor (4.5%)\n"
				  .."Firemaw (4.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16912:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Broodlord Lashlayer (19.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16818:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Vaelastrasz the Corrupt (32.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16918:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Razorgore the Untamed (20.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16917:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Chromaggus (15.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	------------------------------------
	--  Mage Set 5
	------------------------------------
	setIndex = 5;
	setName = "Frostfire Regalia";
	setTabName = "Frostfire";
	setInfo = "Tier 3 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces cooldown on your Evocation by 1 minute.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Gives your Mage Armor a chance when struck by a harmful spell to increase resistance against that school of magic by 35 for 30 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your damage spells have a chance to cause your target to take up to 200 increased damage from subsequent spells.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your damage spells have a chance to displace you, causing the next spell cast to generate no threat.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."764\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."0\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."152\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."167\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."49\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."% To Hit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."% Critical: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."4%\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Damage: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."+283\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."NA"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22498:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Frostfire Circlet";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Circlet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 15\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22496:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Frostfire Robe";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Robe: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 25\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22497:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Frostfire Leggings";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Leggings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22501:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - ".."Frostfire Gloves";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Gloves: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22500:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Frostfire Sandals";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Sandals: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22502:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Frostfire Belt";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Belt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcane Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22503:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Frostfire Bindings";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Bindings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcane Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 6\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[8]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22499:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Frostfire Shoulderpads";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Shoulderpads: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);


	------------------------------------
	-- Mage  Set 6,7
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=6,7 do
		if (i == 6) then
			setName = "Lieutenant Commander's Arcanum";
			setTabName = "Lt Commander";
			
			handsLink		= "item:23290:0:0:0";
			feetLink		= "item:23291:0:0:0";
			chestLink		= "item:23305:0:0:0";
			legsLink		= "item:23304:0:0:0";
			shoulderLink	= "item:23319:0:0:0";
			headLink		= "item:23318:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Alliance)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Champion's Arcanum";
			setTabName = "Champion";

			handsLink		= "item:22870:0:0:0";
			feetLink		= "item:22860:0:0:0";
			chestLink		= "item:22886:0:0:0";
			legsLink		= "item:22883:0:0:0";
			shoulderLink	= "item:23264:0:0:0";
			headLink		= "item:23263:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Horde)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end
		
		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the cooldown of your Blink spell by 1.5 sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE

				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."778\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."96\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."83\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."20\n"..SW_LINK_COLOR_CLOSE;
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
	--  Mage Set 8,9
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=8,9 do
		if (i == 8) then
			setName = "Field Marshal's Regalia";
			setTabName = "Field Marshal";
			
			handsLink		= "item:16440:0:0:0";
			feetLink		= "item:16437:0:0:0";
			chestLink		= "item:16443:0:0:0";
			legsLink		= "item:16442:0:0:0";
			shoulderLink	= "item:16444:0:0:0";
			headLink		= "item:16441:0:0:0";
			
			setInfo = "PvP Tier 2 Set - (Alliance)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Warlord's Regalia";
			setTabName = "Warlord";

			handsLink		= "item:16540:0:0:0";
			feetLink		= "item:16539:0:0:0";
			chestLink		= "item:16535:0:0:0";
			legsLink		= "item:16534:0:0:0";
			shoulderLink	= "item:16536:0:0:0";
			headLink		= "item:16533:0:0:0";
			
			setInfo = "PvP Tier 2 Set - (Horde)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end
		
		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the cooldown of your Blink spell by 1.5 sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
				  	  			  
				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."858\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."148\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."95\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."32\n"..SW_LINK_COLOR_CLOSE;
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
	setName = "Illusionist's Attire";
	setTabName = "Illusionist";
	setInfo = "Zul'Gurub";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 12.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Decreases the mana cost of Arcane Intellect and Arcane Brilliance by 5%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the casting time of your Flamestrike spell by 0.5 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."214\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."52\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."69\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."8\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."180\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19601:0:0:0";
	partLink2	= "item:19600:0:0:0";
	partLink3	= "item:19599:0:0:0";
	partLink4	= "item:19598:0:0:0";
	partInfo	= SW_TEXT_NECK.." - ".."Reputation with Zandalar Tribe.";
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN.."Exalted with the Zandalar Tribe\n\nA new trinket will be awarded for each rank of reputation with the Zandalar Tribe.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_OTHER.."\n\n";
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_NECK]	= SetWrangler_MakePartData(partLink, partStats, partInfo, nil, partLink2, partLink3, partLink4);

	partLink	= "item:19959:0:0:0";
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

	partLink	= "item:20034:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Paragons of Power: The Illusionist's Robes";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Sandfury Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Zulian Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Kossack: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19845:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Paragons of Power: The Illusionist's Mantle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Gurubashi Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Razzashi Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Shawl: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Orange Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19846:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Paragons of Power: The Illusionist's Wraps";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Witherbark Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Vilebranch Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Bindings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Blue Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
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
	-- Mage AQ20 Set 13
	------------------------------------
	setIndex = 13;
	setName = "Trappings of Vaulted Secrets";
	setTabName = "Vaulted Secrets";
	setInfo = "AQ20 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 15% Increase to the total Damage absorbed by Mana Shield.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."52\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."25\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."6\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."31\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21413:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Blade of Vaulted Secrets ";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Ornate Hilt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Obsidian Idol Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Exalted\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21414:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - ".."Band of Vaulted Secrets";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Magisterial Ring: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Azure Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21415:0:0:0";
	partInfo	= SW_TEXT_BACK.." - ".."Drape of Vaulted Secrets";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Regal Drape: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Alabaster Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Revered\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Mage AQ20 Set
	------------------------------------
	
	
	------------------------------------
	-- Mage AQ Set
	------------------------------------
	setIndex = 14;
	setName = "Enigma Vestments";
	setTabName = "Enigma";
	setInfo = "AQ40 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your Blizzard spell has a 30% chance to be uninterruptible.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Grants +5% increased spell hit chance for 20 sec when one of your spells is resisted.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."511\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."95\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."100\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."37\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."345\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21347:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Enigma Circlet";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vek'nilash's Circlet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Night: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21343:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Enigma Robes";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Husk of the Old God: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of the Sun: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21346:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Enigma Leggings";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Ouro's Intact Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of the Sage: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21344:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Enigma Boots";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Dominance: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of the Sun: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21345:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Enigma Shoulderpads";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Dominance: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Death: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]  = SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Mage AQ Set
	------------------------------------
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end