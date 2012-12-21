--[[----------------------------------------------------------------------
		VanasKoS - Locale deDE
------------------------------------------------------------------------]]

function VanasKoS_Locals_deDE()

VANASKOS.CMD_OPTIONS = {
	{
		option = "add",
		desc = "F\195\188gt einen Spieler zu der KoS-Liste hinzu [optional: reason <Grund> nach <Spielername>]",
		method = "AddKoSPlayer",
		input = TRUE
	},
	{
		option = "remove",
		desc = "Entfernt einen Spieler von der KoS-Liste",
		method = "RemoveKoSPlayer",
		input = TRUE
	},
	{
		option = "addguild",
		desc = "F\195\188 einen Spieler zu der KoS-Liste hinzu [optional: reason <Grund> nach <Gildenname>]",
		method = "AddKoSGuild",
		input = TRUE
	},
	{
		option = "removeguild",
		desc = "Entfernt eine Gilde von der KoS-Liste",
		method = "RemoveKoSGuild",
		input = TRUE
	},
	{
		option = "resetkos",
		desc = "L\195\182scht die KoS-Liste f\195\188r diesen Realm",
		method = "ResetKoSList"
	},
	{
		option = "list",
		desc = "Zeigt alle Spieler und Gilden auf der KoS Liste",
		method = "ListKoS"
	},
	{
		option = "menu",
		desc = "Schaltet die graphische Oberfl\195\164che ein/aus",
		method = "ToggleMenu"
	},
	{
		option = "toggle",
		desc = "Schaltet Konfigrationsoptionen an/aus",
		args = {
			{
				option = "visual",
				desc = "Schaltet die Benachrichtigung im Oberen Bereich ein/aus",
				method = "ToggleNotifyVisual"
			},
			{
				option = "chatframe",
				desc = "Schaltet die Benachrichtigung im Chat ein/aus",
				method = "ToggleNotifyChatframe"
			},
			{
				option = "warnframe",
				desc = "Schaltet das Gegner-Warn-Fenster ein/aus",
				method = "ToggleWarnFrame"
			},
			{
				option = "sound",
				desc = "Schaltet das abspielen eines Warntons bei KoS-Erkennung ein/aus",
				method = "ToggleNotifySound"
			}
		}
	},
	{
		option = "set",
		desc = "Settzt Konfigurations Optionen",
		args = {
			{
				option = "interval",
				desc = "Setzt das Minimal-Interval in dem \195\188ber KoS-Listenmitglieder informiert wird",
				method = "ConfigSetNotificationInterval",
				input = TRUE
			}
		}
	},
	{
		option = "report",
		desc = "Aktuelle Einstellungen ausgeben",
		method = "Report"
	},
	{
		option = "import",
		desc = "KoS Daten aus anderen AddOns importieren",
		args = {
			{
        option = "ubotd",
        desc = "Importiert KoS Daten vom \"Ultimate Book of the Dead\"",
        method = "ImportKoSListFromUBotD"
      }
		}
	}
};

