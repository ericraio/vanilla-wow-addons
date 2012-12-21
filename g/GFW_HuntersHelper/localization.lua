------------------------------------------------------
-- localization.lua
-- for Hunter's Helper
-- English strings by default; localizations override with their own.
------------------------------------------------------

-- We treat all five resistances as the same spell, because they're identical in all ways that we care about.
FHH_ARCANE_RESIST = "Arcane Resistance";
FHH_FIRE_RESIST = "Fire Resistance";
FHH_FROST_RESIST = "Frost Resistance";
FHH_NATURE_RESIST = "Nature Resistance";
FHH_SHADOW_RESIST = "Shadow Resistance";
-- So, our reverse mapping represents any of the five resistances.
FHH_ALL_RESISTS = "Arcane/Fire/Frost/Nature/Shadow Resistance";

-- Other spell names
FHH_STAMINA = "Great Stamina";
FHH_ARMOR = "Natural Armor";
FHH_BITE = "Bite";
FHH_CLAW = "Claw";
FHH_COWER = "Cower";
FHH_DASH = "Dash";
FHH_DIVE = "Dive";
FHH_GROWL = "Growl";
FHH_HOWL = "Furious Howl";
FHH_LIGHTNING = "Lightning Breath";
FHH_POISON = "Scorpid Poison";
FHH_PROWL = "Prowl";
FHH_SCREECH = "Screech";
FHH_CHARGE = "Charge";
FHH_SHELL = "Shell Shield";
FHH_THUNDERSTOMP = "Thunderstomp";

-- Beast family names
FHH_BAT = "Bat";
FHH_BEAR = "Bear";
FHH_BOAR = "Boar";
FHH_CARRION_BIRD = "Carrion Bird";
FHH_CAT = "Cat";
FHH_CRAB = "Crab";
FHH_CROCOLISK = "Crocolisk";
FHH_GORILLA = "Gorilla";
FHH_HYENA = "Hyena";
FHH_OWL = "Owl";
FHH_RAPTOR = "Raptor";
FHH_SCORPID = "Scorpid";
FHH_SPIDER = "Spider";
FHH_TALLSTRIDER = "Tallstrider";
FHH_TURTLE = "Turtle";
FHH_WIND_SERPENT = "Wind Serpent";
FHH_WOLF = "Wolf";

-- Other strings used in tables
FHH_ALL_FAMILIES = "all beast families";
FHH_PET_TRAINER = "Pet Trainers (found in major cities and some towns)";

if ( GetLocale() == "deDE" ) then

	-- We treat all five resistances as the same spell, because they're identical in all ways that we care about.
	FHH_ARCANE_RESIST = "Arkanwiderstand";
	FHH_FIRE_RESIST = "Feuerwiderstand";
	FHH_FROST_RESIST = "Frostwiderstand";
	FHH_NATURE_RESIST = "Naturwiderstand";
	FHH_SHADOW_RESIST = "Schattenwiderstand";
	-- So, our reverse mapping represents any of the five resistances.
	FHH_ALL_RESISTS = "Arkan/Feuer/Frost/Natur/Schatten Widerstand";

	-- Other spell names
	FHH_STAMINA = "Große Ausdauer";
	FHH_ARMOR = "Natürliche Rüstung";
	FHH_BITE = "Beißen";
	FHH_CLAW = "Klaue";
	FHH_COWER = "Ducken";
	FHH_DASH = "Spurt";
	FHH_DIVE = "Sturzflug";
	FHH_GROWL = "Knurren";
	FHH_HOWL = "Wutgeheul";
	FHH_LIGHTNING = "Blitzschlagatem";
	FHH_POISON = "Skorpidgift";
	FHH_PROWL = "Schleichen";
	FHH_SCREECH = "Schrei";
	
	-- Beast family names
	FHH_BAT = "Fledermaus";
	FHH_BEAR = "Bär";
	FHH_BOAR = "Eber";
	FHH_CARRION_BIRD = "Aasvogel";
	FHH_CAT = "Katze";
	FHH_CRAB = "Krebs";
	FHH_CROCOLISK = "Krokilisk";
--	FHH_GORILLA = "Gorilla";		-- same as enUS
	FHH_HYENA = "Hyäne";
	FHH_OWL = "Eule";
--	FHH_RAPTOR = "Raptor";		-- same as enUS
	FHH_SCORPID = "Skorpid";
	FHH_SPIDER = "Spinne";
	FHH_TALLSTRIDER = "Weitschreiter";
	FHH_TURTLE = "Schildkröte";
	FHH_WIND_SERPENT = "Windnatter";
--	FHH_WOLF = "Wolf";		-- same as enUS

end

