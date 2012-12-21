-------------------------------------------------------------------------------
--                               TitanCritLine                               --
--                               French Localization                         --
-------------------------------------------------------------------------------
-- A special thanks to Laurent Patouet (ArKoS) for his time in helping me    --
-- debug and get this french localization file correct! Thanks Buddy!        --
--                                                                           --
-------------------------------------------------------------------------------




function TitanCritLine_LocalizeFR()
	
	NORMAL_HIT_TEXT = "Coup Normal";
	NORMAL_TEXT = "Coup Normal";
	CRIT_TEXT = "Coup Critique";

	TITAN_CRITLINE_OPTION_SPLASH_TEXT = "Afficher les Nouveaux Records \195\160 l\'\195\169cran";
	TITAN_CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Jouer un Son.";
	TITAN_CRITLINE_OPTION_PVPONLY_TEXT = "Compter seulement les attaques JcJ.";
	TITAN_CRITLINE_OPTION_SCREENCAP_TEXT = "Faire un Screenshot pour un Nouveau record.";
	TITAN_CRITLINE_OPTION_LVLADJ_TEXT = "Utiliser l\'Ajustement de Niveau.";
	TITAN_CRITLINE_OPTION_FILTER_HEALING_TEXT = "Ne pas compter les Sorts de soin.";
	TITAN_CRITLINE_OPTION_RESET_TEXT = "Mise \195\160 z\195\169ro de tous les records.";

	TITAN_CRITLINE_NEW_RECORD_MSG = "! Nouveau Record pour %s !"; --e.g. New Ambush Record!

	COMBAT_HIT_MSG = "Vous touchez (.+) et infligez (%d+) points de (.+).";--mask dégâts
	COMBAT_CRIT_MSG = "Vous portez un coup critique /195/160 (.+) et infligez (%d+) points de (.+).";--mask dégâts

	SPELL_HIT_MSG = "Votre (.+) touche (.+) et inflige (%d+) points de (.+).";--mask dégâts
	SPELL_CRIT_MSG = "Votre (.+) touche (.+) avec un coup critique et inflige (%d+) points de (.+).";--mask dégâts

	HEAL_SPELL_HIT_MSG = "Votre (.+) vous soigne pour (%d+) points de vie.";
	HEAL_SPELL_CRIT_MSG = "Votre (.+) soigne (.+) avec un effet critique et lui rend (%d+) points de vie.";

end