--[[
filename: localization.lua
author: Jeff Parker <jeff3parker@gmail.com>
created: Sat, 11 Jun 2005 14:15:00 -0800
updated: Sun, 12 Jun 2005 21:39:00 -0800

Special thanks to Thomas Friedrich for the German translations

]]

local PetFeeder_Version = "3.3.1.3";

	PF_FOM_DIET_MEAT	= "meat";
	PF_FOM_DIET_FISH	= "fish";
	PF_FOM_DIET_BREAD	= "bread";
	PF_FOM_DIET_CHEESE = "cheese";
	PF_FOM_DIET_FRUIT	= "fruit";
	PF_FOM_DIET_FUNGUS = "fungus";
	
	-- Beast family names
BAT = "Bat";
BEAR = "Bear";
BOAR = "Boar";
CARRION_BIRD = "Carrion Bird";
CAT = "Cat";
CRAB = "Crab";
CROCOLISK = "Crocolisk";
GORILLA = "Gorilla";
HYENA = "Hyena";
OWL = "Owl";
RAPTOR = "Raptor";
SCORPID = "Scorpid";
SPIDER = "Spider";
TALLSTRIDER = "Tallstrider";
TURTLE = "Turtle";
WIND_SERPENT = "Wind Serpent";
WOLF = "Wolf";

	PETFEEDER_TITLE = "PetFeeder v"..PetFeeder_Version;

	PETFEEDER_SESSION_DISABLED = "Not a Hunter class, disabling PetFeeder this session";
	
	-- binding texts
	BINDING_HEADER_PETFEEDER            = "Pet Feeder";
	BINDING_NAME_PETFEEDER_TOGGLE       = "Toggle the PetFeeder window";
	BINDING_NAME_PETFEEDER_FEED      = "Force feed pet (unless already feeding)";

	-- UI Text located in the XML file
	PETFEEDER_ENABLE="Enable PetFeed";
	PETFEEDER_AUTODETECT="Automatically detect/update foods";
	PETFEEDER_SKIPBUFF_FOODS="Skip Buff foods during auto detect";
	PETFEEDER_ENABLE_ALERTS="Enable PetFeed Alerts";
	PETFEEDER_FEEDING_THRESHOLD="Pet Feeding Threshold";
	PETFEEDER_CONSUME_FOODS="Consume Foods";
	PETFEEDER_SORT1="Sort by";
	PETFEEDER_SORT2="Then by";
	PETFEEDER_FOODS="Pet Foods";
	PETFEEDER_UNLIKED_FOODS="Unliked Pet Foods";
	PETFEEDER_CLEARFOODS="Clear Foods";
	PETFEEDER_UPDATEFOODS="Update Foods";
	PETFEEDER_RESTORES="Restores";  -- used to get the quality of food : "Use: Restores 62.5 points of health over 18 seconds"
	PETFEEDER_FEED_PET="Feed Pet";
	PETFEEDER_HUNTER="Hunter";
	PETFEEDER_REQUIREDAPPROVAL = "Require Approval";
	PETFEEDER_FEEDAPPROVED = "Feed Only Approved Foods";
	
	
	PETFEEDER_TAB_GENERAL = "General";
	PETFEEDER_TAB_LIST = "Foods";
	PETFEEDER_TAB_UNLIKED = "Unliked Foods";
	PETFEEDER_TAB_OPTIONS = "Options";
	PETFEEDER_TAB_APPROVED = "Approved Foods";
	
	PETFEEDER_APPROVE = "Approve";
	PETFEEDER_DISLIKE = "Dislike";
	
	PETFEEDER_APPROVE_FOOD = "Use this food";

	PETFEEDER_LEVELS_DROPDOWN = {
		{ name = "Content" },
		{ name = "Happy" }
	};

	PETFEEDER_SORTOPTION_DROPDOWN = {
		{ name = "None", func = nil},
		{ name = "By Quantity High->Low", func = sortQuantityHighLow },
		{ name = "By Quantity Low->High", func = sortQuantityLowHigh },
		{ name = "By Quality High->Low", func = sortQualityHighLow },
		{ name = "By Quality Low->High", func = sortQualityLowHigh },
		{ name = "Alphabetically Z-A", func = sortAlphabeticallyHighLow },
		{ name = "Alphabetically A-Z", func = sortAlphabeticallyLowHigh }
	};

	-- Chat message text
	PETFEEDER_FAILED_TO_FEED = "You fail to perform Feed Pet: Your pet doesn't like that food.";
	PETFEEDER_AFK = "You are now AFK: Away from Keyboard";
	PETFEEDER_FOODTOOLOW    = "You fail to perform Feed Pet: That food's level is not high enough for your pet.";
	
	-- Food buffs
	PETFEEDER_ITEM_ATTRIBUTE_BUFFS = {
		 { search = "If you spend at least (%d+)" }
		,{ search = "for (%d+) min" }
		,{ search = "for the next (%d+) min" }
	};
	
	PETFEEDER_NEED_PET = "You need a pet to do this";
	
	PETFEEDER_PET_DIES_MSG = "dies.";
	
	-- Messages
	PETFEEDER_ESTABLISH_PET = "You need to establish a pet first";
	PETFEEDER_REMOVE_FOOD = "PetFeeder removing unliked food ";
	PETFEEDER_UNLIKED_FOOD = "Your pet doesn't like to eat ";
	PETFEEDER_EATS_A = " starts to eat a ";
	PETFEEDER_NO_FOOD = " could not find any food to eat.";
	PETFEEDER_BEGIN_SEARCH = " begins looking for food...";

	FOOD_SEARCH = { " Meat", " Jerky", "Crispy", " Kabob", " Ribs", " Flank", " Flesh", " Leg", " Steak", " Sausage", " Stew"
				   ,"Crispy", "Mutton", "Venison", "Chops", "Shank", "Barbecued", "Roast", "Mackerel", "Smallfish"
				   ,"Raw ", "Albacore", "Snapper", "Filet", "Fillet", "Catfish", " Cod", " Trout", "Bloodbelly", "Grilled"
				   ,"  Bass"," Salmon", "Cheddar", "Yellowtail", "Cooked ", "Baked ", " Bread", " Muffin", " Cookie"
				   ,"Crab", "Cornbread", " Rye", " Cake", "Ricecake", "Pumpernickel", "Sourdough", "Sweet Roll", "Mushroom"
				   ,"Senggin", "Morel", "Delicious", "Bleu", "Dalaran Sharp", "Dwarven Mild", "Brie", "Swiss", "Apple"
				   ,"Banana", "Pumpkin", "Peach", "Plantain", "Watermelon", "Savory", " Surprise", " Chowder", " Soup"
				   ,"Seasoned", "Gumbo", "Deviled", "Omelet", "Scorcho", "Bisque", "Rockscale", "Bolete", " Chi"
				   ,"Monster Om", "Squid", "Ice Cream","Melon", "Boiled"
				  };

	PETFEEDER_CLICKFEEDPET		= "Click to feed pet with Pet Feeder";
	PETFEEDER_CLICKOPENOPTIONS	= "Click to open Pet Feeder options";
	PETFEEDER_CLICKMOVEBAR		= "Click and hold to move this bar";
	PETFEEDER_SHOWBUTTONBAR		= "Enable Button Bar";
	PETFEEDER_CONSUMABLE		= "Consumable";
	PETFEEDER_TRADEGOODS		= "Trade Goods";
	
	PETFEEDER_PETHUNGERY		="Your pet is hungery"
	
