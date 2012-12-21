-- Gems, a silly gems-based minigame to kill time.
-- Use /gems to bring up the game.

local Gems_GameIsOver = false;

local Gems_Paused = false;
local Gems_TimerOn = false;
local Gems_TimerFunction;
local Gems_Tick;
local Gems_TimerEnd = 0;
local Gems_PulseTime = 0.5;
local Gems_Score = 0;

local Gems_GemTypes = 10;

local Gems_FallingX = -1;
local Gems_FallingY = 0;

local Gems_GemTextures = {
	"",
	"Interface\\Icons\\INV_Misc_Gem_Topaz_01",
	"Interface\\Icons\\INV_Misc_Gem_Diamond_01",
	"Interface\\Icons\\INV_Misc_Gem_Opal_01",
	"Interface\\Icons\\INV_Misc_Gem_Ruby_01",
	"Interface\\Icons\\INV_Misc_Gem_Amethyst_01",
	"Interface\\Icons\\INV_Misc_Gem_Bloodstone_01",
	"Interface\\Icons\\INV_Misc_Gem_Crystal_01",
	"Interface\\Icons\\INV_Misc_Gem_Emerald_01",
	"Interface\\Icons\\INV_Misc_Gem_Sapphire_01",
	"Interface\\Icons\\INV_Misc_Gem_Stone_01",
	"Interface\\Icons\\INV_Misc_Gem_Variety_01",
	"Interface\\Icons\\INV_Misc_Gem_01",
	"Interface\\Icons\\INV_Misc_Gear_01",
	"Interface\\Icons\\INV_Misc_Rune_01",
	"Interface\\Icons\\INV_Ore_Arcanite_01",
	"Interface\\Icons\\INV_Ore_Copper_01",
	"Interface\\Icons\\INV_Ore_Iron_01",
	"Interface\\Icons\\INV_Ore_Mithril_01",
	"Interface\\Icons\\INV_Ore_Thorium_01",
	"Interface\\Icons\\INV_Ore_Tin_01",
	"Interface\\Icons\\INV_Ore_TrueSilver_01"
}

-- some strings for the key bindings
BINDING_HEADER_GEMS = "Val's Gems";
BINDING_NAME_GEMS_LEFT = "Move Left";
BINDING_NAME_GEMS_RIGHT = "Move Right";
BINDING_NAME_GEMS_DOWN = "Move Down";
	

function Gems_OnLoad()
	-- Register the slash command
	SLASH_GEMS1 = "/gems";
	SlashCmdList["GEMS"] = function(msg)
		Gems_SlashCommand(msg);
	end

	-- hide the frame when escape is pressed
	tinsert(UISpecialFrames,"Gems_Frame");

	Gems_Write("Val's Gems loaded. Type |cffff0000/gems|r to play or |cffff0000/gems help|r for instructions.");
	Gems_NewGame();
end

function Gems_SlashCommand(msg)
	if(msg == nil or msg == "") then
		Gems_Toggle();
	elseif(msg == "help") then
		Gems_Help();
	end
end

function Gems_Help()
	Gems_Write("Help for Val's Gems");
	Gems_Write("=================");
	Gems_Write("The premise of this game is easy - connect 4 of the same gem horizontally, vertically, or diagonally.");
	Gems_Write("Use the < and > buttons to move the falling gems left or right, and the v button to drop the gem to the bottom.");
end

function Gems_Toggle()
	if(getglobal("Gems_Frame"):IsShown()) then
		getglobal("Gems_Frame"):Hide();
	else
		getglobal("Gems_Frame"):Show();
	end
end

function Gems_NewGame()
	
	Gems_GameIsOver = false;
	
	Gems_TimerEnd = 0;
	Gems_Paused = false;

	Gems_FallingX = -1;
	Gems_FallingY = 0;
	Gems_Score = 0;
	Gems_UpdateScore(Gems_Score);
	
	getglobal("Gems_PauseButton"):UnlockHighlight();
	
	for i = 1,64 do
		getglobal("Gems_Cell" .. i).gem = 0;
		Gems_DrawCell(i);
	end

	Gems_ScheduleTimer(Gems_PulseTime, Gems_Pulse);
end

