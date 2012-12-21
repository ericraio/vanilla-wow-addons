--tastatur bindings
BINDING_HEADER_TETRIS = "Tetris";
BINDING_NAME_TETRIS_LEFT = "Move Left";
BINDING_NAME_TETRIS_RIGHT = "Move Right";
BINDING_NAME_TETRIS_DOWN = "Move Down";
BINDING_NAME_TETRIS_TOURN = "Turn";
BINDING_NAME_TETRIS_PAUSE = "Pause";

--titeltexte
Tetris_UBE_GF_Titeltext = "Tetris:";
Tetris_UBE_GF_NS_Titeltext ="Next Piece";
Tetris_UBE_GF_SC_Titeltext ="Score";
Tetris_UBE_MF_Titeltext ="Tetris   v";
Tetris_UBE_CF_Titeltext ="Custom Tetris: Setup";
Tetris_UBE_SOF_Titeltext ="Piece Setup";
Tetris_UBE_OF_Titeltext ="Tetris: Options";
Tetris_UBE_AF_Titeltext = "Tetris: New Game";

--spieltyp
Tetris_UBE_gt_ms_dos = "MS-DOS";
Tetris_UBE_gt_gameboy = "GameBoy";
Tetris_UBE_gt_retris = "Retris";
Tetris_UBE_gt_custom = "Custom";
Tetris_UBE_gt_highest_hopes = "Highest Hopes";

--texturenset
Tetris_UBE_tex_color = "Colour";
Tetris_UBE_tex_bw = "Black and White";
Tetris_UBE_tex_wow = "World Of Warcraft Spells";

--musikstücke
Tetris_UBE_musik_random = "Play a random track";
Tetris_UBE_musik_a = "Gameboy A";
Tetris_UBE_musik_b = "Gameboy B";
Tetris_UBE_musik_c = "Gameboy C";
Tetris_UBE_musik_musik = "Musical Version";
Tetris_UBE_musik_remix = "Remix Version";

--buttons
Tetris_UBE_GF_BF_u = "Turn";
Tetris_UBE_GF_BF_l = "Left";
Tetris_UBE_GF_BF_r = "Right";
Tetris_UBE_GF_BF_d = "Down";

Tetris_UBE_GF_b_close = "Close";
Tetris_UBE_GF_b_newgame = "New Game";
Tetris_UBE_GF_b_pause_pause = "Pause";
Tetris_UBE_GF_b_pause_resume = "Resume";

Tetris_UBE_MF_exit = "Exit";
Tetris_UBE_MF_resume = "Resume current game";
Tetris_UBE_MF_ms_dos = "MS-DOS Tetris";
Tetris_UBE_MF_retris = "Retris";
Tetris_UBE_MF_gameboy = "GameBoy Tetris";
Tetris_UBE_MF_highest_hopes = "Highest Hopes";
Tetris_UBE_MF_options = "Options";
Tetris_UBE_MF_custom = "Custom Tetris";

Tetris_UBE_CF_b_ok = "Play!";
Tetris_UBE_CF_b_exit = "Cancel";
Tetris_UBE_GF_b_stonesetup = "Piece Setup";

Tetris_UBE_SOF_b_back = "Back";
Tetris_UBE_SOF_b_next = "Next";
Tetris_UBE_SOF_b_ok = "Ok";

Tetris_UBE_OF_b_exit = "Cancel";
Tetris_UBE_OF_b_ok = "Ok";

Tetris_UBE_AF_b_ja = "Yes";
Tetris_UBE_AF_b_nein = "No";

--texte
Tetris_UBE_GF_SF_Text_Score_punkte = "Score:";
Tetris_UBE_GF_SF_Text_Score_lvl = "Level:";
Tetris_UBE_GF_SF_Text_Score_line = "Rows:";
Tetris_UBE_GF_Text_Highscore = "Highscore:";
Tetris_UBE_GF_Text_Gametyp = "Gametyp:";
Tetris_UBE_SOF_piece = "Piece number:";
Tetris_UBE_CF_Text_dropdown = "Rules (Gametyp)";
Tetris_UBE_OF_Text_dropdown = "Select a texture-set";
Tetris_UBE_OF_Text_mdropdown = "Select a music-track";
Tetris_UBE_OF_c_Text_gost = "Piece Gost-Preview";
Tetris_UBE_OF_c_Text_musik = "Music";
Tetris_UBE_OF_c_Text_sound = "Sound";
Tetris_UBE_OF_c_Text_mous = "Mouse Control";
Tetris_UBE_AF_Text = "Exit your game and play an new game?";


--sliders
Tetris_UBE_CF_Text_hohe = "Number of lines:";
Tetris_UBE_CF_Text_breite = "Number of crevices:";
Tetris_UBE_CF_s_Text_viel = "Many";
Tetris_UBE_CF_s_Text_wenig = "Few";
Tetris_UBE_CF_Text_r_lines_on = "Number of randomrows:";
Tetris_UBE_CF_Text_r_lines_off = "Randomrows disabled";
Tetris_UBE_OF_s_Text_gross = "Big";
Tetris_UBE_OF_s_Text_klein = "Litle";
Tetris_UBE_OF_Text_bgrosse = "Cell dimension:";

