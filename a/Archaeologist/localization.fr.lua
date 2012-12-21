-- Version : French ( by Sasmira and WLMitch )
-- Last Update : 29/10/2005

if ( GetLocale() == "frFR" ) then

ARCHAEOLOGIST_SUPER_SLASH_COMMAND = "/arch";

PLAYER_GHOST 					= "Fant\195\180me";
PLAYER_WISP 					= "Feu Follet";
FEIGN_DEATH							= "Feindre la Mort";

ARCHAEOLOGIST_CONFIG_SEP			= "Archaeologist";
ARCHAEOLOGIST_CONFIG_SEP_INFO			= "Archaeologist Configuration de la Fen\195\170tre du Joueur";

ARCHAEOLOGIST_FEEDBACK_STRING = "%s a \195\169t\195\169 en %s.";
ARCHAEOLOGIST_NOT_A_VALID_FONT = "%s n'est pas une police valide.";
ArchaeologistLocalizedFonts = { 
	["Default"] = "Default";
	--change fist string for displayd string
	--values must match ArchaeologistFonts keys
	["GameFontNormal"] = "GameFontNormal";
	["NumberFontNormal"] = "NumberFontNormal";
	["ItemTextFontNormal"] = "ItemTextFontNormal";
};

ARCHAEOLOGIST_ON = "On";
ARCHAEOLOGIST_OFF = "Off";
ARCHAEOLOGIST_MOUSEOVER = "Survol";
	
ARCHAEOLOGIST_FONT_OPTIONS = "Font Options:"
for key, name in ArchaeologistLocalizedFonts do
	ARCHAEOLOGIST_FONT_OPTIONS = " "..ARCHAEOLOGIST_FONT_OPTIONS..key..",";
end
ARCHAEOLOGIST_FONT_OPTIONS = string.sub(ARCHAEOLOGIST_FONT_OPTIONS, 1, string.len(ARCHAEOLOGIST_FONT_OPTIONS)-1);

-- <= == == == == == == == == == == == == =>
-- => Presets
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PRESETS = "Presets";
ARCHAEOLOGIST_CONFIG_SET = "Set";

ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS				= "Valeurs sur les barres";
ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS			= "Valeurs \195\160 c\195\180t\195\169 des barres";
ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS			= "Pourcentages sur les barres";
ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS		= "Pourcentages \195\160 c\195\180t\195\169 des barres";
ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS		= "(%) dessus, Valeurs \195\160 c\195\180t\195\169";
ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS		= "Valeurs dessus, (%) \195\160 c\195\180t\195\169";

ARCHAEOLOGIST_CONFIG_PREFIXES_OFF				= "Tous les pr\195\169fixes Off";
ARCHAEOLOGIST_CONFIG_PREFIXES_ON				= "Tous les pr\195\169fixes On";
ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT			= "Tous les pr\195\169fixes par Defaut";

-- <= == == == == == == == == == == == == =>
-- => Player Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PLAYER_SEP			= "Configuration: Barres du Joueur";
ARCHAEOLOGIST_CONFIG_PLAYER_SEP_INFO		= "Par D\195\169faut : toutes les valeurs visibles en passant la Souris dessus.";
	
