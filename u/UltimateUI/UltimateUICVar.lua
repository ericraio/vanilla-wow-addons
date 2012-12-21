
-- CVar Keywords
CSM_CVARNAME = "cvarname";
CSM_CVARVALUE= "cvarval";
CSM_CVARCALLBACK = "callback";
UUI_LAST_PLAYER = "uui_last_player";
UUI_LAST_REALM = "uui_last_realm";


UltimateUIMaster_CVars = { };
UltimateUIMaster_CVarsToRegister = { };
UltimateUIMaster_CVarsToSet = { };
UltimateUIMaster_Callbacks = { };
-- RegisterForSave('UltimateUIMaster_CVars');

-- Debug tools
ULTIMATEUIMASTER_DEBUG_CVAR = 0;
CSM_DEBUG_CVAR = "ULTIMATEUIMASTER_DEBUG_CVAR";

	--[[
		UltimateUIMaster_RegisterCVar

		Usage: 
		UltimateUIMaster_RegisterCVar(uui_cvar, [uui_defvalue, uui_callback ])

		uui_cvar is the "UUI_CVAR_NAME" you used to use. 
		uui_defvalue is the default value you're storing.
		uui_callback will be called when the cvars are loaded
		
		
	]]
function UltimateUI_RegisterCVar (uui_cvar, uui_defvalue, uui_callback)
	-- Sea.io.dprint( CSM_DEBUG_CVAR, "REGISTER: "..uui_cvar);
	
	if ( uui_cvar == nil ) then return false; end
	if ( uui_defvalue == nil) then uui_defvalue = 0; end
	if ( uui_callback ) then
		UltimateUIMaster_Callbacks[this:GetName()] = uui_callback;
	end
	
	playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT )) then
		if (UltimateUIMaster_CVarsToRegister[uui_cvar] == nil) then
			UltimateUIMaster_CVarsToRegister[uui_cvar] = uui_defvalue;
		end
		return false;
	end

	local realmname = GetCVar("realmName");
	if ( UltimateUIMaster_CVars[realmname] == nil ) then 
		UltimateUIMaster_CVars[realmname]={};
	end
	if ( UltimateUIMaster_CVars[realmname][playername] == nil ) then 
		UltimateUIMaster_CVars[realmname][playername]={};
	end
	local var = UltimateUI_GetCVar(uui_cvar);
	if (var) then
		UltimateUIMaster_CVars[realmname][playername][uui_cvar] = var;
	else
		UltimateUIMaster_CVars[realmname][playername][uui_cvar] = uui_defvalue;
	end

	return true;
end

-- The UltimateUI own 
function UltimateUI_SetCVar ( uui_cvar, uui_value)
	if ( uui_cvar == nil ) then return false; end
	if(not uui_value) then
	  uui_value = "0";
	end
	if (isTable(uui_value)) then
		-- Sea.io.dprint( CSM_DEBUG_CVAR, "SET: ",uui_cvar," table");
	else
		-- Sea.io.dprint( CSM_DEBUG_CVAR, "SET: ",uui_cvar,' ',uui_value);
	end

	playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT )) then
		UltimateUIMaster_CVarsToSet[uui_cvar] = uui_value;
		return false;
	end
	
	local realmname = GetCVar("realmName");
	if ( UltimateUIMaster_CVars[realmname] == nil ) then 
		UltimateUIMaster_CVars[realmname]={};
	end
	if ( UltimateUIMaster_CVars[realmname][playername] == nil ) then 
		UltimateUIMaster_CVars[realmname][playername]={};
	end
	UltimateUIMaster_CVars[realmname][playername][uui_cvar] = uui_value;
end

