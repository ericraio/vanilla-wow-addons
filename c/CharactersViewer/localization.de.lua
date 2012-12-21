--[[
   Version: $Rev: 3761 $
   Last Changed by: $LastChangedBy: Flisher $
   Date: $Date: 2006-07-06 10:52:10 -0400 (jeu., 06 juil. 2006) $
   
   Note: Please don't remove commented line and change the layout of this file, the main goal is to have 3 localization files with the same layout for easy spotting of missing information.
   The SVN tag at the begining of the file will automaticaly update upon uploading.
]]--

if (GetLocale() == "deDE") then
	
	-- Configuration variables
	-- SLASH_CHARACTERSVIEWER1			= "/charactersviewer";
	-- SLASH_CHARACTERSVIEWER2			= "/cv";
	-- CHARACTERSVIEWER_SUBCMD_SHOW			= "show";
	-- CHARACTERSVIEWER_SUBCMD_CLEAR		= "clear";
	-- CHARACTERSVIEWER_SUBCMD_CLEARALL		= "clearall";
	-- CHARACTERSVIEWER_SUBCMD_PREVIOUS		= "previous";
	-- CHARACTERSVIEWER_SUBCMD_NEXT			= "next";
	-- CHARACTERSVIEWER_SUBCMD_SWITCH		= "switch";
	-- CHARACTERSVIEWER_SUBCMD_LIST			= "list";
	-- CHARACTERSVIEWER_SUBCMD_BANK			= "bank";
	-- CHARACTERSVIEWER_SUBCMD_RESETLOC		= "resetloc";
	-- CHARACTERSVIEWER_SUBCMD_BAGS			= "bags";
	-- CHARACTERSVIEWER_SUBCMD_BAGUSE		= "baguse";

	-- Localization text
	BINDING_HEADER_CHARACTERSVIEWER                 = "Charakter Anzeiger";
	BINDING_NAME_CHARACTERSVIEWER_TOGGLE            = "Fenster anzeigen/verbergen";
	BINDING_NAME_CHARACTERSVIEWER_BANKTOGGLE	= "Bank Fenster anzeigen/verbergen";
	BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS   = "Auf vorherigen Charakter wechseln";
	BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT       = "Auf n\195\164chsten Charakter wechseln";

	CHARACTERSVIEWER_CRIT                           = "Kritisch";

	CHARACTERSVIEWER_SELPLAYER                      = "Wechseln";
	CHARACTERSVIEWER_DROPDOWN2                      = "Vergleichen";
	CHARACTERSVIEWER_TOOLTIP_BAGRESET               = "Links-Klick: Schaltet die Taschen ein/aus.\nRechts-Klick: Setzt die Anzeige zur\195\188ck.";
	CHARACTERSVIEWER_TOOLTIP_MAIL                   = "Links-Klick: Postkasten (MailTo) Anzeige an/aus.\nRechts-Klick: Setzt die Anzeige zur\195\188ck.";
	CHARACTERSVIEWER_TOOLTIP_BANK                  	= "Links-Klick: Schaltet die Bank ein/aus.\nRight-Click: Reset Bank position.";
	CHARACTERSVIEWER_TOOLTIP_DROPDOWN2 					= "Klicken um einen deiner anderen Charaktere vom/nselben Server auszuw/195/164hlen und im Fenster/ndes Charakteranzeigers darzustellen.";
	CHARACTERSVIEWER_TOOLTIP_BANKBAG                = "Links-Klick: Schaltet die Bank Taschen ein/aus.\nRechts-Klick: Setzt die Anzeige zur\195\188ck.";
	CHARACTERSVIEWER_SAVEDON			= "Gespeichert: ";
	      
	CHARACTERSVIEWER_PROFILECLEARED                 = "Dieses Profil wurde gel\195\182scht: ";
	CHARACTERSVIEWER_ALLPROFILECLEARED              = "Profile aller Server wurden gel\195\182scht. Der aktuelle Charakter wurde neu hinzugef\195\188gt.";
	CHARACTERSVIEWER_NOT_FOUND                      = "Charakter nicht gefunden: ";

	CHARACTERSVIEWER_USAGE                          = "Benutzung: '/cv <Befehl>' <Befehl> kann folgendes sein";
	CHARACTERSVIEWER_USAGE_SUBCMD                   = {};
	CHARACTERSVIEWER_USAGE_SUBCMD[1]                = CHARACTERSVIEWER_SUBCMD_SHOW .. " : Ausr\195\188stung/Werte in einem Charakterfenster anzeigen.";
	CHARACTERSVIEWER_USAGE_SUBCMD[2]                = CHARACTERSVIEWER_SUBCMD_CLEAR .. " <arg1>: Charakterprofil von <arg1> l\195\182schen.";
	CHARACTERSVIEWER_USAGE_SUBCMD[3]                = CHARACTERSVIEWER_SUBCMD_CLEARALL .. " : Alle gespeicherten Daten f\195\188r ALLE Charaktere auf allen Servern l\195\182schen.";
	CHARACTERSVIEWER_USAGE_SUBCMD[4]                = CHARACTERSVIEWER_SUBCMD_PREVIOUS .. " : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS;
	CHARACTERSVIEWER_USAGE_SUBCMD[5]                = CHARACTERSVIEWER_SUBCMD_NEXT .. " : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT;
	CHARACTERSVIEWER_USAGE_SUBCMD[6]                = CHARACTERSVIEWER_SUBCMD_SWITCH .. " <arg1>: Zu Charakter <arg1> wechseln.";
	CHARACTERSVIEWER_USAGE_SUBCMD[7]                = CHARACTERSVIEWER_SUBCMD_LIST .. " : Zeigt verschieden Informationen \195\188ber den Spieler am aktuellen Server an.";
	CHARACTERSVIEWER_USAGE_SUBCMD[8]                = CHARACTERSVIEWER_SUBCMD_BANK .. " : Bankinhalt anzeigen/verbergen";
	CHARACTERSVIEWER_USAGE_SUBCMD[9]                = CHARACTERSVIEWER_SUBCMD_RESETLOC .. " : Die Position des Hauptfensters des " .. BINDING_HEADER_CHARACTERSVIEWER .. "zur\195\188cksetzen.";
	CHARACTERSVIEWER_USAGE_SUBCMD[10]		= CHARACTERSVIEWER_SUBCMD_BAGS .. " : Zeigt eine Liste mit den Taschengr\195\182\195\159en der einzelnen Charaktere an.";
	CHARACTERSVIEWER_USAGE_SUBCMD[11]		= CHARACTERSVIEWER_SUBCMD_BAGUSE .. " : Zeigt die Taschenbenutzug der einzelnen Charaktere an.";

	CHARACTERSVIEWER_DESCRIPTION			= "Speichert die Ausr\195\188stung, den Tascheninhalt\nund die Fertigkeiten all deiner Charaktere.";
	CHARACTERSVIEWER_SHORT_DESC                     = "CharakterAnzeiger anzeigen/verbergen";
	-- CHARACTERSVIEWER_ICON                        = "Interface\\Buttons\\Button-Backpack-Up";

	CHARACTERSVIEWER_NOT_CACHED                     = "Objekt nicht im lokalen Cache";
	CHARACTERSVIEWER_RESTED                         = "ausgeruht";
	CHARACTERSVIEWER_RESTING                        = "ruhen";
	CHARACTERSVIEWER_NOT_RESTING                    = "nicht ruhend";
	CHARACTERSVIEWER_BAG_USE			= "Taschen in Verwendung von ";

	CHARACTERSVIEWER_BANK_TITLE			= "Charakter Anzeiger (Bank)";
	CHARACTERSVIEWER_ALLIANCE_HORDE			= "Horde";
	CHARACTERSVIEWER_ALLIANCE_ALLIANCE		= "Allianz";
	CHARACTERSVIEWER_ALLIANCE_TOTAL			= "Gesamt";

end