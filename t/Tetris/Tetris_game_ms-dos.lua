function Tetris_stone_is_down_ms_dos (r)
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
			--lines um 1 erhöhen
			lines = lines + 1;
			Tetris_GF_gamewindow_Update ();
		end
	end
	--linie speichern
	Tetris["game"]["score"]["linie"] = linie ;
	--score berechnen
	Tetris_score_handler_ms_dos (r);
	--eventuell lvlup ?
	Tetris_lvl_handler_ms_dos ();
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

function Tetris_gameover_ms_dos ()
	--variablen holen und setzen
	local highscore = Tetris["highscore"]["ms_dos"];
	local score = Tetris["game"]["score"]["points"];
	--score speichern
	if (score > highscore) then
		Tetris["highscore"]["ms_dos"] = score;
		Tetris_GF_highscore_Show ();
	end
	--ingamestatus ändern
	Tetris_ingame (0);
end

function Tetris_newgame_ms_dos ()
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
		Tetris["game"]["gametyp"]=1;
        --x spalten
        Tetris["game"]["x"]=10;
        --y zeilen
        Tetris["game"]["y"]=20;
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
		1,
		2,
		3,
		4,
		5,
		6,
		7
		};
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
        --x spalten
        Tetris["game"]["x"]=10;
        --y zeilen
        Tetris["game"]["y"]=20;
        Tetris_GF_gamewindow_Clear ();
		Tetris_ingame(1);
		Tetris_GF_create ();
		Tetris_GF_NS_create ();
		Tetris_fieldlist_create ();
		Tetris_GF_gamewindow_Update ();
		Tetris_GF_SetFramesPos();
		Tetris_new_stone ();
		Tetris_GF_timer_Update ();
		Tetris_GF_Titeltext_Update ();
		Tetris_GF_highscore_Show ();
end

function Tetris_lvl_handler_ms_dos ()

	--variablen holen und setzen
	local lvl = Tetris["game"]["score"]["lvl"];
	local linie = Tetris["game"]["score"]["linie"];
	local timer = Tetris["game"]["timer"];

	if (linie < 11) then
		lvl = 0;
		timer = 0.5;
	end
	if (linie > 10) then
		lvl = 1;
		timer = 0.45;
	end
	if (linie > 20) then
		lvl = 2;
		timer = 0.40;
	end
	if (linie > 30) then
		lvl = 3;
		timer = 0.35;
	end
	if (linie > 40) then
		lvl = 4;
		timer = 0.30;
	end
	if (linie > 50) then
		lvl = 5;
		timer = 0.25;
	end
	if (linie > 60) then
		lvl = 6;
		timer = 0.20;
	end
	if (linie > 70) then
		lvl = 7;
		timer = 0.15;
	end
	if (linie > 80) then
		lvl = 8;
		timer = 0.10;
	end
	if (linie > 90) then
		lvl = 9;
		timer = 0.05;
	end
	--lvl speichern
	Tetris["game"]["score"]["lvl"] = lvl;
	--timer speichern
	Tetris["game"]["timer"] = timer;
end

function Tetris_score_handler_ms_dos (r)
--r = wie erechnet sich die score
--		d = instant drop
--		timer = normaler fall durch timer
	local score = Tetris["game"]["score"]["points"];		
	local lvl = Tetris["game"]["score"]["lvl"];
	local s_plus = 0;
	
	if (lvl == 0) then
		if (r == "timer") then
			s_plus = 6;
		else
			s_plus = 24;
		end
	end
	if (lvl == 1) then
		if (r == "timer") then
			s_plus = 9;
		else
			s_plus = 27;
		end
	end
	if (lvl == 2) then
		if (r == "timer") then
			s_plus = 12;
		else
			s_plus = 30;
		end
	end
	if (lvl == 3) then
		if (r == "timer") then
			s_plus = 15;
		else
			s_plus = 33;
		end
	end
	if (lvl == 4) then
		if (r == "timer") then
			s_plus = 18;
		else
			s_plus = 36;
		end
	end
	if (lvl == 5) then
		if (r == "timer") then
			s_plus = 21;
		else
			s_plus = 39;
		end
	end
	if (lvl == 6) then
		if (r == "timer") then
			s_plus = 24;
		else
			s_plus = 42;
		end
	end
	if (lvl == 7) then
		if (r == "timer") then
			s_plus = 27;
		else
			s_plus = 45;
		end
	end
	if (lvl == 8) then
		if (r == "timer") then
			s_plus = 30;
		else
			s_plus = 48;
		end
	end
	if (lvl == 9) then
		if (r == "timer") then
			s_plus = 33;
		else
			s_plus = 51;
		end
	end
	--neue score speichern
	Tetris["game"]["score"]["points"] = score+s_plus;
end

function Tetris_gameresume_ms_dos ()
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

