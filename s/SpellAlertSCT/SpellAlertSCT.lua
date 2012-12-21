SpellAlertSCTVersion =  "v11100-1";
SpellAlertDEBUG = false;

--[[
SpellAlertSCT
Author:         BarryJ (Eugorym of Perenolde) based on code from Awen
Version: 	11100-1

Description :
This is a modified version of SpellAlert that instead of putting the notification up in it's own frame will send a message to ScrollingCombatText.
There are several command line options to set how the text is displayed.

/sasct crit [on/off] -- Whether or not the message should be a crit; does nothing if style is set to Message.  [Default is Off]
/sasct status -- Displays the current configuration options.
/sasct style [message/vertical/rainbow/horizontal/angled down] -- Animation Style to use.    [Default is Vertical]
/sasct targetonly [on/off] -- Whether or not to display messages from the selected target only.  [Default is Off]
/sasct test -- Send a test message to see how it looks.  (Also done automatically after a settings change)
/sasct emotes [on/off] -- Whether or not to display emotes along with spells.  [Default is On]
/sasct targetindicator [string] -- Text to be put before and after the message, if the spell is being cast by your target.  [Default is ' *** ']
/sasct retarget [on/off] -- Retarget after feign death like old SpellAlert.  [Default is On]
/sasct bosswarnings [on/off] -- Deep Breath and Living Bomb Warning like old SpellAlert.  [Default is On]
/sasct toggle [on/off] -- Toggles alerting of spell casting on and off.  [Default is On]
/sasct color [default/target/warn/emote] [red/green/blue] [0.0 - 1.0] -- Sets the color component of the specified color.
/sasct compact [on/off] -- Toggles compacting of messages.  [Default is Off]
/sasct repeat [number] -- How long in seconds to refrain from repeating the same message [Default is 2]

Changes :
11100-1:
French compatibilty
/sasct repeat command added
Default message repeat delay time is now 2 seconds

11000-11:
Bug Fix: Correctly displays the status of the BossWarnings Option
11000-10:
Added emote color options
Added compact option
Will no longer print the same message more than once every second
11000-9:
Now three different colors, one for regular (default), one for your target (target), and one for boss warnings (warn)
Added toggle option
Code fixes/optimizations
11000-8:
Clean up.
Added color to usage/help
Added /sasct retarget [on/off]
Added /sasct bosswarnings [on/off]
11000-7:
Incorporated changes by gygabyte
11000-6:
Default style is now Vertical, default Crit state is now Off
Added TargetIndicator option
Code cleanup (Yippie!)
Possible German support
Possible Korean support (Note: on curse-gaming there is a Korean Only version of 11000-5.2, more of that translation to come in 11000-7)
Less possible, but still possible French support
11000-5.2:
Back to one slash command
11000-5.1:
Fixed a bug with the /sasct reset from version 11000-5
11000-5:
Added the default settings to the help
Added a reset configuration command /sasct reset
Added emote toggle
11000-4:
Message Color is now changeable
Added TargetOnly option
11000-3:
Cleaned up code some more.
Added /sasct command and options for display.
Made file a .zip per request.
11000-2:
Cleaned up code a bit.
11000-1:
Initial Release
]]

sasct_color =  {r = 1.0, g = 1.00, b = 1.00};
sasct_targetcolor =  {r = 1.0, g = 1.00, b = 1.00};
sasct_warncolor =  {r = 1.0, g = 0.00, b = 1.00};
sasct_emotecolor =  {r = 0.70, g = 0.70, b = 1.00};

-- variables option
--[[sasct_heals = 1;
sasct_cc = 1;
sasct_dispelable = 1;
sasct_damage = 1;]]

-- Local variables
local playerName = nil;
local sa_targetName = nil;
local sa_targetClass = nil;
local sa_targetHostile = nil;
local sa_gains = {};
local partyNum = 0;
local raidNum = 0;
local raidList = {};
local listMessages = {};

function SpellAlertSCT_ShowUsage()
	local yellow = "|cffffff00";
	local white = "|cffffffff";
	SpellAlertSCT_print(SASCT_USAGE_HEADER_1..yellow..SpellAlertSCTVersion..white..SASCT_USAGE_HEADER_2);
	SpellAlertSCT_print(yellow.."/sasct crit [on/off]"..white.." -- "..SASCT_USAGE_CRIT);
	SpellAlertSCT_print(yellow.."/sasct status"..white.." -- "..SASCT_USAGE_STATUS);
	SpellAlertSCT_print(yellow.."/sasct style [message/vertical/rainbow/horizontal/angled down]"..white.." -- "..SASCT_USAGE_STYLE);
	SpellAlertSCT_print(yellow.."/sasct targetonly [on/off]"..white.." -- "..SASCT_USAGE_TARGETONLY);
	SpellAlertSCT_print(yellow.."/sasct test"..white.." -- "..SASCT_USAGE_TEST);
