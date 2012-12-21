-- Version : English - sarf
-- Translation by : None

BINDING_HEADER_COOLDOWNCOUNTHEADER					= "Cooldown Count";
BINDING_NAME_COOLDOWNCOUNT							= "Cooldown Count Toggle";

COOLDOWNCOUNT_CONFIG_HEADER							= "Cooldown Count";
COOLDOWNCOUNT_CONFIG_HEADER_INFO					= "Contains settings for the Cooldown Count,\nan AddOn which displays the time until cooldown\nis done on actions.";

COOLDOWNCOUNT_ENABLED								= "Enable Cooldown Count";
COOLDOWNCOUNT_ENABLED_INFO							= "Enables Cooldown Count, displaying the time until cooldown is complete on actions.";

COOLDOWNCOUNT_ROGUE_STEALTH							= "Rogue Stealth CooldownCount";
COOLDOWNCOUNT_ROGUE_STEALTH_INFO					= "Enables Cooldown Count on Rogue Stealth.";

COOLDOWNCOUNT_NOSPACES								= "Remove space between time and time unit";
COOLDOWNCOUNT_NOSPACES_INFO							= "Removes the space between the time and the time unit, so that, for example, \"19 m\" becomes \"19m\".";

COOLDOWNCOUNT_SIDECOUNT								= "Offset SideBars Side Count";
COOLDOWNCOUNT_SIDECOUNT_INFO						= "Will make the cooldown counts on the sidebar be placed further to the middle of the screen.";

COOLDOWNCOUNT_FLASHSPEED							= "Time between wear-off flashes";
COOLDOWNCOUNT_FLASHSPEED_INFO						= "Determines how long time should be allowed between each flash when the cooldown timer is about to expire.";

COOLDOWNCOUNT_FLASHSPEED_SLIDER_DESCRIPTION			= "Length";
COOLDOWNCOUNT_FLASHSPEED_SLIDER_APPEND				= " second(s)";

COOLDOWNCOUNT_HIDEUNTILTIMELEFT						= "Hide until...";
COOLDOWNCOUNT_HIDEUNTILTIMELEFT_INFO				= "Will hide the CooldownCount timers until they reach the specified time (0 = visible all the time).";

COOLDOWNCOUNT_HIDEUNTILTIMELEFT_SLIDER_DESCRIPTION	= "Length";
COOLDOWNCOUNT_HIDEUNTILTIMELEFT_SLIDER_APPEND		= " second(s)";

COOLDOWNCOUNT_HOURS_FORMAT							= "%s h";
COOLDOWNCOUNT_MINUTES_FORMAT						= "%s m";

COOLDOWNCOUNT_HOUR_MINUTES_FORMAT					= "%s:%s";
COOLDOWNCOUNT_MINUTES_SECONDS_FORMAT				= "%s:%s";
COOLDOWNCOUNT_SECONDS_FORMAT						= "%s";

COOLDOWNCOUNT_SECONDS_LONG_FORMAT					= "%s s";

COOLDOWNCOUNT_USERSCALE								= "Change the scale";
COOLDOWNCOUNT_USERSCALE_INFO						= "Manually changes the scale which CooldownCount uses. Strange results may occur. Default is 1.";
COOLDOWNCOUNT_USERSCALE_SLIDER_DESCRIPTION			= "Scale";
COOLDOWNCOUNT_USERSCALE_SLIDER_APPEND				= " percent";

COOLDOWNCOUNT_USELONGTIMERS							= "Use long timer descriptions";
COOLDOWNCOUNT_USELONGTIMERS_INFO					= "Will use long (explicit) timer descriptions.";

COOLDOWNCOUNT_NORMALCOLOR_SET						= "Set color of text";
COOLDOWNCOUNT_NORMALCOLOR_SET_INFO					= "Set the color of the normal CooldownCount text.";

COOLDOWNCOUNT_FLASHCOLOR_SET						= "Set color of flash";
COOLDOWNCOUNT_FLASHCOLOR_SET_INFO					= "Set the color of the flashing CooldownCount text.";
COOLDOWNCOUNT_SETTEXT								= "Set";

COOLDOWNCOUNT_ALPHA									= "Alpha";
COOLDOWNCOUNT_ALPHA_INFO							= "Determines amount of opacity of the CooldownCount.";

COOLDOWNCOUNT_ALPHA_SLIDER_DESCRIPTION				= "Alpha";
COOLDOWNCOUNT_ALPHA_SLIDER_APPEND					= " percent";


-- Slash Commands

COOLDOWNCOUNT_SLASH_ENABLE							= "enable";
COOLDOWNCOUNT_SLASH_DISABLE							= "disable";
COOLDOWNCOUNT_SLASH_SET								= "set";
COOLDOWNCOUNT_SLASH_FLASHSPEED						= "flash";
COOLDOWNCOUNT_SLASH_SCALE							= "scale";
COOLDOWNCOUNT_SLASH_ALPHA							= "alpha";
COOLDOWNCOUNT_SLASH_NOSPACES						= "space";
COOLDOWNCOUNT_SLASH_NORMALCOLOR						= "normalcolor";
COOLDOWNCOUNT_SLASH_FLASHCOLOR						= "flashcolor";
COOLDOWNCOUNT_SLASH_USELONGTIMERS					= "uselongtimers";
COOLDOWNCOUNT_SLASH_HIDEUNTILTIMELEFT				= "hideuntil";