-- Fakes the GetCVar command
function UltimateUI_GetCVar ( uui_cvar )
	-- Sea.io.dprint( CSM_DEBUG_CVAR,"GET:", uui_cvar);
	if ( uui_cvar == nil ) then return nil; end

	playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT )) then return nil; end

	-- Sea.io.dprint(  CSM_DEBUG_CVAR, "GET: VALUE "..UltimateUIMaster_CVars[uui_cvar] );
	
	local realmname = GetCVar("realmName");
	--Check if variable exists on current realm/player
	if (isTable(UltimateUIMaster_CVars[realmname]) and isTable(UltimateUIMaster_CVars[realmname][playername]) and UltimateUIMaster_CVars[realmname][playername][uui_cvar]) then
		return UltimateUIMaster_CVars[realmname][playername][uui_cvar];
	end
	--Check if variable exists on last realm, current player
	if (UltimateUIMaster_LastRealm and isTable(UltimateUIMaster_CVars[UltimateUIMaster_LastRealm]) and isTable(UltimateUIMaster_CVars[UltimateUIMaster_LastRealm][playername]) and UltimateUIMaster_CVars[UltimateUIMaster_LastRealm][playername][uui_cvar]) then
		return UltimateUIMaster_CVars[UltimateUIMaster_LastRealm][playername][uui_cvar];
	end	
	--Check if variable exists on any realm, current player
	for curRealm in UltimateUIMaster_CVars do
		if (isTable(UltimateUIMaster_CVars[curRealm]) and isTable(UltimateUIMaster_CVars[curRealm][playername]) and UltimateUIMaster_CVars[curRealm][playername][uui_cvar]) then
			return UltimateUIMaster_CVars[curRealm][playername][uui_cvar];
		end	
	end
	--Check if current player exists in old format
	if (isTable(UltimateUIMaster_CVars[playername]) and UltimateUIMaster_CVars[playername][uui_cvar]) then
		return UltimateUIMaster_CVars[playername][uui_cvar];
	end	
	--Check if variable exists on last realm, last player
	if (UltimateUIMaster_LastRealm and UltimateUIMaster_LastPlayer and isTable(UltimateUIMaster_CVars[UltimateUIMaster_LastRealm]) and isTable(UltimateUIMaster_CVars[UltimateUIMaster_LastRealm][UltimateUIMaster_LastPlayer]) and UltimateUIMaster_CVars[UltimateUIMaster_LastRealm][UltimateUIMaster_LastPlayer][uui_cvar]) then
		return UltimateUIMaster_CVars[UltimateUIMaster_LastRealm][UltimateUIMaster_LastPlayer][uui_cvar];
	end	
	--Check if variable exists on cur realm, any player
	if (isTable(UltimateUIMaster_CVars[realmname])) then
		for curPlayer in UltimateUIMaster_CVars[realmname] do
			if (isTable(UltimateUIMaster_CVars[realmname][curPlayer]) and UltimateUIMaster_CVars[realmname][curPlayer][uui_cvar]) then
				return UltimateUIMaster_CVars[realmname][curPlayer][uui_cvar];
			end	
		end
	end
	--Check if variable exists on any realm, any player
	for curRealm in UltimateUIMaster_CVars do
		if (isTable(UltimateUIMaster_CVars[curRealm])) then
			for curPlayer in UltimateUIMaster_CVars[curRealm] do
				if (isTable(UltimateUIMaster_CVars[curRealm][curPlayer]) and UltimateUIMaster_CVars[curRealm][curPlayer][uui_cvar]) then
					return UltimateUIMaster_CVars[curRealm][curPlayer][uui_cvar];
				end	
			end
		end
	end	
	--Check if previous player exists in old format
	if (UltimateUIMaster_LastPlayer and isTable(UltimateUIMaster_CVars[UltimateUIMaster_LastPlayer]) and UltimateUIMaster_CVars[UltimateUIMaster_LastPlayer][uui_cvar]) then
		return UltimateUIMaster_CVars[UltimateUIMaster_LastPlayer][uui_cvar];
	end
	--Check if var exists on any player in old format
	for curPlayer in UltimateUIMaster_CVars do
		if (isTable(UltimateUIMaster_CVars[curPlayer]) and UltimateUIMaster_CVars[curPlayer][uui_cvar]) then
			return UltimateUIMaster_CVars[curPlayer][uui_cvar];
		end	
	end
	--Check if var exists in really old format
	if (UltimateUIMaster_CVars[uui_cvar]) then
		return UltimateUIMaster_CVars[uui_cvar];
	end
	--Give up
	return nil;
