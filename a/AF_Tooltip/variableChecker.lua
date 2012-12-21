if (aftt_color_chart_name == nil) then
	aftt_color_chart_name = "Unknown Name";
	aftt_variableChecker_Flag = 1;
end

if (aftt_color_chart_author == nil) then
	aftt_color_chart_author = "Unknown Author";
	aftt_variableChecker_Flag = 1;
end

if (aftt_background_color == nil) then
	aftt_background_color = {};
	aftt_variableChecker_Flag = 1;
end

if (aftt_background_color["Player_Friendly"] == nil) then
	aftt_background_color["Player_Friendly"] = {
			["red"] =		0.0,
			["green"] =		0.0,
			["blue"] =		0.5,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Player_Friendly_PvP"] == nil) then
	aftt_background_color["Player_Friendly_PvP"] = {
			["red"] =		0.0,
			["green"] =		0.5,
			["blue"] =		0.0,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Player_Neutral"] == nil) then
	aftt_background_color["Player_Neutral"] = {
			["red"] =		0.5,
			["green"] =		0.5,
			["blue"] =		0.0,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Player_Caution"] == nil) then
	aftt_background_color["Player_Caution"] = {
			["red"] =		0.5,
			["green"] =		0.0,
			["blue"] =		0.5,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Player_Hostile"] == nil) then
	aftt_background_color["Player_Hostile"] = {
			["red"] =		0.5,
			["green"] =		0.0,
			["blue"] =		0.0,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Mob_Friendly"] == nil) then
	aftt_background_color["Player_Friendly"] = {
			["red"] =		0.0,
			["green"] =		0.0,
			["blue"] =		0.5,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Mob_Friendly_PvP"] == nil) then
	aftt_background_color["Player_Friendly_PvP"] = {
			["red"] =		0.0,
			["green"] =		0.5,
			["blue"] =		0.0,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Mob_Neutral"] == nil) then
	aftt_background_color["Player_Neutral"] = {
			["red"] =		0.5,
			["green"] =		0.5,
			["blue"] =		0.0,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_background_color["Mob_Hostile"] == nil) then
	aftt_background_color["Player_Caution"] = {
			["red"] =		0.5,
			["green"] =		0.0,
			["blue"] =		0.5,
		}
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_name_hostile == nil) then
	aftt_color_name_hostile = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_name_neutral == nil) then
	aftt_color_name_neutral = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_name_friendly == nil) then
	aftt_color_name_friendly = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_name_caution == nil) then
	aftt_color_name_caution = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_name_pvp == nil) then
	aftt_color_name_pvp = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_name_tapped_by_me == nil) then
	aftt_color_name_tapped_by_me = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_name_tapped_by_other == nil) then
	aftt_color_name_tapped_by_other = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end


if (aftt_color_description_hostile == nil) then
	aftt_color_description_hostile = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_description_neutral == nil) then
	aftt_color_description_neutral = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_description_friendly == nil) then
	aftt_color_description_friendly = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_description_caution == nil) then
	aftt_color_description_caution = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_description_pvp == nil) then
	aftt_color_description_pvp = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_description_tapped_by_me == nil) then
	aftt_color_description_tapped_by_me = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_description_tapped_by_other == nil) then
	aftt_color_description_tapped_by_other = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end


if (aftt_color_level_impossible == nil) then
	aftt_color_level_impossible = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_level_hard == nil) then
	aftt_color_level_hard = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_level_normal == nil) then
	aftt_color_level_normal = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_level_easy == nil) then
	aftt_color_level_easy = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_level_trivial == nil) then
	aftt_color_level_trivial = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_level_same_faction == nil) then
	aftt_color_level_same_faction = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end


if (aftt_color_class_mage == nil) then
	aftt_color_class_mage = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_warlock == nil) then
	aftt_color_class_warlock = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_priest == nil) then
	aftt_color_class_priest = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_druid == nil) then
	aftt_color_class_druid = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_shaman == nil) then
	aftt_color_class_shaman = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_paladin == nil) then
	aftt_color_class_paladin = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_rogue == nil) then
	aftt_color_class_rogue = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_hunter == nil) then
	aftt_color_class_hunter = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_class_warrior == nil) then
	aftt_color_class_warrior = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end


if (aftt_color_elite_elite == nil) then
	aftt_color_elite_elite = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_elite_rare == nil) then
	aftt_color_elite_rare = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_elite_rareelite == nil) then
	aftt_color_elite_rareelite = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_elite_worldboss == nil) then
	aftt_color_elite_worldboss = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end


if (aftt_color_corpse == nil) then
	aftt_color_corpse = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_unknown == nil) then
	aftt_color_unknown = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end
if (aftt_color_guildmate == nil) then
	aftt_color_guildmate = "FFFFFF";
	aftt_variableChecker_Flag = 1;
end