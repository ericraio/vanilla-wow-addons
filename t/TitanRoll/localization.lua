
-- Last update: 30/03/2006


TITANROLL_NAME		= "TitanPanel[Roll]"
TITANROLL_VERSION 	= "0.44b"
TITANROLL_NAMEVERSION	= TITANROLL_NAME.." v"..TITANROLL_VERSION

TITANROLL_MAXTTLEN	= 27


-- Version: English
-- Last update: 07/02/2006

TITANROLL_MENUTEXT	= "Roll"
TITANROLL_LABELTEXT	= "Last roll: "
TITANROLL_LABELWINNER	= "Winner: "
TITANROLL_TOOLTIP	= "Latest rolls"
TITANROLL_NOROLL	= "No rolls yet!"
TITANROLL_TTALERT	= "One or more rolls aren't shown here!"
TITANROLL_HINT		= "Hint: Left-click to perform roll."

TITANROLL_OPTIONS	= "Options"

TITANROLL_TOGWINNER	= "Show winner on the bar";
TITANROLL_TOGREPLACE	= "Replace bad rolls when rerolled"
TITANROLL_TOGSORTLIST	= "Sort rolls by value"
TITANROLL_TOGHIGHLIGHT	= "Highlight group members rolls"
TITANROLL_ERASELIST	= "Erase list"

TITANROLL_PERFORMED	= "Change performed roll"
TITANROLL_CHANGELENGTH	= "Change list length"
TITANROLL_SETTIMEOUT	= "Set timeout"
TITANROLL_CURRENTACTION = "Current boundaries: "

TITANROLL_TIMEOUTS_TEXT = {
	"10 sec",
	"20 sec",
	"30 sec",
	"1 min",
	"2 min",
	"3 min",
	"None"
	}
TITANROLL_TOGERASETO	= "Erase timed out rolls from list"


TITANROLL_SEARCHPATTERN	= "(.+) rolls (%d+) %((%d+)%-(%d+)%)"

TITANROLL_TOGGOODWIN	= "Only accept 1-100 rolls as winner"
TITANROLL_TOGGROUPACC	= "Process group members rolls only"
TITANROLL_TOGIGNOREMUL	= "Ignore multirolls"
TITANROLL_TOGSHOWTIME	= "Show time passed since roll"
TITANROLL_ANNOUNCE	= "Change announcement text"
TITANROLL_CHATFORHELP	= "Look at the chatbox for help"

TITANROLL_ANNPATT	= "[Roll]: $aNo active rolls.$b$w won with a roll of $r. There were $n rolls.$c Invalid rolls were made by: $i"
TITANROLL_ANNHELP01	= "TitanPanel[Roll] announcement change..."
TITANROLL_ANNHELP02	= "Current announcement pattern:\n "
TITANROLL_ANNHELP03	= "Useable tags: "
TITANROLL_ANNHELP04	= " $a - following text displays when there's no active roll"
TITANROLL_ANNHELP05	= " $b - following text displays when there's at least one active roll. Use following tags here:"
TITANROLL_ANNHELP06	= "     $w - winners name "
TITANROLL_ANNHELP07	= "     $r - winners dice roll"
TITANROLL_ANNHELP08	= "	$l - a list of the rolls"
TITANROLL_ANNHELP09	= "     $n - number of total rolls"
TITANROLL_ANNHELP10	= " $c - following text displays when there's at least one invalid roll. Use the following tag here: "
TITANROLL_ANNHELP11	= "     $i - a list of players with invalid rolls"


if ( GetLocale() == "deDE" ) then

-- Version: Deutsch (German)
-- Last update: 21/6/2005
-- Thanks to Max Power for this!

TITANROLL_MENUTEXT = "W\195\188rfeln"
TITANROLL_LABELTEXT = "Letzter W\195\188rf: "
TITANROLL_LABELWINNER = "Sieger: "
TITANROLL_TOOLTIP = "Letzte W\195\188rfe"
TITANROLL_NOROLL = "Keine W\195\188rfe !"
TITANROLL_HINT = "Links klicken zum w\195\188rfeln"

TITANROLL_TOGWINNER = "Zeige Gewinner in der Leiste";
TITANROLL_TOGREPLACE = "Entferne schlechte W\195\188rfe"
TITANROLL_TOGSORTLIST = "W\195\188rfe nach h\195\182he sortieren"
TITANROLL_TOGHIGHLIGHT = "Highlight W\195\188rfe der Gruppenmitglieder"
TITANROLL_ERASELIST = "Liste l\195\182schen"

TITANROLL_PERFORMED = "W\195\188rfelbereich"
TITANROLL_CHANGELENGTH = "L\195\164nge der Liste"
TITANROLL_SETTIMEOUT = "Timeout einstellen"
TITANROLL_CURRENTACTION = "Momentane Grenze: "

TITANROLL_TIMEOUTS_TEXT = {
	"10 Sek",
	"20 Sek",
	"30 Sek",
	"1 Min",
	"2 Min",
	"3 Min",
	"Kein"
	}

TITANROLL_SEARCHPATTERN	= "(.+) w\195\188rfelt. Ergebnis: (%d+) %((%d+)%-(%d+)%)"

end


if ( GetLocale() == "frFR" ) then

-- Version: Francais (French)
-- Last update: 19/6/2005
-- Thanks to Toblerone and Sasmira for this!

TITANROLL_MENUTEXT = "Roll"
TITANROLL_LABELTEXT = "Dernier Roll : "
TITANROLL_LABELWINNER = "Gagnant : "
TITANROLL_TOOLTIP = "Les Derniers Rolls"
TITANROLL_NOROLL = "Aucun Roll Actuellement !"
TITANROLL_HINT = "Usage : Clic-Gauche pour Roll."

TITANROLL_TOGWINNER = "Voir le gagnant dans la barre";
TITANROLL_TOGREPLACE = "Remplacez les mauvais Rolls quand ils sont reroll\195\169s"
TITANROLL_TOGSORTLIST = "Trier les rolls par valeur"
TITANROLL_TOGHIGHLIGHT = "Highlight sur les membres du groupe rollants"
TITANROLL_ERASELIST = "R\195\169initialiser la liste"

TITANROLL_PERFORMED = "Changer la valeur du Roll"
TITANROLL_CHANGELENGTH = "Taille de la liste"
TITANROLL_SETTIMEOUT = "Selection de la Dur\195\169e"
TITANROLL_CURRENTACTION = "Limites courantes : "

TITANROLL_TIMEOUTS_TEXT = {
	"10 sec",
	"20 sec",
	"30 sec",
	"1 min",
	"2 min",
	"3 min",
	"Aucune"
	}

TITANROLL_SEARCHPATTERN = "(.+) obtient un (%d+) %((%d+)%-(%d+)%)"

end