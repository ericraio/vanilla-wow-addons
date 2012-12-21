-- FileName: KillMore.lua

local KM_USE_ERROR_FRAME = true;		-- Use the Error Frame by default
local KM_USE_CHAT_FRAME = true;			-- Use the Chat Frame by default

--
-- Load localized versions in KillMore_GetLocalizedStrings()
--
local KM_EXPERIENCE_GAINED_STRING = "";
local KM_HELP_TITLE = "";
local KM_CMD_HELP = "";
local KM_CMD_CHAT_HELP = "";
local KM_CMD_ERROR_HELP = "";
local KM_CMD_BOTH_HELP = "";
local KM_CMD_OFF_HELP = "";
local KM_CMD_STATUS_HELP = "";

function KillMore_OnLoad()
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");

	SlashCmdList["KillMore"] = KillMore_Command;
	SLASH_KillMore1 = "/killmore";
end

function KillMore_GetLocalizedStrings()
	-- English by default
	KM_EXPERIENCE_GAINED_STRING	= "(.+) dies, you gain (%d+) experience.";
	KM_OUTPUT_STRING		= "%d %s needed to level";
	KM_HELP_TITLE			= "KillMore Commands:";
	KM_CMD_HELP			= "  /killmore               shows this help message";
	KM_CMD_CHAT_HELP		= "  /killmore chat          outputs the KillMore data in the chat window";
	KM_CMD_ERROR_HELP		= "  /killmore error         outputs the KillMore data to the main screen";
	KM_CMD_BOTH_HELP		= "  /killmore both          outputs the KillMore data to the chat window and main screen";
	KM_CMD_OFF_HELP			= "  /killmore off           turn KillMore off";
	KM_CMD_STATUS_HELP		= "  /killmore status        shows KillMore status";


	-- German
	if (GetLocale() == "deDE") then
		KM_EXPERIENCE_GAINED_STRING	= "(.+) stirbt, Ihr bekommt (%d+) Erfahrung.";
		KM_OUTPUT_STRING		= "Noch %d %s bis zum n\195\164chsten Level";
		KM_HELP_TITLE			= "KillMore Commands:";
		KM_CMD_HELP			= "  /killmore               zeigt diese Nachricht an";
		KM_CMD_CHAT_HELP		= "  /killmore chat          chat schreibt die killmore-Statistik in das Chatfenster";
		KM_CMD_ERROR_HELP		= "  /killmore error         zeigt die killmore-Statstik zentriert im Fenster an";
		KM_CMD_BOTH_HELP		= "  /killmore both          zeigt die killmore-Statstik zentriert im Fenster und in das Chatfenster";
		KM_CMD_OFF_HELP			= "  /killmore off           stellen Sie KillMore ab";
		KM_CMD_STATUS_HELP		= "  /killmore status        Erscheinen KillMore Status";
	end
end

function KillMore_OnEvent()
	if (KM_USE_ERROR_FRAME or KM_USE_CHAT_FRAME) then
		if (event == "CHAT_MSG_COMBAT_XP_GAIN") then
			local xpTotal, xpCurrent, xpToLevel, mobsToLevel;
			for creatureName, xp in string.gfind(arg1, KM_EXPERIENCE_GAINED_STRING) do
				xpTotal = UnitXPMax("player");
				xpCurrent = UnitXP("player") + xp;
				xpToLevel = xpTotal - xpCurrent;
				mobsToLevel = abs(xpToLevel / xp)+1;
				if (xpCurrent < xpTotal) then
					if (KM_USE_ERROR_FRAME) then
						UIErrorsFrame:AddMessage(format(TEXT(KM_OUTPUT_STRING),mobsToLevel,creatureName), 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
					end
					if (KM_USE_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage(format(TEXT(KM_OUTPUT_STRING),mobsToLevel,creatureName),1,1,255);
					end
				end
				return;
			end
		end
	end
end

function KillMore_Command(msg)
	msg = string.lower(msg);

	if (msg == 'chat')		then KM_USE_ERROR_FRAME = false; KM_USE_CHAT_FRAME = true; KillMore_Status();
	elseif (msg == 'error')		then KM_USE_ERROR_FRAME = true; KM_USE_CHAT_FRAME = false; KillMore_Status();
	elseif (msg == 'both')		then KM_USE_ERROR_FRAME = true; KM_USE_CHAT_FRAME = true; KillMore_Status();
	elseif (msg == 'off')		then KM_USE_ERROR_FRAME = false; KM_USE_CHAT_FRAME = false; KillMore_Status();
	elseif (msg == 'status')	then KillMore_Status();
	else				KillMore_Help();
	end
end

function KillMore_Help()
	DEFAULT_CHAT_FRAME:AddMessage(KM_HELP_TITLE, 1.0, 1.0, 0.0);
	DEFAULT_CHAT_FRAME:AddMessage(KM_CMD_HELP, 1.0, 1.0, 0.0);
	DEFAULT_CHAT_FRAME:AddMessage(KM_CMD_CHAT_HELP, 1.0, 1.0, 0.0);
	DEFAULT_CHAT_FRAME:AddMessage(KM_CMD_ERROR_HELP, 1.0, 1.0, 0.0);
	DEFAULT_CHAT_FRAME:AddMessage(KM_CMD_BOTH_HELP, 1.0, 1.0, 0.0);
	DEFAULT_CHAT_FRAME:AddMessage(KM_CMD_OFF_HELP, 1.0, 1.0, 0.0);
	DEFAULT_CHAT_FRAME:AddMessage(KM_CMD_STATUS_HELP, 1.0, 1.0, 0.0);
end

function KillMore_Status()
	if (KM_USE_ERROR_FRAME) then
		if (KM_USE_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("KillMore Output: Both", 1.0, 1.0, 0.0);
		else
			DEFAULT_CHAT_FRAME:AddMessage("KillMore Output: Error Frame", 1.0, 1.0, 0.0);
		end
	elseif (KM_USE_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("KillMore Output: Chat Frame", 1.0, 1.0, 0.0);
	else
		DEFAULT_CHAT_FRAME:AddMessage("KillMore Output: None", 1.0, 1.0, 0.0);
	end
end