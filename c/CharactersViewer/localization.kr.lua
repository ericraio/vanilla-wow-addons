--[[
   Version: $Rev: 2303 $
   Last Changed by: $LastChangedBy: flisher $
   Date: $Date: 2005-08-14 20:49:51 -0700 (Sun, 14 Aug 2005) $

   Note: Please don't remove commented line and change the layout of this file, the main goal is to have 3 localization files with the same layout for easy spotting of missing information.
   The SVN tag at the begining of the file will automaticaly update upon uploading.
]]--

if (GetLocale() == "koKR") then

	-- Configuration variables
	SLASH_CHARACTERSVIEWER1							= "/CharactersViewer";
	SLASH_CHARACTERSVIEWER2							= "/cv";
	CHARACTERSVIEWER_SUBCMD_SHOW					= "í‘œì‹œ";
	CHARACTERSVIEWER_SUBCMD_CLEAR					= "ì‚­ì œ";
	CHARACTERSVIEWER_SUBCMD_CLEARALL				= "ëª¨ë‘ì‚­ì œ";
	CHARACTERSVIEWER_SUBCMD_PREVIOUS				= "ì´ì „";
	CHARACTERSVIEWER_SUBCMD_NEXT					= "ë‹¤ìŒ";
	CHARACTERSVIEWER_SUBCMD_SWITCH					= "ë³€ê²½";
	CHARACTERSVIEWER_SUBCMD_LIST					= "ëª©ë¡";
	--CHARACTERSVIEWER_SUBCMD_bank                    = "bank";
	-- CHARACTERSVIEWER_SUBCMD_RESETLOC                = "resetloc";

	-- Localization text
	BINDING_HEADER_CHARACTERSVIEWER                 = "CharactersViewer";
	BINDING_NAME_CHARACTERSVIEWER_TOGGLE            = "CharactersViewer ì°½ ì—´ê¸°/ë‹«ê¸° ë‹¨ì¶•í‚¤";
--	BINDING_NAME_CHARACTERSVIEWER_BANKTOGGLE			= "Open / Close CharactersViewer Bank";
	BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS   = "ì´ì „ ìºë¦­í„° ë³€ê²½";
	BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT       = "ë‹¤ìŒ ìºë¦­í„° ë³€ê²½";

	CHARACTERSVIEWER_CRIT                           = "ì¹˜ëª…íƒ€";

	CHARACTERSVIEWER_SELPLAYER                      = "ì„ íƒ";
	CHARACTERSVIEWER_DROPDOWN2                      = "ë¹„êµ";
	CHARACTERSVIEWER_TOOLTIP_BAGRESET               = "ì™¼ìª½ë²„íŠ¼ í´ë¦­: ê°€ë°© í‘œì‹œ ì¼¬/ë”.\nì˜¤ë¥¸ìª½ë²„íŠ¼ í´ë¦­: ê°€ë°© ìœ„ì¹˜ ì´ˆê¸°í™”.";
	CHARACTERSVIEWER_TOOLTIP_MAIL                   = "ì™¼ìª½ë²„íŠ¼ í´ë¦­: ìš°íŽ¸í•¨ í‘œì‹œ ì¼¬/ë”.\nì˜¤ë¥¸ìª½ë²„íŠ¼ í´ë¦­: ìš°íŽ¸í•¨ ìœ„ì¹˜ ì´ˆê¸°í™”.";
	CHARACTERSVIEWER_TOOLTIP_BANK                   = "ì™¼ìª½ë²„íŠ¼ í´ë¦­: ì€í–‰ í‘œì‹œ ì¼¬/ë”.\nì˜¤ë¥¸ìª½ë²„íŠ¼ í´ë¦­: ì€í–‰ ìœ„ì¹˜ ì´ˆê¸°í™”.";
	CHARACTERSVIEWER_TOOLTIP_DROPDOWN2              = "í´ë¦­ìœ¼ë¡œ ì„œë²„ë‚´ ìžì‹ ì˜ ë‹¤ë¥¸ ìºë¦­í„°ë¥¼ ì„ íƒí•©ë‹ˆë‹¤.\nì°½ì— í‘œì‹œë  ê²ƒìž…ë‹ˆë‹¤.";
	CHARACTERSVIEWER_TOOLTIP_BANKBAG                = "ì™¼ìª½ë²„íŠ¼ í´ë¦­: ì€í–‰ ê°€ë°© í‘œì‹œ ì¼¬/ë”.\nì˜¤ë¥¸ìª½ë²„íŠ¼ í´ë¦­: ì€í–‰ ê°€ë°© ìœ„ì¹˜ ì´ˆê¸°í™”.";
