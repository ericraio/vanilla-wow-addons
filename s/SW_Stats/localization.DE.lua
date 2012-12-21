--[[
	WARNING! If you edit this file you need a good editor, not notepad.
	This file HAS to be saved in UTF-8 format (without signature) else we would have to escape
	all special chars
	
]]--
if (GetLocale() == "deDE") then

-- the main slash commands registered (only 2)
SW_RootSlashes = {"/swstats", "/sws"};


SW_CONSOLE_NOCMD = "Diesen Befehl gibt es nicht: ";
SW_CONSOLE_HELP ="Hilfe: "
SW_CONSOLE_NIL_TRAILER = " ist nich definiert."; -- space at beginning
SW_CONSOLE_SORTED = "Sortiert";
SW_CONSOLE_NOREGEX = "Es gibt kein Regex für diesen event.";
SW_CONSOLE_FALLBACK = "Regex gefunden und hinzugefügt";
SW_FALLBACK_BLOCK_INFO = "Dieser event wurde gesperrt und kann sich nicht selbst aktualisieren.";
SW_FALLBACK_IGRNORED = "Dieser Event wurde ignoriert.";
SW_EMPTY_EVENT = "Wird dieser Event benötigt?: ";
SW_INFO_PLAYER_NF = "Es gibt keine Information für:";
SW_PRINT_INFO_FROMTO = "|cffffffffVon:|r%s, |cffffffffZiel:|r%s,";
SW_PRINT_ITEM = "|cffffffff%s:|r%s,";
SW_PRINT_ITEM_DMG = "Schaden";
SW_PRINT_ITEM_HEAL = "Geheilt";
SW_PRINT_ITEM_THROUGH = "Durch";
SW_PRINT_ITEM_TYPE = "Art";
SW_PRINT_ITEM_CRIT = "|cffff2020KRIT|r";
SW_PRINT_ITEM_WORLD = "WELT";
SW_PRINT_ITEM_NORMAL = "Normal";
SW_PRINT_ITEM_RECIEVED = "Erhalten";
SW_PRINT_INFO_RECIEVED = "|cffff2020Schaden:%s|r, |cff20ff20Heilung:%s|r";
SW_PRINT_ITEM_TOTAL_DONE = "Gesamt";
SW_PRINT_ITEM_NON_SCHOOL = "Sonstiges";
SW_PRINT_ITEM_IGNORED = "Ignoriert";
SW_PRINT_ITEM_DEATHS = "Tode";
SW_SYNC_CHAN_JOIN = "|cff20ff20SWSync: Beigetreten:|r";
SW_SYNC_CHAN_FAIL= "|cffff2020SWSync: Konnte dem folgendem Channel nicht beitreten:|r";

SW_BARS_WIDTHERROR = "Der Balken ist zu breit!"
SW_SYNC_JOINCHECK_FROM = "SWSyncChannel %s von: %s beitreten?"
SW_SYNC_JOINCHECK_INFO = "Alte Daten werden gelöscht!"
SW_SYNC_CURRENT = "Derzeitiger SyncChannel: %s";
SW_B_CONSOLE = "K";
SW_B_SETTINGS = "E";
SW_B_REPORT = "R";
SW_B_SYNC = "Y";

SW_STR_PET_PREFIX = "[Beg.] "; -- pet prefix for pet info displayed in the bars
SW_STR_VPP_PREFIX = "[Alle Beg.] "; -- pet prefix for virtual pet per player info displayed in the bars
SW_STR_VPR = "[Raid Beg.]"; -- pet string for virtual pet per raid info displayed in the bars
-- 1.5.beta.1 Reset vote
SW_STR_RV = "|cffff5d5dReset Abstimmung!|r Von |cffff5d5d%s|r. Wollt Ihr den SyncChannel zurücksetzten?";
SW_STR_RV_PASSED =  "|cffffff00[SW Sync]|r |cff00ff00Reset Abstimmung erfolgreich!|r";
SW_STR_RV_FAILED = "|cffffff00[SW Sync]|r |cffff5d5dReset Abstimmung fehlgeschlagen!|r";
SW_STR_VOTE_WARN = "|cffffff00[SW Sync]|r |cffff5d5dNicht gleich so viele Abstimmungen (wartet etwas)...|r";

