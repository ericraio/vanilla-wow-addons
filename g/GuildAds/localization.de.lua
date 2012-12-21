-- German translation by Cloudernia of Alleria
-- Smilyman patch
-- 02/09/2005 : Poison
-- 02/09/2005 : Graurock 
-- 28/09/2005 : Add Zul'gurrub, Blackwing Lair, Arathi instance
-- 15/10/2005 : Replace "Ork" by "Orc"

if ( GetLocale() == "deDE" ) then

GUILDADS_TITLE = "GuildAds";

-- Minimap button
GUILDADS_BUTTON_TIP = "Klicken um Guildads zu \195\182ffnen.";

-- Config
GUILDADS_CHAT_OPTIONS = "Chat Optionen"; -- tt
GUILDADS_CHAT_USETHIS = "Benutze diesen Kanal :"; -- this
GUILDADS_CHAT_CHANNEL = "Name";
GUILDADS_CHAT_PASSWORD = "Passwort"; --this
GUILDADS_CHAT_COMMAND = "Slash Befehl"; -- tt
GUILDADS_CHAT_ALIAS = "Kanal Alias"; -- tt
GUILDADS_CHAT_SHOW_NEWEVENT = "Zeige Aktualisierungen bei 'Event'"; -- tt
GUILDADS_CHAT_SHOW_NEWASK = "Zeige Aktualisierungen bei 'Anfrage'"; -- tt
GUILDADS_CHAT_SHOW_NEWHAVE = "Zeige Aktualisierungen bei 'Angebote'"; -- tt
GUILDADS_ADS_OPTIONS = "Ads Optionen"; -- tt
GUILDADS_PUBLISH = "Ver\195\182ffentliche meine Anzeigen";
GUILDADS_VIEWMYADS = "Zeige eigene Anzeigen";
GUILDADS_ICON_OPTIONS = "Minikartensymbol Optionen"; -- tt
GUILDADS_ICON = "Minikartensymbol";
GUILDADS_ADJUST_ANGLE = "Winkel anpassen";
GUILDADS_ADJUST_RADIUS = "Radius anpassen";

-- Main frame
GUILDADS_MYADS = "Meine Anfragen";
GUILDADS_BUTTON_ADDREQUEST = "Anfragen";
GUILDADS_BUTTON_ADDAVAILABLE = "Angebote";
GUILDADS_BUTTON_ADDEVENT = "Teilnehmen";
GUILDADS_BUTTON_REMOVE = REMOVE;
GUILDADS_QUANTITY = "Anzahl";
GUILDADS_SINCE = "Seit %s";
GUILDADS_ACCOUNT_NA = "Informationen nicht verf\195\188gbar"; -- tt
GUILDADS_GROUPBYACCOUNT = "Nach Accounts gruppieren"; -- tt

-- Column headers
GUILDADS_HEADER_REQUEST = "Anfragen";
GUILDADS_HEADER_AVAILABLE = "Angebote";
GUILDADS_HEADER_INVENTORY = INSPECT;
GUILDADS_HEADER_SKILL = SKILLS;
GUILDADS_HEADER_ANNONCE = GUILD;
GUILDADS_HEADER_EVENT = "Events";
-- fertig/completed

GUILDADS_RACES = {
	[1] = "Mensch",
	[2] = "Zwerg",
	[3] = "Nachtelf",
	[4] = "Gnom",
	[5] = "Orc",
	[6] = "Untoter",
	[7] = "Tauren",
	[8] = "Troll"
};

GUILDADS_CLASSES = {
	[1] = "Krieger",
	[2] = "Schamane",
	[3] = "Paladin",
	[4] = "Druide",
	[5] = "Schurke",
	[6] = "J\195\164ger",
	[7] = "Hexenmeister",
	[8] = "Magier",
	[9] = "Priester"
};

GUILDADS_ITEMS = {
	everything = "Alles",
	everythingelse = "Alles andere",
	monster = "Monster drops",
	classReagent = "Klassen Reagenzien",
	tradeReagent = "Handelsfertigkeitsreagenz",
	vendor = "H\195\164ndler",
	trade = "Herstellbar",
	gather = "Sammelbar",
};

GUILDADS_ITEMS_SIMPLE = {
	everything = "Alles"
};

-- Skill
GUILDADS_SKILLS = {
	[1] = "Kr\195\164uterkunde",
	[2] = "Bergbau",
	[3] = "K\195\188rschnerei",
	[4] = "Alchimie",
	[5] = "Schmiedekunst",
	[6] = "Ingenieurskunst",
	[7] = "Lederverarbeitung",
	[8] = "Schneiderei",
	[9] = "Verzauberkunst",
	[10] = "Angeln",
	[11] = "Erste Hilfe",
	[12] = "Kochkunst",
	[13] = "Schlossknacken",
	-- [14] = "Gifte",

	[20] = "Faustwaffen",
	[21] = "Dolche",
	[22] = "Schwerter",
	[23] = "Zweihandschwerter",
	[24] = "Streitkolben",
	[25] = "Zweihandstreitkolben",
	[26] = "\195\132xte",
	[27] = "Zweihand\195\164xte",
	[28] = "Stangenwaffen",
	[29] = "St\195\164be",
	[30] = "Wurfwaffen",
	[31] = "Schusswaffen",
	[32] = "B\195\182gen",
	[33] = "Armbr\195\188ste",
	[34] = "Zauberst\195\164be"
};

-- Equipment
GUILDADS_EQUIPMENT = "Ausr\195\188stung";

-- Tooltip requests
GUILDADS_ASKTOOLTIP = "Anfragen: %i";
--
GUILDADS_EVENTS_TITLE = "Instanzen";
GUILDADS_EVENTS = {
	"Burg Shadowfang",
	"Das Scharlachrotes Kloster",
	"Der geschmolzene Kern",
	"Der Kraal von Razorfen ",
	"Der Ragefire Abgrund",
	"Der Versunkene Tempel",
	"Die Blackfeathom Tiefen",
	"Die Todesminen",
	"Die Blackrock Tiefen",
	"Die H\195\182hlen des Wehklagens",
	"Die H\195\188gel von Razorfen",
	"Die Obere Blackrock Spitze",
	"Die Untere Blackrock Spitze",
	"Die Scholomance",
	"D\195\188sterbruch",
	"Gnomeregan",
	"Maraudon",
	"Onyxias Hort",
	"Stratholme",
	"Uldaman",
	"Zul'Gurub",
	"Pechschwingenhort",
	"Zul'Farrak",
	"PvP Alteractal",
	"PvP Arathibecken",
	"PvP Warsongschlucht"
};

-- GuildAds
GUILDADS_TS_LINK = GUILDADS_TITLE;
GUILDADS_TS_ASKITEMS = "Nachfrage nach %i %s";
GUILDADS_TS_ASKITEMS_TT = "\195\132ndere die Objektanzahl um die Anzahl zu \195\164ndern.";

-- Binding
BINDING_HEADER_GUILDADS = GUILDADS_TITLE;
BINDING_NAME_SHOW = "GuildAds anzeigen";
BINDING_NAME_SHOW_CONFIG = "GuildAds Konfiguration anzeigen"

end
