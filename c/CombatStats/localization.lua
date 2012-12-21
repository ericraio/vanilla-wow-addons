-- <= == == == == == == == == == == == == =>
-- Combat Stats 2 Localization file
-- <= == == == == == == == == == == == == =>
COMBATSTATS_CONFIG_HEADER = "CombatStats";
COMBATSTATS_CONFIG_HEADER_INFO = "These options modify CombatStats.\n ";
COMBATSTATS_CONFIG_ONOFF = "Turn CombatStats On/Off";
COMBATSTATS_CONFIG_ONOFF_INFO = "If this box is unchecked,\n CombatStats is off.";
COMBATSTATS_CHAT_COMMAND_INFO = "Tracks CombatStats and generates data.";
COMBATSTATS_CONFIG_HIDEONNOTARGET = "Hide When No Target";
COMBATSTATS_CONFIG_HIDEONNOTARGET_INFO = "If enabled then Combat Stats will only be visible when there is a target.";
COMBATSTATS_CONFIG_USEMOUSEOVER = "Show CombatStats on mouseover";
COMBATSTATS_CONFIG_USEMOUSEOVER_INFO = "If enabled, Combat Stats will appear when you mouseover the title.\nIf disabled, Combat Stats will appear when you click on the title."
COMBATSTATS_CONFIG_ENDOFFIGHT = "Show end of fight statistics";
COMBATSTATS_CONFIG_ENDOFFIGHT_INFO = "If enabled then Combat Stats will show end of fight DPS/damage stats.";


COMBSTATS_CHAT_COMMAND_RESET = "Reset combat stats data.";

CS_CHAT_COMMAND_INFO			= "Type /cs or /combatstats for usage instructions.";

CS_FRAME_GEN_ATTACK_NAME = "Attack Name :";
CS_FRAME_TICKS_TEXT = "DOT ticks.";
CS_FRAME_HOT_TEXT = "HOT ticks.";
CS_FRAME_HITS_TEXT = "hits out of";
CS_FRAME_SWINGS_TEXT = "swings or uses.";
CS_FRAME_MISSES_TEXT = "Misses : ";
CS_FRAME_DODGES_TEXT = "Dodges : ";
CS_FRAME_PARRIES_TEXT = "Parries : ";
CS_FRAME_BLOCKS_TEXT = "Blocks : ";
CS_FRAME_RESISTS_TEXT = "Resists : ";
CS_FRAME_IMMUNE_TEXT = "Immune : ";
CS_FRAME_EVADES_TEXT = "Evades : ";
CS_FRAME_DEFLECTS_TEXT = "Deflects : ";
CS_FRAME_PERCENT_OVERALL_TEXT = "Percentage of overall damage : ";
CS_FRAME_TIME_LASTCRIT_TEXT = "Time since last crit : ";
CS_FRAME_TOTAL_TEXT = "Total : ";
CS_FRAME_DAMAGE_TEXT = "Damage : ";
CS_FRAME_MINMAX_TEXT = "Min / Max : ";
CS_FRAME_AVGDMG_TEXT = "Avg. Damage : ";
CS_FRAME_PERCENTDMG_TEXT = "% Of Dmg. : ";

CS_FRAME_PERCENT_OVERALL_TEXT_HEAL = "Percentage of overall HP healed: ";
CS_FRAME_DAMAGE_TEXT_HEAL = "HP Healed : ";
CS_FRAME_AVGDMG_TEXT_HEAL = "Avg. Healed : ";
CS_FRAME_PERCENTDMG_TEXT_HEAL = "% Of Total : ";
CS_FRAME_HITS_TEXT_HEAL = "heal(s) cast.";

CS_DROPDOWN_SELECT_TEXT = "Select Attack";

