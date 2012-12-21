-- 
-- German Localisation for MobInfo
--
-- created by Skeeve
--

if ( GetLocale() == "deDE" ) then

MI_DESCRIPTION = "Erweitert den Tooltip um Gegnerinformationen und erg\195\164nzt das Zielfenster um Gesundheit/Mana";

MI_MOB_DIES_WITH_XP = "(.+) stirbt, Ihr bekommt (%d+) Erfahrung"
MI_MOB_DIES_WITHOUT_XP = "(.+) stirbt"
MI_PARSE_SPELL_DMG = "(.+)s (.+) trifft Euch f\195\188r (%d+) (.+) Schaden"
MI_PARSE_BOW_DMG = "(.+) trifft Euch %(mit (.+)%). Schaden: (%d+)"
MI_PARSE_COMBAT_DMG = "(.+) trifft Euch f\195\188r (%d+) Schaden"
MI_PARSE_SELF_MELEE = "Ihr trefft (.+). Schaden: (%d+)"
MI_PARSE_SELF_MELEE_CRIT = "Ihr trefft (.+) kritisch f\195\188r (%d+) Schaden"
MI_PARSE_SELF_SPELL = "Euer (.+) trifft (.+). Schaden: (%d+)"
MI_PARSE_SELF_SPELL_CRIT = "Euer (.+) trifft (.+) kritisch. Schaden: (%d+)";
MI_PARSE_SELF_SPELL_PERIODIC = "(.+) erleidet (%d+) (.+)schaden %(durch (.+)%)"
MI_PARSE_SELF_BOW = "(.+) von Euch trifft (.+) f\195\188r (%d+) Schaden"
MI_PARSE_SELF_BOW_CRIT = "(.+) von Euch trifft (.+) kritisch. Schaden: (%d+)"
MI_PARSE_SELF_PET = "(.+) trifft (.+) f\195\188r (%d+) Schaden"
MI_PARSE_SELF_PET_SPELL = "(%a+)s (.+) trifft (.+) f\195\188r (%d+)"

MI_TXT_GOLD   = " Gold";
MI_TXT_SILVER = " Silber";
MI_TXT_COPPER = " Kupfer";

MI_TXT_CONFIG_TITLE		= "MobInfo 2  Optionen"
MI_TXT_WELCOME			= "Wilkommen bei MobInfo 2"
MI_TXT_OPEN				= "\195\150ffnen"
MI_TXT_CLASS			= "Klasse "
MI_TXT_HEALTH			= "Lebenspunkte "
MI_TXT_MANA				= "Mana "
MI_TXT_XP				= "XP "
MI_TXT_KILLS			= "Get\195\182tet "
MI_TXT_DAMAGE			= "Schaden + [DPS] "
MI_TXT_TIMES_LOOTED		= "Gepl\195\188ndert "
MI_TXT_EMPTY_LOOTS		= "Leere Loots "
MI_TXT_TO_LEVEL			= "# bis Level "
MI_TXT_QUALITY			= "Qualit\195\164t "
MI_TXT_CLOTH_DROP		= "Stoff erhalten "
MI_TXT_COIN_DROP		= "Geld (delta)"
MI_TEXT_ITEM_VALUE		= "Wert Items  (delta) "
MI_TXT_MOB_VALUE		= "Gesamtwert (delta) "
MI_TXT_COMBINED			= "Zusammengefasst: "
MI_TXT_MOB_DB_SIZE		= "MobInfo Datenbank Gr\195\182\195\159e:  "
MI_TXT_HEALTH_DB_SIZE	= "Mob HP Datenbank Gr\195\182\195\159e:  "
MI_TXT_PLAYER_DB_SIZE	= "Spieler HP Datenbank Gr\195\182\195\159e:  "
MI_TXT_ITEM_DB_SIZE		= "Gegenst\195\164nde Datenbank Gr\195\182\195\159e:  "
MI_TXT_CUR_TARGET		= "Aktuelles Ziel: "
MI_TXT_MH_DISABLED		= "MobInfo WARNUNG: Separates MobHealth AddOn gefunden. Die interne MobHealth Funktionalit\195\164t ist deaktiviert bis das separate MobHealth AddOn entfernt wird."
MI_TXT_MH_DISABLED2		= (MI_TXT_MH_DISABLED.."\n\nEs gehen KEINE Daten verloren wenn das separate MobHealth deaktiviert wird.\n\nVorteile des Entfernens: Gesundheit und Mana Anzeige, optional mit Prozentangabe, Font und Gr\195\150\195\159e einstellbar.")
MI_TXT_CLR_ALL_CONFIRM	= "M\195\182chten Sie wirklich die folgende L\195\182schoperation durchf\195\188hren: "
MI_TXT_SEARCH_LEVEL		= "Mob Level:"
MI_TXT_SEARCH_MOBTYPE	= "Mob Typ:"
MI_TXT_SEARCH_LOOTS		= "Mob Looted:"
MI_TXT_TRIM_DOWN_CONFIRM = "ACHTUNG: Das L\195\182schen ist unwiederruflich. Wollen Sie wirklich alle nicht zum Speichern ausgew\195\164hlten Mob Daten l\195\182schen ?."
MI_TXT_CLAM_MEAT		= "uschelfleisch"
MI_TXT_SHOWING			= "Liste Zeigt: "
MI_TXT_DROPPED_BY		= "Beute von: "
BINDING_NAME_MI2CONFIG	= "MobInfo2 Optionen \195\150ffnen"
MI_TXT_DEL_SEARCH_CONFIRM = "M\195\182chten Sie wirklich alle %d Mobs in der Suchergebnisliste aus der MobInfo Datenbank L\195\182SCHEN ?"

