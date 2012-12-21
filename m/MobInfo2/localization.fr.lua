----------------------
-- 
-- Localisation for MobInfo
-- 
-- created by Sasmira ( Cosmos Team )
-- updated by Halrik (Curse forum user)
-- updated by Tieum (ui.worldofwar.net forum user)
--
-- Last Update : 10-Apr-2006 by Sasmira
-- 

-- 
-- French localization
-- 

if ( GetLocale() == "frFR" ) then

MI_DESCRIPTION = "Ajoute une pr\195\169cision d\'information sur un monstre dans la Tooltip";

MI_MOB_DIES_WITH_XP = "(.+) meurt, vous gagnez (%d+) points d\'exp\195\169rience";
MI_MOB_DIES_WITHOUT_XP = "(.+) meurt";
MI_PARSE_SPELL_DMG = "(.+) lance (.+) et vous inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_BOW_DMG = "(.+) de (.+) vous inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_COMBAT_DMG = "(.+) vous inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_MELEE = "Vous touchez (.+) et infligez (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_MELEE_CRIT = "Vous touchez (.+) avec un coup critique et infligez (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_SPELL =  "Votre (.+) touche (.+) et lui inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_SPELL_CRIT = "Votre (.+) inflige un coup critique \195\160 (.+) ((%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_SPELL_PERIODIC = "Votre (.+) inflige (%d+) points de d\195\169g\195\162ts de (.+) \195\160 (.+)";
MI_PARSE_SELF_BOW = "Votre (.+) touche (.+) et inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_PET = "(.+) touche (.+) et inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_PET_CRIT = "(.+) touche (.+) avec un coup critique et inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_PET_SPELL = "(.+) de (.+) touche (.+) pour (%d+) points de d\195\169g\195\162ts";
MI_PARSE_SELF_PET_SPELL_CRIT = "(.+) utilise (.+) et touche (.+) avec un coup critique, infligeant (%d+) points de d\195\169g\195\162ts";

MI_TXT_GOLD = " Or";
MI_TXT_SILVER = " Argent";
MI_TXT_COPPER = " Cuivre";

MI_TXT_CONFIG_TITLE = "Options de MobInfo 2";
MI_TXT_WELCOME = "Bienvenue dans MobInfo 2"
MI_TXT_OPEN = "Ouvrir";
MI_TXT_CLASS = "Classe ";
MI_TXT_HEALTH = "Vie ";
MI_TXT_MANA = "Mana ";
MI_TXT_XP = "XP ";
MI_TXT_KILLS = "Nb de fois tu\195\169 ";
MI_TXT_DAMAGE = "Dommages/DPS ";
MI_TXT_TIMES_LOOTED = "Nbre de fois pill\195\169 ";
MI_TXT_EMPTY_LOOTS = "Corps vides ";
MI_TXT_TO_LEVEL = "Nb avant niveau ";
MI_TXT_QUALITY = "Qualit\195\169 ";
MI_TXT_CLOTH_DROP = "Tissu ramass\195\169 ";
MI_TXT_COIN_DROP = "Argent Moyen ";
MI_TEXT_ITEM_VALUE = "Valeur Moyenne ";
MI_TXT_MOB_VALUE = "Valeur Totale ";
MI_TXT_COMBINED = "Fusion:";
MI_TXT_MOB_DB_SIZE = "Taille des Data de MobInfo: ";
MI_TXT_HEALTH_DB_SIZE = "Taille des Data de MobHealth: ";
MI_TXT_PLAYER_DB_SIZE	= "Taille des Data de PlayerHealth:  ";
MI_TXT_ITEM_DB_SIZE		= "Taille des Data Objets:  ";
MI_TXT_CUR_TARGET = "Cible Courante: ";
MI_TXT_MH_DISABLED = "AVERTISSEMENT MobInfo : Un addon MobHealth externe a \195\169t\195\169 trouv\195\169. Les fonctionnalit\195\169es du MobHealth interne ont \195\169t\195\169 d\195\169sactiv\195\169es tant que l\'addon externe n\'est pas supprim\195\169.";
MI_TXT_MH_DISABLED2		= (MI_TXT_MH_DISABLED.."\n\n Vous ne perdrez PAS vos donn\195\169es en d\195\169sactivant l\'addon MobHealth externe.\n\nAvantages : affichage sant\195\169/mana r\195\169glable avec support du pourcentage, polices et tailles r\195\169glables");
MI_TXT_CLR_ALL_CONFIRM	= "Voulez vous r\195\169ellement effectuer l\'op\195\169ration suivante de suppression: ";
MI_TXT_SEARCH_LEVEL = "Niveau du monstre:";
MI_TXT_SEARCH_MOBTYPE = "Type de monstre:";
MI_TXT_SEARCH_LOOTS = "Monstre Pill\195\169e:";
MI_TXT_TRIM_DOWN_CONFIRM = "ATTENTION: Ceci est une suppression imm\195\169diate et permanente. Voulez vous r\195\169ellement supprimer toutes les donn\195\169es des monstres non selectionn\195\169s comme \195\169tant enregistr\195\169s.";
MI_TXT_CLAM_MEAT		= "Viande de Palourde"
MI_TXT_SHOWING			= "Voir Liste: "
MI_TXT_DROPPED_BY		= "Obtenu sur: "
MI_TXT_LOCATION			= "Lieu: "
MI_TXT_DEL_SEARCH_CONFIRM = "Do you really want to DELETE the %d Mobs in the search result list from the MobInfo database ?"
BINDING_NAME_MI2CONFIG	= "Open MobInfo2 Options"

MI2_FRAME_TEXTS = {};
MI2_FRAME_TEXTS["MI2_FrmTooltipOptions"]	= "Options \195\160 voir dans la Tooltip";
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]		= "Options de Mob Health";
MI2_FRAME_TEXTS["MI2_FrmDatabaseOptions"]	= "Options de la DataBase";
MI2_FRAME_TEXTS["MI2_FrmHealthValueOptions"]= "Valeur de la Vie";
MI2_FRAME_TEXTS["MI2_FrmManaValueOptions"]	= "Valeur de la Mana";
MI2_FRAME_TEXTS["MI2_FrmSearchOptions"]		= "Options: Recherche";
MI2_FRAME_TEXTS["MI2_FrmSearchLevel"]		= "Niv. du Monstre";
MI2_FRAME_TEXTS["MI2_FrmItemTooltip"]		= "Options: Objet dans la Tooltip";
MI2_FRAME_TEXTS["MI2_FrmImportDatabase"]	= "Import External MobInfo Database"

