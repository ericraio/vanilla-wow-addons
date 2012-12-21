local MAJOR_VERSION = "Boss 1.1"
local MINOR_VERSION = tonumber(string.sub("$Revision: 2380 $", 12, -3))

if BabbleLib and BabbleLib.versions[MAJOR_VERSION] and BabbleLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

local locale = GetLocale and GetLocale() or "enUS"
if locale ~= "frFR" and locale ~= "deDE" and locale ~= "zhCN" and locale ~= "koKR" then
	locale = "enUS"
end

local initBosses, bosses
if locale == "enUS" then
	function initBosses()
		bosses = {
			-- Raid bosses
			NEFARIAN = "Nefarian",
			VAELASTRASZ_THE_CORRUPT = "Vaelastrasz the Corrupt",
			RAZORGORE_THE_UNTAMED = "Razorgore the Untamed",
			BROODLORD_LASHLAYER = "Broodlord Lashlayer",
			CHROMAGGUS = "Chromaggus",
			EBONROC = "Ebonroc",
			FIREMAW = "Firemaw",
			FLAMEGOR = "Flamegor",
			MAJORDOMO_EXECUTUS = "Majordomo Executus",
			RAGNAROS = "Ragnaros",
			BARON_GEDDON = "Baron Geddon",
			GOLEMAGG_THE_INCINERATOR = "Golemagg the Incinerator",
			GARR = "Garr",
			SULFURON_HARBINGER = "Sulfuron Harbinger",
			SHAZZRAH = "Shazzrah",
			LUCIFRON = "Lucifron",
			GEHENNAS = "Gehennas",
			MAGMADAR = "Magmadar",
			ONYXIA = "Onyxia",
			AZUREGOS = "Azuregos",
			LORD_KAZZAK = "Lord Kazzak",
			YSONDRE = "Ysondre",
			EMERISS = "Emeriss",
			TAERAR = "Taerar",
			LETHON = "Lethon",
			HIGH_PRIESTESS_JEKLIK = "High Priestess Jeklik",
			HIGH_PRIEST_VENOXIS = "High Priest Venoxis",
			HIGH_PRIEST_THEKAL = "High Priest Thekal",
			HIGH_PRIESTESS_ARLOKK = "High Priestess Arlokk",
			HIGH_PRIESTESS_MAR_LI = "High Priestess Mar'li",
			JIN_DO_THE_HEXXER = "Jin'do the Hexxer",
			BLOODLORD_MANDOKIR = "Bloodlord Mandokir",
			GAHZ_RANKA = "Gahz'ranka",
			GRI_LEK = "Gri'lek",
			HAZZA_RAH = "Hazza'rah",
			RENATAKI = "Renataki",
			WUSHOOLAY = "Wushoolay",
			HAKKAR = "Hakkar",
			AYAMISS_THE_HUNTER = "Ayamiss the Hunter",
			BURU_THE_GORGER = "Buru the Gorger",
			GENERAL_RAJAXX = "General Rajaxx",
			ANUBISATH_GUARDIAN = "Anubisath Guardian",
			OSSIRIAN_THE_UNSCARRED = "Ossirian the Unscarred",
			LORD_KRI = "Lord Kri",
			PRINCESS_YAUJ = "Princess Yauj",
			VEM = "Vem",
			EYE_OF_CTHUN = "Eye of C'Thun",
			ANUBISATH_DEFENDER = "Anubisath Defender",
			FANKRISS_THE_UNYIELDING = "Fankriss the Unyielding",
			PRINCESS_HUHURAN = "Princess Huhuran",
			OURO = "Ouro",
			BATTLEGUARD_SARTURA = "Battleguard Sartura",
			THE_PROPHET_SKERAM = "The Prophet Skeram",
			EMPEROR_VEKLOR = "Emperor Vek'lor",
			EMPEROR_VEKNILASH = "Emperor Vek'nilash",
			VISCIDUS = "Viscidus",
			-- Regular bosses
			ALZZIN_THE_WILDSHAPER = "Alzzin the Wildshaper",
			AMBASSADOR_FLAMELASH = "Ambassador Flamelash",
			ANGER_REL = "Anger'rel",
			ARCHIVIST_GALFORD = "Archivist Galford",
			ATAL_ALARION = "Atal'alarion",
			AVATAR_OF_HAKKAR = "Avatar of Hakkar",
			BAEL_GAR = "Bael'Gar",
			BALNAZZAR = "Balnazzar",
			BARONESS_ANASTARI = "Baroness Anastari",
			BARON_RIVENDARE = "Baron Rivendare",
			CANNON_MASTER_WILLEY = "Cannon Master Willey",
			CAPTAIN_KROMCRUSH = "Captain Kromcrush",
			CELEBRAS_THE_CURSED = "Celebras the Cursed",
			CRYSTAL_FANG = "Crystal Fang",
			DARKMASTER_GANDLING = "Darkmaster Gandling",
			DOCTOR_THEOLEN_KRASTINOV = "Doctor Theolen Krastinov",
			DOOM_REL = "Doom'rel",
			DOPE_REL = "Dope'rel",
			DREAMSCYTHE = "Dreamscythe",
			EMPEROR_DAGRAN_THAURISSAN = "Emperor Dagran Thaurissan",
			FINEOUS_DARKVIRE = "Fineous Darkvire",
			GASHER = "Gasher",
			GENERAL_ANGERFORGE = "General Angerforge",
			GENERAL_DRAKKISATH = "General Drakkisath",
			GLOOM_REL = "Gloom'rel",
			GOLEM_LORD_ARGELMACH = "Golem Lord Argelmach",
			GORALUK_ANVILCRACK = "Goraluk Anvilcrack",
			GUARD_FENGUS = "Guard Fengus",
			GUARD_MOL_DAR = "Guard Mol'dar",
			GUARD_SLIP_KIK = "Guard Slip'kik",
			GYTH = "Gyth",
			HALYCON = "Halycon",
			HATE_REL = "Hate'rel",
			HAZZAS = "Hazzas",
			HEARTHSINGER_FORRESTEN = "Hearthsinger Forresten",
			HIGH_INTERROGATOR_GERSTAHN = "High Interrogator Gerstahn",
			HIGHLORD_OMOKK = "Highlord Omokk",
			HUKKU = "Hukku",
			HURLEY_BLACKBREATH = "Hurley Blackbreath",
			HYDROSPAWN = "Hydrospawn",
			ILLYANNA_RAVENOAK = "Illyanna Ravenoak",
			IMMOL_THAR = "Immol'thar",
			INSTRUCTOR_MALICIA = "Instructor Malicia",
			JAMMAL_AN_THE_PROPHET = "Jammal'an the Prophet",
			JANDICE_BAROV = "Jandice Barov",
			KING_GORDOK = "King Gordok",
			KIRTONOS_THE_HERALD = "Kirtonos the Herald",
			LADY_ILLUCIA_BAROV = "Lady Illucia Barov",
			LANDSLIDE = "Landslide",
			LETHTENDRIS = "Lethtendris",
			LORD_ALEXEI_BAROV = "Lord Alexei Barov",
			LORD_INCENDIUS = "Lord Incendius",
			LORD_VYLETONGUE = "Lord Vyletongue",
			LOREKEEPER_POLKELT = "Lorekeeper Polkelt",
			LORO = "Loro",
			MAGISTER_KALENDRIS = "Magister Kalendris",
			MAGISTRATE_BARTHILAS = "Magistrate Barthilas",
			MAGMUS = "Magmus",
			MALEKI_THE_PALLID = "Maleki the Pallid",
			MARDUK_BLACKPOOL = "Marduk Blackpool",
			MESHLOK_THE_HARVESTER = "Meshlok the Harvester",
			MIJAN = "Mijan",
			MORPHAZ = "Morphaz",
			MOTHER_SMOLDERWEB = "Mother Smolderweb",
			NERUB_ENKAN = "Nerub'enkan",
			NOXXION = "Noxxion",
			OGOM_THE_WRETCHED = "Ogom the Wretched",
			OVERLORD_WYRMTHALAK = "Overlord Wyrmthalak",
			PHALANX = "Phalanx",
			PLUGGER_SPAZZRING = "Plugger Spazzring",
			POSTMASTER_MALOWN = "Postmaster Malown",
			PRINCESS_MOIRA_BRONZEBEARD = "Princess Moira Bronzebeard",
			PRINCESS_THERADRAS = "Princess Theradras",
			PRINCE_TORTHELDRIN = "Prince Tortheldrin",
			PUSILLIN = "Pusillin",
			PYROGUARD_EMBERSEER = "Pyroguard Emberseer",
			RAMSTEIN_THE_GORGER = "Ramstein the Gorger",
			RAS_FROSTWHISPER = "Ras Frostwhisper",
			RATTLEGORE = "Rattlegore",
			RAZORLASH = "Razorlash",
			WARCHIEF_REND_BLACKHAND = "Warchief Rend Blackhand",
			RIBBLY_SCREWSPIGOT = "Ribbly Screwspigot",
			ROTGRIP = "Rotgrip",
			SEETH_REL = "Seeth'rel",
			SHADE_OF_ERANIKUS = "Shade of Eranikus",
			SHADOW_HUNTER_VOSH_GAJIN = "Shadow Hunter Vosh'gajin",
			SOLAKAR_FLAMEWREATH = "Solakar Flamewreath",
			STOMPER_KREEG = "Stomper Kreeg",
			TENDRIS_WARPWOOD = "Tendris Warpwood",
			THE_BEAST = "The Beast",
			THE_RAVENIAN = "The Ravenian",
			TIMMY_THE_CRUEL = "Timmy the Cruel",
			TINKERER_GIZLOCK = "Tinkerer Gizlock",
			TSU_ZEE = "Tsu'zee",
			VECTUS = "Vectus",
			VILE_REL = "Vile'rel",
			WAR_MASTER_VOONE = "War Master Voone",
			WEAVER = "Weaver",
			ZEVRIM_THORNHOOF = "Zevrim Thornhoof",
			ZOLO = "Zolo",
 			ZUL_LOR = "Zul'Lor",
		}
	end