MI2_FRAME_TEXTS["MI2_FrmTooltipOptions"]	= "Mob Tooltip Inhalt"
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]		= "MobHealth Optionen"
MI2_FRAME_TEXTS["MI2_FrmDatabaseOptions"]	= "Databank Optionen"
MI2_FRAME_TEXTS["MI2_FrmHealthValueOptions"]= "Gesundheitswert"
MI2_FRAME_TEXTS["MI2_FrmManaValueOptions"]	= "Manawert"
MI2_FRAME_TEXTS["MI2_FrmSearchOptions"]		= "Search Options"
MI2_FRAME_TEXTS["MI2_FrmImportDatabase"]	= "Externe MobInfo Datenbank Importieren"


--
-- This section defines all buttons in the options dialog
--   text : the text displayed on the button
--   cmnd : the command which is executed when clicking the button
--   help : the (short) one line help text for the button
--   info : additional multi line info text for button
--      info is displayed in the help tooltip below the "help" line
--      info is optional and can be omitted if not required
--

MI2_OPTIONS["MI2_OptSearchMinLevel"] = 
{ text = "Min"; help = "Minimaler mob level f\195\188r Suche"; }

MI2_OPTIONS["MI2_OptSearchMaxLevel"] = 
{ text = "Max"; help = "Maximaler mob level f\195\188r Suche (muss < 66 sein)"; }

MI2_OPTIONS["MI2_OptSearchNormal"] = 
{ text = "Normal"; help = "Normale Mobs in Suchergebnis aufnehmen"; }

MI2_OPTIONS["MI2_OptSearchElite"] = 
{ text = "Elite"; help = "Elite Mobs in Suchergebnis aufnehmen"; }

MI2_OPTIONS["MI2_OptSearchBoss"] = 
{ text = "Boss"; help = "Boss Mobs in Suchergebnis aufnehmen"; }

MI2_OPTIONS["MI2_OptSearchMinLoots"] = 
{ text = "Min"; help = "Minimale Anzahl gelooted f\195\188r Suche"; }

MI2_OPTIONS["MI2_OptSearchMobName"] = 
{ text = "Mob Name"; help = "teilweiser oder vollst\195\164ndiger Mob Name f\195\188r Suche";
info = 'Feld leer lassen um nicht nach Namen zu suchen'; }

MI2_OPTIONS["MI2_OptSearchItemName"] = 
{ text = "Item Name"; help = "Teilweiser oder vollst\195\164ndiger Gegenstandsname f\195\188r Suche";
info = 'Feld leer lassen um Suche nicht auf Gegenst\195\164nden einzuschr\195\164nken.\n"*" eingeben um alle Gegenst\195\164nde auszuw\195\164hlen.'; }

MI2_OPTIONS["MI2_OptSortByValue"] = 
{ text = "Sortiere: Profit"; help = "Sortieren des Suchergebnis nach Mob Profit";
info = 'Sortiert die Mobs im Suchergebnis danach, welchen Profit sie abwerfen.'; }

