--[[

-- Atlas Localization Data (French)
-- Translation by Sasmira, Vévé, Sparrows, Pherus
-- Thanks to Sainterre from Blizzard and websites WoWDBU and JudgeHype
-- Last Update: 06/22/2006

--]]





if ( GetLocale() == "frFR" ) then




AtlasSortIgnore = {
	"le (.+)",
	"la (.+)",
	"les (.+)"
}

ATLAS_TITLE = "Atlas";
ATLAS_SUBTITLE = "Navigateur de cartes d\'instances";
ATLAS_DESC = "Atlas est un navigateur de cartes d\'instances.";

ATLAS_OPTIONS_BUTTON = "Options";

BINDING_HEADER_ATLAS_TITLE = "Atlas";
BINDING_NAME_ATLAS_TOGGLE = "Atlas [Ouvrir/Fermer]";
BINDING_NAME_ATLAS_OPTIONS = "Options [Ouvrir/Fermer]";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "options";

ATLAS_STRING_LOCATION = "Lieu";
ATLAS_STRING_LEVELRANGE = "Niveau";
ATLAS_STRING_PLAYERLIMIT = "Limite de joueurs";
ATLAS_STRING_SELECT_CAT = "Choix de la cat\195\169gorie";
ATLAS_STRING_SELECT_MAP = "Choix de la carte";

ATLAS_BUTTON_TOOLTIP = "Atlas";
ATLAS_BUTTON_TOOLTIP2 = "Clic gauche pour ouvrir Atlas.";
ATLAS_BUTTON_TOOLTIP3 = "Clic droit et tirer pour d\195\169placer ce bouton.";

ATLAS_OPTIONS_TITLE = "Atlas Options";
ATLAS_OPTIONS_SHOWBUT = "Voir le bouton sur la mini-carte";
ATLAS_OPTIONS_AUTOSEL = "Auto-s\195\169lection de la carte";
ATLAS_OPTIONS_BUTPOS = "Position du bouton";
ATLAS_OPTIONS_TRANS = "Transparence";
ATLAS_OPTIONS_DONE = "Valider";
ATLAS_OPTIONS_REPMAP = "Remplacer la carte du monde";
ATLAS_OPTIONS_RCLICK = "Clic droit pour afficher la carte du monde";
ATLAS_OPTIONS_SHOWMAPNAME = "Afficher le nom de la carte";
ATLAS_OPTIONS_RESETPOS = "Position initiale";
ATLAS_OPTIONS_ACRONYMS = "Afficher les acronymes VO/VF";

ATLAS_HINT = "Astuce: clic gauche pour ouvrir Atlas.";

ATLAS_LOCALE = {
	menu = "Atlas",
	tooltip = "Atlas",
	button = "Atlas"
};

AtlasZoneSubstitutions = {
   ["Le temple d\'Atal\'Hakkar"]    = "Le temple englouti";
   ["Ahn\'Qiraj"]               = "Le temple d\'Ahn\'Qiraj";
};

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = "    ";

--Catégories de cartes
Atlas_MapTypes = {"Cartes d'instances", "Cartes de champs de bataille", "Cartes de trajets a\195\169riens", "Emplacements des instances", "Rencontre de Raid"};