if ( GetLocale() == "frFR" ) then

	 -- We treat all five resistances as the same spell, because they're identical in all ways that we care about.
	 FHH_ARCANE_RESIST = "Résistance aux arcanes";
	 FHH_FIRE_RESIST = "Résistance au feu";
	 FHH_FROST_RESIST = "Résistance au givre";
	 FHH_NATURE_RESIST = "Résistance à la nature";
	 FHH_SHADOW_RESIST = "Résistance à l'ombre";
	 -- So, our reverse mapping represents any of the five resistances.
	 FHH_ALL_RESISTS = "Résistance arcanes/feu/givre/nature/ombre";

	 -- Other spell names
	 FHH_STAMINA = "Endurance supérieure";
	 FHH_ARMOR = "Armure naturelle";
	 FHH_BITE = "Morsure";
	 FHH_CLAW = "Griffe";
	 FHH_COWER = "Tremblements";
	 FHH_DASH = "Célérité";
	 FHH_DIVE = "Plongeon";
	 FHH_GROWL = "Grondement";
	 FHH_HOWL = "Hurlement furieux";
	 FHH_LIGHTNING = "Souffle de foudre";
	 FHH_POISON = "Poison de scorpide";
	 FHH_PROWL = "Rôder";
	 FHH_SCREECH = "Hurlement";

	 -- Beast family names
	 FHH_BAT = "Chauve-souris";
	 FHH_BEAR = "Ours";
	 FHH_BOAR = "Sanglier";
	 FHH_CARRION_BIRD = "Charognard";
	 FHH_CAT = "Félin";
	 FHH_CRAB = "Crabe";
	 FHH_CROCOLISK = "Crocilisque";
	 FHH_GORILLA = "Gorille";
	 FHH_HYENA = "Hyène";
	 FHH_OWL = "Chouette";
	 FHH_RAPTOR = "Raptor";
	 FHH_SCORPID = "Scorpide";
	 FHH_SPIDER = "Araignée";
	 FHH_TALLSTRIDER = "Haut-trotteur";
	 FHH_TURTLE = "Tortue";
	 FHH_WIND_SERPENT = "Serpent des vents";
	 FHH_WOLF = "Loup";

	 -- Other strings used in tables
	 FHH_ALL_FAMILIES = "Toutes les familles animales";
	 FHH_PET_TRAINER = "Maîtres des familiers (trouvés dans les cités et certaines villes)";

end

if ( GetLocale() == "koKR" ) then


end

if ( GetLocale() == "zhCN" ) then

	-- We treat all five resistances as the same spell, because they're identical in all ways that we care about.
	FHH_ARCANE_RESIST = "奥术抗性";
	FHH_FIRE_RESIST = "火焰抗性";
	FHH_FROST_RESIST = "冰霜抗性";
	FHH_NATURE_RESIST = "自然抗性";
	FHH_SHADOW_RESIST = "暗影抗性";
	-- So, our reverse mapping represents any of the five resistances.
	FHH_ALL_RESISTS = "奥术/火焰/冰霜/自然/暗影 抗性";
	
	-- Other spell names
	FHH_STAMINA = "增强耐力";
	FHH_ARMOR = "自然护甲";
	FHH_BITE = "撕咬";
	FHH_CLAW = "爪击";
	FHH_COWER = "畏缩";
	FHH_DASH = "突进";
	FHH_DIVE = "俯冲";
	FHH_GROWL = "低吼";
	FHH_HOWL = "狂怒之嚎";
	FHH_LIGHTNING = "闪电吐息";
	FHH_POISON = "蝎毒";
	FHH_PROWL = "潜伏";
	FHH_SCREECH = "尖啸";
	FHH_CHARGE = "冲锋";
	FHH_SHELL = "龟壳护盾";
	FHH_THUNDERSTOMP = "雷霆践踏";
	
	-- Beast family names
	FHH_BAT = "蝙蝠";
	FHH_BEAR = "熊";
	FHH_BOAR = "野猪";
	FHH_CARRION_BIRD = "食腐鸟";
	FHH_CAT = "猫";
	FHH_CRAB = "螃蟹";
	FHH_CROCOLISK = "鳄鱼";
	FHH_GORILLA = "猩猩";
	FHH_HYENA = "土狼";
	FHH_OWL = "猫头鹰";
	FHH_RAPTOR = "迅猛龙";
	FHH_SCORPID = "蝎";
	FHH_SPIDER = "蜘蛛";
	FHH_TALLSTRIDER = "陆行鸟";
	FHH_TURTLE = "海龟";
	FHH_WIND_SERPENT = "风蛇";
	FHH_WOLF = "狼";
	
	-- Other strings used in tables
	FHH_ALL_FAMILIES = "全部野兽";
	FHH_PET_TRAINER = "宠物训练师(位于各大主城和某些城镇)";

end