--
-- This section defines all buttons in the options dialog
-- text : the text displayed on the button
-- cmnd : the command which is executed when clicking the button
-- help : the (short) one line help text for the button
-- info : additional multi line info text for button
-- info is displayed in the help tooltip below the "help" line
-- info is optional and can be omitted if not required
--

MI2_OPTIONS = {};

MI2_OPTIONS["MI2_OptSearchMinLevel"] = 
{ text = "Min"; help = "Niveau minimum du monstre pour les options de recherche"; }

MI2_OPTIONS["MI2_OptSearchMaxLevel"] = 
{ text = "Max"; help = "Niveau maximum du monstre pour les options de recherche (doit \195\170tre < 66)"; }

MI2_OPTIONS["MI2_OptSearchNormal"] = 
{ text = "Normal"; help = "inclure le type Normal des monstres dans le r\195\169sultat de la recherche"; }

MI2_OPTIONS["MI2_OptSearchElite"] = 
{ text = "Elite"; help = "inclure le type Elite des monstres dans le r\195\169sultat de la recherche"; }

MI2_OPTIONS["MI2_OptSearchBoss"] = 
{ text = "Boss"; help = "inclure le type Boss des monstres dans le r\195\169sultat de la recherche"; }

MI2_OPTIONS["MI2_OptSearchMinLoots"] = 
{ text = "Min"; help = "Nombre de fois minimum que le monstre a \195\169t\195\169 pill\195\169"; }

MI2_OPTIONS["MI2_OptSearchMobName"] = 
{ text = "Nom: Monstre"; help = "Nom complet ou partiel du monstre pour la recherche";
info = 'Laisser vide restreint la recherche d\'objets sp\195\169cifiques\nEntrer "*" pour s\195\169lectionner tous les objets.'; }

