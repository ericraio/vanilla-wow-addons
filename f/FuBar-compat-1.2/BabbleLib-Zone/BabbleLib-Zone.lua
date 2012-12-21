local MAJOR_VERSION = "Zone 1.1"
local MINOR_VERSION = tonumber(string.sub("$Revision: 1536 $", 12, -3))

if BabbleLib and BabbleLib.versions[MAJOR_VERSION] and BabbleLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

local locale = GetLocale and GetLocale() or "enUS"
if locale ~= "frFR" and locale ~= "deDE" and locale ~= "zhCN" then
	locale = "enUS"
end

local initZones, zones
if locale == "enUS" then
	function initZones()
		zones = {
			ALTERAC_MOUNTAINS = "Alterac Mountains",
			ALTERAC_VALLEY = "Alterac Valley",
			ARATHI_BASIN = "Arathi Basin",
			ARATHI_HIGHLANDS = "Arathi Highlands",
			ASHENVALE = "Ashenvale",
			AZSHARA = "Azshara",
			BADLANDS = "Badlands",
			BARRENS = "The Barrens",
			BLACKFATHOM_DEEPS = "Blackfathom Deeps",
			BLACKROCK_DEPTHS = "Blackrock Depths",
			BLACKROCK_MOUNTAIN = "Blackrock Mountain",
			BLACKROCK_SPIRE = "Blackrock Spire",
			BLACKWING_LAIR = "Blackwing Lair",
			BLASTED_LANDS = "Blasted Lands",
			BOOTY_BAY = "Booty Bay",
			BURNING_STEPPES = "Burning Steppes",
			CAVERNS_OF_TIME = "Caverns of Time",
			DARKSHORE = "Darkshore",
			DARNASSUS = "Darnassus",
			DEADMINES = "The Deadmines",
			DEADWIND_PASS = "Deadwind Pass",
			DEEPRUN_TRAM = "Deeprun Tram",
			DESOLACE = "Desolace",
			DIRE_MAUL = "Dire Maul",
			DUN_MOROGH = "Dun Morogh",
			DUROTAR = "Durotar",
			DUSKWOOD = "Duskwood",
			DUSTWALLOW_MARSH = "Dustwallow Marsh",
			EASTERN_PLAGUELANDS = "Eastern Plaguelands",
			ELWYNN_FOREST = "Elwynn Forest",
			FELWOOD = "Felwood",
			FERALAS = "Feralas",
			FORBIDDING_SEA = "The Forbidding Sea",
			GADGETZAN = "Gadgetzan",
			GNOMEREGAN = "Gnomeregan",
			GREAT_SEA = "The Great Sea",
			HALL_OF_LEGENDS = "Hall of Legends",
			HILLSBRAD_FOOTHILLS = "Hillsbrad Foothills",
			HINTERLANDS = "The Hinterlands",
			HYJAL = "Hyjal",
			IRONFORGE = "Ironforge",
			LOCH_MODAN = "Loch Modan",
			MARAUDON = "Maraudon",
			MOLTEN_CORE = "Molten Core",
			MOONGLADE = "Moonglade",
			MULGORE = "Mulgore",
			ONYXIAS_LAIR = "Onyxia's Lair",
			ORGRIMMAR = "Orgrimmar",
			RATCHET = "Ratchet",
			RAGEFIRE_CHASM = "Ragefire Chasm",
			RAZORFEN_DOWNS = "Razorfen Downs",
			RAZORFEN_KRAUL = "Razorfen Kraul",
			REDRIDGE_MOUNTAINS = "Redridge Mountains",
			RUINS_OF_AHN_QIRAJ = "Ruins of Ahn'Qiraj",
			SCARLET_MONASTERY = "Scarlet Monastery",
			SCHOLOMANCE = "Scholomance",
			SEARING_GORGE = "Searing Gorge",
			SHADOWFANG_KEEP = "Shadowfang Keep",
			SILITHUS = "Silithus",
			SILVERPINE_FOREST = "Silverpine Forest",
			STOCKADE = "The Stockade",
			STONETALON_MOUNTAINS = "Stonetalon Mountains",
			STORMWIND_CITY = "Stormwind City",
			STORMWIND_CITY_ALT = "Stormwind",
			STRANGLETHORN_VALE = "Stranglethorn Vale",
			STRATHOLME = "Stratholme",
			SWAMP_OF_SORROWS = "Swamp of Sorrows",
			TANARIS = "Tanaris",
			TELDRASSIL = "Teldrassil",
			TEMPLE_OF_AHN_QIRAJ = "Temple of Ahn'Qiraj",
			TEMPLE_OF_ATAL_HAKKAR = "The Temple of Atal'Hakkar",
			THOUSAND_NEEDLES = "Thousand Needles",
			THUNDER_BLUFF = "Thunder Bluff",
			TIRISFAL_GLADES = "Tirisfal Glades",
			ULDAMAN = "Uldaman",
			UN_GORO_CRATER = "Un'Goro Crater",
			UNDERCITY = "Undercity",
			UNDERCITY_ALT = "The Undercity",
			WAILING_CAVERNS = "Wailing Caverns",
			WARSONG_GULCH = "Warsong Gulch",
			WESTERN_PLAGUELANDS = "Western Plaguelands",
			WESTFALL = "Westfall",
			WETLANDS = "Wetlands",
			WINTERSPRING = "Winterspring",
			ZUL_FARRAK = "Zul'Farrak",
			ZUL_GURUB = "Zul'Gurub",
		}
	end
