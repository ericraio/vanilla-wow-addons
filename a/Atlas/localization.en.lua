--[[

-- Atlas Data (English)
-- Compiled by Dan Gilbert
-- loglow@gmail.com
-- Last Update: 07/30/2006
-- additions: Niflheim at dragonblight

--]]




AtlasSortIgnore = {
       "the (.+)"
}




ATLAS_TITLE = "Atlas";
ATLAS_SUBTITLE = "Instance Map Browser";
ATLAS_DESC = "Atlas is an instance map browser.";

ATLAS_OPTIONS_BUTTON = "Options";

BINDING_HEADER_ATLAS_TITLE = "Atlas Bindings";
BINDING_NAME_ATLAS_TOGGLE = "Toggle Atlas";
BINDING_NAME_ATLAS_OPTIONS = "Toggle Options";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "options";

ATLAS_STRING_LOCATION = "Location";
ATLAS_STRING_LEVELRANGE = "Level Range";
ATLAS_STRING_PLAYERLIMIT = "Player Limit";
ATLAS_STRING_SELECT_CAT = "Select Category";
ATLAS_STRING_SELECT_MAP = "Select Map";

ATLAS_BUTTON_TOOLTIP = "Atlas";
ATLAS_BUTTON_TOOLTIP2 = "Left-click to open Atlas.";
ATLAS_BUTTON_TOOLTIP3 = "Right-click and drag to move this button.";

ATLAS_OPTIONS_TITLE = "Atlas Options";
ATLAS_OPTIONS_SHOWBUT = "Show Button on Minimap";
ATLAS_OPTIONS_AUTOSEL = "Auto-Select Instance Map";
ATLAS_OPTIONS_BUTPOS = "Button Position";
ATLAS_OPTIONS_TRANS = "Transparency";
ATLAS_OPTIONS_DONE = "Done";
ATLAS_OPTIONS_REPMAP = "Replace the World Map";
ATLAS_OPTIONS_RCLICK = "Right-Click for World Map";
ATLAS_OPTIONS_SHOWMAPNAME = "Show map name";
ATLAS_OPTIONS_RESETPOS = "Reset Position";
ATLAS_OPTIONS_ACRONYMS = "Display Acronyms";

ATLAS_HINT = "Hint: Left-click to open Atlas.";

ATLAS_LOCALE = {
	menu = "Atlas",
	tooltip = "Atlas",
	button = "Atlas"
};

AtlasZoneSubstitutions = {
	["The Temple of Atal'Hakkar"]	= "The Sunken Temple";
	["Ahn'Qiraj"]					= "The Temple of Ahn'Qiraj";
	["Ruins of Ahn'Qiraj"]			= "The Ruins of Ahn'Qiraj";
}; 

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = "   ";

--Keeps track of the different categories of maps
Atlas_MapTypes = {"Instance Maps", "Battleground Maps", "Flight Path Maps", "Dungeon Locations", "Raid Encounters"};

