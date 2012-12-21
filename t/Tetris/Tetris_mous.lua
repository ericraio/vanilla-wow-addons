--piece nach links/rechts bewegen
--x = 1, wenn ohne mausbewegung stein verschoben wird
function Tetris_mous_OnPieceEnter (x)
	if (Tetris["options"]["mous"] == 1) then
		local name = nil;
		if (x == 1) then
			name = Tetris["game"]["mous"];
		else
			name = this:GetName();
			--name speichern für eventueller neuer stein
			Tetris["game"]["mous"] = name 
		end
		--xy pos holen
		local pos = Tetris_return_xy(name)
		local x = pos["x"];
		--x pos des steins
		local s_x = Tetris["game"]["s_pos_x"];
		if (x>s_x) then
			local z = x-s_x
			for i=1, z do
				Tetris_GF_BF_r:Click();
			end
		elseif (x<s_x) then
			local z = s_x-x
			for i=1, z do
				Tetris_GF_BF_l:Click();
			end		
		end
	end
end

--piece drehen, nach unten
function Tetris_mous_OnDownClick(arg1)
	if (Tetris["options"]["mous"] == 1) then
		--nach rechts drehen
		if (arg1 == "RightButton") then
			Tetris_GF_BF_u:Click();
		end
		--nach unten
		if (arg1 == "LeftButton") then
			--starte den timer
			Timex:AddNamedSchedule("Tetris_down_time", 0.5, nil, 1, Tetris_mouse_scroll_down)
		end
	end	
end

--piece nach unten
function Tetris_mous_OnUpClick(arg1)
	if (Tetris["options"]["mous"] == 1) then
		--nach unten
		if (arg1 == "LeftButton") then
			--stoppe scroll down
			if (Timex:NamedScheduleCheck("Tetris_down_time") == nil) then
				Timex:DeleteNamedSchedule("Tetris_scroll_down");
				Tetris_timer_go ();
			else
			--instant drop
				Timex:DeleteNamedSchedule("Tetris_down_time");
				Tetris_GF_BF_d:Click();
			end
		end
	end
end

--piece nach unten scrollen
function Tetris_mouse_scroll_down ()
	if (Timex:NamedScheduleCheck("Tetris_stone_timer") ~= nil) then
		Timex:DeleteNamedSchedule("Tetris_stone_timer");
	end
	Tetris_stone_move ("dd");
	Timex:AddNamedSchedule("Tetris_scroll_down", 0.1, nil, 1, Tetris_mouse_scroll_down)
end

