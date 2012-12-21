--[[		AimedShot = "augmente les d\195\169g\195\162s \195\160 distance de %d+.",
		ScatterShot = "deals 50%% weapon damage",
		Ghostly = "inflige %d+%% des d\195\169g\195\162s de l'arme",
		Backstab = "infligez %d+%% des d\195\169g\195\162s de l'arme plus %d+",
		Claw = "causing %d+ additional damage",
		Claw2 = "causing %d+ to %d+ additional damage",
		Mortal = "les points de d\195\169g\195\162s de l'arme plus %d+",
	-- Aimed Shot becomes hits for (mindamage) to (maxdamage) damage
		hitsfor = "touche la cible et inflige ",
	-- backstab becomes deals (mindamage) to (maxdamage) damage
		deals = "inflige ",
	-- would probably never happen - but it says dealing (mindamage) damage, in the case mindamage = maxdamage
		dealing = "infligeant ",
	-- ambush becomes causing (mindamage) to (maxdamage) damage
		causing = "infligez ",
		shred = "causing %d+%% damage plus %d+",
	-- the part of the description that contains the +damage, eg from shred above plus %d+
		plus = "plus %d+",
		whirlwind = "d\195\169g\195\162s de l'arme \195\160",
		damageto = " damage to ",
		Sinister = "%d+ points de d\195\169g\195\162s en plus des d\195\169g\195\162s normaux de votre arme.",]]--


