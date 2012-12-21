AUTODINGNAME = "AutoDing";
AUTODINGDESC = "automatically announces levelup's to various definable channels.";
AUTODINGVER = "0.8";
AUTODINGLASCHANGED = "0.8";
AUTODINGFRAME = "AutoDingFrame";
AUTODINGOPTIONSFRAME = "AutoDingConfigFrame";
SLASH_AUTODING1 = "/AutoDing";
SLASH_AUTODING2 = "/ad";
UniAutoDing_NameRegistered = 0;
ADmsg = "";
AUTODING_DELAYTIME = 1;

function UniAutoDing_OnLoad()
	SlashCmdList["AUTODING"] = function(msg)
		UniAutoDing_Command(msg);
	end
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LEVEL_UP");
end

function UniAutoDing_OnEvent()
	if (event == "PLAYER_LEVEL_UP") then
		if (UniAutoDingSaved[AutoDing_Player].AutoDing == 1) then
			AutoDing_FormatDing();
			UniAutoDing_ChannelMessage(ADmsg, UniAutoDingSaved[AutoDing_Player].Channel);
		end
		if UnitExists("Party1") then
			if (UniAutoDingSaved[AutoDing_Player].PartyDing == 1) then
				if UniAutoDingSaved[AutoDing_Player].Channel ~= "PARTY" then
					UniAutoDing_ChannelMessage(ADmsg, PARTY);
				end
			end
		end
		if (UniAutoDingSaved[AutoDing_Player].Screenie == 1) then
			UniAutoDing_ChatPrint("Taking Delayed Screenie...");
			AD_StartTime = GetTime();
			AutoDingFrame:Show();			
		end
	end
	if (event == "VARIABLES_LOADED") then
		this:UnregisterEvent("VARIABLES_LOADED");
		if (myAddOnsFrame) then
			myAddOnsList.AutoDing = {
				name = AUTODINGNAME,
				description = AUTODINGDESC,
				version = AUTODINGVER,
				category = MYADDONS_CATEGORY_CHAT,
				frame = AUTODINGFRAME,
				optionsframe = AUTODINGOPTIONSFRAME };
		end
		
		AutoDing_Player = UnitName("player") .. " of " .. GetCVar("realmName");

		if( not UniAutoDingSaved ) then
			UniAutoDingSaved = {};
			UniAutoDing_ResetVars();

		end
		if (not UniAutoDingSaved.Version) or (UniAutoDingSaved.Version < AUTODINGLASCHANGED) then
			UniAutoDing_ResetVars();
			UniAutoDing_ChatPrint("AutoDing Settings reset to default on version upgrade to prevent errors.");
			UIErrorsFrame:AddMessage("AutoDing v"..AUTODINGVER.." by Unique has loaded.", 1.0, 0.0, 0.0, 1.0, 30);
			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("AutoDing v"..AUTODINGVER.." by Unique has loaded. \'/autoding\' for instructions.", 0.9, 0.25, 1.0);
			end
		end
		
		if (not UniAutoDingSaved[AutoDing_Player]) then
			UniAutoDing_ResetVars();
		end

		if (UniAutoDingSaved["Version"] ~= AUTODINGVER) then
			UniAutoDingSaved["Version"] = AUTODINGVER;
		end
		-- Variable Setup Attempt
		if ((UniAutoDingSaved["Channel"] == nil) or not (UniAutoDingSaved["Channel"])) then
			UniAutoDingSaved["Channel"] = GUILD;
		end
		if ((UniAutoDingSaved["AutoDing"] == nil) or not (UniAutoDingSaved["AutoDing"])) then
			UniAutoDingSaved["AutoDing"] = 1;
		end
		if ((UniAutoDingSaved["Version"] == nil) or not (UniAutoDingSaved["Version"])) then
			UniAutoDingSaved["Version"] = AUTODINGVER;
		end
		if ((UniAutoDingSaved["PartyDing"] == nil) or not (UniAutoDingSaved["PartyDing"])) then
			UniAutoDingSaved["PartyDing"] = 1;
		end
		if ((UniAutoDingSaved["Screenie"] == nil) or not (UniAutoDingSaved["Screenie"])) then
			UniAutoDingSaved["Screenie"] = 0;
		end
		if ((UniAutoDingSaved["DingString"] == nil) or not (UniAutoDingSaved["DingString"])) then
			UniAutoDingSaved["DingString"] = "Ding, level $L (AutoDinging since 2005)";
		end
		ADmsg = UniAutoDingSaved["DingString"];
	end