elseif locale == "deDE" then
	function initBosses()
		bosses = {
			-- Raid Bosses
			NEFARIAN = "Nefarian",
			VAELASTRASZ_THE_CORRUPT = "Vaelastrasz der Verdorbene",
			RAZORGORE_THE_UNTAMED = "Razorgore der Ungez\195\164hmte",
			BROODLORD_LASHLAYER = "Brutlord Lashlayer",
			CHROMAGGUS = "Chromaggus",
			EBONROC = "Schattenschwinge",
			FIREMAW = "Feuerschwinge",
			FLAMEGOR = "Flammenmaul",
			MAJORDOMO_EXECUTUS = "Majordomus Executus",
			RAGNAROS = "Ragnaros",
			BARON_GEDDON = "Baron Geddon",
			GOLEMAGG_THE_INCINERATOR = "Golemagg der Verbrenner",
			GARR = "Garr",
			SULFURON_HARBINGER = "Sulfuron-Herold",
			SHAZZRAH = "Shazzrah",
			LUCIFRON = "Lucifron",
			GEHENNAS = "Gehennas",
			MAGMADAR = "Magmadar",
			ONYXIA = "Onyxia",
			AZUREGOS = "Azuregos",
			EMERISS = "Emeriss",
			TAERAR = "Taerar",
			LETHON = "Lethon",
			JIN_DO_THE_HEXXER = "Jin'do der Verhexer",
			BLOODLORD_MANDOKIR = "Blutf\195\188rst Mandokir",
			HAKKAR = "Hakkar",
			LORD_KAZZAK = "Lord Kazzak",
			YSONDRE = "Ysondre",
			HIGH_PRIESTESS_JEKLIK = "Hohepriesterin Jeklik",
			HIGH_PRIEST_vENOXIS = "Hohepriester Venoxis",
			HIGH_PRIEST_THEKAL = "Hohepriester Thekal",
			HIGH_PRIESTESS_ARLOKK = "Hohepriesterin Arlokk",
			HIGH_PRIESTESS_MAR_LI = "Hohepriesterin Mar'li",
			GAHZ_RANKA = "Gahz'ranka",
			GRI_LEK = "Gri'lek",
			HAZZA_RAH = "Hazza'rah",
			RENATAKI = "Renataki",
			WUSHOOLAY = "Wushoolay",
			AYAMISS_THE_HUNTER = "Ayamiss der Jäger",
			BURU_THE_GORGER = "Buru der Verschlinger",
			GENERAL_RAJAXX = "General Rajaxx",
			ANUBISATH_GUARDIAN = "Beschützer des Anubisath",
			OSSIRIAN_THE_UNSCARRED = "Ossirian der Narbenlose",
			LORD_KRI = "Lord Kri",
			PRINCESS_YAUJ = "Prinzessin Yauj",
			VEM = "Vem",
			EYE_OF_CTHUN = "Auge von C'Thun",
			ANUBISATH_DEFENDER = "Verteidiger des Anubisath",
			FANKRISS_THE_UNYIELDING = "Fankriss der Unnachgiebige",
			PRINCESS_HUHURAN = "Prinzessin Huhuran",
			OURO = "Ouro",
			BATTLEGUARD_SARTURA = "Schlachtwache Sartura",
			THE_PROPHET_SKERAM = "Der Prophet Skeram",
			EMPEROR_VEKLOR = "Imperator Vek'lor",
			EMPEROR_VEKNILASH = "Imperator Vek'nilash",
			VISCIDUS = "Viscidus",
			-- Regular Bosses
			ALZZIN_THE_WILDSHAPER = "Alzzin der Wildformer",
			AMBASSADOR_FLAMELASH = "Botschafter Flamelash",
			ANGER_REL = "Anger'rel",
			ARCHIVIST_GALFORD = "Archivar Galford",
			ATAL_ALARION = "Atal'alarion",
			AVATAR_OF_HAKKAR = "Avatar von Hakkar",
			BAEL_GAR = "Bael'Gar",
			BALNAZZAR = "Balnazzar",
			BARONESS_ANASTARI = "Baroness Anastari",
			BARON_RIVENDARE = "Baron Rivendare",
			CAPTAIN_KROMCRUSH = "Captain Kromcrush",
			CELEBRAS_THE_CURSED = "Celebras der Verfluchte",
			CRYSTAL_FANG = "Kristallfangzahn",
			DARKMASTER_GANDLING = "Dunkelmeister Gandling",
			DOCTOR_THEOLEN_KRASTINOV = "Doktor Theolen Krastinov",
			DOOM_REL = "Doom'rel",
			DOPE_REL = "Dope'rel",
			DREAMSCYTHE = "Traumsense",
			FINEOUS_DARKVIRE = "Fineous Darkvire",
			GASHER = "Gasher",
			GENERAL_ANGERFORGE = "General Angerforge",
			GENERAL_DRAKKISATH = "General Drakkisath",
			GLOOM_REL = "Gloom'rel",
			GOLEM_LORD_ARGELMACH = "Golemlord Argelmach",
			GORALUK_ANVILCRACK = "Goraluk Anvilcrack",
			GYTH = "Gyth",
			HALYCON = "Halycon",
			HATE_REL = "Hate'rel",
			HAZZAS = "Hazzas",
			HEARTHSINGER_FORRESTEN = "Herdsinger Forresten",
			HIGHLORD_OMOKK = "Hochlord Omokk",
			HUKKU = "Hukku",
			HURLEY_BLACKBREATH = "Hurley Blackbreath",
			HYDROSPAWN = "Hydrobrut",
			ILLYANNA_RAVENOAK = "Illyanna Ravenoak",
			IMMOL_THAR = "Immol'thar",
			INSTRUCTOR_MALICIA = "Instrukteurin Malicia",
			JAMMAL_AN_THE_PROPHET = "Jammal'an der Prophet",
			JANDICE_BAROV = "Jandice Barov",
			KIRTONOS_THE_HERALD = "Kirtonos der Herold",
			LADY_ILLUCIA_BAROV = "Lady Illucia Barov",
			LANDSLIDE = "Erdrutsch",
			LETHTENDRIS = "Lethtendris",
			LOREKEEPER_POLKELT = "H\195\188ter des Wissens Polkelt",
			LORO = "Loro",
			MAGISTER_KALENDRIS = "Magister Kalendris",
			MAGISTRATE_BARTHILAS = "Magistrat Barthilas",
			MAGMUS = "Magmus",
			MALEKI_THE_PALLID = "Maleki der Leichenblasse",
			MARDUK_BLACKPOOL = "Marduk Blackpool",
			MESHLOK_THE_HARVESTER = "Meshlok der Ernter",
			MIJAN = "Mijan",
			MORPHAZ = "Morphaz",
			MOTHER_SMOLDERWEB = "Mutter Glimmernetz",
			NERUB_ENKAN = "Nerub'enkan",
			NOXXION = "Noxxion",
			OGOM_THE_WRETCHED = "Ogom der Elende",
			OVERLORD_WYRMTHALAK = "Oberanf\195\188hrer Wyrmthalak",
			PHALANX = "Phalanx",
			PLUGGER_SPAZZRING = "Plugger Spazzring",
			POSTMASTER_MALOWN = "Postmeister Malown",
			PRINCESS_MOIRA_BRONZEBEARD = "Prinzessin Moira Bronzebeard",
			PRINCESS_THERADRAS = "Prinzessin Theradras",
			PRINCE_TORTHELDRIN = "Prinz Tortheldrin",
			PUSILLIN = "Pusillin",
			PYROGUARD_EMBERSEER = "Feuerwache Glutseher",
			RAMSTEIN_THE_GORGER = "Ramstein der Verschlinger",
			RATTLEGORE = "Rattlegore",
			RAZORLASH = "Schlingwurzler",
			RIBBLY_SCREWSPIGOT = "Ribbly Screwspigot",
			ROTGRIP = "Faulschnapper",
			SEETH_REL = "Seeth'rel",
			SHADE_OF_ERANIKUS = "Eranikus' Schemen",
			SOLAKAR_FLAMEWREATH = "Solakar Feuerkrone",
			STOMPER_KREEG = "Stampfer Kreeg",
			TENDRIS_WARPWOOD = "Tendris Wucherborke",
			TIMMY_THE_CRUEL = "Timmy der Grausame",
			TINKERER_GIZLOCK = "T\195\188ftler Gizlock",
			TSU_ZEE = "Tsu'zee",
			VECTUS = "Vectus",
			VILE_REL = "Vile'rel",
			WEAVER = "Wirker",
			ZEVRIM_THORNHOOF = "Zevrim Thornhoof",
			ZOLO = "Zolo",
			ZUL_LOR = "Zul'Lor",
			cANNON_MASTER_WILLEY = "Kanonenmeister Willey",
			EMPEROR_DAGRAN_THAURISSAN = "Imperator Dagran Thaurissan",
			GUARD_FENGUS = "Wache Fengus",
			GUARD_MOL_DAR = "Wache Mol'dar",
			GUARD_SLIP_KIK = "Wache Slip'kik",
			HIGH_INTERROGATOR_GERSTAHN = "Verh\195\182rmeisterin Gerstahn",
			KING_GORDOK = "K\195\182nig Gordok",
			LORD_ALEXEI_BAROV = "Lord Alexei Barov",
			LORD_INCENDIUS = "Lord Incendius",
			LORD_VYLETONGUE = "Lord Schlangenzunge",
			RAS_FROSTWHISPER = "Ras Frostwhisper",
			WARCHIEF_REND_BLACKHAND = "Kriegsh\195\164uptling Rend Blackhand",
			SHADOW_HUNTER_VOSH_GAJIN = "Schattenj\195\164gerin Vosh'gajin",
			THE_BEAST = "Die Bestie",
			THE_RAVENIAN = "Der Ravenier",
			WAR_MASTER_VOONE = "Kriegsmeister Voone",
		}
	end