MI2_OPTIONS["MI2_OptSearchItemName"] = 
{ text = "Nom: Objet"; help = "Nom complet ou partiel de l\'objet pour la recherche";
info = 'Laisser vide la recherche pour avoir tous les noms d\'objet'; }

MI2_OPTIONS["MI2_OptSortByValue"] = 
{ text = "Recherche par valeur"; help = "Recherche les 12 monstres les plus profitables";
info = 'Le classement des monstres est fait par valeur des objets plus un bonus pour les objets rares.\n"r"=rang, "v"= valeur totale, "q"=qualit\195\169 des objets'; }

MI2_OPTIONS["MI2_OptSortByItem"] = 
{ text = "Recherche par sorte d\'objet"; help = "Liste le r\195\169sultat de recherche par le nombre de sorte d\'objet";
info = 'Associe les monstres sur lequel le(s) objet(s) indiqu\195\169(s) est/sont ramass\195\169(s).'; }

MI2_OPTIONS["MI2_OptItemTooltip"] = 
{ text = "Liste: Mobs dans la Tooltip Objet"; help = "Affiche les noms des monstres qui droppent un objet dans la Tooltip d\'objet";
info = "Liste \195\160 la vol\195\169 dans la tooltip,\nle nom de tous les monstres sur lequel on trouve l\'objet ramass\195\169. Cr\195\169er une liste en pourcentage \ndu nombre de fois l\'objet ramass\195\169 sur le monstre." }

MI2_OPTIONS["MI2_OptCompactMode"] = 
{ text = "Tooltip Mode Compact"; help = "Active une tooltip compact avec 2 valeurs par ligne";
info = "La tooltip compact utilise des textes courts pour les descriptions.\nPour d\195\169sactiver la tooltip, d\195\169cocher les deux entr\195\169es sur cette ligne." }

MI2_OPTIONS["MI2_OptDisableMobInfo"] = 
{ text = "D\195\169sactiver: Mob Tooltip"; help = "D\195\169sactive la collecte des donn\195\169es sur les monstres pour la tooltip ainsi que son affichage dedans";
info = "A noter que ceci NE d\195\169sactive PAS la collecte des donn\195\169es de Mob Health \nou l\'affichage dans la fen\195\170tre Cible. Les donn\195\169es de Mob Health sont contr\195\180l\195\169es par sa propre page d\'options." }

MI2_OPTIONS["MI2_OptShowClass"] =
{ text = "Classes"; help = "Affiche la classe de la cible"; }

MI2_OPTIONS["MI2_OptShowHealth"] =
{ text = " Vie"; help = "Affiche la vie de la cible (en cours/max)"; }

MI2_OPTIONS["MI2_OptShowMana"] =
{ text = "Mana"; help = "Affiche le mana/rage/\195\169nergie de la cible (en cours/max)"; }

MI2_OPTIONS["MI2_OptShowXp"] =
{ text = "Exp\195\169rience"; help = "Affiche le nombre de point d\'exp\195\169rience qu\'un monstre donne";
info = "Actuellement la derni\195\168re valeur qui s\'affiche. \n(Ne s\'affiche pas lorsque les monstres sont gris pour vous)" }

MI2_OPTIONS["MI2_OptShowNo2lev"] =
{ text = "Mobs pour level"; help = "Affiche le nombre de monstres restant \195\160 tuer pour changer de niveau";
info = "Ne s\'affiche pas lorsque les monstres sont gris pour vous" }

MI2_OPTIONS["MI2_OptShowDamage"] =
{ text = "Zone d\'effet + DPS"; help = "Affiche la zone d\'effet des dommages (Min/Max) + DPS (Damage per Second)";
info = "La zone d\'effet est calcul\195\169e/stock\195\169e s\195\169par\195\169ment par personnage." }

MI2_OPTIONS["MI2_OptShowCombined"] =
{ text = "Fusion des Infos"; help = "Regroupe les Informations des monstres dans la bulle d\'aide";
info = "Affiche un message dans la bulle d\'aide, indiquant que le mode Regoup\195\169 est actif. \nIl liste tous les niveaux des monstres \nqui ont \195\169t\195\169 regroup\195\169 dans une seule bulle d\'aide." }