function Gems_Pulse()
	
	if(Gems_FallingX == -1) then
		Gems_SpawnGem();
	else
		local gemcell = Gems_FallingX * 8 + Gems_FallingY;
		
		if(gemcell > 56) then
			Gems_CheckMatch(Gems_FallingX, Gems_FallingY);
			Gems_FallingX = -1;

		elseif(getglobal("Gems_Cell" .. gemcell+8).gem > 0) then
			Gems_CheckMatch(Gems_FallingX, Gems_FallingY);
			Gems_FallingX = -1

		else
			--Gems_Write("gemcell is " .. gemcell);
			local gemval = getglobal("Gems_Cell" .. gemcell).gem;
			getglobal("Gems_Cell" .. gemcell).gem = 0;
			getglobal("Gems_Cell" .. gemcell+8).gem = gemval;
			Gems_DrawCell(gemcell);
			Gems_DrawCell(gemcell+8);
			Gems_FallingX = Gems_FallingX + 1;
		end
	end
	
	Gems_ScheduleTimer(Gems_PulseTime, Gems_Pulse);
end

function Gems_DrawCell(cellnum)
	local i = getglobal("Gems_Cell" .. cellnum).gem + 1;
	--getglobal("Gems_Cell" .. cellnum):SetBackdropColor(Gems_GemColors[i]["r"], Gems_GemColors[i]["g"], Gems_GemColors[i]["b"]);
	if(i == 1) then
		getglobal("Gems_Cell" .. cellnum):Hide();
	else
		getglobal("Gems_Cell" .. cellnum):Show();
		getglobal("Gems_Cell" .. cellnum):SetNormalTexture(Gems_GemTextures[i]);
	end
end

function Gems_SpawnGem()
	local column = 4;
	local gemval = math.random(1,Gems_GemTypes);
	
	Gems_FallingX = 0;
	Gems_FallingY = column;
	
	--Gems_Write("spawning in " .. column);
	
	getglobal("Gems_Cell" .. Gems_FallingY).gem = gemval;
	Gems_DrawCell(Gems_FallingY);
end

function Gems_MoveLeft()
	local gemcell = Gems_FallingX * 8 + Gems_FallingY;
	if(Gems_FallingY > 1) then
		if(Gems_FallingX == -1 or Gems_FallingX > 6 or getglobal("Gems_Cell" .. gemcell-1).gem > 0) then return end;
		Gems_FallingY = Gems_FallingY - 1;	
		local gemval = getglobal("Gems_Cell" .. gemcell).gem;
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		getglobal("Gems_Cell" .. gemcell-1).gem = gemval;
		Gems_DrawCell(gemcell);
		Gems_DrawCell(gemcell-1);
	end
end

function Gems_MoveRight()
	local gemcell = Gems_FallingX * 8 + Gems_FallingY;
	if(Gems_FallingY < 8) then
		if(Gems_FallingX == -1 or Gems_FallingX > 6 or getglobal("Gems_Cell" .. gemcell+1).gem > 0) then return end;
		Gems_FallingY = Gems_FallingY + 1;
		local gemval = getglobal("Gems_Cell" .. gemcell).gem;
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		getglobal("Gems_Cell" .. gemcell+1).gem = gemval;
		Gems_DrawCell(gemcell);
		Gems_DrawCell(gemcell+1);
	end
end

function Gems_MoveDown()
	if(Gems_FallingX == -1) then
		return;
	end
	local gemcell = Gems_FallingX * 8 + Gems_FallingY;
	local gemval = getglobal("Gems_Cell" .. gemcell).gem;

	while(gemcell <= 56 and getglobal("Gems_Cell" .. gemcell+8).gem == 0) do
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		getglobal("Gems_Cell" .. gemcell+8).gem = gemval;
		Gems_DrawCell(gemcell);
		Gems_DrawCell(gemcell+8);
		gemcell = gemcell + 8;
		Gems_FallingX = Gems_FallingX + 1;
	end
end