if (GetLocale() == "frFR") then

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
	hitorhealhit = "coup",
	hitorhealheal = "soin",
	damorhealdam = "+degats",
	damorhealheal = "+soins",
	damorapap = "puissance d'attaque",
	damorapdam = "+degats",
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
	{show = "embedstyle2", 	left = "#c0.9,0.9,1##OR$dpm$#c1,1,1# Dpm/$hpm$#c1,1,1# HpmOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# to crit"},
	{show = "embedstyle3", 	left = "#c0.9,0.9,1##OR$dps$#c1,1,1# Dps/$hpm$#c1,1,1# HpmOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# to crit"},
	{show = true, 		left = "#c1,1,1#$basecasttime$", right = "#c1,1,1#$cooldown$"},
	{show = true, 		left = "#c1,1,1#$cooldownremaining$",},
	{show = "embed", 	left = "#c1,0.82745098,0##OR$description$/$basedescription$OR##WRAP#"},
	{show = "embed", inverse = true, left = "#c1,0.82745098,0#$basedescription$#WRAP#"},
	{show = true, 		left = "#c1,0.5,1#$outfitname$"},
	{show = true, 		left = "Restores $evocation$ mana."},
	{show = true, 		left = "Sans sceau : $sealunbuffed$"},
	{show = true, 		left = "Avec ce sceau : $sealbuffed$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Statistiques des Soins#"},
	{show = "embed", inverse = true, left = "Soins : $healrange$"},
	{show = "critwithdam", 	left = "Critiques : $crithealchance$% (for $crithealrange$)"},
	{show = "critwithoutdam", left = "Critiques : $crithealchance$%"},
	{show = "hps", 		left = "HPS: $hps$#IF, $withhothps$IF#"},
	{show = "dpsdam", 	left = "HPS grace aux +soins : $hpsdam$ ($hpsdampercent$%)"},
	{show = "averagedamnocrit", left = "Soins moyens : $averagehealnocrit$"},
	{show = "averagedamnocrit", left = "Ticks : $averagehealtick$"},
	{show = "averagedam", 	left = "Soins moyens : $averageheal$"},
	{show = "averagedam", 	left = "Ticks : $averagehealtick$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Statistiques des Degats#"},
	{show = "embed", inverse = true, left = "Degats : $dmgrange$"},
	{show = "critmelee", 	left = "Critiques : $critdmgchance$% (for $critdmgrange$)"},
	{show = "critwithdam", 	left = "Critiques : $critdmgchance$% (for $critdmgrange$)"},
	{show = "sepignite", 	left = "Avec Enflammer : $igniterange$"},
	{show = "critwithoutdam", left = "Critiques : $critdmgchance$%"},
	{show = "dps", 		left = "DPS : $dps$#IF, $withdotdps$IF#"},
	{show = "dpsdam", 	left = "DPS grace aux +degats : $dpsdam$ ($dpsdampercent$%)"},
	{show = "averagedamnocrit", left = "Degats moyens : $averagedamnocrit$"},
	{show = "averagedamnocrit", left = "Ticks : $averagedamtick$"},
	{show = "averagedam", 	left = "Degats moyens : $averagedam$"},
	{show = "averagedam", 	left = "Ticks : $averagedamtick$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Multiplicateurs:#"},
	{show = "plusdam", 	left = "Base $damorheal$: $plusdam$"},
	{show = "damcoef", 	left = "Coefficient $damorheal$ : $damcoef$%"},
	{show = "dameff", 	left = "Efficacite $damorheal$ : $dameff$%"},
	{show = "damfinal", 	left = "Final $damorheal$: $damfinal$#IF, $damfinal2$IF#"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Resistances :#"},
	{show = "resists", 	left = "Au maximum : $penetration$ DPS Penetres"},
	{show = "resists", 	left = "Chances de Resist ($resistlevel$) : $resistrate$%"},
	{show = "resists", 	left = "DPS apres Resistances : $dpsafterresists$ DPS"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Comparaisons:#"},
	{show = "nextcrit", 	left = "1% crit: +$nextcritheal$ $hitorheal$ moyen (soit : $nextcrithealequive$ +heal)"},
	{show = "nextstr", 	left = "10 str: +$nextstrdam,2$ average $hitorheal$ (Eq: $nextstrdamequive,2$ $damorap$)"},
	{show = "nextagi", 	left = "10 agi: +$nextagidam$ $hitorheal$ moyen (soit : $nextagidamequive$ $damorap$)"},
	{show = "nextcrit", 	left = "1% crit : +$nextcritdam$ $hitorheal$ moyen (soit : $nextcritdamequive$ $damorap$)"},
	{show = "nexthit", 	left = "1% toucher : +$nexthitdam$ $hitorheal$ moyen (soit : $nexthitdamequive$ $damorap$)"},
	{show = "nextpen", 	left = "10 pen: Up to +$nextpendam$ $hitorheal$ moyen (soit : $nextpendamequive$ $damorap$)"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Rotations:#"},
	{show = true, 		left = "MS rot ($msrotationlength,1$ sec) dps: $msrotationdps,1$"},
	{show = true, 		left = "AS rot ($asrotationlength,1$ sec) dps: $asrotationdps,1$"},
	{show = true, 		left = "MS/Arcane rot dps: $arcrotationdps,1$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Comparisons combinees:#"},
	{show = "nextagi", 	left = "10 agi: +$nextagidps$ dps (soit : $nextagidpsequive$ $damorap$)"},
	{show = "nextcrit", 	left = "1% crit: +$nextcritdps$ dps $hitorheal$ (soit : $nextcritdpsequive$ $damorap$)"},
	{show = "nexthit", 	left = "1% toucher: +$nexthitdps$ dps $hitorheal$ (soit : $nexthitdpsequive$ $damorap$)"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Efficacite:#"},
	{show = "mana", 	left = "Cout reel en Mana : $manacost$"},
	{show = "dpm", 		left = "DPM: $dpm$#IF, $withdotdpm$IF#"},
	{show = "dpm", 		left = "SPM: $hpm$#IF, $withhothpm$IF#"},
	{show = "lifetap", 	left = "Lifetap DPH: $lifetapdpm$"},
	{show = "lifetap", 	left = "Lifetap HPH: $lifetaphpm$"},
	{show = "lifetap", 	left = "Lifetap DPS: $lifetapdps$"},
	{show = "lifetap", 	left = "Lifetap HPS: $lifetaphps$"},
	{show = "showregenheal", left = "10 secondes de regen normale : $regenheal$ healing"},
	{show = "showregenheal", left = "10 secondes pendant incantation : +$icregenheal$ healing"},
	{show = "showregendam", left = "10 secondes de regen normale : $regendam$ damage"},
	{show = "showregendam", left = "10 secondes pendant incantation : +$icregendam$ damage"},
	{show = "max", 		left = "Soins totaux : $maxoomheal$"},
	{show = "maxtime", 	left = "Soins totaux : $maxoomheal$ ($maxoomhealtime$ secs)"},
	{show = "max", 		left = "Degats totaux : $maxoomdam$"},
	{show = "maxtime", 	left = "Degats totaux : $maxoomdam$ ($maxoomdamtime$ secs)"},
	{show = "maxevoc", 	left = "Degats totaux avec evoc + gemme : $maxevocoomdam$"},
	{show = "maxevoctime", 	left = "Degats totaux avec evoc + gemme : $maxevocoomdam$ ($maxevocoomdamtime$ secs)"},
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
	  replacewith = "and doing $damage$ to them" },
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

	{ pattern = "(%d+) \195\160 (%d+)(.+)puis (%d+) \195\160 (%d+)",						-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+) \195\160 (%d+)(.+)puis (%d+)",							-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },

	{ pattern = "(%d+) \195\160 (%d+)(.+)et (%d+) \195\160 (%d+)",					-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+) \195\160 (%d+)(.+)et (%d+)",						-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },

	{ pattern = "(%d+) \195\160 (%d+)(.+) et (%d+) \195\160 (%d+)",						-- Flame Shock
		type={"mindamage", "maxdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(%d+) \195\160 (%d+)(.+) et (%d+)",							-- Flame Shock
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "inflige (%d+)(.+) et (%d+) \195\160 (%d+)",						-- Flame Shock
		type={"bothdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "inflige (%d+)(.+) et (%d+)",							-- Flame Shock
		type={"bothdamage", "tmptext", "dotbothdamage"} },

	{ pattern = "(%d+) to (%d+) Fire damage.",							-- Magma totem
		type={"mindamage", "maxdamage"} },
	{ pattern = "(%d+) Fire damage.",								-- Magma totem
		type={"bothdamage"} },

	{ pattern = "yards for (%d+) to (%d+) every ",							-- Healing Stream totem
		type={"mindamage", "maxdamage"} },
	{ pattern = "yards for (%d+) every ",								-- Healing Stream totem
		type={"bothdamage"} },

	{ pattern = "(%d+) \195\160 (%d+)",									-- Generic Normal spell
		type={"mindamage", "maxdamage"} },
	{ pattern = "(%d+)",										-- Generic no damage range spell
		type={"bothdamage"} },
}

TheoryCraft_Dequips = {
	{ type = "all", text="Toutes les caract\195\169ristiques %+(%d+)" },
	{ type = "formattackpower", text="%+(%d+) Attack Power in Cat, Bear" },
	{ type = "attackpower", text="%+(%d+) Puissance d'attaque" },
	{ type = "attackpower", text="%+(%d+) \195\160 la puissance d'attaque" },
	{ type = "rangedattackpower", text="%+(%d+) Puissance d'attaque" },
	{ type = "rangedattackpower", text="%+(%d+) \195\160 la puissance d'attaque" },
	{ type = "rangedattackpower", text="%+(%d+) \195\160 la puissance des attaques \195\160 distance" },
	{ type = "strength", text="%+(%d+) Force" },
	{ type = "strength", text="Force %+(%d+)" },
	{ type = "agility", text="%+(%d+) Agilit\195\169" },
	{ type = "agility", text="Agilit\195\169 %+(%d+)" },
	{ type = "stamina", text="%+(%d+) Endurance" },
	{ type = "stamina", text="Endurance %+(%d+)" },
	{ type = "intellect", text="%+(%d+) Intelligence" },
	{ type = "intellect", text="Intelligence %+(%d+)" },
	{ type = "spirit", text="%+(%d+) Esprit" },
	{ type = "spirit", text="Esprit %+(%d+)" },
	{ type = "totalhealth", text="Points de vie %+(%d+)" },
	{ type = "totalhealth", text="Vie %+(%d+)" },
	{ type = "meleecritchance", text="Augmente vos chances d'infliger un coup critique de (%d+)%%%." },
}

TheoryCraft_Locale = {
	HitMessage	= "Your (.+) hits (.+) for (%d+)%.",
	CritMessage	= "Your (.+) crits (.+) for (%d+)%.",
	Absorbed	= "(.+) absorb\195\169s",
	ID_Beast	= "B\195\170te",
	ID_Humanoid	= "Humano\195\175de",
	ID_Giant	= "G\195\169ant",
	ID_Dragonkin	= "Draconien",
	ID_Equip	= "Equip\195\169 : ",
	ID_Set		= "Complet : ",
	ID_Use		= "Use: ",
	to		= " \195\160 ",
	Attack		= "Attaque",
	InstantCast	= "Instant cast",
	SecCast		= " sec d'incantation",
	Mana		= "Mana : ",
	Cooldown	= " sec de recharge",
	CooldownRem	= "Cooldown remaining: ",
	Set		= "(%d+/%d+)",
	LoadText	= "TheoryCraft "..TheoryCraft_Version.." by Aelian. Type /tc for commands",
	lifetap		= "Life Tap",
	MinMax  = {
		autoshotbefore = "Shoots the target for ",
		autoshotafter = ".",
		shooterror = "No wand equipped.",
		crusader = "granting %d+ attack power",
	},
	SpellTranslator = {
		["Frostbolt"] = "Eclair de givre",
		["Frost Nova"] = "Nova de givre",
		["Cone of Cold"] = "C\195\180ne de froid",
		["Blizzard"] = "Blizzard",
		["Arcane Explosion"] = "Explosion des arcanes",
		["Arcane Missiles"] = "Projectiles des arcanes",
		["Fire Blast"] = "Trait de feu",
		["Fireball"] = "Boule de feu",
		["Pyroblast"] = "Explosion pyrotechnique",
		["Scorch"] = "Br\195\187lure",
		["Blast Wave"] = "Vague explosive",
		["Flamestrike"] = "Choc de flammes",
		["Ice Barrier"] = "Ice Barrier",
		["Evocation"] = "Evocation",

		["Shadow Bolt"] = "Trait de l'ombre",
		["Soul Fire"] = "Feu de l'\195\162me",
		["Searing Pain"] = "Douleur br\195\187lante",
		["Immolate"] = "Immolation",
		["Firebolt"] = "Firebolt",
		["Lash of Pain"] = "Lash of Pain",
		["Conflagrate"] = "Conflagration",
		["Rain of Fire"] = "Pluie de feu",
		["Hellfire"] = "Flammes infernales",
		["Corruption"] = "Corruption",
		["Curse of Agony"] = "Mal\195\169diction d'agonie",
		["Curse of Doom"] = "Mal\195\169diction funeste",
		["Drain Soul"] = "Siphon d'\195\162me",
		["Siphon Life"] = "Siphon de vie",
		["Drain Life"] = "Drain de vie",
		["Death Coil"] = "Voile mortel",
		["Shadowburn"] = "Br\195\187lure de l'ombre",

		["Prayer of Healing"] = "Pri\195\168re de soins",
		["Shadow Word: Pain"] = "Mot de l'ombre : Douleur",
		["Mind Flay"] = "Fouet mental",
		["Mind Blast"] = "Attaque mentale",
		["Smite"] = "Ch\195\162timent",
		["Holy Fire"] = "Flammes sacr\195\169es",
		["Holy Nova"] = "Nova sacr\195\169e",
		["Power Word: Shield"] = "Mot de pouvoir : Bouclier",
		["Desperate Prayer"] = "Pri\195\168re du d\195\169sespoir",
		["Lesser Heal"] = "Soins inf\195\169rieurs",
		["Heal"] = "Soins",
		["Flash Heal"] = "Soins rapides",
		["Greater Heal"] = "Soins sup\195\169rieurs",
		["Devouring Plague"] = "Peste d\195\169vorante",
		["Renew"] = "R\195\169novation",
		["Starshards"] = "Eclats stellaires",

		["Healing Touch"] = "Toucher gu\195\169risseur",
		["Tranquility"] = "Tranquilit\195\169",
		["Rejuvenation"] = "Recup\195\169ration",
		["Regrowth"] = "R\195\169tablissement",
		["Starfire"] = "Feu stellaire",
		["Wrath"] = "Col\195\168re",
		["Insect Swarm"] = "Essaim d'insectes",
		["Entangling Roots"] = "Sarments",
		["Moonfire"] = "Eclat lunaire",
		["Hurricane"] = "Ouragan",
		["Ravage"] = "Ravager",
		["Shred"] = "Griffure",
		["Claw"] = "Griffe",
		["Maul"] = "Maul",
		["Ferocious Bite"] = "Ferocious Bite",
		["Swipe"] = "Swipe",

		["Bloodthirst"] = "Bloodthirst",
		["Mortal Strike"] = "Frappe mortelle",
		["Overpower"] = "Overpower",
		["Whirlwind"] = "Whirlwind",
		["Heroic Strike"] = "Heroic Strike",
		["Cleave"] = "Cleave",
		["Block"] = "Block",
		["Thunder Clap"] = "Thunder Clap",
		["Mocking Blow"] = "Mocking Blow",
		["Shield Slam"] = "Shield Slam",

		["Sinister Strike"] = "Attaque pernicieuse",
		["Hemorrhage"] = "Hemorrhage",
		["Backstab"] = "Attaque sournoise",
		["Ghostly Strike"] = "Attaque fantomatique",
		["Ambush"] = "Embuscade",
		["Riposte"] = "Riposte",
		["Eviscerate"] = "Eviscerate",

		["Flash of Light"] = "Eclair lumineux",
		["Holy Light"] = "Lumi\195\168re sacr\195\169e",
		["Exorcism"] = "Exorcisme",
		["Holy Wrath"] = "Col\195\168re divine",
		["Consecration"] = "Cons\195\169cration",
		["Hammer of Wrath"] = "Marteau de courroux",
		["Seal of the Crusader"] = "Sceau du crois\195\169",
		["Seal of Command"] = "Sceau d'autorit\195\169",
		["Seal of Righteousness"] = "Sceau de pi\195\169t\195\169",
		["Holy Shock"] = "Horion sacr\195\169",

		["Chain Lightning"] = "Cha\195\174ne d'\195\169clairs",
		["Lightning Bolt"] = "Eclair",
		["Lightning Shield"] = "Lightning Shield",
		["Lesser Healing Wave"] = "Vague de soins mineurs",
		["Healing Wave"] = "Vague de soins",
		["Chain Heal"] = "Salve de gu\195\169rison",
		["Earth Shock"] = "Horion de terre",
		["Flame Shock"] = "Horion de feu",
		["Frost Shock"] = "Horion de givre",
		["Magma Totem"] = "Magma Totem",
		["Searing Totem"] = "Searing Totem",
		["Healing Stream Totem"] = "Healing Stream Totem",

		["Arcane Shot"] = "Tir des arcanes",
		["Serpent Sting"] = "Morsure de serpent",
		["Mend Pet"] = "Mend Pet",
		["Multi-Shot"] = "Fl\195\168ches multiples",
		["Volley"] = "Salve",
		["Aimed Shot"] = "Vis\195\169e",
		["Scatter Shot"] = "Scatter Shot",
		["Raptor Strike"] = "Raptor Strike",
		["Auto Shot"] = "Tir automatique",

		["Attack"] = "Attack",
		["Shoot"] = "Tir",
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
		{ id="twohandspec", translated="Twohand Spec" },
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
	["titles"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Titles", description = "Seperates the tooltip extended info in to seperate categories." },
	["embed"] = 	{ short = "Embed", description = "Modifies the base description of your spell tooltips,\nto include the effects of gear.", descriptionmelee = "Modifies the base description of your ability tooltips\nto replace terms like 'weapon damage plus 160'\n with actual damage done." },
	["crit"] = 	{ short = "Crit", description = "Adds your crit rate to your spell tooltips.\nIncludes talents, gear and base crit rate (int/$cr).", descriptionmelee = "Adds your crit damage and crit chance to your ability tooltips." },
	["critdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Crit Damage", description = "Shows the damage range of your critical strikes" },
	["rollignites"]={ hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN" }, short = "Rolling Ignites", description = "All calculations that include critical strikes\nwill factor in rolling ignites. That is where\nignite procs whilst ignite is already on the target,\nresetting the timer but adding to the damage." },
	["sepignite"] = { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN" }, short = "Seperate Ignite", description = "Seperates the ignite component from your crit damage." },
	["dps"] = 	{ short = "DPS", description = "Adds Damage per Second cast time to\nyour tooltips. For instant casts,\ncast time is taken as the length of\nthe global cooldown, 1.5 seconds.", descriptionmelee = "How much this ability increases your dps by, if you use it each time the timer is up." },
	["combinedot"]= { hide = {"ROGUE", "WARRIOR"}, short = "Combine DoT", description = "If enabled, spells that have both a \ndirect component and an over time component will have\nthe DoT DPS expressed as (DPS+DoT)/Casttime\n rather then DoT/Duration." },
	["dotoverct"] = { hide = {"ROGUE", "WARRIOR"}, short = "DoT over CT", description = "DoTs will have their DPS as Total Damage / Cast time, \nrather then Total Damage / DoT Duration" },
	["hps"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "HPS", description = "Is calculated the same way as DPS,\nwith the same extended options." },
	["dpsdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "DPS from +dam", description = "How much of your DPS/HPS is from your +damage gear." },
	["averagedam"] ={short = "Average Hit", description = "Adds the spells average hit to your tooltips.", descriptionmelee = "Adds your average damage to your ability tooltips." },
	["averagedamnocrit"] = {short = "Dont include crits", description = "If checked crits won't be included in the Average Hit value." },
	["procs"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Include Procs", description = "All Proc based effects (Wrath of Cenarius, Darkmoon Trinket, Netherwind)\neffects are averaged instead of only being applied while the buff is active." },
	["plusdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Damage", description = "+Damage for that spell, before being multiplied by the +dam coefficient" },
	["damcoef"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Damage Coefficient", description = "+Damage coefficient for that spell.\nWill be modified by applicable talents." },
	["dameff"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Damage Efficiency", description = "The +damage system is based on 3.5 +damage = +1dps, before crits.\nIf the spell gets this, then the efficiency will be 100%." },
	["damfinal"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Final +Damage", description = "+Damage added to the spell after the +dam coefficient." },
	["averagethreat"] = { hide = {"ROGUE", "WARRIOR", "SHAMAN", "HUNTER", "DRUID", "WARLOCK", "PRIEST"}, short = "Average Threat", description = "The average threat caused by the attack." },
	["healanddamage"] = { hide = {"ROGUE", "WARRIOR", "MAGE", "SHAMAN", "HUNTER", "DRUID"}, short = "Show Heal Component", description = "If enabled spells that both damage and heal will\nhave both components listed seperately.\nNormally only the damage component will be shown." },
	["resists"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Resists", description = "Adds a resists category to the tooltip.\nThis includes the resist rate of your *target* and\nyour dps after level-based resists are accounted for.\nIf you have any Spell Penetration gear it'll also\ntell you how much dps your penetration gear adds.\nNote that unless your target has a resist score equal to\nor higher then your penetration score, this dps\npenetrated won't be achieved." },
	["nextstr"] = 	{ hide = {"MAGE", "WARLOCK", "PRIEST", "PALADIN", "SHAMAN" }, short = "Next 10 strength", description = "", descriptionmelee = "Shows how much 10 strength will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextagi"] = 	{ hide = {"MAGE", "WARLOCK", "PRIEST", "PALADIN", "SHAMAN" }, short = "Next 10 agility", description = "", descriptionmelee = "Shows how much 10 agility will add to your average damage (including crits), and how much attack power would be needed to achieve the same increase." },
	["nextcrit"] = 	{ short = "Next 1% to Crit", description = "Shows how much another 1% chance to crit will add to your *average damage*\nalong with how much +damage gear would be equivelant", descriptionmelee = "Shows how much +1% to crit will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nexthit"] = 	{ short = "Next 1% to Hit", description = "Shows how much another 1% chance to hit will add to your *average damage*\nalong with how much +damage gear would be equivelant.", descriptionmelee = "Shows how much +1% to hit will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextpen"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Next 10 Penetration", description = "Shows how much 10 penetration would add to your *average damage*\nalong with how much +damage gear would be equivelant.\nIt assumes that your target has an extra\n10 resistance score to be penetrated." },
	["mana"] =	{ hide = {"ROGUE", "WARRIOR"}, short = "True Mana Cost", description = "Adds the true mana cost of your spell to the tooltip.\nIf a spell costs 30 mana, and you regenerate 40 mana\nwhilst casting it then this will be negative.\nIt is effected by things like mana regen whilst casting,\nshaman earthfury bonus, paladin's illumination talent, etc.\nAll internal calculations go off this value." },
	["dpm"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "DPM", description = "Average Damage divided by True Mana Cost" },
	["dontcritdpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "Dont include crits", description = "If checked crits won't be included in the DPM value." },
	["hpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "HPM", description = "Average Heal divided by True Mana Cost" },
	["dontcrithpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "Dont include crits", description = "If checked crits won't be included in the HPM value." },
	["showregendam"] = { hide = {"ROGUE", "WARRIOR"}, short = "Regen Damage", description = "Shows how much extra damage you could do\ngiven 10 seconds of normal regen, compared to\n10 seconds of regen whilst casting" },
	["showregenheal"] = { hide = {"ROGUE", "WARRIOR"}, short = "Regen Healing", description = "Shows how much extra healing you could do\ngiven 10 seconds of normal regen, compared to\n10 seconds of regen whilst casting" },
	["max"] = { hide = {"ROGUE", "WARRIOR"}, short = "Max til oom", description = "Shows how much damage/healing you can do before going oom,\nchaincasting the spell including all normal forms of regen and\ncritical strikes, but not including resists." },
	["maxevoc"] 	= { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN" }, short = "Max til oom inc gem+evoc", description = "Same as 'Max til oom', but includes two mage abilities to regen mana." },
	["maxtime"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Time taken to go oom", description = "Adds how long it takes to go oom, chain casting that spell." },
	["lifetap"] 	= { hide = {"ROGUE", "WARRIOR", "MAGE", "SHAMAN", "HUNTER", "DRUID", "PRIEST"}, short = "Lifetap Values", description = "DPS, DPM, HPS, HPM if enabled will have/nan additional for if you're using Lifetap./nTakes in to account the global cooldown time needed/nto cast Lifetap." },
	["embedstyle1"]	= { short = "DPS | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPS/HPS on the left and Crit chance on the right.", descriptionmelee="For melee, will only show your crit chance above\nthe description of each ability." },
	["embedstyle2"]	= { hide = {"ROGUE", "WARRIOR"}, short = "DPM | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPM/HPM on the left and Crit chance on the right." },
	["embedstyle3"]	= { hide = {"ROGUE", "WARRIOR"}, short = "DPS/HPM | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPS/HPM on the left and Crit chance on the right." },
	["buttontext"] 	= { short = "Enable Button Text", description = "TheoryCraft can show values on your Action Buttons.\nThis option will enable the feature.\n\nNote: Only supports the default Blizzard Action Bars and Spellbook." },
	["tryfirst"] 	= { short = "Default Button Text", description = "The default value to show on your Action Buttons." },
	["trysecond"] 	= { short = "Alt Button Text", description = "If the default value is nil, TheoryCraft will\ntry to show this value." },
	["tryfirstlarge"] = { short = " ", tooltiptitle = "Large Text", description = "Centers the text and makes it much larger.\nMostly useful if you limit button text to a select\nnumber of spells, eg low rank heals." },
	["tryfirstsfg"]	= { short = "Default Significant Figures", description = "How much the text value should be rounded by.\nA value of 100 will show the number 353 as 400." },
	["trysecondsfg"]= { short = "Alt Significant Figures", description = "How much the text value should be rounded by.\nA value of 100 will show the number 353 as 400." },
	["trysecondlarge"] = { short = " ", tooltiptitle = "Large Text", description = "Centers the text and makes it much larger.\nMostly useful if you limit button text to a select\nnumber of spells, eg low rank heals." },
	["framebyframe"] = { short = "Frame by Frame", tooltiptitle = "Force Frame by Frame", description = "Forces button text to be generated one button per frame, instead of all at once.\nNormally this is only done only in combat, as each button is virtually instant to\ngenerate.  On very slow computers you may wish to force TC to always generate\nbuttons this way, by ticking this checkbox." },
	["outfit"] = { short = " ", tooltiptitle = "Outfit", description = "TheoryCraft allows you to test different sets of gear.\nAny of the 8-9 piece class sets can be tested (with\nyour gear making up the other slots), or you can\nmix and match gear of your choice by selecting\nthe 'Custom' set." },
	["mitigation"] = { short = "Enable Mitigation", description = "If enabled your targets armor will be included in TC's calculations.\nYou can view a mobs armor by typing in /tc armor 'mob name', or\njust leaving it blank to list all known mobs." },
	["showsimult"] = { short = "Compare Mode", description = "If checked, your current stats and your outfits/talents stats\nwill be shown simulatenously on the tooltip." },
	["dontcrit"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Don't include crits", description = "If checked crits won't be included in calculated values (eg: dpm/hpm/dps).\nThis will also disable illumination, master of elements and natures grace bonuses." },
	["dontresist"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Factor resists", description = "If checked, level-based and resistance-based resists will be factored\nfor all calculated values (eg: dpm/hpm/dps).\nResists can be set below." },
	["useglock"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Use GLOCK", description = "GLOCK is an external addon that calculates Mob's resistances from combat.\nIf checked, and GLOCK is enabled, these values can be used by TheoryCraft\nto provide the most accurate statistics available for your target.\n\nWith this option enabled, the edit boxes below are regularly overwritten." },
}

-- Used for schoolname in the buffs/equips.  Wherever schoolname appears, it'll try each "text" value,
-- and the amount will be added to the "name" value.  "text" should be localised, "name" should not.

TheoryCraft_PrimarySchools = {
	{ name = "Frost", text = "givre" },
	{ name = "Nature", text = "nature" },
	{ name = "Fire", text = "feu" },
	{ name = "Arcane", text = "arcane" },
	{ name = "Shadow", text = "ombre" },
	{ name = "Holy", text = "sacr\195\169" },
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
	{ text="Ignore (%d+) of enem.+armor", type="Sunder" },   							-- Bonereaver's Edge
	{ text="Increases Healing Wave's effect by up to (%d+)%%.", type="Healing Wavetalentmod", amount="n/100" },  	-- Healing Way
	{ text="In addition, both the demon and master will inflict (%d+)%% more damage%.", type="Allbaseincrease", amount="n/100" },	-- Soul Link
	{ text="Restores (%d+)%% of total Mana every 4 sec%.", type="FelEnergy", amount="n/100" },   			-- Fel Energy
	{ text="Increases damage and healing done by magical spells and effects by up to (%d+)%.", type="All" },   	-- Elements/Five Thunders
	{ text="Attack power increased by (%d+).  Melee attacks are %d+%% faster, but deal less damage.", type="AttackPowerCrusader" }, -- Seal of the crusader
	{ text="(%d+) mana regen per tick%.", type="manaperfive" },							-- Warchief's blessing
	{ text="Gain (%d+) mana every 2 seconds%.", type="manaperfive", amount="totem" },				-- Totems
	{ text="Les sorts de Lumi\195\168re sacr\195\160e rendent jusqu'\195\169 (%d+) points de vie suppl\195\169mentaires", type="Holy Light", amount="hl", target = "target"},	-- Blessing of light
	{ text="les sorts d'Eclair lumineux jusqu'\195\160 (%d+).", type="Flash of Light", amount="fol", target = "target" },	-- Blessing of light
	{ text="Les chances de voir les sorts Eclair lumineux ou Lumi\195\168re sacr\195\169e avoir un effet critique sont augment\195\169es de 100%%.", type="Healingcritchance", amount="100" },		-- Divine Favour
	{ text="Les chances de voir les sorts Eclair lumineux ou Lumi\195\168re sacr\195\169e avoir un effet critique sont augment\195\169es de 100%%.", type="Holy Shockcritchance", amount=100 },		-- Divine Favour
	{ text="Votre prochain sort de feu infligera automatiquement un coup critique.", type="Firecritchance", amount="100" },	-- Combustion
	{ text="Augmente de (%d+)%% les chances de coup critique des sorts de d\195\169g\195\162ts de Feu.", type="Firecritchance" },		-- Combustion in 1.11
	{ text="Effets des sorts augment\195\169s de (%d+).", type="All" },				-- Spell Blasting
	{ text="Mana cost of your next spell is reduced by 100%%.", type="Holycritchance", amount="25" },	-- Inner Focus
	{ text="Increases healing done by spells and effects by up to (%d+) for %d+ sec.", type="Healing" },	-- Blessed Prayer
	{ text="Augmente de (%d+)%% les d\195\169g\195\162ts d'Ombre que vous infligez", type="Shadowbaseincrease", amount="n/100" },	-- Shadowform
	{ text="Augmente les d\195\169g\195\162ts de (%d+)%%.", type="Allbaseincrease", amount="0.05" },				-- Sayge's fortune
	{ text="Augmente les d\195\169g\195\162ts de (%d+)%%.", type="Meleebaseincrease", amount="0.05" },				-- Sayge's fortune
	{ text="D\195\169g\195\162ts de feu augment\195\169s de (%d+)%%.", type="Firebaseincrease", amount="n/100"},			-- Burning Wish Demonic Sacrifice Imp
	{ text="Augmente les d\195\169g\195\162ts inflig\195\169s (%d+)%%.", type="Allbaseincrease", amount="n/100"},			-- Master Demonologist Succubus
	{ text="D\195\169g\195\162ts d'ombre augment\195\169s de (%d+)%%.", type="Shadowbaseincrease", amount="n/100"},			-- Touch of Shadow Demonic Sacrifice Succubus
	{ text="D\195\169g\195\162ts de m\195\169l\195\169e augment\195\169s de (%d+)%%.", type="Meleebaseincrease", amount="n/100" },			-- Enrage
	{ text="100%% Mana regeneration may continue while casting", type="ICPercent", amount="4" }, 		-- Innervate
	{ text="(%d+)%% de la vitesse normale pendant les incantations de sorts.", type="ICPercent", amount="n/100" }, 	-- Mage Armor
	{ text="D\195\169g\195\162ts des sorts de schoolname augment\195\169s de (%d+) au maximum." },					-- Elixir of frost power
	{ text="D\195\169g\195\162ts et soins produits par les sorts augment\195\169s de (%d+)%%.", type="Allbaseincrease", amount="n/100" },	-- Power Infusion
	{ text="Augmente les points de d\195\169g\195\162ts et le co\195\187t en mana de vos sorts.", type="Damagemodifier", amount="0.35" },	-- Arcane Power
	{ text="Rend (%d+) points de mana toutes les 5 secondes.", type="manaperfive" }, 				-- Blessing of Wisdom
	{ text="R\195\169g\195\169n\195\169ration de mana augment\195\169e de (%d+) toutes les 5 secondes.", type="manaperfive" }, 	-- Safefish Well Fed
	{ text="Points de d\195\169g\195\162ts des sorts augment\195\169s de (%d+) au maximum.", type="Damage" }, 				-- Flask of Supreme Power
	{ text="D\195\169g\195\162ts des sorts augment\195\169s de (%d+) au maximum", type="Damage" }, 				-- ZHC Damage
	{ text="D\195\169g\195\162ts des sorts augment\195\169s de (%d+).", type="Damage" }, 					-- Arcane Elixirs
	{ text="Augmente les chances d'obtenir un coup critique avec les sorts de (%d+)%%.", type="Allcritchance" },			-- Moonkin Aura
	{ text="Augmente les chances d'obtenir un coup critique avec les sorts de (%d+)%% et", type="Allcritchance" },		-- Onyxia
	{ text="Les d\195\169g\195\162ts et soins magiques sont augment\195\169s de (%d+).", type="All" },		-- ToEP
	{ text="Soins augment\195\169s de (%d+) au maximum.", type="Healing" },					-- ZHC Healing
	{ text="Augmente les d\195\169g\195\162ts des sorts de Feu d'un maximum de (%d+).", type="Fire" },					-- Elixir of superior fire power
	{ text="Les d\195\169g\195\162ts infig\195\169s par les sorts et effets de Feu sont augment\195\169s de (%d+) au maximum.", type="Fire" },					-- Elixir of fire power
	{ text="Les d\195\169g\195\162ts infig\195\169s par les sorts de Feu sont augment\195\169s de (%d+) au maximum.", type="Fire" },					-- potion of fire power
	{ text="Augmente les chances de coup critique avec un sort de (%d+)%%.", type="Allcritchance" }       -- Dire Maul North crit chance buff
}

TheoryCraft_Debuffs = {
	{ text="Armure r\195\169duite de (%d+)%.", type="Sunder" },   							-- Sunder Armor
	{ text="Armor decreased%.", type="DontMitigate", amount=1 },							-- Expose Armor
	{ text="Frost spells have a (%d+)%% additional chance to critically", type="Frostcritchance" },   		-- Winter's Chill
	{ text="Tous les attaquants gagnent (%d+) points de puissance d'attaque \195\160 distance contre cette cible.", type="Ranged"},-- Hunter's Mark
	{ text="R\195\169duit de (%d+) vos r\195\169sistances au Feu et au Givre.", type="Firepenetration" },		-- Curse of the Elements
	{ text="R\195\169duit de (%d+) vos r\195\169sistances au Feu et au Givre.", type="Frostpenetration" },		-- Curse of the Elements
	{ text="Augmente de (%d+)%% les d\195\169g\195\162ts d'Ombre subis.", type="Shadowbaseincrease", amount="n/100" },		-- Shadow Weaving
	{ text="Augmente de (%d+)%% les d\195\169g\195\162ts de Feu et de Givre subis.", type="Firebaseincrease", amount="n/100" },	-- Curse of the Elements
	{ text="Augmente de (%d+)%% les d\195\169g\195\162ts de Feu et de Givre subis.", type="Frostbaseincrease", amount="n/100" },	-- Curse of the Elements
	{ text="Increases Holy damage taken by up to (%d+)%.", type="Holy" },				-- Judgement of Crusader
	{ text="Les d\195\169g\195\162ts d'Ombre et des Arcanes subis sont augment\195\169s de (%d+)%%.", type="Shadowbaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="Les d\195\169g\195\162ts d'Ombre et des Arcanes subis sont augment\195\169s de (%d+)%%.", type="Arcanebaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="R\195\169sistances \195\160 l'Ombre et aux Arcanes r\195\169duites de (%d+).", type="Shadowpenetration" },		-- Curse of Shadows
	{ text="R\195\169sistances \195\160 l'Ombre et aux Arcanes r\195\169duites de (%d+).", type="Arcanepenetration" },		-- Curse of Shadows
	{ text="Incapable de bouger.", type="doshatter", amount="1" },						-- Frost Nova
	{ text="Gel\195\169.", type="doshatter", amount="1" },							-- Freezing Band? no, hunter ice trap
	{ text="Augmente les d\195\169g\195\162ts de Feu subis de (%d+)%%.", type="Firebaseincrease", amount="n/100" },		-- Improved Scorch
}

-- Dot Duration is read from here

TheoryCraft_DotDurations = {
	{ text=" en (%d+) sec.", amount="n" },					-- Shadow Word: Pain, Corruption, Immolate, Renew
	{ text="toutes les secondes pendant (%d+) sec.", amount="n" },		-- Arcane Missiles
	{ text="Dure (%d+) sec.", amount="n" },					-- Drain and Siphon Life
	{ text="apr\195\168s 1 min.", amount="60" },				-- Curse of Doom
	{ text=" secondes pendant (%d+) sec.", amount="n" },				-- Tranquility
	{ text="every second for (%d+) sec%.", amount="n" },			-- Volley
}

-- Checks every line for these

TheoryCraft_EquipEveryRight = {
	{ text="^Vitesse (%d+%.?%d+)", type="OffhandSpeed", slot="SecondaryHand" },	-- Weapon Damage
	{ text="^Vitesse (%d+%.?%d+)", type="MainSpeed", slot="MainHand" },		-- Weapon Damage
	{ text="^Vitesse (%d+%.?%d+)", type="Rangedillum", slot="Ranged" },	-- Weapon Damage
	{ text="^Dague", type="MeleeAPMult", amount="-0.7", slot="MainHand" },			-- Weapon Damage
	{ text="^Vitesse (%d+%.?%d+)", type="RangedSpeed", slot="Ranged" },	-- Weapon Damage
	{ text="^Dague", type="DaggerEquipped", amount=1, slot="MainHand" }	,		-- Used for dagger spec
	{ text="^Arme de pugilat", type="FistEquipped", amount=1, slot="MainHand" },		-- Used for fist spec
	{ text="^Hache", type="AxeEquipped", amount=1, slot="MainHand" },				-- Used for Axe Spec
	{ text="^Arme d'hast", type="PolearmEquipped", amount=1, slot="MainHand" },			-- Used for Polearm Spec
	{ text="^Shield", type="ShieldEquipped", amount=1, slot="SecondaryHand" },	-- Used for Block
}

TheoryCraft_EquipEveryLine = {
	{ text="Ranged Attack Power %+(%d+)", type="RangedAttackPowerReport" }, 	-- Hunter Leg/Helm enchant
	{ text="^(%d+) Block", type="BlockValueReport" }, 				-- Block Value (shield)

	{ text="++(%d+) Attack Power", type="AttackPowerReport" }, 			-- Attack power

	{ text="Ajoute (%d+%.?%d+) d\195\169g\195\162ts par seconde", type="Ranged", slot="Ammo" },	-- Arrows

	{ text="Main droite", type="MeleeAPMult", amount="2.4", slot="MainHand" },	-- Weapon Damage
	{ text="A une main", type="MeleeAPMult", amount="2.4", slot="MainHand" },	-- Weapon Damage
	{ text="Deux mains", type="MeleeAPMult", amount="3.3", slot="MainHand" },	-- Weapon Damage
	{ text="(%d+) %- %d+", type="MeleeMin", slot="MainHand" },			-- Weapon Damage
	{ text="%d+ %- (%d+)", type="MeleeMax", slot="MainHand" }, 			-- Weapon Damage
	{ text="Scope %(%+(%d+) Damage%)", type="RangedMin", slot="Ranged" },		-- Weapon Damage enchant
	{ text="Scope %(%+(%d+) Damage%)", type="RangedMax", slot="Ranged" },		-- Weapon Damage enchant
	{ text="(%d+) %- %d+", type="RangedMin", slot="Ranged" },			-- Weapon Damage
	{ text="%d+ %- (%d+)", type="RangedMax", slot="Ranged" }, 			-- Weapon Damage
	{ text="Weapon Damage %+(%d+)", type="MeleeMin", slot="MainHand" },		-- Weapon Damage enchant
	{ text="Weapon Damage %+(%d+)", type="MeleeMax", slot="MainHand" },		-- Weapon Damage enchant
	{ text="(%d+) %- %d+", type="OffhandMin", slot="SecondaryHand" },		-- Weapon Damage
	{ text="%d+ %- (%d+)", type="OffhandMax", slot="SecondaryHand" }, 		-- Weapon Damage
	{ text="Weapon Damage %+(%d+)", type="OffhandMin", slot="SecondaryHand" },	-- Weapon Damage enchant
	{ text="Weapon Damage %+(%d+)", type="OffhandMax", slot="SecondaryHand" },	-- Weapon Damage enchant

	{ text="+(%d+) aux d\195\169g\195\162ts des sorts des arcanes", type="Arcane" },-- of wrath arcane
	{ text="+(%d+) aux d\195\169g\195\162ts des sorts d'ombre", type="Shadow" },	-- of wrath shadow
	{ text="+(%d+) aux d\195\169g\195\162ts des sorts du sacr\195\169", type="Holy" },	-- of wrath holy
	{ text="+(%d+) aux d\195\169g\195\162ts des sorts de schoolname" },			-- of wrath items
	{ text="D\195\169g\195\162ts de schoolname ++(%d+)" },				-- AQ Glove enchants
	{ text="D\195\169g\195\162ts d'ombre ++(%d+)", type="Shadow" },			-- AQ Shadow Glove enchants

	{ text="^Huile de mana brillante", type="manaperfive", amount="12" }, 		-- Enchanting oils
	{ text="^Huile de mana brillante", type="Healing", amount="25", me=1 }, 	-- Enchanting oils
	{ text="^Huile de sorcier brillante", type="Allcritchance", amount="1" }, 	-- Enchanting oils
	{ text="^Huile de sorcier brillante", type="Damage", amount="36" }, 		-- Enchanting oils
	{ text="^Huile de mana mineure", type="manaperfive", amount="4" }, 		-- Enchanting oils
	{ text="^Huile de mana inf\195\169rieure", type="manaperfive", amount="8" }, 	-- Enchanting oils
	{ text="^Huile de sorcier mineure", type="Damage", amount="8" }, 		-- Enchanting oils
	{ text="^Huile de sorcier inf\195\169rieure", type="Damage", amount="16" }, 	-- Enchanting oils
	{ text="^Huile de sorcier", type="Damage", amount="24" }, 			-- Enchanting oils

	{ text="Utiliser : Rend 375 \195\160 625 points de mana.", type="manarestore", amount="500" },-- Robe of the Archmage

	{ text="Chances de toucher des sorts ++(%d+)%%", type="Allhitchance" },		-- zg enchant
	{ text="Soins et d\195\169g\195\162ts des sorts ++(%d+)", type="All", me=1 },	-- zg enchant
	{ text="++(%d+) aux d\195\169g\195\162ts et aux sorts de soins", type="All" },	-- zg shoulder damage enchant
	{ text="++(%d+) aux sorts de soins", type="Healing" },				-- of healing items
	{ text="++(%d+) D\195\169g\195\162ts et soins", type="All" },			-- of sorcery items
	{ text="R\195\169cup. mana ++(%d+)/", type="manaperfive" },			-- zg enchant
	{ text="++(%d+) points de mana toutes les 5 sec.", type="manaperfive" },	-- of restoration
	{ text="R\195\169cup. mana (%d+)/5 sec.", type="manaperfive" },			-- bracers regen enchant
	{ text="D\195\169g\195\162ts des sorts de schoolname ++(%d+)", me=1 }, 		-- Winter's Might
	{ text="D\195\169g\195\162ts des sorts ++(%d+)", type="Damage", me=1 }, 	-- Spell Damage +30 enchant
	{ text="Sorts de soins ++(%d+)", type="Healing" },				-- zg priest and healing enchant
	{ text="Sorts de soin ++(%d+)", type="Healing" },				-- bracers and weapon healing enchant
	{ text="++(%d+) aux d\195\169g\195\162ts des sorts et aux soins", type="All" }, -- not sure
}

-- Won't check any lines containing the following words (for speed)

TheoryCraft_IgnoreLines = {
	"^Durabilit\195\169", "^Li\195\169", "^Classes %:", "requis", "Armure", "^T\195\170te", "^Cou", "^Epaules",
	"^Dos", "^Torse", "^Poignets", "^Mains", "^Taille", "^Jambes", "^Pieds", "^Doigt", "^Bijou",
	"^Baguette", "^Main gauche", "R\195\169sistance?$", "^%+%d+ Endurance", "^%+%d+ Intelligence",
	"^%+%d+ Esprit", "^%+%d+ Agilit\195\169", "^%+%d+ Force"
}

-- Checks every line beginning with Equip: or Set: for these

-- These are handled specially

TheoryCraft_SetsDequipOnly= {
	{ text="Mana cost of Shadow spells reduced by (%d+)%%.", type="Shadowmanacost", amount=-0.15 }, 			-- Felheart 8 piece bonus
}

-- Checks every line beginning Set: for these

TheoryCraft_Sets = {
	{ text="(%d+)%% of your Mana regeneration to continue while casting", type="ICPercent", amount="n/100" }, 	     	-- Stormrage/Trans
	{ text="Your normal ranged attacks have a 4%% chance of restoring 200 mana.", type="Beastmanarestore", amount=200 }, -- Beaststalker/Beastmaster
	{ text="Les points de vie ou de mana gagn\195\169s quand un Drain de vie ou un Drain de mana infligent des d\195\169g\195\162s augmentent de 15%%.", type="Drainlifeillum", amount=0.15 }, -- Felheart 3 piece bonus
	{ text="10%% de chances qu'apr\195\168s avoir lanc\195\169 Projectiles des arcanes, Boule de feu ou Eclair de givre, votre prochain sort dont le temps d'incantation est inf\195\169rieur \195\160 10 secondes soit lanc\195\169 instantan\195\169ment.", type="FrostboltNetherwind", amount=1 },	    -- Netherwind
	{ text="10%% de chances qu'apr\195\168s avoir lanc\195\169 Projectiles des arcanes, Boule de feu ou Eclair de givre, votre prochain sort dont le temps d'incantation est inf\195\169rieur \195\160 10 secondes soit lanc\195\169 instantan\195\169ment.", type="FireballNetherwind", amount=1 },	    -- Netherwind
	{ text="Increases your chance of a critical hit with Prayer of Healing by (%d+)%%.", type="Prayer of Healingcritchance" },-- Prophecy 8 piece
	{ text="Augmente de (%d+)%% vos chances d'obtenir un coup critique avec vos Horions.", type="Shockcritchance" }, -- Shaman Legionnaire set bonus
	{ text="Augmente vos chances d'infliger un coup critique avec les sorts de Nature de (%d+)%%.", type="Naturecritchance" }, -- ten storms set bonus
	{ text="Apr\195\168s avoir lanc\195\169 un sort de Vague de soins ou de Vagues de soins inf\195\169rieurs, vous avez 25%% de chance de gagner un nombre de points de mana \195\169gal \195\160 35%% du co\195\187t de base du sort.", type="EarthfuryBonusmanacost", amount=-0.0875 },   -- earth fury set bonus
	{ text="Increases the damage of Multi-shot and Volley by (%d+)%%.", type="Barragemodifier", amount="n/100"},   -- giantstalker set bonus
	{ text="Augmente les chances d'infliger un coup critique avec vos sorts du Sacr\195\169 de (%d+)%%.", type="Holycritchance" },   -- Prophecy
	{ text="Chance on spell cast to increase your damage and healing by up to 95 for 10 sec%.", type="All", amount=95, duration=9.9, proc=0.04, exact=1 }, 	     	-- Elements
}

-- Checks every line beginning with Equip: or Set: for these

TheoryCraft_Equips = {
	{ text="Diminue les r\195\169sistances magiques des cibles de vos sorts de (%d+).", type="Allpenetration" },	    -- Penetration
	{ text="Augmente vos chances de toucher avec des sorts de (%d+)%%.", type="Allhitchance" },		    -- ZG drops
	{ text="Augmente les chances d'obtenir un effet critique avec vos sorts du Sacr\195\169 de (%d+)%%.", type="Holycritchance" },   -- Benediction
	{ text="Augmente vos chances d'infliger des coups critiques avec vos sorts de (%d+)%%.", type="Allcritchance" },   -- Standard +crit
	{ text="Augmente les d\195\169g\195\162ts et les soins produits par les sorts et effets magiques de (%d+) au maximum.", type="All" },   -- Standard +dam
	{ text="++(%d+) aux d\195\169g\195\162ts et aux sorts de soins", type="manaperfive", type="All" },					    -- +damage
	{ text="Augmente les soins prodigu\195\169s par les sorts et effets de (%d+) au maximum.", type="Healing" },		    -- Standard +heal
	{ text="Augmente les points de d\195\169g\195\162ts inflig\195\169s par vos sorts et effets de Feu de (%d+) au maximum.", type="Fire" },			    -- Fire +dam
	{ text="Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Givre de (%d+) au maximum.", type="Frost" },			    -- Frost +dam
	{ text="Augmente les d\195\169g\195\162ts inflig\195\169s par les effets et sorts des Arcanes de (%d+) au maximum.", type="Arcane" },			    -- Arcane +dam
	{ text="Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets du Sacr\195\169 de (%d+) au maximum.", type="Holy" },			    -- Holy +dam
	{ text="Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Nature de (%d+) au maximum.", type="Nature" },			    -- Nature +dam
	{ text="Augmente les d\195\169g\195\162ts inflig\195\169s par les sorts et effets d'Ombre de (%d+) au maximum.", type="Shadow" },			    -- Shadow +dam
	{ text="Rend (%d+) points de mana toutes les 5 secondes.", type="manaperfive" },					    --= They interchange
	{ text="++(%d+) points de mana toutes les 5 sec.", type="manaperfive" },					    --= these two
	{ text="Quand vos sorts offensifs atteignent une cible, donne une chance d'augmenter les points de d\195\169g\195\162ts inflig\195\169s par vos sorts et effets de 132 pendant 10 sec.", type="All", amount=132, duration=9.9, proc=0.05, exact=1 },		    -- Wrath of Cenarius
	{ text="2%% de chances lors d'un lancer de sort r\195\169ussi de permettre à votre r\195\169g\195\169n\195\169ration de mana de se poursuivre, \195\160 100%% de la vitesse normale, pendant les incantations. Dure 15 sec.", type="ICPercent", amount=1, duration=15, proc=0.02, exact=0 },	    -- Darkmoon Trinket
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
	{ realslot="Head", slot="Head", text="T\195\170te" },
	{ realslot="Neck", slot="Neck", text="Cou" },
	{ realslot="Shoulder", slot="Shoulder", text="Epaule" },
	{ realslot="Back", slot="Back", text="Dos" },
	{ realslot="Chest", slot="Chest", text="Torse" },
	{ realslot="Shirt", slot="Shirt", text="Chemise" },
	{ realslot="Tabard", slot="Tabard", text="Tabard" },
	{ realslot="Wrist", slot="Wrist", text="Poignets" },
	{ realslot="Hands", slot="Hands", text="Mains" },
	{ realslot="Waist", slot="Waist", text="Taille" },
	{ realslot="Legs", slot="Legs", text="Jambes" },
	{ realslot="Feet", slot="Feet", text="Pieds" },
	{ realslot="Finger0", slot="Finger0", text="Doigt" },
	{ realslot="Finger1", slot="Finger1", text="Doigt" },
	{ realslot="Trinket0", slot="Trinket0", text="Bijou" },
	{ realslot="Trinket1", slot="Trinket1", text="Bijou" },
	{ realslot="MainHand", slot="Main", text="Main droite" },
	{ realslot="MainHand", slot="Main", text="A une main" },
	{ realslot="MainHand", slot="Main", text="Deux mains" },
	{ realslot="SecondaryHand", slot="Off Hand", text="Tenu(e) en main gauche" },
	{ realslot="SecondaryHand", slot="Off Hand", text="A une main" },
	{ realslot="SecondaryHand", slot="Off Hand", text="Main gauche" },
	{ realslot="Ranged", slot="Ranged", text="Baguette" },
	{ realslot="Ranged", slot="Ranged", text="Arc" },
	{ realslot="Ranged", slot="Ranged", text="Arme \195\160 feu" },
	{ realslot="Ranged", slot="Ranged", text="Arbal\195\168te" },
	{ realslot="Ranged", slot="Ranged", text="A distance" },
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

TheoryCraft_SetBonuses = { }

end

end