elseif locale == "deDE" then
	function initZones()
		zones = {
			ALTERAC_MOUNTAINS = "Das Alteracgebirge",
			ALTERAC_VALLEY = "Alteractal",
			ARATHI_BASIN = "Arathibecken",
			ARATHI_HIGHLANDS = "Das Arathihochland",
			ASHENVALE = "Ashenvale",
			AZSHARA = "Azshara",
			BADLANDS = "Das \195\150dland",
			BARRENS = "Das Brachland",
			BLACKFATHOM_DEEPS = "Blackfathom-Tiefe",
			BLACKROCK_DEPTHS = "Blackrocktiefen",
			BLACKROCK_MOUNTAIN = "Der Blackrock",
			BLACKROCK_SPIRE = "Blackrockspitze",
			BLACKWING_LAIR = "Pechschwingenhort",
			BLASTED_LANDS = "Die verw\195\188steten Lande",
			BOOTY_BAY = "Booty Bay",
			BURNING_STEPPES = "Die brennende Steppe",
			CAVERNS_OF_TIME = "Die H\195\182hlen der Zeit",
			DARKSHORE = "Dunkelk\195\188ste",
			DARNASSUS = "Darnassus",
			DEADMINES = "Die Todesminen",
			DEADWIND_PASS = "Der Gebirgspass der Totenwinde",
			DEEPRUN_TRAM = "Die Tiefenbahn",
			DESOLACE = "Desolace",
			DIRE_MAUL = "D\195\188sterbruch",
			DUN_MOROGH = "Dun Morogh",
			DUROTAR = "Durotar",
			DUSKWOOD = "Duskwood",
			DUSTWALLOW_MARSH = "Die Marschen von Dustwallow",
			EASTERN_PLAGUELANDS = "Die \195\182stlichen Pestl\195\164nder",
			ELWYNN_FOREST = "Der Wald von Elwynn",
			FELWOOD = "Teufelswald",
			FERALAS = "Feralas",
			FORBIDDING_SEA = "Das verbotene Meer",
			GADGETZAN = "Gadgetzan",
			GNOMEREGAN = "Gnomeregan",
			GREAT_SEA = "Das grosse Meer",
			HALL_OF_LEGENDS = "Halle der Legenden",
			HILLSBRAD_FOOTHILLS = "Die Vorgebirge von Hillsbrad",
			HINTERLANDS = "Das Hinterland",
			HYJAL = "Hyjal",
			IRONFORGE = "Ironforge",
			LOCH_MODAN = "Loch Modan",
			MARAUDON = "Maraudon",
			MOLTEN_CORE = "Geschmolzener Kern",
			MOONGLADE = "Moonglade",
			MULGORE = "Mulgore",
			ONYXIAS_LAIR = "Onyxias Hort",
			ORGRIMMAR = "Orgrimmar",
			RATCHET = "Ratchet",
			RAGEFIRE_CHASM = "Ragefireabgrund",
			RAZORFEN_DOWNS = "Die H\195\188gel von Razorfen",
			RAZORFEN_KRAUL = "Der Kral von Razorfen",
			REDRIDGE_MOUNTAINS = "Das Redridgegebirge",
			RUINS_OF_AHN_QIRAJ = "Ruinen von Ahn'Qiraj",
			SCARLET_MONASTERY = "Das Scharlachrote Kloster",
			SCHOLOMANCE = "Scholomance",
			SEARING_GORGE = "Die sengende Schlucht",
			SHADOWFANG_KEEP = "Burg Shadowfang",
			SILITHUS = "Silithus",
			SILVERPINE_FOREST = "Der Silberwald",
			STOCKADE = "Das Verlies",
			STONETALON_MOUNTAINS = "Das Steinkrallengebirge",
			STORMWIND_CITY = "Stormwind",
			STRANGLETHORN_VALE = "Stranglethorn",
			STRATHOLME = "Stratholme",
			SWAMP_OF_SORROWS = "Die S\195\188mpfe des Elends",
			TANARIS = "Tanaris",
			TELDRASSIL = "Teldrassil",
			TEMPLE_OF_AHN_QIRAJ = "Tempel von Ahn'Qiraj",
			TEMPLE_OF_ATAL_HAKKAR = "Der Tempel von Atal'Hakkar",
			THOUSAND_NEEDLES = "Thousand Needles",
			THUNDER_BLUFF = "Thunder Bluff",
			TIRISFAL_GLADES = "Tirisfal",
			ULDAMAN = "Uldaman",
			UN_GORO_CRATER = "Der Un'Goro Krater",
			UNDERCITY = "Undercity",
			WAILING_CAVERNS = "Die H\195\182hlen des Wehklagens",
			WARSONG_GULCH = "Warsongschlucht",
			WESTERN_PLAGUELANDS = "Die westlichen Pestl\195\164nder",
			WESTFALL = "Westfall",
			WETLANDS = "Das Sumpfland",
			WINTERSPRING = "Winterspring",
			ZUL_FARRAK = "Zul'Farrak",
			ZUL_GURUB = "Zul'Gurub",
		}
	end
