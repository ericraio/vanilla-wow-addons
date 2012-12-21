-- Translated by Gamefaq

local L = AceLibrary("AceLocale-2.0"):new("Detox")

L:RegisterTranslations("deDE", function() return {

	-- menu/options
	["Clean group"] = "Reinige Gruppe",
	["Will attempt to clean a player in your raid/party."] = "Wird versuchen, einen Spieler in Eurer Gruppe zu reinigen.",
	["Play sound if unit needs decursing"] = "Ton abspielen, wenn eine Einheit gereinigt werden muss",
	["Show detoxing in scrolling combat frame"] = "Zeige Reinigung im scrollenden Kampftext",
	["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."] = "SCT 5 wird benutzt, wenn vorhanden, ansonsten Blizzards scrollender Kampftext.",
	["Seconds to blacklist"] = "Sekunden auf der Blacklist",
	["Units that are out of Line of Sight will be blacklisted for the set duration."] = "Einheiten, die au\195\159er Sicht sind, werden f\195\188r die gesetzte Dauer ignoriert",
	["Max debuffs shown"] = "Max sichtbare Debuffs",
	["Defines the max number of debuffs to display in the live list."] = "Setzt die maximale Anzahl an Debuffs, die in der Live Liste angezeigt werden",
	["Update speed"] = "Update Geschwindigkeit",
	["Defines the speed the live list is updated, in seconds."] = "Setzt die Geschwindigkeit mit der die Live Liste aktualisiert wird, in Sekunden.",
	["Detaches the live list from the Detox icon."] = "L\195\182st die Live Liste vom Detox Symbol",
	["Show live list"] = "Zeige Live Liste",
	["Options for the live list."] = "Optionen f\195\188r die Live Liste",
	["Live list"] = "Live Liste",

	-- Filtering
	["Filter"] = "Filter",
	["Options for filtering various debuffs and conditions."] = "Optionen f\195\188rs filtern von verschiedenen Debuffs und Bedingungen.",
	["Debuff"] = "Debuff",
	["Filter by debuff and class."] = "Filtern durch Debuffs und Klasse.",
	["Classes to filter for: %s."] = "Klassen zum Filtern bei %s.",
	["Toggle filtering %s on %s."] = "Aktiviert Filterrung %s bei %s.",
	["Adds a new debuff to the class submenus."] = "F\195\188ge einen neuen Debuff zu dem Klassen Untermen\195\188.",
	["Add"] = "Hinzuf\195\188gen",
	["Removes a debuff from the class submenus."] = "Entfernt einen Debuff vom Klassen Untermen\195\188.",
	["Remove %s from the class submenus."] = "Entferne %s von dem Klassen Untermen\195\188.",
	["Remove"] = "Entferne",
	["<debuff name>"] = "<debuff name>",
	["Filter stealthed units"] = "Filtere getarnte Einheiten",
	["It is recommended not to cure stealthed units."] = "Es wird empfohlen, keine getarnten Einheiten zu reinigen.",
	["Filter Abolished units"] = "Filtere Einheiten die bereits 'Krankheit aufheben' als Buff haben",
	["Skip units that have an active Abolish buff."] = "Filtere Einheiten die bereits 'Krankheit aufheben' als Buff haben.",
	["Filter pets"] = "Begleiter Filtern",
	["Pets are also your friends."] = "Auch Begleiter sind Eure Freunde.",
	["Filter by type"] = "Nach Typ filtern",
	["Only show debuffs you can cure."] = "Nur Debuffs anzeigen, die du beseitigen kannst.",
	["Filter by range"] = "Nach Reichweite filtern",
	["Only show units in range."] = "Nur Einheiten in Reichweite anzeigen",

	-- Priority list
	["Priority"] = "Priorit\195\164t",
	["These units will be priorized when curing."] = "Diese Einheiten werden Priorisiert bei reinigen.",
	["Show priorities"] = "Zeige Priorit\195\164ten",
	["Displays who is prioritized in the live list."] = "Zeigt an wer Priorisiert in der Live Liste ist.",
	["Priorities"] = "Priorit\195\164ten",
	["Can't add/remove current target to priority list, it doesn't exist."] = "Kann aktuelles Ziel nicht zur Priorit\195\164tsliste hinzuf\195\188gen/entfernen, es existiert nicht.",
	["Can't add/remove current target to priority list, it's not in your raid."] = "Kann aktuelles Ziel nicht zur Priorit\195\164tsliste hinzuf\195\188gen/entfernen, es ist nicht in Eurem Schlachtzug.",
	["%s was added to the priority list."] = "%s wurde zu Eurer Priorit\195\164tsliste hinzugef\195\188gt.",
	["%s has been removed from the priority list."] = "%s wurde von Eurer Priorit\195\164tsliste entfernt.",
	["Nothing"] = "Nichts",
	["Prioritize %s."] = "Priorisiere %s.",
	["Every %s"] = "Jeden %s",
	["Prioritize every %s."] = "Priorisiere jeden %s.",
	["Groups"] = "Gruppen",
	["Prioritize by group."] = "Priorisiere durch Gruppen",
	["Group %s"] = "Gruppe %s",
	["Prioritize group %s."] = "Priorisiere Gruppe %s",
	["Class %s"] = "Klasse %s",

	-- bindings
	["Clean group"] = "Reinige Gruppe",
	["Toggle target priority"] = "Aktiviere Ziel Priorit\195\164t",
	["Toggle target class priority"] = "Aktiviere Ziel-Klassen Priorit\195\164t",
	["Toggle target group priority"] = "Aktiviere Ziel-Gruppen Priorit\195\164t",

	-- spells and potions
	["Dreamless Sleep"] = "Traumloser Schlaf",
	["Greater Dreamless Sleep"] = "Gro\195\159er Trank des traumlosen Schlafs",
	["Ancient Hysteria"] = "Uralte Hysterie",
	["Ignite Mana"] = "Mana entz\195\188nden",
	["Tainted Mind"] = "Verdorbene Gedanken",
	["Magma Shackles"] = "Magma Fesseln",
	["Cripple"] = "Verkr\195\188ppeln",
	["Frost Trap Aura"] = "Frostfallenaura",
	["Dust Cloud"] = "Staubwolke",
	["Widow's Embrace"] = "Umarmung der Witwe",
	["Curse of Tongues"] = "Fluch der Sprachen",
	["Sonic Burst"] = "Schallexplosion",
	["Thunderclap"] = "Donnerknall",
	["Delusions of Jin'do"] = "Fluch der Schatten",

	["Magic"] = "Magie",
	["Poison"] = "Gift",
	["Disease"] = "Krankheit",
	["Charm"] = "Verzauberung",
	["Curse"] = "Fluch",

	["Cleaned %s"] = "%s gereinigt",
	
	["Rank (%d+)"] = "Rang (%d+)"

} end)
