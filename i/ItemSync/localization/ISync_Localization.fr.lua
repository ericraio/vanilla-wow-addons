--[[--------------------------------------------------------------------------------
  ItemSync French Localization

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

	-- Traduction par vjeux
	-- Modifié le 15/01/2006 par KKram
	-- Original Translation by Minsonganger! Thanks again Minsonganger.
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

if ( GetLocale() == "frFR" ) then

	ISYNC_COST      	= "Vente pour ";
	ISYNC_VENDORCOST      	= "Vendeur pour ";
	ISYNC_NOSELLPRICE	= "Pas de Prix de Vente";

	ISYNC_SHOWVALID		= "Valide";
	ISYNC_SHOWINVALID	= "Invalide";
	ISYNC_SHOWSUBITEM	= "-Sub Item-";
	ISYNC_SHOWSUBITEM2	= "-Name Unknown-";

	ISYNC_SHOWINVALID_BUTTON = "Voir Objets invalides";
	
	ISYNC_SLASHRESETWINDOWS = "Reset All Windows";

	ISYNC_ITEMISINVALID_TOOLTIP1 = "<Objet invalide>";
	ISYNC_ITEMISINVALID_TOOLTIP2 = "Note: There may be a chance that\nthe item is now valid.  Pass your\nmouse over the link again to check.\nIf you see the actual tooltip then\nthe item is now valid. [REFRESH]";
	ISYNC_ITEMISINVALID_TOOLTIP3 = "\n\nWARNING: YOU MAY GET\nDISCONNECTED!\nUSE AT YOUR OWN RISK!";
	ISYNC_ITEMISINVALID_TOOLTIP4 = "|c00FF9900Click Link:|r|c00BDFCC9 Send to ItemID Tool.|r";
		
	ISYNC_OPT_MONEY1 = "|c00FFFFFF1|r|c00E2CD54g|r |c00FFFFFF1|r|c00AEAEAEs|r |c00FFFFFF1|r|c00D7844Dc|r";
	ISYNC_OPT_MONEY2 = "|c00FFFFFF1|r |c00E2CD54g|r |c00FFFFFF1|r |c00AEAEAEs|r |c00FFFFFF1|r |c00D7844Dc|r";
	ISYNC_OPT_MONEY3 = "|c00FFFFFF1|r|c00E2CD54[g]|r |c00FFFFFF1|r|c00AEAEAE[s]|r |c00FFFFFF1|r|c00D7844D[c]|r";
	ISYNC_OPT_MONEY4 = "|c00FFFFFF1|r|c00E2CD54[G]|r |c00FFFFFF1|r|c00AEAEAE[S]|r |c00FFFFFF1|r|c00D7844D[C]|r";
	ISYNC_OPT_MONEY5 = "|c00FFFFFF1|r |c00E2CD54[g]|r |c00FFFFFF1|r |c00AEAEAE[s]|r |c00FFFFFF1|r |c00D7844D[c]|r";
	ISYNC_OPT_MONEY6 = "|c00FFFFFF1|r |c00E2CD54[G]|r |c00FFFFFF1|r |c00AEAEAE[S]|r |c00FFFFFF1|r |c00D7844D[C]|r";
	ISYNC_OPT_MONEY7 = "|c00E2CD541|r|c00FFFFFF.|r|c00AEAEAE2|r|c00FFFFFF.|r|c00D7844D3|r";
	
	ISYNC_NEWITEMS = "|c00FF9933New Items Available! (Click Refresh)|r";

	ISYNC_OPTGOLD1 = "g";
	ISYNC_OPTGOLD2 = "G";
	ISYNC_OPTSILVER1 = "s";
	ISYNC_OPTSILVER2 = "S";
	ISYNC_OPTCOPPER1 = "c";
	ISYNC_OPTCOPPER2 = "C";

	ISYNC_SORT_NAME = "Nom";
	ISYNC_SORT_RARITY = "Raret\195\169";

	ISYNC_BT_QUICKSEARCH = "Quick Search";
	ISYNC_BT_SEARCH = "Cherche";
	ISYNC_BT_REFRESH = "M\195\160j";
	ISYNC_BT_OPTIONS = "Options";
	ISYNC_BT_FILTERS = "Filtres";
	ISYNC_BT_BAGVIEW = "Voir sacs";
	ISYNC_BT_MODS = "Mods";
	ISYNC_BT_MAIN = "Main";
	ISYNC_BT_ITEMID = "ItemID";
	ISYNC_BT_MINIMAP = "Minimap";
	ISYNC_BT_FAVORITES = "Favorites";
	ISYNC_BT_PURGE = "Purge";

	ISYNC_MAIN_HEADER_OPTIONS = "Options";
	ISYNC_MAIN_HEADER_OPTIONSMOD = "Mod Options";
	ISYNC_MAIN_HEADER_OPTIONSSERVERS = "Servers";
	ISYNC_MAIN_HEADER_OPTIONSCLEAN = "Clean";
	ISYNC_MAIN_HEADER_OPTIONSGENERAL = "General";

	ISYNC_MONEYDISPLAY_HEADER = "AFFICHAGE DE L'ARGENT";

	ISYNC_FILTER_HEADER1 = "FILTRE PAR RARETE";
	ISYNC_FILTER_HEADER2 = "PURGE PAR RARETE";
	ISYNC_FILTER_HEADER3 = "PURGE OBJETS INVALIDES";
	ISYNC_FILTER_HEADER4 = "PURGE DOUBLONS";

	ISYNC_OPTIONS_HEADER1 = "PRIX DE VENTE";
	ISYNC_OPTIONS_HEADER1_SUB1 = "Affiche le prix de vente dans les bulles.";

	ISYNC_OPTIONS_HEADER2 = "PRIX VENDEUR";
	ISYNC_OPTIONS_HEADER2_SUB1 = "Affiche le prix du vendeur dans les bulles.";

	ISYNC_OPTIONS_HEADER3 = "DENOMBREMENT DES OBJETS";
	ISYNC_OPTIONS_HEADER3_SUB1 = "Affiche le d\195\169nombrement des objets.";

	ISYNC_OPTIONS_HEADER4 = "OPTIMISATION BASE DE DONNEE";

	ISYNC_OPTIONS_HEADER5 = "AFFICHAGE DES PRIX";
	ISYNC_OPTIONS_HEADER5_SUB1 = "Affiche les prix avec des ic\195\180nes.";

	ISYNC_OPTIONS_OPTIMIZE = "Optimiser";

	ISYNC_OPTIONS_MODS_HEADER1 = "AuctionMatrix/AuctionSync";
	ISYNC_OPTIONS_MODS_HEADER2 = "Auctioneer/Enchantrix";
	ISYNC_OPTIONS_MODS_HEADER3 = "Reagent Info";
	ISYNC_OPTIONS_MODS_HEADER4 = "Alerte de Qualit\195\169";
	ISYNC_OPTIONS_MODS_HEADER5 = "Alerte d'invalidit\195\169";
	ISYNC_OPTIONS_MODS_HEADER6 = "AllInOneInventory";
	ISYNC_OPTIONS_MODS_HEADER7 = "MyInventory";

	ISYNC_OPTIONS_MODS_HEADER1_SUB1 = "Envoi de la liste \195\160 AM/AS.";
	ISYNC_OPTIONS_MODS_HEADER2_SUB1 = "Envoi de la liste \195\160 Auctioneer/Enchantrix.";
	ISYNC_OPTIONS_MODS_HEADER3_SUB1 = "Envoi de la liste \195\160 Reagent Info.";
	ISYNC_OPTIONS_MODS_HEADER4_SUB1 = "Changement de qualit\195\169.";
	ISYNC_OPTIONS_MODS_HEADER5_SUB1 = "Conversion r\195\169ussie d'objets invalides.";
	ISYNC_OPTIONS_MODS_HEADER6_SUB1 = "Send item data to AllInOneInventory.";
	ISYNC_OPTIONS_MODS_HEADER7_SUB1 = "Send item data to MyInventory.";

	
	ISYNC_OPTIONS_SERVER_BUTTON = "Serveurs";
	ISYNC_OPTIONS_SERVER_HEADER1 = "FUSION DES BASES DE DONNEES SERVEUR";
	ISYNC_OPTIONS_SERVER_HEADER1_SUB1 = "Utilise la m\195\170me base de donn\195\169es entre serveurs.";
	ISYNC_OPTIONS_SERVER_MERGECOMPLETE = "La fusion a \195\169t\195\169 accomplie avec succ\195\168s.";

	ISYNC_BV_HELP = "Affiche total cumul\195\169";
	ISYNC_BV_HELP2 = "Cache prix inconnu";
	ISYNC_BV_HELP3 = "Tri par Prix";
	ISYNC_BV_HELP4 = "Tri par Raret\195\169";

	ISYNC_OPTIMIZE_TEXT      	= "Optimisation";
	ISYNC_OPTIMIZE_COMPLETE     = "Optimisation compl\195\168te";

	ISYNC_CLEANDB = "Nettoyage";
	ISYNC_CLEANDB_HEADER = "NETTOYAGE DES OBJETS DE LA BASE";
	ISYNC_CLEANDB_TOOLTIP = "Effectue un nettoyage rudimentaire de la base.\nLes objets invalides sont extraits\ndes objets valides.";
	ISYNC_CLEAN_SUCCESS = "Le processus de nettoyage est termin\195\169.";

	ISYNC_OPTIONS_CLEAN_HEADER1 = "Tooltip Item Texture Icons";
	ISYNC_OPTIONS_CLEAN_HEADER1_SUB1 = "Show item texture icons on tooltips.";
	
	ISYNC_OPTIONS_CLEAN_HEADER2 = "ItemSync MouseOver Inspect";
	ISYNC_OPTIONS_CLEAN_HEADER2_SUB1 = "Enable |c00A2D96F(MAY cause lag)|r";
	
	ISYNC_OPTIONS_GENERAL_HEADER1 = "ItemSync Chat Type Links";
	ISYNC_OPTIONS_GENERAL_HEADER1_SUB1 = "Enable the use of Type Links while typing.";

	ISYNC_MINIMAPBUTTON_HEADER = "ITEMSYNC MINIMAP BUTTON";
	ISYNC_MINIMAPBUTTON_TOOLTIP = "This option allows you to\nShow/Hide the minimap button.\nIt also allows you to\nset the minimap button\nlocation.";
	ISYNC_MINIMAPBUTTON_SLIDERTEXT = "Set MiniMap Button Position";
	ISYNC_MINIMAPBUTTON_CHECKBUTTON = "Show ItemSync Minimap Button.";

	ISYNC_ITEMIDFRAME_WARNING = "|c00FF0000WARNING: The creator of ItemSync is not\n responsible for any disconnections that\n may occur!|r\n|c00A2D96FUSE AT YOUR OWN RISK!|r";
	ISYNC_ITEMID_GREENBUTTON_WARNING = "|c00A2D96FThis item was inputed\nusing the ItemID tool.|r\n\n|c00FF0000The Creator of ItemSync\ntakes no responsibility in\ndisconnections caused by\nitems inputted by the\nuser themselves.|r";
	
	ISYNC_DELETEITEM_MSG_PART1 = "Are you sure you want to delete";
	ISYNC_DELETEITEM_MSG_PART2 = "NOTE: This process cannot be undone";
	
	ISYNC_QUALITY_CHANGE1 = "|c00A2D96FItemSync: Quality for [|c00FF9900";
	ISYNC_QUALITY_CHANGE2 = "|r|c00A2D96F] has been updated.  Please refresh to view new quality.|r";
	
	ISYNC_DBUPDATE = "Database Update";
	ISYNC_DBUPDATE_INFO = "|c00FFFFFFItemSync must upgrade the database.|r\n|c00FF0000If you don't, ItemSync will be disabled.|r";
	
	ISYNC_PURGEDB = "Purge Database";
	ISYNC_PURGEDB_HEADER = "RESET/PURGE ITEM DATABASE";
	ISYNC_PURGEDB_TOOLTIP = "This will purge the entire item database.\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";

	ISYNC_CLEANER_HEADER = "Invalid Cleaner";
	ISYNC_CLEANER_BUTTON = "Start Cleaning";
	ISYNC_CLEANER_TOOLTIP = "Will run through all the invalids\nand attempt to validate them.n\n\n|c00FF0000WARNING: The creator of\nItemSync is not responsible\nfor any disconnections\nthat may occur!";
	ISYNC_CLEANER_COMPLETE = "Invalid cleaning process is complete.";
	
	
	ISYNC_HELPBUTTON = "[Aide]";
	ISYNC_HELPPANEL_TOOLTIP = "Ouvre la fen\195\170tre d'aide.";
	ISYNC_HELPPANEL_DESC = "Welcome to ItemSync.  ItemSync is a mod that gathers items as you come across them.  If ItemSync cannot determine the item it will add it to an invalid list for later processing.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000Rarity Dropdown:|r\nAllows you to sort the item list by the selected method.\n\n|c00FF0000Refresh Button:|r\nRefreshes the main item list by the last sorted method. ";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000Search Button:|r\nAllows you to search the item database using different options.\n\n|c00FF0000Show Invalid Items:|r\nDisplays the list of invalid items stored by ItemSync. ";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000Filters Button:|r\nAllows you to access the filters panel.\n\n|c00FF0000Bag View:|r\nBrings up a window with all your items and their sell values. ";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000Options Button:|r\nAllows you to access the options panel.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFSEARCH OPTIONS:|r\n\nYou can finite your search by using many of the options available to you.  If you wish to link an item that was search simply close the search window and link the item from the item list as you normally would.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."Once you close the window you lose your search data.  It will be refreshed to show all the items once again.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFFILTER OPTIONS:|r\n\nIn this window you can set what quality items ItemSync can grab.  NOTE: This does not filter the main item view in any way.  What it does do, is tell ItemSync which quality items you prefer for it to store.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nIn this panel you also have some purging options.  Please take care with these options because it's irreversable!  When you purge duplicate items it will purge all items from both the valid and invalid database.  The same thing applies when you purge the invalid items.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nPlease take caution when you purge by rarity.  It will not give you a warning and it will siply just purge the items by the selected quality.  If you make a mistake it cannot be undone.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFBAG VIEW:|r\n\nThis window allows you to view all your items in your inventory that have a value to them.  You have several options available to you including sorting by rarity and price.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nNOTE: You will not be able to see any items in bag view until you visit a merchant.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nBag View is programmed to work just like any other bag.  You can repair items ,sell items, and even right click on items to use them.  Think of it as your second simple bag.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFOPTIONS MENU:|r\n\nThis window allows you to modify several visual aspects of ItemSync.  You have the ability to turn on/off the vendor and price values.  You even have the option to select wether you want money in text or icon format.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nYou cannot have both text and icon money displaying at the same time.  Please be advised that many mods out there use tooltips and ItemSync cannot possibly work perfectly with all of them.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nNOTE: No money values will show unless you have the vendor or price options checked.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFOPTIONS MOD MENU:|r\n\nThis window allows you to modify what mods ItemSync sends data to.  This is a great place to turn on/off options to increase functionality with other mods.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nPlease be advised that these options are programmed to -STOP- sending information period if you turn if off.  If by -SOME- chance another mod still picks up information and attaches it to the tooltips.  It is -THAT- mod that is hooking/linking to ItemSync.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nWhat does this mean?  Basically the other mod has already hooked into the ItemSync functions to attach itself to the tooltips.  Thus you don't need ItemSync to send information.  The simpliest way to fix this is by turning off the options to send data.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nIf you don't want any alerts to be shown when quality is changed or invalid items are processed, then you have the option to turn if off.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00A2D96FOPTIMIZE BUTTON:|r\n\nAllows ItemSync to go through all your items and check to see if they are invalid or not.  This option -ALSO- updates the search features of each item making it more available to you while using the search ability.";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nOptimizing also cleans out your database by sorting the invalid from valid items.  It is a great feature to use once and awhile and I recommend doing it, especially after a WOW PATCH.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFWhy can't I link invalid items?|r\n\nSimple, because you can't.  If the ability was given to users they would be disconnected each time they linked an invalid item.  Blizzard has already said they don't like item gatherers.  They have take great precation to prevent item info farming.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFWhy did all my items become invalid all of a sudden?|r\n\nBecause the server restarted either after maintenance or from a patch.  Each time the server is restarted the itemID's that are stored on server get refreshed.  This means that all your items or I should say most become invalid because they no longer match those on the server.\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\nIn order for those items to become valid again.  The person with the original item has to logon to the server and upload their itemcache.  Once this is done then your item should and I repeat -SHOULD- become valid.  If not, then that itemID has already been rewritten and is no longer valid.  Once again Blizzard does NOT like item farming and thus";	
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.." they have gone to great pain to prevent it.  If you feel you shouldn't lose your items you have gathered then blame Blizzard not the creator of ItemSync.\n\n";	
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFHow do I use the Dressing Room?|r\n\nControl+LeftClick on an item in the main list view or bag view.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFHow do I delete an item?|r\n\nAlt+RightClick on an item in the main list view.  Note this action cannot be undone!  A warning will be provided for you.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFWhat are the available slash commands for ItemSync and Bag View?|r\n\n/itemsync, /isync, /ims, /is\n\n/bagview, /bv, /bagv \n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFCan I search for items using a slash command?|r\n\nYes you can!  Just use any of the slash commands your familiar with for ItemSync and use the search command to it.  \n\nExample: /is search itemname\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFDoes ItemSync have any hotkeys?|r\n\nYes you can setup hotkeys to open both the main window and the bag view.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFHow does invalid parsing work?|r\n\nIt's simple each time an item is found it is matched between the valid list and the invalid list.  If it's in the valid list already then it's ignored.  However if it's in the invalid list then it gets removed from the invalid list and put into the valid list.  Everytime you open the main window";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.." all the invalid items get checked.  There is a function that tries to play around with invalid itemid's to see if it can make it valid.  If the function can make it valid then it removes it from the invalid database and puts it into the valid database.  NOTE: It -MAY- not be the exact item it was before but at least that's one more valid item you have then invalid.";	
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\nItemSync has tons of routines that are constantly monitoring and searching for ways to keep your items valid at all costs.\n\n";	
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFWhy do I have duplicate items and how do I get rid of it?|r\n\nSomehow when certain items get processed their names change because of different itemid's then that one that is stored.  When this happens you get duplicated items.  This doesn't ALWAYS happen but once in awhile it does.  If you want to cleanup your database just use the purge duplicate item ability in the filters panel.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFCan I force invalid items to work?|r\n\nYou won't be able to unless you haxxored ItemSync.  If you did then don't come to me if you keep getting disconnected or worse crash.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFWhy doesn't a certain mod work with ItemSync?|r\n\nBecause that author never included ItemSync support in their mod.  Please alert -THEM- not -ME- that you want them to support ItemSync.  I will only add support for a mod if it's extremely important.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFGosh your a great guy and I want to give you my thanks?|r\n\nYou can thank me by sharing how you feel about ItemSync with your friends.  It's the gift that keeps on giving.\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFWhy do I disconnect when I use the ItemID lookup?|r\n\nThis tool has no support and you USE IT AT YOUR OWN RISK.  If you are disconnected the creator of ItemSync is not responsible.  The reason you may disconnect is because that item may not be in your LOCAL item cache or the SERVE hasn't ever seen it yet.  When this happens you get disconnected.  Once again ItemSync is not responsible for any disconnections.  You have been warned!\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFHow can I add items while I type?|r\n\nIt's simple just type it out within brackets as you go.  So if you type [copper bar] it will replace it with the actual link.  It's not case sensative so don't worry.\n\nNOTE: Make sure you have ItemSync Type Links enabled under the general tab of the options panel.\n\n";
	

	ISYNC_HELP_SUB1 = "This option allows ItemSync to\nonly -GRAB- the items you choose by quality.\n\n|c00FF0000NOTE: This does -NOT- sort or\nfilter the main list view!|r";
	ISYNC_HELP_SUB2 = "This will delete duplicated\n items from both the invalid\n items and valid from all rarity.\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";
	ISYNC_HELP_SUB3 = "This will purge all invalid items.\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";
	ISYNC_HELP_SUB4 = "Permet d'effacer tous les objets par raret\195\169.\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";
	ISYNC_HELP_SUB5 = "Choisissez le format utilis\195\169\npour afficher l'argent.";
	ISYNC_HELP_SUB6 = "Choisissez si vous souhaitez\nvoir le nombre d'objet.";
	ISYNC_HELP_SUB7 = "Choisissez si vous souhaitez\nvoir le prix du vendeur.";
	ISYNC_HELP_SUB8 = "Choisissez si vous souhaitez\nvoir le prix de vente.";
	ISYNC_HELP_SUB9 = "Optimiser: Permet au mod de trier la qualit\195\169\ et de mettre \195\160 jour les objets invalides ou valides en cons\195\169\quence.";
	ISYNC_HELP_SUB10 = "Choisir cette option permet \195\160 ItemSync d'envoyer les donn\195\169\es \195\160 AuctionMatrix pour traitement.";
	ISYNC_HELP_SUB11 = "Choisir cette option permet \195\160 ItemSync d'envoyer les donn\195\169\es \195\160 Auctioneer/Enchantrix pour traitement.";
	ISYNC_HELP_SUB12 = "Choisir cette option permet \195\160 ItemSync d'envoyer les donn\195\169\es \195\160 Reagent Info pour traitement.";
	ISYNC_HELP_SUB13 = "Choisissez si vous souhaitez\navoir une alerte si la qualit\195\169\n d'un objet change.";
	ISYNC_HELP_SUB14 = "Choisissez si vous souhaitez\navoir une alerte quand des\nobjets invalides sont valid\195\169s.";
	ISYNC_HELP_SUB15 = "Choisissez si vous souhaitez\nafficher l'argent en utilisant\ndes ic\195\180nes au lieu du texte.";
	ISYNC_HELP_SUB16 = "This will merge itemsync databases.\nThis will allow you to use\n the same database across servers.\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";
	ISYNC_HELP_SUB17 = "Select whether you wish to\nsend tooltip data to\nAllInOneInventory.";
	ISYNC_HELP_SUB18 = "Select whether you wish to\nsend tooltip data to\nMyInventory.";
	ISYNC_HELP_SUB19 = "Select whether you wish to\nview item texture icons on\nleft hand side of tooltips.";
	ISYNC_HELP_SUB20 = "If this option is enabled\nthen any items you type via\nchat within brackets will be\nreplaced with a clickable item link.\n\n|c00A2D96FExample: [copper bar]\nwould be replaced with\nthe actual clickable item link.|r";
	ISYNC_HELP_SUB21 = "If this option is enabled,\nthen itemsync will gather\nitems by inspecting players\nwhen you pass your mouse\nover them.\n\n|c00A2D96FNote: This may case lag!|r";


	ISYNC_OLDDBDELETED = "Ancienne base de donn\195\169e effac\195\169e.  Une nouvelle base a \195\169t\195\169 cr\195\169\195\169 avec le formatage correct";

	ISYNC_DUPEITEMDELETED = "Les doublons ont \195\169t\195\169 effac\195\169s";
	ISYNC_INVALIDPURGESUCCESS = "Les objets invalides ont \195\169t\195\169 effac\195\168s avec succ\195\168s";
	ISYNC_FILTERPURGESUCCESS = "Les objets ont \195\169t\195\169 effac\195\168s avec succ\195\168s";
	ISYNC_FILTERINVALIDSELECTION = "Choix de qualit\195\169\ invalide";

	ISYNC_FILTER_INVALIDCHANGED = "Some invalid links are now valid.  Please refresh to view the items";

	ISYNC_FILTER_SELECT1 = "|cff9d9d9dPauvre|r";
	ISYNC_FILTER_SELECT2 = "|cffffffffCourant|r";
	ISYNC_FILTER_SELECT3 = "|cff1eff00Inabituel|r";
	ISYNC_FILTER_SELECT4 = "|cff0070ddRare|r";
	ISYNC_FILTER_SELECT5 = "|cffa335eeEpique|r";
	ISYNC_FILTER_SELECT6 = "|cffff8000L\195\169gendaire|r";
	ISYNC_FILTER_SELECT7 = "|cff57BDFBInconnue/Autre|r";

	ISYNC_DELETE_MSGRETAKE = "|c00A2D96F"..ISYNC_DELETEITEM_MSG_PART1.." \n[|r%s|c00A2D96F]?|r|c00FF0000\n"..ISYNC_DELETEITEM_MSG_PART2..".|r";
	ISYNC_DELETE_ITEMMSG = "Item Deleted (Click Refresh)";

	ISYNC_ADDEDTOFAV = "|c00FFFFFFAdded|r|c00FA747B to Favorites";
	ISYNC_FAV_HELP = "|c00FFFFFFHow to add to Favorites:|r\nControl+Shift+Right-Click any item on the main ItemSync window.\n\n|c00FFFFFFHow to remove an item:|r\nClick on the small minus button next to the item to remove it.\n\n|c00FFFFFFHow to link an item:|r\nYou can link any item exactly the same way, as on the main ItemSync window.";
	ISYNC_FAV_CLICKREMOVE_TOOLTIP = "|c00FC5252Click to -REMOVE-:|r\n";
	ISYNC_REMFAV = "|c00FFFFFFRemoved|r|c00FA747B from Favorites";
	ISYNC_FAV_PURGECHK = "|c00FFFF00Are you sure you want to purge this users favorites?|r\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";

	StaticPopupDialogs["ISYNC_PURGEFAVITEM_CONFIRM"] = {
			text = TEXT(""),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				ISync:Fav_Purge();

			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};


	StaticPopupDialogs["ISYNC_DELETEITEM_CONFIRM"] = {
			text = TEXT(""),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				ISync:DeleteItem();

			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};


	StaticPopupDialogs["ISYNC_CLEANER_CONFIRM"] = {
			text = TEXT("|c00A2D96F\nAre you sure you want to run the Invalid Cleaner?\n|c00FF0000WARNING: YOU MAY DISCONNECT!!!."),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: Invalid cleaning process has begun!  The progress bar should be at the center of your screen.  It may be behind some windows.");	
				if(ISync and ISync.InvCleaner) then ISync:InvCleaner(0); end
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};

	StaticPopupDialogs["ISYNC_OPTIMIZE_CONFIRM"] = {
			text = TEXT("|c00A2D96F\nEtes vous s\195\187r de vouloir lancer l'Optimisation?\nNOTE: Cette proc\195\169dure ne peut être stopp\195\169e."),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: Optimisation en cours!  Une barre de progression doit s'afficher au centre de l'\195\169cran.  Elle peut \195\170tre cach\195\169e par une fen\195\170tre.");	
				if(ISync and ISync.Optimize) then ISync:Optimize(0); end
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};

	StaticPopupDialogs["ISYNC_PURGEDATA_CONFIRM"] = {
			text = TEXT("|c00FF0000\nCeci est irr\195\169versible!\n\nEtes vous s\195\187r de vouloir\n effacer les donn\195\169es?\n\nNOTE: Cette action ne peut \195\170tre annul\195\169e!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				if(ISync) then ISync:FilterPurge(); end
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};

	StaticPopupDialogs["ISYNC_PURGEINVALID_CONFIRM"] = {
			text = TEXT("|c00FF0000\nCeci est irr\195\169versible!\n\nEtes vous s\195\187r de vouloir\n effacer les donn\195\169es |c00A2D96FINVALIDES|r|c00FF0000?\n\nNOTE: Cette action ne peut \195\170tre annul\195\169e!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				if(ISync) then ISync:FilterPurgeInvalid(); end
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};


	StaticPopupDialogs["ISYNC_MERGEDB_CONFIRM"] = {
			text = TEXT("|c00FF0000\nThis is Irreverable!\n\nAre you sure you want\n to |c00A2D96FMERGE THE DATABASE|r|c00FF0000?\n\nNOTE: This action cannot be undone!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

					ISync:SetVar({"OPT","SERVER_MERGE"}, 1, "TRUE");
					
					ISYNC_REALM_NUM = ISync:GrabDataProfile();
					
					ISync:Filter_MergeDB(); 
		
					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(1);
				
			end,
			OnCancel = function()

					ISync:SetVar({"OPT","SERVER_MERGE"}, 0, "TRUE");
					
					ISYNC_REALM_NUM = ISync:GrabDataProfile();
					
					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(0);
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	
	
	StaticPopupDialogs["ISYNC_MERGEDB_UNCHECKCONFIRM"] = {
			text = TEXT("|c00FF0000\nAre you sure you want ItemSync to seperate your databases?|r"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

					ISync:SetVar({"OPT","SERVER_MERGE"}, 0, "TRUE");
					
					ISYNC_REALM_NUM = ISync:GrabDataProfile();
					
					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(0);
				
			end,
			OnCancel = function()

					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(1);
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};

	-----------------------
	--THIS IS FOR PURGING!!
	-----------------------
	
	StaticPopupDialogs["ISYNC_PURGE1_CONFIRM"] = {
			text = TEXT("|c00FF0000\nThis is Irreverable!\n\nAre you sure you want\n to |c00A2D96FPURGE THE DATABASE|r|c00FF0000?\n\nNOTE: This action cannot be undone!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				StaticPopup_Show("ISYNC_PURGE2_CONFIRM");
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	
	
	StaticPopupDialogs["ISYNC_PURGE2_CONFIRM"] = {
			text = TEXT("|c00FF0000\nThis is your last chance!\n\nAre you absolutely sure you want\n to |c00A2D96FPURGE THE DATABASE|r|c00FF0000?\n\nNOTE: There is no turning back!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				ISyncDB = nil;
				ISyncDB = nil; --just in case
				ISyncDB = nil; --just in case
	
				if(ISync_SortIndex) then ISync_SortIndex = nil; end
				if( not ISyncDB ) then ISyncDB = { }; end
				if( not ISyncDB[ISYNC_REALM_NUM] ) then ISyncDB[ISYNC_REALM_NUM] = { }; end

				HideUIPanel(ISync_OptionsFrame);
				HideUIPanel(ISync_BV_Frame);
				HideUIPanel(ISync_FiltersFrame);
				HideUIPanel(ISync_FavFrame);
				HideUIPanel(ISync_SearchFrame);
				HideUIPanel(ISync_MainFrame);
								
				ISYNC_SHOWSEARCH_CHK = 0;
				ISync:Main_Refresh();
				ISync:BV_Refresh();
				
				
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: Item database has been purged.");
				
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	
	-----------------------
	--THIS IS FOR PURGING!!
	-----------------------

	ISYNC_DD_SORT = {
		{ name = ISYNC_SORT_NAME, sortType = "name" },
		{ name = ISYNC_SORT_RARITY, sortType = "rarity" },
	};


	ISYNC_SEARCH_TITLE = "Rechercher un objet";
	ISYNC_SEARCH_HELP  = "S\195\169lectionner les options de recherche.";
	ISYNC_SEARCH_HELP1 = "Emplacement :";
	ISYNC_SEARCH_HELP2 = "Arme :";
	ISYNC_SEARCH_HELP3 = "M\195\169tier :";
	ISYNC_SEARCH_HELP4 = "Armure :";
	ISYNC_SEARCH_HELP5 = "Bouclier :";
	ISYNC_SEARCH_HELP6 = "Recheche par nom :";
	ISYNC_SEARCH_HELP7 = "Raret\195\169 :";
	ISYNC_SEARCH_HELP8 = "Niveau :";

	ISYNC_SEARCH_BT1   = "Rechercher";
	ISYNC_SEARCH_BT2   = "R\195\169initialiser";
	ISYNC_SEARCH_BT3   = "Fermer la fen\195\170tre";

	ISYNC_CROSSBOW_TEXT = "Arbal\195\168te";
	ISYNC_GUN_TEXT = "Arme \195\160 feu";
	ISYNC_THROWN_TEXT = "Armes de jet";
	ISYNC_WAND_TEXT = "Baguette";

	ISYNC_REQUIRE_FIND = "(.+) requis";
	ISYNC_REQUIRE_FIND2 = "Niveau (%d+)";
	ISYNC_REQUIRE_FIND3 = "(.+) %((%d+)%)";

	ISYNC_S_USE = "Utiliser:";
	ISYNC_S_EQUIP = "Equip\195\169:";
	ISYNC_S_PASSIVE = "passive:";
	ISYNC_S_COH = "chance de toucher:";
	ISYNC_S_REQUIRES = "Requiert";
	ISYNC_S_RACES = "Races:";
	ISYNC_S_CLASSES = "Classes:";
	ISYNC_S_ALLSTAT = "all stat";


	ISYNC_DD_LOCATION = {
		{ name = "AUCUN", sortType = "NONE" },
		{ name = "A distance", sortType = "A distance" },
		{ name = "A une main", sortType = "A une main" },
		{ name = "Bijou", sortType = "Bijou" },
		{ name = "Chemise", sortType = "Chemise" },
		{ name = "Cou", sortType = "Cou" },
		{ name = "Deux mains", sortType = "Deux mains" },
		{ name = "Doigt", sortType = "Doigt" },
		{ name = "Dos", sortType = "Dos" },
		{ name = "Epaule", sortType = "Epaule" },
		{ name = "Jambes", sortType = "Jambes" },
		{ name = "Main droite", sortType = "Main droite" },
		{ name = "Mains", sortType = "Mains" },
		{ name = "Main gauche", sortType = "Main gauche" },
		{ name = "Pieds", sortType = "Pieds" },
		{ name = "Poignets", sortType = "Poignets" },
		{ name = "Tabard", sortType = "Tabard" },
		{ name = "Taille", sortType = "Taille" },
		{ name = "Tenu(e) en main gauche", sortType = "Tenu(e) en main gauche" },
		{ name = "T\195\170te", sortType = "T\195\170te" },
		{ name = "Torse", sortType = "Torse" },
	};


	ISYNC_WeaponLocation = { };
	ISYNC_WeaponLocation["Tenu(e) en main gauche"] = 1;
	ISYNC_WeaponLocation["Dos"] = 2;
	ISYNC_WeaponLocation["A une main"] = 3;
	ISYNC_WeaponLocation["Deux mains"] = 4;
	ISYNC_WeaponLocation["Main gauche"] = 5;
	ISYNC_WeaponLocation["Poignets"] = 6;
	ISYNC_WeaponLocation["Torse"] = 7;
	ISYNC_WeaponLocation["Jambes"] = 8;
	ISYNC_WeaponLocation["Pieds"] = 9;
	ISYNC_WeaponLocation["Chemise"] = 10;
	ISYNC_WeaponLocation["A distance"] = 11;
	ISYNC_WeaponLocation["Main droite"] = 12;
	ISYNC_WeaponLocation["Taille"] = 13;
	ISYNC_WeaponLocation["T\195\170te"] = 14;
	ISYNC_WeaponLocation[ISYNC_GUN_TEXT] = 15;
	ISYNC_WeaponLocation["Doigt"] = 16;
	ISYNC_WeaponLocation["Mains"] = 17;
	ISYNC_WeaponLocation["Epaule"] = 18;
	ISYNC_WeaponLocation[ISYNC_WAND_TEXT] = 19;
	ISYNC_WeaponLocation["Bijou"] = 20;
	ISYNC_WeaponLocation["Tabard"] = 21;
	ISYNC_WeaponLocation["Cou"] = 22;
	ISYNC_WeaponLocation[ISYNC_THROWN_TEXT] = 23;
	ISYNC_WeaponLocation[ISYNC_CROSSBOW_TEXT] = 24;



	ISYNC_DD_WEAPONS = {
		{ name = "AUCUN", sortType = "NONE" },
		{ name = ISYNC_CROSSBOW_TEXT, sortType = ISYNC_CROSSBOW_TEXT },
		{ name = "Arc", sortType = "Arc" },
		{ name = ISYNC_GUN_TEXT, sortType = ISYNC_GUN_TEXT },
		{ name = "Arme d'hast", sortType = "Arme d'hast" },
		{ name = ISYNC_THROWN_TEXT, sortType = ISYNC_THROWN_TEXT },
		{ name = "Arme de pugilat", sortType = "Arme de pugilat" },
		{ name = ISYNC_WAND_TEXT, sortType = ISYNC_WAND_TEXT },
		{ name = "B\195\162ton", sortType = "B\195\162ton" },
		{ name = "Dague", sortType = "Dague" },
		{ name = "Ep\195\169e", sortType = "Ep\195\169e" },
		{ name = "Hache", sortType = "Hache" },
		{ name = "Masse", sortType = "Masse" },
	};


	ISYNC_WeaponTypes = { };
	ISYNC_WeaponTypes["Hache"] = 1;
	ISYNC_WeaponTypes["Arc"] = 2;
	ISYNC_WeaponTypes["Dague"] = 3;
	ISYNC_WeaponTypes["Masse"] = 4;
	ISYNC_WeaponTypes["B\195\162ton"] = 5;
	ISYNC_WeaponTypes["Ep\195\169e"] = 6;
	ISYNC_WeaponTypes[ISYNC_GUN_TEXT] = 7;
	ISYNC_WeaponTypes[ISYNC_WAND_TEXT] = 8;
	ISYNC_WeaponTypes[ISYNC_THROWN_TEXT] = 9;
	ISYNC_WeaponTypes["Arme d'hast"] = 10;
	ISYNC_WeaponTypes["Arme de pugilat"] = 11;
	ISYNC_WeaponTypes[ISYNC_CROSSBOW_TEXT] = 12;



	ISYNC_DD_TRADESKILLS = {
		{ name = "AUCUN", sortType = "NONE" },
		{ name = "Alchimie", sortType = "Alchimie" },
		{ name = "Couture", sortType = "Couture" },
		{ name = "Cuisine", sortType = "Cuisine" },
		{ name = "Enchantement", sortType = "Enchantement" },
		{ name = "Forge", sortType = "Forge" },
		{ name = "Ing\195\169nierie", sortType = "Ing\195\169nierie" },
		{ name = "P\195\170che", sortType = "P\195\170che" },
		{ name = "Secourisme", sortType = "Secourisme" },
		{ name = "Travail du cuir", sortType = "Travail du cuir" },
	};

	ISYNC_TradeSkills = { };
	ISYNC_TradeSkills["Alchimie"] = 1;
	ISYNC_TradeSkills["Forge"] = 2;
	ISYNC_TradeSkills["Cuisine"] = 3;
	ISYNC_TradeSkills["Enchantement"] = 4;
	ISYNC_TradeSkills["Ing\195\169nierie"] = 5;
	ISYNC_TradeSkills["Travail du cuir"] = 6;
	ISYNC_TradeSkills["Couture"] = 7;
	ISYNC_TradeSkills["Secourisme"] = 8;
	ISYNC_TradeSkills["P\195\170che"] = 9;

	ISYNC_DD_ARMOR = {
		{ name = "AUCUN", sortType = "NONE" },
		{ name = "Cuir", sortType = "Cuir" },
		{ name = "Mailles", sortType = "Mailles" },
		{ name = "Plaques", sortType = "Plaques" },
		{ name = "Tissu", sortType = "Tissu" },
	};

	ISYNC_ArmorTypes = { };
	ISYNC_ArmorTypes["Tissu"] = 1;
	ISYNC_ArmorTypes["Cuir"] = 2;
	ISYNC_ArmorTypes["Mailles"] = 3;
	ISYNC_ArmorTypes["Plaques"] = 4;


	

	ISYNC_DD_SHIELD = {
		{ name = "AUCUN", sortType = "NONE" },
		{ name = "Bouclier", sortType = "Bouclier" },
		{ name = "Targe", sortType = "Targe" },
	};


	ISYNC_ShieldTypes = { };
	ISYNC_ShieldTypes["Targe"] = 1;
	ISYNC_ShieldTypes["Bouclier"] = 2;



	ISYNC_DD_RARITY = {
		{ name = "Tout", sortType = "NONE" },
		{ name = "|cff9d9d9dPauvre|r", sortType = 0 },
		{ name = "|cffffffffCourant|r", sortType = 1 },
		{ name = "|cff1eff00Inabituel|r", sortType = 2 },
		{ name = "|cff0070ddRare|r", sortType = 3 },
		{ name = "|cffa335eeEpique|r", sortType = 4 },
		{ name = "|cffff8000L\195\169gendaire|r", sortType = 5},
			
	};


	ISYNC_DD_LEVEL = {
		{ name = "Tout", sortType = "NONE" },
		{ name = "1-5", sortType = 0 },
		{ name = "5-10", sortType = 1 },
		{ name = "10-15", sortType = 2 },
		{ name = "15-20", sortType = 3 },
		{ name = "20-25", sortType = 4 },
		{ name = "25-30", sortType = 5 },
		{ name = "30-35", sortType = 6 },
		{ name = "35-40", sortType = 7 },
		{ name = "40-45", sortType = 8 },
		{ name = "45-50", sortType = 9 },
		{ name = "50-55", sortType = 10 },
		{ name = "55-60", sortType = 11 },
		
			
	};



end

