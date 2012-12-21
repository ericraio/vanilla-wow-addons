--[[
--	FileName Localization
--		"English Localization"
--	
--	English By: Mugendai
--	Contact: mugekun@gmail.com
--	
--	$Id: localization.lua 2640 2005-10-17 09:22:31Z mugendai $
--	$Rev: 2640 $
--	$LastChangedBy: mugendai $
--	$Date: 2005-10-17 04:22:31 -0500 (Mon, 17 Oct 2005) $
--]]

--------------------------------------------------
--
-- MCom Versioning System, DO NOT CHANGE!
--
--------------------------------------------------
--MCom version number
MCOM_VERSION = 1.49;

--Should we use this version of MCom
MCom_Update = nil;

--If there is no MCom, make one
if (not MCom) then
	MCom = {};
end

--Check the version, and decide if we should update
if (MCom.VERSION) then
	if (MCOM_VERSION > MCom.VERSION) then
		MCom_Update = true;
		MCom.VERSION = MCOM_VERSION;
	end
else
	MCom_Update = true;
	MCom.VERSION = MCOM_VERSION;
end

--------------------------------------------------
--
-- Copyable locale starts here
--
--------------------------------------------------
--Only overwrite if version is newer, be sure to include this(but not the above part) in localizations
if (MCom_Update) then
	--------------------------------------------------
	--
	-- MCom types
	--
	--------------------------------------------------
	MCOM_BOOLT = "B";
	MCOM_NUMT = "N";
	MCOM_MULTIT = "M";
	MCOM_STRINGT = "S";
	MCOM_SIMPLET = "E";
	MCOM_CHOICET = "C";
	MCOM_COLORT = "K";
	
	--------------------------------------------------
	--
	-- MCom help text
	--
	--------------------------------------------------
	MCOM_CHAT_COM_ALIAS			= "Command aliases: %s";
	MCOM_CHAT_COM_COMMANDS		= "Commands:\ncommand/alias - type (state)\ndetails";
	MCOM_CHAT_COM_SUBCOMMAND_S		= "\124c00FFC000%s\124r - %s\n%s";
	MCOM_CHAT_COM_SUBCOMMAND		= "\124c00FFC000%s\124r - %s \124c0000FF00(%s\124c0000FF00)\124r\n%s";
	MCOM_CHAT_COM_NOINFO = "No additonal info available.";
	MCOM_CHAT_COM_CLIST = "Choices: %s";
	MCOM_CHAT_COM_USAGE		=	"When using commands don't include the parenthesis or brackets, or the letter between the parenthesis."
	MCOM_CHAT_COM_USAGE_B		=	"On on/off options, if you don't pass anything to them, they will flip to the opposite state."
	MCOM_CHAT_COM_USAGE_B_M		=	"On options that allow you to specify both on/off and another value, such as a "..MCOM_BOOLT.."%s type, which lets you "..
													"Set an on/off and %s, you can specify only the on/off portion if you wish, and leave the second "..
													"part as it is.";
	MCOM_CHAT_COM_USAGE_B_N		= "a number";
	MCOM_CHAT_COM_USAGE_B_S		= "a string";
	MCOM_CHAT_COM_USAGE_B_C		= "a choice";
	MCOM_CHAT_COM_USAGE_B_K		= "a color";
	
	MCOM_CHAT_C_M = MCOM_CHOICET.."M";	--Letter indicator that this is a multiple choice option
	MCOM_CHAT_K_O = MCOM_COLORT.."O";	--Letter indicator that this is a color option with opacity
	
	MCOM_CHAT_COM_B		= "[on/off]";
	MCOM_CHAT_COM_N		= "[number]";
	MCOM_CHAT_COM_N_MIN = "Min: %s";
	MCOM_CHAT_COM_N_MAX = "Max: %s";
	MCOM_CHAT_COM_N_RANGE = " \124c0064DCFF[%s]\124r";
	MCOM_CHAT_COM_S		= "[string]";
	MCOM_CHAT_COM_C		= "[choice]";
	MCOM_CHAT_COM_C_M		= "[choice[ morechoices]]";
	MCOM_CHAT_COM_K		= "[red green blue]";
	MCOM_CHAT_COM_K_O		= "[red green blue [opacity]]";

	MCOM_CHAT_COM_K_R = "R:%s";
	MCOM_CHAT_COM_K_G = "G:%s";
	MCOM_CHAT_COM_K_B = "B:%s";
	MCOM_CHAT_COM_K_O = "O:%s";
	MCOM_CHAT_COM_K_X = "\124c%sExample\124r";
	
	MCOM_CHAT_COM_USAGE_S_E		= "Usage %s";
	MCOM_CHAT_COM_USAGE_S_S		= "Usage %s %s";
	MCOM_CHAT_COM_USAGE_S_M		= "Usage %s "..MCOM_CHAT_COM_B.." %s";
	
	MCOM_CHAT_COM_USAGE_E	= "Usage for ("..MCOM_SIMPLET..") %s [option]";
	MCOM_CHAT_COM_USAGE_S	= "Usage for (%s) %s [option] %s";
	MCOM_CHAT_COM_USAGE_M	= "Usage for (%s) %s [option] "..MCOM_CHAT_COM_B.." %s";
	
	MCOM_CHAT_COM_EXAMPLE	=	"Example Usage:";
	
	MCOM_CHAT_COM_EXAMPLE_O_B		= "on";
	MCOM_CHAT_COM_EXAMPLE_O_N		= "1";
	MCOM_CHAT_COM_EXAMPLE_O_S		= "somestring";
	MCOM_CHAT_COM_EXAMPLE_O_K		= "20 56 100";
	MCOM_CHAT_COM_EXAMPLE_O_K_O		= "20 56 100 62";
	
	MCOM_CHAT_COM_EXAMPLE_S_E		= "%s";
	MCOM_CHAT_COM_EXAMPLE_S_S		= "%s %s";
	MCOM_CHAT_COM_EXAMPLE_S_M		= "%s "..MCOM_CHAT_COM_EXAMPLE_O_B.." %s";
	
	MCOM_CHAT_COM_EXAMPLE_E		= "%s %s";
	MCOM_CHAT_COM_EXAMPLE_S		= "%s %s %s";
	MCOM_CHAT_COM_EXAMPLE_M		= "%s %s "..MCOM_CHAT_COM_EXAMPLE_O_B.." %s";
	
	MCOM_CHAT_ENABLED = "enabled";
	MCOM_CHAT_DISABLED = "disabled";
	MCOM_CHAT_ON = "On";
	MCOM_CHAT_OFF = "Off";
	
	MCOM_CHAT_STATUS_B = "%s %%s";
	MCOM_CHAT_STATUS_N = "%s set to %%s";
	MCOM_CHAT_STATUS_S = "%s set to %%s";
	MCOM_CHAT_STATUS_C = "%s set to %%s";
	MCOM_CHAT_STATUS_K = "%s set to %%s";
	
	MCOM_FEEDBACK_CHECK = "%s %s";
	MCOM_FEEDBACK_RADIO = "%s set to %s";
	MCOM_FEEDBACK_SLIDER = "%s set to %s";
	MCOM_FEEDBACK_SLIDER_M = "%s, and set to %s";
	MCOM_FEEDBACK_EDITBOX = "%s set to %s";
	MCOM_FEEDBACK_EDITBOX_M = "%s, and set to %s";
	MCOM_FEEDBACK_COLOR = "|c%s%s color changed|r";
	MCOM_FEEDBACK_COLOR_M = "|c%s%s|r";
	MCOM_FEEDBACK_CHOICE = "%s set to %s";
	MCOM_FEEDBACK_CHOICE_M = "%s, and set to %s";
	
	MCOM_PAGE_TEXT = "Page (%s/%s)";
	MCOM_HELP_COMMAND = "help";
	MCOM_HELP_CONFIG = "%s Help";
	MCOM_HELP_CONFIG_INFO = "Will display a screen showing helpful information about %s.";
	MCOM_HELP_GENERIC = "Will display a screen showing helpful information about this addon.";
	MCOM_HELP_TITLE = "%s Help";
	MCOM_HELP_GENERIC_TITLE = "Help";
end