function wowon_geo_ball_in (b)
-- a = flugwinkel ball
-- xb = x pos ball
-- yb = y pos ball
-- r = radius ball
-- d = r/(wurzel2)  -- diagonalenfaktor
	
-- xf = x pos feld (immer links unten)
-- yf = y pos feld
-- b = breite feld
-- h = höhe feld
-- t = berechnungstoleranz / feldrahmen

-- return (punkt auf dem kreis, der kolosion hat) (aufprall winkel) (feldnummer)
-- retrun nil, wenn gar nix der fall ist

	local a = wowon.game.ball[b].w
	local xb = wowon.game.ball[b].x
	local yb = wowon.game.ball[b].y
	local r = wowon.game.ball[b].r
	local d = r/(math.sqrt(2))
	
	
	
	for i = 1, table.getn(wowon.game.felder) do
	
		local f = wowon.game.felder[i]
		local xf = wowon.game.feld[f].x
		local yf = wowon.game.feld[f].y
		local b = wowon.game.feld[f].b
		local h = wowon.game.feld[f].h
		local t = nil
		if (b>h) then
			t = h/2
		else
			t = b/2
		end
	
		-- nach rechts oben (f2)
		if (a>0) and (a<90) then
			-- für p1
			if (yf<yb+r and yf+t>yb+r) and (xf<xb and xf+b>xb) then
				return 1, 2, f
			-- für p3
			elseif (yf<yb and yf+h>yb) and (xf<xb+r and xf+t>xb+r) then
				return 3, 2, f
			-- für p2
			elseif (yf<yb+d and yf+t>yb+d) and (xf<xb+d and xf+t>xb+d) then
				return 2, 2, f
			-- für p8
			elseif (yf<yb+d and yf+t>yb+d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 8, 2, f
			-- für p4
			elseif (xf<xb+d and xf+t>xb+d) and (yf+h>yb-d and yf+h-t<yb-d) then
				return 4, 2, f
			else
			end
		
		-- nach links oben (f6)
		elseif (a>270 and a<360) then
			-- für p1
			if (yf<yb+r and yf+t>yb+r) and (xf<xb and xf+b>xb) then
				return 1, 6, f
			-- für p7
			elseif (yf<yb and yf+h>yb) and (xf+b>xb-r and xf+b-t<xb-r) then
				return 7, 6, f
			-- für p8
			elseif (yf<yb+d and yf+t>yb+d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 8, 6, f
			-- für p2
			elseif (yf<yb+d and yf+t>yb+d) and (xf<xb+d and xf+t>xb+d) then
				return 2, 6, f
			-- für p6
			elseif (yf+h>yb-d and yf+h-t<yb-d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 6, 6
			else
			end
		
		
		-- nach links unten (f5)
		elseif (a>180 and a<270) then
			-- für p5
			if (yf+h>yb-r and yf+h-t<yb-r) and (xf<xb and xf+b>xb) then
				return 5, 5, f
			-- für p7
			elseif (yf<yb and yf+h>yb) and (xf+b>xb-r and xf+b-t<xb-r) then
				return 7, 5, f
			-- für p6
			elseif (yf+h>yb-d and yf+h-t<yb-d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 6, 5, f
			-- für p8
			elseif (yf<yb+d and yf+t>yb+d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 8, 5, f
			-- für p4
			elseif (xf<xb+d and xf+t>xb+d) and (yf+h>yb-d and yf+h-t<yb-d) then
				return 4, 5, f
			else
			end
		
		-- nach rechts unten (f3)
		elseif (a>90 and a<180) then
			-- für p5
			if (yf+h>yb-r and yf+h-t<yb-r) and (xf<xb and xf+b>xb) then
				return 5, 3, f
			-- für p3
			elseif (yf<yb and yf+h>yb) and (xf<xb+r and xf+t>xb+r) then
				return 3, 3	, f
			-- für p4
			elseif (xf<xb+d and xf+t>xb+d) and (yf+h>yb-d and yf+h-t<yb-d) then
				return 4, 3, f
			-- für p2
			elseif (yf<yb+d and yf+t>yb+d) and (xf<xb+d and xf+t>xb+d) then
				return 2, 3, f
			-- für p6
			elseif (yf+h>yb-d and yf+h-t<yb-d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 6, 3, f
			else
			end
			
		-- nach oben (f1)
		elseif (a==0 or a==360) then
			-- für p1
			if (yf<yb+r and yf+t>yb+r) and (xf<xb and xf+b>xb) then
				return 1, 1, f
			-- für p2
			elseif (yf<yb+d and yf+t>yb+d) and (xf<xb+d and xf+t>xb+d) then
				return 2, 1, f
			-- für p8
			elseif (yf<yb+d and yf+t>yb+d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 8, 2, f
			else
			end
		
		-- nach unten (f4)
		elseif (a==180) then
		
			-- für p5
			if (yf+h>yb-r and yf+h-t<yb-r) and (xf<xb and xf+b>xb) then
				return 5, 4, f
			-- für p4
			elseif (xf<xb+d and xf+t>xb+d) and (yf+h>yb-d and yf+h-t<yb-d) then
				return 4, 4, f
			-- für p6
			elseif (yf+h>yb-d and yf+h-t<yb-d) and (xf+b>xb-d and xf+b-t<xb-d) then
				return 6, 4, f
			else
			end
		
		else
		end

	end
	return nil
end



-- überprüft ob ball auserhalb des sf ist
-- return nil - wenn im sf
-- return 1 - wenn oben drausen
-- retrun 5 - wenn unten drausen
-- retrun 7 - wenn links drausen
-- retrun 3 - wenn rechts drausen
-- return "b" - wenn ball den balken berührt
-- zweite stelle = aufprallwinkel
function wowon_geo_ball_out (b)
-- b = ballnummer

	-- a = flugwinkel ball
	local a = wowon.game.ball[b].w
	-- x = x pos ball
	local x = wowon.game.ball[b].x
	-- y = y pos ball
	local y = wowon.game.ball[b].y
	-- r = radius ball
	local r = wowon.game.ball[b].r

	-- h = höhe des sf
	local h = wowon.game.feld.y
	-- b = breite des sf
	local b = wowon.game.feld.x
	-- o = offset
	local o = wowon.game.feld.o
	
	-- bb = breite balken
	local bb = wowon.game.balken.b
	-- xb = x pos balken
	local xb = wowon.game.balken.x
	-- hb = höhe des balken
	local hb = wowon.game.balken.h

	if (y+r>h) then
		if (a>0 and a<90) then
			return 1, 2
		elseif (a>270 and a<360) then
			return 1, 6
		else
			return 1, 1
		end
	elseif (x-r<0) then
		if (a>270 and a<360) then
			return 7, 6
		else
			return 7, 5
		end
	elseif (x+r>b) then
		if (a>0 and a<90) then
			return 3, 2
		else
			return 3, 3
		end
	elseif (y-r<o) and (x>xb-bb/2) and (x<xb+bb/2) and (y-r>o-hb) then
		return "b"
	elseif (y-r<0) then
		return 5
	else
		return nil
	end

end


-- setzt den winkeln nach / einfallswinkel = ausfallswinkel
function wowon_geo_winkel (b, p, w)
-- b = ballnummer
-- p = aufprallpunkt
-- w = aufprallwinkel

	--wowon_debug("b="..b.." p="..p.." w="..w)

	local a = wowon.game.ball[b].w

	if (p == 1) then
		if (w == 1) then
			a = 180
		elseif (w == 2) then
			a = 180-a
		elseif (w == 6) then
			a = 540-a
		else
		end
	elseif (p == 3) then
		if (w == 2) then
			a = 360-a
		elseif (w == 3) then
			a = 360-a
		else
		end
	elseif (p == 7) then
		if (w == 6) then
			a = 360-a
		elseif (w == 5) then
			a = 360-a
		else
		end
	elseif (p == 5) then
		if (w == 5) then
			a = 540-a
		elseif (w == 3) then
			a = 180-a
		elseif (w == 4) then
			a = 0
		else
		end

	-- sonderfälle (eckwinkel)
	elseif (p == 2) then
		a = 225
	elseif (p == 8) then
		a = 135
	elseif (p == 6) then
		a = 45
	elseif (p == 4) then
		a = 315
	else
	end
	
	wowon.game.ball[b].w = a
	
end

-- setzt den winkeln nach / einfallswinkel = zufallwinkel
function wowon_geo_randomwinkel (b, p, w)
-- b = ballnummer
-- p = aufprallpunkt
-- w = aufprallwinkel

	--wowon_debug("b="..b.." p="..p.." w="..w)

	local a = wowon.game.ball[b].w

	--sperrtoleranz des winkel
	local x = 15

	if (p == 1) then
		--if (w == 1) or (w == 2) or (w == 6) then
			a = math.random(90+x,270-x)
			-- verhindern eines zu senkrechten winkels
			if (a < 190) and (a > 170) then
				if (a < 190) and (a > 180) then
					a = a+x
				else
					a = a-x
				end
			end
		--end
	elseif (p == 3) then
		--if (w == 2) or (w == 3) then
			a = math.random(180+x, 360-x)
			-- verhindern eines zu waggrechten winkels
			if (a < 280) and (a > 260) then
				if (a < 280) and (a > 270) then
					a = a+x
				else
					a = a-x
				end
			end
		--end
	elseif (p == 7) then
		--if (w == 6) or (w == 5) then
			a = math.random(0+x,180-x)
			-- verhindern eines zu waggrechten winkels
			if (a < 100) and (a > 80) then
				if (a < 100) and (a > 90) then
					a = a+x
				else
					a = a-x
				end
			end
		--end
	elseif (p == 5) then
		--if (w == 5) or (w == 3) or (w == 4) then
			a = math.random(0+x,180-x)
			-- verhindern eines zu senkrechten winkels
			if (a < 100) and (a > 80) then
				if (a < 100) and (a > 90) then
					a = a+x
				else
					a = a-x
				end
			end
			if (a > 90) then
				a = a-90
			else
				a = 360-4
			end
		--end

	-- sonderfälle (eckwinkel)
	elseif (p == 2) then
		a = math.random(180+x,270-x)
	elseif (p == 8) then
		a = math.random(90+x,180-x)
	elseif (p == 6) then
		a = math.random(0+x,90-x)
	elseif (p == 4) then
		a = math.random(270+x,360-x)
	else
	end
	
	wowon.game.ball[b].w = a
	
end

-- setzt den neuen winkel des balles nach aufprall auf den balken
function wowon_geo_winkel_balken (b)

	-- bx = x pos ball
	local bx = 	wowon.game.ball[b].x
	-- bb = balkenbreite
	local bb = wowon.game.balken.b
	-- bbx = balken pos x
	local bbx = wowon.game.balken.x
	
	-- wenn abprallwinkel zwischen 0 und 90 sein wird
	if (bx > bbx) then
		local x = bx-bbx
		-- prozentualer anteil der länge
		x = x*100/(bb/2)
		-- neuer winkel
		x = 60*(x/100)
		-- winkel setzen
		wowon.game.ball[b].w = x
		--wowon_debug ("b="..b.." w="..x)
	-- wenn abprallwinkel zwischen 270 und 0 sein wird
	elseif (bbx > bx) then
		local x = bbx-bx
		-- prozentualer anteil der länge
		x = x*100/(bb/2)
		-- neuer winkel
		x = 60*(x/100)
		-- winkel abziehen
		x = 360-x
		-- winkel setzen
		wowon.game.ball[b].w = x
		--wowon_debug ("b="..b.." w="..x)
	else
		wowon.game.ball[b].w = 0
	end
	
end
