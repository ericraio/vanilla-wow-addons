-- Sudoku by Fricks
-- Start  : 28.04.06
-- Update : 20.05.06
SUDOKUPUZZLE_VERSION = "Version 1.0 by Fricks";

-- Variablen

Sudoku_Config={};			
Sudoku_Config[1]={};  -- GTable
Sudoku_Config[2]={};  -- GTableR
Sudoku_Config[3]={};  -- GTableL
Sudoku_Config[4]={};  -- GTableC
Sudoku_Config[5]=3;   -- Level
Sudoku_Config[6]=0;   -- ListID
Sudoku_Config[7]=0;   -- Zahlen count
Sudoku_Config[8]=0;   -- Hilfe count
Sudoku_Config[9]={1};  -- GTableH

-- ButtonID > Gitter Koordinaten
local Sudoku_GTableID = {
	[11] = { x = 1, y = 1},
	[12] = { x = 2, y = 1},
	[13] = { x = 3, y = 1},
	[14] = { x = 4, y = 1},
	[15] = { x = 5, y = 1},
	[16] = { x = 6, y = 1},
	[17] = { x = 7, y = 1},
	[18] = { x = 8, y = 1},
	[19] = { x = 9, y = 1},
	[21] = { x = 1, y = 2},
	[22] = { x = 2, y = 2},
	[23] = { x = 3, y = 2},
	[24] = { x = 4, y = 2},
	[25] = { x = 5, y = 2},
	[26] = { x = 6, y = 2},
	[27] = { x = 7, y = 2},
	[28] = { x = 8, y = 2},
	[29] = { x = 9, y = 2},
	[31] = { x = 1, y = 3},
	[32] = { x = 2, y = 3},
	[33] = { x = 3, y = 3},
	[34] = { x = 4, y = 3},
	[35] = { x = 5, y = 3},
	[36] = { x = 6, y = 3},
	[37] = { x = 7, y = 3},
	[38] = { x = 8, y = 3},
	[39] = { x = 9, y = 3},
	[41] = { x = 1, y = 4},
	[42] = { x = 2, y = 4},
	[43] = { x = 3, y = 4},
	[44] = { x = 4, y = 4},
	[45] = { x = 5, y = 4},
	[46] = { x = 6, y = 4},
	[47] = { x = 7, y = 4},
	[48] = { x = 8, y = 4},
	[49] = { x = 9, y = 4},
	[51] = { x = 1, y = 5},
	[52] = { x = 2, y = 5},
	[53] = { x = 3, y = 5},
	[54] = { x = 4, y = 5},
	[55] = { x = 5, y = 5},
	[56] = { x = 6, y = 5},
	[57] = { x = 7, y = 5},
	[58] = { x = 8, y = 5},
	[59] = { x = 9, y = 5},
	[61] = { x = 1, y = 6},
	[62] = { x = 2, y = 6},
	[63] = { x = 3, y = 6},
	[64] = { x = 4, y = 6},
	[65] = { x = 5, y = 6},
	[66] = { x = 6, y = 6},
	[67] = { x = 7, y = 6},
	[68] = { x = 8, y = 6},
	[69] = { x = 9, y = 6},
	[71] = { x = 1, y = 7},
	[72] = { x = 2, y = 7},
	[73] = { x = 3, y = 7},
	[74] = { x = 4, y = 7},
	[75] = { x = 5, y = 7},
	[76] = { x = 6, y = 7},
	[77] = { x = 7, y = 7},
	[78] = { x = 8, y = 7},
	[79] = { x = 9, y = 7},
	[81] = { x = 1, y = 8},
	[82] = { x = 2, y = 8},
	[83] = { x = 3, y = 8},
	[84] = { x = 4, y = 8},
	[85] = { x = 5, y = 8},
	[86] = { x = 6, y = 8},
	[87] = { x = 7, y = 8},
	[88] = { x = 8, y = 8},
	[89] = { x = 9, y = 8},
	[91] = { x = 1, y = 9},
	[92] = { x = 2, y = 9},
	[93] = { x = 3, y = 9},
	[94] = { x = 4, y = 9},
	[95] = { x = 5, y = 9},
	[96] = { x = 6, y = 9},
	[97] = { x = 7, y = 9},
	[98] = { x = 8, y = 9},
	[99] = { x = 9, y = 9},
};

