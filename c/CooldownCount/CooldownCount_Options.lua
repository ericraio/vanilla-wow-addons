	-- registers the mod with Cosmos
function CooldownCount_Register_Cosmos()
	if ( ( Cosmos_UpdateValue ) and ( Cosmos_RegisterConfiguration ) and ( CooldownCount_Cosmos_Registered == 0 ) ) then
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT",
			"SECTION",
			TEXT(COOLDOWNCOUNT_CONFIG_HEADER),
			TEXT(COOLDOWNCOUNT_CONFIG_HEADER_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_HEADER",
			"SEPARATOR",
			TEXT(COOLDOWNCOUNT_CONFIG_HEADER),
			TEXT(COOLDOWNCOUNT_CONFIG_HEADER_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_ENABLED",
			"CHECKBOX",
			TEXT(COOLDOWNCOUNT_ENABLED),
			TEXT(COOLDOWNCOUNT_ENABLED_INFO),
			CooldownCount_Toggle_Enabled,
			CooldownCount_Enabled
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_ROGUE_STEALTH",
			"CHECKBOX",
			TEXT(COOLDOWNCOUNT_ROGUE_STEALTH),
			TEXT(COOLDOWNCOUNT_ROGUE_STEALTH_INFO),
			CooldownCount_Toggle_RogueStealth,
			CooldownCount_RogueStealth
		);
		
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_NOSPACES",
			"CHECKBOX",
			TEXT(COOLDOWNCOUNT_NOSPACES),
			TEXT(COOLDOWNCOUNT_NOSPACES_INFO),
			CooldownCount_Toggle_NoSpaces,
			CooldownCount_NoSpaces
		);
		CooldownCount_UseLongTimerDescriptions = 0;
		--[[
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_USELONGTIMERS",
			"CHECKBOX",
			TEXT(COOLDOWNCOUNT_USELONGTIMERS),
			TEXT(COOLDOWNCOUNT_USELONGTIMERS_INFO),
			CooldownCount_Toggle_UseLongTimers,
			CooldownCount_UseLongTimerDescriptions
		);
		]]--
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_FLASHSPEED",
			"SLIDER",
			TEXT(COOLDOWNCOUNT_FLASHSPEED),
			TEXT(COOLDOWNCOUNT_FLASHSPEED_INFO),
			function (checked, value) CooldownCount_SetFlashSpeed(value, true); end,
			1,
			CooldownCount_TimeBetweenFlashes,
			0.1,
			1,
			COOLDOWNCOUNT_FLASHSPEED_SLIDER_DESCRIPTION,
			0.1,
			1,
			COOLDOWNCOUNT_FLASHSPEED_SLIDER_APPEND,
			1
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_USERSCALE",
			"SLIDER",
			TEXT(COOLDOWNCOUNT_USERSCALE),
			TEXT(COOLDOWNCOUNT_USERSCALE_INFO),
			function (checked, value) CooldownCount_SetUserScale(value, true); end,
			1,
			CooldownCount_UserScale,
			0.1,
			5,
			COOLDOWNCOUNT_USERSCALE_SLIDER_DESCRIPTION,
			0.1,
			1,
			COOLDOWNCOUNT_USERSCALE_SLIDER_APPEND,
			100
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_ALPHA",
			"SLIDER",
			TEXT(COOLDOWNCOUNT_ALPHA),
			TEXT(COOLDOWNCOUNT_ALPHA_INFO),
			function (checked, value) CooldownCount_Set_Alpha(value, true); end,
			1,
			CooldownCountOptions.alpha,
			0.01,
			1,
			COOLDOWNCOUNT_ALPHA_SLIDER_DESCRIPTION,
			0.01,
			1,
			COOLDOWNCOUNT_ALPHA_SLIDER_APPEND,
			100
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_HIDEUNTILTIMELEFT",
			"SLIDER",
			TEXT(COOLDOWNCOUNT_HIDEUNTILTIMELEFT),
			TEXT(COOLDOWNCOUNT_HIDEUNTILTIMELEFT_INFO),
			function (checked, value) CooldownCount_SetHideUntilTimeLeft(value, true); end,
			1,
			CooldownCount_HideUntilTimeLeft,
			0,
			60,
			COOLDOWNCOUNT_FLASHSPEED_SLIDER_DESCRIPTION,
			1,
			1,
			COOLDOWNCOUNT_FLASHSPEED_SLIDER_APPEND,
			1
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_NORMALCOLORSET",
			"BUTTON",
			COOLDOWNCOUNT_NORMALCOLOR_SET,
			COOLDOWNCOUNT_NORMALCOLOR_SET_INFO,
			CooldownCount_NormalColorSetButton,
			0,
			0,
			0,
			0,
			COOLDOWNCOUNT_SETTEXT
		);
		Cosmos_RegisterConfiguration(
			"COS_COOLDOWNCOUNT_FLASHCOLORSET",
			"BUTTON",
			COOLDOWNCOUNT_FLASHCOLOR_SET,
			COOLDOWNCOUNT_FLASHCOLOR_SET_INFO,
			CooldownCount_FlashColorSetButton,
			0,
			0,
			0,
			0,
			COOLDOWNCOUNT_SETTEXT
		);
		CooldownCount_Cosmos_Registered = 1;
	end