--1.5.3
--Raid DPS Strings
SW_RDPS_STRS = {
	["CURR"] = "RDPS dieser Kampf",
	["ALL"] = "RDPS",
	["LAST"] = "RDPS letzter Kampf",
	["MAX"] = "RDPS Max",
	["TOTAL"] = "RDPS Die traurige Wahrheit", -- a timer that keeps running, no matter if in or out of fight
}

--[[
   you can ONLY localize the values! NOT the keys
   don't change aynthing like this ["someString"]
--]]

SW_Spellnames = {
	[1] = "Geringen Fluch aufheben",
	[2] = "Fluch aufheben",
	[3] = "Magiebannung",
	[4] = "Krankheit heilen",
	[5] = "Krankheit aufheben",
	[6] = "Läutern",
	[7] = "Reinigung des Glaubens",
	[8] = "Vergiftung heilen",
	[9] = "Vergiftung aufheben",
	[10] = "Reinigen",
}

SW_LocalizedGUI ={
	["SW_FrameConsole_Title"] = "SW v"..SW_VERSION,
	["SW_FrameConsole_Tab1"] = "Allgemein",
	["SW_FrameConsole_Tab2"] = "Eventinfo",
	--["SW_FrameConsole_Tab3"] = "Einstellung",
	["SW_BarSettingsFrameV2_Tab1"] = "Daten",
	["SW_BarSettingsFrameV2_Tab2"] = "Aussehen",
	["SW_Chk_ShowEventText"] = "Event->Regex anzeigen",
	["SW_Chk_ShowOrigStrText"] = "Kampflog Nachricht",
	["SW_Chk_ShowRegExText"] = "RegEx anzeigen",
	["SW_Chk_ShowMatchText"] = "Gefunden anzeigen",
	["SW_Chk_ShowSyncInfoText"] = "Sync Nachrichten anzeigen",
	["SW_Chk_ShowOnlyFriendsText"] = "Nur 'Freunde' anzeigen.",
	["SW_Chk_ShowSyncBText"] = "Sync Knopf anzeigen",
	["SW_Chk_ShowConsoleBText"] = "Konsolen Knopf anzeigen",
	["SW_Chk_MergePetsText"] = "Pet und sein Herr sind eins",
	["SW_RepTo_SayText"] = "Sagen",
	["SW_RepTo_GroupText"] = "Gruppe",
	["SW_RepTo_RaidText"] = "Raid",
	["SW_RepTo_GuildText"] = "Gilde",
	["SW_RepTo_ChannelText"] = "Channel",
	["SW_RepTo_WhisperText"] = "Flüstern",
	["SW_RepTo_ClipboardText"] = "Textbox",
	["SW_RepTo_OfficerText"] = "Offizier",
	["SW_BarReportFrame_Title_Text"] = "Report an..",
	["SW_Chk_RepMultiText"] = "Einzelne Zeilen",
	["SW_Filter_PCText"] = "PC",
	["SW_Filter_NPCText"] = "NPC",
	["SW_Filter_GroupText"] = "Gruppe/Raid",
	["SW_Filter_EverGroupText"] = "Jemals in Gruppe/Raid",
	["SW_Filter_NoneText"] = "Keinen",
	["SW_GeneralSettings_Title_Text"] = "Allgemeine Einstellungen",
	["SW_BarSyncFrame_Title_Text"] = "SyncChannel Einstellungen",
	["SW_BarSettingsFrameV2_Title_Text"] = "Einstellungen",
	["SW_BarSyncFrame_SyncLeave"] = "Verlassen",
	["SW_BarSyncFrame_OptGroupText"] = "Gruppe",
	["SW_BarSyncFrame_OptRaidText"] = "Raid",
	["SW_BarSyncFrame_OptGuildText"] = "Gilde",
	["SW_BarSyncFrame_SyncSend"] = "Senden an",
	["SW_CS_Damage"] = "Farbe: Schaden",
	["SW_CS_Heal"] = "Farbe: Heilung",
	["SW_CS_BarC"] = "Farbe: Balken",
	["SW_CS_FontC"] = "Farbe: Font",
	["SW_CS_OptC"] = "Farbe: Knopf",
	["SW_TextureSlider"] = "Textur:",
	["SW_FontSizeSlider"] = "Schriftgröße:",
	["SW_BarHeightSlider"] = "H:",
	["SW_BarWidthSlider"] = "Spalten Anzahl:",
	["SW_OptChk_NumText"] = "Anzahl",
	["SW_OptChk_RankText"] = "Rang",
	["SW_OptChk_PercentText"] = "%",
	["SW_VarInfoLbl"] = "Diese Info braucht ein Ziel. 'Ändern' klicken um einen neuen Namen einzugeben, oder 'Von Ziel' klicken um euer derzeitiges Ziel zu verwenden.",
	["SW_SetInfoVarFromTarget"] = "Von Ziel",
	["SW_ColorsOptUseClassText"] = "Klassenfarben",
	["SW_BarSyncFrame_SyncARPY"] = "Erlauben",
	["SW_BarSyncFrame_SyncARPN"] = "Verbieten",
	-- 1.5 new pet filter labels 
	["SW_NoPetInfoLabel"] = "Diese Auswertung hat keine Begleiter Einstellungen.",
	["SW_PF_InactiveText"] = "Inaktiv",
	["SW_PF_ActiveText"] = "Aktiv",
	["SW_PF_MMText"] = "Zusammenfügen: Gemacht",
	["SW_PF_MRText"] = "Zusammenfügen: Erhalten",
	["SW_PF_MBText"] = "Zusammenfügen: Beides",
	["SW_PF_CurrentText"] = "Derzeitige Begleiter",
	["SW_PF_VPPText"] = "Virtueller Begleiter pro Spieler",
	["SW_PF_VPRText"] = "Virtueller Begleiter pro Schlachtzug",
	["SW_PF_IgnoreText"] = "Begleiter Information ignorieren",
	
	-- 1.5.3 new color settings
	["SW_CS_TitleBar"] = "Titel Balkenfarbe",
	["SW_CS_TitleFont"] = "Titel Schrift",
	["SW_CS_Backdrops"] = "Umrandung und Tab",
	["SW_CS_MainWinBack"] = "Hauptfenster Hintergrund",
	["SW_CS_ClassCAlpha"] = "Klassen Durchsichtigkeit",
}

