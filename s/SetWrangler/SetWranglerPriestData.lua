-- Priest Data

function SetWrangler_MakePriestData()
	local classData = {};
	local setName, partName, partLink, partStats, partInfo;
	local setIndex;
	
	classData.sName							= SW_TEXT_CLASSNAMES[SW_CLASS_PRIEST];
	classData.aSetData						= {};

	------------------------------------
	--  Set Priest Set 1
	------------------------------------
	setIndex = 1;
	setName = "Vestments of the Devout";
	setTabName = "Devout";
	setInfo = "Dungeon 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage done to Undead by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When struck in combat has a chance of shielding the wearer in a proctective shiled which will absorb 350 damage.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."491\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."71\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."134\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."115\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."375\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16693:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_SCHOLO;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_SCHOLO.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Darkmaster Gandling (7.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16690:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."General Drakkisath (6.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16694:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_STRAT_UD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_UD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Baron Rivendare (4.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16692:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_STRAT_LIVE;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_LIVE.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Archivist Galford (13.8%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16691:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_STRAT_UD;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT_UD.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Maleki the Pallid (8.9%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16696:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_BRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Blackhand Summoner (3.6%)\n"
				  .."Smolderthorn Shadow Priest (1.8%)\n"
				  .."Firebrand Darkweaver (1.0%)\n"
				  .."Scarshield Spellbinder (0.7%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16697:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_STRAT;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_STRAT.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Thuzadin Necromancer (0.7%)\n"
				  .."Thuzadin Shadowcaster (%0.7)\n"
				  .."Crimson Priest (1.6%)\n";
				  classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16695:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_UBRS;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_UBRS.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Solakar Flamewreath (13.2%)";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

        ------------------------------------
	-- Priest Set 2
	------------------------------------
	setIndex = 2;
	setName = "Vestments of the Virtuous";
	setTabName = "Virtuous";
	setInfo = "Dungeon 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +8 All Resistances.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When struck in combat has a chance of shielding the wearer in a protective shield which will absorb 350 damage.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +200 Armor.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."428\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."108\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."115\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."96\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."420\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22080:0:0:0";
	partInfo	= Unknown
	partStats	= Unknown
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22083:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22085:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22081:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22084:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22078:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22079:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22082:0:0:0";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	--  Priest Set 3
	------------------------------------
	setIndex = 3;
	setName = "Vestments of Prophecy";
	setTabName = "Prophecy";
	setInfo = "Tier 1 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." -0.1 sec to the casting time of your Flash Heal spell.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Improves your chance to get a critical strike with Holy spells by 2%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases your chance of a critical hit with Prayer of Healing by 25%.\n\n"..SW_LINK_COLOR_CLOSE

			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."584\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."113\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."170\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."117\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."34\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."24\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."450\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16813:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Garr (5.5%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16815:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Golemagg the Incinerator (11.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16814:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Magmadar (14.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16812:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Gehennas (11.5%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16811:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Shazzrah (11.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16817:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Flameguard (0.1%)\n"
				  .."Molten Giant (0.1%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.1%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.4%)\n"
				  .."Ancient Core Hound (0.4%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16819:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Flamewaker Priest (0.5%)\n"
				  .."Flameguard (0.1%)\n"
				  .."Molten Giant (0.1%)\n"
				  .."Lava Annihilator (0.1%)\n"
				  .."Firelord (0.1%)\n"
				  .."Lava Elemental (0.1%)\n"
				  .."Firewalker (0.1%)\n"
				  .."Lava Reaver (0.1%)\n"
				  .."Ancient Core Hound (0.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16816:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Sulfuron Harbinger (12.5%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	
	------------------------------------
	-- Priest Set 4
	------------------------------------
	setIndex = 4;
	setName = "Vestments of Transcendence";
	setTabName = "Transcendence";
	setInfo = "Tier 2 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Allows 15% of your Mana regeneration to continue while casting.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." When struck in melee there is a 50% chance you will Fade for 4 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Your Greater Heals now have a heal over time component equivalent to a rank 5 Renew.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."666\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."114\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."176\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."127\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Fire: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."40\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Nature: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Frost: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Shadow: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."30\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Arcane: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."10\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."450\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:16921:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - "..SW_AREA_OL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_OL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Onyxia (12.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HEAD]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16923:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Nefarian (12.0%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16922:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - "..SW_AREA_MC;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_MC.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Ragnaros (13.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_LEGS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16920:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Firemaw (6.6%)\n"
				  .."Ebonroc (10.3%)\n"
				  .."Flamegor (5.6%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_HANDS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16919:0:0:0";
	partInfo	= SW_TEXT_FEET.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Broodlord Lashlayer (15.3%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_FEET]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16925:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Vaelastrasz the Corrupt (17.1%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16926:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Razorgore the Untamed (26.5%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_WRISTS]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:16924:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - "..SW_AREA_BWL;
	partStats	= SW_TEXT_INST_HEADER.."\n"
				  ..SW_WHITE_OPEN..SW_AREA_BWL.."\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_DROP_HEADER.."\n"
				  ..SW_WHITE_OPEN
				  .."Chromaggus (18.2%)\n";
	classData.aSetData[setIndex].aPartData[SW_PART_SHOULD]  = SetWrangler_MakePartData(partLink, partStats, partInfo);

	------------------------------------
	-- Priest Set 5
	------------------------------------
	setIndex = 5;
	setName = "Vestments of Faith";
	setTabName = "Faith";
	setInfo = "Tier 3 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the mana cost of your Renew spell by 12%.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." On Greater Heal critical hits, your target will gain Armor of Faith, absorbing up to 500 damage.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the threat from your healing spells.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."8:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Each spell you cast can trigger an Epiphany, increasing your mana regeneration by 24 for 30 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."764\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Agility: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."0\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."154\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."174\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."154\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."+Healing: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."+428\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Regen: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."23 mana/5 sec\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."NA"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:22514:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Circlet of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Circlet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 15\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22512:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Robe of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Robe: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 25\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22513:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Leggings of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Leggings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22517:0:0:0";
	partInfo	= SW_TEXT_HANDS.." - ".."Gloves of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Gloves: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 4\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22516:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Sandals of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Sandals: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 3\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[6]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22518:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Belt of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Belt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcane Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 8\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[7]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22519:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Bindings of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Bindings: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Arcane Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Nexus Crystal: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 6\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[8]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:22515:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Shoulderpads of Faith";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Desecrated Shoulderpads: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Mooncloth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cured Rugged Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Wartorn Cloth Scrap: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 12\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	------------------------------------
	-- Priest  Set 6,7
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=6,7 do
		if (i == 6) then
			setName = "Lieutenant Commander's Investiture";
			setTabName = "Lt Commander";
			
			handsLink		= "item:23288:0:0:0";
			feetLink		= "item:23289:0:0:0";
			chestLink		= "item:23303:0:0:0";
			legsLink		= "item:23302:0:0:0";
			shoulderLink	= "item:23317:0:0:0";
			headLink		= "item:23316:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Alliance)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Champion's Investiture";
			setTabName = "Champion";

			handsLink		= "item:22869:0:0:0";
			feetLink		= "item:22859:0:0:0";
			chestLink		= "item:22885:0:0:0";
			legsLink		= "item:22882:0:0:0";
			shoulderLink	= "item:23262:0:0:0";
			headLink		= "item:23261:0:0:0";
			
			setInfo = "PvP Tier 1 Set - (Horde)";
			
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end
		
		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."4:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the duration of your Psychic Scream spell by 1 sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
				  			  
				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."708\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."101\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."80\n"..SW_LINK_COLOR_CLOSE;
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
	--  Priest Set 8,9
	------------------------------------
	local setName, setTabName;
	local handsLink, feetLink, chestLink, legsLink, shoulderLink, headLink;

	for i=8,9 do
		if (i == 8) then
			setName = "Field Marshal's Raiment";
			setTabName = "Field Marshal";
			
			handsLink		= "item:17608:0:0:0";
			feetLink		= "item:17607:0:0:0";
			chestLink		= "item:17605:0:0:0";
			legsLink		= "item:17603:0:0:0";
			shoulderLink	= "item:17604:0:0:0";
			headLink		= "item:17602:0:0:0";
			setInfo = "PvP Tier 2 Set - (Alliance)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_A;
		else
			setName = "Warlord's Raiment";
			setTabName = "Warlord";

			handsLink		= "item:17620:0:0:0";
			feetLink		= "item:17618:0:0:0";
			chestLink		= "item:17624:0:0:0";
			legsLink		= "item:17625:0:0:0";
			shoulderLink	= "item:17622:0:0:0";
			headLink		= "item:17623:0:0:0";
			
			setInfo = "PvP Tier 2 Set - (Horde)";
					
			SW_TEXT_RANK_NAMES = SW_TEXT_RANK_NAMES_H;
		end
		
		setIndex = i;
		setStats= SW_TEXT_BONUS_HEADER.."\n\n"
				  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." +20 Stamina.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the duration of your Psychic Scream spell by 1 sec.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."6:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases damage and healing done by magical spells and effects by up to 23.\n\n"..SW_LINK_COLOR_CLOSE
				  
				  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."898\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."154\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."128\n"..SW_LINK_COLOR_CLOSE;
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
	setName = "Confessor's Raiment";
	setTabName = "Confessor";
	setInfo = "Zul'Gurub";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."2:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases healing done by spells and effects by up to 22.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increase the range of your Smite and Holy Fire spells by 5 yds.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Reduces the casting time of your Mind Control spell by 0.5 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."174\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."38\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."62\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."13\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."120\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:19594:0:0:0";
	partLink2	= "item:19593:0:0:0";
	partLink3	= "item:19592:0:0:0";
	partLink4	= "item:19591:0:0:0";
	partInfo	= SW_TEXT_NECK.." - ".."Reputation with Zandalar Tribe.";
	partStats	= SW_TEXT_REQ.."\n\n"
				  ..SW_WHITE_OPEN.."Exalted with the Zandalar Tribe\n\nA new trinket will be awarded for each rank of reputation with the Zandalar Tribe.\n\n"..SW_LINK_COLOR_CLOSE
				  ..SW_TEXT_OTHER.."\n\n";
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_NECK]	= SetWrangler_MakePartData(partLink, partStats, partInfo, nil, partLink2, partLink3, partLink4);

	partLink	= "item:19958:0:0:0";
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

	partLink	= "item:19841:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Paragons of Power: The Confessor's Mantle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Razzashi Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Witherbark Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Aegis: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_CHEST]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19842:0:0:0";
	partInfo	= SW_TEXT_WAIST.." - ".."Paragons of Power: The Confessor's Bindings";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Hakkari Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Zulian Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Sash: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Orange Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
	classData.aSetData[setIndex].aPartData[SW_PART_ZG_BELT]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:19843:0:0:0";
	partInfo	= SW_TEXT_WRIST.." - ".."Paragons of Power: The Confessor's Wraps";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Sandfury Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bloodscalp Coins: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Primal Hakkari Stanchion: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Yellow Bijous: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
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
	-- Priest AQ20 Set 13
	------------------------------------
	setIndex = 13;
	setName = "Finery of Infinite Wisdom";
	setTabName = "Infinite Wisdom";
	setInfo = "AQ20 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the damage of your Shadow Word: Pain spell by 5%.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."52\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."35\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."11\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."32\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21410:0:0:0";
	partInfo	= SW_TEXT_HAND.." - ".."Gavel of Infinite Wisdom ";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Ornate Hilt: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Lambent Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Exalted\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21411:0:0:0";
	partInfo	= SW_TEXT_FINGER.." - ".."Ring of Infinite Wisdom";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Ceremonial Ring: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Obsidian Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	
	partLink	= "item:21412:0:0:0";
	partInfo	= SW_TEXT_BACK.." - ".."Shroud of Infinite Wisdom";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Marital Drape: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Jasper Idol: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Cenarion Circle Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Revered\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Priest AQ20 Set
	------------------------------------
	
	------------------------------------
	-- Priest AQ Set
	------------------------------------
	setIndex = 14;
	setName = "Garments of the Oracle";
	setTabName = "Oracle";
	setInfo = "AQ40 Set";
	setStats= SW_TEXT_BONUS_HEADER.."\n\n"
			  ..SW_GOLD_OPEN.."3:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 20% chance that your heals on others will also heal you 10% of the amount healed.\n\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."5:"..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Increases the duration of your Renew spell by 3 sec.\n\n"..SW_LINK_COLOR_CLOSE
			  
			  ..SW_GOLD_OPEN.."Armor: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."721\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Stamina: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."109\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Intellect: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."109\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Spirit: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."65\n"..SW_LINK_COLOR_CLOSE
			  ..SW_GOLD_OPEN.."Durability: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.."345\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex]							= SetWrangler_MakeSetData(setName,setTabName,setInfo,setStats);

	partLink	= "item:21348:0:0:0";
	partInfo	= SW_TEXT_HEAD.." - ".."Tiara of the Oracle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Vek'nilash's Circlet: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Sage: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[1]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21351:0:0:0";
	partInfo	= SW_TEXT_CHEST.." - ".."Vestments of the Oracle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Husk of the Old God: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Death: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Stone Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Crystal Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Honored\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[2]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21352:0:0:0";
	partInfo	= SW_TEXT_LEGS.." - ".."Trousers of the Oracle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Ouro's Intact Hide: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Life: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Clay Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Friendly\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[3]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21349:0:0:0";
	partInfo	= SW_TEXT_FEET.." - ".."Footwraps of the Oracle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Command: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Death: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Bronze Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Gold Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[4]	= SetWrangler_MakePartData(partLink, partStats, partInfo);

	partLink	= "item:21350:0:0:0";
	partInfo	= SW_TEXT_SHOULDER.." - ".."Mantle of the Oracle";  -- Quest
	partStats	= SW_TEXT_REQ_ITEMS.."\n\n"
				  ..SW_GOLD_OPEN..SW_LINK_COLOR_CLOSE.."Quest: "..SW_WHITE_OPEN..partInfo.."\n\n"
				  ..SW_GOLD_OPEN.."Qiraji Bindings of Command: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 1\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Idol of Rebirth: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 2\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Silver Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Ivory Scarab: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." 5\n"..SW_LINK_COLOR_CLOSE
				  ..SW_GOLD_OPEN.."Brood of Nozdormu Rep: "..SW_LINK_COLOR_CLOSE..SW_WHITE_OPEN.." Neutral\n"..SW_LINK_COLOR_CLOSE;
	classData.aSetData[setIndex].aPartData[5]  = SetWrangler_MakePartData(partLink, partStats, partInfo);
	------------------------------------
	-- END Priest AQ Set
	------------------------------------
	
	---------
	classData.numTabSets = math.ceil(table.getn(classData.aSetData) / SW_MAX_TABS);
	return classData;
end