AtlasText = {
	BlackfathomDeeps = {
		ZoneName = "Blackfathom Deeps";
		Acronym = "BFD";
		Location = "Ashenvale";
		BLUE.."A) Entrance";
		GREY.."1) Ghamoo-ra";
		GREY.."2) Lorgalis Manuscript";
		GREY.."3) Lady Sarevess";
		GREY.."4) Argent Guard Thaelrid";
		GREY.."5) Gelihast";
		GREY.."6) Lorgus Jett (Varies)";
		GREY.."7) Baron Aquanis";
		GREY..INDENT.."Fathom Core";
		GREY.."8) Twilight Lord Kelris";
		GREY.."9) Old Serra'kis";
		GREY.."10) Aku'mai";
	};
	BlackrockDepths = {
		ZoneName = "Blackrock Depths";
		Acronym = "BRD";
		Location = "Blackrock Mountain";
		BLUE.."A) Entrance";
		GREY.."1) Lord Roccor";
		GREY.."2) Kharan Mighthammer";
		GREY.."3) Commander Gor'shak";
		GREY.."4) Marshal Windsor";
		GREY.."5) High Interrogator Gerstahn";
		GREY.."6) Ring of Law, Theldren";
		GREY.."7) Mon. of Franclorn Forgewright";
		GREY..INDENT.."Pyromancer Loregrain";
		GREY.."8) The Vault";
		GREY.."9) Fineous Darkvire";
		GREY.."10) The Black Anvil";
		GREY..INDENT.."Lord Incendius";
		GREY.."11) Bael'Gar";
		GREY.."12) Shadowforge Lock";
		GREY.."13) General Angerforge";
		GREY.."14) Golem Lord Argelmach";
		GREY.."15) The Grim Guzzler";
		GREY.."16) Ambassador Flamelash";
		GREY.."17) Panzor the Invincible (Rare)";
		GREY.."18) Summoner's Tomb";
		GREY.."19) The Lyceum";
		GREY.."20) Magmus";
		GREY.."21) Emperor Dagran Thaurissan";
		GREY..INDENT.."Princess Moira Bronzebeard";
		GREY.."22) The Black Forge";
		GREY.."23) Molten Core";
	};
	BlackrockSpireLower = {
		ZoneName = "Blackrock Spire (Lower)";
		Acronym = "LBRS";
		Location = "Blackrock Mountain";
		BLUE.."A) Entrance";
		GREY.."1) Warosh";
		GREY.."2) Roughshod Pike";
		GREY.."3) Highlord Omokk";
		GREY..INDENT.."Spirestone Battle Lord (Rare)";
		GREY.."4) Shadow Hunter Vosh'gajin";
		GREY..INDENT.."Fifth Mosh'aru Tablet";
		GREY.."5) War Master Voone";
		GREY..INDENT.."Sixth Mosh'aru Tablet";
		GREY..INDENT.."Mor Grayhoof";
		GREY.."6) Mother Smolderweb";
		GREY.."7) Crystal Fang (Rare)";
		GREY.."8) Urok Doomhowl";
		GREY.."9) Quartermaster Zigris";
		GREY.."10) Gizrul the Slavener";
		GREY..INDENT.."Halycon";
		GREY.."11) Overlord Wyrmthalak";
		GREY.."12) Bannok Grimaxe (Rare)";
		GREY.."13) Spirestone Butcher (Rare)";
	};
	BlackrockSpireUpper = {
		ZoneName = "Blackrock Spire (Upper)";
		Acronym = "UBRS";
		Location = "Blackrock Mountain";
		BLUE.."A) Entrance";
		GREY.."1) Pyroguard Emberseer";
		GREY.."2) Solakar Flamewreath";
		GREY..INDENT.."Father Flame";
		GREY.."3) Jed Runewatcher (Rare)";
		GREY.."4) Goraluk Anvilcrack";
		GREY.."5) Warchief Rend Blackhand";
		GREY..INDENT.."Gyth";
		GREY.."6) Awbee";
		GREY.."7) The Beast";
		GREY..INDENT.."Lord Valthalak";
		GREY.."8) General Drakkisath";
		GREY..INDENT.."Doomrigger's Clasp";
		GREY.."9) Blackwing Lair";
	};
	BlackwingLair = {
		ZoneName = "Blackwing Lair";
		Acronym = "BWL";
		Location = "Blackrock Spire";
		BLUE.."A) Entrance";
		BLUE.."B) Connects";
		BLUE.."C) Connects";
		GREY.."1) Razorgore the Untamed";
		GREY.."2) Vaelastrasz the Corrupt";
		GREY.."3) Broodlord Lashlayer";
		GREY.."4) Firemaw";
		GREY.."5) Ebonroc";
		GREY.."6) Flamegor";
		GREY.."7) Chromaggus";
		GREY.."8) Nefarian";
		GREY.."9) Master Elemental Shaper Krixix";
	};
	DireMaulEast = {
		ZoneName = "Dire Maul (East)";
		Acronym = "DM";
		Location = "Feralas";
		BLUE.."A) Entrance";
		BLUE.."B) Entrance";
		BLUE.."C) Entrance";
		BLUE.."D) Exit";
		GREY.."1) Pusillin Chase Begins";
		GREY.."2) Pusillin Chase Ends";
		GREY.."3) Zevrim Thornhoof";
		GREY..INDENT.."Hydrospawn";
		GREY..INDENT.."Lethtendris";
		GREY.."4) Old Ironbark";
		GREY.."5) Alzzin the Wildshaper";
		GREY..INDENT.."Isalien";
	};
	DireMaulNorth = {
		ZoneName = "Dire Maul (North)";
		Acronym = "DM";
		Location = "Feralas";
		BLUE.."A) Entrance";
		GREY.."1) Guard Mol'dar";
		GREY.."2) Stomper Kreeg";
		GREY.."3) Guard Fengus";
		GREY.."4) Knot Thimblejack";
		GREY..INDENT.."Guard Slip'kik";
		GREY.."5) Captain Kromcrush";
		GREY.."6) King Gordok";
		GREY.."7) Dire Maul (West)";
		GREN.."1') Library";
	};
	DireMaulWest = {
		ZoneName = "Dire Maul (West)";
		Acronym = "DM";
		Location = "Feralas";
		BLUE.."A) Entrance";
		BLUE.."B) Pylons";
		GREY.."1) Shen'dralar Ancient";
		GREY.."2) Tendris Warpwood";
		GREY.."3) Illyanna Ravenoak";
		GREY.."4) Magister Kalendris";
		GREY.."5) Tsu'Zee (Rare)";
		GREY.."6) Immol'thar";
		GREY..INDENT.."Lord Hel'nurath";
		GREY.."7) Prince Tortheldrin";
		GREY.."8) Dire Maul (North)";
		GREN.."1') Library";
	};
	Gnomeregan = {
		ZoneName = "Gnomeregan";
		Location = "Dun Morogh";
		BLUE.."A) Entrance (Front)";
		BLUE.."B) Entrance (Back)";
		GREY.."1) Viscous Fallout (Lower)";
		GREY.."2) Grubbis";
		GREY.."3) Matrix Punchograph 3005-B";
		GREY.."4) Clean Zone";
		GREY.."5) Electrocutioner 6000";
		GREY..INDENT.."Matrix Punchograph 3005-C";
		GREY.."6) Mekgineer Thermaplugg";
		GREY.."7) Dark Iron Ambassador (Rare)";
		GREY.."8) Crowd Pummeler 9-60";
		GREY..INDENT.."Matrix Punchograph 3005-D";
	};
	Maraudon = {
		ZoneName = "Maraudon";
		Acronym = "Mara";
		Location = "Desolace";
		BLUE.."A) Entrance (Orange)";
		BLUE.."B) Entrance (Purple)";
		BLUE.."C) Entrance (Portal)";
		GREY.."1) Veng (The Fifth Khan)";
		GREY.."2) Noxxion";
		GREY.."3) Razorlash";
		GREY.."4) Maraudos (The Fourth Khan)";
		GREY.."5) Lord Vyletongue";
		GREY.."6) Meshlok the Harvester (Rare)";
		GREY.."7) Celebras the Cursed";
		GREY.."8) Landslide";
		GREY.."9) Tinkerer Gizlock";
		GREY.."10) Rotgrip";
		GREY.."11) Princess Theradras";
	};
	MoltenCore = {
		ZoneName = "Molten Core";
		Acronym = "MC";
		Location = "Blackrock Depths";
		BLUE.."A) Entrance";
		GREY.."1) Lucifron";
		GREY.."2) Magmadar";
		GREY.."3) Gehennas";
		GREY.."4) Garr";
		GREY.."5) Shazzrah";
		GREY.."6) Baron Geddon";
		GREY.."7) Golemagg the Incinerator";
		GREY.."8) Sulfuron Harbinger";
		GREY.."9) Majordomo Executus";
		GREY.."10) Ragnaros";
	};
	OnyxiasLair = {
		ZoneName = "Onyxia's Lair";
		Location = "Dustwallow Marsh";
		BLUE.."A) Entrance";
		GREY.."1) Onyxian Warders";
		GREY.."2) Whelp Eggs";
		GREY.."3) Onyxia";
	};
	RagefireChasm = {
		ZoneName = "Ragefire Chasm";
		Acronym = "RFC";
		Location = "Orgrimmar";
		BLUE.."A) Entrance";
		GREY.."1) Maur Grimtotem";
		GREY.."2) Taragaman the Hungerer";
		GREY.."3) Jergosh the Invoker";
		GREY.."4) Bazzalan";
	};
	RazorfenDowns = {
		ZoneName = "Razorfen Downs";
		Acronym = "RFD";
		Location = "The Barrens";
		BLUE.."A) Entrance";
		GREY.."1) Tuten'kash";
		GREY.."2) Henry Stern";
		GREY..INDENT.."Belnistrasz";
		GREY.."3) Mordresh Fire Eye";
		GREY.."4) Glutton";
		GREY.."5) Ragglesnout (Rare)";
		GREY.."6) Amnennar the Coldbringer";
	};
	RazorfenKraul = {
		ZoneName = "Razorfen Kraul";
		Acronym = "RFK";
		Location = "The Barrens";
		BLUE.."A) Entrance";
		GREY.."1) Roogug";
		GREY.."2) Aggem Thorncurse";
		GREY.."3) Death Speaker Jargba";
		GREY.."4) Overlord Ramtusk";
		GREY.."5) Agathelos the Raging";
		GREY.."6) Blind Hunter (Rare)";
		GREY.."7) Charlga Razorflank";
		GREY.."8) Willix the Importer";
		GREY..INDENT.."Heralath Fallowbrook";
		GREY.."9) Earthcaller Halmgar (Rare)";
	};
	ScarletMonastery = {
		ZoneName = "Scarlet Monastery";
		Acronym = "SM";
		Location = "Tirisfal Glades";
		BLUE.."A) Entrance (Library)";
		BLUE.."B) Entrance (Armory)";
		BLUE.."C) Entrance (Cathedral)";
		BLUE.."D) Entrance (Graveyard)";
		GREY.."1) Houndmaster Loksey";
		GREY.."2) Arcanist Doan";
		GREY.."3) Herod";
		GREY.."4) High Inquisitor Fairbanks";
		GREY.."5) Scarlet Commander Mograine";
		GREY..INDENT.."High Inquisitor Whitemane";
		GREY.."6) Ironspine (Rare)";
		GREY.."7) Azshir the Sleepless (Rare)";
		GREY.."8) Fallen Champion (Rare)";
		GREY.."9) Bloodmage Thalnos";
	};
	Scholomance = {
		ZoneName = "Scholomance";
		Acronym = "Scholo";
		Location = "Western Plaguelands";
		BLUE.."A) Entrance";
		BLUE.."B) Stairway";
		BLUE.."C) Stairway";
		GREY.."1) Blood Steward of Kirtonos";
		GREY..INDENT.."Deed to Southshore";
		GREY.."2) Kirtonos the Herald";
		GREY.."3) Jandice Barov";
		GREY.."4) Deed to Tarren Mill";
		GREY.."5) Rattlegore (Lower)";
		GREY..INDENT.."Death Knight Darkreaver";
		GREY.."6) Marduk Blackpool";
		GREY..INDENT.."Vectus";
		GREY.."7) Ras Frostwhisper";
		GREY..INDENT.."Deed to Brill";
		GREY..INDENT.."Kormok";
		GREY.."8) Instructor Malicia";
		GREY.."9) Doctor Theolen Krastinov";
		GREY.."10) Lorekeeper Polkelt";
		GREY.."11) The Ravenian";
		GREY.."12) Lord Alexei Barov";
		GREY..INDENT.."Deed to Caer Darrow";
		GREY.."13) Lady Illucia Barov";
		GREY.."14) Darkmaster Gandling";
		GREN.."1') Torch Lever";
		GREN.."2') Secret Chest";
		GREN.."3') Alchemy Lab";
	};
	ShadowfangKeep = {
		ZoneName = "Shadowfang Keep";
		Acronym = "SFK";
		Location = "Silverpine Forest";
		BLUE.."A) Entrance";
		BLUE.."B) Walkway";
		BLUE.."C) Walkway";
		BLUE..INDENT.."Deathsworn Captain (Rare)";
		GREY.."1) Deathstalker Adamant";
		GREY..INDENT.."Sorcerer Ashcrombe";
		GREY..INDENT.."Rethilgore";
		GREY.."2) Razorclaw the Butcher";
		GREY.."3) Baron Silverlaine";
		GREY.."4) Commander Springvale";
		GREY.."5) Odo the Blindwatcher";
		GREY.."6) Fenrus the Devourer";
		GREY.."7) Wolf Master Nandos";
		GREY.."8) Archmage Arugal";
	};
	Stratholme = {
		ZoneName = "Stratholme";
		Acronym = "Strat";
		Location = "Eastern Plaguelands";
		BLUE.."A) Entrance (Front)";
		BLUE.."B) Entrance (Side)";
		GREY.."1) Skul (Rare)";
		GREY..INDENT.."Stratholme Courier";
		GREY..INDENT.."Fras Siabi";
		GREY.."2) Hearthsinger Forresten (Varies)";
		GREY.."3) The Unforgiven";
		GREY.."4) Timmy the Cruel";
		GREY.."5) Cannon Master Willey";
		GREY.."6) Archivist Galford";
		GREY.."7) Balnazzar";
		GREY..INDENT.."Sothos";
		GREY..INDENT.."Jarien";
		GREY.."8) Aurius";
		GREY.."9) Stonespine (Rare)";
		GREY.."10) Baroness Anastari";
		GREY.."11) Nerub'enkan";
		GREY.."12) Maleki the Pallid";
		GREY.."13) Magistrate Barthilas (Varies)";
		GREY.."14) Ramstein the Gorger";
		GREY.."15) Baron Rivendare";
		GREN.."1') Crusaders' Square Postbox";
		GREN.."2') Market Row Postbox";
		GREN.."3') Festival Lane Postbox";
		GREN.."4') Elders' Square Postbox";
		GREN.."5') King's Square Postbox";
		GREN.."6') Fras Siabi's Postbox";
	};
	TheDeadmines = {
		ZoneName = "The Deadmines";
		Acronym = "VC";
		Location = "Westfall";
		BLUE.."A) Entrance";
		BLUE.."B) Exit";
		GREY.."1) Rhahk'Zor";
		GREY.."2) Miner Johnson (Rare)";
		GREY.."3) Sneed";
		GREY.."4) Gilnid";
		GREY.."5) Defias Gunpowder";
		GREY.."6) Captain Greenskin";
		GREY..INDENT.."Edwin VanCleef";
		GREY..INDENT.."Mr. Smite";
		GREY..INDENT.."Cookie";
	};
	TheStockade = {
		ZoneName = "The Stockade";
		Location = "Stormwind City";
		BLUE.."A) Entrance";
		GREY.."1) Targorr the Dread (Varies)";
		GREY.."2) Kam Deepfury";
		GREY.."3) Hamhock";
		GREY.."4) Bazil Thredd";
		GREY.."5) Dextren Ward";
		GREY.."6) Bruegal Ironknuckle (Rare)";
	};
	TheSunkenTemple = {
		ZoneName = "The Sunken Temple";
		Acronym = "ST";
		Location = "Swamp of Sorrows";
		BLUE.."A) Entrance";
		BLUE.."B) Stairway";
		BLUE.."C) Troll Minibosses (Upper)";
		GREY.."1) Altar of Hakkar";
		GREY..INDENT.."Atal'alarion";
		GREY.."2) Dreamscythe";
		GREY..INDENT.."Weaver";
		GREY.."3) Avatar of Hakkar";
		GREY.."4) Jammal'an the Prophet";
		GREY..INDENT.."Ogom the Wretched";
		GREY.."5) Morphaz";
		GREY..INDENT.."Hazzas";
		GREY.."6) Shade of Eranikus";
		GREY..INDENT.."Essence Font";
		GREN.."1'-6') Statue Activation Order";
	};
	Uldaman = {
		ZoneName = "Uldaman";
		Acronym = "Ulda";
		Location = "Badlands";
		BLUE.."A) Entrance (Front)";
		BLUE.."B) Entrance (Back)";
		GREY.."1) Baelog";
		GREY.."2) Remains of a Paladin";
		GREY.."3) Revelosh";
		GREY.."4) Ironaya";
		GREY.."5) Obsidian Sentinel";
		GREY.."6) Annora (Master Enchanter)";
		GREY.."7) Ancient Stone Keeper";
		GREY.."8) Galgann Firehammer";
		GREY.."9) Grimlok";
		GREY.."10) Archaedas (Lower)";
		GREY.."11) The Discs of Norgannon";
		GREY..INDENT.."Ancient Treasure (Lower)";
	};
	WailingCaverns = {
		ZoneName = "Wailing Caverns";
		Acronym = "WC";
		Location = "The Barrens";
		BLUE.."A) Entrance";
		GREY.."1) Disciple of Naralex";
		GREY.."2) Lord Cobrahn";
		GREY.."3) Lady Anacondra";
		GREY.."4) Kresh";
		GREY.."5) Lord Pythas";
		GREY.."6) Skum";
		GREY.."7) Lord Serpentis (Upper)";
		GREY.."8) Verdan the Everliving (Upper)";
		GREY.."9) Mutanus the Devourer";
		GREY..INDENT.."Naralex";
		GREY.."10) Deviate Faerie Dragon (Rare)";
	};
	ZulFarrak = {
		ZoneName = "Zul'Farrak";
		Acronym = "ZF";
		Location = "Tanaris";
		BLUE.."A) Entrance";
		GREY.."1) Antu'sul";
		GREY.."2) Theka the Martyr";
		GREY.."3) Witch Doctor Zum'rah";
		GREY..INDENT.."Zul'Farrak Dead Hero";
		GREY.."4) Nekrum Gutchewer";
		GREY..INDENT.."Shadowpriest Sezz'ziz";
		GREY.."5) Sergeant Bly";
		GREY.."6) Hydromancer Velratha";
		GREY..INDENT.."Gahz'rilla";
		GREY..INDENT.."Dustwraith (Rare)";
		GREY.."7) Chief Ukorz Sandscalp";
		GREY..INDENT.."Ruuzlu";
		GREY.."8) Zerillis (Rare, Wanders)";
		GREY.."9) Sandarr Dunereaver (Rare)";
	};
	ZulGurub = {
		ZoneName = "Zul'Gurub";
		Acronym = "ZG";
		Location = "Stranglethorn Vale";
		BLUE.."A) Entrance";
		GREY.."1) High Priestess Jeklik (Bat)";
		GREY.."2) High Priest Venoxis (Snake)";
		GREY.."3) High Priestess Mar'li (Spider)";
		GREY.."4) Bloodlord Mandokir (Raptor, Optional)";
		GREY.."5) Edge of Madness (Optional)";
		GREY..INDENT.."Gri'lek, of the Iron Blood";
		GREY..INDENT.."Hazza'rah, the Dreamweaver";
		GREY..INDENT.."Renataki, of the Thousand Blades";
		GREY..INDENT.."Wushoolay, the Storm Witch";
		GREY.."6) Gahz'ranka (Optional)";
		GREY.."7) High Priest Thekal (Tiger)";
		GREY.."8) High Priestess Arlokk (Panther)";
		GREY.."9) Jin'do the Hexxer (Undead, Optional)";
		GREY.."10) Hakkar";
		GREN.."1') Muddy Churning Waters";
	};
	TheTempleofAhnQiraj = {
		ZoneName = "The Temple of Ahn'Qiraj";
		Acronym = "AQ40";
		Location = "Silithus";
		BLUE.."A) Entrance";
		GREY.."1) The Prophet Skeram (Outside)";
		GREY.."2) Vem & Co (Optional)";
		GREY.."3) Battleguard Sartura";
		GREY.."4) Fankriss the Unyielding";
		GREY.."5) Viscidus (Optional)";
		GREY.."6) Princess Huhuran";
		GREY.."7) Twin Emperors";
		GREY.."8) Ouro (Optional)";
		GREY.."9) Eye of C'Thun / C'Thun";
		GREN.."1') Andorgos";
		GREN..INDENT.."Vethsera";
		GREN..INDENT.."Kandrostrasz";
		GREN.."2') Arygos";
		GREN..INDENT.."Caelestrasz";
		GREN..INDENT.."Merithra of the Dream";
	};
	TheRuinsofAhnQiraj = {
		ZoneName = "The Ruins of Ahn'Qiraj";
		Acronym = "AQ20";
		Location = "Silithus";
		BLUE.."A) Entrance";
		GREY.."1) Kurinnaxx";
		GREY..INDENT.."Lieutenant General Andorov";
		GREY..INDENT.."Four Kaldorei Elites";
		GREY.."2) General Rajaxx";
		GREY..INDENT.."Captain Qeez";
		GREY..INDENT.."Captain Tuubid";
		GREY..INDENT.."Captain Drenn";
		GREY..INDENT.."Captain Xurrem";
		GREY..INDENT.."Major Yeggeth";
		GREY..INDENT.."Major Pakkon";
		GREY..INDENT.."Colonel Zerran";
		GREY.."3) Moam (Optional)";
		GREY.."4) Buru the Gorger (Optional)";
		GREY.."5) Ayamiss the Hunter (Optional)";
		GREY.."6) Ossirian the Unscarred";
		GREN.."1') Safe Room";
	};
	Naxxramas = {
		ZoneName = "Naxxramas";
		Acronym = "Nax";
		Location = "Stratholme";
		BLUE.."Abomination Wing";
		BLUE..INDENT.."1) Patchwerk";
		BLUE..INDENT.."2) Grobbulus";
		BLUE..INDENT.."3) Gluth";
		BLUE..INDENT.."4) Thaddius";
		ORNG.."Spider Wing";
		ORNG..INDENT.."1) Anub'Rekhan";
		ORNG..INDENT.."2) Grand Widow Faerlina";
		ORNG..INDENT.."3) Maexxna";
		_RED.."Deathknight Wing";
		_RED..INDENT.."1) Instructor Razuvious";
		_RED..INDENT.."2) Gothik the Harvester";
		_RED..INDENT.."3) The Four Horsemen";
		_RED..INDENT..INDENT.."Thane Korth'azz";
		_RED..INDENT..INDENT.."Lady Blaumeux";
		_RED..INDENT..INDENT.."Highlord Mograine";
		_RED..INDENT..INDENT.."Sir Zeliek";
		PURP.."Necro Wing";
		PURP..INDENT.."1) Noth the Plaguebringer";
		PURP..INDENT.."2) Heigan the Unclean";
		PURP..INDENT.."3) Loatheb";
		GREN.."Frostwyrm Lair";
		GREN..INDENT.."1) Sapphiron";
		GREN..INDENT.."2) Kel'Thuzad";
	};
};


