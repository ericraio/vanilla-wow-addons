Funktionen:
-----------
* Optionsbildschirm mit /dhud menu oder Minimap Knopf
* Lebens- / Manaanzeige wechselt Farbe nach Füllstand.
* Alle Balken sind animiert. 
* Anzeige von Level, Name, Klasse und Elite/Boss, Pet, NPC
* Support für Telos Mobhealth / Mobinfo2 / Mobhealth2.
* 4 Alpha-Einstellungen für Kampf, 
  kein Kampf, Ziel Anvisiert, Spieler regeneriert.
* 4 Anzeigemodi für Leben / Mana 
  (1 = 100%, 2 = 456, 3 = 456/1023, 4 = keine Anzeige) 
* Viele positionierungs und skalierungs Optionen.  
* Blizzard Player / Targetframe abschaltbar.
* Zielmenu mit Rechtsclick auf Zielname.
* Spielermenu mit Rechtsclick auf Spielername (F11).
* Castingbar mit Zeitanzeige 
* Option um Petbalken zu verstecken
* Option um Zielbalken / Text zu verstecken 
* Funktioniert mit allen WoW Sprachversionen.
* myAddons Support
* alle Optionen auch mit Slashbefehlen einstellbar

Todo:
-----
* Skin Support (Verschiedene Layouts und Grafiken)
* Balkenfarbe einstellbar machen
* Zeige Ziel PvP Status
* Zeige Ziel PvP Rang
* Gruppenzugehörigkeit bei Raids Anzeigen
* Resting Status anzeigen
* Lebens- Manaanzeige mit Variablen
* Eigene Buffs/Debuffs
* Druidbar Support
* Target of Target Anzeige

Bekannte Bugs:
--------------
keine

History:
---------
2006.04.20 (v0.86)
* gefixt: DHUD init 
* Bliz. Castingbar nun an wenn DHUD Castingbar aus 

2006.04.19 (v0.85)
* gefixed: Bars / Casting Anzeige wurde falsh initalisiert.

2006.04.19 (v0.84)
* gefixt: Hudskalierung über 1.5 (Texte brachen um)
* gefixt: Minimapknopf
* gefixt: hintergrund nun unsichtbar bei Tod
* Spieler / Ziel rechtsklick Menu geändert
* Castingbar hinzugefügt
* Anzeige von Zauberzeit hinzugefügt
* Optionsmenu hat nun Resetknopf
* Option um Zeichensatzfarbe zu ändern hinzugefügt
* Option um Zeichensatzrahmen zu ändern hinzugefügt
* Option zum verstecken der Petanzeige hinzugefügt
* Option zum verstecken der Zielanzeige hinzugefügt

2006.04.11 (v0.83)
* Funktioniert nun mit allen WoW Sprachversionen.
* myAddons Support
* Mobhealth2 Bugfix 
* (testweise) DHUD erkennt nun ob DUF, Classic Perl Unitframes 
  oder Nymbias Perl Unitframes installiert sind
* Minimap Button für Optionsfenster eingebaut.
* Support für Telo's Mobhealth

2006.04.08 (v.082)
* Neue Positionierungsmöglichkeiten. 
* Texturen überarbeitet.
* Einige kleinere fixes.
* NPC Anzeige nun abschaltbar.

2006.04.05 (v.081)
* Slash-Kommando: /dhud bplayer - Blizzard Playerframe an / aus
* Slash-Kommando: /dhud btarget - Blizzard Targetframe an / aus
* Einige Event Optimierungen.
* Target Menu mit Rechtsclick auf Targetname
* Player Menu mit Shift Rechtsclick auf Targetname

2006.04.01 (v.08)
* Optionsmenu über /dhud menu 

2006.03.20 (v.072)
* Code Cleanup.
* Kleinere Bugfixes.

2006.01.21 (v.065)
* Spieler Pets werden nun angezeigt.
* Slash-Kommando hinzugefügt: x und y position nun änderbar.
* Slash-Kommando hinzugefügt: Textgrößen nun änderbar.
* Code weiter optimiert.
* neue Texturen.

* 2006.01.18 (v061):
* Bugfix: Nach dem Login wurde manchmal das Leben des Spielers 
  nicht richtig angezeigt.

2006.01.18 (v06):
* Support für Mobhealth / Mobinfo2.
* Slash-Kommando hinzugefügt: /dhud regalpha 0 - 1
* Slash-Kommando hinzugefügt: /dhud reset
* Slash-Kommando hinzugefügt: /dhud showlevel
* Slash-Kommando hinzugefügt: /dhud showname
* Slash-Kommando hinzugefügt: /dhud showclass
* Slash-Kommando hinzugefügt: /dhud showelite
* Slash-Kommando hinzugefügt: /dhud playerdisplaymode 1 - 4
* Slash-Kommando hinzugefügt: targetdisplaymode 1 - 4
* Balkenrahmen wird nun bei Tod des Spielers versteckt.
* Neuer AlphaModus regalpha hinzugefüht.
* Code weiter bereinigt.
* Slash Commando geben nun feedback.

2006.01.17 (v05):
* HUD verlässt Combat Modus erst wenn Leben und Mana voll sind.
* Slash-Kommando hinzugefügt: /dhud combatalpha 0 - 1
* Slash-Kommando hinzugefügt: /dhud nocombatalpha 0 - 1
* Slash-Kommando hinzugefügt: /dhud selectalpha 0 - 1

2006.01.16 (v041):
* LUA Fehler in zeile 260 gefixt 
  (nicht mehr verwendete Debug Variable entfernt).
* Scale 0.5 geht nun auch.

2006.01.16 (v04):
* Rage & Energy werden nun absolut und nich mehr als % angezeigt.
* Slash-Kommando: /dhud scale 0.5-2 zum scalieren des 
  gesamten Hud hinzugefügt.

2006.01.16 (v031b):
* 0 Level entfernt wenn kein Ziel anvisiert.

2006.01.16 (v03b):
* Erstes öffentliche Release.