CS_TT_OVERALLPCT_TEXT = "Overall critical hit percentage.";
CS_TT_OVERALLDMGPCT_TEXT = "Percentage of the total damage done by all attacks that was done by this attack.";
CS_TT_NONCRIT_HITSPCT_TEXT = "Percent of this attack's hits that are non critical hits.";
CS_TT_CRIT_HITSPCT_TEXT = "Percent of this attack's hits that are critical hits.";
CS_TT_NONCRIT_DMGPCT_TEXT = "Percentage of this attack's damage that was from non critical hits.";
CS_TT_CRIT_DMGPCT_TEXT = "Percentage of this attack's damage that was from critical hits.";

CS_TT_OVERALLPCT_TEXT_NONHEAL = "Overall critical hit percentage.";
CS_TT_OVERALLDMGPCT_TEXT_NONHEAL = "Percentage of the total damage done by all attacks that was done by this attack.";
CS_TT_NONCRIT_HITSPCT_TEXT_NONHEAL = "Percent of this attack's hits that are non critical hits.";
CS_TT_CRIT_HITSPCT_TEXT_NONHEAL = "Percent of this attack's hits that are critical hits.";
CS_TT_NONCRIT_DMGPCT_TEXT_NONHEAL = "Percentage of this attack's damage that was from non critical hits.";
CS_TT_CRIT_DMGPCT_TEXT_NONHEAL = "Percentage of this attack's damage that was from critical hits.";

CS_TT_NONCRIT_HITSPCT_TEXT_HEAL = "Percent of this spell's hits that are non critical hits.";
CS_TT_CRIT_HITSPCT_TEXT_HEAL = "Percent of this spell's hits that are critical hits.";
CS_TT_OVERALLDMGPCT_TEXT_HEAL = "Percentage of the total HP healed by all heal spells that was done by this spell.";
CS_TT_CRIT_DMGPCT_TEXT_HEAL = "Percentage of HP healed from this spell that was from critical hits.";
CS_TT_NONCRIT_DMGPCT_TEXT_HEAL = "Percentage of HP healed from this spell that was from non critical hits.";


RED_FONT_COLOR_CODE = "|cffff2020";
NORMAL_FONT_COLOR_CODE = "|cffffd200";
WHITE_FONT_COLOR_CODE = "|cffffffff";
GREEN_FONT_COLOR_CODE = "|cff20ff20";
BLUE_FONT_COLOR_CODE = "|cff2020ff";

DPS_DISPLAY = "%.2f";

CLOCK_TIME_DAY				= "%d day";
CLOCK_TIME_HOUR				= "%d hour";
CLOCK_TIME_MINUTE			= "%d minute";
CLOCK_TIME_SECOND			= "%d second";

if ( GetLocale() == "deDE" ) then
	-- Translation by pc

	COMBATSTATS_CONFIG_HEADER		= "Kampfstatisktik";
	COMBATSTATS_CONFIG_HEADER_INFO	= "Diese Einstellungen verändern die Kampstatistik.\n ";
	COMBATSTATS_CONFIG_ONOFF		= "Kampfstatisktik Ein-/Ausschalten";
	COMBATSTATS_CONFIG_ONOFF_INFO	= "Wenn diese Checkbox markiert ist,\n ist die Kampfstatistik angeschaltet.";
	COMBATSTATS_CHAT_COMMAND_INFO	= "Ermittelt Kampfstatistik und generiert Daten.";

	RED_FONT_COLOR_CODE		= "|cffff2020";
	NORMAL_FONT_COLOR_CODE	= "|cffffd200";
	WHITE_FONT_COLOR_CODE	= "|cffffffff";
	GREEN_FONT_COLOR_CODE	= "|cff20ff20";
	BLUE_FONT_COLOR_CODE	= "|cff2020ff";

	DPS_DISPLAY				= "Gesamt DPS :: %.2f";

	CLOCK_TIME_DAY			= "%d Tag";
	CLOCK_TIME_HOUR			= "%d Stunde";
	CLOCK_TIME_MINUTE		= "%d Minute";
	CLOCK_TIME_SECOND		= "%d Sekunde";

end