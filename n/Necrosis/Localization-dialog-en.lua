------------------------------------------------------------------------------------------------------
-- Necrosis LdC
--
-- Créateur initial (US) : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Implémentation de base (FR) : Tilienna Thorondor
-- Reprise du projet : Lomig & Nyx des Larmes de Cenarius, Kael'Thas
-- 
-- Skins et voix Françaises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements spéciaux pour Sadyre (JoL)
-- Version 06.05.2006-1
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Necrosis_Localization_Dialog_En()

	function NecrosisLocalization()
		Necrosis_Localization_Speech_En();
	end

	NECROSIS_COOLDOWN = {
		["Spellstone"] = "Spellstone Cooldown",
		["Healthstone"] = "Healthstone Cooldown"
	};

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "Yes";
				[false] = "No";
			},
			Hellspawn = {
				[true] = "On";
				[false] = "Off";
			},
			["Soulshard"] = "Soul Shard(s) : ",
			["InfernalStone"] = "Infernal Stone(s) : ",
			["DemoniacStone"] = "Demonic Figurine(s) ",
			["Soulstone"] = "\nSoulstone : ",
			["Healthstone"] = "Healthstone : ",
			["Spellstone"] = "Spellstone : ",
			["Firestone"] = "Firestone : ",
			["CurrentDemon"] = "Demon : ",
			["EnslavedDemon"] = "Demon : Enslaved",
			["NoCurrentDemon"] = "Demon : None",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSoulstone|r",
			Text = {"Create","Use","Used","Waiting"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Healthstone|r",
			Text = {"Create","Use"}
		},
		["Spellstone"] = {
			Label = "|c0099CCFFSpellstone|r",
			Text = {"Create","In Inventory","Held in hand"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Firestone|r",
			Text = {"Create","In Inventory","Held in hand"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFSpell Durations|r",
			Text = "Active Spells on the target",
			Right = "Right Click for Hearthstone to "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFShadow Transe|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFFel Domination|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFEnslave|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFDemon Armor|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFDetect Invisibility|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFUnending Breath|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFEye of Kilrogg|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFBanish|r"
		},
		["TP"] = {
			Label = "|c00FFFFFFRitual of Summoning|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFSoul Link|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFShadow Ward|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFImp|r"
		},
		["Void"] = {
			Label = "|c00FFFFFFVoidwalker|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFSuccubus|r"
		},
		["Fel"] = {
			Label = "|c00FFFFFFFelhunter|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFInferno|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFDoomguard|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFDemonic sacrifice|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFFAmplify Curse|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFCurse of Weakness|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFCurse of Agony|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFCurse of Recklessness|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFCurse of Tongues|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFCurse of Exhaustion|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFCurse of Elements|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFFCurse of Shadow|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFCurse of Doom|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFSteed|r"
		},
		["Buff"] = {
			Label = "|c00FFFFFFSpell Menu|r\nRight click to keep the menu open"
		},
		["Pet"] = {
			Label = "|c00FFFFFFDemon Menu|r\nRight click to keep the menu open"
		},
		["Curse"] = {
			Label = "|c00FFFFFFCurse Menu|r\nRight click to keep the menu open"
		},
		["Radar"] = {
			Label = "|c00FFFFFFSense Demons|r"
		},
		["AmplifyCooldown"] = "Right click to amplify curse",
		["DominationCooldown"] = "Right click for fast summon",
		["LastSpell"] = "Middle click to cast ",
	};


	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3"
	};


	NECROSIS_NIGHTFALL_TEXT = {
		["NoBoltSpell"] = "You do not seem to have any Shadow Bolt Spell.",
		["Message"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e"
	};


	NECROSIS_MESSAGE = {
		["Error"] = {
			["InfernalStoneNotPresent"] = "You need an Infernal Stone to do that !",
			["SoulShardNotPresent"] = "You need a Soul shard to do that !",
			["DemoniacStoneNotPresent"] = "You need a Demoniac Figurine to do that !",
			["NoRiding"] = "You do not have any Steed to ride !",
			["NoFireStoneSpell"] = "You do not have any Firestone creation spell",
			["NoSpellStoneSpell"] = "You do not have any Spellstone creation spell",
			["NoHealthStoneSpell"] = "You do not have any Healthstone creation spell",
			["NoSoulStoneSpell"] = "You do not have any Soulstone creation spell",
			["FullHealth"] = "You cannot use your Healthstone as you are not hurt",
			["BagAlreadySelect"] = "Error : This bag is already selected.",
			["WrongBag"] = "Error : The number must be between 0 and 4.",
			["BagIsNumber"] = "Error : Please type a number.",
			["NoHearthStone"] = "Error : You do not have a Hearthstone in your inventory"
		},
		["Bag"] = {
			["FullPrefix"] = "Your ",
			["FullSuffix"] = " is full !",
			["FullDestroySuffix"] = " is full; Next shards will be destroyed !",
			["SelectedPrefix"] = "You have chosen your ",
			["SelectedSuffix"] = " to keep your shards."
		},
		["Interface"] = {
			["Welcome"] = "<white>/necro to show the setting menu !",
			["TooltipOn"] = "Tooltips turned on" ,
			["TooltipOff"] = "Tooltips turned off",
			["MessageOn"] = "Chat messaging turned on",
			["MessageOff"] = "Chat messaging turned off",
			["MessagePosition"] = "<- System messages by Necrosis will appear here ->",
			["DefaultConfig"] = "<lightYellow>Default configuration loaded.",
			["UserConfig"] = "<lightYellow>Configuration loaded."
		},
		["Help"] = {
			"/necro recall -- Center Necrosis and all buttons in the middle of the screen",
			"/necro sm -- Replace Soulstoning and summoning messages with a short raid-ready version"
		},
		["EquipMessage"] = "Equip ",
		["SwitchMessage"] = " instead of ",
		["Information"] = {
			["FearProtect"] = "Your target has got a fear protection !!!!",
			["EnslaveBreak"] = "Your demon broke his chains...",
			["SoulstoneEnd"] = "<lightYellow>Your Soulstone has faded."
		}
	};


	-- Gestion XML - Menu de configuration

	NECROSIS_COLOR_TOOLTIP = {
		["Purple"] = "Purple",
		["Blue"] = "Blue",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "Turquoise",
		["X"] = "X"
	};
	
	NECROSIS_CONFIGURATION = {
		["Menu1"] = "Shard Settings",
		["Menu2"] = "Message Settings",
		["Menu3"] = "Button Settings",
		["Menu4"] = "Timer Settings",
		["Menu5"] = "Graphical Settings",
		["MainRotation"] = "Necrosis Angle Selection",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["ShardMenu2"] = "|CFFB700B7S|CFFFF00FFh|CFFFF50FFa|CFFFF99FFr|CFFFFC4FFd C|CFFFF99FFo|CFFFF50FFu|CFFFF00FFn|CFFB700B7t :",
		["ShardMove"] = "Put shards in the selected bag.",
		["ShardDestroy"] = "Destroy all new shards if the bag is full.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "Show white instead of yellow timer texts",
		["TimerDirection"] = "Timers grow upwards",
		["TranseWarning"] = "Alert me when I enter a Trance State",
		["SpellTime"] = "Turn on the spell durations indicator",
		["AntiFearWarning"] = "Warn me when my target cannot be feared.",
		["GraphicalTimer"] = "Show graphical instead text timers",	
		["TranceButtonView"] = "Let me see hidden buttons to drag them.",
		["ButtonLock"] = "Lock the buttons around the Necrosis Sphere.",
		["MainLock"] = "Lock buttons and the Necrosis Sphere.",
		["BagSelect"] = "Selection of Soul Shard Container",
		["BuffMenu"] = "Put buff menu on the left",
		["PetMenu"] = "Put pet menu on the left",
		["CurseMenu"] = "Put curse menu on the left",
		["STimerLeft"] = "Show timers on the left side of the button",
		["ShowCount"] = "Show the Shard count in Necrosis",
		["CountType"] = "Stone type counted",
		["Circle"] = "Event shown by the graphical sphere",
		["Sound"] = "Activate sounds",
		["ShowMessage"] = "Activate random speeches",
		["ShowDemonSummon"] = "Activate random speeches (demon)",
		["ShowSteedSummon"] = "Activate random speeches (steed)",
		["ChatType"] = "Declare Necrosis messages as system messages",
		["NecrosisSize"] = "Size of the Necrosis button",
		["BanishSize"] = "Size of the Banish button",
		["TranseSize"] = "Size of Transe and Anti-fear buttons",
		["Skin"] = "Skin of the Necrosis Sphere",
		["Show"] = {
			["Firestone"] = "Show Firestone button",
			["Spellstone"] = "Show Spellstone button",
			["Healthstone"] = "Show Healthstone button",
			["Soulstone"] = "Show Soulstone button",
			["Steed"] = "Show Steed button",
			["Buff"] = "Show Spell menu button",
			["Curse"] = "Show Curse menu button",
			["Demon"] = "Show Demon menu button",
			["Tooltips"] = "Show tooltips"
		},
		["Count"] = {
			["Shard"] = "Soulshards",
			["Inferno"] = "Demon summoning stones",
			["Rez"] = "Resurrection Timer"
		}
	};

end
