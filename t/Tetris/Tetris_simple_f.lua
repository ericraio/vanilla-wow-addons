function Tetris_stone_outside_test ()
	--variablen holen und setzen
	local spalten = Tetris["game"]["x"];
	local zeilen = Tetris["game"]["y"];
	local anz_s = Tetris["game"]["s_anz_s"];
	--liste erstellen
	for s = 1, anz_s do
		--pos des berechneten steins auslesen
		local pos_string = Tetris["game"]["s_temp"]["temp"][s];
		--pos x y als zahlen holen
		local pos_xy = Tetris_return_xy(pos_string);
		local pos_x = pos_xy["x"];
		local pos_y = pos_xy["y"];
		--überprüfen ob stein auserhalb spielfeld
		if ((pos_x > spalten) or (pos_x < 1) or (pos_y > zeilen) or (pos_y < 1)) then
			--stein ist nicht im spielfeld
			return true;
		else
			--überprüfen ob stein schon besetzt ist
			if not (Tetris["game"]["feld"][pos_string] == 0) then
				return true;
			end
		end
	end
	--keine ungültige oder besetzte steine gefunden
	return false;
end

--position des zukünftigen bausteins berechnen
function Tetris_falling_stone_coming_soon ()
	--variablen holen und setzen
	local stone = Tetris["game"]["s"];
	local s_lage = Tetris["game"]["s_lage"];
	local x_pos = Tetris["game"]["s_pos_x"];
	local y_pos = Tetris["game"]["s_pos_y"];
	local anz_s = Tetris["game"]["s_anz_s"];	
	--pos der steine über diesen baustein in dieser lage holen
	local infos = Tetris_baustein (stone, 2, s_lage);
	--liste erstellen
	for s = 1, anz_s do
		--relative pos des steins zum nullpunkt des bausteins als string
		local r_string_s_pos = infos[s];
		--zahlen auslesen
		local r_s_pos = Tetris_return_xy(r_string_s_pos);
		local r_s_x = r_s_pos["x"];
		local r_s_y = r_s_pos["y"];
		--absolute pos des steins im gamewindow
		local s_x = x_pos+r_s_x;
		local s_y = y_pos+r_s_y;
		--pos des steines als string im temp speichern
		Tetris["game"]["s_temp"]["temp"][s]="x"..s_x.."y"..s_y;
	end
end

--aktuelle neue position des bausteins speichern
function Tetris_falling_stone ()
	--variablen holen und setzen
	local anz_s = Tetris["game"]["s_anz_s"];	
	--liste erstellen
	for s = 1, anz_s do
		--pos des berechneten steins auslesen
		local pos = Tetris["game"]["s_temp"]["temp"][s];
		--pos des steines als string im temp speichern
		Tetris["game"]["s_temp"][s]=pos;
	end
end

--aktueller baustein in feldliste speichern
function Tetris_save_stone ()
	--variablen holen und setzen
	local anz_s = Tetris["game"]["s_anz_s"];
	local stone = Tetris["game"]["s"];
	--in liste speichern
	for s = 1, anz_s do
		--pos des aktuellen steins auslesen
		local pos = Tetris["game"]["s_temp"][s];
		--pos des steines im feld speichern
		Tetris["game"]["feld"][pos]=stone;
	end
end

--return pos x_y als zahlen im table zurück
function Tetris_return_xy(string_xy)
	local suchx = string.find(string_xy, "x", 1);
	local suchy = string.find(string_xy, "y", 1);
	local stringleng = string.len(string_xy);
	local x_pos = tonumber(string.sub(string_xy,suchx+1,suchy-1));
	local y_pos = tonumber(string.sub(string_xy,suchy+1,stringleng));
	local pos = {["x"]=x_pos, ["y"]=y_pos};
	return pos;
end

--feldliste erstellen
function Tetris_fieldlist_create ()
	--variablen holen und setzen
	local spalten = Tetris["game"]["x"];
	local zeilen = Tetris["game"]["y"];
	--vorherige gespeicherte angaben löschen
	Tetris["game"]["feld"]= { };
	--liste erstellen
	for spalte = 1, spalten do
		for zeile = 1, zeilen do
			Tetris["game"]["feld"]["x"..spalte.."y"..zeile]=0;
		end
	end
end

--überprüfen ob eine linie fertig ist
--wenn ja, nummer der linie durchgeben
--wenn nein, 0 durchgeben
function Tetris_complet_zeile_test ()
	--variablen holen und setzen
	local spalten = Tetris["game"]["x"];
	local zeilen = Tetris["game"]["y"];
	local zahler = 0
	for zeile = 1, zeilen do
		local zahler = 0
		for spalte = 1, spalten do
			--überprüfen ob dieses feld 0 ist
			if (Tetris["game"]["feld"]["x"..spalte.."y"..zeile]==0) then
				--weiter zur nächsten zeile
				spalte = spalten+1;
			else
				--volles feld gefunden
				zahler = zahler+1;
			end
			
		end
		--überprüfen ob die gerade überprüfte zeile voll ist
		if (zahler == spalten) then
			return zeile;
		end
	end
	return 0;
end

