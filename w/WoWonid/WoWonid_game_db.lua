-- verschiedene balken / setzt die variablen dem balken entsprechend
function wowon_balk ()
	local x = wowon.game.balken.s
	
	if (x == 1) then
		wowon.game.balken.t = "Interface\\AddOns\\WoWonid\\textur\\balken"
		wowon.game.balken.vc = {};
		wowon.game.balken.vc.r = 1
		wowon.game.balken.vc.g = 1
		wowon.game.balken.vc.b = 1
		wowon.game.balken.vc.a = 1
	end

--[[
--breite des balken in pixel
wowon.game.balken.b = 8
-- balken-höhe
wowon.game.balken.h = 5
-- status des balken
--	1 = standard balken
--	1..9 = weitere stadien des balken (breiter/mit waffe/neuer ball/unsichtbar usw.)
wowon.game.balken.s = 1
-- textur
wowon.game.balken.t = "holz"
--]]
	
end

-- verschiedene bälle
function wowon_ball (b)
-- b = balnummer die geändert wird

	local x = wowon.game.ball[b].s
	-- standardball
	if (x == 1) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\b-normal"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end

	-- feuerball
	if (x == 2) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\b-feuer"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end

	-- blauerball (randomwinkel)
	if (x == 3) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\b-blau"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end

	-- feldball (feuer)
	if (x == 102) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\fb-feuer"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
	-- feldball (blau)
	if (x == 103) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\fb-blau"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
	-- speed+
	if (x == 150) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\speed+"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
	-- speed-
	if (x == 151) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\speed-"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end

	-- grösse+
	if (x == 152) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\grosse+"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
	-- grösse-
	if (x == 153) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\grosse-"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
	-- balken-
	if (x == 200) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\fb-balken-"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
	-- balken+
	if (x == 201) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\fb-balken+"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
	-- ball+1
	if (x == 301) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\fb-ball+1"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end

	-- ball+2
	if (x == 302) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\fb-ball+2"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end

	-- ball+3
	if (x == 303) then
		wowon.game.ball[b].t = "Interface\\AddOns\\WoWonid\\textur\\fb-ball+3"
		wowon.game.ball[b].vc = {};
		wowon.game.ball[b].vc.r = 1
		wowon.game.ball[b].vc.g = 1
		wowon.game.ball[b].vc.b = 1
		wowon.game.ball[b].vc.a = 1
	end
	
--[[	
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
--]]

end

-- verschiedene felder
function wowon_feld (f)
-- f = feldnummer die geändert wird

	local x = wowon.game.feld[f].s
	-- standard-feld
	if (x == 1) then
		wowon.game.feld[f].t = "Interface\\AddOns\\WoWonid\\textur\\rechteck"
	end
	-- stahl-feld
	if (x == 2) then
		wowon.game.feld[f].t = "Interface\\AddOns\\WoWonid\\textur\\rechteck-stahl"
	end
	-- blau-feld
	if (x == 3) then
		wowon.game.feld[f].t = "Interface\\AddOns\\WoWonid\\textur\\rechteck-blau"
	end

--[[	
	-- feldnummer
	wowon.game.feld[1] = {};
	-- x/y pos des feldes
	wowon.game.feld[1].x = 111
	wowon.game.feld[1].y = 111
	-- b/h des feldes
	wowon.game.feld[1].h = 111
	wowon.game.feld[1].b = 111	
	-- feldtextur
	wowon.game.feld[1].t = "textur"
--]]

end
