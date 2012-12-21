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
-- Version 28.06.2006-1
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- VERSION FRANCAISE DES TEXTES --
------------------------------------------------

function Necrosis_Localization_Dialog_Fr()

	function NecrosisLocalization()
		Necrosis_Localization_Speech_Fr();
	end

	NECROSIS_COOLDOWN = {
		["Spellstone"] = "Temps de recharge Pierre de sort",
		["Healthstone"] = "Temps de recharge Pierre de soins"
	};

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "Oui";
				[false] = "Non";
			},
			Hellspawn = {
				[true] = "On";
				[false] = "Off";
			},
			["Soulshard"] = "Fragment(s) d'\195\162me : ",
			["InfernalStone"] = "Pierre(s) infernale(s) : ",
			["DemoniacStone"] = "Pierre(s) d\195\169moniaque(s) : ",
			["Soulstone"] = "\nPierre d'\195\162me : ",
			["Healthstone"] = "Pierre de soins : ",
			["Spellstone"] = "Pierre de sort : ",
			["Firestone"] = "Pierre de feu : ",
			["CurrentDemon"] = "Demon : ",
			["EnslavedDemon"] = "Demon : Asservi",
			["NoCurrentDemon"] = "Demon : Aucun",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFPierre d'\195\162me|r",
			Text = {"Cr\195\169ation","Utilisation","Utilis\195\169e","En attente"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Pierre de soins|r",
			Text = {"Cr\195\169ation","Utilisation"}
		},
		["Spellstone"] = {
			Label = "|c0099CCFFPierre de sort|r",
			Text = {"Cr\195\169ation","En inventaire","Tenue en main"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Pierre de feu|r",
			Text = {"Cr\195\169ation","En inventaire","Tenue en main"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFDur\195\169e des sorts|r",
			Text = "Sorts actifs sur la cible",
			Right = "Clic droit pour pierre de foyer vers "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFTranse de l'ombre|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFDomination corrompue|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFAsservissement|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFArmure d\195\169moniaque|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFD\195\169tection de l'invisibilit\195\169|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFRespiration interminable|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFOeil de Kilrogg|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFBannir|r"
		},
		["TP"] = {
			Label = "|c00FFFFFFRituel d'invocation|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFLien spirituel|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFGardien de l'ombre|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFDiablotin|r"
		},
		["Void"] = {
			Label = "|c00FFFFFFMarcheur \195\169th\195\169r\195\169|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFSuccube|r"
		},
		["Fel"] = {
			Label = "|c00FFFFFFChasseur corrompu|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFInfernal|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFGarde funeste|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFSacrifice d\195\169moniaque|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFFMal\195\169diction amplifi\195\169e|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFMal\195\169diction de faiblesse|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFMal\195\169diction d'agonie|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFMal\195\169diction de t\195\169m\195\169rit\195\169|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFMal\195\169diction des langages|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFMal\195\169diction de fatigue|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFMal\195\169diction des \195\169l\195\169ments|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFFMal\195\169diction de l'ombre|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFMal\195\169diction funeste|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFMonture|r"
		},
		["Buff"] = {
			Label = "|c00FFFFFFMenu des sorts|r\nClic droit pour laisser ouvert"
		},
		["Pet"] = {
			Label = "|c00FFFFFFMenu des d\195\169mons|r\nClic droit pour laisser ouvert"
		},
		["Curse"] = {
			Label = "|c00FFFFFFMenu des mal\195\169dictions|r\nClic droit pour laisser ouvert"
		},
		["Radar"] = {
			Label = "|c00FFFFFFD\195\169tection des d\195\169mons|r"
		},
		["AmplifyCooldown"] = "Clic droit pour amplifier la mal\195\169diction",
		["DominationCooldown"] = "Clic droit pour invocation rapide",
		["LastSpell"] = "Clic du milieu pour caster ",
	};

	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-Fr.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-Fr.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-Fr.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-Fr.mp3"
	};

	NECROSIS_NIGHTFALL_TEXT = {
		["NoBoltSpell"] = "Vos n'avez pas le sort Trait de l'ombre.",
		["Message"] = "<white>T<lightPurple1>r<lightPurple2>a<purple>n<darkPurple1>s<darkPurple2>e d<darkPurple1>e l<purple>'<lightPurple2>o<lightPurple1>m<white>b<lightPurple1>r<lightPurple2>e"
	};


	NECROSIS_MESSAGE = {
		["Error"] = {
			["InfernalStoneNotPresent"] = "Pas de Pierre infernale pour l'invocation",
			["SoulShardNotPresent"] = "Pas de Fragment d'\195\162me pour l'invocation",
			["DemoniacStoneNotPresent"] = "Pas de pierre d\195\169moniaque pour l'invocation",
			["NoRiding"] = "Vous n'avez pas de monture \192\160 invoquer !",
			["NoFireStoneSpell"] = "Vous n'avez pas de sort Cr\195\169ation de Pierre de feu",
			["NoSpellStoneSpell"] = "Vous n'avez pas de sort Cr\195\169ation de Pierre de sort",
			["NoHealthStoneSpell"] = "Vous n'avez pas de sort Cr\195\169ation de Pierre de soins",
			["NoSoulStoneSpell"] = "Vous n'avez pas de sort Cr\195\169ation de Pierre d'\195\162me",
			["FullHealth"] = "Utilisation de Pierre de soins impossible, vous n'etes pas bless\195\169(e)",
			["BagAlreadySelect"] = "Erreur : Vous avez d\195\169j\195\160 ce sac selectionn\195\169.",
			["WrongBag"] = "Erreur : Le No doit \195\170tre compris entre 0 et 4",
			["BagIsNumber"] = "Erreur : Veuillez taper un chiffre.",
			["NoHearthStone"] = "Erreur : Vous n'avez pas de pierre de foyer dans votre inventaire"
		},
		["Bag"] = {
			["FullPrefix"] = "Votre ",
			["FullSuffix"] = " est plein !",
			["FullDestroySuffix"] = " est plein; les prochains fragments seront detruits !",
			["SelectedPrefix"] = "Vous avez choisi votre ",
			["SelectedSuffix"] = " pour stocker vos fragments"
		},
		["Interface"] = {
			["Welcome"] = "<white>/necro pour les options !",
			["TooltipOn"] = "Bulles d'aide activ\195\169es" ,
			["TooltipOff"] = "Bulles d'aide d\195\169sactiv\195\169es",
			["MessageOn"] = "Messages Pierre d'\195\162me et Invocation de joueur activ\195\169s",
			["MessageOff"] = "Messages Pierre d'\195\162me et Invocation de joueur desactiv\195\169s",
			["MessagePosition"] = "<- position des messages systeme Necrosis ->",
			["DefaultConfig"] = "<lightYellow>Configuration par defaut charg\195\169e.",
			["UserConfig"] = "<lightYellow>Configuration charg\195\169e"
		},
		["Help"] = {
			"/necro recall -- Centre Necrosis and tous les boutons au centre de l'écran",
			"/necro sm -- Remplace les messages de pierre d'\195\162me et d'invocation par des versions courtes spéciales raid"
		},
		["EquipMessage"] = "Equipe ",
		["SwitchMessage"] = " \195\160 la place de ",
		["Information"] = {
			["FearProtect"] = "La cible est prot\195\168g\195\169e contre la peur !!!!",
			["EnslaveBreak"] = "Votre D\195\169mon a bris\195\169 ses chaines...",
			["SoulstoneEnd"] = "<lightYellow>Votre Pierre d'\195\162me vient de s'eteindre."
		}
	};


	-- Gestion XML - Menu de configuration

	NECROSIS_COLOR_TOOLTIP = {
		["Purple"] = "Violet",
		["Blue"] = "Bleu",
		["Pink"] = "Rose",
		["Orange"] = "Orange",
		["Turquoise"] = "Turquoise",
		["X"] = "X"
	};
	
	NECROSIS_CONFIGURATION = {
		["Menu1"] = "Configuration des fragments",
		["Menu2"] = "Configuration des messages",
		["Menu3"] = "Configuration des boutons",
		["Menu4"] = "Configuration des timers",
		["Menu5"] = "Configuration graphique",
		["MainRotation"] = "Rotation de Necrosis",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFen|CFFFFC4FFt|CFFFF99FFa|CFFFF50FFi|CFFFF00FFr|CFFB700B7e :",
		["ShardMenu2"] = "|CFFB700B7C|CFFFF00FFo|CFFFF50FFm|CFFFF99FFp|CFFFFC4FFt|CFFFF99FFe|CFFFF50FFu|CFFFF00FFr :",
		["ShardMove"] = "D\195\169place les fragments dans le sac specifi\195\169",
		["ShardDestroy"] = "D\195\169truit les fragments si sac plein",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFo|CFFFF50FFr|CFFFF99FFt|CFFFFC4FFs :",
		["SpellMenu2"] = "|CFFB700B7J|CFFFF00FFo|CFFFF50FFu|CFFFF99FFe|CFFFFC4FFu|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFr|CFFFF99FFs G|CFFFF50FFr|CFFFF00FFa|CFFB700B7ph|CFFFF00FFi|CFFFF50FFq|CFFFF99FFue|CFFFFC4FFs :",
		["TranseWarning"] = "M'alerter quand j'entre en Transe",
		["SpellTime"] = "Affiche la gestion des dur\195\169es de sorts",
		["AntiFearWarning"] = "M'alerter quand ma cible \195\160 un 'anti fear'",
		["GraphicalTimer"] = "Affichage des timers sous forme graphique",
		["TimerColor"] = "Affiche le texte des timers en blanc",
		["TimerDirection"] = "Ajouter les timers en haut des pr\195\169c\195\169dents",
		["TranceButtonView"] = "Affichage des boutons cach\195\169s pour les d\195\169placer",
		["ButtonLock"] = "Verrouiller les boutons sur la sphere Necrosis",
		["MainLock"] = "Verrouiller les boutons des Pierres et Necrosis",
		["BagSelect"] = "Choix du sac contenant les fragments",
		["BuffMenu"] = "Afficher le menu des buffs vers la gauche",
		["PetMenu"] = "Afficher le menu des d\195\169mons vers la gauche",
		["CurseMenu"] = "Afficher le menu des mal\195\169dictions vers la gauche",
		["STimerLeft"] = "Afficher les timers sur la gauche du bouton",
		["ShowCount"] = "Afficher le compteur de fragments",
		["CountType"] = "Type de compteur",
		["Circle"] = "Ev\195\168nement montr\195\169 par la sph\195\168re graphique",
		["ShowMessage"] = "Active les messages al\195\169atoires d'invocation",
		["ShowDemonSummon"] = "Active les messages pour les D\195\169mons",
		["ShowSteedSummon"] = "Active les messages pour la Monture",
		["ChatType"] = "Les messages = des messages syst\195\168mes",
		["Sound"] = "Activer les sons",
		["NecrosisSize"] = "Taille de la pierre Necrosis",
		["BanishSize"] = "Taille du bouton Banish",
		["TranseSize"] = "Taille des boutons Transe et AntiPeur",
		["Skin"] = "Skin de la pierre Necrosis",
		["Show"] = {
			["Firestone"] = "Afficher le bouton des Pierres de feu",
			["Spellstone"] = "Afficher le bouton des Pierres de sort",
			["Healthstone"] = "Afficher le bouton des Pierres de soin",
			["Soulstone"] = "Afficher le bouton des Pierres d'\195\162me",
			["Steed"] = "Afficher le bouton de la Monture",
			["Buff"] = "Affiche le bouton des Buffs",
			["Curse"] = "Affiche le bouton des Mal\195\169dictions",
			["Demon"] = "Affiche le bouton d'invocation des D\195\169mons",
			["Tooltips"] = "Affiche les bulles d'aides"
		},
		["Count"] = {
			["Shard"] = "Fragments d'\195\162me",
			["Inferno"] = "Pierres d'invocations",
			["Rez"] = "Timer de Rez"
		}
	};

end
