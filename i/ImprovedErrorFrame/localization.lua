-- Version : English (by Vjeux, Mugendai)
-- $LastChangedBy: Sinaloit $
-- $Date: 2005-07-10 13:53:31 +1000 (Sun, 10 Jul 2005) $

-- Interface Configuration
IEF_FILE		= "File: ";
IEF_STRING		= "String: ";
IEF_LINE		= "Line: ";
IEF_COUNT		= "Count: ";
IEF_ERROR		= "Error: ";

IEF_CANCEL		= "Cancel";
IEF_CLOSE		= "Close";
IEF_REPORT		= "Report";

IEF_INFINITE		= "Infinite";

-- Slash command strings
IEF_NOTIFY_ON		= "ImprovedErrorFrame: Alert delay notification enabled.";
IEF_NOTIFY_OFF		= "ImprovedErrorFrame: Errors reported as they occur.";
IEF_BLINK_ON		= "ImprovedErrorFrame: Blink with pending errors.";
IEF_BLINK_OFF		= "ImprovedErrorFrame: Button will not blink.";
IEF_COUNT_ON		= "ImprovedErrorFrame: Display count of pending errors.";
IEF_COUNT_OFF		= "ImprovedErrorFrame: No pending error count.";
IEF_ALWAYS_ON		= "ImprovedErrorFrame: Always show error button.";
IEF_ALWAYS_OFF		= "ImprovedErrorFrame: Button shown upon notification.";
IEF_SOUND_ON		= "ImprovedErrorFrame: Sound played upon notification.";
IEF_SOUND_OFF		= "ImprovedErrorFrame: No sounds will be played.";
IEF_EMPTY_ON		= "ImprovedErrorFrame: Button graphic will disapear when blinking.";
IEF_EMPTY_OFF		= "ImprovedErrorFrame: Button graphic will not change with blinking.";
IEF_DEBUG_ON		= "ImprovedErrorFrame: FrameXML Verbose logging on";
IEF_DEBUG_OFF		= "ImprovedErrorFrame: FrameXML Verbose logging off";
IEF_FORMAT_STR		= "Format: /ief <NOTIFY|BLINK|COUNT|ALWAYS|SOUND|EMPTY|DEBUG> <ON|OFF>";
IEF_FORMAT_STR_NOCHRON	= "Format: /ief <NOTIFY|COUNT|ALWAYS|SOUND|DEBUG> <ON|OFF>";
IEF_CURRENT_SETTINGS	= "Current Settings:";
IEF_BLINK_OPT		= "blink";
IEF_NOTIFY_OPT		= "notify";
IEF_COUNT_OPT		= "count";
IEF_ALWAYS_OPT		= "always";
IEF_SOUND_OPT		= "sound";
IEF_EMPTY_OPT		= "empty";
IEF_DEBUG_OPT		= "debug";
IEF_ON			= "on";
IEF_OFF			= "off";
IEF_HELP_TEXT		= "/ief - Improved Error Frame Configuration";

-- Tooltip Text
IEF_TOOLTIP		= "Click to view errors.";
-- Header Text
IEF_TITLE_TEXT		= "Queued Errors";
IEF_ERROR_TEXT		= "Realtime Errors";

-- Khaos/Cosmos descriptions
IEF_OPTION_TEXT		= "Improved Error Frame";
IEF_OPTION_HELP		= "Allows you to set Error Reporting Options.";
IEF_HEADER_TEXT		= "Improved Error Frame";
IEF_HEADER_HELP		= "The various options to configure your error reporting needs.";
IEF_NOTIFY_TEXT		= "Queue Errors";
IEF_NOTIFY_HELP		= "If checked, errors will be queued to be displayed later.";
IEF_BLINK_TEXT		= "Blinking Button";
IEF_BLINK_HELP		= "If checked, button will blink when errors are pending view.";
IEF_COUNT_TEXT		= "Display error count on button";
IEF_COUNT_HELP		= "If checked, error count will be displayed on button.";
IEF_ALWAYS_TEXT		= "Always show error button";
IEF_ALWAYS_HELP		= "If checked, button will always be present on the screen.";
IEF_SOUND_TEXT		= "Play notification sound";
IEF_SOUND_HELP		= "If checked, sound will be played upon initial error event.";
IEF_EMPTY_TEXT		= "Clear Button Graphic";
IEF_EMPTY_HELP		= "If checked, error button will clear while blinking.";
IEF_DEBUG_TEXT		= "Verbose FrameXML Error Log";
IEF_DEBUG_HELP		= "If checked, FrameXML.log will be outputted in verbose mode. (Requires UI Reload)";