--	SpellAlertSCT_print(yellow.."/sasct red [0.0 - 1.0]"..white.." -- "..SASCT_USAGE_RED);
--	SpellAlertSCT_print(yellow.."/sasct green [0.0 - 1.0]"..white.." -- "..SASCT_USAGE_GREEN);
--	SpellAlertSCT_print(yellow.."/sasct blue [0.0 - 1.0]"..white.." -- "..SASCT_USAGE_BLUE);
	SpellAlertSCT_print(yellow.."/sasct emotes [on/off]"..white.." -- "..SASCT_USAGE_EMOTES);
	SpellAlertSCT_print(yellow.."/sasct color [default/target/warn/emote] [red/green/blue] [0.0 - 1.0] "..white.." -- "..SASCT_USAGE_COLOR);
	SpellAlertSCT_print(yellow.."/sasct targetindicator [string]"..white.." -- "..SASCT_USAGE_TARGETINDICATOR);
	SpellAlertSCT_print(yellow.."/sasct retarget [on/off]"..white.." -- "..SASCT_USAGE_RETARGET);
	SpellAlertSCT_print(yellow.."/sasct bosswarnings [on/off]"..white.." -- "..SASCT_USAGE_BOSSWARNINGS);
	SpellAlertSCT_print(yellow.."/sasct toggle [on/off]"..white.." -- "..SASCT_USAGE_TOGGLE);
	SpellAlertSCT_print(yellow.."/sasct compact [on/off]"..white.." -- "..SASCT_USAGE_COMPACT);
	SpellAlertSCT_print(yellow.."/sasct repeat [number]"..white.." -- "..SASCT_USAGE_REPEAT);
end

function SpellAlertSCT_alert(mob, spell, msg, msgtype)
	if (SA_SPELLS_IGNORE[spell]) then
		return;
	end
	
	msgtodisplay = strsub(msg, 0, strlen(msg) - 1);

	if (SpellAlertDEBUG and msgtype == "?") then
		local yellow = "|cffffff00";
		local white = "|cffffffff";	
		SpellAlertSCT_print("Type: "..msgtype.." - Should print '"..yellow..msgtodisplay..white.."'");
	end
	
	if (SpellAlertSCTDB[playerName].Compact) then
		if (msgtype == "cast") then
			msgtodisplay = mob.." > "..spell;
		elseif (msgtype == "gain") then
			msgtodisplay = mob.." + "..spell;
		end
	end
	
	local targetname = UnitName("target");
	if (mob == targetname) then
		SpellAlertSCT_SCTDisplay(msgtodisplay, true, msgtype);
	else
		if (not SpellAlertSCTDB[playerName].TargetOnly) then
			SpellAlertSCT_SCTDisplay(msgtodisplay, false, msgtype);
		end
	end
end

function SpellAlertSCT_SCTDisplay(msg, target, msgtype)
	if (SpellAlertSCTDB[playerName].Toggle == false) then
		return;
	end

	if (not listMessages[msg]) then
		listMessages[msg] = GetTime();
		SpellAlertSCT_debug("Message: '"..msg.."' was printed for the first time at '"..listMessages[msg].."'");
	elseif (GetTime() - listMessages[msg] < SpellAlertSCTDB[playerName].MessageRepeatTime) then
		SpellAlertSCT_debug("Blocking message '"..msg.."' from repeating.  Time difference = "..GetTime() - listMessages[msg]);
		return;
	else
		listMessages[msg] = GetTime();
	end
	
	local color = sasct_color;
	
	if (target) then
		msg = SpellAlertSCTDB[playerName].TargetIndicator..msg..SpellAlertSCTDB[playerName].TargetIndicator;
		color = sasct_targetcolor;
	end

	if (msgtype == "emote") then
		color = sasct_emotecolor;
	end
	
	if (SpellAlertSCTDB[playerName].Style == "message") then
		SCT_Display_Message(msg, color);
	elseif (SpellAlertSCTDB[playerName].Style == "vertical") then
		SCT_Display(msg, color, SpellAlertSCTDB[playerName].Crit, "event", 1 )
	elseif (SpellAlertSCTDB[playerName].Style == "rainbow") then
		SCT_Display(msg, color, SpellAlertSCTDB[playerName].Crit, "event", 2 )
	elseif (SpellAlertSCTDB[playerName].Style == "horizontal") then
		SCT_Display(msg, color, SpellAlertSCTDB[playerName].Crit, "event", 3 )
	elseif (SpellAlertSCTDB[playerName].Style == "angled down") then
		SCT_Display(msg, color, SpellAlertSCTDB[playerName].Crit, "event", 4 )
	else
		SCT_Display_Message(msg, color);
		SpellAlertSCT_print(SASCT_ERRNOSTYLE);
	end
end

