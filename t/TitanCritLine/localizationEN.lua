-------------------------------------------------------------------------------
--                               TitanCritLine                               --
--                               English Localization                        --
-------------------------------------------------------------------------------
-- A special thanks to the following for the english localization:           --
--                                                                           --
-- Sordit                                                                    --
-- http://ui.worldofwar.net/users.php?id=161051                              --
-------------------------------------------------------------------------------




function TitanCritLine_LocalizeEN()
	
	NORMAL_HIT_TEXT = "Normal Hit";
	NORMAL_TEXT = "Normal";
	CRIT_TEXT = "Crit";

	TITAN_CRITLINE_OPTION_SPLASH_TEXT = "Display new high record splash screen";
	TITAN_CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Play Sounds.";
	TITAN_CRITLINE_OPTION_PVPONLY_TEXT = "Only count PvP attacks.";
	TITAN_CRITLINE_OPTION_SCREENCAP_TEXT = "Take screen capture on new records.";
	TITAN_CRITLINE_OPTION_LVLADJ_TEXT = "Use Level Adjustment.";
	TITAN_CRITLINE_OPTION_FILTER_HEALING_TEXT = "Do not count healing spells.";
	TITAN_CRITLINE_OPTION_RESET_TEXT = "Reset All Records.";
		
	TITAN_CRITLINE_NEW_RECORD_MSG = "New %s Record!"; --e.g. New Ambush Record!

	COMBAT_HIT_MSG = "You hit (.+) for (%d+)."; --COMBATHITSELFOTHER
	COMBAT_CRIT_MSG	= "You crit (.+) for (%d+).";
			
	SPELL_HIT_MSG = "Your (.+) hits (.+) for (%d+).";
	SPELL_CRIT_MSG = "Your (.+) crits (.+) for (%d+).";

	HEAL_SPELL_HIT_MSG = "Your (.+) heals (.+) for (%d+).";
	HEAL_SPELL_CRIT_MSG = "Your (.+) critically heals (.+) for (%d+).";
	
end