end

			
function UniAutoDing_OnUpdate()
	if not (AutoDingFrame:IsVisible()) then --Shouldn't get OnUpdates whilst hidden, but you never know :).
		return;
	end
	-- If our initial wait time hasn't passed, then return
	if (GetTime() < (AD_StartTime + AUTODING_DELAYTIME)) then
		return;
	end
	-- Wait time has passed.  Quit receiving updates and take the screenshot.
	AutoDingFrame:Hide();
	TakeScreenshot();

end

function UniAutoDing_Command(ADcommand)
	if (not ADcommand) then
	return;
	end

	local i,j, cmd, param = string.find(ADcommand, "^([^ ]+) (.+)$");
	if (not cmd) then cmd = ADcommand; end
	if (not cmd) then cmd = ""; end
	if (not param) then param = ""; end
	
	if ( cmd and strlen(cmd) > 0 ) then
		cmd = strlower(cmd);
	end
	if (cmd == "status") then
		if (param == "on") then
			UniAutoDingSaved[AutoDing_Player].AutoDing = 1;
			UniAutoDing_ChatPrint("Ding will be sent to "..UniAutoDingSaved[AutoDing_Player].Channel.." channel upon levelling up.");
		elseif (param == "off") then
			UniAutoDingSaved[AutoDing_Player].AutoDing = 0;
			UniAutoDing_ChatPrint("No Ding will be sent to channels, you'll have to do it yourself! Gasp! Too much effort! :(");
		else
			UniAutoDing_ChatPrint("Type \'/ad status on/off\' to turn settings on or off.");
			if not (UniAutoDingSaved) then
				UniAutoDing_ResetVars();
				UniAutoDing_ChatPrint("Settings reset to default as settings not found.");
				return;
			else
				AutoDingTest();
			end
		end
	elseif (cmd == "test") then
		AutoDingTest();
	elseif (cmd == "config") then
		AutoDingConfigFrame:Show();
	elseif (cmd == "toggle") then
		if (UniAutoDingSaved[AutoDing_Player].AutoDing == 1) then
			UniAutoDingSaved[AutoDing_Player].AutoDing = 0;
		else
			UniAutoDingSaved[AutoDing_Player].AutoDing = 1;
		end
	elseif (cmd == "endmessage") or (cmd == "firstmessage") or (cmd == "ding") or (cmd == "message") then
		UniAutoDing_ChatPrint("Use \'/ad config\' to setup Ding messages now");
	elseif (cmd == "party") then
		if (UniAutoDingSaved[AutoDing_Player].PartyDing == 1) then
			UniAutoDingSaved[AutoDing_Player].PartyDing = 0;
			UniAutoDing_ChatPrint("Ding to Party if grouped is off.");
		elseif (UniAutoDingSaved[AutoDing_Player].PartyDing == 0) then
			UniAutoDingSaved[AutoDing_Player].PartyDing = 1;
			UniAutoDing_ChatPrint("Ding to Party if grouped is on.");
		end
	elseif (cmd == "channel") then
		if (param == "raid") or (param == "guild") or (param == "party") or (param == "say") or (param == "yell") then
			UniAutoDingSaved[AutoDing_Player].Channel = strupper(param);
			UniAutoDing_ChatPrint("Autoding set to output to "..UniAutoDingSaved[AutoDing_Player].Channel.." channel");
			if AutoDingConfigFrame:IsVisible() then
				AutoDingConfig_SetValues();
			end
		else
			UniAutoDing_ChatPrint("Valid parameters are guild, party, say, yell or raid. So \'|cff66ccff/ad channel guild|r\' would set the output to guild channel.");
		end
	elseif (cmd == "screenie") then
		if (UniAutoDingSaved[AutoDing_Player].Screenie == 1) then
			UniAutoDingSaved[AutoDing_Player].Screenie = 0;
		else
			UniAutoDingSaved[AutoDing_Player].Screenie = 1;
		end
	elseif (cmd == "reset") then
		UniAutoDing_ChatPrint("AutoDing settings reset to default values.");
		UniAutoDing_ResetVars();		
	else
		UniAutoDing_ChatPrint("AutoDing mod by Unique of Dalaran.");
		UniAutoDing_ChatPrint("|cffffffffSlash Command Usage|r:");
		UniAutoDing_ChatPrint("\'|cff66ccff/ad status|r\' - displays current status/settings of the mod and how to switch it on/off.");
		UniAutoDing_ChatPrint("\'|cff66ccff/ad config|r\' - Opens up Config Window where you can setup everything.");
		UniAutoDing_ChatPrint("\'|cff66ccff/ad channel|r\' - displays instructions for setting channel to output to.");
		UniAutoDing_ChatPrint("\'|cff66ccff/ad reset|r\' - resets all settings to default.");
	end