end


function CooldownCount_Extract_NextParameter(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end


-- registers the mod with the system, integrating it with slash commands and "master" AddOns
function CooldownCount_Register()
	if ( Cosmos_RegisterConfiguration ) then
		CooldownCount_Register_Cosmos();
	else
		SlashCmdList["COOLDOWNCOUNTSLASHMAIN"] = CooldownCount_Main_ChatCommandHandler;
		SLASH_COOLDOWNCOUNTSLASHMAIN1 = "/cooldowncount";
		SLASH_COOLDOWNCOUNTSLASHMAIN2 = "/cc";
		--[[
		SlashCmdList["COOLDOWNCOUNTSLASHENABLE"] = CooldownCount_Enable_ChatCommandHandler;
		SLASH_COOLDOWNCOUNTSLASHENABLE1 = "/cooldowncountenable";
		SLASH_COOLDOWNCOUNTSLASHENABLE2 = "/ccenable";
		SLASH_COOLDOWNCOUNTSLASHENABLE3 = "/cce";
		SLASH_COOLDOWNCOUNTSLASHENABLE4 = "/cooldowncountdisable";
		SLASH_COOLDOWNCOUNTSLASHENABLE5 = "/ccdisable";
		SLASH_COOLDOWNCOUNTSLASHENABLE6 = "/ccd";
		SLASH_COOLDOWNCOUNTSLASHENABLE7 = "/cooldowncounttoggle";
		SLASH_COOLDOWNCOUNTSLASHENABLE8 = "/cctoggle";
		SLASH_COOLDOWNCOUNTSLASHENABLE9 = "/cct";
		SlashCmdList["COOLDOWNCOUNTSLASHFLASHSPEED"] = CooldownCount_FlashSpeed_ChatCommandHandler;
		SLASH_COOLDOWNCOUNTSLASHFLASHSPEED1 = "/cooldowncountflashspeed";
		SLASH_COOLDOWNCOUNTSLASHFLASHSPEED2 = "/ccflashspeed";
		SLASH_COOLDOWNCOUNTSLASHFLASHSPEED3 = "/ccfs";
		SlashCmdList["COOLDOWNCOUNTSLASHSCALE"] = CooldownCount_Scale_ChatCommandHandler;
		SLASH_COOLDOWNCOUNTSLASHSCALE1 = "/cooldowncountscale";
		SLASH_COOLDOWNCOUNTSLASHSCALE2 = "/ccscale";
		SLASH_COOLDOWNCOUNTSLASHSCALE3 = "/ccs";
		]]--
	end
	this:RegisterEvent("ACTIONBAR_PAGE_CHANGED");

	if ( Cosmos_RegisterChatCommand ) then
		local CooldownCountMainCommands = {"/cooldowncount", "/cc", "/cooldowncountenable", "/ccenable", "/cce", "/cooldowncountdisable", "/ccdisable", "/ccd","/cooldowncounttoggle","/cctoggle","/cct"};
		Cosmos_RegisterChatCommand (
			"COOLDOWNCOUNT_MAIN_COMMANDS", -- Some Unique Group ID
			CooldownCountMainCommands, -- The Commands
			CooldownCount_Main_ChatCommandHandler,
			COOLDOWNCOUNT_CHAT_COMMAND_MAIN_INFO -- Description String
		);
		--[[
		local CooldownCountEnableCommands = {"/cooldowncountenable", "/ccenable", "/cce", "/cooldowncountdisable", "/ccdisable", "/ccd","/cooldowncounttoggle","/cctoggle","/cct"};
		Cosmos_RegisterChatCommand (
			"COOLDOWNCOUNT_ENABLE_COMMANDS", -- Some Unique Group ID
			CooldownCountEnableCommands, -- The Commands
			CooldownCount_Enable_ChatCommandHandler,
			COOLDOWNCOUNT_CHAT_COMMAND_ENABLE_INFO -- Description String
		);
		local CooldownCountFlashSpeedCommands = {"/cooldowncountflashspeed", "/ccflashspeed", "/ccfs"};
		Cosmos_RegisterChatCommand (
			"COOLDOWNCOUNT_FLASHSPEED_COMMANDS", -- Some Unique Group ID
			CooldownCountFlashSpeedCommands, -- The Commands
			CooldownCount_FlashSpeed_ChatCommandHandler,
			COOLDOWNCOUNT_CHAT_COMMAND_FLASHSPEED_INFO -- Description String
		);
		local CooldownCountScaleCommands = {"/cooldowncountscale", "/ccscale", "/ccs"};
		Cosmos_RegisterChatCommand (
			"COOLDOWNCOUNT_SCALE_COMMANDS", -- Some Unique Group ID
			CooldownCountScaleCommands, -- The Commands
			CooldownCount_Scale_ChatCommandHandler,
			COOLDOWNCOUNT_CHAT_COMMAND_SCALE_INFO -- Description String
		);
		]]--
	end
end

function CooldownCount_GetChatValue(msg)
	msg = string.lower(msg);
	-- Toggle appropriately
	if ( (string.find(msg, COOLDOWNCOUNT_PARAM_ON)) or ((string.find(msg, '1')) and (not string.find(msg, '-1')) ) ) then
		return 1;
	else
		if ( (string.find(msg, COOLDOWNCOUNT_PARAM_OFF)) or (string.find(msg, '0')) ) then
			return 0;
		else
			return -1;
		end
	end
end


function CooldownCount_Enable_ChatCommandHandler(msg)
	CooldownCount_Toggle_Enabled(1);
end

function CooldownCount_Disable_ChatCommandHandler(msg)
	CooldownCount_Toggle_Enabled(0);
end

function CooldownCount_Set_ChatCommandHandler(msg)
	local value = CooldownCount_GetChatValue(msg);
	CooldownCount_Toggle_Enabled(value);
end

function CooldownCount_NoSpaces_ChatCommandHandler(msg)
	local value = CooldownCount_GetChatValue(msg);
	CooldownCount_Toggle_NoSpaces(value);
end

function CooldownCount_UseLongTimers_ChatCommandHandler(msg)
	local value = CooldownCount_GetChatValue(msg);
	CooldownCount_Toggle_UseLongTimers(value);
end

function CooldownCount_Scale_ChatCommandHandler(msg)
	local scale = nil;
	if ( msg ) and ( strlen(msg) > 0 ) then
		scale = tonumber(msg);
	end
	if ( scale ) then
		CooldownCount_SetUserScale(scale);
	else
		CooldownCount_Print(COOLDOWNCOUNT_CHAT_USERSCALE_NOT_SPECIFIED);
	end
end

function CooldownCount_Alpha_ChatCommandHandler(msg)
	local alpha = nil;
	if ( msg ) and ( strlen(msg) > 0 ) then
		alpha = tonumber(msg);
	end
	if ( alpha ) then
		CooldownCount_Set_Alpha(alpha);
	else
		CooldownCount_Print(COOLDOWNCOUNT_CHAT_ALPHA_NOT_SPECIFIED);
	end
end

function CooldownCount_HideUntilTimeLeft_ChatCommandHandler(msg)
	local timeLeft = nil;
	if ( msg ) and ( strlen(msg) > 0 ) then
		timeLeft = tonumber(msg);
	end
	if ( timeLeft ) then
		CooldownCount_SetHideUntilTimeLeft(timeLeft);
	else
		CooldownCount_Print(COOLDOWNCOUNT_CHAT_HIDEUNTILTIMELEFT_NOT_SPECIFIED);
	end
end

-- Handles chat - e.g. slashcommands - enabling/disabling the CooldownCount
function CooldownCount_FlashSpeed_ChatCommandHandler(msg)
	msg = string.lower(msg);
	
	-- Toggle appropriately
	local num = tonumber(msg);
	if ( num ) then
		CooldownCount_SetFlashSpeed(num);
	end
end

function CooldownCount_PrintUsage()
	for k, v in COOLDOWNCOUNT_SLASH_USAGE do
		CooldownCount_Print(v);
	end
end

function CooldownCount_Main_ChatCommandHandler(msg)
	local cmd, params = CooldownCount_Extract_NextParameter(msg);
	cmd = string.lower(cmd);
	if ( string.find(cmd, COOLDOWNCOUNT_SLASH_ENABLE ) ) then
		return CooldownCount_Enable_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_DISABLE ) ) then
		return CooldownCount_Disable_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_SET ) ) then
		return CooldownCount_Set_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_FLASHSPEED ) ) then
		return CooldownCount_FlashSpeed_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_SCALE ) ) then
		return CooldownCount_Scale_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_ALPHA ) ) then
		return CooldownCount_Alpha_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_NOSPACES ) ) then
		return CooldownCount_NoSpaces_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_NORMALCOLOR ) ) then
		return CooldownCount_NormalColorSetButton(true);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_FLASHCOLOR ) ) then
		return CooldownCount_FlashColorSetButton(true);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_USELONGTIMERS ) ) then
		return CooldownCount_UseLongTimers_ChatCommandHandler(params);
	elseif ( string.find(cmd, COOLDOWNCOUNT_SLASH_HIDEUNTILTIMELEFT ) ) then
		return CooldownCount_HideUntilTimeLeft_ChatCommandHandler(params);
	else
		CooldownCount_PrintUsage();
		return;
	end