MI2_OPTIONS["MI2_OptShowKills"] =
{ text = "Fois tu\195\169"; help = "Affiche le nombre de fois que le m\195\170me monstre a \195\169t\195\169 tu\195\169";
info = "le nombre de mort est calcul\195\169/stock\195\169 \ns\195\169par\195\169ment par personnage." }

MI2_OPTIONS["MI2_OptShowLoots"] =
{ text = "Fois pill\195\169e"; help = "Affiche le nombre de fois que le monstre a \195\169t\195\169 pill\195\169e"; }

MI2_OPTIONS["MI2_OptShowCloth"] =
{ text = "Tissu ramass\195\169"; help = "Affiche le nombre de tissu ramass\195\169"; }

MI2_OPTIONS["MI2_OptShowEmpty"] =
{ text = "Corps vides"; help = "Affiche le nombre de butin vides trouv\195\169s(nbre/%tage)";
info = "Le compteur augmente lorsque vous ouvrez \n un corp sans butin." }

MI2_OPTIONS["MI2_OptShowTotal"] =
{ text = "Valeur Totale"; help = "Affiche la moyenne de la valeur totale des monstres";
info = "Moyenne de la valeur totale \nde l\'Argent et des objets." }

MI2_OPTIONS["MI2_OptShowCoin"] =
{ text = "Argent ramass\195\169"; help = "Affiche la moyenne d\'Argent ramass\195\169e par monstre";
info = "La valeur totale est cumul\195\169e et divis\195\169e \npar le nombre de loot.\n(Ne s\'affiche pas si le compte est de z\195\169ro)" }

MI2_OPTIONS["MI2_OptShowIV"] =
{ text = "Valeur des objets"; help = "Affiche valeur moyenne des objets par monstre";
info = "La valeur totale est cumul\195\169e et divis\195\169e \npar le nombre de loot.\n(Ne s\'affiche pas si le compte est de z\195\169ro)" }

MI2_OPTIONS["MI2_OptShowQuality"] =
{ text = "Qualit\195\169 du Butin"; help = "Affiche la qualit\195\169 du loot en nombre et pourcentage";
info = "Le compteur indique la quantit\195\169 en fonction des 5 cat\195\169gories de raret\195\169" }

MI2_OPTIONS["MI2_OptShowLocation"] = 
{ text = "Le Lieu"; help = "Affiche le Lieu ou vous pouvez trouver le monstre";
info = "L\'enregistrement des donn\195\169es de Lieu doit \195\170tre ACTIF pour fonctionner."; }

MI2_OPTIONS["MI2_OptShowItems"] = 
{ text = "D\195\169tail des Objets loot\195\169s"; help = "Affiche les noms et quantit\195\169s de tous les objets ramass\195\169s";
info = "L\'enregistrement des donn\195\169es d\'Objet doit \195\170tre ACTIF pour fonctionner"; }

MI2_OPTIONS["MI2_OptShowClothSkin"] = 
{ text = "Cloth and Skinning Loot"; help = "Show names and amount of all cloth and skinning loot items";
info = "Recording loot item data must be ENABLED for this to work"; }

MI2_OPTIONS["MI2_OptShowBlankLines"] =
{ text = "Afficher Ligne blanche"; help = "Affiche une ligne blanche dans la bulle d\'aide";
info = "" }

MI2_OPTIONS["MI2_OptCombinedMode"] =
{ text = "Fusion des monstres identiques"; help = "Regroupe les donn\195\169es des monstres de m\195\170me nom";
info = "Regroupe les donn\195\169es des monstres de m\195\170me nom \nmais de niveaux diff\195\169rents dans la bulle d\'aide" }

MI2_OPTIONS["MI2_OptKeypressMode"] =
{ text = "ALT pour voir MobInfo"; help = "MobInfo s\'affiche uniquement dans la bulle d\'aide lorsque la touche ALT est press\195\169e"; }

