if (TheoryCraft_Locale == nil) then

-- The format of the tooltip is defined below.
-- It looks ghastly complicated at first, but is quite straight forward.

-- show is which checkbox needs to be enabled for the line to show

-- if inverse is true, then the checkbox needs to be unchecked

-- left is what gets added to the left hand side of the toolip
-- right is what gets added to the right hand side of the tooltip

-- If a value is not found, the entire line will be hidden.
-- to avoid this, put it in an if... eg the line:
--       "foo#IFbar lalala $invalidvalue$ no#"
-- will just show the word "foo", as the invalid value will hide the entire
-- if.

-- Where you want one value to be shown, or if that isn't valid to show
-- another, use OR.  Eg on a spell with 1000 minimum damage:
--       "foo#ORthis is invalid$invalidvalue$/bar $mindamage$OR#"
-- will just show foobar 1000, however if the spell is a heal nothing
-- will be shown at all.

-- Format for ORs:
--     "#OR text / more text OR#"
-- Format for IFs:
--     "#IF text IF#"

TheoryCraft_TooltipOrs = {
	hitorhealhit = "hit",
	hitorhealheal = "heal",
	damorhealdam = "Dam",
	damorhealheal = "Heal",
	damorapap = "AP",
	damorapdam = "+dam",
}

