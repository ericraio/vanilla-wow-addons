
--[[

-- Deutsch (German "deDE")
-- Lokalisierung (http://www.atlasmod.com/phpBB2/viewforum.php?f=6)
-- Für Tipps zu falschen oder fehlenden Namen sowie Anregungen zur Optimierung
-- bitte im Forum oder per icq benachrichtigen! DANKE!
-- Lokalisation: Nihlo (icq: 260-869-930) und noch unzählige andere...Vielen Dank!
--
-- \195\134 Ä
-- \195\150 Ö
-- \195\156 Ü
-- \195\159 ß
-- \195\164 ä
-- \195\182 ö
-- \195\188 ü
--
-- Letztes Update: 08/10/2006


--]]







if ( GetLocale() == "deDE" ) then





AtlasSortIgnore = {
"der (.+)", "die (.+)", "das (.+)"
}




ATLAS_TITLE = "Atlas";
ATLAS_SUBTITLE = "Instanzkarten";
ATLAS_DESC = "Atlas ist ein Instanzkarten-Browser";

ATLAS_OPTIONS_BUTTON = "Optionen";

BINDING_HEADER_ATLAS_TITLE = "Atlas Tastaturbelegungen";
BINDING_NAME_ATLAS_TOGGLE = "Atlas an/aus";
BINDING_NAME_ATLAS_OPTIONS = "Optionen an/aus";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "Optionen";

ATLAS_STRING_LOCATION = "Region";
ATLAS_STRING_LEVELRANGE = "Levelbereich";
ATLAS_STRING_PLAYERLIMIT = "Max. Spielerzahl";
ATLAS_STRING_SELECT_CAT = "Kategorie w\195\164hlen";
ATLAS_STRING_SELECT_MAP = "Karte w\195\164hlen";

ATLAS_BUTTON_TOOLTIP = "Atlas an/aus";
ATLAS_BUTTON_TOOLTIP2 = "Linksklick um Atlas zu \195\182ffnen.";
ATLAS_BUTTON_TOOLTIP3 = "Rechtsklick halten um diesen Button zu verschieben.";

ATLAS_OPTIONS_TITLE = "Atlas Optionen";
ATLAS_OPTIONS_SHOWBUT = "Zeige Minimap-Schalter";
ATLAS_OPTIONS_AUTOSEL = "Automatische Auswahl";
ATLAS_OPTIONS_BUTPOS = "Schalterposition";
ATLAS_OPTIONS_TRANS = "Transparenz";
ATLAS_OPTIONS_DONE = "Fertig";
ATLAS_OPTIONS_REPMAP = "Ersetze Weltkarte";
ATLAS_OPTIONS_RCLICK = "Rechtsklick f\195\188r Weltkarte";
ATLAS_OPTIONS_SHOWMAPNAME = "Zeige Kartenname";
ATLAS_OPTIONS_RESETPOS = "Position zur\195\188cksetzen";
ATLAS_OPTIONS_ACRONYMS = "Zeige Abk\195\188rzungen";

ATLAS_HINT = "Tipp: Linksklick um Atlas zu \195\182ffnen.";


AtlasZoneSubstitutions = {
   ["Der Tempel von Atal'Hakkar"]    = "Der versunkene Tempel";
   ["Blackrockspitze"] = "Blackrockspitze (oben)";
   ["D\195\188sterbruch"] = "D\195\188sterbruch (Nord)";
   ["Ahn'Qiraj"]               = "Tempel von Ahn'Qiraj";
}; 


local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = " ";

--Dient zur übersichtlicheren Verwaltung der verschiedenen Kartenkategorien
Atlas_MapTypes = {"Instanzkarten", "Schlachtfeldkarten", "Flugkarten", "Dungeon Standorte", "Schlachtzugbosse"};

AtlasText = {
BlackfathomDeeps = {
ZoneName = "Blackfathom-Tiefen";
Acronym = "BFT";
Location = "Ashenvale";
LevelRange = "20-27";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) Ghamoo-ra";
GREY.."2) Lorgalis Manuskript";
GREY.."3) Lady Sarevess";
GREY.."4) Argentumwache Thaelrid";
GREY.."5) Gelihast";
GREY.."6) Lorgus Jett (variiert)";
GREY.."7) Baron Aquanis,";
GREY..INDENT.."Fathomkern";
GREY.."8) Twilight-Lord Kelris";
GREY.."9) Old Serra'kis";
GREY.."10) Aku'mai";
};
BlackrockDepths = {
ZoneName = "Blackrocktiefen";
Acronym = "BRT";
Location = "Blackrock";
LevelRange = "48-56";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) Lord Roccor";
GREY.."2) Kharan Mighthammer";
GREY.."3) Kommandant Gor'shak";
GREY.."4) Marshal Windsor";
GREY.."5) Verh\195\182rmeisterin Gerstahn";
GREY.."6) Ring des Gesetzes, Theldren";
GREY.."7) Mon. von Franclorn Forgewright,";
GREY..INDENT.."Pyromant Loregrain (rar)";
GREY.."8) Das schwarze Gew\195\182lbe,";
GREY..INDENT.."W\195\164rter Stilgiss, Verek";
GREY.."9) Fineous Darkvire";
GREY.."10) Der schwarze Amboss,";
GREY..INDENT.."Lord Incendius";
GREY.."11) Bael'Gar";
GREY.."12) Shadowforge-Schloss";
GREY.."13) General Zornesschmied";
GREY.."14) Golemlord Argelmach";
GREY.."15) The Grim Guzzler";
GREY.."16) Botschafter Flammenschlag";
GREY.."17) Panzor der Unbesiegbare (rar)";
GREY.."18) Grabmal der Boten";
GREY.."19) Das Lyzeum";
GREY.."20) Magmus";
GREY.."21) Imperator Dagran Thaurissan,";
GREY..INDENT.."Prinzessin Moira Bronzebeard";
GREY.."22) Die schwarze Schmiede";
GREY.."23) Der geschmolzene Kern";
};
BlackrockSpireLower = {
ZoneName = "Blackrockspitze (unten)";
Acronym = "LBRS";
Location = "Blackrock";
LevelRange = "53-60";
PlayerLimit = "15";
BLUE.."A) Eingang";
GREY.."1) Warosh";
GREY.."2) Beschlagene Pike";
GREY.."3) Hochlord Omokk";
GREY..INDENT.."Kampflord der Felsspitzoger (rar)";
GREY.."4) Schattenj\195\164gerin Vosh'gajin";
GREY..INDENT.."F\195\188nfte Mosh'aru-Schrifttafel";
GREY.."5) Kriegsmeister Voone";
GREY..INDENT.."Sechste Mosh'aru-Schrifttafel";
GREY..INDENT.."Mor Grayhoof";
GREY.."6) Mutter Glimmernetz";
GREY.."7) Kristallfangzahn (rar)";
GREY.."8) Urok Schreckensbote";
GREY.."9) Quartiermeister Zigris";
GREY.."10) Halycon";
GREY..INDENT.."Gizrul der Geifernde";
GREY.."11) Hochlord Wyrmthalak";
GREY.."12) Bannok Grimaxe (rar)";
GREY.."13) Metzger der Felsspitzoger (rar)";
};
BlackrockSpireUpper = {
ZoneName = "Blackrockspitze (oben)";
Acronym = "UBRS";
Location = "Blackrock";
LevelRange = "53-60";
PlayerLimit = "15";
BLUE.."A) Eingang";
GREY.."1) Feuerwache Glutseher";
GREY.."2) Solakar Feuerkrone,";
GREY.."3) Jed Runewatcher (rar)";
GREY..INDENT.."Vater Flamme";
GREY.."4) Goraluk Anvilcrack";
GREY.."5) Kriegsh\195\164uptling Rend Blackhand,";
GREY..INDENT.."Gyth";
GREY.."6) Awbee";
GREY.."7) Die Bestie";
GREY..INDENT.."Lord Valthalak";
GREY.."8) General Drakkisath";
GREY..INDENT.."Doomriggers Schnalle";
GREY.."9) Pechschwingenhort";
};
BlackwingLair = {
ZoneName = "Pechschwingenhort";
Acronym = "BWL";
Location = "Blackrockspitze";
LevelRange = "60+";
PlayerLimit = "40";
BLUE.."A) Eingang";
BLUE.."B) Pfad";
BLUE.."C) Pfad";
GREY.."1) Razorgore der Ungez\195\164hmte";
GREY.."2) Vaelastrasz der Verdorbene";
GREY.."3) Brutw\195\164chter Dreschbringer";
GREY.."4) Feuerschwinge";
GREY.."5) Schattenschwinge";
GREY.."6) Flammenmaul";
GREY.."7) Chromaggus";
GREY.."8) Nefarian";
GREY.."9) Meisterelementarformer Krixix";
};
DireMaulEast = {
ZoneName = "D\195\188sterbruch (Ost)";
Acronym = "DB"; 
Location = "Feralas";
LevelRange = "56-60";
PlayerLimit = "5";
BLUE.."A) Eingang";
BLUE.."B) Eingang";
BLUE.."C) Eingang";
BLUE.."D) Ausgang";
GREY.."1) Pusillins Jagd beginnt";
GREY.."2) Pusillins Jagd endet";
GREY.."3) Zevrim Dornhuf,";
GREY..INDENT.."Lethtendris,";
GREY..INDENT.."Hydrobrut";
GREY.."4) Eisenborke der Gro\195\159e";
GREY.."5) Alzzin der Wildformer";
GREY..INDENT.."Isalien";
};
DireMaulNorth = {
ZoneName = "D\195\188sterbruch (Nord)";
Acronym = "DB";
Location = "Feralas";
LevelRange = "56-60";
PlayerLimit = "5";
BLUE.."A) Eingang";
GREY.."1) Wache Mol'dar";
GREY.."2) Stampfer Kreeg";
GREY.."3) Wache Fengus";
GREY.."4) Knot Thimblejack,";
GREY..INDENT.."Wache Slip'kik";
GREY.."5) Captain Kromcrush";
GREY.."6) K\195\182nig Gordok";
GREY.."7) D\195\188sterbruch (West)";
};
DireMaulWest = {
ZoneName = "D\195\188sterbruch (West)";
Acronym = "DB";
Location = "Feralas";
LevelRange = "56-60";
PlayerLimit = "5";
BLUE.."A) Eingang";
BLUE.."B) Pylonen";
GREY.."1) Shen'dralar Uralter";
GREY.."2) Tendris Wucherborke";
GREY.."3) Illyanna Rabeneiche";
GREY.."4) Magister Kalendris";
GREY.."5) Tsu'zee (rar)";
GREY.."6) Immol'thar";
GREY..INDENT.."Lord Hel'nurath";
GREY.."7) Prinz Tortheldrin";
GREY.."8) D\195\188sterbruch (Nord)";
};
Gnomeregan = {
ZoneName = "Gnomeregan";
Acronym = "Gnome";
Location = "Dun Morogh";
LevelRange = "24-33";
PlayerLimit = "10";
BLUE.."A) Eingang (Vorne)";
BLUE.."B) Eingang (Hinten)";
GREY.."1) Z\195\164hfl\195\188ssiger Niederschlag";
GREY.."2) Grubbis";
GREY.."3) Lochkarten-Automat 3005-B";
GREY.."4) Die saubere Zone";
GREY.."5) Electrocutioner 6000,";
GREY..INDENT.."Lochkarten-Automat 3005-C";
GREY.."6) Robogenieur Thermaplugg";
GREY.."7) Botschafter der Dunkeleisenzwerge (rar)";
GREY.."8) Meute Verpr\195\188geler 9-60,";
GREY..INDENT.."Lochkarten-Automat 3005-D";
};
Maraudon = {
ZoneName = "Maraudon";
Acronym = "Mauro";
Location = "Desolace";
LevelRange = "40-49";
PlayerLimit = "10";
BLUE.."A) Eingang (Orange)";
BLUE.."B) Eingang (Lila)";
BLUE.."C) Eingang (Portal)";
GREY.."1) Veng (Der f\195\188nfte Khan)";
GREY.."2) Noxxion";
GREY.."3) Schlingwurzler";
GREY.."4) Maraudos (Der vierte Khan)";
GREY.."5) Lord Schlangenzunge";
GREY.."6) Meshlok der Ernter (rar)";
GREY.."7) Celebras der Verbannte";
GREY.."8) Erdrutsch";
GREY.."9) T\195\188ftler Gizlock";
GREY.."10) Faulschnapper";
GREY.."11) Prinzessin Theradras";
};
MoltenCore = {
ZoneName = "Geschmolzener Kern";
Acronym = "MC";
Location = "Blackrocktiefen";
LevelRange = "60+";
PlayerLimit = "40";
BLUE.."A) Eingang";
GREY.."1) Lucifron";
GREY.."2) Magmadar";
GREY.."3) Gehennas";
GREY.."4) Garr";
GREY.."5) Shazzrah";
GREY.."6) Baron Geddon";
GREY.."7) Golemagg der Verbrenner";
GREY.."8) Sulfuronherold";
GREY.."9) Majordomus Executus";
GREY.."10) Ragnaros";
};
Naxxramas = {
ZoneName = "Naxxramas";
Acronym = "NAXX"; 
Location = "Stratholme/\195\150stliche Pestl\195\164nder";
LevelRange = "60+";
PlayerLimit = "40";
BLUE.."Monstr\195\182sit\195\164tenfl\195\188gel";
BLUE..INDENT.."1) Flickwerk";
BLUE..INDENT.."2) Grobbulus";
BLUE..INDENT.."3) Gluth";
BLUE..INDENT.."4) Thaddius";
ORNG.."Spinnenfl\195\188gel";
ORNG..INDENT.."1) Anub'Rekhan";
ORNG..INDENT.."2) Gro\195\159witwe Faerlina";
ORNG..INDENT.."3) Maexxna";
_RED.."Todesritterfl\195\188gel";
_RED..INDENT.."1) Instrukteur Razuvious";
_RED..INDENT.."2) Gothik der Seelenj\195\164ger";
_RED..INDENT.."3) Die vier Ritter";
_RED..INDENT..INDENT.."Thane Korth'azz";
_RED..INDENT..INDENT.."Lady Blaumeux";
_RED..INDENT..INDENT.."Hochlord Mograine";
_RED..INDENT..INDENT.."Sir Zeliek";
PURP.."Seuchenfl\195\188gel";
PURP..INDENT.."1) Noth der Seuchenf\195\188rst";
PURP..INDENT.."2) Heigan der Unreine";
PURP..INDENT.."3) Loatheb";
GREN.."Frostwyrm Lair";
GREN..INDENT.."1) Sapphiron";
GREN..INDENT.."2) Kel'Thuzad";
};
OnyxiasLair = {
ZoneName = "Onyxias Hort";
Acronym = "ONY";
Location = "Marschen von Dustwallow";
LevelRange = "60+";
PlayerLimit = "40";
BLUE.."A) Eingang";
GREY.."1) Onyxias Wachen";
GREY.."2) Welpeneier";
GREY.."3) Onyxia";
};
RagefireChasm = {
ZoneName = "Ragefireabgrund";
Acronym = "RF";
Location = "Orgrimmar";
LevelRange = "13-15";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) Maur Grimtotem";
GREY.."2) Taragaman der Hungerleider";
GREY.."3) Jergosh der Herbeirufer";
GREY.."4) Bazzalan";
};
RazorfenDowns = {
ZoneName = "Die H\195\188gel von Razorfen";
Acronym = "HvR";
Location = "Brachland";
LevelRange = "35-40";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) Tuten'kash";
GREY.."2) Henry Stern";
GREY..INDENT.."Belnistrasz";
GREY.."3) Mordresh Feuerauge";
GREY.."4) Nimmersatt";
GREY.."5) Struppm\195\164hne (rar)";
GREY.."6) Amnennar der K\195\164ltebringer";
};
RazorfenKraul = {
ZoneName = "Der Kral von Razorfen";
Acronym = "KvR";
Location = "Brachland";
LevelRange = "25-35";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) Roogug";
GREY.."2) Aggem Thorncurse";
GREY.."3) Todessprecher Jargba";
GREY.."4) Oberanf\195\188hrer Rammhauer";
GREY.."5) Agathelos der Tobende";
GREY.."6) Blinder J\195\164ger (rar)";
GREY.."7) Charlga Razorflank";
GREY.."8) Willix der Importeur,";
GREY..INDENT.."Heralath Fallowbrook";
GREY.."9) Erdenrufer Halmgar (rar)";
};
ScarletMonastery = {
ZoneName = "Das scharlachrote Kloster";
Acronym = "SM";
Location = "Tirisfal";
LevelRange = "30-40";
PlayerLimit = "10";
BLUE.."A) Eingang (Bibliothek)";
BLUE.."B) Eingang (Waffenkammer)";
BLUE.."C) Eingang (Kathedrale)";
BLUE.."D) Eingang (Friedhof)";
GREY.."1) Hundemeister Loksey";
GREY.."2) Arkanist Doan";
GREY.."3) Herod";
GREY.."4) Hochinquisitor Fairbanks";
GREY.."5) Scharlachroter Kommandant";
GREY..INDENT.."Mograine,";
GREY..INDENT.."Hochinquisitor Whitemane";
GREY.."6) Eisenstachel (rar)";
GREY.."7) Azshir der Schlaflose (rar)";
GREY.."8) Gefallener Held (rar)";
GREY.."9) Blutmagier Thalnos";
};
Scholomance = {
ZoneName = "Scholomance";
Acronym = "Scholo";
Location = "Die westlichen Pestl\195\164nder";
LevelRange = "56-60";
PlayerLimit = "10";
BLUE.."A) Eingang";
BLUE.."B) Treppen";
BLUE.."C) Treppen";
GREY.."1) Blutschale von Kirtonos,";
GREY..INDENT.."Besitzurkunde f\195\188r Southshore";
GREY.."2) Kirtonos der Herold";
GREY.."3) Jandice Barov";
GREY.."4) Besitzurkunde f\195\188r Tarrens M\195\188hle";
GREY.."5) Blutrippe (unten)";
GREY..INDENT.."Todesritter Schattensichel";
GREY.."6) Marduk Blackpool,";
GREY..INDENT.."Vectus";
GREY.."7) Ras Frostraunen,";
GREY..INDENT.."Besitzurkunde f\195\188r Brill";
GREY..INDENT.."Kormok";
GREY.."8) Instrukteurin Malicia";
GREY.."9) Doktor Theolen Krastinov";
GREY.."10) H\195\188ter des Wissens Polkelt";
GREY.."11) Der Ravenier";
GREY.."12) Lord Alexei Barov,";
GREY..INDENT.."Besitzurkunde f\195\188r Caer Darrow";
GREY.."13) Lady Illucia Barov";
GREY.."14) Dunkelmeister Gandling";
GREN.."1') Kerzenhebel";
GREN.."2') Geheime Truhe";
GREN.."3') Alchimielabor";
};
ShadowfangKeep = {
ZoneName = "Burg Shadowfang";
Acronym = "BSF";
Location = "Silberwald";
LevelRange = "18-25";
PlayerLimit = "10";
BLUE.."A) Eingang";
BLUE.."B) Gang";
BLUE.."C) Gang,";
BLUE..INDENT.."Todesh\195\182riger Captain (rar)";
GREY.."1) Todespirscher Adamant,";
GREY..INDENT.."Zauberhexer Ashcrombe,";
GREY..INDENT.."Rethilgore";
GREY.."2) Klingenklaue der Metzger";
GREY.."3) Baron Silverlaine";
GREY.."4) Kommandant Springvale";
GREY.."5) Odo der Blindseher";
GREY.."6) Fenrus der Verschlinger";
GREY.."7) Wolfmeister Nandos";
GREY.."8) Erzmagier Arugal";
};
Stratholme = {
ZoneName = "Stratholme";
Acronym = "Strat";
Location = "Die \195\182stlichen Pestl\195\164nder";
LevelRange = "55-60";
PlayerLimit = "10";
BLUE.."A) Haupteingang";
BLUE.."B) Dienstboteneingang";
GREY.."1) Skul (rar, wandert)";
GREY..INDENT.."Fras Siabi";
GREY..INDENT.."Kurier von Stratholme";
GREY.."2) Herdsinger Forresten";
GREY..INDENT.."(rar, variiert)";
GREY.."3) Der Unverziehene";
GREY.."4) Timmy der Grausame";
GREY.."5) Kanonenmeister Willey";
GREY.."6) Archivar Galford";
GREY.."7) Balnazzar";
GREY..INDENT.."Sothos, Jarien";
GREY.."8) Aurius";
GREY.."9) Steinbuckel (rar)";
GREY.."10) Baroness Anastari";
GREY.."11) Nerub'enkan";
GREY.."12) Maleki der Leichenblasse";
GREY.."13) Magistrat Barthilas (variiert)";
GREY.."14) Ramstein der Verschlinger";
GREY.."15) Baron Rivendare";
GREN.."1') Kreuzz\195\188glerplatz Briefkasten";
GREN.."2') Marktgasse Briefkasten";
GREN.."3') Feststra\195\159e Briefkasten";
GREN.."4') \195\132ltestenplatz Briefkasten";
GREN.."5') K\195\182nigsplatz Briefkasten";
GREN.."6') Fras Siabis Briefkasten";
};
TheDeadmines = {
ZoneName = "Die Todesminen";
Acronym = "DM";
Location = "Westfall";
LevelRange = "15-20";
PlayerLimit = "10";
BLUE.."A) Eingang";
BLUE.."B) Ausgang";
GREY.."1) Rhahk'Zor";
GREY.."2) Minenarbeiter Johnson (rar)";
GREY.."3) Sneed";
GREY.."4) Gilnid";
GREY.."5) Defias Gunpowder";
GREY.."6) Captain Greenskin,";
GREY..INDENT.."Edwin van Cleef,";
GREY..INDENT.."Mr. Smite,";
GREY..INDENT.."Cookie";
};
TheStockade = {
ZoneName = "Das Verlies";
Location = "Stormwind";
LevelRange = "23-26";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) Targorr der Schreckliche";
GREY..INDENT.."(variiert)";
GREY.."2) Kam Deepfury";
GREY.."3) Hamhock";
GREY.."4) Bazil Thredd";
GREY.."5) Dextren Ward";
GREY.."6) Bruegal Eisenfaust (rar)";
};
TheSunkenTemple = {
ZoneName = "Der versunkene Tempel";
Acronym = "ST";
Location = "S\195\188mpfe des Elends";
LevelRange = "44-50";
PlayerLimit = "10";
BLUE.."A) Eingang";
BLUE.."B) Treppen";
BLUE.."C) Troll Minibosse (oben)";
GREY.."1) Altar von Hakkar,";
GREY..INDENT.."Atal'alarion";
GREY.."2) Wirker,";
GREY..INDENT.."Traumsense";
GREY.."3) Avatar von Hakkar";
GREY.."4) Jammal'an der Prophet,";
GREY..INDENT.."Ogom der Elende";
GREY.."5) Morphaz,";
GREY..INDENT.."Hazzas";
GREY.."6) Eranikus' Schemen,";
GREY..INDENT.."Essenzen Schriftsatz";
GREN.."1'-6') Statuen Aktivierungs-";
GREN..INDENT.."reihenfolge";
};
Uldaman = {
ZoneName = "Uldaman";
Acronym = "Ulda";
Location = "Das \195\150dland";
LevelRange = "35-45";
PlayerLimit = "10";
BLUE.."A) Eingang (Vorne)";
BLUE.."B) Eingang (Hinten)";
GREY.."1) Baelog";
GREY.."2) \195\156berreste eines Paladins";
GREY.."3) Revelosh";
GREY.."4) Ironaya";
GREY.."5) Obsidian-Schildwache";
GREY.."6) Annora (Verzauberungsmeister)";
GREY.."7) Uralter Steinbewahrer";
GREY.."8) Galgann Firehammer";
GREY.."9) Grimlok";
GREY.."10) Archaedas (Unten)";
GREY.."11) Die Scheiben von Norgannon";
GREY..INDENT.."Antiker Schatz (Unten)";
};
WailingCaverns = {
ZoneName = "Die H\195\182hlen des Wehklagens";
Acronym = "HdW";
Location = "Brachland";
LevelRange = "15-21";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) J\195\188nger von Naralex";
GREY.."2) Lord Kobrahn";
GREY.."3) Lady Anacondra";
GREY.."4) Kresh";
GREY.."5) Lord Pythas";
GREY.."6) Skum";
GREY.."7) Lord Serpentis (oben)";
GREY.."8) Verdan der Ewiglebende (oben)";
GREY.."9) Mutanus der Verschlinger,";
GREY..INDENT.."Naralex";
GREY.."10) Deviatfeendrache (rar)";
};
ZulFarrak = {
ZoneName = "Zul'Farrak";
Acronym = "ZF";
Location = "Tanaris";
LevelRange = "43-47";
PlayerLimit = "10";
BLUE.."A) Eingang";
GREY.."1) Antu'sul";
GREY.."2) Theka der M\195\164rtyrer";
GREY.."3) Hexendoktor Zum'rah";
GREY..INDENT.."Toter Zul'Farrak-Held";
GREY.."4) Nekrum der Ausweider";
GREY..INDENT.."Schattenpriester Sezz'ziz";
GREY.."5) Sergeant Bly";
GREY.."6) Wasserbeschw\195\182rerin Velratha,";
GREY..INDENT.."Gahz'rilla";
GREY..INDENT.."Dustwraith (rar)";
GREY.."7) H\195\164uptling Ukorz Sandscalp";
GREY..INDENT.."Ruuzlu";
GREY.."8) Zerillis (rar, Wandert)";
GREY.."9) Sandarr Dunereaver (rar)";
};
ZulGurub = {
ZoneName = "Zul'Gurub";
Acronym = "ZG";
Location = "Schlingendorntal";
LevelRange = "60+";
PlayerLimit = "20";
BLUE.."A) Eingang";
GREY.."1) Hohepriesterin Jeklik";
GREY.."2) Hohepriester Venoxis";
GREY.."3) Hohepriesterin Mar'li";
GREY.."4) Blutlord Mandokir";
GREY.."5) Rand des Wahnsinns,";
GREY..INDENT.."Gri'lek,";
GREY..INDENT.."Hazza'rah,";
GREY..INDENT.."Renataki,";
GREY..INDENT.."Wushoolay";
GREY.."6) Gahz'ranka";
GREY.."7) Hohepriester Thekal";
GREY.."8) Hohepriesterin Arlokk";
GREY.."9) Jin'do der Hexer";
GREY.."10) Hakkar";
GREN.."1') Schlammiges aufgew\195\188hltes Gew\195\164sser";
};
TheTempleofAhnQiraj = {
ZoneName = "Tempel von Ahn'Qiraj";
Acronym = "AQ40";
Location = "Silithus";
LevelRange = "60+";
PlayerLimit = "40";
BLUE.."A) Eingang";
GREY.."1) Der Prophet Skeram (Drau\195\159en)";
GREY.."2) Vem & Co (Optional)";
GREY.."3) Schlachtwache Satura";
GREY.."4) Fankriss der Unnachgiebige";
GREY.."5) Viscidus (Optional)";
GREY.."6) Prinzessin Huhuran";
GREY.."7) Die Zwillingsimperatoren";
GREY.."8) Ouro (Optional)";
GREY.."9) Auge von C'Thun";
GREN.."1') Andorgos";
GREN..INDENT.."Vethsera";
GREN..INDENT.."Kandrostrasz";
GREN.."2') Arygos";
GREN..INDENT.."Caelestrasz";
GREN..INDENT.."Merithra des Traums";
};
TheRuinsofAhnQiraj = {
ZoneName = "Ruinen von Ahn'Qiraj";
Acronym = "AQ20";
Location = "Silithus";
LevelRange = "60+";
PlayerLimit = "20";
BLUE.."A) Eingang";
GREY.."1) Kurinnaxx";
GREY..INDENT.."Generallieutenant Andorov";
GREY..INDENT.."Vier Kaldorei Elite";
GREY.."2) General Rajaxx";
GREY..INDENT.."Captain Qeez";
GREY..INDENT.."Captain Tuubid";
GREY..INDENT.."Captain Drenn";
GREY..INDENT.."Captain Xurrem";
GREY..INDENT.."Major Yeggeth";
GREY..INDENT.."Major Pakkon";
GREY..INDENT.."Colonel Zerran";
GREY.."3) Moam (Optional)";
GREY.."4) Buru der Verschlinger (Optional)";
GREY.."5) Ayamiss der J\195\164ger (Optional)";
GREY.."6) Ossirian der Narbenlose";
GREN.."1') Sicherer Raum";
};                   
};