MI2_OPTIONS["MI2_OptSortByItem"] = 
{ text = "Sortiere: Anzahl Items"; help = "Sortieren des Suchergebnis nach Anzahl Items";
info = 'Sortiert die Mobs im Suchergebnis danach, wieviele der angegebenen Items sie abwerfen.'; }

MI2_OPTIONS["MI2_OptItemTooltip"] = 
{ text = "Mobs im Item Tooltip auflisten"; help = "Im Tooltip zu Items die Mobs auflisten, die den Gegenstand droppen.";
info = "Aufgelistet wird jeweils der Name des Mobs und die Anzahl der Drops." }

MI2_OPTIONS["MI2_OptCompactMode"] = 
{ text = "Kompakter Mob Tooltip"; help = "Aktiviert ein kompaktes Mob Tooltip Layout mit 2 Werten pro Zeile";
info = "Der kompakte Tooltip verwendet besondere Kurzbezeichnungen f\195\188r die einzelnen Werte.\nUm eine Zeile nicht anzuzeigen m\195\188ssen beide Werte der Zeile deaktiviert werden." }

MI2_OPTIONS["MI2_OptDisableMobInfo"] = 
{ text = "Deaktiviere Tooltip Info"; help = "Deaktiviert das Darstellen von Mob Infos in den Tooltips";
info = "Diese Option deaktiviert das Hinzuf\195\188gen von Informationen\nzu Mob Tooltip und Item Tooltip" }

MI2_OPTIONS["MI2_OptShowClass"] = 
{ text = "Klasse anzeigen"; help = "Klasseninfo zum Gegner"; }

MI2_OPTIONS["MI2_OptShowHealth"] = 
{ text = "Leben"; help = "Lebenspunkte des Gegners (aktuell/max)"; }

MI2_OPTIONS["MI2_OptShowMana"] = 
{ text = "Mana"; help = "Mana / Energie / Wut des Gegners (aktuell/max)"; }

MI2_OPTIONS["MI2_OptShowXp"] = 
{ text = "Erfahrung"; help = "Die zuletzt vom Gegner erhaltenen Erfahrungspunkte";
info = "Entspricht exakt den bei letzten Kill von diesem\nGegner erhaltenen Erfahrungspunkte\n(wird nicht f\195\188r graue Gegner angezeigt)" }

MI2_OPTIONS["MI2_OptShowNo2lev"] = 
{ text = "Anzahl bis Level"; help = "Anzahl zu t\195\182tender Gegner bis Levelaufstieg";
info = "Zeigt, wie oft dieser Gegner get\195\182tet werden m\195\188sste,\num im Level aufzusteigen\n(wird nicht f\195\188r graue Gegner angezeigt)" }

MI2_OPTIONS["MI2_OptShowDamage"] = 
{ text = "Mob Schaden und DPS"; help = "Schadensbereich des Gegner (Min/Max) und DPS (Damage Pro Sekunde)"; 
info = "Schadensbereich und DPS werden pro Char separat berechnet.\nDPS langsam aber stetig mit jedem Kampf aktualisiert" }
    
MI2_OPTIONS["MI2_OptShowCombined"] = 
{ text = "Zusammengefasst Info"; help = "Zusammengefasste Level im Tooltip anzeigen";
info = "Zeigt an, welche Mob Level zusammengefasst wurden.\nKann nur angezeigt werden wenn zusammenfassen aktiviert ist." }

MI2_OPTIONS["MI2_OptShowKills"] = 
{ text = "Get\195\182tet"; help = "Wie oft Du diesen Gegner get\195\182tet hast";
info = "Anzahl get\195\182tet wird pro Char separat gez\195\164hlt." }

MI2_OPTIONS["MI2_OptShowLoots"] = 
{ text = "Gepl\195\188ndert"; help = "Wie oft Du diesen Gegner gepl\195\188ndert hast"; }

MI2_OPTIONS["MI2_OptShowCloth"] = 
{ text = "Stoffz\195\164hler"; help = "Wie oft der Gegner Stoff als Beute gegeben hat"; }

MI2_OPTIONS["MI2_OptShowEmpty"] = 
{ text = "Leere Loots"; help = "Die leeren Loots f\195\188r diesen Gegner (Anzahl/Prozent)";
info = "Wird hochgez\195\164hlt wenn das Pl\195\188nderfenster des\nget\195\182teten Gegners leer ist." }