function SpellAlertSCT_ShowStatus()
	if ( SpellAlertSCTDB[playerName].Crit ) then
		SpellAlertSCT_print(SASCT_STATUS_CRIT..SpellAlertSCTDB[playerName].Style..SASCT_STATUS_CRIT_2);
	else
		SpellAlertSCT_print(SASCT_STATUS_NONCRIT..SpellAlertSCTDB[playerName].Style..SASCT_STATUS_CRIT_2);
	end
	if ( SpellAlertSCTDB[playerName].TargetOnly ) then
		SpellAlertSCT_print(SASCT_STATUS_TARGETONLY_ON);
	else
		SpellAlertSCT_print(SASCT_STATUS_TARGETONLY_OFF);
	end
	if ( SpellAlertSCTDB[playerName].Emotes ) then
		SpellAlertSCT_print(SASCT_STATUS_EMOTES_ON);
	else
		SpellAlertSCT_print(SASCT_STATUS_EMOTES_OFF);
	end
	if ( SpellAlertSCTDB[playerName].BossWarnings ) then
		SpellAlertSCT_print(SASCT_STATUS_BOSSWARN_ON);
	else
		SpellAlertSCT_print(SASCT_STATUS_BOSSWARN_OFF);
	end
	if ( SpellAlertSCTDB[playerName].Compact ) then
		SpellAlertSCT_print(SASCT_STATUS_COMPACT_ON);
	else
		SpellAlertSCT_print(SASCT_STATUS_COMPACT_OFF);
	end	
	SpellAlertSCT_print(SASCT_STATUS_COLOR..SpellAlertSCTDB[playerName].defaultcolor.red.."/"..SpellAlertSCTDB[playerName].defaultcolor.green.."/"..SpellAlertSCTDB[playerName].defaultcolor.blue..SASCT_STATUS_COLOR_DEFAULT);
	SpellAlertSCT_print(SASCT_STATUS_COLOR..SpellAlertSCTDB[playerName].targetcolor.red.."/"..SpellAlertSCTDB[playerName].targetcolor.green.."/"..SpellAlertSCTDB[playerName].targetcolor.blue..SASCT_STATUS_COLOR_TARGET);
	SpellAlertSCT_print(SASCT_STATUS_COLOR..SpellAlertSCTDB[playerName].warncolor.red.."/"..SpellAlertSCTDB[playerName].warncolor.green.."/"..SpellAlertSCTDB[playerName].warncolor.blue..SASCT_STATUS_COLOR_WARN);
	SpellAlertSCT_print(SASCT_STATUS_COLOR..SpellAlertSCTDB[playerName].emotecolor.red.."/"..SpellAlertSCTDB[playerName].emotecolor.green.."/"..SpellAlertSCTDB[playerName].emotecolor.blue..SASCT_STATUS_COLOR_EMOTE);
	
	SpellAlertSCT_print(SASCT_STATUS_REPEAT..SpellAlertSCTDB[playerName].MessageRepeatTime);
	
	local ti = SpellAlertSCTDB[playerName].TargetIndicator;
	if (ti == "") then ti = "(blank)"; end
	SpellAlertSCT_print(SASCT_STATUS_TARGETINDICATOR..ti);
	
	if ( SpellAlertSCTDB[playerName].Toggle ) then
		SpellAlertSCT_print(SASCT_STATUS_TOGGLE_ON);
	else
		SpellAlertSCT_print(SASCT_STATUS_TOGGLE_OFF);
	end
end