AtlasBG = {
AlteracValleyNorth = {
ZoneName = "Alteractal (Norden)";
Acronym = "AV";
Location = "Vorgebirge von Hillsbrad";
BLUE.."A) Eingang";
BLUE.."B) Dun Baldar (Allianz)";
_RED.."1) Stormpike-Lazarett";
_RED.."2) Stormpike-Friedhof";
_RED.."3) Stonehearth-Friedhof";
_RED.."4) Snowfall-Friedhof";
ORNG.."5) Nordbunker von Dun Baldar";
GREY..INDENT.."Schwadronskommandant Mulverick (Horde)";
ORNG.."6) S\195\188dbunker von Dun Baldar";
ORNG.."7) Icewing-Bunker";
GREY..INDENT.."Schwadronskommandant Guse (Horde)";
GREY..INDENT.."Kommandant Karl Philips (Allianz)";
ORNG.."8) Stonehearth-Au\195\159enposten (Balinda)";
ORNG.."9) Stonehearth-Bunker";
GREY.."10) Irondeep-Mine";
GREY.."11) Icewingh\195\182hle";
GREY.."12) Dampfs\195\164ge (Horde)";
GREY.."13) Schwadronskommandant Jeztor (Horde)";
GREY.."14) Ivus der Waldf\195\188rst (Beschw\195\182rungszone)";
"";
"";
"";
"";
"";
_RED.."Red:"..BLUE.." Friedh\195\182fe, Einnehmbare Gebiete";
ORNG.."Orange:"..BLUE.." Bunker, T\195\188rme, Zerst\195\182rbare Gebiete";
GREY.."Wei\195\159:"..BLUE.." Angreifbare NPCs, Quest-Gebiete";
};
AlteracValleySouth = {
ZoneName = "Alteractal (S\195\188den)";
Acronym = "AV";
Location = "Vorgebirge von Hillsbrad";
BLUE.."A) Eingang";
BLUE.."B) Burg Frostwolf (Horde)";
_RED.."1) H\195\188tte der Heiler von Frostwolf";
_RED.."2) Frostwolf-Friedhof";
_RED.."3) Iceblood-Friedhof";
ORNG.."4) Westlicher Frostwolfturm";
ORNG.."5) \195\150stlicher Frostwolfturm";
GREY..INDENT.."Schwadronskommandant Ichman (Allianz)";
ORNG.."6) Turmstellung";
GREY..INDENT.."Schwadronskommandant Slidore (Allianz)";
GREY..INDENT.."Kommandant Louis Philips (Horde)";
ORNG.."7) Iceblood-Turm";
ORNG.."8) Iceblood-Garnision (Galvangar)";
GREY.."9) H\195\182hle der Wildpfoten";
GREY.."10) Frostwolf-Wolfreiter-Kommandant";
GREY.."11) Schwadronskommandant Vipore (Allianz)";
GREY.."12) Coldtooth-Mine";
GREY.."13) Dampfs\195\164ge (Allianz)";
GREY.."14) Lokholar der Eislord (Beschw\195\182rungszone)";
"";
"";
"";
"";
"";
_RED.."Red:"..BLUE.." Friedh\195\182fe, Einnehmbare Gebiete";
ORNG.."Orange:"..BLUE.." Bunker, T\195\188rme, Zerst\195\182rbare Gebiete";
GREY.."Wei\195\159:"..BLUE.." Angreifbare NPCs, Quest-Gebiete";
};
ArathiBasin = {
ZoneName = "Arathi Becken";
Acronym = "AB";
Location = "Arathi Hochland";
BLUE.."A) Trollbanes Halle";
BLUE.."B) Die Entweihten Feste";
GREY.."1) St\195\164lle";
GREY.."2) Gold Mine";
GREY.."3) Schmiede";
GREY.."4) S\195\164gewerk";
GREY.."5) Hof";
};
WarsongGulch = {
ZoneName = "Warsongschlucht";
Acronym = "WS";
Location = "Ashenvale / Das Brachland";
BLUE.."A) Feste Silverwing ";
BLUE.."B) S\195\164gewerk der Warsong";
};
};



