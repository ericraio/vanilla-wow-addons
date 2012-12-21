if( not ace:LoadTranslation("AcePlayerMenu") ) then

AcePlayerMenuLocals = {
	NAME = "AcePlayerMenu",
	DESCRIPTION = "Hook extra menu to friend list, guild list and chat player.",
	COMMANDS = {"/aceplayermenu", "/apm"},
	CMD_OPTIONS = {
		{
			option  = "toggle",
			desc	= "Toggle AcePlayerMenu enable or disable",
			method	= "Toggle",
		},
		{
			option  = "left",
			desc	= "Toggle left button to active menu enable or disable",
			method	= "Left",
		},
	},
	TEXT = {
		GUILD_INVITE = "Guild Invite",
		GET_NAME = "Get Name",
	},
	MSG = {
		APM_ON = "AcePlayerMenu enabled.",
		APM_OFF = "AcePlayerMenu disabled.",
		LEFT_ON = "Left button menu enabled.",
		LEFT_OFF = "Left button menu disabled.",
	},
}
end