function SpellAlertSCT_SlashHandler(msg)
	if ( not msg or strlen(msg) <= 0 ) then
		SpellAlertSCT_ShowUsage();
		return;
	end
	
	local command, params = SpellAlertSCT_NextParameter(string.lower(msg));

	if ( command == "crit" ) then
		if ( not params ) then
			if (SpellAlertSCTDB[playerName].Crit == true) then
				SpellAlertSCTDB[playerName].Crit = false;
				SpellAlertSCT_print(SASCT_OPT_CRIT_OFF);
			else
				SpellAlertSCTDB[playerName].Crit = true;
				SpellAlertSCT_print(SASCT_OPT_CRIT_ON);
			end
		else
			if (params == "on") then
				SpellAlertSCTDB[playerName].Crit = true;
				SpellAlertSCT_print(SASCT_OPT_CRIT_ON);
			else
				SpellAlertSCTDB[playerName].Crit = false;
				SpellAlertSCT_print(SASCT_OPT_CRIT_OFF);
			end
		end
		SpellAlertSCT_test();
	elseif ( command == "style" ) then
		if ( not params ) then
			SpellAlertSCT_print(SASCT_OPT_STYLE_NOSTYLE);
		else
			if (params == "message") then
				SpellAlertSCTDB[playerName].Style = "message";
				SpellAlertSCT_print(SASCT_OPT_STYLE_MESSAGE);
			elseif (params == "vertical") then
				SpellAlertSCTDB[playerName].Style = "vertical";
				SpellAlertSCT_print(SASCT_OPT_STYLE_VERTICAL);
			elseif (params == "rainbow") then
				SpellAlertSCTDB[playerName].Style = "rainbow";
				SpellAlertSCT_print(SASCT_OPT_STYLE_RAINBOW);
			elseif (params == "horizontal") then
				SpellAlertSCTDB[playerName].Style = "horizontal";
				SpellAlertSCT_print(SASCT_OPT_STYLE_HORIZONTAL);
			elseif (params == "angled down") then
				SpellAlertSCTDB[playerName].Style = "angled down";
				SpellAlertSCT_print(SASCT_OPT_STYLE_ANGLEDDOWN);
			else
				SpellAlertSCT_print(SASCT_OPT_STYLE_CHOICES);
			end
			SpellAlertSCT_test();
		end
	elseif ( command == "targetonly" ) then
		if ( not params ) then
			if (SpellAlertSCTDB[playerName].TargetOnly == true) then
				SpellAlertSCTDB[playerName].TargetOnly = false;
				SpellAlertSCT_print(SASCT_OPT_TARGETONLY_OFF);
			else
				SpellAlertSCTDB[playerName].TargetOnly = true;
				SpellAlertSCT_print(SASCT_OPT_TARGETONLY_ON);
			end
		else
			if (params == "on") then
				SpellAlertSCTDB[playerName].TargetOnly = true;
				SpellAlertSCT_print(SASCT_OPT_TARGETONLY_ON);
			else
				SpellAlertSCTDB[playerName].TargetOnly = false;
				SpellAlertSCT_print(SASCT_OPT_TARGETONLY_OFF);
			end
		end
	elseif ( command == "emotes" ) then
		if ( not params ) then
			if (SpellAlertSCTDB[playerName].Emotes == true) then
				SpellAlertSCTDB[playerName].Emotes = false;
				SpellAlertSCT_print(SASCT_OPT_EMOTES_OFF);
			else
				SpellAlertSCTDB[playerName].Emotes = true;
				SpellAlertSCT_print(SASCT_OPT_EMOTES_ON);
			end
		else
			if (params == "on") then
				SpellAlertSCTDB[playerName].Emotes = true;
				SpellAlertSCT_print(SASCT_OPT_EMOTES_ON);
			else
				SpellAlertSCTDB[playerName].Emotes = false;
				SpellAlertSCT_print(SASCT_OPT_EMOTES_OFF);
			end
		end
