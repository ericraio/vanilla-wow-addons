function Tetris_GF_Toggle()
	if(Tetris_GF:IsVisible()) then
		Tetris_GF:Hide();
		Tetris_play_musik ("stop");
	else
		Tetris_GF_SetFramesPos();
		Tetris_GF:Show();
		Tetris_play_musik ("game");
	end
end

function Tetris_GF_BF_Button_Click()
	local ingame = Tetris["ingame"];
	local button = this:GetName();
	--nur reagieren wenn ingame
		if (ingame == 1) then
		--downbutton
		if (button == "Tetris_GF_BF_d") then
			Tetris_stone_move ("d");
		end
		--upbutton
		if (button == "Tetris_GF_BF_u") then
			Tetris_stone_move ("u");
		end
		--linksbutton
		if (button == "Tetris_GF_BF_l") then
			Tetris_stone_move ("l");
		end
		--rechtsbutton
		if (button == "Tetris_GF_BF_r") then
			Tetris_stone_move ("r");
		end		
	end
end

function Tetris_GF_Button_Click()
	local button = this:GetName();
	--close
	if (button == "Tetris_GF_b_close") then 
		Tetris_gf_buttonclick ("close");
	end
	--newgame
	if (button == "Tetris_GF_b_newgame") then 
		Tetris_gf_buttonclick ("newgame");
	end
	--pause
	if (button == "Tetris_GF_b_pause") then 
		Tetris_gf_buttonclick ("pause");
	end
end

function Tetris_GF_gamewindow_falling_stone_Show ()
	--variablen holen und setzen
	local stone = Tetris["game"]["s"];	
	local anz_s = Tetris["game"]["s_anz_s"];
	local textur = Tetris["options"]["texturenset"];
	--textur ändern
	for s = 1, anz_s do
		local s_pos = Tetris["game"]["s_temp"][s];
		getglobal("Tetris_"..s_pos):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\"..stone);
	end
end

function Tetris_GF_gamewindow_falling_stone_Hide ()
	--variablen holen und setzen
	local anz_s = Tetris["game"]["s_anz_s"];
	local textur = Tetris["options"]["texturenset"];
	--textur ändern
	for s = 1, anz_s do
		local s_pos = Tetris["game"]["s_temp"][s];
		getglobal("Tetris_"..s_pos):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\0");
	end
end

--gamewindow und framegrösse einstellen
function Tetris_GF_create ()
	--variablen holen und setzen
	local spalten = Tetris["game"]["x"];
	local zeilen = Tetris["game"]["y"];
	local b_hohe = Tetris["options"]["b_hohe"];
	local b_breite = Tetris["options"]["b_breite"];
	local abstand_x = Tetris["options"]["r_abstand_x"];
	local abstand_y = Tetris["options"]["r_abstand_y"];
	local faktor_x = Tetris["options"]["r_a-faktor_x"];
 	local faktor_y = Tetris["options"]["r_a-faktor_y"];
	--GF grösse einstellen
	local gf_h = 2*abstand_y+zeilen*b_hohe+faktor_y;
	local gf_b = 2*abstand_x+spalten*b_breite+faktor_x;
	--falls fenster zu klein
	if (gf_h<455) then
		abstand_y = abstand_y+(455-gf_h)/2;
		Tetris_GF:SetHeight(455);
	else
	Tetris_GF:SetHeight(gf_h);
	end
	if (gf_b<410) then
		abstand_x = abstand_x+(410-gf_b)/2;
		Tetris_GF:SetWidth(410);	
	else
		Tetris_GF:SetWidth(gf_b);
	end
	--gamewindow erstellen
	for spalte = 1, spalten do --x position
		for zeile = 1, zeilen do --y position
			--stonename erstellen (position)
			local x = spalte;
			local y = zeile;
			local stonename = "Tetris_x"..x.."y"..y.."";
			--stonefeld verschieben, grösse anpassen und anzeigen
			local x_pos = spalte*b_breite+abstand_x-b_breite;
			local y_pos = zeile*b_hohe+abstand_y-b_hohe;
			getglobal(stonename):SetParent("Tetris_GF");
			getglobal(stonename):SetPoint("BOTTOMLEFT", "Tetris_GF", "BOTTOMLEFT", ""..x_pos.."", ""..y_pos.."");
			getglobal(stonename):SetHeight(b_hohe);
			getglobal(stonename):SetWidth(b_breite);
			getglobal(stonename):Show();
		end
	end