MI2_OPTIONS["MI2_OptShowTotal"] = 
{ text = "Gesamtwert"; help = "Gemittelter Gesamtwert des Gegners (Geld+Gegenst\195\164nde)";
info = "Dies ist die Summe aus gemitteltem Geldwert und\n gemitteltem Gegenstandswert." }

MI2_OPTIONS["MI2_OptShowCoin"] = 
{ text = "Geldwert"; help = "Geldmenge die dieser Gegner im Mittel als Beute gibt";
info = "Die Gesamtgeldbeute wird pro Gegner aufaddiert und\ndurch die Anzahl gepl\195\188ndert dividiert\n(wird nicht angezeigt wenn 0)" }

MI2_OPTIONS["MI2_OptShowIV"] = 
{ text = "Gegenstandswert"; help = "Gemittelter Wert der Beute Gegenst\195\164nde dieses Gegners";
info = "Der Wert aller Beute Gegenst\195\164nde wird pro Gegner \naufaddiert und durch die Anzahl gepl\195\188ndert dividiert\n(wird nicht angezeigt wenn 0)" }

MI2_OPTIONS["MI2_OptShowQuality"] = 
{ text = "Loot Qualit\195\164ts\195\188bersicht"; help = "Qualit\195\164t der von diesem Gegner erhaltenen Gegenst\195\164nde";
info = "Z\195\164hlt separat die erhaltenen Gegenst\195\164nde f\195\188r jede der\n5 Qualit\195\164tsstufen. Stufen ohne Gegenst\195\164nde werden nicht\nangezeigt. Die Prozentangabe entspricht der Wahrscheinlichkeit,\n als Loot einen Gegenstand der entsprechenden Kategorie zu erhalten.\n" }

MI2_OPTIONS["MI2_OptShowLocation"] = 
{ text = "Mob Fundort"; help = "Ort anzeigen, an dem der Mob zuletzt gesehen wurde";
info = "Die Speicherung von Mob Aufenthaltsorten MUSS aktiviert sein"; }

MI2_OPTIONS["MI2_OptShowItems"] = 
{ text = "Normale Loot Gegenst\195\164nde"; help = "Namen und Mengen der normalen Loot Gegenst\195\164nde anzeigen";
info = "Normale Loot Gegenst\195\164nde sind alle Gegenst\195\164nde ausser Stoff und K\195\188rschnerei Loot.\nDie Speicherung von Loot Gegenst\195\164nde MUSS aktiviert sein"; }

MI2_OPTIONS["MI2_OptShowClothSkin"] = 
{ text = "Stoff und K\195\188rschnerei Loot"; help = "Namen und Mengen zu Stoff und K\195\188rschnerei Loot anzeigen";
info = "Die Speicherung von Loot Gegenst\195\164nde MUSS aktiviert sein"; }

MI2_OPTIONS["MI2_OptShowBlankLines"] = 
{ text = "Leerzeilen anzeigen"; help = "Im Tooltip leere Trennzeilen anzeigen";
info = "Leere Trennzeilen sollen die Lesbarkeit des Tooltips erh\195\182hen." }

MI2_OPTIONS["MI2_OptCombinedMode"] = 
{ text = "Gleiche Mobs Zusammenfassen"; help = "Zusammenfassen der Daten f\195\188r Gegner gleichen Namens";
info = "Die Daten von Gegner die sich nur im Level unterscheiden\n werden kombiniert und gemeinsam angezeigt. Ein entsprechender\nHinweis erscheint im Tooltip." }

MI2_OPTIONS["MI2_OptKeypressMode"] = 
{ text = "MobInfo nur wenn ALT gedr\195\188ckt"; help = "Gegnerinfo nur bei gedr\195\188ckter ALT Taste im Tooltip"; }

MI2_OPTIONS["MI2_OptItemFilter"] = 
{ text = "Loot Item Filter"; help = "Setzen des Filtertext für Loot Item Anzeige in Tooltips.";
info = "Zeigt nur die Loot Items im Tooltip, deren Name den Filtertext\nenth\195\164lt. Wird z.B. 'Stoff' eingegeben so werden nur die\nLoot Items angezeigt, deren Name 'Stoff' enth\195\164lt.\nBei leerem Filtertext werden immer alle Loot Items angezeigt." }