--[[		elseif ( command == "red" ) then
		if ( not params ) then
			SpellAlertSCT_print(SASCT_OPT_COLOR_COICES);
		else
			if ( tonumber(params) and tonumber(params) <= 1 and tonumber(params) >= 0) then
				SpellAlertSCTDB[playerName].red = tonumber(params);
				sasct_color.r = SpellAlertSCTDB[playerName].red;
				SpellAlertSCT_print(SASCT_OPT_RED_SET..SpellAlertSCTDB[playerName].red..SASCT_OPT_RED_END);
				SpellAlertSCT_test()
			else
				SpellAlertSCT_print(SASCT_OPT_COLOR_COICES);
			end
		end
	elseif ( command == "green" ) then
		if ( not params ) then
			SpellAlertSCT_print(SASCT_OPT_COLOR_COICES);
		else
			if ( tonumber(params) and tonumber(params) <= 1 and tonumber(params) >= 0) then
				SpellAlertSCTDB[playerName].green = tonumber(params);
				sasct_color.g = SpellAlertSCTDB[playerName].green;
				SpellAlertSCT_print(SASCT_OPT_GREEN_SET..SpellAlertSCTDB[playerName].green..SASCT_OPT_GREEN_END);
				SpellAlertSCT_test()
			else
				SpellAlertSCT_print(SASCT_OPT_COLOR_COICES);
			end
		end
	elseif ( command == "blue" ) then
		if ( not params ) then
			SpellAlertSCT_print(SASCT_OPT_COLOR_COICES);
		else
			if ( tonumber(params) and tonumber(params) <= 1 and tonumber(params) >= 0) then
				SpellAlertSCTDB[playerName].blue = tonumber(params);
				sasct_color.b = SpellAlertSCTDB[playerName].blue;
				SpellAlertSCT_print(SASCT_OPT_BLUE_SET..SpellAlertSCTDB[playerName].blue..SASCT_OPT_BLUE_END);
				SpellAlertSCT_test()
			else
				SpellAlertSCT_print(SASCT_OPT_COLOR_COICES);
			end
		end
]]	elseif ( command == "targetindicator" ) then
		if ( not params ) then
			SpellAlertSCTDB[playerName].TargetIndicator = "";
			SpellAlertSCT_print(SASCT_OPT_TARGETINDICATOR_BLANK);
		else
			SpellAlertSCTDB[playerName].TargetIndicator = params;
			SpellAlertSCT_print(SASCT_OPT_TARGETINDICATOR_SET..SpellAlertSCTDB[playerName].TargetIndicator);
		end
	elseif ( command == "retarget" ) then
		if ( not params ) then
			if (SpellAlertSCTDB[playerName].Retarget == true) then
				SpellAlertSCTDB[playerName].Retarget = false;
				SpellAlertSCT_print(SASCT_OPT_RETARGET_OFF);
			else
				SpellAlertSCTDB[playerName].Retarget = true;
				SpellAlertSCT_print(SASCT_OPT_RETARGET_ON);
			end
		else
			if (params == "on") then
				SpellAlertSCTDB[playerName].Retarget = true;
				SpellAlertSCT_print(SASCT_OPT_RETARGET_ON);
			else
				SpellAlertSCTDB[playerName].Retarget = false;
				SpellAlertSCT_print(SASCT_OPT_RETARGET_OFF);
			end
		end
	elseif ( command == "bosswarnings" ) then
		if ( not params ) then
			if (SpellAlertSCTDB[playerName].BossWarnings == true) then
				SpellAlertSCTDB[playerName].BossWarnings = false;
				SpellAlertSCT_print(SASCT_OPT_BOSSWARNINGS_OFF);
			else
				SpellAlertSCTDB[playerName].BossWarnings = true;
				SpellAlertSCT_print(SASCT_OPT_BOSSWARNINGS_ON);
			end
		else
			if (params == "on") then
				SpellAlertSCTDB[playerName].BossWarnings = true;
				SpellAlertSCT_print(SASCT_OPT_BOSSWARNINGS_ON);
			else
				SpellAlertSCTDB[playerName].BossWarnings = false;
				SpellAlertSCT_print(SASCT_OPT_BOSSWARNINGS_OFF);
			end
		end
	elseif ( command == "toggle" ) then
		if ( not params ) then
			if (SpellAlertSCTDB[playerName].Toggle == true) then
				SpellAlertSCTDB[playerName].Toggle = false;
				SpellAlertSCT_print(SASCT_OPT_TOGGLE_OFF);
			else
				SpellAlertSCTDB[playerName].Toggle = true;
				SpellAlertSCT_print(SASCT_OPT_TOGGLE_ON);
			end
		else
			if (params == "on") then
				SpellAlertSCTDB[playerName].Toggle = true;
				SpellAlertSCT_print(SASCT_OPT_TOGGLE_ON);
			else
				SpellAlertSCTDB[playerName].Toggle = false;
				SpellAlertSCT_print(SASCT_OPT_TOGGLE_OFF);
			end
		end
	elseif ( command == "color" ) then
		if ( not params ) then
			SpellAlertSCT_print(SASCT_OPT_COLOR_TYPES);
		else
			local whichtype;
			whichtype, params = SpellAlertSCT_NextParameter(params);
			if (not (whichtype == "default" or whichtype == "target" or whichtype == "warn" or whichtype == "emote")) then
				SpellAlertSCT_print(SASCT_OPT_COLOR_TYPES);
				SpellAlertSCT_print("You put: "..whichtype);
				return;
			end
			
			if ( not params ) then
				SpellAlertSCT_print(SASCT_OPT_COLOR_COLORS);
			else
				local whichcolor;
				whichcolor, params = SpellAlertSCT_NextParameter(params);
				if ( tonumber(params) and tonumber(params) <= 1 and tonumber(params) >= 0) then
					if (not (whichcolor == "red" or whichcolor == "green" or whichcolor == "blue")) then
						SpellAlertSCT_print(SASCT_OPT_COLOR_COLORS);
						return;
					end
					
					SpellAlertSCTDB[playerName][whichtype.."color"][whichcolor] = tonumber(params);
					SpellAlertSCT_print(whichtype.." "..whichcolor.." = "..SpellAlertSCTDB[playerName][whichtype.."color"][whichcolor]);
					SpellAlertSCT_UpdateColors();
				else
					SpellAlertSCT_print(SASCT_OPT_COLOR_COICES);
				end
			end
		end
	elseif ( command == "compact" ) then
		if ( not params ) then
			if (SpellAlertSCTDB[playerName].Compact == true) then
				SpellAlertSCTDB[playerName].Compact = false;
				SpellAlertSCT_print(SASCT_OPT_COMPACT_OFF);
			else
				SpellAlertSCTDB[playerName].Compact = true;
				SpellAlertSCT_print(SASCT_OPT_COMPACT_ON);
			end
		else
			if (params == "on") then
				SpellAlertSCTDB[playerName].Compact = true;
				SpellAlertSCT_print(SASCT_OPT_COMPACT_ON);
			else
				SpellAlertSCTDB[playerName].Compact = false;
				SpellAlertSCT_print(SASCT_OPT_COMPACT_OFF);
			end
		end
	elseif ( command == "repeat" ) then
		if ( not params ) then
			SpellAlertSCT_print(SASCT_OPT_REPEAT_ERROR);
		else
			if ( tonumber(params)) then
				SpellAlertSCTDB[playerName].MessageRepeatTime = tonumber(params);
				SpellAlertSCT_print(SASCT_OPT_REPEAT_SET..SpellAlertSCTDB[playerName].MessageRepeatTime);
			else
				SpellAlertSCT_print(SASCT_OPT_REPEAT_ERROR);
			end
		end	elseif ( command == "status" ) then
		SpellAlertSCT_ShowStatus();
	elseif ( command == "reset" ) then
		SpellAlertSCT_ResetOptions();
		SpellAlertSCT_print(SASCT_OPT_RESET);
		SpellAlertSCT_test();
	elseif ( command == "test" ) then
		SpellAlertSCT_test();
	elseif ( command == "resetmessagelist" ) then
		listMessages = {};
	elseif (command == "rl") then
		ReloadUI();
	else
		SpellAlertSCT_ShowUsage();
	end