AtlasText = {
	BlackfathomDeeps = {
		ZoneName = "Profondeurs de Brassenoire";
		Acronym = "BFD";
		Location = "Ashenvale";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Ghamoo-ra";
		GREY.."2) Manuscrit de Lorgalis";
		GREY.."3) Dame Sarevess";
		GREY.."4) Garde d\'Argent de Thaelrid";
		GREY.."5) Autel de Gelihast";
		GREY.."6) Lorgus Jett (variable)";
		GREY.."7) Baron Aquanis";
		GREY..INDENT.."Noyau de Fathom";
		GREY.."8) Seigneur Kelris Cr\195\169pusculaire";
		GREY.."9) Vieux Serra'kis";
		GREY.."10) Aku'mai";
	};
	BlackrockDepths = {
		ZoneName = "Profondeurs de Blackrock";
		Acronym = "BRD";
		Location = "Montagne de Blackrock";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Seigneur Roccor";
		GREY.."2) Kharan Mighthammer";
		GREY.."3) Commandant Gor'shak";
		GREY.."4) Mar\195\169chal Windsor";
		GREY.."5) Grand Interrogateur Gerstahn";
		GREY.."6) L\'Ar\195\168ne, Theldren";
		GREY.."7) Statue de Franclorn Forgewright";
		GREY..INDENT.."Pyromancier Loregrain (rare)";
		GREY.."8) La chambre forte";
		GREY.."9) Fineous Darkvire";
		GREY.."10) Enclume Noire";
		GREY..INDENT.." Seigneur Incendius";
		GREY.."11) Bael'Gar";
		GREY.."12) Verrou de Shadowforge";
		GREY.."13) G\195\169n\195\169ral Angerforge";
		GREY.."14) Seigneur Golem Argelmach";
		GREY.."15) Grim Guzzler";
		GREY.."16) Ambassadeur Cingleflammes";
		GREY.."17) Panzor l\'Invincible (rare)";
		GREY.."18) Le Tombeau des Sept";
		GREY.."19) Le Lyceum";
		GREY.."20) Magmus";
		GREY.."21) Empereur Dagran Thaurissan";
		GREY..INDENT.." Princesse Moira Bronzebeard";
		GREY.."22) La Forge Noire";
		GREY.."23) C\197\147ur du Magma";
	};
	BlackrockSpireLower = {
		ZoneName = "Pic Blackrock inf\195\169rieur";
		Acronym = "LBRS";
		Location = "Montagne de Blackrock";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Warosh";
		GREY.."2) Pique de Roughshod";
		GREY.."3) G\195\169n\195\169ralissime Omokk";
		GREY..INDENT.."Seigneur de guerre Spirestone (rare)";
		GREY.."4) Chasseur d\'ombres Vosh'gajin";
		GREY..INDENT.."5\195\168me tablette Mosh'aru";
		GREY.."5) Maitre de Guerre Voone";
		GREY..INDENT.."Mor Grayhoof (optionnel)";
		GREY..INDENT.."6\195\168me tablette Mosh'aru";
		GREY.."6) Matriarche Couveuse";
		GREY.."7) Croc Cristalin (rare)";
		GREY.."8) Urok Hurleruine";
		GREY.."9) Intendant Zigris";
		GREY.."10) Gizrul l'Esclavagiste";
		GREY..INDENT.." Halycon";
		GREY.."11) Seigneur Wyrmthalak";
		GREY.."12) Bannok Grimaxe (rare)";
		GREY.."13) Boucher Spirestone (rare)";
	};
	BlackrockSpireUpper = {
		ZoneName = "Pic Blackrock sup\195\169rieur";
		Acronym = "UBRS";
		Location = "Montagne de Blackrock";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Pyrogarde Proph\195\168te Ardent";
		GREY.."2) Solakar Voluteflamme (optionnel)";
		GREY..INDENT.."Flamme du p\195\168re";
		GREY.."3) Jed Runewatcher (rare)";
		GREY.."4) Goraluk Anvilcrack";
		GREY.."5) Rend Blackhand";
		GREY..INDENT.."Gyth";
		GREY.."6) Awbee";
		GREY.."7) La B\195\170te";
		GREY..INDENT.."Seigneur Valthalak (optionnel)";
		GREY.."8) G\195\169n\195\169ral Drakkisath";
		GREY..INDENT.."Fermoir de Doomrigger";
		GREY.."9) Repaire de l\'Aile noire";
	};
	BlackwingLair = {
		ZoneName = "Repaire de l\'Aile noire";
		Acronym = "BWL";
		Location = "Montagne de Blackrock";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Connexion";
		BLUE.."C) Connexion";
		GREY.."1) Tranchetripe l'Indompt\195\169";
		GREY.."2) Vaelastrasz le Corrompu";
		GREY.."3) Seigneur des couv\195\169es Lashlayer";
		GREY.."4) Gueule de Feu";
		GREY.."5) Roch\195\169b\195\168ne";
		GREY.."6) Flamegor";
		GREY.."7) Chromaggus";
		GREY.."8) Nefarian";
		GREY.."9) Maitre \195\169l\195\169mentaire Krixix";
	};
	DireMaulEast = {
		ZoneName = "Hache-Tripes (Est)";
		Acronym = "DM/HT";
		Location = "Feralas";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Entr\195\169e";
		BLUE.."C) Entr\195\169e";
		BLUE.."D) Sortie";
		GREY.."1) D\195\169but de la chasse \195\160 Pusillin";
		GREY.."2) Fin de la chasse \195\160 Pusillin";
		GREY.."3) Zevrim Thornhoof";
		GREY..INDENT.."Hydrog\195\169nos";
		GREY..INDENT.."Lethtendris";
		GREY.."4) Viel Ironbark";
		GREY.."5) Alzzin le modeleur";
		GREY..INDENT.."Isalien (optionnel)";
	};
	DireMaulNorth = {
		ZoneName = "Hache-Tripes (Nord)";
		Acronym = "DM/HT";
		Location = "Feralas";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Garde Mol'dar";
		GREY.."2) Kreeg le marteleur";
		GREY.."3) Garde Fengus";
		GREY.."4) Knot Thimblejack";
		GREY..INDENT.."Garde Slip'kik";
		GREY.."5) Capitaine Kromcrush";
		GREY.."6) Roi Gordok";
		GREY.."7) Hache-Tripes (Ouest)";
		GREN.."1') Biblioth\195\168que";
	};
	DireMaulWest = {
		ZoneName = "Hache-Tripes (Ouest)";
		Acronym = "DM/HT";
		Location = "Feralas";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Les Pyl\195\180nes";
		GREY.."1) Ancienne de Shen'Dralar";
		GREY.."2) Tendris Crochebois";
		GREY.."3) Illyanna Ravenoak";
		GREY.."4) Magistrat Kalendris";
		GREY.."5) Tsu'Zee (rare)";
		GREY.."6) Immol'thar";
		GREY..INDENT.."Seigneur Hel'nurath";
		GREY.."7) Prince Tortheldrin";
		GREY.."8) Hache-Tripes (Nord)";
		GREN.."1') Biblioth\195\168que";
	};
	Gnomeregan = {
		ZoneName = "Gnomeregan";
		Location = "Dun Morogh";
		BLUE.."A) Entr\195\169e (avant)";
		BLUE.."B) Entr\195\169e (arri\195\168re)";
		GREY.."1) Retomb\195\169es Visqueuses (inf\195\169rieur)";
		GREY.."2) Grubbis";
		GREY.."3) Matrice d\'Encodage 3005-B";
		GREY.."4) Zone Propre";
		GREY.."5) Electrocuteur 6000";
		GREY..INDENT.."Matrice d\'Encodage 3005-C";
		GREY.."6) Mekgineer Thermaplugg";
		GREY.."7) Ambassadeur Dark Iron (rare)";
		GREY.."8) Faucheur de foule 9-60";
		GREY..INDENT.."Matrice d\'Encodage 3005-D";
	};
	Maraudon = {
		ZoneName = "Maraudon";
		Acronym = "Mara";
		Location = "Desolace";
		BLUE.."A) Entr\195\169e (Orange)";
		BLUE.."B) Entr\195\169e (Pourpre)";
		BLUE.."C) Entr\195\169e (Portail)";
		GREY.."1) Veng (5\195\168me Khan)";
		GREY.."2) Noxxion";
		GREY.."3) Tranchefouet";
		GREY.."4) Maraudos (4\195\168me Khan)";
		GREY.."5) Seigneur Vylelangue";
		GREY.."6) Meshlok le collecteur (rare)";
		GREY.."7) Celebras le maudit";
		GREY.."8) Glissement de terrain";
		GREY.."9) Artisan Gizlock";
		GREY.."10) Rotgrip";
		GREY.."11) Princesse Theradras";
	};
	MoltenCore = {
		ZoneName = "C\197\147ur du Magma";
		Acronym = "MC";
		Location = "Profondeurs de Blackrock";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Lucifron";
		GREY.."2) Magmadar";
		GREY.."3) Gehennas";
		GREY.."4) Garr";
		GREY.."5) Shazzrah";
		GREY.."6) Baron Geddon";
		GREY.."7) Golemagg l\'Incin\195\169rateur";
		GREY.."8) Messager de Sulfuron";
		GREY.."9) Chambellan Executus";
		GREY.."10) Ragnaros";
	};
	OnyxiasLair = {
		ZoneName = "Repaire d\'Onyxia";
		Acronym = "Ony";
		Location = "Mar\195\169cage d\'Aprefange";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Gardiens Onyxian";
		GREY.."2) Oeufs";
		GREY.."3) Onyxia";
	};
	RagefireChasm = {
		ZoneName = "Gouffre de Ragefeu";
		Acronym = "RFC";
		Location = "Orgrimmar";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Maur Grimtotem";
		GREY.."2) Taragaman l\'Affam\195\169";
		GREY.."3) Jergosh l\'Invocateur";
		GREY.."4) Bazzalan";
	};
	RazorfenDowns = {
		ZoneName = "Souilles de Tranchebauge";
		Acronym = "RFD";
		Location = "Les Tarides";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Tuten'kash";
		GREY.."2) Henry Stern";
		GREY..INDENT.."Belnistrasz";
		GREY.."3) Mordresh Oeil de Feu";
		GREY.."4) Glouton";
		GREY.."5) Ragglesnout (rare)";
		GREY.."6) Amnennar le Porte-Froid";
	};
	RazorfenKraul = {
		ZoneName = "Kraal de Tranchebauge";
		Acronym = "RFK";
		Location = "Les Tarides";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Roogug";
		GREY.."2) Aggem Thorncurse";
		GREY.."3) M\195\169dium Jargba";
		GREY.."4) Seigneur Brusquebroche";
		GREY.."5) Agathelos l\'Enrag\195\169";
		GREY.."6) Chasseur Aveugle (rare)";
		GREY.."7) Charlga Trancheflanc";
		GREY.."8) Willix l\'Importateur";
		GREY..INDENT.."Heralath Fallowbrook";
		GREY.."9) Implorateur de la terre Halmgar (rare)";
	};
	ScarletMonastery = {
		ZoneName = "Monast\195\168re \195\169carlate";
		Acronym = "SM/ME";
		Location = "Clairi\195\168re de Tirisfal";
		BLUE.."A) Entr\195\169e (Biblioth\195\168que)";
		BLUE.."B) Entr\195\169e (Armurie)";
		BLUE.."C) Entr\195\169e (Cath\195\169drale)";
		BLUE.."D) Entr\195\169e (Cimeti\195\168re)";
		GREY.."1) Maitre-Chien Loksey";
		GREY.."2) Arcaniste Doan";
		GREY.."3) Herod";
		GREY.."4) Grand Inquisiteur Fairbanks";
		GREY.."5) Commandant Mograine";
		GREY..INDENT.."Grand Inquisiteur Whitemane";
		GREY.."6) Ironspine (rare)";
		GREY.."7) Azshir le Sans-sommeil (rare)";
		GREY.."8) Champion Mort (rare)";
		GREY.."9) Mage de Sang Thalnos";
	};
	Scholomance = {
		ZoneName = "Scholomance";
		Acronym = "Scholo";
		Location = "Maleterres de l\'Ouest";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Escalier";
		BLUE.."C) Escalier";
		GREY.."1) R\195\169gisseur sanglant de Kirtonos";
		GREY..INDENT.."Titre de propri\195\169t\195\169 de Southshore";
		GREY.."2) Kirtonos le H\195\169rault";
		GREY.."3) Jandice Barov";
		GREY.."4) Titre de propri\195\169t\195\169 de";
		GREY..INDENT.."Moulin-de-Tarren";
		GREY.."5) Cliquetripes (inf\195\169rieur)";
		GREY..INDENT.."Chevalier de la mort Darkreaver";
		GREY.."6) Marduk Noir\195\169tang";
		GREY..INDENT.."Vectus";
		GREY.."7) Ras Murmegivre";
		GREY..INDENT.."Kormok (optionnel)";
		GREY..INDENT.."Titre de propri\195\169t\195\169 de Brill";
		GREY.."8) Instructeur Malicia";
		GREY.."9) Docteur Theolen Krastinov";
		GREY.."10) Gardien du Savoir Polkelt";
		GREY.."11) Le Voracien";
		GREY.."12) Seigneur Alexei Barov";
		GREY..INDENT.." Titre de propri\195\169t\195\169 de Caer Darrow";
		GREY.."13) Dame Illucia Barov";
		GREY.."14) Sombre Maitre Gandling";
		GREN.."1') Torche levier";
		GREN.."2') Coffre secret";
		GREN.."3') Laboratoire d'alchimie";
	};
	ShadowfangKeep = {
		ZoneName = "Donjon d\'Ombrecroc";
		Acronym = "SFK";
		Location = "For\195\170t des Pins Argent\195\169s";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) All\195\169e";
		BLUE.."C) All\195\169e";
		GREY..INDENT.."Capitaine Deathsworn (rare)";
		GREY.."1) Traqueur noir Adamant";
		GREY..INDENT.."Sorcier Ashcrombe";
		GREY..INDENT.."Rethilgore";
		GREY.."2) Razorclaw le Boucher";
		GREY.."3) Baron Silverlaine";
		GREY.."4) Commandant Springvale";
		GREY.."5) Odo l'Aveugle";
		GREY.."6) Fenrus le D\195\169voreur";
		GREY.."7) Maître-loup Nandos";
		GREY.."8) Archimage Arugal";
	};
	Stratholme = {
		ZoneName = "Stratholme";
		Acronym = "Strat";
		Location = "Maleterres de l\'Est";
		BLUE.."A) Entr\195\169e (avant)";
		BLUE.."B) Entr\195\169e (cot\195\169)";
		GREY.."1) Skul (rare)";
		GREY..INDENT.."Malown le Facteur";
		GREY..INDENT.."Fras Siabi";
		GREY.."2) Hearthsinger Forresten (errant)";
		GREY.."3) Le Condamn\195\169";
		GREY.."4) Timmy le Cruel";
		GREY.."5) Maitre Cannonier Willey";
		GREY.."6) Archiviste Galford";
		GREY.."7) Balnazzar";
		GREY..INDENT.."Sothos (optionnel)";
		GREY..INDENT.."Jarien (optionnel)";
		GREY.."8) Aurius";
		GREY.."9) Stonespine (rare)";
		GREY.."10) Barone Anastari";
		GREY.."11) Nerub'enkan";
		GREY.."12) Maleki le Blafard";
		GREY.."13) Magistrate Barthilas (variable)";
		GREY.."14) Ramstein Grandgosier";
		GREY.."15) Baron Rivendare";
		GREN.."--- Boites aux lettres:";
		GREN.."1') Boite de la Place des Crois\195\169s";
		GREN.."2') Boite de l'All\195\169e du march\195\169";
		GREN.."3') Boite de l'All\195\169e du festival";
		GREN.."4') Boite de la Place des Anciens";
		GREN.."5') Boite de la Place du Roi";
		GREN.."6') Boite de Fras Siabi";
	};
	TheDeadmines = {
		ZoneName = "Les Mortemines";
		Acronym = "VC/DM/MM";
		Location = "Marche de l\'Ouest";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Exit";
		GREY.."1) Rhahk'Zor";
		GREY.."2) Mineur Johnson (rare)";
		GREY.."3) Sneed";
		GREY.."4) Gilnid";
		GREY.."5) Poudre \195\160 canon D\195\169fias";
		GREY.."6) Capitaine Vertepeau";
		GREY..INDENT.."Edwin VanCleef";
		GREY..INDENT.."Mr. Smite";
		GREY..INDENT.."Macaron";
	};
	TheStockade = {
		ZoneName = "La Prison";
		Location = "Cit\195\169 de Stormwind";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Targorr le Terrifiant (variable)";
		GREY.."2) Kam Deepfury";
		GREY.."3) Hamhock";
		GREY.."4) Bazil Thredd";
		GREY.."5) Dextren Ward";
		GREY.."6) Bruegal Ironknuckle (rare)";
	};
	TheSunkenTemple = {
		ZoneName = "Le temple englouti";
		Location = "Marais des chagrins";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Escalier";
		BLUE.."C) Troll Miniboss (sup\195\169rieur)";
		GREY.."1) Autel d\'Hakkar";
		GREY..INDENT.."Atal'alarion";
		GREY.."2) Fauche-r\195\170ve";
		GREY..INDENT.."Tisserand";
		GREY.."3) Avatar d\'Hakkar";
		GREY.."4) Jammal'an le Proph\195\168te";
		GREY..INDENT.."Ogom le Corrompu";
		GREY.."5) Morphaz";
		GREY..INDENT.."Hazzas";
		GREY.."6) Ombre d\'Eranikus";
		GREY..INDENT.."Essence d\'Eranikus enchain\195\169e";
		GREN.."--- Statues:";
		GREN.."1'-6') Ordre d\'activation";
	};
	Uldaman = {
		ZoneName = "Uldaman";
		Acronym = "Ulda";
		Location = "Terres ingrates";
		BLUE.."A) Entr\195\169e (avant)";
		BLUE.."B) Entr\195\169e (arri\195\168re)";
		GREY.."1) Baelog";
		GREY.."2) Restes de Paladin";
		GREY.."3) Revelosh";
		GREY.."4) Ironaya";
		GREY.."5) Sentinelle d\'obsidienne ";
		GREY.."6) Annora (Maitre Enchanteur)";
		GREY.."7) Garde en pierre Antique";
		GREY.."8) Galgann Firehammer";
		GREY.."9) Grimlok";
		GREY.."10) Archaedas (inf\195\169rieur)";
		GREY.."11) les disques de Norgannon";
		GREY..INDENT.." Tr\195\169sor Antique (inf\195\169rieur)";
	};
	WailingCaverns = {
		ZoneName = "Cavernes des lamentations";
		Acronym = "WC";
		Location = "Les Tarides";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Disciple de Naralex";
		GREY.."2) Seigneur Cobrahn";
		GREY.."3) Dame Anacondra (variable)";
		GREY.."4) Kresh";
		GREY.."5) Seigneur Pythas";
		GREY.."6) Skum";
		GREY.."7) Seigneur Serpentis (sup\195\169rieur)";
		GREY.."8) Verdan l'Immortel (sup\195\169rieur)";
		GREY.."9) Mutanus le D\195\169voreur";
		GREY..INDENT.."Naralex";
		GREY.."10) Dragon f\195\169\195\169rique D\195\169viant (rare)";
	};
	ZulFarrak = {
		ZoneName = "Zul'Farrak";
		Acronym = "ZF";
		Location = "Tanaris";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Antu'sul";
		GREY.."2) Theka le Martyr";
		GREY.."3) Sorcier-docteur Zum'rah";
		GREY..INDENT.."H\195\169ros Mort Zul'Farrak";
		GREY.."4) Nekrum M\195\162chetripes";
		GREY..INDENT.."Pr\195\170tre des ombres Sezz'ziz";
		GREY.."5) Sergent Bly";
		GREY.."6) Hydromancienne Velratha";
		GREY..INDENT.."Gahz'rilla";
		GREY..INDENT.."Dustwraith (rare)";
		GREY.."7) Ukorz Scalpessable";
		GREY..INDENT.."Ruuzlu";
		GREY.."8) Zerillis (rare, errant)";
		GREY.."9) Sandarr Dunereaver (rare)";
	};
	ZulGurub = {
		ZoneName = "Zul'Gurub";
		Acronym = "ZG";
		Location = "Vall\195\169e de Strangleronce";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Grande Pr\195\170tresse Jeklik (Chauve-souris)";
		GREY.."2) Grand Pr\195\170tre Venoxis (Serpent)";
		GREY.."3) Grande Pr\195\170tresse Mar'li (Araign\195\169e)";
		GREY.."4) Seigneur sanglant Mandokir (Raptor, optionnel)";
		GREY.."5) Fronti\195\168re de la folie (optionnelle)";
		GREY..INDENT.."Gri'lek du Sang de fer";
		GREY..INDENT.."Hazza'rah Tisser\195\170ve";
		GREY..INDENT.."Renataki des Mille lames";
		GREY..INDENT.."Wushoolay la Sorci\195\168re des temp\195\170tes";
		GREY.."6) Gahz'ranka (optionnel)";
		GREY.."7) Grand Pr\195\170tre Thekal (Tigre)";
		GREY.."8) Grande Pr\195\170tresse Arlokk (Panth\195\168re)";
		GREY.."9) Jin'do le mal\195\169ficieur (optionnel)";
		GREY.."10) Hakkar";
		GREN.."1') Eaux troubles et agit\195\169es";
	};
	TheTempleofAhnQiraj = {
		ZoneName = "Le temple d\'Ahn\'Qiraj";
		Acronym = "AQ40";
		Location = "Silithus";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Proph\195\168te Skeram (ext\195\169rieur)";
		GREY.."2) Vem";
		GREY..INDENT.."Princesse Yauj";
		GREY..INDENT.."Seigneur Kri";
		GREY.."3) Garde de guerre Sartura";
		GREY.."4) Fankriss l'Inflexible";
		GREY.."5) Viscidus (optionnel)";
		GREY.."6) Princesse Huhuran";
		GREY.."7) Empereur Vek'lor";
		GREY..INDENT.."Empereur Vek'nilash";
		GREY.."8) Ouro (optionnel)";
		GREY.."9) Oeil de C'Thun";
		GREN.."1') Andorgos (rejeton de Malygos)";
		GREN..INDENT.." Vethsera (rejeton d'Ysera)";
		GREN..INDENT.." Kandrostrasz (rejeton d'Alexstrasza)";
		GREN.."2') Arygos";
		GREN..INDENT.." Caelestrasz";
		GREN..INDENT.." Merithra du R\195\170ve";
	};
	TheRuinsofAhnQiraj = {
		ZoneName = "Ruines d'Ahn'Qiraj";
		Acronym = "AQ20";
		Location = "Silithus";
		BLUE.."A) Entr\195\169e";
		GREY.."1) Kurinnaxx";
		GREY..INDENT.."G\195\169n\195\169ral de division Andorov";
		GREY..INDENT.."Quatre \195\169lites kaldorei";
		GREY.."2) G\195\169n\195\169ral Rajaxx";
		GREY..INDENT.."Capitaine Qeez";
		GREY..INDENT.."Capitaine Tuubid";
		GREY..INDENT.."Capitaine Drenn";
		GREY..INDENT.."Capitaine Xurrem";
		GREY..INDENT.."Major Yeggeth";
		GREY..INDENT.."Major Pakkon";
		GREY..INDENT.."Colonel Zerran";
		GREY.."3) Moam (optionnel)";
		GREY.."4) Buru Grandgosier (optionnel)";
		GREY.."5) Ayamiss le chasseur (optionnel)";
		GREY.."6) Ossirian l'Intouch\195\169";
		GREN.."1') Pi\195\168ce s\195\187re";
	};
	Naxxramas = {
		ZoneName = "Naxxramas";
		Acronym = "Nax";
		Location = "Stratholme";
		BLUE.."Aile des abominations";
		BLUE..INDENT.."1) Patchwerk";
		BLUE..INDENT.."2) Grobbulus";
		BLUE..INDENT.."3) Gluth";
		BLUE..INDENT.."4) Thaddius";
		ORNG.."Aile des araign\195\169es";
		ORNG..INDENT.."1) Anub'Rekhan";
		ORNG..INDENT.."2) Grand Widow Faerlina";
		ORNG..INDENT.."3) Maexxna";
		_RED.."Aile des chevaliers de la Mort";
		_RED..INDENT.."1) Instructeur Razuvious";
		_RED..INDENT.."2) Gothik le collecteur";
		_RED..INDENT.."3) Les quatre cavaliers";
		_RED..INDENT..INDENT.."Thane Korth'azz";
		_RED..INDENT..INDENT.."Dame Blaumeux";
		_RED..INDENT..INDENT.."Commandant Mograine";
		_RED..INDENT..INDENT.."Sir Zeliek";
		PURP.."Aile du Fl\195\169au";
		PURP..INDENT.."1) Noth le Plaguebringer";
		PURP..INDENT.."2) Heigan le Unclean";
		PURP..INDENT.."3) Loatheb";
		GREN.."Repaire des Frostwyrms";
		GREN..INDENT.."1) Sapphiron";
		GREN..INDENT.."2) Kel'Thuzad";
	};
};