MI2_OPTIONS["MI2_OptSavePlayerHp"] = 
{ text = "Gesundheitswerte von Spielern permanent speichern"; help = "Permanente Speicherung der Gesundheitswerte anderer Spieler aus PvP K\195\164mpfen";
info = "Normalerweise werden die Gesundheitswerte anderer Spieler nach Beendigugn einer\nSession gel\195\182scht. Diese Option aktiviert die permanente Speicherung dieser Daten." }

MI2_OPTIONS["MI2_OptStableMax"] = 
{ text = "Stabiles Gesundheitsmaximum"; help = "Das Gesundheitsmaximum im Zielportr\195\164t bleibt stabil";
info = "When aktiviert wird die Anzeige des Gesundheitsmaximum\nw\195\164rend eines Kampfes nicht ver\195\164ndert, obwohl die Berechnung weiterl\195\164uft."; }

MI2_OPTIONS["MI2_OptAllOn"] = 
{ text = "Alles ein"; help = "Schaltet alle Tooltip Infos ein"; }

MI2_OPTIONS["MI2_OptAllOff"] = 
{ text = "Alles Aus"; help = "Schaltet alle Tooltip Infos aus"; }

MI2_OPTIONS["MI2_OptMinimal"] = 
{ text = "Minimal"; help = "Zeigt nur minimale Tolltip Infos"; }

MI2_OPTIONS["MI2_OptDefault"] = 
{ text = "Default"; help = "Zeigt eine typische Auswahl n\195\188tzlicher Tooltip Infos"; }

MI2_OPTIONS["MI2_OptBtnDone"] = 
{ text = "Fertig"; help = "MobInfo Optionsfenster schliessen";}

MI2_OPTIONS["MI2_OptTargetHealth"] = 
{ text = "Wert anzeigen"; help = "Anzeigen des Gesundheitswertes im Zielfenster"; }

MI2_OPTIONS["MI2_OptTargetMana"] = 
{ text = "Wert anzeigen"; help = "Anzeigen des Manawertes im Zielfenster"; }

MI2_OPTIONS["MI2_OptHealthPercent"] = 
{ text = "Prozent anzeigen"; help = "Prozenzangabe zum Gesundheitswert hinzuf\195\188gen"; }

MI2_OPTIONS["MI2_OptManaPercent"] = 
{ text = "Prozent anzeigen"; help = "Prozenzangabe zum Manawert hinzuf\195\188gen"; }