AtlasBG = {
	AlteracValleyNorth = {
		ZoneName = "Alterac Valley (North)";
		Location = "Alterac Mountains";
		BLUE.."A) Entrance";
		BLUE.."B) Dun Baldar (Alliance)";
		_RED.."1) Stormpike Aid Station";
		_RED.."2) Stormpike Graveyard";
		_RED.."3) Stonehearth Graveyard";
		_RED.."4) Snowfall Graveyard";
		ORNG.."5) Dun Baldar North Bunker";
		GREY..INDENT.."Wing Commander Mulverick (Horde)";
		ORNG.."6) Dun Baldar South Bunker";
		ORNG.."7) Icewing Bunker";
		GREY..INDENT.."Wing Commander Guse (Horde)";
		GREY..INDENT.."Commander Karl Philips (Alliance)";
		ORNG.."8) Stonehearth Outpost (Balinda)";
		ORNG.."9) Stonehearth Bunker";
		GREY.."10) Irondeep Mine";
		GREY.."11) Icewing Cavern";
		GREY.."12) Steamsaw (Horde)";
		GREY.."13) Wing Commander Jeztor (Horde)";
		GREY.."14) Ivus the Forest Lord (Summon Zone)";
		"";
		"";
		"";
		"";
		"";
		_RED.."Red:"..BLUE.." Graveyards, Capturable Areas";
		ORNG.."Orange:"..BLUE.." Bunkers, Towers, Destroyable Areas";
		GREY.."White:"..BLUE.." Assault NPCs, Quest Areas";
	};
	AlteracValleySouth = {
		ZoneName = "Alterac Valley (South)";
		Location = "Hillsbrad Foothills";
		BLUE.."A) Entrance";
		BLUE.."B) Frostwolf Keep (Horde)";
		_RED.."1) Frostwolf Releif Hut";
		_RED.."2) Frostwolf Graveyard";
		_RED.."3) Iceblood Graveyard";
		ORNG.."4) West Frostwolf Tower";
		ORNG.."5) East Frostwolf Tower";
		GREY..INDENT.."Wing Commander Ichman (Alliance)";
		ORNG.."6) Tower Point";
		GREY..INDENT.."Wing Commander Slidore (Alliance)";
		GREY..INDENT.."Commander Louis Philips (Horde)";
		ORNG.."7) Iceblood Tower";
		ORNG.."8) Iceblood Garrison (Galvangar)";
		GREY.."9) Wildpaw Cavern";
		GREY.."10) Wolf Rider Commander";
		GREY.."11) Wing Commander Vipore (Alliance)";
		GREY.."12) Coldtooth Mine";
		GREY.."13) Steamsaw (Alliance)";
		GREY.."14) Lokholar the Ice Lord (Summon Zone)";
		"";
		"";
		"";
		"";
		"";
		_RED.."Red:"..BLUE.." Graveyards, Capturable Areas";
		ORNG.."Orange:"..BLUE.." Bunkers, Towers, Destroyable Areas";
		GREY.."White:"..BLUE.." Assault NPCs, Quest Areas";
	};
	ArathiBasin = {
		ZoneName = "Arathi Basin";
		Location = "Arathi Highlands";
		BLUE.."A) Trollbane Hall (Alliance)";
		BLUE.."B) Defiler's Den (Horde)";
		GREY.."1) Stables";
		GREY.."2) Gold Mine";
		GREY.."3) Smithy";
		GREY.."4) Lumber Mill";
		GREY.."5) Farm";
	};
	WarsongGulch = {
		ZoneName = "Warsong Gulch";
		Location = "Ashenvale / The Barrens";
		BLUE.."A) Silverwing Hold (Alliance)";
		BLUE.."B) Warsong Lumber Mill (Horde)";
	};
};

