function Tetris_Load ()
	--allgemeine variablen
    if (not Tetris) then
        Tetris={ };
        Tetris["game"]= { };
        Tetris["game"]["feld"]= { };
        Tetris["game"]["s_temp"]= { };
		Tetris["game"]["s_temp"]["temp"]= { }; 
        Tetris["game"]["s_NS_temp"]= { };  
        Tetris["highscore"]= { };           
        Tetris["options"]= { };
        Tetris["options"]["stones"]= { };
		--spiel typ
		Tetris["game"]["gametyp"]="ms-dos";
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
		--timer
		Tetris["game"]["timer"] = 0.5;
		--läuft der timer?
		Tetris["game"]["timer_go"] = 0;
		--scores
		Tetris["game"]["score"] = {};
		Tetris["game"]["score"]["points"]=0;		
		Tetris["game"]["score"]["lvl"]=0;
		Tetris["game"]["score"]["linie"]=0;
		--GF_Gamewindow-------------------
        --button höhe des gamewindow button
        Tetris["options"]["b_hohe"]=20;
        --button breite des gamewindow button
        Tetris["options"]["b_breite"]=20;
        --x randabstand des gamewindow
        Tetris["options"]["r_abstand_x"]=15;
        --y randabstand des gamewindow
        Tetris["options"]["r_abstand_y"]=15;
        --x offset des gamewindow
        Tetris["options"]["r_a-faktor_x"]=180;
        --y offset des gamewindow
        Tetris["options"]["r_a-faktor_y"]=25;
        ----------------------------------
        ----GF_NS_Window------------------
        --button höhe des gamewindow button
        Tetris["options"]["b_NS_hohe"]=20;
        --button breite des gamewindow button
        Tetris["options"]["b_NS_breite"]=20;
        --x randabstand des gamewindow
        Tetris["options"]["r_NS_abstand_x"]=15;
        --y randabstand des gamewindow
        Tetris["options"]["r_NS_abstand_y"]=15;
        --x offset des NS window
        Tetris["options"]["r_a_NS-faktor_x"]=0;
        --y offset des NS window
        Tetris["options"]["r_a_NS-faktor_y"]=18;
        -----------------------------------
        --highscore
        Tetris["highscore"]["ms_dos"]= 0;
        --max. verschiedene steine
        Tetris["options"]["max_s"]=7;
        --texturenset (ordnername)
        Tetris["options"]["texturenset"]="color";
        --version dieses scriptes
        Tetris["version"]= 0.1;
		-- im spiel?
		Tetris["ingame"]=0;
        Tetris["debug"]= 0;
    end
    
    --update
    if (Tetris["version"]==0.1) then
    	Tetris["version"]=0.5;
    	--anz x
		Tetris["options"]["breite"]=10;
    	--anz y
		Tetris["options"]["hohe"]=20;
		--random lines
		Tetris["options"]["r_lines"]=1;
		Tetris["options"]["r_lines_activ"]=1;
		--stonelist
        --max. verschiedene steine
        Tetris["options"]["max_s"]=46;
		Tetris["options"]["stones"] = { };
		--table füllen
		for num = 1, Tetris["options"]["max_s"] do
			table.insert(Tetris["options"]["stones"],1)
		end
		Tetris["ingame"]=0;
		Tetris["game"]["gametyp"]=1;
		Tetris["options"]["gametyp"]=1;
		Tetris["options"]["SOF_s_show"]=1;
    end
    if (Tetris["version"]==0.5) then
    	Tetris["version"]=0.6;
        --texturenset (ordnername)
        Tetris["options"]["texturenset"]=1; 	
    end
    if (Tetris["version"]==0.6) then
    	Tetris["version"]=0.7;
        --max. verschiedene steine
        Tetris["options"]["max_s"]=57;
		Tetris["options"]["stones"] = { };
		--table füllen
		for num = 1, Tetris["options"]["max_s"] do
			table.insert(Tetris["options"]["stones"],1)
		end
    end
    if (Tetris["version"]==0.7) then
    	Tetris["version"]=0.8;
        --max. verschiedene steine
        Tetris["options"]["max_s"]=60;
		Tetris["options"]["stones"] = { };
		--table füllen
		for num = 1, Tetris["options"]["max_s"] do
			table.insert(Tetris["options"]["stones"],1)
		end
		--neue gametyps
		Tetris["highscore"]["gameboy"]= 0;
		Tetris["highscore"]["retris"]= 0;
		--button grösse
		Tetris["options"]["b_hohe"] = 15;
		Tetris["options"]["b_breite"] = 15;
        --checkbox gost
        Tetris["options"]["gost"]=1;
    end
    if (Tetris["version"]==0.8) then
    	Tetris["version"]=0.9;
        --checkbox musik
        Tetris["options"]["musik"]=1;
        --checkbox sound
        Tetris["options"]["sound"]=1; 
        --musik track
        Tetris["options"]["musik-track"]=1;
    end
    if (Tetris["version"]==0.9) then
    	Tetris["version"]=1.1;
    end
    if (Tetris["version"]==1.1) then
    	Tetris["version"]=1.2;
    	--checkbox mous
        Tetris["options"]["mous"]=1;
		--neue gametyps
		Tetris["highscore"]["highest_hopes"]= 0;
    end
	--slash command
	SLASH_Tetris1 = "/tetris";
	SlashCmdList["Tetris"] = function(msg)
		Tetris_SlashCommand(msg);
	end
	Tetris_sprachesetzen();
