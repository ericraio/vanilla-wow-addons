if ( GetLocale() == "deDE" ) then
	CT_EH_REPAIR = "Reparatur";
	CT_EH_FLIGHT = "Flug";
	CT_EH_REAGENT = "Zutat";
	CT_EH_AMMO = "Munition";
	CT_EH_MAIL = "Post";
	
	CT_EH_LOGDATE = "Datum";
	CT_EH_LOGTYPE = "Typ";
	CT_EH_LOGCHAR = "Charakter";
	CT_EH_LOGCOST = "Kosten";
	
	CT_EH_AVERAGEREPAIR = "Durchschnittliche Reparaturkosten:";
	CT_EH_AVERAGEEXPENSES = "Durchschnittliche Ausgaben/Tag:";
	CT_EH_FLIGHTCOSTS = "Fl\195\188ge:"; 
	CT_EH_REPAIRCOSTS = "Reparaturen:";
	CT_EH_REAGENTCOSTS = "Zutaten:";
	CT_EH_AMMOCOSTS = "Munition:";
	CT_EH_MAILCOSTS = "Portokosten:";
	
	CT_EH_TOTALCOST = "Gesamtausgaben:";
	CT_EH_PLAYERDISTRIBUTION = "Spielerverteilung:";
	CT_EH_ALLCHARACTERS = "Alle Charaktere";
	CT_EH_RECORDINGFROM = "Datenaufzeichnung von |c00FFFFFF%s|r.";
	CT_EH_VIEWING = "Besichtigung |c00FFFFFF%s|r";
	
	CT_EH_SUMMARY = "Zusammenfassung";
	CT_EH_LOG = "Log";
	
	-- Classes
	CT_EH_WARRIOR = "Krieger";
	CT_EH_MAGE = "Magier";
	CT_EH_DRUID = "Druide";
	CT_EH_ROGUE = "Schurke";
	CT_EH_PRIEST = "Priester";
	CT_EH_WARLOCK = "Hexenmeister";
	CT_EH_HUNTER = "J\195\164ger";
	CT_EH_SHAMAN = "Schamane";
	CT_EH_PALADIN = "Paladin";
	
	-- Reagents to check for to flag as reagents vendor
	CT_EH_SCANFORREAGENTS = {
		["arkanes puder"] = true,
		["wilde beeren"] = true,
		["wilder dornwurz"] = true,
		["hochheilige kerze"] = true,
		["heilige kerze"] = true,
		["ankh"] = true,
		["rune der teleportation"] = true,
		["rune der portale"] = true,
		["symbol der offenbarung"] = true,
		["ahornsamenkorn"] = true,
		["stranglethorn-samenkorn"] = true,
		["eschenholzsamenkorn"] = true,
		["hainbuchensamenkorn"] = true,
		["eisenholzsamenkorn"] = true,
		["blitzstrahlpulver"] = true
	};
	CT_EH_SCANFORAMMO = {
		["eisgewirkter pfeil"] = true,
		["gezackter pfeil"] = true,
		["schneidenpfeil"] = true,
		["scharfer pfeil"] = true,
		["rauer pfeil"] = true,
		["eisgewirkte kugel"] = true,
		["genaue patronen"] = true,
		["robustes geschoss"] = true,
		["glatter kiesel"] = true,
		["schweres geschoss"] = true,
		["leichtes geschoss"] = true,
		["t\192\188ckischer wurfdolch"] = true,
		["glei\195\159ende wurfaxt"] = true,
		["t\195\182dliche wurfaxt"] = true,
		["schwerer wurfdolch"] = true,
		["bei\195\159endes wurfmesser"] = true,
		["scharfe wurfaxt"] = true,
		["ausbalancierter wurfdolch"] = true,
		["beschwerte wurfaxt"] = true,
		["kunstlose wurfaxt"] = true,
		["kleines wurfmesser"] = true
	};
	
	CT_EH_MODINFO = {
		"Expense History",
		"Zeige Dialogfenster",
		"Zeigt ein dialogfenster, in dem du eine auflistung und zusammenfassung deiner ausgaben sehen kannst."
	};
end