if (GetLocale() == "deDE") then
	PF_FOM_DIET_MEAT	= "fleisch";
	PF_FOM_DIET_FISH	= "fisch";
	PF_FOM_DIET_BREAD	= "brot";
	PF_FOM_DIET_CHEESE = "käse";
	PF_FOM_DIET_FRUIT	= "obst";
	
	-- Beast family names
	BAT = "Fledermaus";
	BEAR = "Bär";
	BOAR = "Eber";
	CARRION_BIRD = "Aasvogel";
	CAT = "Katze";
	CRAB = "Krebs";
	CROCOLISK = "Krokilisk";
--	GORILLA = "Gorilla";		-- same as enUS
	HYENA = "Hyäne";
	OWL = "Eule";
--	RAPTOR = "Raptor";		-- same as enUS
	SCORPID = "Skorpid";
	SPIDER = "Spinne";
	TALLSTRIDER = "Weitschreiter";
	TURTLE = "Schildkröte";
	WIND_SERPENT = "Windnatter";
--	WOLF = "Wolf";		-- same as enUS

	PETFEEDER_TITLE = "PetFeeder v"..PetFeeder_Version;

	PETFEEDER_SESSION_DISABLED = "Not a Hunter class, disabling PetFeeder this session";
	
	-- binding texts
	BINDING_HEADER_PETFEEDER            = "Pet Feeder";
	BINDING_NAME_PETFEEDER_TOGGLE       = "schalte das PetFeeder Fenster um";
	BINDING_NAME_PETFEEDER_FEED      = "f\195\188ttere Tier";

	-- UI Text located in the XML file
	PETFEEDER_ENABLE="PetFeed aktivieren";
	PETFEEDER_AUTODETECT="Futter automatisch hinzuf\195\188gen";
	PETFEEDER_ENABLE_ALERTS="Meldungen aktivieren";
	PETFEEDER_FEEDING_THRESHOLD="fressen bis";
	PETFEEDER_CONSUME_FOODS="Futter Anordnen";
	PETFEEDER_FEED_PET="f\195\188ttere Tier";
	PETFEEDER_SORT1="sortiere nach";
	PETFEEDER_SORT2="dann nach";	
	PETFEEDER_PETFOODS="Tierfutter";
	PETFEEDER_CLEARFOODS="L\195\182schen";
	PETFEEDER_UPDATEFOODS="Aktualisieren";
	PETFEEDER_HUNTER="J\195\164ger";
	
	PETFEEDER_LEVELS_DROPDOWN = {
		{ name = "Zufrieden" },
		{ name = "Gl\195\188cklich" }
	};

	PETFEEDER_SORTOPTION_DROPDOWN = {
	{ name = "wie hinzugef\195\188gt",  func = nil  },
	{ name = "nach Menge hoch->niedrig", func = sortQuantityLowHigh },
	{ name = "nach Menge niedrig->hoch", func = sortQuantityLowHigh },
	{ name = "nach Qualität hoch->niedrig", func = sortQualityHighLow },
	{ name = "nach Qualität niedrig->hoch", func = sortQualityLowHigh },
	{ name = "alphabetisch Z-A", func = sortAlphabeticallyHighLow },
	{ name = "alphabetisch A-Z", func = sortAlphabeticallyLowHigh }
};

	-- Chat message text
	PETFEEDER_FAILED_TO_FEED = "Euer Begleiter mag dieses Futter nicht.";
	PETFEEDER_AFK = "Ihr seit jetzt AFK:";
	PETFEEDER_FOODTOOLOW    = "Die Stufe des Essens ist nicht hoch genugf\195\188r Euren Begleiter";

	-- Food buffs
	PETFEEDER_ITEM_ATTRIBUTE_BUFFS = {
		 { search = "Wenn Ihr mindestens (%d+) Sekunden mit Essen verbringt" }
		,{ search = "for (%d+) min" }
		,{ search = "for the next (%d+) min" }
	};
	
	PETFEEDER_PET_DIES_MSG = "stirbt.";
	
	-- Messages
	PETFEED_ESTABLISH_PET = "Du musst ein Tier bei Dir haben.";
	PETFEEDER_REMOVE_FOOD = "PetFeeder entfernt unbeliebtes Futter ";
	PETFEEDER_UNLIKED_FOOD = "Dein Tier mag dieses Futter nicht.";
	PETFEEDER_EATS_A = " frisst ein ";
	PETFEEDER_NO_FOOD = " konnte kein passendes Futter finden";
	PETFEEDER_BEGIN_SEARCH = " schn\195\188ffelt in Deinen Taschen...";
	
	FOOD_SEARCH = { " Fleisch", " Ruckartig", "Knusprig", " Kabob", " Rippen", " Flanke", " Flesh", " Bein", " Steak", " Wurst", " Eintopf"
				   ,"Hammelfleisch", "Rehfleisch", "Hackt", "Shank", "Gegrillt", "Braten", "Mackerel", "Smallfish"
				   ,"Roh ", "Albacore", "Snapper", "Filet", "Fillet", "Wels", " Kabeljau", " Forelle", "Bloodbelly", "Gegrillt"
				   ,"  Bass"," Lachs", "Cheddarkäse", "Yellowtail", "Gekocht ", "Gebacken ", " Brot", " Muffinkuchen", " Plätzchen"
				   ,"Krebs", "Cornbread", " Rye", " Kuchen", "Ricecake", "Pumpernickel", "Sourdough", "Süße Rolle", "Pilz"
				   ,"Senggin", "Morel", "Köstlich", "Bleu", "Dalaran Sharp", "Dwarven Mild", "Brie", "Schweizer", "Apfel"
				   ,"Banane", "Kürbis", "Pfirsich", "Plantain", "Wassermelone", "Lecker", " Überraschung", " Chowder", " Suppe"
				   ,"Seasoned", "Gumbo", "Deviled", "Omelet", "Scorcho", "Bisque", "Rockscale", "Bolete", " Chi"
				   ,"Monster Om", "Tintenfisch", "Eis"
				  };
				  
	PETFEEDER_CONSUMABLE		= "Verbrauchbar";
	PETFEEDER_TRADEGOODS		= "Handwerkswaren";