AtlasFP = {
FPAllianceEast = {
ZoneName = "Allianz (Osten)";
Location = "\195\150stliche K\195\182nigreiche";
GREY.."1) Kapelle des hoffnungsvollen Lichts,";
          _RED.."      Die \195\150stlichen Pestl\195\164nder";
GREY.."2) Chillwind-Spitze,";
          _RED.."      Die westlichen Pestl\195\164nder";
GREY.."3) Aerie Peak, ".._RED.."Das Hinterland";
GREY.."4) Southshore, ".._RED.."Vorgebirge von Hillsbrad";
GREY.."5) Die Zuflucht, ".._RED.."Das Arathi Hochland";
GREY.."6) Hafen von Menethil, ".._RED.."Das Sumpfland";
GREY.."7) Ironforge, ".._RED.."Dun Morogh";
GREY.."8) Thelsamar, ".._RED.."Loch Modan";
GREY.."9) Thoriumspitze, ".._RED.."Die sengende Schlucht";
GREY.."10) Morgans Wacht, ".._RED.."Die brennende Steppe";
GREY.."11) Stormwind, ".._RED.."Der Wald von Elwynn";
GREY.."12) Seenhain, ".._RED.."Das Rotkammgebirge";
GREY.."13) Sp\195\164herkuppe, ".._RED.."Westfall";
GREY.."14) Dunkelhain, ".._RED.."D\195\164mmerwald";
GREY.."15) Burg Nethergarde,";
           _RED.."       Die verw\195\188steten Lande";
GREY.."16) Booty Bay, ".._RED.."Schlingendorntal";
};
FPAllianceWest = {
ZoneName = "Allianz (Westen)";
Location = "Kalimdor";
GREY.."1) Rut'Theran, ".._RED.."Teldrassil";
GREY.."2) Schrein von Remulos, ".._RED.."Moonglade";
GREY.."3) Everlook, ".._RED.."Winterspring";
GREY.."4) Auberdine, ".._RED.."Dunkelk\195\188ste";
GREY.."5) Nachtlaublichtung, ".._RED.."Teufelswald";
GREY.."6) Steinkrallengipfel, ".._RED.."Steinkrallengebirge";
GREY.."7) Astranaar, ".._RED.."Ashenvale";
GREY.."8) Talrendisspitze, ".._RED.."Azshara";
GREY.."9) Nijelspitze, ".._RED.."Desolace";
GREY.."10) Ratchet, ".._RED.."The Barrens";
GREY.."11) Insel Theramore,";
           _RED.."     Marschen von Dustwallow";
GREY.."12) Festung Feathermoon, ".._RED.."Feralas";
GREY.."13) Thalanaar, ".._RED.."Feralas";
GREY.."14) Marshals Zuflucht, ".._RED.."Un'Goro-Krater";
GREY.."15) Burg Cenarius, ".._RED.."Silithus";
GREY.."16) Gadgetzan, ".._RED.."Tanaris";
};
FPHordeEast = {
ZoneName = "Horde (Osten)";
Location = "\195\150stliche K\195\182nigreiche";
GREY.."1) Kapelle des hoffnungsvollen Lichts,";
          _RED.."      Die \195\150stlichen Pestl\195\164nder";
GREY.."2) Undercity, ".._RED.."Tirisfal";
GREY.."3) Das Grabmal, ".._RED.."Silberwald";
GREY.."4) Tarrens M\195\188hle, ".._RED.."Vorgebirge von Hillsbrad";
GREY.."5) Revantusk, ".._RED.."Das Hinterland";
GREY.."6) Hammerfall, ".._RED.."Das Arathihochland";
GREY.."7) Thoriumspitze, ".._RED.."Die sengende Schlucht";
GREY.."8) Kargath, ".._RED.."Das \195\150dland";
GREY.."9) Flammenkamm, ".._RED.."Die brennende Steppe";
GREY.."10) Stonard, ".._RED.."Die S\195\188mpfe des Elends";
GREY.."11) Das Basislager von Grom'Gol,";
           _RED.."      Schlingendorntal";
GREY.."12) Booty Bay, ".._RED.."Schlingendorntal";
};
FPHordeWest = {
ZoneName = "Horde (Westen)";
Location = "Kalimdor";
GREY.."1) Schrein von Remulos, ".._RED.."Moonglade";
GREY.."2) Everlook, ".._RED.."Winterspring";
GREY.."3) Blutgiftposten, ".._RED.."Teufelswald";
GREY.."4) Zoram'gar-Au\195\159enposten, ".._RED.."Ashenvale";
GREY.."5) Valormok, ".._RED.."Azshara";
GREY.."6) Splintertreeposten, ".._RED.."Ashenvale";
GREY.."7) Orgrimmar, ".._RED.."Durotar";
GREY.."8) Sonnenfels, ".._RED.."Steinkrallengebirge";
GREY.."9) Crossroads, ".._RED.."Das Brachland";
GREY.."10) Ratchet, ".._RED.."Das Brachland";
GREY.."11) Shadowprey, ".._RED.."Desolace";
GREY.."12) Thunder Bluff, ".._RED.."Mulgore";
GREY.."13) Camp Taurajo, ".._RED.."Das Brachland";
GREY.."14) Brackenwall, ".._RED.."Marschen von Dustwallow";
GREY.."15) Camp Mojache, ".._RED.."Feralas";
GREY.."16) Freiwindposten, ".._RED.."Tausend Nadeln";
GREY.."17) Marshals Zuflucht, ".._RED.."Un'Goro-Krater";
GREY.."18) Burg Cenarius, ".._RED.."Silithus";
GREY.."19) Gadgetzan, ".._RED.."Tanaris";
};
};

