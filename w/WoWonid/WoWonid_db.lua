-- datenbank
wowon = {};

-- tempräre datenbank des aktuellen spiels
wowon.game = {};

-- datenbank des spielfeldes
wowon.game.feld = {};
-- feld nummer
wowon.game.feld[1] = {};
-- gösse des feldes / höhe*breite
wowon.game.feld[1]["h"] = 10
wowon.game.feld[1]["b"] = 20
-- position des feldes
wowon.game.feld[1]["x"] = 100
wowon.game.feld[1]["y"] = 120
-- status des feldes
--		1..99 = verschiedene stadien des feldes (unbesiegbar/spezialitem usw.)
wowon.game.feld[1]["s"] = 1

-- grösse des ganzen spielfeldes
wowon.game.feld.x = 400
wowon.game.feld.y = 300
-- offset unten (bereich des balken) / ballfreiheit ist demnach x*(y-o)
wowon.game.feld.o = 50

-- datenbank der bälle
wowon.game.ball = {};
-- ballnummer
wowon.game.ball[1] = {};
-- x/y pos des balles
wowon.game.ball[1].x = 111
wowon.game.ball[1].y = 111
-- geschwindigkeit des ball in pixel
wowon.game.ball[1].a = 2
-- status des balles
--	0 = standard
--	1..99 = weitere stadien des balles (unsichtbar/stark/farbe usw.)
wowon.game.ball[1].s = 1
-- startstatus des balles
--	1 = auf balken
--	2 = fliegend
--  3 = im feld
--	4 = im feld (fliegend)
wowon.game.ball[1].ss = 1
-- flugwinkel des balles
--	0 = 360 = senkrecht nach oben
--	90 = waagrecht nach rechts
--	180 = senkrecht nach unten
--	270 = waagrecht nach links
wowon.game.ball[1].w = 0
-- radius des ball in pixel
wowon.game.ball[1].r = 4
-- balltextur
wowon.game.ball[1].t = "textur"
-- bälle im spiel
-- ein table, dabei wird die ballnummer hier 1, gespeichert
wowon.game.balle = {}
-- bälle frei
-- ein table, dabei wird die ballnummer hier 1, gespeichert
wowon.game.ballfrei = {}

-- datenbank des spielbalken
wowon.game.balken = {};
-- breite des balken in pixel
wowon.game.balken.b = 8
-- status des balken
--	1 = standard balken
--	1..9 = weitere stadien des balken (breiter/mit waffe/neuer ball/unsichtbar usw.)
wowon.game.balken.s = 1
-- x position des balken (mittelpunkt)
wowon.game.balken.x = 40
-- balken-höhe
wowon.game.balken.h = 5
-- textur
wowon.game.balken.t = "holz"
-- vertex color für balken
wowon.game.balken.vc = {};
-- rot
wowon.game.balken.vc.r = 1
-- grün
wowon.game.balken.vc.g = 1
-- blau
wowon.game.balken.vc.b = 1
-- alpha kanal
wowon.game.balken.vc.a = 1



--[[
Frames:

HF - HauptFrame
Hauptframe, das absolute Topframe von WoWonid

SF - SpielFrame
Darin spielt sich das Spielgeschehen ab

PF - PunkteStatusSteuerungsFrame
Infos und Buttons wärend des Spieles werden hier Dargestellt


Struktur:

wowon_hf
- wowon_hf_text
- wowon_hf_textur
-- wowon_hf_rf

	wowon_sf
	- wowon_sf_hgtextur (hintergrundtextur)

		wowon_balken
		- wowon_balken_textur

	wowon_pf



BACKGROUND - Level 0. Place the background of your frame here.
BORDER - Level 1. Place the artwork of your frame here .
ARTWORK - Level 2. Place the artwork of your frame here.
OVERLAY - Level 3. Place your text, objects, and buttons in this level
HIGHLIGHT - Level 4. Place your text, objects, and buttons in this level


--]]