ace:RegisterGlobals({
		VANASKOS_TEXT_VANASKOS = "Vanas KoS",
		
		VANASKOS_TEXT_ADD_PLAYER = "Spieler hinzuf\195\188gen",
		VANASKOS_TEXT_ADD_GUILD = "Gilde hinzuf\195\188gen",
		VANASKOS_TEXT_REMOVE_ENTRY = "Eintrag entfernen",
		VANASKOS_TEXT_CHANGE_ENTRY = "Eintrag \195\164ndern",
		VANASKOS_TEXT_REASON = "Grund",
		VANASKOS_TEXT_PLAYERS = "Spieler",
		VANASKOS_TEXT_PLAYER_ADDED = "Spieler %s (Grund: %s) hinzugef\195\188gt.",
		
		VANASKOS_TEXT_PLAYERS_COLON = "Spieler:",
		VANASKOS_TEXT_GUILDS_COLON = "Gilden:",
		VANASKOS_TEXT_GUILDS = "Gilden",
		VANASKOS_TEXT_GUILD_ADDED = "Gilde %s (Grund: %s) hinzugef\195\188gt.",
		VANASKOS_TEXT_PLAYER_REMOVED = "Spieler \"%s\" von KoS-Liste entfernt.",
		VANASKOS_TEXT_GUILD_REMOVED = "Gilde \"%s\" von KoS-Liste entfernt.",
		VANASKOS_TEXT_LIST_PURGED = "KoS Liste f\195\188r Realm \"%s\" gel\195\182scht.",
		VANASKOS_TEXT_LISTS = "Listen",
		VANASKOS_TEXT_CONFIG = "Konfiguration",
		VANASKOS_TEXT_ABOUT = "\195\156ber",
		VANASKOS_TEXT_ABOUT_CREATED = "Erstellt von Vane auf EU-Aegwynn",
		VANASKOS_TEXT_NOTIFY_UPPER = "Benachrichtigung im oberen Bildschirmbereich",
		VANASKOS_TEXT_NOTIFY_CHATFRAME = "Benachrichtigung im Chat",
		VANASKOS_TEXT_WARN_FRAME = "KoS/Gegner/freundlich Fenster",
		VANASKOS_TEXT_PLAY_SOUND = "Sound bei Erkennung von KoS Gegnern",
		VANASKOS_TEXT_NOTIFY_INTERVAL = "Benachrichtigungs Interval (Sekunden)",
		VANASKOS_TEXT_LAST_SEEN = "zuletzt gesehen:",
		VANASKOS_TEXT_PLAYER_LIST = "Spieler Liste",
		VANASKOS_TEXT_GUILDS_LIST = "Gilden Liste",
		VANASKOS_TEXT_CONFIGURATION = "Konfiguration",
		VANASKOS_TEXT_KOS = "KoS:",
		VANASKOS_TEXT_KOS_GUILD = "KoS (Gilden):",
		VANASKOS_TEXT_KOS_LIST_FOR_REALM = "KoS Liste f\195\188r Realm: %s",
		
		VANASKOS_TEXT_UBOTD_IMPORT_FAILED = "UBotD data konnte nicht geladen werden",
		VANASKOS_TEXT_UBOTD_IMPORT_SUCCESS = "UBotD data wurde importiert.",
		VANASKOS_TEXT_IMPORTED = "importiert",
		VANASKOS_TEXT_VERSION = VANASKOS.VERSION,
		VANASKOS_COLOR_WHITE = "|cffffffff",
		VANASKOS_COLOR_END = "|r",
		
		BINDING_HEADER_VANASKOS_HEADER = VANASKOS.NAME,
		BINDING_NAME_VANASKOS_TEXT_TOGGLE_MENU = "Menu aufrufen",
	});

	StaticPopupDialogs["VANASKOS_ADD_REASON"] = {
		text = "Grund",
		button1 = "Ok",
		button2 = "Abbrechen",
		hasEditBox = 1,
		maxLetters = 40,
		OnAccept = function()
			local editBox = getglobal(this:GetParent():GetName().."EditBox");
			VanasKoS:AddKoSPlayerR(VANASKOS.LastNameEntered, editBox:GetText());
			VanasKoS:GUIOnUpdate();
		end,
		OnShow = function()
			getglobal(this:GetName().."EditBox"):SetFocus();
		end,
		OnHide = function()
			if(ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:SetFocus();
			end
			getglobal(this:GetName().."EditBox"):SetText("");
		end,
		EditBoxOnEscapePressed = function()
			this:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}
	StaticPopupDialogs["VANASKOS_ADD_PLAYER"] = {
		text = "Name des Spielers",
		button1 = "Ok",
		button2 = "Abbrechen",
		hasEditBox = 1,
		maxLetters = 12,
		OnAccept = function()
			local editBox = getglobal(this:GetParent():GetName().."EditBox");
			VANASKOS.LastNameEntered = editBox:GetText();
			if(VANASKOS.LastNameEntered ~= "") then
				StaticPopup_Show("VANASKOS_ADD_REASON");
			end
		end,
		OnShow = function()
			getglobal(this:GetName().."EditBox"):SetFocus();
		end,
		OnHide = function()
			if(ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:SetFocus();
			end
			getglobal(this:GetName().."EditBox"):SetText("");
		end,
		EditBoxOnEscapePressed = function()
			this:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
}

	StaticPopupDialogs["VANASKOS_ADD_REASON_GUILD"] = {
		text = "Grund",
		button1 = "Ok",
		button2 = "Abbrechen",
		hasEditBox = 1,
		maxLetters = 40,
		OnAccept = function()
			local editBox = getglobal(this:GetParent():GetName().."EditBox");
			VanasKoS:AddKoSGuildR(VANASKOS.LastNameEntered, editBox:GetText());
			VanasKoS:GUIOnUpdate();
		end,
		OnShow = function()
			getglobal(this:GetName().."EditBox"):SetFocus();
		end,
		OnHide = function()
			if(ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:SetFocus();
			end
			getglobal(this:GetName().."EditBox"):SetText("");
		end,
		EditBoxOnEscapePressed = function()
			this:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}
	StaticPopupDialogs["VANASKOS_ADD_GUILD"] = {
		text = "Name der Gilde",
		button1 = "Ok",
		button2 = "Abbrechen",
		hasEditBox = 1,
		maxLetters = 40,
		OnAccept = function()
			local editBox = getglobal(this:GetParent():GetName().."EditBox");
			VANASKOS.LastNameEntered = editBox:GetText();
			if(VANASKOS.LastNameEntered ~= "") then
				StaticPopup_Show("VANASKOS_ADD_REASON_GUILD");
			end
		end,
		OnShow = function()
			getglobal(this:GetName().."EditBox"):SetFocus();
		end,
		OnHide = function()
			if(ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:SetFocus();
			end
			getglobal(this:GetName().."EditBox"):SetText("");
		end,
		EditBoxOnEscapePressed = function()
			this:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

	StaticPopupDialogs["VANASKOS_CHANGE_ENTRY"] = {
		text = "Grund",
		button1 = "Ok",
		button2 = "Abbrechen",
		hasEditBox = 1,
		maxLetters = 40,
		OnAccept = function()
			local editBox = getglobal(this:GetParent():GetName().."EditBox");
			VanasKoS:GUIChangeKoSReason(editBox:GetText());
		end,
		OnShow = function()
			getglobal(this:GetName().."EditBox"):SetFocus();
		end,
		OnHide = function()
			if(ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:SetFocus();
			end
			getglobal(this:GetName().."EditBox"):SetText("");
		end,
		EditBoxOnEscapePressed = function()
			this:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

VANASKOS.TEXT_REASON = "Grund:";
VANASKOS.TEXT_REASON_UNKNOWN = "unbekannt";
VANASKOS.TEXT_UNKNOWN_ENTITY = "Unbekannt";

VANASKOS.MAP_ONOFF_COLOR = {[0]="|cffff5050Aus|r",[1]="|cff00ff00An|r"}

VANASKOS.TargetMatch = {
	{ -- HEALEDOTHEROTHER
		pattern = "(.+)s (.+) heilt (.+) um (%d+) Punkte.",
		patternname = 0
	},
	{ -- HEALECRITDOTHEROTHER
		pattern = "Besondere Heilung: (.+)s (.+) heilt (.+) um (%d+) Punkte.",
		patternname = 0
	},
	{ -- SPELLDEFLECTEDOTHEROTHER
		pattern = "(.+) versuchte es mit (.+)",
		patternname = 0
	},
	{ -- SPELLPARRIEDOTHEROTHER
		pattern = "(.+)s von (.+) wurde von (.+) parriert",
		patternname = 1
	},
	{ -- SPELLDODGEDOTHEROTHER
		pattern = "(.+)s ist (.+) von (.+) ausgewichen",
		patternname = 2
	},
	{ -- SPELLPOWERDRAINOTHEROTHER
		pattern = "(.+) benutzt (.+) und entzieht",
		patternname = 0
	},
	{ -- SPELLLOGCRITOTHEROTHER
		pattern = "(.+)s (.+) trifft (.+) kritisch f\195\188r (%d+) Schaden.",
		patternname = 0
	},
	{ -- COMBATHITOTHEROTHER
		pattern = "(.+)s (.+) trifft (.+) f\195\188r (%d+) Schaden.",
		patternname = 0
	},
	{ -- SPELLCASTGOOTHER
		pattern = "(.+) wirkt (.+)",
		patternname = 0
	},
	{ -- SPELLCASTGOOTHERTARGETTED
		pattern = "(.+) wirkt (.+) auf (.+)",
		patternname = 0
	},
	{ -- COMBATHITOTHEROTHER
		pattern = "(.+) trifft (.+) f\195\188r (%d+) Schaden.",
		patternname = 0
	},
	{ -- AURAADDEDOTHERHARMFUL
		pattern = "(.+) ist von (.+) betroffen.",
		patternname = 0
	},
	{ -- AURAADDEDOTHERHELPFUL
		pattern = "(.+) bekommt ",
		patternname = 0
	},
	{ -- SPELLPERFORMGOOTHER
		pattern = "(.+) f\195\188hrt (.+) aus",
		patternname = 0
	},
	{ -- MISSEDOTHEROTHER
		pattern = "(.+) verfehlt (.+)",
		patternname = 0
	},
	 --[[ PERIODICAURADAMAGEOTHEROTHER = "%s suffers %d %s damage from %s's %s."; 
				PERIODICAURADAMAGESELFOTHER = "%s suffers %d %s damage from your %s.";
				PERIODICAURAHEALOTHEROTHER = "%s gains %d health from %s's %s.";
				PERIODICAURAHEALSELFOTHER = "%s gains %d health from your %s.";
				 ]]
	{
		pattern = "(.+) erleidet ",
		patternname = 0
	},
	{ -- SPELLPERFORMOTHERSTART
		pattern = "(.+) beginnt (.+) auszuf\195\188hren",
		patternname = 0
	},
	{ -- SPELLCASTOTHERSTART
		pattern = "(.+) beginnnt (.+) zu wirken",
		patternname = 0
	},
	{ -- VSDODGEOTHEROTHER VSABSORBOTHEROTHER VSBLOCKOTHEROTHER VSDEFLECTOTHEROTHER
		pattern = "(.+) greift an.",
		patternname = 0
	},
	{ -- VSENVIRONMENTALDAMAGE_FALLING_OTHER
		pattern = "(.+) f\195\164llt und verliert",
		patternname = 0
	}
};
end
