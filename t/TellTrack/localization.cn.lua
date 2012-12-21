-- Version : Chinese Simple (WOWUI.CN)
-- Last Update : 04/11/2005

TELLTRACK_EMPTYLABEL = "Empty";

if (GetLocale() == "zhCN") then

TELLTRACK_MENU_WIDTH 			= 100;

-- Binding Configuration
BINDING_HEADER_TELLTRACKHEADER		= "Tell Track";
BINDING_NAME_TELLTRACK			= "打开 Tell Track";
BINDING_NAME_TELLTRACK1			= "悄悄话给第一个可见的";
BINDING_NAME_TELLTRACK2			= "悄悄话给第二个可见的";
BINDING_NAME_TELLTRACK3			= "悄悄话给第三个可见的";
BINDING_NAME_TELLTRACK4			= "悄悄话给第四个可见的";
BINDING_NAME_TELLTRACK_RETELL		= "悄悄话给最后告诉你的";

-- Cosmos Configuration
TELLTRACK_CONFIG_HEADER			= "Tell Track";
TELLTRACK_CONFIG_HEADER_INFO		= "Contains settings for Tell Track,\nan AddOn which makes it easier for you to talk to several people simultaneously.\nClick the question-mark corner for more info.";

TELLTRACK_ENABLED			= "Enable Tell Track";
TELLTRACK_ENABLED_INFO			= "Enables Tell Track, displaying its window.";

TELLTRACK_INVERTED			= "Inverts the Tell Track list";
TELLTRACK_INVERTED_INFO			= "Inverts Tell Track, displaying names in reverse order.";

-- Chat Configuration
TELLTRACK_CHAT_ENABLED			= "Tell Track 启用了。\n点击 Tell Track 右上角'?'按钮获得跟多信息。";
TELLTRACK_CHAT_DISABLED			= "Tell Track 禁用了。";

TELLTRACK_CHAT_INVERTED			= "反向显示 Tell Track 列表。";
TELLTRACK_CHAT_NORMALIZED		= "正向显示 Tell Track 列表。";

TELLTRACK_CHAT_COMMAND_ENABLE_INFO	= "Enables/disables Tell Track.\nAlso, use /telltrack clearall to clear all entries.";
TELLTRACK_CHAT_COMMAND_INVERT_INFO	= "Inverts/Normalizes Tell Track list.";

TELLTRACK_CHAT_QUESTION_MARK_INFO	= "TellTrack 汉化版 |cffffff00[WOWUI.CN汉化]|r\n\n"..
			"左键点击：发送悄悄话。\n"..
			"右键点击：删除人名。\n"..
			"滚轮：按行滚动(最大20)。\n"..
			"左键点击箭头：按页滚动(max 20)。\n"..
			"右键点击箭头：到最顶端或最底端。";

-- Interface Configuration
TELLTRACK_QUESTION_MARK_TOOLTIP		= "点击这里获取更多信息"
TELLTRACK_RESIZE_TOOLTIP		= "拖动这里来调整大小"
-- Only For Earth Menu
TELLTRACK_WHISPER			= "Whisper";
TELLTRACK_WHO				= "Who";
TELLTRACK_GRPINV			= "Group Invite";
TELLTRACK_ADDFRIEND			= "Add to Friends";
TELLTRACK_DELETE			= "Delete"
TELLTRACK_DELETE_ALL			= "Delete All"
TELLTRACK_INVERT			= "Invert List"
TELLTRACK_CANCEL			= "Cancel";

TELLTRACK_EMPTYLABEL = "(空)";

-- Cosmos AddOn Mod Configuration
TELLTRACK_CONFIG_TRANSNUI		= "Transparent TellTrack";
TELLTRACK_CONFIG_TRANSNUI_INFO		= "Allows you to make TellTrack transparent";

TELLTRACK_CONFIG_POPNUI			= "Autohide TellTrack";
TELLTRACK_CONFIG_POPNUI_INFO		= "Check this to make TellTrack only show when you move your mouse over it.";

end