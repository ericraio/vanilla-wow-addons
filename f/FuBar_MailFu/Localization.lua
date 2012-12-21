

FuBar_MailLocale =
	GetLocale() == "deDE" and { -- German by Lunox
		nomail = "Keine Post ",
		newmail = "Neue Post ",
		ahalert = "AH-Alarm! ",

		chatecho = "Neue Post erhalten (%d/%d)",

		ttnew = " neue Nachrichten",
		tttotal = " Nachrichten insgesamt",

		OUTBID = "\195\156berboten: ",
		WON = "Gewonnen: ",
		EXPIRED = "Abgelaufen: ",
		REMOVED = "Abgebrochen: ",
		SOLD = "Verkauft: ",

		menuminimap  = "Verstecke Minimap-Symbol",
		menucompact = "Kompakt-Modus",
		menuchat    = "Chat-Alarm",
		menusound   = "Sound verwenden",
		menutext = "Show Text",
		menucount = "Show Count",
		menuicon = "Hide icon if no mail",
	}
	or GetLocale() == "frFR" and { -- French by Apsalar
		nomail = "Aucun courier",
		newmail = "Nouveau courier",
		ahalert = "Alerte AH!",

		chatecho = "New Mail Recieved (%d/%d)",

		ttnew = " new mail items",
		tttotal = " total mail items",

		OUTBID = "Outbid: ",
		WON = "Won: ",
		EXPIRED = "Expired: ",
		REMOVED = "Cancelled: ",
		SOLD = "Sold: ",

		menuminimap = "Cacher l'ic\195\180ne de la minicarte",
		menucompact = "Mode compact",
		menuchat = "Chat Alert",
		menusound = "Use Sound",
		menutext = "Show Text",
		menucount = "Show Count",
		menuicon = "Hide icon if no mail",
	}
	or { -- English by Tekkub (duh)
		nomail = "No mail",
		newmail = "New Mail",
		ahalert = "AH Alert!",

		chatecho = "New Mail Recieved (%d/%d)",

		ttnew = " new mail items",
		tttotal = " total mail items",

		OUTBID = "Outbid: ",
		WON = "Won: ",
		EXPIRED = "Expired: ",
		REMOVED = "Cancelled: ",
		SOLD = "Sold: ",

		menuminimap = "Hide Minimap Icon",
		menucompact = "Compact Mode",
		menuchat = "Chat Alert",
		menusound = "Use Sound",
		menutext = "Show Text",
		menucount = "Show Count",
		menuicon = "Hide icon if no mail",
	}