end

function UltimateUI_RegisterMissed ()
	playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT )) then return false;	end

	for uui_cvar, uui_defvalue in UltimateUIMaster_CVarsToRegister do
		UltimateUI_RegisterCVar(uui_cvar, uui_defvalue);
		UltimateUIMaster_CVarsToRegister[uui_cvar] = nil;
	end
	
	return true;
end

function UltimateUI_SetMissed ()
	playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT )) then return false;	end

	for uui_cvar, uui_value in UltimateUIMaster_CVarsToSet do
		UltimateUI_SetCVar(uui_cvar, uui_value);
		UltimateUIMaster_CVarsToSet[uui_cvar] = nil;
	end
	
	return true;
end

function UltimateUI_RegisterVarsLoaded (uui_callback)
	if ( uui_callback ) then
		UltimateUIMaster_Callbacks[this:GetName()] = uui_callback;
	end
end

function UltimateUI_CallVarsLoaded ()
	playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT )) then return false;	end

	for uui_mod, uui_func in UltimateUIMaster_Callbacks do
		if (uui_func) then
-----------------------------------------------------------------------
--WARNING WARNING WARNING we are chaning this so that the called-------
--function will behave normalish, but this could be dangerous----------
-----------------------------------------------------------------------
			--Store old this
			local curThis = this;
			--If we got a good something to set this to, then do it
			if (getglobal(uui_mod)) then
				this = getglobal(uui_mod);
			end
			--Call the function
			uui_func();
			--Reset this
			this = curThis;
		end
	end
	
	return true;
end

ULTIMATEUI_SETTINGS_CLASS_PREFIX = "CLASS_DEFAULT_SETTING_";

-- this saves default settings for a certain class
-- it is recommended that UltimateUIMaster_StoreVariables() is called prior to 
-- this function so that the CVars contain the latest info, but...
function UltimateUI_SaveDefaultSettingsForClass(className)
	if ( not className ) then
		className = UnitClass("player");
	end
	local playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT ) or ( not className ) ) then
		return false;
	end

	if ( UltimateUIMaster_CVars[playername] == nil ) then 
		UltimateUIMaster_CVars[playername]={};
	end
	
	local cvarIndex = ULTIMATEUI_SETTINGS_CLASS_PREFIX..className;
	
	if ( UltimateUIMaster_CVars[cvarIndex] == nil ) then 
		UltimateUIMaster_CVars[cvarIndex]={};
	end
	
	for k, v in UltimateUIMaster_CVars[playername] do
		UltimateUIMaster_CVars[cvarIndex][k] = v;
	end
	return true;
end	

-- this loads default settings for a certain class
-- it is recommended that UltimateUIMaster_LoadVariables() is called after this 
-- function so that the system contains the latest info, but...
function UltimateUI_LoadDefaultSettingsForClass(className)
	if ( not className ) then
		className = UnitClass("player");
	end
	local playername = UnitName("player");
	if (( playername == nil ) or ( playername == UKNOWNBEING ) or ( playername == UNKNOWNOBJECT ) or ( not className ) ) then
		return false;
	end

	if ( UltimateUIMaster_CVars[playername] == nil ) then 
		UltimateUIMaster_CVars[playername]={};
	end
	
	local cvarIndex = ULTIMATEUI_SETTINGS_CLASS_PREFIX..className;
	
	if ( UltimateUIMaster_CVars[cvarIndex] == nil ) then 
		UltimateUIMaster_CVars[cvarIndex]={};
	end
	
	for k, v in UltimateUIMaster_CVars[cvarIndex] do
		UltimateUIMaster_CVars[playername][k] = v;
	end
	return true;
end	

--[[
  
  Everything below this point is a helper function. 
  
  You shouldn't have to call any of these.
  
  ]]--

function PrintCvars()
	PrintTable(UltimateUIMaster_CVars, "UltimateUIMaster_CVars");
end
	
function pcv ()
	DEFAULT_CHAT_FRAME=ChatFrame1;
	PrintCvars();
end
