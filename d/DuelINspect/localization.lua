--##TRANSLATE PLZ---------
--##pre version 0.9-------
--Arcane Resistance
--Fire Resistance
--Nature Resistance
--Frost Resistance
--Shadow Resistance
--Target
--Trinket
--[Poor]
--[Standard]
--[Good]
--[Rare]
--[Epic]
--[Legendary]
--[Artifact]
--Armor
--Use:


--##version 0.9------------
--Are you sure you want to duel?
--You are already being challenged to a duel
--Items Quality
--Buffs
--Resistances
--Outbound Duels
--No Rank
--No Guild


TEXT_CLASS_COLORS = {
  ["HUNTER"] = "|cffaad372",
  ["WARLOCK"] = "|cff9382C9",
  ["PRIEST"] = "|cffffffff",
  ["PALADIN"] = "|cfff48cba",
  ["MAGE"] = "|cff68ccef",
  ["ROGUE"] = "|cfffff468",
  ["DRUID"] = "|cffff7c0a",
  ["SHAMAN"] = "|cfff48cba",
  ["WARRIOR"] = "|cffc69b6d" };






DI_RESISTANCES = {
	["ARCRES"] = "Arcane Resistance",
	["FIRERES"] = "Fire Resistance",
	["NATRES"] = "Nature Resistance",
	["FROSTRES"] = "Frost Resistance",
	["SHADRES"] = "Shadow Resistance"
};

 
DI_OTHERS = {
	["ARMOR"] = "Armor",
	["USE"] = "Use:"
};


DI_TEXT_TARGET = "Target";
DI_TEXT_TRINKET = "Trinket";
DI_TEXT_CONFIRMDUEL = "Are you sure you want to duel?";
DI_TEXT_ALREADYCHALLENGED = "You are already being challenged to a duel";
DI_TEXT_ITEMQUALITY = "Items Quality";
DI_TEXT_BUFFS = "Buffs";
DI_TEXT_RESISTANCES = "Resistances";
DI_TEXT_UPGROUTBOUND = "Outbound Duels";
DI_TEXT_NORANK = "No Rank";
DI_TEXT_NOGUILD = "No Guild";
DI_TEXT_QUALITY = {
	[0] = "[Poor]",
	[1] = "[Standard]",
	[2] = "[Good]",
	[3] = "[Rare]",
	[4] = "[Epic]",
	[5] = "[Legendary]",
	[6] = "[Artifact]" };


--English----------------------------------------------------
-----------------------------------------------------------

if (GetLocale() == "enUS" or GetLocale() == "enGB") then
	
	DI_RESISTANCES = {
		["ARCRES"] = "Arcane Resistance",
		["FIRERES"] = "Fire Resistance",
		["NATRES"] = "Nature Resistance",
		["FROSTRES"] = "Frost Resistance",
		["SHADRES"] = "Shadow Resistance"
	};


	DI_TEXT_TARGET = "Target";
	DI_TEXT_TRINKET = "Trinket";
	DI_TEXT_CONFIRMDUEL = "Are you sure you want to duel?";
	DI_TEXT_ALREADYCHALLENGED = "You are already being challenged to a duel";
	DI_TEXT_ITEMQUALITY = "Items Quality";
	DI_TEXT_BUFFS = "Buffs";
	DI_TEXT_RESISTANCES = "Resistances";
	DI_TEXT_UPGROUTBOUND = "Outbound Duels";
	DI_TEXT_NORANK = "No Rank";
	DI_TEXT_NOGUILD = "No Guild";
	DI_TEXT_QUALITY = {
		[0] = "[Poor]",
		[1] = "[Standard]",
		[2] = "[Good]",
		[3] = "[Rare]",
		[4] = "[Epic]",
		[5] = "[Legendary]",
		[6] = "[Artifact]" };
		
	DI_OTHERS = {
		["ARMOR"] = "Armor",
		["USE"] = "Use:"
	};

end







--German-----------------------------------------------------
-----------------------------------------------------------


if ( GetLocale() == "deDE" ) then

	DI_RESISTANCES = {
		["ARCRES"] = "Arkanwiderstand",
		["FIRERES"] = "Feuerwiderstand",
		["NATRES"] = "Naturwiderstand",
		["FROSTRES"] = "Frostwiderstand",
		["SHADRES"] = "Schattenwiderstand"
	};
	
	DI_TEXT_TARGET = "Ziel";
	DI_TEXT_TRINKET = "Schmuck";
	DI_TEXT_CONFIRMDUEL = "Are you sure you want to duel?";
	DI_TEXT_ALREADYCHALLENGED = "You are already being challenged to a duel";
	DI_TEXT_ITEMQUALITY = "Items Quality";
	DI_TEXT_BUFFS = "Buffs";
	DI_TEXT_RESISTANCES = "Resistances";
	DI_TEXT_UPGROUTBOUND = "Outbound Duels";
	DI_TEXT_NORANK = "No Rank";
	DI_TEXT_NOGUILD = "No Guild";
	DI_TEXT_QUALITY = {
		[0] = "[Schlecht]",
		[1] = "[Verbreitet]",
		[2] = "[Selten]",
		[3] = "[Rare]",
		[4] = "[Episch]",
		[5] = "[Legend195/164r]",
		[6] = "[Artefakt]" };
		
	DI_OTHERS = {
		["ARMOR"] = "R195/188stung",
		["USE"] = "Verwenden:"
	};
	
end







