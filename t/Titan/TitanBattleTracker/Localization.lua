if (GetLocale() == "enUS") then

	-- ###############
	-- ## MENU TEXT ##
	-- ###############

	TITANBT_TOOLTIP = "BattleTracker";

	TITANBT_MENU_DISP_AV           = "Show Alterac Valley Tracker";
	TITANBT_MENU_DISP_AB           = "Show Arathi Basin Tracker";
	TITANBT_MENU_DISP_WSG          = "Show Warsong Gulch Tracker";

	TITANBT_MENU_OPTS_DEBUG       = "Debug Mode";

	TITANBT_MENU_FUNCS_RESET       = "Reset Statistics";


	-- ###################
	-- ## BUTTON LABELS ##
	-- ###################

	-- Battleground
	TITANBT_S_AB           = " AB:";
	TITANBT_S_AV           = " AV:";
	TITANBT_S_WSG          = " WSG:";
	TITANBT_S_NULL         = "BattleTracker";
	TITANBT_S_SHORT        = "BT ";


	-- ####################
	-- ## TOOLTIP LABELS ##
	-- ####################

	TITANBT_TT_HeaderLeft   = "Battlefield:";
	TITANBT_TT_HeaderRight  = "Total/" .. TitanUtils_GetGreenText("Wins") .. "/" .. TitanUtils_GetRedText("Losses");
	TITANBT_TT_AB           = "Arathi Basin:";
	TITANBT_TT_AV           = "Alterac Valley:";
	TITANBT_TT_WSG          = "Warsong Gulch:";



	-- ####################
	-- ## SYSTEM NOTICES ##
	-- ####################

	-- Notices sent by the system during battlegrounds play.

	-- !! WARNING !!
	-- These must appear EXACTLY as they appear in the game when these events occur.

	-- Please make certain the text appears EXACTLY as printed. Do not insert capitals where they are not necessary,
	-- nor not include capitals when they are listed.

		TITANBT_NOTICE_GAMEOVER   = " wins!";
		TITANBT_NOTICE_GAMEOVER2  = " Wins!";

	-- !! END WARNING !!


	-- ######################
	-- ## TITANBT MESSAGES ##
	-- ######################

	TITANBT_GAMELOST                  = "[%s] Game over, loss tracked";
	TITANBT_GAMEWON                   = "[%s] Game over, win tracked.";

	TITANBT_SEND_DATA                 = "[BattleTracker] AV: %s, AB: %s, WSG: %s";

	-- ##################
	-- ## NOMENCLATURE ##
	-- ##################

	-- Short names for the battlegrounds.
	TITANBT_BG_AV_SHORT  = "AV";
	TITANBT_BG_WSG_SHORT = "WSG";
	TITANBT_BG_AB_SHORT  = "AB";

	-- Faction names. EXACTLY as returned by UnitFactionGroup("player") or UnitFactionGroup("target").
	TITANBT_HORDE    = "Horde";
	TITANBT_ALLIANCE = "Alliance";

	-- !! WARNING !!
	-- These must apear exactly as sent by the system.
	-- This can be tested by making certain the lines between !! DEBUG START and !! DEBUG END
	-- are not commented (do not have a preceeding --) and typing '/console reloadui' into the chat window.

	-- 'BG = ' will display the name of the battleground. If the slot isn't taken up by a battleground,
	-- then it will display the zone you are currently in.

	-- 'STATUS = ' will show the status of the current battleground.

	-- Please make certain the text appears EXACTLY as printed. Do not insert capitals where they are not necessary,
	-- nor not include capitals when they are listed.

		-- Battleground Names
		TITANBT_BG_AV  = "Alterac Valley";
		TITANBT_BG_WSG = "Warsong Gulch";
		TITANBT_BG_AB  = "Arathi Basin";

	-- !! END WARNING !!
end