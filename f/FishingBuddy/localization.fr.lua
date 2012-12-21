FishingTranslations["frFR"] = {
   NAME = "Fishing Buddy";
   DESCRIPTION1 = "Se souvient des poissons pris et";
   DESCRIPTION2 = "organise votre \195\169quipement.";

   -- Tab labels and tooltips
   LOCATIONS_INFO = "Affiche les informations de p\195\170che locales";
   LOCATIONS = "R\195\169gions";
   OUTFITS_INFO = "Pr\195\169pare votre equipement de p\195\170che";
   OUTFITS = "Equipement";
   OPTIONS_INFO = "R\195\168gle les options";
   OPTIONS = "Options";
   TRACKING_INFO = "Affiche les donn\195\169es sur les poissons";
   TRACKING = "Donn\195\169es";

   POINT = "point";
   POINTS = "points";

   RAW = "Raw";

   BOBBER_NAME	= "Fishing Bobber";
   FISHINGSKILL = "P\195\170che";
   HELP = "Aide";
   SWITCH = "switch";
   IMPORT = "import";
   TRACK = "track";
   NOTRACK = "notrack";
   TRACKING = "tracking";

   ADD = "add";
   REPLACE = "replace";
   UPDATE = "update";
   CURRENT = "current";
   RESET = "reset";
   CLEANUP = "cleanup";
   CHECK = "check";
   NOW = "NOW";

   WATCHER = "watcher";
   WATCHER_LOCK = "lock";
   WATCHER_UNLOCK = "unlock";

   UNKNOWN = "Inconnu";
   WEEKLY = "Hebdomadaire";
   HOURLY = "toutes les heures";

   SHOWFISHIES = "Poissons";
   SHOWFISHIES_INFO = "Affiche vos prises class\195\169es par type de poisson.";

   SHOWLOCATIONS = "R\195\169gions";
   SHOWLOCATIONS_INFO = "Affiche vos prises class\195\169es par r\195\169gions.";

   SWITCHOUTFIT = "Equipement";
   SWITCHOUTFIT_INFO = "Vous habille avec votre \195\169quipement de p\195\170che, ou vous r\195\169habille comme avant.";

   CONFIG_SKILL_TEXT		= "P\195\170che ";

   TITAN_CLICKTOSWITCH_ONOFF	= "Clique pour changer";
   TITAN_CLICKTOSWITCH_INFO	= "Si activ\195\169, un clic gauche change l'\195\169quipement, si d\195\169sactiv\195\169, affiche la fen\195\170tre.";

   LEFTCLICKTODRAG = "Clique gauche pour bouger";

   MINIMAPBUTTONPLACEMENT = "Position du bouton";
   MINIMAPBUTTONPLACEMENTTOOLTIP = "Permet de bouger le bouton de #NAME# autour de la minimap";
   CONFIG_MINIMAPBUTTON_ONOFF	= "Affiche le bouton de la minimap.";
   CONFIG_MINIMAPBUTTON_INFO	= "Affiche le bouton de #NAME# pr\195\168s de la minimap.";

   CONFIG_ENHANCESOUNDS_ONOFF      = "Augmentez les bruits de p\195\170che";
   CONFIG_ENHANCESOUNDS_INFO       = "Maximisez le volume sain et r\195\169duisez au minimum le volume ambiant pour faire le bobber \195\169bruiter plus apparent tout en p\195\170chant.";

   TIMETOGO = "Le concours de p\195\170che commence dans %d:%02d";
   TIMELEFT = "Le concours de p\195\170che se termine dans %d:%02d";

   STVZONENAME = "Vall\195\169e de Strangleronce";
};

FishingTranslations["frFR"].IMPORT_HELP = {
      "|c0000FF00/fb #IMPORT#|r",
      "    Importe les donn\195\169es d'Impp's fishinfo ou de FishInfo2.",
   };
FishingTranslations["frFR"].SWITCH_HELP = {
      "|c0000FF00/fb #SWITCH#|r",
      "    Change l'\195\169quipement (si OutfitDisplayFrame ou Outfitter est charg\195\169)",
   };
FishingTranslations["frFR"].WATCHER_HELP = {
      "|c0000FF00/fb #WATCHER#|r [|c0000FF00#WATCHER_LOCK#|r or |c0000FF00#WATCHER_UNLOCK#|r or |c0000FF00#RESET#|r]",
      "    D\195\169v\195\169rouille pour bouger la fen\195\170tre,",
      "    lock pour arr\195\170ter, reset pour mettre a z\195\169ro",
   };
FishingTranslations["frFR"].CURRENT_HELP = {
      "|c0000FF00/fb #CURRENT# #RESET#|r",
      "    Met a z\195\169ro des poissons pris durant cette session.",
   };
FishingTranslations["frFR"].TRACKING_HELP = {
      "|c0000FF00/fb #TRACK#|r [|c0000FF00#HOURLY#|r or |c0000FF00#WEEKLY#|r] |c00FF00FF<fish link>|r",
      "    Surveille le temps de prise pour ce poisson (Maj-Click)",
      "|c0000FF00/fb #NOTRACK#|r |c00FF00FF<fish link>|r",
      "    Retire ce poisson (Maj-Click) du surveillant",
      "|c0000FF00/fb #TRACKING#|r",
      "    Un mauvais affichage du moment de prise d'un poisson surveill\195\169",
   };

FishingTranslations["frFR"].HELPMSG = {
      "Vous pouvez utiliser |c0000FF00/fishingbuddy|r ou |c0000FF00/fb|r pour toutes les commandes",
      "|c0000FF00/fb|r: seul, affiche/cache la fen\195\170tre de FishingBuddy",
      "|c0000FF00/fb #HELP#|r: affiche ce message",
      "#SWITCH_HELP#",
      "#WATCHER_HELP#",
      "#CURRENT_HELP#",
      "#IMPORT_HELP#",
      "#TRACKING_HELP#",
      " ",
      "Vous pouvez assigner une touche pour afficher/cacher la fen\195\170tre et/ou",
      "changer d'\195\169quipement dans la fen\195\170tre \"Raccourcis\".",

   BINDING_HEADER_FISHINGBUDDY_BINDINGS = "#NAME#";
   BINDING_NAME_FISHINGBUDDY_TOGGLE = "Toggle:#NAME#(Fen\195\170tre)";
   BINDING_NAME_FISHINGBUDDY_SWITCH = "Changer l'\195\169quipement";

   BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "Toggle: #NAME# (Panneau de r\195\169gion)";
   BINDING_NAME_TOGGLEFISHINGBUDDY_OUT = "Toggle: #NAME# (Panneau d'\195\169quipement)";
   BINDING_NAME_TOGGLEFISHINGBUDDY_TRK = "Toggle: #NAME# (Panneau de donn\195\169es)";
   BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "Toggle: #NAME# (Panneau d'options)";
};