end

function Tetris_SlashCommand(msg)	
	Tetris_MF_Toggle();
end

function Tetris_stone_move (r)
--r = move-richtung
--		u = drehen
--		d = runter (instant)
--		dd= runter (einen schritt)
--		l = links
--		r = rechts
--  oder = timer wenn zeit down
	--variablen holen und setzen
	local anz_l = Tetris["game"]["s_anz_l"];
	local s_l = Tetris["game"]["s_lage"];
	local pos_x = Tetris["game"]["s_pos_x"];
	local pos_y = Tetris["game"]["s_pos_y"];
	--backup der nötigen variablen erstellen
	local b_s_l = Tetris["game"]["s_lage"];
	local b_pos_x = Tetris["game"]["s_pos_x"];
	local b_pos_y = Tetris["game"]["s_pos_y"];

	if (Tetris["ingame"]==0) then
		return;
	end

	--stein drehen
	if (r == "u") then
		if not (anz_l == 1) then
			s_l = s_l + 1;
			if (s_l > anz_l) then
				s_l = 1;
			end
		end
	end
	--stein nach links
	if (r == "l") then
		pos_x = pos_x-1;
	end
	--stein nach rechts
	if (r == "r") then
		pos_x = pos_x+1;
	end
	--stein nach unten
	if (r == "d") or (r == "timer") or (r == "dd") then
		pos_y = pos_y-1;
	end
	--änderungen speichern
	Tetris["game"]["s_lage"] = s_l
	Tetris["game"]["s_pos_x"] = pos_x;
	Tetris["game"]["s_pos_y"] = pos_y;
	--neue position der steine berechnen
	Tetris_falling_stone_coming_soon ();
	--test laufen lassen und reagieren
	if (Tetris_stone_outside_test()==true) then
		if (r == "d") or (r =="timer") or (r == "dd") then
			--stein kann nicht weiter
			--wenn scroll down wie timer handeln
			if (r == "dd") then
				r = "timer"
			end
			Tetris_stone_is_down (r);

		else
			--gemachte änderungen rückgängig machen
			Tetris["game"]["s_lage"]=b_s_l;
			Tetris["game"]["s_pos_x"]=b_pos_x;
			Tetris["game"]["s_pos_y"]=b_pos_y;
		end
	--test war false --> stein bewegen
	else
		if ((r ~= "d") and (r ~= "timer") and (r ~= "dd")) then
			Tetris_gost_stone ();
		end
		--aktuell angezeigter stein löschen
		Tetris_GF_gamewindow_falling_stone_Hide ();
		--neue position der steine speichern
		Tetris_falling_stone ();
		--neue position des bausteins anzeigen
		Tetris_GF_gamewindow_falling_stone_Show ();
		--timer starten, wenn nötig
		if (r == "timer") then
			Tetris_timer_go ();
		end
		--für instant drop nochmal durchrechnen
		if (r == "d") then
			Tetris_stone_move ("d");
		end
		--sound
		if ((r ~= "d") and (r ~= "timer") and (r ~= "dd")) then
			Tetris_play_sound (r);
		end		
	end
end

--fallender baustein ist unten angekommen
function Tetris_stone_is_down (r)
--r = wie ist der stein nach unten gekommen?
--		d = instant drop
--		timer = normaler fall durch timer
	local gametyp = Tetris["game"]["gametyp"];
	local custom = Tetris["game"]["gametypc"];
	if (custom == 1) then
		Tetris_stone_is_down_custom (r);
	else
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
end