elseif locale == "frFR" then
	function initBosses()
		bosses = {
			-- Raid Bosses
			NEFARIAN = "Nefarian",
			VAELASTRASZ_THE_CORRUPT = "Vaelastrasz le Corrompu",
			RAZORGORE_THE_UNTAMED = "Razorgore l'Indompt\195\169",
			BROODLORD_LASHLAYER = "Seigneur des couv\195\169es Lashslayer",
			CHROMAGGUS = "Chromaggus",
			EBONROC = "Ebonroc",
			FIREMAW = "Gueule-de-feu",
			FLAMEGOR = "Flamegor",
			MAJORDOMO_EXECUTUS = "Majordome Executus",
			RAGNAROS = "Ragnaros",
			BARON_GEDDON = "Baron Geddon",
			GOLEMAGG_THE_INCINERATOR = "Golemagg l'Incin\195\169rateur",
			GARR = "Garr",
			SULFURON_HARBINGER = "Messager de Sulfuron",
			SHAZZRAH = "Shazzrah",
			LUCIFRON = "Lucifron",
			GEHENNAS = "Gehennas",
			MAGMADAR = "Magmadar",
			ONYXIA = "Onyxia",
			AZUREGOS = "Azuregos",
			EMERISS = "Emeriss",
			TAERAR = "Taerar",
			LETHON = "L\195\169thon",
			JIN_DO_THE_HEXXER = "Jin'do le Mal\195\169ficieur",
			BLOODLORD_MANDOKIR = "Seigneur sanglant Mandokir",
			HAKKAR = "Hakkar",
			LORD_KAZZAK = "Seigneur Kazzak",
			YSONDRE = "Ysondre",
			HIGH_PRIESTESS_JEKLIK = "Grande pr\195\170tresse Jeklik",
			HIGH_PRIEST_vENOXIS = "Grand-pr\195\170tre Venoxis",
			HIGH_PRIEST_THEKAL = "Grand pr\195\170tre Thekal",
			HIGH_PRIESTESS_ARLOKK = "Grande pr\195\170tresse Arlokk",
			HIGH_PRIESTESS_MAR_LI = "Grande pr\195\170tresse Mar'li",
			GAHZ_RANKA = "Gahz'ranka",
			GRI_LEK = "Gri'lek",
			HAZZA_RAH = "Hazza'rah",
			RENATAKI = "Renataki",
			WUSHOOLAY = "Wushoolay",
			AYAMISS_THE_HUNTER = "Ayamiss le Chasseur",
			BURU_THE_GORGER = "Buru Grandgosier",
			GENERAL_RAJAXX = "Général Rajaxx",
			ANUBISATH_GUARDIAN = "Anubisath Guardian", -- CHECK
			OSSIRIAN_THE_UNSCARRED = "Ossirian the Unscarred", -- CHECK
			LORD_KRI = "Lord Kri", -- CHECK
			PRINCESS_YAUJ = "Princess Yauj", -- CHECK
			VEM = "Vem", -- CHECK
			EYE_OF_CTHUN = "Eye of C'Thun", -- CHECK
			ANUBISATH_DEFENDER = "Anubisath Defender", -- CHECK
			FANKRISS_THE_UNYIELDING = "Fankriss the Unyielding", -- CHECK
			PRINCESS_HUHURAN = "Princess Huhuran", -- CHECK
			OURO = "Ouro", -- CHECK
			BATTLEGUARD_SARTURA = "Battleguard Sartura", -- CHECK
			THE_PROPHET_SKERAM = "Le Prophète Skeram",
			EMPEROR_VEKLOR = "Emperor Vek'lor", -- CHECK
			EMPEROR_VEKNILASH = "Emperor Vek'nilash", -- CHECK
			VISCIDUS = "Viscidus", -- CHECK
			-- Regular Bosses
			ALZZIN_THE_WILDSHAPER = "Alzzin le Modeleur",
			AMBASSADOR_FLAMELASH = "Ambassadeur Flamelash",
			ANGER_REL = "Anger'rel",
			ARCHIVIST_GALFORD = "Archiviste Galford",
			ATAL_ALARION = "Atal'alarion",
			AVATAR_OF_HAKKAR = "Avatar d'Hakkar",
			BAEL_GAR = "Bael'Gar",
			BALNAZZAR = "Balnazzar",
			BARONESS_ANASTARI = "Baronne Anastari",
			BARON_RIVENDARE = "Baron Rivendare",
			CAPTAIN_KROMCRUSH = "Capitaine Kromcrush",
			CELEBRAS_THE_CURSED = "Celebras le Maudit",
			CRYSTAL_FANG = "Croc cristallin",
			DARKMASTER_GANDLING = "Sombre Ma\195\174tre Gandling",
			DOCTOR_THEOLEN_KRASTINOV = "Docteur Theolen Krastinov",
			DOOM_REL = "Doom'rel",
			DOPE_REL = "Dope'rel",
			DREAMSCYTHE = "Fauche-r\195\170ve",
			FINEOUS_DARKVIRE = "Fineous Darkvire",
			GASHER = "Gasher",
			GENERAL_ANGERFORGE = "G\195\169n\195\169ral Angerforge",
			GENERAL_DRAKKISATH = "G\195\169n\195\169ral Drakkisath",
			GLOOM_REL = "Gloom'rel",
			GOLEM_LORD_ARGELMACH = "Seigneur golem Argelmach",
			GORALUK_ANVILCRACK = "Goraluk Anvilcrack",
			GYTH = "Gyth",
			HALYCON = "Halycon",
			HATE_REL = "Hate'rel",
			HAZZAS = "Hazzas",
			HEARTHSINGER_FORRESTEN = "Hearthsinger Forresten",
			HIGHLORD_OMOKK = "G\195\169n\195\169ralissime Omokk",
			HUKKU = "Hukku",
			HURLEY_BLACKBREATH = "Hurley Blackbreath",
			HYDROSPAWN = "Hydrospawn",
			ILLYANNA_RAVENOAK = "Illyanna Ravenoak",
			IMMOL_THAR = "Immol'thar",
			INSTRUCTOR_MALICIA = "Instructeur Malicia",
			JAMMAL_AN_THE_PROPHET = "Jammal'an le proph\195\168te",
			JANDICE_BAROV = "Jandice Barov",
			KIRTONOS_THE_HERALD = "Kirtonos le H\195\169raut",
			LADY_ILLUCIA_BAROV = "Dame Illucia Barov",
			LANDSLIDE = "Glissement de terrain",
			LETHTENDRIS = "Lethtendris",
			LOREKEEPER_POLKELT = "Gardien du savoir Polkelt",
			LORO = "Loro",
			MAGISTER_KALENDRIS = "Magist\195\168re Kalendris",
			MAGISTRATE_BARTHILAS = "Magistrat Barthilas",
			MAGMUS = "Magmus",
			MALEKI_THE_PALLID = "Maleki le Blafard",
			MARDUK_BLACKPOOL = "Marduk Blackpool",
			MESHLOK_THE_HARVESTER = "Meshlok le Collecteur",
			MIJAN = "Mijan",
			MORPHAZ = "Morphaz",
			MOTHER_SMOLDERWEB = "Matriarche Couveuse",
			NERUB_ENKAN = "Nerub'enkan",
			NOXXION = "Noxxion",
			OGOM_THE_WRETCHED = "Ogom le Corrompu",
			OVERLORD_WYRMTHALAK = "Seigneur Wyrmthalak",
			PHALANX = "Phalange",
			PLUGGER_SPAZZRING = "Plugger Spazzring",
			POSTMASTER_MALOWN = "Postier Malown",
			PRINCESS_MOIRA_BRONZEBEARD = "Princesse Moira Bronzebeard",
			PRINCESS_THERADRAS = "Princesse Theradras",
			PRINCE_TORTHELDRIN = "Prince Tortheldrin",
			PUSILLIN = "Pusillin",
			PYROGUARD_EMBERSEER = "Pyrogarde Proph\195\168te ardent",
			RAMSTEIN_THE_GORGER = "Ramstein Grandgosier",
			RATTLEGORE = "Rattlegore",
			RAZORLASH = "Razorlash",
			RIBBLY_SCREWSPIGOT = "Ribbly Screwspigot",
			ROTGRIP = "Grippe-charogne",
			SEETH_REL = "Seeth'rel",
			SHADE_OF_ERANIKUS = "Ombre d'Eranikus",
			SOLAKAR_FLAMEWREATH = "Solakar Flamewreath",
			STOMPER_KREEG = "Kreeg le Marteleur",
			TENDRIS_WARPWOOD = "Tendris Crochebois",
			TIMMY_THE_CRUEL = "Timmy le Cruel",
			TINKERER_GIZLOCK = "Artisan Gizlock",
			TSU_ZEE = "Tsu'zee",
			VECTUS = "Vectus",
			VILE_REL = "Vile'rel",
			WEAVER = "Tisserand",
			ZEVRIM_THORNHOOF = "Zevrim Thornhoof",
			ZOLO = "Zolo",
			ZUL_LOR = "Zul'Lor",
			cANNON_MASTER_WILLEY = "Ma\195\174tre canonnier Willey",
			EMPEROR_DAGRAN_THAURISSAN = "Empereur Dagran Thaurissan",
			GUARD_FENGUS = "Garde Fengus",
			GUARD_MOL_DAR = "Garde Mol'dar",
			GUARD_SLIP_KIK = "Garde Slip'kik",
			HIGH_INTERROGATOR_GERSTAHN = "Grand Interrogateur Gerstahn",
			KING_GORDOK = "Roi Gordok",
			LORD_ALEXEI_BAROV = "Seigneur Alexei Barov",
			LORD_INCENDIUS = "Seigneur Incendius",
			LORD_VYLETONGUE = "Seigneur Vyletongue",
			RAS_FROSTWHISPER = "Ras Frostwhisper",
			WARCHIEF_REND_BLACKHAND = "Chef de guerre Rend Blackhand",
			SHADOW_HUNTER_VOSH_GAJIN = "Chasseur des ombres Vosh'gajin",
			THE_BEAST = "La B\195\170te",
			THE_RAVENIAN = "Le Voracien",
			WAR_MASTER_VOONE = "Ma\195\174tre de guerre Voone",
		}
	end
