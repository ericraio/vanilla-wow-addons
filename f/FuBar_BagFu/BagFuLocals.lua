local L = AceLibrary("AceLocale-2.0"):new("BagFu")

L:RegisterTranslations("enUS", function()
	return {
		["NAME"] = "FuBar - BagFu",
		["DESCRIPTION"] = "Keeps track of space left in your bags.",

		["ARGUMENT_AMMO"] = "ammo",
		["ARGUMENT_DEPLETION"] = "depletion",
		["ARGUMENT_PROFESSION"] = "profession",

		["AMMO_BAGS"] = "Ammo/Soul Bags",
		["PROFESSION_BAGS"] = "Profession Bags",
		["BAG_DEPLETION"] = "Bag Depletion",
		["MENU_INCLUDE_AMMO_BAGS"] = "Include ammo/soul bags",
		["MENU_INCLUDE_PROFESSION_BAGS"] = "Include profession bags",
		["MENU_SHOW_DEPLETION_OF_BAGS"] = "Show depletion of bags",

		["TEXT_SOUL_BAG"] = "Soul Bag",
		["TEXT_ENCHANTING_BAG"] = "Enchanting Bag",
		["TEXT_HERB_BAG"] = "Herb Bag",
		["TEXT_ENGINEERING_BAG"] = "Engineering Bag",
		["TEXT_QUIVER"] = "Quiver",
		["TEXT_AMMO_POUCH"] = "Ammo Pouch",

		["TEXT_HINT"] = "Click to open your bags."
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["NAME"] = "FuBar - BagFu",
		["DESCRIPTION"] = "\195\156berwacht die Taschenpl\195\164tze.",
	
		["ARGUMENT_AMMO"] = "ammo",
		["ARGUMENT_DEPLETION"] = "depletion",
		["ARGUMENT_PROFESSION"] = "profession",

		["AMMO_BAGS"] = "Munition/Seelen Taschen",
		["PROFESSION_BAGS"] = "Berufe Taschen",
		["BAG_DEPLETION"] = "Taschen Entleerung",
		["MENU_INCLUDE_AMMO_BAGS"] = "Munition/Seelen Taschen mit einbeziehen",
		["MENU_INCLUDE_PROFESSION_BAGS"] = "Spezialtaschen f\195\188r Berufe einbeziehen",
		["MENU_SHOW_DEPLETION_OF_BAGS"] = "Zeige freie Pl\195\164tze",
	
		["TEXT_SOUL_BAG"] = "Seelenbeutel",
		["TEXT_ENCHANTING_BAG"] = "Verzauberertasche",
		["TEXT_HERB_BAG"] = "Kr\195\164utertasche",
		["TEXT_ENGINEERING_BAG"] = "Ingenieurstasche",
		["TEXT_QUIVER"] = "K\195\182cher",
		["TEXT_AMMO_POUCH"] = "Munitionsbeutel",
	
		["TEXT_HINT"] = "Linksklick \195\182ffnet die Taschen."
	}
end)
