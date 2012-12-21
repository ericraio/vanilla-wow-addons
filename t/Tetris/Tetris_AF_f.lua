function Tetris_AF_b_click ()
	local button = this:GetName();
	if (button == "Tetris_AF_b_ja") then
		Tetris_newgame ();
		Tetris_AF_Toggle();
	end
	if (button == "Tetris_AF_b_nein") then
		Tetris_AF_Toggle();
		Tetris_MF_Toggle();
	end
end

function Tetris_AF_Toggle()
	if(Tetris_AF:IsVisible()) then
		Tetris_AF:Hide();
	else
		local ingame = 	Tetris["ingame"];
		if (ingame == 0) then
			Tetris_newgame ();
		else
			Tetris_AF:Show();
		end
			
	end	
end