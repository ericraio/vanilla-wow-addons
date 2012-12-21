function Tetris_gost_stone ()
	if (Tetris["options"]["gost"] == 1) then
		Tetris_stone_gost_pos ();
	end
end


function Tetris_stone_gost_hide ()
	--variablen holen und setzen
	local anz_s = Tetris["game"]["s_anz_s"];
	local textur = Tetris["options"]["texturenset"];
	if ( Tetris["game"]["s_gost"]["temp"]["save"] == 1) then
		--textur ändern
		for s = 1, anz_s do
			local s_pos = Tetris["game"]["s_gost"]["temp"][s];
			getglobal("Tetris_"..s_pos):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\0");
		end
		
		if (Tetris["debug"]==1) then
			DEFAULT_CHAT_FRAME:AddMessage("Hide Ex-Gost");
		end
	end
end

--aktuelle neue position des gost-bausteins speichern
function Tetris_gost_stone_save ()
	--variablen holen und setzen
	local anz_s = Tetris["game"]["s_anz_s"];	
	--liste erstellen
	for s = 1, anz_s do
		--pos des berechneten steins auslesen
		local pos = Tetris["game"]["s_gost"][s];
		--pos des steines als string im temp speichern
		Tetris["game"]["s_gost"]["temp"][s]=pos;
	end
	Tetris["game"]["s_gost"]["temp"]["save"] = 1;
end

function Tetris_stone_gost_show ()
	--variablen holen und setzen	
	local stone = Tetris["game"]["s"];	
	local anz_s = Tetris["game"]["s_anz_s"];
	local textur = Tetris["options"]["texturenset"];
	--textur ändern
	for s = 1, anz_s do
		local s_pos = Tetris["game"]["s_gost"][s];
		getglobal("Tetris_"..s_pos):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\g");
	end
end

function Tetris_stone_gost_pos (minus)
--minus = anzahl der felder nach unten
	--variablen holen und setzen
	local anz_l = Tetris["game"]["s_anz_l"];
	local s_l = Tetris["game"]["s_lage"];
	local pos_y = Tetris["game"]["s_pos_y"];
	
	--änderungen speichern
	if (minus == nil) then
		Tetris["game"]["s_gost"]["s_pos_y"] = pos_y;
	else
		Tetris["game"]["s_gost"]["s_pos_y"] = pos_y+minus;
	end
		
	--neue position der steine berechnen
	Tetris_falling_gost_stone_coming_soon();
	--test laufen lassen und reagieren
	if (Tetris_gost_stone_outside_test()==true) then
		--gost stein ist unten
		Tetris_stone_gost_is_down ();
	else
		--gost stein ist nicht unten
		if (minus == nil) then
			Tetris_stone_gost_pos (1);
		else
			local minus = minus-1;
			Tetris_stone_gost_pos (minus);
		end		
	end	
end

--position des zukünftigen gost-bausteins berechnen
function Tetris_falling_gost_stone_coming_soon ()
	--variablen holen und setzen
	local stone = Tetris["game"]["s"];
	local s_lage = Tetris["game"]["s_lage"];
	local x_pos = Tetris["game"]["s_pos_x"];
	local y_pos = Tetris["game"]["s_gost"]["s_pos_y"];
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
		Tetris["game"]["s_gost"][s]="x"..s_x.."y"..s_y;
	end
end

function Tetris_gost_stone_outside_test ()
	--variablen holen und setzen
	local anz_s = Tetris["game"]["s_anz_s"];
	--liste erstellen
	for s = 1, anz_s do
		--pos des berechneten steins auslesen
		local pos_string = Tetris["game"]["s_gost"][s];
		--pos x y als zahlen holen
		local pos_xy = Tetris_return_xy(pos_string);
		local pos_x = pos_xy["x"];
		local pos_y = pos_xy["y"]-1;
		--überprüfen ob stein auserhalb spielfeld
		if (pos_y < 1) then
			--stein ist nicht im spielfeld
			return true;
		else
			--überprüfen ob stein schon besetzt ist
			local pos = "x"..pos_x.."y"..pos_y;
			if not (Tetris["game"]["feld"][pos] == 0) then
				return true;
			end
		end
	end
	--keine ungültige oder besetzte steine gefunden
	return false;
end

function Tetris_stone_gost_is_down ()
	Tetris_stone_gost_hide ();
	Tetris_gost_stone_save ();
	Tetris_stone_gost_show ();
end
