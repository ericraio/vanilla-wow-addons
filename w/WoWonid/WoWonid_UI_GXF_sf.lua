-- löschanimation eines feldes
function wowon_UI_GXF_sf (art, n)
-- art = ball/feld/balken
-- n = nummer des ball/feld


	if (art == "felddelet") then
		-- anfangsstatus
		if (wowon.game.gfx[art..n] == nil) then
			wowon.game.gfx[art..n] = { }
			
			wowon.game.gfx[art..n].b = wowon.game.feld[n].b/20
			wowon.game.gfx[art..n].h = wowon.game.feld[n].h/20
			wowon.game.gfx[art..n].a = wowon.game.feld[n].vc.a/20
			wowon.game.gfx[art..n].timer = 1
			
			-- timer starten
			wowon_timer_gxf (true, art, n)
		
		-- der gxf
		elseif (wowon.game.gfx[art..n].timer>0 and wowon.game.gfx[art..n].timer<18) then
		
			wowon.game.feld[n].vc.a = wowon.game.feld[n].vc.a - wowon.game.gfx[art..n].a
			wowon.game.feld[n].b = wowon.game.feld[n].b - wowon.game.gfx[art..n].b
			wowon.game.feld[n].h = wowon.game.feld[n].h - wowon.game.gfx[art..n].h
			
			wowon.game.feld[n].x = wowon.game.feld[n].x + wowon.game.gfx[art..n].b/2
			wowon.game.feld[n].y = wowon.game.feld[n].y + wowon.game.gfx[art..n].h/2

			wowon.game.gfx[art..n].timer = wowon.game.gfx[art..n].timer + 1

			wowon_UI_sf_feld_update (n)
			wowon_UI_sf_feld_start (n)
			
		-- ende
		else
			wowon_timer_gxf (false, art, n)
			wowon.game.gfx[art..n] = nil
			wowon_UI_sf_feld_hide (n)
		end
	end

	if (art == "balken+") then
		-- anfangsstatus
		if (wowon.game.gfx[art..n] == nil) then
			wowon.game.gfx[art..n] = { }	
			wowon.game.gfx[art..n].b = wowon.game.balken.b
			wowon.game.gfx[art..n].h = wowon.game.balken.h
			wowon.game.gfx[art..n].timer = 1
			
			-- timer starten
			wowon_timer_gxf (true, art, n)
		
		-- der gxf
		elseif (wowon.game.gfx[art..n].timer>0 and wowon.game.gfx[art..n].timer<18) then
		
			wowon.game.balken.b = wowon.game.balken.b+wowon.game.gfx[art..n].b*0.01
			wowon.game.balken.h = wowon.game.balken.h-wowon.game.gfx[art..n].h*0.01
			
			wowon.game.gfx[art..n].timer = wowon.game.gfx[art..n].timer + 1

			wowon_UI_sf_balken_update ()
			
		-- ende
		else
			wowon_timer_gxf (false, art, n)
			wowon.game.gfx[art..n] = nil
		end
	end

	if (art == "balken-") then
		-- anfangsstatus
		if (wowon.game.gfx[art..n] == nil) then
			wowon.game.gfx[art..n] = { }	
			wowon.game.gfx[art..n].b = wowon.game.balken.b
			wowon.game.gfx[art..n].h = wowon.game.balken.h
			wowon.game.gfx[art..n].timer = 1
			
			-- timer starten
			wowon_timer_gxf (true, art, n)
		
		-- der gxf
		elseif (wowon.game.gfx[art..n].timer>0 and wowon.game.gfx[art..n].timer<18) then
		
			wowon.game.balken.b = wowon.game.balken.b-wowon.game.gfx[art..n].b*0.01
			wowon.game.balken.h = wowon.game.balken.h+wowon.game.gfx[art..n].h*0.01
			
			wowon.game.gfx[art..n].timer = wowon.game.gfx[art..n].timer + 1

			wowon_UI_sf_balken_update ()
			
		-- ende
		else
			wowon_timer_gxf (false, art, n)
			wowon.game.gfx[art..n] = nil
		end
	end

	
end



-- stopt alle timer über table.foreach
function wowon_UI_GXF_sf_stop_all (x)
-- x = name des table
	if not (wowon.game.gfx[x] == nil) then
		wowon_timer_gxf (false, "", x)
	end
end