elseif locale == "zhCN" then
	function initBosses()
		bosses = {
			-- Raid bosses
			NEFARIAN = "\229\165\136\230\179\149\229\136\169\229\174\137",
			VAELASTRASZ_THE_CORRUPT = "\229\160\149\232\144\189\231\154\132\231\147\166\230\139\137\230\150\175\229\161\148\229\133\185",
			RAZORGORE_THE_UNTAMED = "\231\139\130\233\135\142\231\154\132\230\139\137\228\189\144\230\160\188\229\176\148",
			BROODLORD_LASHLAYER = "\229\139\146\228\187\128\233\155\183\229\176\148",
			CHROMAGGUS = "\229\133\139\230\180\155\231\142\155\229\143\164\230\150\175",
			EBONROC = "\229\159\131\229\141\154\232\175\186\229\133\139",
			FIREMAW = "\232\180\185\229\176\148\233\187\152",
			FLAMEGOR = "\229\188\151\232\142\177\230\160\188\229\176\148",
			MAJORDOMO_EXECUTUS = "\231\174\161\231\144\134\232\128\133\229\159\131\229\133\139\231\180\162\229\155\190\230\150\175",
			RAGNAROS = "\230\139\137\230\160\188\231\186\179\231\189\151\230\150\175",
			BARON_GEDDON = "\232\191\166\233\161\191\231\148\183\231\136\181",
			GOLEMAGG_THE_INCINERATOR = "\231\132\154\229\140\150\232\128\133\229\143\164\233\155\183\230\155\188\230\160\188",
			GARR = "\229\138\160\229\176\148",
			SULFURON_HARBINGER = "\232\144\168\229\188\151\233\154\134\229\133\136\233\169\177\232\128\133",
			SHAZZRAH = "\230\178\153\230\150\175\230\139\137\229\176\148",
			LUCIFRON = "\233\178\129\232\165\191\229\188\151\233\154\134",
			GEHENNAS = "\229\159\186\232\181\171\231\186\179\230\150\175",
			MAGMADAR = "\231\142\155\230\160\188\230\155\188\232\190\190",
			ONYXIA = "\229\165\165\229\166\174\229\133\139\229\184\140\228\186\154",
			AZUREGOS = "\232\137\190\231\180\162\233\155\183\232\145\155\230\150\175",
			LORD_KAZZAK = "\229\141\161\230\137\142\229\133\139",
			YSONDRE = "\228\188\138\230\163\174\229\190\183\233\155\183",
			EMERISS = "\232\137\190\232\142\171\232\142\137\228\184\157",
			TAERAR = "\230\179\176\230\139\137\229\176\148",
			LETHON = "\232\142\177\231\180\162\230\129\169",
			HIGH_PRIESTESS_JEKLIK = "\233\171\152\233\152\182\231\165\173\229\143\184\2 32\128\182\229\133\139\233\135\140\229\133\139",
			HIGH_PRIEST_VENOXIS = "\233\171\152\233\152\182\231\165\173\229\143\184\2 30\184\169\232\175\186\229\184\140\230\150\175",
			HIGH_PRIEST_THEKAL = "\233\171\152\233\152\182\231\165\173\229\143\184\2 29\161\158\229\141\161\229\176\148",
			HIGH_PRIESTESS_ARLOKK = "\233\171\152\233\152\182\231\165\173\229\143\184\2 29\168\133\229\176\148\231\189\151",
			HIGH_PRIESTESS_MAR_LI = "\233\171\152\233\152\182\231\165\173\229\143\184\2 31\142\155\229\176\148\233\135\140",
			JIN_DO_THE_HEXXER = "\229\166\150\230\156\175\229\184\136\233\135\145\2 29\186\166",
			BLOODLORD_MANDOKIR = "\232\161\128\233\162\134\228\184\187\230\155\188\2 29\164\154\229\159\186\229\176\148",
			GAHZ_RANKA = "\229\138\160\229\133\185\229\133\176\229\141\161",
			GRI_LEK = "\230\160\188\233\135\140\233\155\183\229\133\139",
			HAZZA_RAH = "\229\147\136\230\137\142\230\139\137\229\176\148",
			RENATAKI = "\233\155\183\231\186\179\229\161\148\229\159\186",
			WUSHOOLAY = "\228\185\140\232\139\143\233\155\183",
			HAKKAR = "\229\147\136\229\141\161",
			AYAMISS_THE_HUNTER = "Ayamiss the Hunter", -- CHECK
			BURU_THE_GORGER = "Buru the Gorger", -- CHECK
			GENERAL_RAJAXX = "General Rajaxx", -- CHECK
			ANUBISATH_GUARDIAN = "Anubisath Guardian", -- CHECK
			OSSIRIAN_THE_UNSCARRED = "Ossirian the Unscarred", -- CHECK
			LORD_KRI = "Lord Kri", -- CHECK
			PRINCESS_YAUJ = "Princess Yauj", -- CHECK
			VEM = "Vem", -- CHECK
			EYE_OF_CTHUN = "Eye of C'Thun", -- CHECK
			ANUBISATH_DEFENDER = "Anubisath Defender", -- CHECK
			FANKRISS_THE_UNYIELDING = "Fankriss the Unyielding", -- CHECK
			PRINCESS_HUHURAN = "Princess Huhuran", -- CHECK
			OURO = "Ouro", -- CHECK
			BATTLEGUARD_SARTURA = "Battleguard Sartura", -- CHECK
			THE_PROPHET_SKERAM = "The Prophet Skeram", -- CHECK
			EMPEROR_VEKLOR = "Emperor Vek'lor", -- CHECK
			EMPEROR_VEKNILASH = "Emperor Vek'nilash", -- CHECK
			VISCIDUS = "Viscidus", -- CHECK
			-- Regular bosses
			ALZZIN_THE_WILDSHAPER = "\229\165\165\229\133\185\230\129\169",
			AMBASSADOR_FLAMELASH = "\229\188\151\232\142\177\230\139\137\230\150\175\229\164\167\228\189\191",
			ANGER_REL = "\229\174\137\230\160\188\233\155\183\229\176\148",
			ARCHIVIST_GALFORD = "\230\161\136\231\174\161\231\144\134\229\145\152\229\138\160\229\176\148\231\166\143\231\137\185",
			ATAL_ALARION = "\233\152\191\229\161\148\230\139\137\229\136\169\2 30\129\169",
			AVATAR_OF_HAKKAR = "\229\147\136\229\141\161\231\154\132\229\140\150\2 32\186\171",
			BAEL_GAR = "\232\180\157\229\176\148\229\138\160",
			BALNAZZAR = "\229\183\180\231\186\179\230\137\142\229\176\148",
			BARONESS_ANASTARI = "\229\174\137\229\168\156\228\184\157\229\161\148\228\184\189\231\148\183\231\136\181\229\164\171\228\186\186",
			BARON_RIVENDARE = "\231\145\158\230\150\135\230\136\180\229\176\148\231\148\183\231\136\181",
			CANNON_MASTER_WILLEY = "\231\130\174\230\137\139\229\168\129\229\136\169",
			CAPTAIN_KROMCRUSH = "\229\133\139\231\189\151\229\141\161\230\150\175",
			CELEBRAS_THE_CURSED = "\232\162\171\232\175\133\229\146\146\231\154\132\229\161\158\233\155\183\229\184\131\230\139\137\230\150\175",
			CRYSTAL_FANG = "\230\176\180\230\153\182\228\185\139\231\137\153",
			DARKMASTER_GANDLING = "\233\187\145\230\154\151\233\153\162\233\149\191\229\138\160\228\184\129",
			DOCTOR_THEOLEN_KRASTINOV = "\231\145\159\229\176\148\230\158\151\224\130\183\229\141\161\230\150\175\232\191\170\232\175\186\229\164\171\230\149\153\230\142\136",
			DOOM_REL = "\230\157\156\229\167\134\233\155\183\229\176\148",
			DOPE_REL = "\229\164\154\230\153\174\233\155\183\229\176\148",
			DREAMSCYTHE = "\229\190\183\229\167\134\229\161\158\229\141\161\2 29\176\148",
			EMPEROR_DAGRAN_THAURISSAN = "\232\190\190\230\160\188\229\133\176\224\130\183\231\180\162\231\145\158\230\163\174\229\164\167\229\184\157",
			FINEOUS_DARKVIRE = "\229\188\151\232\175\186\230\150\175\224\130\183\232\190\190\229\133\139\231\187\180\229\176\148",
			GASHER = "\229\138\160\228\187\128\229\176\148",
			GENERAL_ANGERFORGE = "\229\174\137\230\160\188\229\188\151\229\176\134\229\134\155",
			GENERAL_DRAKKISATH = "\232\190\190\229\159\186\232\144\168\230\150\175\229\176\134\229\134\155",
			GLOOM_REL = "\230\160\188\233\178\129\233\155\183\229\176\148",
			GOLEM_LORD_ARGELMACH = "\229\130\128\229\132\161\231\187\159\229\184\133\233\152\191\230\160\188\230\155\188\229\165\135",
			GORALUK_ANVILCRACK = "\229\143\164\230\139\137\233\178\129\229\133\139",
			GUARD_FENGUS = "\229\141\171\229\133\181\232\138\172\229\143\164\230\150\175",
			GUARD_MOL_DAR = "\229\141\171\229\133\181\230\145\169\229\176\148\232\190\190",
			GUARD_SLIP_KIK = "\229\141\171\229\133\181\230\150\175\233\135\140\229\159\186\229\133\139",
			GYTH = "\231\155\150\230\150\175",
			HALYCON = "\229\147\136\233\155\183\232\130\175",
			HATE_REL = "\233\187\145\231\137\185\233\155\183\229\176\148",
			HAZZAS = "\229\147\136\230\137\142\230\150\175",
			HEARTHSINGER_FORRESTEN = "\229\188\151\233\155\183\230\150\175\231\137\185\230\129\169",
			HIGH_INTERROGATOR_GERSTAHN = "\229\174\161\232\174\175\229\174\152\230\160\188\230\150\175\229\161\148\230\129\169",
			HIGHLORD_OMOKK = "\230\172\167\232\142\171\229\133\139\229\164\167\231\142\139",
			HUKKU = "\232\131\161\229\186\147",
			HURLEY_BLACKBREATH = "\233\156\141\229\176\148\233\155\183\224\130\183\233\187\145\233\161\187",
			HYDROSPAWN = "\230\181\183\229\164\154\230\150\175\229\141\154\230\129\169",
			ILLYANNA_RAVENOAK = "\228\188\138\231\144\179\229\168\156\224\130\183\230\154\151\230\156\168",
			IMMOL_THAR = "\228\188\138\232\142\171\229\161\148\229\176\148",
			INSTRUCTOR_MALICIA = "\232\174\178\229\184\136\231\142\155\228\184\189\229\184\140\228\186\154",
			JAMMAL_AN_THE_PROPHET = "\233\162\132\232\168\128\232\128\133\232\191\166\2 31\142\155\229\133\176",
			JANDICE_BAROV = "\232\169\185\232\191\170\230\150\175\224\130\183\229\183\180\231\189\151\229\164\171",
			KING_GORDOK = "\230\136\136\229\164\154\229\133\139\229\164\167\231\142\139",
			KIRTONOS_THE_HERALD = "\228\188\160\228\187\164\229\174\152\229\159\186\229\176\148\229\155\190\232\175\186\230\150\175",
			LADY_ILLUCIA_BAROV = "\228\188\138\233\156\178\229\184\140\228\186\154\224\130\183\229\183\180\231\189\151\229\164\171",
			LANDSLIDE = "\229\133\176\230\150\175\229\136\169\229\190\183",
			LETHTENDRIS = "\232\149\190\231\145\159\229\161\148\232\146\130\228\184\157",
			LORD_ALEXEI_BAROV = "\233\152\191\233\155\183\229\133\139\230\150\175\224\130\183\229\183\180\231\189\151\229\164\171",
			LORD_INCENDIUS = "\228\188\138\230\163\174\232\191\170\229\165\165\230\150\175",
			LORD_VYLETONGUE = "\231\187\180\229\136\169\229\161\148\230\129\169",
			LOREKEEPER_POLKELT = "\229\141\154\229\173\166\232\128\133\230\153\174\229\133\139\229\176\148\231\137\185",
			LORO = "\230\180\155\232\139\165\229\176\148",
			MAGISTER_KALENDRIS = "\229\141\161\233\155\183\232\191\170\230\150\175\233\149\135\233\149\191",
			MAGISTRATE_BARTHILAS = "\229\183\180\231\145\159\230\139\137\230\150\175\233\149\135\233\149\191",
			MAGMUS = "\231\142\155\230\160\188\229\167\134\230\150\175",
			MALEKI_THE_PALLID = "\232\139\141\231\153\189\231\154\132\231\142\155\229\139\146\229\159\186",
			MARDUK_BLACKPOOL = "\233\169\172\230\157\156\229\133\139\224\130\183\229\184\131\232\142\177\229\133\139\230\179\162\229\176\148",
			MESHLOK_THE_HARVESTER = "\230\148\182\229\137\178\232\128\133\233\186\166\228\187\128\230\180\155\229\133\139",
			MIJAN = "\231\177\179\230\157\137",
			MORPHAZ = "\230\145\169\229\188\151\230\139\137\230\150\175",
			MOTHER_SMOLDERWEB = "\231\131\159\231\189\145\232\155\155\229\144\142",
			NERUB_ENKAN = "\229\165\136\233\178\129\229\184\131\230\129\169\229\157\142",
			NOXXION = "\232\175\186\229\133\139\232\181\155\230\129\169",
			OGOM_THE_WRETCHED = "\229\143\175\230\130\178\231\154\132\229\165\165\2 30\136\136\229\167\134",
			OVERLORD_WYRMTHALAK = "\231\187\180\229\167\134\232\144\168\230\139\137\229\133\139",
			PHALANX = "\230\179\149\230\139\137\229\133\139\230\150\175",
			PLUGGER_SPAZZRING = "\230\153\174\230\139\137\230\160\188",
			POSTMASTER_MALOWN = "\233\130\174\229\183\174\233\169\172\233\190\153",
			PRINCESS_MOIRA_BRONZEBEARD = "\233\147\129\231\130\137\229\160\161\229\133\172\228\184\187\232\140\137\232\137\190\230\139\137\224\130\183\233\147\156\233\161\187",
			PRINCESS_THERADRAS = "\231\145\159\232\142\177\229\190\183\228\184\157\229\133\172\228\184\187",
			PRINCE_TORTHELDRIN = "\230\137\152\229\161\158\229\190\183\230\158\151\231\142\139\229\173\144",
			PUSILLIN = "\230\153\174\229\184\140\230\158\151",
			PYROGUARD_EMBERSEER = "\231\131\136\231\132\176\229\141\171\229\163\171\232\137\190\229\141\154\229\184\140\229\176\148",
			RAMSTEIN_THE_GORGER = "\229\144\158\229\146\189\232\128\133\230\139\137\229\167\134\230\150\175\231\153\187",
			RAS_FROSTWHISPER = "\232\142\177\230\150\175\224\130\183\233\156\156\232\175\173",
			RATTLEGORE = "\232\161\128\233\170\168\229\130\128\229\132\161",
			RAZORLASH = "\233\148\144\229\136\186\233\158\173\231\172\158\232\128\133",
			WARCHIEF_REND_BLACKHAND = "\233\155\183\229\190\183\224\130\183\233\187\145\230\137\139",
			RIBBLY_SCREWSPIGOT = "\233\155\183\229\184\131\233\135\140\224\130\183\230\150\175\229\186\147\230\175\148\230\160\188\231\137\185",
			ROTGRIP = "\230\180\155\231\137\185\230\160\188\233\135\140\230\153\174",
			SEETH_REL = "\232\165\191\230\150\175\233\155\183\229\176\148",
			SHADE_OF_ERANIKUS = "\228\188\138\229\133\176\229\176\188\229\186\147\2 30\150\175\231\154\132\233\152\180\229\189\177",
			SHADOW_HUNTER_VOSH_GAJIN = "\230\154\151\229\189\177\231\140\142\230\137\139\230\178\131\228\187\128\229\138\160\230\150\175",
			SOLAKAR_FLAMEWREATH = "Solakar Flamewreath",
			STOMPER_KREEG = "\232\183\181\232\184\143\232\128\133\229\133\139\2 33\155\183\230\160\188",
			TENDRIS_WARPWOOD = "\231\137\185\232\191\170\230\150\175\224\130\183\230\137\173\230\156\168",
			THE_BEAST = "\230\175\148\230\150\175\229\183\168\229\133\189",
			THE_RAVENIAN = "\230\139\137\230\150\135\229\176\188\228\186\154",
			TIMMY_THE_CRUEL = "\230\130\178\230\131\168\231\154\132\230\143\144\2 31\177\179 --Timmy!!!",
			TINKERER_GIZLOCK = "\229\183\165\229\140\160\229\144\137\229\133\185\230\180\155\229\133\139",
			TSU_ZEE = "\232\139\143\230\150\175",
			VECTUS = "\231\187\180\229\133\139\229\155\190\230\150\175",
			VILE_REL = "\231\147\166\229\139\146\233\155\183\229\176\148",
			WAR_MASTER_VOONE = "\230\140\135\230\140\165\229\174\152\230\178\131\2 30\129\169",
			WEAVER = "\229\190\183\230\139\137\231\187\180\230\178\131\2 29\176\148",
			ZEVRIM_THORNHOOF = "\229\161\148\231\189\151\224\130\183\229\136\186\232\185\132",
			ZOLO = "\231\165\150\231\189\151",
			ZUL_LOR = "\231\165\150\231\189\151\229\176\148",
		}
	end
