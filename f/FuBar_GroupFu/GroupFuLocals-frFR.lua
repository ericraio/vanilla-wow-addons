function GroupFu_Locals_frFR()

GroupFuLocals = {

	NAME = "FuBar - GroupFu",
	DESCRIPTION = "Combinaison de LootType et Roll.",
	
	DEFAULT_ICON = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",

	TEXT_SOLO = "Solo",
	TEXT_GROUP = "Groupe",
	TEXT_FFA = "Acces libre",
	TEXT_MASTER = "Responsable du Butin",
	TEXT_NBG = "Le Besoin avant Cupidite",
	TEXT_RR = "Chacun son tour",
	TEXT_NOROLLS = "Aucun Tirage",

	TEXT_ENDING10 = "Le tirage finit dans 10",
	TEXT_ENDING5 = "Le tirage finit dans 5",
	TEXT_ENDING4 = "Le tirage finit dans 4",
	TEXT_ENDING3 = "Le tirage finit dans 3",
	TEXT_ENDING2 = "Le tirage finit dans 2",
	TEXT_ENDING1 = "Le tirage finit dans 1",
	TEXT_ENDED = "Le tirage est fini, annonce du gagnant.",
	
	SEARCH_MASTERLOOTER = "(.+) est maintenant responsable du butin.",
	SEARCH_ROLLS = "(.+) obtient un (%d+) %((%d+)%-(%d+)%)",
	
	FORMAT_ANNOUNCE_WIN = "Gagnant: %s [%d] sur %d tirages.",
	FORMAT_TEXT_ROLLCOUNT = "%s (%d/%d)",
	FORMAT_TOOLTIP_ROLLCOUNT = "%d of expected %d rolls recorded",

	MENU_SHOWMLNAME = "Montrer le nom du Responsable du Butin",
	MENU_PERFORMROLL = "Effectuer un tirage quand clic",
	MENU_SHOWROLLCOUNT = "Afficher un decompte des tirages enregistres ie <# tirages>/<# joueurs dans le raid/groupe>",
	MENU_ANNOUNCEROLLCOUNTDOWN = "Annoncer le compte a rebours et afficher le gagnant quand le temps d'expiration est atteint",

	MENU_OUTPUT = "Lieu d'affichage",
	MENU_OUTPUT_AUTO = "Afficher les resultats selon qu'on est en Raid, Groupe ou Solo",
	MENU_OUTPUT_LOCAL = "Affichage sur l'ecran",
	MENU_OUTPUT_SAY = "Affichage sur /dire",
	MENU_OUTPUT_PARTY = "Affichage sur /gr",
	MENU_OUTPUT_RAID = "Affichage sur /raid",
	MENU_OUTPUT_GUILD = "Affichage sur /g",

	MENU_CLEAR = "Nettoyage automatique des tirages",
	MENU_CLEAR_NEVER = "Jamais",
	MENU_CLEAR_15SEC = "15 secondes",
	MENU_CLEAR_30SEC = "30 secondes",
	MENU_CLEAR_45SEC = "45 secondes",
	MENU_CLEAR_60SEC = "60 secondes",

	MENU_DETAIL = "Niveau de Detail",
	MENU_DETAIL_SHORT = "Afficher le gagnant seulement",
	MENU_DETAIL_LONG = "Afficher tous les tirages",
	MENU_DETAIL_FULL = "Afficher tous les tirags, ainsi que l'info des tirages non standards",
	
	MENU_MODE = "Mode Texte",
	MENU_MODE_GROUPFU = "GroupFu: Mode de butin, sauf si un tirage est actif, alors le gagnant du tirage",
	MENU_MODE_ROLLSFU = "RollsFu: Aucun tirage, sauf si un tirage est actif alors le gagnant du tirage",
	MENU_MODE_LOOTTYFU = "LootTyFu: Toujours Mode de butin",
	
	MENU_STANDARDROLLSONLY = "N'accepter que les tirages standards (1-100)",
	MENU_IGNOREDUPES = "Ignorer les tirages en double",
	MENU_AUTODELETE = "Auto-suppression des tirages apres affichage",
	MENU_SHOWCLASSLEVEL = "Montrer classe et niveau dans la bulle",
	
	MENU_GROUP = "Fonctions de groupe",
	MENU_GROUP_LEAVE = "Quitter le groupe",
	MENU_GROUP_RAID = "Convertir Groupe en Raid",
	MENU_GROUP_LOOT = "Changer le mode de butin",
	MENU_GROUP_THRESHOLD = "Changer le Seuil de butin",
	MENU_GROUP_RESETINSTANCE = "Reset Instance",

	TOOLTIP_CAT_LOOTING = "Butin",
	TOOLTIP_CAT_ROLLS = "Tirages",
	TOOLTIP_METHOD = "Mode de Butin",
	TOOLTIP_HINT_ROLLS = "Clic pour tirage, Ctrl-Clic pour afficher le gagnant, Shift-Clic pour effacer la liste",
	TOOLTIP_HINT_NOROLLS = "Ctrl-Clic pour afficher le gagnant, Shift-Clic pour effacer la liste",

	ENDFRLOCALE = true
}

end