--[[
This is the basic template for adding a variable:

["variable"] = { func = function(text, unit)
		code that creates the value that replaces your variable
		text = DUF_gsub(text, 'variable', value);
		return text;
	end,
	events = {"event", "event2", ...} },

variable - Can be anything you want and doesn't necessarily have to be preceded with a $.
func - This is the function called when the variable needs to be updated.
	text - This is the entire text of the TextBox and must be returned after it is modified.
	unit - This is the unit ID (party1, player, target, etc.) that the TextBox refers to.
	No other parameters will be passed to your function and those 2 will always be passed.
	text = DUF_gsub(text, 'variable', value) - This line is used to replace the variable with the value you generated in the preceding code.  It handles trimming leading spaces if value is nil or false.
events - List all the events here that will cause the variable to update.  You can enter as many as you want.  Variables are only updated when event's unit is the same as the TextBox's unit.  PARTY_MEMBERS_CHANGED and PLAYER_TARGET_CHANGED are registered automatically and appropriately for each textbox and need not be defined as events.
--]]

DUF_VARIABLE_FUNCTIONS = {
	-- New Line
	["$nl"] = { func = function(text, unit)
				text = string.gsub(text, '$nl', "\n");
				return text;
			end,
			events = {} },

	-- Raid Group
	["$rg"] = { func = function(text, unit)
				local value;
				for i=1, GetNumRaidMembers() do
					if (UnitIsUnit("raid"..i, unit)) then
						_, _, value = GetRaidRosterInfo(i);
						break;
					end
				end
				text = DUF_gsub(text, '$rg', value);
				return text;
			end,
			events = {"RAID_ROSTER_UPDATE"} },

	-- Honor Progress
	["$hn"] = { func = function(text, unit)
				local value = GetPVPRankProgress();
				value = math.floor(value * 100);
				text = string.gsub(text, '$hn', value);
				return text;
			end,
			events = {"PLAYER_PVP_KILLS_CHANGED", "PLAYER_PVP_RANK_CHANGED"} },

	-- Name
	["$nm"] = { func = function(text, unit)
				local unitname = UnitName(unit);
				if (not unitname) then unitname = unit; end
				text = DUF_gsub(text, '$nm', unitname);
				return text;
			end,
			events = {"UNIT_NAME_UPDATE"} },

	-- Level
	["$lv"] = { func = function(text, unit)
				local level = UnitLevel(unit);
				if (level == -1) then
					if (UnitClassification(unit) == "worldboss") then
						level = "61+";
					else
						level = ">"..(UnitLevel("player") + 10);
					end
				end
				text = DUF_gsub(text, '$lv', level);
				return text;
			end,
		events = {"UNIT_LEVEL"} },

	-- Next Level
	["$xn"] = { func = function(text, unit)
				local level = UnitLevel(unit) + 1;
				text = DUF_gsub(text, '$xn', level);
				return text;
			end,
		events = {"UNIT_LEVEL"} },	

	-- Player Class
	["$cl"] = { func = function(text, unit)
			local class = UnitClass(unit);
			if (class == "") then class = "class"; end
			if (UnitIsPlayer(unit)) then
				text = DUF_gsub(text, '$cl', class);
			else
				text = DUF_gsub(text, '$cl', "");
			end
			return text;
		end,
		events = {"UNIT_NAME_UPDATE"} },

	-- Mob Class
	["$cy"] = { func = function(text, unit)
			local class = UnitClass(unit);
			if (not class) then class = "class"; end
			if (not UnitIsPlayer(unit)) then
				text = DUF_gsub(text, '$cy', class);
			else
				text = DUF_gsub(text, '$cy', "");
			end
			return text;
		end,
		events = {} },

	-- Current Health
	["$hc"] = { func = function(text, unit)
			local health = DUF_Get_Health(unit);
			text = DUF_gsub(text, '$hc', health);
			return text;
		end,
		events = {"UNIT_HEALTH"} },

	-- Max Health
	["$hm"] = { func = function(text, unit)
			local healthmax = DUF_Get_MaxHealth(unit);
			text = DUF_gsub(text, '$hm', healthmax);
			return text;
		end,
		events = {"UNIT_MAXHEALTH"} },
	
	-- Damage Taken, i.e. lost health
	["$dt"] = { func = function(text, unit)
			local damage = DUF_Get_HealthDamage(unit);
			text = DUF_gsub(text, '$dt', damage);
			return text;
		end,
		events = {"UNIT_HEALTH", "UNIT_MAXHEALTH"} },

	-- Damage as a percent
	["$dp"] = { func = function(text, unit)
			local damage = UnitHealthMax(unit) - UnitHealth(unit);
			local healthmax = UnitHealthMax(unit);
			if (healthmax == 0) then
				damage = 0;
			else
				damage = math.floor(damage/healthmax * 100);
			end
			text = DUF_gsub(text, '$dp', damage);
			return text;
		end,
		events = {"UNIT_HEALTH", "UNIT_MAXHEALTH"} },

	-- Health as a percent
	["$hp"] = { func = function(text, unit)
			local percent = 0;
			local health = UnitHealth(unit);
			local healthmax = UnitHealthMax(unit);
			if (healthmax > 0) then
				percent = math.floor(health/healthmax * 100);
			else
				percent = 0;
			end
			text = DUF_gsub(text, '$hp', percent);
			return text;
		end,
		events = {"UNIT_HEALTH", "UNIT_MAXHEALTH"} },

	-- Current Mana
	["$mc"] = { func = function(text, unit)
			local mana = UnitMana(unit);
			text = DUF_gsub(text, '$mc', mana, 1);
			return text;
		end,
		events = {"UNIT_MANA", "UNIT_RAGE", "UNIT_ENERGY", "UNIT_FOCUS", "UNIT_DISPLAYPOWER"} },

	-- Max Mana
	["$mm"] = { func = function(text, unit)
			local manamax = UnitManaMax(unit);
			if (not manamax) then
				manamax = 0;
			end
			text = DUF_gsub(text, '$mm', manamax, 1);
			return text;
		end,
		events = {"UNIT_MAXMANA", "UNIT_MAXRAGE", "UNIT_MAXENERGY", "UNIT_MAXFOCUS", "UNIT_DISPLAYPOWER"} },

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
			text = DUF_gsub(text, '$mp', percent, 1);
			return text;
		end,
		events = {"UNIT_MAXMANA", "UNIT_MAXRAGE", "UNIT_MAXENERGY", "UNIT_MAXFOCUS", "UNIT_MANA", "UNIT_RAGE", "UNIT_ENERGY", "UNIT_FOCUS", "UNIT_DISPLAYPOWER"} },

	-- Mana Used
	["$mx"] = { func = function(text, unit)
			local mana = UnitMana(unit);
			local manamax = UnitManaMax(unit);
			local damage = manamax - mana;
			text = DUF_gsub(text, '$mx', damage, 1);
			return text;
		end,
		events = {"UNIT_MAXMANA", "UNIT_MAXRAGE", "UNIT_MAXENERGY", "UNIT_MAXFOCUS", "UNIT_MANA", "UNIT_RAGE", "UNIT_ENERGY", "UNIT_FOCUS", "UNIT_DISPLAYPOWER"} },

	-- Mana Used as a percent
	["$my"] = { func = function(text, unit)
			local mana = UnitMana(unit);
			local manamax = UnitManaMax(unit);
			local damage = manamax - mana;
			if (manamax == 0) then
				damage = 0;
			else
				damage = math.floor(damage/manamax * 100);
			end
			text = DUF_gsub(text, '$my', damage);
			return text;
		end,
		events = {"UNIT_MAXMANA", "UNIT_MAXRAGE", "UNIT_MAXENERGY", "UNIT_MAXFOCUS", "UNIT_MANA", "UNIT_RAGE", "UNIT_ENERGY", "UNIT_FOCUS", "UNIT_DISPLAYPOWER"} },

	-- Race
	["$rc"] = { func = function(text, unit)
			local race = UnitRace(unit);
			if (not UnitName(unit)) then race = "race"; end
			text = DUF_gsub(text, '$rc', race);
			return text;
		end,
		events = {"UNIT_NAME_UPDATE"} },

	-- Class Abbreviation
	["$ca"] = { func = function(text, unit)
			local value = DUF_CLASSABBREV[UnitClass(unit)];
			if (not UnitName(unit)) then value = "CA"; end
			text = DUF_gsub(text, '$ca', value);
			return text;
		end,
		events = {"UNIT_NAME_UPDATE"} },

	-- Race Abbreviation
	["$ra"] = { func = function(text, unit)
			local value = DUF_RACEABBREV[UnitRace(unit)];
			if (not UnitName(unit)) then value = "RA"; end
			text = DUF_gsub(text, '$ra', value);
			return text;
		end,
		events = {"UNIT_NAME_UPDATE"} },

	-- Death Status - DEAD, GHOST, or nothing
	["$ds"] = { func = function(text, unit)
			local value;
			if (UnitIsGhost(unit)) then
				value = DUF_TEXT.Ghost;
			elseif (UnitIsDead(unit)) then
				value = DUF_TEXT.Dead;
			elseif (not UnitName(unit)) then
				value = DUF_TEXT.Dead;
			else
				value = nil;
			end
			text = DUF_gsub(text, '$ds', value);
			return text;
		end,
		events = {"UNIT_HEALTH"} },

	-- Faction - Horde, Alliance, or nothing
	["$fa"] = { func = function(text, unit)
			local value = UnitFactionGroup(unit);
			if (not UnitName(unit)) then value = "faction"; end
			text = DUF_gsub(text, '$fa', value);
			return text;
		end,
		events = {"UNIT_FACTION"} },

	-- Keybinding
	["$kb"] = { func = function(text, unit)
			local value;
			if (unit == "player") then
				value = DL_Get_KeybindingText("TARGETSELF");
			elseif (unit == "pet") then
				value = DL_Get_KeybindingText("TARGETPET");
			elseif (unit == "party1") then
				value = DL_Get_KeybindingText("TARGETPARTYMEMBER1");
			elseif (unit == "party2") then
				value = DL_Get_KeybindingText("TARGETPARTYMEMBER2");
			elseif (unit == "party3") then
				value = DL_Get_KeybindingText("TARGETPARTYMEMBER3");
			elseif (unit == "party4") then
				value = DL_Get_KeybindingText("TARGETPARTYMEMBER4");
			elseif (unit == "partypet1") then
				value = DL_Get_KeybindingText("TARGETPARTYPET1");
			elseif (unit == "partypet2") then
				value = DL_Get_KeybindingText("TARGETPARTYPET2");
			elseif (unit == "partypet3") then
				value = DL_Get_KeybindingText("TARGETPARTYPET3");
			elseif (unit == "partypet4") then
				value = DL_Get_KeybindingText("TARGETPARTYPET4");
			end
			text = DUF_gsub(text, '$kb', value);
			return text;
		end,
		events = {"UPDATE_BINDINGS"} },

	-- Is Visible
	["$iv"] = { func = function(text, unit)
			local value;
			if (not UnitIsVisible(unit)) then
				value = DUF_TEXT.OutOfRange;
			end
			text = DUF_gsub(text, '$iv', value);
			return text;
		end,
		events = {} },

	-- In Combat - COMBAT or nothing
	["$ic"] = { func = function(text, unit)
			local value = "";
			if (UnitAffectingCombat(unit) or (not UnitName(unit))) then
				value = DUF_TEXT.Combat;
			end
			text = DUF_gsub(text, '$ic', value);
			return text;
		end,
		events = {} },

	-- Offline Status - OFFLINE or nothing
	["$of"] = { func = function(text, unit)
			local value;
			if (UnitIsConnected(unit)) then
				value = nil;
			else
				value = DUF_TEXT.Offline;
			end
			text = DUF_gsub(text, '$of', value);
			return text;
		end,
		events = {} },

	-- Creature Classification - Elite, Boss, etc.
	["$cc"] = { func = function(text, unit)
			local value = UnitClassification(unit);
			if (value == "normal") then
				value = nil;
			elseif (value == "elite" or (not UnitName(unit))) then
				value = DUF_TEXT.Elite;
			elseif (value == "worldboss") then
				value = DUF_TEXT.Boss;
			elseif (value == "rare") then
				value = DUF_TEXT.Rare;
			elseif (value == "rareelite") then
				value = DUF_TEXT.RareElite;
			end
			text = DUF_gsub(text, '$cc', value);
			return text;
		end,
		events = {"UNIT_CLASSIFICATION_CHANGED"} },

	-- Creature Type - Beast, Humanoid, Undead, etc.
	["$ct"] = { func = function(text, unit)
			local value = UnitCreatureType(unit);
			if (UnitIsPlayer(unit)) then value = nil; end
			if (not UnitName(unit)) then value = "beast"; end
			text = DUF_gsub(text, '$ct', value);
			return text;
		end,
		events = {"UNIT_CLASSIFICATION_CHANGED"} },

	-- Creature Family - Bear, Crab, Cat, etc.
	["$cf"] = { func = function(text, unit)
			local value = UnitCreatureFamily(unit);
			if (not UnitName(unit)) then value = "cat"; end
			text = DUF_gsub(text, '$cf', value);
			return text;
		end,
		events = {"UNIT_CLASSIFICATION_CHANGED"} },

	-- Health Regen per Second
	["$hr"] = { func = function(text, unit)
			text = DUF_gsub(text, '$hr', this.healthregen);
			return text;
		end,
		events = {"UNIT_HEALTH"} },

	-- Mana Regen per Second
	["$mr"] = { func = function(text, unit)
			text = DUF_gsub(text, '$mr', this.manaregen);
			return text;
		end,
		events = {"UNIT_MANA", "UNIT_RAGE", "UNIT_ENERGY", "UNIT_FOCUS"} },

	-- Health Regen per Tick
	["$ht"] = { func = function(text, unit)
			text = DUF_gsub(text, '$ht', this.healthregentick);
			return text;
		end,
		events = {"UNIT_HEALTH"} },

	-- Mana Regen per Tick
	["$mt"] = { func = function(text, unit)
			text = DUF_gsub(text, '$mt', this.manaregentick);
			return text;
		end,
		events = {"UNIT_MANA", "UNIT_RAGE", "UNIT_ENERGY", "UNIT_FOCUS"} },

	-- Recent Damage - shows all combat text: damage, blocks, evasions, etc.
	["$rd"] = { func = function(text, unit)
			text = DUF_gsub(text, '$rd', this.damagetext);
			return text;
		end,
		events = {"UNIT_COMBAT"} },

	-- Recent Heals
	["$rh"] = { func = function(text, unit)
			text = DUF_gsub(text, '$rh', this.healtext);
			return text;
		end,
		events = {"UNIT_COMBAT"} },

	-- Sex
	["$sx"] = { func = function(text, unit)
			local value = DUF_UnitSex(unit);
			text = DUF_gsub(text, '$sx', value);
			return text;
		end,
		events = {"UNIT_NAME_UPDATE"} },

	-- Sex Abbreviation
	["$sa"] = { func = function(text, unit)
			local value = DUF_SEXABBREV[DUF_UnitSex(unit)];
			text = DUF_gsub(text, '$sa', value);
			return text;
		end,
		events = {"UNIT_NAME_UPDATE"} },

	-- Tapped - TAPPED or nothing
	["$do"] = { func = function(text, unit)
			local value;
			if (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
				value = DUF_TEXT.Tapped
			end
			text = DUF_gsub(text, '$do', value);
			return text;
		end,
		events = {"UNIT_DYNAMIC_FLAGS", "PLAYER_FLAGS_CHANGED"} },

	-- Unit Reaction - Hostile, Neutral, Friendly
	["$re"] = { func = function(text, unit)
			local value = UnitReaction("player", unit);
			if (value) then
				if (value < 4) then
					value = DUF_TEXT.Hostile;
				elseif (value == 4) then
					value = DUF_TEXT.Neutral;
				else
					value = DUF_TEXT.Friendly;
				end
			end
			text = DUF_gsub(text, '$re', value);
			return text;
		end,
		events = {} },

	--PVP Rank
	["$pr"] = { func = function(text, unit)
			local value = GetPVPRankInfo(UnitPVPRank(unit), unit);
			text = DUF_gsub(text, '$pr', value);
			return text;
		end,
		events = {"UNIT_PVP_UPDATE"} },

	--PVP Rank Number
	["$pn"] = { func = function(text, unit)
			local value = UnitPVPRank(unit);
			if (value > 0) then
				value = value - 4;
			else
				value = nil;
			end
			text = DUF_gsub(text, '$pn', value);
			return text;
		end,
		events = {"UNIT_PVP_UPDATE"} },

	--PVP Tagged - PvP or PvP Free For All
	["$pt"] = { func = function(text, unit)
			local value;
			if (UnitIsPVPFreeForAll(unit)) then
				value = DUF_TEXT.PVPFree;
			elseif (UnitIsPVP(unit)) then
				value = DUF_TEXT.PVP;
			end
			text = DUF_gsub(text, '$pt', value);
			return text;
		end,
		events = {"UNIT_PVP_UPDATE"} },

	--Combo Points as a number
	["$cp"] = { func = function(text, unit)
			local value = GetComboPoints();
			if (value == 0) then
				value = "";
			end
			text = DUF_gsub(text, '$cp', value);
			return text;
		end,
		events = {"PLAYER_COMBO_POINTS"} },

	--Mana Label - Mana, Energy, Rage, Focus
	["$ml"] = { func = function(text, unit)
			local value = UnitPowerType(unit);
			if (value == 0) then
				value = DUF_TEXT.Mana;
			elseif (value == 1) then
				value = DUF_TEXT.Rage;
			elseif (value == 2) then
				value = DUF_TEXT.Focus;
			elseif (value == 3) then
				value = DUF_TEXT.Energy;
			end
			text = DUF_gsub(text, '$ml', value);
			return text;
		end,
		events = {"UNIT_DISPLAYPOWER"} },

	--Current XP
	["$xc"] = { func = function(text, unit)
			local currentxp = UnitXP(unit);
			if (not currentxp) then
				currentxp = 0;
			end
			text = DUF_gsub(text, '$xc', currentxp);
			return text;
		end,
		events = {"PLAYER_XP_UPDATE", "UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP", "PLAYER_UPDATE_RESTING"} },

	--Total XP Needed to Level
	["$xl"] = { func = function(text, unit)
			local maxxp = UnitXPMax(unit);
			if (not maxxp) then
				maxxp = 0;
			end
			text = DUF_gsub(text, '$xl', maxxp);
			return text;
		end,
		events = {"PLAYER_XP_UPDATE", "UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP", "PLAYER_UPDATE_RESTING"} },

	--Net XP Needed to Level
	["$xd"] = { func = function(text, unit)
			local currentxp = UnitXP(unit);
			if (not currentxp) then
				currentxp = 0;
			end
			local maxxp = UnitXPMax(unit);
			if (not maxxp) then
				maxxp = 0;
			end
			local value = maxxp - currentxp;
			text = DUF_gsub(text, '$xd', value);
			return text;
		end,
		events = {"PLAYER_XP_UPDATE", "UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP", "PLAYER_UPDATE_RESTING"} },

	--Percent XP Gained This Level
	["$xy"] = { func = function(text, unit)
			local currentxp = UnitXP(unit);
			if (not currentxp) then
				currentxp = 0;
			end
			local maxxp = UnitXPMax(unit);
			if (not maxxp) then
				maxxp = 0;
			end
			local value;
			if (maxxp == 0) then
				value = 0;
			else
				value = math.floor(currentxp / maxxp * 100);
			end
			text = DUF_gsub(text, '$xy', value);
			return text;
		end,
		events = {"PLAYER_XP_UPDATE", "UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP", "PLAYER_UPDATE_RESTING"} },

	--Percent XP Until Level
	["$xx"] = { func = function(text, unit)
			local currentxp = UnitXP(unit);
			if (not currentxp) then
				currentxp = 0;
			end
			local maxxp = UnitXPMax(unit);
			if (not maxxp) then
				maxxp = 0;
			end
			local value;
			if (maxxp == 0) then
				value = 0;
			else
				value = math.floor(currentxp / maxxp * 100);
			end
			value = 100 - value;
			text = DUF_gsub(text, '$xx', value);
			return text;
		end,
		events = {"PLAYER_XP_UPDATE", "UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP", "PLAYER_UPDATE_RESTING"} },

	--Rested XP
	["$xr"] = { func = function(text, unit)
			local value = GetXPExhaustion();
			if (value) then
				value = math.floor(value / 2);
			else
				value = 0;
			end
			text = DUF_gsub(text, '$xr', value);
			return text;
		end,
		events = {"PLAYER_XP_UPDATE", "UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP", "PLAYER_UPDATE_RESTING"} },
	
	 --Rested XP Percentage courtesy of Dsanai
	["$xb"] = { func = function(text, unit)
			local restXP = GetXPExhaustion();
			local nextlevelXP = UnitXPMax("player");
			local PercentRest = 0;
			if (restXP) then
				PercentRest = DL_round(restXP / nextlevelXP * 100, 0);
			end
			text = DUF_gsub(text, '$xb', PercentRest);
			return text;
		end,
		events = {"PLAYER_XP_UPDATE", "UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP", "PLAYER_UPDATE_RESTING"} },

	--Creature Difficulty - Trivial, Minor, Suicide, etc.
	["$cd"] = { func = function(text, unit)
			local diff = UnitLevel(unit) - UnitLevel("player");
			local difficulty;
			if (UnitLevel(unit) == -1) then
				difficulty = 6;
			elseif (diff < -GetQuestGreenRange()) then
				difficulty = 1;
			elseif (diff < -2) then
				difficulty = 2;
			elseif (diff < 3) then
				difficulty = 3;
			elseif (diff < 5) then
				difficulty = 4;
			elseif (diff < 11) then
				difficulty = 5;
			else
				difficulty = 6;
			end
			text = DUF_gsub(text, '$cd', DUF_TEXT["LevelDifference"..difficulty]);
			return text;
		end,
		events = {"UNIT_LEVEL"} },

	--Guild
	["$gu"] = { func = function(text, unit)
			local value = GetGuildInfo(unit);
			text = DUF_gsub(text, '$gu', value);
			return text;
		end,
		events = {"UNIT_NAME_UPDATE"} },

	-- Unit Target's Name
	["$tn"] = { func = function(text, unit)
			local value = this.targetname;
			if (not value) then
				value = DUF_TEXT.NoTarget;
			elseif (UnitIsUnit(unit.."target", "player")) then
				value = DUF_TEXT.You;
			elseif (UnitIsUnit(unit.."target", "target")) then
				value = DUF_TEXT.YourTarget;
			end
			text = DUF_gsub(text, '$tn', value);
			return text;
		end,
		events = {} },

	-- Unit Target's Health
	["$th"] = { func = function(text, unit)
			local value = this.targethealth;
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$th', value);
			return text;
		end,
		events = {} },

	-- Unit Target's Max Health
	["$tx"] = { func = function(text, unit)
			local value = this.targethealthmax;
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$tx', value);
			return text;
		end,
		events = {} },

	-- Unit Target's Mana
	["$tm"] = { func = function(text, unit)
			local value = this.targetmana;
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$tm', value);
			return text;
		end,
		events = {} },

	-- Unit's Target's Max Mana
	["$ty"] = { func = function(text, unit)
			local value = this.targetmanamax;
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$ty', value);
			return text;
		end,
		events = {} },

	-- Unit's Target's Health Percent
	["$ta"] = { func = function(text, unit)
			local value;
			if (this.targethealth and this.targethealthmax) then
				if (this.targethealthmax == 0) then
					value = 0;
				else
					value = math.ceil(this.targethealth / this.targethealthmax * 100);
				end
			end
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$ta', value);
			return text;
		end,
		events = {} },

	-- Unit's Target's Mana Percent
	["$tb"] = { func = function(text, unit)
			local value;
			if (this.targetmana and this.targetmanamax) then
				if (this.targetmanamax == 0) then
					value = 0;
				else
					value = math.ceil(this.targetmana / this.targetmanamax * 100);
				end
			end
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$tb', value);
			return text;
		end,
		events = {} },

	-- Unit's Target's Level
	["$tl"] = { func = function(text, unit)
			local value = this.targetlevel;
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$tl', value);
			return text;
		end,
		events = {} },

	-- Unit's Target's Type
	["$tt"] = { func = function(text, unit)
			local value = this.targettype;
			if (not this.targetname) then
				value = nil;
			end
			text = DUF_gsub(text, '$tt', value);
			return text;
		end,
		events = {} },

	-- Color Code
	["$co"] = { func = function(text, unit)
			text = DUF_gsub(text, '$co', '|c');
			return text;
		end,
		events = {} },

	-- Pet Current XP
	["$px"] = { func = function(text, unit)
			local value = GetPetExperience();
			text = DUF_gsub(text, '$px', value);
			return text;
		end,
		events = {"UNIT_PET_EXPERIENCE"} },

	-- Pet XP Needed to Level
	["$py"] = { func = function(text, unit)
			local _,value = GetPetExperience();
			text = DUF_gsub(text, '$py', value);
			return text;
		end,
		events = {"UNIT_PET_EXPERIENCE"} },

	-- Pet XP Percent Complete
	["$pc"] = { func = function(text, unit)
			local min,max = GetPetExperience();
			local value = 0;
			if (max and min and max > 0) then
				value = DL_round(min / max * 100, 0);
			end
			text = DUF_gsub(text, '$pc', value);
			return text;
		end,
		events = {"UNIT_PET_EXPERIENCE"} },

	-- Pet XP Percent Needed
		["$pp"] = { func = function(text, unit)
			local min,max = GetPetExperience();
			local value = 0;
			if (max and min and max > 0) then
				value = DL_round(min / max * 100, 0);
				value = 100 - value;
			end
			text = DUF_gsub(text, '$pp', value);
			return text;
		end,
		events = {"UNIT_PET_EXPERIENCE"} },

	-- Pet XP To Go
		["$pg"] = { func = function(text, unit)
			local min,max = GetPetExperience();
			local value = 0;
			if (max and min and max > 0) then
				value = max - min;
			end
			text = DUF_gsub(text, '$pg', value);
			return text;
		end,
		events = {"UNIT_PET_EXPERIENCE"} },

	-- Pet Happiness
	["$ph"] = { func = function(text, unit)
			local value = GetPetHappiness();
			text = DUF_gsub(text, '$ph', value);
			return text;
		end,
		events = {"UNIT_HAPPINESS"} },

	-- NPC
	["$np"] = { func = function(text, unit)
		local value;
		if (not UnitIsPlayer(unit)) then
			value = "NPC";
		end
		text = DUF_gsub(text, '$np', value);
		return text;
		end,
		events = {} },

	-- Civilian
	["$cv"] = { func = function(text, unit)
		local value;
		if (UnitIsCivilian(unit)) then
			value = "Civilian";
		end
		text = DUF_gsub(text, '$cv', value);
		return text;
		end,
		events = {} }, 

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
			text = DUF_gsub(text, '$cx', value);
			return text;
		end,
		events = {"UNIT_CLASSIFICATION_CHANGED"} },

	-- Reaction Color Context
	["$cr"] = { func = function(text, unit)
			local value;
			local r, g, b = DUF_Get_ReactionColor(unit);
			if (r and g and b) then
				value = "|cFF"..string.format("%02X%02X%02X", r * 255.0, g * 255.0, b * 255.0);
			end
			text = DUF_gsub(text, '$cr', value);
			return text;
		end,
		events = {} },

	-- Class Color Context
	["$cw"] = { func = function(text, unit)
			local value;
			local r, g, b = DUF_Get_ClassColor(unit);
			if (r and g and b) then
				value = "|cFF"..string.format("%02X%02X%02X", r * 255.0, g * 255.0, b * 255.0);
			end
			text = DUF_gsub(text, '$cw', value);
			return text;
		end,
		events = {} },

	-- Mana Color Context
	["$cm"] = { func = function(text, unit)
			local value;
			local r, g, b = DUF_Get_ManaColor(unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].TextBox[this:GetID()].textcolor);
			if (r and g and b) then
				value = "|cFF"..string.format("%02X%02X%02X", r * 255.0, g * 255.0, b * 255.0);
			end
			text = DUF_gsub(text, '$cm', value);
			return text;
		end,
		events = {} },

	-- Health Color Context
	["$ch"] = { func = function(text, unit)
			local value;
			local r, g, b = DUF_Get_HealthColor(unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].TextBox[this:GetID()].textcolor);
			if (r and g and b) then
				value = "|cFF"..string.format("%02X%02X%02X", r * 255.0, g * 255.0, b * 255.0);
			end
			text = DUF_gsub(text, '$ch', value);
			return text;
		end,
		events = {} },

	-- Difficulty Color Context
	["$cq"] = { func = function(text, unit)
			local value;
			local r, g, b = DUF_Get_DifficultyColor(unit);
			if (r and g and b) then
				value = "|cFF"..string.format("%02X%02X%02X", r * 255.0, g * 255.0, b * 255.0);
			end
			text = DUF_gsub(text, '$cq', value);
			return text;
		end,
		events = {} },

	-- Powertype Color
	["$cz"] = { func = function(text, unit)
			local color, value;
			local unit = this:GetParent().unit;
			local pt = UnitPowerType(unit);
			if (pt == 0) then
				color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].StatusBar[2].manacolor;
			elseif (pt == 1) then
				color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].StatusBar[2].ragecolor;
			elseif (pt == 2) then
				color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].StatusBar[2].focuscolor;
			elseif (pt == 3) then
				color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].StatusBar[2].energycolor;
			end
			if (color.r and color.g and color.b) then
				value = "|cFF"..string.format("%02X%02X%02X", color.r * 255.0, color.g * 255.0, color.b * 255.0);
			end
			text = DUF_gsub(text, '$cz', value);
			return text;
		end,
		events = {"UNIT_DISPLAYPOWER"} },
	
	-- Watched Faction
	["$wf"] = { func = function(text, unit)
			local name = GetWatchedFactionInfo();
			if (not name) then name = "" end
			text = string.gsub(text, '$wf', name);
			return text;
		end,
		events = {"UPDATE_FACTION"} },
	
	-- Watched Faction Max
	["$wm"] = { func = function(text, unit)
			local _, _, min, max = GetWatchedFactionInfo();
			text = string.gsub(text, '$wm', max - min);
			return text;
		end,
		events = {"UPDATE_FACTION", "PLAYER_LEVEL_UP"} },
	
	-- Watched Faction Current
	["$wc"] = { func = function(text, unit)
			local _, _, min, _, value = GetWatchedFactionInfo();
			text = string.gsub(text, '$wc', value - min);
			return text;
		end,
		events = {"UPDATE_FACTION", "PLAYER_LEVEL_UP"} },
	
	-- Watched Faction Percent
	["$wp"] = { func = function(text, unit)
			local _, _, min, max, value = GetWatchedFactionInfo();
			text = string.gsub(text, '$wp', DL_round((value-min)/(max - min)*100, 0));
			return text;
		end,
		events = {"UPDATE_FACTION", "PLAYER_LEVEL_UP"} },

	-- Watched Faction Reaction
	["$wr"] = { func = function(text, unit)
			local _, reaction = GetWatchedFactionInfo();
			reaction = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
			if (not reaction) then reaction = "" end
			text = string.gsub(text, '$wr', reaction);
			return text;
		end,
		events = {"UPDATE_FACTION", "PLAYER_LEVEL_UP"} },
};

function DUF_UnitSex(unit)
	value = UnitSex(unit);
	if (value == 2) then
		value = DUF_TEXT.Male;
	elseif (value == 3) then
		value = DUF_TEXT.Female;
	else
		value = DUF_TEXT.Neuter;
	end
	return value;
end

function DUF_gsub(text, variable, value)
	if (value) then
		text = string.gsub(text, variable, value);
	elseif (string.find(text, " "..variable)) then
		text = string.gsub(text, " "..variable, "");
	else
		text = string.gsub(text, variable, "");
	end
	return text;
end