elseif locale == "koKR" then
	function initBosses()
		bosses = {
			-- Raid bosses
			NEFARIAN = "네파리안",
			VAELASTRASZ_THE_CORRUPT = "타락한 밸라스트라즈",
			RAZORGORE_THE_UNTAMED = "Razorgore the Untamed",
			BROODLORD_LASHLAYER = "Broodlord Lashlayer",
			CHROMAGGUS = "ũ؎ضѸݺ",
			EBONROC = "에본로크",
			FIREMAW = "화염아귀",
			FLAMEGOR = "플레임고르",
			MAJORDOMO_EXECUTUS = "청지기 이그젝큐투스",
			RAGNAROS = "라그나로스",
			BARON_GEDDON = "남작 게돈",
			GOLEMAGG_THE_INCINERATOR = "Golemagg the Incinerator",
			GARR = "Garr",
			SULFURON_HARBINGER = "Sulfuron Harbinger",
			SHAZZRAH = "샤즈라",
			LUCIFRON = "루시프론",
			GEHENNAS = "게헨나스",
			MAGMADAR = "마그마다르",
			ONYXIA = "오닉시아",
			AZUREGOS = "Azuregos",
			LORD_KAZZAK = "Lord Kazzak",
			YSONDRE = "Ysondre",
			EMERISS = "에메리스",
			TAERAR = "Taerar",
			LETHON = "Lethon",
			HIGH_PRIESTESS_JEKLIK = "대여사제 제클릭",
			HIGH_PRIEST_VENOXIS = "대사제 베녹시스",
			HIGH_PRIEST_THEKAL = "High Priest Thekal",
			HIGH_PRIESTESS_ARLOKK = "High Priestess Arlokk",
			HIGH_PRIESTESS_MAR_LI = "대여사제 말리",
			JIN_DO_THE_HEXXER = "Jin'do the Hexxer",
			BLOODLORD_MANDOKIR = "혈군주 만도키르",
			GAHZ_RANKA = "Gahz'ranka",
			GRI_LEK = "Gri'lek",
			HAZZA_RAH = "Hazza'rah",
			RENATAKI = "Renataki",
			WUSHOOLAY = "Wushoolay",
			HAKKAR = "학카르",
			AYAMISS_THE_HUNTER = "사냥꾼 아야미스",
			BURU_THE_GORGER = "먹보 부루",
			GENERAL_RAJAXX = "장군 라작스",
			ANUBISATH_GUARDIAN = "아누비사스 감시자",
			OSSIRIAN_THE_UNSCARRED = "무적의 오시리안",
			LORD_KRI = "군주 크리",
			PRINCESS_YAUJ = "공주 야우즈",
			VEM = "벰",
			EYE_OF_CTHUN = "쑨의 눈",
			ANUBISATH_DEFENDER = "아누비사스 문지기",
			FANKRISS_THE_UNYIELDING = "불굴의 판크리스",
			PRINCESS_HUHURAN = "공주 후후란",
			OURO = "아우로",
			BATTLEGUARD_SARTURA = "전투감시병 살투라",
			THE_PROPHET_SKERAM = "예언자 스케람",
			EMPEROR_VEKLOR = "제왕 베클로어",
			EMPEROR_VEKNILASH = "제왕 베크닐라쉬",
			VISCIDUS = "비시디우스",
			-- Regular bosses
			ALZZIN_THE_WILDSHAPER = "Alzzin the Wildshaper",
			AMBASSADOR_FLAMELASH = "Ambassador Flamelash",
			ANGER_REL = "Anger'rel",
			ARCHIVIST_GALFORD = "Archivist Galford",
			ATAL_ALARION = "Atal'alarion",
			AVATAR_OF_HAKKAR = "Avatar of Hakkar",
			BAEL_GAR = "Bael'Gar",
			BALNAZZAR = "Balnazzar",
			BARONESS_ANASTARI = "Baroness Anastari",
			BARON_RIVENDARE = "Baron Rivendare",
			CANNON_MASTER_WILLEY = "Cannon Master Willey",
			CAPTAIN_KROMCRUSH = "Captain Kromcrush",
			CELEBRAS_THE_CURSED = "Celebras the Cursed",
			CRYSTAL_FANG = "Crystal Fang",
			DARKMASTER_GANDLING = "Darkmaster Gandling",
			DOCTOR_THEOLEN_KRASTINOV = "Doctor Theolen Krastinov",
			DOOM_REL = "Doom'rel",
			DOPE_REL = "Dope'rel",
			DREAMSCYTHE = "Dreamscythe",
			EMPEROR_DAGRAN_THAURISSAN = "Emperor Dagran Thaurissan",
			FINEOUS_DARKVIRE = "Fineous Darkvire",
			GASHER = "Gasher",
			GENERAL_ANGERFORGE = "General Angerforge",
			GENERAL_DRAKKISATH = "General Drakkisath",
			GLOOM_REL = "Gloom'rel",
			GOLEM_LORD_ARGELMACH = "Golem Lord Argelmach",
			GORALUK_ANVILCRACK = "Goraluk Anvilcrack",
			GUARD_FENGUS = "Guard Fengus",
			GUARD_MOL_DAR = "Guard Mol'dar",
			GUARD_SLIP_KIK = "Guard Slip'kik",
			GYTH = "Gyth",
			HALYCON = "Halycon",
			HATE_REL = "Hate'rel",
			HAZZAS = "Hazzas",
			HEARTHSINGER_FORRESTEN = "Hearthsinger Forresten",
			HIGH_INTERROGATOR_GERSTAHN = "High Interrogator Gerstahn",
			HIGHLORD_OMOKK = "Highlord Omokk",
			HUKKU = "Hukku",
			HURLEY_BLACKBREATH = "Hurley Blackbreath",
			HYDROSPAWN = "Hydrospawn",
			ILLYANNA_RAVENOAK = "Illyanna Ravenoak",
			IMMOL_THAR = "Immol'thar",
			INSTRUCTOR_MALICIA = "Instructor Malicia",
			JAMMAL_AN_THE_PROPHET = "Jammal'an the Prophet",
			JANDICE_BAROV = "Jandice Barov",
			KING_GORDOK = "King Gordok",
			KIRTONOS_THE_HERALD = "Kirtonos the Herald",
			LADY_ILLUCIA_BAROV = "Lady Illucia Barov",
			LANDSLIDE = "Landslide",
			LETHTENDRIS = "Lethtendris",
			LORD_ALEXEI_BAROV = "Lord Alexei Barov",
			LORD_INCENDIUS = "Lord Incendius",
			LORD_VYLETONGUE = "Lord Vyletongue",
			LOREKEEPER_POLKELT = "Lorekeeper Polkelt",
			LORO = "Loro",
			MAGISTER_KALENDRIS = "Magister Kalendris",
			MAGISTRATE_BARTHILAS = "Magistrate Barthilas",
			MAGMUS = "Magmus",
			MALEKI_THE_PALLID = "Maleki the Pallid",
			MARDUK_BLACKPOOL = "Marduk Blackpool",
			MESHLOK_THE_HARVESTER = "Meshlok the Harvester",
			MIJAN = "Mijan",
			MORPHAZ = "Morphaz",
			MOTHER_SMOLDERWEB = "Mother Smolderweb",
			NERUB_ENKAN = "Nerub'enkan",
			NOXXION = "Noxxion",
			OGOM_THE_WRETCHED = "Ogom the Wretched",
			OVERLORD_WYRMTHALAK = "Overlord Wyrmthalak",
			PHALANX = "Phalanx",
			PLUGGER_SPAZZRING = "Plugger Spazzring",
			POSTMASTER_MALOWN = "Postmaster Malown",
			PRINCESS_MOIRA_BRONZEBEARD = "Princess Moira Bronzebeard",
			PRINCESS_THERADRAS = "Princess Theradras",
			PRINCE_TORTHELDRIN = "Prince Tortheldrin",
			PUSILLIN = "Pusillin",
			PYROGUARD_EMBERSEER = "Pyroguard Emberseer",
			RAMSTEIN_THE_GORGER = "Ramstein the Gorger",
			RAS_FROSTWHISPER = "Ras Frostwhisper",
			RATTLEGORE = "Rattlegore",
			RAZORLASH = "Razorlash",
			WARCHIEF_REND_BLACKHAND = "Warchief Rend Blackhand",
			RIBBLY_SCREWSPIGOT = "Ribbly Screwspigot",
			ROTGRIP = "Rotgrip",
			SEETH_REL = "Seeth'rel",
			SHADE_OF_ERANIKUS = "Shade of Eranikus",
			SHADOW_HUNTER_VOSH_GAJIN = "Shadow Hunter Vosh'gajin",
			SOLAKAR_FLAMEWREATH = "Solakar Flamewreath",
			STOMPER_KREEG = "Stomper Kreeg",
			TENDRIS_WARPWOOD = "Tendris Warpwood",
			THE_BEAST = "The Beast",
			THE_RAVENIAN = "The Ravenian",
			TIMMY_THE_CRUEL = "Timmy the Cruel",
			TINKERER_GIZLOCK = "Tinkerer Gizlock",
			TSU_ZEE = "Tsu'zee",
			VECTUS = "Vectus",
			VILE_REL = "Vile'rel",
			WAR_MASTER_VOONE = "War Master Voone",
			WEAVER = "Weaver",
			ZEVRIM_THORNHOOF = "Zevrim Thornhoof",
			ZOLO = "Zolo",
 			ZUL_LOR = "Zul'Lor",
		}
	end