end

function SpellAlertSCT_ResetOptions()
	SpellAlertSCTDB[playerName] = {
			["Crit"] = false,
			["Style"] = "vertical",
			["TargetOnly"] = false,
			["TargetIndicator"] = " *** ",
--			["red"] = 1.0,
--			["green"] = 1.0,
--			["blue"] = 1.0,
			["Emotes"] = true,
			["Retarget"] = true,
			["BossWarnings"] = true,
			["Toggle"] = true,
			["Compact"] = false,
			["MessageRepeatTime"] = 2,

			["defaultcolor"] = {
				["red"] = 1.0,
				["green"] = 1.0,
				["blue"] = 1.0,		
			},
			["targetcolor"] = {
				["red"] = 1.0,
				["green"] = 1.0,
				["blue"] = 1.0,		
			},
			["warncolor"] = {
				["red"] = 1.0,
				["green"] = 0.0,
				["blue"] = 1.0,		
			},
			["emotecolor"] = {
				["red"] = 1.0,
				["green"] = 0.0,
				["blue"] = 1.0,		
			},
		};
		
	SpellAlertSCT_UpdateColors()
end

function SpellAlertSCT_OnEvent()
	local mob, spell;
	if ( event == "VARIABLES_LOADED" ) then
		this:RegisterEvent("RAID_ROSTER_UPDATE");
		this:RegisterEvent("PARTY_MEMBERS_CHANGED");
		
		this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
		this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
		this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		
		this:RegisterEvent("PLAYER_LEAVE_COMBAT");
		
		if ( not SpellAlertSCTDB ) then
			SpellAlertSCTDB = {};
			SpellAlertSCT_print("first use!")
		end
		
		if (GetLocale()=="koKR") then
			playerName = GetCVar("realmName").." 서버의 "..UnitName("player");
		else
			playerName = UnitName("player").." of "..GetCVar("realmName");
		end
		
		if ( not SpellAlertSCTDB[playerName] ) then
			SpellAlertSCT_ResetOptions();
			if (GetLocale()=="koKR") then
				SpellAlertSCT_print(playerName.."님의 프로필이 생성되었습니다");
			else
				SpellAlertSCT_print("profile "..playerName.." created!");
			end
		else
			if ( SpellAlertSCTDB[playerName].Style == nil ) then SpellAlertSCTDB[playerName].Style = "vertical"; end
			if ( SpellAlertSCTDB[playerName].Crit == nil ) then SpellAlertSCTDB[playerName].Crit = false; end
			if ( SpellAlertSCTDB[playerName].TargetOnly == nil ) then SpellAlertSCTDB[playerName].TargetOnly = false; end
			if ( SpellAlertSCTDB[playerName].Emotes == nil ) then SpellAlertSCTDB[playerName].Emotes = true; end
			if ( SpellAlertSCTDB[playerName].Retarget == nil ) then SpellAlertSCTDB[playerName].Retarget = true; end
			if ( SpellAlertSCTDB[playerName].BossWarnings == nil ) then SpellAlertSCTDB[playerName].BossWarnings = true; end
			if ( SpellAlertSCTDB[playerName].TargetIndicator == nil ) then SpellAlertSCTDB[playerName].TargetIndicator = " *** "; end
			if ( SpellAlertSCTDB[playerName].Toggle == nil ) then SpellAlertSCTDB[playerName].Toggle = true; end
			if ( SpellAlertSCTDB[playerName].Compact == nil ) then SpellAlertSCTDB[playerName].Compact = false; end
			if ( SpellAlertSCTDB[playerName].MessageRepeatTime == nil ) then SpellAlertSCTDB[playerName].MessageRepeatTime = 2; end

			
			if ( not SpellAlertSCTDB[playerName].defaultcolor) then
				SpellAlertSCTDB[playerName].defaultcolor = {
					["red"] = 1.0,
					["green"] = 1.0,
					["blue"] = 1.0,		
				};
			end
			if ( not SpellAlertSCTDB[playerName].targetcolor) then
				SpellAlertSCTDB[playerName].targetcolor = {
					["red"] = 1.0,
					["green"] = 1.0,
					["blue"] = 1.0,		
				};
			end
			if ( not SpellAlertSCTDB[playerName].warncolor) then
				SpellAlertSCTDB[playerName].warncolor ={
					["red"] = 1.0,
					["green"] = 0.0,
					["blue"] = 1.0,		
				};
			end
			if ( not SpellAlertSCTDB[playerName].emotecolor) then
				SpellAlertSCTDB[playerName].emotecolor ={
					["red"] = 0.70,
					["green"] = 0.70,
					["blue"] = 0.0,		
				};
			end
			
			SpellAlertSCT_print(playerName..SASCT_PROFILELOADED);
		end
		
		if ( SpellAlertSCTDB[playerName].red) then
			SpellAlertSCTDB[playerName].defaultcolor.red = SpellAlertSCTDB[playerName].red;
			SpellAlertSCTDB[playerName].red = nil;
		end
		if ( SpellAlertSCTDB[playerName].green) then
			SpellAlertSCTDB[playerName].defaultcolor.green = SpellAlertSCTDB[playerName].green;
			SpellAlertSCTDB[playerName].green = nil;
		end
		if ( SpellAlertSCTDB[playerName].blue) then
			SpellAlertSCTDB[playerName].defaultcolor.blue = SpellAlertSCTDB[playerName].blue;
			SpellAlertSCTDB[playerName].blue = nil;
		end
		
		SpellAlertSCT_UpdateColors();
		
		local yellow = "|cffffff00"
		local white = "|cffffffff"
		SpellAlertSCT_print("SpellAlert SCT "..yellow..SpellAlertSCTVersion..white..SASCT_LOADPRINT);
	elseif (event == "PARTY_MEMBERS_CHANGED") then
		local num = GetNumPartyMembers();
		if ((num ~= partyNum) and (GetNumRaidMembers() == 0)) then
			partyNum = num;
			SpellAlertSCT_BuildRaidList(false);
		end

	elseif (event == "RAID_ROSTER_UPDATE") then
		local num = GetNumRaidMembers();
		if (num ~= raidNum) then
			raidNum = num;
			SpellAlertSCT_BuildRaidList(true);
		end
	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			if (not SpellAlertSCT_isParty(mob)) then
				SpellAlertSCT_alert(mob, spell, arg1, "cast");
			end
			return;
		end
		-- "(.+) begins to perform (.+)."
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_PERFORM) do
			if (not SpellAlertSCT_isParty(mob)) then
				SpellAlertSCT_alert(mob, spell, arg1, "cast");
			end
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
		for mob, spell, k in string.gfind(arg1, SA_PTN_SPELL_GAINS_X) do
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			if (not SpellAlertSCT_isParty(mob)) then
				SpellAlertSCT_alert(mob, spell, arg1, "cast");
			end
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_TOTEM) do
			if (not SpellAlertSCT_isParty(mob)) then
				SpellAlertSCT_alert(mob, spell, arg1, "cast");
			end
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_GAINS) do
			SpellAlertSCT_alert(mob, spell, arg1, "cast");
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			SpellAlertSCT_alert(mob, spell, arg1, "cast");
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		for mob, spell, k in string.gfind(arg1, SA_PTN_SPELL_GAINS_X) do
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_GAINS) do
			SpellAlertSCT_alert(mob, spell, arg1, "gain");
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			SpellAlertSCT_alert(mob, spell, arg1, "cast");
			return;
		end
		-- "(.+) begins to perform (.+)."
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_PERFORM) do
			SpellAlertSCT_alert(mob, spell, arg1, "cast");
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS") then
		for mob, spell, temp in string.gfind(arg1, SA_PTN_SPELL_GAINS_X) do
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_GAINS) do
			if ( (spell == SA_WOTF) or
			     (spell == SA_BERSERKER_RAGE) ) then
				sa_gains[mob] = {};
				sa_gains[mob].spell = spell;
				sa_gains[mob].time = GetTime();
			end
			SpellAlertSCT_alert(mob, spell, arg1, "gain");
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
		for spell, mob in string.gfind(arg1, SA_PTN_SPELL_FADE) do
			if ( (spell == SA_WOTF) or
			     (spell == SA_BERSERKER_RAGE) ) then
				local tt = sa_gains[mob];
				if (tt) then
					if (tt.spell == spell) then
						if (GetTime() - tt.time <= 30) then
							SpellAlertSCT_alert(mob, spell, arg1, "?");
						end
					end
					tt[mob] = nil;
					return;
				end
			end
		end           
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
		if ((arg1 == SA_AFFLICT_LIVINGBOMB) and (SpellAlertSCTDB[playerName].BossWarnings)) then
			SpellAlertSCT_warn(arg1);
		end
	elseif (event == "CHAT_MSG_EMOTE") then
		if (arg1) then
			if (SpellAlertSCTDB[playerName].Emotes) then
				SpellAlertSCT_alert("", "", arg1, "emote");
			end
		end
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		local name = arg2;
		if (not name) then
			name = "nil";
		end
		if (arg1) then
			-- Onyxia Deep Breath and emotes
			if (SpellAlertSCTDB[playerName].BossWarnings and (name == SASCT_ONY) and (arg1 == SA_EMOTE_DEEPBREATH) ) then
				SpellAlertSCT_warn(name .. SASCT_EMOTESPACE .. arg1);
			elseif (SpellAlertSCTDB[playerName].Emotes) then
				SpellAlertSCT_alert(name, arg1, name .. SASCT_EMOTESPACE .. arg1, "emote");
			end
		end
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		--listMessages = {};
	end