MI2_OPTIONS["MI2_OptItemFilter"] = 
{ text = "Filtre d\'Objets ramass\195\169s"; help = "Configure un filtrage dans l\'affichage de la tooltip pour les objets ramass\195\169s";
info = "Affiche uniquement les objets ramass\195\169s dans la Tooltip des monstres qu\'inclu\n le filtre texte. E.g. entrer 'Tissu' affichera tous les objets avec\n'Tissu' dans le nom.\nNe rien rentrer pour voir tous les objets." }

MI2_OPTIONS["MI2_OptSavePlayerHp"] = 
{ text = "Sauver la vie des joueurs de mani\195\168re permanente."; help = "Sauve la vie des joueurs en bataille JcJ.";
info = "Habituellement, la vie des joueurs JcJ est effac\195\169e apr\195\168s\nchaque session. Cette option vous permet de garder ces donn\195\169es." }

MI2_OPTIONS["MI2_OptAllOn"] =
{ text = "Tous ON"; help = "Toutes les options de MobInfo sont activ\195\169es"; }

MI2_OPTIONS["MI2_OptAllOff"] =
{ text = "Tous OFF"; help = "Toutes les options de MobInfo sont d\195\169sactiv\195\169es"; }

MI2_OPTIONS["MI2_OptMinimal"] =
{ text = "Minimum"; help = "Affiche les options minimales"; }

MI2_OPTIONS["MI2_OptDefault"] =
{ text = "D\195\169faut"; help = "Affiche les options par d\195\169faut de MobInfo"; }

MI2_OPTIONS["MI2_OptBtnDone"] =
{ text = "Appliquer"; help = "Ferme la fen\195\170tre des Options de MobInfo"; }

MI2_OPTIONS["MI2_OptStableMax"] =
{ text = "Affichage stable des PV max"; help = "Affichage stable des PV max dans votre Fen\195\170tre Cible";
info = "Actualise les PV Max du monstre moins souvent \n(seulement au premier combat avec le monstre et entre les batailles)."; }

MI2_OPTIONS["MI2_OptTargetHealth"] =
{ text = "Valeur de la Vie"; help = "Affiche la valeur de la vie dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptTargetMana"] =
{ text = "Valeur du Mana"; help = "Affiche la valeur du mana dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptHealthPercent"] =
{ text = "Vie en pourcentage"; help = "Ajoute la Vie en pourcentage dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptManaPercent"] =
{ text = "Mana en pourcentage"; help = "Ajoute le Mana en pourcentage dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptHealthPosX"] =
{ text = "Position Horizontale"; help = "Ajuste la Position Horizontale de la Vie dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptHealthPosY"] =
{ text = "Position Verticale"; help = "Ajuste la Position Verticale de la Vie dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptManaPosX"] =
{ text = "Position Horizontale"; help = "Ajuste la Position Horizontale du mana dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptManaPosY"] =
{ text = "Position Verticale"; help = "Ajuste la Position Verticale du mana dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptTargetFont"] =
{ text = "Police"; help = "Configure la police de caract\195\168re pour la valeur vie/mana dans la fen\195\170tre Cible";
  choice1 = "NumberFont"; choice2 = "GameFont"; choice3 = "ItemTextFont" }

MI2_OPTIONS["MI2_OptTargetFontSize"] =
{ text = "Taille de la Police"; help = "Configure taille de la police de caract\195\168re pour la valeur vie/mana dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_OptClearTarget"] =
{ text = "Suppr. Data Cible"; help = "Supprime le contenu de la Base donn\195\169es pour la cible courante"; }

MI2_OPTIONS["MI2_OptClearMobDb"] = 
{ text = "Suppr. Database"; help = "Supprime enti\195\168rement le contenu des informations sur les monstres de la Base de donn\195\169es."; }

MI2_OPTIONS["MI2_OptClearHealthDb"] = 
{ text = "Suppr. Database"; help = "Supprime enti\195\168rement le contenu des informations de MobHealth de la Base de donn\195\169es."; }

MI2_OPTIONS["MI2_OptClearPlayerDb"] = 
{ text = "Suppr. Database"; help = "Supprime enti\195\168rement le contenu des informations de PlayerHealth de la Base de donn\195\169es."; }

