--[[
	Extra common usage commands not significant enough for a new module.
	--Thott
	
	Refactored it so that it uses the localization.lua. Added save settings by class.
	--sarf
]]

function UltimateUI_RegisterUltimateUIChatCommands()
	--------------------------------------------------------------------------------
	-- Register the help command.
	local comlist = ULTIMATEUI_HELP_COMM;
	local desc = ULTIMATEUI_HELP_COMM_INFO;
	local id = "ULTIMATEUIHELP";
	local func = function (msg) UltimateUIMaster_ChatCommandsHelpDisplay(); end
	UltimateUI_RegisterChatCommand ( id, comlist, func, desc, CSM_CHAINNONE );
	-- Overwrite old help command.
	UltimateUI_RegisterChatCommand ( "HELP", comlist, func, "", CSM_CHAINPRE );
	--------------------------------------------------------------------------------

	--------------------------------------------------------------------------------
	-- Register the version command.
	comlist = ULTIMATEUI_VERSION_COMM;
	desc = ULTIMATEUI_VERSION_COMM_INFO;
	id = "ULTIMATEUIVERSION";
	func = function (msg) UltimateUIMaster_ChatVersionDisplay(); end
	UltimateUI_RegisterChatCommand ( id, comlist, func, desc, CSM_CHAINNONE );
	--------------------------------------------------------------------------------

	--------------------------------------------------------------------------------
	-- Register the reload ui command.
	comlist = ULTIMATEUI_RELOADUI_COMM;
	desc	= ULTIMATEUI_RELOADUI_COMM_INFO;
	id = "RELOADUI";
	func = function()
		ReloadUI();
	end
	UltimateUI_RegisterChatCommand ( id, comlist, func, desc );
	--------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------
	-- Register (and setup) /stop
	UltimateUIStop_OnLoad();
	comlist = ULTIMATEUI_STOP_COMM;
	desc	= ULTIMATEUI_STOP_COMM_INFO;
	id = "STOP";
	func = function()
		UltimateUI_Stop();
	end
	UltimateUI_RegisterChatCommand ( id, comlist, func, desc );
	--------------------------------------------------------------------------------

	--------------------------------------------------------------------------------
	-- Register the class CVar settings commands.
	comlist = ULTIMATEUI_CLASS_SETTINGS_COMM;
	desc	= format(ULTIMATEUI_CLASS_SETTINGS_COMM_INFO, ULTIMATEUI_CLASS_SETTINGS_PARAM_SAVE, ULTIMATEUI_CLASS_SETTINGS_PARAM_LOAD);
	id = "SETTINGSBYCLASS";
	func = function(msg)
		if ( ( not msg ) or ( strlen(msg) <= 0 ) ) then
			-- Sea.io.print(format(ULTIMATEUI_CLASS_SETTINGS_HELP1, ULTIMATEUI_CLASS_SETTINGS_PARAM_LOAD, ULTIMATEUI_CLASS_SETTINGS_PARAM_SAVE));
			return;
		end
		local command = strlower(msg);
		local class = UnitClass("player");
		if( strfind("save", command) ) then
			UltimateUIMaster_StoreVariables()
			if ( UltimateUI_SaveDefaultSettingsForClass(class) ) then
				-- Sea.io.print(format(ULTIMATEUI_CLASS_SETTINGS_SAVED, class));
			else
				-- Sea.io.print(format(ULTIMATEUI_CLASS_SETTINGS_SAVED_ERROR, class));
			end
		elseif( strfind("load", command) ) then
			if ( UltimateUI_LoadDefaultSettingsForClass(class) ) then
				UltimateUIMaster_LoadVariables();
				-- Sea.io.print(format(ULTIMATEUI_CLASS_SETTINGS_LOADED, class));
			else
				-- Sea.io.print(format(ULTIMATEUI_CLASS_SETTINGS_LOADED_ERROR, class));
			end
		else
			-- Sea.io.print(ULTIMATEUI_CLASS_SETTINGS_HELP2);
		end
	end
	UltimateUI_RegisterChatCommand ( id, comlist, func, desc );
	--------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------
	-- Register the /f x command
	if (SLASH_FOLLOW4 == "/f") then
		SLASH_FOLLOW1 = "/fol";
		SLASH_FOLLOW4 = "/fol";
	end

	comlist = FCOMMAND_COMM;
	desc	= FCOMMAND_COMM_INFO;
	id = "FRIENDSCOMMAND";
	func = function(msg)
		local tbl = split(msg, " ");
		if (not tbl[1]) then return; end

		if (tbl[1] == "l" or tbl[1] == "list") then
			local m = ""
			local bool = 0;
			local numFriends = GetNumFriends();
			for i = 1, numFriends, 1 do
				local name, level, class, area, connected = GetFriendInfo(i);
				if (not connected) then
					if (bool == 0) then
						bool = 1;
						print1(FCOMMAND_ONLINE);
						print1(m);
						m = "";
					end
					m = m..MakeHyperLink("Player:"..name, name, "FF0000").." ";
				else
					m = m..MakeHyperLink("Player:"..name, name, "00FF00").." ";
				end
			end
			print1(FCOMMAND_OFFLINE);
			print1(m);
		elseif (tbl[1] == "a" or tbl[1] == "add") then
			if (tbl[2]) then
				AddFriend(tbl[2]);
			end
		elseif (tbl[1] == "r" or tbl[1] == "remove") then
			if (tbl[2]) then
				RemoveFriend(tbl[2]);
			end
		elseif (tbl[1] == "m" or tbl[1] == "message") then
			local m = strsub(msg, strlen(tbl[1]) + 1);
			if (not m or strlen(m) < 1) then return; end
			local numFriends = GetNumFriends();
			for i = 1, numFriends, 1 do
				local name, level, class, area, connected = GetFriendInfo(i);
				if (not connected) then
					break;
				end
				SendChatMessage(m, "WHISPER", this.language, name);
			end
		end
	end
	UltimateUI_RegisterChatCommand ( id, comlist, func, desc );
	--------------------------------------------------------------------------------
end

-- UltimateUI /stop command functions.  This command is obviously for macros.
function UltimateUIStop_OnLoad()
  -- Sea.util.hook("MoveForwardStop","UltimateUIStop_AutoStop");
  -- Sea.util.hook("MoveBackwardStop","UltimateUIStop_AutoStop");
  -- Sea.util.hook("ToggleAutoRun","UltimateUIStop_AutoToggle");
end
function UltimateUIStop_AutoStop()
  UltimateUIStopAuto = false;
end
function UltimateUIStop_AutoToggle()
  UltimateUIStopAuto = not UltimateUIStopAuto;
end
function UltimateUI_Stop()
  if(UltimateUIStopAuto) then
    UltimateUIStopAuto = false;
    ToggleAutoRun();
  end
  MoveForwardStop();
  MoveBackwardStop();
  TurnLeftStop();
  TurnRightStop();
end
