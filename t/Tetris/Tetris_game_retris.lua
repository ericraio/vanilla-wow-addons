function Tetris_stone_is_down_retris (r)
	local linie = Tetris["game"]["score"]["linie"];
	local lines = 0;
	--stein in feldliste speichern
	Tetris_save_stone ();
	--überprüfen ob eine linie komplett ist
	while 1 do
		local ergebnis = Tetris_complet_zeile_test ();
		if (ergebnis == 0) then
			break
		else
			--linie löschen und steine runterfallen lassen
			Tetris_delet_line (ergebnis);
			--linie um 1 erhöhen
			linie = linie + 1;
			--anzahl der linien speichern
			lines = lines +1;
			Tetris_GF_gamewindow_Update ();
		end
	end
	--linie speichern
	Tetris["game"]["score"]["linie"] = linie ;
	--score berechnen
	Tetris_score_handler_retris (r, lines);
	--eventuell lvlup ?
	Tetris_lvl_handler_retris ();
	Tetris_new_stone ();
	--sound
	if (lines == 4) then
		Tetris_play_sound ("tet");
	else
		if (lines == 0) then
			Tetris_play_sound ("d");			
		else
			Tetris_play_sound ("dl");
		end	
	end
end

function Tetris_gameover_retris ()
	--variablen holen und setzen
	local highscore = Tetris["highscore"]["retris"];
	local score = Tetris["game"]["score"]["points"];
	--score speichern
	if (score > highscore) then
		Tetris["highscore"]["retris"] = score;
		Tetris_GF_highscore_Show ();
	end
	--ingamestatus ändern
	Tetris_ingame (0);
end

function Tetris_newgame_retris ()
		local ingame = Tetris["ingame"];
		if (ingame == 1) then
			Tetris_gameover ();
		end
		--alles reseten
        Tetris["game"]= { };
        Tetris["game"]["feld"]= { };
        Tetris["game"]["s_temp"]= { };
		Tetris["game"]["s_temp"]["temp"]= { }; 
        Tetris["game"]["s_NS_temp"]= { };  
        Tetris["game"]["s_gost"] = { };
        Tetris["game"]["s_gost"]["temp"] = { };
		--spiel typ
		Tetris["game"]["gametyp"]=3;
		Tetris["game"]["gametypc"]=0;
        --x spalten
        Tetris["game"]["x"]=30;
        --y zeilen
        Tetris["game"]["y"]=40;
        --x NS spalten
        Tetris["game"]["NS_x"]=4;
        --y NS zeilen
        Tetris["game"]["NS_y"]=3;
        --nummer des nächsten bausteins
        Tetris["game"]["s_next"]=0;
        --nummer des aktuellen bausteins
        Tetris["game"]["s"]=0;
        --anz_steine des aktuellen bausteins
        Tetris["game"]["s_anz_s"]=0;
        --anz_lagen aktuellen bausteins
        Tetris["game"]["s_anz_l"]=0;
        --aktuelle lage des bausteins
		Tetris["game"]["s_lage"]=0;
		--x pos des hauptbausteins
		Tetris["game"]["s_pos_x"]=0;
		--y pos des hauptbausteins
		Tetris["game"]["s_pos_y"]=0;
        --start timer
        Tetris["game"]["timer"] = 0.5;
        Tetris["game"]["timer_go"] = 1;
		--scores
		Tetris["game"]["score"] = {};
		Tetris["game"]["score"]["points"]=0;		
		Tetris["game"]["score"]["lvl"]=0;
		Tetris["game"]["score"]["linie"]=0;
		Tetris["game"]["stones"] = { 
		41,
		1,
		2,
		45,
		55,
		39,
		10,
		};
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
        Tetris_GF_gamewindow_Clear ();
		Tetris_ingame(1);
		Tetris_GF_create ();
		Tetris_GF_NS_create ();
		Tetris_fieldlist_create ();
		Tetris_creat_custom_lines (6);
		Tetris_GF_gamewindow_Update ();
		Tetris_GF_SetFramesPos();
		Tetris_new_stone ();
		Tetris_GF_timer_Update ();
		Tetris_GF_Titeltext_Update ();
		Tetris_GF_highscore_Show ();
end