elseif locale == "frFR" then
	function initZones()
		zones = {
			ALTERAC_MOUNTAINS = "Montagnes d'Alterac",
			ALTERAC_VALLEY = "Vall\195\169e d'Alterac",
			ARATHI_BASIN = "Bassin d'Arathi",
			ARATHI_HIGHLANDS = "Hautes-terres d'Arathi",
			ASHENVALE = "Ashenvale",
			AZSHARA = "Azshara",
			BADLANDS = "Terres ingrates",
			BARRENS = "Les Tarides",
			BLACKFATHOM_DEEPS = "Profondeurs de Brassenoire",
			BLACKROCK_DEPTHS = "Profondeurs de Blackrock",
			BLACKROCK_MOUNTAIN = "Mont Blackrock",
			BLACKROCK_SPIRE = "Pic Blackrock",
			BLACKWING_LAIR = "Repaire de l'Aile noire",
			BLASTED_LANDS = "Terres foudroy\195\169es",
			BOOTY_BAY = "Baie-du-Butin",
			BURNING_STEPPES = "Steppes Ardentes",
			CAVERNS_OF_TIME = "Grottes du temps",
			DARKSHORE = "Sombrivage",
			DARNASSUS = "Darnassus",
			DEADMINES = "Les mortemines",
			DEADWIND_PASS = "D\195\169fil\195\169 de Deuillevent",
			DEEPRUN_TRAM = "Tram des profondeurs",
			DESOLACE = "D\195\169solace",
			DIRE_MAUL = "Hache-Tripes",
			DUN_MOROGH = "Dun Morogh",
			DUROTAR = "Durotar",
			DUSKWOOD = "Bois de la p\195\169nombre",
			DUSTWALLOW_MARSH = "Mar\195\169cage d'\195\130prefange",
			EASTERN_PLAGUELANDS = "Maleterres de l'est",
			ELWYNN_FOREST = "For\195\170t d'Elwynn",
			FELWOOD = "Gangrebois",
			FERALAS = "Feralas",
			FORBIDDING_SEA = "La Mer interdite",
			GADGETZAN = "Gadgetzan", -- CHECK
			GNOMEREGAN = "Gnomeregan",
			GREAT_SEA = "La Grande mer",
			HALL_OF_LEGENDS = "Hall des L\195\169gendes",
			HILLSBRAD_FOOTHILLS = "Contreforts d'Hillsbrad",
			HINTERLANDS = "Les Hinterlands",
			HYJAL = "Hyjal", -- CHECK
			IRONFORGE = "Ironforge",
			LOCH_MODAN = "Loch Modan",
			MARAUDON = "Maraudon",
			MOLTEN_CORE = "C\221\181r du Magma",
			MOONGLADE = "Reflet-de-lune",
			MULGORE = "Mulgore",
			ONYXIAS_LAIR = "Repaire d'Onyxia",
			ORGRIMMAR = "Orgrimmar",
			RATCHET = "Ratchet",
			RAGEFIRE_CHASM = "Gouffre de Ragefeu",
			RAZORFEN_DOWNS = "Souilles de Tranchebauge",
			RAZORFEN_KRAUL = "Kraal de Tranchebauge",
			REDRIDGE_MOUNTAINS = "Les Carmines",
			RUINS_OF_AHN_QIRAJ = "Ruines d'Ahn'Qiraj",
			SCARLET_MONASTERY = "Monast\195\168re Ecarlate",
			SCHOLOMANCE = "Scholomance",
			SEARING_GORGE = "Gorge des Vents br\195\187lants",
			SHADOWFANG_KEEP = "Donjon d'Ombrecroc",
			SILITHUS = "Silithus",
			SILVERPINE_FOREST = "For\195\170t des pins argent\195\169s",
			STOCKADE = "La Prison",
			STONETALON_MOUNTAINS = "Les Serres-Rocheuses",
			STORMWIND_CITY = "Cit\195\169 de Stormwind",
			STRANGLETHORN_VALE = "Vall\195\169e de Strangleronce",
			STRATHOLME = "Stratholme",
			SWAMP_OF_SORROWS = "Marais des Chagrins",
			TANARIS = "Tanaris",
			TELDRASSIL = "Teldrassil",
			TEMPLE_OF_AHN_QIRAJ = "Le temple d'Ahn'Qiraj",
			TEMPLE_OF_ATAL_HAKKAR = "Le Temple d'Atal'Hakkar",
			THOUSAND_NEEDLES = "Mille pointes",
			THUNDER_BLUFF = "Thunder Bluff",
			TIRISFAL_GLADES = "Clairi\195\168res de Tirisfal",
			ULDAMAN = "Uldaman",
			UN_GORO_CRATER = "Crat\195\168re d'Un'Goro",
			UNDERCITY = "Undercity",
			WAILING_CAVERNS = "Cavernes des lamentations",
			WARSONG_GULCH = "Goulet des Warsong",
			WESTERN_PLAGUELANDS = "Maleterres de l'ouest",
			WESTFALL = "Marche de l'Ouest",
			WETLANDS = "Les Paluns",
			WINTERSPRING = "Berceau-de-l'Hiver",
			ZUL_FARRAK = "Zul'Farrak",
			ZUL_GURUB = "Zul'Gurub",
		}
	end
