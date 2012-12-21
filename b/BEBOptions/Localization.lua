BEBOPTIONS = {}
BEBOPTIONS.TEXTELEMENTS = {
	BEBConfigHeaderText =				"BEB "..BEB.CurrentVersion.." Config",
	BEBConfigFrameButtonClose =			"Close",
	BEBDefaultsButton =					"Defaults",
	BEBMainSelector =					"General",
	BEBBackgroundSelector =				"Background",
	BEBXpBarSelector =					"Xp Bar",
	BEBRestedXpBarSelector =				"Rested Xp Bar",
	BEBMarkersSelector =				"Marker artwork",
	BEBXpTickSelector =					"Xp Tick",
	BEBRestedXpTickSelector =			"Rested Xp Tick",
	BEBRestedXpTickGlowSelector =			"Tick Glow",
	BEBBarTextSelector =				"Bar Text",
	BEBProfileSelector =				"Profiles",
	BEBDragableCheckButtonText =			"Dragable.",
	BEBFlashingCheckButtonText =			"Flash when resting.",
	BEBShownCheckButtonText =			"Shown",
	BEBShowOnMouseoverCheckButtonText =	"Show on mouseover.",
	BEBClickTextCheckButtonText =			"Add text to chat on left click",
	BEBColorsHeader =					"Colors",
	BEBAttachHeader =					"Attach",
	BEBUnrestedTextureColorButtonText =	"Unrested",
	BEBRestedTextureColorButtonText =		"Rested",
	BEBMaxrestedTextureColorButtonText =	"Fully Rested",
	BEBUnrestedTextColorButtonText =		"Unrested",
	BEBRestedTextColorButtonText =		"Rested",
	BEBMaxrestedTextColorButtonText =		"Fully Rested",
	BEB_MainAttachToFrame_Label =			"on frame",
	BEB_BarTextFrame_Label =				"Text on the bar",
	BEB_TextureFrame_Label =				"Texture file",
	BEB_MainAttachPointButton_Label =		"point",
	BEB_MainAttachToPointButton_Label =	"to point",
	BEB_StrataDDMButton_Label =			"Strata",
	BEBOptionsPositionControlsTitle =		"Position",
	BEBOptionsHeightSlider_Label =		"Height",
	BEBOptionsWidthSlider_Label =			"Width",
	BEBOptionsLevelSlider_Label =			"Level",
	BEBOptions_ColorCopy =				"Copy",
	BEBOptions_ColorPaste =				"Paste",
	BEBProfileFrameCreateButton =			"Create",
	BEBProfileFrameUseButton =			"Use",
	BEBProfileFrameLoadButton =			"Load",
	BEBProfileFrameSaveButton =			"Save to",
	BEBProfileFrameDeleteButton =			"Delete",
}
BEBOPTIONS.ATTACHPOINTS = {
	TOP =						"Top",
	BOTTOM =						"Bottom",
	LEFT =						"Left",
	RIGHT =						"Right",
	TOPLEFT =						"Top left",
	TOPRIGHT =					"Top right",
	BOTTOMLEFT =					"Bottom left",
	BOTTONRIGHT =					"Bottom right",
	CENTER =						"Center",
}
BEBOPTIONS.UIATTACHFRAMES = {
	UIParent =					"UI Parent",
	MainMenuExpBar =				"UI Experience bar",
	MainMenuBar =					"UI Main bar",
	ChatFrame1 =					"UI Chat frame",
	MinimapCluster =				"UI Minimap",
	PlayerFrame =					"UI Player unit frame",
}
if (BEB.IsFrame("TitanPanelBarButton")) then
	BEBOPTIONS.UIATTACHFRAMES.TitanPanelBarButton = "Titan Bar"
end
if (BEB.IsFrame("TitanPanelAuxBarButton")) then
	BEBOPTIONS.UIATTACHFRAMES.TitanPanelAuxBarButton = "Titan Bar 2"