-- Aktuelle Zahlenanordnung
local Sudoku_GTable = {
	[1] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[2] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[3] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[4] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[5] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[6] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[7] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[8] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[9] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
};

-- Zahlenanordnung zu Beginn
local Sudoku_GTableR = {
	[1] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[2] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[3] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[4] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[5] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[6] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[7] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[8] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[9] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
};

-- Zahlenanordnung Lösung
local Sudoku_GTableL = {
	[1] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[2] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[3] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[4] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[5] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[6] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[7] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[8] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[9] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
};

-- Ziffern die mit Hilfe gesetzt wurden
local Sudoku_GTableH = {
	[1] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[2] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[3] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[4] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[5] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[6] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[7] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[8] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[9] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
};

-- Hintergrundfarbe bestimmen
local Sudoku_GTableC = {
	[1] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[2] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[3] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[4] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[5] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[6] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[7] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[8] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
	[9] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 },
};

-- Farben von Text und Hintergrund, Rahmen 
local Sudoku_Color = {
	["blau"] = { ["r"] = 0, ["g"] = 0, ["b"] = 0.6 },
	["gruen"] = { ["r"] = 0, ["g"] = 0.6, ["b"] = 0 },
	["rot"] = { ["r"] = 0.6, ["g"] = 0, ["b"] = 0 },
	["schwarz"] = { ["r"] = 0.3, ["g"] = 0.3, ["b"] = 0.3 },
	["textweiss"] = { ["r"] = 1, ["g"] = 1, ["b"] = 1 },
	["textgelb"] = { ["r"] = 1, ["g"] = 1, ["b"] = 0 },
	["textlila"] = { ["r"] = 1, ["g"] = 0, ["b"] = 1 },
	["textgruen"] = { ["r"] = 0, ["g"] = 1, ["b"] = 0 },
};

local auswahl=0; -- Auswahl der Zahl 1-9, 0 , ?
local level=3; -- Level : 3=Leicht, 2=Mittel, 1=Schwer
local level2=3;
local listid=0;
local listid1=0;
local listid2=0;
local listid3=0;
local zahlencount=0;
local hilfecount=0;
local sudoplay=0; -- 0 = nicht anklickbar, 1 = anklickbar

-- Functions

function Sudoku_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");	
	tinsert(UISpecialFrames, "Sudoku_MainFrame");
	UIPanelWindows["Sudoku_MainFrame"] =		nil;
	Sudoku_MainFrame:RegisterForDrag("LeftButton");	

  SLASH_SUDOKU_FRAME1 = SUDOKU_FRAME_SLASH;
  SlashCmdList["SUDOKU_FRAME"] = function(msg)
    Sudoku_SlashCommand(msg);
  end
   	 
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(SUDOKU_ONLOAD_MESSAGE, 1, 1, 0);
	end
	
Sudoku_ViewGameButton:Disable();

Sudoku_Auswahl1Text:SetText("1");
Sudoku_Auswahl2Text:SetText("2");
Sudoku_Auswahl3Text:SetText("3");
Sudoku_Auswahl4Text:SetText("4");
Sudoku_Auswahl5Text:SetText("5");
Sudoku_Auswahl6Text:SetText("6");
Sudoku_Auswahl7Text:SetText("7");
Sudoku_Auswahl8Text:SetText("8");
Sudoku_Auswahl9Text:SetText("9");
Sudoku_Auswahl10Text:SetText("");
Sudoku_Auswahl11Text:SetText("?");

Sudoku_LevelAuswahl3Text:SetText(SUDOKU_LEVEL_EASY);
Sudoku_LevelAuswahl2Text:SetText(SUDOKU_LEVEL_MEDIUM);
Sudoku_LevelAuswahl1Text:SetText(SUDOKU_LEVEL_HARD);

Sudoku_LevelAuswahl_OnClick("LeftButton",3);

Sudoku_Count1Text:SetText("ID #0");
Sudoku_Count2Text:SetText(SUDOKU_EMPTYCELLS..zahlencount);
Sudoku_Count3Text:SetText("? : 0");

--Sudoku_MainFrameVersionText:SetTextColor(0.7,0,0,1);