--englisch ist default
function Tetris_sprachesetzen ()
	if GetLocale() == "deDE" then
--tastatur bindings
		BINDING_HEADER_TETRIS = "Tetris";
		BINDING_NAME_TETRIS_LEFT = "Links";
		BINDING_NAME_TETRIS_RIGHT = "Rechts";
		BINDING_NAME_TETRIS_DOWN = "Nach Unten";
		BINDING_NAME_TETRIS_TOURN = "Stein Drehen";
		BINDING_NAME_TETRIS_PAUSE = "Pause";
		
--titeltexte
		Tetris_UBE_GF_Titeltext = "Tetris:";
		Tetris_UBE_GF_NS_Titeltext ="Vorschau";
		Tetris_UBE_GF_SC_Titeltext ="Punkte";
		Tetris_UBE_MF_Titeltext ="Tetris   v";
		Tetris_UBE_CF_Titeltext ="Eigenes Tetris: Setup";
		Tetris_UBE_SOF_Titeltext ="Stein Setup";
		Tetris_UBE_OF_Titeltext ="Tetris: Optionen";
		Tetris_UBE_AF_Titeltext = "Tetris: Neues Spiel";
		
--spieltyp
		Tetris_UBE_gt_ms_dos = "MS-DOS";
		Tetris_UBE_gt_gameboy = "GameBoy";
		Tetris_UBE_gt_retris = "Retris";
		Tetris_UBE_gt_custom = "Eigenes Spiel";
		Tetris_UBE_gt_highest_hopes = "Highest Hopes";
		
--texturenset
		Tetris_UBE_tex_color = "Bunt";
		Tetris_UBE_tex_bw = "Schwarz und Weis";
		Tetris_UBE_tex_wow = "World Of Warcraft Zauberspr\195\188che";
		
--musikstücke
		Tetris_UBE_musik_random = "Spiel ein St\195\188ck per Zufall";
		Tetris_UBE_musik_a = "Gameboy A";
		Tetris_UBE_musik_b = "Gameboy B";
		Tetris_UBE_musik_c = "Gameboy C";
		Tetris_UBE_musik_musik = "Musikalische Version";
		Tetris_UBE_musik_remix = "Remix Version";
		
--buttons
		Tetris_UBE_GF_BF_u = "Drehen";
		Tetris_UBE_GF_BF_l = "Links";
		Tetris_UBE_GF_BF_r = "Rechts";
		Tetris_UBE_GF_BF_d = "Runter";
		
		Tetris_UBE_GF_b_close = "Exit";
		Tetris_UBE_GF_b_newgame = "Neu!";
		Tetris_UBE_GF_b_pause_pause = "Pause";
		Tetris_UBE_GF_b_pause_resume = "Fortsetzen";
		
		Tetris_UBE_MF_exit = "Exit";
		Tetris_UBE_MF_resume = "Spiel wieder Aufnehmen";
		Tetris_UBE_MF_ms_dos = "MS-DOS Tetris";
		Tetris_UBE_MF_retris = "Retris";
		Tetris_UBE_MF_gameboy = "GameBoy Tetris";
		Tetris_UBE_MF_highest_hopes = "Highest Hopes";
		Tetris_UBE_MF_options = "Optionen";
		Tetris_UBE_MF_custom = "Eigenes Tetris";
		
		Tetris_UBE_CF_b_ok = "Spielen!";
		Tetris_UBE_CF_b_exit = "Zur\195\188ck";
		Tetris_UBE_GF_b_stonesetup = "Stein Einstellungen";
		
		Tetris_UBE_SOF_b_back = "Zur\195\188ck";
		Tetris_UBE_SOF_b_next = "Weiter";
		Tetris_UBE_SOF_b_ok = "Ok";
		
		Tetris_UBE_OF_b_exit = "Zur\195\188ck";
		Tetris_UBE_OF_b_ok = "Ok";
		
		Tetris_UBE_AF_b_ja = "Ja";
		Tetris_UBE_AF_b_nein = "Nein";
		
--texte
		Tetris_UBE_GF_SF_Text_Score_punkte = "Punkte:";
		Tetris_UBE_GF_SF_Text_Score_lvl = "Level:";
		Tetris_UBE_GF_SF_Text_Score_line = "Linien:";
		Tetris_UBE_GF_Text_Highscore = "Rekord:";
		Tetris_UBE_GF_Text_Gametyp = "Spielart:";
		Tetris_UBE_SOF_piece = "Stein Nummer:";
		Tetris_UBE_CF_Text_dropdown = "Regeln (Spielart)";
		Tetris_UBE_OF_Text_dropdown = "Texturen Set";
		Tetris_UBE_OF_Text_mdropdown = "Gew\195\164hltes Musikst\195\188ck";
		Tetris_UBE_OF_c_Text_gost = "Stein Vorschau";
		Tetris_UBE_OF_c_Text_musik = "Musik";
		Tetris_UBE_OF_c_Text_sound = "Sound";
		Tetris_UBE_OF_c_Text_mous = "Maussteuerung";
		Tetris_UBE_AF_Text = "Aktuelles Spiel beenden und neues starten?";
		
		