function Tetris_lvl_handler_retris ()

	--variablen holen und setzen
	local level = Tetris["game"]["score"]["lvl"];
	local linie = Tetris["game"]["score"]["linie"];
	local timer = Tetris["game"]["timer"];
	local lvl = nil;
	if (linie < 9) then
		lvl = 0;
		timer = 0.5;
	end
	if (linie > 8) then
		lvl = 1;
		timer = 0.49;
	end
	if (linie > 16) then
		lvl = 2;
		timer = 0.48;
	end
	if (linie > 24) then
		lvl = 3;
		timer = 0.47;
	end	
	if (linie > 32) then
		lvl = 4;
		timer = 0.46;
	end	
	if (linie > 40) then
		lvl = 5;
		timer = 0.45;
	end
	if (linie > 48) then
		lvl = 6;
		timer = 0.44;
	end	
	if (linie > 56) then
		lvl = 7;
		timer = 0.43;
	end
	if (linie > 64) then
		lvl = 8;
		timer = 0.42;
	end
	if (linie > 72) then
		lvl = 9;
		timer = 0.41;
	end
	if (linie > 80) then
		lvl = 10;
		timer = 0.40;
	end
	if (linie > 88) then
		lvl = 11;
		timer = 0.39;
	end
	if (linie > 96) then
		lvl = 12;
		timer = 0.38;
	end
	if (linie > 104) then
		lvl = 13;
		timer = 0.37;
	end
	if (linie > 112) then
		lvl = 14;
		timer = 0.36;
	end
	if (linie > 120) then
		lvl = 15;
		timer = 0.35;
	end
	if (linie > 128) then
		lvl = 16;
		timer = 0.34;
	end
	if (linie > 136) then
		lvl = 17;
		timer = 0.33;
	end
	if (linie > 144) then
		lvl = 18;
		timer = 0.32;
	end
	if (linie > 152) then
		lvl = 19;
		timer = 0.31;
	end
	if (linie > 160) then
		lvl = 20;
		timer = 0.30;
	end
	if (linie > 168) then
		lvl = 21;
		timer = 0.29;
	end
	if (linie > 176) then
		lvl = 22;
		timer = 0.28;
	end
	if (linie > 184) then
		lvl = 23;
		timer = 0.27;
	end
	if (linie > 192) then
		lvl = 24;
		timer = 0.26;
	end
	if (linie > 200) then
		lvl = 25;
		timer = 0.25;
	end
	if (linie > 208) then
		lvl = 26;
		timer = 0.24;
	end
	if (linie > 216) then
		lvl = 27;
		timer = 0.23;
	end
	if (linie > 224) then
		lvl = 28;
		timer = 0.22;
	end
	if (linie > 232) then
		lvl = 29;
		timer = 0.21;
	end
	if (linie > 240) then
		lvl = 30;
		timer = 0.20;
	end
	if (linie > 248) then
		lvl = 31;
		timer = 0.19;
	end
	if (linie > 256) then
		lvl = 32;
		timer = 0.18;
	end
	if (linie > 264) then
		lvl = 33;
		timer = 0.17;
	end
	if (linie > 272) then
		lvl = 34;
		timer = 0.16;
	end
	if (linie > 280) then
		lvl = 35;
		timer = 0.15;
	end
	if (linie > 288) then
		lvl = 36;
		timer = 0.14;
	end
	if (linie > 296) then
		lvl = 37;
		timer = 0.13;
	end
	if (linie > 304) then
		lvl = 38;
		timer = 0.12;
	end
	if (linie > 312) then
		lvl = 39;
		timer = 0.11;
	end
	if (linie > 320) then
		lvl = 40;
		timer = 0.10;
	end

	--wenn es ein levelveränderung gab, neue steine
	if ((level ~= lvl) and (Tetris["game"]["gametypc"]~=1)) then
		Tetris_stone_handler_retris (lvl);
	end

	--lvl speichern
	Tetris["game"]["score"]["lvl"] = lvl;
	--timer speichern
	Tetris["game"]["timer"] = timer;
end

function Tetris_stone_handler_retris (lvl)
--lvl = das aktuelle level
	if (lvl == 1) then
		local s1 = 24;
		local s2 = 25;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	
	if (lvl == 2) then
		local s1 = 28;
		local s2 = 29;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 3) then
		local s1 = 46;
		local s2 = 11;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 4) then
		local s1 = 5;
		local s2 = 6;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 5) then
		local s1 = 3;
		local s2 = 4;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 6) then
		local s1 = 17;
		local s2 = 12;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 7) then
		local s1 = 37;
		local s2 = 38;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 8) then
		local s1 = 44;
		local s2 = 45;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 9) then
		local s1 = 7;
		local s2 = 13;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 10) then
		local s1 = 14;
		local s2 = 18;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 11) then
		local s1 = 15;
		local s2 = 16;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 12) then
		local s1 = 19;
		local s2 = 26;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 13) then
		local s1 = 30;
		local s2 = 31;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 14) then
		local s1 = 32;
		local s2 = 33;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 15) then
		local s1 = 58;
		local s2 = 59;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 16) then
		local s1 = 34;
		local s2 = 39;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 17) then
		local s1 = 47;
		local s2 = 48;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 18) then
		local s1 = 22;
		local s2 = 23;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 19) then
		local s1 = 35;
		local s2 = 36;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 20) then
		local s1 = 43;
		local s2 = 27;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 21) then
		local s1 = 56;
		local s2 = 57;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end
	if (lvl == 22) then
		local s1 = 20;
		local s2 = 40;
		
		table.insert(Tetris["game"]["stones"], s1)
		table.insert(Tetris["game"]["stones"], s2)
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
	end


end


function Tetris_score_handler_retris (r, l)
--r = wie erechnet sich die score
--		d = instant drop
--		timer = normaler fall durch timer
--l = anzahl der linien die vollständig sind
	local score = Tetris["game"]["score"]["points"];		
	local lvl = Tetris["game"]["score"]["lvl"];
	local s_plus = 0;
	
	if (l == 1) then
		s_plus = 1+lvl;
	end
	if (l == 2) then
		s_plus = 3+lvl;
	end
	if (l == 3) then
		s_plus = 7+lvl;
	end
	if (l == 4) then
		s_plus = 20+(lvl*2);
	end
	
	if (r == "timer") then
		s_plus = s_plus+1;
	else
		s_plus = s_plus+1+2;
	end
	
	--neue score speichern
	Tetris["game"]["score"]["points"] = score+s_plus;
end

function Tetris_gameresume_retris ()
	    Tetris_GF_NS_create ();
        Tetris_GF_NS_Clear ();
        Tetris_GF_NS_Show ();
        Tetris_GF_create ();
        Tetris_GF_gamewindow_Update ();
        Tetris_GF_SetFramesPos();
        Tetris_GF_timer_Update ();
        Tetris_GF_Titeltext_Update ();
        Tetris_GF_Text_Score_Update ();
        Tetris_GF_highscore_Show ();
        Tetris_gost_stone ();
        Tetris_GF_gamewindow_falling_stone_Show ();
end

