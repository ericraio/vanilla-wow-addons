-- Version : English - Ramble
-- FR Translation by : Rincevent 
-- Merged with AIOI - Norbet.
BINDING_HEADER_AIOBHEADER	= "All In One Bank";
BINDING_NAME_AIOBICON		= "AIOB Frame Toggle";
BINDING_NAME_AIOBCONFIG		= "AIOB Config Frame Toggle";

if (GetLocale() == "frFR") then
	-- é: C3 A9  - \195\169
	-- ê: C3 AA  - \195\170
	-- à: C3 A0  - \195\160
	-- î: C3 AE  - \195\174
	-- è: C3 A8  - \195\168
	-- ë: C3 AB  - \195\171
	-- ô: C3 B4  - \195\180
	-- û: C3 BB  - \195\187
	-- â: C3 A2  - \195\162
	-- ç: C3 A7  - \185\167
	--
	-- ': E2 80 99  - \226\128\153
	AIOB_MYADDON_NAME = "AIOB";
	AIOB_MYADDON_DESCRIPTION = "Une fen\195\170tre de banque simple et compacte";

	AIOB_CHAT_COMMAND_USAGE = {
		[1]="Usage: /AIOB [init reset show toggle replacebags cols column freeze unfreeze]",
		[2]="Commands:",
		[3]="show - affiche la fen\195\170tre AIOB",
		[4]="replacebank - Remplacer la banque normale",
		[5]="cols - Nombre de colonnes par ligne.",
		[6]="reset or init, Recr\195\169er votre profil avec les param\195\168tres par d\195\169faut.",
		[7]="freeze/unfreeze Bloquer/d\195\169bloquer le d\195\169placement de la fen\195\170tre AIOB."
	};


	AIOB_CHAT_PROFILE_CREATED = "AIOB: Nouveau profil cr\195\169e pour %s"; 
	AIOB_CHAT_OLDVERSION = "Ancienne Version detect\195\169e. Effacement des anciens profils";

	AIOB_CHAT_COLUMNS_FORMAT = "AIOB Nombre de colonnes mis \195\160 %d";
	AIOB_CHAT_FREEZEON = "AIOB position fixe";
	AIOB_CHAT_FREEZEOFF = "AIOB position libre";
	AIOB_CHAT_REPLACEBANKON = "AIOB remplace la banque";
	AIOB_CHAT_REPLACEBANKOFF = "AIOB ne remplace pas la banque";

	AIOB_PURCHASE_CONFIRM_S = "Etes vous s\195\187r de vouloir acheter un emplacement de sac pour %d argent?";
	AIOB_PURCHASE_CONFIRM_G = "Etes vous s\195\187r de vouloir acheter un emplacement de sac pour %d or?";

	AIOB_ATBANK = "A la Banque";

	AIOB_CONFIG_REPLACE = "Remplacer la banque";
	AIOB_CONFIG_FREEZE = "Bloquer la fen\195\170tre AIOB en place";
	AIOB_CONFIG_HIGHLIGHTITEMS = "Surligner les objets du sac";
	AIOB_CONFIG_HIGHLIGHTBAGS = "Surligner le sac des objets";
	AIOB_CONFIG_HIGHLIGHTCOLOR = "Couleur surlignage";

	AIOB_FROZEN_ERROR = "AIOB est bloqu\195\169e et ne peux pas \195\170tre d\195\169plac\195\169e...";

	AIOB_LOADED = "AIOB (par Ramble) charg\195\169e.";

	AIOB_CHAT_HIGHLIGHTBAGSON = "AIOB surlignera le sac des objets";
	AIOB_CHAT_HIGHLIGHTBAGSOFF = "AIOB ne surlignera pas le sac des objets";
	AIOB_CHAT_HIGHLIGHTITEMSON = "AIOB surlignera les objets du sac";
	AIOB_CHAT_HIGHLIGHTITEMSOFF = "AIOB ne surlignera pas les objets du sac";

	AIOB_FRAME_PLAYERANDREGION = "Banque de %s de %s";
	AIOB_FRAME_PLAYERONLY = "Banque de %s";
	AIOB_FRAME_SLOTS = "%d/%d emplacements";
	AIOB_FRAME_ALLREALMS = "Tous les Royaumes";
	AIOB_FRAME_SELECTPLAYER = "Afficher la banque de :";
	AIOB_FRAME_TOTAL = "(t)";
	AIOB_FRAME_BUY = "Acheter";
else
	AIOB_MYADDON_NAME	= "AllInOneBank";
	AIOB_MYADDON_DESCRIPTION = "A simple, compact bank frame window.";

	AIOB_CHAT_COMMAND_USAGE		= {
		[1]="Usage: /AIOB [init reset show toggle replacebags cols column freeze unfreeze]",
		[2]="Commands:",
		[3]="show - toggles the AIOB window",
		[4]="replacebank - if it should replace the bank or not",
		[5]="cols - how many columns there should be in each row.",
		[6]="reset or init, will recreate your profile with default settings.",
		[7]="freeze/unfreeze will lock/unlock the window for dragging."
	};

	AIOB_CHAT_PROFILE_CREATED   = "AIOB: New profile for %s was created";
	AIOB_CHAT_OLDVERSION        = "Old Version detected. Clearing old profiles.";
	
	AIOB_CHAT_COLUMNS_FORMAT			 = "AIOB number of columns set to %d.";
	AIOB_CHAT_FREEZEON                = "AIOB frozen.";
	AIOB_CHAT_FREEZEOFF               = "AIOB unfrozen.";
	AIOB_CHAT_REPLACEBANKON           = "AIOB replacing bank.";
	AIOB_CHAT_REPLACEBANKOFF          = "AIOB not replacing bank.";
	AIOB_CHAT_HIGHLIGHTBAGSON		    = "AIOB will highlight item's bag.";
	AIOB_CHAT_HIGHLIGHTBAGSOFF		    = "AIOB not highlighting item's bag.";
	AIOB_CHAT_HIGHLIGHTITEMSON		    = "AIOB will highlight bag's items.";
	AIOB_CHAT_HIGHLIGHTITEMSOFF		 = "AIOB not highlighting bag's items.";

	AIOB_PURCHASE_CONFIRM_S = "Are you sure you wish to purchase a bag slot for %d silver?";
	AIOB_PURCHASE_CONFIRM_G = "Are you sure you wish to purchase a bag slot for %d gold?";
	
	AIOB_ATBANK = "At Bank";
	
	AIOB_CONFIG_REPLACE = "Replace Bank";
	AIOB_CONFIG_FREEZE  = "Freeze AIOB";
	AIOB_CONFIG_HIGHLIGHTITEMS = "Highlight Bag's Items";
	AIOB_CONFIG_HIGHLIGHTBAGS  = "Highlight Item's Bag";
	AIOB_CONFIG_HIGHLIGHTCOLOR = "Highlight Color";
	
	AIOB_FROZEN_ERROR = "AIOB is frozen and can not move...";
	
	AIOB_LOADED = "AIOB AddOn loaded.";
	
	AIOB_FRAME_PLAYERANDREGION = "%s of %s's Bank";
	AIOB_FRAME_PLAYERONLY      = "%s's Bank";
	AIOB_FRAME_SLOTS           = "%d/%d Slots.";
	AIOB_FRAME_ALLREALMS       = "All Realms";
	AIOB_FRAME_SELECTPLAYER    = "Select Player's Bank to Show";
	AIOB_FRAME_TOTAL           = "(total)";
	AIOB_FRAME_BUY             = "Buy";
end