SW_GS_Tooltips["SW_Chk_ShowOnlyFriends"] = "Diese Option wird nur für /sws Kommandos verwendet die in der Kosole ausgegeben werden.";
SW_GS_Tooltips["SW_Chk_ShowSyncB"] = "Option um einen extra Knopf für die Sync-einstellungen im Hauptfenster anzuzeigen.";
SW_GS_Tooltips["SW_Chk_ShowConsoleB"] = "Option um einen extra Knopf für die Konsole im Hauptfenster anzuzeigen.";
SW_GS_Tooltips["SW_CS_Damage"] = "Die Farbe mit der 'Schadensbalken' angezeigt werden. Wird z.B. bei der Detailansicht verwendet.";
SW_GS_Tooltips["SW_CS_Heal"] = "Die Farbe mit der 'Heilungsbalken' angezeigt werden. Wird z.B. bei der Detailansicht verwendet.";
SW_GS_Tooltips["SW_CS_BarC"] = "Die Farbe mit der die Balken angezeigt werden. (Manche Daten verwenden Standardfarben, dann wird diese Farbe ignoriert).";
SW_GS_Tooltips["SW_CS_FontC"] = "Die Farbe mit der die Schrift dargestellt wird.";
SW_GS_Tooltips["SW_CS_OptC"] = "Ändert die Farbe des Knopfes unterhalb des Hauptfensters.";
SW_GS_Tooltips["SW_TextureSlider"] = "Ändert die Textur der Balken in dieser Ansicht.";
SW_GS_Tooltips["SW_FontSizeSlider"] = "Ändert die Schriftgröße in dieser Ansicht";
SW_GS_Tooltips["SW_BarHeightSlider"] = "Ändert die Balkenhöhe in dieser Ansicht";
SW_GS_Tooltips["SW_ColCountSlider"] = "Ändert die Anzahl der Balkenspalten in dieser Ansicht";
SW_GS_Tooltips["SW_SetOptTxtFrame"] = "Ändert den Text im Knopf unterhalb des Hauptfensters.";
SW_GS_Tooltips["SW_SetFrameTxtFrame"] = "Ändert den Text im Titel des Hauptfensters.";
SW_GS_Tooltips["SW_OptChk_Num"] = "Zeigt den numerischen Wert an (z.B. Schaden, Heilung etc.)";
SW_GS_Tooltips["SW_OptChk_Rank"] = "Zeigt die Rangliste an.";
SW_GS_Tooltips["SW_OptChk_Percent"] = "Zeigt den Prozentwert an den ein Balken vom Gesamtwert hat.";
SW_GS_Tooltips["SW_Filter_None"] = "Es werden keine PC/NPC/Gruppen Filter verwendet. (Alle Daten werden in den Balken angezeigt)";
SW_GS_Tooltips["SW_Filter_PC"] = "Es wird ein Filter benutzt um nur Spieler anzuzeigen. Diese müssen mindestens einmal als Ziel ausgewählt worden sein, oder in eurer Gruppe/Raid gewesen sein.";
SW_GS_Tooltips["SW_Filter_NPC"] = "Es wird ein Filter verwendet um nur 'Mobs' anzuzeigen. Diese müssen mindestens einmal als Ziel ausgewählt worden sein";
SW_GS_Tooltips["SW_Filter_Group"] = "Es wird ein Filter verwendet um nur Personen und Pets in der Gruppe/Raid anzuzeigen.";
SW_GS_Tooltips["SW_Filter_EverGroup"] = "Es wird ein Filter verwendet um nur Personen und Pets anzuzeigen die jemals in der Gruppe/Raid waren.";
SW_GS_Tooltips["SW_ClassFilterSlider"] = "Gibt einen 'Klassenfilter' an. Es werden nur Personen mit dieser Klasse angezeigt. Diese müssen mindestens einmal als Ziel ausgewählt worden sein, oder in eurer Gruppe/Raid gewesen sein.";
SW_GS_Tooltips["SW_InfoTypeSlider"] = "Hier kann man angeben welche Art von Daten man anzeigen möchte. Ein (S) bedeutet das diese Daten gesynced werden. ";
SW_GS_Tooltips["SW_ColorsOptUseClass"] = "Falls diese Option aktiv ist werden die Balken nach Klassen gefärbt. (Überschreibt die oben angegebene Balkenfarbe falls die Klasse bekannt ist.)";
SW_GS_Tooltips["SW_Chk_ShowDPS"] = "Eure DPS im Titel des Hauptfensters Anzeigen?";
SW_GS_Tooltips["SW_OptCountSlider"] = "Ändert die Anzahl der Knöpfe unterhalb des Hauptfensters.";
SW_GS_Tooltips["SW_AllowARP"] = "Erlaubt das Posten von Stats im Raid";
SW_GS_Tooltips["SW_DisAllowARP"] = "Verbietet das Posten von Stats im Raid";
SW_GS_Tooltips["SW_OptChk_Running"] = "Option abwählen um Datenkollektion zu pausieren. Option auswählen um sie wieder zu starten. Datenkollektion kann in einem SyncChannel nicht deaktiviert werden.";
-- 1.5 new pet filter Tooltips
SW_GS_Tooltips["SW_PF_Inactive"] = "Die neuen Begleiter Mechanismen sind zum grossteil inaktiv. Begleiter werden wie alles andere angezeigt.";
SW_GS_Tooltips["SW_PF_Active"] = "Begleiter werden mit "..SW_STR_PET_PREFIX.." markiert. Kontrollierte Begleiter ( z.B. Gedankenkontrolle ) werden angezeigt. Nur die Ereignisse während das ziel kontrolliert wurde werden gezählt. Eigene Spieler in der Gruppe/ Schlachtzug die von Feinden kontrolliert wurden tauchen nicht auf. ";
SW_GS_Tooltips["SW_PF_MM"] = "Begleiter werden versteckt. Schaden und Heilung den die Begleiter gemacht haben werden ihren Besitzern gutgeschrieben.";
SW_GS_Tooltips["SW_PF_MR"] = "Begleiter werden versteckt. Schaden und Heilung den die Begleiter erhalten haben werden ihren Besitzern gutgeschrieben.";
SW_GS_Tooltips["SW_PF_MB"] = "Begleiter werden versteckt. Schaden und Heilung den die Begleiter gemacht UND erhalten haben werden ihren Besitzern gutgeschrieben.";
SW_GS_Tooltips["SW_PF_Current"] = "Es werden nur aktive Begleiter angezeigt.";
SW_GS_Tooltips["SW_PF_VPP"] = "Alle Begleiter die ein Spieler jemals hatte werden zu einem Begleiter zusammengefügt.";
SW_GS_Tooltips["SW_PF_VPR"] = "Alle Begleiter die der Schlachtzug jemals hatte werden zu einem Begleiter zusammengefügt.";
SW_GS_Tooltips["SW_PF_Ignore"] = "Begleiter Information wird ignoriert.";
--1.5.3 new color options

