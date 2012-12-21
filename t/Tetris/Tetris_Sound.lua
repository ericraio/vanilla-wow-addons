function Tetris_play_sound (stk)
--stk   u = drehen
--		l = links
--		r = rechts
--		d = unten
--		timer = unten durch timer
--		tet = vier linien
--		dl = eine normale linie
--		go = game over

	local sound = Tetris["options"]["sound"];
	if (sound == 1) then
		if (stk == "u") then
			PlaySoundFile("Interface\\AddOns\\Tetris\\sound\\turn.wav");
		end
		if (stk == "l")or(stk == "r") then
			PlaySoundFile("Interface\\AddOns\\Tetris\\sound\\move.wav");
		end
		if (stk == "d")or(stk == "timer") then
			PlaySoundFile("Interface\\AddOns\\Tetris\\sound\\down.wav");
		end
		if (stk == "dl") then
			PlaySoundFile("Interface\\AddOns\\Tetris\\sound\\line.wav");
		end
		if (stk == "tet") then
			PlaySoundFile("Interface\\AddOns\\Tetris\\sound\\tetris.wav");
		end
		if (stk == "go") then
			PlaySoundFile("Interface\\AddOns\\Tetris\\sound\\go.wav");
		end
	end
end

function Tetris_play_musik (x)
--x		stop = musik stoppen
--		game = gamemusik abspielen
--		menu = menumusik abspielen
	local musik = Tetris["options"]["musik"];
	local m_track = Tetris["options"]["musik-track"];
	--track 1 = random
	--track 2 = gb a
	--track 3 = gb b
	--track 4 = gb c
	--track 5 = musical
	--track 6 = remix
	if (musik == 1) then
		if (x == "stop") then
			StopMusic();
		end
		if (x == "game") then
			if (m_track == 1) then
				local track = (math.random(5))+1;
				PlayMusic("Interface\\AddOns\\Tetris\\musik\\"..track..".mp3");
			else
				PlayMusic("Interface\\AddOns\\Tetris\\musik\\"..m_track..".mp3");
			end
		end
		if (x == "menu" ) then
			PlayMusic("Interface\\AddOns\\Tetris\\musik\\0.mp3");			
		end
	end
end