TheoryCraft_TooltipFormat = {
	{show = true, 		left = "#c1,1,1#$spellname$", 		right = "#c0.5,0.5,0.5#Rank $spellrank$"},
	{show = true, 		left = "#c1,1,1#$wandlineleft2$", 	right = "#c1,1,1#$wandlineright2$"},
	{show = true, 		left = "#c1,1,1#$wandlineleft3$", 	right = "#c1,1,1#$wandlineright3$"},
	{show = "embedstyle1", 	left = "#c1,1,1#$wandlineleft4$", 	right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# to crit"},
	{show = "embedstyle1", inverse = true, left = "#c1,1,1#$wandlineleft4$"},
	{show = true, 		left = "#c1,1,1#$basemanacost$ Mana", 	right = "#c1,1,1#$spellrange$"},
	{show = "embedstyle1", 	left = "#c0.9,0.9,1##OR$dps$#c1,1,1# Dps/$hps$#c1,1,1# HpsOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# to crit"},
	{show = "embedstyle2", 	left = "#c0.9,0.9,1##OR$dpm,2$#c1,1,1# Dpm/$hpm,2$#c1,1,1# HpmOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# to crit"},
	{show = "embedstyle3", 	left = "#c0.9,0.9,1##OR$dps$#c1,1,1# Dps/$hpm,2$#c1,1,1# HpmOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# to crit"},
	{show = true, 		left = "#c1,1,1#$basecasttime$", right = "#c1,1,1#$cooldown$"},
	{show = true, 		left = "#c1,1,1#$cooldownremaining$",},
	{show = "embed", 	left = "#c1,0.82745098,0##OR$description$/$basedescription$OR##WRAP#"},
	{show = "embed", inverse = true, left = "#c1,0.82745098,0#$basedescription$#WRAP#"},
	{show = true, 		left = "#c1,0.5,1#$outfitname$"},
	{show = true, 		left = "Restores $evocation$ mana."},
	{show = true, 		left = "Unbuffed: $sealunbuffed,1$ dps"},
	{show = true, 		left = "With this seal: $sealbuffed,1$ dps"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Healing Statistics#"},
	{show = "embed", inverse = true, left = "Heals: $healrange$"},
	{show = "critwithdam", 	left = "Crits: $crithealchance,2$% (for $crithealrange$)"},
	{show = "critwithoutdam", left = "Crits: $crithealchance,2$%"},
	{show = "hps", 		left = "HPS: $hps,1$#IF, $withhothps,1$IF#"},
	{show = "dpsdam", 	left = "HPS from +heal: $hpsdam,1$ ($hpsdampercent,1$%)"},
	{show = "averagedamnocrit", left = "Average Heal: $averagehealnocrit$"},
	{show = "averagedamnocrit", left = "Ticks For: $averagehealtick$"},
	{show = "averagedam", 	left = "Average Heal: $averageheal$"},
	{show = "averagedam", 	left = "Ticks For: $averagehealtick$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Damage Statistics#"},
	{show = "embed", inverse = true, left = "Hits: $dmgrange$"},
	{show = "critmelee", 	left = "Crits: $critdmgchance,2$% (for $critdmgrange$)"},
	{show = "critwithdam", 	left = "Crits: $critdmgchance,2$% (for $critdmgrange$)"},
	{show = "sepignite", 	left = "With Ignite: $igniterange$"},
	{show = "critwithoutdam", left = "Crits: $critdmgchance,2$%"},
	{show = "dps", 		left = "DPS: $dps,1$#IF, $withdotdps,1$IF#"},
	{show = "dpsdam", 	left = "DPS from +dam: $dpsdam,1$ ($dpsdampercent,1$%)"},
	{show = "averagedamnocrit", left = "Average Hit: $averagedamnocrit$"},
	{show = "averagedamnocrit", left = "Ticks For: $averagedamtick$"},
	{show = "averagedam", 	left = "Average Hit: $averagedam$"},
	{show = "averagedam", 	left = "Ticks For: $averagedamtick$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Multipliers:#"},
	{show = "plusdam", 	left = "Base +$damorheal$: $plusdam$"},
	{show = "damcoef", 	left = "+$damorheal$ Coefficient: $damcoef,1$%#IF, $damcoef2,1$%IF#"},
	{show = "dameff", 	left = "+$damorheal$ Efficiency: $dameff,1$%"},
	{show = "damtodouble", 	left = "+$damorheal$ to Double: $damtodouble$"},
	{show = "damfinal", 	left = "Final +$damorheal$: $damfinal$#IF, $damfinal2$IF#"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Resists:#"},
	{show = "resists", 	left = "Resist Rate ($resistlevel$): $resistrate$%"},
	{show = "resists", 	left = "After Level Resists: $dpsafterresists,1$ DPS"},
	{show = "resists", 	left = "Up to: $penetration,1$ DPS Penetrated"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Comparisons:#"},
	{show = "nextcrit", 	left = "1% to crit: +$nextcritheal,2$ average heal (Eq: $nextcrithealequive,2$ +heal)"},
	{show = "nextstr", 	left = "10 str: +$nextstrdam,2$ average $hitorheal$ (Eq: $nextstrdamequive,2$ $damorap$)"},
	{show = "nextagi", 	left = "10 agi: +$nextagidam,2$ average $hitorheal$#IF (Eq: $nextagidamequive,2$ $damorap$)IF#"},
	{show = "nextcrit", 	left = "1% to crit: +$nextcritdam,2$ average $hitorheal$#IF (Eq: $nextcritdamequive,2$ $damorap$)IF#"},
	{show = "nexthit", 	left = "1% to hit: +$nexthitdam,2$ average $hitorheal$#IF (Eq: $nexthitdamequive,2$ $damorap$)IF#"},
	{show = "nextpen", 	left = "10 pen: #OR$dontshowupto$/Up to OR#+$nextpendam,2$ average $hitorheal$#IF (Eq: $nextpendamequive,2$ $damorap$)IF#"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Rotations:#"},
	{show = true, 		left = "MS rot ($msrotationlength,1$ sec) dps: $msrotationdps,1$"},
	{show = true, 		left = "AS rot ($asrotationlength,1$ sec) dps: $asrotationdps,1$"},
	{show = true, 		left = "MS/Arcane rot dps: $arcrotationdps,1$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Combined Comparisons:#"},
	{show = "nextagi", 	left = "10 agi: +$nextagidps,2$ MS rot dps#IF (Eq: $nextagidpsequive,2$ $damorap$)IF#"},
	{show = "nextcrit", 	left = "1% to crit: +$nextcritdps,2$ MS rot dps (Eq: $nextcritdpsequive,2$ $damorap$)"},
	{show = "nexthit", 	left = "1% to hit: +$nexthitdps,2$ MS rot dps (Eq: $nexthitdpsequive,2$ $damorap$)"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Efficiency:#"},
	{show = "mana", 	left = "True Mana Cost: $manacost,1$"},
	{show = "dpm", 		left = "DPM: $dpm,2$#IF, $withdotdpm,2$IF#"},
	{show = "dpsmana", 	left = "DPS/Mana: $dpsmana,3$"},
	{show = "hpm", 		left = "HPM: $hpm,2$#IF, $withhothpm,2$IF#"},
	{show = "lifetap", 	left = "Lifetap DPH: $lifetapdpm,1$"},
	{show = "lifetap", 	left = "Lifetap HPH: $lifetaphpm,1$"},
	{show = "lifetap", 	left = "Lifetap DPS: $lifetapdps,1$"},
	{show = "lifetap", 	left = "Lifetap HPS: $lifetaphps,1$"},
	{show = "showregenheal", left = "10 sec of regen: +$regenheal$ healing"},
	{show = "showregenheal", left = "10 sec of regen whilst casting: +$icregenheal$ healing"},
	{show = "showregendam", left = "10 sec of regen: +$regendam$ damage"},
	{show = "showregendam", left = "10 sec of regen whilst casting: +$icregendam$ damage"},
	{show = "max", 		left = "Healing til oom: $maxoomheal$ ($maxoomhealtime$ secs)"},
	{show = "max", 		left = "Damage til oom: $maxoomdam$ ($maxoomdamtime$ secs)"},
	{show = "maxevoc", 	left = "Damage til oom w/ evoc+gem: $maxevocoomdam$ ($maxevocoomdamtime$ secs)"},
}


TheoryCraft_MeleeComboEnergyConverter = "into (.-) additional"
TheoryCraft_MeleeComboReader = "(%d+) point(.-): (%d+)%-(%d+) damage"
TheoryCraft_MeleeComboReplaceWith = "$points$ point%1: %2%-%3 damage"

TheoryCraft_MeleeMinMaxReader = {
	{ pattern = "(%d+)%% of your attack power",							-- Bloodthirst
		type={"bloodthirstmult"} },
	{ pattern = "causing (%d+) to (%d+) damage, modified by attack power",				-- Shield Slam
		type={"mindamage", "maxdamage"} },
	{ pattern = "(%d+)%% damage",									-- Shred/Ravage
		type={"backstabmult"} },
	{ pattern = "(%d+)%% weapon damage",								-- Backstab
		type={"backstabmult"} },
	{ pattern = "plus (%d+)",									-- Backstab
		type={"addeddamage"} },
	{ pattern = "next attack by (%d+) damage",							-- Maul
		type={"addeddamage"} },
	{ pattern = "causing (%d+) additional damage",							-- Claw
		type={"addeddamage"} },
	{ pattern = "causes (%d+) damage in addition",							-- Sinister Strike
		type={"addeddamage"} },
	{ pattern = "increases melee damage by (%d+)",							-- Aimed Shot
		type={"addeddamage"} },
	{ pattern = "increases ranged damage by (%d+)",							-- Aimed Shot
		type={"addeddamage"} },
	{ pattern = "for an additional (%d+) damage",							-- Multi-Shot
		type={"addeddamage"} },
	{ pattern = "inflicting (%d+) damage%.",							-- Swipe
		type={"addeddamage"} },
	{ pattern = "that causes (%d+) damage,",							-- Mocking Blow
		type={"addeddamage"} },
	{ pattern = "and doing (%d+) damage to them",							-- Thunder Clap
		type={"addeddamage"} },

}

TheoryCraft_MeleeMinMaxReplacer = {
	{ search = " causing %d+ to %d+ damage, modified by attack power, ",				-- Shield Slam
	  replacewith = " causing $damage$ damage " },
	{ search = " deals %d+%% weapon damage and ",							-- Scattershot / Ghostly
	  replacewith = " deals $damage$ damage and " },
	{ search = " causing damage equal to %d+%% of your attack power",				-- Bloodthirst
	  replacewith = " causing $damage$ damage" },
	{ search = "Increases the druid's next attack by %d+ damage",					-- Maul
	  replacewith = "Your next attack causes $damage$ damage" },
	{ search = " causing %d+% additional damage",							-- Claw
	  replacewith = " causing $damage$ damage" },
	{ search = " causing %d+%% weapon damage plus %d+ to the target",				-- Backstab
	  replacewith = " causing $damage$ damage" },
	{ search = " causing %d+%% damage plus %d+ to the target",					-- Shred/Ravage
	  replacewith = " causing $damage$ damage" },
	{ search = " causes %d+ damage in addition to your normal weapon damage",			-- Sinister Strike
	  replacewith = " causes $damage$ damage" },
	{ search = " that increases melee damage by %d+",						-- Aimed Shot
	  replacewith = " that deals $damage$ damage to the target" },
	{ search = " increases ranged damage by %d+",							-- Aimed Shot
	  replacewith = " causes $damage$ damage to the target" },
	{ search = " for an additional %d+ damage",							-- Multi-Shot
	  replacewith = " for $damage$ damage" },
	{ search = " deals weapon damage plus %d+ and ",						-- Mortal Strike
	  replacewith = " deals $damage$ damage and " },
	{ search = " does your weapon damage plus %d+ to ",						-- Cleave
	  replacewith = " deals $damage$ damage to " },
	{ search = " causing weapon damage plus %d+",							-- Overpower
	  replacewith = " causing $damage$ damage" },
	{ search = " to block enemy melee and ranged attacks%.",					-- Block
	  replacewith = " to block enemy melee and ranged attacks, reducing damage taken by $blockvalue$." },
	{ search = "This attack deals %d+%% weapon damage ",						-- Riposte
	  replacewith = "This attack deals $damage$ damage " },
	{ search = "inflicting (%d+) damage%.",								-- Swipe
	  replacewith = "inflicting $damage$ damage." },
	{ search = "that causes (%d+) damage,",								-- Mocking Blow
	  replacewith = "that causes $damage$ damage," },
	{ search = "and doing (%d+) damage to them",							-- Thunder Clap
	  replacewith = "and doing $damage$ damage to them" },
	{ search = " causing weapon damage ",						-- Whirlwind
	  replacewith = " causing $damage$ damage " },
}

TheoryCraft_SpellMinMaxReader = {
	{ pattern = "causing (%d+) to (%d+) Fire damage to himself and (%d+) to (%d+) Fire damage",	-- Hellfire
		type={"mindamage", "maxdamage", "mindamage", "maxdamage"} },
	{ pattern = "causing (%d+) Fire damage to himself and (%d+) Fire damage",			-- Hellfire
		type={"bothdamage", "bothdamage"} },

	{ pattern = "will be struck for (%d+) Nature damage.",						-- Lightning Shield
		type={"bothdamage"} },

	{ pattern = "and causing (%d+) Nature damage",							-- Insect Swarm
		type={"bothdamage"} },

	{ pattern = "horror for 3 sec and causes (%d+) Shadow damage",					-- Death Coil
		type={"bothdamage"} },

	{ pattern = "(%d+) to (%d+)(.+)and another (%d+) to (%d+)",					-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+) to (%d+)(.+)and another (%d+)",						-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(%d+)(.+)and another (%d+) to (%d+)",						-- Generic Hybrid spell
		type={"bothdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+)(.+)and another (%d+)",							-- Generic Hybrid spell
		type={"bothdamage", "tmptext", "dotbothdamage"} },

	{ pattern = "(%d+) to (%d+)(.+)an additional (%d+) to (%d+)",					-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+) to (%d+)(.+)an additional (%d+)",						-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(%d+)(.+)an additional (%d+) to (%d+)",						-- Generic Hybrid spell
		type={"bothdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+)(.+)an additional (%d+)",							-- Generic Hybrid spell
		type={"bothdamage", "tmptext", "dotbothdamage"} },

	{ pattern = "(%d+) to (%d+)(.+) and (%d+) to (%d+)",						-- Flame Shock
		type={"mindamage", "maxdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+) to (%d+)(.+) and (%d+)",							-- Flame Shock
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "causing (%d+)(.+) and (%d+) to (%d+)",						-- Flame Shock
		type={"bothdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "causing (%d+)(.+) and (%d+)",							-- Flame Shock
		type={"bothdamage", "tmptext", "dotbothdamage"} },

	{ pattern = "(%d+) to (%d+) Fire damage.",							-- Magma totem
		type={"mindamage", "maxdamage"} },
	{ pattern = "(%d+) Fire damage.",								-- Magma totem
		type={"bothdamage"} },

	{ pattern = "yards for (%d+) to (%d+) every ",							-- Healing Stream totem
		type={"mindamage", "maxdamage"} },
	{ pattern = "yards for (%d+) every ",								-- Healing Stream totem
		type={"bothdamage"} },

	{ pattern = "(%d+) to (%d+)",									-- Generic Normal spell
		type={"mindamage", "maxdamage"} },
	{ pattern = "(%d+)",										-- Generic no damage range spell
		type={"bothdamage"} },
}

TheoryCraft_Dequips = {
	{ type = "all", text="All Stats %+(%d+)" },
	{ type = "formattackpower", text="%+(%d+) Attack Power in Cat, Bear" },
	{ type = "attackpower", text="%+(%d+) Attack Power" },
	{ type = "rangedattackpower", text="%+(%d+) ranged Attack Power" },
	{ type = "rangedattackpower", text="Ranged Attack Power %+(%d+)%/" },
	{ type = "strength", text="%+(%d+) Strength" },
	{ type = "strength", text="Strength %+(%d+)" },
	{ type = "agility", text="%+(%d+) Agility" },
	{ type = "agility", text="Agility %+(%d+)" },
	{ type = "stamina", text="%+(%d+) Stamina" },
	{ type = "stamina", text="Stamina %+(%d+)" },
	{ type = "intellect", text="%+(%d+) Intellect" },
	{ type = "intellect", text="Intellect %+(%d+)" },
	{ type = "spirit", text="%+(%d+) Spirit" },
	{ type = "spirit", text="Spirit %+(%d+)" },
	{ type = "totalhealth", text="Health %+(%d+)" },
	{ type = "totalhealth", text="HP %+(%d+)" },
	{ type = "meleecritchance", text="Improves your chance to get a critical strike by (%d+)%%%." },
}

TheoryCraft_Locale = {
	HitMessage	= "Your (.+) hits (.+) for (%d+)%.",
	CritMessage	= "Your (.+) crits (.+) for (%d+)%.",
	Absorbed	= "(%+) absorbed",
	ID_Beast	= "Beast",
	ID_Humanoid	= "Humanoid",
	ID_Giant	= "Giant",
	ID_Dragonkin	= "Dragonkin",
	ID_Equip	= "Equip: ",
	ID_Set		= "Set: ",
	ID_Use		= "Use: ",
	to		= " to ",
	Attack		= "Attack",
	InstantCast	= "Instant cast",
	SecCast		= " sec cast",
	Mana		= " Mana",
	Cooldown	= " sec cooldown",
	CooldownRem	= "Cooldown remaining: ",
	Set		= "%(%d+/%d+%)",
	LoadText	= "TheoryCraft "..TheoryCraft_Version.." by Aelian. Type /tc for ui interface. Type /tc more for hidden features.",
	lifetap		= "Life Tap",
	MinMax  = {
		autoshotbefore = "Shoots the target for ",
		autoshotafter = ".",
		shooterror = "No wand equipped.",
		crusader = "granting %d+ melee attack power",
	},
	SpellTranslator = {
		["Frostbolt"] = "Frostbolt",
		["Frost Nova"] = "Frost Nova",
		["Cone of Cold"] = "Cone of Cold",
		["Blizzard"] = "Blizzard",
		["Arcane Explosion"] = "Arcane Explosion",
		["Arcane Missiles"] = "Arcane Missiles",
		["Fire Blast"] = "Fire Blast",
		["Fireball"] = "Fireball",
		["Pyroblast"] = "Pyroblast",
		["Scorch"] = "Scorch",
		["Blast Wave"] = "Blast Wave",
		["Flamestrike"] = "Flamestrike",
		["Ice Barrier"] = "Ice Barrier",
		["Evocation"] = "Evocation",

		["Shadow Bolt"] = "Shadow Bolt",
		["Soul Fire"] = "Soul Fire",
		["Searing Pain"] = "Searing Pain",
		["Immolate"] = "Immolate",
		["Firebolt"] = "Firebolt",
		["Lash of Pain"] = "Lash of Pain",
		["Conflagrate"] = "Conflagrate",
		["Rain of Fire"] = "Rain of Fire",
		["Hellfire"] = "Hellfire",
		["Corruption"] = "Corruption",
		["Curse of Agony"] = "Curse of Agony",
		["Curse of Doom"] = "Curse of Doom",
		["Drain Soul"] = "Drain Soul",
		["Siphon Life"] = "Siphon Life",
		["Drain Life"] = "Drain Life",
		["Death Coil"] = "Death Coil",
		["Shadowburn"] = "Shadowburn",
		["Life Tap"] = "Life Tap",

		["Prayer of Healing"] = "Prayer of Healing",
		["Shadow Word: Pain"] = "Shadow Word: Pain",
		["Mind Flay"] = "Mind Flay",
		["Mind Blast"] = "Mind Blast",
		["Smite"] = "Smite",
		["Holy Fire"] = "Holy Fire",
		["Holy Nova"] = "Holy Nova",
		["Power Word: Shield"] = "Power Word: Shield",
		["Desperate Prayer"] = "Desperate Prayer",
		["Lesser Heal"] = "Lesser Heal",
		["Heal"] = "Heal",
		["Flash Heal"] = "Flash Heal",
		["Greater Heal"] = "Greater Heal",
		["Devouring Plague"] = "Devouring Plague",
		["Renew"] = "Renew",
		["Starshards"] = "Starshards",

		["Healing Touch"] = "Healing Touch",
		["Tranquility"] = "Tranquility",
		["Rejuvenation"] = "Rejuvenation",
		["Regrowth"] = "Regrowth",
		["Starfire"] = "Starfire",
		["Wrath"] = "Wrath",
		["Insect Swarm"] = "Insect Swarm",
		["Entangling Roots"] = "Entangling Roots",
		["Moonfire"] = "Moonfire",
		["Hurricane"] = "Hurricane",
		["Ravage"] = "Ravage",
		["Shred"] = "Shred",
		["Claw"] = "Claw",
		["Maul"] = "Maul",
		["Ferocious Bite"] = "Ferocious Bite",
		["Swipe"] = "Swipe",

		["Bloodthirst"] = "Bloodthirst",
		["Mortal Strike"] = "Mortal Strike",
		["Overpower"] = "Overpower",
		["Whirlwind"] = "Whirlwind",
		["Heroic Strike"] = "Heroic Strike",
		["Cleave"] = "Cleave",
		["Block"] = "Block",
		["Thunder Clap"] = "Thunder Clap",
		["Mocking Blow"] = "Mocking Blow",
		["Shield Slam"] = "Shield Slam",

		["Sinister Strike"] = "Sinister Strike",
		["Hemorrhage"] = "Hemorrhage",
		["Backstab"] = "Backstab",
		["Ghostly Strike"] = "Ghostly Strike",
		["Ambush"] = "Ambush",
		["Riposte"] = "Riposte",
		["Eviscerate"] = "Eviscerate",

		["Flash of Light"] = "Flash of Light",
		["Holy Light"] = "Holy Light",
		["Exorcism"] = "Exorcism",
		["Holy Wrath"] = "Holy Wrath",
		["Consecration"] = "Consecration",
		["Hammer of Wrath"] = "Hammer of Wrath",
		["Seal of the Crusader"] = "Seal of the Crusader",
		["Seal of Command"] = "Seal of Command",
		["Seal of Righteousness"] = "Seal of Righteousness",
		["Holy Shock"] = "Holy Shock",

		["Chain Lightning"] = "Chain Lightning",
		["Lightning Bolt"] = "Lightning Bolt",
		["Lightning Shield"] = "Lightning Shield",
		["Lesser Healing Wave"] = "Lesser Healing Wave",
		["Healing Wave"] = "Healing Wave",
		["Chain Heal"] = "Chain Heal",
		["Earth Shock"] = "Earth Shock",
		["Flame Shock"] = "Flame Shock",
		["Frost Shock"] = "Frost Shock",
		["Magma Totem"] = "Magma Totem",
		["Searing Totem"] = "Searing Totem",
		["Healing Stream Totem"] = "Healing Stream Totem",

		["Arcane Shot"] = "Arcane Shot",
		["Serpent Sting"] = "Serpent Sting",
		["Mend Pet"] = "Mend Pet",
		["Multi-Shot"] = "Multi-Shot",
		["Volley"] = "Volley",
		["Aimed Shot"] = "Aimed Shot",
		["Scatter Shot"] = "Scatter Shot",
		["Raptor Strike"] = "Raptor Strike",
		["Auto Shot"] = "Auto Shot",

		["Attack"] = "Attack",
		["Shoot"] = "Shoot",
	},
-- Appears on the advanced tab, left side matches spell data (do not translate), right side equals display text
	TalentTranslator = {
-- Warlock
		{ id="suppression", translated="Suppression" },
		{ id="impcorrupt", translated="Corruption" },
		{ id="impdrainlife", translated="Drain Life" },
		{ id="impcoa", translated="CoA" },
		{ id="shadowmastery", translated="SM" },
		{ id="demonicembrace", translated="Demonic Emb" },
		{ id="impsearing", translated="Searing Pain" },
		{ id="impimmolate", translated="Immolate" },
		{ id="emberstorm", translated="Emberstorm" },
		{ id="devastation", translated="Devastation" },
		{ id="ruin", translated="Ruin" },
-- Mage
		{ id="subtlety", translated="Subtlety" },
		{ id="focus", translated="Arcane Focus" },
		{ id="clearcast", translated="Clearcast" },
		{ id="meditation", translated="Meditation" },
		{ id="arcanemind", translated="Arcane Mind" },
		{ id="instab", translated="Instability" },
		{ id="impfire", translated="Fireball" },
		{ id="ignite", translated="Ignite" },
		{ id="incinerate", translated="Incinerate" },
		{ id="impflame", translated="Flamestrike" },
		{ id="critmass", translated="Crit Mass" },
		{ id="firepower", translated="Fire Power" },
		{ id="impfrost", translated="Frostbolt" },
		{ id="shards", translated="Ice Shards" },
		{ id="piercice", translated="Pierc Ice" },
		{ id="chanelling", translated="Chanelling" },
		{ id="shatter", translated="Shatter" },
		{ id="impcoc", translated="Cone of Cold" },
-- Mage2
		{ id="subtlety", translated="Subtlety" },
		{ id="focus", translated="Arcane Focus" },
		{ id="clearcast", translated="Clearcast" },
		{ id="impae", translated="IAE" },
		{ id="meditation", translated="Meditation" },
		{ id="arcanemind", translated="Arcane Mind" },
		{ id="instab", translated="Instability" },
		{ id="impfire", translated="Fireball" },
		{ id="ignite", translated="Ignite" },
		{ id="incinerate", translated="Incinerate" },
		{ id="impflame", translated="Flamestrike" },
		{ id="burnsoul", translated="Burning Soul" },
		{ id="masterofelements", translated="Mast Element" },
		{ id="critmass", translated="Crit Mass" },
		{ id="firepower", translated="Fire Power" },
		{ id="impfrost", translated="Frostbolt" },
		{ id="elemprec", translated="Elem Prec" },
		{ id="shards", translated="Ice Shards" },
		{ id="piercice", translated="Pierc Ice" },
		{ id="chanelling", translated="Chanelling" },
		{ id="shatter", translated="Shatter" },
		{ id="impcoc", translated="Cone of Cold" },
-- Hunter
		{ id="lethalshots", translated="Lethal Shots" },
		{ id="mortalshots", translated="Mortal Shots" },
		{ id="rws", translated="Ranged Spec" },
		{ id="barrage", translated="Barrage" },
		{ id="humanoidslaying", translated="Humananoid" },
		{ id="monsterslaying", translated="Monster" },
		{ id="savagestrikes", translated="Savage" },
		{ id="survivalist", translated="Survivalist" },
		{ id="killerinstinct", translated="Killer Inst" },
		{ id="reflexes", translated="Reflexes" },
-- Priest
		{ id="imppwrword", translated="PW: Shield" },
		{ id="pmeditation", translated="Meditation" },
		{ id="mentalagility", translated="Mental Agi" },
		{ id="mentalstrength", translated="Mental Str" },
		{ id="forceofwill", translated="Force of Will" },
		{ id="imprenew", translated="Renew" },
		{ id="holyspec", translated="Holy Spec" },
		{ id="divinefury", translated="Divine Fury" },
		{ id="imphealing", translated="Imp Healing" },
		{ id="searinglight", translated="Searing Light" },
		{ id="guidance", translated="Guidance" },
		{ id="imppoh", translated="Imp PoH" },
		{ id="spiritual", translated="Spiritual" },
		{ id="shadowfocus", translated="Shadow Focus" },
		{ id="darkness", translated="Darkness" },
-- Warrior
		{ id="impoverpower", translated="Overpower" },
		{ id="impale", translated="Impale" },
		{ id="twohandspec", translated="Twohnd Spec" },
		{ id="axespec", translated="Axe Spec" },
		{ id="polearmspec", translated="Polearm Spec" },
		{ id="cruelty", translated="Cruelty" },
		{ id="onehandspec", translated="Onehnd Spec" },
-- Shaman
		{ id="lightningmast", translated="Lightning" },
		{ id="elemfocus", translated="Elem Focus" },
		{ id="convection", translated="Convection" },
		{ id="concussion", translated="Concussion" },
		{ id="callofthunder", translated="Call of Thund" },
		{ id="fury", translated="Elem Fury" },
		{ id="impcl", translated="Imp Chain L" },
		{ id="ancestral", translated="Ancestral" },
		{ id="thundering", translated="Thundering" },
		{ id="impls", translated="Lghtng Shield" },
		{ id="imphealingwave", translated="Healing Wve" },
		{ id="tidalfocus", translated="Tidal Focus" },
		{ id="tidalmastery", translated="Tidal Mast" },
		{ id="purification", translated="Purification" },
		{ id="natguid", translated="Natures Guid" },
		{ id="weaponmast", translated="Weapon" },
-- Druid
		{ id="impwrath", translated="Wrath" },
		{ id="impmoon", translated="Moonfire" },
		{ id="vengeance", translated="Vengeance" },
		{ id="impstarfire", translated="Starfire" },
		{ id="grace", translated="Grace" },
		{ id="moonfury", translated="Moonfury" },
		{ id="natweapons", translated="Nat Weapons" },
		{ id="claws", translated="Sharp Claws" },
		{ id="strikes", translated="Pred Strikes" },
		{ id="savagefury", translated="Savage Fury" },
		{ id="hotw", translated="Heart ot W" },
		{ id="imptouch", translated="Healing Tch" },
		{ id="reflection", translated="Reflection" },
		{ id="tranquil", translated="Tranquil" },
		{ id="imprejuve", translated="Rejuvenation" },
		{ id="giftofnat", translated="Gift of Nat" },
		{ id="impregrowth", translated="Regrowth" },
-- Paladin
		{ id="divineint", translated="Divine Int" },
		{ id="divinestrength", translated="Divine Str" },
		{ id="illumination", translated="Illumination" },
		{ id="holypower", translated="Holy Power" },
		{ id="conviction", translated="Conviction" },
-- Rogue
		{ id="malice", translated="Malice" },
		{ id="lethality", translated="Lethality" },
		{ id="impbs", translated="Backstab" },
		{ id="daggerspec", translated="Dagger spec" },
		{ id="fistspec", translated="Fist spec" },
		{ id="aggression", translated="Aggression" },
		{ id="opportunity", translated="Opportunity" },
		{ id="impambush", translated="Imp Ambush" },
	},
-- Needs translating for the predefined sets to have set bonuses
	SetTranslator = {
		{ id="Magisters", translated="Magister's Regalia" },
		{ id="Sorcerers", translated="Sorcerer's Regalia" },
		{ id="Arcanist", translated="Arcanist Regalia" },
		{ id="Netherwind", translated="Netherwind Regalia" },

		{ id="Dreadmist", translated="Dreadmist Raiment" },
		{ id="Deathmist", translated="Deathmist Raiment" },
		{ id="Felheart", translated="Felheart Raiment" },
		{ id="Nemesis", translated="Nemesis Raiment" },

		{ id="Devout", translated="Vestments of the Devout" },
		{ id="Virtuous", translated="Vestments of the Virtuous" },
		{ id="Prophecy", translated="Vestments of Prophecy" },
		{ id="Transcendence", translated="Vestments of Transcendence" },

		{ id="Wildheart", translated="Wildheart Raiment" },
		{ id="Feralheart", translated="Feralheart Raiment" },
		{ id="Cenarion", translated="Cenarion Raiment" },
		{ id="Stormrage", translated="Stormrage Raiment" },

		{ id="Elements", translated="The Elements" },
		{ id="Five Thunders", translated="The Five Thunders" },
		{ id="Earthfury", translated="The Earthfury" },
		{ id="Ten Storms", translated="The Ten Storms" },

		{ id="Lightforge", translated="Lightforge Armor" },
		{ id="Soulforge", translated="Soulforge Armor" },
		{ id="Lawbringer", translated="Lawbringer Armor" },
		{ id="Judgement", translated="Judgement Armor" },

		{ id="Valor", translated="Battlegear of Valor" },
		{ id="Heroism", translated="Battlegear of Heroism" },
		{ id="Might", translated="Battlegear of Might" },
		{ id="Wrath", translated="Battlegear of Wrath" },

		{ id="Shadowcraft", translated="Shadowcraft Armor" },
		{ id="Darkmantle", translated="Darkmantle Armor" },
		{ id="Nightslayer", translated="Nightslayer Armor" },
		{ id="Bloodfang", translated="Bloodfang Armor" },

		{ id="Beaststalker", translated="Beaststalker Armor" },
		{ id="Beastmaster", translated="Beastmaster Armor" },
		{ id="Giantstalker", translated="Giantstalker Armor" },
		{ id="Dragonstalker", translated="Dragonstalker Armor" },
	},

}
	
TheoryCraft_CheckButtons = {
	["embedstyle1"]	= { short = "DPS | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPS/HPS on the left and Crit chance on the right.", descriptionmelee="For melee, will only show your crit chance above\nthe description of each ability." },
	["embedstyle2"]	= { hide = {"ROGUE", "WARRIOR"}, short = "DPM | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPM/HPM on the left and Crit chance on the right." },
	["embedstyle3"]	= { hide = {"ROGUE", "WARRIOR"}, short = "DPS/HPM | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPS/HPM on the left and Crit chance on the right." },
	["titles"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Titles", description = "Seperates the tooltip extended info in to seperate categories." },
	["embed"] 	= { short = "Embed", description = "Modifies the base description of your spell tooltips,\nto include the effects of gear.", descriptionmelee = "Modifies the base description of your ability tooltips\nto replace terms like 'weapon damage plus 160'\nwith actual damage done." },
	["crit"] 	= { short = "Crit", description = "Adds your crit rate to your spell tooltips.\nIncludes talents, gear and base crit rate (int/$cr).", descriptionmelee = "Adds your crit damage and crit chance to your ability tooltips." },
	["critdam"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Crit Damage", description = "Shows the damage range of your critical strikes" },
	["rollignites"]	= { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN", "HUNTER" }, short = "Rolling Ignites", description = "All calculations that include critical strikes\nwill factor in rolling ignites. That is where\nignite procs whilst ignite is already on the target,\nresetting the timer but adding to the damage." },
	["sepignite"] 	= { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN", "HUNTER" }, short = "Seperate Ignite", description = "Seperates the ignite component from your crit damage." },
	["dps"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "DPS", description = "Adds Damage per Second cast time to\nyour tooltips. For instant casts,\ncast time is taken as the length of\nthe global cooldown, 1.5 seconds.", descriptionmelee = "How much this ability increases your dps by, if you use it each time the timer is up." },
	["combinedot"]	= { hide = {"ROGUE", "WARRIOR"}, short = "Combine DoT", description = "If enabled, spells that have both a \ndirect component and an over time component will have\nthe DoT DPS expressed as (DPS+DoT)/Casttime\n rather then DoT/Duration." },
	["dotoverct"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "DoT over CT", description = "DoTs will have their DPS as Total Damage / Cast time, \nrather then Total Damage / DoT Duration" },
	["hps"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "HPS", description = "Is calculated the same way as DPS,\nwith the same extended options." },
	["dpsdam"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "DPS from +dam", description = "How much of your DPS/HPS is from your +damage gear." },
	["averagedam"] 	= {short = "Average Hit", description = "Adds the spells average hit to your tooltips.", descriptionmelee = "Adds your average damage to your ability tooltips." },
	["procs"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Include Procs", description = "All Proc based effects (Wrath of Cenarius, Darkmoon Trinket, Netherwind)\neffects are averaged instead of only being applied while the buff is active." },
	["mitigation"] 	= { hide = {"STRIPPED"}, short = "Enable Mitigation", description = "If enabled your targets armor will be included in TC's calculations.\nYou can view a mobs armor by typing in /tc armor 'mob name', or\njust leaving it blank to list all known mobs." },
	["resists"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Resists", description = "Adds a resists category to the tooltip.\nThis includes the resist rate of your *target* and\nyour dps after level-based resists are accounted for.\nIf you have any Spell Penetration gear it'll also\ntell you how much dps your penetration gear adds.\nNote that unless your target has a resist score equal to\nor higher then your penetration score, this dps\npenetrated won't be achieved." },
	["averagethreat"] = { hide = {"ROGUE", "WARRIOR", "SHAMAN", "HUNTER", "DRUID", "WARLOCK", "PRIEST", "MAGE"}, short = "Average Threat", description = "The average threat caused by the attack." },
	["plusdam"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "+Damage", description = "+Damage for that spell, before the +dam coefficient." },
	["damcoef"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "+Damage Coefficient", description = "+Damage coefficient for that spell.\nWill be modified by applicable talents." },
	["dameff"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "+Damage Efficiency", description = "The +damage system is based on 3.5 +damage = +1dps, before crits.\nIf the spell gets this, then the efficiency will be 100%." },
	["damfinal"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Final +Damage", description = "+Damage added to the spell after the +dam coefficient." },
	["healanddamage"] = { hide = {"ROGUE", "WARRIOR", "MAGE", "SHAMAN", "HUNTER", "DRUID"}, short = "Show Heal Component", description = "If enabled spells that both damage and heal will\nhave both components listed seperately.\nNormally only the damage component will be shown." },
	["nextagi"] 	= { hide = {"MAGE", "WARLOCK", "PRIEST", "PALADIN", "SHAMAN" }, short = "Next 10 agility", description = "", descriptionmelee = "Shows how much 10 agility will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextstr"] 	= { hide = {"MAGE", "WARLOCK", "PRIEST", "PALADIN", "SHAMAN" }, short = "Next 10 strength", description = "", descriptionmelee = "Shows how much 10 strength will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextcrit"] 	= { short = "Next 1% to Crit", description = "Shows how much another 1% chance to crit will add to your *average damage*\nalong with how much +damage gear would be equivelant", descriptionmelee = "Shows how much +1% to crit will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nexthit"] 	= { short = "Next 1% to Hit", description = "Shows how much another 1% chance to hit will add to your *average damage*\nalong with how much +damage gear would be equivelant. To have it incorporate\nyour targets level you must have 'Factor Resists' turned on.", descriptionmelee = "Shows how much +1% to hit will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextpen"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Next 10 Penetration", description = "If the target has a higher resistance score then your\npenetration score, your average damage will be\nlower then what TC says. Having an extra 10 penetration\nwill increase your actual average damage closer to TC's\ncalculated value, by the amount shown.\nTC will also tell you how much extra +damage\nwould increase your actual damage by the same amount.\nIf you have Factor Resists turned on, it'll tell you exactly\nhow much damage it'll add and the equivelant +damage figure." },
	["mana"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "True Mana Cost", description = "Adds the true mana cost of your spell to the tooltip.\nIf a spell costs 30 mana, and you regenerate 40 mana\nwhilst casting it then this will be negative.\nIt is effected by things like mana regen whilst casting,\nshaman earthfury bonus, paladin's illumination talent, etc.\nAll internal calculations go off this value." },
	["dpm"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "DPM", description = "Average Damage divided by True Mana Cost" },
	["hpm"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "HPM", description = "Average Heal divided by True Mana Cost" },
	["max"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Max til oom", description = "Shows how much damage/healing you can do before going oom,\nchaincasting the spell including all normal forms of regen." },
	["maxevoc"] 	= { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN", "HUNTER" }, short = "Max til oom (gem+evoc)", description = "Same as 'Max til oom', but includes two mage abilities to regen mana." },
	["lifetap"] 	= { hide = {"ROGUE", "WARRIOR", "MAGE", "SHAMAN", "HUNTER", "DRUID", "PRIEST", "PALADIN"}, short = "Lifetap Values", description = "DPS, DPM, HPS, HPM if enabled will have\nadditional info for if you're using Lifetap.\nTakes in to account the global cooldown." },
	["buttontext"] 	= { short = "Enable Button Text", description = "TheoryCraft can show values on your Action Buttons.\nThis option will enable the feature.\n\nNote: Only supports the default Blizzard, Discord, Nurfed and Flex Action Bars, along with the Spellbook." },
	["tryfirst"] 	= { short = "Default Button Text", description = "The default value to show on your Action Buttons." },
	["trysecond"] 	= { short = "Alt Button Text", description = "If the default value is nil, TheoryCraft will\ntry to show this value." },
	["tryfirstsfg"]	= { short = "Default Significant Figures", description = "How much the text value should be rounded by.\nA value of 100 will show the number 353 as 400." },
	["trysecondsfg"]= { short = "Alt Significant Figures", description = "How much the text value should be rounded by.\nA value of 100 will show the number 353 as 400." },
	["framebyframe"]= { short = "Frame by Frame", tooltiptitle = "Force Frame by Frame", description = "Forces button text to be generated one button per frame, instead of all at once.\nNormally this is only done only in combat, as each button is virtually instant to\ngenerate.  On very slow computers you may wish to force TC to always generate\nbuttons this way, by ticking this checkbox." },
	["outfit"] 	= { short = " ", tooltiptitle = "Outfit", description = "TheoryCraft allows you to test different sets of gear.\nAny of the 8-9 piece class sets can be tested (with\nyour gear making up the other slots), or you can\nmix and match gear of your choice by selecting\nthe 'Custom' set." },
	["showsimult"] 	= { short = "Compare Mode", description = "If checked, your current stats and your outfits/talents stats\nwill be shown simulatenously on the tooltip." },
	["dontcrit"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Don't include crits", description = "If checked crits won't be included in calculated values (eg: dpm/hpm/dps).\nThis will also disable illumination, master of elements and natures grace bonuses." },
	["dontresist"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Factor resists", description = "If checked, level-based and resistance-based resists will be factored\nfor all calculated values (eg: dpm/hpm/dps).\nResists can be set below." },
	["useglock"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Use GLOCK", description = "GLOCK is an external addon that calculates Mob's resistances from combat.\nIf checked, and GLOCK is enabled, these values can be used by TheoryCraft\nto provide the most accurate statistics available for your target.\n\nWith this option enabled, the edit boxes below are regularly overwritten." },
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
-- amount		The amount to increase the value by. Valid values are:
--	"n/100" 100th of tooltip value
--	"totem" 5/2 of tooltip value (used for totem mana regen)
--	"hl"	for blessing of light, holy light +heal (read from tooltip)
--	"fol"	for blessing of light, flash of light +heal (read from tooltip)
--	any other value will add that amount to the data value
-- me			Mutually exclusive, if this tag is on an increaser then after this line has been found, no other increaser
--			with the me tag will read this line, good for things like Wizard Oil and Lesser Wizard Oil, where you don't want
--			Wizard Oil being picked up in Lesser Wizard Oil. The tag highest up gets spotted first.

-- Checks every buff for these

TheoryCraft_Buffs = {
	{ text="damage done increases by (%d+)%%", type="Damagebaseincrease", amount="n/100" },   							-- General buff in av
	{ text="Ignore (%d+) of enem.+armor", type="Sunder" },   							-- Bonereaver's Edge
	{ text="Increases Healing Wave's effect by up to (%d+)%%.", type="Healing Wavetalentmod", amount="n/100" },  	-- Healing Way
	{ text="Restores (%d+)%% of total Mana every 4 sec%.", type="FelEnergy", amount="n/100" },   			-- Fel Energy
	{ text="Magical damage dealt.-increase.-(%d+)", type="All" },   						-- Very Berry/Eye of Moam
	{ text="Magical resistances of your spell targets reduced by (%d+)", type="Allpenetration" },   		-- Eye of Moam
	{ text="Increases damage and healing done by magical spells and effects by up to (%d+)%.", type="All" },   	-- Elements/Five Thunders
	{ text="Melee attack power increased by (%d+)%.  Melee attacks are %d+%% faster, but deal less damage%.", type="AttackPowerCrusader" }, -- Seal of the crusader
	{ text="(%d+) mana regen per tick%.", type="manaperfive" },							-- Warchief's blessing
	{ text="Gain (%d+) mana every 2 seconds%.", type="manaperfive", amount="totem" },				-- Totems
	{ text="Receives up to (%d+) extra healing from Holy Light spells", type="Holy Light", amount="hl", target = "target"},	-- Blessing of light
	{ text="(%d+) extra healing from Flash of Light spells%.", type="Flash of Light", amount="fol", target = "target" },	-- Blessing of light
	{ text="Holy Shock spell increased by 100%%", type="Holycritchance", amount=100 },				-- Divine Favour
	{ text="Holy Shock spell increased by 100%%", type="Holy Shockcritchance", amount=100 },			-- Divine Favour
	{ text="Increases critical strike chance from Fire damage spells by (%d+)%%", type="Firecritchance" },		-- Combustion in 1.11
	{ text="Spell effects increased by (%d+)%.", type="All" },							-- Spell Blasting
	{ text="Mana cost of your next spell is reduced by 100%%%.", type="Holycritchance", amount=25 },		-- Inner Focus
	{ text="Increases healing done by spells and effects by up to (%d+) for %d+ sec%.", type="Healing" },		-- Blessed Prayer
	{ text="Shadow damage you deal increased by (%d+)%%%.", type="Shadowbaseincrease", amount="n/100" },		-- Shadowform
	{ text="Increases damage by (%d+)%%%.", type="Allbaseincrease", amount=0.05 },					-- Sayge's fortune
	{ text="Increases damage by (%d+)%%%.", type="Meleebaseincrease", amount=0.05 },				-- Sayge's fortune
	{ text="Fire damage increased by (%d+)%%%.", type="Firebaseincrease", amount="n/100" },				-- Burning Wish Demonic Sacrifice Imp
	{ text="Increases damage caused by (%d+)%%%.", type="Allbaseincrease", amount="n/100" },			-- Master Demonologist Succubus
	{ text="Shadow damage increased by (%d+)%%%.", type="Shadowbaseincrease", amount="n/100" },			-- Touch of Shadow Demonic Sacrifice Succubus
	{ text="Melee damage increased by (%d+)%%%.", type="Meleebaseincrease", amount="n/100" },			-- Enrage
	{ text="100%% Mana regeneration may continue while casting", type="ICPercent", amount=4 }, 			-- Innervate
	{ text="(%d+)%% of your mana regeneration to continue while", type="ICPercent", amount="n/100" },		-- Mage Armor
	{ text="schoolname spell damage increased by up to (%d+)%." },							-- Elixir of frost power
	{ text="Increases spell fire damage by up to (%d+)%.", type="Fire" },						-- Elixir of greater firepower
	{ text="Spell damage and healing done increased by (%d+)%%%.", type="Allbaseincrease", amount="n/100" },	-- Power Infusion
	{ text="Increased damage and mana cost for your spells%.", type="Damagemodifier", amount=0.35 },		-- Arcane Power
	{ text="(%d+) [mM]ana every 5 seconds%.", type="manaperfive" }, 						-- Blessing of Wisdom/Nightfin soup
	{ text="Mana Regeneration increased by (%d+) every 5 seconds%.", type="manaperfive" }, 				-- Safefish Well Fed
	{ text="Spell damage increased by .-(%d+)", type="Damage" }, 							-- Flask of Supreme Power / ZHC Damage
	{ text="spell critical chance.-(%d+)", type="Allcritchance" },							-- Moonkin Aura/Fire Festival Fury
	{ text="Magical damage and healing dealt is increased by (%d+)", type="All" },					-- ToEP
	{ text="Healing increased by up to (%d+)", type="Healing" },							-- ZHC Healing
	{ text="In addition, both the demon and master will inflict (%d+)%% more damage%.", type="Allbaseincrease", amount="n/100" },	-- Soul Link
}

TheoryCraft_Debuffs = {
	{ text="Armor decreased by (%d+)%.", type="Sunder" },   							-- Sunder Armor
	{ text="Armor decreased%.", type="DontMitigate", amount=1 },							-- Expose Armor
	{ text="Frost spells have a (%d+)%% ", type="Frostcritchance" },   						-- Winter's Chill
	{ text="All attackers gain (%d+) Ranged Attack Power against this target%.", type="huntersmark" },		-- Hunter's Mark
	{ text="Increases Shadow damage taken by (%d+)%%%.", type="Shadowbaseincrease", amount="n/100" },		-- Shadow Weaving
	{ text="Reduces Fire and Frost resistances by (%d+)%.", type="Firepenetration" },				-- Curse of the Elements
	{ text="Reduces Fire and Frost resistances by (%d+)%.", type="Frostpenetration" },				-- Curse of the Elements
	{ text="Increases Fire and Frost damage taken by (%d+)%%%.", type="Firebaseincrease", amount="n/100" },		-- Curse of the Elements
	{ text="Increases Fire and Frost damage taken by (%d+)%%%.", type="Frostbaseincrease", amount="n/100" },	-- Curse of the Elements
	{ text="Shadow and Arcane damage taken increased by (%d+)%%%.", type="Shadowbaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="Shadow and Arcane damage taken increased by (%d+)%%%.", type="Arcanebaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="Reduces Shadow and Arcane resistances by (%d+)%.", type="Shadowpenetration" },				-- Curse of Shadows
	{ text="Reduces Shadow and Arcane resistances by (%d+)%.", type="Arcanepenetration" },				-- Curse of Shadows
	{ text="Increases Holy damage taken by up to (%d+)%%.", type="Holy" },						-- Judgement of Crusader
	{ text="Frozen in place%.", type="doshatter", amount=1 },							-- Frost Nova
	{ text="Frozen%.", type="doshatter", amount=1 },								-- Freezing Band?
	{ text="Increases Fire damage taken by (%d+)%%%.", type="Firebaseincrease", amount="n/100" },			-- Improved Scorch
}

-- Dot Duration is read from here

TheoryCraft_DotDurations = {
	{ text=" over (%d+) sec", amount="n" },				-- Shadow Word: Pain, Corruption, Immolate, Renew
	{ text="every second for (%d+) sec%.", amount="n" },			-- Volley
	{ text=" seconds for (%d+) sec%.", amount="n" },			-- Tranquility
	{ text="each second for (%d+) sec%.", amount="n" },			-- Arcane Missiles
	{ text="Lasts (%d+) sec%.", amount="n" },				-- Drain and Siphon Life
	{ text="after 1 min%.", amount="60" },					-- Curse of Doom
}

-- Checks every line for these

TheoryCraft_EquipEveryRight = {
	{ text="^Speed (%d+%.?%d+)", type="OffhandSpeed", slot="SecondaryHand" },	-- Weapon Damage
	{ text="^Speed (%d+%.?%d+)", type="MainSpeed", slot="MainHand" },		-- Weapon Damage
	{ text="^Speed (%d+%.?%d+)", type="RangedSpeed", slot="Ranged" },		-- Weapon Damage
	{ text="^Dagger", type="MeleeAPMult", amount=-0.7, slot="MainHand" },		-- Weapon Damage
	{ text="^Dagger", type="DaggerEquipped", amount=1, slot="MainHand" }	,	-- Used for dagger spec
	{ text="^Fist Weapon", type="FistEquipped", amount=1, slot="MainHand" },	-- Used for fist spec
	{ text="^Axe", type="AxeEquipped", amount=1, slot="MainHand" },			-- Used for Axe Spec
	{ text="^Polearm", type="PolearmEquipped", amount=1, slot="MainHand" },		-- Used for Polearm Spec
	{ text="^Shield", type="ShieldEquipped", amount=1, slot="SecondaryHand" },	-- Used for Block
}

TheoryCraft_EquipEveryLine = {
	{ text=".+Block Value %+(%d+)", type="BlockValueReport" }, -- Block Value (ZG Enchant)
	{ text="Ranged Attack Power %+(%d+)", type="RangedAttackPowerReport" }, 	-- Hunter Leg/Helm enchant
	{ text="^(%d+) Block", type="BlockValueReport" }, 				-- Block Value (shield)

	{ text="%+(%d+) Attack Power", type="AttackPowerReport" }, 			-- Attack power

	{ text="Adds (%d+%.?%d+) damage per second", type="AmmoDPS", slot="Ammo" },	-- Arrows

	{ text="Main Hand", type="MeleeAPMult", amount="2.4", slot="MainHand" },	-- Weapon Damage
	{ text="One%-Hand", type="MeleeAPMult", amount="2.4", slot="MainHand" },	-- Weapon Damage
	{ text="Two%-Hand", type="MeleeAPMult", amount="3.3", slot="MainHand" },	-- Weapon Damage
	{ text="(%d+) %- %d+", type="RangedMin", slot="Ranged" },			-- Weapon Damage
	{ text="%d+ %- (%d+)", type="RangedMax", slot="Ranged" }, 			-- Weapon Damage
	{ text="Scope %(%+(%d+) Damage%)", type="RangedMin", slot="Ranged" },		-- Weapon Damage enchant
	{ text="Scope %(%+(%d+) Damage%)", type="RangedMax", slot="Ranged" },		-- Weapon Damage enchant
	{ text="(%d+) %- %d+", type="MeleeMin", slot="MainHand" },			-- Weapon Damage
	{ text="%d+ %- (%d+)", type="MeleeMax", slot="MainHand" }, 			-- Weapon Damage
	{ text="Weapon Damage %+(%d+)", type="MeleeMin", slot="MainHand" },		-- Weapon Damage enchant
	{ text="Weapon Damage %+(%d+)", type="MeleeMax", slot="MainHand" },		-- Weapon Damage enchant
	{ text="(%d+) %- %d+", type="OffhandMin", slot="SecondaryHand" },		-- Weapon Damage
	{ text="%d+ %- (%d+)", type="OffhandMax", slot="SecondaryHand" }, 		-- Weapon Damage
	{ text="Weapon Damage %+(%d+)", type="OffhandMin", slot="SecondaryHand" },	-- Weapon Damage enchant
	{ text="Weapon Damage %+(%d+)", type="OffhandMax", slot="SecondaryHand" },	-- Weapon Damage enchant

	{ text="%+(%d+) schoolname Spell Damage" },					-- of wrath items
	{ text="schoolname Damage +(+%d+)" },						-- AQ Glove enchants
	{ text="Healing and Spell Damage %+(%d+)", type="All", me=1 },			-- zg enchant
	{ text="%+(%d+) Healing", type="Healing" },					-- of healing items
	{ text="%+(%d+) Damage and Healing Spells", type="All" },			-- of sorcery items
	{ text="schoolname Spell Damage %+(%d+)", me=1 }, 				-- Winter's Might
	{ text="Spell Damage %+(%d+)", type="All", me=1 }, 				-- Spell Damage +30 enchant
	{ text="Healing Spells %+(%d+)", type="Healing" },				-- zg priest and healing enchant
	{ text="++(%d+) Spell Damage and Healing", type="All" }, 			-- not sure

	{ text="Use: Restores 375 to 625 mana%.", type="manarestore", amount="500" },    -- Robe of the Archmage

	{ text="Spell Hit %+(%d+)%%", type="Allhitchance" },				-- zg enchant
	{ text="%/Hit %+(%d+)%%", type="Meleehitchance" },					-- Hunter Leg/Helm enchant

	{ text="^.(%d+) mana every 5 sec%.", type="manaperfive" },			-- of restoration
	{ text="Mana Regen %+(%d+)/", type="manaperfive" },				-- zg enchant
	{ text="Mana Regen (%d+) per 5 sec%.", type="manaperfive" },			-- bracers healing enchant

	{ text="^Brilliant Mana Oil", type="manaperfive", amount="12" }, 		-- Enchanting oils
	{ text="^Brilliant Mana Oil", type="Healing", amount="25" }, 			-- Enchanting oils
	{ text="^Brilliant Wizard Oil", type="Allcritchance", amount="1" }, 		-- Enchanting oils
	{ text="^Brilliant Wizard Oil", type="Damage", amount="36" }, 			-- Enchanting oils
	{ text="^Minor Mana Oil", type="manaperfive", amount="4" }, 			-- Enchanting oils
	{ text="^Lesser Mana Oil", type="manaperfive", amount="8" }, 			-- Enchanting oils
	{ text="^Minor Wizard Oil", type="Damage", amount="8" }, 			-- Enchanting oils
	{ text="^Lesser Wizard Oil", type="Damage", amount="16" }, 			-- Enchanting oils
	{ text="^Wizard Oil", type="Damage", amount="24" }, 				-- Enchanting oils
}

-- Won't check any lines containing the following words (for speed)

TheoryCraft_IgnoreLines = {
	"^Durability", "^Soulbound", "^Classes%:", "^Requires", "^%d+ Armor", "^Head", "^Neck", "^Shoulder",
	"^Back", "^Chest", "^Wrist", "^Hands", "^Waist", "^Legs", "^Feet", "^Finger", "^Trinket",
	"^Wand", "^Held In Off%-hand", "Resistances?$", "^%+%d+ Stamina", "^%+%d+ Intellect",
	"^%+%d+ Spirit", "^%+%d+ Agility", "^%+%d+ Strength"
}

-- These are handled specially

TheoryCraft_SetsDequipOnly= {
	{ text="Mana cost of Shadow spells reduced by %d+%%%.", type="Shadowmanacost", amount=-0.15 }, 			-- Felheart 8 piece bonus
}

-- Checks every line beginning Set: for these

TheoryCraft_Sets = {
	{ text="(%d+)%% of your Mana regeneration to continue while casting", type="ICPercent", amount="n/100" }, 	     	-- Stormrage/Trans
	{ text="Your normal ranged attacks have a 4%% chance of restoring 200 mana%.", type="Beastmanarestore", amount=200 },	-- Beaststalker/Beastmaster
	{ text="Health or Mana gained from Drain Life and Drain Mana increased by 15%%%.", type="Drain Lifeillum", amount=0.15 },	-- Felheart 3 piece bonus
	{ text="10%% chance after casting Arcane Missiles, Fireball, or Frostbolt that your next spell with a casting time under 10 seconds cast instantly%.", type="FrostboltNetherwind", amount=1 },	    -- Netherwind
	{ text="10%% chance after casting Arcane Missiles, Fireball, or Frostbolt that your next spell with a casting time under 10 seconds cast instantly%.", type="FireballNetherwind", amount=1 },	    -- Netherwind
	{ text="Increases your chance of a critical hit with Prayer of Healing by (%d+)%%%.", type="Prayer of Healingcritchance" },	-- Prophecy 8 piece
	{ text="Improves your chance to get a critical strike with all Shock spells by (%d+)%%%.", type="Shockcritchance" }, 	-- Shaman Legionnaire set bonus
	{ text="Improves your chance to get a critical strike with Nature spells by (%d+)%%%.", type="Naturecritchance" }, 	-- ten storms set bonus
	{ text="After casting your Healing Wave or Lesser Healing Wave spell, gives you a 25%% chance to gain Mana equal to 35%% of the base cost of the spell%.", type="EarthfuryBonusmanacost", amount=-0.0875 },   -- earth fury set bonus
	{ text="Increases the damage of Multi%-shot and Volley by (%d+)%%%.", type="Barragemodifier", amount="n/100"},   	-- giantstalker set bonus
	{ text="Improves your chance to get a critical strike with Holy spells by (%d+)%%%.", type="Holycritchance" },		-- Prophecy
	{ text="Chance on spell cast to increase your damage and healing by up to 95 for 10 sec%.", type="All", amount=95, duration=9.9, proc=0.04, exact=1 }, 	     	-- Elements
}

-- Checks every line beginning with Equip: or Set: for these

TheoryCraft_Equips = {
	{ text="Undead by magical spells and effects by up to (%d+)%.", type="Undead" }, 	    	    	    -- Rune of the Dawn
	{ text="Increases healing done by Lesser Healing Wave by up to (%d+)%.", type="Lesser Healing Wave" }, 	    -- Totem of Life
	{ text="^(%d+) Block", type="BlockValueReport" }, 							    -- Block Value
	{ text=".+block value of your shield by (%d+)%.", type="BlockValueReport" }, 				    -- Block Value
	{ text="Improves your chance to hit by (%d+)%%%.", type="Meleehitchance" }, 				    -- Generic Hit
	{ text="Improves your chance to get a critical strike by (%d+)%%%.", type="CritReport" }, 		    -- Generic Crit
	{ text="%+(%d+) Attack Power%.", type="AttackPowerReport" }, 						    -- Attack power
	{ text="%+(%d+) ranged Attack Power%.", type="RangedAttackPowerReport" }, 				    -- Hunter's Royal seal of eldre'thalas
	{ text="Improves your chance to get a critical strike with spells by (%d+)%%%.", type="Allcritchance" },    -- Generic spell crit
	{ text="Decreases the magical resistances of your spell targets by (%d+)%.", type="Allpenetration" },	    -- Penetration
	{ text="Improves your chance to hit with spells by (%d+)%%%.", type="Allhitchance" },		    	    -- ZG drops
	{ text="Increases the critical effect chance of your Holy spells by (%d+)%%%.", type="Holycritchance" },    -- Benediction
	{ text="Increases damage and healing done by magical spells and effects by up to (%d+)%.", type="All" },    -- Standard +dam
	{ text="Increases healing done by spells and effects by up to (%d+)%.", type="Healing" },		    -- Standard +heal
	{ text="Increases damage done by schoolname spells and effects by up to (%d+)%." },			    -- Single school +dam
	{ text="Restores (%d+) mana .+ 5 sec%.", type="manaperfive" },					            -- mana per five
	{ text="Gives a chance when your harmful spells land to increase the damage of your spells and effects by 132 for 10 sec%.", type="All", amount=132, duration=9.9, proc=0.05, exact=1 },		    -- Wrath of Cenarius
	{ text="2%% chance on successful spellcast to allow 100%% of your Mana regeneration to continue while casting for 15 sec%.", type="ICPercent", amount=1, duration=15, proc=0.02, exact=0 },	    -- Darkmoon Trinket
}

TheoryCraft_WeaponSkillOther = "Unarmed"

-- Used for calcuting real crit chance, off attack skill of your current weapon.
-- English must not be translated. ltext is the text that will be to the left of the weapon type
-- Skill is what skill it matches. (eg Two-Handed Axes)

TheoryCraft_WeaponSkills = {
	{ english="Axe", text="Axe", ltext="Two-Hand", skill="Two-Handed Axes" },
	{ english="Sword", text="Sword", ltext="Two-Hand", skill="Two-Handed Swords" },
	{ english="Mace", text="Mace", ltext="Two-Hand", skill="Two-Handed Maces" },
	{ english="Staff", text="Staff", skill="Staves" },
	{ english="Axe", text="Axe", skill="Axes" },
	{ english="Sword", text="Sword", skill="Swords" },
	{ english="Mace", text="Mace", skill="Maces" },
	{ english="Polearm", text="Polearm", skill="Polearms" },
	{ english="Dagger", text="Dagger", skill="Daggers" },
	{ english="", text="Fishing Pole", skill="Fishing" },
}

-- Slot is the text that appears on the custom form, text needs to be translated. Realslot needs to stay as is.

TheoryCraft_SlotNames = {
	{ realslot="Head", slot="Head", text="Head" },
	{ realslot="Neck", slot="Neck", text="Neck" },
	{ realslot="Shoulder", slot="Shoulder", text="Shoulder" },
	{ realslot="Back", slot="Back", text="Back" },
	{ realslot="Chest", slot="Chest", text="Chest" },
	{ realslot="Shirt", slot="Shirt", text="Shirt" },
	{ realslot="Tabard", slot="Tabard", text="Tabard" },
	{ realslot="Wrist", slot="Wrist", text="Wrist" },
	{ realslot="Hands", slot="Hands", text="Hands" },
	{ realslot="Waist", slot="Waist", text="Waist" },
	{ realslot="Legs", slot="Legs", text="Legs" },
	{ realslot="Feet", slot="Feet", text="Feet" },
	{ realslot="Finger0", slot="Finger0", text="Finger" },
	{ realslot="Finger1", slot="Finger1", text="Finger" },
	{ realslot="Trinket0", slot="Trinket0", text="Trinket" },
	{ realslot="Trinket1", slot="Trinket1", text="Trinket" },
	{ realslot="MainHand", slot="Main", text="Main Hand" },
	{ realslot="MainHand", slot="Main", text="One-Hand" },
	{ realslot="MainHand", slot="Main", text="Two-Hand", both=true },
	{ realslot="SecondaryHand", slot="Off Hand", text="Held In Off-hand" },
	{ realslot="SecondaryHand", slot="Off Hand", text="One-Hand" },
	{ realslot="SecondaryHand", slot="Off Hand", text="Off Hand" },
	{ realslot="Ranged", slot="Ranged", text="Wand" },
	{ realslot="Ranged", slot="Ranged", text="Bow" },
	{ realslot="Ranged", slot="Ranged", text="Gun" },
	{ realslot="Ranged", slot="Ranged", text="Crossbow" },
	{ realslot="Ranged", slot="Ranged", text="Ranged" },
	{ realslot="Ranged", slot="Ranged", text="Thrown" },
}

--
-- From here on *DOES NOT NEED TO BE TRANSLATED*
-- 
-- In fact, TC will work just fine with none of the text below.
--
-- It does not need to be modified, and is automatically generated.
-- 
-- The purpose of this function is simply to help TC work with set bonuses even
-- when run for the very first time. Contact Aelian/Mania if you wish
-- to provide a locale of the following.
--
-- Or you can simply use TC's automatically generated file in
-- World of Warcraft\Account Name\SavedVariables\TheoryCraft.lua
--

function TheoryCraft_LoadDefaultSetData()

TheoryCraft_SetBonuses = {
	["Darkmantle Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Chance on melee attack to restore 35 energy.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+40 Attack Power.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Lawbringer Armor"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases the chance of triggering a Judgement of Light heal by 10%.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Improves your chance to get a critical strike with spells by 1%.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Improves your chance to get a critical strike by 1%.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "Gives the Paladin a chance on every melee hit to heal your party for 189 to 211.",
		},
	},
	["Lieutenant Commander's Aegis"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Improves your chance to get a critical strike by 1%.",
		},
		[2] = {
			["pieces"] = 2,
			["text"] = "+6 Intellect.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Hammer of Justice by 10 sec.",
		},
		[4] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Lightforge Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "+40 Attack Power.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Chance on melee attack to increase your damage and healing done by magical spells and effects by up to 95 for 10 sec.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["Lieutenant Commander's Battlegear"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Intercept ability by 5 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Bloodfang Armor"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases the chance to apply poisons to your target by 5%.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Improves the threat reduction of Feint by 25%.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Gives the Rogue a chance to inflict 283 to 317 damage on the target and heal the Rogue for 50 health every 1 sec. for 6 sec. on a melee hit.",
		},
	},
	["Giantstalker Armor"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases the range of your Mend Pet spell by 50% and the effect by 10%.  Also reduces the cost by 30%.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Increases your pet's stamina by 30 and all spell resistances by 40.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Increases the damage of Multi-shot and Volley by 15%.",
		},
	},
	["Stormrage Raiment"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Allows 15% of your Mana regeneration to continue while casting.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Reduces the casting time of your Regrowth spell by 0.2 sec.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Increases the duration of your Rejuvenation spell by 3 sec.",
		},
	},
	["Battlegear of Valor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "+40 Attack Power.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Chance on melee attack to heal you for 88 to 132.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["Beastmaster Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Your normal ranged attacks have a 4% chance of restoring 200 mana.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+40 Attack Power.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Champion's Pursuit"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Concussive Shot by 1 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Confessor's Raiment"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases healing done by spells and effects by up to 22.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Increase the range of your Smite and Holy Fire spells by 5 yds.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Reduces the casting time of your Mind Control spell by 0.5 sec.",
		},
	},
	["Champion's Threads"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the casting time of your Immolate spell by 0.2  sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Vestments of Prophecy"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "-0.1 sec to the casting time of your Flash Heal spell.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Improves your chance to get a critical strike with Holy spells by 2%.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Increases your chance of a critical hit with Prayer of Healing by 25%.",
		},
	},
	["Dal'Rend's Arms"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+50 Attack Power.",
		},
	},
	["Shard of the Gods"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+10 All Resistances.",
		},
	},
	["Wildheart Raiment"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "+26 Attack Power.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 15.",
		},
		[4] = {
			["pieces"] = 6,
			["text"] = "When struck in combat has a chance of returning 300 mana, 10 rage, or 40 energy to the wearer. ",
		},
		[5] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["Deathdealer's Embrace"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Reduces the cooldown of your Evasion ability by -1 min.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "15% increased damage to your Eviscerate ability.",
		},
	},
	["The Elements"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Chance on spell cast to increase your damage and healing by up to 95 for 10 sec.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["Vestments of Transcendence"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Allows 15% of your Mana regeneration to continue while casting.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "When struck in melee there is a 50% chance you will Fade for 4 sec.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Your Greater Heals now have a heal over time component equivalent to a rank 5 Renew.",
		},
	},
	["Battlegear of Wrath"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases the attack power granted by Battle Shout by 30.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "20% chance after using an offensive ability requiring rage that your next offensive ability requires 5 less rage to use.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "4% chance to parry the next attack after a block.",
		},
	},
	["Cenarion Raiment"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Damage dealt by Thorns increased by 4 and duration increased by 50%.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Improves your chance to get a critical strike with spells by 2%.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Reduces the cooldown of your Tranquility and Hurricane spells by 50%.",
		},
	},
	["Vestments of the Virtuous"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "When struck in combat has a chance of shielding the wearer in a protective shield which will absorb 350 damage.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Chain of the Scarlet Crusade"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+10 Armor.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Increased Defense +1.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "+5 Shadow Resistance.",
		},
		[4] = {
			["pieces"] = 5,
			["text"] = "+15 Attack Power when fighting Undead.",
		},
		[5] = {
			["pieces"] = 6,
			["text"] = "Improves your chance to hit by 1%.",
		},
	},
	["Demoniac's Threads"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 12.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Increases the damage of Corruption by 2%.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Decreases the cooldown of Death Coil by 15%.",
		},
	},
	["Vestments of the Devout"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "When struck in combat has a chance of shielding the wearer in a protective shield which will absorb 350 damage.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["The Postmaster"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+50 Armor.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "+10 Fire Resistance.",
		},
		[3] = {
			["pieces"] = 3,
			["text"] = "+10 Arcane Resistance.",
		},
		[4] = {
			["pieces"] = 4,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 12.",
		},
		[5] = {
			["pieces"] = 5,
			["text"] = "Increases run speed by 5%.",
		},
		[6] = {
			["pieces"] = 5,
			["text"] = "+10 Intellect.",
		},
	},
	["Ironweave Battlesuit"] = {
		[1] = {
			["pieces"] = 4,
			["text"] = "Increases your chance to resist Silence and Interrupt effects by 10%.",
		},
		[2] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Illusionist's Attire"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 12.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Decreases the mana cost of Arcane Intellect and Arcane Brilliance by 5%.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Reduces the casting time of your Flamestrike spell by 0.5 sec.",
		},
	},
	["Netherwind Regalia"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Reduces the threat generated by your Scorch,  Arcane Missiles, Fireball, and Frostbolt spells.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Increases the radius of Arcane Explosion, Flamestrike, and Blizzard by 25%.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "10% chance after casting Arcane Missiles, Fireball, or Frostbolt that your next spell with a casting time under 10 seconds cast instantly.",
		},
	},
	["Beaststalker Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "+40 Attack Power.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Your normal ranged attacks have a 4% chance of restoring 200 mana.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["Zanzil's Concentration"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Improves your chance to hit with spells by 1%.",
		},
		[2] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 6.",
		},
	},
	["Nemesis Raiment"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Your pet gains 20 stamina and 130 spell resistance against all schools of magic.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Reduces the threat generated by your Destruction spells by 20%.",
		},
	},
	["The Earthfury"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "The radius of your totems that affect friendly targets is increased by 10 yd.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "After casting your Healing Wave or Lesser Healing Wave spell, gives you a 25% chance to gain Mana equal to 35% of the base cost of the spell.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Your Healing Wave will now jump to additional nearby targets. Each jump reduces the effectiveness of the heal by 80%, and the spell will jump to up to two additional targets.",
		},
	},
	["Predator's Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+20 Attack Power.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Decreases the cooldown of Concussive Shot by 1 sec.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Increases the duration of Serpent Sting by 3 sec.",
		},
	},
	["Embrace of the Viper"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage done by Nature spells and effects by up to 7.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Increased Staves +2.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "Increases healing done by spells and effects by up to 11.",
		},
		[4] = {
			["pieces"] = 5,
			["text"] = "+10 Intellect.",
		},
	},
	["The Highlander's Purpose"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+5 Stamina.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Improves your chance to get a critical strike by 1%.",
		},
	},
	["Vindicator's Battlegear"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases your chance to block attacks with a shield by 2%.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Decreases the cooldown of Intimidating Shout by 15 sec.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Decrease the rage cost of Whirlwind by 3.",
		},
	},
	["Lieutenant Commander's Pursuit"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Concussive Shot by 1 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Emblems of Veiled Shadows"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "-10 energy cost for your Slice and Dice ability.",
		},
	},
	["Doomcaller's Attire"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "5% increased damage on your Immolate spell.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Reduces the mana cost of Shadow Bolt by 15%.",
		},
	},
	["Madcap's Outfit"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+20 Attack Power.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Decreases the cooldown of Blind by 20 sec.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Decrease the energy cost of Eviscerate and Rupture by 5.",
		},
	},
	["Necropile Raiment"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increased Defense +3.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "+5 Intellect.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "+15 All Resistances.",
		},
		[4] = {
			["pieces"] = 5,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
	},
	["version"] = "1.04 Final Beta 2",
	["Lieutenant Commander's Regalia"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Blink spell by 1.5 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Field Marshal's Pursuit"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+15 Stamina.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Reduces the cooldown of your Concussive Shot by 1 sec.",
		},
	},
	["Bloodmail Regalia"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increased Defense +3.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "+10 Attack Power.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "+15 All Resistances.",
		},
		[4] = {
			["pieces"] = 5,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
	},
	["Sorcerer's Regalia"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "When struck in combat has a chance of freezing the attacker in place for 3 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Primal Blessing"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Grants a small chance when ranged or melee damage is dealt to infuse the wielder with a blessing from the Primal Gods. Ranged and melee attack power increased by 300 for 12 seconds.",
		},
	},
	["Champion's Battlegear"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Intercept ability by 5 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Primal Batskin"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Minor increase to running and swimming speed.",
		},
	},
	["Stormshroud Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "5% chance of dealing 15 to 25 Lightning damage on a successful melee attack.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "2% chance on melee attack of restoring 30 energy.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "+14 Attack Power.",
		},
	},
	["Imperial Plate"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+100 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "+28 Attack Power.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+18 Stamina.",
		},
	},
	["Deathmist Raiment"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "When struck in combat has a chance of causing the attacker to flee in terror for 2 seconds. ",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["The Five Thunders"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Chance on spell cast to increase your damage and healing by up to 95 for 10 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Felheart Raiment"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Health or Mana gained from Drain Life and Drain Mana increased by 15%.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Your pet gains 15 stamina and 100 spell resistance against all schools of magic.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Mana cost of Shadow spells reduced by 15%.",
		},
	},
	["Defias Leather"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+10 Armor.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "+5 Arcane Resistance.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "Increased Daggers +1.",
		},
		[4] = {
			["pieces"] = 5,
			["text"] = "+10 Attack Power.",
		},
	},
	["Devilsaur Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Improves your chance to hit by 2%.",
		},
	},
	["Cadaverous Garb"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increased Defense +3.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "+10 Attack Power.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "+15 All Resistances.",
		},
		[4] = {
			["pieces"] = 5,
			["text"] = "Improves your chance to hit by 2%.",
		},
	},
	["Dragonstalker Armor"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases the Ranged Attack Power bonus of your Aspect of the Hawk by 20%.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Increases your pet's stamina by 40 and all spell resistances by 60.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "You have a chance whenever you deal ranged damage to apply an Expose Weakness effect to the target. Expose Weakness increases the Ranged Attack Power of all attackers against that target by 450 for 7 sec.",
		},
	},
	["Prayer of the Primal"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases healing done by spells and effects by up to 33.",
		},
	},
	["Field Marshal's Battlegear"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+15 Stamina.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Reduces the cooldown of your Intercept ability by 5 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
	},
	["Battlegear of Might"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases the block value of your shield by 30.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Gives you a 20% chance to generate an additional Rage point whenever damage is dealt to you.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Increases the threat generated by Sunder Armor by 15%.",
		},
	},
	["Battlegear of Heroism"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Chance on melee attack to heal you for 88 to 132.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+40 Attack Power.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Haruspex's Garb"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Restores 4 mana per 5 sec.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Increases the duration of Faerie Fire by 5 sec.",
		},
		[3] = {
			["pieces"] = 5,
			["text"] = "Increases the critical hit chance of your Starfire spell 3%.",
		},
	},
	["Champion's Regalia"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Blink spell by 1.5 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Nightslayer Armor"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Reduces the cooldown of your Vanish ability by 30 sec.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Increases your maximum Energy by 10.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Heals the rogue for 500 when Vanish is performed.",
		},
	},
	["The Highlander's Resolution"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+5 Stamina.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Improves your chance to get a critical strike by 1%.",
		},
	},
	["Dreadmist Raiment"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "When struck in combat has a chance of causing the attacker to flee in terror for 2 seconds. ",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["Arcanist Regalia"] = {
		[1] = {
			["pieces"] = 3,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 18.",
		},
		[2] = {
			["pieces"] = 5,
			["text"] = "Decreases the magical resistances of your spell targets by 10.",
		},
		[3] = {
			["pieces"] = 8,
			["text"] = "Decreases the threat generated by your spells by 15%.",
		},
	},
	["Field Marshal's Vestments"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+15 Stamina.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Reduces the cooldown of your Gouge ability by 1 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
	},
	["Ironfeather Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 20.",
		},
	},
	["Spirit of Eskhandar"] = {
		[1] = {
			["pieces"] = 4,
			["text"] = "1% chance on a critical hit to call forth the spirit of Eskhandar to protect you in battle for 2 min.",
		},
	},
	["Major Mojo Infusion"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+30 Attack Power.",
		},
	},
	["Feralheart Raiment"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+8 All Resistances.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "When struck in combat has a chance of returning 300 mana, 10 rage, or 40 energy to the wearer. ",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 15.",
		},
		[4] = {
			["pieces"] = 6,
			["text"] = "+26 Attack Power.",
		},
		[5] = {
			["pieces"] = 8,
			["text"] = "+200 Armor.",
		},
	},
	["Champion's Raiment"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Increases the duration of your Psychic Scream spell by 1 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Magister's Regalia"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Increases damage and healing done by magical spells and effects by up to 23.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "When struck in combat has a chance of freezing the attacker in place for 3 sec.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
	["Lieutenant Commander's Vestments"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Increases your chance to parry an attack by 1%.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "Reduces the cooldown of your Gouge ability by 1 sec.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "+15 Stamina.",
		},
	},
	["Black Dragon Mail"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "Improves your chance to hit by 1%.",
		},
		[2] = {
			["pieces"] = 3,
			["text"] = "Improves your chance to get a critical strike by 2%.",
		},
		[3] = {
			["pieces"] = 4,
			["text"] = "+10 Fire Resistance.",
		},
	},
	["Shadowcraft Armor"] = {
		[1] = {
			["pieces"] = 2,
			["text"] = "+200 Armor.",
		},
		[2] = {
			["pieces"] = 4,
			["text"] = "+40 Attack Power.",
		},
		[3] = {
			["pieces"] = 6,
			["text"] = "Chance on melee attack to restore 35 energy.",
		},
		[4] = {
			["pieces"] = 8,
			["text"] = "+8 All Resistances.",
		},
	},
}

end

end