function Gems_Collapse()
	local didcollapse = false;
	for y = 1,8 do
		for x = 7,1,-1 do
			--Gems_Write("checking " .. x .. "," .. y .. " (" .. (x*8 + y) .. " - " .. getglobal("Gems_Cell" .. (x*8 + y)).gem);
			if(getglobal("Gems_Cell" .. (x*8 + y)).gem == 0) then
			--	Gems_Write("collapsing");
				getglobal("Gems_Cell" .. (x*8 + y)).gem = getglobal("Gems_Cell" .. ((x-1)*8 + y)).gem;
				getglobal("Gems_Cell" .. ((x-1)*8 + y)).gem = 0;
				Gems_DrawCell(x*8 + y);
				Gems_DrawCell((x-1)*8 + y);
				didcollapse = true;
		--	else
		--		Gems_Write("breaking");
		--		break;
			end
		end
	end
	
	if(didcollapse) then
		for y = 1,8 do
			for x = 7,1,-1 do
				if(getglobal("Gems_Cell" .. (x*8 + y)).gem > 0) then
					Gems_CheckMatch(x,y);
				end
			end
		end
	end
end

function Gems_CheckMatch(x, y)
	local gemcell = x * 8 + y;
	local gemval = getglobal("Gems_Cell" .. gemcell).gem;
	
	if(gemval == 0) then return	end

	local htotal = Gems_ScanLeft(x, y, gemval) + Gems_ScanRight(x, y, gemval) - 1;
	local dtotal1 = Gems_ScanUpLeft(x, y, gemval) + Gems_ScanDownRight(x, y, gemval) - 1;
	local dtotal2 = Gems_ScanDownLeft(x, y, gemval) + Gems_ScanUpRight(x, y, gemval) - 1;
	local vtotal = Gems_ScanUp(x, y, gemval) + Gems_ScanDown(x, y, gemval) -1;
	
	local scoreval = 0;

	if(htotal >= 4) then
		if(y > 1) then
			Gems_DelLeft(x, y-1, gemval);
		end
		
		if(y < 8) then
			Gems_DelRight(x, y+1, gemval);
		end
		scoreval = scoreval + (htotal - 3) * 5;
	end
	
	if(vtotal >= 4) then
		if(x > 0) then
			Gems_DelUp(x-1, y, gemval);
		end
		
		if(x < 7) then
			Gems_DelDown(x+1, y, gemval);
		end
		scoreval = scoreval + (vtotal - 3) * 5;
	end
	
	if(dtotal2 >= 4) then
		if(x < 7 and y > 1) then
			Gems_DelDownLeft(x+1, y-1, gemval);
		end
		
		if(x > 0 and y < 8) then
			Gems_DelUpRight(x-1, y+1, gemval);
		end
		scoreval = scoreval + (dtotal2 - 3) * 5;
	end
	
	if(dtotal1 >= 4) then
		if(x > 0 and y > 1) then
			Gems_DelUpLeft(x-1, y-1, gemval);
		end
		
		if(x < 7 and y < 8) then
			Gems_DelDownRight(x+1, y+1, gemval);
		end
		scoreval = scoreval + (dtotal1 - 3) * 5;
	end
	
	if(htotal >= 4 or vtotal >=4 or dtotal1 >= 4 or dtotal2 >= 4) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
		Gems_Collapse();
		Gems_UpdateScore(Gems_Score + scoreval);
	end
end

