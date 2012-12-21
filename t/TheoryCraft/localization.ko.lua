if (GetLocale() == "koKR") then

TheoryCraft_Locale = {
	ID_Beast	= "Beast",
	ID_Humanoid	= "Humanoid",
	ID_Giant	= "Giant",
	ID_Dragonkin	= "Dragonkin",
	ID_Intellect	= "Intellect",
	ID_Spirit	= "Spirit",
	ID_Stamina	= "Stamina",
	ID_Equip	= "Equip: ",
	ID_Set		= "Set: ",
	to		= " to ",
	ID_Health	= "Health ++%d+", -- Health enchant on chest
	ID_Health2	= "HP ++%d+", 	  -- Health libram
	Attack		= "Attack",
	SecCast		= " sec cast",
	Mana		= " Mana",
	ManaBegin	= "",
	ManaEnd		= " Mana",
	Cooldown	= " sec cooldown",
	Set		= "(%d+/%d+)",
	LoadText	= "TheoryCraft "..TheoryCraft_Version.." by Aelian. Type /tc for commands",
	MinMax  = {
		MultiShot = "for an additional %d+ damage.",
		AimedShot = "increases ranged damage by %d+.",
		Ghostly = "deals %d+%% weapon damage",
		Backstab = "causing %d+%% weapon damage plus %d+",
		Claw = "causing %d+ additional damage",
		Claw2 = "causing %d+ to %d+ additional damage",
		Mortal = "weapon damage plus %d+",
		Sinister = "%d+ damage in addition to your normal weapon damage.",
		andanother = "and another %d+",
		anadditional = "an additional %d+",
		oversecs = "over %d+ sec",
		flameshock = "and %d+ Fire damage",
		prayerofhealing = "%d+ yards for %d+",
		prayerofhealing2 = "%d+ yards for ",
		deathcoil = "%d+ Shadow",
		hellfire = "%d+ Fire damage to himself and %d+",
		newhellfire = " Fire damage to himself and ",
		insectswarm = "%d+ Nature",
		unbuffed = "Unbuffed: ",
		withthisseal = "With this seal: ",
		dps = " dps.", --for paladin seals
		autoshot = "Shoots the target for ",
		attack = "Hits the target for ",
		offhandattack = "Off hand hits the target for ",
		aimedshotname = "Aimed Shot",
		multishotname = "Multi-Shot",
	-- MultiShot "for an additional %d+ damage" becomes
	-- lfor (mindamage) to (maxdamage) damage
		lfor = "for ",
		damage = " damage",
	-- Aimed Shot becomes hits for (mindamage) to (maxdamage) damage
		hitsfor = "hits for ",
	-- backstab becomes deals (mindamage) to (maxdamage) damage
		deals = "deals ",
	-- would probably never happen - but it says dealing (mindamage) damage, in the case mindamage = maxdamage
		dealing = "dealing ",
	-- ambush becomes causing (mindamage) to (maxdamage) damage
		causing = "causing ",
		shred = "causing %d+%% damage plus %d+",
	-- the part of the description that contains the +damage, eg from shred above plus %d+
		plus = "plus %d+",
		whirlwind = "weapon damage to ",
		damageto = " damage to ",
		crusader = "granting %d+ attack power",
	},
	Tooltip = { 
		seconds = " seconds",
		Titles = {
			DamageStats = "Damage Statistics:",
			HealStats = "Healing Statistics:",
			Multipliers = "Multipliers:",
			Resists = "Resists:",
			Comparisons = "Comparisons:",
			Efficiency = "Efficiency:",
			Special = "Combined:",
		},
		TimerLocal = "Init Locals: ", 
		TimerReset = "Resetting Globals: ",
		TimerGear = "Gear Time: ",
		TimerBuffs = "Buff Time: ",
		TimerDebuffs = "Debuff Time: ",
		TimerTalents = "Talent Time: ",
		TimerCalc = "Calculating Time: ",
		TimerTook = "Took: ",
		TimerGen = " seconds to generate",
		TimerLinesParsed = " equip lines parsed",
		TimerCompsMade = " comparisons made",
		Hits = "Hits: ",
		Heals = "Heals: ",
		Crits = "Crits: ",
		Crit = "Crit: ",
		WithIgnite = "With Ignite: ",
		to = " to ",
		AverageHit = "Average Hit: ",
		AverageHeal = "Average Heal: ",
		TicksFor = "Ticks For: ",
		NextHit = "1% chance to hit: +",
		NextCrit = "1% chance to crit: +",
		NextAgi = "10 more agility: +",
		NextPen = "10 penetration: Up to +",
		AP = " AP",
		dps = " dps ", -- used on hunter tooltip, it says '1% chance to hit: +3.62 dps'
		damage = " damage ",
		healing = " healing ",
		Multipliers = {
			Damage = "+Damage",
			Heal = "+Healing",
			Base = "Base ",  -- For multipliers, will appear as Base" +"Damage2
			Coef = " Coefficient: ",
			Eff = " Efficiency: ",
			Final = "Final ",
		},
		Penetration = "Up to: ",
		HPS = "HPS: ",
		DPS = "DPS: ",
		HPSdam = "HPS from +heal: ",
		DPSdam = "DPS from +dam: ",
		HPM = "HPM: ",
		DPM = "DPM: ",
		RegenNormal = "10 seconds in normal regen: +",
		RegenIC = "10 seconds in five rule: +",
		TotalDamage = "Total Damage: ",
		TotalDamageEvoc = "Total Damage w/ evoc+gem: ",
		TotalHealing = "Total Healing: ",
		DPSafterresists = "DPS After Resists: ",
		Colon = ": ",
		ManaCost = "Mana Cost: ",
		ManaCostDamage = " (damage)",
		ManaCostHealing = " (healing)",
		damage = " damage",
		healing = " healing",
	},
	SpellTranslator = {
		{ id="Frostbolt", translated="Frostbolt" },
		{ id="Frost Nova", translated="Frost Nova" },
		{ id="Cone of Cold", translated="Cone of Cold" },
		{ id="Blizzard", translated="Blizzard" },
		{ id="Arcane Explosion", translated="Arcane Explosion" },
		{ id="Arcane Missiles", translated="Arcane Missiles" },
		{ id="Fire Blast", translated="Fire Blast" },
		{ id="Fireball", translated="Fireball" },
		{ id="Pyroblast", translated="Pyroblast" },
		{ id="Scorch", translated="Scorch" },
		{ id="Blast Wave", translated="Blast Wave" },
		{ id="Flamestrike", translated="Flamestrike" },
		{ id="Shadow Bolt", translated="Shadow Bolt" },
		{ id="Soul Fire", translated="Soul Fire" },
		{ id="Searing Pain", translated="Searing Pain" },
		{ id="Immolate", translated="Immolate" },
		{ id="Conflagrate", translated="Conflagrate" },
		{ id="Rain of Fire", translated="Rain of Fire" },
		{ id="Hellfire", translated="Hellfire" },
		{ id="Corruption", translated="Corruption" },
		{ id="Curse of Agony", translated="Curse of Agony" },
		{ id="Curse of Doom", translated="Curse of Doom" },
		{ id="Drain Soul", translated="Drain Soul" },
		{ id="Siphon Life", translated="Siphon Life" },
		{ id="Drain Life", translated="Drain Life" },
		{ id="Death Coil", translated="Death Coil" },
		{ id="Shadowburn", translated="Shadowburn" },
		{ id="Prayer of Healing", translated="Prayer of Healing" },
		{ id="Shadow Word: Pain", translated="Shadow Word: Pain" },
		{ id="Mind Flay", translated="Mind Flay" },
		{ id="Mind Blast", translated="Mind Blast" },
		{ id="Smite", translated="Smite" },
		{ id="Holy Fire", translated="Holy Fire" },
		{ id="Holy Nova", translated="Holy Nova" },
		{ id="Power Word: Shield", translated="Power Word: Shield" },
		{ id="Desperate Prayer", translated="Desperate Prayer" },
		{ id="Lesser Heal", translated="Lesser Heal" },
		{ id="Heal", translated="Heal" },
		{ id="Flash Heal", translated="Flash Heal" },
		{ id="Greater Heal", translated="Greater Heal" },
		{ id="Devouring Plague", translated="Devouring Plague" },
		{ id="Renew", translated="Renew" },
		{ id="Healing Touch", translated="Healing Touch" },
		{ id="Tranquility", translated="Tranquility" },
		{ id="Rejuvenation", translated="Rejuvenation" },
		{ id="Regrowth", translated="Regrowth" },
		{ id="Starfire", translated="Starfire" },
		{ id="Wrath", translated="Wrath" },
		{ id="Insect Swarm", translated="Insect Swarm" },
		{ id="Entangling Roots", translated="Entangling Roots" },
		{ id="Moonfire", translated="Moonfire" },
		{ id="Hurricane", translated="Hurricane" },
		{ id="Ravage", translated="Ravage" },
		{ id="Shred", translated="Shred" },
		{ id="Claw", translated="Claw" },
		{ id="Mortal Strike", translated="Mortal Strike" },
		{ id="Overpower", translated="Overpower" },
		{ id="Whirlwind", translated="Whirlwind" },
		{ id="Sinister Strike", translated="Sinister Strike" },
		{ id="Backstab", translated="Backstab" },
		{ id="Ghostly Strike", translated="Ghostly Strike" },
		{ id="Ambush", translated="Ambush" },
		{ id="Flash of Light", translated="Flash of Light" },
		{ id="Holy Light", translated="Holy Light" },
		{ id="Exorcism", translated="Exorcism" },
		{ id="Holy Wrath", translated="Holy Wrath" },
		{ id="Consecration", translated="Consecration" },
		{ id="Hammer of Wrath", translated="Hammer of Wrath" },
		{ id="Seal of the Crusader", translated="Seal of the Crusader" },
		{ id="Seal of Command", translated="Seal of Command" },
		{ id="Seal of Righteousness", translated="Seal of Righteousness" },
		{ id="Holy Shock", translated="Holy Shock" },
		{ id="Chain Lightning", translated="Chain Lightning" },
		{ id="Lightning Bolt", translated="Lightning Bolt" },
		{ id="Lesser Healing Wave", translated="Lesser Healing Wave" },
		{ id="Healing Wave", translated="Healing Wave" },
		{ id="Chain Heal", translated="Chain Heal" },
		{ id="Earth Shock", translated="Earth Shock" },
		{ id="Flame Shock", translated="Flame Shock" },
		{ id="Frost Shock", translated="Frost Shock" },
		{ id="Arcane Shot", translated="Arcane Shot" },
		{ id="Serpent Sting", translated="Serpent Sting" },
		{ id="Multi-Shot", translated="Multi-Shot" },
		{ id="Aimed Shot", translated="Aimed Shot" },
		{ id="Auto Shot", translated="Auto Shot" },
		{ id="Shoot", translated="Shoot" },
		{ id="Starshards", translated="Starshards" },
	}
}
	
