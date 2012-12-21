-- Thanks for taking the time to take a look at Answering Machine.
-- For up to date versions, please check the following authorized sites.

-- http://www.curse-gaming.com/mod.php?addid=1583
-- http://www.wowinterface.com/downloads/fileinfo.php?id=4078
-- http://ui.worldofwar.net/ui.php?id=1221

-- Mindark of Dragonmaw

local Missed_Tells = { };
local Missed_Authors = { };
local Answer_Frame = true;
local IsRecording = false;
local rec_AFK = true;
local rec_DND = true;
local Is_AFK = false;
local Is_DND = false;

function AnsweringMachine_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterForDrag("LeftButton");
end

function AnsweringMachine_OnDragStart()
	AnswerFrame:StartMoving()
end

function AnsweringMachine_OnDragStop()
	AnswerFrame:StopMovingOrSizing()
end

function AnsweringMachine_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		SlashCmdList["ANSWER"] = Answer_SlashHandler;
			SLASH_ANSWER1 = "/answer";
	end

	if (event == "CHAT_MSG_SYSTEM") then
		if (string.find(arg1, string.sub(MARKED_AFK_MESSAGE, 1, string.len(MARKED_AFK_MESSAGE) - 4), 1)) then
			if (rec_AFK) then
				Ans_Record();
			elseif (Is_DND) then
				Ans_Stop();
			end
			Is_AFK = true;
			if (Is_DND) then
				Is_DND = false;
			end
		elseif (string.find(arg1, string.sub(MARKED_DND, 1, string.len(MARKED_DND) - 3), 1)) then
			if (rec_DND) then
				Ans_Record();
			elseif (Is_AFK) then
				Ans_Stop();
			end
			Is_DND = true;
			if (Is_AFK) then
				Is_AFK = false;
			end
		end

		if (arg1 == CLEARED_AFK) then
			Ans_Stop();
			Is_AFK = false;
		end
		if (arg1 == CLEARED_DND) then
			Ans_Stop();
			Is_DND = false;
		end
	end

	if (event == "CHAT_MSG_WHISPER" and IsRecording) then
		table.insert(Missed_Tells, arg1);
		table.insert(Missed_Authors, arg2);
		AnsweringMachine_Text:SetText(ANS_MISSED1 .. table.getn(Missed_Tells) .. ANS_MISSED2);
	end
end

function Ans_Record()
	IsRecording = true;
	if (Answer_Frame) then
		AnswerFrame:Show();
	end
	AnsweringMachine_Text:SetText(ANS_MISSED1 .. table.getn(Missed_Tells) .. ANS_MISSED2);
end

function Ans_Stop()
	IsRecording = false;
	Ans_Retell_Msgs();
	Missed_Tells = { };
	Missed_Authors = { };
	AnswerFrame:Hide();
end

function Ans_Retell_Msgs()
	if (table.getn(Missed_Tells) > 0) then
		DEFAULT_CHAT_FRAME:AddMessage(ANS_SEPARATOR .. "\n" .. ANS_MISSED1 .. table.getn(Missed_Tells) .. ANS_MISSED2, 1.0, 0.5, 1.0);
		for i=1,table.getn(Missed_Tells) do
			DEFAULT_CHAT_FRAME:AddMessage("[" .. Missed_Authors[i] .. "]: " .. Missed_Tells[i], 1.0, 0.5, 1.0);
		end
		DEFAULT_CHAT_FRAME:AddMessage(ANS_SEPARATOR, 1.0, 0.5, 1.0);
	else
		DEFAULT_CHAT_FRAME:AddMessage(ANS_NOTELLS, 1.0, 1.0, 0.0);
	end
end