elseif (GetLocale() == "frFR") then
	
	PF_FOM_DIET_MEAT	= "viande";
	PF_FOM_DIET_FISH	= "poisson";
	PF_FOM_DIET_BREAD	= "pain";
	PF_FOM_DIET_CHEESE = "fromage";
	PF_FOM_DIET_FRUIT	= "fruit";
	PF_FOM_DIET_FUNGUS = "champignon";
	
	-- Beast family names
	 BAT = "Chauve-souris";
	 BEAR = "Ours";
	 BOAR = "Sanglier";
	 CARRION_BIRD = "Charognard";
	 CAT = "Félin";
	 CRAB = "Crabe";
	 CROCOLISK = "Crocilisque";
	 GORILLA = "Gorille";
	 HYENA = "Hyène";
	 OWL = "Chouette";
	 RAPTOR = "Raptor";
	 SCORPID = "Scorpide";
	 SPIDER = "Araignée";
	 TALLSTRIDER = "Haut-trotteur";
	 TURTLE = "Tortue";
	 WIND_SERPENT = "Serpent des vents";
	 WOLF = "Loup";
	
	PETFEEDER_SESSION_DISABLED = "Not a Hunter class, disabling PetFeeder this session";
	
	BINDING_HEADER_PETFEEDER = "Pet Feeder";
	BINDING_NAME_PETFEEDER_TOGGLE = "Ouvrir la fenetre Pet Feeder";
	BINDING_NAME_PETFEEDER_FEED = "Force le Familier \195\160 s'alimenter (sauf si il est en train de manger)";

	-- UI Text located in the XML file
	PETFEEDER_ENABLE="PetFeed actif";
	PETFEEDER_AUTODETECT="d\195\169tection et mise \195\160 jour automatiques";
	PETFEEDER_SKIPBUFF_FOODS="Ignorer les demandes pendant la d\195\169tection";
	PETFEEDER_ENABLE_ALERTS="Alertes actives";
	PETFEEDER_FEEDING_THRESHOLD="Seuil d'alimentation";
	PETFEEDER_CONSUME_FOODS="Nourritures consomm\195\169es";
	PETFEEDER_SORT1="Trier par";
	PETFEEDER_SORT2="puis par";
	PETFEEDER_FOODS="Nourritures";
	PETFEEDER_UNLIKED_FOODS="Mauvaises Nourritures";
	PETFEEDER_CLEARFOODS="Effacer";
	PETFEEDER_UPDATEFOODS="Mettre \195\160 jour";
	PETFEEDER_RESTORES="Restauration"; -- used to get the quality of food : "Use: Restores 62.5 points of health over 18 seconds"
	PETFEEDER_FEED_PET="Nourrir";
	PETFEEDER_HUNTER="Chasseur";

	PETFEEDER_TAB_GENERAL = "G\195\169n\195\169ral";
	PETFEEDER_TAB_LIST = "Nourritures";
	PETFEEDER_TAB_UNLIKED = "Nourritures incorrectes";
	PETFEEDER_TAB_OPTIONS = "Options";

	PETFEEDER_LEVELS_DROPDOWN = {
	{ name = "Content" },
	{ name = "Heureux" }
	};

	PETFEEDER_SORTOPTION_DROPDOWN = {
	{ name = "Aucun", func = nil},
	{ name = "Quantit\195\169s d\195\169croissantes", func = sortQuantityHighLow },
	{ name = "Quantit\195\169s croissantes", func = sortQuantityLowHigh },
	{ name = "Qualit\195\169s d\195\169croissantes", func = sortQualityHighLow },
	{ name = "Qualit\195\169s croissantes", func = sortQualityLowHigh },
	{ name = "Alphabetiquement Z-A", func = sortAlphabeticallyHighLow },
	{ name = "Alphabetiquement A-Z", func = sortAlphabeticallyLowHigh }
	};

	-- Chat message text
	PETFEEDER_FAILED_TO_FEED = "Votre Familier n'aime pas cette nourriture.";
	PETFEEDER_AFK = "Vous êtes maintenant absent";
	PETFEEDER_FOODTOOLOW = "Le niveau de cette nourriture n'est pas assez \195\169lev\195\169 pour votre Familier.";
	PETFEEDER_ITEM_ATTRIBUTE_BUFF= "Si vous d\195\169pensez au moins";
	PETFEEDER_ITEM_ATTRIBUTE_BUFFS = {
	{ search = "Si vous d\195\169pensez au moins (%d+)" }
	,{ search = "en (%d+) min" }
	,{ search = "pour les prochaines (%d+) min" }
	};

	PETFEEDER_NEED_PET = "Vous devez avoir un Familier pour faire cela";
	
	PETFEEDER_PET_DIES_MSG = "dies.";
	
	-- Messages
	PETFEEDER_ESTABLISH_PET = "Vous devez appeler un Familier d'abord";
	PETFEEDER_REMOVE_FOOD = "PetFeeder supprime les nourritures incorrectes";
	PETFEEDER_UNLIKED_FOOD = "Votre Familier n'aime pas manger cette nourriture";
	PETFEEDER_EATS_A = " mange ";
	PETFEEDER_NO_FOOD = " ne trouve pas \195\160 manger.";
	PETFEEDER_BEGIN_SEARCH = " cherche \195\160 manger...";
	FOOD_SEARCH = { " Meat", " Jerky", "Croustillant", " Kabob", " C\195\180tes", " Flanc", " Chair", " Patte", " Steak", " Saucisse", " Rago\195\187t"
	,"Croustillant ", "Mouton", "Venaison", "Chops", "Jarret", "Grill\195\169", "R\195\180tis", "Maquereau", "Poisson"
	,"Cru ", "Thon", "Snapper", "Filet", "Filet", "Poisson chat", " Morue", " Truite", "Bloodbelly", "Grillé"
	," Bass"," Saumon", "Cheddar", "Yellowtail", "Cuit ", "Dor\195\169 ", " Pain", " Muffin", " Cookie"
	,"Crabe", "Cornbread", " Seigle", " Cake", "Ricecake", "Pumpernickel", "Sourdough", "Sweet Roll", "Champignon"
	,"Senggin", "Morel", "D\195\169licieux", "Bleu", "Dalaran Sharp", "Dwarven Mild", "Brie", "Suisse", "Pomme"
	,"Banane", "Potiron", "P\195\170che", "Plantain", "Melon d'eau", "Savoureux", " Surprise", " Chowder", " Soupe"
	,"Seasoned", "Gumbo", "Deviled", "Omelette", "Scorcho", "Bisque", "Rockscale", "Bolet", " Chi"
	,"Monster Om", "Calmar", "Glace","Melon"
	}; 

end

