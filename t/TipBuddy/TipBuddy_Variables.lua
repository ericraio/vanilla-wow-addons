--[[
This is the basic template for adding a variable:

["variable"] = { func = function(text, unit)
		code that creates the value that replaces your variable
		text = TipBuddy_gsub(text, 'variable', value);
		return text;
	end,

variable - Can be anything you want and doesn't necessarily have to be preceded with a $.
func - This is the function called when the variable needs to be updated.
	text - This is the entire text of the TextBox and must be returned after it is modified.
	unit - This is the unit ID (party1, player, target, etc.) that the TextBox refers to.
	No other parameters will be passed to your function and those 2 will always be passed.
	text = TipBuddy_gsub(text, 'variable', value) - This line is used to replace the variable 
	with the value you generated in the preceding code.  It handles trimming leading spaces 
	if value is nil or false.
--]]

TB_VARIABLE_FUNCTIONS = {
	-- New Line (resets coloring)
	["$nl"] = { func = function(text, unit)
				text = string.gsub(text, '$nl', "\n");
				return text;
		end,
		},

	-- Carriage Return (resets coloring)
	["\n"] = { func = function(text, unit)
				text = string.gsub(text, "\n", "|r\n");
				return text;
		end,
		},
	-- Name
	["$nm"] = { func = function(text, unit)
				local unitname = UnitName(unit);
				if (not unitname) then unitname = unit; end
				text = TipBuddy_gsub(text, '$nm', unitname, "nm");
				return text;
		end,
		},

	--Guild - Returns guild name for PCs, title for NPCs
	["$gu"] = { func = function(text, unit)
			local value = TipBuddy.gtt_guild;
			text = TipBuddy_gsub(text, '$gu', value, "gu");
			return text;
		end,
		},

	--Guild Title - returns the player's title rank in their guild
	["$gt"] = { func = function(text, unit)
			local _, value = GetGuildInfo(unit);
			text = TipBuddy_gsub(text, '$gt', value, "gt");
			return text;
		end,
		},

	-- Level
	["$lv"] = { func = function(text, unit)
				TipBuddy.gtt_level = UnitLevel(unit);
				local level = TipBuddy.gtt_level;
				if (level == -1) then
					level = "??";	
				end
				text = TipBuddy_gsub(text, '$lv', level, "lv");
				return text;
		end,
		},

	-- Unit's Class
	["$cl"] = { func = function(text, unit)
			--local class = TipBuddy.gtt_class;
			local class = UnitClass(unit);
			text = TipBuddy_gsub(text, '$cl', class, "cl");
			return text;
		end,
		},

	-- Race (players only)
	["$rc"] = { func = function(text, unit)
			local race = UnitRace(unit);
			text = TipBuddy_gsub(text, '$rc', race, "rc");
			return text;
		end,
		},

	-- Faction - Horde, Alliance, or nothing (players only)
	["$fa"] = { func = function(text, unit)
			local value = UnitFactionGroup(unit);
			if (not UnitName(unit)) then value = "faction"; end
			text = TipBuddy_gsub(text, '$fa', value, "fa");
			return text;
		end,
		},

	-- City Faction - Stormwind, Darkspear Trolls, etc. (NPCs only)
	["$cf"] = { func = function(text, unit)
			local value = TipBuddy.gtt_cityfac;
			if (not UnitName(unit)) then value = "city faction"; end
			text = TipBuddy_gsub(text, '$cf', value, "cf");
			return text;
		end,
		},

	-- Current Health (actual)
	["$hc"] = { func = function(text, unit)
			local health = TB_GetHealth_Text( unit, "current" );
			text = TipBuddy_gsub(text, '$hc', health, "hc");
			return text;
		end,
		},

	-- Max Health (actual)
	["$hm"] = { func = function(text, unit)
			local healthmax = TB_GetHealth_Text( unit, "max" );
			text = TipBuddy_gsub(text, '$hm', healthmax, "hm");
			return text;
		end,
		},

	-- Health as a percent
	["$hp"] = { func = function(text, unit)
			local health = TB_GetHealth_Text( unit, "percent" );
			text = TipBuddy_gsub(text, '$hp', health, "hp");
			return text;
		end,
		},

	-- Current Mana (actual)
	["$mc"] = { func = function(text, unit)
			local mana = UnitMana(unit);
			text = TipBuddy_gsub(text, '$mc', mana, "mc");
			return text;
		end,
		},

	-- Max Mana (actual)
	["$mm"] = { func = function(text, unit)
			local manamax = UnitManaMax(unit);
			if (not manamax) then
				manamax = 0;
			end
			text = TipBuddy_gsub(text, '$mm', manamax, "mm");
			return text;
		end,
		},

	-- Mana as a percent
	["$mp"] = { func = function(text, unit)
			local mana = UnitMana(unit);
			local manamax = UnitManaMax(unit);
			local percent = 0;
			if (manamax == 0) then
				percent = 0;
			else
				percent = math.floor(mana/manamax * 100);
			end
			text = TipBuddy_gsub(text, '$mp', percent, "mp");
			return text;
		end,
		},

	--[[ Death Status - DEAD, GHOST, or nothing
	["$ds"] = { func = function(text, unit)
			local value;
			if (UnitIsGhost(unit)) then
				value = TipBuddy_TEXT.Ghost;
			elseif (UnitIsDead(unit)) then
				value = TipBuddy_TEXT.Dead;
			elseif (not UnitName(unit)) then
				value = TipBuddy_TEXT.Dead;
			else
				value = "";
			end
			text = TipBuddy_gsub(text, '$ds', value);
			return text;
		end,
		},]]

	--[[In Combat - COMBAT or nothing
	["$ic"] = { func = function(text, unit)
			local value = "";
			if (UnitAffectingCombat(unit) or (not UnitName(unit))) then
				value = TipBuddy_TEXT.Combat;
			end
			text = TipBuddy_gsub(text, '$ic', value);
			return text;
		end,
		},]]

	-- NPC Classification - Elite, Boss, etc.
	["$ns"] = { func = function(text, unit)
			local value = UnitClassification(unit);
			if (value == "normal") then
				value = "";
			elseif (value == "elite" or (not UnitName(unit))) then
				value = TB_elite;
			elseif (value == "worldboss") then
				value = TB_worldboss;
			elseif (value == "rare") then
				value = TB_rare;
			elseif (value == "rareelite") then
				value = TB_rareelite;
			end
			text = TipBuddy_gsub(text, '$ns', value, "ns");
			return text;
		end,
		},

	-- NPC Type - Beast, Humanoid, Undead, etc.
	["$nt"] = { func = function(text, unit)
			local value = UnitCreatureType(unit);
			if (UnitIsPlayer(unit)) then value = nil; end
			if (not UnitName(unit)) then value = "beast"; end
			text = TipBuddy_gsub(text, '$nt', value, "nt");
			return text;
		end,
		},

	-- NPC Family - Bear, Crab, Cat, etc.
	["$nf"] = { func = function(text, unit)
			local value = UnitCreatureFamily(unit);
			if (not UnitName(unit)) then value = "cat"; end
			text = TipBuddy_gsub(text, '$nf', value, "nf");
			return text;
		end,
		},

	-- Tapped - TAPPED or nothing
	["$tp"] = { func = function(text, unit)
			local value;
			if (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
				value = TB_tapped;
			end
			text = TipBuddy_gsub(text, '$tp', value, "tp");
			return text;
		end,
		},

	-- Unit Reaction - Hostile, Neutral, Friendly
	["$re"] = { func = function(text, unit)
			local value = UnitReaction("player", unit);
			if (value) then
				if (value < 4) then
					value = FACTION_STANDING_LABEL2;
				elseif (value == 4) then
					value = FACTION_STANDING_LABEL4;
				else
					value = FACTION_STANDING_LABEL5;
				end
			end
			text = TipBuddy_gsub(text, '$re', value, "re");
			return text;
		end,
		},

	--PVP Rank
	["$pr"] = { func = function(text, unit)
			local value = GetPVPRankInfo(UnitPVPRank(unit), unit);
			text = TipBuddy_gsub(text, '$pr', value, "pr");
			return text;
		end,
		},

	--PVP Rank Number
	["$pn"] = { func = function(text, unit)
			local value = UnitPVPRank(unit);
			if (value > 0) then
				value = value - 4;
			else
				value = nil;
			end
			text = TipBuddy_gsub(text, '$pn', value, "pn");
			return text;
		end,
		},

	--PVP Flagged - PvP or PvP Free For All
	["$pv"] = { func = function(text, unit)
			local value;
			if (UnitIsPVPFreeForAll(unit)) then
				value = "FFA";
			elseif (UnitIsPVP(unit)) then
				value = PVP_ENABLED;
			end
			text = TipBuddy_gsub(text, '$pv', value, "pv");
			return text;
		end,
		},

	--Mana Label - Mana, Energy, Rage, Focus
	["$ml"] = { func = function(text, unit)
			local value = UnitPowerType(unit);
			if (value == 0) then
				value = MANA;
			elseif (value == 1) then
				value = RAGE;
			elseif (value == 2) then
				value = FOCUS;
			elseif (value == 3) then
				value = ENERGY;
			end
			text = TipBuddy_gsub(text, '$ml', value, "ml");
			return text;
		end,
		},

	--Unit Difficulty - Trivial, Minor, Suicide, etc.
	["$df"] = { func = function(text, unit)
			local _, value = TipBuddy_GetDifficultyColor(UnitLevel(unit));
			text = TipBuddy_gsub(text, '$df', value, "df");
			return text;
		end,
		},

	-- Unit Target's Target Name
	["$tn"] = { func = function(text, unit)
			local target = TipBuddy_Adv_TargetsTarget( unit );
			text = TipBuddy_gsub(text, '$tn', target, "tn");
			return text;
		end,
		},

	-- Civilian
	--[[["$cv"] = { func = function(text, unit)
		local value;
		if (UnitIsCivilian(unit)) then
			value = "Civilian";
		end
		text = TipBuddy_gsub(text, '$cv', value, "cv");
		return text;
		end,
		},]]

	-- Shorthand Elite Text
	["$cx"] = { func = function(text, unit)
			local value = UnitClassification(unit);
			if (value == "normal") then
				value = nil;
			elseif (value == "elite" or (not UnitName(unit))) then
				value = "+";
			elseif (value == "worldboss") then
				value = "++";
			elseif (value == "rare") then
				value = "(R)";
			elseif (value == "rareelite") then
				value = "(R)+";
			end
			text = TipBuddy_gsub(text, '$cx', value, "cx");
			return text;
		end,
		},

	---- COLORS ----
	-- Reaction Name
	["@Crn"] = { func = function(text, unit)
		local value = getglobal("tbcolor_nam_"..TipBuddy_GetUnitReaction( unit ));
		text = TipBuddy_gsub(text, '@Crn', value);
		return text;
		end,
		},

	-- Reaction Guild
	["@Crg"] = { func = function(text, unit)
		local value = getglobal("tbcolor_gld_"..TipBuddy_GetUnitReaction( unit ));
		text = TipBuddy_gsub(text, '@Crg', value);
		return text;
		end,
		},

	-- Difficulty
	["@Cdf"] = { func = function(text, unit)
		local value = TipBuddy_GetDifficultyColor(UnitLevel(unit));
		text = TipBuddy_gsub(text, '@Cdf', value);
		return text;
		end,
		},

	-- Class Color
	["@Ccl"] = { func = function(text, unit)
		if (UnitClass(unit) == TB_mage) then
			TipBuddy.gtt_classcolor = tbcolor_cls_mage;
		elseif (UnitClass(unit) == TB_warlock) then
			TipBuddy.gtt_classcolor = tbcolor_cls_warlock;
		elseif (UnitClass(unit) == TB_priest) then
			TipBuddy.gtt_classcolor = tbcolor_cls_priest;
		elseif (UnitClass(unit) == TB_druid) then
			TipBuddy.gtt_classcolor = tbcolor_cls_druid;
		elseif (UnitClass(unit) == TB_shaman) then
			TipBuddy.gtt_classcolor = tbcolor_cls_shaman;
		elseif (UnitClass(unit) == TB_paladin) then
			TipBuddy.gtt_classcolor = tbcolor_cls_paladin;
		elseif (UnitClass(unit) == TB_rogue) then
			TipBuddy.gtt_classcolor = tbcolor_cls_rogue;
		elseif (UnitClass(unit) == TB_hunter) then
			TipBuddy.gtt_classcolor = tbcolor_cls_hunter;
		elseif (UnitClass(unit) == TB_warrior) then
			TipBuddy.gtt_classcolor = tbcolor_cls_warrior;
		else
			TipBuddy.gtt_classcolor = tbcolor_cls_other;
		end
		local value = TipBuddy.gtt_classcolor;
		text = TipBuddy_gsub(text, '@Ccl', value);
		return text;
		end,
		},

	-- Target's Target Color (only color's if the unit has a target)
	["@Ctt"] = { func = function(text, unit)
		local _, value = TipBuddy_Adv_TargetsTarget( unit );
		text = TipBuddy_gsub(text, '@Ctt', value);
		return text;
		end,
		},


	-- Corpse Color
	-- Will only color text if unit is a corpse
	["@Ccp"] = { func = function(text, unit)
		local value;
		if (UnitHealth(unit) <= 0) then
			value = tbcolor_corpse;
			--TipBuddy.gtt_classlvlcolor = tbcolor_corpse;
			--TipBuddy.gtt_classcorpse = " "..CORPSE;
		else
			value = "";
		end
		text = TipBuddy_gsub(text, '@Ccp', value);
		return text;
		end,
		},

	-- Orange
	["@Cor"] = { func = function(text, unit)
		local value = TB_NML_TXT;
		text = TipBuddy_gsub(text, '@Cor', value);
		return text;
		end,
		},
	-- White
	["@Cwt"] = { func = function(text, unit)
		local value = TB_WHT_TXT;
		text = TipBuddy_gsub(text, '@Cwt', value);
		return text;
		end,
		},
	-- Grey
	["@Cgy"] = { func = function(text, unit)
		local value = TB_GRY_TXT;
		text = TipBuddy_gsub(text, '@Cgy', value);
		return text;
		end,
		},
	-- Red
	["@Crd"] = { func = function(text, unit)
		local value = TB_RED_TXT;
		text = TipBuddy_gsub(text, '@Crd', value);
		return text;
		end,
		},
	-- Green
	["@Cgn"] = { func = function(text, unit)
		local value = TB_GRN_TXT;
		text = TipBuddy_gsub(text, '@Cgn', value);
		return text;
		end,
		},
	-- Yellow
	["@Cyw"] = { func = function(text, unit)
		local value = TB_YLW_TXT;
		text = TipBuddy_gsub(text, '@Cyw', value);
		return text;
		end,
		},
	-- Blue
	["@Cbl"] = { func = function(text, unit)
		local value = TB_BLE_TXT;
		text = TipBuddy_gsub(text, '@Cbl', value);
		return text;
		end,
		},
	-- Pink
	["@Cpk"] = { func = function(text, unit)
		local value = TB_PNK_TXT;
		text = TipBuddy_gsub(text, '@Cpk', value);
		return text;
		end,
		}
};

function TipBuddy_gsub(text, variable, value, tag)
	if (not tag) then
		tag = "";	
	end
	if (value and value ~= "") then
		if (string.find(text, "<"..tag..">.-"..variable..".-<\/"..tag..">")) then
			--TB_AddMessage("found pattern: "..variable);
			text = string.gsub(text, "<"..tag..">(.-)"..variable.."(.-)<\/"..tag..">", "%1"..value.."%2");
		else
			--TB_AddMessage("didn't find pattern...: "..variable);
			text = string.gsub(text, variable, value);
		end
	elseif (string.find(text, "<"..tag..">.-"..variable..".-<\/"..tag..">")) then
		text = string.gsub(text, "<"..tag..">.-"..variable..".-</"..tag..">", "");
	else
		text = string.gsub(text, variable, "", 1);
	end
	--TB_AddMessage("start: "..text);
	return text;
end