end

function Tetris_GF_gamewindow_Update ()
	--variablen holen und setzen
	local spalten = Tetris["game"]["x"];
	local zeilen = Tetris["game"]["y"];
	local textur = Tetris["options"]["texturenset"];

	--feldnummer aus fieldliste holen und setzen
	for spalte = 1, spalten do
		for zeile = 1, zeilen do
			local f_nr = Tetris["game"]["feld"]["x"..spalte.."y"..zeile];
			getglobal("Tetris_x"..spalte.."y"..zeile):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\"..f_nr);
		end
	end
end

function Tetris_GF_gamewindow_Clear ()
	--variablen holen und setzen
	local spalten = 50;
	local zeilen = 50;
	--alles löschen
	for spalte = 1, spalten do
		for zeile = 1, zeilen do
			getglobal("Tetris_x"..spalte.."y"..zeile):SetParent("Tetris_TEMP");
			--getglobal("Tetris_x"..spalte.."y"..zeile):Hide();
		end
	end
end

function Tetris_GF_NS_create ()
	--variablen holen und setzen
	local spalten = Tetris["game"]["NS_x"];
	local zeilen = Tetris["game"]["NS_y"];
	local b_hohe = Tetris["options"]["b_NS_hohe"];
	local b_breite = Tetris["options"]["b_NS_breite"];
	local abstand_x = Tetris["options"]["r_NS_abstand_x"];
	local abstand_y = Tetris["options"]["r_NS_abstand_y"];
	local faktor_x = Tetris["options"]["r_a_NS-faktor_x"];
	local faktor_y = Tetris["options"]["r_a_NS-faktor_y"];
	--GF_NS grösse einstellen
	local gf_h = 2*abstand_y+zeilen*b_hohe+faktor_y;
	local gf_b = 2*abstand_x+spalten*b_breite+faktor_x;
	Tetris_GF_NS:SetHeight(gf_h);
	Tetris_GF_NS:SetWidth(gf_b);
	--gamewindow erstellen
	for spalte = 1, spalten do --x position
		for zeile = 1, zeilen do --y position
			--stonename erstellen (position)
			local x = spalte;
			local y = zeile;
			local stonename = "Tetris_NS_x"..x.."y"..y.."";
			--stonefeld verschieben, grösse anpassen und anzeigen
			local x_pos = spalte*b_breite+abstand_x-b_breite;
			local y_pos = zeile*b_hohe+abstand_y-b_hohe;
			getglobal(stonename):SetPoint("BOTTOMLEFT", "Tetris_GF_NS", "BOTTOMLEFT", ""..x_pos.."", ""..y_pos.."");
			getglobal(stonename):SetHeight(b_hohe);
			getglobal(stonename):SetWidth(b_breite);
			getglobal(stonename):Show();
		end
	end
end

function Tetris_GF_NS_Show ()
	--variablen holen und setzen
	local textur = Tetris["options"]["texturenset"];
	local stone = Tetris["game"]["s_next"];
	--anz. steine die dieser baustein hat holen
	local info_anz_s = Tetris_baustein (stone, 1);
	local anz_s = info_anz_s[2];

	--textur ändern
	for s = 1, anz_s do
		local s_pos = Tetris["game"]["s_NS_temp"][s];
		getglobal("Tetris_NS_"..s_pos):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\"..stone);
	end
end