--sliders
		Tetris_UBE_CF_Text_hohe = "Anzahl Linien:";
		Tetris_UBE_CF_Text_breite = "Anzahl Spalten:";
		Tetris_UBE_CF_s_Text_viel = "Viele";
		Tetris_UBE_CF_s_Text_wenig = "Wenige";
		Tetris_UBE_CF_Text_r_lines_on = "Anzahl Zufallslinien:";
		Tetris_UBE_CF_Text_r_lines_off = "Zufallslinien abgeschaltet";
		Tetris_UBE_OF_s_Text_gross = "Gross";
		Tetris_UBE_OF_s_Text_klein = "Klein";
		Tetris_UBE_OF_Text_bgrosse = "Zellengr\195\181sse:";


	elseif GetLocale() == "frFR" then
	--franz
	end
	
--BUTTONS und TITELTEXTE setzen
	--buttons
	Tetris_GF_BF_u:SetText(Tetris_UBE_GF_BF_u);	
	Tetris_GF_BF_d:SetText(Tetris_UBE_GF_BF_d);	
	Tetris_GF_BF_l:SetText(Tetris_UBE_GF_BF_l);	
	Tetris_GF_BF_r:SetText(Tetris_UBE_GF_BF_r);
	Tetris_GF_b_close:SetText(Tetris_UBE_GF_b_close);
	Tetris_GF_b_newgame:SetText(Tetris_UBE_GF_b_newgame);

	Tetris_MF_exit:SetText(Tetris_UBE_MF_exit);
	Tetris_MF_resume:SetText(Tetris_UBE_MF_resume);
	Tetris_MF_ms_dos:SetText(Tetris_UBE_MF_ms_dos);
	Tetris_MF_gameboy:SetText(Tetris_UBE_MF_gameboy);
	Tetris_MF_retris:SetText(Tetris_UBE_MF_retris);
	Tetris_MF_highest_hopes:SetText(Tetris_UBE_MF_highest_hopes);
	Tetris_MF_custom:SetText(Tetris_UBE_MF_custom);
	Tetris_MF_options:SetText(Tetris_UBE_MF_options);

	Tetris_CF_b_Ok:SetText(Tetris_UBE_CF_b_ok);
	Tetris_CF_b_Exit:SetText(Tetris_UBE_CF_b_exit);
	Tetris_CF_b_StoneSetup:SetText(Tetris_UBE_GF_b_stonesetup);

	Tetris_SOF_b_Next:SetText(Tetris_UBE_SOF_b_next);
	Tetris_SOF_b_Back:SetText(Tetris_UBE_SOF_b_back);
	Tetris_SOF_b_Ok:SetText(Tetris_UBE_SOF_b_ok);

	Tetris_OF_b_exit:SetText(Tetris_UBE_OF_b_exit);
	Tetris_OF_b_ok:SetText(Tetris_UBE_OF_b_ok);
	
	Tetris_AF_b_ja:SetText(Tetris_UBE_AF_b_ja);
	Tetris_AF_b_nein:SetText(Tetris_UBE_AF_b_nein);

	--texte
	Tetris_GF_NS_Titeltext:SetText(Tetris_UBE_GF_NS_Titeltext);
	Tetris_GF_SF_Titeltext:SetText(Tetris_UBE_GF_SC_Titeltext);
	Tetris_MF_Titeltext:SetText(Tetris_UBE_MF_Titeltext..Tetris["version"]);
	Tetris_CF_Titeltext:SetText(Tetris_UBE_CF_Titeltext);
	Tetris_CF_Text_dropdown:SetText(Tetris_UBE_CF_Text_dropdown);
	Tetris_SOF_Titeltext:SetText(Tetris_UBE_SOF_Titeltext.."  ("..Tetris["options"]["max_s"]..")");
	Tetris_OF_Titeltext:SetText(Tetris_UBE_OF_Titeltext);
	Tetris_OF_c_Text_gost:SetText(Tetris_UBE_OF_c_Text_gost);
	Tetris_OF_c_Text_sound:SetText(Tetris_UBE_OF_c_Text_sound);
	Tetris_OF_c_Text_musik:SetText(Tetris_UBE_OF_c_Text_musik);
	Tetris_OF_c_Text_mous:SetText(Tetris_UBE_OF_c_Text_mous);
	Tetris_OF_Text_dropdown:SetText(Tetris_UBE_OF_Text_dropdown);
	Tetris_OF_Text_mdropdown:SetText(Tetris_UBE_OF_Text_mdropdown);
	Tetris_AF_Text:SetText(Tetris_UBE_AF_Text);
	Tetris_AF_Titeltext:SetText(Tetris_UBE_AF_Titeltext);
end



