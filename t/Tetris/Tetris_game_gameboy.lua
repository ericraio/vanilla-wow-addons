function Tetris_stone_is_down_gameboy (r)
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
	Tetris_score_handler_gameboy (r, lines);
	--eventuell lvlup ?
	Tetris_lvl_handler_gameboy ();
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

function Tetris_gameover_gameboy ()
	--variablen holen und setzen
	local highscore = Tetris["highscore"]["gameboy"];
	local score = Tetris["game"]["score"]["points"];
	--score speichern
	if (score > highscore) then
		Tetris["highscore"]["gameboy"] = score;
		Tetris_GF_highscore_Show ();
	end
	--ingamestatus ändern
	Tetris_ingame (0);
end

function Tetris_newgame_gameboy ()
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
		Tetris["game"]["gametyp"]=2;
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

function Tetris_lvl_handler_gameboy ()

	--variablen holen und setzen
	local lvl = Tetris["game"]["score"]["lvl"];
	local linie = Tetris["game"]["score"]["linie"];
	local timer = Tetris["game"]["timer"];

	if (linie < 26) then
		lvl = 0;
		timer = 0.5;
	end
	if (linie > 25) then
		lvl = 1;
		timer = 0.45;
	end
	if (linie > 50) then
		lvl = 2;
		timer = 0.40;
	end
	if (linie > 75) then
		lvl = 3;
		timer = 0.35;
	end
	if (linie > 100) then
		lvl = 4;
		timer = 0.30;
	end
	if (linie > 125) then
		lvl = 5;
		timer = 0.25;
	end
	if (linie > 150) then
		lvl = 6;
		timer = 0.20;
	end
	if (linie > 175) then
		lvl = 7;
		timer = 0.15;
	end
	if (linie > 200) then
		lvl = 8;
		timer = 0.10;
	end
	if (linie > 225) then
		lvl = 9;
		timer = 0.05;
	end
	--lvl speichern
	Tetris["game"]["score"]["lvl"] = lvl;
	--timer speichern
	Tetris["game"]["timer"] = timer;
end

function Tetris_score_handler_gameboy (r, l)
--r = wie erechnet sich die score
--		d = instant drop
--		timer = normaler fall durch timer
--l = anzahl der linien die vollständig sind
	local score = Tetris["game"]["score"]["points"];		
	local lvl = Tetris["game"]["score"]["lvl"];
	local s_plus = 0;
	
	if (l == 1) then
		s_plus = (1+lvl)*40;
	end
	if (l == 2) then
		s_plus = (1+lvl)*100;
	end
	if (l == 3) then
		s_plus = (1+lvl)*300;
	end
	if (l == 4) then
		s_plus = (1+lvl)*1200;
	end	
	
	--neue score speichern
	Tetris["game"]["score"]["points"] = score+s_plus;
end

function Tetris_gameresume_gameboy ()
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