AtlasDL = {
DLEast = {
ZoneName = "Dungeon Standorte (Osten)";
Location = "\195\150stlicher K\195\182nigreiche";
BLUE.."A) Alteractal, ".._RED.."Das Alteracgebirge/";
          _RED.."     Vorgebirge von Hillsbrad";
BLUE.."B) Arathibecken, ".._RED.."Das Arathihochland";
GREY.."1) Das scharlachrote Kloster, ".._RED.."Tirisfal";
GREY.."2) Stratholme, ".._RED.."Die \195\182stlichen Pestl\195\164nder";
          GREY..INDENT.."   Naxxramas, ".._RED.."Stratholme/";
          _RED.."     Die \195\182stlichen Pestl\195\164nder";
GREY.."3) Scholomance, ".._RED.."Die westlichen Pestl\195\164nder";
GREY.."4) Burg Shadowfang, ".._RED.."Silberwald";
GREY.."5) Gnomeregan, ".._RED.."Dun Morogh";
GREY.."6) Uldaman, ".._RED.."Das \195\150dland";
GREY.."7) Der Pechschwingenhort, ".._RED.."Blackrockspitze";
	     GREY..INDENT.."   Die Blackrocktiefen, ".._RED.."Der Blackrock";
	     GREY..INDENT.."   Die Blackrockspitze, ".._RED.."Der Blackrock";
	     GREY..INDENT.."   Geschmolzener Kern, ".._RED.."Blackrocktiefen";
GREY.."8) Das Verlies, ".._RED.."Stormwind";
GREY.."9) Die Todesminen, ".._RED.."Westfall";
GREY.."10) Zul'Gurub, ".._RED.."Schlingendorntal";
GREY.."11) Der versunkene Tempel,";
           _RED.."      Die S\195\188mpfe des Elends";
"";
"";
"";
"";
"";
BLUE.."Blau:"..ORNG.." Schlachtfelder";
GREY.."Wei\195\159:"..ORNG.." Instanzen";
};
DLWest = {
ZoneName = "Dungeon Standorte (Westen)";
Location = "Kalimdor";
BLUE.."A) Warsongschlucht,";
          _RED.."     Das Brachland / Ashenvale";
GREY.."1) Blackfathom-Tiefen, ".._RED.."Ashenvale";
GREY.."2) Ragefireabgrund, ".._RED.."Orgrimmar";
GREY.."3) Die H\195\182hlen des Wehklagens,";
          _RED.."    Das Brachland";
GREY.."4) Maraudon, ".._RED.."Desolace";
GREY.."5) D\195\188sterbruch, ".._RED.."Feralas";
GREY.."6) Der Kral von Razorfen, ".._RED.."Das Brachland";
GREY.."7) Die H\195\188gel von Razorfen , ".._RED.."Das Brachland";
GREY.."8) Onyxias Hort, ".._RED.."Marschen von Dustwallow";
GREY.."9) Zul'Farrak, ".._RED.."Tanaris";
GREY.."10) Die Ruinen von Ahn'Qiraj, ".._RED.."Silithus";
	   GREY..INDENT.."Ahn'Qiraj, ".._RED.."Silithus";
"";
"";
"";
"";
"";
"";
"";
"";
"";
"";
"";
BLUE.."Blau:"..ORNG.." Schlachtfelder";
GREY.."Wei\195\159:"..ORNG.." Instanzen";
};
};

AtlasRE = {
	Azuregos = {
		ZoneName = "Azuregos";
		Location = "Azshara";
		GREY.."1) Azuregos";
	};
	FourDragons = {
		ZoneName = "Alptraumdrachen";
		Location = "Zuf\195\164llig, siehe unten";
		GREN..INDENT.."Lethon";
		GREN..INDENT.."Emeriss";
		GREN..INDENT.."Taerar";
		GREN..INDENT.."Ysondre";
		"";
		GREY.."1) D\195\164mmerwald, Mitte";
		GREY.."2) Hinterland, Norden";
		GREY.."3) Feralas, Nordwesten";
		GREY.."4) Ashenvale, Nordosten";
	};
	Kazzak = {
		ZoneName = "Kazzak";
		Location = "Verw\195\188stete Lande";
		GREY.."1) Kazzak";
		GREY.."2) Burg Nethergard";
	};
};
end