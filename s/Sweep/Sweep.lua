
local Sweep_Mines = 10;
local Sweep_FlagsDown = 0;
local Sweep_NumExposed = 0;
local Sweep_GameIsOver = false;

function Sweep_OnLoad()
	-- Register the slash command
	SLASH_SWEEP1 = "/sweep";
	SlashCmdList["SWEEP"] = function(msg)
		Sweep_SlashCommand(msg);
	end

	Sweep_Write("Val's Sweep loaded. Type |cffff0000/sweep|r to play or |cffff0000/sweep help|r for instructions.");
	Sweep_NewGame();
end

function Sweep_SlashCommand(msg)
	if(msg == nil or msg == "") then
		Sweep_Toggle();
	elseif(msg == "help") then
		Sweep_Help();
	end
end

function Sweep_Help()
	Sweep_Write("Help for Val's Sweep");
	Sweep_Write("=================");
	Sweep_Write("- Expose a square by clicking it. If you expose a mine, you lose.");
	Sweep_Write("- A number on a square tells how many mines are adjacent to the square.");
	Sweep_Write("- If you think a square contains a mine, right-click to mark it.");
	Sweep_Write("- When all non-mined squares are exposed, you win.");
	Sweep_Write("- There are " .. Sweep_Mines .. " mines per game.");
end

function Sweep_Toggle()
	if(getglobal("Sweep_Frame"):IsShown()) then
		getglobal("Sweep_Frame"):Hide();
	else
		getglobal("Sweep_Frame"):Show();
	end
end

function Sweep_NewGame()
	
	Sweep_FlagsDown = 0;
	Sweep_NumExposed = 0;
	Sweep_GameIsOver = false;
	
	for i = 1,64 do
		getglobal("Sweep_Cell" .. i).mined = false;
		getglobal("Sweep_Cell" .. i).flagged = false;
		getglobal("Sweep_Cell" .. i).exposed = false;
		getglobal("Sweep_Cell" .. i).adjacent = 0;
		getglobal("Sweep_Cell" .. i .. "Label"):SetText("");
		getglobal("Sweep_Cell" .. i):SetBackdropColor(0.0, 0.0, 0.0);
	end
	
	local minesToLay = Sweep_Mines;
	local cellNum;
	math.randomseed = 3;
	while(minesToLay > 0) do
		cellNum = math.random(1,64);
		if(not getglobal("Sweep_Cell" .. cellNum).mined) then
			getglobal("Sweep_Cell" .. cellNum).mined = true;
			--getglobal("Sweep_Cell" .. cellNum .. "Label"):SetText("*");
			minesToLay = minesToLay - 1;
		end
	end
end

function Sweep_CellOnClick(arg1)
	local frame = this:GetName();
	
	if(Sweep_GameIsOver) then
		return;
	end
	
	if(arg1 == "LeftButton") then
		if(this.mined) then
			Sweep_GameOver(frame);
		elseif(not this.flagged) then
			Sweep_Expose(this);
		end
	elseif(arg1 == "RightButton") then
		if(this.flagged) then
			this.flagged = false;
			Sweep_FlagsDown = Sweep_FlagsDown - 1;
			if(this.exposed) then
				if(this.adjacent > 0) then
					this:SetBackdropColor(0.5, 0.0, 0.0);
					getglobal(frame.."Label"):SetText(this.adjacent);
				else
					this:SetBackdropColor(0.0, 0.5, 0.0);
					getglobal(frame.."Label"):SetText("");
				end
			else
				this:SetBackdropColor(0.0, 0.0, 0.0);
				getglobal(frame.."Label"):SetText("");
			end
			
		else
			this.flagged = true;
			Sweep_FlagsDown = Sweep_FlagsDown + 1;
			getglobal(frame.."Label"):SetText("F");
			this:SetBackdropColor(0.0, 0.0, 0.5);
			Sweep_CheckVictory();
		end
	end
end

function Sweep_Expose(frame)

	if(frame.exposed or frame.mined or frame.flagged) then
		return;
	end
	
	local adjacent = 0;
	local id = frame:GetID();
	
	local is_top = (id < 9);
	local is_left = (math.mod(id-1, 8) == 0);
	local is_right = (math.mod(id-1, 8) == 7);
	local is_bottom = (id > 56);
	
	frame.exposed = true;
	Sweep_NumExposed = Sweep_NumExposed + 1;

	
	if(not is_top) then
		
		if(getglobal("Sweep_Cell"..id-8).mined) then
			adjacent = adjacent + 1;
		end
		
		
		if(not is_left) then
			if(getglobal("Sweep_Cell"..id-9).mined) then
				adjacent = adjacent + 1;
			end
		end
		
		if(not is_right) then
			if(getglobal("Sweep_Cell"..id-7).mined) then
				adjacent = adjacent + 1;
			end
		end
	end
	
	if(not is_left) then
		if(getglobal("Sweep_Cell"..id-1).mined) then
			adjacent = adjacent + 1;
		end
		
	end
	
	if(not is_right) then
		if(getglobal("Sweep_Cell"..id+1).mined) then
			adjacent = adjacent + 1;
		end
		
	end
	
	if(not is_bottom) then
		if(getglobal("Sweep_Cell"..id+8).mined) then
			adjacent = adjacent + 1;
		end
		
		
		if(not is_left) then
			if(getglobal("Sweep_Cell"..id+7).mined) then
				adjacent = adjacent + 1;
			end
		end
		
		if(not is_right) then
			if(getglobal("Sweep_Cell"..id+9).mined) then
				adjacent = adjacent + 1;
			end
		end
	end
	
	if(adjacent > 0) then
		getglobal("Sweep_Cell" .. id .. "Label"):SetText(adjacent);
		frame:SetBackdropColor(0.5, 0.0, 0.0);
	else
		frame:SetBackdropColor(0.0, 0.5, 0.0);
		
		if(not is_top) then
		
			Sweep_Expose(getglobal("Sweep_Cell"..id-8));
			
			
			if(not is_left) then
				Sweep_Expose(getglobal("Sweep_Cell"..id-9));
			end
			
			if(not is_right) then
				Sweep_Expose(getglobal("Sweep_Cell"..id-7));
			end
		end
		
		if(not is_left) then
			Sweep_Expose(getglobal("Sweep_Cell"..id-1));
		end
		
		if(not is_right) then
			Sweep_Expose(getglobal("Sweep_Cell"..id+1));
		end
		
		if(not is_bottom) then
			Sweep_Expose(getglobal("Sweep_Cell"..id+8));
			
			
			if(not is_left) then
				Sweep_Expose(getglobal("Sweep_Cell"..id+7));
			end
			
			if(not is_right) then
				Sweep_Expose(getglobal("Sweep_Cell"..id+9));
			end
		end
	end
	
	frame.adjacent = adjacent;
	
	Sweep_CheckVictory();
		
end

function Sweep_GameOver(frame)
	Sweep_Write("BOMB! Game over.");
	
	for i = 1,64 do
		if(getglobal("Sweep_Cell" .. i).mined and not getglobal("Sweep_Cell" .. i).flagged) then
			getglobal("Sweep_Cell" .. i .. "Label"):SetText("*");
		end
	end
	
	getglobal(frame.."Label"):SetText("X");
	Sweep_GameIsOver = true;
end

function Sweep_CheckVictory()
	if(Sweep_NumExposed + Sweep_FlagsDown == 64) then
		Sweep_Write("You Win!");
		Sweep_GameIsOver = true;
	end
end

function Sweep_Write(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end
