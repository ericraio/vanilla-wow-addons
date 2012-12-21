function Tetris_newgame_custom ()
		local ingame = Tetris["ingame"];
		if (ingame == 1) then
			Tetris_gameover();
		end
		--alles reseten
        Tetris["game"]= { };
        Tetris["game"]["feld"]= { };
        Tetris["game"]["s_temp"]= { };
		Tetris["game"]["s_temp"]["temp"]= { }; 
        Tetris["game"]["s_NS_temp"]= { };
        Tetris["game"]["s_gost"] = { };
        Tetris["game"]["s_gost"]["temp"] = { };
		--spiel typ custom
		Tetris["game"]["gametypc"]=1;
		Tetris["game"]["gametyp"]=Tetris["options"]["gametyp"];
        --x spalten
        Tetris["game"]["x"]=Tetris["options"]["breite"];
        --y zeilen
        Tetris["game"]["y"]=Tetris["options"]["hohe"];
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
		--steinliste erstellen
		Tetris_stonelist_create ();
		--grösse des table speichern
		Tetris["game"]["stones"]["anz_stones"]=table.getn(Tetris["game"]["stones"]);
		Tetris_GF_gamewindow_Clear ();
		Tetris_ingame(1);
		Tetris_GF_create ();
		Tetris_GF_NS_create ();
		Tetris_fieldlist_create ();
		--zufalls steine
		if (Tetris["options"]["r_lines_activ"] == 1) then
			local lines = Tetris["options"]["r_lines"];
			Tetris_creat_custom_lines (lines);
		end
		Tetris_GF_gamewindow_Update ();
		Tetris_GF_SetFramesPos();
		Tetris_new_stone ();
		Tetris_GF_timer_Update ();
		Tetris_GF_Titeltext_Update ();
		Tetris_GF_highscore_Show ();
end

function Tetris_stone_is_down_custom (r)
	local gametyp = Tetris["game"]["gametyp"];
	if (gametyp == 1) then
		Tetris_stone_is_down_ms_dos (r);
	end
	if (gametyp == 2) then
		Tetris_stone_is_down_gameboy (r);
	end
	if (gametyp == 3) then
		Tetris_stone_is_down_retris (r);
	end
	if (gametyp == 4) then
		Tetris_stone_is_down_highest_hopes (r);
	end
end

function Tetris_gameover_custom ()
	--ingamestatus ändern
	Tetris_ingame (0);
end
