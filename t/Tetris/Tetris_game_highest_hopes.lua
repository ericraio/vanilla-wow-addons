function Tetris_stone_is_down_highest_hopes (r)
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
	Tetris_score_handler_highest_hopes (r, lines);
	--eventuell lvlup ?
	Tetris_lvl_handler_highest_hopes ();
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

function Tetris_gameover_highest_hopes ()
	--variablen holen und setzen
	local highscore = Tetris["highscore"]["highest_hopes"];
	local score = Tetris["game"]["score"]["points"];
	--score speichern
	if (score > highscore) then
		Tetris["highscore"]["highest_hopes"] = score;
		Tetris_GF_highscore_Show ();
	end
	--ingamestatus ändern
	Tetris_ingame (0);
end

function Tetris_newgame_highest_hopes ()
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
		Tetris["game"]["gametyp"]=4;
        --x spalten
        Tetris["game"]["x"]=5;
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
		2,
		7,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		18
		};
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
        Tetris_GF_gamewindow_Clear ();
		Tetris_ingame(1);
		Tetris_GF_create ();
		Tetris_GF_NS_create ();
		Tetris_fieldlist_create ();
		Tetris_creat_custom_lines (20);
		Tetris_GF_gamewindow_Update ();
		Tetris_GF_SetFramesPos();
		Tetris_new_stone ();
		Tetris_GF_timer_Update ();
		Tetris_GF_Titeltext_Update ();
		Tetris_GF_highscore_Show ();
end

function Tetris_lvl_handler_highest_hopes ()

	--variablen holen und setzen
	local lvl = Tetris["game"]["score"]["lvl"];
	local linie = Tetris["game"]["score"]["linie"];
	local timer = Tetris["game"]["timer"];

	if (linie < 6) then
		lvl = 0;
		timer = 0.5;
	end
	if (linie > 5) then
		lvl = 1;
		timer = 0.45;
	end
	if (linie > 10) then
		lvl = 2;
		timer = 0.40;
	end
	if (linie > 15) then
		lvl = 3;
		timer = 0.35;
	end
	if (linie > 20) then
		lvl = 4;
		timer = 0.30;
	end
	if (linie > 25) then
		lvl = 5;
		timer = 0.25;
	end
	if (linie > 30) then
		lvl = 6;
		timer = 0.20;
	end
	if (linie > 35) then
		lvl = 7;
		timer = 0.15;
	end
	if (linie > 40) then
		lvl = 8;
		timer = 0.10;
	end
	if (linie > 45) then
		lvl = 9;
		timer = 0.05;
	end
	if (linie > 50) then
		lvl = 10;
		timer = 0.04;
	end
	if (linie > 55) then
		lvl = 11;
		timer = 0.03;
	end
	if (linie > 60) then
		lvl = 12;
		timer = 0.025;
	end
	if (linie > 65) then
		lvl = 13;
		timer = 0.02;
	end
	if (linie > 70) then
		lvl = 14;
		timer = 0.015;
	end
	--lvl speichern
	Tetris["game"]["score"]["lvl"] = lvl;
	--timer speichern
	Tetris["game"]["timer"] = timer;
end

function Tetris_score_handler_highest_hopes (r, l)
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
		s_plus = 6+lvl;
	end
	if (l == 4) then
		s_plus = 10+lvl;
	end
	
	if (r == "timer") then
		s_plus = s_plus+1;
	else
		s_plus = s_plus+1+2;
	end
	
	--neue score speichern
	Tetris["game"]["score"]["points"] = score+s_plus;
end

function Tetris_gameresume_highest_hopes ()
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