end
--[[if (BEB.IsFrame("DAB_ActionBar_1") then
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_1
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_2
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_3
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_4
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_5
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_6
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_7
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_8
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_9
	BEBOPTIONS.UIATTACHFRAMES.DAB_ActionBar_10
end]]
BEBOPTIONS.VARIABLE_FUNCTIONS_DESCIPTIONS = {
	["$plv"] =					"$plv Character's level.",
	["$cxp"] =					"$cxp Current xp for this level.",
	["$mxp"] =					"$mxp Total xp needed for this level.",
	["$rxp"] =					"$rxp Rested xp as reported by the game.",
	["$Rxp"] =					"$Rxp Actual current rested xp.",
	["$Cxp"] =					"$Cxp Total xp ever earned for this character.",
	["$Mxp"] =					"$Mxp Xp to go until you can earn no more.",
	["$txp"] =					"$txp Xp needed to level.",
	["$Txp"] =					"$Txp Xp needed to reach level 60.",
	["$pdl"] =					"$pdl Percent of the way through the current level.",
	["$Pdl"] =					"$Pdl Percent of the way to the end of level 60.",
	["$ptl"] =					"$ptl Percent of the level left to complete.",
	["$res"] =					"$res Shows 'Resting' if you are currently resting.",
	["$rst"] =					"$rst Shows 'Unrested', 'Rested' or 'Fully Rested'.",
	["$ptx"] =					"$ptx Pet's current xp for this level.",
	["$pty"] =					"$pty Pet's total xp needed for this level.",
	["$ppc"] =					"$ppc Pet's % of the way through the current level.",
	["$ppn"] =					"$ppn Pet's % of the level left to complete.",
	["$pxg"] =					"$pxg Pet's xp needed to level.",
	["$tts"] =					"$tts Time played this session.",
	["$rss"] =					"$rss Xp per second (session).",
	["$rsm"] =					"$rsm Xp per minute (session).",
	["$rsh"] =					"$rsh Xp per hour (session).",
	["$tls"] =					"$tls Time to level up (session).",
	["$xts"] =					"$xts Xp earned this session.",
	["$prt"] =					"$prt Percent of the way to being fully rested.",
	["$pre"] =					"$pre Percent rested to next level.",
	["$nkx"] =					"$nkx Kills this session that gave XP.",
	["$xpk"] =					"$xpk Average XP per kill this session.",
	["$kls"] =					"$kls Number of kills needed to level up (session).",
}
BEBOPTIONS.TEXTURES = {
	["PlainBackdrop"] =				"Plain Backdrop",
	["BEB-BarFill-Rounded"] =		"Rounded bar",
	["BEB-BarFill-RoundedLight"] =	"Light rounded bar",
	["BEB-BarFill-RoundedUp"] =		"Rounded bar lit from above",
	["BEB-BarFill-Flat"] =			"Flat bar",
	["BEB-ExperienceBarMarkers"] =	"Default marker artwork",
	["BEB-ExhaustionTicks"] =		"Default ticks",
	["BEB-ExhaustionTicksGlow"] =		"Default tick glow",
	["BEB-BarFill-Metal"] =			"Metallic bar texture",
	["BEB-BarFill-Wood"] =			"Wooden bar texture",
}
BEBOPTIONS.STRATAS = {
	BACKGROUND =					"Lowest",
	DIALOG =						"Higher",
	FULLSCREEN =					"Highest",
	HIGH =						"High",
	LOW =						"Low",
	MEDIUM =						"Medium",
}
BEBOPTIONS.TEXT = {
	none =						"<NONE>",
	profilealreadyexists =			"BEB: The profile you wish to create already exists",
	frameisinvalid =				"BEB: The frame you entered does not exist or is invalid.",
	optionstextwasmouseover =		"BEB: Text was being shown on mouseover, this has been disabled",
	optionstextwashidden =			"BEB: Text was set to never show. Text is now enabled",
}
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  French  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
if (GetLocale() == "frFR") then
BEBOPTIONS.TEXTELEMENTS = {
	BEBConfigHeaderText =				"BEB "..BEB.CurrentVersion.." Config",
	BEBConfigFrameButtonClose =			"Fermer",
	BEBDefaultsButton =					"D\195\169fauts",
	BEBMainSelector =					"G\195\169n\195\169ral",
	BEBBackgroundSelector =				"Fond",
	BEBXpBarSelector =					"Bar d'Xp",
	BEBRestedXpBarSelector =				"Bar d'Xp Repos\195\169",
	BEBMarkersSelector =				"dessin-mod\195\168le",
	BEBXpTickSelector =					"Tick d'Xp",
	BEBRestedXpTickSelector =			"Tick d'Xp Repos\195\169",
	BEBRestedXpTickGlowSelector =			"Lueur du Tick",
	BEBBarTextSelector =				"Texte",
	BEBProfileSelector =				"Profils",
	BEBDragableCheckButtonText =			"D\195\168placable.",
	BEBFlashingCheckButtonText =			"Clignotez en se reposant",
	BEBShownCheckButtonText =			"Visible",
	BEBShowOnMouseoverCheckButtonText =	"Montrez lors d'un mouseover",
	BEBClickTextCheckButtonText =			"Ajoutez le texte au Chat lors d'un clique gauche.",
	BEBColorsHeader =					"Couleurs",
	BEBAttachHeader =					"Attacher",
	BEBUnrestedTextureColorButtonText =	"Pas repos\195\169",
	BEBRestedTextureColorButtonText =		"Repos\195\169",
	BEBMaxrestedTextureColorButtonText =	"Enti\195\168rement repos\195\169",
	BEBUnrestedTextColorButtonText =		"Pas repos\195\169",
	BEBRestedTextColorButtonText =		"Repos\195\169",
	BEBMaxrestedTextColorButtonText =		"Enti\195\168rement repos\195\169",
	BEB_MainAttachToFrame_Label =			"sur l'armature",
	BEB_BarTextFrame_Label =				"Texte sur la barre",
	BEB_TextureFrame_Label =				"Fichier de texture",
	BEB_StrataDDMButton_Label =			"Strata", --
	BEB_MainAttachPointButton_Label =		"point",
	BEB_MainAttachToPointButton_Label =	"au point",
	BEBOptionsPositionControlsTitle =		"Position",
	BEBOptionsHeightSlider_Label =		"Hauteur",
	BEBOptionsWidthSlider_Label =			"Largeur",
	BEBOptionsLevelSlider_Label =			"Level", --
	BEBOptions_ColorCopy =				"Copier",
	BEBOptions_ColorPaste =				"Coller",
	BEBProfileFrameCreateButton =			"Cr\195\169er",
	BEBProfileFrameUseButton =			"Employer",
	BEBProfileFrameLoadButton =			"Charger",
	BEBProfileFrameSaveButton =			"Sauver \195\160",
	BEBProfileFrameDeleteButton =			"supprimer",
}
BEBOPTIONS.ATTACHPOINTS = {
	TOP =						"Sup\195\169rieur",
	BOTTOM =						"Inf\195\169rieur",
	LEFT =						"Gauche",
	RIGHT =						"Droite",
	TOPLEFT =						"Sup\195\169rieur gauche",
	TOPRIGHT =					"Sup\195\169rieur droit",
	BOTTOMLEFT =					"Inf\195\169rieur gauche",
	BOTTONRIGHT =					"Inf\195\169rieur droit",
	CENTER =						"Centre",
}
BEBOPTIONS.UIATTACHFRAMES = {
	UIParent =					"UI Parent",
	MainMenuExpBar =				"UI Barre d'exp\195\169rience",
	MainMenuBar =					"UI Barre principale",
	ChatFrame1 =					"UI Cadre du dialogue",
	MinimapCluster =				"UI Petite carte",
	PlayerFrame =					"UI Frame du joueur", --
}
if (BEB.IsFrame("TitanPanelBarButton")) then
	BEBOPTIONS.UIATTACHFRAMES.TitanPanelBarButton = "Titan Bar" --
end
if (BEB.IsFrame("TitanPanelAuxBarButton")) then
	BEBOPTIONS.UIATTACHFRAMES.TitanPanelAuxBarButton = "Titan Bar 2" --
end
BEBOPTIONS.VARIABLE_FUNCTIONS_DESCIPTIONS = { --
	["$plv"] =					"$plv level du joueur.",
	["$cxp"] =					"$cxp Xp actuel.",
	["$mxp"] =					"$mxp Xp total pour ce level.",
	["$rxp"] =					"$rxp Xp au repos (annoncé par le jeu).",
	["$Rxp"] =					"$Rxp Xp au repos actuel.",
	["$Cxp"] =					"$Cxp Xp total gagné par ce joueur.",
	["$Mxp"] =					"$Mxp Xp restant pour atteindre la fin du level 60.",
	["$txp"] =					"$txp Xp restant pour ce level.",
	["$Txp"] =					"$Txp Xp restant pour atteindre le level 60.",
	["$pdl"] =					"$pdl Pourcentage du level d\195\169j\195\160 effectu\195\169",
	["$Pdl"] =					"$Pdl Pourcentage restant pour atteindre le level 60.",
	["$ptl"] =					"$ptl Pourcentage restant du level actuel.",
	["$res"] =					"$res Montre 'Resting' si vous vous reposez.",
	["$rst"] =					"$rst Montre 'Unrested', 'Rested' ou 'Fully Rested'.",
	["$ptx"] =					"$ptx Xp du pet pour ce level.",
	["$pty"] =					"$pty Xp total du pet pour ce level.",
	["$ppc"] =					"$ppc Pourcentage du level d\195\169j\195\160 effectu\195\169 pour le pet",
	["$ppn"] =					"$ppn Pourcentage restant au pet pour le level actuel.",
	["$pxg"] =					"$pxg Xp du pet restant pour ce level.",
	["$tts"] =					"$tts Temps jou\195\169 dans cette session.",
	["$rss"] =					"$rss Xp par seconde (session).",
	["$rsm"] =					"$rsm Xp par minute (session).",
	["$rsh"] =					"$rsh Xp par heure (session).",
	["$tls"] =					"$tls Durée pour changer de level (session).",
	["$xts"] =					"$xts Xp gagn\195\169 cette session.",
	["$prt"] =					"$prt Pourcentage de l'Xp de repos.",
	["$pre"] =					"$pre Pourcentage de l'Xp de repos par rapport à l'Xp restant du level",
	["$nkx"] =					"$nkx Tu\195\169s pour cette session qui ont donn\195\169 de l'XP.",
	["$xpk"] =					"$xpk Moyenn d'XP par tu\195\169 pour cette session.",
	["$kls"] =					"$kls Nombre de tu\195\169 nécessaire pour changer de level (session).",
}
BEBOPTIONS.TEXTURES = {
	["PlainBackdrop"] =				"Fond d'\195\169cran plein",
	["BEB-BarFill-Rounded"] =		"Barre arroundis",
	["BEB-BarFill-RoundedLight"] =	"Barre arroundis \195\169clair\195\169e",
	["BEB-BarFill-RoundedUp"] =		"Barre arrondis \195\169clair\195\169e par le dessus",
	["BEB-BarFill-Flat"] =			"Barre plate",
	["BEB-ExperienceBarMarkers"] =	"Marqueur iconographique de d\195\169faut",
	["BEB-ExhaustionTicks"] =		"Ticks de d\195\169faut",
	["BEB-ExhaustionTicksGlow"] =		"Eclairage des ticks de d\195\169faut",
	["BEB-BarFill-Metal"] =			"Texture de la barre : metallique", --
	["BEB-BarFill-Wood"] =			"Texture de la barre : bois", --
}
BEBOPTIONS.STRATAS = { --
	BACKGROUND =					"Tr\195\168s faible",
	DIALOG =						"Tr\195\168 haute",
	FULLSCREEN =					"Tr\195\168s tr\195\168s haute",
	HIGH =						"Haute",
	LOW =						"Faible",
	MEDIUM =						"Moyenne",
}
BEBOPTIONS.TEXT = {
	none =						"<AUCUN>",
	profilealreadyexists =			"BEB: Le profil que vous souhaitez cr\195\169er d\195\169j\195\160 existe.",
	frameisinvalid =				"BEB: Le cadre que vous avez entr\195\169 n'existe pas ou est invalide.",
	optionstextwasmouseover =		"BEB: Le text s'affichait lorsque vous passiez la souris sur un object, cette option a \195\169t\195\169 d\195\169sactiv\195\169",
	optionstextwashidden =			"BEB: Le text ne s'affichait jamais. Dor\195\169navant, le text s'affiche.",
}
end
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  German  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
if (GetLocale() == "deDE") then
BEBOPTIONS.TEXTELEMENTS = {
	BEBConfigHeaderText =				"BEB "..BEB.CurrentVersion.." Konfiguration",
	BEBConfigFrameButtonClose =			"Schlie\195\159en",
	BEBDefaultsButton =					"Voreinstellung",
	BEBMainSelector =					"Allgemeines",
	BEBBackgroundSelector =				"Hintergrund",
	BEBXpBarSelector =					"XP-Leiste",
	BEBRestedXpBarSelector =				"Ausgeruhte XP",
	BEBMarkersSelector =				"Markierungen",
	BEBXpTickSelector =					"Erfahrungsticks",
	BEBRestedXpTickSelector =			"Ausgeruhte Ticks",
	BEBRestedXpTickGlowSelector =			"Ticks Leuchten",
	BEBBarTextSelector =				"Leistentext",
	BEBProfileSelector =				"Profile",
	BEBDragableCheckButtonText =			"Bewegbar",
	BEBFlashingCheckButtonText =			"Blinken wenn ausgeruht",
	BEBShownCheckButtonText =			"Sichtbar",
	BEBShowOnMouseoverCheckButtonText =	"Anzeigen bei Mausber\195\188hrung",
	BEBClickTextCheckButtonText =			"Füge den Text mit Linksklick in den Chat ein.",
	BEBColorsHeader =					"Farben",
	BEBAttachHeader =					"Anheften",
	BEBUnrestedTextureColorButtonText =	"Unausgeruht",
	BEBRestedTextureColorButtonText =		"Ausgeruht",
	BEBMaxrestedTextureColorButtonText =	"Voll ausgeruht",
	BEBUnrestedTextColorButtonText =		"Unausgeruht",
	BEBRestedTextColorButtonText =		"Ausgeruht",
	BEBMaxrestedTextColorButtonText =		"Voll ausgeruht",
	BEB_MainAttachToFrame_Label =			"an Rahmen",
	BEB_BarTextFrame_Label =				"Text in der Leiste",
	BEB_TextureFrame_Label =				"Texturendatei",
	BEB_MainAttachPointButton_Label =		"Punkt",
	BEB_MainAttachToPointButton_Label =	"zu Punkt",
	BEB_StrataDDMButton_Label =			"Strata",
	BEBOptionsPositionControlsTitle =		"Position",
	BEBOptionsHeightSlider_Label =		"H\195\182he",
	BEBOptionsWidthSlider_Label =			"Breite",
	BEBOptionsLevelSlider_Label =			"Level",
	BEBOptions_ColorCopy =				"Kopieren",
	BEBOptions_ColorPaste =				"Einf\195\188gen",
	BEBProfileFrameCreateButton =			"Erstellen",
	BEBProfileFrameUseButton =			"Benutzen",
	BEBProfileFrameLoadButton =			"Laden",
	BEBProfileFrameSaveButton =			"Speichern",
	BEBProfileFrameDeleteButton =			"L\195\182schen",
}
BEBOPTIONS.ATTACHPOINTS = {
	TOP =						"Oben",
	BOTTOM =						"Unten",
	LEFT =						"Links",
	RIGHT =						"Rechts",
	TOPLEFT =						"Oben links",
	TOPRIGHT =					"Oben rechts",
	BOTTOMLEFT =					"Unten links",
	BOTTONRIGHT =					"Unten rechts",
	CENTER =						"Mitte",
}
BEBOPTIONS.UIATTACHFRAMES = {
	UIParent =					"UI Parent",
	MainMenuExpBar =				"UI Erfahrungsleiste",
	MainMenuBar =					"UI Hauptleiste",
	ChatFrame1 =					"UI Chat Fenster",
	MinimapCluster =				"UI Minimap",
	PlayerFrame =					"UI UI Einheitenframe des Spielers",
}
if (BEB.IsFrame("TitanPanelBarButton")) then
	BEBOPTIONS.UIATTACHFRAMES.TitanPanelBarButton = "Titan Bar"
end
if (BEB.IsFrame("TitanPanelAuxBarButton")) then
	BEBOPTIONS.UIATTACHFRAMES.TitanPanelAuxBarButton = "Titan Bar 2"
end
BEBOPTIONS.VARIABLE_FUNCTIONS_DESCIPTIONS = {
	["$plv"] =					"$plv Charakterlevel.",
	["$cxp"] =					"$cxp Aktuelle Erfahrung f\195\188r dieses Level.",
	["$mxp"] =					"$mxp Gesamte Erfahrung f\195\188r dieses Level.",
	["$rxp"] =					"$rxp Ausgeruhte Erfahrung laut Spiel.",
	["$Rxp"] =					"$Rxp Tats\195\164chliche ausgeruhte Erfahrung.",
	["$Cxp"] =					"$Cxp Insgesamt gesammelte Erfahrung f\195\188r diesen Charakter.",
	["$Mxp"] =					"$Mxp Erfahrung die ben\195\182tigt wird, bis keine Erfahrung mehr gesammelt werden kann.",
	["$txp"] =					"$txp Erfahrung bis Levelanstieg.",
	["$Txp"] =					"$Txp Erfahrung bis zu Level 60.",
	["$pdl"] =					"$pdl Prozent geschafft f\195\188r dieses Level.",
	["$Pdl"] =					"$Pdl Prozent geschafft bis Ende von Level 60.",
	["$ptl"] =					"$ptl Noch ben\195\182tigte Prozent f\195\188r dieses Level.",
	["$res"] =					"$res Zeigt 'Ausruhen' wenn du dich gerade ausruhst.",
	["$rst"] =					"$rst Zeigt 'Ausgeruht', 'Nicht ausgeruht' und 'Vollst\195\164ndig ausgeruht'.",
	["$ptx"] =					"$ptx Aktuelle Prozent f\195\188r dieses Level des Tieres.",
	["$pty"] =					"$pty Gesamte Erfahrung f\195\188r dieses Level des Tieres.",
	["$ppc"] =					"$ppc Prozent geschafft f\195\188r dieses Level des Tieres.",
	["$ppn"] =					"$ppn Noch ben\195\182tigte Prozent f\195\188r dieses Level des Tieres.",
	["$pxg"] =					"$pxg N\195\182tige Erfahrung bis Levelanstieg des Tieres.",
	["$tts"] =					"$tts Zeit gespielt in dieser Session.",
	["$rss"] =					"$rss Erfahrung pro Sekunde (Session).",
	["$rsm"] =					"$rsm Erfahrung pro Minute (Session).",
	["$rsh"] =					"$rsh Erfahrung pro Stunde (Session).",
	["$tls"] =					"$tls Zeit bis zum nächsten Level (Session).",
	["$xts"] =					"$xts Erfahrung gesammelt in dieser Session.",
	["$prt"] =					"$prt Fehlende Prozent bis vollst\195\164ndig erholt.",
	["$pre"] =					"$pre Fehlende Prozent bis erholt zum nächsten Level.",
	["$nkx"] =					"$nkx Kills diese Session, die Erfahrung gaben.",
	["$xpk"] =					"$xpk Durchschnittliche Erfahrung pro Kill in dieser Session.",
	["$kls"] =					"$kls Anzahl Kills bis zum n\195\164chsten Level (session).",
}
BEBOPTIONS.STRATAS = {
	BACKGROUND =					"Niedrigste",
	DIALOG =						"H\195\182her",
	FULLSCREEN =					"H\195\182chste",
	HIGH =						"Hoch",
	LOW =						"Niedriger",
	MEDIUM =						"Mittel",
}
BEBOPTIONS.TEXTURES = {
	["PlainBackdrop"] =				"Schlichter Hintergrund",
	["BEB-BarFill-Rounded"] =		"Abgerundete Leiste",
	["BEB-BarFill-RoundedLight"] =	"Leicht abgerundete Leiste",
	["BEB-BarFill-RoundedUp"] =		"Abgerundete Leiste mit Licht von oben",
	["BEB-BarFill-Flat"] =			"Flache Leiste",
	["BEB-ExperienceBarMarkers"] =	"Standardm\195\164\195\159iges Markierungsaussehen",
	["BEB-ExhaustionTicks"] =		"Standardh\195\164kchen",
	["BEB-ExhaustionTicksGlow"] =		"Stadard H\195\164kchenleuchten",
	["BEB-BarFill-Metal"] =			"Metallische Leistentextur",
	["BEB-BarFill-Wood"] =			"Hölzerne Leistentextur",
}
BEBOPTIONS.TEXT = {
	none =						"<KEINS>",
	profilealreadyexists =			"BEB: Das Profil, dass du anlegen willst existiert bereits.",
	frameisinvalid =				"BEB: Der Rahmen den du eingegeben hast existiert nicht oder ist ung\195\188ltig.",
	optionstextwasmouseover =		"BEB: Text war bei Mausber\195\188hrung eingestellt, das wurde deaktiviert.",
	optionstextwashidden =			"BEB: Text war auf nie zeigen eingestellt. Text ist jetzt aktiviert.",
}
end