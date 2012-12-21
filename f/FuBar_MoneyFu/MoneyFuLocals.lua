local L = AceLibrary("AceLocale-2.0"):new("MoneyFu")

L:RegisterTranslations("enUS", function()
	return {
		["NAME"] = "FuBar - MoneyFu",
		["DESCRIPTION"] = "Keeps track of current money and all your characters on one realm.",
		["COMMANDS"] = {"/monfu", "/moneyfu"},
		["TEXT_TOTAL"] = "Total",
		["TEXT_SESSION_RESET"] = "Session reset",
		["TEXT_THIS_SESSION"] = "This session",
		["TEXT_GAINED"] = "Gained",
		["TEXT_SPENT"] = "Spent",
		["TEXT_AMOUNT"] = "Amount",
		["TEXT_PER_HOUR"] = "Per hour",

		["ARGUMENT_RESETSESSION"] = "resetSession",

		["MENU_RESET_SESSION"] = "Reset Session",
		["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "Show character-specific cashflow",
		["MENU_PURGE"] = "Purge",
		["MENU_SHOW_GRAPHICAL"] = "Show with coins",
		["MENU_SHOW_FULL"] = "Show full style",
		["MENU_SHOW_SHORT"] = "Show short style",
		["MENU_SHOW_CONDENSED"] = "Show condensed style",
		["SIMPLIFIED_TOOLTIP"] = "Simplified Tooltip",

		["TEXT_SESSION_RESET"] = "Session reset.",
		["TEXT_CHARACTERS"] = "Characters",
		["TEXT_PROFIT"] = "Profit",
		["TEXT_LOSS"] = "Loss",
	
		["HINT"] = "Click to pick up money"
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["NAME"] = "FuBar - MoneyFu",
		["DESCRIPTION"] = "F\195\188hrt Buch \195\188ber Eure Reicht\195\188mer und die Eurer Charaktere auf diesem Realm.",
		["COMMANDS"] = {"/monfu", "/moneyfu"},
		["TEXT_TOTAL"] = "Gesamt",
		["TEXT_SESSION_RESET"] = "Sitzung zur\195\188cksetzen",
		["TEXT_THIS_SESSION"] = "Diese Sitzung",
		["TEXT_GAINED"] = "Eingenommen",
		["TEXT_SPENT"] = "Ausgegeben",
		["TEXT_AMOUNT"] = "Geldmenge",
		["TEXT_PER_HOUR"] = "Pro Stunde",
	
		["ARGUMENT_RESETSESSION"] = "resetSession",
	
		["MENU_RESET_SESSION"] = "Sitzung zur\195\188cksetzen",
		["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "Charakterspezifischen Geldfluss anzeigen",
		["MENU_PURGE"] = "L\195\182schen",
		["MENU_SHOW_GRAPHICAL"] = "Anzeige mit M\195\188nzsymbolen",
		["MENU_SHOW_FULL"] = "Ausf\195\188hrlicher Stil",
		["MENU_SHOW_SHORT"] = "Kurzstil",
		["MENU_SHOW_CONDENSED"] = "Komprimierter Stil",
		["SIMPLIFIED_TOOLTIP"] = "Vereinfachtes Tooltip",
	
		["TEXT_SESSION_RESET"] = "Sitzung zur\195\188ckgesetzt.",
		["TEXT_CHARACTERS"] = "Charaktere",
		["TEXT_PROFIT"] = "Gewinn",
		["TEXT_LOSS"] = "Verlust",
	
		["HINT"] = "Anklicken, um Geld aufzunehmen.",
	}
end)