AtlasBG = {
	AlteracValleyNorth = {
		ZoneName = "Vall\195\169e d'Alterac (Nord)";
		Location = "Montagnes d'Alterac";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Dun Baldar (Alliance)";
		_RED.."1) Poste de secours Stormpike";
		_RED.."2) Cimeti\195\168re Stormpike";
		_RED.."3) Cimeti\195\168re Stonehearth";
		_RED.."4) Cimeti\195\168re des neiges";
		ORNG.."5) Fortin nord de Dun Baldar";
		GREY..INDENT.."Chef d'escadrille Mulverick (Horde)";
		ORNG.."6) Fortin sud de Dun Baldar";
		ORNG.."7) Tour de l'Aile de glace";
		GREY..INDENT.."Chef d'escadrille Guse (Horde)";
		GREY..INDENT.."Commandant Karl Philips (Alliance)";
		ORNG.."8) Avant-poste de Stonehearth (Balinda)";
		ORNG.."9) Fortin de Stonehearth";
		GREY.."10) Mine de Gouffrefer";
		GREY.."11) Caverne de l'Aile de glace";
		GREY.."12) Scie m\195\169canique (Horde)";
		GREY.."13) Chef d'escadrille Jeztor (Horde)";
		GREY.."14) Ivus le Seigneur des for\195\170ts (zone d'invocation)";
		"";
		"";
		"";
		"";
		"";
		_RED.."Rouge:"..BLUE.." Cimeti\195\168res, Zones capturable";
		ORNG.."Orange:"..BLUE.." Fortins, Tours, Zones destructibles";
		GREY.."Blanc:"..BLUE.." PNJs, Zones de qu\195\170tes";
	};
	AlteracValleySouth = {
		ZoneName = "Vall\195\169e d'Alterac (Sud)";
		Location = "Contreforts d'Hillsbrad";
		BLUE.."A) Entr\195\169e";
		BLUE.."B) Donjon Frostwolf (Horde)";
		_RED.."1) Hutte de gu\195\169rison Frostwolf";
		_RED.."2) Cimeti\195\168re Frostwolf";
		_RED.."3) Cimeti\195\168re de Glacesang";
		ORNG.."4) Tour Frostwolf occidentale";
		ORNG.."5) Tour Frostwolf orientale";
		GREY..INDENT.."Chef d'escadrille Ichman (Alliance)";
		ORNG.."6) Tour de la Halte";
		GREY..INDENT.."Chef d'escadrille Slidore (Alliance)";
		GREY..INDENT.."Commandant Louis Philips (Horde)";
		ORNG.."7) Tour de Glacesang";
		ORNG.."8) Garnison de Glacesang (Galvangar)";
		GREY.."9) Caverne des Follepatte";
		GREY.."10) Commandant des chevaucheurs de loup";
		GREY.."11) Chef d'escadrille Vipore (Alliance)";
		GREY.."12) Mine de Froidedent";
		GREY.."13) Scie m\195\169canique (Alliance)";
		GREY.."14) Lokholar le Seigneur de glace (zone d'invocation)";
		"";
		"";
		"";
		"";
		"";
		_RED.."Rouge:"..BLUE.." Cimeti\195\168res, Zones capturable";
		ORNG.."Orange:"..BLUE.." Fortins, Tours, Zones destructibles";
		GREY.."Blanc:"..BLUE.." PNJs, Zones de qu\195\170tes";
	};
	ArathiBasin = {
		ZoneName = "Bassin d'Arathi";
		Location = "Hautes-terres d'Arathi";
		BLUE.."A) Salle de Trollbane (Alliance)";
		BLUE.."B) L'antre des Profanateurs (Horde)";
		GREY.."1) Ecuries";
		GREY.."2) Mine";
		GREY.."3) Forge";
		GREY.."4) Scierie";
		GREY.."5) Ferme";
	};
	WarsongGulch = {
		ZoneName = "Goulet des Warsong";
		Location = "Ashenvale / Les Tarrides";
		BLUE.."A) Fort d'Aile-argent (Alliance)";
		BLUE.."B) Scierie des Warsong (Horde)";
	};
};