SW_GS_Tooltips["SW_CS_TitleBar"] =  "Ändert die Farbe aller Titelbalken und der Knöpfe in Ihnen.";
SW_GS_Tooltips["SW_CS_TitleFont"] =  "Ändert die Farbe des Textes in den Titelbalken.";
SW_GS_Tooltips["SW_CS_Backdrops"] =  "Ändert die Farbe des Rahmens um die Fenster.";
SW_GS_Tooltips["SW_CS_MainWinBack"] = "Ändert die Hintergrundfarbe des Hauptfensters.";
SW_GS_Tooltips["SW_CS_ClassCAlpha"] = "Only the alpha channel set here will be used for class coloring.";
	
-- edit boxes
SW_GS_EditBoxes["SW_SetOptTxtFrame"] = {"Ändern","Knopftext: ", "Neuer Knopftext:" };
SW_GS_EditBoxes["SW_SetFrameTxtFrame"] = {"Ändern","Fenstertext: ", "Neuer Fenstertext:" };
SW_GS_EditBoxes["SW_SetInfoVarTxtFrame"] = {"Ändern","Info für: ", "Neuer Name des Spielers oder Mobs:" };
SW_GS_EditBoxes["SW_SetSyncChanTxtFrame"] = {"Ändern","SyncChannel: ", "Neuer SyncChannel:" };

