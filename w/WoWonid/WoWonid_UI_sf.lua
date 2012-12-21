-- balken neu darstellen und einstellen
--	z.b. balkengrösse und textur  ändert sich
function wowon_UI_sf_balken_update ()

	-- balken variablen setzten lassen
	wowon_balk ()

	wowon_sf_balken:SetHeight(wowon.game.balken.h)
    wowon_sf_balken:SetWidth(wowon.game.balken.b)
    if (wowon.game.balken.t == nil) then
		wowon_sf_balken:SetTexture(wowon.game.balken.vc.r, wowon.game.balken.vc.g, wowon.game.balken.vc.b, wowon.game.balken.vc.a)	
    else
	    wowon_sf_balken:SetTexture (wowon.game.balken.t)
		wowon_sf_balken:SetVertexColor(wowon.game.balken.vc.r, wowon.game.balken.vc.g, wowon.game.balken.vc.b, wowon.game.balken.vc.a)
    end
	
end

-- balken bewegen
function wowon_UI_sf_balken_move ()
	local x = wowon.game.balken.x
	local o = wowon.game.feld.o
	wowon_sf_balken:SetPoint("TOP", "wowon_sf", "BOTTOMLEFT", x, o);
end


-- balken auf startposition setzen
function wowon_UI_sf_balken_start ()

	local x = wowon.game.feld.x
	local y = wowon.game.feld.y
	local o = wowon.game.feld.o

	wowon_sf_balken:SetPoint("TOP", "wowon_sf", "BOTTOMLEFT", x/2, o)
	
end

-- ball erstellen
-- wird nur aufgerufen wenn kein ball frei ist
function wowon_UI_sf_ball_creat ()
	-- wieviele bälle existieren schon?
	local b = nil
	if (wowon.game.balle == nil) then
		b = 0
	else
		b = table.getn(wowon.game.balle)
	end
	b = b+1
	-- ball erstellen
	wowon_sf:CreateTexture("wowon_sf_b"..b, "OVERLAY")
	-- parent zuweisen
	getglobal("wowon_sf_b"..b):SetParent("wowon_sf")
	-- neuer ball hinzufügen
	table.insert(wowon.game.ballfrei, b)
end

-- ball updaten
function wowon_UI_sf_ball_update (b)
-- b = ballnummer
	-- ball variablen setzen
	wowon_ball (b)
	getglobal("wowon_sf_b"..b):SetHeight(wowon.game.ball[b].r*2)
	getglobal("wowon_sf_b"..b):SetWidth(wowon.game.ball[b].r*2)
    if (wowon.game.ball[b].t == nil) then
		getglobal("wowon_sf_b"..b):SetTexture(wowon.game.ball[b].vc.r, wowon.game.ball[b].vc.g, wowon.game.ball[b].vc.b, wowon.game.ball[b].vc.a)	
    else
	    getglobal("wowon_sf_b"..b):SetTexture (wowon.game.ball[b].t)
		getglobal("wowon_sf_b"..b):SetVertexColor(wowon.game.ball[b].vc.r, wowon.game.ball[b].vc.g, wowon.game.ball[b].vc.b, wowon.game.ball[b].vc.a)
    end
end

-- ball auf startposition setzen
function wowon_UI_sf_ball_start (b)
-- b = ballnummer
	getglobal("wowon_sf_b"..b):SetPoint("CENTER", "wowon_sf_balken", "TOP", 0, wowon.game.ball[b].r)
	getglobal("wowon_sf_b"..b):Show()
end

-- f-ball auf startposition setzen
function wowon_UI_sf_feldball_start (b)
-- b = ballnummer
	getglobal("wowon_sf_b"..b):SetPoint("CENTER", "wowon_sf", "BOTTOMLEFT", wowon.game.ball[b].x, wowon.game.ball[b].y)
	getglobal("wowon_sf_b"..b):Show()
end

-- ball bewegen
function wowon_UI_ball_move (b)
-- b = ballnummer
	getglobal("wowon_sf_b"..b):SetPoint("CENTER", "wowon_sf", "BOTTOMLEFT", wowon.game.ball[b].x, wowon.game.ball[b].y)
end

-- ball verdecken
function wowon_UI_sf_ball_hide (b)
-- b = ballnummer
	getglobal("wowon_sf_b"..b):Hide()
end

-- feld verdecken
function wowon_UI_sf_feld_hide (f)
-- f = feldnummer
	getglobal("wowon_sf_f"..f):Hide()
end

-- feld erstellen
-- wird nur aufgerufen wenn kein feld frei ist
function wowon_UI_sf_feld_creat ()
	-- wieviele felder existieren schon?
	local f = nil
	if (wowon.game.felder == nil) then
		f = 0
	else
		f = table.getn(wowon.game.felder)
	end
	f = f+1
	-- feld erstellen
	wowon_sf:CreateTexture("wowon_sf_f"..f, "ARTWORK")
	-- parent zuweisen
	getglobal("wowon_sf_f"..f):SetParent("wowon_sf")
	-- neues feld hinzufügen
	table.insert(wowon.game.feldfrei, f)
end

-- feld updaten
function wowon_UI_sf_feld_update (f)
-- f = feldnummer
	
	-- feld variablen setzen
	wowon_feld (f)

	getglobal("wowon_sf_f"..f):SetHeight(wowon.game.feld[f].h)
	getglobal("wowon_sf_f"..f):SetWidth(wowon.game.feld[f].b)
    if (wowon.game.feld[f].t == nil) then
		getglobal("wowon_sf_f"..f):SetTexture(wowon.game.feld[f].vc.r, wowon.game.feld[f].vc.g, wowon.game.feld[f].vc.b, wowon.game.feld[f].vc.a)	
    else
	    getglobal("wowon_sf_f"..f):SetTexture (wowon.game.feld[f].t)
		getglobal("wowon_sf_f"..f):SetVertexColor(wowon.game.feld[f].vc.r, wowon.game.feld[f].vc.g, wowon.game.feld[f].vc.b, wowon.game.feld[f].vc.a)
    end
end

-- feld zeigen und setzen
function wowon_UI_sf_feld_start (f)
-- f = feldnummer

	local x = wowon.game.feld[f].x
	local y = wowon.game.feld[f].y

	getglobal("wowon_sf_f"..f):SetPoint("BOTTOMLEFT", "wowon_sf", "BOTTOMLEFT", x, y)
	getglobal("wowon_sf_f"..f):Show()
end


function wowon_UI_sf_string (x)
-- x = false = gameover
-- x = true = done
	wowon_sf_text:Show()
	if (x == false) then
		wowon_sf_text:SetText("Game Over")
	elseif (x == true) then
		wowon_sf_text:SetText("Level Done!")	
	end
end
