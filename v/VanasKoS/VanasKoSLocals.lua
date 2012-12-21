-- Locals unknown
VANASKOS = { ACEUTIL_VERSION = 1.01 };

VANASKOS.NAME = "VanasKoS";
VANASKOS.COMMANDS = {"/kos", "/vkos", "/vanaskos"};
VANASKOS.VERSION = "1.53";
VANASKOS.LastNameEntered = "";

if( not ace:LoadTranslation("VanasKoS") ) then

VANASKOS.CMD_OPTIONS = {
	{
		option = "add",
		desc = "Adds a player to the KoS list [optional: reason <reason> after <playername>]",
		method = "AddKoSPlayer",
		input = TRUE
	},
	{
		option = "remove",
		desc = "Removes a player from the KoS list",
		method = "RemoveKoSPlayer",
		input = TRUE
	},
	{
		option = "addguild",
		desc = "Adds a guild to the KoS list [optional: reason <reason> after <guildname>]",
		method = "AddKoSGuild",
		input = TRUE
	},
	{
		option = "removeguild",
		desc = "Removes a guild from the KoS list",
		method = "RemoveKoSGuild",
		input = TRUE
	},
	{
		option = "resetkos",
		desc = "Resets the KoS list on this Realm",
		method = "ResetKoSList"
	},
	{
		option = "list",
		desc = "Lists all players/guild on the KoS list",
		method = "ListKoS"
	},
	{
		option = "menu",
		desc = "Toggles the Menu",
		method = "ToggleMenu"
	},
	{
		option = "toggle",
		desc = "Toggles Configuration Options",
		args = {
			{
				option = "visual",
				desc = "Toggles the Notification in the Upper Area",
				method = "ToggleNotifyVisual"
			},
			{
				option = "chatframe",
				desc = "Toggles the Notification in the Chatframe",
				method = "ToggleNotifyChatframe"
			},
			{
				option = "warnframe",
				desc = "Toggles the Warning Frame on/off",
				method = "ToggleWarnFrame"
			},
			{
				option = "sound",
				desc = "Toggles the Audio Notification",
				method = "ToggleNotifySound"
			}
		}
	},
	{
		option = "set",
		desc = "Sets Configuration Options",
		args = {
			{
				option = "interval",
				desc = "Sets the Notification Interval to the specified value",
				method = "ConfigSetNotificationInterval",
				input = TRUE
			}
		}
	},
	{
		option = "report",
		desc = "Reports the current Settings",
		method = "Report"
	},
	{
		option = "import",
		desc = "Imports KoS Data from other KoS tools",
		args = {
			{
        option = "ubotd",
        desc = "Imports KoS Data from Ultimate Book of the Dead",
        method = "ImportKoSListFromUBotD"
      }
		}
	}
};

