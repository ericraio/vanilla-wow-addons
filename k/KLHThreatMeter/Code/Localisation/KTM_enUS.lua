
klhtm.string.data["enUS"] = 
{
	["binding"] = 
	{
		hideshow = "Hide / Show Window",
		stop = "Emergency Stop",
		mastertarget = "Set / Clear Master Target",
		resetraid = "Reset Raid Threat",
	},
	["spell"] = 
	{
		["heroicstrike"] = "Heroic Strike",
		["maul"] = "Maul",
		["swipe"] = "Swipe",
		["shieldslam"] = "Shield Slam",
		["revenge"] = "Revenge",
		["shieldbash"] = "Shield Bash",
		["sunder"] = "Sunder Armor",
		["feint"] = "Feint",
		["cower"] = "Cower",
		["taunt"] = "Taunt",
		["growl"] = "Growl",
		["vanish"] = "Vanish",
		["frostbolt"] = "Frostbolt",
		["fireball"] = "Fireball",
		["arcanemissiles"] = "Arcane Missiles",
		["scorch"] = "Scorch",
		["cleave"] = "Cleave",
		
		-- Items / Buffs:
		["arcaneshroud"] = "Arcane Shroud",
		["reducethreat"] = "Reduce Threat",

		-- Leeches: no threat from heal
		["holynova"] = "Holy Nova", -- no heal or damage threat
		["siphonlife"] = "Siphon Life", -- no heal threat
		["drainlife"] = "Drain Life", -- no heal threat
		["deathcoil"] = "Death Coil",	
		
		-- Fel Stamina and Fel Energy DO cause threat! GRRRRRRR!!!
		--["felstamina"] = "Fel Stamina",
		--["felenergy"] = "Fel Energy",
		
		["bloodsiphon"] = "Blood Siphon", -- poisoned blood vs Hakkar
		
		["lifetap"] = "Life Tap", -- no mana gain threat
		["holyshield"] = "Holy Shield", -- multiplier
		["tranquility"] = "Tranquility",
		["distractingshot"] = "Distracting Shot",
		["earthshock"] = "Earth Shock",
		["rockbiter"] = "Rockbiter",
		["fade"] = "Fade",
		["thunderfury"] = "Thunderfury",
		
		-- Spell Sets
		-- warlock descruction
		["shadowbolt"] = "Shadow Bolt",
		["immolate"] = "Immolate",
		["conflagrate"] = "Conflagrate",
		["searingpain"] = "Searing Pain", -- 2 threat per damage
		["rainoffire"] = "Rain of Fire",
		["soulfire"] = "Soul Fire",
		["shadowburn"] = "Shadowburn",
		["hellfire"] = "Hellfire",
		
		-- mage offensive arcane
		["arcaneexplosion"] = "Arcane Explosion",
		["counterspell"] = "Counterspell",
		
		-- priest shadow. No longer used (R17).
		["mindblast"] = "Mind Blast",	-- 2 threat per damage
		--[[
		["mindflay"] = "Mind Flay",
		["devouringplague"] = "Devouring Plague",
		["shadowwordpain"] = "Shadow Word: Pain",
		,
		["manaburn"] = "Mana Burn",
		]]
	},
	["power"] = 
	{
		["mana"] = "Mana",
		["rage"] = "Rage",
		["energy"] = "Energy",
	},
	["threatsource"] = -- these values are for user printout only
	{
		["powergain"] = "Power Gain",
		["total"] = "Total",
		["special"] = "Specials",
		["healing"] = "Healing",
		["dot"] = "Dots",
		["threatwipe"] = "NPC Spells",
		["damageshield"] = "Damage Shields",
		["whitedamage"] = "White Damage",
	},
	["talent"] = -- these values are for user printout only
	{
		["defiance"] = "Defiance",
		["impale"] = "Impale",
		["silentresolve"] = "Silent Resolve",
		["frostchanneling"] = "Frost Channeling",
		["burningsoul"] = "Burning Soul",
		["healinggrace"] = "Healing Grace",
		["shadowaffinity"] = "Shadow Affinity",
		["druidsubtlety"] = "Druid Subtlety",
		["feralinstinct"] = "Feral Instinct",
		["ferocity"] = "Ferocity",
		["savagefury"] = "Savage Fury",
		["tranquility"] = "Improved Tranquility",
		["masterdemonologist"] = "Master Demonologist",
		["arcanesubtlety"] = "Arcane Subtlety",
		["righteousfury"] = "Righteous Fury",
	},
	["threatmod"] = -- these values are for user printout only
	{
		["tranquilair"] = "Tranquil Air Totem",
		["salvation"] = "Blessing of Salvation",
		["battlestance"] = "Battle Stance",
		["defensivestance"] = "Defensive Stance",
		["berserkerstance"] = "Berserker Stance",
		["defiance"] = "Defiance",
		["basevalue"] = "Base Value",
		["bearform"] = "Bear Form",
		["catform"] = "Cat Form",
		["glovethreatenchant"] = "+Threat Enchant to Gloves",
		["backthreatenchant"] = "-Threat Enchant to Back",
	},
	
	["sets"] = 
	{
		["bloodfang"] = "Bloodfang",
		["nemesis"] = "Nemesis",
		["netherwind"] = "Netherwind",
		["might"] = "Might",
		["arcanist"] = "Arcanist",
	},
	["boss"] = 
	{
		["speech"] = 
		{
			["razorphase2"] = "flee as the controlling power of the orb is drained.",
			["onyxiaphase3"] = "It seems you'll need another lesson",
			["thekalphase2"] = "fill me with your RAGE",
			["rajaxxfinal"] = "Impudent fool! I will kill you myself!",
			["azuregosport"] = "Come, little ones",
			["nefphase2"] = "BURN! You wretches! BURN!",
		},
		-- Some of these are unused. Also, if none is defined in your localisation, they won't be used,
		-- so don't worry if you don't implement it.
		["name"] = 
		{
			["rajaxx"] = "General Rajaxx",
			["onyxia"] = "Onyxia",
			["ebonroc"] = "Ebonroc",
			["razorgore"] = "Razorgore the Untamed",
			["thekal"] = "High Priest Thekal",
			["shazzrah"] = "Shazzrah",
			["twinempcaster"] = "Emperor Vek'lor",
			["twinempmelee"] = "Emperor Vek'nilash",
			["noth"] = "Noth the Plaguebringer",
		},
		["spell"] = 
		{
			["shazzrahgate"] = "Gate of Shazzrah", -- "Shazzrah casts Gate of Shazzrah."
			["wrathofragnaros"] = "Wrath of Ragnaros", -- "Ragnaros's Wrath of Ragnaros hits you for 100 Fire damage."
			["timelapse"] = "Time Lapse", -- "You are afflicted by Time Lapse."
			["knockaway"] = "Knock Away",
			["wingbuffet"] = "Wing Buffet",
			["burningadrenaline"] = "Burning Adrenaline",
			["twinteleport"] = "Twin Teleport",
			["nothblink"] = "Blink",
			["sandblast"] = "Sand Blast",
		}
	},
	["misc"] = 
	{
		["imp"] = "Imp", -- UnitCreatureFamily("pet")
		["spellrank"] = "Rank (%d+)", -- second value of GetSpellName(x, "spell")
		["aggrogain"] = "Aggro Gain",
	},

	-- labels and tooltips for the main window
	["gui"] = { 
		["raid"] = {
			["head"] = {
				-- column headers for the raid view
				["name"] = "Name",
				["threat"] = "Threat",
				["pc"] = "%Max",			-- your threat as a percentage of the #1 player's threat
			},
			["stringshort"] = {
				-- tooltip titles for the bottom bar strings
				["tdef"] = "Threat Margin", -- the difference in threat between you and the MT / #1 in the list.
				["targ"] = "Master Target",
			},
			["stringlong"] = {
				-- tooltip descriptions for the bottom bar strings
				["tdef"] = "",
				["targ"] = "Only threat against %s is being counted towards raid threat values."
			},
		},
		["self"] = {
			["head"] = {
				-- column headers for the self view
				["name"] = "Name",
				["hits"] = "Hits",
				["rage"] = "Rage",
				["dam"] = "Damage",
				["threat"] = "Threat",
				["pc"] = "%T",			-- Abbreviation of %Threat
			},
			-- text on the self threat reset button
			["reset"] = "Reset",
		},
		["title"] = {
			["text"] = {
				-- the window titles
				["long"] = "KTM %d.%d",	-- don't need to localise these
				["short"] = "KTM",
				
			},
			["buttonshort"] = {
				-- the tooltip titles for command buttons
				["close"] = "Close",
				["min"] = "Minimise",
				["max"] = "Maximise",
				["self"] = "Self View",
				["raid"] = "Raid View",
				["pin"] = "Pin",
				["unpin"] = "Unpin",
				["opt"] = "Options",
				["targ"] = "Master Target",
				["clear"] = "Reset",
			},
			["buttonlong"] = {
				-- the tooltip descriptions for command buttons
				["close"] = "Threat data will still be sent if you are in a party or raid",
				["min"] = "",
				["max"] = "",
				["self"] = "Shows personal threat details",
				["raid"] = "Shows raid threat data",
				["pin"] = "Prevents the threatmeter window from being moved",
				["unpin"] = "Allows the threatmeter window to be moved",
				["opt"] = "",
				["targ"] = "Sets the Master Target to your current target. If you do not have a target, the Master Target is cleared. You must be a raid assistant or leader.",
				["clear"] = "Sets all players' threat to zero. You must be a raid assistant or leader.",
			},
			["stringshort"] = {
				-- the tooltip titles for titlebar strings
				["threat"] = "Threat",
				["tdef"] = "Threat Defecit",
				["rank"] = "Threat Rank",
				["pc"] = "% Threat",
			},
			["stringlong"] = {
				-- the tooltip descriptions for titlebar strings
				["threat"] = "The amount of threat accumulated since your personal value was reset",
				["tdef"] = "The difference between your threat and the target's",
				["rank"] = "Your position in the threat list",
				["pc"] = "Your threat as a percent of the target's",
			},
		},
	},
	-- labels and tooltips for the options gui
	["optionsgui"] = {
		["buttons"] = {
			-- the options gui command button labels
			["gen"] = "General",
			["raid"] = "Raid",
			["self"] = "Self",
			["close"] = "Close",	
		},
		-- the labels for option checkboxes and headers
		["labels"] = {
			-- the title description for each option page
			["titlebar"] = {
				["gen"] = "General Options",
				["raid"] = "Raid Options",
				["self"] = "Self Options",
			},
			["buttons"] = {
				-- the names of title bar command buttons
				["pin"] = "Pin",
				["opt"] = "Options",
				["view"] = "View change",
				["targ"] = "Master Target",
				["clear"] = "Reset Raid Threat",
			},
			["columns"] = {
				-- names of columns on the self and raid views
				["hits"] = "Hits",
				["rage"] = "Rage",
				["dam"] = "Damage",
				["threat"] = "Threat",
				["pc"] = "% threat",
			},
			["options"] = {
				-- miscelaneous option names
				["hide"] = "Hide rows with 0 threat",
				["abbreviate"] = "Abbreviate large values",
				["resize"] = "Resize frame",
				["aggro"] = "Show aggro gain",
				["rows"] = "Max visible rows",
				["scale"] = "Frame scale",
				["bottom"] = "Hide bottom bar",
			},
			["minvis"] = {
				-- the names of minimised strings
				["threat"] = "Minimised threat", -- dodge...
				["rank"] = "Threat rank",
				["pc"] = "% threat",
				["tdef"] = "Threat defecit",
			},
			["headers"] = {
				-- headers in the options gui
				["columns"] = "Visible columns",
				["strings"] = "Minimised strings",
				["other"] = "Other options",
				["minvis"] = "Minimised buttons",
				["maxvis"] = "Maximised buttons",
			},
		},
		-- the tooltips for some of the options
		["tooltips"] = {
			-- miscelaneous option descriptions
			["raidhide"] = "If checked, players with zero threat will not be visible on the threat meter.",
			["selfhide"] = "Uncheck to show all threat categories.",
			["abbreviate"] = "If checked, values larger than ten thousand will be abbreviated with the prefix 'k'. eg '15400' will become '15.4k'.",
			["resize"] = "If checked, the number of visible rows will be lowered to match the number of players reporting threat.",
			["aggro"] = "If checked, a player is added to the raid display showing the estimated threat barrier. It is most accurate when a mastertarget is set.",
			["rows"] = "The maximum number of players visible on the raid threat window.",
			["bottom"] = "If checked, the bottom bar will be hidden. It shows your threat defecit and the master target.",
		},
	},
	["print"] = 
	{
		["main"] = 
		{
			["startupmessage"] = "KLHThreatMeter Release |cff33ff33%s|r Revision |cff33ff33%s|r loaded. Type |cffffff00/ktm|r for help.",
		},
		["data"] = 
		{
			["abilityrank"] = "Your %s ability is rank %s.",
			["globalthreat"] = "Your global threat multiplier is %s.",
			["globalthreatmod"] = "%s gives you %s.",
			["multiplier"] = "As a %s, your threat from %s is multiplied by %s.",
			["damage"] = "damage",
			["shadowspell"] = "shadow spells",
			["arcanespell"] = "arcane spells",
			["holyspell"] = "holy spells",
			["setactive"] = "%s %d piece active? ... %s.",
			["true"] = "true",
			["false"] = "false",
			["healing"] = "Your healing causes %s threat (before global threat multiplier).",
			["talentpoint"] = "You have %d talent points in %s.",
			["talent"] = "Found %d %s talents.",
			["rockbiter"] = "Your rank %d Rockbiter adds %d threat to successful melee attacks.",
		},
		
		-- new in R17.7
		["boss"] = 
		{
			["automt"] = "The master target has been automatically set to %s.",
			["spellsetmob"] = "%s sets the %s parameter of %s's %s ability to %s from %s.", -- "Kenco sets the multiplier parameter of Onyxia's Knock Away ability to 0.7"
			["spellsetall"] = "%s sets the %s parameter of the %s ability to %s from %s.",
			["reportmiss"] = "%s reports that %s's %s missed him.",
			["reporttick"] = "%s reports that %s's %s hit him. He has suffered %s ticks, and will be affected in %s more ticks.",
			["reportproc"] = "%s reports that %s's %s changed his threat from %s to %s.",
			["bosstargetchange"] = "%s changed tagets from %s (on %s threat) to %s (on %s threat).",
			["autotargetstart"] = "You will automatically clear the meter and set the master target when you next target a world boss.",
			["autotargetabort"] = "The master target has already been set to the world boss %s.",
		},
		
		["network"] = 
		{
			["newmttargetnil"] = "Could not confirm the master target %s, because %s has no target.",
			["newmttargetmismatch"] = "%s sets the master target to %s, but his own target is %s. Using his own target instead, check this!",
			["mtpollwarning"] = "Updated your master target to %s, but could not confirm this. Ask %s to rebroadcast the master target if this does not sound correct.",
			["threatreset"] = "The raid threat meter was cleared by %s.",
			["newmt"] = "The master target has been set to '%s' by %s.",
			["mtclear"] = "The master target has been cleared by %s.",
			["knockbackstart"] = "NPC Spell reporting has been activated by %s.",
			["knockbackstop"] = "NPC Spell reporting has been stopped by %s.",
			["aggrogain"] = "%s reports gaining aggro with %d threat.",
			["aggroloss"] = "%s reports losing aggro with %d threat.",
			["knockback"] = "%s reports suffering a knock away. He's down to %d threat.",
			["knockbackstring"] = "%s reports this knockback text: '%s'.",
			["upgraderequest"] = "%s urges you to upgrade to Release %s of KLHThreatMeter. You are currently using Release %s.",
			["remoteoldversion"] = "%s is using the outdated Release %s of KLHThreatMeter. Please tell him to upgrade to Release %s.",
			["knockbackvaluechange"] = "|cffffff00%s|r has set the threat reduction of %s's |cffffff00%s|r attack to |cffffff00%d%%|r.",
			["raidpermission"] = "You need to be the raid leader or an assistant to do that!",
			["needmastertarget"] = "You have to set a master target first!",
			["knockbackinactive"] = "Knockback discovery is not active in the raid.",
			["versionrequest"] = "Requesting version information from the raid. Responses in 3 seconds.",
			["versionrecent"] = "These people have release %s: { ",
			["versionold"] = "These people have older versions: { ",
			["versionnone"] = "These people do not have KLHThreatMeter, or are not in the right CTRA channel: { ",
			["channel"] = 
			{
				ctra = "CTRA Channel",
				ora = "oRA Channel",
				manual = "Manual Override",
			},
			needtarget = "Target the mob to select as the master target first.",
			upgradenote = "Older versions of the mod have been notified to upgrade.",
			advertisestart = "You will now occasionally tell people who pull aggro to download KLHThreatMeter.",
			advertisestop = "You have stopped advertising KLHThreatMeter.",
			advertisemessage = "If you had KLHThreatMeter, you might not have pulled aggro on that %s.",
		}			
	}
}
