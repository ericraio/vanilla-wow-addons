-- event ball bewegt sich
function wowon_event_ball (b)
-- b = ballnummer

	-- berechnungsstufe
	local b_lvl = nil
	-- angaben für verfeinerung der berechnung
	if (wowon.game.ball[b].a>3) then
		-- aufgerundet
		b_lvl = math.ceil(wowon.game.ball[b].a/1.2)
	else
		b_lvl = 1
	end
	
	-- schlaufe für berechnungsstufe
	for i = 1, b_lvl do
	
		-- neue position des balles berechnen und anzeigen
		wowon_sf_ball_move (b, b_lvl)

		--wowon_debug (b)
	
		-- h = höhe des sf
		local hf = wowon.game.feld.y
		-- b = breite des sf
		local bf = wowon.game.feld.x
		-- r = ballradius
		local r = wowon.game.ball[b].r
		
		-- spielfeld aussentest
		local p, w = wowon_geo_ball_out (b)
		-- vorhin berechnete position
		local pos = wowon.game.ball[b].pos_temp
		-- ball ist drausen
		if not (p == nil) then
			-- ball oben
			if (p == 1 ) and not (pos == 1) then
				wowon.game.ball[b].y = hf-r
				wowon.game.ball[b].pos_temp = 1
				wowon.game.ball[b].posfeld_temp	= nil
				-- winkel ändern
				wowon_geo_winkel (b, p, w)
			-- ball links
			elseif (p == 7) and not (pos == 7) then
				wowon.game.ball[b].x = r
				wowon.game.ball[b].pos_temp = 7
				wowon.game.ball[b].posfeld_temp	= nil
				-- winkel ändern
				wowon_geo_winkel (b, p, w)
			-- ball rechts
			elseif (p == 3) and not (pos == 3) then
				wowon.game.ball[b].x = bf-r
				wowon.game.ball[b].pos_temp = 3
				wowon.game.ball[b].posfeld_temp	= nil
				-- winkel ändern
				wowon_geo_winkel (b, p, w)
			-- ball beim balken
			elseif (p == "b") and not (pos == "b") then
				wowon.game.ball[b].y = wowon.game.feld.o+r
				wowon.game.ball[b].pos_temp = "b"
				wowon.game.ball[b].posfeld_temp	= nil
				wowon_event_ballbalken (b)
				return
			elseif (p == 5) then
				wowon_event_ball_out (b)
				return
			else
				return
			end
		-- outside test war erfolglos
		else
			local p, w, f = wowon_geo_ball_in (b)
			-- vorhin berechnete position für feld
			local pos = wowon.game.ball[b].posfeld_temp	
			
			if not (p == nil) and not (pos == f) then
				wowon_event_ballfeld (p, w, f, b)
				wowon.game.ball[b].posfeld_temp	= f
				wowon.game.ball[b].pos_temp = nil
			end
		end

	end
	
end


-- event ball trifft balken
function wowon_event_ballbalken (b)
-- b == ballnummer

	if (wowon.game.ball[b].ss == 2) then
		-- feuerball
		if (wowon.game.ball[b].s == 2) then
			-- ballstatus zu normal ändern
			wowon.game.ball[b].s = 1
			wowon_UI_sf_ball_update (b)
		end
		wowon_geo_winkel_balken (b)
	
	elseif (wowon.game.ball[b].ss == 4) then
		-- balken-
		if (wowon.game.ball[b].s == 200) then
			-- feldball löschen
			wowon_sf_ball_delet (b)
			wowon_UI_GXF_sf ("balken-", b)
		
		--balken+
		elseif (wowon.game.ball[b].s == 201) then
			-- feldball löschen
			wowon_sf_ball_delet (b)
			wowon_UI_GXF_sf ("balken+", b)
				
		--ball+1
		elseif (wowon.game.ball[b].s == 301) then
			-- feldball löschen
			wowon_sf_ball_delet (b)
			wowon_sf_ball_add (1)

		--ball+2
		elseif (wowon.game.ball[b].s == 302) then
			-- feldball löschen
			wowon_sf_ball_delet (b)
			wowon_sf_ball_add (1)
			wowon_sf_ball_add (1)

		--ball+3
		elseif (wowon.game.ball[b].s == 303) then
			-- feldball löschen
			wowon_sf_ball_delet (b)
			wowon_sf_ball_add (1)
			wowon_sf_ball_add (1)
			wowon_sf_ball_add (1)
		
		end
	end
end

-- event ball ist ausserhalb des sf (unter dem balken)
function wowon_event_ball_out (b)
-- b = ballnummer
	wowon_sf_ball_delet (b)
	-- noch ein spielball frei?
	local x = false
	for i = 1, table.getn(wowon.game.balle) do
		if (wowon.game.ball[wowon.game.balle[i]].ss == 1) or (wowon.game.ball[wowon.game.balle[i]].ss == 2) then
			x = true
			break
		end
	end
	if (x == false) then
		wowon_exit_game ()
		wowon_UI_sf_string (false)
	end
