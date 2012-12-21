if ( GetLocale() == "frFR" ) then
	CT_EH_REPAIR = "R\195\169pare";
	CT_EH_FLIGHT = "Vol";
	CT_EH_REAGENT = "Composant";
	CT_EH_AMMO = "Munitions";
	CT_EH_MAIL = "Courrier";
	
	CT_EH_LOGDATE = "Date";
	CT_EH_LOGTYPE = "Type";
	CT_EH_LOGCHAR = "Personnage";
	CT_EH_LOGCOST = "Cost";
	
	CT_EH_AVERAGEREPAIR = "R\195\169paration Moyenne:";
	CT_EH_AVERAGEEXPENSES = "D\195\169pense Moyenne/Jour:";
	CT_EH_FLIGHTCOSTS = "Vols:";
	CT_EH_REPAIRCOSTS = "R\195\169parations:";
	CT_EH_REAGENTCOSTS = "Composants:";
	CT_EH_AMMOCOSTS = "Munitions:";
	CT_EH_MAILCOSTS = "Envoie de Courrier:";
	
	CT_EH_TOTALCOST = "Montant D\195\169pens\195\169 Total:";
	CT_EH_PLAYERDISTRIBUTION = "Distribution par Joueur:";
	CT_EH_ALLCHARACTERS = "Tous les Personnages:";
	CT_EH_RECORDINGFROM = "Donn\195\169es Enregistr\195\169es Depuis |c00FFFFFF%s|r.";
	CT_EH_VIEWING = "Regarder |c00FFFFFF%s|r";
	
	CT_EH_SUMMARY = "Sommaire";
	CT_EH_LOG = "Journal";
	
	-- Classes
	CT_EH_WARRIOR = "Guerrier";
	CT_EH_MAGE = "Mage";
	CT_EH_DRUID = "Druide";
	CT_EH_ROGUE = "Voleur";
	CT_EH_PRIEST = "Pr\195\170tre";
	CT_EH_WARLOCK = "D\195\169moniste";
	CT_EH_HUNTER = "Chasseur";
	CT_EH_SHAMAN = "Chaman";
	CT_EH_PALADIN = "Paladin";
	
	-- Reagents to check for to flag as reagents vendor
	CT_EH_SCANFORREAGENTS = {
		["poudre des arcane"] = true,
		["baies sauvages"] = true,
		["epinette sauvage"] = true,
		["bougies sanctifi\195\169e"] = true,
		["bougie sacr\195\169e"] = true,
		["croix"] = true,
		["rune de t\195\169l\195\169portation"] = true,
		["rune de portails"] = true,
		["symbole de divinit\195\169"] = true,
		["graine d'erable"] = true,
		["graine de stranglethorn"] = true,
		["graine de fr\195\1701ne"] = true,
		["graine de charme"] = true,
		["graine de bois de fer"] = true,
		["poudre d'\195\169clair"] = true
	};
	CT_EH_SCANFORAMMO = {
		["fl\195\168che de glace"] = true,
		["fl\195\168che barbel\195\169e"] = true,
		["fl\195\168che rasoir"] = true,
		["fl\195\168che pointue"] = true,
		["fl\195\168che grossi\195\168re"] = true,
		["balle de glace"] = true,
		["balle de pr\195\169cision"] = true,
		["balle dure"] = true,
		["caillou lisse"] = true,
		["balle lourde"] = true,
		["balle l\195\169g\195\168re"] = true,
		["dague de lancer corrompue"] = true,
		["hache de lancer \195\169tincellante"] = true,
		["hache de lancer mortelle"] = true,
		["couteau de lancer lourd"] = true,
		["couteau de lancer per\195\167ant"] = true,
		["hache de lancer aiguis\195\169e"] = true,
		["dague de lancer \195\169quilibr\195\168e"] = true,
		["hache de lancer \195\169quilibr\195\168e"] = true,
		["hache de lancer grossi\195\168re"] = true,
		["petit couteau de lancer"] = true
	};
	
	CT_EH_MODINFO = {
		"Expense History",
		"Afficher Fen\195\170tre",
		"Affiche la fen\195\170tre \195\160 partir de laquelle vous pouvez voir une liste et un r\195\169sum\195\169 de vos d\195\169penses."
	};
end