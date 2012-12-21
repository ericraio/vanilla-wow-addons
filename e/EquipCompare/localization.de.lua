-- Version : German
-- Maintained by StarDust
-- (First version by Maischter, zerra)
-- Last Update : 06/17/2005

if (GetLocale() == "deDE") then
	-- "Bonus" inventory types
	-- WARNING: these lines must match the text displayed by the client exactly.
	-- Can't use arbitrary phrases. Edit and translate with care.
	EQUIPCOMPARE_INVTYPE_WAND		= "Zauberstab";
	EQUIPCOMPARE_INVTYPE_GUN		= "Schusswaffe";
	EQUIPCOMPARE_INVTYPE_GUNPROJECTILE	= "Projektil Kugel";
	EQUIPCOMPARE_INVTYPE_BOWPROJECTILE	= "Projektil Pfeil";
	EQUIPCOMPARE_INVTYPE_CROSSBOW		= "Armbrust";
	EQUIPCOMPARE_INVTYPE_THROWN		= "Geworfen";

	-- Usage text
	EQUIPCOMPARE_USAGE_TEXT =		{ "Ausr\195\188stungsVergleich  "..EQUIPCOMPARE_VERSIONID.." Benutzung:",
						"Gehe mit dem Mauszeiger \195\188ber Gegenst\195\164nde, um jene mit anderen zu vergleichen.",
						"Slash Befehle:",
						"/eqc          - Ausr\195\188stungsVergleich aktivieren/deaktivieren",
						"/eqc [on|off] - Ausr\195\188stungsVergleich ein|aus",
						"/eqc control  - Umschalten des STRG-Tastenmodus ein/aus",
						"/eqc cv       - Integration mit CharakterAnzeiger ein/aus",
						"/eqc alt      - Umschalten des ALT-Tastenmodus ein/aus",
						"/eqc shift    - Tooltip nach oben verschieben wenn zu hoch ein/aus",
						"/eqc help     - dieser Hilfetext",
						"(Aufrufbar mit /equipcompare oder /eqc)" }

	-- Feedback text
	EQUIPCOMPARE_HELPTIP			= "(Gib /equipcompare ein um eine Hilfe anzuzeigen.)";
	EQUIPCOMPARE_TOGGLE_ON			= "Ausr\195\188stungsVergleich aktiviert.";
	EQUIPCOMPARE_TOGGLE_OFF			= "Ausr\195\188stungsVergleich deaktiviert.";
	EQUIPCOMPARE_TOGGLECONTROL_ON		= "Ausr\195\188stungsVergleich STRG-Modus aktiviert.";
	EQUIPCOMPARE_TOGGLECONTROL_OFF		= "Ausr\195\188stungsVergleich STRG-Modus deaktiviert.";
	EQUIPCOMPARE_TOGGLECV_ON		= "Ausr\195\188stungsVergleich Integration mit CharakterAnzeiger aktiviert.";
	EQUIPCOMPARE_TOGGLECV_OFF		= "Ausr\195\188stungsVergleich Integration mit CharakterAnzeiger deaktiviert.";
	EQUIPCOMPARE_TOGGLEALT_ON		= "Ausr\195\188stungsVergleich ALT-Modus aktiviert.";
	EQUIPCOMPARE_TOGGLEALT_OFF		= "Ausr\195\188stungsVergleich ALT-Modus deaktiviert.";
	EQUIPCOMPARE_SHIFTUP_ON			= "Ausr\195\188stungsVergleich Tooltip nach oben verschieben.";
	EQUIPCOMPARE_SHIFTUP_OFF		= "Ausr\195\188stungsVergleich Tooltip nicht nach oben verschieben.";

	-- Cosmos configuration texts
	EQUIPCOMPARE_COSMOS_SECTION		= "Ausr\195\188stungs Vergleich";
	EQUIPCOMPARE_COSMOS_SECTION_INFO	= "Optionen f\195\188r die Ausr\195\188stungsVergleich Tooltips.";
	EQUIPCOMPARE_COSMOS_HEADER		= "Ausr\195\188stungsVergleich "..EQUIPCOMPARE_VERSIONID;
	EQUIPCOMPARE_COSMOS_HEADER_INFO		= "Optionen f\195\188r die Ausr\195\188stungsVergleich Tooltips.";
	EQUIPCOMPARE_COSMOS_ENABLE		= "Ausr\195\188stungsVergleich Tooltips aktivieren";
	EQUIPCOMPARE_COSMOS_ENABLE_INFO		= "Wenn aktiviert, werden die zus\195\164tzliche Tooltips vom Ausr\195\188stungsVergleich aktiviert, "..
						  "wenn du den Mauszeiger \195\188ber einen Gegenstand bewegst.";
	EQUIPCOMPARE_COSMOS_CONTROLMODE		= "STRG Tastenmodus aktivieren";
	EQUIPCOMPARE_COSMOS_CONTROLMODE_INFO	= "Wenn aktiviert, werden die zus\195\164tzlichen Tooltips nur angezeigt wenn die "..
						  "STRG Taste gedr\195\188ckt wird w\195\164hrend der Mauszeiger \195\188ber einen Gegenstand bewegt wird.";
	EQUIPCOMPARE_COSMOS_CVMODE		= "Integration mit CharakterAnzeiger aktivieren (wenn installiert)";
	EQUIPCOMPARE_COSMOS_CVMODE_INFO		= "Wenn aktiviert, zeigt der Tooltip des Ausr\195\188stungsVergleich nicht den Vegleich des "..
						  "eigenen Charakters sondern von jenem der momentan im CharakterAnzeiger ausgew\195\164hlt ist.";
	EQUIPCOMPARE_COSMOS_ALTMODE		= "ALT Tastenmodus f\195\188r CharakterAnzeiger aktivieren";
	EQUIPCOMPARE_COSMOS_ALTMODE_INFO	= "Wenn aktiviert, werden die zus\195\164tzlichen Tooltips nur angezeigt wenn die "..
						  "ALT Taste gedr\195\188ckt wird w\195\164hrend der Mauszeiger \195\188ber einen Gegenstand bewegt wird.";
	EQUIPCOMPARE_COSMOS_SHIFTUP		= "Verleich-Tooltip nach oben verschieben wenn zu hoch"
	EQUIPCOMPARE_COSMOS_SHIFTUP_INFO	= "Wenn aktiviert, wird der Vergleich-Tooltip nach oben verschoben, wenn dessen unterer Rand unter jenen "..
						  "des Haupt-Tooltips reichen w\195\188rde... somit schlie\195\159en beide unten b\195\188ndig ab.";
	EQUIPCOMPARE_COSMOS_SLASH_DESC		= "Erlaubt es den Ausr\195\188stungsVergleich an oder auszuschalten. "..
						  "Gib /equipcompare f\195\188r HILFE ein."

	-- Misc labels
	EQUIPCOMPARE_EQUIPPED_LABEL		= "Momentan angelegt:";
	EQUIPCOMPARE_GREETING			= "Ausr\195\188stungsVergleich "..EQUIPCOMPARE_VERSIONID.." geladen. Viel Spa\195\159.";
end