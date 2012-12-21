local function dout(msg)
	if( DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,1.0,0,0);
	end
end

function SetWrangler_MakeLocalItemSet()
	----------------------------
	gLocalPartData["localdb:1"] = {};
	gLocalPartData["localdb:1"].tex			= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:1"].line		= {};
	gLocalPartData["localdb:1"].color		= {};
	
	gLocalPartData["localdb:1"].line[1]		= "Pristine Enchanted South Seas Kelp";
	gLocalPartData["localdb:1"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:1"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:1"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:1"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:1"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:1"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:1"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:1"].line[5]		= "+6 "..SW_TEXT_STRENGTH;
	gLocalPartData["localdb:1"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:1"].line[6]		= "+10 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:1"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:1"].line[7]		= "+10 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:1"].color[7]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:1"].line[8]		= "+9 "..SW_TEXT_SPIRIT;
	gLocalPartData["localdb:1"].color[8]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:1"].line[9]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_DRUID];
	gLocalPartData["localdb:1"].color[9]	= SW_RED;
	gLocalPartData["localdb:1"].line[10] 	= "Equip: Increases the critical hit chance of\n"
											  .."Wrath and Starfire by 2%.";
	gLocalPartData["localdb:1"].color[10]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:1"].line[11]	= "Haruspex's Garb";
	gLocalPartData["localdb:1"].color[11]	= SW_GOLD;
	
	
	----------------------------
	gLocalPartData["localdb:2"] = {};
	gLocalPartData["localdb:2"].tex			= "Interface/Icons/INV_Jewelry_Necklace_25";
	gLocalPartData["localdb:2"].line		= {};
	gLocalPartData["localdb:2"].color		= {};
	
	gLocalPartData["localdb:2"].line[1]		= "Enchanted South Seas Kelp";
	gLocalPartData["localdb:2"].color[1]	= SW_LINK_COLORS[3];
	gLocalPartData["localdb:2"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:2"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:2"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:2"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:2"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:2"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:2"].line[5]		= "+6 "..SW_TEXT_STRENGTH;
	gLocalPartData["localdb:2"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:2"].line[6]		= "+10 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:2"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:2"].line[7]		= "+10 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:2"].color[7]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:2"].line[8]		= "+9 "..SW_TEXT_SPIRIT;
	gLocalPartData["localdb:2"].color[8]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:2"].line[9]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_DRUID];
	gLocalPartData["localdb:2"].color[9]	= SW_RED;
	
	----------------------------
	gLocalPartData["localdb:3"] = {};
	gLocalPartData["localdb:3"].tex			= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:3"].line		= {};
	gLocalPartData["localdb:3"].color		= {};
	
	gLocalPartData["localdb:3"].line[1]		= "Maelstrom's Wrath";
	gLocalPartData["localdb:3"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:3"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:3"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:3"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:3"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:3"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:3"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:3"].line[5]		= "+15 "..SW_TEXT_AGILITY;
	gLocalPartData["localdb:3"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:3"].line[6]		= "+9 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:3"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:3"].line[7]		= "+6 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:3"].color[7]	= SW_LINK_COLORS[1];
		
	gLocalPartData["localdb:3"].line[8]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_HUNTER];
	gLocalPartData["localdb:3"].color[8]	= SW_RED;
	gLocalPartData["localdb:3"].line[9] 	= "Equip: Decreases the cooldown of\n"
											  .."Feign Death  by 2 sec.";
	gLocalPartData["localdb:3"].color[9]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:3"].line[10]	= "Predator's Armor";
	gLocalPartData["localdb:3"].color[10]	= SW_GOLD;
	
	----------------------------
	gLocalPartData["localdb:4"] = {};
	gLocalPartData["localdb:4"].tex			= "Interface/Icons/INV_Jewelry_Necklace_25";
	gLocalPartData["localdb:4"].line		= {};
	gLocalPartData["localdb:4"].color		= {};
	
	gLocalPartData["localdb:4"].line[1]		= "Maelstrom's Tendril";
	gLocalPartData["localdb:4"].color[1]	= SW_LINK_COLORS[3];
	gLocalPartData["localdb:4"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:4"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:4"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:4"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:4"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:4"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:4"].line[5]		= "+15 "..SW_TEXT_AGILITY;
	gLocalPartData["localdb:4"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:4"].line[6]		= "+9 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:4"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:4"].line[7]		= "+6 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:4"].color[7]	= SW_LINK_COLORS[1];
		
	gLocalPartData["localdb:4"].line[8]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_HUNTER];
	gLocalPartData["localdb:4"].color[8]	= SW_RED;
	
	----------------------------
	gLocalPartData["localdb:5"] = {};
	gLocalPartData["localdb:5"].tex			= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:5"].line		= {};
	gLocalPartData["localdb:5"].color		= {};
	
	gLocalPartData["localdb:5"].line[1]		= "Jewel of Kajaro";
	gLocalPartData["localdb:5"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:5"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:5"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:5"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:5"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:5"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:5"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:5"].line[5]		= "+8 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:5"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:5"].line[6]		= "+13 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:5"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:5"].line[7]		= "+8 "..SW_TEXT_SPIRIT;
	gLocalPartData["localdb:5"].color[7]	= SW_LINK_COLORS[1];
		
	gLocalPartData["localdb:5"].line[8]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_MAGE];
	gLocalPartData["localdb:5"].color[8]	= SW_RED;
	gLocalPartData["localdb:5"].line[9] 	= "Equip: Increases damage and healing\ndone"
											  .."by magical spells and effects by up\n"
											  .."to 9.";
	gLocalPartData["localdb:5"].color[9]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:5"].line[10] 	= "Equip: Reduces the cooldown of\n"
											  .."Counterspell by 2 sec.";
	gLocalPartData["localdb:5"].color[10]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:5"].line[11]	= "Illusionist's Attire";
	gLocalPartData["localdb:5"].color[11]	= SW_GOLD;
	
	
	----------------------------
	gLocalPartData["localdb:6"] = {};
	gLocalPartData["localdb:6"].tex			= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:6"].line		= {};
	gLocalPartData["localdb:6"].color		= {};
	
	gLocalPartData["localdb:6"].line[1]		= "Hero's Brand";
	gLocalPartData["localdb:6"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:6"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:6"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:6"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:6"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:6"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:6"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:6"].line[5]		= "+10 "..SW_TEXT_STRENGTH;
	gLocalPartData["localdb:6"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:6"].line[6]		= "+10 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:6"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:6"].line[7]		= "+6 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:6"].color[7]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:6"].line[8]		= "+9 "..SW_TEXT_SPIRIT;
	gLocalPartData["localdb:6"].color[8]	= SW_LINK_COLORS[1];
		
	gLocalPartData["localdb:6"].line[9]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_PALADIN];
	gLocalPartData["localdb:6"].color[9]	= SW_RED;
	gLocalPartData["localdb:6"].line[10] 	= "Equip: Increases the duration of\nHammer of Justice by 0.5 sec.";
	gLocalPartData["localdb:6"].color[10]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:6"].line[11]	= "Freethinker's Armor";
	gLocalPartData["localdb:6"].color[11]	= SW_GOLD;
	
	----------------------------
	gLocalPartData["localdb:7"] = {};
	gLocalPartData["localdb:7"].tex			= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:7"].line		= {};
	gLocalPartData["localdb:7"].color		= {};
	
	gLocalPartData["localdb:7"].line[1]		= "The All-Seeing Eye of Zuldazar";
	gLocalPartData["localdb:7"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:7"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:7"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:7"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:7"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:7"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:7"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:7"].line[5]		= "+8 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:7"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:7"].line[6]		= "+8 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:7"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:7"].line[7]		= "+13 "..SW_TEXT_SPIRIT;
	gLocalPartData["localdb:7"].color[7]	= SW_LINK_COLORS[1];
		
	gLocalPartData["localdb:7"].line[8]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_PRIEST];
	gLocalPartData["localdb:7"].color[8]	= SW_RED;
	gLocalPartData["localdb:7"].line[9] 	= "Equip: Increases healing done by spells\nand effects by up to 18.";
	gLocalPartData["localdb:7"].color[9]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:7"].line[10] 	= "Equip: Increases the amount of damage\nabsorbed by Power Word: Shield by 35.";
	gLocalPartData["localdb:7"].color[10]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:7"].line[11]	= "Confessor's Raiment";
	gLocalPartData["localdb:7"].color[11]	= SW_GOLD;
	
	----------------------------
	gLocalPartData["localdb:8"] = {};
	gLocalPartData["localdb:8"].tex			= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:8"].line		= {};
	gLocalPartData["localdb:8"].color		= {};
	
	gLocalPartData["localdb:8"].line[1]		= "Zandalarian Shadow Mastery Talisman";
	gLocalPartData["localdb:8"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:8"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:8"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:8"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:8"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:8"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:8"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:8"].line[5]		= "+6 "..SW_TEXT_STRENGTH;
	gLocalPartData["localdb:8"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:8"].line[6]		= "+15 "..SW_TEXT_AGILITY;
	gLocalPartData["localdb:8"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:8"].line[7]		= "+9 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:8"].color[7]	= SW_LINK_COLORS[1];
		
	gLocalPartData["localdb:8"].line[8]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_ROGUE];
	gLocalPartData["localdb:8"].color[8]	= SW_RED;
	gLocalPartData["localdb:8"].line[9] 	= "Equip: Decreases the cooldown of Kick by\n0.5 sec.";
	gLocalPartData["localdb:8"].color[9]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:8"].line[10]	= "Madcap's Outfit";
	gLocalPartData["localdb:8"].color[10]	= SW_GOLD;
	
	----------------------------
	gLocalPartData["localdb:9"] = {};
	gLocalPartData["localdb:9"].tex			= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:9"].line		= {};
	gLocalPartData["localdb:9"].color		= {};
	
	gLocalPartData["localdb:9"].line[1]		= "Unmarred Vision of Voodress";
	gLocalPartData["localdb:9"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:9"].line[2]		= SW_TEXT_BINDS;
	gLocalPartData["localdb:9"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:9"].line[3]		= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:9"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:9"].line[4]		= SW_TEXT_NECK;
	gLocalPartData["localdb:9"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:9"].line[5]		= "+6 "..SW_TEXT_STRENGTH;
	gLocalPartData["localdb:9"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:9"].line[6]		= "+10 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:9"].color[6]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:9"].line[7]		= "+10 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:9"].color[7]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:9"].line[8]		= "+9 "..SW_TEXT_SPIRIT;
	gLocalPartData["localdb:9"].color[8]	= SW_LINK_COLORS[1];
		
	gLocalPartData["localdb:9"].line[9]		= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_SHAMAN];
	gLocalPartData["localdb:9"].color[9]	= SW_RED;
	gLocalPartData["localdb:9"].line[10] 	= "Equip: Decreases the mana cost of your\nHealing Stream and Mana Spring\ntotems by 20.";
	gLocalPartData["localdb:9"].color[10]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:9"].line[11]	= "Augur's Regalia";
	gLocalPartData["localdb:9"].color[11]	= SW_GOLD;
	
	----------------------------
	gLocalPartData["localdb:10"] = {};
	gLocalPartData["localdb:10"].tex		= "Interface/Icons/INV_Jewelry_Necklace_26";
	gLocalPartData["localdb:10"].line		= {};
	gLocalPartData["localdb:10"].color		= {};
	
	gLocalPartData["localdb:10"].line[1]	= "Kezan's Unstoppable Taint";
	gLocalPartData["localdb:10"].color[1]	= SW_LINK_COLORS[4];
	gLocalPartData["localdb:10"].line[2]	= SW_TEXT_BINDS;
	gLocalPartData["localdb:10"].color[2]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:10"].line[3]	= SW_TEXT_UNIQUE;
	gLocalPartData["localdb:10"].color[3]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:10"].line[4]	= SW_TEXT_NECK;
	gLocalPartData["localdb:10"].color[4]	= SW_LINK_COLORS[1];
	
	gLocalPartData["localdb:10"].line[5]	= "+8 "..SW_TEXT_STAMINA;
	gLocalPartData["localdb:10"].color[5]	= SW_LINK_COLORS[1];
	gLocalPartData["localdb:10"].line[6]	= "+13 "..SW_TEXT_INTELLECT;
	gLocalPartData["localdb:10"].color[6]	= SW_LINK_COLORS[1];
			
	gLocalPartData["localdb:10"].line[7]	= SW_TEXT_CLASSES..SW_TEXT_CLASSNAMES[SW_CLASS_WARLOCK];
	gLocalPartData["localdb:10"].color[7]	= SW_RED;
	gLocalPartData["localdb:10"].line[8] 	= "Equip: Increases damage and healing\ndone by magical spells and effects by\nup to 14.";
	gLocalPartData["localdb:10"].color[8]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:10"].line[9] 	= "Equip: Increases the radius of Rain of\nFire and Hellfire by 1 yard.";
	gLocalPartData["localdb:10"].color[9]	= SW_LINK_COLORS[2];
	gLocalPartData["localdb:10"].line[10]	= "Demoniac's Threads";
	gLocalPartData["localdb:10"].color[10]	= SW_GOLD;
end