--	CHARACTERSVIEWER_SAVEDON								= "Saved on: ";
	
	CHARACTERSVIEWER_PROFILECLEARED                 = "í”„ë¡œíŒŒì¼ì´ ì‚­ì œë˜ì—ˆìŠµë‹ˆë‹¤: ";
	CHARACTERSVIEWER_ALLPROFILECLEARED              = "ëª¨ë“  ì„œë²„ì˜ í”„ë¡œíŒŒì¼ì´ ì‚­ì œë˜ì—ˆìŠµë‹ˆë‹¤. í˜„ìž¬ ìºë¦­í„°ì˜ í”„ë¡œíŒŒì¼ì´ ì¶”ê°€ë˜ì—ˆìŠµë‹ˆë‹¤.";
	CHARACTERSVIEWER_NOT_FOUND                      = "ìºë¦­í„°ê°€ ì—†ìŠµë‹ˆë‹¤: ";

	CHARACTERSVIEWER_USAGE                          = "ì‚¬ìš©ë²•: '/cv <ëª…ë ¹ì–´>' <ëª…ë ¹ì–´> ë¶€ë¶„ì— ì‚¬ìš©í•  ìˆ˜ ìžˆëŠ” ëª…ë ¹ì–´ëŠ” ë‹¤ìŒê³¼ ê°™ìŠµë‹ˆë‹¤.";
	CHARACTERSVIEWER_USAGE_SUBCMD                   = {};
	CHARACTERSVIEWER_USAGE_SUBCMD[1]                = " í‘œì‹œ : ìºë¦­í„° ìƒíƒœì°½ì— ìž¥ë¹„/ëŠ¥ë ¥ì¹˜ë¥¼ í‘œì‹œí•©ë‹ˆë‹¤.";
	CHARACTERSVIEWER_USAGE_SUBCMD[2]                = " ì‚­ì œ <ì¸ìˆ˜1>: <ì¸ìˆ˜1> ì´ë¦„ì˜ ìºë¦­í„° í”„ë¡œíŒŒì¼ì„ ì‚­ì œí•©ë‹ˆë‹¤.";
	CHARACTERSVIEWER_USAGE_SUBCMD[3]                = " ëª¨ë‘ì‚­ì œ : ëª¨ë“  ì„œë²„ì˜ ëª¨ë“  ìºë¦­í„° ìž¥ë¹„/ëŠ¥ë ¥ì¹˜ ì •ë³´ë¥¼ ì‚­ì œí•©ë‹ˆë‹¤.";
	CHARACTERSVIEWER_USAGE_SUBCMD[4]                = " ì´ì „ : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS;
	CHARACTERSVIEWER_USAGE_SUBCMD[5]                = " ë‹¤ìŒ : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT;
	CHARACTERSVIEWER_USAGE_SUBCMD[6]                = " ë³€ê²½ <ì¸ìˆ˜1>: <ì¸ìˆ˜1> ì´ë¦„ì˜ ìºë¦­í„°ë¡œ ë³€ê²½í•©ë‹ˆë‹¤.";
	CHARACTERSVIEWER_USAGE_SUBCMD[7]                = " ëª©ë¡ : í˜„ìž¬ ì„œë²„ì˜ ìºë¦­í„°ë“¤ì— ëŒ€í•œ ì—¬ëŸ¬ ì •ë³´ë¥¼ í‘œì‹œí•©ë‹ˆë‹¤.";
	--   CHARACTERSVIEWER_USAGE_SUBCMD[8]                = " bank : Toggle the Bank display on/off.";
  --   CHARACTERSVIEWER_USAGE_SUBCMD[9]                = " resetloc : Reset the position of the main frame of " .. BINDING_HEADER_CHARACTERSVIEWER;

	CHARACTERSVIEWER_DESCRIPTION                    = "ìžì‹ ì˜ ë‹¤ë¥¸ ìºë¦­í„°ì˜ ìž¥ë¹„, ì¸ë²¤í† ë¦¬, ëŠ¥ë ¥ì¹˜ ë³´ê¸°";
	CHARACTERSVIEWER_SHORT_DESC                     = "ë¶€ìº ì‚´íŽ´ë³´ê¸° ì¼œê¸°/ë„ê¸°";
	CHARACTERSVIEWER_ICON                           = "Interface\\Buttons\\Button-Backpack-Up";

	CHARACTERSVIEWER_NOT_CACHED                     = "ìºì‰¬ ì •ë³´ì— ìˆ˜ë¡ë˜ì§€ ì•Šì€ ì•„ì´í…œ";
	CHARACTERSVIEWER_RESTED                         = "íœ´ì‹ ìƒíƒœ";
	CHARACTERSVIEWER_RESTING                        = "íœ´ì‹ì¤‘ ìƒíƒœ";
	CHARACTERSVIEWER_NOT_RESTING                    = "ì¼ë°˜ ìƒíƒœ";

	CHARACTERSVIEWER_BANK_TITLE                     = "CharactersViewer (ì€í–‰)";
	CHARACTERSVIEWER_ALLIANCE_HORDE					= "Horde";
   CHARACTERSVIEWER_ALLIANCE_ALLIANCE				= "Alliance";
	CHARACTERSVIEWER_ALLIANCE_TOTAL					= "Total";
end