end

function SpellAlertSCT_OnLoad()
	if ( not SCT_OnLoad ) then
		SpellAlertSCT_print(SASCT_NOSCT);
		return;
	end

	this:RegisterEvent("VARIABLES_LOADED");
	
	SlashCmdList["SpellAlertSCTCOMMAND"] = SpellAlertSCT_SlashHandler;
	SLASH_SpellAlertSCTCOMMAND1 = "/sasct";
	SLASH_SpellAlertSCTCOMMAND2 = "/ss";
end


function SpellAlertSCT_print(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cff68ccefSpellAlertSCT:|cffffffff "..msg);
	end
end

function SpellAlertSCT_debug(msg)
	if (SpellAlertDEBUG) then
		SpellAlertSCT_print(msg);
	end
end


function SpellAlertSCT_warn(msg)
--  Trying to rely only on SCT
--	WarningFrame:AddMessage(msg, sasct_color.r, sasct_color.g, sasct_color.b, 1, 5);
	if (SpellAlertSCTDB[playerName].Toggle == false) then
		return;
	end

	msg = SpellAlertSCTDB[playerName].TargetIndicator..msg..SpellAlertSCTDB[playerName].TargetIndicator;
	SCT_Display_Message(msg, sasct_warncolor);
end

function SpellAlertSCT_isParty(name)
--[[	for i = 1, 4, 1 do
		local partyname = UnitName("party" .. i);
		if (name == partyname) then
			return 1;
		end
	end
	return nil;]]
	return raidList[name];
end

function SpellAlertSCT_retarget(spell)
	if (SpellAlertSCTDB[playerName].Retarget == false) then
		return;
	end
	if (not UnitName("target")) then
		if (sa_targetName) then
			if (sa_targetHostile) then
				SpellAlertSCT_print(SASCT_RETARGET_1..spell..SASCT_RETARGET_2..sa_targetName);
				TargetLastEnemy();
			else
				SpellAlertSCT_print(SASCT_RETARGET_1..spell..SASCT_RETARGET_2..sa_targetName);
				TargetByName(sa_targetName);
			end
		end
	end
end

function SpellAlertSCT_OnUpdate()
	local targetName = UnitName("target");
	if (targetName) then
		sa_targetClass = UnitClass("target");
		sa_targetHostile = UnitIsEnemy("player", "target");
	else
		if (SpellAlertSCTDB[playerName].Retarget == true and sa_targetName and (sa_targetClass == SASCT_HUNTER) and sa_targetHostile ) then
			TargetLastTarget();
			if( UnitHealth("target") == 0 and UnitCanAttack("player", "target") ) then
				ClearTarget();
				SpellAlertSCT_retarget(SASCT_FEIGNDEATH);
			else
				ClearTarget();
			end
		end
	end
	sa_targetName = targetName;
end

function SpellAlertSCT_NextParameter(msg)
	local params = nil;
	local command = nil;
	local index = strfind(msg, " ");
	
	if ( index ) then
		command = strsub(msg, 1, index - 1);
		params = strsub(msg, index + 1);
	else
		command = msg;
	end
	return command, params;
end

function SpellAlertSCT_UpdateColors()
	sasct_color.r = SpellAlertSCTDB[playerName].defaultcolor.red;
	sasct_color.g = SpellAlertSCTDB[playerName].defaultcolor.green;
	sasct_color.b = SpellAlertSCTDB[playerName].defaultcolor.blue;
	
	sasct_targetcolor.r = SpellAlertSCTDB[playerName].targetcolor.red;
	sasct_targetcolor.g = SpellAlertSCTDB[playerName].targetcolor.green;
	sasct_targetcolor.b = SpellAlertSCTDB[playerName].targetcolor.blue;
	
	sasct_warncolor.r = SpellAlertSCTDB[playerName].warncolor.red;
	sasct_warncolor.g = SpellAlertSCTDB[playerName].warncolor.green;
	sasct_warncolor.b = SpellAlertSCTDB[playerName].warncolor.blue;

	sasct_emotecolor.r = SpellAlertSCTDB[playerName].emotecolor.red;
	sasct_emotecolor.g = SpellAlertSCTDB[playerName].emotecolor.green;
	sasct_emotecolor.b = SpellAlertSCTDB[playerName].emotecolor.blue;
end

function SpellAlertSCT_BuildRaidList(isRaid)
	raidList = { };
	local max, g, name;
	if (isRaid) then
		max = 40;
		g = "raid";
	else
		max = 4;
		g = "party";
	end
	for i = 1, max do
		name = UnitName(g..i);
		if (name) then
			raidList[name] = true; 
		end
		name = UnitName(g.."pet"..i);
		if (name) then
			raidList[name] = true;
		end
	end
end

function SpellAlertSCT_test()
	SpellAlertSCT_alert("Player", "test", playerName..SASCT_ADDONTEST);
end