end

function Sudoku_OnEvent()
	if (event == "VARIABLES_LOADED") then
		Sudoku_Load();			
	end
end

function Sudoku_Load()
	if (getn(Sudoku_Config[1])>0) then
		Sudoku_GTable=Sudoku_Config[1];
		Sudoku_GTableR=Sudoku_Config[2];
		Sudoku_GTableL=Sudoku_Config[3];
		Sudoku_GTableC=Sudoku_Config[4];
		level=Sudoku_Config[5];
		listid=Sudoku_Config[6];
		hilfecount=Sudoku_Config[8];
		
		if (getn(Sudoku_Config[9])>1) then
			Sudoku_GTableH=Sudoku_Config[9];
		end

		if (level==1) then
			listid1=listid;
		elseif (level==2) then
			listid2=listid;
		elseif (level==3) then
			listid3=listid;
		end

		Sudoku_Count1Text:SetText("ID #"..listid);
		Sudoku_Count3Text:SetText("? : "..hilfecount);
		Sudoku_LevelAuswahl_OnClick("LeftButton",level);
		Sudoku_ViewGameButton:Enable();
		sudoplay=1;
	end
	Sudoku_ErstelleGitter();
	Sudoku_GitterFarbe();
end

function Sudoku_SlashCommand(msg)
    Sudoku_Toggle();
end

function Sudoku_Toggle()
  if(Sudoku_MainFrame:IsVisible()) then
    HideUIPanel(Sudoku_MainFrame);
  else
		ShowUIPanel(Sudoku_MainFrame);
  end
end 

function Sudoku_Gitter_OnClick(button,gitterid)
  if (sudoplay==1) then
  	local gx=Sudoku_GTableID[gitterid]["x"];
  	local gy=Sudoku_GTableID[gitterid]["y"];
  	if ((button == "LeftButton" or button == "RightButton") and Sudoku_GTableR[gy][gx]==0) then
  		local GitterText = getglobal("Sudoku_Gitter"..gitterid.."Text");
  		if (auswahl>0 and auswahl<10 and Sudoku_GTable[gy][gx]~=auswahl and Sudoku_GTableH[gy][gx]==0) then				
  			Sudoku_GTable[gy][gx]=auswahl;
  			GitterText:SetText(auswahl);
  		elseif (auswahl==10 and Sudoku_GTableH[gy][gx]==0) then
  			Sudoku_GTable[gy][gx]=0;
  			GitterText:SetText("");
  		elseif (auswahl==11 and Sudoku_GTableH[gy][gx]==0) then
  			Sudoku_GTableH[gy][gx]=1;
  			Sudoku_GTable[gy][gx]=Sudoku_GTableL[gy][gx];
  			GitterText:SetText(Sudoku_GTableL[gy][gx]);
  			GitterText:SetTextColor(Sudoku_Color["textgruen"]["r"],Sudoku_Color["textgruen"]["g"],Sudoku_Color["textgruen"]["b"]);		
  			Sudoku_Config[9]=Sudoku_GTableH;
  			hilfecount=Sudoku_GetHelp();
  			Sudoku_Count3Text:SetText("? : "..hilfecount);
  		end		

  		zahlencount=Sudoku_GetEmpty();
  		Sudoku_Count2Text:SetText(SUDOKU_EMPTYCELLS..zahlencount);

  		Sudoku_Config[1]=Sudoku_GTable;
  		Sudoku_Check();
  		Sudoku_Config[4]=Sudoku_GTableC;

  		Sudoku_Config[7]=zahlencount;
  		Sudoku_Config[8]=hilfecount;
			
			Sudoku_CheckSuccess();
  		
  	end
  end
end

function Sudoku_Auswahl_OnClick(button,auswahlid)
	if( (button == "LeftButton" or button == "RightButton") and sudoplay==1) then
		auswahl=auswahlid;
		local i=0;
		for i=1,11 do
			local Gitter = getglobal("Sudoku_Auswahl"..i.."Texture");
			local Gitter2 = getglobal("Sudoku_Auswahl"..i.."Texture2");
			if (i==auswahlid) then
				Gitter:Hide();
				Gitter2:Show();
			else
				Gitter2:Hide();
				Gitter:Show();
			end						
		end
	end