end


function CooldownCount_LoadOptions()
	if ( CooldownCount_Cosmos_Registered == 0 ) then
		local value = CooldownCount_Enabled;
		if (value == nil ) then
			-- defaults to off
			value = 0;
		end
		CooldownCount_Toggle_Enabled(value);
		
		local value = CooldownCount_TimeBetweenFlashes;
		if (value == nil ) then
			value = 0.25;
		end
		CooldownCount_SetFlashSpeed(value);
		
		local value = CooldownCount_UserScale;
		if (value == nil ) then
			value = 2;
		end
		CooldownCount_SetUserScale(value);
		
		local value = CooldownCount_UseLongTimerDescriptions;
		if (value == nil ) then
			value = 1;
		end
		CooldownCount_Toggle_UseLongTimers(value);
		if ( CooldownCountOptions ) then
			CooldownCount_Set_Alpha(CooldownCountOptions.alpha);
			CooldownCount_Set_NormalColor(CooldownCountOptions.color.normal);
			CooldownCount_Set_FlashColor(CooldownCountOptions.color.flash);
		end
		local value = CooldownCount_NoSpaces;
		if ( value == nil ) then
			value = 0;
		end
		CooldownCount_Toggle_NoSpaces(value);
		local value = CooldownCount_HideUntilTimeLeft;
		if ( value == nil ) then
			value = 0;
		end
		CooldownCount_SetHideUntilTimeLeft(value);
	end
end