MI2_OPTIONS["MI2_OptHealthPosX"] = 
{ text = "Horizontale Position"; help = "Einstellen der horizontalen Position des Gesundheitswertes"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
{ text = "Vertikale Position"; help = "Einstellen der vertikalen Position des Gesundheitswertes"; }

MI2_OPTIONS["MI2_OptManaPosX"] = 
{ text = "Horizontale Position"; help = "Einstellen der horizontalen Position des Manawertes"; }

MI2_OPTIONS["MI2_OptManaPosY"] = 
{ text = "Vertikale Position"; help = "Einstellen der vertikalen Position des Manawertes"; }

MI2_OPTIONS["MI2_OptTargetFont"] = 
{ text = "Schriftart"; help = "Schriftart f\195\188r Darstellung des Gesundheits- und Manawertes";
	  choice1 = "NumberFont"; choice2 = "GameFont"; choice3 = "ItemTextFont" }

MI2_OPTIONS["MI2_OptTargetFontSize"] = 
{ text = "Schriftgr\195\182\195\159e"; help = "Schriftgr\195\182\195\159e f\195\188r Darstellung des Gesundheits- und Manawertes"; }

MI2_OPTIONS["MI2_OptClearTarget"] = 
{ text = "Ziel Daten L\195\182schen"; help = "Alle Daten zum aktuellen Ziel aus den Datenbanken l\195\182schen"; }

MI2_OPTIONS["MI2_OptClearMobDb"] = 
{ text = "Datenbank L\195\182schen"; help = "Inhalt der Mob Info Datenbank vollst\195\164ndig l\195\182schen"; }

MI2_OPTIONS["MI2_OptClearHealthDb"] = 
{ text = "Datenbank L\195\182schen"; help = "Inhalt der Mob HP Datenbank vollst\195\164ndig l\195\182schen"; }

MI2_OPTIONS["MI2_OptClearPlayerDb"] = 
{ text = "Datenbank L\195\182schen"; help = "Inhalt der Spieler HP Datenbank vollst\195\164ndig l\195\182schen"; }

MI2_OPTIONS["MI2_OptSaveItems"] = 
{ text = "Daten zu Loot Gegenst\195\164nde speichern :"; help = "Speichern detailierte Daten zu den gelooteten Gegenst\195\164nde";
info = "Du kannst die Qualit\195\164t der zu speichernden Gegenst\195\164nde ausw\195\164hlen."; }

MI2_OPTIONS["MI2_OptSaveBasicInfo"] = 
{ text = "Speichern der Basis Mob Daten"; help = "Speichern grundlegender Informationen zu allen Mobs.";
info = "Beinhaltet: XP, Mob Typ, Z\195\164hler f\195\188r: Loots, leere Loots, Stoff, Geld, Gegenstandswert"; }

MI2_OPTIONS["MI2_OptSaveCharData"] = 
{ text = "Speichern aller Spielerbezogenen Mob Daten"; help = "Speichern aller auf die Spielfigur bezogenen Mob Daten.";
info = "Aktiviert die Speicherung der folgenden Daten:\nAnzahl get\195\182tet, min/max Schaden, DPS (Schaden pro Sekunde)\n\nDiese Daten werden pro Spielfigur gespeichert und k\195\182nnen nur\ngemeinsam ein/ausgeschaltet werden."; }

MI2_OPTIONS["MI2_OptSaveLocation"] = 
{ text = "Speichern der Daten zum Mob Fundort"; help = "Speichert pro Mobs die Gegend und die Koordinaten des Fundortes." }

MI2_OPTIONS["MI2_OptItemsQuality"] = 
{ text = ""; help = "Speichern der Loot Details f\195\188r diese und Bessere Gegenst\195\164nde.";
choice1 = "Grau & Besser"; choice2 = "Weis & Besser"; choice3 = "Gr\195\188n & Besser";  }

MI2_OPTIONS["MI2_OptTrimDownMobData"] = 
{ text = "Mob Datenbank Minimieren"; help = "Minimiert die Gr\195\182\195\159e der Mob Datenbank durch L\195\182schen unn\195\182tiger Daten.";
info = "Als unn\195\182tige Daten gelten alle Mob Daten die nicht zum Speichern ausgew\195\164hlt sind."; }

MI2_OPTIONS["MI2_OptImportMobData"] = 
{ text = "Import Starten"; help = "Importieren einer externen Mob Datenbank in die eigene Mob Datenbank";
info = "WICHTIG: vorher die Anleitung zum Import lesen !\nVorher UNBEDINGT die eigene Datenbank sichern !"; }

MI2_OPTIONS["MI2_OptDeleteSearch"] = 
{ text = "L\195\182SCHEN"; help = "L\195\182scht aller Mobs der Suchergebnisliste aus der MobInfo Datenbank";
info = "ACHTUNG: Diese Operation l\195\164sst sich nicht r\195\188ckg\195\164ngig machen.\nBitte mit Vorsich verwenden\nVor dem L\195\182\195\159schen empfiehlt sich ein Backup der MobInfo Datenbank"; }

MI2_OPTIONS["MI2_OptImportOnlyNew"] = 
{ text = "Nur neue Mobs Importieren"; help = "Importiere nur Mobs die es in der eigenen Datenbank noch nicht gibt";
info = "Durch aktivieren dieser Option wir verhindert, dass die Daten\nexistierender Mobs ver\195\164ndert werden. Nur unbekannte Mobs werden\nimportiert. Diese Option erm\195\182glicht das problemlose importieren\nvon teilweise gleichen Datenbanken."; }

MI2_OPTIONS["MI2_MainOptionsFrameTab1"] = 
{ text = "Tooltips"; help = "Optionen die Umfang und Aussehen des ToolTips bestimmen."; }

MI2_OPTIONS["MI2_MainOptionsFrameTab2"] = 
{ text = "Gesundheit/Mana"; help = "Optionen die Aussehen und Position der Gesundheits-\nund Manadarstellung im Zielfenster bestimmen"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab3"] = 
{ text = "Datenbank"; help = "Datenbank Management Optionen"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab4"] = 
{ text = "Suchen"; help = "In der Mob Datenbank suchen"; }

end
