function Tetris_MF_Button_Click ()
	local button = this:GetName();
	
	if (button == "Tetris_MF_resume") then
		Tetris_gameresume ();
		Tetris_GF_Toggle();
		Tetris_MF_Toggle();
	end
	
	if (button == "Tetris_MF_ms_dos") then
		Tetris["game"]["next_game"]= "ms_dos";
		Tetris_AF_Toggle();
		Tetris_MF_Toggle();
	end

	if (button == "Tetris_MF_gameboy") then
		Tetris["game"]["next_game"]= "gameboy";
		Tetris_AF_Toggle();
		Tetris_MF_Toggle();
	end
	
	if (button == "Tetris_MF_retris") then
		Tetris["game"]["next_game"]= "retris";
		Tetris_AF_Toggle();
		Tetris_MF_Toggle();
	end
	
	if (button == "Tetris_MF_highest_hopes") then
		Tetris["game"]["next_game"]= "highest_hopes";
		Tetris_AF_Toggle();
		Tetris_MF_Toggle();
	end

	if (button == "Tetris_MF_custom") then
		Tetris["game"]["next_game"]= "custom";
		Tetris_AF_Toggle();
		Tetris_MF_Toggle();
	end	

	if (button == "Tetris_MF_options") then
		Tetris_OF_Toggle();
		Tetris_MF_Toggle();
	end

	if (button == "Tetris_MF_exit") then
		Tetris_MF_Toggle();
		Tetris_play_musik ("stop");
	end
end

function Tetris_MF_Toggle()
	if(Tetris_MF:IsVisible()) then
		Tetris_MF:Hide();
	else
		Tetris_MF:Show();
		Tetris_MF_resume_Update ();
		Tetris_play_musik ("menu");
	end	
end

function Tetris_MF_resume_Update ()
	local ingame = 	Tetris["ingame"];
	if (ingame == 0) then
		Tetris_MF_resume:Disable ();
	else
		Tetris_MF_resume:Enable ();
	end
end
