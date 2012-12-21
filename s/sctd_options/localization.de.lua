-- Version : German (by Gamefaq)
-- Last Update : 08/11/2006

if GetLocale() ~= "deDE" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "Nahkampfschaden", tooltipText = "Anzeige des Nahkampfschaden aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_EVENT102 = {name = "Periodischer Schaden", tooltipText = "Anzeige des periodischen Schadens aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_EVENT103 = {name = "Zauberschaden/Skills", tooltipText = "Anzeige des Zauberschadens / der Skills aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_EVENT104 = {name = "Tierschaden", tooltipText = "Anzeige des Tierschadens aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_EVENT105 = {name = "F\195\164rbe kritischer Treffer", tooltipText = "Anzeige deiner kritischen Treffer in der ausgew\195\164hlten Farbe aktivieren/deaktivieren"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "SCT - Damage aktivieren", tooltipText = "Aktiviert oder Deaktiviert SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "Kampftext markieren", tooltipText = "Legt fest, ob Kampftexte in * gesetzt werden sollen"};
SCT.LOCALS.OPTION_CHECK103 = { name = "Zaubertyp", tooltipText = "Anzeige des Zaubertyps aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_CHECK104 = { name = "Zauber/Skillname", tooltipText = "Anzeige des Namens von Zaubern/Skills aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_CHECK105 = { name = "Widerstehen", tooltipText = "Anzeige des widerstandenen Schadens aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_CHECK106 = { name = "Name des Ziels", tooltipText = "Name des Ziels aktivieren/deaktivieren"};
SCT.LOCALS.OPTION_CHECK107 = { name = "Schaden von WoW deaktivieren", tooltipText = "Den in WoW integrierten Schaden aktivieren/deaktivieren.\n\nANMERKUNG: Bewirkt das gleiche wie in den Interface-Optionen. Allerdings hat man hier eine gr\195\182\195\159ere Kontrolle."};
SCT.LOCALS.OPTION_CHECK108 = { name = "Nur f\195\188r Ziel", tooltipText = "Zeigt nur den Schaden an der auf dein gegenw\195\164rtiges Ziel ausge\195\188bt wird. AE Effekte werden nicht angezeigt, es sei denn die Ziele haben den gleichen Namen."};
SCT.LOCALS.OPTION_CHECK109 = { name = "Anzeige f\195\188r PvP aktivieren", tooltipText = "Aktiviert WoW eigene Schadensanzeige und deaktiviert SCTD w\195\164hrend PVP. Sollte nicht n\195\188tzlich auf PVP Servern sein."};
SCT.LOCALS.OPTION_CHECK110 = { name = "Benutze SCT Animationen", tooltipText = "Aktivierung benutzt SCT f\195\188r Schadensanzeigen. Wenn aktiviert, WERDEN ALLE EINSTELLUNGEN VON SCT \195\188BERNOMMEN. Bitte benutze nur SCT f\195\188r das einstellen des Textes wie du ihn haben m”chtest."};
SCT.LOCALS.OPTION_CHECK111 = { name = "Stehende Crits", tooltipText = "Bei aktivierung werden die Crittexte gr\195\182\195\159er dargetsellt und nicht scrollen sondern eine weile sichtbar stehn bleiben. Wenn aus, werden Crits wie folgt dargestellt +1236+ usw..."};
SCT.LOCALS.OPTION_CHECK112 = { name = "Zauberfarben", tooltipText = "Aktiviert/Deaktiviert das Anzeigen des Zauberschadens in Farbe der entsprechenden Klasse (Farben sind NICHT einstellbar)"};
SCT.LOCALS.OPTION_CHECK113 = { name = "Textscrollrichtung", tooltipText = "L\195\164st den Text nach unten scrollen"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="Position X-Achse", minText="-600", maxText="600", tooltipText = "Den Text in der X-Achse verschieben"};
SCT.LOCALS.OPTION_SLIDER102 = { name="Position Y-Achse", minText="-400", maxText="400", tooltipText = "Den Text in der Y-Achse verschieben"};
SCT.LOCALS.OPTION_SLIDER103 = { name="Ausblenden-Geschwindigkeit", minText="Schneller", maxText="Langsamer", tooltipText = "Bestimmt die Geschwindigkeit, mit der Nachrichten ausgeblendet werden"};
SCT.LOCALS.OPTION_SLIDER104 = { name="Schriftgr\195\182\195\159e", minText="Kleiner", maxText="Gr\195\182\195\159er", tooltipText = "Bestimmt die Schriftgr\195\182\195\159e"};
SCT.LOCALS.OPTION_SLIDER105 = { name="Transparenz", minText="0%", maxText="100%", tooltipText = "Bestimmt die Transparenz des Testes"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD Optionen "..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="Schlie\195\159en", tooltipText = "Einstellungen speichern und schlie\195\159en"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "SCT - Damage Einstellungen \195\182ffnen"};
SCT.LOCALS.OPTION_MISC104 = {name="Schadens Ereignisse", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="Anzeige Optionen", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="Fenster Optionen", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="Schriftart f\195\188r Schaden", tooltipText = "Welche Schriftart soll f\195\188r den Schaden verwendet werden?", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION102 = { name="Rand um Schrifart", tooltipText = "Welche Art Rand soll um die Schriftart verwendet werden?", table = {[1] = "Kein",[2] = "D\195\188nn",[3] = "Dick"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="Schadens Animations Typ", tooltipText = "Welchen Animations Typ benutzen? Es ist SEHR zu empfehlen hier einen anderen Animations Typ zu benutzen als man mit SCT benutzt.", table = {[1] = "Vertical (Normal)",[2] = "Regenbogen",[3] = "Horizontal",[4] = "Im Winkel runter",[5] = "Im Winkel hoch",[6] = "Zuf\195\164llig"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="Schadens Seiten Style", tooltipText = "Wie soll der zu Seite scrollende Text dargestellt werden?", table = {[1] = "Abwechselnt",[2] = "Schaden Links",[3] = "Schaden Rechts", [4] = "Alles Links", [5] = "Alles Rechts"}};