elseif locale == "zhCN" then
	function initZones()
		zones = {
			ALTERAC_MOUNTAINS = "\229\165\165\231\137\185\229\133\176\229\133\139\229\177\177\232\132\137",
			ALTERAC_VALLEY = "\229\165\165\231\137\185\229\133\176\229\133\139\229\177\177\232\176\183",
			ARATHI_BASIN = "\233\152\191\230\139\137\229\184\140\231\155\134\229\156\176",
			ARATHI_HIGHLANDS = "\233\152\191\230\139\137\229\184\140\233\171\152\229\156\176",
			ASHENVALE = "\231\129\176\232\176\183",
			AZSHARA = "\232\137\190\232\144\168\230\139\137",
			BADLANDS = "\232\141\146\232\138\156\228\185\139\229\156\176",
			BARRENS = "\232\180\171\231\152\160\228\185\139\229\156\176",
			BLACKFATHOM_DEEPS = "\233\187\145\230\154\151\230\183\177\230\184\138",
			BLACKROCK_DEPTHS = "\233\187\145\231\159\179\230\183\177\230\184\138",
			BLACKROCK_MOUNTAIN = "\233\187\145\231\159\179\229\177\177",
			BLACKROCK_SPIRE = "\233\187\145\231\159\179\229\161\148",
			BLACKWING_LAIR = "\233\187\145\231\191\188\228\185\139\229\183\162",
			BLASTED_LANDS = "\232\175\133\229\146\146\228\185\139\229\156\176",
			BOOTY_BAY = "Booty Bay", -- CHECK
			BURNING_STEPPES = "\231\135\131\231\131\167\229\185\179\229\142\159",
			CAVERNS_OF_TIME = "\230\151\182\229\133\137\228\185\139\231\169\180",
			DARKSHORE = "\233\187\145\230\181\183\229\178\184",
			DARNASSUS = "\232\190\190\231\186\179\232\139\143\230\150\175",
			DEADMINES = "\230\173\187\228\186\161\231\159\191\228\186\149",
			DEADWIND_PASS = "\233\128\134\233\163\142\229\176\143\229\190\132",
			DEEPRUN_TRAM = "\231\159\191\239\191\189?\239\191\189\229\156\176\239\191\189?", -- CHECK
			DESOLACE = "\229\135\132\229\135\137\228\185\139\229\156\176",
			DIRE_MAUL = "\229\142\132\232\191\144\228\185\139\230\167\140",
			DUN_MOROGH = "\228\184\185\232\142\171\231\189\151",
			DUROTAR = "\230\157\156\233\154\134\229\161\148\229\176\148",
			DUSKWOOD = "\230\154\174\232\137\178\230\163\174\230\158\151",
			DUSTWALLOW_MARSH = "\229\176\152\230\179\165\230\178\188\230\179\189",
			EASTERN_PLAGUELANDS = "\228\184\156\231\152\159\231\150\171\228\185\139\229\156\176",
			ELWYNN_FOREST = "\232\137\190\229\176\148\230\150\135\230\163\174\230\158\151",
			FELWOOD = "\232\180\185\228\188\141\229\190\183\230\163\174\230\158\151",
			FERALAS = "\239\191\189?\239\191\189\230\139\137\230\150\175", -- CHECK
			FORBIDDING_SEA = "The Forbidding Sea",
			GADGETZAN = "Gadgetzan", -- CHECK
			GNOMEREGAN = "\232\175\186\232\142\171\231\145\158\230\160\185",
			GREAT_SEA = "The Great Sea", -- CHECK
			HALL_OF_LEGENDS = "Hall of Legends", -- CHECK
			HILLSBRAD_FOOTHILLS = "\229\184\140\229\176\148\230\150\175\229\184\131\232\142\177\229\190\183\228\184\152\233\153\181",
			HINTERLANDS = "\232\190\155\231\137\185\229\133\176",
			HYJAL = "Hyjal", -- CHECK
			IRONFORGE = "\233\147\129\231\130\137\229\160\161", 
			LOCH_MODAN = "\230\180\155\229\133\139\232\142\171\228\184\185",
			MARAUDON = "\231\142\155\230\139\137\233\161\191",
			MOLTEN_CORE = "\231\134\148\231\129\171\228\185\139\229\191\131",
			MOONGLADE = "\230\156\136\229\133\137\230\158\151\229\156\176",
			MULGORE = "\232\142\171\233\171\152\233\155\183",
			ONYXIAS_LAIR = "\229\165\165\229\166\174\229\133\139\232\165\191\228\186\154\231\154\132\229\183\162\231\169\180",
			ORGRIMMAR = "\229\165\165\230\160\188\231\145\158\231\142\155",
			RATCHET = "Ratchet", -- CHECK
			RAGEFIRE_CHASM = "\230\128\146\231\132\176\232\163\130\232\176\183",
			RAZORFEN_DOWNS = "\229\137\131\229\136\128\233\171\152\229\156\176",
			RAZORFEN_KRAUL = "\229\137\131\229\136\128\230\178\188\230\179\189",
			REDRIDGE_MOUNTAINS = "\232\181\164\232\132\138\229\177\177",
			RUINS_OF_AHN_QIRAJ = "\229\174\137\229\133\182\230\139\137\229\186\159\229\162\159",
			SCARLET_MONASTERY = "\232\161\128\232\137\178\228\191\174\233\129\147\233\153\162",
			SCHOLOMANCE = "\233\128\154\231\129\181\229\173\166\233\153\162", -- CHECK
			SEARING_GORGE = "\231\129\188\231\131\173\229\179\161\232\176\183",
			SHADOWFANG_KEEP = "\229\189\177\231\137\153\229\159\142\229\160\161",
			SILITHUS = "\229\184\140\229\136\169\239\191\189?\230\150\175", -- CHECK
			SILVERPINE_FOREST = "\233\147\182\239\191\189?\239\191\189\230\163\174\230\158\151", -- CHECK
			STOCKADE = "\230\154\180\233\163\142\229\159\142\231\155\145\231\139\177",
			STONETALON_MOUNTAINS = "\231\159\179\231\136\170\229\177\177\232\132\137",
			STORMWIND_CITY = "\230\154\180\233\163\142\229\159\142",
			STRANGLETHORN_VALE = "\232\141\134\230\163\152\232\176\183",
			STRATHOLME = "\230\150\175\229\157\166\231\180\162\229\167\134",
			SWAMP_OF_SORROWS = "\230\130\178\228\188\164\230\178\188\230\179\189",
			TANARIS = "\229\161\148\231\186\179\229\136\169\230\150\175",
			TELDRASSIL = "\230\179\176\232\190\190\229\184\140\229\176\148",
			TEMPLE_OF_AHN_QIRAJ = "\229\174\137\229\133\182\230\139\137\231\165\158\230\174\191",
			TEMPLE_OF_ATAL_HAKKAR = "\233\152\191\229\161\148\229\147\136\239\191\189?\239\191\189\231\165\158\229\186\153", -- CHECK
			THOUSAND_NEEDLES = "\239\191\189?\239\191\189\233\146\136\231\159\179", -- CHECK
			THUNDER_BLUFF = "\233\155\183\233\156\134\229\180\150",
			TIRISFAL_GLADES = "\230\143\144\231\145\158\230\150\175\230\179\149\230\158\151\229\156\176",
			ULDAMAN = "\229\165\165\232\190\190\230\155\188",
			UN_GORO_CRATER = "\231\142\175\229\158\139\229\177\177",
			UNDERCITY = "\229\185\189\230\154\151\229\159\142",
			WAILING_CAVERNS = "\229\147\128\229\154\142\230\180\158\231\169\180",
			WARSONG_GULCH = "\230\136\152\230\173\140\229\179\161\232\176\183",
			WESTERN_PLAGUELANDS = "\232\165\191\231\152\159\231\150\171\228\185\139\229\156\176",
			WESTFALL = "\232\165\191\233\131\168\232\141\146\233\135\142",
			WETLANDS = "\230\185\191\229\156\176",
			WINTERSPRING = "\229\134\172\230\179\137\232\176\183",
			ZUL_FARRAK = "\231\165\150\229\176\148\230\179\149\230\139\137\229\133\139",
			ZUL_GURUB = "\231\165\150\229\176\148\230\160\188\230\139\137\229\184\131",
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
local localZones

function lib:GetEnglish(zone)
	return localZones[zone] or zone
end

function lib:GetLocalized(zone)
	return zones[zone] or zone
end

function lib:GetIterator()
	return pairs(zones)
end

function lib:GetReverseIterator()
	return pairs(localZones)
end

function lib:HasZone(zone)
	return (zones[zone] or localZones[zone]) and true or false
end

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
	initZones()
	initZones = nil
	
	localZones = {}
	for english, localized in pairs(zones) do
		if string.sub(english, -4) == "_ALT" then
			localZones[localized] = string.sub(english, 0, -5)
		elseif string.sub(english, -5, -2) == "_ALT" then
			localZones[localized] = string.sub(english, 0, -6)
		else
			localZones[localized] = english
		end
	end
end

function lib:LibDeactivate()
	zones, localZones, initZones = nil
end

BabbleLib:Register(lib)
lib = nil
