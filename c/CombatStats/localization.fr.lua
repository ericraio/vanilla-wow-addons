-- Version : French ( by Vjeux, Sasmira )
-- Last Update : 03/26/2005

if ( GetLocale() == "frFR" ) then

COMBATSTATS_CONFIG_HEADER = "Statistiques de Combats";
COMBATSTATS_CONFIG_HEADER_INFO = "Modifie les options des Statistiques de Combats.\n ";
COMBATSTATS_CONFIG_ONOFF = "Marche/Arr\195\170t des Statistiques de Combats";
COMBATSTATS_CONFIG_ONOFF_INFO = "Affiche les Statistiques de Combats au dessus du portrait de votre personnage.";
COMBATSTATS_CHAT_COMMAND_INFO = "Affiche les statistiques sur vos combats.";
COMBATSTATS_CONFIG_HIDEONNOTARGET = "Cacher la fen\195\170tre quand vous n\'avez pas de cible";
COMBATSTATS_CONFIG_HIDEONNOTARGET_INFO = "Cache la fen\195\170tre des Statistiques de Combats quand vous n\'avez pas de cible.";
COMBATSTATS_CONFIG_USEMOUSEOVER = "Afficher les Statistiques de Combats en passant la Souris dessus";
COMBATSTATS_CONFIG_USEMOUSEOVER_INFO = "Si vous activez cette option, les informations s\'afficheront lors du passage de la Souris, sinon il faudra cliquer dessus."
COMBATSTATS_CONFIG_ENDOFFIGHT = "Afficher les Statistiques \195\160 la fin d\'un combat";
COMBATSTATS_CONFIG_ENDOFFIGHT_INFO = "Si vous activez cette option, les informations s\'afficheront lors de la fin d\'un combat.";


COMBSTATS_CHAT_COMMAND_RESET = "R\195\169inisialise les Statistiques.";

CS_CHAT_COMMAND_INFO			= "Tapez /cs ou /combatstats pour avoir plus d\'informations.";

CS_FRAME_GEN_ATTACK_NAME = "Nom du Coups:";
CS_FRAME_TICKS_TEXT = "DOT ticks.";
CS_FRAME_HITS_TEXT = "coups sur";
CS_FRAME_SWINGS_TEXT = "R\195\169ussis.";
CS_FRAME_MISSES_TEXT = "Loup\195\169s: ";
CS_FRAME_DODGES_TEXT = "Esquiv\195\169s: ";
CS_FRAME_PARRIES_TEXT = "Parr\195\169s: ";
CS_FRAME_BLOCKS_TEXT = "Bloc : ";
CS_FRAME_RESISTS_TEXT = "R\195\169sist: ";
CS_FRAME_IMMUNE_TEXT = "Immun: ";
CS_FRAME_EVADES_TEXT = "\195\169vit\195\169s: ";
CS_FRAME_DEFLECTS_TEXT = "D\195\169vi\195\169s: ";
CS_FRAME_PERCENT_OVERALL_TEXT = "%age de tous les dommages: ";
CS_FRAME_TIME_LASTCRIT_TEXT = "Temps dernier critic: ";
CS_FRAME_TOTAL_TEXT = "Total: ";
CS_FRAME_DAMAGE_TEXT = "Dammages: ";
CS_FRAME_MINMAX_TEXT = "Min / Max: ";
CS_FRAME_AVGDMG_TEXT = "Dmgs Moyens: ";
CS_FRAME_PERCENTDMG_TEXT = "% de Dmgs.: ";

CS_DROPDOWN_SELECT_TEXT = "Choix de l\'Attaque";

CS_TT_OVERALLPCT_TEXT = "Pourcentage total de coups critiques.";
CS_TT_OVERALLDMGPCT_TEXT = "";--Percentage of the total damage done by all attacks that was done by this attack.";
CS_TT_NONCRIT_HITSPCT_TEXT = "";--Percent of this attacks hits that are non critical hits.";
CS_TT_CRIT_HITSPCT_TEXT = "";--Percent of this attacks hits that are critical hits.";
CS_TT_NONCRIT_DMGPCT_TEXT = "";--Percentage of this attacks damage that was from non critical hits.";
CS_TT_CRIT_DMGPCT_TEXT = "";--Percentage of this attacks damage that was from critical hits.";


RED_FONT_COLOR_CODE = "|cffff2020";
NORMAL_FONT_COLOR_CODE = "|cffffd200";
WHITE_FONT_COLOR_CODE = "|cffffffff";
GREEN_FONT_COLOR_CODE = "|cff20ff20";
BLUE_FONT_COLOR_CODE = "|cff2020ff";

DPS_DISPLAY = "%.2f";

CLOCK_TIME_DAY				= "%d jour";
CLOCK_TIME_HOUR				= "%d heure";
CLOCK_TIME_MINUTE			= "%d minute";
CLOCK_TIME_SECOND			= "%d seconde";