ARCHAEOLOGIST_CONFIG_PLAYERHP			= "Toujours voir la Vie (%)";
ARCHAEOLOGIST_CONFIG_PLAYERHP_INFO		= "Affiche le Pourcentage de points de Vie du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERHP2		= "Toujours voir la Vie";
ARCHAEOLOGIST_CONFIG_PLAYERHP2_INFO = "Affiche les points de Vie exact du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERMP			= "Toujours voir le Mana (%)";
ARCHAEOLOGIST_CONFIG_PLAYERMP_INFO		= "Affiche le Pourcentage de points de Mana du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERMP2		= "Toujours voir le Mana";
ARCHAEOLOGIST_CONFIG_PLAYERMP2_INFO = "Affiche les points de Mana exact du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERXP			= "Toujours voir l\'Exp\195\169rience";
ARCHAEOLOGIST_CONFIG_PLAYERXP_INFO		= "Affiche les points d\'Exp\195\169rience dans la barre du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERXPP			= "L\'Exp\195\169rience en Pourcentage";
ARCHAEOLOGIST_CONFIG_PLAYERXPP_INFO		= "Affiche L\'Exp\195\169rience du Familier en pourcentage.";
ARCHAEOLOGIST_CONFIG_PLAYERXPV			= "Afficher la valeur exacte d\'XP";
ARCHAEOLOGIST_CONFIG_PLAYERXPV_INFO	= "Affiche la valeur exacte sur la barre d\'XP du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERHPINVERT			= "Afficher la Vie manquante";
ARCHAEOLOGIST_CONFIG_PLAYERHPINVERT_INFO	= "Affiche la Vie manquante du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERMPINVERT			= "Afficher le Mana manquant";
ARCHAEOLOGIST_CONFIG_PLAYERMPINVERT_INFO	= "Affiche le Mana manquant du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERXPINVERT			= "Affiche l\'XP necessaire pour passer le niveau";
ARCHAEOLOGIST_CONFIG_PLAYERXPINVERT_INFO	= "";
ARCHAEOLOGIST_CONFIG_PLAYERHPNOPREFIX		= "Cacher le pr\195\169fixe : Vie";
ARCHAEOLOGIST_CONFIG_PLAYERHPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Vie' dans la barre du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERMPNOPREFIX		= "Cacher le pr\195\169fixe : Mana/Rage/Energie";
ARCHAEOLOGIST_CONFIG_PLAYERMPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Mana/Rage/Energie' dans la barre du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERXPNOPREFIX		= "Cacher le pr\195\169fixe : XP";
ARCHAEOLOGIST_CONFIG_PLAYERXPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'XP' dans la barre du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERCLASSICON		= "Icone de Classe";
ARCHAEOLOGIST_CONFIG_PLAYERCLASSICON_INFO	= "Affiche l\icone de Classe dans la fen\195\170tre du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERHPSWAP			= "Echanger les affichages de la Vie";
ARCHAEOLOGIST_CONFIG_PLAYERHPSWAP_INFO		= "Echange la position de la Vie en pourcentage et de la Vie exacte du Joueur.";
ARCHAEOLOGIST_CONFIG_PLAYERMPSWAP			= "Echanger les affichage du Mana";
ARCHAEOLOGIST_CONFIG_PLAYERMPSWAP_INFO		= "Echange la position du Mana en pourcentage et du Mana exact du Joueur.";

-- <= == == == == == == == == == == == == =>
-- => Party Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PARTY_SEP			= "Configuration: Barres du Groupe";
ARCHAEOLOGIST_CONFIG_PARTY_SEP_INFO		= "Par D\195\169faut : toutes les valeurs visibles en passant la Souris dessus.";

ARCHAEOLOGIST_CONFIG_PARTYHP			= "Toujours voir la Vie (%)";
ARCHAEOLOGIST_CONFIG_PARTYHP_INFO		= "Affiche le Pourcentage de points de Vie du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYHP2		= "Toujours voir la Vie";
ARCHAEOLOGIST_CONFIG_PARTYHP2_INFO = "Affiche les points de Vie exact du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYMP			= "Toujours voir le Mana (%)";
ARCHAEOLOGIST_CONFIG_PARTYMP_INFO		= "Affiche le Pourcentage de points de Mana du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYMP2		= "Toujours voir le Mana";
ARCHAEOLOGIST_CONFIG_PARTYMP2_INFO = "Affiche les points de Mana exact du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYHPINVERT			= "Afficher la Vie manquante";
ARCHAEOLOGIST_CONFIG_PARTYHPINVERT_INFO	= "Affiche la Vie manquante du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYMPINVERT			= "Afficher le Mana manquant";
ARCHAEOLOGIST_CONFIG_PARTYMPINVERT_INFO	= "Affiche le Mana manquant du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYHPNOPREFIX		= "Cacher le pr\195\169fixe : Vie";
ARCHAEOLOGIST_CONFIG_PARTYHPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Vie' dans la barre du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYMPNOPREFIX		= "Cacher le pr\195\169fixe : Mana/Rage/Energie";
ARCHAEOLOGIST_CONFIG_PARTYMPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Mana/Rage/Energie' dans la barre du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYCLASSICON			= "Icone de Classe";
ARCHAEOLOGIST_CONFIG_PARTYCLASSICON_INFO	= "Affiche les icones de Classes dans la fen\195\170tre de Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYHPSWAP			= "Echanger les affichages de la Vie";
ARCHAEOLOGIST_CONFIG_PARTYHPSWAP_INFO		= "Echange la position de la Vie en pourcentage et de la Vie exacte du Groupe.";
ARCHAEOLOGIST_CONFIG_PARTYMPSWAP			= "Echanger les affichage du Mana";
ARCHAEOLOGIST_CONFIG_PARTYMPSWAP_INFO		= "Echange la position du Mana en pourcentage et du Mana exact du Groupe.";

