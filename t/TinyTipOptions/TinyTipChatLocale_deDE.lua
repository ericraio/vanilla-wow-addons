--[[ TinyTip by Thrae
-- 
--
-- German Localization
-- For TinyTipChat
--
-- Any wrong words, change them here.
-- 
-- TinyTipChatLocale should be defined in your FIRST localization
-- code.
--
-- Note: Other localization is in TinyTipLocale_deDE.
-- 
-- Contributors: Gamefaq (thank you thank you thank you)
--]]

if TinyTipChatLocale and TinyTipChatLocale == "deDE" then
	TinyTipChatLocale_MenuTitle = "TinyTip Optionen"

	TinyTipChatLocale_On = "An"
	TinyTipChatLocale_Off = "Aus"
	TinyTipChatLocale_GameDefault = "WoW Grundeinstellung"
	TinyTipChatLocale_TinyTipDefault = "TinyTip's Grundeinstellung"

	if getglobal("TinyTipAnchorExists") then
		TinyTipChatLocale_Opt_Main_Anchor			= "Tooltip Grundposition"
		TinyTipChatLocale_Opt_MAnchor					= "Spieler Position"
		TinyTipChatLocale_Opt_FAnchor					= "Fenster Position"
		TinyTipChatLocale_Opt_MOffX						= "Spieler Position waagerechte [X-Achse]"
		TinyTipChatLocale_Opt_MOffY						= "Spieler Position senkrechte [Y-Achse]"
		TinyTipChatLocale_Opt_FOffX						= "Fenster Position waagerechte [X-Achse]"
		TinyTipChatLocale_Opt_FOffY						= "Fenster Position senkrechte [Y-Achse]"
		TinyTipChatLocale_Opt_AnchorAll				= "Verankern von Zusatz Tooltips am Fix Punkt"
		TinyTipChatLocale_Opt_AlwaysAnchor		= "Spiel Tooltips immer am Fix Punkt verankern"

		TinyTipChatLocale_ChatMap_Anchor = {
			["LEFT"]				= "LINKS", 
			["RIGHT"]				= "RECHTS", 
			["BOTTOMRIGHT"]	= "UNTENRECHTS", 
			["BOTTOMLEFT"]	= "UNTENLINKS", 
			["BOTTOM"]			= "UNTEN", 
			["TOP"]					= "OBEN", 
			["TOPLEFT"] 		= "OBENLINKS", 
			["TOPRIGHT"] 		= "OBENRECHTS",
			["CENTER"]			= "MITTE"
		}

		TinyTipChatLocale_Anchor_Cursor = "CURSOR"
		TinyTipChatLocale_Anchor_Sticky = "FEST"

		TinyTipChatLocale_Desc_Main_Anchor = "Stellt die Tooltip Position ein."
		TinyTipChatLocale_Desc_MAnchor = "Stellt die Position f\195\188r den Tooltip wenn man mit dem Mausecourser \195\188ber andere Spieler im Hauptfenster geht."
		TinyTipChatLocale_Desc_FAnchor = "Stellt die Position des Tooltips wenn man \195\188ber ein BELIBIGES Fenster mit dem Mauscourser geht ein (au\195\159er das Hauptfenster)."
		TinyTipChatLocale_Desc_MOffX = "Stellt die horinzontale Position des Tooptips ein f\195\188r den Fixpunkt der Spieler ein."
		TinyTipChatLocale_Desc_MOffY = "Stellt die vertikale Position des Tooltips f\195\188r den Fixpunkt der Spieler eins."
		TinyTipChatLocale_Desc_FOffX = "Stellt die waagerechte Position des Tooltips ausgehend vom Fixpunkt f\195\188r ALLE Fenster ein."
		TinyTipChatLocale_Desc_FOffY = "Stellt die senkrechte Position des Tooltips ausgehend vom Fixpunkt f\195\188r ALLE Fenster ein."
		TinyTipChatLocale_Desc_AnchorAll = "Positioniert ALLE Zusatz Fenster Tooltips am Tooltip Fixpunkt welche die 'GameTooltip_SetDefaultAnchor' Funktion benutzen, anstelle des WoW Tooltippunktes."
		TinyTipChatLocale_Desc_AlwaysAnchor = "Fixiere die Positionen von Fenster Tooltips am Tooltip Fixpunkt welche den erweiterten WoW Tooltip verwenden. Dies kann zb. mit dem Bergbauvorkommen, Kr\195\164uter usw. Tooltips verwendet werden und jedem anderen Tooltipfenster das den erweiterten WoW Tooltip verwendet."

		if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
			TinyTipChatLocale_Opt_ETAnchor				= "Extra Tooltip Position"
			TinyTipChatLocale_Opt_ETOffX					= "Extra Tooltip horizontale Position[X-Achse]"
			TinyTipChatLocale_Opt_ETOffY					= "Extra Tooltip vertikale Position [Y-Achse]"
			TinyTipChatLocale_Desc_ETAnchor 			= "Stellt die Position f\195\188r den Extra Tooltip ein."
			TinyTipChatLocale_Desc_ETOffX					= "Stellt die horizontale Position f\195\188r den Fixpunkt des Extra Tooltips ein."
			TinyTipChatLocale_Desc_ETOffY					= "Stellt die vertikale Position f\195\188r den Fixpunkt des Extra Tooltips ein."

			TinyTipChatLocale_Opt_PvPIconAnchor1	= "PvP Rangsymbol Position"
			TinyTipChatLocale_Opt_PvPIconAnchor2	= "PvP Rangsymbol Grundposition"
			TinyTipChatLocale_Opt_PvPIconOffX			= "PvP Rangsymbol [X-Achse]"
			TinyTipChatLocale_Opt_PvPIconOffY			= "PvP Rangsymbol [Y-Achse]"

			TinyTipChatLocale_Desc_PvPIconAnchor1	= "Stellt die Position f\195\188r das PVP Symbol ein."
			TinyTipChatLocale_Desc_PvPIconAnchor2	= "Stellt die Grundposition f\195\188r das PVP Rangsymbol ein."
			TinyTipChatLocale_Desc_PvPIconOffX		= "Stellt die horizontale X-Achse Position f\195\188r den Fixpunkt des PVP Rangsymbols ein."
			TinyTipChatLocale_Desc_PvPIconOffY		= "Stellt die vertikale Y-Achse Position f\195\188r den Fixpunkt des PVP Rangsymbols ein."

			TinyTipChatLocale_Opt_RTIconAnchor1		= "Schlachtgruppenziel Symbol Fixpunkt"
			TinyTipChatLocale_Opt_RTIconAnchor2		= "Schlachtgruppenziel Symbol Grundpositions Fixpunkt"
			TinyTipChatLocale_Opt_RTIconOffX			= "Schlachtgruppenziel Symbol X-Achse]"
			TinyTipChatLocale_Opt_RTIconOffY			= "Schlachtgruppenziel Symbol [Y-Achse]"

			TinyTipChatLocale_Desc_RTIconAnchor1	= "Stellt die Position f\195\188r das Schlachtgruppenziel Symbol ein."
			TinyTipChatLocale_Desc_RTIconAnchor2	= "Stellt die Grundposition f\195\188r das Schlachtgruppenziel Symbol ein."
			TinyTipChatLocale_Desc_RTIconOffX			= "Stellt die horizontale X-Achse Position f\195\188r den Fixpunkt des Schlachtgruppenziel Symbols ein."
			TinyTipChatLocale_Desc_RTIconOffY			= "Stellt die vertikale Y-Achse Position f\195\188r den Fixpunkt des Schlachtgruppenziel Symbols ein."

			TinyTipChatLocale_Opt_BuffAnchor1			= "Buffs Position"
			TinyTipChatLocale_Opt_BuffAnchor2			= "Buffs Grundposition"
			TinyTipChatLocale_Opt_BuffOffX				= "Buffs [X-Achse]"
			TinyTipChatLocale_Opt_BuffOffY				= "Buffs [Y-Achse]"

			TinyTipChatLocale_Opt_DebuffAnchor1		= "Debuffs Position"
			TinyTipChatLocale_Opt_DebuffAnchor2		= "Debuffs Grundposition"
			TinyTipChatLocale_Opt_DebuffOffX			= "Debuff [X-Achse]"
			TinyTipChatLocale_Opt_DebuffOffY			= "Debuff [Y-Achse]"

			TinyTipChatLocale_Desc_BuffAnchor1	= "Stellt die Position f\195\188r die Buff Symbole ein."
			TinyTipChatLocale_Desc_BuffAnchor2	= "Stellt die Grundposition f\195\188r die Buff Symbole ein."
			TinyTipChatLocale_Desc_BuffOffX			= "Stellt die horizontale X-Achse Position f\195\188r den Fixpunkt der Buff Symbole ein."
			TinyTipChatLocale_Desc_BuffOffY			= "Stellt die vertikale Y-Achse Position f\195\188r den Fixpunkt der Buff Symbole ein."

			TinyTipChatLocale_Desc_DebuffAnchor1	= "Stellt die Position f\195\188r die Debuff Symbole ein."
			TinyTipChatLocale_Desc_DebuffAnchor2	= "Stellt die Grundposition f\195\188r die Debuff Symbole ein."
			TinyTipChatLocale_Desc_DebuffOffX			= "Stellt die horizontale X-Achse Position f\195\188r den Fixpunkt der Debuff Symbole ein."
			TinyTipChatLocale_Desc_DebuffOffY			= "Stellt die vertikale Y-Achse Position f\195\188r den Fixpunkt die Debuff Symbole ein."
		end
	end

	TinyTipChatLocale_Opt_Main_Text					= "Text"
	TinyTipChatLocale_Opt_HideLevelText			= "Verstecke Level Text"
	TinyTipChatLocale_Opt_HideRace					= "Verstecke Rassen und Kreatur Typen Text"
	TinyTipChatLocale_Opt_KeyElite					= "Benutze Rar/Elite Markierung"
	TinyTipChatLocale_Opt_PvPRank						= "PvP Rang"
	TinyTipChatLocale_Opt_HideGuild					= "Verstecke Gilden Namen"
	TinyTipChatLocale_Opt_LevelGuess				= "Verstecke Levelnangabe"
	TinyTipChatLocale_Opt_ReactionText			= "Zeige Reaktionstext"

	TinyTipChatLocale_Desc_Main_Text = "Stellt ein was in dem Spieler Tooltip angezeigt wird."
	TinyTipChatLocale_Desc_HideLevelText = "Das Level des Ziels anzeigen?"
	TinyTipChatLocale_Desc_HideRace = "Spieler Rasse oder Monster Typ anzeigen?"
	TinyTipChatLocale_Desc_KeyElite = "Anzeigeart * f\195\188r Elite, ! f\195\188r Rare, !* f\195\188r Rare Elite, und ** f\195\188r Weld Boss."
	TinyTipChatLocale_Desc_PvPRank = "Stelle die Optionen ein um den PVP Rang in Textform anzuzeigen."
	TinyTipChatLocale_Desc_HideGuild = "Gildennamen der Spieler ausschalten?."
	TinyTipChatLocale_Desc_ReactionText = "Reaktionstext der Ziele anzeigen ? (Freundlich, Feindlich, usw.)"
	TinyTipChatLocale_Desc_LevelGuess = "Anzeige umschalten (Dein Level +10) anstelle von ?? f\195\188r unbekannte Gegner Level?"

	TinyTipChatLocale_Opt_Main_Appearance			= "Aussehen"
	TinyTipChatLocale_Opt_Scale								= "Scalierung"
	TinyTipChatLocale_Opt_Fade								= "Ausblenden Effect"
	TinyTipChatLocale_Opt_BGColor							= "Hintergrund Optionen"
	TinyTipChatLocale_Opt_Border							= "Rand Optionen"
	TinyTipChatLocale_Opt_SmoothBorder				= "Rand und Hintergrund gl\195\164tten"
	TinyTipChatLocale_Opt_Friends							= "Farbton f\195\188r Freunde und Gildenkollegen"
	TinyTipChatLocale_Opt_HideInFrames				= "Verstecke Tooltips von Spieler Fenstern"
	TinyTipChatLocale_Opt_FormatDisabled			= "Deaktiviere Tooltip Formatierung"
	TinyTipChatLocale_Opt_Compact							= "Zeige kompakten Tooltip"

	TinyTipChatLocale_ChatIndex_PvPRank = { 
		[1] = TinyTipChatLocale_Off, 
		[2] = "Zeige Rang Namen",
		[3] = "Zeige Rang Nummer nach dem Namen"
	}

	TinyTipChatLocale_ChatIndex_Fade = {
		[1] = "Immer Ausblenden ",
		[2] = "Nie Ausblenden"
	}

	TinyTipChatLocale_ChatIndex_BGColor = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "F\195\164rbe NPCs wie PCs",
		[3] = "Immer Schwarz"
	}

	TinyTipChatLocale_ChatIndex_Border = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "Verstecke Ramen"
	}

	TinyTipChatLocale_ChatIndex_Friends = {
		[1] = "F\195\164rbe nur Namen",
		[2] = "Kein einf\195\164rben"
	}

	TinyTipChatLocale_Desc_Main_Appearance = "Stellt Aussehen und Verhalten des Tooltips ein."
	TinyTipChatLocale_Desc_Fade = "Tooltip weich ausblenden lassen oder einfach wegschalten?"
	TinyTipChatLocale_Desc_Scale =  "Stellt die Skalierung des Tooltips und eventuell angehefter Icons ein."
	TinyTipChatLocale_Desc_BGColor = "Stellt die Farben des Tooltip Hintergunds ein."
	TinyTipChatLocale_Desc_Border = "Stellt die Farben f\195\188r den Tooltipramen ein."
	TinyTipChatLocale_Desc_SmoothBorder = "Ver\195\164ndert die voreingestellte Transpazenz und gr\195\182\195\159e des Hintergrunds und Ramens."
	TinyTipChatLocale_Desc_Friends = "Namen und Hintegrund anders einf\195\164rben als von Freunden und Gidenmitgliedern?"
	TinyTipChatLocale_Desc_HideInFrames = "Verstecke den Tooltip von Interface Fenstern (Party/Schachtgruppe/Ziel) die zu Spielern geh\195\182ren, wenn man mit dem Mauscourser \195\188ber sie geht."
	TinyTipChatLocale_Desc_FormatDisabled = "Deaktiviert TinyTipïs spezielle Tooltip Formatierung."
	TinyTipChatLocale_Desc_Compact = "Verkleinert den Tooltip ohne \195\164nderrung der Skallierung."

	if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
		TinyTipChatLocale_Opt_PvPIconScale	= "PvP Symbol Skalierung"
		TinyTipChatLocale_Opt_RTIconScale		= "Schlachtgruppenziel Skalierung"
		TinyTipChatLocale_Opt_BuffScale			= "Buff und Debuff Skalierung"

		TinyTipChatLocale_Desc_PvPIconScale		= "Stellt die gr\195\182\195\159e das PVP Symbols ein."
		TinyTipChatLocale_Desc_RTIconScale		= "Stellt die gr\195\182\195\159e das Schlachtgruppen Symbols ein."
		TinyTipChatLocale_Desc_BuffScale			= "Stellt die gr\195\182\195\159e das Buff und Debuff Symbols ein."

		TinyTipChatLocale_Opt_Main_Targets				= "Ziel von..."
		TinyTipChatLocale_Opt_ToT									= "Spieler Tooltip's "
		TinyTipChatLocale_Opt_ToP									= "Gruppe"
		TinyTipChatLocale_Opt_ToR									= "Schlachtgruppe"

		TinyTipChatLocale_ChatIndex_ToT = {
			[1] = "Zeige Ziel des Spielers in einer neuen Spalte",
			[2] = "Zeige Ziel des Spielers in der gleichen Spalte wie seinen Namen"
		}

		TinyTipChatLocale_ChatIndex_ToP = {
			[1] = "Zeige alle Namen",
			[2] = "Zeige # der Spieler"
		}

		TinyTipChatLocale_ChatIndex_ToR = {
			[1] = "Zeige # der Spieler",
			[2] = "Zeige Anzahl aus jeder Klasse",
			[3] = "Zeige ALL Namen"
		}

		TinyTipChatLocale_Desc_Main_Targets = "Zeigt das Ziel des eigenen Ziels auch im Tooltip an."
		TinyTipChatLocale_Desc_ToT = "Stellt ein ob man den Namen des Ziels, vom eigenen Ziel angezeigt haben m”chte."
		TinyTipChatLocale_Desc_ToP = "Zeigt an ob jemand anderes aus deiner Gruppe, dein Tooltip Ziel auch angeklickt hat."
		TinyTipChatLocale_Desc_ToR = "Zeigt an ob jemand anderes aus deiner Schlachtgruppe, dein Tooltip Ziel auch angeklickt hat."

		TinyTipChatLocale_Opt_Main_Extras					= "Extras"
		TinyTipChatLocale_Opt_PvPIcon							= "Zeige PvP Rangsymbol"
		TinyTipChatLocale_Opt_ExtraTooltip				= "TinyTip's Extra Tooltip"
		TinyTipChatLocale_Opt_Buffs								= "Buffs"
		TinyTipChatLocale_Opt_Debuffs							= "Debuffs"
		TinyTipChatLocale_Opt_ManaBar					= "Zeigt Mana Balken"
		TinyTipChatLocale_Opt_RTIcon					= "Zeigt Schlachtgruppensymbol"

		TinyTipChatLocale_ChatIndex_ExtraTooltip	= {
			[1] = "Zeige Informationen von anderen Addons",
			[2] = "Zeige von anderen Addons & TinyTipïs Extra Infos"
		}

		TinyTipChatLocale_ChatIndex_Buffs = {
			[1] = "Zeige 8 Buffs",
			[2] = "Zeige nur selbst zauberbare Buffs",
			[3] = "Zeige Menge an Buffs im Tooltip"
		}

		TinyTipChatLocale_ChatIndex_Debuffs = {
			[1] = "Zeige 8 Debuffs",
			[2] = "Zeige NUR selbst entfernbare Debuffs",
			[3] = "Zeige Menge von entfernbaren Debuffs im Tooltip",
			[4] = "Zeige Menge von jeder Art selbst entfernbarer Debuffs im Tooltip",
			[5] = "Zeige Menge von ALLEN Arten von Debuffs im Tooltip"
		}

		TinyTipChatLocale_Desc_Main_Extras = "Extra Funktionen die nicht im TinyTip Basis Addon enthalten sind."
		TinyTipChatLocale_Desc_PvPIcon = "Anzeigen des PVP Rang Icons eines Spielers neben dem Tooltip?"
		TinyTipChatLocale_Desc_ExtraTooltip = "Zus\195\164tzliche Addon Informationen von TinyTip und anderen Addons in einem SEPERATEN Tooltip anzzeigen? (Manche Addons ben\195\182\tigen einen zusatz Tooltip f\195\188r ihre Informationen.)"
		TinyTipChatLocale_Desc_Buffs			= "Zeige Informationen welche Buffs das Ziel hat."
		TinyTipChatLocale_Desc_Debuffs		= "Zeige Informationen welche Debuffs das Ziel hat."
		TinyTipChatLocale_Desc_ManaBar		= "Zeige eine Manaleiste unter der Lebensenergieleiste."
		TinyTipChatLocale_Desc_RTIcon			= "Zeigt das Schlachtgruppensymbol f\195\188r das ausgew\195\164hlte Ziel, falls es existiert."
	end

	TinyTipChatLocale_Opt_Profiles = "Speichere die Einstellungen pro Charakter"
	TinyTipChatLocale_Desc_Profiles = "Auswahl ob man pro Charakter die Einstellungen speichern m\195\182chte oder global f\195\188r alle."

	TinyTipChatLocale_Opt_Main_Default = "Optionen zur\195\188cksetzen"
	TinyTipChatLocale_Desc_Main_Default = "Setzt die Einstellungen zurr\195\188ck zu den Grundeinstellungen."

	-- slash command-related stuff
	TinyTipChatLocale_DefaultWarning = "Bist du SICHER das du die Einstellungen zurr\195\188ck auf die Grundeinstellungen setzen willst? Tippe ein "
	TinyTipChatLocale_NotValidCommand = "ist keine g\195\188lte eingabe."

	TinyTipChatLocale_Confirm = "best\195\188tige" -- must be lowercase!
	TinyTipChatLocale_Opt_Slash_Default = "standart" -- ditto

	-- we're done with this.
	TinyTipChatLocale = nil
end