end

function Sudoku_LevelAuswahl_OnClick(button,levelid)
	if( button == "LeftButton" or button == "RightButton" ) then
		level2=levelid;
		local i=0;
		for i=1,3 do
			local Gitter = getglobal("Sudoku_LevelAuswahl"..i.."Texture");
			local Gitter2 = getglobal("Sudoku_LevelAuswahl"..i.."Texture2");
			if (i==levelid) then
				Gitter:Hide();
				Gitter2:Show();
			else
				Gitter2:Hide();
				Gitter:Show();
			end
		end
		if (level2==1) then
			Sudoku_Count1Text:SetText("ID #"..listid1);
		elseif (level2==2) then
			Sudoku_Count1Text:SetText("ID #"..listid2);
		elseif (level2==3) then
			Sudoku_Count1Text:SetText("ID #"..listid3);
		end
	end
end

function Sudoku_LevelID_OnClick(button)
	if( button == "LeftButton") then
		if (level2==1) then
			listid1=math.random(getn(Sudoku_List1A));
			listid=listid1;
		elseif (level2==2) then
			listid2=math.random(getn(Sudoku_List2A));
			listid=listid2;
		elseif (level2==3) then
			listid3=math.random(getn(Sudoku_List3A));
			listid=listid3;
		end
		Sudoku_Count1Text:SetText("ID #"..listid);
	end
	if( button == "RightButton") then
		Sudoku_Count1:Hide();
		Sudoku_EditID:SetText("");
		Sudoku_EditID:Show();
	end	
end

function Sudoku_EditListID(lista)
	if (lista>"") then
		local list=tonumber(lista);
		if (level2==1) then
			if (list>getn(Sudoku_List1A)) then
				list=getn(Sudoku_List1A);			
			elseif (list<1) then
				list=1;
			end
			listid1=list;
		elseif (level2==2) then
			if (list>getn(Sudoku_List2A)) then
				list=getn(Sudoku_List2A);			
			elseif (list<1) then
				list=1;
			end
			listid2=list;
		elseif (level2==3) then
			if (list>getn(Sudoku_List3A)) then
				list=getn(Sudoku_List3A);			
			elseif (list<1) then
				list=1;
			end
			listid3=list;
		end
		listid=list;
		Sudoku_Count1Text:SetText("ID #"..listid);
	end
end

function Sudoku_GetEmpty()
			local x=0;
			local y=0;
			local empty=0;
			for y=1,9 do
				for x=1,9 do
					if (Sudoku_GTable[y][x]==0) then
						empty=empty+1;
					end
				end
			end
	return empty; 
end

function Sudoku_GetHelp()
			local x=0;
			local y=0;
			local ret=0;
			for y=1,9 do
				for x=1,9 do
					if (Sudoku_GTableH[y][x]==1) then
						ret=ret+1;
					end
				end
			end
	return ret; 
end

function Sudoku_CheckSuccess()

			local x=0;
			local y=0;
			local success=0;
			for y=1,9 do
				for x=1,9 do
					if (Sudoku_GTable[y][x]~=Sudoku_GTableL[y][x]) then
						success=1;
					end
				end
			end  		
  		if (success==0) then
				sudoplay=1;
				Sudoku_Auswahl_OnClick("LeftButton",0);
				Sudoku_ViewGameButton:Disable();
				sudoplay=0;

				Sudoku_Config[1]={};
				Sudoku_Config[2]={};
				Sudoku_Config[3]={};
				Sudoku_Config[4]={};
				Sudoku_Config[9]={};
				
				Sudoku_SuccessFarbe();
			end

end