-- <= == == == == == == == == == == == == =>
-- => Pet Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PET_SEP			= "Configuration: Barres du Familier";
ARCHAEOLOGIST_CONFIG_PET_SEP_INFO		= "Par D\195\169faut : toutes les valeurs visibles en passant la Souris dessus.";

ARCHAEOLOGIST_CONFIG_PETHP			= "Toujours voir la Vie (%).";
ARCHAEOLOGIST_CONFIG_PETHP_INFO			= "Affiche le Pourcentage de points de Vie du Familier.";
ARCHAEOLOGIST_CONFIG_PETHP2		= "Toujours voir la Vie";
ARCHAEOLOGIST_CONFIG_PETHP2_INFO = "Affiche les points de Vie exact du Familier.";
ARCHAEOLOGIST_CONFIG_PETMP			= "Toujours voir le Mana (%)";
ARCHAEOLOGIST_CONFIG_PETMP_INFO			= "Affiche le Pourcentage de points de Mana du Familier.";
ARCHAEOLOGIST_CONFIG_PETMP2		= "Toujours voir le Mana";
ARCHAEOLOGIST_CONFIG_PETMP2_INFO = "Affiche les points de Mana exact du Familier.";
ARCHAEOLOGIST_CONFIG_PETXP		= "Toujours voir l\'Exp\195\169rience";
ARCHAEOLOGIST_CONFIG_PETXP_INFO = "Affiche les points d\'Exp\195\169rience dans la barre du Familier.";
ARCHAEOLOGIST_CONFIG_PETXPP			= "L\'Exp\195\169rience en Pourcentage";
ARCHAEOLOGIST_CONFIG_PETXPP_INFO	= "Affiche L\'Exp\195\169rience du Familier en pourcentage.";
ARCHAEOLOGIST_CONFIG_PETXPV			= "Afficher la valeur exacte d\'XP";
ARCHAEOLOGIST_CONFIG_PETXPV_INFO	= "Affiche la valeur exacte sur la barre d\'XP du Familier.";
ARCHAEOLOGIST_CONFIG_PETHPINVERT			= "Afficher la Vie manquante";
ARCHAEOLOGIST_CONFIG_PETHPINVERT_INFO	= "Affiche la Vie manquante du Familier.";
ARCHAEOLOGIST_CONFIG_PETMPINVERT			= "Afficher le Mana manquant";
ARCHAEOLOGIST_CONFIG_PETMPINVERT_INFO	= "Affiche le Mana manquant du Familier.";
ARCHAEOLOGIST_CONFIG_PETHPNOPREFIX		= "Cacher le pr\195\169fixe : Vie";
ARCHAEOLOGIST_CONFIG_PETHPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Vie' dans la barre du Familier.";
ARCHAEOLOGIST_CONFIG_PETMPNOPREFIX		= "Cacher le pr\195\169fixe : Mana/Rage/Energie";
ARCHAEOLOGIST_CONFIG_PETMPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Mana/Rage/Energie' dans la barre du Familier.";
ARCHAEOLOGIST_CONFIG_PETXPNOPREFIX		= "Cacher le pr\195\169fixe : XP";
ARCHAEOLOGIST_CONFIG_PETXPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Vie' dans la barre du Familier.";
ARCHAEOLOGIST_CONFIG_PETHPSWAP			= "Echanger les affichages de la Vie";
ARCHAEOLOGIST_CONFIG_PETHPSWAP_INFO		= "Echange la position de la Vie en pourcentage et de la Vie exacte du Familier.";
ARCHAEOLOGIST_CONFIG_PETMPSWAP			= "Echanger les affichage du Mana";
ARCHAEOLOGIST_CONFIG_PETMPSWAP_INFO		= "Echange la position du Mana en pourcentage et du Mana exact du Familier.";