AtlasFP = {
	FPAllianceEast = {
		ZoneName = "Alliance (East)";
		Location = "Eastern Kingdoms";
		GREY.."1) Light's Hope Chapel, ".._RED.."Eastern Plaguelands";
		GREY.."2) Chillwind Post, ".._RED.."Western Plaguelands";
		GREY.."3) Aerie Peak, ".._RED.."The Hinterlands";
		GREY.."4) Southshore, ".._RED.."Hillsbrad Foothills";
		GREY.."5) Refuge Point, ".._RED.."Arathi Highlands";
		GREY.."6) Menethil Harbor, ".._RED.."Wetlands";
		GREY.."7) Ironforge, ".._RED.."Dun Morogh";
		GREY.."8) Thelsamar, ".._RED.."Loch Modan";
		GREY.."9) Thorium Point, ".._RED.."Searing Gorge";
		GREY.."10) Morgan's Vigil, ".._RED.."Burning Steppes";
		GREY.."11) Stormwind, ".._RED.."Elwyn Forest";
		GREY.."12) Lakeshire, ".._RED.."Redridge Mountains";
		GREY.."13) Sentinel Hill, ".._RED.."Westfall";
		GREY.."14) Darkshire, ".._RED.."Duskwood";
		GREY.."15) Netherguard Keep, ".._RED.."The Blasted Lands";
		GREY.."16) Booty Bay, ".._RED.."Stranglethorn Vale";
	};
	FPAllianceWest = {
		ZoneName = "Alliance (West)";
		Location = "Kalimdor";
		GREY.."1) Rut'Theran Village, ".._RED.."Teldrassil";
		GREY.."2) Shrine of Remulos, ".._RED.."Moonglade";
		GREY.."3) Everlook, ".._RED.."Winterspring";
		GREY.."4) Auberdine, ".._RED.."Darkshore";
		GREY.."5) Talonbranch Glade, ".._RED.."Felwood";
		GREY.."6) Stonetalon Peak, ".._RED.."Stonetalon Mountains";
		GREY.."7) Astranaar, ".._RED.."Ashenvale Forest";
		GREY.."8) Talrendis Point, ".._RED.."Azshara";
		GREY.."9) Nijel's Point, ".._RED.."Desolace";
		GREY.."10) Ratchet, ".._RED.."The Barrens";
		GREY.."11) Theramore Isle, ".._RED.."Dustwallow Marsh";
		GREY.."12) Feathermoon Stronghold, ".._RED.."Ferelas";
		GREY.."13) Thalanaar, ".._RED.."Ferelas";
		GREY.."14) Marshall's Refuge, ".._RED.."Un'Goro Crater";
		GREY.."15) Cenarion Hold, ".._RED.."Silithus";
		GREY.."16) Gadgetzan, ".._RED.."Tanaris Desert";
	};
	FPHordeEast = {
		ZoneName = "Horde (East)";
		Location = "Eastern Kingdoms";
		GREY.."1) Light's Hope Chapel, ".._RED.."Eastern Plaguelands";
		GREY.."2) Undercity, ".._RED.."Tirisfal Glade";
		GREY.."3) The Sepulcher, ".._RED.."Silverpine Forest";
		GREY.."4) Tarren Mill, ".._RED.."Hillsbrad Foothills";
		GREY.."5) Revantusk Village, ".._RED.."The Hinterlands";
		GREY.."6) Hammerfall, ".._RED.."Arathi Highlands";
		GREY.."7) Thorium Point, ".._RED.."Searing Gorge";
		GREY.."8) Kargath, ".._RED.."Badlands";
		GREY.."9) Flame Crest, ".._RED.."Burning Steppes";
		GREY.."10) Stonard, ".._RED.."Swamp of Sorrows";
		GREY.."11) Grom'Gol, ".._RED.."Stranglethorn Vale";
		GREY.."12) Booty Bay, ".._RED.."Stranglethorn Vale";
	};
	FPHordeWest = {
		ZoneName = "Horde (West)";
		Location = "Kalimdor";
		GREY.."1) Shrine of Remulos, ".._RED.."Moonglade";
		GREY.."2) Everlook, ".._RED.."Winterspring";
		GREY.."3) Bloodvenom Post, ".._RED.."Felwood";
		GREY.."4) Zoram'gar Outpost, ".._RED.."Ashenvale";
		GREY.."5) Valormok, ".._RED.."Azshara";
		GREY.."6) Splintertree Post, ".._RED.."Ashenvale";
		GREY.."7) Orgrimmar, ".._RED.."Durotar";
		GREY.."8) Sunrock Retreat, ".._RED.."Stonetalon Mountains";
		GREY.."9) Crossroads, ".._RED.."The Barrens";
		GREY.."10) Ratchet, ".._RED.."The Barrens";
		GREY.."11) Shadowprey Village, ".._RED.."Desolace";
		GREY.."12) Thunder Bluff, ".._RED.."Mulgore";
		GREY.."13) Camp Taurajo, ".._RED.."The Barrens";
		GREY.."14) Brackenwall Village, ".._RED.."Dustwallow Marsh";
		GREY.."15) Camp Mojache, ".._RED.."Ferelas";
		GREY.."16) Freewind Post, ".._RED.."Thousand Needles";
		GREY.."17) Marshall's Refuge, ".._RED.."Un'Goro Crater";
		GREY.."18) Cenarion Hold, ".._RED.."Silithus";
		GREY.."19) Gadgetzan, ".._RED.."Tanaris Desert";
	};
};