ace:RegisterGlobals({
		VANASKOS_TEXT_VANASKOS = "Vanas KoS",

		VANASKOS_TEXT_ADD_PLAYER = "Add Player",
		VANASKOS_TEXT_ADD_GUILD = "Add Guild",
		VANASKOS_TEXT_REMOVE_ENTRY = "Remove Entry",
		VANASKOS_TEXT_CHANGE_ENTRY = "Change Entry",
		VANASKOS_TEXT_REASON = "Reason",
		VANASKOS_TEXT_PLAYERS = "Players",
		VANASKOS_TEXT_PLAYER_ADDED = "Player %s (Reason: %s) added.",

		VANASKOS_TEXT_PLAYERS_COLON = "Players:",
		VANASKOS_TEXT_GUILDS_COLON = "Guilds:",
		VANASKOS_TEXT_GUILDS = "Guilds",
		VANASKOS_TEXT_GUILD_ADDED = "Guild %s (Reason: %s) added.",
		VANASKOS_TEXT_PLAYER_REMOVED = "Player \"%s\" removed from KoS list",
		VANASKOS_TEXT_GUILD_REMOVED = "Guild \"%s\" removed from KoS list",
		VANASKOS_TEXT_LIST_PURGED = "KoS List for Realm \"%s\" now purged.",
		VANASKOS_TEXT_LISTS = "Lists",
		VANASKOS_TEXT_CONFIG = "Configuration",
		VANASKOS_TEXT_ABOUT = "About",
		VANASKOS_TEXT_ABOUT_CREATED = "Created by Vane of EU-Aegwynn",
		VANASKOS_TEXT_NOTIFY_UPPER = "Notification in the Upper Area",
		VANASKOS_TEXT_NOTIFY_CHATFRAME = "Notification in the Chatframe",
		VANASKOS_TEXT_WARN_FRAME = "KoS/Enemy/Friendly Warning Window",
		VANASKOS_TEXT_PLAY_SOUND = "Sound on KoS detection",
		VANASKOS_TEXT_NOTIFY_INTERVAL = "Notification Interval (seconds)",
		VANASKOS_TEXT_LAST_SEEN = "last seen:",
		VANASKOS_TEXT_PLAYER_LIST = "Player List",
		VANASKOS_TEXT_GUILDS_LIST = "Guilds List",
		VANASKOS_TEXT_CONFIGURATION = "Configuration",
		VANASKOS_TEXT_KOS = "KoS:",
		VANASKOS_TEXT_KOS_GUILD = "KoS (Guild):",
		VANASKOS_TEXT_KOS_LIST_FOR_REALM = "KoS List for Realm: %s",

		VANASKOS_TEXT_UBOTD_IMPORT_FAILED = "UBotD data couldn't be loaded",
		VANASKOS_TEXT_UBOTD_IMPORT_SUCCESS = "UBotD data was imported",
		VANASKOS_TEXT_IMPORTED = "imported",
		VANASKOS_TEXT_VERSION = VANASKOS.VERSION,
		VANASKOS_COLOR_WHITE = "|cffffffff",
		VANASKOS_COLOR_END = "|r",

		BINDING_HEADER_VANASKOS_HEADER = VANASKOS.NAME,
		BINDING_NAME_VANASKOS_TEXT_TOGGLE_MENU = "Toggle Menu",
	});

	StaticPopupDialogs["VANASKOS_ADD_REASON"] = {
		text = "Reason",
		button1 = "Accept",
		button2 = "Cancel",
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
		text = "Name of Player to add",
		button1 = "Accept",
		button2 = "Cancel",
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
		text = "Reason",
		button1 = "Accept",
		button2 = "Cancel",
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
		text = "Name of Guild to add",
		button1 = "Accept",
		button2 = "Cancel",
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
		text = "Reason",
		button1 = "Accept",
		button2 = "Cancel",
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

VANASKOS.TEXT_REASON = "Reason:";
VANASKOS.TEXT_REASON_UNKNOWN = "unknown";
VANASKOS.TEXT_UNKNOWN_ENTITY = "Unknown";

VANASKOS.MAP_ONOFF_COLOR = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"}

VANASKOS.TargetMatch = {
	{ -- HEALEDOTHEROTHER
		pattern = "(.+)'s (.+) heals (.+) for (%d+).",
		patternname = 0
	},
	{ -- HEALECRITDOTHEROTHER
		pattern = "(.+)'s (.+) critically heals (.+) for (%d+).",
		patternname = 0
	},
	{ -- SPELLDEFLECTEDOTHEROTHER
		pattern = "(.+)'s (.+) was deflected by (.+)",
		patternname = 0
	},
	{ -- SPELLPARRIEDOTHEROTHER
		pattern = "(.+)'s (.+) was parried by (.+)",
		patternname = 0
	},
	{ -- SPELLDODGEDOTHEROTHER
		pattern = "(.+)'s (.+) was dodged by (.+)",
		patternname = 0
	},
	{ -- SPELLPOWERDRAINOTHEROTHER
		pattern = "(.+)'s (.+) drains (%d+) (.+) from (.+)",
		patternname = 0
	},
	{ -- SPELLLOGCRITOTHEROTHER
		pattern = "(.+)'s (.+) crits (.+) for (%d+).",
		patternname = 0
	},
	{ -- COMBATHITOTHEROTHER
		pattern = "(.+)'s (.+) hits (.+) for (%d+).",
		patternname = 0
	},
	{ -- SPELLCASTGOOTHER
		pattern = "(.+) casts (.+)",
		patternname = 0
	},
	{ -- SPELLCASTGOOTHERTARGETTED
		pattern = "(.+) casts (.+) on (.+)",
		patternname = 0
	},
	{ -- COMBATHITOTHEROTHER
		pattern = "(.+) hits (.+) for (%d+).",
		patternname = 0
	},
	{ -- AURAADDEDOTHERHARMFUL
		pattern = "(.+) is afflicted by (.+)",
		patternname = 0
	},
	{ -- AURAADDEDOTHERHELPFUL
		pattern = "(.+) gains (.+)",
		patternname = 0
	},
	{ -- SPELLPERFORMGOOTHER
		pattern = "(.+) performs (.+)",
		patternname = 0
	},
	{ -- MISSEDOTHEROTHER
		pattern = "(.+) misses (.+)",
		patternname = 0
	},
	 --[[ PERIODICAURADAMAGEOTHEROTHER = "%s suffers %d %s damage from %s's %s.";
				PERIODICAURADAMAGESELFOTHER = "%s suffers %d %s damage from your %s.";
				PERIODICAURAHEALOTHEROTHER = "%s gains %d health from %s's %s.";
				PERIODICAURAHEALSELFOTHER = "%s gains %d health from your %s.";
				 ]]
	{
		pattern = "(.+) suffers",
		patternname = 0
	},
	{ -- SPELLPERFORMOTHERSTART
		pattern = "(.+) begins to perform (.+)",
		patternname = 0
	},
	{ -- SPELLCASTOTHERSTART
		pattern = "(.+) begins to cast (.+)",
		patternname = 0
	},
	{ -- VSDODGEOTHEROTHER
		pattern = "(.+) attacks. (.+) dodges",
		patternname = 0
	},
	{ -- VSABSORBOTHEROTHER
		pattern = "(.+) attacks. (.+) absorbs",
		patternname = 0
	},
	{ -- VSBLOCKOTHEROTHER
		pattern = "(.+) attacks. (.+) blocks",
		patternname = 0
	},
	{ -- VSDEFLECTOTHEROTHER
		pattern = "(.+) attacks. (.+) deflects",
		patternname = 0
	},
	{ -- VSENVIRONMENTALDAMAGE_FALLING_OTHER
		pattern = "(.+) falls and loses (%d+) health.",
		patternname = 0
	}
};

end