TheoryCraft_CheckButtons = {
	["titles"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Titles", description = "Seperates your tooltips in to Damage/Healing Statistics, Multipliers, Resists, Comparison and Efficiency Subsections." },
	["embed"] = 	{ short = "Embed", description = "Modifies the base description of your spell tooltips to include effects of +damage.", descriptionmelee = "Modifies the base description of your ability to replace terms like 'weapon damage plus 160' with actual damage done." },
	["crit"] = 	{ short = "Crit", description = "Adds your crit rate to your spell tooltips. Includes talents, gear and base crit rate (int/59.5).", descriptionmelee = "Adds your crit damage and crit chance to your ability tooltips." },
	["critdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Crit Damage", description = "If 'Crit' is enabled, shows the damage range of your critical strikes" },
	["rollignites"]={ hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN" }, short = "Rolling Ignites", description = "DPS, Average Damage and Maxoom figures will factor in rolling ignites for fire spells. That is, ignite proccing when ignite is already on the target, resetting the timer and adding to the damage." },
	["sepignite"] = { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN" }, short = "Seperate Ignite", description = "If 'Critdam' is enabled, seperates the ignite component from your crit damage (mage only)" },
	["healanddamage"] = 	{ hide = {"ROGUE", "WARRIOR", "MAGE", "SHAMAN", "HUNTER", "DRUID"}, short = "Show Heal Component", description = "If enabled spells that do damage and healing will show both components seperately, otherwise only the damage component will be shown." },
	["dps"] = 	{ short = "DPS", description = "For simple cast time spells and chanelled spells, dps is calculated as damage done per second cast time. For DoTs, it's damage per second over the duration of the DoT. For spells that are a combination of both, two values are given. For instant casts, it's cast time is taken as 1.5 seconds as that is the length of the global cooldown. Critical strikes are included.", descriptionmelee = "How much this ability increases your dps by, if you use it each time the timer is up." },
	["combinedot"]= { hide = {"ROGUE", "WARRIOR"}, short = "Combine DoT", description = "If enabled, spells that have a direct component and an over time component will have the DoT DPS expressed as (DPS+DoT)/Casttime rather then simply DoT/Duration." },
	["dotoverct"] = { hide = {"ROGUE", "WARRIOR"}, short = "DoT over CT", description = "DoTs will have their DPS as Total Damage / Cast time, rather then Total Damage / DoT Duration" },
	["hps"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "HPS", description = "For simple cast time spells and chanelled spells, hps is calculated as healing done per second cast time. For HoTs, it's healing per second over the duration of the HoT. For spells that are a combination of both, two values are given. For instant casts, it's cast time is taken as 1.5 seconds as that is the length of the global cooldown. Critical strikes are included." },
	["dpsdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "DPS from +dam", description = "How much of your DPS/HPS figure is from your +damage gear. Includes crits." },
	["averagedam"] ={short = "Average Hit", description = "What the spell hits for on average, including critical strikes.", descriptionmelee = "Adds your average damage to your ability tooltips. This figure includes critical strikes." },
	["procs"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Include Procs", description = "All Proc based effects (Wrath of Cenarius, Darkmoon, Imp Aspect of the Hawk) effects are averaged instead of only being applied while the buff is active." },
	["plusdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Damage", description = "+Damage for that spell, before being multiplied by the +dam coefficient" },
	["damcoef"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Damage Coefficient", description = "+Damage coefficient for that spell" },
	["dameff"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Damage Efficiency", description = "The +damage system is based on 3.5 +damage = +1dps, before crits. If the spell gets this, then the efficiency will be 100%." },
	["damfinal"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Final +Damage", description = "+Damage added to the spell after the +dam coefficient." },
	["resists"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Resists", description = "Adds a resists category to the tooltip. This includes the resist rate of your *target*, and your dps after resists are accounted for. If you have it, it'll also tell you how much otherwise resisted dps your penetration gear can counter." },
	["nextagi"] = 	{ hide = {"MAGE", "WARLOCK", "PRIEST", "PALADIN", "SHAMAN" }, short = "Next 10 agility", description = "", descriptionmelee = "Shows how much 10 agility will add to your average damage (including crits), and how much attack power would be needed to achieve the same increase." },
	["nextcrit"] = 	{ short = "Next 1% to Crit", description = "Shows how much another 1% chance to crit will add to your *average damage*, and how much +damage gear would be needed to get the same result.", descriptionmelee = "Shows how much +1% to crit will add to your average damage, and how much attack power would be needed to achieve the same increase." },
	["nexthit"] = 	{ short = "Next 1% to Hit", description = "Shows how much another 1% chance to hit will add to your *average damage*, and how much +damage gear would be needed to get the same result. Resist rate is determined by your target.", descriptionmelee = "Shows how much +1% to hit will add to your average damage, and how much attack power would be needed to achieve the same increase." },
	["nextpen"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Next 10 Penetration", description = "Shows how much 10 penetration would add to your damage, on average, along with how much +damage gear you would need to get the same amount. It assumes that your target has 10 more resistance score to be penetrated." },
	["mana"] =	{ hide = {"ROGUE", "WARRIOR"}, short = "True Mana Cost", description = "Adds the true mana cost of your spell to the tooltip. If a spell costs 30 mana, and you regenerate 40 mana whilst casting it then this will be negative. It includes things like mana regen whilst casting, shaman earthfury bonus, paladin's illumination talent, etc. All internal calculations go off this value." },
	["dpm"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "DPM", description = "Shows how much damage the spell does per mana point spent, at the end of the cast of the spell.  Eg it goes off the true mana cost of the spell." },
	["showresistdpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "Factor Resists", description = "If checked, resists are accounted for in DPM, reducing the value." },
	["dontcritdpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "Dont include crits", description = "If checked crits won't be included in the DPM value." },
	["hpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "HPM", description = "Shows how much healing the spell does per mana point spent, at the end of the cast of the spell.  Eg it goes off the true mana cost of the spell." },
	["dontcrithpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "Dont include crits", description = "If checked crits won't be included in the HPM value." },
	["showregendam"] = { hide = {"ROGUE", "WARRIOR"}, short = "Regen Damage", description = "Adds values for how much extra damage you could do given 10 seconds of natural regen (outside of 5 second rule), and how much you could do from 10 seconds of in 5 second rule regen. Useful for comparing spirit to mana regen gear." },
	["showregenheal"] = { hide = {"ROGUE", "WARRIOR"}, short = "Regen Healing", description = "Adds values for how much extra healing you could do given 10 seconds of natural regen (outside of 5 second rule), and how much you could do from 10 seconds of in 5 second rule regen. Useful for comparing spirit to mana regen gear." },
	["max"] = { hide = {"ROGUE", "WARRIOR"}, short = "Max til oom", description = "Shows how much damage/healing you can do before going oom, chaincasting the spell, including all normal forms of regen and critical strikes, but not resists." },
	["maxevoc"] 	= { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN" }, short = "Max til oom inc gem+evoc", description = "Same as 'Max til oom', but includes two mage abilities to regen mana." },
	["maxtime"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Time taken to go oom", description = "Adds how long it takes to go oom, chain casting that spell." },
}

-- Used for schoolname in the buffs/equips.  Wherever schoolname appears, it'll try each "text" value,
-- and the amount will be added to the "name" value.  "text" should be localised, "name" should not.

TheoryCraft_PrimarySchools = {
	{ name = "Frost", text = "Frost" },
	{ name = "Nature", text = "Nature" },
	{ name = "Fire", text = "Fire" },
	{ name = "Arcane", text = "Arcane" },
	{ name = "Shadow", text = "Shadow" },
	{ name = "Holy", text = "Holy" },
}

-- All buffs and equip effects are read from here
-- Variable Name:	Description:
-- text			The text that the buff description or equip line says. If it contains the word schoolname then it tries each
--			school name in that position, eg Frost, and adds it to the appropriate variable. Can not be used for the rare
--			cases of items that only increase crit to one school, as it will only add to the damage component
-- type			The variable to modify when it sees this label, from the following:
--	All/Damage/Frost		Increases damage/healing of all spells in that school
--	Allcritchance/Frostcrithit	Any of their subcategories can be modified too
--	manaperfive			Increases mana per 5 second regen
--	ICPercent			The value that your mana regen is multiplied by to get in-5-second-rule regen
-- amount		The amount to increase the value by. "n" reads it from the description, or you can modify it by a set amount.
-- me			Mutually exclusive, if this tag is on an increaser then after this line has been found, no other increaser
--			with the me tag will read this line, good for things like Wizard Oil and Lesser Wizard Oil, where you don't want
--			Wizard Oil being picked up in Lesser Wizard Oil. The tag highest up gets spotted first.

-- Checks every buff for these

TheoryCraft_Buffs = {
	{ text="Gain %d+ mana every 2 seconds.", type="manaperfive", amount="totem" },			-- Totems
	{ text="or Curse of Agony by", type="CoAmultiplier", amount="0.5" },				-- Amplify Curse
	{ text="Receives up to %d+% extra healing from Holy Light spells", type="Holylight", amount="hl", target = "target"},	-- Blessing of light
	{ text="%d+% extra healing from Flash of Light spells.", type="Flashoflight", amount="fol", target = "target" },	-- Blessing of light
	{ text="Holy Light spell increased by 100%%.", type="Healingcritchance", amount="100" },		-- Divine Favour
	{ text="Your next fire spell is guaranteed a critical strike.", type="Firecritchance", amount="100" },	-- Combustion
	{ text="Spell effects increased by %d+.", type="All", amount="n", proc=1 },				-- Spell Blasting
	{ text="Mana cost of your next spell is reduced by 100%%.", type="Holycritchance", amount="25" },	-- Inner Focus
	{ text="Increases healing done by spells and effects by up to %d+ for %d+ sec.", type="Healing", amount="n" },	-- Blessed Prayer
	{ text="Shadow damage you deal increased by %d+%%.", type="Shadowbaseincrease", amount="n/100" },	-- Shadowform
	{ text="Increases damage by %d+%%.", type="Allbaseincrease", amount="0.05" },				-- Sayge's fortune
	{ text="Increases damage by %d+%%.", type="Meleebaseincrease", amount="0.05" },				-- Sayge's fortune
	{ text="Fire damage increased by %d+%%.", type="Firebaseincrease", amount="n/100"},			-- Burning Wish Demonic Sacrifice Imp
	{ text="Increases damage caused by %d+%%.", type="Allbaseincrease", amount="n/100"},			-- Master Demonologist Succubus
	{ text="Shadow damage increased by %d+%%.", type="Shadowbaseincrease", amount="n/100"},			-- Touch of Shadow Demonic Sacrifice Succubus
	{ text="Melee damage increased by %d+%%.", type="Meleebaseincrease", amount="n/100" },			-- Enrage
	{ text="100%% Mana regeneration may continue while casting", type="ICPercent", amount="400" }, 		-- Innervate
	{ text="%d+%% of your Mana regeneration to continue while casting", type="ICPercent", amount="n" }, 	-- Mage Armor
	{ text="schoolname spell damage increased by up to %d+.", amount="n" },					-- Elixir of frost power
	{ text="Increases spell fire damage by up to %d+.", type="Fire", amount="n" },					-- Elixir of greater firepower
	{ text="Spell damage and healing done increased by %d+%%.", type="Allbaseincrease", amount="n/100" },	-- Power Infusion
	{ text="Increased damage and mana cost for your spells.", type="Damagemodifier", amount="0.35" },	-- Arcane Power
	{ text="Restores %d+ mana every 5 seconds.", type="manaperfive", amount="n" }, 				-- Blessing of Wisdom
	{ text="Mana Regeneration increased by %d+ every 5 seconds.", type="manaperfive", amount="n" }, 	-- Safefish Well Fed
	{ text="Spell damage increased by up to %d+.", type="Damage", amount="n" }, 				-- Flask of Supreme Power / ZHC Damage
	{ text="Spell damage increased by %d+.", type="Damage", amount="n" }, 					-- Arcane Elixirs
	{ text="Increases spell critical chance by %d+%%.", type="Allcritchance", amount="n" },			-- Moonkin Aura
	{ text="Increases critical chance of spells by %d+%%,", type="Allcritchance", amount="n" },		-- Onyxia
	{ text="Magical damage and healing dealt is increased by %d+.", type="All", amount="n" },		-- ToEP
	{ text="Healing increased by up to %d+.", type="Healing", amount="n" },					-- ZHC Healing
}

TheoryCraft_Debuffs = {
	{ text="All attackers gain %d+ Ranged Attack Power against this target.", type="Ranged", amount="n/14"},-- Hunter's Mark
	{ text="Increases Shadow damage taken by %d+%%.", type="Shadowbaseincrease", amount="n/100" },		-- Shadow Weaving
	{ text="Increases Fire and Frost damage taken by %d+%%.", type="Firebaseincrease", amount="n/100" },	-- Curse of the Elements
	{ text="Increases Fire and Frost damage taken by %d+%%.", type="Frostbaseincrease", amount="n/100" },	-- Curse of the Elements
	{ text="Increases Holy damage taken by up to %d+%.", type="Holy", amount="n" },				-- Judgement of Crusader
	{ text="Shadow and Arcane damage taken increased by %d+%%.", type="Shadowbaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="Shadow and Arcane damage taken increased by %d+%%.", type="Arcanebaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="Frozen in place.", type="doshatter", amount="1" },						-- Frost Nova
	{ text="Frozen.", type="doshatter", amount="1" },							-- Freezing Band?
	{ text="Increases Fire damage taken by %d+%%.", type="Firebaseincrease", amount="n/100" },		-- Improved Scorch
}

-- Dot Duration is read from here

TheoryCraft_DotDurations = {
	{ text=" over %d+ sec.", amount="n" },				-- Shadow Word: Pain, Corruption, Immolate, Renew
	{ text="each second for %d+ sec.", amount="n" },		-- Arcane Missiles
	{ text="Lasts %d+ sec.", amount="n" },				-- Drain and Siphon Life
	{ text="after 1 min.", amount="60" },				-- Curse of Doom
}

-- Checks every line for these

TheoryCraft_EquipEveryRight = {
	{ text="Speed %d+%.%d+", type="Rangedillum", amount="n.n", slot="Ranged" },	-- Weapon Damage
	{ text="Dagger", type="MeleeAPMult", amount="-0.7", slot="MainHand" }		-- Weapon Damage
}

TheoryCraft_EquipEveryLine = {
	{ text="Adds %d+ damage per second", type="Ranged", amount="n", slot="Ammo" },	-- Arrows
	{ text="Main Hand", type="MeleeAPMult", amount="2.4", slot="MainHand" },	-- Weapon Damage
	{ text="One%-Hand", type="MeleeAPMult", amount="2.4", slot="MainHand" },	-- Weapon Damage
	{ text="Two%-Hand", type="MeleeAPMult", amount="3.3", slot="MainHand" },	-- Weapon Damage
	{ text="%d+ %- %d+ Damage", type="MeleeMin", amount="n", slot="MainHand" },	-- Weapon Damage
	{ text=" %- %d+ Damage", type="MeleeMax", amount="n", slot="MainHand" }, 	-- Weapon Damage
	{ text="%d+ %- %d+ Damage", type="RangedMin", amount="n", slot="Ranged" },	-- Weapon Damage
	{ text=" %- %d+ Damage", type="RangedMax", amount="n", slot="Ranged" }, 	-- Weapon Damage
	{ text="+%d+ schoolname Spell Damage", amount="n" },				-- of wrath items
	{ text="schoolname Damage ++%d+", amount="n" },					-- AQ Glove enchants
	{ text="Brilliant Mana Oil", type="manaperfive", amount="12" }, 		-- Enchanting oils
	{ text="Brilliant Mana Oil", type="Healing", amount="25", me=1 }, 		-- Enchanting oils
	{ text="Brilliant Wizard Oil", type="Allcritchance", amount="1" }, 		-- Enchanting oils
	{ text="Brilliant Wizard Oil", type="Damage", amount="36", me=1 }, 		-- Enchanting oils
	{ text="Minor Mana Oil", type="manaperfive", amount="4", me=1 }, 		-- Enchanting oils
	{ text="Lesser Mana Oil", type="manaperfive", amount="8", me=1 }, 		-- Enchanting oils
	{ text="Minor Wizard Oil", type="Damage", amount="8", me=1 }, 			-- Enchanting oils
	{ text="Lesser Wizard Oil", type="Damage", amount="16", me=1 }, 		-- Enchanting oils
	{ text="Wizard Oil", type="Damage", amount="24", me=1 }, 			-- Enchanting oils
	{ text="Use: Restores 375 to 625 mana.", type="manarestore", amount="500" },    -- Robe of the Archmage
	{ text="Spell Hit ++%d+%%", type="Allhitchance", amount="n" },			-- zg enchant
	{ text="Healing and Spell Damage ++%d+", type="All", amount="n", me=1 },	-- zg enchant
	{ text="+%d+ Healing", type="Healing", amount="n" },				-- of healing items
	{ text="+%d+ Damage and Healing Spells", type="All", amount="n" },		-- of sorcery items
	{ text="Mana Regen ++%d+/", type="manaperfive", amount="n" },			-- zg enchant
	{ text="Restores %d+ mana every 5 sec.", type="manaperfive", amount="n" },	-- of restoration
	{ text="Mana Regen %d+ per 5 sec.", type="manaperfive", amount="n" },		-- bracers healing enchant
	{ text="schoolname Spell Damage ++%d+", amount="n", me=1 }, 			-- Winter's Might
	{ text="Spell Damage ++%d+", type="Damage", amount="n", me=1 }, 		-- Spell Damage +30 enchant
	{ text="Healing Spells ++%d+", type="Healing", amount="n" },			-- zg priest and healing enchant
	{ text="++%d+ Spell Damage and Healing", type="All", amount="n" }, 		-- not sure
}

-- Won't check any lines containing the following words (for speed)

TheoryCraft_IgnoreLines = {
	"Durability", "Soulbound", "Classes", "Requires", "Armor", "Head", "Neck", "Shoulder",
	"Back", "Chest", "Wrist", "Hands", "Waist", "Legs", "Feet", "Finger", "Trinket",
	"Wand", "Held In Off-hand", "Resistance", "+%d+ Stamina", "+%d+ Intellect",
	"+%d+ Spirit", "+%d+ Agility", "+%d+ Strength"
}

-- Checks every line beginning with Equip: or Set: for these

TheoryCraft_Equips = {
	{ text="Health or Mana gained from Drain Life and Drain Mana increased by 15%%.", type="Drainlifeillum", amount=0.15 }, -- Felheart 3 piece bonus
	{ text="Gives a chance when your harmful spells land to increase the damage of your spells and effects by 132 for 10 sec.", type="All", amount=132, duration=9.9, proc=0.05, exact=1 },		    -- Wrath of Cenarius
	{ text="2%% chance on successful spellcast to allow 100%% of your Mana regeneration to continue while casting for 15 sec.", type="ICPercent", amount=100, duration=15, proc=0.02, exact=0 },	    -- Darkmoon Trinket
	{ text="10%% chance after casting Arcane Missiles, Fireball, or Frostbolt that your next spell with a casting time under 10 seconds cast instantly.", type="FrostboltNetherwind", amount=1 },	    -- Netherwind
	{ text="10%% chance after casting Arcane Missiles, Fireball, or Frostbolt that your next spell with a casting time under 10 seconds cast instantly.", type="FireballNetherwind", amount=1 },	    -- Netherwind
	{ text="Decreases the magical resistances of your spell targets by %d+.", type="Allpenetration", amount="n" },	    -- Penetration
	{ text="Improves your chance to hit with spells by %d+%%.", type="Damagehitchance", amount="n" },		    -- ZG drops
	{ text="Increases the critical effect chance of your Holy spells by %d+%%.", type="Holycritchance", amount="n" },   -- Benediction
	{ text="Improves your chance to get a critical strike with Holy spells by %d+%%.", type="Holycritchance", amount="n" },   -- Prophecy
	{ text="Improves your chance to get a critical strike with spells by %d+%%.", type="Allcritchance", amount="n" },   -- Standard +crit
	{ text="Increases damage and healing done by magical spells and effects by up to %d+.", type="All", amount="n" },   -- Standard +dam
	{ text="Increases healing done by spells and effects by up to %d+.", type="Healing", amount="n" },		    -- Standard +heal
	{ text="Increases damage done by schoolname spells and effects by up to %d+.", amount="n" },			    -- Single school +dam
	{ text="Restores %d+ mana per 5 sec.", type="manaperfive", amount="n" },					    --= They interchange
	{ text="Restores %d+ mana every 5 sec.", type="manaperfive", amount="n" },					    --= these two
	{ text="Improves your chance to get a critical strike with all Shock spells by %d+%%.", type="Shockcritchance", amount="n" }, -- Shaman Legionnaire set bonus
	{ text="Improves your chance to get a critical strike with Nature spells by %d+%%.", type="Naturecritchance", amount="n" }, -- ten storms set bonus
	{ text="After casting your Healing Wave or Lesser Healing Wave spell, gives you a 25%% chance to gain Mana equal to 35%% of the base cost of the spell.", type="EarthfuryBonusmanacost", amount=-0.0875 },   -- earth fury set bonus
}

end