end

-------------IRIEL'S-STUB-CODE--------------
local stub = {};

-- Instance replacement method, replace contents of old with that of new
function stub:ReplaceInstance(old, new)
   for k,v in pairs(old) do old[k]=nil; end
   for k,v in pairs(new) do old[k]=v; end
end

-- Get a new copy of the stub
function stub:NewStub()
  local newStub = {};
  self:ReplaceInstance(newStub, self);
  newStub.lastVersion = '';
  newStub.versions = {};
  return newStub;
end

-- Get instance version
function stub:GetInstance(version)
   if (not version) then version = self.lastVersion; end
   local versionData = self.versions[version];
   if (not versionData) then
      message("Cannot find library instance with version '" 
              .. version .. "'");
      return;
   end
   return versionData.instance;
end

-- Register new instance
function stub:Register(newInstance)
   local version,minor = newInstance:GetLibraryVersion();
   self.lastVersion = version;
   local versionData = self.versions[version];
   if (not versionData) then
      -- This one is new!
      versionData = { instance = newInstance,
         minor = minor,
         old = {} 
      };
      self.versions[version] = versionData;
      newInstance:LibActivate(self);
      return newInstance;
   end
   if (minor <= versionData.minor) then
      -- This one is already obsolete
      if (newInstance.LibDiscard) then
         newInstance:LibDiscard();
      end
      return versionData.instance;
   end
   -- This is an update
   local oldInstance = versionData.instance;
   local oldList = versionData.old;
   versionData.instance = newInstance;
   versionData.minor = minor;
   local skipCopy = newInstance:LibActivate(self, oldInstance, oldList);
   table.insert(oldList, oldInstance);
   if (not skipCopy) then
      for i, old in ipairs(oldList) do
         self:ReplaceInstance(old, newInstance);
      end
   end
   return newInstance;
end

-- Bind stub to global scope if it's not already there
if (not BabbleLib) then
   BabbleLib = stub:NewStub();
end

-- Nil stub for garbage collection
stub = nil;
-----------END-IRIEL'S-STUB-CODE------------

local lib = {}
local localBosses

function lib:GetEnglish(boss)
	return localBosses[boss] or boss
end

function lib:GetLocalized(boss)
	return bosses[boss] or boss
end

function lib:GetIterator()
	return pairs(bosses)
end

function lib:GetReverseIterator()
	return pairs(localBosses)
end

function lib:HasBoss(boss)
	return (bosses[boss] or localBosses[boss]) and true or false
end

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
	initBosses()
	initBosses = nil
	
	localBosses = {}
	for english, localized in pairs(bosses) do
		if string.sub(english, -4) == "_ALT" then
			localBosses[localized] = string.sub(english, 0, -5)
		elseif string.sub(english, -5, -2) == "_ALT" then
			localBosses[localized] = string.sub(english, 0, -6)
		else
			localBosses[localized] = english
		end
	end
end

function lib:LibDeactivate()
	bosses, localBosses, initBosses = nil
end

BabbleLib:Register(lib)
lib = nil
