--[[
	Author: 		Jacob Bowers (Thronk on Mal'Ganis server)
	
]]


MinesweeperOptions = {};
local CS_BLANK = 0;
local CS_QUESTION = 1;
local CS_FLAGGED = 2;
local CS_CLEARED = 3;
local CS_MINE = 4;
local NUM_SQUARES = 81;
local NUM_MINES = 10;
local GameLost = 0;
local NumUncovered = 0;

local CellState = {state = 0, bMined = 0, num = 0};

function Minesweeper_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");

	SlashCmdList["MINESWEEPER"] = Minesweeper_SlashHandler;
		SLASH_MINESWEEPER1 = "/minesweeper";

	MS_CreateMatrix();

end


function Minesweeper_OnEvent(event)

	if( event == "VARIABLES_LOADED") then
		
	end
end


function MS_Test1()
	PlaySoundFile("Sound\\Doodad\\G_Mortar.wav");
end


function MS_CreateMatrix()
	local sent = 0;
	local cnt = 0;
	local val = 0;

	GameLost = 0;
	NumUncovered = 0;

	for i=1,NUM_SQUARES do
		CellState[i] = {state = 0, bMined = 0, num = 0};
		
		getglobal("MSButton"..i.."TextureOverlay"):SetTexture("");

		if(random() > 0.5) then
			getglobal("MSButton"..i.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonPlainv3");
		else
			getglobal("MSButton"..i.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonPlainv3_2");
		end
		getglobal("MSButton"..i):SetText("");
	end

	while (sent == 0) do
		
		val = floor(random()*NUM_SQUARES);

		if ( val == 0 ) then
			val = 1;
		end

		if ( CellState[val].bMined == 0 ) then
			CellState[val].bMined = 1;
			MS_UpdateCellNumbers(val);
			cnt = cnt + 1;
		end

		if ( cnt >= NUM_MINES ) then
			sent = 1;
		end
	end

	
end


function MS_UpdateCellNumbers(cellnum)
	
	if ( MS_CheckIsInLeftmostColumn(cellnum) == nil) then
		if ( cellnum - 10 > 0 ) then
			CellState[cellnum-10].num = CellState[cellnum-10].num + 1;
		end
	end


	if ( cellnum - 9 > 0 ) then
		CellState[cellnum-9].num = CellState[cellnum-9].num + 1;
	end

	if ( MS_CheckIsInRightmostColumn(cellnum) == nil) then
		if ( cellnum - 8 > 0 ) then
			CellState[cellnum-8].num = CellState[cellnum-8].num + 1;
		end
	end
	
	


	if ( MS_CheckIsInLeftmostColumn(cellnum) == nil) then
		if ( cellnum - 1 > 0 ) then
			CellState[cellnum-1].num = CellState[cellnum-1].num + 1;
		end
	end 

	if ( MS_CheckIsInRightmostColumn(cellnum) == nil) then
		if ( cellnum + 1 <= NUM_SQUARES ) then
			CellState[cellnum+1].num = CellState[cellnum+1].num + 1;
		end
	end 



	if ( MS_CheckIsInRightmostColumn(cellnum) == nil ) then
		if ( cellnum + 10 <= NUM_SQUARES ) then
			CellState[cellnum+10].num = CellState[cellnum+10].num + 1;
		end
	end
	if ( cellnum + 9 <= NUM_SQUARES ) then
		CellState[cellnum+9].num = CellState[cellnum+9].num + 1;
	end
	if ( MS_CheckIsInLeftmostColumn(cellnum) == nil) then
		if ( cellnum + 8 <= NUM_SQUARES ) then
			CellState[cellnum+8].num = CellState[cellnum+8].num + 1;
		end
	end
end


function MS_CheckIsInLeftmostColumn(cellnum)
	if( cellnum == 1 or cellnum == 10 or cellnum == 19 or cellnum == 28 or cellnum == 37 or cellnum == 46 or cellnum == 55 or cellnum == 64 or cellnum == 73 ) then
		return 1;
	else
		return nil;
	end
end

function MS_CheckIsInRightmostColumn(cellnum)
	if( cellnum == 9 or cellnum == 18 or cellnum == 27 or cellnum == 36 or cellnum == 45 or cellnum == 54 or cellnum == 63 or cellnum == 72 or cellnum == 81 ) then
		return 1;
	else
		return nil;
	end
end

function MS_CheckIsInBottommostRow(cellnum)
	if( cellnum >= 72 ) then
		return 1;
	else
		return nil;
	end
end

function MS_CheckIsInTopmostRow(cellnum)
	if( cellnum <= 9 ) then
		return 1;
	else
		return nil;
	end
end

function MS_UncoverMatrix()
	local i;

	GameLost = 1;

	for i=1,NUM_SQUARES do
		if ( CellState[i].bMined == 0 ) then
			getglobal("MSButton"..i.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
		else
			if ( CellState[i].state ~= CS_MINE ) then
				getglobal("MSButton"..i.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearMinev2");
			else
				getglobal("MSButton"..i.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonMineHitv2");
			end
		end
	end

	for i=1,NUM_SQUARES do
		if ( CellState[i].num > 0 and CellState[i].bMined == 0) then
			--getglobal("MSButton"..i):SetText(CellState[i].num);
			MS_SetNumColor(i);
		else
			getglobal("MSButton"..i):SetText("");
		end
	end
end


function MS_RecursiveClear(cellnum)

	if (cellnum < 1 or cellnum > 81 ) then
		return;
	end

	if ( CellState[cellnum].num == 0 and CellState[cellnum].state ~= CS_CLEARED and CellState[cellnum].bMined ~= 1) then
		getglobal("MSButton"..cellnum.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
		CellState[cellnum].state = CS_CLEARED;
		NumUncovered = NumUncovered + 1;
		getglobal("MSButton"..cellnum.."TextureOverlay"):SetTexture("");
	else
		return;
	end

	if ( MS_CheckIsInLeftmostColumn(cellnum) == nil) then
		if ( cellnum - 10 > 0 ) then
			if ( CellState[cellnum-10].num == 0 ) then
				MS_RecursiveClear(cellnum-10);
			elseif ( CellState[cellnum-10].num ~= 0 ) then
				getglobal("MSButton"..(cellnum-10).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
				CellState[cellnum-10].state = CS_CLEARED;
				MS_SetNumColor(cellnum-10);
				--NumUncovered = NumUncovered + 1;
				getglobal("MSButton"..(cellnum-10).."TextureOverlay"):SetTexture("");
			end
		end
	end


	if ( cellnum - 9 > 0 ) then
		if ( CellState[cellnum-9].num == 0 ) then
			MS_RecursiveClear(cellnum-9);
		elseif ( CellState[cellnum-9].num ~= 0 ) then
			getglobal("MSButton"..(cellnum-9).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
			CellState[cellnum-9].state = CS_CLEARED;
			MS_SetNumColor(cellnum-9);
			--NumUncovered = NumUncovered + 1;
			getglobal("MSButton"..(cellnum-9).."TextureOverlay"):SetTexture("");
		end
	end

	if ( MS_CheckIsInRightmostColumn(cellnum) == nil) then
		if ( cellnum - 8 > 0 ) then
			if ( CellState[cellnum-8].num == 0 ) then
				MS_RecursiveClear(cellnum-8);
			elseif ( CellState[cellnum-8].num ~= 0 ) then
				getglobal("MSButton"..(cellnum-8).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
				CellState[cellnum-8].state = CS_CLEARED;
				MS_SetNumColor(cellnum-8);
				--NumUncovered = NumUncovered + 1;
				getglobal("MSButton"..(cellnum-8).."TextureOverlay"):SetTexture("");
			end
		end
	end
	
	


	if ( MS_CheckIsInLeftmostColumn(cellnum) == nil) then
		if ( cellnum - 1 > 0 ) then
			if ( CellState[cellnum-1].num == 0 ) then
				MS_RecursiveClear(cellnum-1);
			elseif ( CellState[cellnum-1].num ~= 0 ) then
				getglobal("MSButton"..(cellnum-1).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
				CellState[cellnum-1].state = CS_CLEARED;
				MS_SetNumColor(cellnum-1);
				--NumUncovered = NumUncovered + 1;
				getglobal("MSButton"..(cellnum-1).."TextureOverlay"):SetTexture("");
			end
		end
	end 

	if ( MS_CheckIsInRightmostColumn(cellnum) == nil) then
		if ( cellnum + 1 <= NUM_SQUARES ) then
			if ( CellState[cellnum+1].num == 0 ) then
				MS_RecursiveClear(cellnum+1);
			elseif ( CellState[cellnum+1].num ~= 0 ) then
				getglobal("MSButton"..(cellnum+1).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
				CellState[cellnum+1].state = CS_CLEARED;
				MS_SetNumColor(cellnum+1);
				--NumUncovered = NumUncovered + 1;
				getglobal("MSButton"..(cellnum+1).."TextureOverlay"):SetTexture("");
			end
		end
	end 



	if ( MS_CheckIsInRightmostColumn(cellnum) == nil ) then
		if ( cellnum + 10 <= NUM_SQUARES ) then
			if ( CellState[cellnum+10].num == 0 ) then
				MS_RecursiveClear(cellnum+10);
			elseif ( CellState[cellnum+10].num ~= 0 ) then
				getglobal("MSButton"..(cellnum+10).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
				CellState[cellnum+10].state = CS_CLEARED;
				MS_SetNumColor(cellnum+10);
				--NumUncovered = NumUncovered + 1;
				getglobal("MSButton"..(cellnum+10).."TextureOverlay"):SetTexture("");
			end
		end
	end
	if ( cellnum + 9 <= NUM_SQUARES ) then
		if ( CellState[cellnum+9].num == 0 ) then
			MS_RecursiveClear(cellnum+9);
		elseif ( CellState[cellnum+9].num ~= 0 ) then
			getglobal("MSButton"..(cellnum+9).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
			CellState[cellnum+9].state = CS_CLEARED;
			MS_SetNumColor(cellnum+9);
			--NumUncovered = NumUncovered + 1;
			getglobal("MSButton"..(cellnum+9).."TextureOverlay"):SetTexture("");
		end
	end
	if ( MS_CheckIsInLeftmostColumn(cellnum) == nil) then
		if ( cellnum + 8 <= NUM_SQUARES ) then
			if ( CellState[cellnum+8].num == 0 ) then
				MS_RecursiveClear(cellnum+8);
			elseif ( CellState[cellnum+8].num ~= 0 ) then
				getglobal("MSButton"..(cellnum+8).."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
				CellState[cellnum+8].state = CS_CLEARED;
				MS_SetNumColor(cellnum+8);
				--NumUncovered = NumUncovered + 1;
				getglobal("MSButton"..(cellnum+8).."TextureOverlay"):SetTexture("");
			end
		end
	end
end


function MS_SetNumColor(id)

	getglobal("MSButton"..id):SetText(CellState[id].num);

	if ( CellState[id].num == 1 ) then
		getglobal("MSButton"..id):SetTextColor(0, 0, 1);
	elseif ( CellState[id].num == 2 ) then
		getglobal("MSButton"..id):SetTextColor(0, 1, 0);
	else
		getglobal("MSButton"..id):SetTextColor(1, 0, 0);
	end

end


function MS_OnClick(id)
	
	if ( GameLost == 1) then
		return;
	end
	
	if ( IsAltKeyDown() ) then
		DEFAULT_CHAT_FRAME:AddMessage(id);
		return;
	end

	if ( IsControlKeyDown() and CellState[id].state ~= CS_CLEARED and CellState[id].state ~= CS_MINE ) then
		if ( CellState[id].state ~= CS_FLAGGED ) then
			getglobal("MSButton"..id.."TextureOverlay"):SetTexture("Interface\\AddOns\\Minesweeper\\Flag");
			CellState[id].state = CS_FLAGGED;
		else	
			getglobal("MSButton"..id.."TextureOverlay"):SetTexture("");
			CellState[id].state = MS_BLANK;
		end
		return;
	end

	if ( IsShiftKeyDown() and CellState[id].state ~= CS_CLEARED and CellState[id].state ~= CS_MINE ) then
		if( CellState[id].state ~= CS_QUESTION ) then
			getglobal("MSButton"..id.."TextureOverlay"):SetTexture("Interface\\AddOns\\Minesweeper\\Question");
			CellState[id].state = CS_QUESTION;
		else
			getglobal("MSButton"..id.."TextureOverlay"):SetTexture("");
			CellState[id].state = MS_BLANK;
		end
		return;
	end
	
	if (CellState[id].state ~= CS_CLEARED and CellState[id].state ~= CS_QUESTION and CellState[id].state ~= CS_FLAGGED) then
		if( CellState[id].bMined ~= 1 ) then
			getglobal("MSButton"..id.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearv2");
			--CellState[id].state = CS_CLEARED;
			if ( CellState[id].num > 0) then
				MS_SetNumColor(id);
				CellState[id].state = CS_CLEARED;
				NumUncovered = NumUncovered + 1;

				tmpval = random();

				if(tmpval < 0.25) then
					PlaySoundFile("Sound\\Spells\\TradeSkills\\MiningHitA.wav");
				elseif(tmpval >= 0.25 and tmpval < 0.5) then
					PlaySoundFile("Sound\\Spells\\TradeSkills\\MiningHitA.wav");
				elseif(tmpval >= 0.5 and tmpval < 0.75) then
					PlaySoundFile("Sound\\Spells\\TradeSkills\\MiningHitA.wav");
				elseif(tmpval >= 0.75) then
					PlaySoundFile("Sound\\Spells\\TradeSkills\\MiningHitA.wav");
				end
			else
				getglobal("MSButton"..id):SetText("");
				MS_RecursiveClear(id);
				PlaySoundFile("Sound\\interface\\OrcExploration.wav");
			end

			getglobal("MSButton"..id.."TextureOverlay"):SetTexture("");

		else
			getglobal("MSButton"..id.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearMinev2");
			CellState[id].state = CS_MINE;
			MS_UncoverMatrix();
			--PlaySoundFile("Sound\\Spells\\DynamiteExplode.wav");

			if(random() < 0.5) then
				PlaySoundFile("Sound\\Creature\\GoblinMaleZanyNPC\\GoblinMaleZanyNPCPissed03.wav");
			else
				PlaySoundFile("Sound\\Creature\\GoblinMaleZanyNPC\\GoblinMaleZanyNPCPissed04.wav");
			end

			DEFAULT_CHAT_FRAME:AddMessage("YOU LOSE AT GOBLIN MINESWEEPER! TRY AGAIN!");
		end
	end

	Minesweeper_CheckWin();
end


function Minesweeper_ShowMines()
	for i=1,NUM_SQUARES do
		
		if ( CellState[i].bMined == 1 ) then
			getglobal("MSButton"..i.."Texture"):SetTexture("Interface\\AddOns\\Minesweeper\\ButtonClearMinev2");
		end
	end

end


function Minesweeper_CheckWin()
	local NumCleared = 0;

	for i=1,NUM_SQUARES do
		
		if ( CellState[i].state == CS_CLEARED ) then
			NumCleared = NumCleared + 1;
		end
	end

	if(NumCleared == NUM_SQUARES - NUM_MINES) then
		GameLost = 1;
		--PlaySoundFile("Sound\\interface\\LevelUp.wav");
		DEFAULT_CHAT_FRAME:AddMessage("YOU WIN GOBLIN MINESWEEPER!");
	
		if(random() < 0.5) then
			PlaySoundFile("Sound\\Creature\\GoblinMaleZanyNPC\\GoblinMaleZanyNPCFarewell02.wav");
		else
			PlaySoundFile("Sound\\Creature\\GoblinMaleZanyNPC\\GoblinMaleZanyNPCFarewell04.wav");
		end
	else
		--DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..NumCleared);
	end
end


function Minesweeper_SlashHandler(cmd)
	
	local args = {};
	local counter = 0;
	local i, w;
	local status;
	local TmpStr = {};
	TmpStr = "";

	cmd = string.lower(cmd);
	for w in string.gfind(cmd, "%w+") do
		counter = counter + 1;
		args[counter] = w;
	end

	if (args[1] == nil) then
		MinesweeperFrame:Show();
	end
end