AtlasDL = {
	DLEast = {
		ZoneName = "Dungeon Locations (East)";
		Location = "Eastern Kingdoms";
		BLUE.."A) Alterac Valley, ".._RED.."Alterac / Hillsbrad";
		BLUE.."B) Arathi Basin, ".._RED.."Arathi Highlands";
		GREY.."1) Scarlet Monastery, ".._RED.."Tirisfal Glade";
		GREY.."2) Stratholme, ".._RED.."Eastern Plaguelands";
		GREY..INDENT.."Naxxramas, ".._RED.."Stratholme";
		GREY.."3) Scholomance, ".._RED.."Western Plaguelands";
		GREY.."4) Shadowfang Keep, ".._RED.."Silverpine Forest";
		GREY.."5) Gnomeregan, ".._RED.."Dun Morogh";
		GREY.."6) Uldaman, ".._RED.."Badlands";
		GREY.."7) Blackwing Lair, ".._RED.."Blackrock Spire";
		GREY..INDENT.."Blackrock Depths, ".._RED.."Blackrock Mountain";
		GREY..INDENT.."Blackrock Spire, ".._RED.."Blackrock Mountain";
		GREY..INDENT.."Molten Core, ".._RED.."Blackrock Depths";
		GREY.."8) The Stockade, ".._RED.."Stormwind City";
		GREY.."9) The Deadmines, ".._RED.."Westfall";
		GREY.."10) Zul'Gurub, ".._RED.."Stranglethorn Vale";
		GREY.."11) The Sunken Temple, ".._RED.."Swamp of Sorrows";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		BLUE.."Blue:"..ORNG.." Battlegrounds";
		GREY.."White:"..ORNG.." Instances";
	};
	DLWest = {
		ZoneName = "Dungeon Locations (West)";
		Location = "Kalimdor";
		BLUE.."A) Warsong Gulch, ".._RED.."The Barrens / Ashenvale";
		GREY.."1) Blackfathom Deeps, ".._RED.."Ashenvale";
		GREY.."2) Ragefire Chasm, ".._RED.."Orgrimmar";
		GREY.."3) Wailing Caverns, ".._RED.."The Barrens";
		GREY.."4) Maraudon, ".._RED.."Desolace";
		GREY.."5) Dire Maul, ".._RED.."Feralas";
		GREY.."6) Razorfen Kraul, ".._RED.."The Barrens";
		GREY.."7) Razorfen Downs, ".._RED.."The Barrens";
		GREY.."8) Onyxia's Lair, ".._RED.."Dustwallow Marsh";
		GREY.."9) Zul'Farrak, ".._RED.."Tanaris";
		GREY.."10) The Ruins of Ahn'Qiraj, ".._RED.."Silithus";
		GREY..INDENT.."The Temple of Ahn'Qiraj, ".._RED.."Silithus";
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
		BLUE.."Blue:"..ORNG.." Battlegrounds";
		GREY.."White:"..ORNG.." Instances";
	};
};

AtlasRE = {
	Azuregos = {
		ZoneName = "Azuregos";
		Location = "Azshara";
		GREY.."1) Azuregos";
	};
	FourDragons = {
		ZoneName = "Dragons of Nightmare";
		Location = "Various";
		GREN..INDENT.."Lethon";
		GREN..INDENT.."Emeriss";
		GREN..INDENT.."Taerar";
		GREN..INDENT.."Ysondre";
		"";
		GREY.."1) Duskwood";
		GREY.."2) The Hinterlands";
		GREY.."3) Feralas";
		GREY.."4) Ashenvale";
	};
	Kazzak = {
		ZoneName = "Lord Kazzak";
		Location = "Blasted Lands";
		GREY.."1) Lord Kazzak";
		GREY.."2) Nethergarde Keep";
	};
};