function Gems_ScanLeft(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;
		
		if(y > 1) then
			total = total + Gems_ScanLeft(x, y-1, gemval);
		end
	end
	return total;
end

function Gems_ScanRight(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;

		if(y < 8) then
			total = total + Gems_ScanRight(x, y+1, gemval);
		end
	end
		
	return total;
end

function Gems_ScanUp(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;
	
		if(x > 0) then
			total = total + Gems_ScanUp(x-1, y, gemval);
		end
	end
	return total;
end

function Gems_ScanDown(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;
	
		if(x < 7) then
			total = total + Gems_ScanDown(x+1, y, gemval);
		end
	end
	return total;
end

function Gems_ScanUpLeft(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;
	
		if(x > 0 and y > 1) then
			total = total + Gems_ScanUpLeft(x-1, y-1, gemval);
		end
	end
	return total;
end

function Gems_ScanUpRight(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;
	
		if(x > 0 and y < 8) then
			total = total + Gems_ScanUpRight(x-1, y+1, gemval);
		end
	end
	return total;
end

function Gems_ScanDownLeft(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;
	
		if(x < 7 and y > 1) then
			total = total + Gems_ScanDownLeft(x+1, y-1, gemval);
		end
	end
	return total;
end

function Gems_ScanDownRight(x, y, gemval)
	local total = 0;
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		total = 1;
	
		if(x < 7 and y < 8) then
			total = total + Gems_ScanDownRight(x+1, y+1, gemval);
		end
	end
	return total;
end

function Gems_DelLeft(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
		
		if(y > 1) then
			Gems_DelLeft(x, y-1, gemval);
		end
	end
end

function Gems_DelRight(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);

		if(y < 8) then
			Gems_DelRight(x, y+1, gemval);
		end
	end
end

function Gems_DelUp(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
	
		if(x > 0) then
			Gems_DelUp(x-1, y, gemval);
		end
	end
end

function Gems_DelDown(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
	
		if(x < 7) then
			Gems_DelDown(x+1, y, gemval);
		end
	end
end

function Gems_DelUpLeft(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
	
		if(x > 0 and y > 1) then
			Gems_DelUpLeft(x-1, y-1, gemval);
		end
	end

end

function Gems_DelUpRight(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
	
		if(x > 0 and y < 8) then
			Gems_DelUpRight(x-1, y+1, gemval);
		end
	end
end

function Gems_DelDownLeft(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
	
		if(x < 7 and y > 1) then
			Gems_DelDownLeft(x+1, y-1, gemval);
		end
	end
end

function Gems_DelDownRight(x, y, gemval)
	local gemcell = x * 8 + y;
	if(getglobal("Gems_Cell" .. gemcell).gem == gemval) then
		getglobal("Gems_Cell" .. gemcell).gem = 0;
		Gems_DrawCell(gemcell);
	
		if(x < 7 and y < 8) then
			Gems_DelDownRight(x+1, y+1, gemval);
		end
	end
end

function Gems_UpdateScore(newscore)
	Gems_Score = newscore;
	--Gems_Write("Score is now " .. Gems_Score);
	getglobal("Gems_ScoreString"):SetText(Gems_Score);
end

function Gems_PauseToggle()
	if(Gems_Paused == false) then
		Gems_Paused = true;
		Gems_TimerOn = false;
		this:LockHighlight();
	else
		Gems_Paused = false;
		Gems_TimerOn = true;
		this:UnlockHighlight();
	end
end

function Gems_ScheduleTimer(time, func)
	Gems_TimerFunction = func;
	Gems_TimerEnd = GetTime() + time;
	Gems_TimerOn = true;
end

function Gems_OnUpdate()
	if (not Gems_TimerOn) then return end
	local Gems_Tick = GetTime();
	if (Gems_TimerEnd - Gems_Tick < 0) then
		Gems_TimerOn = false;
		Gems_TimerFunction();
	end
end

function Gems_Difficulty_Initialize()
	local info;
	info = {
		text = "Easy";
		func = Gems_Difficulty_OnClick;
	};
	UIDropDownMenu_AddButton(info);
	
	info = {
		text = "Medium";
		func = Gems_Difficulty_OnClick;
	};
	UIDropDownMenu_AddButton(info);
	
	info = {
		text = "Hard";
		func = Gems_Difficulty_OnClick;
	};
	UIDropDownMenu_AddButton(info);
	
	info = {
		text = "Crazy";
		func = Gems_Difficulty_OnClick;
	};
	UIDropDownMenu_AddButton(info);

end

function Gems_Difficulty_OnLoad()
	UIDropDownMenu_Initialize(Gems_Difficulty, Gems_Difficulty_Initialize);
	UIDropDownMenu_SetSelectedID(Gems_Difficulty, 1);
	UIDropDownMenu_SetWidth(60);
end

function Gems_Difficulty_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(Gems_Difficulty);
	UIDropDownMenu_SetSelectedID(Gems_Difficulty, this:GetID());
	if(oldID ~= this:GetID()) then
		Gems_ChangeDifficulty();
	end
end

function Gems_Write(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function Gems_ChangeDifficulty()
	local id = UIDropDownMenu_GetSelectedID(Gems_Difficulty);
	if(id == 1) then
		Gems_GemTypes = 10
	elseif(id == 2) then
		Gems_GemTypes = 13
	elseif(id == 3) then
		Gems_GemTypes = 15
	elseif(id == 4) then
		Gems_GemTypes = 20
	end
	
	Gems_NewGame();
end