-- <= == == == == == == == == == == == == =>
-- => Target Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_TARGET_SEP			= "Configuration: Barres de la Cible";
ARCHAEOLOGIST_CONFIG_TARGET_SEP_INFO		= "Par D\195\169faut : toutes les valeurs visibles en passant la Souris dessus.";
	
ARCHAEOLOGIST_CONFIG_TARGETHP			= "Toujours voir la Vie (%)";
ARCHAEOLOGIST_CONFIG_TARGETHP_INFO		= "Affiche le Pourcentage de points de Vie de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETHP2		= "Toujours voir la Vie";
ARCHAEOLOGIST_CONFIG_TARGETHP2_INFO = "Affiche les points de Vie exact de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETMP			= "Toujours voir le Mana (%)";
ARCHAEOLOGIST_CONFIG_TARGETMP_INFO		= "Affiche le Pourcentage de points de Mana de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETMP2		= "Toujours voir le Mana";
ARCHAEOLOGIST_CONFIG_TARGETMP2_INFO = "Affiche les points de Mana exact de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETHPINVERT			= "Afficher la Vie manquante";
ARCHAEOLOGIST_CONFIG_TARGETHPINVERT_INFO	= "Affiche la Vie manquante de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETMPINVERT			= "Afficher le Mana manquant";
ARCHAEOLOGIST_CONFIG_TARGETMPINVERT_INFO	= "Affiche le Mana manquant de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETHPNOPREFIX		= "Cacher le pr\195\169fixe : Vie";
ARCHAEOLOGIST_CONFIG_TARGETHPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Vie' dans la barre de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETMPNOPREFIX		= "Cacher le pr\195\169fixe : Mana/Rage/Energie";
ARCHAEOLOGIST_CONFIG_TARGETMPNOPREFIX_INFO	= "Cache le pr\195\169fixe 'Mana/Rage/Energie' dans la barre de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETCLASSICON		= "Icone de Classe";
ARCHAEOLOGIST_CONFIG_TARGETCLASSICON_INFO	= "Affiche l\icone de Classe dans la fen\195\170tre de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETHPSWAP			= "Echanger les affichages de la Vie";
ARCHAEOLOGIST_CONFIG_TARGETHPSWAP_INFO		= "Echange la position de la Vie en pourcentage et de la Vie exacte de la Cible.";
ARCHAEOLOGIST_CONFIG_TARGETMPSWAP			= "Echanger les affichage du Mana";
ARCHAEOLOGIST_CONFIG_TARGETMPSWAP_INFO		= "Echange la position du Mana en pourcentage et du Mana exact de la Cible.";

-- <= == == == == == == == == == == == == =>
-- => Alternate Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP		= "Options Alternatives";
ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP_INFO		= "Options Alternatives";
	
ARCHAEOLOGIST_CONFIG_HPCOLOR			= "Afficher les changements de couleur de la Barre de Vie";
ARCHAEOLOGIST_CONFIG_HPCOLOR_INFO		= "Affiche les changements de couleur de la Barre de Vie quand la Vie baisse.";
	
ARCHAEOLOGIST_CONFIG_DEBUFFALT			= "Position Alternative des D\195\169buffs";
ARCHAEOLOGIST_CONFIG_DEBUFFALT_INFO		= "Affiche les D\195\169buffs du Familier et du Groupe sous les Buffs.\nPar d\195\169faut les debuffs apparaissent \195\160 Droite de la Fen\195\170tre.";
	
ARCHAEOLOGIST_CONFIG_TBUFFALT			= "Diviser les D\195\169buffs";
ARCHAEOLOGIST_CONFIG_TBUFFALT_INFO		= "Divise les D\195\169buffs de la cible en lignes de 8.";
	
ARCHAEOLOGIST_CONFIG_USEHPVALUE			= "Affiche la valeur exacte des points de vie si possible";
ARCHAEOLOGIST_CONFIG_USEHPVALUE_INFO	= "Remplacera l\'affichage du pourcentage par la valeur exact si c\'est possible.";
	
ARCHAEOLOGIST_CONFIG_MOBHEALTH			= "Utiliser MobHealth2 pour voir les PV de la Cible";
ARCHAEOLOGIST_CONFIG_MOBHEALTH_INFO		= "Cache le texte d\'origine de MobHealth2 et l\'emploie \195\160 la place du texte des Points de Vie de la \195\170tre de Cible.";
	
ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT		= "Portrait des Classes";
ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT_INFO = "Remplace le Portrait par l\'Icone de Classe.";