CS_1		= "Votre (.+) inflige (%d+) points de d\195\169g\195\162ts de (.+) \195\160 (.+)."; -- !
CS_2		= "Votre (.+) touche (.+) et inflige (%d+) points de d\195\169g\195\162ts.";
CS_3		= "Vous touchez (.+) et infligez (%d+) points de d\195\169g\195\162ts.";
CS_4		= "Votre (.+) touche (.+) avec un coup critique et inflige (%d+) points de d\195\169g\195\162ts.";
CS_5		= "Vous touchez (.+) avec un coup critique et infligez (%d+) points de d\195\169g\195\162ts.";
CS_6		= "Vous ratez (.+).";
CS_7		= "Vous attaquez, mais (.+) pare l\'attaque.";
CS_8		= "Vous attaquez et (.+) l\'\195\169vite.";
CS_9		= "Vous attaquez, mais (.+) esquive.";
CS_10		= "Vous attaquez et (.+) d\195\169vie le coup.";
CS_11		= "Vous attaquez, mais (.+) bloque l\'attaque.";
CS_12		= "Votre (.+) a \195\169t\195\169 bloqu\195\169 par (.+).";
CS_13		= ".+ d\195\169vie votre (.+).";
CS_14		= ".+ esquive votre (.+).";
CS_15		= ".+ \195\169vite votre (.+).";
CS_16		= ".+ pare votre (.+).";
CS_17		= "Vous utilisez (.+), mais (.+) r\195\169siste.";
CS_18		= "Votre (.+) rate. (.+) y est insensible.";
CS_19		= "Votre (.+) a rat\195\169 (.+).";
CS_20		= "(.+) touche (.+) avec un coup critique et inflige (%d+) points de d\195\169g\195\162ts.";
CS_21		= "(.+) touche (.+) et inflige (%d+) points de d\195\169g\195\162ts.";
CS_22		= "(.+) de (.+) touche (.+) pour (%d+) points de d\195\169g\195\162ts."; -- !
CS_23		= "(.+) utilise (.+) et touche (.+) avec un coup critique, infligeant (%d+) points de d\195\169g\195\162ts.";
CS_24		= "(.+) bloque (.+) de (.+).";
CS_25		= "(.+) esquive (.+) de (.+).";
CS_26		= "(.+) \195\169vite (.+) de (.+).";
CS_27		= "(.+) utilise (.+), mais (.+) est insensible.";
CS_28		= "(.+) utilise (.+), mais (.+) r\195\169siste.";
CS_29		= "(.+) de (.+) vous rate.";
CS_30		= "(.+) voit son (.+) manquer (.+).";
CS_31		= "(.+)'s (.+) failed. (.+) is immune."; -- not in the global strings !
CS_32		= "(.+) voit son (.+) manquer (.+).";
CS_33		= "(.+) d\195\169vie (.+) de (.+)";
CS_34		= "(.+) manque (.*).";
CS_35		= "(.+) attaque et (.+) pare son attaque.";
CS_36		= "(.+) attaque et (.+) \195\169vite le coup.";
CS_37		= "(.+) attaque et (.+) esquive.";
CS_38		= "(.+) attaque, mais (.+) d\195\169vie le coup.";
CS_39		= "(.+) attaque et (.+) bloque l\'attaque.";
CS_40		= "(.+) hits you for (%d+). (.+) blocked"; -- not in the global strings !
CS_41		= "(.+) vous touche et inflige (.+) points de d\195\169g\195\162ts.";
CS_42		= "(.+) vous touche avec un coup critique et inflige (%d+) points de d\195\169g\195\162ts.";
CS_43		= "(.+) de (.+) vous inflige (%d+) points de d\195\169g\195\162ts.";
CS_44		= "(.+) lance (.+) et vous inflige un coup critique %((%d+) points de d\195\169g\195\162t%).";
CS_45		= "(.+) utilise (.+), mais son adversaire bloque.";
CS_46		= "(.+) de (.+) : d\195\169vi\195\169%.";
CS_47		= "(.+) utilise (.+), mais son adversaire esquive%.";
CS_48		= "(.+) utilise (.+), mais son adversaire l\'\195\169vite%.";
CS_49		= "(.+) de (.+) \195\169choue. Vous \195\170tes insensible.";
CS_50		= "(.+)'s (.+) misses you.";
CS_51		= "You parry (.+)'s (.+)"; -- not in the global strings !
CS_52		= "(.+) utilise (.+), mais cela n\'a aucun effet%.";
CS_53		= "(.+) vous rate.";
CS_54		= "(.+) attaque, mais vous parez le coup.";
CS_55		= "(.+) attaque et vous l\'\195\169vitez.";
CS_56		= "(.+) attaque et vous esquivez.";
CS_57		= "(.+) attaque, mais vous d\195\169viez le coup.";
CS_58		= "(.+) attaque, mais vous bloquez le coup.";

end