COOLDOWNCOUNT_PARAM_ON								= "on";
COOLDOWNCOUNT_PARAM_OFF								= "off";
COOLDOWNCOUNT_PARAM_TOGGLE							= "toggle";


COOLDOWNCOUNT_SLASH_USAGE 							= {
	" Usage: /cooldowncount (or /cc) <command> [params]",
	"",
	" Commands:",
	COOLDOWNCOUNT_SLASH_ENABLE.." - enables CooldownCount",
	COOLDOWNCOUNT_SLASH_DISABLE.." - disables CooldownCount",
	COOLDOWNCOUNT_SLASH_SET.." - enables/disables CooldownCount",
	COOLDOWNCOUNT_SLASH_FLASHSPEED.." - controls the flash speed",
	COOLDOWNCOUNT_SLASH_SCALE.." - controls the scaling",
	COOLDOWNCOUNT_SLASH_ALPHA.." - controls the alpha",
	COOLDOWNCOUNT_SLASH_NOSPACES.." - controls the spacing (whether to put a space between number and unit)",
	COOLDOWNCOUNT_SLASH_NORMALCOLOR.." - choose normal CooldownCount color",
	COOLDOWNCOUNT_SLASH_FLASHCOLOR.." - choose flashing CooldownCount color",
	COOLDOWNCOUNT_SLASH_HIDEUNTILTIMELEFT.." - hide until specified number of seconds left, 0 disables",
	--COOLDOWNCOUNT_SLASH_USELONGTIMERS.." - control long timer descriptions"
};

COOLDOWNCOUNT_CHAT_ALPHA_NOT_SPECIFIED				= "Cooldown Count alpha requires you to specify a number.";

COOLDOWNCOUNT_CHAT_USERSCALE						= "Cooldown Count user defined scale set to %s.";
COOLDOWNCOUNT_CHAT_USERSCALE_NOT_SPECIFIED			= "Cooldown Count scale requires you to specify a number.";

COOLDOWNCOUNT_CHAT_USELONGTIMERS_ENABLED			= "Cooldown Count use long timer descriptions enabled.";
COOLDOWNCOUNT_CHAT_USELONGTIMERS_DISABLED			= "Cooldown Count use long timer descriptions disabled.";



COOLDOWNCOUNT_CHAT_ENABLED							= "Cooldown Count enabled.";
COOLDOWNCOUNT_CHAT_DISABLED							= "Cooldown Count disabled.";

COOLDOWNCOUNT_CHAT_ROGUE_STEALTH_ENABLED			= "Cooldown Count on Rogue Stealth enabled.";
COOLDOWNCOUNT_CHAT_ROGUE_STEALTH_DISABLED			= "Cooldown Count on Rogue Stealth disabled.";

COOLDOWNCOUNT_CHAT_NOSPACES_ENABLED					= "Cooldown Count no spaces enabled.";
COOLDOWNCOUNT_CHAT_NOSPACES_DISABLED				= "Cooldown Count no spaces disabled.";
COOLDOWNCOUNT_CHAT_FLASHSPEED						= "Cooldown Count flash speed set to %s.";

COOLDOWNCOUNT_CHAT_COMMAND_MAIN_INFO				= "Controls Cooldown Count.";
COOLDOWNCOUNT_CHAT_COMMAND_ENABLE_INFO				= "Enables/disables Cooldown Count.";
COOLDOWNCOUNT_CHAT_COMMAND_SIDECOUNT_ENABLE_INFO	= "Enables/disables Cooldown Count side bar offset.";
COOLDOWNCOUNT_CHAT_COMMAND_FLASHSPEED_INFO			= "Sets how long the time should be (in seconds) between each flash when the cooldown is about to expire.";
COOLDOWNCOUNT_CHAT_COMMAND_SCALE_INFO				= "Sets how big a scale the Cooldown Count numbers should have.";

COOLDOWNCOUNT_CHAT_ALPHA_FORMAT						= "Cooldown Count alpha set to %2f";
COOLDOWNCOUNT_CHAT_NORMAL_COLOR_SET					= "Cooldown Count - normal countdown color set.";
COOLDOWNCOUNT_CHAT_FLASH_COLOR_SET					= "Cooldown Count - flash countdown color set.";

COOLDOWNCOUNT_CHAT_HIDEUNTILTIMELEFT				= "Cooldown Count hide until time left set to %d.";
COOLDOWNCOUNT_CHAT_HIDEUNTILTIMELEFT_NOT_SPECIFIED	= "Cooldown Count hide until time left requires you to specify a number.";


-- Classes

COOLDOWNCOUNT_CLASS_ROGUE							= "Rogue";

