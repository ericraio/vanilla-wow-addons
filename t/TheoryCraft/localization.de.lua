if (GetLocale() == "deDE") then
--if true then

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
	hitorhealhit = "Treffer",
	hitorhealheal = "Heilung",
	damorhealdam = "Schaden",
	damorhealheal = "Heilung",
	damorapap = "Angriffskraft",
	damorapdam = "+Schaden",
}

TheoryCraft_TooltipFormat = {
	{show = true, 		left = "#c1,1,1#$spellname$", 		right = "#c0.5,0.5,0.5#Rank $spellrank$"},
	{show = true, 		left = "#c1,1,1#$wandlineleft2$", 	right = "#c1,1,1#$wandlineright2$"},
	{show = true, 		left = "#c1,1,1#$wandlineleft3$", 	right = "#c1,1,1#$wandlineright3$"},
	{show = "embedstyle1", 	left = "#c1,1,1#$wandlineleft4$", 	right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# Kritisch"},
	{show = "embedstyle1", inverse = true, left = "#c1,1,1#$wandlineleft4$"},
	{show = true, 		left = "#c1,1,1#$basemanacost$ Mana", 	right = "#c1,1,1#$spellrange$"},
	{show = "embedstyle1", 	left = "#c0.9,0.9,1##OR$dps$#c1,1,1# DPS/$hps$#c1,1,1# HpsOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# Kritisch"},
	{show = "embedstyle2", 	left = "#c0.9,0.9,1##OR$dpm,2$#c1,1,1# DPM/$hpm,2$#c1,1,1# HpmOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# Kritisch"},
	{show = "embedstyle3", 	left = "#c0.9,0.9,1##OR$dps$#c1,1,1# DPS/$hpm,2$#c1,1,1# HpmOR#", 
			       right = "#c0.9,0.9,1#$critchance,1$%#c1,1,1# Kritisch"},
	{show = true, 		left = "#c1,1,1#$basecasttime$", right = "#c1,1,1#$cooldown$"},
	{show = true, 		left = "#c1,1,1#$cooldownremaining$",},
	{show = "embed", 	left = "#c1,0.82745098,0##OR$description$/$basedescription$OR##WRAP#"},
	{show = "embed", inverse = true, left = "#c1,0.82745098,0#$basedescription$#WRAP#"},
	{show = true, 		left = "#c1,0.5,1#$outfitname$"},
	{show = true, 		left = "Stellt $evocation$ Mana her."},
	{show = true, 		left = "ungebufft: $sealunbuffed,1$ dps"},
	{show = true, 		left = "mit diesem Siegel: $sealbuffed,1$ dps"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Heil Statistik:#"},
	{show = "embed", inverse = true, left = "Geheilt: $healrange$"},
	{show = "critwithdam", 	left = "Krits: $crithealchance,2$% (für $crithealrange$)"},
	{show = "critwithoutdam", left = "Krits: $crithealchance,2$%"},
	{show = "hps", 		left = "HPS: $hps,1$#IF, $withhothps,1$IF#"},
	{show = "dpsdam", 	left = "HPS aus +Heilung: $hpsdam,1$ ($hpsdampercent,1$%)"},
	{show = "averagedamnocrit", left = "Ø Heilung: $averagehealnocrit$"},
	{show = "averagedamnocrit", left = "nötige Ticks: $averagehealtick$"},
	{show = "averagedam", 	left = "Ø Heilung: $averageheal$"},
	{show = "averagedam", 	left = "nötige Ticks: $averagehealtick$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Schaden Statistik#"},
	{show = "embed", inverse = true, left = "Treffer: $dmgrange$"},
	{show = "critmelee", 	left = "Krits: $critdmgchance,2$% (für $critdmgrange$)"},
	{show = "critwithdam", 	left = "Krits: $critdmgchance,2$% (für $critdmgrange$)"},
	{show = "sepignite", 	left = "mit Entzünden: $igniterange$"},
	{show = "critwithoutdam", left = "Krits: $critdmgchance,2$%"},
	{show = "dps", 		left = "DPS: $dps,1$#IF, $withdotdps,1$IF#"},
	{show = "dpsdam", 	left = "DPS aus +Schaden: $dpsdam,1$ ($dpsdampercent,1$%)"},
	{show = "averagedamnocrit", left = "Ø Treffer: $averagedamnocrit$"},
	{show = "averagedamnocrit", left = "nötige Ticks: $averagedamtick$"},
	{show = "averagedam", 	left = "Ø Treffer: $averagedam$"},
	{show = "averagedam", 	left = "nötige Ticks: $averagedamtick$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Multiplikator:#"},
	{show = "plusdam", 	left = "Grund +$damorheal$: $plusdam$"},
	{show = "damcoef", 	left = "+$damorheal$ Koeffizient: $damcoef,1$%#IF, $damcoef2,1$%IF#"},
	{show = "dameff", 	left = "+$damorheal$ Effizienz: $dameff,1$%"},
	{show = "damtodouble", 	left = "+$damorheal$ zum Verdoppeln: $damtodouble$"},
	{show = "damfinal", 	left = "End Bonus +$damorheal$: $damfinal$#IF, $damfinal2$IF#"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Widerstand:#"},
	{show = "resists", 	left = "Widerstands Rate ($resistlevel$): $resistrate$%"},
	{show = "resists", 	left = "Nach Level Widerstand: $dpsafterresists,1$ DPS"},
	{show = "resists", 	left = "Bis zu: $penetration,1$ DPS Penetrated"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Vergleich:#"},
	{show = "nextcrit",	left = "+1% Krit ergibt: +$nextcritheal,2$ Ø Heilung (Entspricht: $nextcrithealequive,2$ +Heilung)"},
	{show = "nextstr", 	left = "+10 Stärke ergibt: +$nextstrdam,2$ Ø $hitorheal$ (Entspricht: $nextstrdamequive,2$ $damorap$)"},
	{show = "nextagi", 	left = "+10 Beweglichkeit ergibt: +$nextagidam,2$ Ø $hitorheal$#IF (Entspricht: $nextagidamequive,2$ $damorap$)IF#"},
	{show = "nextcrit",	left = "+1% Krit ergibt: +$nextcritdam,2$ Ø $hitorheal$#IF (Entspricht: $nextcritdamequive,2$ $damorap$)IF#"},
	{show = "nexthit", 	left = "+1% Treffer ergibt: +$nexthitdam,2$ Ø $hitorheal$#IF (Entspricht: $nexthitdamequive,2$ $damorap$)IF#"},
	{show = "nextpen", 	left = "+10 pen: #OR$dontshowupto$/Up to OR#+$nextpendam,2$ average $hitorheal$#IF (Eq: $nextpendamequive,2$ $damorap$)IF#"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Rotation:#"},
	{show = true, 		left = "MS Rotation ($msrotationlength,1$ Sek) DPS: $msrotationdps,1$"},
	{show = true, 		left = "AS Rotation ($asrotationlength,1$ Sek) DPS: $asrotationdps,1$"},
	{show = true, 		left = "MS/Arcane Rotation DPS: $arcrotationdps,1$"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Kombinierter Vergleich:#"},
	{show = "nextagi", 	left = "+10 Beweglichkeit ergibt: +$nextagidps,2$ MS Rotation DPS#IF (Entspricht: $nextagidpsequive,2$ $damorap$)IF#"},
	{show = "nextcrit",	left = "+1% Krit ergibt: +$nextcritdps,2$ MS Rotation DPS (Entspricht: $nextcritdpsequive,2$ $damorap$)"},
	{show = "nexthit", 	left = "+1% Treffer ergibt: +$nexthitdps,2$ MS Ratotion DPS (Entspricht: $nexthitdpsequive,2$ $damorap$)"},
	{show = "titles", 	left = "#c1,1,1##TITLE=Effizienz:#"},
	{show = "mana", 	left = "Echte Mana Kosten: $manacost,1$"},
	{show = "dpm", 		left = "DPM: $dpm,2$#IF, $withdotdpm,2$IF#"},
	{show = "dpsmana", 	left = "DPS/Mana: $dpsmana,3$"},
	{show = "hpm", 		left = "HPM: $hpm,2$#IF, $withhothpm,2$IF#"},
	{show = "lifetap", 	left = "Aderlass DPH: $lifetapdpm,1$"},
	{show = "lifetap", 	left = "Aderlass HPH: $lifetaphpm,1$"},
	{show = "lifetap", 	left = "Aderlass DPS: $lifetapdps,1$"},
	{show = "lifetap", 	left = "Aderlass HPS: $lifetaphps,1$"},
	{show = "showregenheal", left = "10 Sek Regeneration: +$regenheal$ Heilung"},
	{show = "showregenheal", left = "10 Sek Regeneration beim Zaubern: +$icregenheal$ Heilung"},
	{show = "showregendam", left = "10 Sek Regeneration: +$regendam$ Schaden"},
	{show = "showregendam", left = "10 Sek Regeneration beim Zaubern: +$icregendam$ Schaden"},
	{show = "max", 		left = "Max Heilung: $maxoomheal$ ($maxoomhealtime$ secs)"},
	{show = "max", 		left = "Max Schaden: $maxoomdam$ ($maxoomdamtime$ secs)"},
	{show = "maxevoc", 	left = "Max Schaden mit evoc+gem: $maxevocoomdam$ ($maxevocoomdamtime$ secs)"},
}

TheoryCraft_MeleeComboEnergyConverter = "in (.-) zusätzlichen"
TheoryCraft_MeleeComboReader = "(%d+) Punkt(.-): (%d+)%-(%d+) Schadenspunkte"
TheoryCraft_MeleeComboReplaceWith = "$points$ Punkt%1: %2%-%3 Schadenspunkte"

TheoryCraft_MeleeMinMaxReader = {
	{ pattern = "der (%d+)%% Eurer Angriffskraft entspricht",				-- Blutdurst
		type={"bloodthirstmult"} },
	{ pattern = " zusätzlich (%d+) Punkt%(e%) Schaden",						-- Klaue
		type={"addeddamage"} },
	{ pattern = "(%d+)%%",													-- Schreddern/Verheeren/Hinterhalt/Meucheln
		type={"backstabmult"} },
	{ pattern = "plus (%d+)",												-- Schreddern/Verheeren/Hinterhalt/Maucheln
		type={"addeddamage"} },
	{ pattern = " um (%d+)",												-- Maul/Zermalmen/Gezielter Schuß/Heldenhafter Stoß/Raptorstoß
		type={"addeddamage"} },
	{ pattern = "fügt Ihnen (%d+) Punkt",									-- Donnerknall
		type={"addeddamage"} },		
	{ pattern = "(%d+) Schaden zusätzlich",									-- Sinister Strike
		type={"addeddamage"} },
	{ pattern = "verursacht (%d+) bis (%d+) Schaden",						-- Prankenhieb/Schildschlag
		type={"mindamage", "maxdamage"} },
	{ pattern = "der (%d+) Schaden",										-- Spöttischer Schlag
		type={"addeddamage"} },
	{ pattern = " um zusätzlich (%d+) ",									-- Mehrfach Schuß
		type={"addeddamage"} },
}


TheoryCraft_MeleeMinMaxReplacer = {
	{ search = "Schild und verursacht (%d+) bis (%d+) Schaden",							-- Schildschlag
	  replacewith = "Schild und verursacht $damage$ Schaden" },
	{ search = " der den Distanzschaden um (%d+) erhöht",								-- Gezielter Schuss
	  replacewith = " der beim Ziel $damage$ Distanzschaden verursacht" },
	{ search = "Nahkampfschaden um (%d+) Punkt",										-- Heldenhafter Stoß, Raptorstoß
	  replacewith = "Nahkampfschaden auf $damage$ Punkt" },
	{ search = "zusätzlich (%d+) Punkt%(e%)",											-- Klaue
	  replacewith = "ingesamt $damage$ Punkte" },
	{ search = "Ziel (%d+)%% Schaden plus (%d+) zugefügt wird",							-- Schredden/Verheeren
	  replacewith = "Ziel $damage$ Punkte Schaden zugefügt werden" },
	{ search = "Druiden um %d+",														-- Zermalmen
	  replacewith = "Druiden auf $damage$ Punkte Schaden" },
	{ search = " (%d+)%% Waffenschaden plus %d+",										-- Hinterhalt/Meucheln
	  replacewith = " $damage$ Waffenschaden" },
	{ search = " fügt (%d+)%% Waffenschaden hinzu und ",								-- Scattershot/Ghostly Strike
	  replacewith = " fügt $damage$ Schaden zu und " },
	{ search = " verursacht Schaden gleich bis (%d+)%% von Eurer Angriffskraft",		-- Bloodthirst
	  replacewith = " verursacht $damage$ Schaden." },
	{ search = " verursacht (%d+)%% Schaden plus %d+ beim Ziel",						-- Shred/Ravage
	  replacewith = " verursacht $damage$ Schaden" },
	{ search = " verursacht (%d+) zusätzlichen Schaden zu Eurem normalen Waffenschaden",	-- Sinister Strike
	  replacewith = " verursacht $damage$ Schaden" },
	{ search = " erhöht Nahkampfschaden um (%d+)",										-- Gezielter Schuß
	  replacewith = " bringt $damage$ Schaden beim Ziel" },
	{ search = " erhöht Distanzschaden um (%d+)",										-- Gezielter Schuß
	  replacewith = " verursacht $damage$ Schaden beim Ziel" },
	{ search = " für zusätzlich (%d+) Schaden",											-- Mehrfach Schuß
	  replacewith = " für $damage$ Schaden" },
	{ search = " bringt Waffenschaden plus (%d+) und ",									-- Mortal Strike
	  replacewith = " bringt $damage$ Schaden und " },
	{ search = " Euer Waffenschaden plus (%d+) bis ",									-- Cleave
	  replacewith = " bringt $damage$ Schaden bis " },
	{ search = " verursacht Waffenschaden plus (%d+)",									-- Overpower
	  replacewith = " verursacht $damage$ Schaden" },
	{ search = " zum Blocken feindlicher Nahkampf und Distanzangriffe%.",				-- Block
	  replacewith = " zum Blocken feindlicher Nahkampf und Distanzangriffe, Schadensreduzierung von $blockvalue$." },
	{ search = "Diser Angriff fügt (%d+)%% Waffenschaden hinzu ",						-- Riposte
	  replacewith = "Diser Angriff fügt $damage$ Schaden hinzu" },
	{ search = "verursacht (%d+) bis (%d+) Schaden",									-- Prankenhieb
	  replacewith = "verursacht $damage$ Schaden" }, 
	{ search = "der (%d+) Schaden",														-- Spöttischer Schlag
	  replacewith = "der $damage$ Schaden" },
	{ search = "fügt Ihnen (%d+) Punkt",												-- Donnerschlag
	  replacewith = "fügt Ihnen $damage$ Punkt" },
}

TheoryCraft_SpellMinMaxReader = {
	{ pattern = "(%d+) bis (%d+)(.+)(%d+) bis (%d+)",									-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
-- priest patch 1.12
	{ pattern = "das 18 Sek%. lang (%d+) Punkt",							-- Schattenwort: Schmerz
		type={"bothdamage"} },    -- dotbothdamage (so better display)




-- druid
	{ pattern = "(%d+) bis (%d+)(.+) lang (%d+)",										-- Mondfeuer
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(.+) lang um (%d+)",													-- Erneuerung		
		type={"tmptext", "bothdamage"} },
	{ pattern = "(%d+) bis (%d+)(.+) weitere (%d+)",									-- Nachwachsen
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "Heilt beim Ziel (.+) lang (%d+)",										-- Verjüngung
		type={"tmptext", "dotbothdamage"} },
	{ pattern = "festwurzeln (.+) lang (%d+)",											-- Wucherwurzeln
		type={"tmptext", "dotbothdamage"} },
	{ pattern = "(.+) 2 Sekunden (%d+)",												-- Gelassenheit
		type={"tmptext", "bothdamage"} },
	{ pattern = "Sek%. (%d+) Naturschaden",												-- Hurrikan
		type={"bothdamage"} },
-- pala
	{ pattern = "(%d+) bis (%d+)(.+) zusätzlich (%d+)",									-- Heiliges Feuer
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(%d+) Punkt%(e%) Heiligschaden",										-- Weihe
		type={"bothdamage"} },
-- warlock
	{ pattern = "Verbrennt den Feind und fügt (%d+) bis (%d+)(.+) lang (%d+)",			-- Feuerbrand
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "Verdirbt das Ziel und verursacht (.+) Sek%. lang (%d+)",				-- Verderbnis
		type={"tmptext", "dotbothdamage"} },
	{ pattern = "(.+) Minute (%d+)",													-- Fluch der Verdammnis
		type={"tmptext", "bothdamage"} },
	{ pattern = "(%d+) Feuerschaden und nahen Gegner (%d+)",							-- Höllenfeuer
		type={"bothdamage", "bothdamage"} },
	{ pattern = "Sek%. lang (%d+) Punkt%(e%) Schattenschaden",							-- Seelendieb
		type={"dotbothdamage"} },
	{ pattern = "fügt (.+) Sek%. lang (%d+) Punkt",										-- Fluch der Pein
		type={"tmptext", "dotbothdamage"} },
	{ pattern = "Überträgt pro Sekunde (%d+)",											-- Blutsauger
		type={"bothdamage"} },
-- mage
	{ pattern = "(.+) pro Sekunde (%d+) bis (%d+)",										-- Arkane Geschosse
		type={"tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "(.+) pro Sekunde (%d+)",												-- Arkane Geschosse
		type={"tmptext", "dotbothdamage"} },
	{ pattern = "(%d+) bis (%d+) Punkt%(e%) Feuerschaden (.+) Sek%. lang (%d+)",		-- Feuerball, Flammenstoß, Feuerbrand (WL)
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(%d+) bis (%d+) Punkt%(en%) Feuerschaden%.",							-- Feuerschlag
		type={"mindamage", "maxdamage"} },
	{ pattern = "der (%d+) bis (%d+) Frostschaden",										-- Frostblitz
		type={"mindamage", "maxdamage"} },
-- hunter
	{ pattern = "sofortiger Schuss, der (%d+)",											-- Arkaner Schuss
		type={"bothdamage"} },
	{ pattern = "Sek%. lang (%d+) Naturschaden%. Es kann immer nur",					-- Schlangenbiss
		type={"bothdamage"} },
-- priest
	{ pattern = "(%d+) bis (%d+) Punkt%(e%) Heiligschaden (.+) zusätzlich (%d+)",		-- Heiliges Feuer
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(%d+) bis (%d+) Punkt Heiligschaden",									-- Göttliche Pein
		type={"mindamage", "maxdamage"} },
-- more
	{ pattern = "verursacht (%d+) Feuerschaden bei sich selbst und (%d+) Feuerschaden",	-- Hellfire
		type={"bothdamage", "bothdamage"} },
	{ pattern = "wird getroffen für (%d+) Naturschaden",								-- Lightning Shield
		type={"bothdamage"} },
	{ pattern = "und verursacht (%d+) Naturschaden",									-- Insect Swarm
		type={"bothdamage"} },
	{ pattern = "Furcht für 3 Sek%. und verursacht (%d+) Schattenschaden",				-- Death Coil
		type={"bothdamage"} },
	{ pattern = "(%d+) bis (%d+)(.+)und weitere(%d+)",									-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(%d+) bis (%d+)(.+)zusätzlich (%d+)",									-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "(%d+) bis (%d+)(.+) und (%d+)",										-- Generic Hybrid spell
		type={"mindamage", "maxdamage", "tmptext", "dotbothdamage"} },
	{ pattern = "verursacht (%d+)(.+) und (%d+) bis (%d+)",								-- Generic Hybrid spell
		type={"bothdamage", "tmptext", "dotmindamage", "dotmaxdamage"} },
	{ pattern = "verursacht (%d+)(.+) und (%d+)",										-- Generic Hybrid spell
		type={"bothdamage", "tmptext", "dotbothdamage"} },

	{ pattern = "(%d+) bis (%d+) Feuer Schaden.",										-- Magma totem
		type={"mindamage", "maxdamage"} },
	{ pattern = "(%d+) Feuer Schaden.",													-- Magma totem
		type={"bothdamage"} },
	{ pattern = "Meter für (%d+) bis (%d+) alle",										-- Healing Stream totem
		type={"mindamage", "maxdamage"} },
	{ pattern = "Meter für (%d+) alle",													-- Healing Stream totem
		type={"bothdamage"} },

	{ pattern = "(%d+) bis (%d+)",														-- Generic Normal spell
		type={"mindamage", "maxdamage"} },
	{ pattern = "(%d+)",																-- Generic no damage range spell
		type={"bothdamage"} },		
}

TheoryCraft_Dequips = {
	{ type = "all", text="All Stats %+(%d+)" },
	{ type = "formattackpower", text="%+(%d+) Angriffskraft in Katze, Bär" },
	{ type = "attackpower", text="%+(%d+) Angriffskraft" },
	{ type = "rangedattackpower", text="%+(%d+) Distanzangriffskraft" },
	{ type = "rangedattackpower", text="Distanzangriffskraft %+(%d+)%/" },
	{ type = "strength", text="%+(%d+) Stärke" },
	{ type = "strength", text="Stärke %+(%d+)" },
	{ type = "agility", text="%+(%d+) Beweglichkeit" },
	{ type = "agility", text="Beweglichkeit %+(%d+)" },
	{ type = "stamina", text="%+(%d+) Ausdauer" },
	{ type = "stamina", text="Ausdauer %+(%d+)" },
	{ type = "intellect", text="%+(%d+) Intelligenz" },
	{ type = "intellect", text="Intelligenz %+(%d+)" },
	{ type = "spirit", text="%+(%d+) Willenskraft" },
	{ type = "spirit", text="Willenskraft %+(%d+)" },
	{ type = "totalhealth", text="Gesundheit %+(%d+)" },
	{ type = "totalhealth", text="HP %+(%d+)" },
	{ type = "meleecritchance", text="Erhöht Eure Chance, einen kritischen Schlag zu erzielen, um (%d+)%%%." },
}

TheoryCraft_Locale = {
	HitMessage	= "Dein (.+) trift (.+) für (%d+)%.",
	CritMessage	= "Dein (.+) krits (.+) für (%d+)%.",
	Absorbed	= "(%+) absorbiert",
	ID_Beast	= "Bestie",
	ID_Humanoid	= "Humanoid",
	ID_Giant	= "Riese",
	ID_Dragonkin	= "Drache",
	ID_Equip	= "Anlegen: ",
	ID_Set		= "Set: ",
	ID_Use		= "Benutzen: ",
	to			= " bis ",
	Attack		= "Angreifen",
	InstantCast	= "Spontanzauber",
	SecCast		= " Sek Zauber",
	Mana		= " Mana",
	Cooldown	= " Sek. Abklingzeit",
	CooldownRem	= "Verbleibende Abklingzeit: ",
	Set			= "%(%d+/%d+%)",
	LoadText	= "TheoryCraft "..TheoryCraft_Version.." by Aelian. Type /tc for ui interface. Type /tc more for hidden features.",
	lifetap		= "Aderlass",
	MinMax  = {
		autoshotbefore = "Beschiesst das Ziel für ",
		autoshotafter = ".",
		shooterror = "Kein Zauberstab angelegt.",
		crusader = "granting %d+ Angriffskraft",
	},
	SpellTranslator = {
		["Frostbolt"] = "Frostblitz",
		["Frost Nova"] = "Frostnova",
		["Cone of Cold"] = "Kältekegel",
		["Blizzard"] = "Blizzard",
		["Arcane Explosion"] = "Arkane Explosion",
		["Arcane Missiles"] = "Arkane Geschosse",
		["Fire Blast"] = "Feuerschlag",
		["Fireball"] = "Feuerball",
		["Pyroblast"] = "Pyroschlag",
		["Scorch"] = "Versengen",
		["Blast Wave"] = "Druckwelle",
		["Flamestrike"] = "Flammenstoß",
		["Ice Barrier"] = "Eis-Barriere",
		["Evocation"] = "Hervorrufung",

		["Shadow Bolt"] = "Schattenblitz",
		["Soul Fire"] = "Seelenfeuer",
		["Searing Pain"] = "Sengender Schmerz",
		["Immolate"] = "Feuerbrand",
		["Firebolt"] = "Feuerblitz",
		["Lash of Pain"] = "Schmezenspeitsche",
		["Conflagrate"] = "Feuersbrunst",
		["Rain of Fire"] = "Feuerregen",
		["Hellfire"] = "Höllenfeuer",
		["Corruption"] = "Verderbnis",
		["Curse of Agony"] = "Fluch der Pein",
		["Curse of Doom"] = "Fluch der Verdammnis",
		["Drain Soul"] = "Seelendieb",
		["Siphon Life"] = "Lebensentzug",
		["Drain Life"] = "Blutsauger",
		["Death Coil"] = "Todesmantel",
		["Shadowburn"] = "Schattenbrand",
		["Life Tap"] = "Life Tap",

		["Prayer of Healing"] = "Gebet der Heilung",
		["Shadow Word: Pain"] = "Schattenwort: Schmerz",
		["Mind Flay"] = "Gedankenschinden",
		["Mind Blast"] = "Gedankenschlag",
		["Smite"] = "Göttliche Pein",
		["Holy Fire"] = "Heiliges Feuer",
		["Holy Nova"] = "Heilige Nova",
		["Power Word: Shield"] = "Machtwort: Schild",
		["Desperate Prayer"] = "Verzweifeltes Gebet",
		["Lesser Heal"] = "Geringes Heilen",
		["Heal"] = "Heilen",
		["Flash Heal"] = "Blitzheilung",
		["Greater Heal"] = "Große Heilung",
		["Devouring Plague"] = "Verschlingende Seuche",
		["Renew"] = "Erneuerung",
		["Starshards"] = "Sternensplitter",

		["Healing Touch"] = "Heilende Berührung",
		["Tranquility"] = "Gelassenheit",
		["Rejuvenation"] = "Verjüngung",
		["Regrowth"] = "Nachwachsen",
		["Starfire"] = "Sternenfeuer",
		["Wrath"] = "Zorn",
		["Insect Swarm"] = "Insektenschwarm",
		["Entangling Roots"] = "Wucherwurzeln",
		["Moonfire"] = "Mondfeuer",
		["Hurricane"] = "Hurrikan",
		["Ravage"] = "Verheeren",
		["Shred"] = "Schreddern",
		["Claw"] = "Klaue",
		["Maul"] = "Zermalmen",
		["Ferocious Bite"] = "Wilder Biss",
		["Swipe"] = "Prankenhieb",

		["Bloodthirst"] = "Blutdurst",
		["Mortal Strike"] = "Tödlicher Stoß",
		["Overpower"] = "Überwältigen",
		["Whirlwind"] = "Wirbelwind",
		["Heroic Strike"] = "Heldenhafter Stoß",
		["Cleave"] = "Spalten",
		["Block"] = "Blocken",
		["Thunder Clap"] = "Donnerknall",
		["Mocking Blow"] = "Spöttischer Schlag",
		["Shield Slam"] = "Schildhieb",

		["Sinister Strike"] = "Finsterer Stoß",
		["Hemorrhage"] = "Blutsturz",
		["Backstab"] = "Meucheln",
		["Ghostly Strike"] = "Geisterhafter Stoß",
		["Ambush"] = "Hinterhalt",
		["Riposte"] = "Riposte",
		["Eviscerate"] = "Ausweiden",

		["Flash of Light"] = "Lichtblitz",
		["Holy Light"] = "Heiliges Licht",
		["Exorcism"] = "Exorzismus",
		["Holy Wrath"] = "Heiliger Zorn",
		["Consecration"] = "Weihe",
		["Hammer of Wrath"] = "Hammer des Zorns",
		["Seal of the Crusader"] = "Siegel des Kreuzfahrers",
		["Seal of Command"] = "Siegel des Befehls",
		["Seal of Righteousness"] = "Siegel der Rechtschaffenheit",
		["Holy Shock"] = "Heiliger Schock",

		["Chain Lightning"] = "Kettenblitzschlag",
		["Lightning Bolt"] = "Blitzschlag",
		["Lightning Shield"] = "Blitzschlagschild",
		["Lesser Healing Wave"] = "Geringe Welle der Heilung",
		["Healing Wave"] = "Welle der Heilung",
		["Chain Heal"] = "Kettenheilung",
		["Earth Shock"] = "Erdschock",
		["Flame Shock"] = "Flammenschock",
		["Frost Shock"] = "Frostschock",
		["Magma Totem"] = "Totem der glühenden Magma",
		["Searing Totem"] = "Totem der Verbrennung",
		["Healing Stream Totem"] = "Totem des heilenden Flusses",

		["Arcane Shot"] = "Arkaner Schuss",
		["Serpent Sting"] = "Schlangenbiss",
		["Mend Pet"] = "Tier heilen",
		["Multi-Shot"] = "Mehrfachschuss",
		["Volley"] = "Salve",
		["Aimed Shot"] = "Gezielter Schuss",
		["Scatter Shot"] = "Streuschuss",
		["Raptor Strike"] = "Raptorstoß",
		["Auto Shot"] = "Automatischer Schuss",

		["Attack"] = "Angreifen",
		["Shoot"] = "Schießen",
	},
	
	
-- Appears on the advanced tab, left side matches spell data (do not translate), right side equals display text
-- Talent Namen Stark gekürtzt, DIENT NUR ZUR ANZEIGE

	TalentTranslator = {
-- Warlock
		{ id="suppression", translated="Unterdrück." },
		{ id="impcorrupt", translated="Verderbniss" },
		{ id="impdrainlife", translated="Seelendieb" },
		{ id="impcoa", translated="Fluch der Pein" },
		{ id="shadowmastery", translated="Schattenbeh." },
		{ id="demonicembrace", translated="Umarmung" },
		{ id="impsearing", translated="Schmerz" },
		{ id="impimmolate", translated="Feuerbrand" },
		{ id="emberstorm", translated="Glutsturm" },
		{ id="devastation", translated="Verwüstung" },
		{ id="ruin", translated="Verderben" },
-- Mage
		{ id="subtlety", translated="Feingefühl" },
		{ id="focus", translated="Arkaner Fokus" },
		{ id="clearcast", translated="Konzentration" },
		{ id="meditation", translated="Meditation" },
		{ id="arcanemind", translated="Arkaner Geist" },
		{ id="instab", translated="Instabilität" },
		{ id="impfire", translated="Feuerball" },
		{ id="ignite", translated="Entzünden" },
		{ id="incinerate", translated="Verbrennen" },
		{ id="impflame", translated="Flammenstoß" },
		{ id="critmass", translated="Krit. Masse" },
		{ id="firepower", translated="Feuermacht" },
		{ id="impfrost", translated="Frostblitz" },
		{ id="shards", translated="Eissplitter" },
		{ id="piercice", translated="Stechend.Eis" },
		{ id="chanelling", translated="Frost-Kanal." },
		{ id="shatter", translated="Zertrümmern" },
		{ id="impcoc", translated="Kältekegel" },
-- Mage2
		{ id="subtlety", translated="Feingefühl" },
		{ id="focus", translated="Arkaner Fokus" },
		{ id="clearcast", translated="Konzentration" },
		{ id="impae", translated="IAE" },
		{ id="meditation", translated="Meditation" },
		{ id="arcanemind", translated="Arkaner Geist" },
		{ id="instab", translated="Instabilität" },
		{ id="impfire", translated="Feuerball" },
		{ id="ignite", translated="Entzünden" },
		{ id="incinerate", translated="Verbrennen" },
		{ id="impflame", translated="Flammenstoß" },
		{ id="burnsoul", translated="Brennende Seele" },
		{ id="masterofelements", translated="MeisterElem." },
		{ id="critmass", translated="Krit. Masse" },
		{ id="firepower", translated="Feuermacht" },
		{ id="impfrost", translated="Frostblitz" },
		{ id="elemprec", translated="Elementarfokus" },
		{ id="shards", translated="Eissplitter" },
		{ id="piercice", translated="Stechend.Eis" },
		{ id="chanelling", translated="Frost-Kanal." },
		{ id="shatter", translated="Zertrümmern" },
		{ id="impcoc", translated="Kältekegel" },
-- Hunter
		{ id="lethalshots", translated="Tödl. Schüsse" },
		{ id="mortalshots", translated="Todbr. Schüsse" },
		{ id="rws", translated="Distanzwaffen" },
		{ id="barrage", translated="Sperrfeuer" },
		{ id="humanoidslaying", translated="Humanoidentöten" },
		{ id="monsterslaying", translated="Monstertöten" },
		{ id="savagestrikes", translated="Wilde Schläge" },
		{ id="survivalist", translated="Überlebens." },
		{ id="killerinstinct", translated="Tötungstrieb" },
		{ id="reflexes", translated="Blitz. Reflexe" },
-- Priest
		{ id="imppwrword", translated="Schild" },
		{ id="pmeditation", translated="Meditation" },
		{ id="mentalagility", translated="Ment. Beweg." },
		{ id="mentalstrength", translated="Ment.Stärke" },
		{ id="forceofwill", translated="Willensmacht" },
		{ id="imprenew", translated="Erneuerung" },
		{ id="holyspec", translated="Glauben" },
		{ id="divinefury", translated="Göttlicher Furor" },
		{ id="imphealing", translated="Heilung" },
		{ id="searinglight", translated="Seng. Licht" },
		{ id="guidance", translated="Geist. Führung" },
		{ id="imppoh", translated="Gebet Heilung" },
		{ id="spiritual", translated="Heilung" },
		{ id="shadowfocus", translated="Schatten Fokus" },
		{ id="darkness", translated="Dunkelheit" },
-- Warrior
		{ id="impoverpower", translated="Überwältigen" },
		{ id="impale", translated="Durchbohren" },
		{ id="twohandspec", translated="Zweihand" },
		{ id="axespec", translated="Axt" },
		{ id="polearmspec", translated="Stangenwaffe" },
		{ id="cruelty", translated="Grausamkeit" },
		{ id="onehandspec", translated="Einhand" },
-- Shaman
		{ id="lightningmast", translated="Lightning" },
		{ id="elemfocus", translated="Elem Focus" },
		{ id="convection", translated="Convection" },
		{ id="concussion", translated="Erschütterung" },
		{ id="callofthunder", translated="Donnerruf" },
		{ id="fury", translated="Elementarfuror" },
		{ id="impcl", translated="Kettenschlag" },
		{ id="ancestral", translated="Ahnen Wissen" },
		{ id="thundering", translated="Donnernde Stöße" },
		{ id="impls", translated="Blitz Schild" },
		{ id="imphealingwave", translated="Heilung" },
		{ id="tidalfocus", translated="Gezeiten-Fokus" },
		{ id="tidalmastery", translated="Beherrschung" },
		{ id="purification", translated="Läuterung" },
		{ id="natguid", translated="Natures Guid" },
		{ id="weaponmast", translated="Weapon" },
-- Druid
		{ id="impwrath", translated="Zorn" },
		{ id="impmoon", translated="Mondfeuer" },
		{ id="vengeance", translated="Rache" },
		{ id="impstarfire", translated="Sternenfeuer" },
		{ id="grace", translated="Natur Anmut" },
		{ id="moonfury", translated="Mondfuror" },
		{ id="natweapons", translated="Wildheit" },
		{ id="claws", translated="Klauen" },
		{ id="strikes", translated="Raubtier" },
		{ id="savagefury", translated="Ungez.Wut" },
		{ id="hotw", translated="HerzWildness" },
		{ id="imptouch", translated="Berührung" },
		{ id="reflection", translated="Reflexion" },
		{ id="tranquil", translated="Gelassenheit" },
		{ id="imprejuve", translated="Verjüngung" },
		{ id="giftofnat", translated="GeschenkNatur" },
		{ id="impregrowth", translated="Nachwachsen" },
-- Paladin
		{ id="divineint", translated="Weisheit" },
		{ id="divinestrength", translated="Stärke" },
		{ id="illumination", translated="Illumination" },
		{ id="holypower", translated="Heilige Macht" },
		{ id="conviction", translated="Überzeugung" },
-- Rogue
		{ id="malice", translated="Tücke" },
		{ id="lethality", translated="Tödlichkeit" },
		{ id="impbs", translated="Meucheln" },
		{ id="daggerspec", translated="Dolch" },
		{ id="fistspec", translated="Faustwaffen" },
		{ id="aggression", translated="Aggression" },
		{ id="opportunity", translated="Gelegenheit" },
		{ id="impambush", translated="Hinterhalt" },
	},
-- Needs translating for the predefined sets to have set bonuses
	SetTranslator = {
		{ id="Magisters", translated="Ornat des Magister" },
		{ id="Sorcerers", translated="Ornat der Zauberkünste" },
		{ id="Arcanist", translated="Ornat des Arkanisten" },
		{ id="Netherwind", translated="Ornat der Unterwelt" },

		{ id="Dreadmist", translated="Nebel der Furcht" },
		{ id="Deathmist", translated="Roben des Todesnebels" },
		{ id="Felheart", translated="Teufelsherzroben" },
		{ id="Nemesis", translated="Roben der Nemesis" },

		{ id="Devout", translated="Gewänder des Gläubigen" },
		{ id="Virtuous", translated="Gewänder des Tugendhaften" },
		{ id="Prophecy", translated="Gewänder der Prophezeiung" },
		{ id="Transcendence", translated="Gewänder der Erhabenheit" },

		{ id="Wildheart", translated="Herz der Wildnis" },
		{ id="Feralheart", translated="Ungezähmtes Herz" },
		{ id="Cenarion", translated="Gewänder des Cenarius" },
		{ id="Stormrage", translated="Gewänder des Stormrage" },

		{ id="Elements", translated="Die Elemente" },
		{ id="Five Thunders", translated="Die fünf Donner" },
		{ id="Earthfury", translated="Die Wut der Erde" },
		{ id="Ten Storms", translated="Die Zehn Stürme" },
			
		{ id="Lightforge", translated="Esse des Lichts" },
		{ id="Soulforge", translated="Rüstung der Seelenschmiede" },
		{ id="Lawbringer", translated="Rüstung der Gerechtigkeit" },
		{ id="Judgement", translated="Rüstung des Richturteils" },

		{ id="Valor", translated="Schlachtrüstung der Ehre" },
		{ id="Heroism", translated="Schlachtrüstung des Heldentums" },
		{ id="Might", translated="Schlachtrüstung der Macht" },
		{ id="Wrath", translated="Schlachtrüstung des Zorns" },

		{ id="Shadowcraft", translated="Rüstung des Schattens" },
		{ id="Darkmantle", translated="Rüstung der Finsternis" },
		{ id="Nightslayer", translated="Der Nachtmeuchler" },
		{ id="Bloodfang", translated="Blutfangrüstung" },

		{ id="Beaststalker", translated="Rüstung des Bestienjägers" },
		{ id="Beastmaster", translated="Rüstung der Tierherrschaft" },
		{ id="Giantstalker", translated="Rüstung des Riesenjägers" },
		{ id="Dragonstalker", translated="Rüstung des Drachenjägers" },
	},
}

TheoryCraft_CheckButtons = {
	["embedstyle1"]	= { short = "DPS | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPS/HPS on the left and Crit chance on the right.", descriptionmelee="For melee, will only show your crit chance above\nthe description of each ability." },
	["embedstyle2"]	= { hide = {"ROGUE", "WARRIOR"}, short = "DPM | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPM/HPM on the left and Crit chance on the right." },
	["embedstyle3"]	= { hide = {"ROGUE", "WARRIOR"}, short = "DPS/HPM | Crit", description = "Adds an extra line in the middle of the tooltip,\nwith DPS/HPM on the left and Crit chance on the right." },
	["titles"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Titel", description = "Zeit Kategorien für die erweiterten Tooltip Infos an." },
	["embed"] = 	{ short = "Einbinden", description = "Verändert die Beschreibung deiner Zauber um die Effekte deiner Ausrüstung einzubinden.", descriptionmelee = "Verändert die Beschreibung deiner Fähigkeiten um 'Schaden plus X' durch Gesamtschaden zu ersetzen." },
	["crit"] = 	{ short = "Krit", description = "Fügt deine Krit Rate zur Zauber Beschreibung hinzu.\nEnthählt Talente, Ausrüstung und Grund Krit Rate (Int/$cr).", descriptionmelee = "Fügt deinen Krit Schaden und deine Krit Chance zum Fähigkeiten Tooltip." },
	["critdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Krit Schaden", description = "Zeigt den Schadens Bereich deiner kritischen Schläge." },
	["rollignites"]={ hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN", "HUNTER" }, short = "Rolling Ignites", description = "All calculations that include critical strikes\nwill factor in rolling ignites. That is where\nignite procs whilst ignite is already on the target,\nresetting the timer but adding to the damage." },
	["sepignite"] = { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN", "HUNTER" }, short = "Seperate Ignite", description = "Seperates the ignite component from your crit damage." },
	["dps"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "DPS", description = "Fügt Schaden pro Sekunde Zauberzeit zum Tooltip.\nFür Spontanzauber gilt die allgemeine Abklingzeit von 1.5 Sekunden.", descriptionmelee = "Zeigt an, um wieviel sich dein DPS erhöht, wenn die Fähigkeit jedes mal benutzt wird, wenn die Abklingzeit verstrichen ist." },
	["combinedot"]= { hide = {"ROGUE", "WARRIOR"}, short = "Kombiniere DoT", description = "If enabled, spells that have both a \ndirect component and an over time component will have\nthe DoT DPS expressed as (DPS+DoT)/Casttime\n rather then DoT/Duration." },
	["dotoverct"] = { hide = {"ROGUE", "WARRIOR"}, short = "DoT/Zauberzeit", description = "DoTs will have their DPS as Total Damage / Cast time, \nrather then Total Damage / DoT Duration" },
	["hps"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "HPS", description = "Is calculated the same way as DPS,\nwith the same extended options." },
	["dpsdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "DPS von +Schaden", description = "How much of your DPS/HPS is from your +damage gear." },
	["averagedam"] ={short = "Ø Treffer", description = "Adds the spells average hit to your tooltips.", descriptionmelee = "Adds your average damage to your ability tooltips." },
	["procs"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Include Procs", description = "All Proc based effects (Wrath of Cenarius, Darkmoon Trinket, Netherwind)\neffects are averaged instead of only being applied while the buff is active." },
	["mitigation"] 	= { hide = {"STRIPPED"}, short = "Enable Mitigation", description = "If enabled your targets armor will be included in TC's calculations.\nYou can view a mobs armor by typing in /tc armor 'mob name', or\njust leaving it blank to list all known mobs." },
	["resists"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Resists", description = "Adds a resists category to the tooltip.\nThis includes the resist rate of your *target* and\nyour dps after level-based resists are accounted for.\nIf you have any Spell Penetration gear it'll also\ntell you how much dps your penetration gear adds.\nNote that unless your target has a resist score equal to\nor higher then your penetration score, this dps\npenetrated won't be achieved." },
	["averagethreat"] = { hide = {"ROGUE", "WARRIOR", "SHAMAN", "HUNTER", "DRUID", "WARLOCK", "PRIEST", "MAGE"}, short = "Average Threat", description = "The average threat caused by the attack." },
	["plusdam"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Schaden", description = "+Damage for that spell, before the +dam coefficient." },
	["damcoef"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Schaden Koeffizient", description = "+Damage coefficient for that spell.\nWill be modified by applicable talents." },
	["dameff"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "+Schaden Effizienz", description = "The +damage system is based on 3.5 +damage = +1dps, before crits.\nIf the spell gets this, then the efficiency will be 100%." },
	["damfinal"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Gesamt +Schaden", description = "+Damage added to the spell after the +dam coefficient." },
	["healanddamage"] = { hide = {"ROGUE", "WARRIOR", "MAGE", "SHAMAN", "HUNTER", "DRUID"}, short = "Zeige Heil Anteil", description = "If enabled spells that both damage and heal will\nhave both components listed seperately.\nNormally only the damage component will be shown." },
	["nextagi"] = 	{ hide = {"MAGE", "WARLOCK", "PRIEST", "PALADIN", "SHAMAN" }, short = "+10 Beweglichkeit", description = "Zeigt um wieviel der Nahkampfschaden erhöht wird.", descriptionmelee = "Shows how much 10 agility will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextstr"] = 	{ hide = {"MAGE", "WARLOCK", "PRIEST", "PALADIN", "SHAMAN" }, short = "+10 Stärke", description = "Zeigt um wieviel der Nahkampfschaden erhöht wird.", descriptionmelee = "Shows how much 10 strenght will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextcrit"] = 	{ short = "+1% Krit", description = "Shows how much another 1% chance to crit will add to your *average damage*\nalong with how much +damage gear would be equivelant", descriptionmelee = "Shows how much +1% to crit will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nexthit"] = 	{ short = "+1% Treffer", description = "Shows how much another 1% chance to hit will add to your *average damage*\nalong with how much +damage gear would be equivelant.", descriptionmelee = "Shows how much +1% to hit will add to your average damage,\nalong with how much attack power would provide an equivelant boost." },
	["nextpen"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "Next 10 Penetration", description = "If the target has a higher resistance score then your\npenetration score, your average damage will be\nlower then what TC says. Having an extra 10 penetration\nwill increase your actual average damage closer to TC's\ncalculated value, by the amount shown.\nTC will also tell you how much extra +damage\nwould increase your actual damage by the same amount." },
	["mana"] =	{ hide = {"ROGUE", "WARRIOR"}, short = "Echte Mana Kosten", description = "Adds the true mana cost of your spell to the tooltip.\nIf a spell costs 30 mana, and you regenerate 40 mana\nwhilst casting it then this will be negative.\nIt is effected by things like mana regen whilst casting,\nshaman earthfury bonus, paladin's illumination talent, etc.\nAll internal calculations go off this value." },
	["dpm"] = 	{ hide = {"ROGUE", "WARRIOR"}, short = "DPM", description = "Average Damage divided by True Mana Cost" },
	["hpm"] = { hide = {"ROGUE", "WARRIOR"}, short = "HPM", description = "Average Heal divided by True Mana Cost" },
	["max"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Max bis oom", description = "Shows how much damage/healing you can do before going oom,\nchaincasting the spell including all normal forms of regen." },
	["maxevoc"] 	= { hide = {"ROGUE", "WARRIOR", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN", "HUNTER" }, short = "Max bis oom (gem+evoc)", description = "Same as 'Max til oom', but includes two mage abilities to regen mana." },
	["lifetap"] 	= { hide = {"ROGUE", "WARRIOR", "MAGE", "SHAMAN", "HUNTER", "DRUID", "PRIEST", "PALADIN"}, short = "Aderlass Werte", description = "DPS, DPM, HPS, HPM if enabled will have\nadditional info for if you're using Lifetap.\nTakes in to account the global cooldown." },
	["buttontext"] 	= { short = "Button Text einschalten", description = "TheoryCraft can show values on your Action Buttons.\nThis option will enable the feature.\n\nNote: Only supports the default Blizzard, Discord, Nurfed and Flex Action Bars, along with the Spellbook." },
	["tryfirst"] 	= { short = "Standard Button Text", description = "The default value to show on your Action Buttons." },
	["trysecond"] 	= { short = "Alternativer Button Text", description = "If the default value is nil, TheoryCraft will\ntry to show this value." },
	["tryfirstsfg"]	= { short = "Default Significant Figures", description = "How much the text value should be rounded by.\nA value of 100 will show the number 353 as 400." },
	["trysecondsfg"]= { short = "Alt Significant Figures", description = "How much the text value should be rounded by.\nA value of 100 will show the number 353 as 400." },
	["framebyframe"]= { short = "Frame für Frame", tooltiptitle = "Force Frame by Frame", description = "Forces button text to be generated one button per frame, instead of all at once.\nNormally this is only done only in combat, as each button is virtually instant to\ngenerate.  On very slow computers you may wish to force TC to always generate\nbuttons this way, by ticking this checkbox." },
	["outfit"] 	= { short = " ", tooltiptitle = "Outfit", description = "TheoryCraft allows you to test different sets of gear.\nAny of the 8-9 piece class sets can be tested (with\nyour gear making up the other slots), or you can\nmix and match gear of your choice by selecting\nthe 'Custom' set." },
	["showsimult"] 	= { short = "Vergleichs Modus", description = "If checked, your current stats and your outfits/talents stats\nwill be shown simulatenously on the tooltip." },
	["dontcrit"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Ohne Krits", description = "If checked crits won't be included in calculated values (eg: dpm/hpm/dps).\nThis will also disable illumination, master of elements and natures grace bonuses." },
	["dontresist"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Factor resists", description = "If checked, level-based and resistance-based resists will be factored\nfor all calculated values (eg: dpm/hpm/dps).\nResists can be set below." },
	["useglock"] 	= { hide = {"ROGUE", "WARRIOR"}, short = "Use GLOCK", description = "GLOCK is an external addon that calculates Mob's resistances from combat.\nIf checked, and GLOCK is enabled, these values can be used by TheoryCraft\nto provide the most accurate statistics available for your target.\n\nWith this option enabled, the edit boxes below are regularly overwritten." },
}

-- Used for schoolname in the buffs/equips.  Wherever schoolname appears, it'll try each "text" value,
-- and the amount will be added to the "name" value.  "text" should be localised, "name" should not.

TheoryCraft_PrimarySchools = {
	{ name = "Frost",	text = "Frost" },
	{ name = "Nature",	text = "Natur" },
	{ name = "Fire",	text = "Feuer" },
	{ name = "Arcane",	text = "Arkan" },
	{ name = "Shadow",	text = "Schatten" },
	{ name = "Holy",	text = "Heilig" },
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
-- working
	{ text="Von Euch zugefügter Schattenschaden um (%d+)%% erhöht%.", type="Shadowbaseincrease", amount="n/100" },			-- Shadowform
	{ text="Stellt (%d+) Mana alle 5 Sek%. wieder her%.", type="manaperfive" }, 						-- Blessing of Wisdom/Nightfin soup

-- checking needed
	{ text="Erhöht die kritische Trefferchance von Zaubern um (%d+)%%%.", type="Allcritchance" },		-- Moonkin Aura
	{ text="Verursachter Magieschaden und Heilung um (%d+) Punkt%(e%) erhöht%.", type="All" },			-- ToEP
	{ text="Heilung um bis zu (%d+) erhöht%.", type="Healing" },										-- ZHC Healing
	{ text="Zauberschaden um bis zu (%d+) erhöht%.", type="Damage" }, 									-- Flask of Supreme Power / ZHC Damage
	{ text="Erhöhter Schaden und erhöhte Manakosten für Eure Zauber%.", type="Damagemodifier", amount=0.35 },		-- Arcane Power
	{ text="Um %d+ erhöhter Widerstand gegen alle Arten von Magie und jederzeit (%d+)%% der normalen Manaregeneration%.", type="ICPercent", amount="n/100" },		-- Mage Armor
	{ text="Zaubertrefferchance um (%d+)%% erhöht%.", type="Allhitchance" },										-- Pagles kaputte Spule
	{ text="Die Manakosten Eures nächsten Zaubers sind um 100%% verringert%.", type="Holycritchance", amount=25 },	-- Inner Focus
	{ text="100%% der Manaregeneration", type="ICPercent", amount=4 }, 												-- Innervate

-- needs translation
	{ text="Ignore (%d+) of enem.+armor", type="Sunder" },   													-- Bonereaver's Edge
	{ text="Increases Healing Wave's effect by up to (%d+)%%.", type="Healing Wavetalentmod", amount="n/100" }, -- Healing Way
	{ text="Restores (%d+)%% of total Mana every 4 sec%.", type="FelEnergy", amount="n/100" },   				-- Fel Energy
	{ text="Magical damage dealt.-increase.-(%d+)", type="All" },   											-- Very Berry/Eye of Moam
	{ text="Magical resistances of your spell targets reduced by (%d+)", type="Allpenetration" },   			-- Eye of Moam
	{ text="Increases damage and healing done by magical spells and effects by up to (%d+)%.", type="All" },   	-- Elements/Five Thunders
	{ text="Melee attack power increased by (%d+)%. Melee attacks are %d+%% faster, but deal less damage%.", type="AttackPowerCrusader" }, -- Seal of the crusader
	{ text="(%d+) mana regen per tick%.", type="manaperfive" },										-- Warchief's blessing
	{ text="Gain (%d+) mana every 2 seconds%.", type="manaperfive", amount="totem" },				-- Totems
	{ text="Receives up to (%d+) extra healing from Holy Light spells", type="Holy Light", amount="hl", target = "target"},	-- Blessing of light
	{ text="(%d+) extra healing from Flash of Light spells%.", type="Flash of Light", amount="fol", target = "target" },	-- Blessing of light
	{ text="Holy Shock spell increased by 100%%", type="Holycritchance", amount=100 },							-- Divine Favour
	{ text="Holy Shock spell increased by 100%%", type="Holy Shockcritchance", amount=100 },					-- Divine Favour
	{ text="Increases critical strike chance from Fire damage spells by (%d+)%%", type="Firecritchance" },		-- Combustion in 1.11
	{ text="Spell effects increased by (%d+)%.", type="All" },													-- Spell Blasting
	{ text="Increases healing done by spells and effects by up to (%d+) for %d+ sec%.", type="Healing" },		-- Blessed Prayer
	{ text="Increases damage by (%d+)%%%.", type="Allbaseincrease", amount=0.05 },						-- Sayge's fortune
	{ text="Increases damage by (%d+)%%%.", type="Meleebaseincrease", amount=0.05 },					-- Sayge's fortune
	{ text="Fire damage increased by (%d+)%%%.", type="Firebaseincrease", amount="n/100" },				-- Burning Wish Demonic Sacrifice Imp
	{ text="Increases damage caused by (%d+)%%%.", type="Allbaseincrease", amount="n/100" },			-- Master Demonologist Succubus
	{ text="Shadow damage increased by (%d+)%%%.", type="Shadowbaseincrease", amount="n/100" },			-- Touch of Shadow Demonic Sacrifice Succubus
	{ text="Melee damage increased by (%d+)%%%.", type="Meleebaseincrease", amount="n/100" },			-- Enrage
	{ text="schoolname spell damage increased by up to (%d+)%." },										-- Elixir of frost power
	{ text="Increases spell fire damage by up to (%d+)%.", type="Fire" },								-- Elixir of greater firepower
	{ text="Spell damage and healing done increased by (%d+)%%%.", type="Allbaseincrease", amount="n/100" },	-- Power Infusion
	{ text="Mana Regeneration increased by (%d+) every 5 seconds%.", type="manaperfive" }, 				-- Safefish Well Fed
	{ text="In addition, both the demon and master will inflict (%d+)%% more damage%.", type="Allbaseincrease", amount="n/100" },	-- Soul Link
}

TheoryCraft_Debuffs = {
-- working
	{ text="Distanzangriffskraft aller Angreifer gegen dieses Ziel um (%d+)%.", type="huntersmark" },				-- Hunter's Mark
	{ text="Erhöht erlittenen Schattenschaden um (%d+)%%%.", type="Shadowbaseincrease", amount="n/100" },			-- Shadow Weaving
-- needs translation
	{ text="Armor decreased by (%d+)%.", type="Sunder" },   														-- Sunder Armor
	{ text="Armor decreased%.", type="DontMitigate", amount=1 },													-- Expose Armor
	{ text="Frost spells have a (%d+)%% additional chance to critically", type="Frostcritchance" },  	 			-- Winter's Chill
	{ text="Reduces Fire and Frost resistances by (%d+)%.", type="Firepenetration" },								-- Curse of the Elements
	{ text="Reduces Fire and Frost resistances by (%d+)%.", type="Frostpenetration" },								-- Curse of the Elements
	{ text="Increases Fire and Frost damage taken by (%d+)%%%.", type="Firebaseincrease", amount="n/100" },			-- Curse of the Elements
	{ text="Increases Fire and Frost damage taken by (%d+)%%%.", type="Frostbaseincrease", amount="n/100" },		-- Curse of the Elements
	{ text="Shadow and Arcane damage taken increased by (%d+)%%%.", type="Shadowbaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="Shadow and Arcane damage taken increased by (%d+)%%%.", type="Arcanebaseincrease", amount="n/100" },	-- Curse of shadows
	{ text="Reduces Shadow and Arcane resistances by (%d+)%.", type="Shadowpenetration" },							-- Curse of Shadows
	{ text="Reduces Shadow and Arcane resistances by (%d+)%.", type="Arcanepenetration" },							-- Curse of Shadows
	{ text="Increases Holy damage taken by up to (%d+)%%.", type="Holy" },											-- Judgement of Crusader
	{ text="Frozen in place%.", type="doshatter", amount=1 },														-- Frost Nova
	{ text="Frozen%.", type="doshatter", amount=1 },																-- Freezing Band?
	{ text="Increases Fire damage taken by (%d+)%%%.", type="Firebaseincrease", amount="n/100" },					-- Improved Scorch
}

-- Dot Duration is read from here

TheoryCraft_DotDurations = {
	{ text=" hält (%d+) Sek%.", amount="n" },				-- Hurrikan (alle 2 Sekunden)
	{ text=" (%d+) Sek%.", amount="n" },					-- Einer für alle (One for all)	
	{ text=" nach 1 Minute%.", amount="60"} 				-- Fluch der Verdammnis (Curse of Doom)
}

-- Checks every line for these

TheoryCraft_EquipEveryRight = {
	{ text="^Geschwindikkeit (%d+%.?%d+)", type="OffhandSpeed", slot="SecondaryHand" },	-- Weapon Damage
	{ text="^Geschwindigkeit (%d+%.?%d+)", type="MainSpeed", slot="MainHand" },			-- Weapon Damage
	{ text="^Geschwindigkeit (%d+%.?%d+)", type="RangedSpeed", slot="Ranged" },			-- Weapon Damage
	{ text="^Dolch", type="MeleeAPMult", amount=-0.7, slot="MainHand" },				-- Weapon Damage
	{ text="^Dolch", type="DaggerEquipped", amount=1, slot="MainHand" }	,				-- Used for dagger spec
	{ text="^Faustwaffe", type="FistEquipped", amount=1, slot="MainHand" },				-- Used for fist spec
	{ text="^Axt", type="AxeEquipped", amount=1, slot="MainHand" },						-- Used for Axe Spec
	{ text="^Stangenwaffe", type="PolearmEquipped", amount=1, slot="MainHand" },		-- Used for Polearm Spec
	{ text="^Schild", type="ShieldEquipped", amount=1, slot="SecondaryHand" },			-- Used for Block
}

TheoryCraft_EquipEveryLine = {
-- patch 1.12
	{ text="%+(%d+) Heilzauber", type="Healing" },										-- of healing items
	{ text="Heilzauber %+(%d+)", type="Healing" },								-- zg priest and healing enchant


--working
	{ text="^(%d+) Blocken", type="BlockValueReport" }, 							-- Blocken (Schild)
	{ text="Zaubertrefferchance %+(%d+)%%", type="Allhitchance" },					-- Trefferchance
	{ text="schoolnameschaden +(+%d+)" },											-- AQ Glove enchants
	{ text="%+(%d+) Zauberschaden", type="Damage", me=1 }, 							-- Spell Damage +30 enchant
	{ text="Heilung und Zauberschaden %+(%d+)", type="All", me=1 },					-- zg enchant
	{ text="%+(%d+) Schadens%- und Heilzauber", type="All" },						-- of sorcery items

--checking needed
	{ text="Ranged Attack Power %+(%d+)", type="RangedAttackPowerReport" }, 		-- Hunter Leg/Helm enchant
	{ text="%+(%d+) Angriffskraft", type="AttackPowerReport" }, 					-- Angriffsgraft
	{ text="Verursacht (%d+%.?%d+) zusätzlichen Schaden pro Sekunden", type="AmmoDPS", slot="Ammo" },	-- Pfeile
	{ text="Waffenhand", type="MeleeAPMult", amount="2.4", slot="MainHand" },		-- Weapon Damage
	{ text="Einhändig", type="MeleeAPMult", amount="2.4", slot="MainHand" },		-- Weapon Damage
	{ text="Zweihändig", type="MeleeAPMult", amount="3.3", slot="MainHand" },		-- Weapon Damage
	{ text="(%d+) %- %d+", type="RangedMin", slot="Ranged" },						-- Weapon Ranged Damage Min
	{ text="%d+ %- (%d+)", type="RangedMax", slot="Ranged" }, 						-- Weapon Ranged Damage Max
	{ text="Scope %(%+(%d+) Damage%)", type="RangedMin", slot="Ranged" },			-- Weapon Damage enchant
	{ text="Scope %(%+(%d+) Damage%)", type="RangedMax", slot="Ranged" },			-- Weapon Damage enchant
	{ text="(%d+) %- %d+", type="MeleeMin", slot="MainHand" },						-- Weapon Damage
	{ text="%d+ %- (%d+)", type="MeleeMax", slot="MainHand" }, 						-- Weapon Damage
	{ text="Waffenschaden %+(%d+)", type="MeleeMin", slot="MainHand" },				-- Weapon Damage enchant
	{ text="Waffenschaden %+(%d+)", type="MeleeMax", slot="MainHand" },				-- Weapon Damage enchant
	{ text="(%d+) %- %d+", type="OffhandMin", slot="SecondaryHand" },				-- Weapon Damage
	{ text="%d+ %- (%d+)", type="OffhandMax", slot="SecondaryHand" }, 				-- Weapon Damage
	{ text="Waffenschaden %+(%d+)", type="OffhandMin", slot="SecondaryHand" },		-- Weapon Damage enchant
	{ text="Waffenschaden %+(%d+)", type="OffhandMax", slot="SecondaryHand" },		-- Weapon Damage enchant

	{ text="%+(%d+) schoolname Zauberschaden" },									-- of wrath items
	{ text="%+(%d+) Heilung", type="Healing" },										-- of healing items
	{ text="schoolname Zauberschaden %+(%d+)", me=1 }, 								-- Winter's Might
	{ text="Heilungszauber %+(%d+)", type="Healing" },								-- zg priest and healing enchant
	{ text="%+(%d+) Zauberschaden und Heilung", type="All" }, 						-- not sure
	{ text="Stellt 375 bis 625 Punkt%(e%) Mana wieder her%.", type="manarestore", amount="500" },    -- Robe of the Archmage
	{ text="Zaubertreffer %+(%d+)%%", type="Allhitchance" },						-- zg enchant
	{ text="%/Treffer %+(%d+)%%", type="Meleehitchance" },							-- Hunter Leg/Helm enchant

	{ text="Stellt alle 5 Sek%. (%d+) Punkt%(e%) Mana", type="manaperfive" },		-- Mana Regeneration
	{ text="Manaregeneration %+(%d+)/", type="manaperfive" },						-- zg enchant
	{ text="Manaregeneration (%d+) per 5 Sek%.", type="manaperfive" },				-- bracers healing enchant
	
	{ text="Zandalarianisches Siegel der Macht", type="AttackPowerReport", value = 30 },
	{ text="Zandalarianisches Siegel des Mojo", type="All", value = 18 },
	{ text="Zandalarianisches Siegel der Inneren Ruhe", type="Heal", value = 33 },
	
	{ text="^Hervorragendes Manaöl", type="manaperfive", amount="12" }, 			-- Enchanting oils
	{ text="^Hervorragendes Manaöl", type="Healing", amount="25" }, 				-- Enchanting oils
	{ text="^Hervorragendes Zauberöl", type="Allcritchance", amount="1" }, 			-- Enchanting oils
	{ text="^Hervorragendes Zauberöl", type="Damage", amount="36" },		 		-- Enchanting oils
	{ text="^Schwaches Manaöl", type="manaperfive", amount="4" }, 					-- Enchanting oils
	{ text="^Geringes Manaöl", type="manaperfive", amount="8" },		 			-- Enchanting oils
	{ text="^Schwaches Zauberöl", type="Damage", amount="8" }, 						-- Enchanting oils
	{ text="^Geringes Zauberöl", type="Damage", amount="16" }, 						-- Enchanting oils
	{ text="^Zauberöl", type="Damage", amount="24" }, 								-- Enchanting oils
}

-- Won't check any lines containing the following words (for speed)

TheoryCraft_IgnoreLines = {
	"^Haltbarkeit", "^Seelengebunden", "^Klassen", "^Benötigt", "^%d+ Rüstung", "^Kopf", "^Hals", "^Schulter",
	"^Rücken", "^Brust", "^Handgelenke", "^Hände", "^Taille", "^Beine", "^Füße", "^Finger", "^Schmuck",
	"^Zauberstab", "^In Schildhand geführt", "^Widerstand", "^%+%d+ Ausdauer", "^%+%d+ Intelligenz",
	"^%+%d+ Willenskraft", "^%+%d+ Beweglichkeit", "^%+%d+ Stärke"
}

-- These are handled specially

TheoryCraft_SetsDequipOnly= {
	{ text="Manakosten von Schattenzaubern um %d+%%% verringert%.", type="Shadowmanacost", amount=-0.15 },	-- Teufelsherz
}

-- Checks every line beginning Set: for these

TheoryCraft_Sets = {
-- working (hope so)
	{ text="Ermöglicht, dass (%d+)%% Eurer Manaregeneration während des Zauberwirkens weiterläuft%.", type="ICPercent", amount="n/100" },	-- Erhabenheit
	{ text="Beim Ausführen eines normalen Distanzangriffs besteht eine Chance von 4%%, dass Ihr 200 Mana wiederherstellt%.", type="Beastmanarestore", amount=200 },	-- Bestienjäger
	{ text="Erhöht durch Euren Zauber %'Blutsauger%' abgezogene Gesundheit und durch Euren Zauber %'Mana abziehen%' abgezogenes Mana um 15%% %.", type="Drain Lifeillum", amount=0.15 },	-- Teufelsherz
	{ text="Wenn die Zauber Arkane Geschosse, Feuerball oder Frostblitz gewirkt werden, besteht eine 10%% Chance, dass der nächste Zauber mit einer Spruchdauer unter 10 Sek%. sofort gewirkt wird%.", type="FrostboltNetherwind", amount=1 },	-- Netherwind
	{ text="Wenn die Zauber Arkane Geschosse, Feuerball oder Frostblitz gewirkt werden, besteht eine 10%% Chance, dass der nächste Zauber mit einer Spruchdauer unter 10 Sek%. sofort gewirkt wird%.", type="FireballNetherwind", amount=1 },	-- Netherwind
	{ text="Erhöht die Chance auf einen kritischen Treffer mit Euren Zaubern %'Gebet der Heilung%' um 25%%%.", type="Prayer of Healingcritchance" },	-- Prophezeiung
	{ text="Erhöht Eure Chance, einen kritischen Effekt durch Heiligzauber zu erzielen, um (%d+)%%%.", type="Holycritchance" },	-- Prophezeiung
	{ text="Erhöht den Schaden von %'Mehrfachschuss%' und %'Salve%' um (%d+)%%%.", type="Barragemodifier", amount="n/100"},	-- Riesenjägers
	
-- checking	
	{ text="Improves your chance to get a critical strike with all Shock spells by (%d+)%%%.", type="Shockcritchance" },	-- Shaman Legionnaire set bonus
	{ text="Improves your chance to get a critical strike with Nature spells by (%d+)%%%.", type="Naturecritchance" },	-- ten storms set bonus
	{ text="After casting your Healing Wave or Lesser Healing Wave spell, gives you a 25%% chance to gain Mana equal to 35%% of the base cost of the spell%.", type="EarthfuryBonusmanacost", amount=-0.0875 },	-- earth fury set bonus
	{ text="Chance on spell cast to increase your damage and healing by up to 95 for 10 sec%.", type="All", amount=95, duration=9.9, proc=0.04, exact=1 },	-- Elements
}

-- Checks every line beginning with Equip: or Set: for these

TheoryCraft_Equips = {
-- working (hope so)
	-- schaden/heilung erhöhen
	{ text="Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu (%d+)%.", type="All" },		-- Zauber und Heilung
	{ text="Erhöht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", type="Healing" },	 					-- Heilung
	{ text="Erhöht durch schoolnamezauber und schoolnameeffekte zugefügten Schaden um bis zu (%d+)%." },					-- Arkan bis Schatten
	{ text="Reduziert die Magiewiderstände der Ziele Eurer Zauber um (%d+)%.", type="Allpenetration" },						-- Penetration
	-- mana
	{ text="Stellt alle 5 Sek%. (%d+) Punkt%(e%) Mana wieder her%.", type="manaperfive" },									-- mana per five
	{ text="Wenn ein Zauber erfolgreich gewirkt wurde, besteht eine Chance von 2%%, dass 100%% Eurer Manaregeneration während des Zauberwirkens weiterläuft%. Dauer: 15 Sek%.", type="ICPercent", amount=1, duration=15, proc=0.02, exact=0 },	-- Darkmoon Trinket
	{ text="Stellt 10 Sek%. lang alle 1 Sek%. 30 Punkt%(e%) Mana wieder her%.", type="manarestore", amount="300" },			-- Zweiter Wind
-- krit/hit
	{ text="Erhöht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um (%d+)%%%.", type="Allcritchance" },	-- Zauber Krit
	{ text="Erhöht Eure Chance, einen kritischen Treffer zu erzielen, um (%d+)%%%.", type="CritReport" },					-- Allgemein Krit
	{ text="Erhöht Eure Chance mit Zaubern zu treffen um (%d+)%%%.", type="Allhitchance" },   								-- Treffer
	-- blocken
	{ text="Erhöht den Blockwert Eures Schildes um (%d+)%.", type="BlockValueReport" },										-- Block Wert
	{ text="^(%d+) Blocken", type="BlockValueReport" }, 												-- auch bei EquipEveryLine ... warum?
	-- kraft
	{ text="%+(%d+) Angriffskraft%.", type="AttackPowerReport" }, 							  								-- Angriffskraft
	{ text="%+(%d+) Distanzangriffskraft%.", type="RangedAttackPowerReport" }, 										  		-- Distanzangriffskraft

-- checking needed
	-- krit/hit
	{ text="Erhöht Eure Chance, einen kritischen Treffer durch Heiligzauber zu erzielen, um (%d+)%%%..", type="Holycritchance" },   -- Heilig Krit
	{ text="Erhöht Eure Chance, mit Geschosswaffen einen kritischen Schlag zu erzielen, um (%d+)%.", type="Rangedcritchance" },		-- Distanz Krit
	{ text="Verbessert Eure Trefferchance um (%d+)%%%.", type="Meleehitchance" },   										-- Nahkampftreffer

-- translation needed
	{ text="Undead by magical spells and effects by up to (%d+)%.", type="Undead" }, 	    	    	 					-- Rune of the Dawn
	{ text="Increases healing done by Lesser Healing Wave by up to (%d+)%.", type="Lesser Healing Wave" },					-- Totem of Life
	{ text="Stellt (%d+) Mana alle 5 Sek%.", type="manaperfive" },															-- mana per five
	{ text="Gives a chance when your harmful spells land to increase the damage of your spells and effects by 132 for 10 sec%.", type="All", amount=132, duration=9.9, proc=0.05, exact=1 },	-- Wrath of Cenarius
}

TheoryCraft_WeaponSkillOther = "Unbewaffnet"

-- Used for calcuting real crit chance, off attack skill of your current weapon.
-- English must not be translated. ltext is the text that will be to the left of the weapon type
-- Skill is what skill it matches. (eg Two-Handed Axes)

TheoryCraft_WeaponSkills = {
	{ english="Axe", text="Axt", ltext="Zweihändig", skill="Zweihandäxte" },
	{ english="Sword", text="Schwert", ltext="Zweihändig", skill="Zweihandschwerter" },
	{ english="Mace", text="Streitkolben", ltext="Zweihändig", skill="Zweihandsteitkolben" },
	{ english="Staff", text="Stab", skill="Stäbe" },
	{ english="Axe", text="Axt", skill="Äxte" },
	{ english="Sword", text="Schwert", skill="Schwerter" },
	{ english="Mace", text="Streitkolben", skill="Streitkolben" },
	{ english="Polearm", text="Stangenwaffe", skill="Stangenwaffen" },
	{ english="Dagger", text="Dolch", skill="Dolche" },
	{ english="", text="Angel", skill="Fischen" },
}

-- Slot is the text that appears on the custom form, text needs to be translated. Realslot needs to stay as is.

TheoryCraft_SlotNames = {
	{ realslot="Head", slot="Head", text="Kopf" },
	{ realslot="Neck", slot="Neck", text="Hals" },
	{ realslot="Shoulder", slot="Shoulder", text="Schultern" },
	{ realslot="Back", slot="Back", text="Rücken" },
	{ realslot="Chest", slot="Chest", text="Brust" },
	{ realslot="Shirt", slot="Shirt", text="Hemd" },
	{ realslot="Tabard", slot="Tabard", text="Wappenrock" },
	{ realslot="Wrist", slot="Wrist", text="Handgelenke" },
	{ realslot="Hands", slot="Hands", text="Hände" },
	{ realslot="Waist", slot="Waist", text="Taille" },
	{ realslot="Legs", slot="Legs", text="Beine" },
	{ realslot="Feet", slot="Feet", text="Füße" },
	{ realslot="Finger0", slot="Finger0", text="Finger" },
	{ realslot="Finger1", slot="Finger1", text="Finger" },
	{ realslot="Trinket0", slot="Trinket0", text="Schmuck" },
	{ realslot="Trinket1", slot="Trinket1", text="Schmuck" },
	{ realslot="MainHand", slot="Main", text="Waffenhand" },
	{ realslot="MainHand", slot="Main", text="Einhändig" },
	{ realslot="MainHand", slot="Main", text="Zweihändig", both=true },
	{ realslot="SecondaryHand", slot="Off Hand", text="In Schildhand geführt" },
	{ realslot="SecondaryHand", slot="Off Hand", text="Einhändig" },
	{ realslot="SecondaryHand", slot="Off Hand", text="Schildhand" },
	{ realslot="Ranged", slot="Ranged", text="Zauberstab" },
	{ realslot="Ranged", slot="Ranged", text="Bogen" },
	{ realslot="Ranged", slot="Ranged", text="Schusswaffe" },
	{ realslot="Ranged", slot="Ranged", text="Armbrust" },
	{ realslot="Ranged", slot="Ranged", text="Distanz" },
	{ realslot="Ranged", slot="Ranged", text="Geworfen" },
}

end