function Tetris_delet_line (linie)
--linie = zeile die gelöscht werden muss
	if (Tetris["debug"]==1) then
		DEFAULT_CHAT_FRAME:AddMessage("Delet Linie "..linie);
	end
	--variablen holen und setzen
	local spalten = Tetris["game"]["x"];
	local zeilen = Tetris["game"]["y"];
	for zeile=1 , zeilen-linie do
		for spalte = 1, spalten do
			--nummer des oberen feldes auslesen
			local field_nr = Tetris["game"]["feld"]["x"..spalte.."y"..zeile+linie];
			--nummer ins untere feld schreiben
			Tetris["game"]["feld"]["x"..spalte.."y"..zeile+linie-1] = field_nr;
		end
	end
end

function Tetris_random_stone (anz_s)
	--variablen holen und setzen
	local zufall = math.random(anz_s);
	return zufall;
end

function Tetris_release_stone ()
	--variablen holen und setzen
	local s_next = Tetris["game"]["s_next"];
	local spalten = Tetris["game"]["x"];
	local anz_s = Tetris["game"]["stones"]["anz_stones"];
	local s = "";
	--überprüfen ob der nächste stein bekannt ist
	if (s_next == 0) then
		--zufalls-stein generieren
		local zufall = Tetris_random_stone (anz_s)
		--stein holen dem diese zufallszahl zugeordnet ist
		s = Tetris["game"]["stones"][zufall];
	--nächster stein bekannt
	else
		s = s_next;
	end	
	--infos über diesen stein holen
	local infos = Tetris_baustein (s, 1)
	local anz_lagen = infos[1];
	local anz_steine = infos[2];
	--baustein-nullpunkt setzen
	local x = spalten/2;
	local x = math.ceil(x)+1;
	local y = Tetris["game"]["y"];
	--nächster zufallstein generieren
	local zufall = Tetris_random_stone (anz_s);
	local s_next = Tetris["game"]["stones"][zufall];
	Tetris["game"]["s_next"] = s_next;
	--alle angaben speichern
	Tetris["game"]["s"]=s;
	Tetris["game"]["s_anz_s"]=anz_steine;
	Tetris["game"]["s_anz_l"]=anz_lagen;
	Tetris["game"]["s_lage"]=1;
	Tetris["game"]["s_pos_x"]=x;
	Tetris["game"]["s_pos_y"]=y;
	if (Tetris["debug"]==1) then
		DEFAULT_CHAT_FRAME:AddMessage("This Stone="..s.." Next Stone="..s_next);
	end
end

--position des zukünftigen bausteins berechnen, für NS
function Tetris_falling_stone_coming_soon_NS ()	
	--variablen holen und setzen
	local stone = Tetris["game"]["s_next"];
	local s_lage = 1;
	local x_pos = math.ceil(Tetris["game"]["NS_x"]/2+1);
	local y_pos = Tetris["game"]["NS_y"];
	--anz. steine die dieser baustein hat holen
	local info_anz_s = Tetris_baustein (stone, 1);
	local anz_s = info_anz_s[2];
	--pos der steine über diesen baustein in dieser lage holen
	local infos = Tetris_baustein (stone, 2, s_lage);
	--liste erstellen
	for s = 1, anz_s do
		--relative pos des steins zum nullpunkt des bausteins als string
		local r_string_s_pos = infos[s];
		--zahlen auslesen
		local r_s_pos = Tetris_return_xy(r_string_s_pos);
		local r_s_x = r_s_pos["x"];
		local r_s_y = r_s_pos["y"];
		--absolute pos des steins im gamewindow
		local s_x = x_pos+r_s_x;
		local s_y = y_pos+r_s_y;
		--pos des steines als string im temp speichern
		Tetris["game"]["s_NS_temp"][s]="x"..s_x.."y"..s_y;
	end
end

function Tetris_ingame(nr)
--nr = neuer ingamestatus
	if (nr == 0) then
		Tetris["ingame"]=0;
		Tetris_GF_b_pause:Disable();
		Tetris_GF_BF_l:Disable();
		Tetris_GF_BF_u:Disable();
		Tetris_GF_BF_r:Disable();
		Tetris_GF_BF_d:Disable();
	end
	if (nr == 1) then
		Tetris["ingame"]=1;
		Tetris_GF_b_pause:Enable();
		Tetris_GF_BF_l:Enable();
		Tetris_GF_BF_u:Enable();
		Tetris_GF_BF_r:Enable();
		Tetris_GF_BF_d:Enable();
	end		
end

function Tetris_stonelist_create ()
	local max_s = Tetris["options"]["max_s"];
	Tetris["game"]["stones"] = { };
	for s = 1, max_s do
		local status = Tetris["options"]["stones"][s];
		if status == 1 then
			table.insert(Tetris["game"]["stones"],s)
		end	
	end
	--falls kein stein gewählt ist
	local anz_s = table.getn(Tetris["game"]["stones"]);
	if (anz_s < 1) then
		Tetris["game"]["stones"]["anz_stones"]=1;
		table.insert(Tetris["options"]["stones"],1)
	else
		Tetris["game"]["stones"]["anz_stones"]=anz_s;	
	end
end

function Tetris_creat_custom_lines (lines)
--lines = anzahl linien
	--variablen holen und setzen
	local spalten = Tetris["game"]["x"];
	local zeilen = Tetris["game"]["y"];
	local max_s = Tetris["options"]["max_s"];
	
	for zeile = 1, lines do
		for spalte = 1, spalten do
			local zufall = Tetris_random_stone(2);
			if (zufall == 1) then
				local zufall = Tetris_random_stone(max_s);
				Tetris["game"]["feld"]["x"..spalte.."y"..zeile] = zufall;
			end
		end
	end	
end
