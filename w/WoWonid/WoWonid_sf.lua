-- mauszeiger betritt sf
function wowon_sf_maus_OnEnter ()
	if (wowon.game.ingame == true) then
		wowon_timer_balken (true)
	end
end

-- mauszeiger verlässt sf
function wowon_sf_maus_OnLeave ()
	wowon_timer_balken (false)
end

-- mausklick
function wowon_sf_maus_OnClick()
	if (wowon.game.ingame == true) then
		wowon_event_mausklick ()
	end
end

-- neue pos. des balken berechnen
function wowon_sf_balken_move ()
	-- fenster position
	local x = wowon_sf:GetLeft()
	-- cursor position
	local cx = GetCursorPosition()
	-- sf fensterbreite
	local fx = wowon.game.feld.x
	-- balkenbreite
	local b = wowon.game.balken.b
	-- scalegrösse
	local sc = UIParent:GetScale()
	-- scalegrösse kompensieren
	cx = cx/sc
	
	-- maus ist im spielfeld
	if not (cx<x) and not (cx>(fx+x)) then			-- eigentlich unnötige sicherheitsabfrage, da maus auserhalb den timer wowon_balken deaktiviert
		-- balken ist ganz links
		if (cx<(x+b/2)) then
			wowon.game.balken.x = b/2
		-- balken ist ganz rechts
		elseif (cx>(x+fx-b/2)) then
			wowon.game.balken.x = fx-b/2
		-- balken ist dazwischen
		else
			wowon.game.balken.x = cx-x			
		end
	end
	--wowon_debug(wowon.game.balken.x)
	wowon_UI_sf_balken_move ()
end

-- ball erstellen
function wowon_sf_ball_add (status)
-- s = startstatus des balles
	-- überprüfen ob ein ball frei ist
	if (wowon.game.ballfrei[1] == nil) then
		wowon_UI_sf_ball_creat ()
	end
	-- erster freier ball nehmen
	local b = wowon.game.ballfrei[1]
	-- von der ballfrei liste entfernen
	table.remove(wowon.game.ballfrei, 1)
	-- zur balle liste hinzufügen
	table.insert(wowon.game.balle, b)
	-- ball table fürs game erstellen
	wowon.game.ball[b] = {};
	-- status des balles setzten
	wowon.game.ball[b].s = status
	-- starteigenschaften für startball (status = 1)
	if (status == 1) then
		wowon.game.ball[b].a = 4
		wowon.game.ball[b].r = 10
	end
	wowon.game.ball[b].ss = 1
	-- ball darstellen
	wowon_UI_sf_ball_update (b)
	-- ball zeigen und an startposition setzen
	wowon_UI_sf_ball_start (b)
end

-- ball freigeben
function wowon_sf_ball_start (b)
-- b = ballnummer
	wowon.game.ball[b].x = wowon.game.balken.x
	wowon.game.ball[b].y = wowon.game.feld.o+wowon.game.ball[b].r
	wowon.game.ball[b].ss = 2
	-- zufallsstartwinkel
	local z = math.random(120)
	if (z > 60) then
		wowon.game.ball[b].w = z-60
	else
		wowon.game.ball[b].w = 360-z
	end
	--wowon_UI_sf_ball_update (b)
	wowon_timer_ball (true, b)
end

-- feldball freigeben
function wowon_sf_feldball_start (b)
-- b = ballnummer
	wowon.game.ball[b].ss = 4
	wowon.game.ball[b].a = 4
	-- zufallsstartwinkel
	wowon.game.ball[b].w = math.random(1, 360)
	wowon_timer_ball (true, b)
end

function wowon_sf_ball_move (b, b_lvl)
-- b = ballnummer	
-- b_lvl = berechnungs-lvl

	-- neue position des balls berechnen
	local w = wowon.game.ball[b].w
	local a = wowon.game.ball[b].a/b_lvl

	wowon.game.ball[b].y = wowon.game.ball[b].y+math.cos(math.rad(w))*a	
	wowon.game.ball[b].x = wowon.game.ball[b].x+math.sin(math.rad(w))*a

	wowon_UI_ball_move(b)