function Sudoku_NewGame()

	local x=1;
	local y=1;
	local sR="";
	local sL="";
	local c=0;
	local r=0;
	local puzzleL="";
	local puzzleR="";

	level=level2;
	Sudoku_Config[5]=level;
		
	if (level==1) then
		if( listid1 == 0) then
			Sudoku_LevelID_OnClick("LeftButton")
		end
		puzzleL=Sudoku_List1A[listid1];	
		puzzleR=Sudoku_List1B[listid1];
		Sudoku_Config[6]=listid1;
	elseif (level==2) then
		if( listid2 == 0) then
			Sudoku_LevelID_OnClick("LeftButton")
		end
		puzzleL=Sudoku_List2A[listid2];	
		puzzleR=Sudoku_List2B[listid2];
		Sudoku_Config[6]=listid2;
	elseif (level==3) then
		if( listid3 == 0) then
			Sudoku_LevelID_OnClick("LeftButton")
		end
		puzzleL=Sudoku_List3A[listid3];	
		puzzleR=Sudoku_List3B[listid3];
		Sudoku_Config[6]=listid3;
	end

	for y = 1, 9 do
		for x = 1, 9 do
			c=c+1;
			sL=strsub(puzzleL,c,c);
			sR=strsub(puzzleR,c,c);
			Sudoku_GTableL[y][x] = tonumber(sL);
			Sudoku_GTableC[y][x] = 0;
			Sudoku_GTableH[y][x] = 0;
			if (sR==".") then
				Sudoku_GTable[y][x] = 0;
				Sudoku_GTableR[y][x] = 0;
			else
				Sudoku_GTable[y][x] = tonumber(sR);
				Sudoku_GTableR[y][x] = tonumber(sR);
			end
		end
	end

	Sudoku_Config[1]=Sudoku_GTable;
	Sudoku_Config[2]=Sudoku_GTableR;
	Sudoku_Config[3]=Sudoku_GTableL;
	Sudoku_Config[4]=Sudoku_GTableC;
	Sudoku_Config[9]=Sudoku_GTableH;	

	hilfecount=0;
	Sudoku_Config[8]=hilfecount;
	Sudoku_Count3Text:SetText("? : "..hilfecount);

	Sudoku_ErstelleGitter();
	Sudoku_GitterFarbe();
	
	sudoplay=1;
	Sudoku_Auswahl_OnClick("LeftButton",0);
	Sudoku_ViewGameButton:Enable();
end

function Sudoku_ErstelleGitter()
	zahlencount=0;
	for y = 1, 9 do
		for x = 1, 9 do
			local GitterText = getglobal("Sudoku_Gitter"..y..x.."Text");
			if (Sudoku_GTableR[y][x]==0 and Sudoku_GTableH[y][x]==0) then
				GitterText:SetTextColor(Sudoku_Color["textweiss"]["r"],Sudoku_Color["textweiss"]["g"],Sudoku_Color["textweiss"]["b"]);
			elseif (Sudoku_GTableR[y][x]==0 and Sudoku_GTableH[y][x]==1) then
				GitterText:SetTextColor(Sudoku_Color["textgruen"]["r"],Sudoku_Color["textgruen"]["g"],Sudoku_Color["textgruen"]["b"]);
			else
				GitterText:SetTextColor(Sudoku_Color["textgelb"]["r"],Sudoku_Color["textgelb"]["g"],Sudoku_Color["textgelb"]["b"]);
			end
			if (Sudoku_GTable[y][x]==0) then
				GitterText:SetText("");
				zahlencount=zahlencount+1;
			else
				GitterText:SetText(Sudoku_GTable[y][x]);			
			end
		end
	end
	Sudoku_Config[7]=zahlencount;
	Sudoku_Count2Text:SetText(SUDOKU_EMPTYCELLS..zahlencount);
end

function Sudoku_SuccessFarbe()
	for y = 1, 9 do
		for x = 1, 9 do
			local GitterText = getglobal("Sudoku_Gitter"..y..x.."Text");
			GitterText:SetTextColor(Sudoku_Color["textgelb"]["r"],Sudoku_Color["textgelb"]["g"],Sudoku_Color["textgelb"]["b"]);
		end
	end
end

function Sudoku_Check()
	local x=1;
	local y=1;
	for y=1,9 do
		for x=1,9 do
			Sudoku_GTableC[y][x]=0;
		end
	end
	for y=1,9 do
		for x=1,9 do
			Sudoku_CheckZahl(x,y)
		end
	end
	Sudoku_GitterFarbe();
end