AtlasFP = {
	FPAllianceEast = {
		ZoneName = "Alliance (Est)";
		Location = "Royaumes de l'Est";
		GREY.."1) Chapelle de l'Espoir de Lumi\195\168re, ".._RED.."Maleterres de l'est";
		GREY.."2) Camp du Noroit, ".._RED.."Maleterres de l'ouest";
		GREY.."3) Nid-de-l'Aigle, ".._RED.."Les Hinterlands";
		GREY.."4) Southshore, ".._RED.."Contreforts d'Hillsbrad";
		GREY.."5) Refuge de l'Orni\195\168re, ".._RED.."Hautes-terres d'Arathi";
		GREY.."6) Port de Menethil, ".._RED.."Les Paluns";
		GREY.."7) Ironforge, ".._RED.."Dun Morogh";
		GREY.."8) Thelsamar, ".._RED.."Loch Modan";
		GREY.."9) Halte du Thorium, ".._RED.."Gorge des Vents br\195\187lants";
		GREY.."10) Veill\195\169e de Morgan, ".._RED.."Steppes ardentes";
		GREY.."11) Stormwind, ".._RED.."For\195\170t d'Elwynn";
		GREY.."12) Lakeshire, ".._RED.."Les Carmines";
		GREY.."13) Collines des Sentinelles, ".._RED.."Marche de l'Ouest";
		GREY.."14) Darkshire, ".._RED.."Bois de la p\195\169nombre";
		GREY.."15) Rempart-du-N\195\169ant, ".._RED.."Terres foudroy\195\169es";
		GREY.."16) Baie-du-Butin, ".._RED.."Vall\195\169e de Strangleronce";
	};
	FPAllianceWest = {
		ZoneName = "Alliance (Ouest)";
		Location = "Kalimdor";
		GREY.."1) Village de Rut'Theran, ".._RED.."Teldrassil";
		GREY.."2) Autel de Remulos, ".._RED.."Reflet-de-Lune";
		GREY.."3) Long-guet, ".._RED.."Berceau-de-l'Hiver";
		GREY.."4) Auberdine, ".._RED.."Sombrivage";
		GREY.."5) Prairie de Talonbranch, ".._RED.."Gangrebois";
		GREY.."6) Pic des Serres-Rocheuses, ".._RED.."Les Serres-Rocheuses";
		GREY.."7) Astranaar, ".._RED.."Ashenvale";
		GREY.."8) Cap Talrendis, ".._RED.."Azshara";
		GREY.."9) Combe de Nijel, ".._RED.."Desolace";
		GREY.."10) Ratchet, ".._RED.."Les Tarides";
		GREY.."11) Ile de Theramore, ".._RED.."Mar\195\169cage d'Aprefange";
		GREY.."12) Feathermoon, ".._RED.."Feralas";
		GREY.."13) Thalanaar, ".._RED.."Feralas";
		GREY.."14) Refuge des Marshal, ".._RED.."Crat\195\168re d'Un'Goro";
		GREY.."15) Fort c\195\169narien, ".._RED.."Silithus";
		GREY.."16) Gadgetzan, ".._RED.."Tanaris";
	};
	FPHordeEast = {
		ZoneName = "Horde (Est)";
		Location = "Royaumes de l'Est";
		GREY.."1) Chapelle de l'Espoir de Lumi\195\168re, ".._RED.."Maleterres de l'est";
		GREY.."2) Undercity, ".._RED.."Clairi\195\168res de Tirisfal";
		GREY.."3) Le S\195\169pulcre, ".._RED.."For\195\170t des Pins argent\195\169s";
		GREY.."4) Moulin-de-Tarren, ".._RED.."Contreforts d'Hillsbrad";
		GREY.."5) Village des Revantusk, ".._RED.."Les Hinterlands";
		GREY.."6) Tr\195\169pas-d'Orgrim, ".._RED.."Hautes-terres d'Arathi";
		GREY.."7) Halte du Thorium, ".._RED.."Gorge des Vents br\195\187lants";
		GREY.."8) Kargath, ".._RED.."Terres ingrates";
		GREY.."9) Corniche des Flammes, ".._RED.."Steppes ardentes";
		GREY.."10) Stonard, ".._RED.."Marais des Chagrins";
		GREY.."11) Camp Grom'Gol, ".._RED.."Vall\195\169e de Strangleronce";
		GREY.."12) Baie-du-Butin, ".._RED.."Vall\195\169e de Strangleronce";
	};
	FPHordeWest = {
		ZoneName = "Horde (Ouest)";
		Location = "Kalimdor";
		GREY.."1) Autel de Remulos, ".._RED.."Reflet-de-Lune";
		GREY.."2) Long-guet, ".._RED.."Berceau-de-l'Hiver";
		GREY.."3) Poste de la V\195\169n\195\169neuse, ".._RED.."Gangrebois";
		GREY.."4) Avant-poste de Zoram'gar, ".._RED.."Ashenvale";
		GREY.."5) Valormok, ".._RED.."Azshara";
		GREY.."6) Poste de Bois-bris\195\169, ".._RED.."Ashenvale";
		GREY.."7) Orgrimmar, ".._RED.."Durotar";
		GREY.."8) Retraite de Roche-Soleil, ".._RED.."Les Serres-Rocheuses";
		GREY.."9) La Crois\195\169e, ".._RED.."Les Tarides";
		GREY.."10) Ratchet, ".._RED.."Les Tarides";
		GREY.."11) Proie-de-l'Ombre, ".._RED.."Desolace";
		GREY.."12) Thunder Bluff, ".._RED.."Mulgore";
		GREY.."13) Camp Taurajo, ".._RED.."Les Tarides";
		GREY.."14) Mur-de-Foug\195\168res, ".._RED.."Mar\195\169cage d'Aprefange";
		GREY.."15) Camp Mojache, ".._RED.."Feralas";
		GREY.."16) Poste de Librevent, ".._RED.."Mille pointes";
		GREY.."17) Refuge des Marshal, ".._RED.."Crat\195\168re d'Un'Goro";
		GREY.."18) Fort c\195\169narien, ".._RED.."Silithus";
		GREY.."19) Gadgetzan, ".._RED.."Tanaris";
	};
};