end

function UniAutoDing_ResetVars()
	
	if not (UniAutoDingSaved) then
		UniAutoDingSaved = {};
	end
	if not (AutoDing_Player) then
		AutoDing_Player = UnitName("player") .. " of " .. GetCVar("realmName");
	end
	if not (UniAutoDingSaved[AutoDing_Player]) then
		UniAutoDingSaved[AutoDing_Player] = {};
		UniAutoDingSaved[AutoDing_Player].Channel = "GUILD";
		UniAutoDingSaved[AutoDing_Player].AutoDing = 1;
		UniAutoDingSaved[AutoDing_Player].Channel = "GUILD";
		UniAutoDingSaved[AutoDing_Player].Version = AUTODINGVER;
		UniAutoDingSaved[AutoDing_Player].PartyDing = 1;
		UniAutoDingSaved[AutoDing_Player].Screenie = 0;
		UniAutoDingSaved[AutoDing_Player].DingString = "Woot - Ding, level $L (AutoDinging since 2005)";
	else
		UniAutoDingSaved[AutoDing_Player].Channel = "GUILD";
		UniAutoDingSaved[AutoDing_Player].AutoDing = 1;
		UniAutoDingSaved[AutoDing_Player].Channel = "GUILD";
		UniAutoDingSaved[AutoDing_Player].Version = AUTODINGVER;
		UniAutoDingSaved[AutoDing_Player].PartyDing = 1;
		UniAutoDingSaved[AutoDing_Player].Screenie = 0;
		UniAutoDingSaved[AutoDing_Player].DingString = "Woot - Ding, level $L (AutoDinging since 2005)";
	end

end
------------------------------------------------------------------------------------------------
-- Chat Messaging Functions - making my life easier
------------------------------------------------------------------------------------------------

function UniAutoDing_ChatPrint(str)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(str, 1.0, 1.0, 0.0);
	end
end

function UniAutoDing_ChannelMessage(message, channel)
	SendChatMessage(message, channel);
end

function AutoDing_FormatDing()
	local ADLevel = (UnitLevel("player") +1 );
	ADmsg = UniAutoDingSaved[AutoDing_Player].DingString;
	ADmsg = string.gsub(ADmsg, "$L", ADLevel);
	return ADmsg;	
end

function AutoDingTest()
	AutoDing_FormatDing();
	if UniAutoDingSaved[AutoDing_Player].AutoDing == 1 then
		UniAutoDing_ChatPrint("AutoDing is currently |cff66ccffon|r and will export the message \""..ADmsg.."\" to "..UniAutoDingSaved[AutoDing_Player].Channel.." channel.");
	elseif UniAutoDingSaved[AutoDing_Player].AutoDing == 0 then
		UniAutoDing_ChatPrint("AutoDing is currently |cff66ccffoff|r and won't export the message \""..ADmsg.."\" to "..UniAutoDingSaved[AutoDing_Player].Channel.." channel.");
	end
end