if not ace:LoadTranslation("EmoteFu") then

EmoteFuLocals = {
	NAME = "FuBar - EmoteFu",
	DESCRIPTION = "Allows you to easily access emotes, saving the time and hassle of memorizing the emote commands!  This mod was ported from TitanEmoteMenu by Dsanai of Whisperwind.  Credit for many internal routines goes to Dsanai.",
	COMMANDS = {"/emotefu", "/emofu"},
	CMD_OPTIONS = {},
	
	LMBTEXT = "Right Click for a list of emotes.",
	
	ARGUMENT_SLASH = "slshCmd"
}

EmoteFuLocals.CMD_OPTIONS = {
	{
		option = EmoteFuLocals.ARGUMENT_SLASH,
		desc = "Show the Slash Command of an emote prior to the emote text.",
		method = "ToggleShowingSlashCommands"
	},
}
		

end
