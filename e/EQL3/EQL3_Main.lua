-- Main Script file for Extended Questlog 3.6
-- Copyright © 2006 Daniel Rehn

-- Version text
EQL3_QUESTLOG_VERSION = "v3.6.1";
EQL3_QUESTS_DISPLAYED = 27; -- 6 lol
MAX_QUESTWATCH_LINES = 50;
MAX_WATCHABLE_QUESTS = 20;
EQL3_Player = nil;

-- Options init
QuestlogOptions = {};
EQL3_Temp = {};
EQL3_Temp.QuestList = {};
EQL3_Temp.AddTrack = nil;
EQL3_Temp.updateTime = 0;
EQL3_Temp.updateTarget = 30;
EQL3_Temp.manageHeaders = nil;
EQL3_Temp.hasManaged = nil;
EQL3_Temp.movingWatchFrame = nil;

-- Organizing vars
EQL3_Temp.GotQuestLogUpdate=nil;
EQL3_Temp.savedQuestIDMap=nil;
EQL3_Temp.lastExistingNumEntries = -1;
EQL3_Temp.savedNumEntries=nil;
EQL3_Temp.savedNumQuests=nil;
EQL3_Temp.savedSelectedQuest=nil;
EQL3_Temp.reportedNoQuests=nil;

-- Window handling
UIPanelWindows["EQL3_QuestLogFrame"] =		{ area = "doublewide",	pushable = 0,	whileDead = 1 };





-- Options function
function QuestLog_Options_Toggle()
	-- Insert code to show and hide options frame
	if(EQL3_OptionsFrame:IsVisible()) then
		EQL3_OptionsFrame:Hide();
	else
		EQL3_OptionsFrame:Show();
	end
end

EQL3_TrackerLists = {};
EQL3_TrackerLists[0] = {};
EQL3_TrackerLists[0][0] = "1";
EQL3_TrackerLists[0][1] = "2";
EQL3_TrackerLists[0][2] = "3";
EQL3_TrackerLists[0][3] = "4";
EQL3_TrackerLists[0][4] = "5";
EQL3_TrackerLists[0][5] = "6";
EQL3_TrackerLists[0][6] = "7";
EQL3_TrackerLists[0][7] = "8";
EQL3_TrackerLists[0][8] = "9";
EQL3_TrackerLists[0][9] = "10";

EQL3_TrackerLists[1] = {};
EQL3_TrackerLists[1][0] = "a";
EQL3_TrackerLists[1][1] = "b";
EQL3_TrackerLists[1][2] = "c";
EQL3_TrackerLists[1][3] = "d";
EQL3_TrackerLists[1][4] = "e";
EQL3_TrackerLists[1][5] = "f";
EQL3_TrackerLists[1][6] = "g";
EQL3_TrackerLists[1][7] = "h";
EQL3_TrackerLists[1][8] = "i";
EQL3_TrackerLists[1][9] = "j";

EQL3_TrackerLists[2] = {};
EQL3_TrackerLists[2][0] = "A";
EQL3_TrackerLists[2][1] = "B";
EQL3_TrackerLists[2][2] = "C";
EQL3_TrackerLists[2][3] = "D";
EQL3_TrackerLists[2][4] = "E";
EQL3_TrackerLists[2][5] = "F";
EQL3_TrackerLists[2][6] = "G";
EQL3_TrackerLists[2][7] = "H";
EQL3_TrackerLists[2][8] = "I";
EQL3_TrackerLists[2][9] = "J";

EQL3_TrackerLists[3] = {};
EQL3_TrackerLists[3][0] = "I";
EQL3_TrackerLists[3][1] = "II";
EQL3_TrackerLists[3][2] = "III";
EQL3_TrackerLists[3][3] = "IV";
EQL3_TrackerLists[3][4] = "V";
EQL3_TrackerLists[3][5] = "VI";
EQL3_TrackerLists[3][6] = "VII";
EQL3_TrackerLists[3][7] = "VIII";
EQL3_TrackerLists[3][8] = "IX";
EQL3_TrackerLists[3][9] = "X";

EQL3_TrackerSymbols = {};
EQL3_TrackerSymbols[0] = "-";
EQL3_TrackerSymbols[1] = "+";
EQL3_TrackerSymbols[2] = "@";
EQL3_TrackerSymbols[3] = ">";


-- Fix for escape button... should'nt mess with oRA any more...

EQL3_old_CloseWindows = CloseWindows;

function CloseWindows(ignoreCenter)
	if ( EQL3_QuestLogFrame:IsVisible() ) then
		HideUIPanel(EQL3_QuestLogFrame);
		return EQL3_QuestLogFrame;
	end
	
	return EQL3_old_CloseWindows(ignoreCenter);
end





function decToHex(Dec, Length)
	local B, K, Hex, I, D = 16, "0123456789ABCDEF", "", 0;
	while Dec>0 do
		I=I+1;
		Dec, D = math.floor(Dec/B), math.mod(Dec,B)+1;
		Hex=string.sub(K,D,D)..Hex;
	end
	if( (Length ~= nil) and (string.len(Hex) < Length) ) then
		local temp, i = Length-string.len(Hex), 1;
		for i=1, temp, 1 do
			Hex = "0"..Hex;
		end
	end
	return Hex;
end

function EQL3_ColorText(t, r, g, b)
	if ( t == nil ) then t = ""; end
	if ( r == nil ) then r = 0.0; end
	if ( g == nil ) then g = 0.0; end
	if ( b == nil ) then b = 0.0; end
	return "|CFF"..decToHex(r*255, 2)..decToHex(g*255, 2)..decToHex(b*255, 2)..t.."|r";
end