--popups
StaticPopupDialogs["SW_Reset"]["text"] = "Sollen die Daten wirklich gelöscht werden?"
StaticPopupDialogs["SW_ResetFailInfo"]["text"] = "Ihr seid in einem SyncChannel und könnt die Daten nicht löschen. Nur die Gruppen bzw. Raidleitung kann das für einen SyncChannel.";
StaticPopupDialogs["SW_ResetSync"]["text"] = "Ihr seid in einem SyncChannel und werdet an alle eine Löschanweisung senden. Sollen die Daten wirklich gelöscht werden?";
StaticPopupDialogs["SW_PostFail"]["text"] = "Das geht leider nicht. Die Raidleitung hat das posten von Daten nicht zugelassen.";
StaticPopupDialogs["SW_InvalidChan"]["text"] = "Dieser Name ist ungültig."

-- key bindig strings
BINDING_HEADER_SW_BINDINGS = "SW Stats";
BINDING_NAME_SW_BIND_TOGGLEBARS = "Hauptfenster anzeigen bzw. verstecken.";
BINDING_NAME_SW_BIND_CONSOLE = "Konsole anzeigen bzw. verstecken.";
BINDING_NAME_SW_BIND_PAGE1 = "Info tab 1 anzeigen";
BINDING_NAME_SW_BIND_PAGE2 = "Info tab 2 anzeigen";
BINDING_NAME_SW_BIND_PAGE3 = "Info tab 3 anzeigen";
BINDING_NAME_SW_BIND_PAGE4 = "Info tab 4 anzeigen";
BINDING_NAME_SW_BIND_PAGE5 = "Info tab 5 anzeigen";
BINDING_NAME_SW_BIND_PAGE6 = "Info tab 6 anzeigen";
BINDING_NAME_SW_BIND_PAGE7 = "Info tab 7 anzeigen";
BINDING_NAME_SW_BIND_PAGE8 = "Info tab 8 anzeigen";
BINDING_NAME_SW_BIND_PAGE9 = "Info tab 9 anzeigen";
BINDING_NAME_SW_BIND_PAGE10 = "Info tab 10 anzeigen";