end

-- ball trifft ein feld
function wowon_event_ballfeld (p, w, f, b)
-- p = auprallpunkt
-- w = aufprallwinkel
-- f = feldnummer
-- b = ballnummer

			
	-- fliegende feldbälle
	if (wowon.game.ball[b].ss == 4) then
		-- winkel ändern
		wowon_geo_winkel (b, p, w)
	else

		if (wowon.game.feld[f].s == 1) then
			
			-- feldbälle
			if not (wowon.game.feld[f].fb == nil) then
				
				-- feuerball
				if (wowon.game.ball[wowon.game.feld[f].fb].s == 102) then
					-- feldball löschen
					wowon_sf_ball_delet (wowon.game.feld[f].fb)
					-- ballstatus zu feuer ändern
					wowon.game.ball[b].s = 2
					wowon_UI_sf_ball_update (b)
	
				-- blauerball
				elseif (wowon.game.ball[wowon.game.feld[f].fb].s == 103) then
					-- feldball löschen
					wowon_sf_ball_delet (wowon.game.feld[f].fb)
					-- ballstatus zu blau ändern
					wowon.game.ball[b].s = 3
					wowon_UI_sf_ball_update (b)
	
				-- speed+
				elseif (wowon.game.ball[wowon.game.feld[f].fb].s == 150) then
					-- feldball löschen
					wowon_sf_ball_delet (wowon.game.feld[f].fb)
					-- ballspeed um 25% erhöhen
					wowon.game.ball[b].a = wowon.game.ball[b].a*1.25
	
				-- speed-
				elseif (wowon.game.ball[wowon.game.feld[f].fb].s == 151) then
					-- feldball löschen
					wowon_sf_ball_delet (wowon.game.feld[f].fb)
					-- ballspeed um 25% verringern
					wowon.game.ball[b].a = wowon.game.ball[b].a*0.75
	
				-- grösse+
				elseif (wowon.game.ball[wowon.game.feld[f].fb].s == 152) then
					-- feldball löschen
					wowon_sf_ball_delet (wowon.game.feld[f].fb)
					-- ballradiusgrösse um 50% erhöhen
					wowon.game.ball[b].r = wowon.game.ball[b].r*1.50
					wowon_UI_sf_ball_update (b)
	
				-- grösse-
				elseif (wowon.game.ball[wowon.game.feld[f].fb].s == 153) then
					-- feldball löschen
					wowon_sf_ball_delet (wowon.game.feld[f].fb)
					-- ballradiusgrösse um 50% verringern
					wowon.game.ball[b].r = wowon.game.ball[b].r*0.5
					wowon_UI_sf_ball_update (b)
	
				-- feldbälle starten
				elseif (wowon.game.ball[wowon.game.feld[f].fb].s > 199) then
					-- feldball starten
					wowon_sf_feldball_start (wowon.game.feld[f].fb)
				end
				
			end
			
			-- ballstatus
			if not (wowon.game.ball[b].s == 1) then
				-- feuerball
				if (wowon.game.ball[b].s == 2) then
					-- speed ändern
					wowon.game.ball[b].a = wowon.game.ball[b].a+0.2
					-- feld löschen
					wowon_sf_feld_delet (f)
	
				-- blauerball
				elseif (wowon.game.ball[b].s == 3) then
					-- speed ändern
					wowon.game.ball[b].a = wowon.game.ball[b].a+0.2
					-- feld löschen
					wowon_sf_feld_delet (f)
					-- winkel ändern
					wowon_geo_randomwinkel (b, p, w)
				end
	
			else
				--ball status = 1
				wowon_sf_feld_delet (f)
				-- winkel ändern
				wowon_geo_winkel (b, p, w)
				-- speed ändern
				wowon.game.ball[b].a = wowon.game.ball[b].a+0.12
			end
	
		-- stahl-feld
		elseif (wowon.game.feld[f].s == 2) then
			-- winkel ändern
			wowon_geo_winkel (b, p, w)
	
		-- blau-feld
		elseif (wowon.game.feld[f].s == 3) then
			-- winkel ändern
			wowon_geo_randomwinkel (b, p, w)
		end
		
		-- spiel beendet?
		local donetest = true
		for i=1, table.getn(wowon.game.felder) do
			if (wowon.game.feld[wowon.game.felder[i]].s == 1) then
				donetest = false
			end
		end
		if (donetest == true) then
			wowon_exit_game ()
			wowon_UI_sf_string (true)
		end
	end

end


-- mausklick im sf feld
function wowon_event_mausklick ()

	for i=1, table.getn(wowon.game.balle) do
		local bnr = wowon.game.balle[i]
		if (wowon.game.ball[bnr].ss == 1) then
				-- status des balles ändern
				wowon_sf_ball_start (bnr)
		end
	end
end
