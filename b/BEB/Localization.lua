BEB = {}

BEB.TEXT = {
	validcommands =				"Valid commands are /beb [defaults, help]. /beb by itself will open the config screen.",
	invalidcommand =				"Invalid command, use ,/beb help, for a list of commands",
	xpnomatch1 =					"Table and in game Xp per level do not match, contact the author with; BEB: LVL= ",
	xpnomatch2 =					", TableXp = ",
	xpnomatch3 =					", ActualXp = ",
	framelocked =					"The BEB frame is locked. Unlock it if you wish to move it",
	loaded =						"BEB Loaded",
	framewasinvalid =				"BEB: The frame that BEB was attached to does not exist or is invalid. Please use /beb and change the frame BEB is attached to.",
	optionsdisabled =				"BEBOptions is disabled. Please log out to the character selection screen and re-enable it.",
	optionsmissing =				"BEBOptions is missing or not in the correct folder. Please exit the game and replace BEBOptions or reinstall the AddOn.",
	optionscorrupt =				"BEBOptions is corrupt. Please reinstall the AddOn. If that does not help please contact the author for a fix.",
	optionsversion =				"BEBOptions failed to load because you haven't set WoW to load out of date addons from the addons screen.",
	optionsnoload1 =				"BEBOptions failed to load with reason ",
	optionsnoload2 =				". Contact the author with the reason and the circumstances.",
	profilemissing =				"BEB: The profile used by this character is missing or has been deleted.",
	defaultsloaded =				"BEB Defaults Loaded",
}
BEB.TEXTVARTEXT = {
	rested =						"Rested",
	unrested =					"Unrested",
	fullyrested =					"Fully Rested",
	resting =						"Resting",
}
BEB.LOCALIZED = {
	RestedSearchString =			"(%d+) exp (%S+) bonus",
	XpSearchString =				"dies, you gain (%d+) experience.",
}
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  German  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --
if (GetLocale() == "deDE") then
BEB.TEXT = {
	validcommands =				"G\195\188ltige Kommandos sind /beb [defaults, help]. /beb alleine \195\182ffnet das Konfigurationsmen\195\188.",
	invalidcommand =				"Ung\195\188ltiges Kommando, benutze '/beb help' um eine Liste der Kommandos zu bekommen",
	xpnomatch1 =					"Tabellen und Ingame Erfahrung pro Level passen nicht zusammen. Kontaktiere den Autor mit; BEB: LVL= ",
	xpnomatch2 =					", TableXp= ",
	xpnomatch3 =					", ActualXp = ",
	framelocked =					"Der BEB Rahmen ist festgestellt. L\195\182se ihn, wenn du ihn bewegen willst.",
	loaded =						"BEB geladen",
	framewasinvalid =				"BEB: Der Rahmen an den BEB angeheftet war existiert nicht oder ist ung\195\188ltig. Bitte benutze /beb und \195\164ndere den Rahmen an dem BEB angeheftet ist.",
	optionsdisabled =				"BEBOptions ist deaktiviert. Bitte logge zum Charakterauswahlbildschirm aus und aktiviere es.",
	optionsmissing =				"BEBOptions fehlt oder ist nicht im richtigen Ordner. Bitte verlasse das Spiel und ersetze BEBOptions oder installiere das AddOn erneut.",
	optionscorrupt =				"BEBOptions ist besch\195\164digt. Bitte installiere das AddOn erneut. Wenn das nicht hilft wende dich an den Autor f\195\188r Hilfe bei der Fehlerbehebung.",
	optionsversion =				"BEBOptions konnte nicht geladen werden, da du den Schalter Veraltete AddOns laden im AddOns Bildschirm nicht gesetzt hast.",
	optionsnoload1 =				"BEBOptions konnte aus folgenden Grund nicht geladen werden: ",
	optionsnoload2 =				". Kontaktiere den Autor mit dem Grund und den Gegebenheiten.",
	profilemissing =				"BEB: Das Profil, dass von diesem Charakter benutzt wird fehlt oder wurde gel\195\182scht.",
	defaultsloaded =				"BEB Voreinstellungen geladen.",
}
BEB.TEXTVARTEXT = {
	rested =						"Ausgeruht",
	unrested =					"Unausgeruht",
	fullyrested =					"Vollst\195\164ndig ausgeruht",
	resting =						"Ausruhen",
}
BEB.LOCALIZED = {
	RestedSearchString =			"(%d+) Erf. (%S+) Bonus",
	XpSearchString =				"stirbt, Ihr bekommt (%d+) Erfahrung.",
}
end
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  French  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --
if (GetLocale() == "frFR") then
BEB.TEXT = {
	validcommands =				"Les commandes valides sont /beb [defaults, help]. /beb tout seul ouvrira l'ecran de configuration",
	invalidcommand =				"Commande invalide, veuillez utiliser, /beb help, pour une liste de commandes",
	xpnomatch1 =					"Les données et votre xp ne sont pas les memes, veuillez contacter l'auter avec; BEB: LVL= ",
	xpnomatch2 =					", TableXp = ",
	xpnomatch3 =					", ActualXp = ",
	framelocked =					"Le cadre BEB est verouillez. Deverouillez le si vous souhaitez le deplacer",
	loaded =						"BEB est charg\195\169",
	framewasinvalid =				"BEB: Le cadre auquel BEB \195\169tait accroch\195\169 n'existe pas ou est invalide. Veuillez utiliser /beb pour le changer.",
	optionsdisabled =				"BEBOptions est d\195\169sactiv\195\169. Veuillez fermer cette session, et activer l'option \195\160 l'\195\169cran de selection de votre personnage.",
	optionsmissing =				"BEBOptions n'existe pas ou est dans le mauvais fichier. Veuillez sortir du jeu et remplacer BEBOption ou r\195\169installer l'AddOn.",
	optionscorrupt =				"BEBOption est corrompu. Veuillez r\195\169installer l'AddOn. Si cette manoeuvre ne vous aide pas, veuillez contacter l'auteur.",
	optionsversion =				"BEBOptions n'a pas reussi a charger car vous n'avez pas configure WoW a lancer les interfaces personalisees qui n'ont pas ete mis a jour. Vous pouvez activer cette option a l'ecran de selection de vos personnages.", -----
	optionsnoload1 =				"BEBOption n'a pas reussi a charge pour raison ", ---------
	optionsnoload2 =				". Veuillez contacter l'auteur avec la raison et les circonstances", -------
	profilemissing =				"BEB: Le profil utilis\195\169 utilis\195\169 par ce caract\195\168re est manquant ou a \195\169t\195\169 \195\169ffac\195\169.",
	defaultsloaded =				"BEB Configuration par d\195\169faut charg\195\169e",
}
BEB.TEXTVARTEXT = {
	rested =						"Repos\195\169",
	unrested =					"Pas repos\195\169",
	fullyrested =					"Enti\195\168rement repos\195\169",
	resting =						"En repos",
}
BEB.LOCALIZED = {
	RestedSearchString =			"(%d+) exp (%S+) bonus",
	XpSearchString =				"succombe, vous gagnez (%d+) points d'exp\195\169rience.",
}
end