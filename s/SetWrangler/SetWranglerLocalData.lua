function SetWrangler_ClearLocalData()
	SWLocalSetData = {};
end

function SetWrangler_LoadLocalData()
SWLocalSetData = {
	["16724:0:0:0"] = {
		["i"] = "Lightforge Gauntlets",
		["t"] = "Lightforge Gauntlets·Binds when picked up·Hands·Plate·386 Armor·+14 Strength·+9 Stamina·+14 Spirit·Requires Level 54· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
		["c"] = "0070dd",
	},
	["16729:0:0:0"] = {
		["i"] = "Lightforge Spaulders",
		["t"] = "Lightforge Spaulders·Binds when picked up·Shoulder·Plate·470 Armor·+9 Strength·+4 Agility·+15 Stamina·+11 Intellect·+5 Spirit·Requires Level 55· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
		["c"] = "0070dd",
	},
	["16722:0:0:0"] = {
		["i"] = "Lightforge Bracers",
		["c"] = "0070dd",
		["t"] = "Lightforge Bracers·Binds when equipped·Wrist·Plate·261 Armor·+7 Strength·+4 Agility·+10 Stamina·+8 Spirit·Requires Level 52· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
	},
	["16723:0:0:0"] = {
		["i"] = "Lightforge Belt",
		["c"] = "0070dd",
		["t"] = "Lightforge Belt·Binds when equipped·Waist·Plate·341 Armor·+10 Strength·+9 Stamina·+15 Intellect·+6 Spirit·Requires Level 53· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
	},
	["16728:0:0:0"] = {
		["i"] = "Lightforge Legplates",
		["c"] = "0070dd",
		["t"] = "Lightforge Legplates·Binds when picked up·Legs·Plate·557 Armor·+20 Strength·+8 Agility·+14 Stamina·+12 Intellect·+9 Spirit·Requires Level 56· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
	},
	["16725:0:0:0"] = {
		["i"] = "Lightforge Boots",
		["c"] = "0070dd",
		["t"] = "Lightforge Boots·Binds when picked up·Feet·Plate·424 Armor·+8 Strength·+18 Stamina·+9 Spirit·Requires Level 54· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
	},
	["16726:0:0:0"] = {
		["i"] = "Lightforge Breastplate",
		["c"] = "0070dd",
		["t"] = "Lightforge Breastplate·Binds when picked up·Chest·Plate·657 Armor·+13 Strength·+21 Stamina·+16 Intellect·+8 Spirit·Requires Level 58· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
	},
	["16727:0:0:0"] = {
		["i"] = "Lightforge Helm",
		["c"] = "0070dd",
		["t"] = "Lightforge Helm·Binds when picked up·Head·Plate·526 Armor·+13 Strength·+6 Agility·+20 Stamina·+14 Intellect·+10 Spirit·Requires Level 57· \
·Lightforge Armor (8)·  Lightforge Belt·  Lightforge Boots·  Lightforge Bracers·  Lightforge Breastplate·  Lightforge Gauntlets·  Lightforge Legplates·  Lightforge Spaulders·  Lightforge Helm·",
	},
	["16731:0:0:0"] = {
		["i"] = "Helm of Valor",
		["t"] = "Helm of Valor·Binds when picked up·Head·Plate·526 Armor·+15 Strength·+9 Agility·+23 Stamina·+8 Spirit·Requires Level 57· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
		["c"] = "0070dd",
	},
	["16736:0:0:0"] = {
		["i"] = "Belt of Valor",
		["c"] = "0070dd",
		["t"] = "Belt of Valor·Binds when picked up·Waist·Plate·341 Armor·+14 Strength·+7 Agility·+8 Stamina·+4 Spirit·Requires Level 53· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
	},
	["16735:0:0:0"] = {
		["c"] = "0070dd",
		["t"] = "Bracers of Valor·Binds when equipped·Wrist·Plate·261 Armor·+7 Strength·+3 Agility·+14 Stamina·+2 Spirit·Requires Level 52· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
		["i"] = "Bracers of Valor",
	},
	["16730:0:0:0"] = {
		["i"] = "Breastplate of Valor",
		["c"] = "0070dd",
		["t"] = "Breastplate of Valor·Binds when picked up·Chest·Plate·657 Armor·+15 Strength·+10 Agility·+24 Stamina·+6 Spirit·Requires Level 58· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
	},
	["16737:0:0:0"] = {
		["i"] = "Gauntlets of Valor",
		["t"] = "Gauntlets of Valor·Binds when picked up·Hands·Plate·386 Armor·+17 Strength·+3 Agility·+10 Stamina·+8 Spirit·Requires Level 54· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
		["c"] = "0070dd",
	},
	["16732:0:0:0"] = {
		["i"] = "Legplates of Valor",
		["c"] = "0070dd",
		["t"] = "Legplates of Valor·Binds when picked up·Legs·Plate·557 Armor·+23 Strength·+11 Agility·+15 Stamina·+4 Spirit·Requires Level 56· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
	},
	["16734:0:0:0"] = {
		["i"] = "Boots of Valor",
		["c"] = "0070dd",
		["t"] = "Boots of Valor·Binds when picked up·Feet·Plate·424 Armor·+8 Strength·+4 Agility·+20 Stamina·+3 Spirit·Requires Level 54· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
	},
	["16733:0:0:0"] = {
		["i"] = "Spaulders of Valor",
		["c"] = "0070dd",
		["t"] = "Spaulders of Valor·Binds when picked up·Shoulder·Plate·470 Armor·+11 Strength·+9 Agility·+17 Stamina·Requires Level 55· \
·Battlegear of Valor (8)·  Belt of Valor·  Boots of Valor·  Bracers of Valor·  Breastplate of Valor·  Gauntlets of Valor·  Helm of Valor·  Legplates of Valor·  Spaulders of Valor·",
	},
	["16867:0:0:0"] = {
		["i"] = "Legplates of Might",
		["c"] = "a335ee",
		["t"] = "Legplates of Might·Binds when picked up·Legs·Plate·655 Armor·+24 Strength·+23 Stamina·+10 Shadow Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to parry an attack by 1%.·Equip: Increased Defense +7.· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
	},
	["16868:0:0:0"] = {
		["i"] = "Pauldrons of Might",
		["c"] = "a335ee",
		["t"] = "Pauldrons of Might·Binds when picked up·Shoulder·Plate·562 Armor·+15 Strength·+22 Stamina·+7 Shadow Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to block attacks with a shield by 2%.·Equip: Increased Defense +5.· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
	},
	["16864:0:0:0"] = {
		["i"] = "Belt of Might",
		["c"] = "a335ee",
		["t"] = "Belt of Might·Binds when equipped·Waist·Plate·421 Armor·+21 Strength·+15 Stamina·+7 Fire Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to dodge an attack by 1%.·Equip: Increased Defense +5.· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
	},
	["16866:0:0:0"] = {
		["i"] = "Helm of Might",
		["c"] = "a335ee",
		["t"] = "Helm of Might·Binds when picked up·Head·Plate·608 Armor·+15 Strength·+35 Stamina·+10 Fire Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to dodge an attack by 1%.·Equip: Increased Defense +7.· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
	},
	["16863:0:0:0"] = {
		["i"] = "Gauntlets of Might",
		["t"] = "Gauntlets of Might·Binds when picked up·Hands·Plate·468 Armor·+22 Strength·+17 Stamina·+7 Fire Resistance·Classes: Warrior·Requires Level 60·Equip: Improves your chance to hit by 1%.·Equip: Increased Defense +5.· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
		["c"] = "a335ee",
	},
	["16862:0:0:0"] = {
		["i"] = "Sabatons of Might",
		["c"] = "a335ee",
		["t"] = "Sabatons of Might·Binds when picked up·Feet·Plate·515 Armor·+15 Strength·+26 Stamina·+7 Shadow Resistance·Classes: Warrior·Requires Level 60·Equip: Increased Defense +5.· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
	},
	["16861:0:0:0"] = {
		["i"] = "Bracers of Might",
		["c"] = "a335ee",
		["t"] = "Bracers of Might·Binds when equipped·Wrist·Plate·328 Armor·+11 Strength·+23 Stamina·Classes: Warrior·Requires Level 60· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
	},
	["16865:0:0:0"] = {
		["i"] = "Breastplate of Might",
		["t"] = "Breastplate of Might·Binds when picked up·Chest·Plate·749 Armor·+20 Strength·+28 Stamina·+10 Fire Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to block attacks with a shield by 3%.·Equip: Increased Defense +7.· \
·Battlegear of Might (8)·  Belt of Might·  Bracers of Might·  Breastplate of Might·  Gauntlets of Might·  Helm of Might·  Legplates of Might·  Pauldrons of Might·  Sabatons of Might·",
		["c"] = "a335ee",
	},
	["16718:0:0:0"] = {
		["i"] = "Wildheart Spaulders",
		["c"] = "0070dd",
		["t"] = "Wildheart Spaulders·Binds when picked up·Shoulder·Leather·127 Armor·+9 Stamina·+18 Intellect·+8 Spirit·Requires Level 55· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
	},
	["16715:0:0:0"] = {
		["i"] = "Wildheart Boots",
		["t"] = "Wildheart Boots·Binds when picked up·Feet·Leather·115 Armor·+10 Stamina·+9 Intellect·+17 Spirit·Requires Level 54· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
		["c"] = "0070dd",
	},
	["16714:0:0:0"] = {
		["i"] = "Wildheart Bracers",
		["c"] = "0070dd",
		["t"] = "Wildheart Bracers·Binds when equipped·Wrist·Leather·71 Armor·+7 Strength·+15 Intellect·Requires Level 52· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
	},
	["16720:0:0:0"] = {
		["i"] = "Wildheart Cowl",
		["c"] = "0070dd",
		["t"] = "Wildheart Cowl·Binds when picked up·Head·Leather·141 Armor·+6 Strength·+10 Stamina·+20 Intellect·+20 Spirit·Requires Level 57· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
	},
	["16706:0:0:0"] = {
		["i"] = "Wildheart Vest",
		["t"] = "Wildheart Vest·Binds when picked up·Chest·Leather·176 Armor·+13 Stamina·+20 Intellect·+20 Spirit·Requires Level 58· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
		["c"] = "0070dd",
	},
	["16716:0:0:0"] = {
		["i"] = "Wildheart Belt",
		["t"] = "Wildheart Belt·Binds when equipped·Waist·Leather·93 Armor·+9 Stamina·+17 Intellect·+10 Spirit·Requires Level 53· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
		["c"] = "0070dd",
	},
	["16717:0:0:0"] = {
		["i"] = "Wildheart Gloves",
		["c"] = "0070dd",
		["t"] = "Wildheart Gloves·Binds when equipped·Hands·Leather·105 Armor·+9 Intellect·+21 Spirit·Requires Level 54· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
	},
	["16719:0:0:0"] = {
		["i"] = "Wildheart Kilt",
		["c"] = "0070dd",
		["t"] = "Wildheart Kilt·Binds when picked up·Legs·Leather·150 Armor·+13 Strength·+12 Agility·+14 Stamina·+14 Intellect·+14 Spirit·Requires Level 56· \
·Wildheart Raiment (8)·  Wildheart Belt·  Wildheart Boots·  Wildheart Bracers·  Wildheart Cowl·  Wildheart Vest·  Wildheart Spaulders·  Wildheart Kilt·  Wildheart Gloves·",
	},
	["16834:0:0:0"] = {
		["i"] = "Cenarion Helm",
		["c"] = "a335ee",
		["t"] = "Cenarion Helm·Binds when picked up·Head·Leather·163 Armor·+26 Stamina·+28 Intellect·+13 Spirit·+10 Fire Resistance·Classes: Druid·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
	},
	["16829:0:0:0"] = {
		["i"] = "Cenarion Boots",
		["t"] = "Cenarion Boots·Binds when picked up·Feet·Leather·138 Armor·+16 Stamina·+13 Intellect·+15 Spirit·+7 Shadow Resistance·Classes: Druid·Requires Level 60·Equip: Restores 3 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 18.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
		["c"] = "a335ee",
	},
	["16836:0:0:0"] = {
		["i"] = "Cenarion Spaulders",
		["t"] = "Cenarion Spaulders·Binds when picked up·Shoulder·Leather·150 Armor·+13 Stamina·+20 Intellect·+10 Spirit·+7 Shadow Resistance·Classes: Druid·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 18.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
		["c"] = "a335ee",
	},
	["16833:0:0:0"] = {
		["i"] = "Cenarion Vestments",
		["c"] = "a335ee",
		["t"] = "Cenarion Vestments·Binds when picked up·Chest·Leather·200 Armor·+23 Stamina·+24 Intellect·+16 Spirit·+10 Fire Resistance·Classes: Druid·Requires Level 60·Equip: Restores 3 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 22.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
	},
	["16830:0:0:0"] = {
		["i"] = "Cenarion Bracers",
		["c"] = "a335ee",
		["t"] = "Cenarion Bracers·Binds when equipped·Wrist·Leather·88 Armor·+13 Stamina·+14 Intellect·+13 Spirit·Classes: Druid·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 6.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
	},
	["16828:0:0:0"] = {
		["i"] = "Cenarion Belt",
		["c"] = "a335ee",
		["t"] = "Cenarion Belt·Binds when equipped·Waist·Leather·113 Armor·+10 Stamina·+22 Intellect·+10 Spirit·+7 Fire Resistance·Classes: Druid·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
	},
	["16835:0:0:0"] = {
		["i"] = "Cenarion Leggings",
		["c"] = "a335ee",
		["t"] = "Cenarion Leggings·Binds when picked up·Legs·Leather·175 Armor·+18 Stamina·+19 Intellect·+20 Spirit·+10 Shadow Resistance·Classes: Druid·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Restores 4 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 22.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
	},
	["16831:0:0:0"] = {
		["i"] = "Cenarion Gloves",
		["c"] = "a335ee",
		["t"] = "Cenarion Gloves·Binds when picked up·Hands·Leather·125 Armor·+17 Stamina·+18 Intellect·+15 Spirit·+7 Fire Resistance·Classes: Druid·Requires Level 60·Equip: Increases healing done by spells and effects by up to 18.· \
·Cenarion Raiment (8)·  Cenarion Belt·  Cenarion Boots·  Cenarion Bracers·  Cenarion Vestments·  Cenarion Gloves·  Cenarion Helm·  Cenarion Leggings·  Cenarion Spaulders·",
	},
	["16903:0:0:0"] = {
		["i"] = "Stormrage Belt",
		["c"] = "a335ee",
		["t"] = "Stormrage Belt·Binds when picked up·Waist·Leather·126 Armor·+12 Stamina·+23 Intellect·+10 Spirit·+10 Shadow Resistance·Classes: Druid·Requires Level 60·Equip: Increases healing done by spells and effects by up to 26.·Equip: Restores 4 mana per 5 sec.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
	},
	["16904:0:0:0"] = {
		["i"] = "Stormrage Bracers",
		["t"] = "Stormrage Bracers·Binds when picked up·Wrist·Leather·98 Armor·+11 Stamina·+15 Intellect·+12 Spirit·Classes: Druid·Requires Level 60·Equip: Increases healing done by spells and effects by up to 33.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
		["c"] = "a335ee",
	},
	["16897:0:0:0"] = {
		["i"] = "Stormrage Chestguard",
		["c"] = "a335ee",
		["t"] = "Stormrage Chestguard·Binds when picked up·Chest·Leather·225 Armor·+20 Stamina·+25 Intellect·+17 Spirit·+10 Fire Resistance·+10 Nature Resistance·Classes: Druid·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases healing done by spells and effects by up to 42.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
	},
	["16902:0:0:0"] = {
		["i"] = "Stormrage Pauldrons",
		["c"] = "a335ee",
		["t"] = "Stormrage Pauldrons·Binds when picked up·Shoulder·Leather·169 Armor·+14 Stamina·+21 Intellect·+10 Spirit·+10 Fire Resistance·Classes: Druid·Requires Level 60·Equip: Increases healing done by spells and effects by up to 29.·Equip: Restores 4 mana per 5 sec.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
	},
	["16899:0:0:0"] = {
		["i"] = "Stormrage Handguards",
		["c"] = "a335ee",
		["t"] = "Stormrage Handguards·Binds when picked up·Hands·Leather·140 Armor·+13 Stamina·+19 Intellect·+15 Spirit·+10 Shadow Resistance·Classes: Druid·Requires Level 60·Equip: Increases healing done by spells and effects by up to 42.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
	},
	["16900:0:0:0"] = {
		["i"] = "Stormrage Cover",
		["c"] = "a335ee",
		["t"] = "Stormrage Cover·Binds when picked up·Head·Leather·183 Armor·+20 Stamina·+31 Intellect·+12 Spirit·+10 Frost Resistance·+10 Shadow Resistance·Classes: Druid·Requires Level 60·Equip: Restores 6 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 29.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
	},
	["16901:0:0:0"] = {
		["i"] = "Stormrage Legguards",
		["c"] = "a335ee",
		["t"] = "Stormrage Legguards·Binds when picked up·Legs·Leather·197 Armor·+17 Stamina·+26 Intellect·+16 Spirit·+10 Arcane Resistance·+10 Fire Resistance·Classes: Druid·Requires Level 60·Equip: Increases healing done by spells and effects by up to 48.·Equip: Restores 6 mana per 5 sec.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
	},
	["16898:0:0:0"] = {
		["i"] = "Stormrage Boots",
		["c"] = "a335ee",
		["t"] = "Stormrage Boots·Binds when picked up·Feet·Leather·154 Armor·+15 Stamina·+17 Intellect·+11 Spirit·+10 Fire Resistance·Classes: Druid·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases healing done by spells and effects by up to 26.· \
·Stormrage Raiment (8)·  Stormrage Belt·  Stormrage Boots·  Stormrage Bracers·  Stormrage Chestguard·  Stormrage Cover·  Stormrage Handguards·  Stormrage Legguards·  Stormrage Pauldrons·",
	},
	["16423:0:0:0"] = {
		["i"] = "Lieutenant Commander's Dragonhide Epaulets",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Dragonhide Epaulets·Binds when picked up·Unique·Shoulder·Leather·132 Armor·+10 Strength·+10 Agility·+10 Stamina·+6 Intellect·+10 Spirit·Classes: Druid·Requires Level 58·Requires Lieutenant Commander·Equip: Increases damage and healing done by magical spells and effects by up to 8.· \
·Lieutenant Commander's Sanctuary (6)·  Lieutenant Commander's Dragonhide Epaulets·  Lieutenant Commander's Dragonhide Shroud·  Knight-Captain's Dragonhide Leggings·  Knight-Captain's Dragonhide Tunic·  Knight-Lieutenant's Dragonhide Footwraps·  Knight-Lieutenant's Dragonhide Gloves·",
	},
	["16424:0:0:0"] = {
		["i"] = "Lieutenant Commander's Dragonhide Shroud",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Dragonhide Shroud·Binds when picked up·Unique·Head·Leather·143 Armor·+11 Strength·+11 Agility·+16 Stamina·+11 Intellect·+9 Spirit·Classes: Druid·Requires Level 58·Requires Champion·Equip: +16 Attack Power.·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Lieutenant Commander's Sanctuary (6)·  Lieutenant Commander's Dragonhide Epaulets·  Lieutenant Commander's Dragonhide Shroud·  Knight-Captain's Dragonhide Leggings·  Knight-Captain's Dragonhide Tunic·  Knight-Lieutenant's Dragonhide Footwraps·  Knight-Lieutenant's Dragonhide Gloves·",
	},
	["16393:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Dragonhide Footwraps",
		["t"] = "Knight-Lieutenant's Dragonhide Footwraps·Binds when picked up·Unique·Feet·Leather·121 Armor·+12 Strength·+5 Agility·+12 Stamina·+5 Intellect·+5 Spirit·Classes: Druid·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·Lieutenant Commander's Sanctuary (6)·  Lieutenant Commander's Dragonhide Epaulets·  Lieutenant Commander's Dragonhide Shroud·  Knight-Captain's Dragonhide Leggings·  Knight-Captain's Dragonhide Tunic·  Knight-Lieutenant's Dragonhide Footwraps·  Knight-Lieutenant's Dragonhide Gloves·",
		["c"] = "0070dd",
	},
	["16421:0:0:0"] = {
		["i"] = "Knight-Captain's Dragonhide Tunic",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Dragonhide Tunic·Binds when picked up·Unique·Chest·Leather·176 Armor·+13 Strength·+9 Agility·+14 Stamina·+8 Intellect·Classes: Druid·Requires Level 58·Requires Knight-Captain·Equip: Increases damage and healing done by magical spells and effects by up to 16.·Equip: Improves your chance to get a critical strike by 1%.· \
·Lieutenant Commander's Sanctuary (6)·  Lieutenant Commander's Dragonhide Epaulets·  Lieutenant Commander's Dragonhide Shroud·  Knight-Captain's Dragonhide Leggings·  Knight-Captain's Dragonhide Tunic·  Knight-Lieutenant's Dragonhide Footwraps·  Knight-Lieutenant's Dragonhide Gloves·",
	},
	["16397:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Dragonhide Gloves",
		["t"] = "Knight-Lieutenant's Dragonhide Gloves·Binds when picked up·Unique·Hands·Leather·110 Armor·+12 Strength·+12 Agility·+12 Stamina·Classes: Druid·Requires Level 58·Requires Blood Guard·Equip: Slightly increases your stealth detection.· \
·Lieutenant Commander's Sanctuary (6)·  Lieutenant Commander's Dragonhide Epaulets·  Lieutenant Commander's Dragonhide Shroud·  Knight-Captain's Dragonhide Leggings·  Knight-Captain's Dragonhide Tunic·  Knight-Lieutenant's Dragonhide Footwraps·  Knight-Lieutenant's Dragonhide Gloves·",
		["c"] = "0070dd",
	},
	["16422:0:0:0"] = {
		["i"] = "Knight-Captain's Dragonhide Leggings",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Dragonhide Leggings·Binds when picked up·Unique·Legs·Leather·154 Armor·+12 Strength·+12 Agility·+12 Stamina·+9 Intellect·+12 Spirit·Classes: Druid·Requires Level 58·Requires Legionnaire·Equip: Increases your chance to dodge an attack by 1%.·Equip: +18 Attack Power.· \
·Lieutenant Commander's Sanctuary (6)·  Lieutenant Commander's Dragonhide Epaulets·  Lieutenant Commander's Dragonhide Shroud·  Knight-Captain's Dragonhide Leggings·  Knight-Captain's Dragonhide Tunic·  Knight-Lieutenant's Dragonhide Footwraps·  Knight-Lieutenant's Dragonhide Gloves·",
	},
	["16504:0:0:0"] = {
		["i"] = "Legionnaire's Dragonhide Breastplate",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Dragonhide Breastplate·Binds when picked up·Unique·Chest·Leather·176 Armor·+13 Strength·+9 Agility·+14 Stamina·+8 Intellect·Classes: Druid·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Champion's Sanctuary (6)·  Blood Guard's Dragonhide Boots·  Blood Guard's Dragonhide Gauntlets·  Legionnaire's Dragonhide Breastplate·  Legionnaire's Dragonhide Trousers·  Champion's Dragonhide Helm·  Champion's Dragonhide Spaulders·",
	},
	["16502:0:0:0"] = {
		["i"] = "Legionnaire's Dragonhide Trousers",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Dragonhide Trousers·Binds when picked up·Unique·Legs·Leather·154 Armor·+12 Strength·+12 Agility·+12 Stamina·+9 Intellect·+12 Spirit·Classes: Druid·Requires Level 58·Requires Legionnaire·Equip: Increases your chance to dodge an attack by 1%.·Equip: +18 Attack Power.· \
·Champion's Sanctuary (6)·  Blood Guard's Dragonhide Boots·  Blood Guard's Dragonhide Gauntlets·  Legionnaire's Dragonhide Breastplate·  Legionnaire's Dragonhide Trousers·  Champion's Dragonhide Helm·  Champion's Dragonhide Spaulders·",
	},
	["16494:0:0:0"] = {
		["i"] = "Blood Guard's Dragonhide Boots",
		["t"] = "Blood Guard's Dragonhide Boots·Binds when picked up·Unique·Feet·Leather·121 Armor·+12 Strength·+5 Agility·+12 Stamina·+5 Intellect·+5 Spirit·Classes: Druid·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·Champion's Sanctuary (6)·  Blood Guard's Dragonhide Boots·  Blood Guard's Dragonhide Gauntlets·  Legionnaire's Dragonhide Breastplate·  Legionnaire's Dragonhide Trousers·  Champion's Dragonhide Helm·  Champion's Dragonhide Spaulders·",
		["c"] = "0070dd",
	},
	["16503:0:0:0"] = {
		["i"] = "Champion's Dragonhide Helm",
		["c"] = "0070dd",
		["t"] = "Champion's Dragonhide Helm·Binds when picked up·Unique·Head·Leather·143 Armor·+11 Strength·+11 Agility·+16 Stamina·+11 Intellect·+9 Spirit·Classes: Druid·Requires Level 58·Requires Champion·Equip: +16 Attack Power.·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Champion's Sanctuary (6)·  Blood Guard's Dragonhide Boots·  Blood Guard's Dragonhide Gauntlets·  Legionnaire's Dragonhide Breastplate·  Legionnaire's Dragonhide Trousers·  Champion's Dragonhide Helm·  Champion's Dragonhide Spaulders·",
	},
	["16501:0:0:0"] = {
		["i"] = "Champion's Dragonhide Spaulders",
		["t"] = "Champion's Dragonhide Spaulders·Binds when picked up·Unique·Shoulder·Leather·132 Armor·+10 Strength·+10 Agility·+10 Stamina·+6 Intellect·+10 Spirit·Classes: Druid·Requires Level 58·Requires Champion·Equip: Increases damage and healing done by magical spells and effects by up to 8.· \
·Champion's Sanctuary (6)·  Blood Guard's Dragonhide Boots·  Blood Guard's Dragonhide Gauntlets·  Legionnaire's Dragonhide Breastplate·  Legionnaire's Dragonhide Trousers·  Champion's Dragonhide Helm·  Champion's Dragonhide Spaulders·",
		["c"] = "0070dd",
	},
	["16496:0:0:0"] = {
		["i"] = "Blood Guard's Dragonhide Gauntlets",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Dragonhide Gauntlets·Binds when picked up·Unique·Hands·Leather·110 Armor·+12 Strength·+12 Agility·+12 Stamina·Classes: Druid·Requires Level 58·Requires Blood Guard·Equip: Slightly increases your stealth detection.· \
·Champion's Sanctuary (6)·  Blood Guard's Dragonhide Boots·  Blood Guard's Dragonhide Gauntlets·  Legionnaire's Dragonhide Breastplate·  Legionnaire's Dragonhide Trousers·  Champion's Dragonhide Helm·  Champion's Dragonhide Spaulders·",
	},
	["16451:0:0:0"] = {
		["i"] = "Field Marshal's Dragonhide Helmet",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Dragonhide Helmet·Binds when picked up·Unique·Head·Leather·160 Armor·+15 Strength·+16 Agility·+16 Stamina·+15 Intellect·+13 Spirit·Classes: Druid·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 18.·Equip: +24 Attack Power.· \
·Field Marshal's Sanctuary (6)·  Field Marshal's Dragonhide Breastplate·  Field Marshal's Dragonhide Helmet·  Field Marshal's Dragonhide Spaulders·  Marshal's Dragonhide Boots·  Marshal's Dragonhide Gauntlets·  Marshal's Dragonhide Legguards·",
	},
	["16449:0:0:0"] = {
		["i"] = "Field Marshal's Dragonhide Spaulders",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Dragonhide Spaulders·Binds when picked up·Unique·Shoulder·Leather·148 Armor·+12 Strength·+12 Agility·+12 Stamina·+11 Intellect·+11 Spirit·Classes: Druid·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 18.· \
·Field Marshal's Sanctuary (6)·  Field Marshal's Dragonhide Breastplate·  Field Marshal's Dragonhide Helmet·  Field Marshal's Dragonhide Spaulders·  Marshal's Dragonhide Boots·  Marshal's Dragonhide Gauntlets·  Marshal's Dragonhide Legguards·",
	},
	["16448:0:0:0"] = {
		["i"] = "Marshal's Dragonhide Gauntlets",
		["c"] = "a335ee",
		["t"] = "Marshal's Dragonhide Gauntlets·Binds when picked up·Unique·Hands·Leather·123 Armor·+18 Strength·+17 Agility·+15 Stamina·Classes: Druid·Requires Level 60·Requires General·Equip: Slightly increases your stealth detection.· \
·Field Marshal's Sanctuary (6)·  Field Marshal's Dragonhide Breastplate·  Field Marshal's Dragonhide Helmet·  Field Marshal's Dragonhide Spaulders·  Marshal's Dragonhide Boots·  Marshal's Dragonhide Gauntlets·  Marshal's Dragonhide Legguards·",
	},
	["16450:0:0:0"] = {
		["i"] = "Marshal's Dragonhide Legguards",
		["c"] = "a335ee",
		["t"] = "Marshal's Dragonhide Legguards·Binds when picked up·Unique·Legs·Leather·173 Armor·+16 Strength·+16 Agility·+15 Stamina·+13 Intellect·+15 Spirit·Classes: Druid·Requires Level 60·Requires General·Equip: Increases your chance to dodge an attack by 1%.·Equip: +22 Attack Power.· \
·Field Marshal's Sanctuary (6)·  Field Marshal's Dragonhide Breastplate·  Field Marshal's Dragonhide Helmet·  Field Marshal's Dragonhide Spaulders·  Marshal's Dragonhide Boots·  Marshal's Dragonhide Gauntlets·  Marshal's Dragonhide Legguards·",
	},
	["16452:0:0:0"] = {
		["i"] = "Field Marshal's Dragonhide Breastplate",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Dragonhide Breastplate·Binds when picked up·Unique·Chest·Leather·197 Armor·+19 Strength·+14 Agility·+18 Stamina·+13 Intellect·Classes: Druid·Requires Level 60·Requires Warlord·Equip: +36 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·Field Marshal's Sanctuary (6)·  Field Marshal's Dragonhide Breastplate·  Field Marshal's Dragonhide Helmet·  Field Marshal's Dragonhide Spaulders·  Marshal's Dragonhide Boots·  Marshal's Dragonhide Gauntlets·  Marshal's Dragonhide Legguards·",
	},
	["16459:0:0:0"] = {
		["i"] = "Marshal's Dragonhide Boots",
		["t"] = "Marshal's Dragonhide Boots·Binds when picked up·Unique·Feet·Leather·136 Armor·+15 Strength·+10 Agility·+14 Stamina·+11 Intellect·+10 Spirit·Classes: Druid·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Field Marshal's Sanctuary (6)·  Field Marshal's Dragonhide Breastplate·  Field Marshal's Dragonhide Helmet·  Field Marshal's Dragonhide Spaulders·  Marshal's Dragonhide Boots·  Marshal's Dragonhide Gauntlets·  Marshal's Dragonhide Legguards·",
		["c"] = "a335ee",
	},
	["16552:0:0:0"] = {
		["i"] = "General's Dragonhide Leggings",
		["t"] = "General's Dragonhide Leggings·Binds when picked up·Unique·Legs·Leather·173 Armor·+16 Strength·+16 Agility·+15 Stamina·+13 Intellect·+15 Spirit·Classes: Druid·Requires Level 60·Requires General·Equip: Increases your chance to dodge an attack by 1%.·Equip: +22 Attack Power.· \
·Warlord's Sanctuary (6)·  General's Dragonhide Boots·  General's Dragonhide Gloves·  General's Dragonhide Leggings·  Warlord's Dragonhide Epaulets·  Warlord's Dragonhide Hauberk·  Warlord's Dragonhide Helmet·",
		["c"] = "a335ee",
	},
	["16549:0:0:0"] = {
		["i"] = "Warlord's Dragonhide Hauberk",
		["t"] = "Warlord's Dragonhide Hauberk·Binds when picked up·Unique·Chest·Leather·197 Armor·+19 Strength·+14 Agility·+18 Stamina·+13 Intellect·Classes: Druid·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 21.·Equip: Improves your chance to get a critical strike by 1%.· \
·Warlord's Sanctuary (6)·  General's Dragonhide Boots·  General's Dragonhide Gloves·  General's Dragonhide Leggings·  Warlord's Dragonhide Epaulets·  Warlord's Dragonhide Hauberk·  Warlord's Dragonhide Helmet·",
		["c"] = "a335ee",
	},
	["16555:0:0:0"] = {
		["i"] = "General's Dragonhide Gloves",
		["t"] = "General's Dragonhide Gloves·Binds when picked up·Unique·Hands·Leather·123 Armor·+18 Strength·+17 Agility·+15 Stamina·Classes: Druid·Requires Level 60·Requires General·Equip: Slightly increases your stealth detection.· \
·Warlord's Sanctuary (6)·  General's Dragonhide Boots·  General's Dragonhide Gloves·  General's Dragonhide Leggings·  Warlord's Dragonhide Epaulets·  Warlord's Dragonhide Hauberk·  Warlord's Dragonhide Helmet·",
		["c"] = "a335ee",
	},
	["16550:0:0:0"] = {
		["i"] = "Warlord's Dragonhide Helmet",
		["t"] = "Warlord's Dragonhide Helmet·Binds when picked up·Unique·Head·Leather·160 Armor·+15 Strength·+16 Agility·+16 Stamina·+15 Intellect·+13 Spirit·Classes: Druid·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 18.·Equip: +24 Attack Power.· \
·Warlord's Sanctuary (6)·  General's Dragonhide Boots·  General's Dragonhide Gloves·  General's Dragonhide Leggings·  Warlord's Dragonhide Epaulets·  Warlord's Dragonhide Hauberk·  Warlord's Dragonhide Helmet·",
		["c"] = "a335ee",
	},
	["16551:0:0:0"] = {
		["i"] = "Warlord's Dragonhide Epaulets",
		["t"] = "Warlord's Dragonhide Epaulets·Binds when picked up·Unique·Shoulder·Leather·148 Armor·+12 Strength·+12 Agility·+12 Stamina·+11 Intellect·+11 Spirit·Classes: Druid·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 18.· \
·Warlord's Sanctuary (6)·  General's Dragonhide Boots·  General's Dragonhide Gloves·  General's Dragonhide Leggings·  Warlord's Dragonhide Epaulets·  Warlord's Dragonhide Hauberk·  Warlord's Dragonhide Helmet·",
		["c"] = "a335ee",
	},
	["16554:0:0:0"] = {
		["i"] = "General's Dragonhide Boots",
		["t"] = "General's Dragonhide Boots·Binds when picked up·Unique·Feet·Leather·136 Armor·+15 Strength·+10 Agility·+14 Stamina·+11 Intellect·+10 Spirit·Classes: Druid·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Warlord's Sanctuary (6)·  General's Dragonhide Boots·  General's Dragonhide Gloves·  General's Dragonhide Leggings·  Warlord's Dragonhide Epaulets·  Warlord's Dragonhide Hauberk·  Warlord's Dragonhide Helmet·",
		["c"] = "a335ee",
	},
	["19838:0:0:0"] = {
		["i"] = "Zandalar Haruspex's Tunic",
		["c"] = "a335ee",
		["t"] = "Zandalar Haruspex's Tunic·Binds when picked up·Chest·Leather·287 Armor·+15 Stamina·+24 Intellect·+23 Spirit·Classes: Druid·Equip: Increases healing done by spells and effects by up to 33.· \
·Haruspex's Garb (5)·  Pristine Enchanted South Seas Kelp·  Wushoolay's Charm of Nature·  Zandalar Haruspex's Bracers·  Zandalar Haruspex's Belt·  Zandalar Haruspex's Tunic·",
	},
	["19840:0:0:0"] = {
		["i"] = "Zandalar Haruspex's Bracers",
		["t"] = "Zandalar Haruspex's Bracers·Binds when picked up·Wrist·Leather·122 Armor·+7 Stamina·+10 Intellect·+10 Spirit·Classes: Druid·Equip: Increases healing done by spells and effects by up to 22.· \
·Haruspex's Garb (5)·  Pristine Enchanted South Seas Kelp·  Wushoolay's Charm of Nature·  Zandalar Haruspex's Bracers·  Zandalar Haruspex's Belt·  Zandalar Haruspex's Tunic·",
		["c"] = "0070dd",
	},
	["19955:0:0:0"] = {
		["i"] = "Wushoolay's Charm of Nature",
		["c"] = "a335ee",
		["t"] = "Wushoolay's Charm of Nature·Binds when picked up·Unique·Trinket·Classes: Druid·Requires Level 60·Use: Reduces the casting time of your Healing Touch spells by 40%, and reduces the mana cost of your healing spells by 5% for 15 sec.· \
·Haruspex's Garb (5)·  Pristine Enchanted South Seas Kelp·  Wushoolay's Charm of Nature·  Zandalar Haruspex's Bracers·  Zandalar Haruspex's Belt·  Zandalar Haruspex's Tunic·",
	},
	["19839:0:0:0"] = {
		["i"] = "Zandalar Haruspex's Belt",
		["c"] = "0070dd",
		["t"] = "Zandalar Haruspex's Belt·Binds when picked up·Waist·Leather·166 Armor·+10 Stamina·+21 Intellect·+12 Spirit·Classes: Druid· \
·Haruspex's Garb (5)·  Pristine Enchanted South Seas Kelp·  Wushoolay's Charm of Nature·  Zandalar Haruspex's Bracers·  Zandalar Haruspex's Belt·  Zandalar Haruspex's Tunic·",
	},
	["19613:0:0:0"] = {
		["i"] = "Pristine Enchanted South Seas Kelp",
		["c"] = "a335ee",
		["t"] = "Pristine Enchanted South Seas Kelp·Binds when picked up·Unique·Neck·+6 Strength·+10 Stamina·+10 Intellect·+9 Spirit·Classes: Druid·Passive: Increases the critical hit chance of Wrath and Starfire by 2%.· \
·Haruspex's Garb (5)·  Pristine Enchanted South Seas Kelp·  Wushoolay's Charm of Nature·  Zandalar Haruspex's Bracers·  Zandalar Haruspex's Belt·  Zandalar Haruspex's Tunic·",
	},
	["19612:0:0:0"] = {
		["i"] = "Enchanted South Seas Kelp",
		["c"] = "0070dd",
		["t"] = "Enchanted South Seas Kelp·Binds when picked up·Unique·Neck·+6 Strength·+10 Stamina·+10 Intellect·+9 Spirit·Classes: Druid·",
	},
	["19611:0:0:0"] = {
		["i"] = "Enchanted South Seas Kelp",
		["c"] = "0070dd",
		["t"] = "Enchanted South Seas Kelp·Binds when picked up·Unique·Neck·+6 Strength·+8 Stamina·+8 Intellect·+7 Spirit·Classes: Druid·",
	},
	["19610:0:0:0"] = {
		["i"] = "Enchanted South Seas Kelp",
		["c"] = "1eff00",
		["t"] = "Enchanted South Seas Kelp·Binds when picked up·Unique·Neck·+8 Stamina·+8 Intellect·+7 Spirit·Classes: Druid·",
	},
	["20045:0:0:0"] = {
		["i"] = "Highlander's Leather Girdle",
		["t"] = "Highlander's Leather Girdle·Binds when picked up·Unique·Waist·Leather·159 Armor·+7 Stamina·Classes: Rogue, Druid·Requires Level 58·Requires The League of Arathor - Honored·Equip: Improves your chance to get a critical strike by 1%.·Equip: +34 Attack Power.· \
·The Highlander's Purpose (3)·  Highlander's Leather Boots·  Highlander's Leather Girdle·  Highlander's Leather Shoulders·",
		["c"] = "0070dd",
	},
	["20059:0:0:0"] = {
		["i"] = "Highlander's Leather Shoulders",
		["c"] = "a335ee",
		["t"] = "Highlander's Leather Shoulders·Binds when picked up·Unique·Shoulder·Leather·258 Armor·+18 Agility·+17 Stamina·Classes: Rogue, Druid·Requires Level 60·Requires The League of Arathor - Exalted·Equip: +30 Attack Power.· \
·The Highlander's Purpose (3)·  Highlander's Leather Boots·  Highlander's Leather Girdle·  Highlander's Leather Shoulders·",
	},
	["20052:0:0:0"] = {
		["i"] = "Highlander's Leather Boots",
		["t"] = "Highlander's Leather Boots·Binds when picked up·Unique·Feet·Leather·181 Armor·+12 Agility·+16 Stamina·Classes: Rogue, Druid·Requires Level 58·Requires The League of Arathor - Revered·Equip: Run speed increased slightly.·Equip: +16 Attack Power.· \
·The Highlander's Purpose (3)·  Highlander's Leather Boots·  Highlander's Leather Girdle·  Highlander's Leather Shoulders·",
		["c"] = "0070dd",
	},
	["20060:0:0:0"] = {
		["i"] = "Highlander's Lizardhide Shoulders",
		["c"] = "a335ee",
		["t"] = "Highlander's Lizardhide Shoulders·Binds when picked up·Unique·Shoulder·Leather·258 Armor·+12 Agility·+17 Stamina·+12 Intellect·Classes: Rogue, Druid·Requires Level 60·Requires The League of Arathor - Exalted·Equip: +30 Attack Power.· \
·The Highlander's Will (3)·",
	},
	["20053:0:0:0"] = {
		["i"] = "Highlander's Lizardhide Boots",
		["c"] = "0070dd",
		["t"] = "Highlander's Lizardhide Boots·Binds when picked up·Unique·Feet·Leather·181 Armor·+8 Agility·+16 Stamina·+8 Intellect·Classes: Rogue, Druid·Requires Level 58·Requires The League of Arathor - Revered·Equip: Run speed increased slightly.·Equip: +16 Attack Power.· \
·The Highlander's Will (3)·  Highlander's Lizardhide Boots·  Highlander's Lizardhide Girdle·  Highlander's Lizardhide Shoulders·",
	},
	["20046:0:0:0"] = {
		["i"] = "Highlander's Lizardhide Girdle",
		["c"] = "0070dd",
		["t"] = "Highlander's Lizardhide Girdle·Binds when picked up·Unique·Waist·Leather·159 Armor·+7 Stamina·+17 Intellect·Classes: Rogue, Druid·Requires Level 58·Requires The League of Arathor - Honored·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·The Highlander's Will (3)·  Highlander's Lizardhide Boots·  Highlander's Lizardhide Girdle·  Highlander's Lizardhide Shoulders·",
	},
	["20194:0:0:0"] = {
		["i"] = "Defiler's Leather Shoulders",
		["t"] = "Defiler's Leather Shoulders·Binds when picked up·Unique·Shoulder·Leather·258 Armor·+18 Agility·+17 Stamina·Classes: Rogue, Druid·Requires Level 60·Requires The Defilers - Exalted·Equip: +30 Attack Power.· \
·The Defiler's Purpose (3)·  Defiler's Leather Boots·  Defiler's Leather Girdle·  Defiler's Leather Shoulders·",
		["c"] = "a335ee",
	},
	["20190:0:0:0"] = {
		["i"] = "Defiler's Leather Girdle",
		["c"] = "0070dd",
		["t"] = "Defiler's Leather Girdle·Binds when picked up·Unique·Waist·Leather·159 Armor·+7 Stamina·Classes: Rogue, Druid·Requires Level 58·Requires The Defilers - Honored·Equip: Improves your chance to get a critical strike by 1%.·Equip: +34 Attack Power.· \
·The Defiler's Purpose (3)·  Defiler's Leather Boots·  Defiler's Leather Girdle·  Defiler's Leather Shoulders·",
	},
	["20186:0:0:0"] = {
		["i"] = "Defiler's Leather Boots",
		["c"] = "0070dd",
		["t"] = "Defiler's Leather Boots·Binds when picked up·Unique·Feet·Leather·181 Armor·+12 Agility·+16 Stamina·Classes: Rogue, Druid·Requires Level 58·Requires The Defilers - Revered·Equip: Run speed increased slightly.·Equip: +16 Attack Power.· \
·The Defiler's Purpose (3)·  Defiler's Leather Boots·  Defiler's Leather Girdle·  Defiler's Leather Shoulders·",
	},
	["20175:0:0:0"] = {
		["i"] = "Defiler's Lizardhide Shoulders",
		["t"] = "Defiler's Lizardhide Shoulders·Binds when picked up·Unique·Shoulder·Leather·258 Armor·+12 Agility·+17 Stamina·+12 Intellect·Classes: Rogue, Druid·Requires Level 60·Requires The Defilers - Exalted·Equip: +30 Attack Power.· \
·The Defiler's Will (3)·  Defiler's Lizardhide Boots·  Defiler's Lizardhide Girdle·  Defiler's Lizardhide Shoulders·",
		["c"] = "a335ee",
	},
	["20171:0:0:0"] = {
		["i"] = "Defiler's Lizardhide Girdle",
		["t"] = "Defiler's Lizardhide Girdle·Binds when picked up·Unique·Waist·Leather·159 Armor·+7 Stamina·+17 Intellect·Classes: Rogue, Druid·Requires Level 58·Requires The Defilers - Honored·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·The Defiler's Will (3)·  Defiler's Lizardhide Boots·  Defiler's Lizardhide Girdle·  Defiler's Lizardhide Shoulders·",
		["c"] = "0070dd",
	},
	["20167:0:0:0"] = {
		["i"] = "Defiler's Lizardhide Boots",
		["t"] = "Defiler's Lizardhide Girdle·Binds when picked up·Unique·Waist·Leather·159 Armor·+7 Stamina·+17 Intellect·Classes: Rogue, Druid·Requires Level 58·Requires The Defilers - Honored·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·The Defiler's Will (3)·  Defiler's Lizardhide Boots·  Defiler's Lizardhide Girdle·  Defiler's Lizardhide Shoulders·",
		["c"] = "0070dd",
	},
	["16859:0:0:0"] = {
		["i"] = "Lawbringer Boots",
		["c"] = "a335ee",
		["t"] = "Lawbringer Boots·Binds when picked up·Feet·Plate·515 Armor·+7 Strength·+20 Stamina·+13 Intellect·+10 Spirit·+7 Shadow Resistance·Classes: Paladin·Requires Level 60·Equip: Restores 2 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 18.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
	},
	["16853:0:0:0"] = {
		["i"] = "Lawbringer Chestguard",
		["c"] = "a335ee",
		["t"] = "Lawbringer Chestguard·Binds when picked up·Chest·Plate·749 Armor·+8 Strength·+26 Stamina·+21 Intellect·+13 Spirit·+10 Fire Resistance·Classes: Paladin·Requires Level 60·Equip: Increases healing done by spells and effects by up to 22.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
	},
	["16855:0:0:0"] = {
		["i"] = "Lawbringer Legplates",
		["c"] = "a335ee",
		["t"] = "Lawbringer Legplates·Binds when picked up·Legs·Plate·655 Armor·+7 Strength·+24 Stamina·+18 Intellect·+18 Spirit·+10 Shadow Resistance·Classes: Paladin·Requires Level 60·Equip: Restores 3 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 22.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
	},
	["16856:0:0:0"] = {
		["i"] = "Lawbringer Spaulders",
		["t"] = "Lawbringer Spaulders·Binds when picked up·Shoulder·Plate·562 Armor·+10 Strength·+22 Stamina·+15 Intellect·+8 Spirit·+7 Shadow Resistance·Classes: Paladin·Requires Level 60·Equip: Increases healing done by spells and effects by up to 18.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
		["c"] = "a335ee",
	},
	["16858:0:0:0"] = {
		["i"] = "Lawbringer Belt",
		["c"] = "a335ee",
		["t"] = "Lawbringer Belt·Binds when equipped·Waist·Plate·421 Armor·+13 Strength·+15 Stamina·+20 Intellect·+8 Spirit·+7 Fire Resistance·Classes: Paladin·Requires Level 60·Equip: Increases healing done by spells and effects by up to 18.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
	},
	["16857:0:0:0"] = {
		["i"] = "Lawbringer Bracers",
		["t"] = "Lawbringer Bracers·Binds when equipped·Wrist·Plate·328 Armor·+10 Strength·+11 Stamina·+8 Intellect·+11 Spirit·Classes: Paladin·Requires Level 60·Equip: Restores 4 mana per 5 sec.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
		["c"] = "a335ee",
	},
	["16854:0:0:0"] = {
		["i"] = "Lawbringer Helm",
		["c"] = "a335ee",
		["t"] = "Lawbringer Helm·Binds when picked up·Head·Plate·608 Armor·+9 Strength·+20 Stamina·+24 Intellect·+10 Spirit·+10 Fire Resistance·Classes: Paladin·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 22.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
	},
	["16860:0:0:0"] = {
		["i"] = "Lawbringer Gauntlets",
		["t"] = "Lawbringer Gauntlets·Binds when picked up·Hands·Plate·468 Armor·+10 Strength·+15 Stamina·+15 Intellect·+14 Spirit·+7 Fire Resistance·Classes: Paladin·Requires Level 60·Equip: Increases healing done by spells and effects by up to 18.· \
·Lawbringer Armor (8)·  Lawbringer Belt·  Lawbringer Boots·  Lawbringer Bracers·  Lawbringer Chestguard·  Lawbringer Gauntlets·  Lawbringer Helm·  Lawbringer Legplates·  Lawbringer Spaulders·",
		["c"] = "a335ee",
	},
	["16955:0:0:0"] = {
		["i"] = "Judgement Crown",
		["t"] = "Judgement Crown·Binds when picked up·Head·Plate·696 Armor·+17 Strength·+18 Stamina·+23 Intellect·+6 Spirit·+10 Frost Resistance·+10 Shadow Resistance·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 32.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
		["c"] = "a335ee",
	},
	["16951:0:0:0"] = {
		["i"] = "Judgement Bindings",
		["t"] = "Judgement Bindings·Binds when picked up·Wrist·Plate·375 Armor·+9 Strength·+21 Stamina·+9 Intellect·+8 Spirit·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 7.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
		["c"] = "a335ee",
	},
	["16956:0:0:0"] = {
		["i"] = "Judgement Gauntlets",
		["c"] = "a335ee",
		["t"] = "Judgement Gauntlets·Binds when picked up·Hands·Plate·535 Armor·+6 Strength·+15 Stamina·+20 Intellect·+6 Spirit·+10 Shadow Resistance·Classes: Paladin·Requires Level 60·Equip: Restores 6 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 15.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
	},
	["16958:0:0:0"] = {
		["i"] = "Judgement Breastplate",
		["t"] = "Judgement Breastplate·Binds when picked up·Chest·Plate·857 Armor·+16 Strength·+21 Stamina·+21 Intellect·+5 Spirit·+10 Fire Resistance·+10 Nature Resistance·Classes: Paladin·Requires Level 60·Equip: Restores 5 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 25.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
		["c"] = "a335ee",
	},
	["16952:0:0:0"] = {
		["i"] = "Judgement Belt",
		["c"] = "a335ee",
		["t"] = "Judgement Belt·Binds when picked up·Waist·Plate·482 Armor·+8 Strength·+14 Stamina·+20 Intellect·+6 Spirit·+10 Shadow Resistance·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 23.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
	},
	["16953:0:0:0"] = {
		["i"] = "Judgement Spaulders",
		["c"] = "a335ee",
		["t"] = "Judgement Spaulders·Binds when picked up·Shoulder·Plate·642 Armor·+13 Strength·+20 Stamina·+14 Intellect·+6 Spirit·+10 Fire Resistance·Classes: Paladin·Requires Level 60·Equip: Restores 5 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
	},
	["16957:0:0:0"] = {
		["i"] = "Judgement Sabatons",
		["c"] = "a335ee",
		["t"] = "Judgement Sabatons·Binds when picked up·Feet·Plate·589 Armor·+13 Strength·+20 Stamina·+14 Intellect·+8 Spirit·+10 Fire Resistance·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 18.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
	},
	["16954:0:0:0"] = {
		["i"] = "Judgement Legplates",
		["c"] = "a335ee",
		["t"] = "Judgement Legplates·Binds when picked up·Legs·Plate·749 Armor·+10 Strength·+26 Stamina·+27 Intellect·+5 Spirit·+10 Arcane Resistance·+10 Fire Resistance·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.·Equip: Restores 4 mana per 5 sec.· \
·Judgement Armor (8)·  Judgement Belt·  Judgement Bindings·  Judgement Breastplate·  Judgement Crown·  Judgement Gauntlets·  Judgement Legplates·  Judgement Sabatons·  Judgement Spaulders·",
	},
	["16435:0:0:0"] = {
		["i"] = "Knight-Captain's Lamellar Leggings",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Lamellar Leggings·Binds when picked up·Unique·Legs·Plate·575 Armor·+7 Strength·+13 Stamina·Classes: Paladin·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike by 2%.· \
·Lieutenant Commander's Aegis (6)·  Knight-Lieutenant's Lamellar Gauntlets·  Knight-Lieutenant's Lamellar Sabatons·  Knight-Captain's Lamellar Breastplate·  Knight-Captain's Lamellar Leggings·  Lieutenant Commander's Lamellar Headguard·  Lieutenant Commander's Lamellar Shoulders·",
	},
	["16409:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Lamellar Sabatons",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Lamellar Sabatons·Binds when picked up·Unique·Feet·Plate·452 Armor·+15 Strength·+6 Agility·+16 Stamina·+7 Intellect·Classes: Paladin·Requires Level 58·Requires Knight-Lieutenant· \
·Lieutenant Commander's Aegis (6)·  Knight-Lieutenant's Lamellar Gauntlets·  Knight-Lieutenant's Lamellar Sabatons·  Knight-Captain's Lamellar Breastplate·  Knight-Captain's Lamellar Leggings·  Lieutenant Commander's Lamellar Headguard·  Lieutenant Commander's Lamellar Shoulders·",
	},
	["16433:0:0:0"] = {
		["i"] = "Knight-Captain's Lamellar Breastplate",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Lamellar Breastplate·Binds when picked up·Unique·Chest·Plate·657 Armor·+9 Strength·+8 Agility·+25 Stamina·Classes: Paladin·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike by 1%.· \
·Lieutenant Commander's Aegis (6)·  Knight-Lieutenant's Lamellar Gauntlets·  Knight-Lieutenant's Lamellar Sabatons·  Knight-Captain's Lamellar Breastplate·  Knight-Captain's Lamellar Leggings·  Lieutenant Commander's Lamellar Headguard·  Lieutenant Commander's Lamellar Shoulders·",
	},
	["16410:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Lamellar Gauntlets",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Lamellar Gauntlets·Binds when picked up·Unique·Hands·Plate·410 Armor·+15 Strength·+16 Stamina·Classes: Paladin·Requires Level 58·Requires Knight-Lieutenant·Equip: Increases the Holy damage bonus of your Judgement of the Crusader by 10.· \
·Lieutenant Commander's Aegis (6)·  Knight-Lieutenant's Lamellar Gauntlets·  Knight-Lieutenant's Lamellar Sabatons·  Knight-Captain's Lamellar Breastplate·  Knight-Captain's Lamellar Leggings·  Lieutenant Commander's Lamellar Headguard·  Lieutenant Commander's Lamellar Shoulders·",
	},
	["16436:0:0:0"] = {
		["i"] = "Lieutenant Commander's Lamellar Shoulders",
		["t"] = "Lieutenant Commander's Lamellar Shoulders·Binds when picked up·Unique·Shoulder·Plate·493 Armor·+12 Strength·+12 Agility·+12 Stamina·+7 Intellect·+5 Spirit·Classes: Paladin·Requires Level 58·Requires Lieutenant Commander· \
·Lieutenant Commander's Aegis (6)·  Knight-Lieutenant's Lamellar Gauntlets·  Knight-Lieutenant's Lamellar Sabatons·  Knight-Captain's Lamellar Breastplate·  Knight-Captain's Lamellar Leggings·  Lieutenant Commander's Lamellar Headguard·  Lieutenant Commander's Lamellar Shoulders·",
		["c"] = "0070dd",
	},
	["16434:0:0:0"] = {
		["i"] = "Lieutenant Commander's Lamellar Headguard",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Lamellar Headguard·Binds when picked up·Unique·Head·Plate·534 Armor·+9 Strength·+8 Agility·+31 Stamina·Classes: Paladin·Requires Level 58·Requires Lieutenant Commander· \
·Lieutenant Commander's Aegis (6)·  Knight-Lieutenant's Lamellar Gauntlets·  Knight-Lieutenant's Lamellar Sabatons·  Knight-Captain's Lamellar Breastplate·  Knight-Captain's Lamellar Leggings·  Lieutenant Commander's Lamellar Headguard·  Lieutenant Commander's Lamellar Shoulders·",
	},
	["16476:0:0:0"] = {
		["i"] = "Field Marshal's Lamellar Pauldrons",
		["t"] = "Field Marshal's Lamellar Pauldrons·Binds when picked up·Unique·Shoulder·Plate·553 Armor·+17 Strength·+11 Agility·+18 Stamina·+10 Intellect·+10 Spirit·Classes: Paladin·Requires Level 60·Requires Field Marshal· \
·Field Marshal's Aegis (6)·  Field Marshal's Lamellar Chestplate·  Field Marshal's Lamellar Faceguard·  Field Marshal's Lamellar Pauldrons·  Marshal's Lamellar Boots·  Marshal's Lamellar Gloves·  Marshal's Lamellar Legplates·",
		["c"] = "a335ee",
	},
	["16474:0:0:0"] = {
		["i"] = "Field Marshal's Lamellar Faceguard",
		["t"] = "Field Marshal's Lamellar Faceguard·Binds when picked up·Unique·Head·Plate·599 Armor·+19 Strength·+11 Agility·+35 Stamina·Classes: Paladin·Requires Level 60·Requires Field Marshal· \
·Field Marshal's Aegis (6)·  Field Marshal's Lamellar Chestplate·  Field Marshal's Lamellar Faceguard·  Field Marshal's Lamellar Pauldrons·  Marshal's Lamellar Boots·  Marshal's Lamellar Gloves·  Marshal's Lamellar Legplates·",
		["c"] = "a335ee",
	},
	["16475:0:0:0"] = {
		["i"] = "Marshal's Lamellar Legplates",
		["c"] = "a335ee",
		["t"] = "Marshal's Lamellar Legplates·Binds when picked up·Unique·Legs·Plate·646 Armor·+15 Strength·+19 Stamina·Classes: Paladin·Requires Level 60·Requires Marshal·Equip: Improves your chance to hit by 1%.·Equip: Improves your chance to get a critical strike by 2%.· \
·Field Marshal's Aegis (6)·  Field Marshal's Lamellar Chestplate·  Field Marshal's Lamellar Faceguard·  Field Marshal's Lamellar Pauldrons·  Marshal's Lamellar Boots·  Marshal's Lamellar Gloves·  Marshal's Lamellar Legplates·",
	},
	["16472:0:0:0"] = {
		["i"] = "Marshal's Lamellar Boots",
		["c"] = "a335ee",
		["t"] = "Marshal's Lamellar Boots·Binds when picked up·Unique·Feet·Plate·507 Armor·+15 Strength·+7 Agility·+26 Stamina·+8 Intellect·Classes: Paladin·Requires Level 60·Requires Marshal· \
·Field Marshal's Aegis (6)·  Field Marshal's Lamellar Chestplate·  Field Marshal's Lamellar Faceguard·  Field Marshal's Lamellar Pauldrons·  Marshal's Lamellar Boots·  Marshal's Lamellar Gloves·  Marshal's Lamellar Legplates·",
	},
	["16473:0:0:0"] = {
		["i"] = "Field Marshal's Lamellar Chestplate",
		["t"] = "Field Marshal's Lamellar Chestplate·Binds when picked up·Unique·Chest·Plate·738 Armor·+14 Strength·+13 Agility·+35 Stamina·Classes: Paladin·Requires Level 60·Requires Field Marshal·Equip: Improves your chance to get a critical strike by 1%.· \
·Field Marshal's Aegis (6)·  Field Marshal's Lamellar Chestplate·  Field Marshal's Lamellar Faceguard·  Field Marshal's Lamellar Pauldrons·  Marshal's Lamellar Boots·  Marshal's Lamellar Gloves·  Marshal's Lamellar Legplates·",
		["c"] = "a335ee",
	},
	["16471:0:0:0"] = {
		["i"] = "Marshal's Lamellar Gloves",
		["c"] = "a335ee",
		["t"] = "Marshal's Lamellar Gloves·Binds when picked up·Unique·Hands·Plate·461 Armor·+20 Strength·+13 Agility·+16 Stamina·Classes: Paladin·Requires Level 60·Requires Marshal·Equip: Increases the Holy damage bonus of your Judgement of the Crusader by 10.· \
·Field Marshal's Aegis (6)·  Field Marshal's Lamellar Chestplate·  Field Marshal's Lamellar Faceguard·  Field Marshal's Lamellar Pauldrons·  Marshal's Lamellar Boots·  Marshal's Lamellar Gloves·  Marshal's Lamellar Legplates·",
	},
	["19827:0:0:0"] = {
		["i"] = "Zandalar Freethinker's Armguards",
		["c"] = "0070dd",
		["t"] = "Zandalar Freethinker's Armguards·Binds when picked up·Wrist·Plate·309 Armor·+11 Strength·+5 Agility·+12 Stamina·+9 Intellect·Classes: Paladin· \
·Freethinker's Armor (5)·  Gri'lek's Charm of Valor·  Hero's Brand·  Zandalar Freethinker's Armguards·  Zandalar Freethinker's Belt·  Zandalar Freethinker's Breastplate·",
	},
	["19826:0:0:0"] = {
		["i"] = "Zandalar Freethinker's Belt",
		["c"] = "0070dd",
		["t"] = "Zandalar Freethinker's Belt·Binds when picked up·Waist·Plate·397 Armor·+13 Strength·+8 Agility·+13 Stamina·+9 Intellect·Classes: Paladin·Equip: Increases healing done by spells and effects by up to 22.· \
·Freethinker's Armor (5)·  Gri'lek's Charm of Valor·  Hero's Brand·  Zandalar Freethinker's Armguards·  Zandalar Freethinker's Belt·  Zandalar Freethinker's Breastplate·",
	},
	["19825:0:0:0"] = {
		["i"] = "Zandalar Freethinker's Breastplate",
		["c"] = "a335ee",
		["t"] = "Zandalar Freethinker's Breastplate·Binds when picked up·Chest·Plate·738 Armor·+19 Strength·+26 Stamina·+16 Intellect·+7 Spirit·All Stats +4·Classes: Paladin·Equip: Improves your chance to get a critical strike by 1%.· \
·Freethinker's Armor (5)·  Gri'lek's Charm of Valor·  Hero's Brand·  Zandalar Freethinker's Armguards·  Zandalar Freethinker's Belt·  Zandalar Freethinker's Breastplate·",
	},
	["19588:0:0:0"] = {
		["i"] = "Hero's Brand",
		["c"] = "a335ee",
		["t"] = "Hero's Brand·Binds when picked up·Unique·Neck·+10 Strength·+10 Stamina·+6 Intellect·+9 Spirit·Classes: Paladin·Passive: Increases the duration of Hammer of Justice by 0.5 sec.· \
·Freethinker's Armor (5)·  Gri'lek's Charm of Valor·  Hero's Brand·  Zandalar Freethinker's Armguards·  Zandalar Freethinker's Belt·  Zandalar Freethinker's Breastplate·",
	},
	["19586:0:0:0"] = {
		["i"] = "Heathen's Brand",
		["c"] = "0070dd",
		["t"] = "Heathen's Brand·Binds when picked up·Unique·Neck·+10 Strength·+10 Stamina·+6 Intellect·+9 Spirit·Classes: Paladin·",
	},
	["19585:0:0:0"] = {
		["i"] = "Heathen's Brand",
		["c"] = "0070dd",
		["t"] = "Heathen's Brand·Binds when picked up·Unique·Neck·+8 Strength·+8 Stamina·+6 Intellect·+7 Spirit·Classes: Paladin·",
	},
	["19579:0:0:0"] = {
		["i"] = "Heathen's Brand",
		["c"] = "1eff00",
		["t"] = "Heathen's Brand·Binds when picked up·Unique·Neck·+8 Strength·+8 Stamina·+7 Spirit·Classes: Paladin·",
	},
	["19952:0:0:0"] = {
		["i"] = "Gri'lek's Charm of Valor",
		["c"] = "a335ee",
		["t"] = "Gri'lek's Charm of Valor·Binds when picked up·Unique·Trinket·Classes: Paladin·Use: Increases the critical hit chance of Holy spells by 10% for 15 seconds.· \
·Freethinker's Armor (5)·  Gri'lek's Charm of Valor·  Hero's Brand·  Zandalar Freethinker's Armguards·  Zandalar Freethinker's Belt·  Zandalar Freethinker's Breastplate·",
	},
	["20057:0:0:0"] = {
		["i"] = "Highlander's Plate Spaulders",
		["t"] = "Highlander's Plate Spaulders·Binds when picked up·Unique·Shoulder·Plate·553 Armor·+18 Strength·+17 Agility·+20 Stamina·Classes: Warrior, Paladin·Requires Level 60·Requires The League of Arathor - Exalted· \
·The Highlander's Resolution (3)·  Highlander's Plate Girdle·  Highlander's Plate Greaves·  Highlander's Plate Spaulders·",
		["c"] = "a335ee",
	},
	["20048:0:0:0"] = {
		["i"] = "Highlander's Plate Greaves",
		["c"] = "0070dd",
		["t"] = "Highlander's Plate Greaves·Binds when picked up·Unique·Feet·Plate·452 Armor·+14 Strength·+12 Agility·+12 Stamina·Classes: Warrior, Paladin·Requires Level 58·Requires The League of Arathor - Revered·Equip: Run speed increased slightly.· \
·The Highlander's Resolution (3)·  Highlander's Plate Girdle·  Highlander's Plate Greaves·  Highlander's Plate Spaulders·",
	},
	["20041:0:0:0"] = {
		["i"] = "Highlander's Plate Girdle",
		["t"] = "Highlander's Plate Girdle·Binds when picked up·Unique·Waist·Plate·369 Armor·+17 Strength·+10 Stamina·Classes: Warrior, Paladin·Requires Level 58·Requires The League of Arathor - Honored·Equip: Improves your chance to get a critical strike by 1%.· \
·The Highlander's Resolution (3)·  Highlander's Plate Girdle·  Highlander's Plate Greaves·  Highlander's Plate Spaulders·",
		["c"] = "0070dd",
	},
	["20042:0:0:0"] = {
		["i"] = "Highlander's Lamellar Girdle",
		["c"] = "0070dd",
		["t"] = "Highlander's Lamellar Girdle·Binds when picked up·Unique·Waist·Plate·369 Armor·+15 Strength·+6 Stamina·+10 Intellect·Classes: Paladin·Requires Level 58·Requires The League of Arathor - Honored·Equip: Improves your chance to get a critical strike by 1%.· \
·The Highlander's Resolve (3)·  Highlander's Lamellar Girdle·  Highlander's Lamellar Greaves·  Highlander's Lamellar Spaulders·",
	},
	["20049:0:0:0"] = {
		["i"] = "Highlander's Lamellar Greaves",
		["c"] = "0070dd",
		["t"] = "Highlander's Lamellar Greaves·Binds when picked up·Unique·Feet·Plate·452 Armor·+14 Strength·+12 Agility·+8 Stamina·+8 Intellect·Classes: Paladin·Requires Level 58·Requires The League of Arathor - Revered·Equip: Run speed increased slightly.· \
·The Highlander's Resolve (3)·  Highlander's Lamellar Girdle·  Highlander's Lamellar Greaves·  Highlander's Lamellar Spaulders·",
	},
	["20058:0:0:0"] = {
		["i"] = "Highlander's Lamellar Spaulders",
		["c"] = "a335ee",
		["t"] = "Highlander's Lamellar Spaulders·Binds when picked up·Unique·Shoulder·Plate·553 Armor·+18 Strength·+17 Agility·+15 Stamina·+10 Intellect·Classes: Paladin·Requires Level 60·Requires The League of Arathor - Exalted· \
·The Highlander's Resolve (3)·  Highlander's Lamellar Girdle·  Highlander's Lamellar Greaves·  Highlander's Lamellar Spaulders·",
	},
	["16677:0:0:0"] = {
		["i"] = "Beaststalker's Cap",
		["c"] = "0070dd",
		["t"] = "Beaststalker's Cap·Binds when picked up·Head·Mail·297 Armor·+20 Agility·+20 Stamina·+10 Intellect·+6 Spirit·Requires Level 57· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
	},
	["16679:0:0:0"] = {
		["i"] = "Beaststalker's Mantle",
		["c"] = "0070dd",
		["t"] = "Beaststalker's Mantle·Binds when picked up·Shoulder·Mail·266 Armor·+11 Agility·+17 Stamina·+7 Intellect·+4 Spirit·Requires Level 55· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
	},
	["16680:0:0:0"] = {
		["i"] = "Beaststalker's Belt",
		["c"] = "0070dd",
		["t"] = "Beaststalker's Belt·Binds when equipped·Waist·Mail·193 Armor·+9 Strength·+10 Agility·+6 Stamina·+9 Intellect·+11 Spirit·Requires Level 53· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
	},
	["16675:0:0:0"] = {
		["i"] = "Beaststalker's Boots",
		["c"] = "0070dd",
		["t"] = "Beaststalker's Boots·Binds when picked up·Feet·Mail·240 Armor·+21 Agility·+9 Stamina·Requires Level 54· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
	},
	["16678:0:0:0"] = {
		["i"] = "Beaststalker's Pants",
		["t"] = "Beaststalker's Pants·Binds when picked up·Legs·Mail·315 Armor·+6 Strength·+26 Agility·+6 Stamina·+12 Spirit·Requires Level 56· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
		["c"] = "0070dd",
	},
	["16681:0:0:0"] = {
		["i"] = "Beaststalker's Bindings",
		["c"] = "0070dd",
		["t"] = "Beaststalker's Bindings·Binds when equipped·Wrist·Mail·148 Armor·+15 Agility·+7 Stamina·Requires Level 52· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
	},
	["16674:0:0:0"] = {
		["i"] = "Beaststalker's Tunic",
		["c"] = "0070dd",
		["t"] = "Beaststalker's Tunic·Binds when picked up·Chest·Mail·370 Armor·+5 Strength·+21 Agility·+16 Stamina·+13 Intellect·+6 Spirit·Requires Level 58· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
	},
	["16676:0:0:0"] = {
		["i"] = "Beaststalker's Gloves",
		["c"] = "0070dd",
		["t"] = "Beaststalker's Gloves·Binds when picked up·Hands·Mail·218 Armor·+14 Agility·+9 Stamina·+9 Intellect·+10 Spirit·Requires Level 54· \
·Beaststalker Armor (8)·  Beaststalker's Belt·  Beaststalker's Boots·  Beaststalker's Bindings·  Beaststalker's Cap·  Beaststalker's Tunic·  Beaststalker's Pants·  Beaststalker's Mantle·  Beaststalker's Gloves·",
	},
	["16847:0:0:0"] = {
		["i"] = "Giantstalker's Leggings",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Leggings·Binds when picked up·Legs·Mail·369 Armor·+32 Agility·+15 Stamina·+6 Intellect·+8 Spirit·+10 Shadow Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16848:0:0:0"] = {
		["i"] = "Giantstalker's Epaulets",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Epaulets·Binds when picked up·Shoulder·Mail·317 Armor·+24 Agility·+14 Stamina·+5 Intellect·+9 Spirit·+7 Shadow Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16849:0:0:0"] = {
		["i"] = "Giantstalker's Boots",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Boots·Binds when picked up·Feet·Mail·290 Armor·+28 Agility·+14 Stamina·+6 Spirit·+7 Shadow Resistance·Classes: Hunter·Requires Level 60· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16845:0:0:0"] = {
		["i"] = "Giantstalker's Breastplate",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Breastplate·Binds when picked up·Chest·Mail·422 Armor·+26 Agility·+23 Stamina·+11 Intellect·+10 Fire Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16852:0:0:0"] = {
		["i"] = "Giantstalker's Gloves",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Gloves·Binds when picked up·Hands·Mail·264 Armor·+18 Agility·+12 Stamina·+7 Fire Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to hit by 2%.· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16851:0:0:0"] = {
		["i"] = "Giantstalker's Belt",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Belt·Binds when equipped·Waist·Mail·237 Armor·+18 Agility·+16 Stamina·+9 Intellect·+4 Spirit·+7 Fire Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16846:0:0:0"] = {
		["i"] = "Giantstalker's Helmet",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Helmet·Binds when picked up·Head·Mail·343 Armor·+23 Agility·+23 Stamina·+15 Intellect·+8 Spirit·+10 Fire Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16850:0:0:0"] = {
		["i"] = "Giantstalker's Bracers",
		["c"] = "a335ee",
		["t"] = "Giantstalker's Bracers·Binds when equipped·Wrist·Mail·185 Armor·+20 Agility·+11 Stamina·+6 Intellect·+5 Spirit·Classes: Hunter·Requires Level 60· \
·Giantstalker Armor (8)·  Giantstalker's Belt·  Giantstalker's Boots·  Giantstalker's Bracers·  Giantstalker's Breastplate·  Giantstalker's Epaulets·  Giantstalker's Gloves·  Giantstalker's Helmet·  Giantstalker's Leggings·",
	},
	["16935:0:0:0"] = {
		["i"] = "Dragonstalker's Bracers",
		["c"] = "a335ee",
		["t"] = "Dragonstalker's Bracers·Binds when picked up·Wrist·Mail·211 Armor·+23 Agility·+13 Stamina·+6 Intellect·+6 Spirit·Classes: Hunter·Requires Level 60· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
	},
	["16939:0:0:0"] = {
		["i"] = "Dragonstalker's Helm",
		["c"] = "a335ee",
		["t"] = "Dragonstalker's Helm·Binds when picked up·Head·Mail·392 Armor·+27 Agility·+26 Stamina·+16 Intellect·+8 Spirit·+10 Frost Resistance·+10 Shadow Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
	},
	["16940:0:0:0"] = {
		["i"] = "Dragonstalker's Gauntlets",
		["t"] = "Dragonstalker's Gauntlets·Binds when picked up·Hands·Mail·301 Armor·+20 Agility·+17 Stamina·+13 Intellect·+6 Spirit·+10 Shadow Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
		["c"] = "a335ee",
	},
	["16936:0:0:0"] = {
		["i"] = "Dragonstalker's Belt",
		["c"] = "a335ee",
		["t"] = "Dragonstalker's Belt·Binds when picked up·Waist·Mail·271 Armor·+20 Agility·+15 Stamina·+13 Intellect·+11 Spirit·+10 Shadow Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
	},
	["16941:0:0:0"] = {
		["i"] = "Dragonstalker's Greaves",
		["c"] = "a335ee",
		["t"] = "Dragonstalker's Greaves·Binds when picked up·Feet·Mail·332 Armor·+30 Agility·+15 Stamina·+6 Intellect·+6 Spirit·+10 Fire Resistance·Classes: Hunter·Requires Level 60· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
	},
	["16942:0:0:0"] = {
		["i"] = "Dragonstalker's Breastplate",
		["t"] = "Dragonstalker's Breastplate·Binds when picked up·Chest·Mail·482 Armor·+34 Agility·+17 Stamina·+14 Intellect·+6 Spirit·+10 Fire Resistance·+10 Nature Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
		["c"] = "a335ee",
	},
	["16937:0:0:0"] = {
		["i"] = "Dragonstalker's Spaulders",
		["t"] = "Dragonstalker's Spaulders·Binds when picked up·Shoulder·Mail·362 Armor·+23 Agility·+15 Stamina·+13 Intellect·+6 Spirit·+10 Fire Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
		["c"] = "a335ee",
	},
	["16938:0:0:0"] = {
		["i"] = "Dragonstalker's Legguards",
		["c"] = "a335ee",
		["t"] = "Dragonstalker's Legguards·Binds when picked up·Legs·Mail·422 Armor·+31 Agility·+16 Stamina·+15 Intellect·+8 Spirit·+10 Arcane Resistance·+10 Fire Resistance·Classes: Hunter·Requires Level 60·Equip: Improves your chance to hit by 1%.·Equip: Improves your chance to get a critical strike by 1%.· \
·Dragonstalker Armor (8)·  Dragonstalker's Belt·  Dragonstalker's Bracers·  Dragonstalker's Breastplate·  Dragonstalker's Gauntlets·  Dragonstalker's Greaves·  Dragonstalker's Helm·  Dragonstalker's Legguards·  Dragonstalker's Spaulders·",
	},
	["16401:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Chain Boots",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Chain Boots·Binds when picked up·Unique·Feet·Mail·255 Armor·+10 Agility·+17 Stamina·Classes: Hunter·Requires Level 58·Requires Knight-Lieutenant·Equip: Increases your chance to dodge an attack by 1%.· \
·Lieutenant Commander's Pursuit (6)·  Knight-Captain's Chain Hauberk·  Knight-Captain's Chain Leggings·  Knight-Lieutenant's Chain Boots·  Knight-Lieutenant's Chain Gauntlets·  Lieutenant Commander's Chain Helmet·  Lieutenant Commander's Chain Pauldrons·",
	},
	["16403:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Chain Gauntlets",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Chain Gauntlets·Binds when picked up·Unique·Hands·Mail·231 Armor·+11 Agility·+18 Stamina·Classes: Hunter·Requires Level 58·Requires Knight-Lieutenant·Equip: Reduces the mana cost of your Arcane Shot by 15.· \
·Lieutenant Commander's Pursuit (6)·  Knight-Captain's Chain Hauberk·  Knight-Captain's Chain Leggings·  Knight-Lieutenant's Chain Boots·  Knight-Lieutenant's Chain Gauntlets·  Lieutenant Commander's Chain Helmet·  Lieutenant Commander's Chain Pauldrons·",
	},
	["16425:0:0:0"] = {
		["i"] = "Knight-Captain's Chain Hauberk",
		["t"] = "Knight-Captain's Chain Hauberk·Binds when picked up·Unique·Chest·Mail·370 Armor·+16 Agility·+18 Stamina·Classes: Hunter·Requires Level 58·Requires Knight-Captain·Equip: +26 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·Lieutenant Commander's Pursuit (6)·",
		["c"] = "0070dd",
	},
	["16426:0:0:0"] = {
		["i"] = "Knight-Captain's Chain Leggings",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Chain Leggings·Binds when picked up·Unique·Legs·Mail·324 Armor·+18 Agility·+17 Stamina·Classes: Hunter·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases your chance to dodge an attack by 1%.· \
·Lieutenant Commander's Pursuit (6)·  Knight-Captain's Chain Hauberk·  Knight-Captain's Chain Leggings·  Knight-Lieutenant's Chain Boots·  Knight-Lieutenant's Chain Gauntlets·  Lieutenant Commander's Chain Helmet·  Lieutenant Commander's Chain Pauldrons·",
	},
	["16428:0:0:0"] = {
		["i"] = "Lieutenant Commander's Chain Helmet",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Chain Helmet·Binds when picked up·Unique·Head·Mail·301 Armor·+15 Agility·+24 Stamina·+10 Intellect·Classes: Hunter·Requires Level 58·Requires Champion·Equip: +12 Attack Power.· \
·Lieutenant Commander's Pursuit (6)·  Knight-Captain's Chain Hauberk·  Knight-Captain's Chain Leggings·  Knight-Lieutenant's Chain Boots·  Knight-Lieutenant's Chain Gauntlets·  Lieutenant Commander's Chain Helmet·  Lieutenant Commander's Chain Pauldrons·",
	},
	["16427:0:0:0"] = {
		["i"] = "Lieutenant Commander's Chain Pauldrons",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Chain Pauldrons·Binds when picked up·Unique·Shoulder·Mail·278 Armor·+10 Agility·+20 Stamina·Classes: Hunter·Requires Level 58·Requires Lieutenant Commander·Equip: +12 Attack Power.· \
·Lieutenant Commander's Pursuit (6)·  Knight-Captain's Chain Hauberk·  Knight-Captain's Chain Leggings·  Knight-Lieutenant's Chain Boots·  Knight-Lieutenant's Chain Gauntlets·  Lieutenant Commander's Chain Helmet·  Lieutenant Commander's Chain Pauldrons·",
	},
	["16525:0:0:0"] = {
		["i"] = "Legionnaire's Chain Breastplate",
		["t"] = "Legionnaire's Chain Breastplate·Binds when picked up·Unique·Chest·Mail·370 Armor·+16 Agility·+18 Stamina·Classes: Hunter·Requires Level 58·Requires Legionnaire·Equip: +26 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·Champion's Pursuit (6)·  Blood Guard's Chain Boots·  Blood Guard's Chain Gauntlets·  Legionnaire's Chain Breastplate·  Legionnaire's Chain Leggings·  Champion's Chain Headguard·  Champion's Chain Pauldrons·",
		["c"] = "0070dd",
	},
	["16526:0:0:0"] = {
		["i"] = "Champion's Chain Headguard",
		["t"] = "Champion's Chain Headguard·Binds when picked up·Unique·Head·Mail·301 Armor·+15 Agility·+24 Stamina·+10 Intellect·Classes: Hunter·Requires Level 58·Requires Champion·Equip: +12 Attack Power.· \
·Champion's Pursuit (6)·  Blood Guard's Chain Boots·  Blood Guard's Chain Gauntlets·  Legionnaire's Chain Breastplate·  Legionnaire's Chain Leggings·  Champion's Chain Headguard·  Champion's Chain Pauldrons·",
		["c"] = "0070dd",
	},
	["16531:0:0:0"] = {
		["i"] = "Blood Guard's Chain Boots",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Chain Boots·Binds when picked up·Unique·Feet·Mail·255 Armor·+10 Agility·+17 Stamina·Classes: Hunter·Requires Level 58·Requires Blood Guard·Equip: Increases your chance to dodge an attack by 1%.· \
·Champion's Pursuit (6)·  Blood Guard's Chain Boots·  Blood Guard's Chain Gauntlets·  Legionnaire's Chain Breastplate·  Legionnaire's Chain Leggings·  Champion's Chain Headguard·  Champion's Chain Pauldrons·",
	},
	["16530:0:0:0"] = {
		["i"] = "Blood Guard's Chain Gauntlets",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Chain Gauntlets·Binds when picked up·Unique·Hands·Mail·231 Armor·+11 Agility·+18 Stamina·Classes: Hunter·Requires Level 58·Requires Blood Guard·Equip: Reduces the mana cost of your Arcane Shot by 15.· \
·Champion's Pursuit (6)·  Blood Guard's Chain Boots·  Blood Guard's Chain Gauntlets·  Legionnaire's Chain Breastplate·  Legionnaire's Chain Leggings·  Champion's Chain Headguard·  Champion's Chain Pauldrons·",
	},
	["16528:0:0:0"] = {
		["i"] = "Champion's Chain Pauldrons",
		["t"] = "Champion's Chain Pauldrons·Binds when picked up·Unique·Shoulder·Mail·278 Armor·+10 Agility·+20 Stamina·Classes: Hunter·Requires Level 58·Requires Lieutenant Commander·Equip: +12 Attack Power.· \
·Champion's Pursuit (6)·",
		["c"] = "0070dd",
	},
	["16527:0:0:0"] = {
		["i"] = "Legionnaire's Chain Leggings",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Chain Leggings·Binds when picked up·Unique·Legs·Mail·324 Armor·+18 Agility·+17 Stamina·Classes: Hunter·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases your chance to dodge an attack by 1%.· \
·Champion's Pursuit (6)·  Blood Guard's Chain Boots·  Blood Guard's Chain Gauntlets·  Legionnaire's Chain Breastplate·  Legionnaire's Chain Leggings·  Champion's Chain Headguard·  Champion's Chain Pauldrons·",
	},
	["16463:0:0:0"] = {
		["i"] = "Marshal's Chain Grips",
		["c"] = "a335ee",
		["t"] = "Marshal's Chain Grips·Binds when picked up·Unique·Hands·Mail·260 Armor·+17 Agility·+18 Stamina·+16 Intellect·Classes: Hunter·Requires Level 60·Requires Marshal·Equip: Reduces the mana cost of your Arcane Shot by 15.· \
·Field Marshal's Pursuit (6)·  Field Marshal's Chain Breastplate·  Field Marshal's Chain Helm·  Field Marshal's Chain Spaulders·  Marshal's Chain Boots·  Marshal's Chain Grips·  Marshal's Chain Legguards·",
	},
	["16465:0:0:0"] = {
		["i"] = "Field Marshal's Chain Helm",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Chain Helm·Binds when picked up·Unique·Head·Mail·338 Armor·+19 Agility·+27 Stamina·+17 Intellect·+10 Spirit·Classes: Hunter·Requires Level 60·Requires Field Marshal·Equip: +20 Attack Power.· \
·Field Marshal's Pursuit (6)·  Field Marshal's Chain Breastplate·  Field Marshal's Chain Helm·  Field Marshal's Chain Spaulders·  Marshal's Chain Boots·  Marshal's Chain Grips·  Marshal's Chain Legguards·",
	},
	["16462:0:0:0"] = {
		["i"] = "Marshal's Chain Boots",
		["c"] = "a335ee",
		["t"] = "Marshal's Chain Boots·Binds when picked up·Unique·Feet·Mail·286 Armor·+14 Agility·+26 Stamina·Classes: Hunter·Requires Level 60·Requires Marshal·Equip: Increases your chance to dodge an attack by 1%.· \
·Field Marshal's Pursuit (6)·  Field Marshal's Chain Breastplate·  Field Marshal's Chain Helm·  Field Marshal's Chain Spaulders·  Marshal's Chain Boots·  Marshal's Chain Grips·  Marshal's Chain Legguards·",
	},
	["16466:0:0:0"] = {
		["i"] = "Field Marshal's Chain Breastplate",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Chain Breastplate·Binds when picked up·Unique·Chest·Mail·416 Armor·+23 Agility·+24 Stamina·Classes: Hunter·Requires Level 60·Requires Field Marshal·Equip: +40 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·Field Marshal's Pursuit (6)·  Field Marshal's Chain Breastplate·  Field Marshal's Chain Helm·  Field Marshal's Chain Spaulders·  Marshal's Chain Boots·  Marshal's Chain Grips·  Marshal's Chain Legguards·",
	},
	["16467:0:0:0"] = {
		["i"] = "Marshal's Chain Legguards",
		["c"] = "a335ee",
		["t"] = "Marshal's Chain Legguards·Binds when picked up·Unique·Legs·Mail·364 Armor·+23 Agility·+22 Stamina·Classes: Hunter·Requires Level 60·Requires Marshal·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases your chance to dodge an attack by 1%.·Equip: Improves your chance to hit by 1%.· \
·Field Marshal's Pursuit (6)·  Field Marshal's Chain Breastplate·  Field Marshal's Chain Helm·  Field Marshal's Chain Spaulders·  Marshal's Chain Boots·  Marshal's Chain Grips·  Marshal's Chain Legguards·",
	},
	["16468:0:0:0"] = {
		["i"] = "Field Marshal's Chain Spaulders",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Chain Spaulders·Binds when picked up·Unique·Shoulder·Mail·312 Armor·+15 Agility·+26 Stamina·Classes: Hunter·Requires Level 60·Requires Field Marshal·Equip: +22 Attack Power.· \
·Field Marshal's Pursuit (6)·  Field Marshal's Chain Breastplate·  Field Marshal's Chain Helm·  Field Marshal's Chain Spaulders·  Marshal's Chain Boots·  Marshal's Chain Grips·  Marshal's Chain Legguards·",
	},
	["16463:0:0:0"] = {
		["i"] = "Marshal's Chain Grips",
		["c"] = "a335ee",
		["t"] = "Marshal's Chain Grips·Binds when picked up·Unique·Hands·Mail·260 Armor·+17 Agility·+18 Stamina·+16 Intellect·Classes: Hunter·Requires Level 60·Requires Marshal·Equip: Reduces the mana cost of your Arcane Shot by 15.· \
·Field Marshal's Pursuit (6)·  Field Marshal's Chain Breastplate·  Field Marshal's Chain Helm·  Field Marshal's Chain Spaulders·  Marshal's Chain Boots·  Marshal's Chain Grips·  Marshal's Chain Legguards·",
	},
	["16567:0:0:0"] = {
		["i"] = "General's Chain Legguards",
		["c"] = "a335ee",
		["t"] = "General's Chain Legguards·Binds when picked up·Unique·Legs·Mail·364 Armor·+23 Agility·+22 Stamina·Classes: Hunter·Requires Level 60·Requires General·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases your chance to dodge an attack by 1%.·Equip: Improves your chance to hit by 1%.· \
·Warlord's Marshal's Pursuit (6)·  General's Chain Boots·  General's Chain Gloves·  General's Chain Legguards·  Warlord's Chain Chestpiece·  Warlord's Chain Helmet·  Warlord's Chain Shoulders·",
	},
	["16569:0:0:0"] = {
		["i"] = "General's Chain Boots",
		["t"] = "General's Chain Boots·Binds when picked up·Unique·Feet·Mail·286 Armor·+14 Agility·+26 Stamina·Classes: Hunter·Requires Level 60·Requires General·Equip: Increases your chance to dodge an attack by 1%.· \
·Warlord's Marshal's Pursuit (6)·  General's Chain Boots·  General's Chain Gloves·  General's Chain Legguards·  Warlord's Chain Chestpiece·  Warlord's Chain Helmet·  Warlord's Chain Shoulders·",
		["c"] = "a335ee",
	},
	["16571:0:0:0"] = {
		["i"] = "General's Chain Gloves",
		["c"] = "a335ee",
		["t"] = "General's Chain Gloves·Binds when picked up·Unique·Hands·Mail·260 Armor·+17 Agility·+18 Stamina·+16 Intellect·Classes: Hunter·Requires Level 60·Requires General·Equip: Reduces the mana cost of your Arcane Shot by 15.· \
·Warlord's Marshal's Pursuit (6)·  General's Chain Boots·  General's Chain Gloves·  General's Chain Legguards·  Warlord's Chain Chestpiece·  Warlord's Chain Helmet·  Warlord's Chain Shoulders·",
	},
	["16566:0:0:0"] = {
		["i"] = "Warlord's Chain Helmet",
		["t"] = "Warlord's Chain Helmet·Binds when picked up·Unique·Head·Mail·338 Armor·+19 Agility·+27 Stamina·+17 Intellect·+10 Spirit·Classes: Hunter·Requires Level 60·Requires Warlord·Equip: +20 Attack Power.· \
·Warlord's Marshal's Pursuit (6)·  General's Chain Boots·  General's Chain Gloves·  General's Chain Legguards·  Warlord's Chain Chestpiece·  Warlord's Chain Helmet·  Warlord's Chain Shoulders·",
		["c"] = "a335ee",
	},
	["16568:0:0:0"] = {
		["i"] = "Warlord's Chain Shoulders",
		["t"] = "Warlord's Chain Shoulders·Binds when picked up·Unique·Shoulder·Mail·312 Armor·+15 Agility·+26 Stamina·Classes: Hunter·Requires Level 60·Requires Warlord·Equip: +22 Attack Power.· \
·Warlord's Marshal's Pursuit (6)·  General's Chain Boots·  General's Chain Gloves·  General's Chain Legguards·  Warlord's Chain Chestpiece·  Warlord's Chain Helmet·  Warlord's Chain Shoulders·",
		["c"] = "a335ee",
	},
	["16565:0:0:0"] = {
		["i"] = "Warlord's Chain Chestpiece",
		["t"] = "Warlord's Chain Chestpiece·Binds when picked up·Unique·Chest·Mail·416 Armor·+23 Agility·+24 Stamina·Classes: Hunter·Requires Level 60·Requires Warlord·Equip: +40 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·Warlord's Marshal's Pursuit (6)·  General's Chain Boots·  General's Chain Gloves·  General's Chain Legguards·  Warlord's Chain Chestpiece·  Warlord's Chain Helmet·  Warlord's Chain Shoulders·",
		["c"] = "a335ee",
	},
	["19831:0:0:0"] = {
		["i"] = "Zandalar Predator's Mantle",
		["c"] = "a335ee",
		["t"] = "Zandalar Predator's Mantle·Binds when picked up·Shoulder·Mail·326 Armor·+22 Agility·+15 Stamina·+11 Intellect·Classes: Hunter·Equip: Increases damage done by Arcane spells and effects by up to 16.· \
·Predator's Armor (5)·  Maelstrom's Wrath·  Renataki's Charm of Beasts·  Zandalar Predator's Bracers·  Zandalar Predator's Belt·  Zandalar Predator's Mantle·",
	},
	["19832:0:0:0"] = {
		["i"] = "Zandalar Predator's Belt",
		["c"] = "0070dd",
		["t"] = "Zandalar Predator's Belt·Binds when picked up·Waist·Mail·224 Armor·+18 Agility·+12 Stamina·+12 Intellect·+7 Spirit·Classes: Hunter·Equip: Increases damage done by Arcane spells and effects by up to 11.· \
·Predator's Armor (5)·  Maelstrom's Wrath·  Renataki's Charm of Beasts·  Zandalar Predator's Bracers·  Zandalar Predator's Belt·  Zandalar Predator's Mantle·",
	},
	["19833:0:0:0"] = {
		["i"] = "Zandalar Predator's Bracers",
		["c"] = "0070dd",
		["t"] = "Zandalar Predator's Bracers·Binds when picked up·Wrist·Mail·174 Armor·+10 Stamina·+7 Intellect·+6 Spirit·Classes: Hunter·Equip: Increases damage done by Arcane spells and effects by up to 14.·Equip: +22 ranged Attack Power.· \
·Predator's Armor (5)·  Maelstrom's Wrath·  Renataki's Charm of Beasts·  Zandalar Predator's Bracers·  Zandalar Predator's Belt·  Zandalar Predator's Mantle·",
	},
	["19621:0:0:0"] = {
		["i"] = "Maelstrom's Wrath",
		["c"] = "a335ee",
		["t"] = "Pristine Enchanted South Seas Kelp·Binds when picked up·Unique·Neck·+10 Strength·+10 Stamina·+6 Intellect·+9 Spirit·Classes: Hunter·Passive: Increases the duration of Hammer of Justice by 0.5 sec.· \
·Predator's Armor (5)·  Maelstrom's Wrath·  Renataki's Charm of Beasts·  Zandalar Predator's Bracers·  Zandalar Predator's Belt·  Zandalar Predator's Mantle·",
	},
	["19620:0:0:0"] = {
		["i"] = "Maelstrom's Tendril",
		["c"] = "0070dd",
		["t"] = "Maelstrom's Tendril·Binds when picked up·Unique·Neck·+15 Agility·+9 Stamina·+6 Intellect·Classes: Hunter·",
	},
	["19619:0:0:0"] = {
		["i"] = "Maelstrom's Tendril",
		["c"] = "0070dd",
		["t"] = "Maelstrom's Tendril·Binds when picked up·Unique·Neck·+12 Agility·+7 Stamina·+6 Intellect·Classes: Hunter·",
	},
	["19618:0:0:0"] = {
		["i"] = "Maelstrom's Tendril",
		["c"] = "1eff00",
		["t"] = "Maelstrom's Tendril·Binds when picked up·Unique·Neck·+12 Agility·+7 Stamina·Classes: Hunter·",
	},
	["19953:0:0:0"] = {
		["i"] = "Renataki's Charm of Beasts",
		["c"] = "a335ee",
		["t"] = "Renataki's Charm of Beasts·Binds when picked up·Unique·Trinket·Classes: Hunter·Use: Instantly clears the cooldowns of Aimed Shot, Multishot, Volley, and Arcane Shot.· \
·Predator's Armor (5)·  Maelstrom's Wrath·  Renataki's Charm of Beasts·  Zandalar Predator's Bracers·  Zandalar Predator's Belt·  Zandalar Predator's Mantle·",
	},
	["20050:0:0:0"] = {
		["i"] = "Highlander's Chain Greaves",
		["t"] = "Highlander's Chain Greaves·Binds when picked up·Unique·Feet·Mail·255 Armor·+15 Agility·+16 Stamina·+8 Intellect·Classes: Hunter·Requires Level 58·Requires The League of Arathor - Revered·Equip: Run speed increased slightly.· \
·The Highlander's Determination (3)·  Highlander's Chain Girdle·  Highlander's Chain Greaves·  Highlander's Chain Pauldrons·",
		["c"] = "0070dd",
	},
	["20043:0:0:0"] = {
		["i"] = "Highlander's Chain Girdle",
		["c"] = "0070dd",
		["t"] = "Highlander's Chain Girdle·Binds when picked up·Unique·Waist·Mail·208 Armor·+10 Stamina·Classes: Hunter·Requires Level 58·Requires The League of Arathor - Honored·Equip: Improves your chance to get a critical strike by 1%.·Equip: +34 Attack Power.· \
·The Highlander's Determination (3)·",
	},
	["20055:0:0:0"] = {
		["i"] = "Highlander's Chain Pauldrons",
		["t"] = "Highlander's Chain Pauldrons·Binds when picked up·Unique·Shoulder·Mail·312 Armor·+20 Agility·+18 Stamina·+17 Intellect·Classes: Hunter·Requires Level 60·Requires The League of Arathor - Exalted· \
·The Highlander's Determination (3)·  Highlander's Chain Girdle·  Highlander's Chain Greaves·  Highlander's Chain Pauldrons·",
		["c"] = "a335ee",
	},
	["20150:0:0:0"] = {
		["i"] = "Defiler's Chain Girdle",
		["c"] = "0070dd",
		["t"] = "Defiler's Chain Girdle·Binds when picked up·Unique·Waist·Mail·208 Armor·+10 Stamina·Classes: Hunter, Shaman·Requires Level 58·Requires The Defilers - Honored·Equip: Improves your chance to get a critical strike by 1%.·Equip: +34 Attack Power.· \
·The Defiler's Determination (3)·  Defiler's Chain Pauldrons·  Defiler's Chain Greaves·  Defiler's Chain Girdle·",
	},
	["20154:0:0:0"] = {
		["i"] = "Defiler's Chain Greaves",
		["c"] = "0070dd",
		["t"] = "Defiler's Chain Greaves·Binds when picked up·Unique·Feet·Mail·255 Armor·+15 Agility·+16 Stamina·+8 Intellect·Classes: Hunter, Shaman·Requires Level 58·Requires The Defilers - Revered·Equip: Run speed increased slightly.· \
·The Defiler's Determination (3)·  Defiler's Chain Pauldrons·  Defiler's Chain Greaves·  Defiler's Chain Girdle·",
	},
	["20158:0:0:0"] = {
		["i"] = "Defiler's Chain Pauldrons",
		["t"] = "Defiler's Chain Pauldrons·Binds when picked up·Unique·Shoulder·Mail·312 Armor·+20 Agility·+18 Stamina·+17 Intellect·Classes: Hunter, Shaman·Requires Level 60·Requires The Defilers - Exalted· \
·The Defiler's Determination (3)·  Defiler's Chain Pauldrons·  Defiler's Chain Greaves·  Defiler's Chain Girdle·",
		["c"] = "a335ee",
	},
	["20195:0:0:0"] = {
		["i"] = "Defiler's Mail Girdle",
		["t"] = "Defiler's Mail Girdle·Binds when picked up·Unique·Waist·Mail·208 Armor·+10 Stamina·+17 Intellect·Classes: Hunter, Shaman·Requires Level 58·Requires The Defilers - Honored·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·The Defiler's Fortitude (3)·  Defiler's Mail Girdle·  Defiler's Mail Greaves·  Defiler's Mail Pauldrons·",
		["c"] = "0070dd",
	},
	["20199:0:0:0"] = {
		["i"] = "Defiler's Mail Greaves",
		["c"] = "0070dd",
		["t"] = "Defiler's Mail Greaves·Binds when picked up·Unique·Feet·Mail·255 Armor·+15 Agility·+16 Stamina·+8 Intellect·Classes: Hunter, Shaman·Requires Level 58·Requires The Defilers - Revered·Equip: Run speed increased slightly.· \
·The Defiler's Fortitude (3)·  Defiler's Mail Girdle·  Defiler's Mail Greaves·  Defiler's Mail Pauldrons·",
	},
	["20203:0:0:0"] = {
		["i"] = "Defiler's Mail Pauldrons",
		["c"] = "a335ee",
		["t"] = "Defiler's Mail Pauldrons·Binds when picked up·Unique·Shoulder·Mail·312 Armor·+11 Strength·+10 Agility·+18 Stamina·+17 Intellect·Classes: Hunter, Shaman·Requires Level 60·Requires The Defilers - Exalted·Equip: Restores 4 mana per 5 sec.· \
·The Defiler's Fortitude (3)·  Defiler's Mail Girdle·  Defiler's Mail Greaves·  Defiler's Mail Pauldrons·",
	},
	["16686:0:0:0"] = {
		["i"] = "Magister's Crown",
		["t"] = "Magister's Crown·Binds when picked up·Head·Cloth·71 Armor·+11 Stamina·+30 Intellect·+5 Spirit·Requires Level 57· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
		["c"] = "0070dd",
	},
	["16683:0:0:0"] = {
		["i"] = "Magister's Bindings",
		["t"] = "Magister's Bindings·Binds when equipped·Wrist·Cloth·35 Armor·+4 Stamina·+15 Intellect·+5 Spirit·Requires Level 52· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
		["c"] = "0070dd",
	},
	["16688:0:0:0"] = {
		["i"] = "Magister's Robes",
		["c"] = "0070dd",
		["t"] = "Magister's Robes·Binds when picked up·Chest·Cloth·89 Armor·+9 Stamina·+31 Intellect·+8 Spirit·Requires Level 58· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
	},
	["16687:0:0:0"] = {
		["i"] = "Magister's Leggings",
		["c"] = "0070dd",
		["t"] = "Magister's Leggings·Binds when picked up·Legs·Cloth·76 Armor·+12 Stamina·+20 Intellect·+21 Spirit·Requires Level 56· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
	},
	["16685:0:0:0"] = {
		["i"] = "Magister's Belt",
		["c"] = "0070dd",
		["t"] = "Magister's Belt·Binds when equipped·Waist·Cloth·46 Armor·+6 Stamina·+21 Intellect·+6 Spirit·Requires Level 53· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
	},
	["16689:0:0:0"] = {
		["i"] = "Magister's Mantle",
		["c"] = "0070dd",
		["t"] = "Magister's Mantle·Binds when picked up·Shoulder·Cloth·64 Armor·+6 Stamina·+22 Intellect·+6 Spirit·Requires Level 55· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
	},
	["16682:0:0:0"] = {
		["i"] = "Magister's Boots",
		["c"] = "0070dd",
		["t"] = "Magister's Boots·Binds when picked up·Feet·Cloth·58 Armor·+9 Stamina·+14 Intellect·+14 Spirit·Requires Level 54· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
	},
	["16684:0:0:0"] = {
		["i"] = "Magister's Gloves",
		["c"] = "0070dd",
		["t"] = "Magister's Gloves·Binds when equipped·Hands·Cloth·52 Armor·+9 Stamina·+14 Intellect·+14 Spirit·Requires Level 54· \
·Magister's Regalia (8)·  Magister's Belt·  Magister's Bindings·  Magister's Crown·  Magister's Gloves·  Magister's Leggings·  Magister's Mantle·  Magister's Robes·  Magister's Boots·",
	},
	["16797:0:0:0"] = {
		["i"] = "Arcanist Mantle",
		["c"] = "a335ee",
		["t"] = "Arcanist Mantle·Binds when picked up·Shoulder·Cloth·76 Armor·+10 Stamina·+21 Intellect·+5 Spirit·+7 Shadow Resistance·Classes: Mage·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
	},
	["16802:0:0:0"] = {
		["i"] = "Arcanist Belt",
		["c"] = "a335ee",
		["t"] = "Arcanist Belt·Binds when equipped·Waist·Cloth·57 Armor·+11 Stamina·+20 Intellect·+10 Spirit·+10 Fire Resistance·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
	},
	["16799:0:0:0"] = {
		["i"] = "Arcanist Bindings",
		["c"] = "a335ee",
		["t"] = "Arcanist Bindings·Binds when equipped·Wrist·Cloth·44 Armor·+8 Stamina·+15 Intellect·+6 Spirit·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 12.·Equip: Restores 3 mana per 5 sec.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
	},
	["16801:0:0:0"] = {
		["i"] = "Arcanist Gloves",
		["c"] = "a335ee",
		["t"] = "Arcanist Gloves·Binds when picked up·Hands·Cloth·63 Armor·+14 Stamina·+15 Intellect·+10 Spirit·+7 Fire Resistance·Classes: Mage·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
	},
	["16795:0:0:0"] = {
		["i"] = "Arcanist Crown",
		["c"] = "a335ee",
		["t"] = "Arcanist Crown·Binds when picked up·Head·Cloth·83 Armor·+16 Stamina·+27 Intellect·+10 Spirit·+10 Fire Resistance·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.·Equip: Improves your chance to hit with spells by 1%.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
	},
	["16800:0:0:0"] = {
		["i"] = "Arcanist Boots",
		["t"] = "Arcanist Boots·Binds when picked up·Feet·Cloth·70 Armor·+13 Stamina·+14 Intellect·+11 Spirit·+10 Shadow Resistance·Classes: Mage·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 11.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
		["c"] = "a335ee",
	},
	["16798:0:0:0"] = {
		["i"] = "Arcanist Robes",
		["t"] = "Arcanist Robes·Binds when picked up·Chest·Cloth·102 Armor·+19 Stamina·+25 Intellect·+10 Spirit·+10 Fire Resistance·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 23.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
		["c"] = "a335ee",
	},
	["16796:0:0:0"] = {
		["i"] = "Arcanist Leggings",
		["t"] = "Arcanist Leggings·Binds when picked up·Legs·Cloth·89 Armor·+18 Stamina·+23 Intellect·+10 Spirit·+10 Shadow Resistance·Classes: Mage·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Arcanist Regalia (8)·  Arcanist Belt·  Arcanist Bindings·  Arcanist Crown·  Arcanist Boots·  Arcanist Gloves·  Arcanist Leggings·  Arcanist Mantle·  Arcanist Robes·",
		["c"] = "a335ee",
	},
	["16915:0:0:0"] = {
		["i"] = "Netherwind Pants",
		["c"] = "a335ee",
		["t"] = "Netherwind Pants·Binds when picked up·Legs·Cloth·101 Armor·+16 Stamina·+27 Intellect·+5 Spirit·+10 Arcane Resistance·+10 Fire Resistance·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 30.·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
	},
	["16917:0:0:0"] = {
		["i"] = "Netherwind Mantle",
		["c"] = "a335ee",
		["t"] = "Netherwind Mantle·Binds when picked up·Shoulder·Cloth·87 Armor·+16 Stamina·+13 Intellect·+12 Spirit·+10 Fire Resistance·Classes: Mage·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
	},
	["16916:0:0:0"] = {
		["i"] = "Netherwind Robes",
		["c"] = "a335ee",
		["t"] = "Netherwind Robes·Binds when picked up·Chest·Cloth·116 Armor·+16 Stamina·+26 Intellect·+8 Spirit·+10 Fire Resistance·+10 Nature Resistance·Classes: Mage·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 32.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
	},
	["16912:0:0:0"] = {
		["i"] = "Netherwind Boots",
		["t"] = "Netherwind Boots·Binds when picked up·Feet·Cloth·80 Armor·+13 Stamina·+16 Intellect·+10 Spirit·+10 Fire Resistance·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 27.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
		["c"] = "a335ee",
	},
	["16913:0:0:0"] = {
		["i"] = "Netherwind Gloves",
		["c"] = "a335ee",
		["t"] = "Netherwind Gloves·Binds when picked up·Hands·Cloth·72 Armor·+16 Stamina·+16 Intellect·+6 Spirit·+10 Shadow Resistance·Classes: Mage·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
	},
	["16918:0:0:0"] = {
		["i"] = "Netherwind Bindings",
		["c"] = "a335ee",
		["t"] = "Netherwind Bindings·Binds when picked up·Wrist·Cloth·51 Armor·+9 Stamina·+15 Intellect·+8 Spirit·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 19.·Equip: Restores 4 mana per 5 sec.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
	},
	["16914:0:0:0"] = {
		["i"] = "Netherwind Crown",
		["c"] = "a335ee",
		["t"] = "Netherwind Crown·Binds when picked up·Head·Cloth·94 Armor·+17 Stamina·+26 Intellect·+7 Spirit·+10 Frost Resistance·+10 Shadow Resistance·Classes: Mage·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 32.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
	},
	["16818:0:0:0"] = {
		["i"] = "Netherwind Belt",
		["c"] = "a335ee",
		["t"] = "Netherwind Belt·Binds when picked up·Waist·Cloth·65 Armor·+13 Stamina·+20 Intellect·+13 Spirit·+10 Shadow Resistance·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 23.· \
·Netherwind Regalia (8)·  Netherwind Belt·  Netherwind Bindings·  Netherwind Boots·  Netherwind Crown·  Netherwind Mantle·  Netherwind Gloves·  Netherwind Pants·  Netherwind Robes·",
	},
	["16391:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Silk Gloves",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Silk Gloves·Binds when picked up·Unique·Hands·Cloth·56 Armor·+11 Stamina·Classes: Mage·Requires Level 58·Requires Knight-Lieutenant·Equip: Increases the damage absorbed by your Mana Shield by 285.·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Lieutenant Commander's Regalia (6)·  Knight-Lieutenant's Silk Boots·  Knight-Lieutenant's Silk Gloves·  Knight-Captain's Silk Raiment·  Knight-Captain's Silk Leggings·  Lieutenant Commander's Crown·  Lieutenant Commander's Silk Spaulders·",
	},
	["16414:0:0:0"] = {
		["i"] = "Knight-Captain's Silk Leggings",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Silk Leggings·Binds when picked up·Unique·Legs·Cloth·78 Armor·+16 Stamina·+13 Intellect·+16 Spirit·Classes: Mage·Requires Level 58·Requires Knight-Captain·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Lieutenant Commander's Regalia (6)·  Knight-Lieutenant's Silk Boots·  Knight-Lieutenant's Silk Gloves·  Knight-Captain's Silk Raiment·  Knight-Captain's Silk Leggings·  Lieutenant Commander's Crown·  Lieutenant Commander's Silk Spaulders·",
	},
	["16413:0:0:0"] = {
		["i"] = "Knight-Captain's Silk Raiment",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Silk Raiment·Binds when picked up·Unique·Chest·Cloth·89 Armor·+20 Stamina·+20 Intellect·Classes: Mage·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Lieutenant Commander's Regalia (6)·  Knight-Lieutenant's Silk Boots·  Knight-Lieutenant's Silk Gloves·  Knight-Captain's Silk Raiment·  Knight-Captain's Silk Leggings·  Lieutenant Commander's Crown·  Lieutenant Commander's Silk Spaulders·",
	},
	["16369:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Silk Boots",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Silk Boots·Binds when picked up·Unique·Feet·Cloth·61 Armor·+16 Stamina·+15 Intellect·Classes: Mage·Requires Level 58·Requires Knight-Lieutenant·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Lieutenant Commander's Regalia (6)·  Knight-Lieutenant's Silk Boots·  Knight-Lieutenant's Silk Gloves·  Knight-Captain's Silk Raiment·  Knight-Captain's Silk Leggings·  Lieutenant Commander's Crown·  Lieutenant Commander's Silk Spaulders·",
	},
	["16416:0:0:0"] = {
		["i"] = "Lieutenant Commander's Crown",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Crown·Binds when picked up·Unique·Head·Cloth·73 Armor·+16 Stamina·+16 Intellect·+16 Spirit·Classes: Mage·Requires Level 58·Requires Lieutenant Commander·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Lieutenant Commander's Regalia (6)·  Knight-Lieutenant's Silk Boots·  Knight-Lieutenant's Silk Gloves·  Knight-Captain's Silk Raiment·  Knight-Captain's Silk Leggings·  Lieutenant Commander's Crown·  Lieutenant Commander's Silk Spaulders·",
	},
	["16415:0:0:0"] = {
		["i"] = "Lieutenant Commander's Silk Spaulders",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Silk Spaulders·Binds when picked up·Unique·Shoulder·Cloth·67 Armor·+16 Stamina·+15 Intellect·Classes: Mage·Requires Level 58·Requires Lieutenant Commander·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Lieutenant Commander's Regalia (6)·  Knight-Lieutenant's Silk Boots·  Knight-Lieutenant's Silk Gloves·  Knight-Captain's Silk Raiment·  Knight-Captain's Silk Leggings·  Lieutenant Commander's Crown·  Lieutenant Commander's Silk Spaulders·",
	},
	["16491:0:0:0"] = {
		["i"] = "Legionnaire's Silk Robes",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Silk Robes·Binds when picked up·Unique·Chest·Cloth·89 Armor·+20 Stamina·+20 Intellect·Classes: Mage·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Champion's Regalia (6)·  Blood Guard's Silk Footwraps·  Blood Guard's Silk Gloves·  Legionnaire's Silk Robes·  Legionnaire's Silk Pants·  Champion's Silk Hood·  Champion's Silk Shoulderpads·",
	},
	["16492:0:0:0"] = {
		["i"] = "Champion's Silk Shoulderpads",
		["c"] = "0070dd",
		["t"] = "Champion's Silk Shoulderpads·Binds when picked up·Unique·Shoulder·Cloth·67 Armor·+16 Stamina·+15 Intellect·Classes: Mage·Requires Level 58·Requires Champion·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Champion's Regalia (6)·  Blood Guard's Silk Footwraps·  Blood Guard's Silk Gloves·  Legionnaire's Silk Robes·  Legionnaire's Silk Pants·  Champion's Silk Hood·  Champion's Silk Shoulderpads·",
	},
	["16487:0:0:0"] = {
		["i"] = "Blood Guard's Silk Gloves",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Silk Gloves·Binds when picked up·Unique·Hands·Cloth·56 Armor·+11 Stamina·Classes: Mage·Requires Level 58·Requires Blood Guard·Equip: Increases the damage absorbed by your Mana Shield by 285.·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Champion's Regalia (6)·  Blood Guard's Silk Footwraps·  Blood Guard's Silk Gloves·  Legionnaire's Silk Robes·  Legionnaire's Silk Pants·  Champion's Silk Hood·  Champion's Silk Shoulderpads·",
	},
	["16489:0:0:0"] = {
		["i"] = "Champion's Silk Hood",
		["c"] = "0070dd",
		["t"] = "Champion's Silk Hood·Binds when picked up·Unique·Head·Cloth·73 Armor·+16 Stamina·+16 Intellect·+16 Spirit·Classes: Mage·Requires Level 58·Requires Champion·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Champion's Regalia (6)·  Blood Guard's Silk Footwraps·  Blood Guard's Silk Gloves·  Legionnaire's Silk Robes·  Legionnaire's Silk Pants·  Champion's Silk Hood·  Champion's Silk Shoulderpads·",
	},
	["16490:0:0:0"] = {
		["i"] = "Legionnaire's Silk Pants",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Silk Pants·Binds when picked up·Unique·Legs·Cloth·78 Armor·+16 Stamina·+13 Intellect·+16 Spirit·Classes: Mage·Requires Level 58·Requires Legionnaire·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Champion's Regalia (6)·  Blood Guard's Silk Footwraps·  Blood Guard's Silk Gloves·  Legionnaire's Silk Robes·  Legionnaire's Silk Pants·  Champion's Silk Hood·  Champion's Silk Shoulderpads·",
	},
	["16485:0:0:0"] = {
		["i"] = "Blood Guard's Silk Footwraps",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Silk Footwraps·Binds when picked up·Unique·Feet·Cloth·61 Armor·+16 Stamina·+15 Intellect·Classes: Mage·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Champion's Regalia (6)·  Blood Guard's Silk Footwraps·  Blood Guard's Silk Gloves·  Legionnaire's Silk Robes·  Legionnaire's Silk Pants·  Champion's Silk Hood·  Champion's Silk Shoulderpads·",
	},
	["16441:0:0:0"] = {
		["i"] = "Field Marshal's Coronet",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Coronet·Binds when picked up·Unique·Head·Cloth·81 Armor·+24 Stamina·+24 Intellect·+19 Spirit·Classes: Mage·Requires Level 60·Requires Field Marshal·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Field Marshal's Regalia (6)·  Field Marshal's Coronet·  Field Marshal's Silk Spaulders·  Field Marshal's Silk Vestments·  Marshal's Silk Footwraps·  Marshal's Silk Gloves·  Marshal's Silk Leggings·",
	},
	["16440:0:0:0"] = {
		["i"] = "Marshal's Silk Gloves",
		["c"] = "a335ee",
		["t"] = "Marshal's Silk Gloves·Binds when picked up·Unique·Hands·Cloth·63 Armor·+16 Stamina·Classes: Mage·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 30.·Equip: Increases the damage absorbed by your Mana Shield by 285.· \
·Field Marshal's Regalia (6)·  Field Marshal's Coronet·  Field Marshal's Silk Spaulders·  Field Marshal's Silk Vestments·  Marshal's Silk Footwraps·  Marshal's Silk Gloves·  Marshal's Silk Leggings·",
	},
	["16437:0:0:0"] = {
		["i"] = "Marshal's Silk Footwraps",
		["c"] = "a335ee",
		["t"] = "Marshal's Silk Footwraps·Binds when picked up·Unique·Feet·Cloth·69 Armor·+21 Stamina·+21 Intellect·Classes: Mage·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Field Marshal's Regalia (6)·  Field Marshal's Coronet·  Field Marshal's Silk Spaulders·  Field Marshal's Silk Vestments·  Marshal's Silk Footwraps·  Marshal's Silk Gloves·  Marshal's Silk Leggings·",
	},
	["16444:0:0:0"] = {
		["i"] = "Field Marshal's Silk Spaulders",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Silk Spaulders·Binds when picked up·Unique·Shoulder·Cloth·75 Armor·+22 Stamina·+17 Intellect·Classes: Mage·Requires Level 60·Requires Field Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Field Marshal's Regalia (6)·  Field Marshal's Coronet·  Field Marshal's Silk Spaulders·  Field Marshal's Silk Vestments·  Marshal's Silk Footwraps·  Marshal's Silk Gloves·  Marshal's Silk Leggings·",
	},
	["16442:0:0:0"] = {
		["i"] = "Marshal's Silk Leggings",
		["c"] = "a335ee",
		["t"] = "Marshal's Silk Leggings·Binds when picked up·Unique·Legs·Cloth·88 Armor·+23 Stamina·+16 Intellect·+19 Spirit·Classes: Mage·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 28.· \
·Field Marshal's Regalia (6)·  Field Marshal's Coronet·  Field Marshal's Silk Spaulders·  Field Marshal's Silk Vestments·  Marshal's Silk Footwraps·  Marshal's Silk Gloves·  Marshal's Silk Leggings·",
	},
	["16443:0:0:0"] = {
		["i"] = "Field Marshal's Silk Vestments",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Silk Vestments·Binds when picked up·Unique·Chest·Cloth·100 Armor·+30 Stamina·+25 Intellect·Classes: Mage·Requires Level 60·Requires Field Marshal·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Field Marshal's Regalia (6)·  Field Marshal's Coronet·  Field Marshal's Silk Spaulders·  Field Marshal's Silk Vestments·  Marshal's Silk Footwraps·  Marshal's Silk Gloves·  Marshal's Silk Leggings·",
	},
	["16534:0:0:0"] = {
		["i"] = "General's Silk Trousers",
		["t"] = "General's Silk Trousers·Binds when picked up·Unique·Legs·Cloth·88 Armor·+23 Stamina·+16 Intellect·+19 Spirit·Classes: Mage·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 28.· \
·Warlord's Regalia (6)·  Warlord's Silk Amice·  Warlord's Silk Cowl·  Warlord's Silk Raiment·  General's Silk Boots·  General's Silk Handguards·  General's Silk Trousers·",
		["c"] = "a335ee",
	},
	["16540:0:0:0"] = {
		["i"] = "General's Silk Handguards",
		["c"] = "a335ee",
		["t"] = "General's Silk Handguards·Binds when picked up·Unique·Hands·Cloth·63 Armor·+16 Stamina·Classes: Mage·Requires Level 60·Requires General·Equip: Increases the damage absorbed by your Mana Shield by 285.·Equip: Increases damage and healing done by magical spells and effects by up to 30.· \
·Warlord's Regalia (6)·  Warlord's Silk Amice·  Warlord's Silk Cowl·  Warlord's Silk Raiment·  General's Silk Boots·  General's Silk Handguards·  General's Silk Trousers·",
	},
	["16533:0:0:0"] = {
		["i"] = "Warlord's Silk Cowl",
		["c"] = "a335ee",
		["t"] = "Warlord's Silk Cowl·Binds when picked up·Unique·Head·Cloth·81 Armor·+24 Stamina·+24 Intellect·+19 Spirit·Classes: Mage·Requires Level 60·Requires Warlord·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Warlord's Regalia (6)·  Warlord's Silk Amice·  Warlord's Silk Cowl·  Warlord's Silk Raiment·  General's Silk Boots·  General's Silk Handguards·  General's Silk Trousers·",
	},
	["16539:0:0:0"] = {
		["i"] = "General's Silk Boots",
		["t"] = "General's Silk Boots·Binds when picked up·Unique·Feet·Cloth·69 Armor·+21 Stamina·+21 Intellect·Classes: Mage·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Warlord's Regalia (6)·  Warlord's Silk Amice·  Warlord's Silk Cowl·  Warlord's Silk Raiment·  General's Silk Boots·  General's Silk Handguards·  General's Silk Trousers·",
		["c"] = "a335ee",
	},
	["16536:0:0:0"] = {
		["i"] = "Warlord's Silk Amice",
		["t"] = "Warlord's Silk Amice·Binds when picked up·Unique·Shoulder·Cloth·75 Armor·+22 Stamina·+17 Intellect·Classes: Mage·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Warlord's Regalia (6)·  Warlord's Silk Amice·  Warlord's Silk Cowl·  Warlord's Silk Raiment·  General's Silk Boots·  General's Silk Handguards·  General's Silk Trousers·",
		["c"] = "a335ee",
	},
	["16535:0:0:0"] = {
		["i"] = "Warlord's Silk Raiment",
		["t"] = "Warlord's Silk Raiment·Binds when picked up·Unique·Chest·Cloth·100 Armor·+30 Stamina·+25 Intellect·Classes: Mage·Requires Level 60·Requires Warlord·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Warlord's Regalia (6)·  Warlord's Silk Amice·  Warlord's Silk Cowl·  Warlord's Silk Raiment·  General's Silk Boots·  General's Silk Handguards·  General's Silk Trousers·",
		["c"] = "a335ee",
	},
	["19846:0:0:0"] = {
		["i"] = "Zandalar Illusionist's Wraps",
		["c"] = "0070dd",
		["t"] = "Zandalar Illusionist's Wraps·Binds when picked up·Wrist·Cloth·42 Armor·+11 Stamina·+11 Intellect·Classes: Mage·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·Illusionist's Attire (5)·  Jewel of Kajaro·  Hazza'rah's Charm of Magic·  Zandalar Illusionist's Wraps·  Zandalar Illusionist's Mantle·  Zandalar Illusionist's Robe·",
	},
	["20034:0:0:0"] = {
		["i"] = "Zandalar Illusionist's Robe",
		["c"] = "a335ee",
		["t"] = "Zandalar Illusionist's Robe·Binds when picked up·Chest·Cloth·100 Armor·+23 Stamina·+24 Intellect·Classes: Mage·Equip: Improves your chance to hit with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 27.· \
·Illusionist's Attire (5)·  Jewel of Kajaro·  Hazza'rah's Charm of Magic·  Zandalar Illusionist's Wraps·  Zandalar Illusionist's Mantle·  Zandalar Illusionist's Robe·",
	},
	["19845:0:0:0"] = {
		["i"] = "Zandalar Illusionist's Mantle",
		["c"] = "0070dd",
		["t"] = "Zandalar Illusionist's Mantle·Binds when picked up·Shoulder·Cloth·72 Armor·+10 Stamina·+21 Intellect·Classes: Mage·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Illusionist's Attire (5)·  Jewel of Kajaro·  Hazza'rah's Charm of Magic·  Zandalar Illusionist's Wraps·  Zandalar Illusionist's Mantle·  Zandalar Illusionist's Robe·",
	},
	["19601:0:0:0"] = {
		["i"] = "Jewel of Kajaro",
		["t"] = "Jewel of Kajaro·Binds when picked up·Unique·Neck·+8 Stamina·+13 Intellect·+8 Spirit·Classes: Mage·Equip: Increases damage and healing done by magical spells and effects by up to 9.·Equip: Reduces the cooldown of Counterspell by 2 sec.· \
·Illusionist's Attire (5)·  Jewel of Kajaro·  Hazza'rah's Charm of Magic·  Zandalar Illusionist's Wraps·  Zandalar Illusionist's Mantle·  Zandalar Illusionist's Robe·",
		["c"] = "a335ee",
	},
	["19600:0:0:0"] = {
		["i"] = "Pebble of Kajaro",
		["t"] = "Pebble of Kajaro·Binds when picked up·Unique·Neck·+8 Stamina·+13 Intellect·+8 Spirit·Classes: Mage·Equip: Increases damage and healing done by magical spells and effects by up to 9.·",
		["c"] = "0070dd",
	},
	["19599:0:0:0"] = {
		["i"] = "Pebble of Kajaro",
		["c"] = "0070dd",
		["t"] = "Pebble of Kajaro·Binds when picked up·Unique·Neck·+7 Stamina·+10 Intellect·+6 Spirit·Classes: Mage·Equip: Increases damage and healing done by magical spells and effects by up to 7.·",
	},
	["19598:0:0:0"] = {
		["i"] = "Pebble of Kajaro",
		["t"] = "Pebble of Kajaro·Binds when picked up·Unique·Neck·+7 Stamina·+10 Intellect·Classes: Mage·Equip: Increases damage and healing done by magical spells and effects by up to 7.·",
		["c"] = "1eff00",
	},
	["19959:0:0:0"] = {
		["i"] = "Hazza'rah's Charm of Magic",
		["c"] = "a335ee",
		["t"] = "Hazza'rah's Charm of Magic·Binds when picked up·Unique·Trinket·Classes: Mage·Use: Increases the critical hit chance of your Arcane spells by 5%, and increases the critical hit damage of your Arcane spells by 50% for 20 seconds.· \
·Illusionist's Attire (5)·  Jewel of Kajaro·  Hazza'rah's Charm of Magic·  Zandalar Illusionist's Wraps·  Zandalar Illusionist's Mantle·  Zandalar Illusionist's Robe·",
	},
	["20047:0:0:0"] = {
		["i"] = "Highlander's Cloth Girdle",
		["c"] = "0070dd",
		["t"] = "Highlander's Cloth Girdle·Binds when picked up·Unique·Waist·Cloth·150 Armor·+7 Stamina·+6 Intellect·Classes: Priest, Mage, Warlock·Requires Level 58·Requires The League of Arathor - Honored·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·The Highlander's Intent (3)·  Highlander's Cloth Boots·  Highlander's Cloth Girdle·  Highlander's Epaulets·",
	},
	["20061:0:0:0"] = {
		["i"] = "Highlander's Epaulets",
		["c"] = "a335ee",
		["t"] = "Highlander's Epaulets·Binds when picked up·Unique·Shoulder·Cloth·185 Armor·+18 Stamina·+17 Intellect·Classes: Priest, Mage, Warlock·Requires Level 60·Requires The League of Arathor - Exalted·Equip: Increases damage and healing done by magical spells and effects by up to 12.·Equip: Restores 4 mana per 5 sec.· \
·The Highlander's Intent (3)·  Highlander's Cloth Boots·  Highlander's Cloth Girdle·  Highlander's Epaulets·",
	},
	["20054:0:0:0"] = {
		["i"] = "Highlander's Cloth Boots",
		["c"] = "0070dd",
		["t"] = "Highlander's Cloth Boots·Binds when picked up·Unique·Feet·Cloth·161 Armor·+16 Stamina·+8 Intellect·Classes: Priest, Mage, Warlock·Requires Level 58·Requires The League of Arathor - Revered·Equip: Run speed increased slightly.·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·The Highlander's Intent (3)·  Highlander's Cloth Boots·  Highlander's Cloth Girdle·  Highlander's Epaulets·",
	},
	["20176:0:0:0"] = {
		["i"] = "Defiler's Epaulets",
		["c"] = "a335ee",
		["t"] = "Defiler's Epaulets·Binds when picked up·Unique·Shoulder·Cloth·185 Armor·+18 Stamina·+17 Intellect·Classes: Priest, Mage, Warlock·Requires Level 60·Requires The Defilers - Exalted·Equip: Increases damage and healing done by magical spells and effects by up to 12.·Equip: Restores 4 mana per 5 sec.· \
·The Defiler's Intent (3)·  Defiler's Epaulets·  Defiler's Cloth Boots·  Defiler's Cloth Girdle·",
	},
	["20163:0:0:0"] = {
		["i"] = "Defiler's Cloth Girdle",
		["c"] = "0070dd",
		["t"] = "Defiler's Cloth Girdle·Binds when picked up·Unique·Waist·Cloth·150 Armor·+7 Stamina·+6 Intellect·Classes: Priest, Mage, Warlock·Requires Level 58·Requires The Defilers - Honored·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 14.· \
·The Defiler's Intent (3)·  Defiler's Epaulets·  Defiler's Cloth Boots·  Defiler's Cloth Girdle·",
	},
	["20159:0:0:0"] = {
		["i"] = "Defiler's Cloth Boots",
		["t"] = "Defiler's Cloth Boots·Binds when picked up·Unique·Feet·Cloth·161 Armor·+16 Stamina·+8 Intellect·Classes: Priest, Mage, Warlock·Requires Level 58·Requires The Defilers - Revered·Equip: Run speed increased slightly.·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·The Defiler's Intent (3)·  Defiler's Epaulets·  Defiler's Cloth Boots·  Defiler's Cloth Girdle·",
		["c"] = "0070dd",
	},
	["16691:0:0:0"] = {
		["i"] = "Devout Sandals",
		["t"] = "Devout Sandals·Binds when picked up·Feet·Cloth·58 Armor·+9 Stamina·+10 Intellect·+17 Spirit·Requires Level 54· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
		["c"] = "0070dd",
	},
	["16695:0:0:0"] = {
		["i"] = "Devout Mantle",
		["c"] = "0070dd",
		["t"] = "Devout Mantle·Binds when picked up·Shoulder·Cloth·64 Armor·+4 Stamina·+21 Intellect·+9 Spirit·Requires Level 55· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
	},
	["16697:0:0:0"] = {
		["i"] = "Devout Bracers",
		["c"] = "0070dd",
		["t"] = "Devout Bracers·Binds when equipped·Wrist·Cloth·35 Armor·+7 Stamina·+10 Intellect·+10 Spirit·Requires Level 52· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
	},
	["16694:0:0:0"] = {
		["i"] = "Devout Skirt",
		["c"] = "0070dd",
		["t"] = "Devout Skirt·Binds when picked up·Legs·Cloth·76 Armor·+12 Stamina·+15 Intellect·+23 Spirit·Requires Level 56· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
	},
	["16696:0:0:0"] = {
		["i"] = "Devout Belt",
		["t"] = "Devout Belt·Binds when equipped·Waist·Cloth·46 Armor·+4 Stamina·+20 Intellect·+9 Spirit·Requires Level 53· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
		["c"] = "0070dd",
	},
	["16693:0:0:0"] = {
		["i"] = "Devout Crown",
		["c"] = "0070dd",
		["t"] = "Devout Crown·Binds when picked up·Head·Cloth·71 Armor·+13 Stamina·+24 Intellect·+15 Spirit·Requires Level 57· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
	},
	["16692:0:0:0"] = {
		["i"] = "Devout Gloves",
		["c"] = "0070dd",
		["t"] = "Devout Gloves·Binds when picked up·Hands·Cloth·52 Armor·+9 Stamina·+10 Intellect·+17 Spirit·Requires Level 54· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
	},
	["16690:0:0:0"] = {
		["i"] = "Devout Robe",
		["c"] = "0070dd",
		["t"] = "Devout Robe·Binds when picked up·Chest·Cloth·89 Armor·+13 Stamina·+24 Intellect·+15 Spirit·Requires Level 58· \
·Vestments of the Devout (8)·  Devout Belt·  Devout Sandals·  Devout Bracers·  Devout Crown·  Devout Gloves·  Devout Mantle·  Devout Skirt·  Devout Robe·",
	},
	["16817:0:0:0"] = {
		["i"] = "Girdle of Prophecy",
		["c"] = "a335ee",
		["t"] = "Girdle of Prophecy·Binds when equipped·Waist·Cloth·57 Armor·+10 Stamina·+22 Intellect·+10 Spirit·+7 Fire Resistance·Classes: Priest·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
	},
	["16819:0:0:0"] = {
		["i"] = "Vambraces of Prophecy",
		["c"] = "a335ee",
		["t"] = "Vambraces of Prophecy·Binds when equipped·Wrist·Cloth·44 Armor·+8 Stamina·+14 Intellect·+10 Spirit·Classes: Priest·Requires Level 60·Equip: Restores 2 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 24.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
	},
	["16815:0:0:0"] = {
		["i"] = "Robes of Prophecy",
		["t"] = "Robes of Prophecy·Binds when picked up·Chest·Cloth·102 Armor·+20 Stamina·+27 Intellect·+17 Spirit·+10 Fire Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 22.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
		["c"] = "a335ee",
	},
	["16812:0:0:0"] = {
		["i"] = "Gloves of Prophecy",
		["t"] = "Gloves of Prophecy·Binds when picked up·Hands·Cloth·63 Armor·+10 Stamina·+15 Intellect·+15 Spirit·+7 Fire Resistance·Classes: Priest·Requires Level 60·Equip: Restores 6 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 18.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
		["c"] = "a335ee",
	},
	["16816:0:0:0"] = {
		["i"] = "Mantle of Prophecy",
		["t"] = "Mantle of Prophecy·Binds when picked up·Shoulder·Cloth·76 Armor·+13 Stamina·+23 Intellect·+10 Spirit·+7 Shadow Resistance·Classes: Priest·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
		["c"] = "a335ee",
	},
	["16814:0:0:0"] = {
		["i"] = "Pants of Prophecy",
		["c"] = "a335ee",
		["t"] = "Pants of Prophecy·Binds when picked up·Legs·Cloth·89 Armor·+18 Stamina·+24 Intellect·+20 Spirit·+10 Shadow Resistance·Classes: Priest·Requires Level 60·Equip: Restores 6 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 22.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
	},
	["16813:0:0:0"] = {
		["i"] = "Circlet of Prophecy",
		["c"] = "a335ee",
		["t"] = "Circlet of Prophecy·Binds when picked up·Head·Cloth·83 Armor·+17 Stamina·+27 Intellect·+20 Spirit·+10 Fire Resistance·Classes: Priest·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
	},
	["16811:0:0:0"] = {
		["i"] = "Boots of Prophecy",
		["t"] = "Boots of Prophecy·Binds when picked up·Feet·Cloth·70 Armor·+17 Stamina·+18 Intellect·+15 Spirit·+7 Shadow Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 18.· \
·Vestments of Prophecy (8)·  Boots of Prophecy·  Circlet of Prophecy·  Girdle of Prophecy·  Gloves of Prophecy·  Pants of Prophecy·  Mantle of Prophecy·  Robes of Prophecy·  Vambraces of Prophecy·",
		["c"] = "a335ee",
	},
	["16924:0:0:0"] = {
		["i"] = "Pauldrons of Transcendence",
		["t"] = "Pauldrons of Transcendence·Binds when picked up·Shoulder·Cloth·87 Armor·+12 Stamina·+25 Intellect·+13 Spirit·+10 Fire Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 26.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
		["c"] = "a335ee",
	},
	["16923:0:0:0"] = {
		["i"] = "Robes of Transcendence",
		["c"] = "a335ee",
		["t"] = "Robes of Transcendence·Binds when picked up·Chest·Cloth·116 Armor·+17 Stamina·+27 Intellect·+16 Spirit·+10 Fire Resistance·+10 Nature Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 57.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
	},
	["16922:0:0:0"] = {
		["i"] = "Leggings of Transcendence",
		["c"] = "a335ee",
		["t"] = "Leggings of Transcendence·Binds when picked up·Legs·Cloth·101 Armor·+16 Stamina·+21 Intellect·+21 Spirit·+10 Arcane Resistance·+10 Shadow Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 46.·Equip: Restores 7 mana per 5 sec.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
	},
	["16926:0:0:0"] = {
		["i"] = "Bindings of Transcendence",
		["c"] = "a335ee",
		["t"] = "Bindings of Transcendence·Binds when picked up·Wrist·Cloth·51 Armor·+9 Stamina·+13 Intellect·+16 Spirit·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 33.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
	},
	["16920:0:0:0"] = {
		["i"] = "Handguards of Transcendence",
		["c"] = "a335ee",
		["t"] = "Handguards of Transcendence·Binds when picked up·Hands·Cloth·72 Armor·+12 Stamina·+20 Intellect·+13 Spirit·+10 Shadow Resistance·Classes: Priest·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases healing done by spells and effects by up to 29.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
	},
	["16925:0:0:0"] = {
		["i"] = "Belt of Transcendence",
		["c"] = "a335ee",
		["t"] = "Belt of Transcendence·Binds when picked up·Waist·Cloth·65 Armor·+14 Stamina·+26 Intellect·+9 Spirit·+10 Shadow Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 26.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
	},
	["16921:0:0:0"] = {
		["i"] = "Halo of Transcendence",
		["c"] = "a335ee",
		["t"] = "Halo of Transcendence·Binds when picked up·Head·Cloth·94 Armor·+17 Stamina·+27 Intellect·+22 Spirit·+10 Fire Resistance·+10 Frost Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 48.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
	},
	["16919:0:0:0"] = {
		["i"] = "Boots of Transcendence",
		["t"] = "Boots of Transcendence·Binds when picked up·Feet·Cloth·80 Armor·+17 Stamina·+17 Intellect·+17 Spirit·+10 Fire Resistance·Classes: Priest·Requires Level 60·Equip: Increases healing done by spells and effects by up to 35.· \
·Vestments of Transcendence (8)·  Belt of Transcendence·  Bindings of Transcendence·  Boots of Transcendence·  Halo of Transcendence·  Handguards of Transcendence·  Leggings of Transcendence·  Pauldrons of Transcendence·  Robes of Transcendence·",
		["c"] = "a335ee",
	},
	["17599:0:0:0"] = {
		["i"] = "Knight-Captain's Satin Leggings",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Satin Leggings·Binds when picked up·Unique·Legs·Cloth·78 Armor·+16 Stamina·+13 Intellect·+16 Spirit·Classes: Priest·Requires Level 58·Requires Knight-Captain·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Lieutenant Commander's Raiment (6)·  Knight-Lieutenant's Satin Boots·  Knight-Lieutenant's Satin Gloves·  Knight-Captain's Satin Robes·  Knight-Captain's Satin Leggings·  Lieutenant Commander's Diadem·  Lieutenant Commander's Satin Amice·",
	},
	["17596:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Satin Gloves",
		["s"] = "0 1 2 3 4",
		["d"] = "bi2·un1·lo16·ar56·le58·ty0·su0·",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Satin Gloves·Binds when picked up·Unique·Hands·Cloth·56 Armor·+11 Stamina·Classes: Priest·Requires Level 58·Requires Knight-Lieutenant·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Mind Blast.·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Lieutenant Commander's Raiment (6)·  Knight-Lieutenant's Satin Boots·  Knight-Lieutenant's Satin Gloves·  Knight-Captain's Satin Robes·  Knight-Captain's Satin Leggings·  Lieutenant Commander's Diadem·  Lieutenant Commander's Satin Amice·",
	},
	["17594:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Satin Boots",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Satin Boots·Binds when picked up·Unique·Feet·Cloth·61 Armor·+16 Stamina·+15 Intellect·Classes: Priest·Requires Level 58·Requires Knight-Lieutenant·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Lieutenant Commander's Raiment (6)·  Knight-Lieutenant's Satin Boots·  Knight-Lieutenant's Satin Gloves·  Knight-Captain's Satin Robes·  Knight-Captain's Satin Leggings·  Lieutenant Commander's Diadem·  Lieutenant Commander's Satin Amice·",
	},
	["17601:0:0:0"] = {
		["i"] = "Lieutenant Commander's Satin Amice",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Satin Amice·Binds when picked up·Unique·Shoulder·Cloth·67 Armor·+16 Stamina·+15 Intellect·Classes: Priest·Requires Level 58·Requires Lieutenant Commander·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Lieutenant Commander's Raiment (6)·  Knight-Lieutenant's Satin Boots·  Knight-Lieutenant's Satin Gloves·  Knight-Captain's Satin Robes·  Knight-Captain's Satin Leggings·  Lieutenant Commander's Diadem·  Lieutenant Commander's Satin Amice·",
	},
	["17600:0:0:0"] = {
		["i"] = "Knight-Captain's Satin Robes",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Satin Robes·Binds when picked up·Unique·Chest·Cloth·89 Armor·+20 Stamina·+20 Intellect·Classes: Priest·Requires Level 58·Requires Knight-Captain·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Lieutenant Commander's Raiment (6)·  Knight-Lieutenant's Satin Boots·  Knight-Lieutenant's Satin Gloves·  Knight-Captain's Satin Robes·  Knight-Captain's Satin Leggings·  Lieutenant Commander's Diadem·  Lieutenant Commander's Satin Amice·",
	},
	["17598:0:0:0"] = {
		["i"] = "Lieutenant Commander's Diadem",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Diadem·Binds when picked up·Unique·Head·Cloth·73 Armor·+20 Stamina·+20 Intellect·Classes: Priest·Requires Level 58·Requires Lieutenant Commander·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Lieutenant Commander's Raiment (6)·  Knight-Lieutenant's Satin Boots·  Knight-Lieutenant's Satin Gloves·  Knight-Captain's Satin Robes·  Knight-Captain's Satin Leggings·  Lieutenant Commander's Diadem·  Lieutenant Commander's Satin Amice·",
	},
	["17612:0:0:0"] = {
		["i"] = "Legionnaire's Satin Vestments",
		["t"] = "Legionnaire's Satin Vestments·Binds when picked up·Unique·Chest·Cloth·89 Armor·+20 Stamina·+20 Intellect·Classes: Priest·Requires Level 58·Requires Legionnaire·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
		["c"] = "0070dd",
	},
	["17617:0:0:0"] = {
		["i"] = "Blood Guard's Satin Gloves",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Satin Gloves·Binds when picked up·Unique·Hands·Cloth·56 Armor·+11 Stamina·Classes: Priest·Requires Level 58·Requires Blood Guard·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Mind Blast.·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
	},
	["17610:0:0:0"] = {
		["i"] = "Champion's Satin Cowl",
		["t"] = "Champion's Satin Cowl·Binds when picked up·Unique·Head·Cloth·73 Armor·+20 Stamina·+20 Intellect·Classes: Priest·Requires Level 58·Requires Champion·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
		["c"] = "0070dd",
	},
	["17613:0:0:0"] = {
		["i"] = "Champion's Satin Shoulderpads",
		["c"] = "0070dd",
		["t"] = "Champion's Satin Shoulderpads·Binds when picked up·Unique·Shoulder·Cloth·67 Armor·+16 Stamina·+15 Intellect·Classes: Priest·Requires Level 58·Requires Champion·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
	},
	["17611:0:0:0"] = {
		["i"] = "Legionnaire's Satin Trousers",
		["t"] = "Legionnaire's Satin Trousers·Binds when picked up·Unique·Legs·Cloth·78 Armor·+16 Stamina·+13 Intellect·+16 Spirit·Classes: Priest·Requires Level 58·Requires Legionnaire·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
		["c"] = "0070dd",
	},
	["17616:0:0:0"] = {
		["i"] = "Blood Guard's Satin Boots",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Satin Boots·Binds when picked up·Unique·Feet·Cloth·61 Armor·+16 Stamina·+15 Intellect·Classes: Priest·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
	},
	["17612:0:0:0"] = {
		["i"] = "Legionnaire's Satin Vestments",
		["t"] = "Legionnaire's Satin Vestments·Binds when picked up·Unique·Chest·Cloth·89 Armor·+20 Stamina·+20 Intellect·Classes: Priest·Requires Level 58·Requires Legionnaire·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
		["c"] = "0070dd",
	},
	["17617:0:0:0"] = {
		["i"] = "Blood Guard's Satin Gloves",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Satin Gloves·Binds when picked up·Unique·Hands·Cloth·56 Armor·+11 Stamina·Classes: Priest·Requires Level 58·Requires Blood Guard·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Mind Blast.·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Champion's Raiment (6)·  Blood Guard's Satin Boots·  Blood Guard's Satin Gloves·  Legionnaire's Satin Vestments·  Legionnaire's Satin Trousers·  Champion's Satin Shoulderpads·  Champion's Satin Cowl·",
	},
	["17604:0:0:0"] = {
		["i"] = "Field Marshal's Satin Mantle",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Satin Mantle·Binds when picked up·Unique·Shoulder·Cloth·75 Armor·+22 Stamina·+17 Intellect·Classes: Priest·Requires Level 60·Requires Field Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Field Marshal's Raiment (6)·  Field Marshal's Headdress·  Field Marshal's Satin Mantle·  Field Marshal's Satin Vestments·  Marshal's Satin Pants·  Marshal's Satin Gloves·  Marshal's Satin Sandals·",
	},
	["17605:0:0:0"] = {
		["i"] = "Field Marshal's Satin Vestments",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Satin Vestments·Binds when picked up·Unique·Chest·Cloth·100 Armor·+30 Stamina·+25 Intellect·Classes: Priest·Requires Level 60·Requires Field Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Field Marshal's Raiment (6)·  Field Marshal's Headdress·  Field Marshal's Satin Mantle·  Field Marshal's Satin Vestments·  Marshal's Satin Pants·  Marshal's Satin Gloves·  Marshal's Satin Sandals·",
	},
	["17608:0:0:0"] = {
		["i"] = "Marshal's Satin Gloves",
		["c"] = "a335ee",
		["t"] = "Marshal's Satin Gloves·Binds when picked up·Unique·Hands·Cloth·63 Armor·+16 Stamina·Classes: Priest·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 30.·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Mind Blast.· \
·Field Marshal's Raiment (6)·  Field Marshal's Headdress·  Field Marshal's Satin Mantle·  Field Marshal's Satin Vestments·  Marshal's Satin Pants·  Marshal's Satin Gloves·  Marshal's Satin Sandals·",
	},
	["17607:0:0:0"] = {
		["i"] = "Marshal's Satin Sandals",
		["c"] = "a335ee",
		["t"] = "Marshal's Satin Sandals·Binds when picked up·Unique·Feet·Cloth·69 Armor·+21 Stamina·+21 Intellect·Classes: Priest·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Field Marshal's Raiment (6)·  Field Marshal's Headdress·  Field Marshal's Satin Mantle·  Field Marshal's Satin Vestments·  Marshal's Satin Pants·  Marshal's Satin Gloves·  Marshal's Satin Sandals·",
	},
	["17603:0:0:0"] = {
		["i"] = "Marshal's Satin Pants",
		["c"] = "a335ee",
		["t"] = "Marshal's Satin Pants·Binds when picked up·Unique·Legs·Cloth·88 Armor·+23 Stamina·+16 Intellect·+19 Spirit·Classes: Priest·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 28.· \
·Field Marshal's Raiment (6)·  Field Marshal's Headdress·  Field Marshal's Satin Mantle·  Field Marshal's Satin Vestments·  Marshal's Satin Pants·  Marshal's Satin Gloves·  Marshal's Satin Sandals·",
	},
	["17602:0:0:0"] = {
		["i"] = "Field Marshal's Headdress",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Headdress·Binds when picked up·Unique·Head·Cloth·81 Armor·+28 Stamina·+24 Intellect·Classes: Priest·Requires Level 60·Requires Field Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Field Marshal's Raiment (6)·  Field Marshal's Headdress·  Field Marshal's Satin Mantle·  Field Marshal's Satin Vestments·  Marshal's Satin Pants·  Marshal's Satin Gloves·  Marshal's Satin Sandals·",
	},
	["17624:0:0:0"] = {
		["i"] = "Warlord's Satin Robes",
		["c"] = "a335ee",
		["t"] = "Warlord's Satin Robes·Binds when picked up·Unique·Chest·Cloth·100 Armor·+30 Stamina·+25 Intellect·Classes: Priest·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Warlord's Raiment (6)·  Warlord's Satin Cowl·  General's Satin Leggings·  Warlord's Satin Mantle·  Warlord's Satin Robes·  General's Satin Boots·  General's Satin Gloves·",
	},
	["17618:0:0:0"] = {
		["i"] = "General's Satin Boots",
		["c"] = "a335ee",
		["t"] = "General's Satin Boots·Binds when picked up·Unique·Feet·Cloth·69 Armor·+21 Stamina·+21 Intellect·Classes: Priest·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Warlord's Raiment (6)·  Warlord's Satin Cowl·  General's Satin Leggings·  Warlord's Satin Mantle·  Warlord's Satin Robes·  General's Satin Boots·  General's Satin Gloves·",
	},
	["17625:0:0:0"] = {
		["i"] = "General's Satin Leggings",
		["c"] = "a335ee",
		["t"] = "General's Satin Leggings·Binds when picked up·Unique·Legs·Cloth·88 Armor·+23 Stamina·+16 Intellect·+19 Spirit·Classes: Priest·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 28.· \
·Warlord's Raiment (6)·  Warlord's Satin Cowl·  General's Satin Leggings·  Warlord's Satin Mantle·  Warlord's Satin Robes·  General's Satin Boots·  General's Satin Gloves·",
	},
	["17622:0:0:0"] = {
		["i"] = "Warlord's Satin Mantle",
		["c"] = "a335ee",
		["t"] = "Warlord's Satin Mantle·Binds when picked up·Unique·Shoulder·Cloth·75 Armor·+22 Stamina·+17 Intellect·Classes: Priest·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Warlord's Raiment (6)·  Warlord's Satin Cowl·  General's Satin Leggings·  Warlord's Satin Mantle·  Warlord's Satin Robes·  General's Satin Boots·  General's Satin Gloves·",
	},
	["17620:0:0:0"] = {
		["i"] = "General's Satin Gloves",
		["c"] = "a335ee",
		["t"] = "General's Satin Gloves·Binds when picked up·Unique·Hands·Cloth·63 Armor·+16 Stamina·Classes: Priest·Requires Level 60·Requires General·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Mind Blast.·Equip: Increases damage and healing done by magical spells and effects by up to 30.· \
·Warlord's Raiment (6)·  Warlord's Satin Cowl·  General's Satin Leggings·  Warlord's Satin Mantle·  Warlord's Satin Robes·  General's Satin Boots·  General's Satin Gloves·",
	},
	["17623:0:0:0"] = {
		["i"] = "Warlord's Satin Cowl",
		["c"] = "a335ee",
		["d"] = "bi2·un1·lo13·ar81·le60·se64·ty0·su0·",
		["t"] = "Warlord's Satin Cowl·Binds when picked up·Unique·Head·Cloth·81 Armor·+28 Stamina·+24 Intellect·Classes: Priest·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Warlord's Raiment (6)·  Warlord's Satin Cowl·  General's Satin Leggings·  Warlord's Satin Mantle·  Warlord's Satin Robes·  General's Satin Boots·  General's Satin Gloves·",
		["s"] = "0 1 2 3 4",
	},
	["19843:0:0:0"] = {
		["i"] = "Zandalar Confessor's Wraps",
		["c"] = "0070dd",
		["t"] = "Zandalar Confessor's Wraps·Binds when picked up·Wrist·Cloth·42 Armor·+9 Stamina·+10 Intellect·+10 Spirit·Classes: Priest·Equip: Increases healing done by spells and effects by up to 22.· \
·Confessor's Raiment (5)·  The All-Seeing Eye of Zuldazar·  Hazza'rah's Charm of Healing·  Zandalar Confessor's Wraps·  Zandalar Confessor's Bindings·  Zandalar Confessor's Mantle·",
	},
	["19841:0:0:0"] = {
		["i"] = "Zandalar Confessor's Mantle",
		["t"] = "Zandalar Confessor's Mantle·Binds when picked up·Shoulder·Cloth·78 Armor·+11 Stamina·+24 Intellect·+15 Spirit·Classes: Priest·Equip: Increases healing done by spells and effects by up to 22.· \
·Confessor's Raiment (5)·  The All-Seeing Eye of Zuldazar·  Hazza'rah's Charm of Healing·  Zandalar Confessor's Wraps·  Zandalar Confessor's Bindings·  Zandalar Confessor's Mantle·",
		["c"] = "a335ee",
	},
	["19842:0:0:0"] = {
		["i"] = "Zandalar Confessor's Bindings",
		["t"] = "Zandalar Confessor's Bindings·Binds when picked up·Waist·Cloth·54 Armor·+10 Stamina·+20 Intellect·+10 Spirit·Classes: Priest·Equip: Increases healing done by spells and effects by up to 24.· \
·Confessor's Raiment (5)·  The All-Seeing Eye of Zuldazar·  Hazza'rah's Charm of Healing·  Zandalar Confessor's Wraps·  Zandalar Confessor's Bindings·  Zandalar Confessor's Mantle·",
		["c"] = "0070dd",
	},
	["19594:0:0:0"] = {
		["i"] = "The All-Seeing Eye of Zuldazar",
		["t"] = "The All-Seeing Eye of Zuldazar·Binds when picked up·Unique·Neck·+8 Stamina·+8 Intellect·+13 Spirit·Classes: Priest·Equip: Increases healing done by spells and effects by up to 18.·Equip: Increases the amount of damage absorbed by Power Word: Shield by 35.· \
·Confessor's Raiment (5)·  The All-Seeing Eye of Zuldazar·  Hazza'rah's Charm of Healing·  Zandalar Confessor's Wraps·  Zandalar Confessor's Bindings·  Zandalar Confessor's Mantle·",
		["c"] = "a335ee",
	},
	["19593:0:0:0"] = {
		["i"] = "The Eye of Zuldazar",
		["c"] = "0070dd",
		["t"] = "The Eye of Zuldazar·Binds when picked up·Unique·Neck·+8 Stamina·+8 Intellect·+13 Spirit·Classes: Priest·Equip: Increases healing done by spells and effects by up to 18.·",
	},
	["19592:0:0:0"] = {
		["i"] = "The Eye of Zuldazar",
		["t"] = "The Eye of Zuldazar·Binds when picked up·Unique·Neck·+6 Stamina·+7 Intellect·+10 Spirit·Classes: Priest·Equip: Increases healing done by spells and effects by up to 13.·",
		["c"] = "0070dd",
	},
	["19591:0:0:0"] = {
		["i"] = "The Eye of Zuldazar",
		["t"] = "The Eye of Zuldazar·Binds when picked up·Unique·Neck·+6 Stamina·+7 Intellect·+10 Spirit·Classes: Priest·",
		["c"] = "1eff00",
	},
	["19958:0:0:0"] = {
		["i"] = "Hazza'rah's Charm of Healing",
		["c"] = "a335ee",
		["t"] = "Hazza'rah's Charm of Healing·Binds when picked up·Unique·Trinket·Classes: Priest·Use: Reduces the casting time of your Greater Heal spells by 40%, and reduces the mana cost of your healing spells by 5% for 15 seconds.· \
·Confessor's Raiment (5)·  The All-Seeing Eye of Zuldazar·  Hazza'rah's Charm of Healing·  Zandalar Confessor's Wraps·  Zandalar Confessor's Bindings·  Zandalar Confessor's Mantle·",
	},
	["16710:0:0:0"] = {
		["i"] = "Shadowcraft Bracers",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Bracers·Binds when equipped·Wrist·Leather·71 Armor·+15 Agility·+7 Stamina·Requires Level 52· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16709:0:0:0"] = {
		["i"] = "Shadowcraft Pants",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Pants·Binds when picked up·Legs·Leather·150 Armor·+12 Strength·+25 Agility·+12 Stamina·Requires Level 56· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16721:0:0:0"] = {
		["i"] = "Shadowcraft Tunic",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Tunic·Binds when picked up·Chest·Leather·176 Armor·+26 Agility·+13 Stamina·+12 Spirit·Requires Level 58· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16711:0:0:0"] = {
		["i"] = "Shadowcraft Boots",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Boots·Binds when picked up·Feet·Leather·115 Armor·+21 Agility·+9 Stamina·Requires Level 54· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16712:0:0:0"] = {
		["i"] = "Shadowcraft Gloves",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Gloves·Binds when picked up·Hands·Leather·105 Armor·+9 Strength·+14 Agility·+9 Stamina·+10 Spirit·Requires Level 54· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16708:0:0:0"] = {
		["i"] = "Shadowcraft Spaulders",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Spaulders·Binds when picked up·Shoulder·Leather·127 Armor·+22 Agility·+9 Stamina·Requires Level 55· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16713:0:0:0"] = {
		["i"] = "Shadowcraft Belt",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Belt·Binds when equipped·Waist·Leather·93 Armor·+9 Strength·+14 Agility·+10 Stamina·+9 Spirit·Requires Level 53· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16707:0:0:0"] = {
		["i"] = "Shadowcraft Cap",
		["c"] = "0070dd",
		["t"] = "Shadowcraft Cap·Binds when picked up·Head·Leather·141 Armor·+13 Strength·+20 Agility·+18 Stamina·+5 Spirit·Requires Level 57· \
·Shadowcraft Armor (8)·  Shadowcraft Belt·  Shadowcraft Boots·  Shadowcraft Bracers·  Shadowcraft Tunic·  Shadowcraft Spaulders·  Shadowcraft Pants·  Shadowcraft Gloves·  Shadowcraft Cap·",
	},
	["16823:0:0:0"] = {
		["i"] = "Nightslayer Shoulder Pads",
		["c"] = "a335ee",
		["t"] = "Nightslayer Shoulder Pads·Binds when picked up·Shoulder·Leather·150 Armor·+3 Strength·+26 Agility·+12 Stamina·+7 Shadow Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
	},
	["16822:0:0:0"] = {
		["i"] = "Nightslayer Pants",
		["c"] = "a335ee",
		["t"] = "Nightslayer Pants·Binds when picked up·Legs·Leather·175 Armor·+10 Strength·+33 Agility·+15 Stamina·+10 Shadow Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
	},
	["16820:0:0:0"] = {
		["i"] = "Nightslayer Chestpiece",
		["c"] = "a335ee",
		["t"] = "Nightslayer Chestpiece·Binds when picked up·Chest·Leather·200 Armor·+10 Strength·+29 Agility·+20 Stamina·+10 Fire Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
	},
	["16825:0:0:0"] = {
		["i"] = "Nightslayer Bracelets",
		["c"] = "a335ee",
		["t"] = "Nightslayer Bracelets·Binds when equipped·Wrist·Leather·88 Armor·+20 Agility·+15 Stamina·Classes: Rogue·Requires Level 60· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
	},
	["16824:0:0:0"] = {
		["i"] = "Nightslayer Boots",
		["t"] = "Nightslayer Boots·Binds when picked up·Feet·Leather·138 Armor·+26 Agility·+18 Stamina·+7 Shadow Resistance·Classes: Rogue·Requires Level 60· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
		["c"] = "a335ee",
	},
	["16826:0:0:0"] = {
		["i"] = "Nightslayer Gloves",
		["c"] = "a335ee",
		["t"] = "Nightslayer Gloves·Binds when picked up·Hands·Leather·125 Armor·+12 Strength·+18 Agility·+17 Stamina·+7 Fire Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
	},
	["16821:0:0:0"] = {
		["i"] = "Nightslayer Cover",
		["t"] = "Nightslayer Cover·Binds when picked up·Head·Leather·163 Armor·+6 Strength·+20 Agility·+19 Stamina·+10 Fire Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 2%.· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
		["c"] = "a335ee",
	},
	["16827:0:0:0"] = {
		["i"] = "Nightslayer Belt",
		["c"] = "a335ee",
		["t"] = "Nightslayer Belt·Binds when equipped·Waist·Leather·113 Armor·+9 Strength·+17 Agility·+18 Stamina·+7 Fire Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Nightslayer Armor (8)·  Nightslayer Belt·  Nightslayer Boots·  Nightslayer Bracelets·  Nightslayer Chestpiece·  Nightslayer Cover·  Nightslayer Gloves·  Nightslayer Pants·  Nightslayer Shoulder Pads·",
	},
	["16907:0:0:0"] = {
		["i"] = "Bloodfang Gloves",
		["c"] = "a335ee",
		["t"] = "Bloodfang Gloves·Binds when picked up·Hands·Leather·140 Armor·+19 Strength·+20 Agility·+20 Stamina·+10 Shadow Resistance·Classes: Rogue·Requires Level 60·Equip: Immune to Disarm.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16906:0:0:0"] = {
		["i"] = "Bloodfang Boots",
		["c"] = "a335ee",
		["t"] = "Bloodfang Boots·Binds when picked up·Feet·Leather·154 Armor·+6 Strength·+25 Agility·+17 Stamina·+10 Fire Resistance·Classes: Rogue·Requires Level 60·Equip: Increases your chance to dodge an attack by 1%.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16909:0:0:0"] = {
		["i"] = "Bloodfang Pants",
		["c"] = "a335ee",
		["t"] = "Bloodfang Pants·Binds when picked up·Legs·Leather·197 Armor·+11 Strength·+37 Agility·+17 Stamina·+10 Arcane Resistance·+10 Fire Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16905:0:0:0"] = {
		["i"] = "Bloodfang Chestpiece",
		["c"] = "a335ee",
		["t"] = "Bloodfang Chestpiece·Binds when picked up·Chest·Leather·225 Armor·+12 Strength·+26 Agility·+17 Stamina·+10 Fire Resistance·+10 Nature Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.·Equip: Improves your chance to hit by 2%.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16910:0:0:0"] = {
		["i"] = "Bloodfang Belt",
		["c"] = "a335ee",
		["t"] = "Bloodfang Belt·Binds when picked up·Waist·Leather·126 Armor·+13 Strength·+20 Agility·+15 Stamina·+10 Shadow Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16911:0:0:0"] = {
		["i"] = "Bloodfang Bracers",
		["c"] = "a335ee",
		["t"] = "Bloodfang Bracers·Binds when picked up·Wrist·Leather·98 Armor·+23 Agility·+13 Stamina·Classes: Rogue·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16908:0:0:0"] = {
		["i"] = "Bloodfang Hood",
		["c"] = "a335ee",
			["t"] = "Bloodfang Hood·Binds when picked up·Head·Leather·183 Armor·+19 Strength·+27 Agility·+25 Stamina·+10 Frost Resistance·+10 Shadow Resistance·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16832:0:0:0"] = {
		["i"] = "Bloodfang Spaulders",
		["c"] = "a335ee",
		["t"] = "Bloodfang Spaulders·Binds when picked up·Shoulder·Leather·169 Armor·+6 Strength·+25 Agility·+17 Stamina·+10 Fire Resistance·Classes: Rogue·Requires Level 60·Equip: Increases your chance to dodge an attack by 1%.· \
·Bloodfang Armor (8)·  Bloodfang Belt·  Bloodfang Boots·  Bloodfang Bracers·  Bloodfang Chestpiece·  Bloodfang Gloves·  Bloodfang Hood·  Bloodfang Pants·  Bloodfang Spaulders·",
	},
	["16420:0:0:0"] = {
		["i"] = "Lieutenant Commander's Leather Spaulders",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Leather Spaulders·Binds when picked up·Unique·Shoulder·Leather·132 Armor·+7 Agility·+23 Stamina·Classes: Rogue·Requires Level 58·Requires Lieutenant Commander·Equip: +12 Attack Power.· \
·Lieutenant Commander's Vestments (6)·  Knight-Lieutenant's Leather Boots·  Knight-Lieutenant's Leather Gauntlets·  Knight-Captain's Leather Armor·  Knight-Captain's Leather Legguards·  Lieutenant Commander's Leather Spaulders·  Lieutenant Commander's Leather Veil·",
	},
	["16392:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Leather Boots",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Leather Boots·Binds when picked up·Unique·Feet·Leather·121 Armor·+23 Stamina·Classes: Rogue·Requires Level 58·Requires Knight-Lieutenant·Equip: Increases the duration of your Sprint ability by 3 sec.· \
·Lieutenant Commander's Vestments (6)·  Knight-Lieutenant's Leather Boots·  Knight-Lieutenant's Leather Gauntlets·  Knight-Captain's Leather Armor·  Knight-Captain's Leather Legguards·  Lieutenant Commander's Leather Spaulders·  Lieutenant Commander's Leather Veil·",
	},
	["16418:0:0:0"] = {
		["i"] = "Lieutenant Commander's Leather Veil",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Leather Veil·Binds when picked up·Unique·Head·Leather·143 Armor·+26 Stamina·Classes: Rogue·Requires Level 58·Requires Lieutenant Commander·Equip: Increases your chance to dodge an attack by 1%.·Equip: +12 Attack Power.·Equip: Improves your chance to hit by 1%.· \
·Lieutenant Commander's Vestments (6)·  Knight-Lieutenant's Leather Boots·  Knight-Lieutenant's Leather Gauntlets·  Knight-Captain's Leather Armor·  Knight-Captain's Leather Legguards·  Lieutenant Commander's Leather Spaulders·  Lieutenant Commander's Leather Veil·",
	},
	["16417:0:0:0"] = {
		["i"] = "Knight-Captain's Leather Armor",
		["t"] = "Knight-Captain's Leather Armor·Binds when picked up·Unique·Chest·Leather·176 Armor·+13 Agility·+25 Stamina·Classes: Rogue·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike by 1%.· \
·Lieutenant Commander's Vestments (6)·  Knight-Lieutenant's Leather Boots·  Knight-Lieutenant's Leather Gauntlets·  Knight-Captain's Leather Armor·  Knight-Captain's Leather Legguards·  Lieutenant Commander's Leather Spaulders·  Lieutenant Commander's Leather Veil·",
		["c"] = "0070dd",
	},
	["16419:0:0:0"] = {
		["i"] = "Knight-Captain's Leather Legguards",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Leather Legguards·Binds when picked up·Unique·Legs·Leather·154 Armor·+7 Strength·+13 Stamina·Classes: Rogue·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike by 2%.· \
·Lieutenant Commander's Vestments (6)·  Knight-Lieutenant's Leather Boots·  Knight-Lieutenant's Leather Gauntlets·  Knight-Captain's Leather Armor·  Knight-Captain's Leather Legguards·  Lieutenant Commander's Leather Spaulders·  Lieutenant Commander's Leather Veil·",
	},
	["16396:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Leather Gauntlets",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Leather Gauntlets·Binds when picked up·Unique·Hands·Leather·110 Armor·+10 Agility·+15 Stamina·Classes: Rogue·Requires Level 58·Requires Knight-Lieutenant·Equip: +32 Attack Power.· \
·Lieutenant Commander's Vestments (6)·  Knight-Lieutenant's Leather Boots·  Knight-Lieutenant's Leather Gauntlets·  Knight-Captain's Leather Armor·  Knight-Captain's Leather Legguards·  Lieutenant Commander's Leather Spaulders·  Lieutenant Commander's Leather Veil·",
	},
	["16498:0:0:0"] = {
		["i"] = "Blood Guard's Leather Treads",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Leather Treads·Binds when picked up·Unique·Feet·Leather·121 Armor·+11 Agility·+18 Stamina·Classes: Rogue·Requires Level 58·Requires Blood Guard·Equip: Increases the duration of your Sprint ability by 3 sec.· \
·Champion's Vestments (6)·  Blood Guard's Leather Treads·  Blood Guard's Leather Vices·  Legionnaire's Leather Hauberk·  Legionnaire's Leather Leggings·  Champion's Leather Headguard·  Champion's Leather Mantle·",
	},
	["16505:0:0:0"] = {
		["i"] = "Legionnaire's Leather Hauberk",
		["t"] = "Legionnaire's Leather Hauberk·Binds when picked up·Unique·Chest·Leather·176 Armor·+13 Agility·+25 Stamina·Classes: Rogue·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike by 1%.· \
·Champion's Vestments (6)·  Blood Guard's Leather Treads·  Blood Guard's Leather Vices·  Legionnaire's Leather Hauberk·  Legionnaire's Leather Leggings·  Champion's Leather Headguard·  Champion's Leather Mantle·",
		["c"] = "0070dd",
	},
	["16506:0:0:0"] = {
		["i"] = "Champion's Leather Headguard",
		["c"] = "0070dd",
		["t"] = "Champion's Leather Headguard·Binds when picked up·Unique·Head·Leather·143 Armor·+26 Stamina·Classes: Rogue·Requires Level 58·Requires Champion·Equip: Increases your chance to dodge an attack by 1%.·Equip: Improves your chance to hit by 1%.·Equip: +12 Attack Power.· \
·Champion's Vestments (6)·  Blood Guard's Leather Treads·  Blood Guard's Leather Vices·  Legionnaire's Leather Hauberk·  Legionnaire's Leather Leggings·  Champion's Leather Headguard·  Champion's Leather Mantle·",
	},
	["16507:0:0:0"] = {
		["i"] = "Champion's Leather Mantle",
		["c"] = "0070dd",
		["t"] = "Champion's Leather Mantle·Binds when picked up·Unique·Shoulder·Leather·132 Armor·+7 Agility·+23 Stamina·Classes: Rogue·Requires Level 58·Requires Champion·Equip: +12 Attack Power.· \
·Champion's Vestments (6)·  Blood Guard's Leather Treads·  Blood Guard's Leather Vices·  Legionnaire's Leather Hauberk·  Legionnaire's Leather Leggings·  Champion's Leather Headguard·  Champion's Leather Mantle·",
	},
	["16508:0:0:0"] = {
		["i"] = "Legionnaire's Leather Leggings",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Leather Leggings·Binds when picked up·Unique·Legs·Leather·154 Armor·+7 Strength·+13 Stamina·Classes: Rogue·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike by 2%.· \
·Champion's Vestments (6)·  Blood Guard's Leather Treads·  Blood Guard's Leather Vices·  Legionnaire's Leather Hauberk·  Legionnaire's Leather Leggings·  Champion's Leather Headguard·  Champion's Leather Mantle·",
	},
	["16499:0:0:0"] = {
		["i"] = "Blood Guard's Leather Vices",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Leather Vices·Binds when picked up·Unique·Hands·Leather·110 Armor·+10 Agility·+15 Stamina·Classes: Rogue·Requires Level 58·Requires Blood Guard·Equip: +32 Attack Power.· \
·Champion's Vestments (6)·  Blood Guard's Leather Treads·  Blood Guard's Leather Vices·  Legionnaire's Leather Hauberk·  Legionnaire's Leather Leggings·  Champion's Leather Headguard·  Champion's Leather Mantle·",
	},
	["16446:0:0:0"] = {
		["i"] = "Marshal's Leather Footguards",
		["t"] = "Marshal's Leather Footguards·Binds when picked up·Unique·Feet·Leather·136 Armor·+16 Agility·+26 Stamina·Classes: Rogue·Requires Level 60·Requires Marshal·Equip: Increases the duration of your Sprint ability by 3 sec.· \
·Field Marshal's Vestments (6)·  Field Marshal's Leather Chestpiece·  Field Marshal's Leather Epaulets·  Field Marshal's Leather Mask·  Marshal's Leather Footguards·  Marshal's Leather Handgrips·  Marshal's Leather Leggings·",
		["c"] = "a335ee",
	},
	["16453:0:0:0"] = {
		["i"] = "Field Marshal's Leather Chestpiece",
		["t"] = "Field Marshal's Leather Chestpiece·Binds when picked up·Unique·Chest·Leather·197 Armor·+20 Agility·+35 Stamina·Classes: Rogue·Requires Level 60·Requires Field Marshal·Equip: Improves your chance to get a critical strike by 1%.· \
·Field Marshal's Vestments (6)·  Field Marshal's Leather Chestpiece·  Field Marshal's Leather Epaulets·  Field Marshal's Leather Mask·  Marshal's Leather Footguards·  Marshal's Leather Handgrips·  Marshal's Leather Leggings·",
		["c"] = "a335ee",
	},
	["16454:0:0:0"] = {
		["i"] = "Marshal's Leather Handgrips",
		["t"] = "Marshal's Leather Handgrips·Binds when picked up·Unique·Hands·Leather·123 Armor·+14 Agility·+18 Stamina·Classes: Rogue·Requires Level 60·Requires Marshal·Equip: +40 Attack Power.· \
·Field Marshal's Vestments (6)·  Field Marshal's Leather Chestpiece·  Field Marshal's Leather Epaulets·  Field Marshal's Leather Mask·  Marshal's Leather Footguards·  Marshal's Leather Handgrips·  Marshal's Leather Leggings·",
		["c"] = "a335ee",
	},
	["16456:0:0:0"] = {
		["i"] = "Marshal's Leather Leggings",
		["t"] = "Marshal's Leather Leggings·Binds when picked up·Unique·Legs·Leather·173 Armor·+12 Strength·+24 Stamina·Classes: Rogue·Requires Level 60·Requires Marshal·Equip: Improves your chance to get a critical strike by 2%.·Equip: Improves your chance to hit by 1%.· \
·Field Marshal's Vestments (6)·  Field Marshal's Leather Chestpiece·  Field Marshal's Leather Epaulets·  Field Marshal's Leather Mask·  Marshal's Leather Footguards·  Marshal's Leather Handgrips·  Marshal's Leather Leggings·",
		["c"] = "a335ee",
	},
	["16457:0:0:0"] = {
		["i"] = "Field Marshal's Leather Epaulets",
		["t"] = "Field Marshal's Leather Epaulets·Binds when picked up·Unique·Shoulder·Leather·148 Armor·+15 Agility·+26 Stamina·Classes: Rogue·Requires Level 60·Requires Field Marshal·Equip: +22 Attack Power.· \
·Field Marshal's Vestments (6)·  Field Marshal's Leather Chestpiece·  Field Marshal's Leather Epaulets·  Field Marshal's Leather Mask·  Marshal's Leather Footguards·  Marshal's Leather Handgrips·  Marshal's Leather Leggings·",
		["c"] = "a335ee",
	},
	["16455:0:0:0"] = {
		["i"] = "Field Marshal's Leather Mask",
		["t"] = "Field Marshal's Leather Mask·Binds when picked up·Unique·Head·Leather·160 Armor·+35 Stamina·Classes: Rogue·Requires Level 60·Requires Field Marshal·Equip: Increases your chance to dodge an attack by 1%.·Equip: Improves your chance to hit by 1%.·Equip: +30 Attack Power.· \
·Field Marshal's Vestments (6)·  Field Marshal's Leather Chestpiece·  Field Marshal's Leather Epaulets·  Field Marshal's Leather Mask·  Marshal's Leather Footguards·  Marshal's Leather Handgrips·  Marshal's Leather Leggings·",
		["c"] = "a335ee",
	},
	["16564:0:0:0"] = {
		["i"] = "General's Leather Legguards",
		["t"] = "General's Leather Legguards·Binds when picked up·Unique·Legs·Leather·173 Armor·+12 Strength·+24 Stamina·Classes: Rogue·Requires Level 60·Requires General·Equip: Improves your chance to get a critical strike by 2%.·Equip: Improves your chance to hit by 1%.· \
·Warlord's Vestments (6)·  Warlord's Leather Breastplate·  Warlord's Leather Helm·  Warlord's Leather Spaulders·  General's Leather Legguards·  General's Leather Mitts·  General's Leather Treads·",
		["c"] = "a335ee",
	},
	["16558:0:0:0"] = {
		["i"] = "General's Leather Treads",
		["t"] = "General's Leather Treads·Binds when picked up·Unique·Feet·Leather·136 Armor·+16 Agility·+26 Stamina·Classes: Rogue·Requires Level 60·Requires General·Equip: Increases the duration of your Sprint ability by 3 sec.· \
·Warlord's Vestments (6)·  Warlord's Leather Breastplate·  Warlord's Leather Helm·  Warlord's Leather Spaulders·  General's Leather Legguards·  General's Leather Mitts·  General's Leather Treads·",
		["c"] = "a335ee",
	},
	["16561:0:0:0"] = {
		["i"] = "Warlord's Leather Helm",
		["t"] = "Warlord's Leather Helm·Binds when picked up·Unique·Head·Leather·160 Armor·+35 Stamina·Classes: Rogue·Requires Level 60·Requires Warlord·Equip: +30 Attack Power.·Equip: Increases your chance to dodge an attack by 1%.·Equip: Improves your chance to hit by 1%.· \
·Warlord's Vestments (6)·  Warlord's Leather Breastplate·  Warlord's Leather Helm·  Warlord's Leather Spaulders·  General's Leather Legguards·  General's Leather Mitts·  General's Leather Treads·",
		["c"] = "a335ee",
	},
	["16560:0:0:0"] = {
		["i"] = "General's Leather Mitts",
		["c"] = "a335ee",
		["t"] = "General's Leather Mitts·Binds when picked up·Unique·Hands·Leather·123 Armor·+14 Agility·+18 Stamina·Classes: Rogue·Requires Level 60·Requires General·Equip: +40 Attack Power.· \
·Warlord's Vestments (6)·  Warlord's Leather Breastplate·  Warlord's Leather Helm·  Warlord's Leather Spaulders·  General's Leather Legguards·  General's Leather Mitts·  General's Leather Treads·",
	},
	["16562:0:0:0"] = {
		["i"] = "Warlord's Leather Spaulders",
		["t"] = "Warlord's Leather Spaulders·Binds when picked up·Unique·Shoulder·Leather·148 Armor·+15 Agility·+26 Stamina·Classes: Rogue·Requires Level 60·Requires Warlord·Equip: +22 Attack Power.· \
·Warlord's Vestments (6)·  Warlord's Leather Breastplate·  Warlord's Leather Helm·  Warlord's Leather Spaulders·  General's Leather Legguards·  General's Leather Mitts·  General's Leather Treads·",
		["c"] = "a335ee",
	},
	["16563:0:0:0"] = {
		["i"] = "Warlord's Leather Breastplate",
		["t"] = "Warlord's Leather Breastplate·Binds when picked up·Unique·Chest·Leather·197 Armor·+20 Agility·+35 Stamina·Classes: Rogue·Requires Level 60·Requires Warlord·Equip: Improves your chance to get a critical strike by 1%.· \
·Warlord's Vestments (6)·  Warlord's Leather Breastplate·  Warlord's Leather Helm·  Warlord's Leather Spaulders·  General's Leather Legguards·  General's Leather Mitts·  General's Leather Treads·",
		["c"] = "a335ee",
	},
	["19954:0:0:0"] = {
		["i"] = "Renataki's Charm of Trickery",
		["c"] = "a335ee",
		["t"] = "Renataki's Charm of Trickery·Binds when picked up·Unique·Trinket·Classes: Rogue·Requires Level 60·Use: Instantly increases your energy by 60.· \
·Madcap's Outfit (5)·  Zandalarian Shadow Mastery Talisman·  Renataki's Charm of Trickery·  Zandalar Madcap's Bracers·  Zandalar Madcap's Mantle·  Zandalar Madcap's Tunic·",
	},
	["19836:0:0:0"] = {
		["i"] = "Zandalar Madcap's Bracers",
		["c"] = "0070dd",
		["t"] = "Zandalar Madcap's Bracers·Binds when picked up·Wrist·Leather·82 Armor·+7 Strength·+14 Agility·+12 Stamina·Classes: Rogue· \
·Madcap's Outfit (5)·",
	},
	["19834:0:0:0"] = {
		["i"] = "Zandalar Madcap's Tunic",
		["t"] = "Zandalar Madcap's Tunic·Binds when picked up·Chest·Leather·197 Armor·+19 Stamina·Classes: Rogue·Equip: Improves your chance to get a critical strike by 2%.·Equip: +44 Attack Power.· \
·Madcap's Outfit (5)·  Zandalarian Shadow Mastery Talisman·  Renataki's Charm of Trickery·  Zandalar Madcap's Bracers·  Zandalar Madcap's Mantle·  Zandalar Madcap's Tunic·",
		["c"] = "a335ee",
	},
	["19617:0:0:0"] = {
		["i"] = "Zandalarian Shadow Mastery Talisman",
		["c"] = "a335ee",
		["t"] = "Zandalarian Shadow Mastery Talisman·Binds when picked up·Unique·Neck·+6 Strength·+15 Agility·+9 Stamina·Classes: Rogue·Equip: Decreases the cooldown of Kick by 0.5 sec.· \
·Madcap's Outfit (5)·  Zandalarian Shadow Mastery Talisman·  Renataki's Charm of Trickery·  Zandalar Madcap's Bracers·  Zandalar Madcap's Mantle·  Zandalar Madcap's Tunic·",
	},
	["19616:0:0:0"] = {
		["i"] = "Zandalarian Shadow Talisman",
		["t"] = "Zandalarian Shadow Talisman·Binds when picked up·Unique·Neck·+6 Strength·+15 Agility·+9 Stamina·Classes: Rogue·",
		["c"] = "0070dd",
	},
	["19615:0:0:0"] = {
		["i"] = "Zandalarian Shadow Talisman",
		["t"] = "Zandalarian Shadow Talisman·Binds when picked up·Unique·Neck·+6 Strength·+12 Agility·+7 Stamina·Classes: Rogue·",
		["c"] = "0070dd",
	},
	["19614:0:0:0"] = {
		["i"] = "Zandalarian Shadow Talisman",
		["t"] = "Zandalarian Shadow Talisman·Binds when picked up·Unique·Neck·+12 Agility·+7 Stamina·Classes: Rogue·",
		["c"] = "1eff00",
	},
	["19835:0:0:0"] = {
		["i"] = "Zandalar Madcap's Mantle",
		["c"] = "0070dd",
		["t"] = "Zandalar Madcap's Mantle·Binds when picked up·Shoulder·Leather·141 Armor·+20 Agility·+12 Stamina·Classes: Rogue·Equip: Improves your chance to hit by 1%.· \
·Madcap's Outfit (5)·  Zandalarian Shadow Mastery Talisman·  Renataki's Charm of Trickery·  Zandalar Madcap's Bracers·  Zandalar Madcap's Mantle·  Zandalar Madcap's Tunic·",
	},
	["16668:0:0:0"] = {
		["i"] = "Kilt of Elements",
		["c"] = "0070dd",
		["t"] = "Kilt of Elements·Binds when picked up·Legs·Mail·315 Armor·+12 Strength·+6 Agility·+7 Stamina·+15 Intellect·+20 Spirit·Requires Level 56· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
	},
	["16666:0:0:0"] = {
		["i"] = "Vest of Elements",
		["c"] = "0070dd",
		["t"] = "Vest of Elements·Binds when picked up·Chest·Mail·370 Armor·+13 Stamina·+20 Intellect·+20 Spirit·Requires Level 58· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
	},
	["16669:0:0:0"] = {
		["i"] = "Pauldrons of Elements",
		["c"] = "0070dd",
		["t"] = "Pauldrons of Elements·Binds when picked up·Shoulder·Mail·266 Armor·+6 Strength·+14 Stamina·+15 Intellect·+6 Spirit·Requires Level 55· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
	},
	["16673:0:0:0"] = {
		["i"] = "Cord of Elements",
		["c"] = "0070dd",
		["t"] = "Cord of Elements·Binds when equipped·Waist·Mail·193 Armor·+9 Strength·+6 Stamina·+17 Intellect·+7 Spirit·Requires Level 53· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
	},
	["16670:0:0:0"] = {
		["i"] = "Boots of Elements",
		["t"] = "Boots of Elements·Binds when picked up·Feet·Mail·240 Armor·+9 Agility·+17 Spirit·Requires Level 54· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
		["c"] = "0070dd",
	},
	["16667:0:0:0"] = {
		["i"] = "Coif of Elements",
		["c"] = "0070dd",
		["t"] = "Coif of Elements·Binds when picked up·Head·Mail·297 Armor·+7 Strength·+13 Stamina·+23 Intellect·+12 Spirit·Requires Level 57· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
	},
	["16671:0:0:0"] = {
		["i"] = "Bindings of Elements",
		["c"] = "0070dd",
		["t"] = "Bindings of Elements·Binds when equipped·Wrist·Mail·148 Armor·+7 Stamina·+10 Intellect·+10 Spirit·Requires Level 52· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
	},
	["16672:0:0:0"] = {
		["i"] = "Gauntlets of Elements",
		["c"] = "0070dd",
		["t"] = "Gauntlets of Elements·Binds when picked up·Hands·Mail·218 Armor·+9 Strength·+4 Stamina·+10 Intellect·+16 Spirit·Requires Level 54· \
·The Elements (8)·  Cord of Elements·  Boots of Elements·  Bindings of Elements·  Coif of Elements·  Gauntlets of Elements·  Kilt of Elements·  Pauldrons of Elements·  Vest of Elements·",
	},
	["16843:0:0:0"] = {
		["i"] = "Earthfury Legguards",
		["c"] = "a335ee",
		["t"] = "Earthfury Legguards·Binds when picked up·Legs·Mail·369 Armor·+18 Stamina·+19 Intellect·+21 Spirit·+10 Shadow Resistance·Classes: Shaman·Requires Level 60·Equip: Restores 6 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
	},
	["16841:0:0:0"] = {
		["i"] = "Earthfury Vestments",
		["c"] = "a335ee",
		["t"] = "Earthfury Vestments·Binds when picked up·Chest·Mail·422 Armor·+17 Stamina·+27 Intellect·+13 Spirit·+10 Fire Resistance·Classes: Shaman·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases healing done by spells and effects by up to 22.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
	},
	["16844:0:0:0"] = {
		["i"] = "Earthfury Epaulets",
		["t"] = "Earthfury Epaulets·Binds when picked up·Shoulder·Mail·317 Armor·+17 Stamina·+18 Intellect·+10 Spirit·+7 Shadow Resistance·Classes: Shaman·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 18.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
		["c"] = "a335ee",
	},
	["16838:0:0:0"] = {
		["i"] = "Earthfury Belt",
		["c"] = "a335ee",
		["t"] = "Earthfury Belt·Binds when equipped·Waist·Mail·237 Armor·+12 Stamina·+21 Intellect·+7 Spirit·+7 Fire Resistance·Classes: Shaman·Requires Level 60·Equip: Restores 4 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 18.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
	},
	["16837:0:0:0"] = {
		["i"] = "Earthfury Boots",
		["c"] = "a335ee",
		["t"] = "Earthfury Boots·Binds when picked up·Feet·Mail·290 Armor·+15 Stamina·+10 Intellect·+22 Spirit·+7 Shadow Resistance·Classes: Shaman·Requires Level 60·Equip: Increases healing done by spells and effects by up to 18.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
	},
	["16839:0:0:0"] = {
		["i"] = "Earthfury Gauntlets",
		["c"] = "a335ee",
		["t"] = "Earthfury Gauntlets·Binds when picked up·Hands·Mail·264 Armor·+14 Stamina·+13 Intellect·+15 Spirit·+7 Fire Resistance·Classes: Shaman·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
	},
	["16842:0:0:0"] = {
		["i"] = "Earthfury Helmet",
		["c"] = "a335ee",
		["t"] = "Earthfury Helmet·Binds when picked up·Head·Mail·343 Armor·+24 Stamina·+23 Intellect·+13 Spirit·+10 Fire Resistance·Classes: Shaman·Requires Level 60·Equip: Restores 6 mana per 5 sec.·Equip: Increases healing done by spells and effects by up to 22.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
	},
	["16840:0:0:0"] = {
		["i"] = "Earthfury Bracers",
		["c"] = "a335ee",
		["t"] = "Earthfury Bracers·Binds when equipped·Wrist·Mail·185 Armor·+10 Stamina·+17 Intellect·+11 Spirit·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 6.· \
·The Earthfury (8)·  Earthfury Belt·  Earthfury Boots·  Earthfury Bracers·  Earthfury Vestments·  Earthfury Epaulets·  Earthfury Gauntlets·  Earthfury Helmet·  Earthfury Legguards·",
	},
	["16946:0:0:0"] = {
		["i"] = "Legplates of Ten Storms",
		["c"] = "a335ee",
		["t"] = "Legplates of Ten Storms·Binds when picked up·Legs·Mail·422 Armor·+16 Stamina·+18 Intellect·+20 Spirit·+10 Arcane Resistance·+10 Fire Resistance·Classes: Shaman·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 29.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
	},
	["16943:0:0:0"] = {
		["i"] = "Bracers of Ten Storms",
		["c"] = "a335ee",
		["t"] = "Bracers of Ten Storms·Binds when picked up·Wrist·Mail·211 Armor·+13 Stamina·+16 Intellect·+9 Spirit·Classes: Shaman·Requires Level 60·Equip: Restores 6 mana per 5 sec.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
	},
	["16945:0:0:0"] = {
		["i"] = "Epaulets of Ten Storms",
		["t"] = "Epaulets of Ten Storms·Binds when picked up·Shoulder·Mail·362 Armor·+23 Stamina·+17 Intellect·+8 Spirit·+10 Fire Resistance·Classes: Shaman·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
		["c"] = "a335ee",
	},
	["16947:0:0:0"] = {
		["i"] = "Helmet of Ten Storms",
		["c"] = "a335ee",
		["t"] = "Helmet of Ten Storms·Binds when picked up·Head·Mail·392 Armor·+20 Stamina·+24 Intellect·+12 Spirit·+10 Frost Resistance·+10 Shadow Resistance·Classes: Shaman·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 9.·Equip: Increases healing done by spells and effects by up to 18.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
	},
	["16950:0:0:0"] = {
		["i"] = "Breastplate of Ten Storms",
		["c"] = "a335ee",
		["t"] = "Breastplate of Ten Storms·Binds when picked up·Chest·Mail·482 Armor·+17 Stamina·+31 Intellect·+16 Spirit·+10 Fire Resistance·+10 Nature Resistance·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 23.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
	},
	["16949:0:0:0"] = {
		["i"] = "Greaves of Ten Storms",
		["c"] = "a335ee",
		["t"] = "Greaves of Ten Storms·Binds when picked up·Feet·Mail·332 Armor·+17 Stamina·+16 Intellect·+16 Spirit·+10 Fire Resistance·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
	},
	["16944:0:0:0"] = {
		["i"] = "Belt of Ten Storms",
		["t"] = "Belt of Ten Storms·Binds when picked up·Waist·Mail·271 Armor·+13 Stamina·+18 Intellect·+11 Spirit·+10 Shadow Resistance·Classes: Shaman·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases healing done by spells and effects by up to 26.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
		["c"] = "a335ee",
	},
	["16948:0:0:0"] = {
		["i"] = "Gauntlets of Ten Storms",
		["c"] = "a335ee",
		["t"] = "Gauntlets of Ten Storms·Binds when picked up·Hands·Mail·301 Armor·+15 Stamina·+17 Intellect·+13 Spirit·+10 Shadow Resistance·Classes: Shaman·Requires Level 60·Equip: Restores 6 mana per 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 8.·Equip: Increases healing done by spells and effects by up to 15.· \
·The Ten Storms (8)·  Belt of Ten Storms·  Bracers of Ten Storms·  Breastplate of Ten Storms·  Epaulets of Ten Storms·  Gauntlets of Ten Storms·  Greaves of Ten Storms·  Helmet of Ten Storms·  Legplates of Ten Storms·",
	},
	["16518:0:0:0"] = {
		["i"] = "Blood Guard's Mail Walkers",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Mail Walkers·Binds when picked up·Unique·Feet·Mail·255 Armor·+14 Stamina·+10 Intellect·Classes: Shaman·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 14.·Equip: Increases the speed of your Ghost Wolf ability by 15%.· \
·Champion's Earthshaker (6)·  Blood Guard's Mail Grips·  Blood Guard's Mail Walkers·  Legionnaire's Mail Chestpiece·  Legionnaire's Mail Legguards·  Champion's Mail Helm·  Champion's Mail Shoulders·",
	},
	["16521:0:0:0"] = {
		["i"] = "Champion's Mail Helm",
		["t"] = "Champion's Mail Helm·Binds when picked up·Unique·Head·Mail·301 Armor·+8 Strength·+25 Stamina·+9 Intellect·Classes: Shaman·Requires Level 58·Requires Champion·Equip: Improves your chance to get a critical strike by 1%.· \
·Champion's Earthshaker (6)·  Blood Guard's Mail Grips·  Blood Guard's Mail Walkers·  Legionnaire's Mail Chestpiece·  Legionnaire's Mail Legguards·  Champion's Mail Helm·  Champion's Mail Shoulders·",
		["c"] = "0070dd",
	},
	["16523:0:0:0"] = {
		["i"] = "Legionnaire's Mail Legguards",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Mail Legguards·Binds when picked up·Unique·Legs·Mail·324 Armor·+5 Agility·+20 Stamina·+11 Intellect·Classes: Shaman·Requires Level 58·Requires Legionnaire·Equip: Increases damage and healing done by magical spells and effects by up to 25.· \
·Champion's Earthshaker (6)·  Blood Guard's Mail Grips·  Blood Guard's Mail Walkers·  Legionnaire's Mail Chestpiece·  Legionnaire's Mail Legguards·  Champion's Mail Helm·  Champion's Mail Shoulders·",
	},
	["16522:0:0:0"] = {
		["i"] = "Legionnaire's Mail Chestpiece",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Mail Chestpiece·Binds when picked up·Unique·Chest·Mail·370 Armor·+20 Stamina·+20 Intellect·Classes: Shaman·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike by 1%.· \
·Champion's Earthshaker (6)·  Blood Guard's Mail Grips·  Blood Guard's Mail Walkers·  Legionnaire's Mail Chestpiece·  Legionnaire's Mail Legguards·  Champion's Mail Helm·  Champion's Mail Shoulders·",
	},
	["16524:0:0:0"] = {
		["i"] = "Champion's Mail Shoulders",
		["t"] = "Champion's Mail Shoulders·Binds when picked up·Unique·Shoulder·Mail·278 Armor·+5 Strength·+5 Agility·+16 Stamina·+15 Intellect·Classes: Shaman·Requires Level 58·Requires Champion·Equip: Increases damage and healing done by magical spells and effects by up to 6.· \
·Champion's Earthshaker (6)·  Blood Guard's Mail Grips·  Blood Guard's Mail Walkers·  Legionnaire's Mail Chestpiece·  Legionnaire's Mail Legguards·  Champion's Mail Helm·  Champion's Mail Shoulders·",
		["c"] = "0070dd",
	},
	["16519:0:0:0"] = {
		["i"] = "Blood Guard's Mail Grips",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Mail Grips·Binds when picked up·Unique·Hands·Mail·231 Armor·+6 Strength·+15 Stamina·+7 Intellect·Classes: Shaman·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Champion's Earthshaker (6)·  Blood Guard's Mail Grips·  Blood Guard's Mail Walkers·  Legionnaire's Mail Chestpiece·  Legionnaire's Mail Legguards·  Champion's Mail Helm·  Champion's Mail Shoulders·",
	},
	["16573:0:0:0"] = {
		["i"] = "General's Mail Boots",
		["t"] = "General's Mail Boots·Binds when picked up·Unique·Feet·Mail·286 Armor·+18 Stamina·+17 Intellect·Classes: Shaman·Requires Level 60·Requires General·Equip: Increases the speed of your Ghost Wolf ability by 15%.·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Warlord's Earthshaker (6)·  Warlord's Mail Armor·  Warlord's Mail Helm·  Warlord's Mail Spaulders·  General's Mail Boots·  General's Mail Gauntlets·  General's Mail Leggings·",
		["c"] = "a335ee",
	},
	["16579:0:0:0"] = {
		["i"] = "General's Mail Leggings",
		["c"] = "a335ee",
		["t"] = "General's Mail Leggings·Binds when picked up·Unique·Legs·Mail·364 Armor·+15 Agility·+23 Stamina·+19 Intellect·Classes: Shaman·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 28.· \
·Warlord's Earthshaker (6)·  Warlord's Mail Armor·  Warlord's Mail Helm·  Warlord's Mail Spaulders·  General's Mail Boots·  General's Mail Gauntlets·  General's Mail Leggings·",
	},
	["16577:0:0:0"] = {
		["i"] = "Warlord's Mail Armor",
		["c"] = "a335ee",
		["t"] = "Warlord's Mail Armor·Binds when picked up·Unique·Chest·Mail·416 Armor·+35 Stamina·+20 Intellect·Classes: Shaman·Requires Level 60·Requires Warlord·Equip: Improves your chance to get a critical strike by 1%.· \
·Warlord's Earthshaker (6)·  Warlord's Mail Armor·  Warlord's Mail Helm·  Warlord's Mail Spaulders·  General's Mail Boots·  General's Mail Gauntlets·  General's Mail Leggings·",
	},
	["16578:0:0:0"] = {
		["i"] = "Warlord's Mail Helm",
		["c"] = "a335ee",
		["t"] = "Warlord's Mail Helm·Binds when picked up·Unique·Head·Mail·338 Armor·+10 Strength·+35 Stamina·+11 Intellect·Classes: Shaman·Requires Level 60·Requires Warlord·Equip: Improves your chance to get a critical strike by 1%.· \
·Warlord's Earthshaker (6)·  Warlord's Mail Armor·  Warlord's Mail Helm·  Warlord's Mail Spaulders·  General's Mail Boots·  General's Mail Gauntlets·  General's Mail Leggings·",
	},
	["16580:0:0:0"] = {
		["i"] = "Warlord's Mail Spaulders",
		["c"] = "a335ee",
		["t"] = "Warlord's Mail Spaulders·Binds when picked up·Unique·Shoulder·Mail·312 Armor·+11 Strength·+8 Agility·+18 Stamina·+17 Intellect·Classes: Shaman·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 8.· \
·Warlord's Earthshaker (6)·  Warlord's Mail Armor·  Warlord's Mail Helm·  Warlord's Mail Spaulders·  General's Mail Boots·  General's Mail Gauntlets·  General's Mail Leggings·",
	},
	["16574:0:0:0"] = {
		["i"] = "General's Mail Gauntlets",
		["t"] = "General's Mail Gauntlets·Binds when picked up·Unique·Hands·Mail·260 Armor·+11 Strength·+17 Stamina·+15 Intellect·Classes: Shaman·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Warlord's Earthshaker (6)·  Warlord's Mail Armor·  Warlord's Mail Helm·  Warlord's Mail Spaulders·  General's Mail Boots·  General's Mail Gauntlets·  General's Mail Leggings·",
		["c"] = "a335ee",
	},
	["19609:0:0:0"] = {
		["i"] = "Unmarred Vision of Voodress",
		["t"] = "Unmarred Vision of Voodress·Binds when picked up·Unique·Neck·+6 Strength·+10 Stamina·+10 Intellect·+9 Spirit·Classes: Shaman·Equip: Decreases the mana cost of your Healing Stream and Mana Spring totems by 20.· \
·Augur's Regalia (5)·  Unmarred Vision of Voodress·  Wushoolay's Charm of Spirits·  Zandalar Augur's Bracers·  Zandalar Augur's Belt·  Zandalar Augur's Hauberk·",
		["c"] = "a335ee",
	},
	["19608:0:0:0"] = {
		["i"] = "Vision of Voodress",
		["c"] = "0070dd",
		["t"] = "Vision of Voodress·Binds when picked up·Unique·Neck·+6 Strength·+10 Stamina·+10 Intellect·+9 Spirit·Classes: Shaman·",
	},
	["19607:0:0:0"] = {
		["i"] = "Vision of Voodress",
		["c"] = "0070dd",
		["t"] = "Vision of Voodress·Binds when picked up·Unique·Neck·+6 Strength·+8 Stamina·+8 Intellect·+7 Spirit·Classes: Shaman·",
	},
	["19606:0:0:0"] = {
		["i"] = "Vision of Voodress",
		["c"] = "1eff00",
		["t"] = "Vision of Voodress·Binds when picked up·Unique·Neck·+8 Stamina·+8 Intellect·+7 Spirit·Classes: Shaman·",
	},
	["19830:0:0:0"] = {
		["i"] = "Zandalar Augur's Bracers",
		["t"] = "Zandalar Augur's Bracers·Binds when picked up·Wrist·Mail·174 Armor·+12 Stamina·+11 Intellect·Classes: Shaman·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Augur's Regalia (5)·  Unmarred Vision of Voodress·  Wushoolay's Charm of Spirits·  Zandalar Augur's Bracers·  Zandalar Augur's Belt·  Zandalar Augur's Hauberk·",
		["c"] = "0070dd",
	},
	["19828:0:0:0"] = {
		["i"] = "Zandalar Augur's Hauberk",
		["t"] = "Zandalar Augur's Hauberk·Binds when picked up·Chest·Mail·416 Armor·+19 Stamina·+15 Intellect·Classes: Shaman·Equip: Increases damage and healing done by magical spells and effects by up to 34.·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Augur's Regalia (5)·  Unmarred Vision of Voodress·  Wushoolay's Charm of Spirits·  Zandalar Augur's Bracers·  Zandalar Augur's Belt·  Zandalar Augur's Hauberk·",
		["c"] = "a335ee",
	},
	["19829:0:0:0"] = {
		["i"] = "Zandalar Augur's Belt",
		["t"] = "Zandalar Augur's Belt·Binds when picked up·Waist·Mail·224 Armor·+10 Stamina·+21 Intellect·Classes: Shaman·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Augur's Regalia (5)·  Unmarred Vision of Voodress·  Wushoolay's Charm of Spirits·  Zandalar Augur's Bracers·  Zandalar Augur's Belt·  Zandalar Augur's Hauberk·",
		["c"] = "0070dd",
	},
	["19956:0:0:0"] = {
		["i"] = "Wushoolay's Charm of Spirits",
		["c"] = "a335ee",
		["t"] = "Wushoolay's Charm of Spirits·Binds when picked up·Unique·Trinket·Classes: Shaman·Requires Level 60·Use: Increases the damage dealt by your Lightning Shield spell by 100% for 20 seconds.· \
·Augur's Regalia (5)·  Unmarred Vision of Voodress·  Wushoolay's Charm of Spirits·  Zandalar Augur's Bracers·  Zandalar Augur's Belt·  Zandalar Augur's Hauberk·",
	},
	["16701:0:0:0"] = {
		["i"] = "Dreadmist Mantle",
		["c"] = "0070dd",
		["t"] = "Dreadmist Mantle·Binds when picked up·Shoulder·Cloth·64 Armor·+14 Stamina·+15 Intellect·+9 Spirit·Requires Level 55· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·",
	},
	["16698:0:0:0"] = {
		["i"] = "Dreadmist Mask",
		["c"] = "0070dd",
		["t"] = "Dreadmist Mask·Binds when picked up·Head·Cloth·71 Armor·+15 Stamina·+23 Intellect·+12 Spirit·Requires Level 57· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·",
	},
	["16702:0:0:0"] = {
		["i"] = "Dreadmist Belt",
		["t"] = "Dreadmist Belt·Binds when equipped·Waist·Cloth·46 Armor·+10 Stamina·+17 Intellect·+9 Spirit·Requires Level 53· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·",
		["c"] = "0070dd",
	},
	["16704:0:0:0"] = {
		["i"] = "Dreadmist Sandals",
		["c"] = "0070dd",
		["t"] = "Dreadmist Sandals·Binds when picked up·Feet·Cloth·58 Armor·+17 Stamina·+9 Intellect·+10 Spirit·Requires Level 54· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·Set: +4 Fire Resistance.·Set: +4 Shadow Resistance.·",
	},
	["16699:0:0:0"] = {
		["i"] = "Dreadmist Leggings",
		["c"] = "0070dd",
		["t"] = "Dreadmist Leggings·Binds when picked up·Legs·Cloth·76 Armor·+15 Stamina·+14 Intellect·+21 Spirit·Requires Level 56· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·Set: +4 Fire Resistance.·Set: +4 Shadow Resistance.·",
	},
	["16700:0:0:0"] = {
		["i"] = "Dreadmist Robe",
		["t"] = "Dreadmist Robe·Binds when picked up·Chest·Cloth·89 Armor·+20 Stamina·+21 Intellect·+13 Spirit·Requires Level 58· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·",
		["c"] = "0070dd",
	},
	["16703:0:0:0"] = {
		["i"] = "Dreadmist Bracers",
		["c"] = "0070dd",
			["t"] = "Dreadmist Bracers·Binds when equipped·Wrist·Cloth·35 Armor·+10 Stamina·+10 Intellect·+7 Spirit·Requires Level 52· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·",
	},
	["16705:0:0:0"] = {
		["i"] = "Dreadmist Wraps",
		["t"] = "Dreadmist Wraps·Binds when equipped·Hands·Cloth·52 Armor·+13 Stamina·+9 Intellect·+14 Spirit·Requires Level 54· \
·Dreadmist Raiment (8)·  Dreadmist Belt·  Dreadmist Bracers·  Dreadmist Leggings·  Dreadmist Mantle·  Dreadmist Robe·  Dreadmist Sandals·  Dreadmist Mask·  Dreadmist Wraps·",
		["c"] = "0070dd",
	},
	["16808:0:0:0"] = {
		["i"] = "Felheart Horns",
		["t"] = "Felheart Horns·Binds when picked up·Head·Cloth·83 Armor·+27 Stamina·+20 Intellect·+10 Spirit·+10 Fire Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
		["c"] = "a335ee",
	},
	["16803:0:0:0"] = {
		["i"] = "Felheart Slippers",
		["c"] = "a335ee",
		["t"] = "Felheart Slippers·Binds when picked up·Feet·Cloth·70 Armor·+23 Stamina·+11 Intellect·+7 Shadow Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 18.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
	},
	["16806:0:0:0"] = {
		["i"] = "Felheart Belt",
		["c"] = "a335ee",
		["t"] = "Felheart Belt·Binds when equipped·Waist·Cloth·57 Armor·+18 Stamina·+15 Intellect·+8 Spirit·+7 Fire Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
	},
	["16804:0:0:0"] = {
		["i"] = "Felheart Bracers",
		["c"] = "a335ee",
		["t"] = "Felheart Bracers·Binds when equipped·Wrist·Cloth·44 Armor·+18 Stamina·+11 Intellect·+8 Spirit·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
	},
	["16807:0:0:0"] = {
		["i"] = "Felheart Shoulder Pads",
		["c"] = "a335ee",
		["t"] = "Felheart Shoulder Pads·Binds when picked up·Shoulder·Cloth·76 Armor·+25 Stamina·+17 Intellect·+7 Spirit·+7 Shadow Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
	},
	["16805:0:0:0"] = {
		["i"] = "Felheart Gloves",
		["t"] = "Felheart Gloves·Binds when picked up·Hands·Cloth·63 Armor·+18 Stamina·+15 Intellect·+8 Spirit·+7 Fire Resistance·Classes: Warlock·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
		["c"] = "a335ee",
	},
	["16809:0:0:0"] = {
		["i"] = "Felheart Robes",
		["c"] = "a335ee",
		["t"] = "Felheart Robes·Binds when picked up·Chest·Cloth·102 Armor·+31 Stamina·+20 Intellect·+10 Fire Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 13.·Use: Improves your chance to hit with spells by 1%.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
	},
	["16810:0:0:0"] = {
		["i"] = "Felheart Pants",
		["c"] = "a335ee",
		["t"] = "Felheart Pants·Binds when picked up·Legs·Cloth·89 Armor·+20 Stamina·+19 Intellect·+10 Spirit·+10 Shadow Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 30.· \
·Felheart Raiment (8)·  Felheart Belt·  Felheart Bracers·  Felheart Gloves·  Felheart Pants·  Felheart Robes·  Felheart Shoulder Pads·  Felheart Horns·  Felheart Slippers·",
	},
	["16934:0:0:0"] = {
		["i"] = "Nemesis Bracers",
		["c"] = "a335ee",
		["t"] = "Nemesis Bracers·Binds when picked up·Wrist·Cloth·51 Armor·+21 Stamina·+11 Intellect·+6 Spirit·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 15.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
	},
	["16928:0:0:0"] = {
		["i"] = "Nemesis Gloves",
		["c"] = "a335ee",
		["t"] = "Nemesis Gloves·Binds when picked up·Hands·Cloth·72 Armor·+17 Stamina·+15 Intellect·+10 Shadow Resistance·Classes: Warlock·Requires Level 60·Equip: Restores 3 health every 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 15.·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
	},
	["16927:0:0:0"] = {
		["i"] = "Nemesis Boots",
		["c"] = "a335ee",
		["t"] = "Nemesis Boots·Binds when picked up·Feet·Cloth·80 Armor·+20 Stamina·+17 Intellect·+6 Spirit·+10 Fire Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 23.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
	},
	["16929:0:0:0"] = {
		["i"] = "Nemesis Skullcap",
		["c"] = "a335ee",
		["t"] = "Nemesis Skullcap·Binds when picked up·Head·Cloth·94 Armor·+26 Stamina·+16 Intellect·+6 Spirit·+10 Frost Resistance·+10 Shadow Resistance·Classes: Warlock·Requires Level 60·Equip: Restores 3 health every 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 32.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
	},
	["16930:0:0:0"] = {
		["i"] = "Nemesis Leggings",
		["c"] = "a335ee",
		["t"] = "Nemesis Leggings·Binds when picked up·Legs·Cloth·101 Armor·+23 Stamina·+16 Intellect·+4 Spirit·+10 Arcane Resistance·+10 Fire Resistance·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 39.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
	},
	["16933:0:0:0"] = {
		["i"] = "Nemesis Belt",
		["c"] = "a335ee",
		["t"] = "Nemesis Belt·Binds when picked up·Waist·Cloth·65 Armor·+18 Stamina·+8 Intellect·+6 Spirit·+10 Shadow Resistance·Classes: Warlock·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 25.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
	},
	["16932:0:0:0"] = {
		["i"] = "Nemesis Spaulders",
		["t"] = "Nemesis Spaulders·Binds when picked up·Shoulder·Cloth·87 Armor·+20 Stamina·+13 Intellect·+6 Spirit·+10 Fire Resistance·Classes: Warlock·Requires Level 60·Equip: Restores 3 health every 5 sec.·Equip: Increases damage and healing done by magical spells and effects by up to 23.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
		["c"] = "a335ee",
	},
	["16931:0:0:0"] = {
		["i"] = "Nemesis Robes",
		["c"] = "a335ee",
		["t"] = "Nemesis Robes·Binds when picked up·Chest·Cloth·116 Armor·+26 Stamina·+16 Intellect·+8 Spirit·+10 Fire Resistance·+10 Nature Resistance·Classes: Warlock·Requires Level 60·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 32.· \
·Nemesis Raiment (8)·  Nemesis Belt·  Nemesis Boots·  Nemesis Bracers·  Nemesis Gloves·  Nemesis Leggings·  Nemesis Robes·  Nemesis Skullcap·  Nemesis Spaulders·",
	},
	["17569:0:0:0"] = {
		["i"] = "Lieutenant Commander's Dreadweave Mantle",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Dreadweave Mantle·Binds when picked up·Unique·Shoulder·Cloth·67 Armor·+16 Stamina·+15 Intellect·Classes: Warlock·Requires Level 58·Requires Lieutenant Commander·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Lieutenant Commander's Threads (6)·  Knight-Lieutenant's Dreadweave Boots·  Knight-Lieutenant's Dreadweave Gloves·  Knight-Captain's Dreadweave Robe·  Knight-Captain's Dreadweave Leggings·  Lieutenant Commander's Dreadweave Mantle·  Lieutenant Commander's Headguard·",
	},
	["17568:0:0:0"] = {
		["i"] = "Knight-Captain's Dreadweave Robe",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Dreadweave Robe·Binds when picked up·Unique·Chest·Cloth·89 Armor·+20 Stamina·+20 Intellect·Classes: Warlock·Requires Level 58·Requires Knight-Captain·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Lieutenant Commander's Threads (6)·  Knight-Lieutenant's Dreadweave Boots·  Knight-Lieutenant's Dreadweave Gloves·  Knight-Captain's Dreadweave Robe·  Knight-Captain's Dreadweave Leggings·  Lieutenant Commander's Dreadweave Mantle·  Lieutenant Commander's Headguard·",
	},
	["17567:0:0:0"] = {
		["i"] = "Knight-Captain's Dreadweave Leggings",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Dreadweave Leggings·Binds when picked up·Unique·Legs·Cloth·78 Armor·+21 Stamina·+20 Intellect·Classes: Warlock·Requires Level 58·Requires Knight-Captain·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Lieutenant Commander's Threads (6)·  Knight-Lieutenant's Dreadweave Boots·  Knight-Lieutenant's Dreadweave Gloves·  Knight-Captain's Dreadweave Robe·  Knight-Captain's Dreadweave Leggings·  Lieutenant Commander's Dreadweave Mantle·  Lieutenant Commander's Headguard·",
	},
	["17566:0:0:0"] = {
		["i"] = "Lieutenant Commander's Headguard",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Headguard·Binds when picked up·Unique·Head·Cloth·73 Armor·+20 Stamina·+20 Intellect·Classes: Warlock·Requires Level 58·Requires Lieutenant Commander·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Lieutenant Commander's Threads (6)·  Knight-Lieutenant's Dreadweave Boots·  Knight-Lieutenant's Dreadweave Gloves·  Knight-Captain's Dreadweave Robe·  Knight-Captain's Dreadweave Leggings·  Lieutenant Commander's Dreadweave Mantle·  Lieutenant Commander's Headguard·",
	},
	["17562:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Dreadweave Boots",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Dreadweave Boots·Binds when picked up·Unique·Feet·Cloth·61 Armor·+10 Stamina·+15 Intellect·Classes: Warlock·Requires Level 58·Requires Knight-Lieutenant·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Lieutenant Commander's Threads (6)·  Knight-Lieutenant's Dreadweave Boots·  Knight-Lieutenant's Dreadweave Gloves·  Knight-Captain's Dreadweave Robe·  Knight-Captain's Dreadweave Leggings·  Lieutenant Commander's Dreadweave Mantle·  Lieutenant Commander's Headguard·",
	},
	["17564:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Dreadweave Gloves",
		["c"] = "0070dd",
		["t"] = "Knight-Lieutenant's Dreadweave Gloves·Binds when picked up·Unique·Hands·Cloth·56 Armor·+18 Stamina·+11 Intellect·Classes: Warlock·Requires Level 58·Requires Knight-Lieutenant·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Searing Pain.· \
·Lieutenant Commander's Threads (6)·  Knight-Lieutenant's Dreadweave Boots·  Knight-Lieutenant's Dreadweave Gloves·  Knight-Captain's Dreadweave Robe·  Knight-Captain's Dreadweave Leggings·  Lieutenant Commander's Dreadweave Mantle·  Lieutenant Commander's Headguard·",
	},
	["17572:0:0:0"] = {
		["i"] = "Legionnaire's Dreadweave Robe",
		["c"] = "0070dd",
		["t"] = "Legionnaire's Dreadweave Robe·Binds when picked up·Unique·Chest·Cloth·89 Armor·+20 Stamina·+20 Intellect·Classes: Warlock·Requires Level 58·Requires Legionnaire·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Champion's Threads (6)·  Blood Guard's Dreadweave Boots·  Blood Guard's Dreadweave Gloves·  Legionnaire's Dreadweave Robe·  Legionnaire's Dreadweave Leggings·  Champion's Dreadweave Hood·  Champion's Dreadweave Shoulders·",
	},
	["Blood Guard's Dreadweave Boots"] = {
		["i"] = "17576:0:0:0",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Dreadweave Boots·Binds when picked up·Unique·Feet·Cloth·61 Armor·+16 Stamina·+15 Intellect·Classes: Warlock·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Champion's Threads (6)·  Blood Guard's Dreadweave Boots·  Blood Guard's Dreadweave Gloves·  Legionnaire's Dreadweave Robe·  Legionnaire's Dreadweave Leggings·  Champion's Dreadweave Hood·  Champion's Dreadweave Shoulders·",
	},
	["17570:0:0:0"] = {
		["i"] = "Champion's Dreadweave Hood",
		["c"] = "0070dd",
		["t"] = "Champion's Dreadweave Hood·Binds when picked up·Unique·Head·Cloth·73 Armor·+20 Stamina·+20 Intellect·Classes: Warlock·Requires Level 58·Requires Champion·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Champion's Threads (6)·  Blood Guard's Dreadweave Boots·  Blood Guard's Dreadweave Gloves·  Legionnaire's Dreadweave Robe·  Legionnaire's Dreadweave Leggings·  Champion's Dreadweave Hood·  Champion's Dreadweave Shoulders·",
	},
	["17571:0:0:0"] = {
		["i"] = "Legionnaire's Dreadweave Leggings",
		["t"] = "Legionnaire's Dreadweave Leggings·Binds when picked up·Unique·Legs·Cloth·78 Armor·+15 Stamina·+13 Intellect·Classes: Warlock·Requires Level 58·Requires Legionnaire·Equip: Increases damage and healing done by magical spells and effects by up to 28.· \
·Champion's Threads (6)·  Blood Guard's Dreadweave Boots·  Blood Guard's Dreadweave Gloves·  Legionnaire's Dreadweave Robe·  Legionnaire's Dreadweave Leggings·  Champion's Dreadweave Hood·  Champion's Dreadweave Shoulders·",
		["c"] = "0070dd",
	},
	["17573:0:0:0"] = {
		["i"] = "Champion's Dreadweave Shoulders",
		["c"] = "0070dd",
		["t"] = "Champion's Dreadweave Shoulders·Binds when picked up·Unique·Shoulder·Cloth·67 Armor·+16 Stamina·+15 Intellect·Classes: Warlock·Requires Level 58·Requires Champion·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Champion's Threads (6)·  Blood Guard's Dreadweave Boots·  Blood Guard's Dreadweave Gloves·  Legionnaire's Dreadweave Robe·  Legionnaire's Dreadweave Leggings·  Champion's Dreadweave Hood·  Champion's Dreadweave Shoulders·",
	},
	["17577:0:0:0"] = {
		["i"] = "Blood Guard's Dreadweave Gloves",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Dreadweave Gloves·Binds when picked up·Unique·Hands·Cloth·56 Armor·+11 Stamina·Classes: Warlock·Requires Level 58·Requires Blood Guard·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Searing Pain.·Equip: Increases damage and healing done by magical spells and effects by up to 21.· \
·Champion's Threads (6)·  Blood Guard's Dreadweave Boots·  Blood Guard's Dreadweave Gloves·  Legionnaire's Dreadweave Robe·  Legionnaire's Dreadweave Leggings·  Champion's Dreadweave Hood·  Champion's Dreadweave Shoulders·",
	},
	["17576:0:0:0"] = {
		["i"] = "Blood Guard's Dreadweave Boots",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Dreadweave Boots·Binds when picked up·Unique·Feet·Cloth·61 Armor·+16 Stamina·+15 Intellect·Classes: Warlock·Requires Level 58·Requires Blood Guard·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Champion's Threads (6)·  Blood Guard's Dreadweave Boots·  Blood Guard's Dreadweave Gloves·  Legionnaire's Dreadweave Robe·  Legionnaire's Dreadweave Leggings·  Champion's Dreadweave Hood·  Champion's Dreadweave Shoulders·",
	},
	["17583:0:0:0"] = {
		["i"] = "Marshal's Dreadweave Boots",
		["c"] = "a335ee",
		["t"] = "Marshal's Dreadweave Boots·Binds when picked up·Unique·Feet·Cloth·69 Armor·+21 Stamina·+21 Intellect·Classes: Warlock·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Field Marshal's Threads (6)·  Field Marshal's Dreadweave Robe·  Field Marshal's Dreadweave Shoulders·  Marshal's Dreadweave Boots·  Marshal's Dreadweave Gloves·  Marshal's Dreadweave Leggings·  Field Marshal's Coronal·",
	},
	["17578:0:0:0"] = {
		["i"] = "Field Marshal's Coronal",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Coronal·Binds when picked up·Unique·Head·Cloth·81 Armor·+28 Stamina·+24 Intellect·Classes: Warlock·Requires Level 60·Requires Field Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Field Marshal's Threads (6)·  Field Marshal's Dreadweave Robe·  Field Marshal's Dreadweave Shoulders·  Marshal's Dreadweave Boots·  Marshal's Dreadweave Gloves·  Marshal's Dreadweave Leggings·  Field Marshal's Coronal·",
	},
	["17579:0:0:0"] = {
		["i"] = "Marshal's Dreadweave Leggings",
		["c"] = "a335ee",
		["t"] = "Marshal's Dreadweave Leggings·Binds when picked up·Unique·Legs·Cloth·88 Armor·+23 Stamina·+16 Intellect·Classes: Warlock·Requires Level 60·Requires Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 35.· \
·Field Marshal's Threads (6)·  Field Marshal's Dreadweave Robe·  Field Marshal's Dreadweave Shoulders·  Marshal's Dreadweave Boots·  Marshal's Dreadweave Gloves·  Marshal's Dreadweave Leggings·  Field Marshal's Coronal·",
	},
	["17584:0:0:0"] = {
		["i"] = "Marshal's Dreadweave Gloves",
		["c"] = "a335ee",
		["t"] = "Marshal's Dreadweave Gloves·Binds when picked up·Unique·Hands·Cloth·63 Armor·+16 Stamina·Classes: Warlock·Requires Level 60·Requires Marshal·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Searing Pain.·Equip: Increases damage and healing done by magical spells and effects by up to 30.· \
·Field Marshal's Threads (6)·  Field Marshal's Dreadweave Robe·  Field Marshal's Dreadweave Shoulders·  Marshal's Dreadweave Boots·  Marshal's Dreadweave Gloves·  Marshal's Dreadweave Leggings·  Field Marshal's Coronal·",
	},
	["17581:0:0:0"] = {
		["i"] = "Field Marshal's Dreadweave Robe",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Dreadweave Robe·Binds when picked up·Unique·Chest·Cloth·100 Armor·+30 Stamina·+25 Intellect·Classes: Warlock·Requires Level 60·Requires Field Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Field Marshal's Threads (6)·  Field Marshal's Dreadweave Robe·  Field Marshal's Dreadweave Shoulders·  Marshal's Dreadweave Boots·  Marshal's Dreadweave Gloves·  Marshal's Dreadweave Leggings·  Field Marshal's Coronal·",
	},
	["17580:0:0:0"] = {
		["i"] = "Field Marshal's Dreadweave Shoulders",
		["t"] = "Field Marshal's Dreadweave Shoulders·Binds when picked up·Unique·Shoulder·Cloth·75 Armor·+22 Stamina·+17 Intellect·Classes: Warlock·Requires Level 60·Requires Field Marshal·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Field Marshal's Threads (6)·  Field Marshal's Dreadweave Robe·  Field Marshal's Dreadweave Shoulders·  Marshal's Dreadweave Boots·  Marshal's Dreadweave Gloves·  Marshal's Dreadweave Leggings·  Field Marshal's Coronal·",
		["c"] = "a335ee",
	},
	["17590:0:0:0"] = {
		["i"] = "Warlord's Dreadweave Mantle",
		["c"] = "a335ee",
		["t"] = "Warlord's Dreadweave Mantle·Binds when picked up·Unique·Shoulder·Cloth·75 Armor·+22 Stamina·+17 Intellect·Classes: Warlock·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Warlord's Threads (6)·  General's Dreadweave Boots·  General's Dreadweave Gloves·  General's Dreadweave Pants·  Warlord's Dreadweave Hood·  Warlord's Dreadweave Mantle·  Warlord's Dreadweave Robe·",
	},
	["17588:0:0:0"] = {
		["i"] = "General's Dreadweave Gloves",
		["c"] = "a335ee",
		["t"] = "General's Dreadweave Gloves·Binds when picked up·Unique·Hands·Cloth·63 Armor·+16 Stamina·Classes: Warlock·Requires Level 60·Requires General·Equip: Gives you a 50% chance to avoid interruption caused by damage while casting Searing Pain.·Equip: Increases damage and healing done by magical spells and effects by up to 30.· \
·Warlord's Threads (6)·  General's Dreadweave Boots·  General's Dreadweave Gloves·  General's Dreadweave Pants·  Warlord's Dreadweave Hood·  Warlord's Dreadweave Mantle·  Warlord's Dreadweave Robe·",
	},
	["17592:0:0:0"] = {
		["i"] = "Warlord's Dreadweave Robe",
		["c"] = "a335ee",
		["t"] = "Warlord's Dreadweave Robe·Binds when picked up·Unique·Chest·Cloth·100 Armor·+30 Stamina·+25 Intellect·Classes: Warlock·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Warlord's Threads (6)·  General's Dreadweave Boots·  General's Dreadweave Gloves·  General's Dreadweave Pants·  Warlord's Dreadweave Hood·  Warlord's Dreadweave Mantle·  Warlord's Dreadweave Robe·",
	},
	["17591:0:0:0"] = {
		["i"] = "Warlord's Dreadweave Hood",
		["c"] = "a335ee",
		["t"] = "Warlord's Dreadweave Hood·Binds when picked up·Unique·Head·Cloth·81 Armor·+28 Stamina·+24 Intellect·Classes: Warlock·Requires Level 60·Requires Warlord·Equip: Increases damage and healing done by magical spells and effects by up to 20.· \
·Warlord's Threads (6)·  General's Dreadweave Boots·  General's Dreadweave Gloves·  General's Dreadweave Pants·  Warlord's Dreadweave Hood·  Warlord's Dreadweave Mantle·  Warlord's Dreadweave Robe·",
	},
	["17593:0:0:0"] = {
		["i"] = "General's Dreadweave Pants",
		["c"] = "a335ee",
		["t"] = "General's Dreadweave Pants·Binds when picked up·Unique·Legs·Cloth·88 Armor·+23 Stamina·+16 Intellect·Classes: Warlock·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 35.· \
·Warlord's Threads (6)·  General's Dreadweave Boots·  General's Dreadweave Gloves·  General's Dreadweave Pants·  Warlord's Dreadweave Hood·  Warlord's Dreadweave Mantle·  Warlord's Dreadweave Robe·",
	},
	["17586:0:0:0"] = {
		["i"] = "General's Dreadweave Boots",
		["c"] = "a335ee",
		["t"] = "General's Dreadweave Boots·Binds when picked up·Unique·Feet·Cloth·69 Armor·+21 Stamina·+21 Intellect·Classes: Warlock·Requires Level 60·Requires General·Equip: Increases damage and healing done by magical spells and effects by up to 13.· \
·Warlord's Threads (6)·  General's Dreadweave Boots·  General's Dreadweave Gloves·  General's Dreadweave Pants·  Warlord's Dreadweave Hood·  Warlord's Dreadweave Mantle·  Warlord's Dreadweave Robe·",
	},
	["20033:0:0:0"] = {
		["i"] = "Zandalar Demoniac's Robe",
		["c"] = "a335ee",
		["t"] = "Zandalar Demoniac's Robe·Binds when picked up·Chest·Cloth·100 Armor·+35 Stamina·Classes: Warlock·Equip: Improves your chance to hit with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 27.· \
·Demoniac's Threads (5)·  Kezan's Unstoppable Taint·  Hazza'rah's Charm of Destruction·  Zandalar Demoniac's Wraps·  Zandalar Demoniac's Mantle·  Zandalar Demoniac's Robe·",
	},
	["19848:0:0:0"] = {
		["i"] = "Zandalar Demoniac's Wraps",
		["c"] = "0070dd",
		["t"] = "Zandalar Demoniac's Wraps·Binds when picked up·Wrist·Cloth·42 Armor·+15 Stamina·Classes: Warlock·Equip: Increases damage and healing done by magical spells and effects by up to 16.· \
·Demoniac's Threads (5)·",
	},
	["19957:0:0:0"] = {
		["i"] = "Hazza'rah's Charm of Destruction",
		["c"] = "a335ee",
		["t"] = "Hazza'rah's Charm of Destruction·Binds when picked up·Unique·Trinket·Classes: Warlock·Requires Level 60·Use: Increases the critical hit chance of your Destruction spells by 10% for 20 sec.· \
·Demoniac's Threads (5)·  Kezan's Unstoppable Taint·  Hazza'rah's Charm of Destruction·  Zandalar Demoniac's Wraps·  Zandalar Demoniac's Mantle·  Zandalar Demoniac's Robe·",
	},
	["19605:0:0:0"] = {
		["i"] = "Kezan's Unstoppable Taint",
		["t"] = "Kezan's Unstoppable Taint·Binds when picked up·Unique·Neck·+13 Stamina·+8 Intellect·Classes: Warlock·Equip: Increases damage and healing done by magical spells and effects by up to 14.·Equip: Increases the radius of Rain of Fire and Hellfire by 1 yard.· \
·Demoniac's Threads (5)·  Kezan's Unstoppable Taint·  Hazza'rah's Charm of Destruction·  Zandalar Demoniac's Wraps·  Zandalar Demoniac's Mantle·  Zandalar Demoniac's Robe·",
		["c"] = "a335ee",
	},
	["19849:0:0:0"] = {
		["i"] = "Zandalar Demoniac's Mantle",
		["c"] = "0070dd",
		["t"] = "Zandalar Demoniac's Mantle·Binds when picked up·Shoulder·Cloth·72 Armor·+21 Stamina·+10 Intellect·Classes: Warlock·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Demoniac's Threads (5)·  Kezan's Unstoppable Taint·  Hazza'rah's Charm of Destruction·  Zandalar Demoniac's Wraps·  Zandalar Demoniac's Mantle·  Zandalar Demoniac's Robe·",
	},
	["19604:0:0:0"] = {
		["i"] = "Kezan's Taint",
		["t"] = "Kezan's Taint·Binds when picked up·Unique·Neck·+13 Stamina·+8 Intellect·Classes: Warlock·Equip: Increases damage and healing done by magical spells and effects by up to 14.·",
		["c"] = "0070dd",
	},
	["19603:0:0:0"] = {
		["i"] = "Kezan's Taint",
		["t"] = "Kezan's Taint·Binds when picked up·Unique·Neck·+10 Stamina·+6 Intellect·Classes: Warlock·Equip: Increases damage and healing done by magical spells and effects by up to 12.·",
		["c"] = "0070dd",
	},
	["19602:0:0:0"] = {
		["i"] = "Kezan's Taint",
		["t"] = "Kezan's Taint·Binds when picked up·Unique·Neck·+10 Stamina·Classes: Warlock·Equip: Increases damage and healing done by magical spells and effects by up to 12.·",
		["c"] = "1eff00",
	},
	["16966:0:0:0"] = {
		["i"] = "Breastplate of Wrath",
		["t"] = "Breastplate of Wrath·Binds when picked up·Chest·Plate·857 Armor·+17 Strength·+40 Stamina·+10 Fire Resistance·+10 Nature Resistance·Classes: Warrior·Requires Level 60·Equip: Increased Defense +11.· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
		["c"] = "a335ee",
	},
	["16962:0:0:0"] = {
		["i"] = "Legplates of Wrath",
		["c"] = "a335ee",
		["t"] = "Legplates of Wrath·Binds when picked up·Legs·Plate·749 Armor·+19 Strength·+27 Stamina·+10 Arcane Resistance·+10 Fire Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to dodge an attack by 2%.·Equip: Increased Defense +11.· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
	},
	["16963:0:0:0"] = {
		["i"] = "Helm of Wrath",
		["c"] = "a335ee",
		["t"] = "Helm of Wrath·Binds when picked up·Head·Plate·696 Armor·+17 Strength·+40 Stamina·+10 Frost Resistance·+10 Shadow Resistance·Classes: Warrior·Requires Level 60·Equip: Increased Defense +11.· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
	},
	["16959:0:0:0"] = {
		["i"] = "Bracelets of Wrath",
		["c"] = "a335ee",
		["t"] = "Bracelets of Wrath·Binds when picked up·Wrist·Plate·375 Armor·+13 Strength·+27 Stamina·Classes: Warrior·Requires Level 60· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
	},
	["16960:0:0:0"] = {
		["i"] = "Waistband of Wrath",
		["t"] = "Waistband of Wrath·Binds when picked up·Waist·Plate·482 Armor·+20 Strength·+20 Stamina·+10 Shadow Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to block attacks with a shield by 3%.·Equip: Increased Defense +7.· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
		["c"] = "a335ee",
	},
	["16965:0:0:0"] = {
		["i"] = "Sabatons of Wrath",
		["c"] = "a335ee",
		["t"] = "Sabatons of Wrath·Binds when picked up·Feet·Plate·589 Armor·+13 Strength·+30 Stamina·+10 Fire Resistance·Classes: Warrior·Requires Level 60·Equip: Increases the block value of your shield by 14.·Equip: Increased Defense +7.· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
	},
	["16964:0:0:0"] = {
		["i"] = "Gauntlets of Wrath",
		["c"] = "a335ee",
		["t"] = "Gauntlets of Wrath·Binds when picked up·Hands·Plate·535 Armor·+15 Strength·+20 Stamina·+10 Shadow Resistance·Classes: Warrior·Requires Level 60·Equip: Increases your chance to parry an attack by 1%.·Equip: Increased Defense +7.· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
	},
	["16961:0:0:0"] = {
		["i"] = "Pauldrons of Wrath",
		["c"] = "a335ee",
		["t"] = "Pauldrons of Wrath·Binds when picked up·Shoulder·Plate·642 Armor·+13 Strength·+27 Stamina·+10 Fire Resistance·Classes: Warrior·Requires Level 60·Equip: Increases the block value of your shield by 27.·Equip: Increased Defense +7.· \
·Battlegear of Wrath (8)·  Bracelets of Wrath·  Breastplate of Wrath·  Gauntlets of Wrath·  Helm of Wrath·  Legplates of Wrath·  Pauldrons of Wrath·  Sabatons of Wrath·  Waistband of Wrath·",
	},
	["16431:0:0:0"] = {
		["i"] = "Knight-Captain's Plate Leggings",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Plate Leggings·Binds when picked up·Unique·Legs·Plate·575 Armor·+7 Strength·+13 Stamina·Classes: Warrior·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike by 2%.· \
·Lieutenant Commander's Battlegear (6)·  Knight-Lieutenant's Plate Boots·  Knight-Lieutenant's Plate Gauntlets·  Knight-Captain's Plate Chestguard·  Knight-Captain's Plate Leggings·  Lieutenant Commander's Plate Helm·  Lieutenant Commander's Plate Pauldrons·",
	},
	["16405:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Plate Boots",
		["t"] = "Knight-Lieutenant's Plate Boots·Binds when picked up·Unique·Feet·Plate·452 Armor·+8 Strength·+5 Agility·+23 Stamina·Classes: Warrior·Requires Level 58·Requires Knight-Lieutenant· \
·Lieutenant Commander's Battlegear (6)·  Knight-Lieutenant's Plate Boots·  Knight-Lieutenant's Plate Gauntlets·  Knight-Captain's Plate Chestguard·  Knight-Captain's Plate Leggings·  Lieutenant Commander's Plate Helm·  Lieutenant Commander's Plate Pauldrons·",
		["c"] = "0070dd",
	},
	["16432:0:0:0"] = {
		["i"] = "Lieutenant Commander's Plate Pauldrons",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Plate Pauldrons·Binds when picked up·Unique·Shoulder·Plate·493 Armor·+7 Strength·+6 Agility·+23 Stamina·Classes: Warrior·Requires Level 58·Requires Lieutenant Commander· \
·Lieutenant Commander's Battlegear (6)·  Knight-Lieutenant's Plate Boots·  Knight-Lieutenant's Plate Gauntlets·  Knight-Captain's Plate Chestguard·  Knight-Captain's Plate Leggings·  Lieutenant Commander's Plate Helm·  Lieutenant Commander's Plate Pauldrons·",
	},
	["16406:0:0:0"] = {
		["i"] = "Knight-Lieutenant's Plate Gauntlets",
		["t"] = "Knight-Lieutenant's Plate Gauntlets·Binds when picked up·Unique·Hands·Plate·410 Armor·+16 Strength·+15 Stamina·Classes: Warrior·Requires Level 58·Requires Knight-Lieutenant·Equip: Hamstring Rage cost reduced by 3.· \
·Lieutenant Commander's Battlegear (6)·  Knight-Lieutenant's Plate Boots·  Knight-Lieutenant's Plate Gauntlets·  Knight-Captain's Plate Chestguard·  Knight-Captain's Plate Leggings·  Lieutenant Commander's Plate Helm·  Lieutenant Commander's Plate Pauldrons·",
		["c"] = "0070dd",
	},
	["16429:0:0:0"] = {
		["i"] = "Lieutenant Commander's Plate Helm",
		["c"] = "0070dd",
		["t"] = "Lieutenant Commander's Plate Helm·Binds when picked up·Unique·Head·Plate·534 Armor·+9 Strength·+8 Agility·+31 Stamina·Classes: Warrior·Requires Level 58·Requires Lieutenant Commander· \
·Lieutenant Commander's Battlegear (6)·  Knight-Lieutenant's Plate Boots·  Knight-Lieutenant's Plate Gauntlets·  Knight-Captain's Plate Chestguard·  Knight-Captain's Plate Leggings·  Lieutenant Commander's Plate Helm·  Lieutenant Commander's Plate Pauldrons·",
	},
	["16430:0:0:0"] = {
		["i"] = "Knight-Captain's Plate Chestguard",
		["c"] = "0070dd",
		["t"] = "Knight-Captain's Plate Chestguard·Binds when picked up·Unique·Chest·Plate·657 Armor·+9 Strength·+6 Agility·+25 Stamina·Classes: Warrior·Requires Level 58·Requires Knight-Captain·Equip: Improves your chance to get a critical strike by 1%.· \
·Lieutenant Commander's Battlegear (6)·  Knight-Lieutenant's Plate Boots·  Knight-Lieutenant's Plate Gauntlets·  Knight-Captain's Plate Chestguard·  Knight-Captain's Plate Leggings·  Lieutenant Commander's Plate Helm·  Lieutenant Commander's Plate Pauldrons·",
	},
	["16509:0:0:0"] = {
		["i"] = "Blood Guard's Plate Boots",
		["c"] = "0070dd",
		["t"] = "Blood Guard's Plate Boots·Binds when picked up·Unique·Feet·Plate·452 Armor·+8 Strength·+5 Agility·+23 Stamina·Classes: Warrior·Requires Level 58·Requires Blood Guard· \
·Champion's Battlegear (6)·  Blood Guard's Plate Boots·  Blood Guard's Plate Gloves·  Legionnaire's Plate Armor·  Legionnaire's Plate Legguards·  Champion's Plate Headguard·  Champion's Plate Pauldrons·",
	},
	["16514:0:0:0"] = {
		["i"] = "Champion's Plate Headguard",
		["t"] = "Champion's Plate Headguard·Binds when picked up·Unique·Head·Plate·534 Armor·+9 Strength·+8 Agility·+31 Stamina·Classes: Warrior·Requires Level 58·Requires Champion· \
·Champion's Battlegear (6)·  Blood Guard's Plate Boots·  Blood Guard's Plate Gloves·  Legionnaire's Plate Armor·  Legionnaire's Plate Legguards·  Champion's Plate Headguard·  Champion's Plate Pauldrons·",
		["c"] = "0070dd",
	},
	["16510:0:0:0"] = {
		["i"] = "Blood Guard's Plate Gloves",
		["t"] = "Blood Guard's Plate Gloves·Binds when picked up·Unique·Hands·Plate·410 Armor·+16 Strength·+15 Stamina·Classes: Warrior·Requires Level 58·Requires Blood Guard·Equip: Hamstring Rage cost reduced by 3.· \
·Champion's Battlegear (6)·  Blood Guard's Plate Boots·  Blood Guard's Plate Gloves·  Legionnaire's Plate Armor·  Legionnaire's Plate Legguards·  Champion's Plate Headguard·  Champion's Plate Pauldrons·",
		["c"] = "0070dd",
	},
	["16516:0:0:0"] = {
		["i"] = "Champion's Plate Pauldrons",
		["t"] = "Champion's Plate Pauldrons·Binds when picked up·Unique·Shoulder·Plate·493 Armor·+7 Strength·+6 Agility·+23 Stamina·Classes: Warrior·Requires Level 58·Requires Champion· \
·Champion's Battlegear (6)·  Blood Guard's Plate Boots·  Blood Guard's Plate Gloves·  Legionnaire's Plate Armor·  Legionnaire's Plate Legguards·  Champion's Plate Headguard·  Champion's Plate Pauldrons·",
		["c"] = "0070dd",
	},
	["16513:0:0:0"] = {
		["i"] = "Legionnaire's Plate Armor",
		["t"] = "Legionnaire's Plate Armor·Binds when picked up·Unique·Chest·Plate·657 Armor·+9 Strength·+6 Agility·+25 Stamina·Classes: Warrior·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike by 1%.· \
·Champion's Battlegear (6)·  Blood Guard's Plate Boots·  Blood Guard's Plate Gloves·  Legionnaire's Plate Armor·  Legionnaire's Plate Legguards·  Champion's Plate Headguard·  Champion's Plate Pauldrons·",
		["c"] = "0070dd",
	},
	["16515:0:0:0"] = {
		["i"] = "Legionnaire's Plate Legguards",
		["t"] = "Legionnaire's Plate Legguards·Binds when picked up·Unique·Legs·Plate·575 Armor·+7 Strength·+13 Stamina·Classes: Warrior·Requires Level 58·Requires Legionnaire·Equip: Improves your chance to get a critical strike by 2%.· \
·Champion's Battlegear (6)·  Blood Guard's Plate Boots·  Blood Guard's Plate Gloves·  Legionnaire's Plate Armor·  Legionnaire's Plate Legguards·  Champion's Plate Headguard·  Champion's Plate Pauldrons·",
		["c"] = "0070dd",
	},
	["16477:0:0:0"] = {
		["i"] = "Field Marshal's Plate Armor",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Plate Armor·Binds when picked up·Unique·Chest·Plate·738 Armor·+13 Strength·+13 Agility·+35 Stamina·Classes: Warrior·Requires Level 60·Requires Field Marshal·Equip: Improves your chance to get a critical strike by 1%.· \
·Field Marshal's Battlegear (6)·  Field Marshal's Plate Armor·  Field Marshal's Plate Helm·  Field Marshal's Plate Shoulderguards·  Marshal's Plate Boots·  Marshal's Plate Gauntlets·  Marshal's Plate Legguards·",
	},
	["16483:0:0:0"] = {
		["i"] = "Marshal's Plate Boots",
		["c"] = "a335ee",
		["t"] = "Marshal's Plate Boots·Binds when picked up·Unique·Feet·Plate·507 Armor·+15 Strength·+11 Agility·+26 Stamina·Classes: Warrior·Requires Level 60·Requires Marshal· \
·Field Marshal's Battlegear (6)·  Field Marshal's Plate Armor·  Field Marshal's Plate Helm·  Field Marshal's Plate Shoulderguards·  Marshal's Plate Boots·  Marshal's Plate Gauntlets·  Marshal's Plate Legguards·",
	},
	["16479:0:0:0"] = {
		["i"] = "Marshal's Plate Legguards",
		["c"] = "a335ee",
		["t"] = "Marshal's Plate Legguards·Binds when picked up·Unique·Legs·Plate·646 Armor·+16 Strength·+20 Stamina·Classes: Warrior·Requires Level 60·Requires Marshal·Equip: Improves your chance to get a critical strike by 2%.·Equip: Improves your chance to hit by 1%.· \
·Field Marshal's Battlegear (6)·  Field Marshal's Plate Armor·  Field Marshal's Plate Helm·  Field Marshal's Plate Shoulderguards·  Marshal's Plate Boots·  Marshal's Plate Gauntlets·  Marshal's Plate Legguards·",
	},
	["16478:0:0:0"] = {
		["i"] = "Field Marshal's Plate Helm",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Plate Helm·Binds when picked up·Unique·Head·Plate·599 Armor·+19 Strength·+15 Agility·+35 Stamina·Classes: Warrior·Requires Level 60·Requires Field Marshal· \
·Field Marshal's Battlegear (6)·  Field Marshal's Plate Armor·  Field Marshal's Plate Helm·  Field Marshal's Plate Shoulderguards·  Marshal's Plate Boots·  Marshal's Plate Gauntlets·  Marshal's Plate Legguards·",
	},
	["16480:0:0:0"] = {
		["i"] = "Field Marshal's Plate Shoulderguards",
		["c"] = "a335ee",
		["t"] = "Field Marshal's Plate Shoulderguards·Binds when picked up·Unique·Shoulder·Plate·553 Armor·+15 Strength·+11 Agility·+26 Stamina·Classes: Warrior·Requires Level 60·Requires Field Marshal· \
·Field Marshal's Battlegear (6)·  Field Marshal's Plate Armor·  Field Marshal's Plate Helm·  Field Marshal's Plate Shoulderguards·  Marshal's Plate Boots·  Marshal's Plate Gauntlets·  Marshal's Plate Legguards·",
	},
	["16484:0:0:0"] = {
		["i"] = "Marshal's Plate Gauntlets",
		["c"] = "a335ee",
		["t"] = "Marshal's Plate Gauntlets·Binds when picked up·Unique·Hands·Plate·461 Armor·+18 Strength·+15 Agility·+17 Stamina·Classes: Warrior·Requires Level 60·Requires Marshal·Equip: Hamstring Rage cost reduced by 3.· \
·Field Marshal's Battlegear (6)·  Field Marshal's Plate Armor·  Field Marshal's Plate Helm·  Field Marshal's Plate Shoulderguards·  Marshal's Plate Boots·  Marshal's Plate Gauntlets·  Marshal's Plate Legguards·",
	},
	["16548:0:0:0"] = {
		["i"] = "General's Plate Gauntlets",
		["t"] = "General's Plate Gauntlets·Binds when picked up·Unique·Hands·Plate·461 Armor·+18 Strength·+15 Agility·+17 Stamina·Classes: Warrior·Requires Level 60·Requires General·Equip: Hamstring Rage cost reduced by 3.· \
·Warlord's Battlegear (6)·  Warlord's Plate Armor·  Warlord's Plate Headpiece·  Warlord's Plate Shoulders·  General's Plate Boots·  General's Plate Gauntlets·  General's Plate Leggings·",
		["c"] = "a335ee",
	},
	["16542:0:0:0"] = {
		["i"] = "Warlord's Plate Headpiece",
		["c"] = "a335ee",
		["t"] = "Warlord's Plate Headpiece·Binds when picked up·Unique·Head·Plate·599 Armor·+19 Strength·+15 Agility·+35 Stamina·Classes: Warrior·Requires Level 60·Requires Warlord· \
·Warlord's Battlegear (6)·  Warlord's Plate Armor·  Warlord's Plate Headpiece·  Warlord's Plate Shoulders·  General's Plate Boots·  General's Plate Gauntlets·  General's Plate Leggings·",
	},
	["16541:0:0:0"] = {
		["i"] = "Warlord's Plate Armor",
		["c"] = "a335ee",
		["t"] = "Warlord's Plate Armor·Binds when picked up·Unique·Chest·Plate·738 Armor·+13 Strength·+13 Agility·+35 Stamina·Classes: Warrior·Requires Level 60·Requires Warlord·Equip: Improves your chance to get a critical strike by 1%.· \
·Warlord's Battlegear (6)·  Warlord's Plate Armor·  Warlord's Plate Headpiece·  Warlord's Plate Shoulders·  General's Plate Boots·  General's Plate Gauntlets·  General's Plate Leggings·",
	},
	["16544:0:0:0"] = {
		["i"] = "Warlord's Plate Shoulders",
		["c"] = "a335ee",
		["t"] = "Warlord's Plate Shoulders·Binds when picked up·Unique·Shoulder·Plate·553 Armor·+15 Strength·+11 Agility·+26 Stamina·Classes: Warrior·Requires Level 60·Requires Warlord· \
·Warlord's Battlegear (6)·  Warlord's Plate Armor·  Warlord's Plate Headpiece·  Warlord's Plate Shoulders·  General's Plate Boots·  General's Plate Gauntlets·  General's Plate Leggings·",
	},
	["16543:0:0:0"] = {
		["i"] = "General's Plate Leggings",
		["c"] = "a335ee",
		["t"] = "General's Plate Leggings·Binds when picked up·Unique·Legs·Plate·646 Armor·+16 Strength·+20 Stamina·Classes: Warrior·Requires Level 60·Requires General·Equip: Improves your chance to get a critical strike by 2%.·Equip: Improves your chance to hit by 1%.· \
·Warlord's Battlegear (6)·  Warlord's Plate Armor·  Warlord's Plate Headpiece·  Warlord's Plate Shoulders·  General's Plate Boots·  General's Plate Gauntlets·  General's Plate Leggings·",
	},
	["16545:0:0:0"] = {
		["i"] = "General's Plate Boots",
		["t"] = "General's Plate Boots·Binds when picked up·Unique·Feet·Plate·507 Armor·+15 Strength·+11 Agility·+26 Stamina·Classes: Warrior·Requires Level 60·Requires General· \
·Warlord's Battlegear (6)·  Warlord's Plate Armor·  Warlord's Plate Headpiece·  Warlord's Plate Shoulders·  General's Plate Boots·  General's Plate Gauntlets·  General's Plate Leggings·",
		["c"] = "a335ee",
	},
	["19822:0:0:0"] = {
		["i"] = "Zandalar Vindicator's Breastplate",
		["c"] = "a335ee",
		["t"] = "Zandalar Vindicator's Breastplate·Binds when picked up·Chest·Plate·828 Armor·+23 Strength·+15 Agility·+24 Stamina·Classes: Warrior·Equip: Increased Defense +4.· \
·Vindicator's Battlegear (5)·  Gri'lek's Charm of Might·  Rage of Mugamba·  Zandalar Vindicator's Armguards·  Zandalar Vindicator's Belt·  Zandalar Vindicator's Breastplate·",
	},
	["19824:0:0:0"] = {
		["i"] = "Zandalar Vindicator's Armguards",
		["c"] = "0070dd",
		["t"] = "Zandalar Vindicator's Armguards·Binds when picked up·Wrist·Plate·309 Armor·+12 Strength·+11 Agility·+11 Stamina·Classes: Warrior· \
·Vindicator's Battlegear (5)·  Gri'lek's Charm of Might·  Rage of Mugamba·  Zandalar Vindicator's Armguards·  Zandalar Vindicator's Belt·  Zandalar Vindicator's Breastplate·",
	},
	["19951:0:0:0"] = {
		["i"] = "Gri'lek's Charm of Might",
		["c"] = "a335ee",
		["t"] = "Gri'lek's Charm of Might·Binds when picked up·Unique·Trinket·Classes: Warrior·Requires Level 60·Use: Instantly increases your rage by 30.· \
·Vindicator's Battlegear (5)·  Gri'lek's Charm of Might·  Rage of Mugamba·  Zandalar Vindicator's Armguards·  Zandalar Vindicator's Belt·  Zandalar Vindicator's Breastplate·",
	},
	["19823:0:0:0"] = {
		["i"] = "Zandalar Vindicator's Belt",
		["t"] = "Zandalar Vindicator's Belt·Binds when picked up·Waist·Plate·397 Armor·+18 Strength·+10 Stamina·Classes: Warrior·Equip: Improves your chance to get a critical strike by 1%.· \
·Vindicator's Battlegear (5)·  Gri'lek's Charm of Might·  Rage of Mugamba·  Zandalar Vindicator's Armguards·  Zandalar Vindicator's Belt·  Zandalar Vindicator's Breastplate·",
		["c"] = "0070dd",
	},
	["19577:0:0:0"] = {
		["i"] = "Rage of Mugamba",
		["c"] = "a335ee",
		["t"] = "Rage of Mugamba·Binds when picked up·Unique·Neck·+8 Strength·+8 Agility·+13 Stamina·Classes: Warrior·Equip: Increased Defense +6.·Equip: Increases your chance to block attacks with a shield by 2%.·Equip: Reduces the cost of your Hamstring ability by 2 rage points.· \
·Vindicator's Battlegear (5)·  Gri'lek's Charm of Might·  Rage of Mugamba·  Zandalar Vindicator's Armguards·  Zandalar Vindicator's Belt·  Zandalar Vindicator's Breastplate·",
	},
	["19576:0:0:0"] = {
		["i"] = "Strength of Mugamba",
		["c"] = "0070dd",
		["t"] = "Strength of Mugamba·Binds when picked up·Unique·Neck·+8 Strength·+8 Agility·+13 Stamina·Classes: Warrior·Equip: Increased Defense +5.·",
	},
	["19575:0:0:0"] = {
		["i"] = "Strength of Mugamba",
		["c"] = "0070dd",
		["t"] = "Strength of Mugamba·Binds when picked up·Unique·Neck·+7 Strength·+6 Agility·+10 Stamina·Classes: Warrior·Equip: Increased Defense +4.·",
	},
	["19574:0:0:0"] = {
		["i"] = "Strength of Mugamba",
		["c"] = "1eff00",
		["t"] = "Strength of Mugamba·Binds when picked up·Unique·Neck·+7 Strength·+10 Stamina·Classes: Warrior·Equip: Increased Defense +4.·",
	},
	["20204:0:0:0"] = {
		["i"] = "Defiler's Plate Girdle",
		["c"] = "0070dd",
		["t"] = "Defiler's Plate Girdle·Binds when picked up·Unique·Waist·Plate·369 Armor·+17 Strength·+10 Stamina·Classes: Warrior·Requires Level 58·Requires The Defilers - Honored·Equip: Improves your chance to get a critical strike by 1%.· \
·The Defiler's Resolution (3)·  Defiler's Plate Girdle·  Defiler's Plate Greaves·  Defiler's Plate Spaulders·",
	},
	["20212:0:0:0"] = {
		["i"] = "Defiler's Plate Spaulders",
		["c"] = "a335ee",
		["t"] = "Defiler's Plate Spaulders·Binds when picked up·Unique·Shoulder·Plate·553 Armor·+18 Strength·+17 Agility·+20 Stamina·Classes: Warrior·Requires Level 60·Requires The Defilers - Exalted· \
·The Defiler's Resolution (3)·  Defiler's Plate Girdle·  Defiler's Plate Greaves·  Defiler's Plate Spaulders·",
	},
	["20208:0:0:0"] = {
		["i"] = "Defiler's Plate Greaves",
		["c"] = "0070dd",
		["t"] = "Defiler's Plate Greaves·Binds when picked up·Unique·Feet·Plate·452 Armor·+14 Strength·+12 Agility·+12 Stamina·Classes: Warrior·Requires Level 58·Requires The Defilers - Revered·Equip: Run speed increased slightly.· \
·The Defiler's Resolution (3)·  Defiler's Plate Girdle·  Defiler's Plate Greaves·  Defiler's Plate Spaulders·",
	},
	["15051:0:0:0"] = {
		["i"] = "Black Dragonscale Shoulders",
		["t"] = "Black Dragonscale Shoulders·Binds when equipped·Shoulder·Mail·266 Armor·+9 Stamina·+6 Fire Resistance·Requires Level 55·Equip: +40 Attack Power.· \
·Black Dragon Mail (4)·  Black Dragonscale Boots·  Black Dragonscale Breastplate·  Black Dragonscale Leggings·  Black Dragonscale Shoulders·",
		["c"] = "0070dd",
	},
	["15052:0:0:0"] = {
		["i"] = "Black Dragonscale Leggings",
		["c"] = "0070dd",
		["t"] = "Black Dragonscale Leggings·Binds when equipped·Legs·Mail·320 Armor·+8 Stamina·+13 Fire Resistance·Requires Level 57·Equip: +54 Attack Power.· \
·Black Dragon Mail (4)·  Black Dragonscale Boots·  Black Dragonscale Breastplate·  Black Dragonscale Leggings·  Black Dragonscale Shoulders·",
	},
	["15050:0:0:0"] = {
		["i"] = "Black Dragonscale Breastplate",
		["t"] = "Black Dragonscale Breastplate·Binds when equipped·Chest·Mail·344 Armor·+8 Stamina·+12 Fire Resistance·Requires Level 53·Equip: +50 Attack Power.· \
·Black Dragon Mail (4)·  Black Dragonscale Boots·  Black Dragonscale Breastplate·  Black Dragonscale Leggings·  Black Dragonscale Shoulders·",
		["c"] = "0070dd",
	},
	["16984:0:0:0"] = {
		["i"] = "Black Dragonscale Boots",
		["t"] = "Black Dragonscale Boots·Binds when equipped·Feet·Mail·270 Armor·+10 Stamina·+24 Fire Resistance·Requires Level 56·Equip: +28 Attack Power.· \
·Black Dragon Mail (4)·  Black Dragonscale Boots·  Black Dragonscale Breastplate·  Black Dragonscale Leggings·  Black Dragonscale Shoulders·",
		["c"] = "a335ee",
	},
	["19689:0:0:0"] = {
		["i"] = "Blood Tiger Shoulders",
		["c"] = "0070dd",
		["t"] = "Blood Tiger Shoulders·Binds when equipped·Shoulder·Leather·136 Armor·+13 Strength·+13 Stamina·+12 Intellect·+10 Spirit·Requires Level 60· \
·Blood Tiger Harness (2)·Requires Leatherworking (300)·",
	},
	["19688:0:0:0"] = {
		["i"] = "Blood Tiger Breastplate",
		["c"] = "0070dd",
		["t"] = "Blood Tiger Breastplate·Binds when equipped·Chest·Leather·181 Armor·+17 Strength·+17 Stamina·+16 Intellect·+13 Spirit·Requires Level 60· \
·Blood Tiger Harness (2)·Requires Leatherworking (300)·",
	},
	["19691:0:0:0"] = {
		["i"] = "Bloodsoul Shoulders",
		["c"] = "0070dd",
		["t"] = "Bloodsoul Shoulders·Binds when equipped·Shoulder·Mail·286 Armor·+24 Agility·+10 Stamina·Requires Level 60· \
·Bloodsoul Embrace (3)·  Bloodsoul Breastplate·  Bloodsoul Shoulders·  Bloodsoul Gauntlets·",
	},
	["19692:0:0:0"] = {
		["i"] = "Bloodsoul Gauntlets",
		["c"] = "0070dd",
		["t"] = "Bloodsoul Gauntlets·Binds when equipped·Hands·Mail·238 Armor·+10 Agility·+17 Stamina·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Bloodsoul Embrace (3)·  Bloodsoul Breastplate·  Bloodsoul Shoulders·  Bloodsoul Gauntlets·",
	},
	["19690:0:0:0"] = {
		["i"] = "Bloodsoul Breastplate",
		["c"] = "0070dd",
		["t"] = "Bloodsoul Breastplate·Binds when equipped·Chest·Mail·381 Armor·+9 Agility·+13 Stamina·Requires Level 60·Equip: Improves your chance to get a critical strike by 2%.· \
·Bloodsoul Embrace (3)·  Bloodsoul Breastplate·  Bloodsoul Shoulders·  Bloodsoul Gauntlets·",
	},
	["19682:0:0:0"] = {
		["i"] = "Bloodvine Vest",
		["t"] = "Bloodvine Vest·Binds when equipped·Chest·Cloth·92 Armor·+13 Intellect·Requires Level 60·Equip: Improves your chance to hit with spells by 2%.·Equip: Increases damage and healing done by magical spells and effects by up to 27.· \
·Bloodvine Garb (3)·Requires Tailoring (300)·  Bloodvine Vest·  Bloodvine Leggings·  Bloodvine Boots·",
		["c"] = "0070dd",
	},
	["19684:0:0:0"] = {
		["i"] = "Bloodvine Boots",
		["c"] = "0070dd",
		["t"] = "Bloodvine Boots·Binds when equipped·Feet·Cloth·63 Armor·+16 Intellect·Requires Level 60·Equip: Improves your chance to hit with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 19.· \
·Bloodvine Garb (3)·Requires Tailoring (300)·  Bloodvine Vest·  Bloodvine Leggings·  Bloodvine Boots·",
	},
	["19683:0:0:0"] = {
		["i"] = "Bloodvine Leggings",
		["c"] = "0070dd",
		["t"] = "Bloodvine Leggings·Binds when equipped·Legs·Cloth·80 Armor·+6 Intellect·Requires Level 60·Equip: Improves your chance to hit with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 37.· \
·Bloodvine Garb (3)·Requires Tailoring (300)·  Bloodvine Vest·  Bloodvine Leggings·  Bloodvine Boots·",
	},
	["15049:0:0:0"] = {
		["i"] = "Blue Dragonscale Shoulders",
		["t"] = "Blue Dragonscale Shoulders·Binds when equipped·Shoulder·Mail·262 Armor·+21 Intellect·+6 Spirit·+6 Arcane Resistance·Requires Level 54· \
·Blue Dragon Mail (3)·  Blue Dragonscale Breastplate·  Blue Dragonscale Leggings·  Blue Dragonscale Shoulders·",
		["c"] = "0070dd",
	},
	["15048:0:0:0"] = {
		["i"] = "Blue Dragonscale Breastplate",
		["c"] = "0070dd",
		["t"] = "Blue Dragonscale Breastplate·Binds when equipped·Chest·Mail·338 Armor·+28 Intellect·+8 Spirit·+8 Arcane Resistance·Requires Level 52· \
·Blue Dragon Mail (3)·  Blue Dragonscale Breastplate·  Blue Dragonscale Leggings·  Blue Dragonscale Shoulders·",
	},
	["20295:0:0:0"] = {
		["i"] = "Blue Dragonscale Leggings",
		["c"] = "0070dd",
		["t"] = "Blue Dragonscale Leggings·Binds when equipped·Legs·Mail·310 Armor·+20 Intellect·+19 Spirit·+12 Arcane Resistance·Requires Level 55· \
·Blue Dragon Mail (3)·  Blue Dragonscale Breastplate·  Blue Dragonscale Leggings·  Blue Dragonscale Shoulders·",
	},
	["19695:0:0:0"] = {
		["i"] = "Darksoul Shoulders",
		["c"] = "0070dd",
		["t"] = "Darksoul Shoulders·Binds when equipped·Shoulder·Plate·507 Armor·+24 Stamina·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·The Darksoul (3)·Requires Blacksmithing (300)·  Darksoul Breastplate·  Darksoul Leggings·  Darksoul Shoulders·",
	},
	["19694:0:0:0"] = {
		["i"] = "Darksoul Leggings",
		["c"] = "0070dd",
		["t"] = "Darksoul Leggings·Binds when equipped·Legs·Plate·722 Armor·+22 Stamina·Requires Level 60·Equip: Improves your chance to hit by 2%.· \
·The Darksoul (3)·Requires Blacksmithing (300)·  Darksoul Breastplate·  Darksoul Leggings·  Darksoul Shoulders·",
	},
	["19693:0:0:0"] = {
		["i"] = "Darksoul Breastplate",
		["c"] = "0070dd",
		["t"] = "Darksoul Breastplate·Binds when equipped·Chest·Plate·736 Armor·+32 Stamina·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·The Darksoul (3)·Requires Blacksmithing (300)·  Darksoul Breastplate·  Darksoul Leggings·  Darksoul Shoulders·",
	},
	["15063:0:0:0"] = {
		["i"] = "Devilsaur Gauntlets",
		["c"] = "0070dd",
		["t"] = "Devilsaur Gauntlets·Binds when equipped·Hands·Leather·103 Armor·+9 Stamina·Requires Level 53·Equip: +28 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·Devilsaur Armor (2)·  Devilsaur Leggings·  Devilsaur Gauntlets·",
	},
	["15062:0:0:0"] = {
		["i"] = "Devilsaur Leggings",
		["c"] = "0070dd",
		["t"] = "Devilsaur Leggings·Binds when equipped·Legs·Leather·148 Armor·+12 Stamina·Requires Level 55·Equip: +46 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·Devilsaur Armor (2)·  Devilsaur Leggings·  Devilsaur Gauntlets·",
	},
	["13134:0:0:0"] = {
		["i"] = "Belt of the Gladiator",
		["t"] = "Belt of the Gladiator·Binds when equipped·Waist·Mail·166 Armor·+18 Strength·+7 Stamina·Requires Level 44·",
		["c"] = "0070dd",
	},
	["11731:0:0:0"] = {
		["i"] = "Savage Gladiator Greaves",
		["c"] = "0070dd",
		["t"] = "Savage Gladiator Greaves·Binds when picked up·Feet·Mail·233 Armor·+13 Strength·+13 Agility·+13 Stamina·Requires Level 52· \
·The Gladiator (5)·  Savage Gladiator Helm·  Savage Gladiator Chain·  Savage Gladiator Leggings·  Savage Gladiator Greaves·  Savage Gladiator Grips·",
	},
	["11729:0:0:0"] = {
		["i"] = "Savage Gladiator Helm",
		["t"] = "Savage Gladiator Helm·Binds when picked up·Head·Mail·275 Armor·+28 Stamina·+12 Spirit·Requires Level 52· \
·The Gladiator (5)·  Savage Gladiator Helm·  Savage Gladiator Chain·  Savage Gladiator Leggings·  Savage Gladiator Greaves·  Savage Gladiator Grips·",
		["c"] = "0070dd",
	},
	["11726:0:0:0"] = {
		["i"] = "Savage Gladiator Chain",
		["c"] = "a335ee",
		["t"] = "Savage Gladiator Chain·Binds when picked up·Chest·Mail·369 Armor·+13 Stamina·Requires Level 52·Equip: Increased Defense +13.·Equip: Improves your chance to get a critical strike by 2%.· \
·The Gladiator (5)·  Savage Gladiator Helm·  Savage Gladiator Chain·  Savage Gladiator Leggings·  Savage Gladiator Greaves·  Savage Gladiator Grips·",
	},
	["11730:0:0:0"] = {
		["i"] = "Savage Gladiator Grips",
		["c"] = "0070dd",
		["t"] = "Savage Gladiator Grips·Binds when picked up·Hands·Mail·211 Armor·+9 Agility·+14 Stamina·+14 Spirit·Requires Level 52· \
·The Gladiator (5)·  Savage Gladiator Helm·  Savage Gladiator Chain·  Savage Gladiator Leggings·  Savage Gladiator Greaves·  Savage Gladiator Grips·",
	},
	["11728:0:0:0"] = {
		["i"] = "Savage Gladiator Leggings",
		["t"] = "Savage Gladiator Leggings·Binds when picked up·Legs·Mail·296 Armor·+12 Strength·+19 Stamina·+18 Spirit·Requires Level 52· \
·The Gladiator (5)·  Savage Gladiator Helm·  Savage Gladiator Chain·  Savage Gladiator Leggings·  Savage Gladiator Greaves·  Savage Gladiator Grips·",
		["c"] = "0070dd",
	},
	["15046:0:0:0"] = {
		["i"] = "Green Dragonscale Leggings",
		["c"] = "0070dd",
		["t"] = "Green Dragonscale Leggings·Binds when equipped·Legs·Mail·282 Armor·+10 Stamina·+22 Spirit·+11 Nature Resistance·Requires Level 49· \
·Green Dragon Mail (3)·  Green Dragonscale Breastplate·  Green Dragonscale Leggings·  Green Dragonscale Gauntlets·",
	},
	["15045:0:0:0"] = {
		["i"] = "Green Dragonscale Breastplate",
		["t"] = "Green Dragonscale Breastplate·Binds when equipped·Chest·Mail·311 Armor·+10 Stamina·+21 Spirit·+11 Nature Resistance·Requires Level 47· \
·Green Dragon Mail (3)·  Green Dragonscale Breastplate·  Green Dragonscale Leggings·  Green Dragonscale Gauntlets·",
		["c"] = "0070dd",
	},
	["20296:0:0:0"] = {
		["i"] = "Green Dragonscale Gauntlets",
		["c"] = "0070dd",
		["t"] = "Green Dragonscale Gauntlets·Binds when equipped·Hands·Mail·208 Armor·+5 Stamina·+18 Spirit·+9 Nature Resistance·Requires Level 51· \
·Green Dragon Mail (3)·  Green Dragonscale Breastplate·  Green Dragonscale Leggings·  Green Dragonscale Gauntlets·",
	},
	["12425:0:0:0"] = {
		["i"] = "Imperial Plate Bracers",
		["c"] = "1eff00",
		["t"] = "Imperial Plate Bracers·Binds when equipped·Wrist·Plate·225 Armor·+9 Strength·+8 Stamina·Requires Level 49· \
·Imperial Plate (7)·  Imperial Plate Belt·  Imperial Plate Boots·  Imperial Plate Bracers·  Imperial Plate Chest·  Imperial Plate Helm·  Imperial Plate Leggings·  Imperial Plate Shoulders·",
	},
	["12422:0:0:0"] = {
		["i"] = "Imperial Plate Chest",
		["c"] = "1eff00",
		["t"] = "Imperial Plate Chest·Binds when equipped·Chest·Plate·570 Armor·+18 Strength·+17 Stamina·Requires Level 55· \
·Imperial Plate (7)·  Imperial Plate Belt·  Imperial Plate Boots·  Imperial Plate Bracers·  Imperial Plate Chest·  Imperial Plate Helm·  Imperial Plate Leggings·  Imperial Plate Shoulders·",
	},
	["12427:0:0:0"] = {
		["i"] = "Imperial Plate Helm",
		["t"] = "Imperial Plate Helm·Binds when equipped·Head·Plate·456 Armor·+18 Strength·+17 Stamina·Requires Level 54· \
·Imperial Plate (7)·  Imperial Plate Belt·  Imperial Plate Boots·  Imperial Plate Bracers·  Imperial Plate Chest·  Imperial Plate Helm·  Imperial Plate Leggings·  Imperial Plate Shoulders·",
		["c"] = "1eff00",
	},
	["12426:0:0:0"] = {
		["i"] = "Imperial Plate Boots",
		["c"] = "1eff00",
		["t"] = "Imperial Plate Boots·Binds when equipped·Feet·Plate·386 Armor·+13 Strength·+12 Stamina·Requires Level 54· \
·Imperial Plate (7)·  Imperial Plate Belt·  Imperial Plate Boots·  Imperial Plate Bracers·  Imperial Plate Chest·  Imperial Plate Helm·  Imperial Plate Leggings·  Imperial Plate Shoulders·",
	},
	["12424:0:0:0"] = {
		["i"] = "Imperial Plate Belt",
		["c"] = "1eff00",
		["t"] = "Imperial Plate Belt·Binds when equipped·Waist·Plate·285 Armor·+12 Strength·+11 Stamina·Requires Level 47· \
·Imperial Plate (7)·  Imperial Plate Belt·  Imperial Plate Boots·  Imperial Plate Bracers·  Imperial Plate Chest·  Imperial Plate Helm·  Imperial Plate Leggings·  Imperial Plate Shoulders·",
	},
	["12429:0:0:0"] = {
		["i"] = "Imperial Plate Leggings",
		["c"] = "1eff00",
		["t"] = "Imperial Plate Leggings·Binds when equipped·Legs·Plate·507 Armor·+18 Strength·+18 Stamina·Requires Level 56· \
·Imperial Plate (7)·  Imperial Plate Belt·  Imperial Plate Boots·  Imperial Plate Bracers·  Imperial Plate Chest·  Imperial Plate Helm·  Imperial Plate Leggings·  Imperial Plate Shoulders·",
	},
	["12428:0:0:0"] = {
		["i"] = "Imperial Plate Shoulders",
		["t"] = "Imperial Plate Shoulders·Binds when equipped·Shoulder·Plate·380 Armor·+12 Strength·+11 Stamina·Requires Level 47· \
·Imperial Plate (7)·  Imperial Plate Belt·  Imperial Plate Boots·  Imperial Plate Bracers·  Imperial Plate Chest·  Imperial Plate Helm·  Imperial Plate Leggings·  Imperial Plate Shoulders·",
		["c"] = "1eff00",
	},
	["15067:0:0:0"] = {
		["i"] = "Ironfeather Shoulders",
		["c"] = "0070dd",
		["t"] = "Ironfeather Shoulders·Binds when equipped·Shoulder·Leather·117 Armor·+20 Intellect·+8 Spirit·Requires Level 49· \
·Ironfeather Armor (2)·  Ironfeather Breastplate·  Ironfeather Shoulders·",
	},
	["15066:0:0:0"] = {
		["i"] = "Ironfeather Breastplate",
		["t"] = "Ironfeather Breastplate·Binds when equipped·Chest·Leather·165 Armor·+12 Intellect·+28 Spirit·Requires Level 53· \
·Ironfeather Armor (2)·  Ironfeather Breastplate·  Ironfeather Shoulders·",
		["c"] = "0070dd",
	},
	["19685:0:0:0"] = {
		["i"] = "Primal Batskin Jerkin",
		["c"] = "0070dd",
		["t"] = "Primal Batskin Jerkin·Binds when equipped·Chest·Leather·181 Armor·+32 Agility·+6 Stamina·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Primal Batskin (3)·Requires Leatherworking (300)·  Primal Batskin Jerkin·  Primal Batskin Bracers·  Primal Batskin Gloves·",
	},
	["19687:0:0:0"] = {
		["i"] = "Primal Batskin Bracers",
		["t"] = "Primal Batskin Bracers·Binds when equipped·Wrist·Leather·79 Armor·+14 Agility·+7 Stamina·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Primal Batskin (3)·Requires Leatherworking (300)·  Primal Batskin Jerkin·  Primal Batskin Bracers·  Primal Batskin Gloves·",
		["c"] = "0070dd",
	},
	["19686:0:0:0"] = {
		["i"] = "Primal Batskin Gloves",
		["t"] = "Primal Batskin Gloves·Binds when equipped·Hands·Leather·113 Armor·+10 Agility·+9 Stamina·Requires Level 60·Equip: Improves your chance to hit by 2%.· \
·Primal Batskin (3)·Requires Leatherworking (300)·  Primal Batskin Jerkin·  Primal Batskin Bracers·  Primal Batskin Gloves·",
		["c"] = "0070dd",
	},
	["10332:0:0:0"] = {
		["i"] = "Scarlet Boots",
		["c"] = "0070dd",
		["t"] = "Scarlet Boots·Binds when equipped·Feet·Mail·161 Armor·+5 Agility·+12 Stamina·Requires Level 30· \
·Chain of the Scarlet Crusade (6)·  Scarlet Belt·  Scarlet Boots·  Scarlet Chestpiece·  Scarlet Gauntlets·  Scarlet Leggings·  Scarlet Wristguards·",
	},
	["10330:0:0:0"] = {
		["i"] = "Scarlet Leggings",
		["c"] = "0070dd",
		["t"] = "Scarlet Leggings·Binds when picked up·Legs·Mail·233 Armor·+20 Strength·+10 Stamina·Requires Level 38· \
·Chain of the Scarlet Crusade (6)·  Scarlet Belt·  Scarlet Boots·  Scarlet Chestpiece·  Scarlet Gauntlets·  Scarlet Leggings·  Scarlet Wristguards·",
	},
	["10331:0:0:0"] = {
		["i"] = "Scarlet Gauntlets",
		["c"] = "1eff00",
		["t"] = "Scarlet Gauntlets·Binds when equipped·Hands·Mail·139 Armor·+8 Strength·+7 Agility·Requires Level 33· \
·Chain of the Scarlet Crusade (6)·  Scarlet Belt·  Scarlet Boots·  Scarlet Chestpiece·  Scarlet Gauntlets·  Scarlet Leggings·  Scarlet Wristguards·",
	},
	["10333:0:0:0"] = {
		["i"] = "Scarlet Wristguards",
		["c"] = "1eff00",
		["t"] = "Scarlet Wristguards·Binds when equipped·Wrist·Mail·95 Armor·+8 Stamina·Requires Level 31· \
·Chain of the Scarlet Crusade (6)·  Scarlet Belt·  Scarlet Boots·  Scarlet Chestpiece·  Scarlet Gauntlets·  Scarlet Leggings·  Scarlet Wristguards·",
	},
	["10328:0:0:0"] = {
		["i"] = "Scarlet Chestpiece",
		["c"] = "0070dd",
		["t"] = "Scarlet Chestpiece·Binds when equipped·Chest·Mail·250 Armor·+8 Strength·+19 Stamina·Requires Level 34· \
·Chain of the Scarlet Crusade (6)·  Scarlet Belt·  Scarlet Boots·  Scarlet Chestpiece·  Scarlet Gauntlets·  Scarlet Leggings·  Scarlet Wristguards·",
	},
	["10329:0:0:0"] = {
		["i"] = "Scarlet Belt",
		["t"] = "Scarlet Belt·Binds when equipped·Waist·Mail·123 Armor·+8 Strength·+7 Stamina·Requires Level 32· \
·Chain of the Scarlet Crusade (6)·  Scarlet Belt·  Scarlet Boots·  Scarlet Chestpiece·  Scarlet Gauntlets·  Scarlet Leggings·  Scarlet Wristguards·",
		["c"] = "1eff00",
	},
	["15058:0:0:0"] = {
		["i"] = "Stormshroud Shoulders",
		["c"] = "0070dd",
		["t"] = "Stormshroud Shoulders·Binds when equipped·Shoulder·Leather·126 Armor·+12 Stamina·Requires Level 54·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases your chance to dodge an attack by 1%.· \
·Stormshroud Armor (3)·  Stormshroud Armor·  Stormshroud Pants·  Stormshroud Shoulders·",
	},
	["15056:0:0:0"] = {
		["i"] = "Stormshroud Armor",
		["t"] = "Stormshroud Armor·Binds when equipped·Chest·Leather·163 Armor·Requires Level 52·Equip: Improves your chance to get a critical strike by 2%.·Equip: Increases your chance to dodge an attack by 1%.· \
·Stormshroud Armor (3)·  Stormshroud Armor·  Stormshroud Pants·  Stormshroud Shoulders·",
		["c"] = "0070dd",
	},
	["15057:0:0:0"] = {
		["i"] = "Stormshroud Pants",
		["t"] = "Stormshroud Pants·Binds when equipped·Legs·Leather·138 Armor·Requires Level 50·Equip: Improves your chance to get a critical strike by 2%.·Equip: Increases your chance to dodge an attack by 1%.· \
·Stormshroud Armor (3)·  Stormshroud Armor·  Stormshroud Pants·  Stormshroud Shoulders·",
		["c"] = "0070dd",
	},
	["20408:0:0:0"] = {
		["i"] = "Twilight Cultist Cowl",
		["c"] = "1eff00",
		["t"] = "Twilight Cultist Cowl·Head·Cloth·63 Armor·Requires Level 60· \
·Twilight Trappings (3)·  Twilight Cultist Mantle·  Twilight Cultist Cowl·  Twilight Cultist Robe·",
	},
	["20407:0:0:0"] = {
		["i"] = "Twilight Cultist Robe",
		["t"] = "Twilight Cultist Robe·Chest·Cloth·77 Armor·Requires Level 60· \
·Twilight Trappings (3)·  Twilight Cultist Mantle·  Twilight Cultist Cowl·  Twilight Cultist Robe·",
		["c"] = "1eff00",
	},
	["20406:0:0:0"] = {
		["i"] = "Twilight Cultist Mantle",
		["t"] = "Twilight Cultist Mantle·Shoulder·Cloth·58 Armor·Requires Level 60· \
·Twilight Trappings (3)·  Twilight Cultist Mantle·  Twilight Cultist Cowl·  Twilight Cultist Robe·",
		["c"] = "1eff00",
	},
	["15054:0:0:0"] = {
		["i"] = "Volcanic Leggings",
		["c"] = "1eff00",
		["t"] = "Volcanic Leggings·Binds when equipped·Legs·Leather·204 Armor·+20 Fire Resistance·Requires Level 49· \
·Volcanic Armor (3)·  Volcanic Breastplate·  Volcanic Leggings·  Volcanic Shoulders·",
	},
	["15053:0:0:0"] = {
		["i"] = "Volcanic Breastplate",
		["c"] = "1eff00",
		["t"] = "Volcanic Breastplate·Binds when equipped·Chest·Leather·268 Armor·+20 Fire Resistance·Requires Level 52· \
·Volcanic Armor (3)·  Volcanic Breastplate·  Volcanic Leggings·  Volcanic Shoulders·",
	},
	["15055:0:0:0"] = {
		["i"] = "Volcanic Shoulders",
		["c"] = "1eff00",
		["t"] = "Volcanic Shoulders·Binds when equipped·Shoulder·Leather·167 Armor·+18 Fire Resistance·Requires Level 56· \
·Volcanic Armor (3)·  Volcanic Breastplate·  Volcanic Leggings·  Volcanic Shoulders·",
	},
	["19865:0:0:0"] = {
		["i"] = "Warblade of the Hakkari",
		["t"] = "Warblade of the Hakkari·Binds when picked up·Unique·Main Hand·Sword·59 - 110 Damage·Speed 1.70·(49.7 damage per second)·Requires Level 60·Equip: +28 Attack Power.·Equip: Improves your chance to get a critical strike by 1%.· \
·The Twin Blades of Hakkari (2)·  Warblade of the Hakkari·  Warblade of the Hakkari·",
		["c"] = "a335ee",
	},
	["19866:0:0:0"] = {
		["i"] = "Warblade of the Hakkari",
		["c"] = "a335ee",
		["t"] = "Warblade of the Hakkari·Binds when picked up·Unique·Off Hand·Sword·57 - 106 Damage·Speed 1.70·(47.9 damage per second)·Requires Level 60·Equip: +40 Attack Power.· \
·The Twin Blades of Hakkari (2)·  Warblade of the Hakkari·  Warblade of the Hakkari·",
	},
	["12939:0:0:0"] = {
		["i"] = "Dal'Rend's Tribal Guardian",
		["c"] = "0070dd",
		["t"] = "Dal'Rend's Tribal Guardian·Binds when picked up·Off Hand·Sword·52 - 97 Damage·Speed 1.80·(41.4 damage per second)·100 Armor·Requires Level 58·Equip: Increased Defense +7.· \
·Dal'Rend's Arms (2)·  Dal'Rend's Sacred Charge·  Dal'Rend's Tribal Guardian·",
	},
	["12940:0:0:0"] = {
		["i"] = "Dal'Rend's Sacred Charge",
		["t"] = "Dal'Rend's Sacred Charge·Binds when picked up·Main Hand·Sword·81 - 151 Damage·Speed 2.80·(41.4 damage per second)·+4 Strength·Requires Level 58·Equip: Improves your chance to get a critical strike by 1%.· \
·Dal'Rend's Arms (2)·  Dal'Rend's Sacred Charge·  Dal'Rend's Tribal Guardian·",
		["c"] = "0070dd",
	},
	["19910:0:0:0"] = {
		["i"] = "Arlokk's Grasp",
		["t"] = "Arlokk's Grasp·Binds when picked up·Unique·Off Hand·Fist Weapon·41 - 85 Damage·Speed 1.50·(42.0 damage per second)·Requires Level 60·Chance on hit: Sends a shadowy bolt at the enemy causing 55 to 85 Shadow damage.· \
·Primal Blessing (2)·  Thekal's Grasp·  Arlokk's Grasp·",
		["c"] = "a335ee",
	},
	["19896:0:0:0"] = {
		["i"] = "Thekal's Grasp",
		["t"] = "Thekal's Grasp·Binds when picked up·Unique·Main Hand·Fist Weapon·72 - 135 Damage·Speed 2.20·(47.0 damage per second)·+13 Stamina·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Primal Blessing (2)·  Thekal's Grasp·  Arlokk's Grasp·",
		["c"] = "a335ee",
	},
	["13218:0:0:0"] = {
		["i"] = "Fang of the Crystal Spider",
		["c"] = "0070dd",
		["t"] = "Fang of the Crystal Spider·Binds when picked up·One-Hand·Dagger·45 - 84 Damage·Speed 1.60·(40.3 damage per second)·Requires Level 56·Chance on hit: Slows target enemy's casting speed, melee attack speed and range attack speed by 10% for 10 sec.· \
·Spider's Kiss (2)·  Fang of the Crystal Spider·  Venomspitter·",
	},
	["13183:0:0:0"] = {
		["i"] = "Venomspitter",
		["c"] = "0070dd",
		["t"] = "Venomspitter·Binds when picked up·One-Hand·Mace·52 - 98 Damage·Speed 1.90·(39.5 damage per second)·Requires Level 55·Chance on hit: Poisons target for 7 Nature damage every 2 sec for 30 sec.· \
·Spider's Kiss (2)·  Fang of the Crystal Spider·  Venomspitter·",
	},
	["19920:0:0:0"] = {
		["i"] = "Primalist's Band",
		["t"] = "Primalist's Band·Binds when picked up·Unique·Finger·+8 Stamina·+10 Intellect·Requires Level 60·Equip: Restores 6 mana per 5 sec.· \
·Prayer of the Primal (2)·  Primalist's Seal·  Primalist's Band·",
		["c"] = "0070dd",
	},
	["19863:0:0:0"] = {
		["i"] = "Primalist's Seal",
		["c"] = "0070dd",
		["t"] = "Primalist's Seal·Binds when picked up·Unique·Finger·+12 Intellect·+8 Spirit·Requires Level 60·Equip: Increases healing done by spells and effects by up to 29.· \
·Prayer of the Primal (2)·  Primalist's Seal·  Primalist's Band·",
	},
	["19905:0:0:0"] = {
		["i"] = "Zanzil's Band",
		["t"] = "Zanzil's Band·Binds when picked up·Unique·Finger·+13 Intellect·Requires Level 60·Equip: Improves your chance to hit with spells by 1%.·Equip: Restores 4 mana per 5 sec.· \
·Zanzil's Concentration (2)·  Zanzil's Band·  Zanzil's Seal·",
		["c"] = "0070dd",
	},
	["19893:0:0:0"] = {
		["i"] = "Zanzil's Seal",
		["c"] = "0070dd",
		["t"] = "Zanzil's Seal·Binds when picked up·Unique·Finger·+10 Stamina·+10 Intellect·Requires Level 60·Equip: Improves your chance to hit with spells by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 11.· \
·Zanzil's Concentration (2)·  Zanzil's Band·  Zanzil's Seal·",
	},
	["21354:0:0:0"] = {
		["i"] = "Genesis Shoulderpads",
		["c"] = "a335ee",
		["t"] = "Genesis Shoulderpads·Binds when picked up·Shoulder·Leather·172 Armor·+15 Strength·+14 Agility·+15 Stamina·+13 Intellect·+6 Spirit·Classes: Druid·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.·Equip: Restores 3 mana per 5 sec.· \
·Genesis Raiment (5)·  Genesis Boots·  Genesis Helm·  Genesis Shoulderpads·  Genesis Trousers·  Genesis Vest·",
	},
	["21356:0:0:0"] = {
		["i"] = "Genesis Trousers",
		["c"] = "a335ee",
		["t"] = "Genesis Trousers·Binds when picked up·Legs·Leather·207 Armor·+12 Strength·+12 Agility·+22 Stamina·+22 Intellect·+9 Spirit·Classes: Druid·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 27.·Equip: Improves your chance to get a critical strike by 1%.·Equip: Restores 4 mana per 5 sec.· \
·Genesis Raiment (5)·  Genesis Boots·  Genesis Helm·  Genesis Shoulderpads·  Genesis Trousers·  Genesis Vest·",
	},
	["21357:0:0:0"] = {
		["i"] = "Genesis Vest",
		["c"] = "a335ee",
		["d"] = "bi2·lo6·ar253·le60·se65·ty0·su1·",
		["t"] = "Genesis Vest·Binds when picked up·Chest·Leather·253 Armor·+13 Strength·+12 Agility·+24 Stamina·+24 Intellect·+11 Spirit·Classes: Druid·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 28.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Improves your chance to get a critical strike by 1%.· \
·Genesis Raiment (5)·  Genesis Boots·  Genesis Helm·  Genesis Shoulderpads·  Genesis Trousers·  Genesis Vest·",
	},
	["21355:0:0:0"] = {
		["i"] = "Genesis Boots",
		["c"] = "a335ee",
		["t"] = "Genesis Boots·Binds when picked up·Feet·Leather·158 Armor·+12 Strength·+13 Agility·+14 Stamina·+14 Intellect·+6 Spirit·Classes: Druid·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.·Equip: Restores 4 mana per 5 sec.·Equip: Decreases the magical resistances of your spell targets by 10.· \
·Genesis Raiment (5)·  Genesis Boots·  Genesis Helm·  Genesis Shoulderpads·  Genesis Trousers·  Genesis Vest·",
	},
	["21353:0:0:0"] = {
		["i"] = "Genesis Helm",
		["c"] = "a335ee",
		["t"] = "Genesis Helm·Binds when picked up·Head·Leather·192 Armor·+15 Strength·+12 Agility·+22 Stamina·+22 Intellect·+12 Spirit·Classes: Druid·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 27.·Equip: Improves your chance to get a critical strike by 1%.· \
·Genesis Raiment (5)·  Genesis Boots·  Genesis Helm·  Genesis Shoulderpads·  Genesis Trousers·  Genesis Vest·",
	},
	["21365:0:0:0"] = {
		["i"] = "Striker's Footguards",
		["c"] = "a335ee",
		["t"] = "Striker's Footguards·Binds when picked up·Feet·Mail·340 Armor·+31 Agility·+16 Stamina·+8 Intellect·+6 Spirit·Classes: Hunter·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 6.· \
·Striker's Garb (5)·  Striker's Diadem·  Striker's Footguards·  Striker's Hauberk·  Striker's Leggings·  Striker's Pauldrons·",
	},
	["21370:0:0:0"] = {
		["i"] = "Striker's Hauberk",
		["c"] = "a335ee",
		["t"] = "Striker's Hauberk·Binds when picked up·Chest·Mail·553 Armor·+39 Agility·+26 Stamina·+15 Intellect·+7 Spirit·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·Striker's Garb (5)·  Striker's Diadem·  Striker's Footguards·  Striker's Hauberk·  Striker's Leggings·  Striker's Pauldrons·",
	},
	["21368:0:0:0"] = {
		["i"] = "Striker's Leggings",
		["c"] = "a335ee",
		["t"] = "Striker's Leggings·Binds when picked up·Legs·Mail·448 Armor·+36 Agility·+22 Stamina·+14 Intellect·+10 Spirit·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 9.· \
·Striker's Garb (5)·  Striker's Diadem·  Striker's Footguards·  Striker's Hauberk·  Striker's Leggings·  Striker's Pauldrons·",
	},
	["21367:0:0:0"] = {
		["i"] = "Striker's Pauldrons",
		["c"] = "a335ee",
		["t"] = "Striker's Pauldrons·Binds when picked up·Shoulder·Mail·384 Armor·+26 Agility·+24 Stamina·+11 Intellect·+5 Spirit·Classes: Hunter·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 6.· \
·Striker's Garb (5)·  Striker's Diadem·  Striker's Footguards·  Striker's Hauberk·  Striker's Leggings·  Striker's Pauldrons·",
	},
	["21366:0:0:0"] = {
		["i"] = "Striker's Diadem",
		["c"] = "a335ee",
		["t"] = "Striker's Diadem·Binds when picked up·Head·Mail·416 Armor·+29 Agility·+26 Stamina·+18 Intellect·+10 Spirit·Classes: Hunter·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.·Equip: Increases damage and healing done by magical spells and effects by up to 12.· \
·Striker's Garb (5)·  Striker's Diadem·  Striker's Footguards·  Striker's Hauberk·  Striker's Leggings·  Striker's Pauldrons·",
	},
	["21345:0:0:0"] = {
		["i"] = "Enigma Shoulderpads",
		["c"] = "a335ee",
		["t"] = "Enigma Shoulderpads·Binds when picked up·Shoulder·Cloth·89 Armor·+16 Stamina·+12 Intellect·+4 Spirit·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 30.·Equip: Decreases the magical resistances of your spell targets by 10.·Equip: Restores 4 mana per 5 sec.· \
·Enigma Vestments (5)·  Enigma Boots·  Enigma Circlet·  Enigma Leggings·  Enigma Robes·  Enigma Shoulderpads·",
	},
	["21343:0:0:0"] = {
		["i"] = "Enigma Robes",
		["c"] = "a335ee",
		["t"] = "Enigma Robes·Binds when picked up·Chest·Cloth·133 Armor·+19 Stamina·+23 Intellect·+7 Spirit·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 39.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Decreases the magical resistances of your spell targets by 20.· \
·Enigma Vestments (5)·  Enigma Boots·  Enigma Circlet·  Enigma Leggings·  Enigma Robes·  Enigma Shoulderpads·",
	},
	["21346:0:0:0"] = {
		["i"] = "Enigma Leggings",
		["c"] = "a335ee",
		["t"] = "Enigma Leggings·Binds when picked up·Legs·Cloth·107 Armor·+21 Stamina·+26 Intellect·+8 Spirit·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 34.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Restores 5 mana per 5 sec.· \
·Enigma Vestments (5)·  Enigma Boots·  Enigma Circlet·  Enigma Leggings·  Enigma Robes·  Enigma Shoulderpads·",
	},
	["21347:0:0:0"] = {
		["i"] = "Enigma Circlet",
		["c"] = "a335ee",
		["t"] = "Enigma Circlet·Binds when picked up·Head·Cloth·100 Armor·+24 Stamina·+24 Intellect·+12 Spirit·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 33.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Improves your chance to hit with spells by 1%.· \
·Enigma Vestments (5)·  Enigma Boots·  Enigma Circlet·  Enigma Leggings·  Enigma Robes·  Enigma Shoulderpads·",
	},
	["21344:0:0:0"] = {
		["i"] = "Enigma Boots",
		["c"] = "a335ee",
		["t"] = "Enigma Boots·Binds when picked up·Feet·Cloth·82 Armor·+15 Stamina·+15 Intellect·+6 Spirit·Classes: Mage·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 28.·Equip: Improves your chance to hit with spells by 1%.·Equip: Restores 4 mana per 5 sec.· \
·Enigma Vestments (5)·  Enigma Boots·  Enigma Circlet·  Enigma Leggings·  Enigma Robes·  Enigma Shoulderpads·",
	},
	["21390:0:0:0"] = {
		["i"] = "Avenger's Legguards",
		["c"] = "a335ee",
		["t"] = "Avenger's Legguards·Binds when picked up·Legs·Plate·796 Armor·+21 Strength·+12 Agility·+22 Stamina·+22 Intellect·+9 Spirit·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 16.·Equip: Improves your chance to get a critical strike by 1%.·Equip: Restores 4 mana per 5 sec.· \
·Avenger's Battlegear (5)·  Avenger's Breastplate·  Avenger's Crown·  Avenger's Greaves·  Avenger's Legguards·  Avenger's Pauldrons·",
	},
	["21389:0:0:0"] = {
		["i"] = "Avenger's Breastplate",
		["c"] = "a335ee",
		["t"] = "Avenger's Breastplate·Binds when picked up·Chest·Plate·985 Armor·+23 Strength·+12 Agility·+24 Stamina·+24 Intellect·+11 Spirit·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 18.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Improves your chance to get a critical strike by 1%.· \
·Avenger's Battlegear (5)·  Avenger's Breastplate·  Avenger's Crown·  Avenger's Greaves·  Avenger's Legguards·  Avenger's Pauldrons·",
	},
	["21388:0:0:0"] = {
		["i"] = "Avenger's Greaves",
		["c"] = "a335ee",
		["t"] = "Avenger's Greaves·Binds when picked up·Feet·Plate·604 Armor·+18 Strength·+13 Agility·+18 Stamina·+14 Intellect·+6 Spirit·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 14.·Equip: Restores 4 mana per 5 sec.· \
·Avenger's Battlegear (5)·  Avenger's Breastplate·  Avenger's Crown·  Avenger's Greaves·  Avenger's Legguards·  Avenger's Pauldrons·",
	},
	["21387:0:0:0"] = {
		["i"] = "Avenger's Crown",
		["c"] = "a335ee",
		["t"] = "Avenger's Crown·Binds when picked up·Head·Plate·739 Armor·+20 Strength·+12 Agility·+22 Stamina·+22 Intellect·+12 Spirit·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 23.·Equip: Improves your chance to get a critical strike by 1%.· \
·Avenger's Battlegear (5)·  Avenger's Breastplate·  Avenger's Crown·  Avenger's Greaves·  Avenger's Legguards·  Avenger's Pauldrons·",
	},
	["21391:0:0:0"] = {
		["i"] = "Avenger's Pauldrons",
		["c"] = "a335ee",
		["t"] = "Avenger's Pauldrons·Binds when picked up·Shoulder·Plate·659 Armor·+18 Strength·+14 Agility·+15 Stamina·+13 Intellect·+6 Spirit·Classes: Paladin·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 14.·Equip: Restores 3 mana per 5 sec.· \
·Avenger's Battlegear (5)·  Avenger's Breastplate·  Avenger's Crown·  Avenger's Greaves·  Avenger's Legguards·  Avenger's Pauldrons·",
	},
	["21349:0:0:0"] = {
		["i"] = "Footwraps of the Oracle",
		["c"] = "a335ee",
		["t"] = "Footwraps of the Oracle·Binds when picked up·Feet·Cloth·112 Armor·+20 Stamina·+17 Intellect·+12 Spirit·Classes: Priest·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 21.·Equip: Restores 3 mana per 5 sec.· \
·Garments of the Oracle (5)·  Footwraps of the Oracle·  Mantle of the Oracle·  Tiara of the Oracle·  Trousers of the Oracle·  Vestments of the Oracle·",
	},
	["21350:0:0:0"] = {
		["i"] = "Mantle of the Oracle",
		["c"] = "a335ee",
		["t"] = "Mantle of the Oracle·Binds when picked up·Shoulder·Cloth·119 Armor·+21 Stamina·+20 Intellect·+8 Spirit·Classes: Priest·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 20.·Equip: Restores 3 mana per 5 sec.·Equip: Decreases the magical resistances of your spell targets by 10.· \
·Garments of the Oracle (5)·  Footwraps of the Oracle·  Mantle of the Oracle·  Tiara of the Oracle·  Trousers of the Oracle·  Vestments of the Oracle·",
	},
	["21351:0:0:0"] = {
		["i"] = "Vestments of the Oracle",
		["c"] = "a335ee",
		["t"] = "Vestments of the Oracle·Binds when picked up·Chest·Cloth·183 Armor·+23 Stamina·+26 Intellect·+15 Spirit·Classes: Priest·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 36.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Decreases the magical resistances of your spell targets by 10.· \
·Garments of the Oracle (5)·  Footwraps of the Oracle·  Mantle of the Oracle·  Tiara of the Oracle·  Trousers of the Oracle·  Vestments of the Oracle·",
	},
	["21348:0:0:0"] = {
		["i"] = "Tiara of the Oracle",
		["c"] = "a335ee",
		["t"] = "Tiara of the Oracle·Binds when picked up·Head·Cloth·150 Armor·+22 Stamina·+22 Intellect·+16 Spirit·Classes: Priest·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 28.·Equip: Restores 7 mana per 5 sec.·Equip: Improves your chance to hit with spells by 1%.· \
·Garments of the Oracle (5)·  Footwraps of the Oracle·  Mantle of the Oracle·  Tiara of the Oracle·  Trousers of the Oracle·  Vestments of the Oracle·",
	},
	["21352:0:0:0"] = {
		["i"] = "Trousers of the Oracle",
		["c"] = "a335ee",
		["t"] = "Trousers of the Oracle·Binds when picked up·Legs·Cloth·157 Armor·+23 Stamina·+24 Intellect·+14 Spirit·Classes: Priest·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 33.·Equip: Restores 6 mana per 5 sec.· \
·Garments of the Oracle (5)·  Footwraps of the Oracle·  Mantle of the Oracle·  Tiara of the Oracle·  Trousers of the Oracle·  Vestments of the Oracle·",
	},
	["21359:0:0:0"] = {
		["i"] = "Deathdealer's Boots",
		["c"] = "a335ee",
		["t"] = "Deathdealer's Boots·Binds when picked up·Feet·Leather·158 Armor·+17 Strength·+30 Agility·+21 Stamina·Classes: Rogue·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Deathdealer's Embrace (5)·  Deathdealer's Boots·  Deathdealer's Helm·  Deathdealer's Spaulders·  Deathdealer's Leggings·  Deathdealer's Vest·",
	},
	["21361:0:0:0"] = {
		["i"] = "Deathdealer's Spaulders",
		["c"] = "a335ee",
		["t"] = "Deathdealer's Spaulders·Binds when picked up·Shoulder·Leather·172 Armor·+18 Strength·+27 Agility·+25 Stamina·Classes: Rogue·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Deathdealer's Embrace (5)·  Deathdealer's Boots·  Deathdealer's Helm·  Deathdealer's Spaulders·  Deathdealer's Leggings·  Deathdealer's Vest·",
	},
	["21362:0:0:0"] = {
		["i"] = "Deathdealer's Leggings",
		["c"] = "a335ee",
		["t"] = "Deathdealer's Leggings·Binds when picked up·Legs·Leather·207 Armor·+18 Strength·+38 Agility·+25 Stamina·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.· \
·Deathdealer's Embrace (5)·  Deathdealer's Boots·  Deathdealer's Helm·  Deathdealer's Spaulders·  Deathdealer's Leggings·  Deathdealer's Vest·",
	},
	["21360:0:0:0"] = {
		["i"] = "Deathdealer's Helm",
		["c"] = "a335ee",
		["t"] = "Deathdealer's Helm·Binds when picked up·Head·Leather·192 Armor·+25 Strength·+29 Agility·+27 Stamina·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.·Equip: Improves your chance to hit by 1%.· \
·Deathdealer's Embrace (5)·  Deathdealer's Boots·  Deathdealer's Helm·  Deathdealer's Spaulders·  Deathdealer's Leggings·  Deathdealer's Vest·",
	},
	["21364:0:0:0"] = {
		["i"] = "Deathdealer's Vest",
		["c"] = "a335ee",
		["t"] = "Deathdealer's Vest·Binds when picked up·Chest·Leather·253 Armor·+19 Strength·+37 Agility·+28 Stamina·Classes: Rogue·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.·Equip: Improves your chance to hit by 1%.· \
·Deathdealer's Embrace (5)·  Deathdealer's Boots·  Deathdealer's Helm·  Deathdealer's Spaulders·  Deathdealer's Leggings·  Deathdealer's Vest·",
	},
	["21375:0:0:0"] = {
		["i"] = "Stormcaller's Leggings",
		["c"] = "a335ee",
		["t"] = "Stormcaller's Leggings·Binds when picked up·Legs·Mail·448 Armor·+12 Strength·+9 Agility·+22 Stamina·+22 Intellect·+12 Spirit·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 29.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Restores 4 mana per 5 sec.· \
·Stormcaller's Garb (5)·  Stormcaller's Diadem·  Stormcaller's Footguards·  Stormcaller's Hauberk·  Stormcaller's Leggings·  Stormcaller's Pauldrons·",
	},
	["21376:0:0:0"] = {
		["i"] = "Stormcaller's Pauldrons",
		["c"] = "a335ee",
		["t"] = "Stormcaller's Pauldrons·Binds when picked up·Shoulder·Mail·371 Armor·+10 Strength·+10 Agility·+15 Stamina·+13 Intellect·+6 Spirit·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 28.·Equip: Restores 3 mana per 5 sec.· \
·Stormcaller's Garb (5)·  Stormcaller's Diadem·  Stormcaller's Footguards·  Stormcaller's Hauberk·  Stormcaller's Leggings·  Stormcaller's Pauldrons·",
	},
	["21372:0:0:0"] = {
		["i"] = "Stormcaller's Diadem",
		["c"] = "a335ee",
		["t"] = "Stormcaller's Diadem·Binds when picked up·Head·Mail·416 Armor·+12 Strength·+8 Agility·+22 Stamina·+22 Intellect·+12 Spirit·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 32.·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Stormcaller's Garb (5)·  Stormcaller's Diadem·  Stormcaller's Footguards·  Stormcaller's Hauberk·  Stormcaller's Leggings·  Stormcaller's Pauldrons·",
	},
	["21373:0:0:0"] = {
		["i"] = "Stormcaller's Footguards",
		["c"] = "a335ee",
		["t"] = "Stormcaller's Footguards·Binds when picked up·Feet·Mail·340 Armor·+12 Strength·+9 Agility·+14 Stamina·+14 Intellect·+6 Spirit·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 22.·Equip: Decreases the magical resistances of your spell targets by 10.·Equip: Restores 4 mana per 5 sec.· \
·Stormcaller's Garb (5)·  Stormcaller's Diadem·  Stormcaller's Footguards·  Stormcaller's Hauberk·  Stormcaller's Leggings·  Stormcaller's Pauldrons·",
	},
	["21374:0:0:0"] = {
		["i"] = "Stormcaller's Hauberk",
		["c"] = "a335ee",
		["t"] = "Stormcaller's Hauberk·Binds when picked up·Chest·Mail·553 Armor·+11 Strength·+10 Agility·+24 Stamina·+24 Intellect·+11 Spirit·Classes: Shaman·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 32.·Equip: Improves your chance to get a critical strike by 1%.·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Stormcaller's Garb (5)·  Stormcaller's Diadem·  Stormcaller's Footguards·  Stormcaller's Hauberk·  Stormcaller's Leggings·  Stormcaller's Pauldrons·",
	},
	["21336:0:0:0"] = {
		["i"] = "Doomcaller's Trousers",
		["c"] = "a335ee",
		["t"] = "Doomcaller's Trousers·Binds when picked up·Legs·Cloth·107 Armor·+28 Stamina·+24 Intellect·+9 Spirit·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 34.·Equip: Improves your chance to get a critical strike with spells by 1%.· \
·Doomcaller's Attire (5)·  Doomcaller's Circlet·  Doomcaller's Footwraps·  Doomcaller's Mantle·  Doomcaller's Robes·  Doomcaller's Trousers·",
	},
	["21337:0:0:0"] = {
		["i"] = "Doomcaller's Circlet",
		["c"] = "a335ee",
		["t"] = "Doomcaller's Circlet·Binds when picked up·Head·Cloth·100 Armor·+27 Stamina·+24 Intellect·+6 Spirit·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 33.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Improves your chance to hit with spells by 1%.· \
·Doomcaller's Attire (5)·  Doomcaller's Circlet·  Doomcaller's Footwraps·  Doomcaller's Mantle·  Doomcaller's Robes·  Doomcaller's Trousers·",
	},
	["21338:0:0:0"] = {
		["i"] = "Doomcaller's Footwraps",
		["c"] = "a335ee",
		["t"] = "Doomcaller's Footwraps·Binds when picked up·Feet·Cloth·82 Armor·+20 Stamina·+16 Intellect·+3 Spirit·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 28.·Equip: Decreases the magical resistances of your spell targets by 10.· \
·Doomcaller's Attire (5)·  Doomcaller's Circlet·  Doomcaller's Footwraps·  Doomcaller's Mantle·  Doomcaller's Robes·  Doomcaller's Trousers·",
	},
	["21335:0:0:0"] = {
		["i"] = "Doomcaller's Mantle",
		["c"] = "a335ee",
		["t"] = "Doomcaller's Mantle·Binds when picked up·Shoulder·Cloth·89 Armor·+20 Stamina·+11 Intellect·+4 Spirit·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 28.·Equip: Decreases the magical resistances of your spell targets by 10.·Equip: Improves your chance to hit with spells by 1%.· \
·Doomcaller's Attire (5)·  Doomcaller's Circlet·  Doomcaller's Footwraps·  Doomcaller's Mantle·  Doomcaller's Robes·  Doomcaller's Trousers·",
	},
	["21334:0:0:0"] = {
		["i"] = "Doomcaller's Robes",
		["c"] = "a335ee",
		["t"] = "Doomcaller's Robes·Binds when picked up·Chest·Cloth·133 Armor·+23 Stamina·+17 Intellect·+7 Spirit·Classes: Warlock·Requires Level 60·Equip: Increases damage and healing done by magical spells and effects by up to 41.·Equip: Improves your chance to get a critical strike with spells by 1%.·Equip: Decreases the magical resistances of your spell targets by 20.· \
·Doomcaller's Attire (5)·  Doomcaller's Circlet·  Doomcaller's Footwraps·  Doomcaller's Mantle·  Doomcaller's Robes·  Doomcaller's Trousers·",
	},
	["21333:0:0:0"] = {
		["i"] = "Conqueror's Greaves",
		["c"] = "a335ee",
		["t"] = "Conqueror's Greaves·Binds when picked up·Feet·Plate·604 Armor·+21 Strength·+17 Agility·+23 Stamina·Classes: Warrior·Requires Level 60·Equip: Increased Defense +4.· \
·Conqueror's Battlegear (5)·  Conqueror's Breastplate·  Conqueror's Crown·  Conqueror's Greaves·  Conqueror's Legguards·  Conqueror's Spaulders·",
	},
	["21329:0:0:0"] = {
		["i"] = "Conqueror's Crown",
		["c"] = "a335ee",
		["t"] = "Conqueror's Crown·Binds when picked up·Head·Plate·739 Armor·+29 Strength·+18 Agility·+34 Stamina·Classes: Warrior·Requires Level 60·Equip: Increased Defense +6.· \
·Conqueror's Battlegear (5)·  Conqueror's Breastplate·  Conqueror's Crown·  Conqueror's Greaves·  Conqueror's Legguards·  Conqueror's Spaulders·",
	},
	["21330:0:0:0"] = {
		["i"] = "Conqueror's Spaulders",
		["c"] = "a335ee",
		["t"] = "Conqueror's Spaulders·Binds when picked up·Shoulder·Plate·659 Armor·+20 Strength·+16 Agility·+21 Stamina·Classes: Warrior·Requires Level 60·Equip: Increased Defense +4.·Equip: Improves your chance to hit by 1%.· \
·Conqueror's Battlegear (5)·  Conqueror's Breastplate·  Conqueror's Crown·  Conqueror's Greaves·  Conqueror's Legguards·  Conqueror's Spaulders·",
	},
	["21331:0:0:0"] = {
		["i"] = "Conqueror's Breastplate",
		["c"] = "a335ee",
		["t"] = "Conqueror's Breastplate·Binds when picked up·Chest·Plate·985 Armor·+34 Strength·+24 Agility·+38 Stamina·Classes: Warrior·Requires Level 60·Equip: Increased Defense +6.· \
·Conqueror's Battlegear (5)·  Conqueror's Breastplate·  Conqueror's Crown·  Conqueror's Greaves·  Conqueror's Legguards·  Conqueror's Spaulders·",
	},
	["21332:0:0:0"] = {
		["i"] = "Conqueror's Legguards",
		["c"] = "a335ee",
		["t"] = "Conqueror's Legguards·Binds when picked up·Legs·Plate·796 Armor·+33 Strength·+21 Agility·+24 Stamina·Classes: Warrior·Requires Level 60·Equip: Increased Defense +6.·Equip: Improves your chance to hit by 1%.· \
·Conqueror's Battlegear (5)·  Conqueror's Breastplate·  Conqueror's Crown·  Conqueror's Greaves·  Conqueror's Legguards·  Conqueror's Spaulders·",
	},
	["19925:0:0:0"] = {
		["i"] = "Band of Jin",
		["c"] = "0070dd",
		["t"] = "Band of Jin·Binds when picked up·Unique·Finger·+14 Agility·+8 Stamina·Requires Level 60·Equip: Improves your chance to hit by 1%.· \
·Major Mojo Infusion (2)·  Seal of Jin·  Band of Jin·",
	},
	["19898:0:0:0"] = {
		["i"] = "Seal of Jin",
		["c"] = "0070dd",
		["t"] = "Seal of Jin·Binds when picked up·Unique·Finger·+8 Stamina·Requires Level 60·Equip: Improves your chance to get a critical strike by 1%.·Equip: +20 Attack Power.· \
·Major Mojo Infusion (2)·  Seal of Jin·  Band of Jin·",
	},
};
end