function Tetris_GF_NS_Clear ()
	--variablen holen und setzen
	local textur = Tetris["options"]["texturenset"];
	local spalten = Tetris["game"]["NS_x"];
	local zeilen = Tetris["game"]["NS_y"];
	--textur ändern
	for spalte = 1, spalten do
		for zeile = 1, zeilen do
			getglobal("Tetris_NS_x"..spalte.."y"..zeile):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\0");
		end
	end
end

function Tetris_GF_Text_Score_Update ()
	--variablen holen und setzen
	local points = Tetris["game"]["score"]["points"];		
	local lvl = Tetris["game"]["score"]["lvl"];
	local line = Tetris["game"]["score"]["linie"];
	local UBS_points = Tetris_UBE_GF_SF_Text_Score_punkte;
	local UBS_lvl = Tetris_UBE_GF_SF_Text_Score_lvl;
	local UBS_line = Tetris_UBE_GF_SF_Text_Score_line;
	
	--text updaten
	Tetris_GF_SF_Text_Score:SetText(UBS_points.." "..points.."\n"..UBS_lvl.." "..lvl.."\n"..UBS_line.." "..line)
end

--Tetris_GF_SF
--Tetris_GF_BF
--Tetris_GF_NS
--Tetris_GF_b_pause
--Tetris_GF_b_newgame

function Tetris_GF_SetFramesPos ()
	--variablen holen und setzen
	local SF_h = Tetris_GF_SF:GetHeight();
	local SF_b = Tetris_GF_SF:GetWidth();
	local BF_h = Tetris_GF_BF:GetHeight();
	local BF_b = Tetris_GF_BF:GetWidth();
	local NS_h = Tetris_GF_NS:GetHeight();
	local NS_b = Tetris_GF_NS:GetWidth();
    local r_a_x = Tetris["options"]["r_abstand_x"];
    local r_a_y = Tetris["options"]["r_abstand_y"];
	local faktor_x = Tetris["options"]["r_a-faktor_x"];
	local faktor_y = Tetris["options"]["r_a-faktor_y"];
	
	local SF_x = (r_a_x+faktor_x)/2-SF_b/2;
	local BF_x = (r_a_x+faktor_x)/2-BF_b/2;
	local NS_x = (r_a_x+faktor_x)/2-NS_b/2;

	local NS_y = r_a_y+faktor_y+12;
	local BF_y = 2*r_a_y+25;

	getglobal("Tetris_GF_SF"):SetPoint("RIGHT", "Tetris_GF", "RIGHT", -SF_x, 0);
	getglobal("Tetris_GF_BF"):SetPoint("BOTTOMRIGHT", "Tetris_GF", "BOTTOMRIGHT", -BF_x, BF_y);
	getglobal("Tetris_GF_NS"):SetPoint("TOPRIGHT", "Tetris_GF", "TOPRIGHT", -NS_x, -NS_y);
	
	getglobal("Tetris_GF_b_pause"):SetPoint("BOTTOMRIGHT", "Tetris_GF", "BOTTOMRIGHT", -BF_x-BF_b+70, r_a_y);
	getglobal("Tetris_GF_b_newgame"):SetPoint("BOTTOMRIGHT", "Tetris_GF", "BOTTOMRIGHT", -BF_x, r_a_y);	

end

function Tetris_GF_timer_Update ()
	local timer = Tetris["game"]["timer_go"];
	local pause = Tetris_UBE_GF_b_pause_pause;
	local resume = Tetris_UBE_GF_b_pause_resume;
	if (timer == 1) then
		Tetris_GF_b_pause:SetText(pause);
		Tetris_GF_BF_l:Enable();
		Tetris_GF_BF_u:Enable();
		Tetris_GF_BF_r:Enable();
		Tetris_GF_BF_d:Enable();
	end
	if (timer == 0) then
		Tetris_GF_b_pause:SetText(resume);
		Tetris_GF_BF_l:Disable();
		Tetris_GF_BF_u:Disable();
		Tetris_GF_BF_r:Disable();
		Tetris_GF_BF_d:Disable();
	end
end