function Sudoku_CheckZahl(x1,y1)

	local x=1;
	local y=1;
	local z=Sudoku_GTable[y1][x1];
	
	for x = 1,9 do
		if (Sudoku_GTable[y1][x]==z and z>0 and x~=x1) then
			Sudoku_GTableC[y1][x]=1;
			Sudoku_GTableC[y1][x1]=1;
		end
	end
	for y = 1,9 do
		if (Sudoku_GTable[y][x1]==z and z>0 and y~=y1) then
			Sudoku_GTableC[y][x1]=1;
			Sudoku_GTableC[y1][x1]=1;
		end
	end	

	if ((x1==1 or x1==2 or x1==3) and (y1==1 or y1==2 or y1==3)) then
		for x = 1,3 do
			for y=1,3 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end
	elseif ((x1==4 or x1==5 or x1==6) and (y1==1 or y1==2 or y1==3)) then
		for x = 4,6 do
			for y=1,3 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end
	elseif ((x1==7 or x1==8 or x1==9) and (y1==1 or y1==2 or y1==3)) then
		for x = 7,9 do
			for y=1,3 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end	
	elseif ((x1==1 or x1==2 or x1==3) and (y1==4 or y1==5 or y1==6)) then
		for x = 1,3 do
			for y=4,6 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end	
	elseif ((x1==4 or x1==5 or x1==6) and (y1==4 or y1==5 or y1==6)) then
		for x = 4,6 do
			for y=4,6 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end	
	elseif ((x1==7 or x1==8 or x1==9) and (y1==4 or y1==5 or y1==6)) then
		for x = 7,9 do
			for y=4,6 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end	
	elseif ((x1==1 or x1==2 or x1==3) and (y1==7 or y1==8 or y1==9)) then
		for x = 1,3 do
			for y=7,9 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end	
	elseif ((x1==4 or x1==5 or x1==6) and (y1==7 or y1==8 or y1==9)) then
		for x = 4,6 do
			for y=7,9 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end	
	elseif ((x1==7 or x1==8 or x1==9) and (y1==7 or y1==8 or y1==9)) then
		for x = 7,9 do
			for y=7,9 do
				if (Sudoku_GTable[y][x]==z and z>0 and x~=x1 and y~=y1) then
					Sudoku_GTableC[y][x]=1;
					Sudoku_GTableC[y1][x1]=1;
				end				
			end
		end	
	end
end

function Sudoku_GitterFarbe()
	local x=1;
	local y=1;
	for y=1,9 do
		for x=1,9 do
			local Gitter = getglobal("Sudoku_Gitter"..y..x.."Texture");
			local Gitter2 = getglobal("Sudoku_Gitter"..y..x.."Texture2");
			if (Sudoku_GTableC[y][x]==1) then
				Gitter:Hide();
				Gitter2:Show();
			else
				Gitter2:Hide();
				Gitter:Show();
			end
				--DEFAULT_CHAT_FRAME:AddMessage(Gitter:GetTexture(), 1, 1, 0); 
		end
	end
end

function Sudoku_ZeigeLoesung()
	local x=1;
	local y=1;	
	for y = 1, 9 do
		for x = 1, 9 do
			local Gitter = getglobal("Sudoku_Gitter"..y..x.."Text");
			local GitterT1 = getglobal("Sudoku_Gitter"..y..x.."Texture");
			local GitterT2 = getglobal("Sudoku_Gitter"..y..x.."Texture2");
			Gitter:SetTextColor(Sudoku_Color["textgelb"]["r"],Sudoku_Color["textgelb"]["g"],Sudoku_Color["textgelb"]["b"]);
			Gitter:SetText(Sudoku_GTableL[y][x]);				
			GitterT2:Hide();
			GitterT1:Show();
		end	
	end
	
	sudoplay=1;
	Sudoku_Auswahl_OnClick("LeftButton",0);
	Sudoku_ViewGameButton:Disable();
	sudoplay=0;
	
  zahlencount=0;
  Sudoku_Count2Text:SetText(SUDOKU_EMPTYCELLS..zahlencount);
  Sudoku_Config[7]=zahlencount;
	hilfecount=0;
	Sudoku_Config[8]=hilfecount;
	Sudoku_Count3Text:SetText("? : "..hilfecount);
	
	Sudoku_Config[1]={};
	Sudoku_Config[2]={};
	Sudoku_Config[3]={};
	Sudoku_Config[4]={};
	Sudoku_Config[9]={};
end 