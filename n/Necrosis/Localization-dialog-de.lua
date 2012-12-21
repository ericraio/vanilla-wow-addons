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
-- Version 11.05.2006-1
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- GERMAN VERSION TEXTS --
------------------------------------------------

function Necrosis_Localization_Dialog_De()

	function NecrosisLocalization()
		Necrosis_Localization_Speech_De();
	end

	NECROSIS_COOLDOWN = {
		["Spellstone"] = "Zauberstein Cooldown",
		["Healthstone"] = "Gesundheitsstein Cooldown"
	};

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "Ja";
				[false] = "Nein";
			},
			Hellspawn = {
				[true] = "An";
				[false] = "Aus";
			},
			["Soulshard"] = "Seelensplitter : ",
			["InfernalStone"] = "H\195\182llensteine : ",
			["DemoniacStone"] = "D\195\164monen-Statuetten : ",
			["Soulstone"] = "\nSeelenstein : ",
			["Healthstone"] = "Gesundheitsstein : ",
			["Spellstone"] = "Zauberstein: ",
			["Firestone"] = "Feuerstein : ",
			["CurrentDemon"] = "D\195\164mon : ",
			["EnslavedDemon"] = "D\195\164mon : Versklavter",
			["NoCurrentDemon"] = "D\195\164mon : Keiner",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSeelenstein|r",
			Text = {"Erstelle","Verwende","Benutzt","Warten"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Gesundheitsstein|r",
			Text = {"Erstelle","Verwende"}
		},
		["Spellstone"] = {
			Label = "|c0099CCFFZauberstein|r",
			Text = {"Erstelle","Im Inventar","In der Hand gehalten"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Feuerstein|r",
			Text = {"Erstelle","Im Inventar","In der Hand gehalten"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFSpruchdauer|r",
			Text = "Aktive Spr\195\188che auf dem Ziel\n",
			Right = "Rechtsklick f\195\188r Ruhestein nach "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFSchatten Trance|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFTeufelsbeherrschung|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFVersklavt|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFD\195\164monenr\195\188stung|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFEntdecke Unsichtbarkeit|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFUnendlicher Atem|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFAuge von Kilrogg|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFVerbannen|r"
		},
		["TP"] = {
			Label = "|c00FFFFFFRitual der Beschw\195\182rung|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFSeelenverbindung|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFSchattenzauberschutz|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFWichtel|r"
		},
		["Void"] = {
			Label = "|c00FFFFFFLeerwandler|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFSukkubus|r"
		},
		["Fel"] = {
			Label = "|c00FFFFFFTeufelsj\195\164ger|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFH\195\182llenbestie|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFVerdammniswache|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFD\195\164monenopferung|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFFFluch verst\195\164rken|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFFluch der Schw\195\164che|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFFluch der Pein|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFFluch der Tollk\195\188hnheit|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFFluch der Sprachen|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFFluch der Ersch\195\182pfung|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFFluch der Elemente|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFFFluch der Schatten|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFFluch der Verdammnis|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFMount|r"
		},
		["Buff"] = {
			Label = "|c00FFFFFFSpruch Men\195\188|r\nRechtsklick um das Men\195\188 zu \195\182ffnen"
		},
		["Pet"] = {
			Label = "|c00FFFFFFD\195\164monen Men\195\188|r\nRechtsklick um das Men\195\188 zu \195\182ffnen"
		},
		["Curse"] = {
			Label = "|c00FFFFFFFluch Men\195\188|r\nRechtsklick um das Men\195\188 zu \195\182ffnen"
		},
		["Radar"] = {
			Label = "|c00FFFFFFD\195\164monen sp\195\188ren|r"
		},
		["AmplifyCooldown"] = "Mit der rechten Taste klicken f\195\188r verstärken",
		["DominationCooldown"] = "Mit der rechten Taste klicken f\195\188r eine schnelle Beschw\195\182rung",
		["LastSpell"] = "Mittlere Taste klicken f\195\188r ",
	};


	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3"
	};


	NECROSIS_NIGHTFALL_TEXT = {
		["NoBoltSpell"] = "Du hast scheinbar keinen Schattenblitz Zauber.",
		["Message"] = "<white>S<lightPurple1>c<lightPurple2>h<purple>a<darkPurple1>tt<darkPurple2>en<darkPurple1>tr<purple>a<lightPurple2>n<lightPurple1>c<white>e"
	};


	NECROSIS_MESSAGE = {
		["Error"] = {
			["InfernalStoneNotPresent"] = "Du ben\195\182tigst einen H\195\182llenstein daf\195\188r !",
			["SoulShardNotPresent"] = "Du ben\195\182tigst einen Seelensplitter daf\195\188r !",
			["DemoniacStoneNotPresent"] = "Du ben\195\182tigst eine D\195\164monen-Statuette daf\195\188r !",
			["NoRiding"] = "Du hast kein Mount zum reiten !",
			["NoFireStoneSpell"] = "Du hast keinen Zauber um Feuersteine zu erstellen",
			["NoSpellStoneSpell"] = "Du hast keinen Zauber um Zaubersteine zu erstellen",
			["NoHealthStoneSpell"] = "Du hast keinen Zauber um Gesundheitssteine zu erstellen",
			["NoSoulStoneSpell"] = "Du hast keinen Zauber um Seelensteine zu erstellen",
			["FullHealth"] = "Du kannst deinen Gesundheitsstein nicht benutzen, du hast bereits volles Leben",
			["BagAlreadySelect"] = "Fehler : Diese Tasche ist bereits ausgew\195\164hlt.",
			["WrongBag"] = "Fehler : Die Zahl muss zwischen 0 und 4 sein.",
			["BagIsNumber"] = "Fehler : Bitte gib eine Zahl an.",
			["NoHearthStone"] = "Fehler : Du hast keinen Ruhestein im Inventar"
		},
		["Bag"] = {
			["FullPrefix"] = "Dein ",
			["FullSuffix"] = " ist voll !",
			["FullDestroySuffix"] = " ist voll; folgende Seelensplitter werden zerst\195\182rt !",
			["SelectedPrefix"] = "Du hast deinen ",
			["SelectedSuffix"] = " f\195\188r deine Seelensplitter gew\195\164hlt."
		},
		["Interface"] = {
			["Welcome"] = "<white>/necro f\195\188r das Einstellungsmen\195\188.",
			["TooltipOn"] = "Tooltips an" ,
			["TooltipOff"] = "Tooltips aus",
			["MessageOn"] = "Chat Nachrichten an",
			["MessageOff"] = "Chat Nachrichten aus",
			["MessagePosition"] = "<- Hier werden Nachrichten von Necrosis erscheinen ->",
			["DefaultConfig"] = "<lightYellow>Standard-Einstellungen geladen.",
			["UserConfig"] = "<lightYellow>Einstellungen geladen."
		},
		["Help"] = {
			"/necro recall -- Zentriere Necrosis und alle Buttons in der Mitte des Bildschirms",
			"/necro sm -- Ersetze Seelenstein- und Beschw\195\182rungs-Zufallsnachrichten durch eine kurze, raidgeeignete Version"
		},
		["EquipMessage"] = "Ausr\195\188ste ",
		["SwitchMessage"] = " anstelle von ",
		["Information"] = {
			["FearProtect"] = "Dein Ziel hat Fear-Protection!!!",
			["EnslaveBreak"] = "Dein D\195\164mon hat seine Ketten gebrochen...",
			["SoulstoneEnd"] = "<lightYellow>Dein Seelenstein ist ausgelaufen."
		}
	};


	-- Gestion XML - Menu de configuration

	NECROSIS_COLOR_TOOLTIP = {
		["Purple"] = "Lila",
		["Blue"] = "Blau",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "T\195\188rkis",
		["X"] = "X"
	};
	
	NECROSIS_CONFIGURATION = {
		["Menu1"] = "Splitter Einstellungen",
		["Menu2"] = "Nachrichten Einstellungen",
		["Menu3"] = "Buttons Einstellungen",
		["Menu4"] = "Timer Einstellungen",
		["Menu5"] = "Graphische Einstellungen",
		["MainRotation"] = "Necrosis Rotiationseinstellung",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFa|CFFFF00FFr :",
		["ShardMenu2"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFl|CFFFF99FFi|CFFFFC4FFtt|CFFFF99FFe|CFFFF50FFr :",
		["ShardMove"] = "Lege die Seelensplitter in die ausgew\195\164hlte Tasche.",
		["ShardDestroy"] = "Zerst\195\182re neue Seelensplitter, wenn die Tasche voll ist.",
		["SpellMenu1"] = "|CFFB700B7Z|CFFFF00FFa|CFFFF50FFu|CFFFFC4FFb|CFFFF99FFe|CFFFF50FFr :",
		["SpellMenu2"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFi|CFFFF99FFe|CFFFFC4FFl|CFFFF99FFe|CFFFF50FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFs|CFFFF00FFc|CFFB700B7he T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFF00FFr :",
		["TranseWarning"] = "Warnung, wenn Schattentrance eintritt",
		["SpellTime"] = "Spruchdauer anzeigen",
		["AntiFearWarning"] = "Warnung, wenn Ziel immun gegen\195\188ber Fear",
		["TranceButtonView"] = "Zeige versteckte Buttons um sie zu verschieben",
		["GraphicalTimer"] = "Verwende graphische Timer anstelle von Texttimern",
		["TimerColor"] = "Zeige wei\195\159en Text in Timern anstelle von gelbem Text",
		["TimerDirection"] = "Neue Timer oberhalb der bestehenden Timer anzeigen",
		["ButtonLock"] = "Sperre die Buttons um die Necrosis Sph\195\164re",
		["MainLock"] = "Sperre die Buttons und die Necrosis Sph\195\164re",
		["BagSelect"] = "W\195\164hle die Seelensplitter-Tasche",
		["BuffMenu"] = "Setze das Spruch Men\195\188 nach links",
		["CurseMenu"] = "Setze das Fluch Men\195\188 nach links",
		["PetMenu"] = "Setze das Diener Men\195\188 nach links",
		["STimerLeft"] = "Zeige die Timer auf der linken Seite des Knopfes",		
		["ShowCount"] = "Zeige die Anzahl der Seelensplitter in Necrosis",
		["CountType"] = "Stein Typ gez\195\164hlt",
		["Circle"] = "Anzeige in der grafischen Sph\195\164re",
		["Sound"] = "Aktiviere Sounds",
		["ShowMessage"] = "Zuf\195\164llige Spr\195\188che",
		["ShowDemonSummon"] = "Zuf\195\164llige Spr\195\188che (D\195\164mon)",
		["ShowSteedSummon"] = "Zuf\195\164llige Spr\195\188che (Mount)",
		["ChatType"] = "Necrosis Nachrichten als System-Nachrichten anzeigen",
		["NecrosisSize"] = "Gr\195\182\195\159e des Necrosis Button",
		["BanishSize"] = "Gr\195\182\195\159e des Verbannen Button",		
		["TranseSize"] = "Gr\195\182\195\159e des Trance und Anti-Fear Buttons",
		["Skin"] = "Aussehen der Necrosis Sph\195\164re",
		["Show"] = {
			["Firestone"] = "Zeige den Feuerstein Button",
			["Spellstone"] = "Zeige den Zauberstein Button",
			["Healthstone"] = "Zeige den Gesundheitsstein Button",
			["Soulstone"] = "Zeige den Seelenstein Button",
			["Steed"] = "Zeige den Mount Button",
			["Buff"] = "Zeige den Spruch Men\195\188 Button",
			["Demon"] = "Zeige den D\195\164monen Men\195\188 Button",
			["Curse"] = "Zeige den Fluch Men\195\188 Button",
			["Tooltips"] = "Zeige Tooltips"
		},
		["Count"] = {
			["Shard"] = "Seelensplitter",
			["Inferno"] = "D\195\164monenen-Beschw\195\182rungs-Steine",
			["Rez"] = "Wiederbelebungs-Timer"
		}
	};

end