function Tetris_new_stone ()
	--stein generieren anzeigen
	Tetris_release_stone ();
	Tetris_falling_stone_coming_soon ();
	Tetris_falling_stone ();
	Tetris_GF_gamewindow_falling_stone_Show ();
	--GF_NS Frame
	Tetris_falling_stone_coming_soon_NS ();
	Tetris_GF_NS_Clear ();
	Tetris_GF_NS_Show ();
	--Score Updaten
	Tetris_GF_Text_Score_Update ();
	--game over?
	if (Tetris_stone_outside_test()==true) then
		Tetris_gameover ();
	else
		Tetris_timer_go ();
	end
	--chache für gost-stone löschen
    Tetris["game"]["s_gost"]["temp"] = { };
    if (Tetris["debug"]==1) then
		DEFAULT_CHAT_FRAME:AddMessage("Delet saved Gost (NewStone)");
	end
	Tetris_gost_stone ();
	--wenn maussteuerung aktiv, stein gleich zur maus verschieben
	if (Tetris["options"]["mous"] == 1) and (Tetris["game"]["mous"] ~= nil)  then
		Tetris_mous_OnPieceEnter (1)
	end
end

function Tetris_timer_go ()
	--Chronos.unscheduleByName (Tetris_stone_timer);
	--timer dem lvl entsprechend holen
	local timer = Tetris["game"]["timer"];
	Timex:AddNamedSchedule("Tetris_stone_timer", timer, nil, 1, Tetris_timer_end)
end

function Tetris_timer_toggle ()
	--timer abgeschaltet dann anschalten
	if (Timex:NamedScheduleCheck("Tetris_stone_timer") == nil) then
		Tetris["game"]["timer_go"] = 1;
		Tetris_timer_go ();
	else
	--timer läuft dann stoppen
		Timex:DeleteNamedSchedule("Tetris_stone_timer");
		Tetris["game"]["timer_go"] = 0;
	end
	--anzeige updaten
	Tetris_GF_timer_Update ();
end

function Tetris_timer_end ()
	--stein nach unten bewegen
	Tetris_stone_move ("timer");
end

function Tetris_gf_buttonclick (b)
--b = button der gedrückt wurde
	local gametyp = Tetris["game"]["gametyp"];
	local custom = Tetris["game"]["gametypc"];
	if (b == "newgame") then
		if (custom == 1) then
			Tetris_newgame_custom ();
		else
			if (gametyp == 1) then
				Tetris_newgame_ms_dos ();
			end
			if (gametyp == 2) then
				Tetris_newgame_gameboy ();
			end
			if (gametyp == 3) then
				Tetris_newgame_retris ();
			end
			if (gametyp == 4) then
				Tetris_newgame_highest_hopes ();
			end
		end
	end
	if (b == "pause") then
		Tetris_timer_toggle ();
	end
	if (b == "close") then
		if ( Tetris["game"]["timer_go"] == 1) then
			Tetris_timer_toggle ();
		end
		Tetris_GF_Toggle();
		Tetris_MF_Toggle();
	end
end

function Tetris_gameover ()
	local gametyp = Tetris["game"]["gametyp"];
	local custom = Tetris["game"]["gametypc"];
	--sound
	Tetris_play_sound ("go");
	if (custom == 1) then	
		Tetris_gameover_custom ();
	else
		if (gametyp == 1) then
			Tetris_gameover_ms_dos ();
		end
		if (gametyp == 2) then
			Tetris_gameover_gameboy ();
		end
		if (gametyp == 3) then
			Tetris_gameover_retris ();
		end
		if (gametyp == 4) then
			Tetris_gameover_highest_hopes ();
		end
	end
end

function Tetris_gameresume ()
	local gametyp = Tetris["game"]["gametyp"];
	if (gametyp == 1) then
		Tetris_gameresume_ms_dos ();
	end
	if (gametyp == 2) then
		Tetris_gameresume_gameboy ();
	end
	if (gametyp == 3) then
		Tetris_gameresume_retris ();
	end
	if (gametyp == 4) then
		Tetris_gameresume_highest_hopes ();
	end
end

function Tetris_gametyp_list_create()
	Tetris_gametyp_list = {
		Tetris_UBE_gt_ms_dos,
		Tetris_UBE_gt_gameboy,
		Tetris_UBE_gt_retris,
		Tetris_UBE_gt_highest_hopes,
	};
end