-- <= == == == == == == == == == == == == =>
-- => Font Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP			= "Configuration: Polices";
ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP_INFO		= "";
	
ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE		= "Taille du Texte Joueur/Cible.";
ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE_SLIDER_TEXT = " ";
	
ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT		= "Police du Texte Joueur/Cible.";
ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT_INFO = ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT.."\n Font Options: %s";
	
ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE		= "Taille du Texte Familier/Groupe";
ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE_SLIDER_TEXT = " ";
	
ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT		= "Police du Texte Familier/Groupe";
ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT_INFO = ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT.."\n Font Options: %s";
	
ARCHAEOLOGIST_COLOR_CHANGED				= "|c%s%s couleur chang\195\169e.|r";
ARCHAEOLOGIST_COLOR_RESET				= "|c%s%s couleur annul\195\169e.|r";
	
ARCHAEOLOGIST_CONFIG_COLORPHP			= "Vie (%):";
ARCHAEOLOGIST_CONFIG_COLORPHP_INFO		= "Change la couleur de la Vie en pourcentage.";
ARCHAEOLOGIST_CONFIG_COLORPHP_RESET			= "Annuler";
ARCHAEOLOGIST_CONFIG_COLORPHP_RESET_INFO	= "Annule la couleur s\195\169lection\195\169e pour la Vie en pourcentage.";
	
ARCHAEOLOGIST_CONFIG_COLORPMP			= "Mana (%):";
ARCHAEOLOGIST_CONFIG_COLORPMP_INFO		= "Change la couleur du Mana en pourcentage.";
ARCHAEOLOGIST_CONFIG_COLORPMP_RESET			= "Annuler";
ARCHAEOLOGIST_CONFIG_COLORPMP_RESET_INFO	= "Annule la couleur s\195\169lection\195\169e pour le Mana en pourcentage.";
	
ARCHAEOLOGIST_CONFIG_COLORSHP			= "Vie (%):";
ARCHAEOLOGIST_CONFIG_COLORSHP_INFO		= "Change la couleur de la Vie exacte.";
ARCHAEOLOGIST_CONFIG_COLORSHP_RESET			= "Annuler";
ARCHAEOLOGIST_CONFIG_COLORSHP_RESET_INFO	= "Annule la couleur s\195\169lection\195\169e pour la Vie exacte.";
	
ARCHAEOLOGIST_CONFIG_COLORSMP			= "Mana:";
ARCHAEOLOGIST_CONFIG_COLORSMP_INFO		= "Change la couleur du Mana exact.";
ARCHAEOLOGIST_CONFIG_COLORSMP_RESET			= "Annuler";
ARCHAEOLOGIST_CONFIG_COLORSMP_RESET_INFO	= "Annule la couleur s\195\169lection\195\169e pour le Mana exact.";
	
	
-- <= == == == == == == == == == == == == =>
-- => Party Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP		= "Configuration: Buff Du Groupe";
ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP_INFO	= "Par D\195\169faut : Douze Duffs et Douze D\195\169buffs sont visibles.";
	
ARCHAEOLOGIST_CONFIG_PBUFFS			= "Cacher les Buffs";
ARCHAEOLOGIST_CONFIG_PBUFFS_INFO		= "Les Buffs du Groupe apparaissent en passant la Souris sur le portrait.";
	
ARCHAEOLOGIST_CONFIG_PBUFFNUM			= "Nombre de Buffs";
ARCHAEOLOGIST_CONFIG_PBUFFNUM_INFO		= "Affiche le nombre de Buffs du Groupe.";
ARCHAEOLOGIST_CONFIG_PBUFFNUM_SLIDER_TEXT  	= "Buffs Visibles";
	
ARCHAEOLOGIST_CONFIG_PDEBUFFS			= "Cacher les D\195\169buffs";
ARCHAEOLOGIST_CONFIG_PDEBUFFS_INFO		= "Les D\195\169buffs du Groupe apparaissent en passant la Souris sur le portrait.";
	
ARCHAEOLOGIST_CONFIG_PDEBUFFNUM		= "Nombre de D\195\169buffs";
ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_INFO		= "Affiche le nombre de Buffs du Groupe.";
ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_SLIDER_TEXT 	= "D\195\169buffs Visibles";
	