-- Minimap Icon Menu strings
SW_MiniIconMenu[2]["textShow"] = "Hauptfenster anzeigen";
SW_MiniIconMenu[2]["textHide"] = "Hauptfenster verstecken";
SW_MiniIconMenu[3]["textShow"] = "Konsole anzeigen";
SW_MiniIconMenu[3]["textHide"] = "Konsole verstecken";
SW_MiniIconMenu[4]["textShow"] = "Allgemeine Einstellungen";
SW_MiniIconMenu[4]["textHide"] = "Allgemeine Einstellungen";
SW_MiniIconMenu[5]["textShow"] = "Sync Einstellungen anzeigen";
SW_MiniIconMenu[5]["textHide"] = "Sync Einstellungen verstecken";
SW_MiniIconMenu[7]["text"] = "Daten Reset";
SW_MiniIconMenu[9]["text"] = "Gruppeninfo Update";
--info types
SW_InfoTypes[1]["t"] = "Schaden Liste (S)";
SW_InfoTypes[1]["d"] = "Zeigt eine einfache Schadensliste an (Wer hat den meisten Schaden gemacht?)";
SW_InfoTypes[2]["t"] = "Heilung Liste (S)";
SW_InfoTypes[2]["d"] = "Zeigt eine einfache Heilungsliste an. (Wer hat am meisten geheilt?) Anmerkung: Overheals werden bei diesen Zahlen gezählt.";
SW_InfoTypes[3]["t"] = "Schaden Erhalten Liste (S)";
SW_InfoTypes[3]["d"] = "Zeigt eine Liste mit Schaden erhalten an. (Wer hat den meisten Schaden erhalten?)";
SW_InfoTypes[4]["t"] = "Heilung Erhalten Liste (S)";
SW_InfoTypes[4]["d"] = "Zeigt eine Liste der geheilten Personen. (Wer hat am meisten Heilung erhalten?)";
SW_InfoTypes[5]["t"] = "Heil Info für (S)";
SW_InfoTypes[5]["d"] = "Zeigt Detailinformation für Heilung. (Wen hat diese Person geheilt?)";
SW_InfoTypes[6]["t"] = "Wurde geheilt von (S)";
SW_InfoTypes[6]["d"] = "Zeigt Detailinformation für das Heilungsziel (Von wem wurde diese Person geheilt?)";
SW_InfoTypes[7]["t"] = "Details (NichtS)";
SW_InfoTypes[7]["d"] = "Ziegt Detailinformation für eine Person (Welche Fähigkeiten verwendet diese Person?) Die Zahl in Klammern neben dem Namen gibt den maximalen Wert des Schadens bzw. der Heilung an.";
SW_InfoTypes[8]["t"] = "Details/Event (NichtS)";
SW_InfoTypes[8]["d"] = "Zeigt Durchschnittswerte für Fähigkeiten an. Die Nummer neben dem Namen gibt an wie oft diese verwendet wurde. Anmerkung: Bei Magie mit einem großen Anfangsschaden und einem kleinem DOT wirken die Daten eigenartig.";
SW_InfoTypes[9]["t"] = "Art Schaden gemacht (NichtS)";
SW_InfoTypes[9]["d"] = "Zeigt die Art des Schadens an. (Womit hat diese Person am meisten Schaden gemacht? Z.B. Feuer, Eis, etc.)";
SW_InfoTypes[10]["t"] = "Art Schaden erhalten (NichtS)";
SW_InfoTypes[10]["d"] = "Zeigt die Art des erhalten Schadens an. (Wodurch wurde diese Person am meisten verletzt? Z.B. Feuer, Eis, etc.)";
SW_InfoTypes[11]["t"] = "Gemacht Summe (NichtS)";
SW_InfoTypes[11]["d"] = "Zeigt die Schadensart an. (Womit hat die Schlachtgruppe am meisten Schaden gemacht? Z.B. Feuer, Eis, etc.) Anmerkung: Stellt sicher einen Filter zu verwenden.";
SW_InfoTypes[12]["t"] = "Erhalten Summe (NichtS)";
SW_InfoTypes[12]["d"] = "Zeigt die erhaltene Schadensart an. (Wodurch hat die Schlachtgruppe am meisten Schaden erhalten? Z.B. Feuer, Eis, etc.) Anmerkung: Stellt sicher einen Filter zu verwenden.";
SW_InfoTypes[13]["t"] = "Overheal Info (S)";
SW_InfoTypes[13]["d"] = "Zeigt Overheal Information. Der Prozentwert neben dem Namen gibt dessen Overhealwert an. Falls die oben stehende Prozentwert-Option aktiv ist gibt diese den Anteil dieser Person am gesamten Overheal der Schlachtgruppe an.";
SW_InfoTypes[14]["t"] = "Effektive Heilungs Liste (S)";
SW_InfoTypes[14]["d"] = "Zeigt die effektive Heilungsliste an. Overheal wird in dieser Liste ABGEZOGEN. Somit erhält man eine 'echte' Heilungsliste.";
SW_InfoTypes[15]["t"] = "Zauber/Mana Details (NichtS)";
SW_InfoTypes[15]["d"] = "Zeigt die Menge des Schadens bzw. der Heilung pro verwendeten Manapunkt an. Eine höhere Zahl ist besser. Dies funktioniert NUR für euch selbst.";
SW_InfoTypes[16]["t"] = "Heilung/Mana Effizienz (S)";
SW_InfoTypes[16]["d"] = "Um Heiler zu vergleichen die nicht im SyncChannel sind müsst Ihr andere Auswertungen verwenden. Für Heiler im SyncChannel wird die effektive Heilung durch die verwendeten Manapunkte dividiert. ";
SW_InfoTypes[17]["t"] = "Anzahl Tode (S)";
SW_InfoTypes[17]["d"] = "Ein einfacher Zähler von gestorbenen PCs und NPCs. Es werden alle Tode gezählt, nicht nur diejenigen die Ihr getötet habt!";
SW_InfoTypes[18]["t"] = "Schaden/Mana Effizienz (S)";
SW_InfoTypes[18]["d"] = "Um Personen zu vergleichen die nicht im SyncChannel sind müsst Ihr andere Auswertungen verwenden. Jäger, Schamanen und Paladine haben extreme Werte da sie viel Schaden machen ohne Mana zu verwenden.";
SW_InfoTypes[19]["t"] = "Decurse Anzahl (S v1.5.1+)";
SW_InfoTypes[19]["d"] = "Wie oft hat jemand 'decursed'? :"..SW_GetSpellList();
SW_InfoTypes[20]["t"] = "'Power gain' (NichtS)";
SW_InfoTypes[20]["d"] = "Eine EXPERIMENTELLE Auswertung - Bin mir selbst nicht sicher was hier Angezeigt werden wird:P";
SW_InfoTypes[21]["t"] = "Schlachtgruppe pro Sekunde (S)";
SW_InfoTypes[21]["d"] = "Zeigt verschiedene DPS Werte der gesamten Schlachtgruppe.";

	
SW_LocalizedCommands = {
	["help"] = {	["c"] = "?",
					["si"] = "Hilfe anzeigen.",
	},
	["console"] = {["c"] = "kon",
				   ["si"] = "Zeigt die SW Stats Konsole an.",
	},
	["dumpVar"] = {["c"] = "dump",
				   ["si"] = "Zeigt den inhalt einer Variablen an.",
				   ["u"] = "Verwendung:"..SW_RootSlashes[1].." dump nameDerVariablen",
	},
	["reset"] = {	["c"] = "neu",
					["si"] = "Es wird neu angefangen zu zählen",
	},
	["toggleBars"]={["c"] = "balken",
					["si"] = "Zeigt oder versteckt das Hauptfenster.",
					
	},
	["toggleGS"] = {["c"] = "ae",
					["si"] = "Zeigt oder versteckt die allgemeinen Einstellungen.",
	},
	["skillUsage"] ={["c"] = "su",
					["si"] = "Zeigt an wie oft Personen im SyncChannel Fähigkeiten verwendet haben. Der Name der Fähigkeit muss GENAU so geschrieben werden wie im Spiel!",
					["u"] = "Verwendung:"..SW_RootSlashes[1].." su Name der Fähigkeit",
	},
}

function SW_FixLogStrings(str)
	--problematic strings
	-- %ss 
	-- a string capture directly followd by a letter followed by a space
	return string.gsub(str, "(%%%d?$?s)(%a%s)", "%1%'%2");
end
-- this MUST go at the end of a localization
-- Again if you create a localization put SW_mergeLocalization(); at the end!!!
SW_mergeLocalization();
end