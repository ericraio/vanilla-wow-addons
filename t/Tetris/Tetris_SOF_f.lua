function Tetris_SOF_Toggle()
	if(Tetris_SOF:IsVisible()) then
		Tetris_SOF:Hide();
	else
		Tetris_SOF_clear();
		Tetris_SOF_update();
		Tetris_SOF:Show();
	end
end


function Tetris_SOF_clear()
	--variablen holen und setzen
	local textur = Tetris["options"]["texturenset"];
	local spalten = 4;
	local zeilen = 3;
	--textur ändern
	for num = 1, 9 do
		for spalte = 1, spalten do
			for zeile = 1, zeilen do
				getglobal("Tetris_SOF_num"..num.."_x"..spalte.."y"..zeile):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\0");
			end
		end
	end
	--verdecken
	for num = 1, 9 do
		getglobal("Tetris_SOF_num"..num):Hide();
	end
end

function Tetris_SOF_update()
	--variablen holen und setzen
	local show_s = Tetris["options"]["SOF_s_show"];
	local max_s = Tetris["options"]["max_s"];
	local text = Tetris_UBE_SOF_piece;
	

	--stones/text/checkbox in den fenstern anzeigen
	local num = 1;
	for stone = show_s, max_s do
		--stein anzeigen
		Tetris_SOF_stone_Show (stone, num);
		--text ändern
		getglobal("Tetris_SOF_num"..num.."_text"):SetText(text.." "..stone);
		--checkbox setzen
		local check = Tetris["options"]["stones"][stone];
		getglobal("Tetris_SOF_num"..num.."_c"):SetChecked(check);
		--seitentext ändern
		local show_s2 = show_s+9-1;
		if show_s2>max_s then
			show_s2 = max_s;
		end
		Tetris_SOF_s_Text:SetText(show_s.."-"..show_s2);
		--nächste schlaufe
		num = num+1;
		if num > 9 then
			break;
		end
	end
end

function Tetris_SOF_stone_Show (stein, num)
	--variablen holen und setzen
	local stone = stein;
	local s_lage = 1;
	local x_pos = 3;
	local y_pos = 3;
	local textur = Tetris["options"]["texturenset"];
	local fenster = num;
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
		--pos des steines als string
		local pos="x"..s_x.."y"..s_y;
		--textur ändern
		getglobal("Tetris_SOF_num"..num.."_"..pos):SetNormalTexture ("Interface\\AddOns\\Tetris\\texturen\\"..textur.."\\"..stone);
		--fenster anzeigen
		getglobal("Tetris_SOF_num"..num):Show();		
	end
end

function Tetris_SOF_b_Click()
	local button = this:GetName();
	if (button == "Tetris_SOF_b_Ok") then 
		Tetris_SOF_Toggle();
		Tetris_CF_Toggle();
	end
	if (button == "Tetris_SOF_b_Next") then 
		local show_s = Tetris["options"]["SOF_s_show"];
		local max_s = Tetris["options"]["max_s"];
		local show_s_next = show_s+9;
		if show_s_next>max_s then
			Tetris["options"]["SOF_s_show"] = 1;
		else
			Tetris["options"]["SOF_s_show"] = show_s_next;
		end
		Tetris_SOF_clear();
		Tetris_SOF_update();
	end	
	if (button == "Tetris_SOF_b_Back") then 
		local show_s = Tetris["options"]["SOF_s_show"];
		local max_s = Tetris["options"]["max_s"];
		local show_s_next = show_s-9;
		if show_s_next<1 then
			Tetris["options"]["SOF_s_show"] = max_s-(math.mod(max_s,9))+1;
		else
			Tetris["options"]["SOF_s_show"] = show_s_next;
		end
		Tetris_SOF_clear();
		Tetris_SOF_update();
	end	
end

function Tetris_SOF_c_Click()
	local checkbox = this:GetName();
	local show_s = Tetris["options"]["SOF_s_show"];
	local checkboxnum = string.sub(checkbox, 15, 15);
	--für welchen stein galt diese checkbox
	local s_num = show_s+checkboxnum-1;
	--was zeigt diese checkbox an
	local checkstatus = getglobal(checkbox):GetChecked();
	if (checkstatus == 1) then
		checkstatus = 1;
	else
		checkstatus = 0;
	end
	--änderung im stonetable speichern
	table.remove(Tetris["options"]["stones"],s_num)
	table.insert(Tetris["options"]["stones"],s_num,checkstatus)
end