-- <= == == == == == == == == == == == == =>
-- => Party Pet Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP		= "Configuration: Buff du Familier du groupe";
ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP_INFO		= "Par D\195\169faut : 16 Buffs et 16 D\195\169buffs sont visibles.";
	
ARCHAEOLOGIST_CONFIG_PPTBUFFS			= "Cacher les Buffs";
ARCHAEOLOGIST_CONFIG_PPTBUFFS_INFO		= "Les Buffs du Familier du groupe apparaissent en passant la Souris sur le portrait.";
	
ARCHAEOLOGIST_CONFIG_PPTBUFFNUM			= "Nombre de Buffs";
ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_INFO		= "Affiche le nombre de Buffs du Familier du groupe";
ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_SLIDER_TEXT 	 = "Buffs Visibles";
	
ARCHAEOLOGIST_CONFIG_PPTDEBUFFS			= "Cacher les D\195\169buffs";
ARCHAEOLOGIST_CONFIG_PPTDEBUFFS_INFO		= "Les D\195\169buffs du Familier du groupe apparaissent en passant la Souris sur le portrait.";
	
ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM		= "Nombre de D\195\169buffs";
ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_INFO		= "Affiche le nombre de Buffs du Familier.";
ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_SLIDER_TEXT 	= "D\195\169buffs Visibles";
	
-- <= == == == == == == == == == == == == =>
-- => Pet Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP		= "Configuration: Buff du Familier";
ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP_INFO		= "Par D\195\169faut : 16 Buffs et 4 D\195\169buffs sont visibles.";
	
ARCHAEOLOGIST_CONFIG_PTBUFFS			= "Cacher les Buffs";
ARCHAEOLOGIST_CONFIG_PTBUFFS_INFO		= "Les Buffs du Familier apparaissent en passant la Souris sur le portrait.";
	
ARCHAEOLOGIST_CONFIG_PTBUFFNUM			= "Nombre de Buffs";
ARCHAEOLOGIST_CONFIG_PTBUFFNUM_INFO		= "Affiche le nombre de Buffs du Familier";
ARCHAEOLOGIST_CONFIG_PTBUFFNUM_SLIDER_TEXT 	 = "Buffs Visibles";
	
ARCHAEOLOGIST_CONFIG_PTDEBUFFS			= "Cacher les D\195\169buffs";
ARCHAEOLOGIST_CONFIG_PTDEBUFFS_INFO		= "Les D\195\169buffs du Familier apparaissent en passant la Souris sur le portrait.";
	
ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM		= "Nombre de D\195\169buffs";
ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_INFO		= "Affiche le nombre de Buffs du Familier.";
ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_SLIDER_TEXT 	= "D\195\169buffs Visibles";
	
-- <= == == == == == == == == == == == == =>
-- => Target Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP		= "Configuration: Buff de la Cible";
ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP_INFO   	= "Par D\195\169faut : Huit Buffs et Huit D\195\169buffs sont visibles.";
	
ARCHAEOLOGIST_CONFIG_TBUFFS			= "Cacher les Buffs";
ARCHAEOLOGIST_CONFIG_TBUFFS_INFO		= "Cache les Buffs de la Cible.";
	
ARCHAEOLOGIST_CONFIG_TBUFFNUM			= "Nombre de Buffs";
ARCHAEOLOGIST_CONFIG_TBUFFNUM_INFO		= "Affiche le nombre de Buffs de la Cible.";
ARCHAEOLOGIST_CONFIG_TBUFFNUM_SLIDER_TEXT   	= "Buffs Visible";
	
ARCHAEOLOGIST_CONFIG_TDEBUFFS			= "Cacher les D\195\169buffs";
ARCHAEOLOGIST_CONFIG_TDEBUFFS_INFO		= "Cache les D\195\169buffs de la Cible.";
	
ARCHAEOLOGIST_CONFIG_TDEBUFFNUM			= "Nombre de D\195\169buffs";
ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_INFO		= "Affiche le nombre de Buffs de la Cible.";
ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_SLIDER_TEXT 	= "D\195\169buffs Visibles";
	
ARCHAEOLOGIST_FEEDBACK_STRING = "%s est actuellement r\195\169gler sur %s.";
end