MI2_OPTIONS["MI2_OptSaveItems"] = 
{ text = "Sauve: Data des Objets loot\195\169s"; help = "Activer cette fonction pour enregistrer le d\195\169tail des objets ramass\195\169s pour tous les monstres.";
info = "Cela enregistrera tous les objets: nom, qualit\195\169, quantit\195\169 totale.\nEnregistre seulement \195\160 partir des objets Communs (Blanc)."; }

MI2_OPTIONS["MI2_OptSaveBasicInfo"] = 
{ text = "Enreg. Mob info de base"; help = "Enregistre un ensemble d\'information de base des monstres.";
info = "Information de base des monstres inclu: xp, type de monstre, compteur pour: loot, loot vide, tissu, monnaie, valeur des objets"; }

MI2_OPTIONS["MI2_OptSaveCharData"] = 
{ text = "Sauvegarde de toutes les Data des Mobs sp\195\169cifiques"; help = "Sauvegarde toutes les donn\195\169es des mobs qui ont des caract\195\169ristiques sp\195\169cifiques.";
info = "Ceci activera ou d\195\169sactivera des donn\195\169es suivantes:\nnombre de morts, min/max dommage, DPS (dommage par sec)\n\nCette donn\195\169e est sauvegard\195\169e s\195\169parement pour chaque personnage.\nLe sauver peut seulement \195\170tre Activer/D\195\169sactiver pour la configuration enti\195\168re de 4 valeurs"; }

MI2_OPTIONS["MI2_OptSaveLocation"] = 
{ text = "Enregistrement de la description du Lieu du Mob"; help = "Enregistre l\'aire et les coordonn\195\169es de l\'endroit ou vous pouvez trouver le monstre." }

MI2_OPTIONS["MI2_OptItemsQuality"] = 
{ text = ""; help = "Enregistre le d\195\169tail des objets ramass\195\169s en s\195\169lectionnant la qualit\195\169 et plus.";
choice1 = "Gris & Plus"; choice2="Blanc & Plus"; choice3="Vert & Plus" }

MI2_OPTIONS["MI2_OptTrimDownMobData"] = 
{ text = "R\195\169duire la taille: Database Mob"; help = "R\195\169duit la taille de la Base de donn\195\169es sur les monstres par suppression du surplus de donn\195\169es.";
	  info = "Les donn\195\169es en surplus sont toutes les donn\195\169es dans la base de donn\195\169es qui ne sont pas marqu\195\169es comme \195\169tant enregistr\195\169es."; }

MI2_OPTIONS["MI2_OptImportMobData"] = 
{ text = "Start the Import"; help = "Import an external Mob Database into your own Mob Database";
info = "IMPORTANT: please read the import instructions !\nALWAYS backup your own Mob database BEFORE import !"; }

MI2_OPTIONS["MI2_OptDeleteSearch"] = 
{ text = "DELETE"; help = "Deletes all Mobs in the search result list from the MobInfo database.";
info = "WARNING: this operation can not be undone.\nPlease use carefully !\nYou might want to backup your MobInfo database before deleting Mobs."; }

MI2_OPTIONS["MI2_OptImportOnlyNew"] = 
{ text = "Import only unknown Mobs"; help = "Import only Mobs that do not exist in your own database";
info = "Activating this option prevents that the data of existing Mobs\nis modified. Only unknown (ie. new) Mobs will get imported. This\nallows importing partially overlapping database without causing\nconsistency problems."; }

MI2_OPTIONS["MI2_MainOptionsFrameTab1"] =
{ text = "Tooltips"; help = "Configure les options d\'affichage des informations sur les monstres dans la bulle d\'aide"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab2"] =
{ text = "Vie des Monstres"; help = "Configure les options d\'affichage Vie/mana dans la fen\195\170tre Cible"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab3"] =
{ text = "Base de Donn\195\169es"; help = "Gestions des options des bases de donn\195\169es"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab4"] = 
{ text = "Recherche"; help = "Recherche par la base de donn\195\169es"; }

MI2_OPTIONS["MI2_SearchResultFrameTab1"] = 
{ text = "Liste Mob"; help = ""; }

MI2_OPTIONS["MI2_SearchResultFrameTab2"] = 
{ text = "Liste Objets"; help = ""; }

end
