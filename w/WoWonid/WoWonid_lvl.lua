function wowonid_set_lvl (lvl)
-- lvl = lvl nummer

	if (lvl == 999) then

		wowon.game.feld = {}
		wowon.game.ball = {}
		wowon.game.balken = {}
		wowon.game.balken.b = 128
		wowon.game.balken.h = 12
		
		wowon.game.feld.x = 600
		wowon.game.feld.y = 500
		wowon.game.feld.o = 50
		wowon.game.balken.s = 1
		wowon.game.balken.x = wowon.game.feld.x/2

		wowon_UI_setup ()
		wowon_UI_sf_balken_update ()
		wowon_UI_sf_balken_start ()
		
		--wowon_sf_feld_add (h, b, x, y, s, cr, cg, cb, ca, fb)

		local y = 200
		local h = 20
		local b = 80
		local x = 80
		local s = 1
		-- farbe
		local cr = 1
		local cg = 0
		local cb = 0
		local ca = 1
	
		for i = 1, 11 do
			y = y+h
			
			-- sonderreihe
			if ( i == 8) then
				wowon_sf_feld_add (20, 80, 20, y, 1, cr, cg, cb, ca, 150)
				wowon_sf_feld_add (20, 80, 20+80, y, 1, cr, cg, cb, ca, 151)
				wowon_sf_feld_add (20, 80, 20+80+80, y, 1, cr, cg, cb, ca, 152)
				--wowon_sf_feld_add (20, 80, 20+160+80, y, 1, cr, cg, cb, ca)
				wowon_sf_feld_add (20, 80, 20+160+160, y, 1, cr, cg, cb, ca, 152)
				wowon_sf_feld_add (20, 80, 20+320+80, y, 1, cr, cg, cb, ca, 151)
				wowon_sf_feld_add (20, 80, 20+320+160, y, 1, cr, cg, cb, ca, 150)
			elseif ( i == 6) then
				wowon_sf_feld_add (20, 80, 20, y, 1, 1, 1, 1, 0.75)
				wowon_sf_feld_add (20, 80, 20+80, y, 1, 1, 1, 1, 0.75)
				wowon_sf_feld_add (20, 80, 20+80+80, y, 1, 1, 1, 1, 0.75)
				--wowon_sf_feld_add (20, 80, 20+160+80, y, 1, 1, 1, 1, 0.5)
				wowon_sf_feld_add (20, 80, 20+160+160, y, 1, 1, 1, 1, 0.75)
				wowon_sf_feld_add (20, 80, 20+320+80, y, 1, 1, 1, 1, 0.75)
				wowon_sf_feld_add (20, 80, 20+320+160, y, 1, 1, 1, 1, 0.75)					
			else
				wowon_sf_feld_add (20, 80, 20, y, 1, cr, cg, cb, ca)
				wowon_sf_feld_add (20, 80, 20+80, y, 1, cr, cg, cb, ca)
				wowon_sf_feld_add (20, 80, 20+80+80, y, 1, cr, cg, cb, ca)
				--wowon_sf_feld_add (20, 80, 20+160+80, y, 1, cr, cg, cb, ca)
				wowon_sf_feld_add (20, 80, 20+160+160, y, 1, cr, cg, cb, ca)
				wowon_sf_feld_add (20, 80, 20+320+80, y, 1, cr, cg, cb, ca)
				wowon_sf_feld_add (20, 80, 20+320+160, y, 1, cr, cg, cb, ca)			
			end
			--cr = cr-0.02
			--cg = cg+0.01
			cb = cb+0.09
			cg = cg+0.09
		end

		cr = 0.5
		cg = 0.5
		cb = 0.5
		ca = 0.75
		
		--kreuz
		y = 200+6*h
		wowon_sf_feld_add (20, 80, 20, y, 1, 1, 1, 1, 0.75)
		wowon_sf_feld_add (20, 80, 20+80, y, 1, 1, 1, 1, 0.75, 153)
		wowon_sf_feld_add (20, 80, 20+80+80, y, 1, 1, 1, 1, 0.75)
		wowon_sf_feld_add (20, 80, 20+160+80, y, 1, 1, 1, 1, 0.75, 302)
		wowon_sf_feld_add (20, 80, 20+160+160, y, 1, 1, 1, 1, 0.75)
		wowon_sf_feld_add (20, 80, 20+320+80, y, 1, 1, 1, 1, 0.75, 153)
		wowon_sf_feld_add (20, 80, 20+320+160, y, 1, 1, 1, 1, 0.75)
		y = 200
		for i = 1, 11 do
			y = y+h	
			wowon_sf_feld_add (20, 80, 20+160+80, y, 1, 1, 1, 1, 0.75)
		end
		y = 200
		for i = 1, 11 do
			y = y+h	
			wowon_sf_feld_add (20, 80, 20+160+80, y, 1, 1, 1, 1, 0.75)
		end
		--feuerball
		wowon_sf_feld_add (40, 80, 260, 440, 1, 1, 1, 1, 0.75, 102)

		-- stahlfelder
		wowon_sf_feld_add (20, 80, 20+160, 200, 2, 1, 1, 1, 1)
		wowon_sf_feld_add (20, 80, 20+2*160, 200, 2, 1, 1, 1, 1)

		-- felder mit blauerball
		wowon_sf_feld_add (20, 80, 20+80, 200, 1, 1, 1, 1, 1, 103)
		wowon_sf_feld_add (20, 80, 20+2*160+80, 200, 1, 1, 1, 1, 1, 103)
		
		-- blaues feld, balken -+
		wowon_sf_feld_add (20, 60, 1*60-60, 480, 1, 0, 0, 1, 1, 200)
		wowon_sf_feld_add (20, 60, 2*60-60, 480, 1, 0, 0, 1, 1, 201)
		wowon_sf_feld_add (20, 60, 3*60-60, 480, 1, 0, 0, 1, 1, 200)
		wowon_sf_feld_add (20, 60, 4*60-60, 480, 1, 0, 0, 1, 1, 201)
		wowon_sf_feld_add (20, 60, 5*60-60, 480, 3, 1, 1, 1, 1)
		wowon_sf_feld_add (20, 60, 6*60-60, 480, 3, 1, 1, 1, 1)
		wowon_sf_feld_add (20, 60, 7*60-60, 480, 1, 0, 0, 1, 1, 201)
		wowon_sf_feld_add (20, 60, 8*60-60, 480, 1, 0, 0, 1, 1, 200)
		wowon_sf_feld_add (20, 60, 9*60-60, 480, 1, 0, 0, 1, 1, 201)
		wowon_sf_feld_add (20, 60, 10*60-60, 480, 1, 0, 0, 1, 1, 200)
		
		wowon_sf_ball_add (1)
		
	end

end










