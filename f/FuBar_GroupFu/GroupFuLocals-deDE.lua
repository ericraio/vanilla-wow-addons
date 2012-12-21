function GroupFu_Locals_deDE()

GroupFuLocals = {

	NAME = "FuBar - GroupFu",
	DESCRIPTION = "Kombination aus Titan Loot Type und Roll.",
	
	DEFAULT_ICON = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",

	TEXT_SOLO = "Solo",
	TEXT_GROUP = "Gruppe",
	TEXT_FFA = "Jeder gegen Jeden",
	TEXT_MASTER = "Plündermeister",
	TEXT_NBG = "Bedarf vor Gier",
	TEXT_RR = "Reihum",
	TEXT_NOROLLS = "Keine Würfe",

	TEXT_ENDING10 = "Würfeln endet in 10 Sekunden",
	TEXT_ENDING5 = "Würfeln endet in 5",
	TEXT_ENDING4 = "Würfeln endet in 4",
	TEXT_ENDING3 = "Würfeln endet in 3",
	TEXT_ENDING2 = "Würfeln endet in 2",
	TEXT_ENDING1 = "Würfeln endet in 1",
	TEXT_ENDED = "Würfeln beendet, Gewinner wird angesagt.",
	
	SEARCH_MASTERLOOTER = "(.+) ist jetzt der Plündermeister.",
	SEARCH_ROLLS = "(.+) würfelt. Ergebnis: (%d+) %((%d+)%-(%d+)%)",
	
	FORMAT_ANNOUNCE_WIN = "Gewinner: %s mit einer [%d] aus %d Spielern.",
	FORMAT_TEXT_ROLLCOUNT = "%s (%d/%d)",
	FORMAT_TOOLTIP_ROLLCOUNT = "%d aus erwarteten %d würfen registriert",

	MENU_SHOWMLNAME = "Plündermeister Namen anzeigen",
	MENU_PERFORMROLL = "Durch Anklicken würfeln",
	MENU_SHOWROLLCOUNT = "Zeige Menge der Würfe kontra Spielern aus Raid/Gruppe",
	MENU_ANNOUNCEROLLCOUNTDOWN = "Kündige Count Down an und zeige dannach Gewinner",

	MENU_OUTPUT = "Anzeigeort der Ergebnisses",
	MENU_OUTPUT_AUTO = "Gewinner automatsich ausgeben = Raid, Gruppe, oder Solo",
	MENU_OUTPUT_LOCAL = "Im lokalen Fenster ausgeben",
	MENU_OUTPUT_SAY = "Im Sagen Kanal ausgeben",
	MENU_OUTPUT_PARTY = "Im Gruppen Kanal ausgeben",
	MENU_OUTPUT_RAID = "Im Raid Kanal ausgeben",
	MENU_OUTPUT_GUILD = "Im Gilden Kanal ausgeben",

	MENU_CLEAR = "Automatisches verwerfen der Würfe",
	MENU_CLEAR_NEVER = "Nie",
	MENU_CLEAR_15SEC = "15 Sekunden",
	MENU_CLEAR_30SEC = "30 Sekunden",
	MENU_CLEAR_45SEC = "45 Sekunden",
	MENU_CLEAR_60SEC = "60 Sekunden",

	MENU_DETAIL = "Ausgabe Details",
	MENU_DETAIL_SHORT = "Nur Gewinner anzeigen",
	MENU_DETAIL_LONG = "Alle Würfe anzeigen",
	MENU_DETAIL_FULL = "Alle Würfe und nicht Standard Würfe anzeigen",
	
	MENU_MODE = "Text Modus",
	MENU_MODE_GROUPFU = "GroupFu: Plündern Typ, außer es wurde schon gewürfelt, dann den Gewinner",
	MENU_MODE_ROLLSFU = "RollFu: Nicht würfeln, außer es wurde schon gewürfelt, dann den Gewinner",
	MENU_MODE_LOOTTYFU = "LootTyFu: Plündern Typ Immer",

	MENU_STANDARDROLLSONLY = "Nur Standard (1-100) Würfe akzeptieren",
	MENU_IGNOREDUPES = "Doppelte Würfe ignorieren",
	MENU_AUTODELETE = "Würfe nach Ausgabe automatisch löschen",
	MENU_SHOWCLASSLEVEL = "Klasse und Level im Tooltip anzeigen",
	
	MENU_GROUP = "Gruppen Funktionen",
	MENU_GROUP_LEAVE = "Gruppe verlassen",
	MENU_GROUP_RAID = "In Schlachtzug Gruppe umwandeln",
	MENU_GROUP_LOOT = "Plündern Methode ändern",
	MENU_GROUP_THRESHOLD = "Plündern Schwelle ändern",
	MENU_GROUP_RESETINSTANCE = "Instanz Resetten",
	
	TOOLTIP_CAT_LOOTING = "Plündern",
	TOOLTIP_CAT_ROLLS = "Würfe",
	TOOLTIP_METHOD = "Plündern Methode",
	TOOLTIP_HINT_ROLLS = "Anklicken zum würfeln, Ctrl-Klick um den Gewinner auszugeben, Shift-Klick um die Liste zu löschen",
	TOOLTIP_HINT_NOROLLS = "Ctrl-Klick um den Gewinner anzuzeigen, Shift-Klick um die Liste zu löschen",

	ENDDELOCALE = true
}

end