function MoneyFu_Locals_deDE()

MoneyFuLocals = {
	NAME = "FuBar - MoneyFu",
	DESCRIPTION = "F\195\188hrt Buch \195\188ber Eure Reicht\195\188mer und die Eurer Charaktere auf diesem Realm.",
	COMMANDS = {"/monfu", "/moneyfu"},
	CMD_OPTIONS = {},
	TEXT_TOTAL = "Gesamt",
	TEXT_SESSION_RESET = "Sitzung zur\195\188cksetzen",
	TEXT_THIS_SESSION = "Diese Sitzung",
	TEXT_GAINED = "Eingenommen",
	TEXT_SPENT = "Ausgegeben",
	TEXT_AMOUNT = "Geldmenge",
	TEXT_PER_HOUR = "Pro Stunde",
	
	ARGUMENT_RESETSESSION = "resetSession",
	
	MENU_RESET_SESSION = "Sitzung zur\195\188cksetzen",
	MENU_CHARACTER_SPECIFIC_CASHFLOW = "Charakterspezifischen Geldfluss anzeigen",
	MENU_PURGE = "L\195\182schen",
	MENU_SHOW_GRAPHICAL = "Anzeige mit M\195\188nzsymbolen",
	MENU_SHOW_FULL = "Ausf\195\188hrlicher Stil",
	MENU_SHOW_SHORT = "Kurzstil",
	MENU_SHOW_CONDENSED = "Komprimierter Stil",
	
	Text_SESSION_RESET = "Sitzung zur\195\188ckgesetzt.",
	TEXT_CHARACTERS = "Charaktere",
	TEXT_PROFIT = "Gewinn",
	TEXT_LOSS = "Verlust",
	
	HINT = "Anklicken, um Geld aufzunehmen.",
}

MoneyFuLocals.CMD_OPTIONS = {
	{
		option = MoneyFuLocals.ARGUMENT_RESETSESSION,
		desc = "Daten der aktuellen Sitzung zur\195\188cksetzen.",
		method = "ResetSession"
	}
}

end