function Answer_SlashHandler(msg)
	local words = {};
	for word in string.gfind(msg, "%w+") do
		table.insert(words, word);
	end
	if table.getn(words) == 0 then
		DEFAULT_CHAT_FRAME:AddMessage(ANS_MSG_HELP .. "\n\n", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(ANS_FRAME_HELP .. "\n\n", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_AFK_HELP .. "\n\n", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_DND_HELP, 1.0, 1.0, 0.0);
	else
		local cmd = string.lower(words[1]);
		if cmd == "msg" then
			local ans_msg = "";
			for i=2,table.getn(words) do
				ans_msg = ans_msg .. " " .. words[i];
			end
			if ans_msg == "" then
				DEFAULT_CHAT_FRAME:AddMessage(ANS_AWAY_MSG .. DEFAULT_AFK_MESSAGE, 1.0, 1.0, 0.0);
			else
				DEFAULT_AFK_MESSAGE = ans_msg;
				DEFAULT_CHAT_FRAME:AddMessage(ANS_DEFAULT .. DEFAULT_AFK_MESSAGE, 1.0, 1.0, 0.0);
			end
		elseif cmd == "frame" then
			if (table.getn(words) == 1) then
				if (Answer_Frame) then
					DEFAULT_CHAT_FRAME:AddMessage(ANS_FRAME_STATUS .. ANS_ON, 1.0, 1.0, 0.0);
				else
					DEFAULT_CHAT_FRAME:AddMessage(ANS_FRAME_STATUS .. ANS_OFF, 1.0, 1.0, 0.0);
				end			
			elseif (string.lower(words[2]) == "on") then
				DEFAULT_CHAT_FRAME:AddMessage(ANS_FRAME_STATUS .. ANS_ON, 1.0, 1.0, 0.0);
				if (IsRecording) then
					AnswerFrame:Show();
				end
				Answer_Frame = true;
			elseif (string.lower(words[2]) == "off") then
				DEFAULT_CHAT_FRAME:AddMessage(ANS_FRAME_STATUS .. ANS_OFF, 1.0, 1.0, 0.0);
				AnswerFrame:Hide();
				Answer_Frame = false;
			else
				DEFAULT_CHAT_FRAME:AddMessage(ANS_FRAME_HELP, 1.0, 1.0, 0.0);
			end
		elseif cmd == "afk" then
			if (table.getn(words) == 1) then
				if (rec_AFK) then
					DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_AFK_STATUS .. ANS_ON, 1.0, 1.0, 0.0);
				else
					DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_AFK_STATUS .. ANS_OFF, 1.0, 1.0, 0.0);
				end
			elseif (string.lower(words[2]) == "on") then
				DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_AFK_STATUS .. ANS_ON, 1.0, 1.0, 0.0);
				rec_AFK = true;
			elseif (string.lower(words[2]) == "off") then
				DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_AFK_STATUS .. ANS_OFF, 1.0, 1.0, 0.0);
				if (Is_AFK) then
					Ans_Stop();
				end
				rec_AFK = false;
			else
				DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_AFK_HELP, 1.0, 1.0, 0.0);
			end
		elseif cmd == "dnd" then
			if (table.getn(words) == 1) then
				if (rec_DND) then
					DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_DND_STATUS .. ANS_ON, 1.0, 1.0, 0.0);
				else
					DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_DND_STATUS .. ANS_OFF, 1.0, 1.0, 0.0);
				end
			elseif (string.lower(words[2]) == "on") then
				DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_DND_STATUS .. ANS_ON, 1.0, 1.0, 0.0);
				rec_DND = true;
			elseif (string.lower(words[2]) == "off") then
				DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_DND_STATUS .. ANS_OFF, 1.0, 1.0, 0.0);
				if (Is_DND) then
					Ans_Stop();
				end
				rec_DND = false;
			else
				DEFAULT_CHAT_FRAME:AddMessage(ANS_REC_DND_HELP, 1.0, 1.0, 0.0);
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(ANS_MSG_HELP .. "\n\n" .. ANS_FRAME_HELP, 1.0, 1.0, 0.0);
		end
	end	
end