function Tetris_textur_list_create()
	Tetris_textur_list = {
		Tetris_UBE_tex_color,
		Tetris_UBE_tex_bw,
		Tetris_UBE_tex_wow,
	};
end

function Tetris_musik_list_create()
	Tetris_musik_list = {
		Tetris_UBE_musik_random,
		Tetris_UBE_musik_a,
		Tetris_UBE_musik_b,
		Tetris_UBE_musik_c,
		Tetris_UBE_musik_musik,
		Tetris_UBE_musik_remix,
	};
end

function Tetris_GF_Titeltext_Update ()
	--variablen holen und setzen
	local UBE_tetris = Tetris_UBE_GF_Titeltext;
	local UBE_msdos = Tetris_UBE_gt_ms_dos;
	local UBE_gameboy = Tetris_UBE_gt_gameboy;
	local UBE_retris = Tetris_UBE_gt_retris;
	local UBE_custom = Tetris_UBE_gt_custom;
	local UBE_highest_hopes = Tetris_UBE_gt_highest_hopes;
	local gametyp = Tetris["game"]["gametyp"];
	local custom = Tetris["game"]["gametypc"];
	if (custom == 1) then	
		Tetris_GF_Titeltext:SetText(UBE_tetris.." "..UBE_custom);
	else	
		if (gametyp == 1) then
			Tetris_GF_Titeltext:SetText(UBE_tetris.." "..UBE_msdos);
		end
		if (gametyp == 2) then
			Tetris_GF_Titeltext:SetText(UBE_tetris.." "..UBE_gameboy);
		end
		if (gametyp == 3) then
			Tetris_GF_Titeltext:SetText(UBE_tetris.." "..UBE_retris);
		end
		if (gametyp == 4) then
			Tetris_GF_Titeltext:SetText(UBE_tetris.." "..UBE_highest_hopes);
		end
	end
end

function Tetris_GF_highscore_Show ()
	--variablen holen und setzen
	local UBE_hs = Tetris_UBE_GF_Text_Highscore;
	local gametyp = Tetris["game"]["gametyp"];
	local UBE_msdos = Tetris_UBE_gt_ms_dos;	
	local UBE_gameboy = Tetris_UBE_gt_gameboy;
	local UBE_retris = Tetris_UBE_gt_retris;
	local UBE_highest_hopes = Tetris_UBE_gt_highest_hopes;	
	local custom = Tetris["game"]["gametypc"];
	local UBE_gametyp = Tetris_UBE_GF_Text_Gametyp
	if (custom == 1) then
		if (gametyp == 1) then
			Tetris_GF_Text_Highscore:SetText(UBE_gametyp.." "..UBE_msdos);
		end
		if (gametyp == 2) then
			Tetris_GF_Text_Highscore:SetText(UBE_gametyp.." "..UBE_gameboy);
		end	
		if (gametyp == 3) then
			Tetris_GF_Text_Highscore:SetText(UBE_gametyp.." "..UBE_retris);
		end
		if (gametyp == 4) then
			Tetris_GF_Text_Highscore:SetText(UBE_gametyp.." "..UBE_highest_hopes);
		end	
	else
		if (gametyp == 1) then
			local highscore = Tetris["highscore"]["ms_dos"]
			Tetris_GF_Text_Highscore:SetText(UBE_hs.." "..highscore);
		end
		if (gametyp == 2) then
			local highscore = Tetris["highscore"]["gameboy"]
			Tetris_GF_Text_Highscore:SetText(UBE_hs.." "..highscore);
		end
		if (gametyp == 3) then
			local highscore = Tetris["highscore"]["retris"]
			Tetris_GF_Text_Highscore:SetText(UBE_hs.." "..highscore);
		end
		if (gametyp == 4) then
			local highscore = Tetris["highscore"]["highest_hopes"]
			Tetris_GF_Text_Highscore:SetText(UBE_hs.." "..highscore);
		end	
	end
end

function Tetris_newgame ()
	local game = Tetris["game"]["next_game"];
	if (game == "ms_dos") then
		Tetris_newgame_ms_dos ();
		Tetris_GF_Toggle();
	end
	if (game == "retris") then
		Tetris_newgame_retris ();
		Tetris_GF_Toggle();
	end
	if (game == "gameboy") then
		Tetris_newgame_gameboy ();
		Tetris_GF_Toggle();
	end
	if (game == "highest_hopes") then
		Tetris_newgame_highest_hopes ();
		Tetris_GF_Toggle();
	end
	if (game == "custom") then
		Tetris_CF_Toggle();
	end	
end