AtlasDL = {
	DLEast = {
		ZoneName = "Instances (Est)";
		Location = "Royaumes de l'Est";
		BLUE.."A) Vall\195\169e d'Alterac, ".._RED.."Alterac / Hillsbrad";
		BLUE.."B) Bassin d'Arathi, ".._RED.."Hautes-terres d'Arathi";
		GREY.."1) Monast\195\168re \195\169carlate, ".._RED.."Clairi\195\168re de Tirisfal";
		GREY.."2) Stratholme, ".._RED.."Maleterres de l\'Est";
		GREY..INDENT.."Naxxramas, ".._RED.."Stratholme";
		GREY.."3) Scholomance, ".._RED.."Maleterres de l\'Ouest";
		GREY.."4) Donjon d\'Ombrecroc, ".._RED.."For\195\170t des Pins Argent\195\169s";
		GREY.."5) Gnomeregan, ".._RED.."Dun Morogh";
		GREY.."6) Uldaman, ".._RED.."Terres ingrates";
		GREY.."7) Repaire de l\'Aile noire, ".._RED.."Montagne de Blackrock";
		GREY..INDENT.."Profondeurs de Blackrock, ".._RED.."Montagne de Blackrock";
		GREY..INDENT.."Pic Blackrock, ".._RED.."Montagne de Blackrock";
		GREY..INDENT.."C\197\147ur du Magma, ".._RED.."Profondeurs de Blackrock";
		GREY.."8) La Prison, ".._RED.."Cit\195\169 de Stormwind";
		GREY.."9) Les Mortemines, ".._RED.."Marche de l\'Ouest";
		GREY.."10) Zul'Gurub, ".._RED.."Vall\195\169e de Strangleronce";
		GREY.."11) Le temple englouti, ".._RED.."Marais des chagrins";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		BLUE.."Bleu:"..ORNG.." Champs de bataille";
		GREY.."Blanc:"..ORNG.." Instances";
	};
	DLWest = {
		ZoneName = "Instances (Ouest)";
		Location = "Kalimdor";
		BLUE.."A) Goulet des Warsong, ".._RED.."Ashenvale / Tarrides";
		GREY.."1) Profondeurs de Brassenoire, ".._RED.."Ashenvale";
		GREY.."2) Gouffre de Ragefeu, ".._RED.."Orgrimmar";
		GREY.."3) Cavernes des lamentations, ".._RED.."Les Tarrides";
		GREY.."4) Maraudon, ".._RED.."Desolace";
		GREY.."5) Hache-Tripes, ".._RED.."Feralas";
		GREY.."6) Kraal de Tranchebauge, ".._RED.."Les Tarrides";
		GREY.."7) Souilles de Tranchebauge, ".._RED.."Les Tarrides";
		GREY.."8) Repaire d\'Onyxia, ".._RED.."Mar\195\169cage d\'Aprefange";
		GREY.."9) Zul'Farrak, ".._RED.."Tanaris";
		GREY.."10) Ruines d'Ahn'Qiraj, ".._RED.."Silithus";
		GREY..INDENT.." Le temple d'Ahn'Qiraj, ".._RED.."Silithus";
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
		"";
		"";
		BLUE.."Bleu:"..ORNG.." Champs de bataille";
		GREY.."Blanc:"..ORNG.." Instances";
	};
};
AtlasRE = {
   Azuregos = {
      ZoneName = "Azuregos";
      Location = "Azshara";
      GREY.."1) Azuregos";
   };
   FourDragons = {
      ZoneName = "Les dragons du Cauchemar";
      Location = "Divers";
      GREN..INDENT.."Lethon";
      GREN..INDENT.."Emeriss";
      GREN..INDENT.."Taerar";
      GREN..INDENT.."Ysondre";
      "";
      GREY.."1) Bois de la P\195\169nombre(Duskwood)";
      GREY.."2) Les Hinterlands";
      GREY.."3) Feralas";
      GREY.."4) Ashenvale";
   };
   Kazzak = {
      ZoneName = "Kazzak";
      Location = "Terres Foudroy\195\169es(Blasted Lands)";
      GREY.."1) Kazzak";
      GREY.."2) Rempart-du-N\195\169ant";
   };
};
end
