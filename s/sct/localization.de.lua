-- Version : German (by Endymion, StarDust, Sasmira, Gamefaq)
-- Last Update : 09/16/2005

if GetLocale() ~= "deDE" then return end

-- Static Messages
SCT.LOCALS.LowHP = "Wenig Gesundheit!"; -- Message to be displayed when HP is low
SCT.LOCALS.LowMana = "Wenig Mana!"; -- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*"; -- Icon to show self hits
SCT.LOCALS.Combat = "+Kampf"; -- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "-Kampf"; -- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "CP"; -- Message to be displayed when you become a combo point
SCT.LOCALS.FiveCPMessage = "Alle Combo-Punkte!"; -- Message to be displayed when you have 5 combo points
SCT.LOCALS.ExtraAttack = "Extra Attack!"; -- Message to be displayed when time to execute

--startup messages
SCT.LOCALS.STARTUP = "Scrolling Combat Text "..SCT.Version.." AddOn geladen. Gib /sctmenu f\195\188r Optionen ein.";
SCT.LOCALS.Option_Crit_Tip = "Lass dieses Ereignis immer als KRITISCHER Treffer anzeigen.";
SCT.LOCALS.Option_Msg_Tip = "Lass dieses Ereignis immer als NACHRICHT erscheinen. Ignoriert KRITS.";
SCT.LOCALS.Frame1_Tip = "Lass dieses Ereignis immer im FENSTER 1 erscheinen.";
SCT.LOCALS.Frame2_Tip = "Lass dieses Ereignis immer im FENSTER 2 erscheinen";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT HINWEIS|r\n\nSind Ihre gespeicherten Einstellungen von einer \195\188berholten Version von SCT? Wenn Sie St\195\182rungen oder merkw\195\188rdiges Verhalten antreffen, setzen Sie bitte Ihre Einstellungen mit der Zur\195\188ckstellentaste oder durch schreiben von /sctreset zur\195\188ck";
SCT.LOCALS.Load_Error = "|cff00ff00Fehler beim laden der SCT Optionen. Sie k\195\182nnten in den WoW Addonoptionen deaktiviert sein.|r";

--nouns
SCT.LOCALS.TARGET = "Ziel ";
SCT.LOCALS.PROFILE = "SCT Profil geladen: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "SCT Profil gel\195\182scht: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "Neues SCT Profil erstellt: |cff00ff00";
SCT.LOCALS.WARRIOR = "Krieger";
SCT.LOCALS.ROGUE = "Schurke";
SCT.LOCALS.HUNTER = "J\195\164ger";
SCT.LOCALS.MAGE = "Magier";
SCT.LOCALS.WARLOCK = "Hexenmeister";
SCT.LOCALS.DRUID = "Druide";
SCT.LOCALS.PRIEST = "Priester";
SCT.LOCALS.SHAMAN = "Schamane";
SCT.LOCALS.PALADIN = "Paladin";

--Usage
SCT.LOCALS.DISPLAY_USEAGE = "Benutzung: \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'Nachricht' (f\195\188r wei\195\159en Text)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'Nachricht' red(0-10) green(0-10) blue(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Beispiel: /sctdisplay 'Heile Mich' 10 0 0\nDies stellt 'Heile Mich' in hellrot dar.\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Einige Farben: Rot = 10 0 0, Gr\195\188n = 0 10 0, Blau = 0 0 10,\nGelb = 10 10 0, Magenta = 10 0 10, Zyan = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="Default", path="Fonts\\FRIZQT__.TTF"},
	[2] = { name="TwCenMT", path="Interface\\Addons\\sct\\fonts\\Tw_Cen_MT_Bold.TTF"},
	[3] = { name="Adventure", path="Interface\\Addons\\sct\\fonts\\Adventure.ttf"},
	[4] = { name="Enigma", path="Interface\\Addons\\sct\\fonts\\Enigma__2.TTF"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME = "Scrollender Kampftext".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC = "von Grayhoof";
SCT.LOCALS.CB_LONG_DESC = "Zeigt Kampfnachrichten \195\188ber dem Charakter an - probier es aus!";
SCT.LOCALS.CB_ICON = "Interface\\Icons\\Spell_Shadow_EvilEye";
