local L = AceLibrary("AceLocale-2.2"):new("ItemBonusesFu")

L:RegisterTranslations("frFR", function() return {
	["Easy access item bonuses."] = "Accès aisé aux bonus des objets.", -- Desc
	["Item Bonuses"] = "Bonus des objets", -- TEXT
	["IB"] = "BO", -- SHORT_TEXT
	["Display none"] = "Afficher aucun", -- DISPLAY_NONE
	["Show label text"] = "Afficher le texte descriptif", -- SHOWLABEL
	["Brief label text"] = "Afficher le descriptif bref", -- SHORTDISPLAY
	["Show Colored text"] = "Afficher le texte coloré", -- COLORED
	["BonusScanner N/A"] = "BonusScanner n'est pas disponible", -- BONUSSCANNER_MISSING
	["Attributes"] = "Attributs", -- CAT - ATT
	["Resistance"] = "Résistances", -- CAT - RES
	["Skills"] = "Compétences", -- CAT - SKILL
	["Melee and ranged combat"] = "Combat à distance et au corps à corps", -- CAT - BON
	["Spells"] = "Sorts", -- CAT - SBON
	["Life and mana"] = "Vie et mana" --CAT - OBON
} end)