end

function wowon_sf_ball_delet (b)
-- b = ballnummer

	-- von der balle liste entfernen
	for i = 1, table.getn(wowon.game.balle) do
		if (wowon.game.balle[i] == b) then
			table.remove(wowon.game.balle, i)
			break
		end
	end
	-- zur ballfrei liste hinzufügen
	table.insert(wowon.game.ballfrei, b)
	-- balltimer deaktivieren
	wowon_timer_ball (false, b)
	-- ball verdecken
	wowon_UI_sf_ball_hide (b)
end



-- feld erstellen
function wowon_sf_feld_add (h, b, x, y, s, vr, vg, vb, va, fb)
-- s = feldstatus
-- h = höhe
-- b = breite
-- x = x pos
-- y = y pos
-- vr = rot
-- vg = grün
-- vb = blau
-- va = alpha
-- fb = feldball

	-- überprüfen ob ein feld frei ist
	if (wowon.game.feldfrei[1] == nil) then
		wowon_UI_sf_feld_creat ()
	end
	-- erster freier ball nehmen
	local f = wowon.game.feldfrei[1]
	-- von der feldfrei liste entfernen
	table.remove(wowon.game.feldfrei, 1)
	-- zur felder liste hinzufügen
	table.insert(wowon.game.felder, f)
	-- ball table fürs game erstellen
	wowon.game.feld[f] = {};
	-- daten eingeben
	wowon.game.feld[f].h = h
	wowon.game.feld[f].b = b
	wowon.game.feld[f].x = x
	wowon.game.feld[f].y = y
	wowon.game.feld[f].s = s
	-- farbe
	if not (vr == nil) then
		wowon.game.feld[f].vc = {};
		wowon.game.feld[f].vc.r = vr
		wowon.game.feld[f].vc.g = vg
		wowon.game.feld[f].vc.b = vb
		wowon.game.feld[f].vc.a = va
	end
	
	-- feld darstellen
	wowon_UI_sf_feld_update (f)
	-- feld zeigen und setzen
	wowon_UI_sf_feld_start (f)
	
	-- feldball
	if not (fb == nil) then

		-- überprüfen ob ein ball frei ist
		if (wowon.game.ballfrei[1] == nil) then
			wowon_UI_sf_ball_creat ()
		end
		-- erster freier ball nehmen
		local ball = wowon.game.ballfrei[1]
		-- von der ballfrei liste entfernen
		table.remove(wowon.game.ballfrei, 1)
		-- zur balle liste hinzufügen
		table.insert(wowon.game.balle, ball)
		
		-- ball table fürs game erstellen
		wowon.game.ball[ball] = {};
		-- status des f-balles setzten
		wowon.game.ball[ball].s = fb
		wowon.game.ball[ball].ss = 3
		-- radius des f-balles
		if (h > b) then
			wowon.game.ball[ball].r = b/2
		else
			wowon.game.ball[ball].r = h/2
		end
		-- position des f-ball
		wowon.game.ball[ball].y = y+h/2
		wowon.game.ball[ball].x = x+b/2
		-- ball darstellen
		wowon_UI_sf_ball_update (ball)
		-- ball zeigen und an startposition setzen
		wowon_UI_sf_feldball_start (ball)

		-- im feld die f-ball nummer speichern
		wowon.game.feld[f].fb = ball
	end
	
end

function wowon_sf_feld_delet (f)
-- f = feldnummer

	-- von der felder liste entfernen
	for i = 1, table.getn(wowon.game.felder) do
		if (wowon.game.felder[i] == f) then
			table.remove(wowon.game.felder, i)
			break
		end
	end
	-- zur feldfrei liste hinzufügen
	table.insert(wowon.game.feldfrei, f)
	-- feld verdecken
	wowon_UI_GXF_sf ("felddelet", f)
end
