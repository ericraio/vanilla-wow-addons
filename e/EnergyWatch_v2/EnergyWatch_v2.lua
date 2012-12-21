ENERGYWATCH_VERSION = "EnergyWatch v2 1.4"

ENERGYWATCH_TIMER_START = 0
ENERGYWATCH_TIMER_END = 0

ENERGYWATCH_TICK_LENGTH = 2

ENERGYWATCH_ALPHA_STEP = 0.2

ENERGYWATCH_ENERGY = nil

ENERGYWATCH_STATUS = 0

ENERGYWATCH_TEXT = "Energy"

ENERGYWATCH_SOUND = ""
ENERGYWATCH_DEFAULT_SOUND = "SPELLBOOKCLOSE"

ENERGYWATCH_COMBO = 0

ENERGYWATCH_INVERT = false

ENERGYWATCH_SHOW = 0

ENERGYWATCH_SCALE = 1

ENERGYWATCH_PROFILE = ""

EnergyWatch_Save = {}

ENERGYWATCH_VARIABLES_LOADED = false

ENERGYWATCH_VARIABLE_TIMER = 0

ENERGYWATCH_SPARK_SIZE = 105;

function EnergyWatch_OnLoad()
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_MAXENERGY");

	SLASH_ENERGYWATCH1 = "/energywatch";
	SLASH_ENERGYWATCH2 = "/ew";
	SlashCmdList["ENERGYWATCH"] = function(msg)
		EnergyWatch_SlashCommandHandler(msg);
	end

	ENERGYWATCH_ENERGY = UnitMana("player");

	DEFAULT_CHAT_FRAME:AddMessage(ENERGYWATCH_VERSION.." Loaded - /ew");
end

function EnergyWatch_OnEvent(event)
	if( ENERGYWATCH_STATUS == 0 ) then
		return
	end
	
	EnergyWatch_EventHandler[event](arg1, arg2, arg3, arg4, arg5);
end

EnergyWatch_EventHandler = {}

EnergyWatch_EventHandler["UNIT_ENERGY"] = function()
	EnergyWatch_TextUpdate();
end

EnergyWatch_EventHandler["UNIT_MAXENERGY"] = function()
	EnergyWatch_TextUpdate();
end

EnergyWatch_EventHandler["PLAYER_COMBO_POINTS"] = function()
	ENERGYWATCH_COMBO = GetComboPoints();
	EnergyWatch_TextUpdate();
end

EnergyWatch_EventHandler["PLAYER_REGEN_ENABLED"] = function()
	if ENERGYWATCH_SHOW > 0 then
		EnergyWatchBar:Hide()
  else
    EnergyWatchBar:Show()
	end
end

EnergyWatch_EventHandler["PLAYER_REGEN_DISABLED"] = function()
	if ( ENERGYWATCH_SHOW ~= 3 ) then
		EnergyWatchBar:Show()
  else
    EnergyWatchBar:Hide()
	end
end

EnergyWatch_EventHandler["PLAYER_AURAS_CHANGED"] = function()
  
	if ( ENERGYWATCH_SHOW ~= 2 and ENERGYWATCH_SHOW ~= 3 ) then
		return
	end

  checkStealth()
end

function checkStealth()
	local i = 0
	while GetPlayerBuffTexture(i) ~= nil do
    -- check for rogue's stealth and druid's prowl
		if GetPlayerBuffTexture(i) == "Interface\\Icons\\Ability_Stealth" or 
          GetPlayerBuffTexture(i) == "Interface\\Icons\\Ability_Ambush" then
			EnergyWatchBar:Show()
			return
		else
			i = i + 1
		end
	end
	if not UnitAffectingCombat("player") then
		EnergyWatchBar:Hide()
	end
end

function EnergyWatch_SlashCommandHandler(msg)
	if( msg ) then
		local command = string.lower(msg);
		if( command == "on" ) then
			if( ENERGYWATCH_STATUS == 0 ) then
				ENERGYWATCH_STATUS = 1;
				EnergyWatch_Save[ENERGYWATCH_PROFILE].status = ENERGYWATCH_STATUS;
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch enabled");
				EnergyWatchBar:Show();
			end
		elseif( command == "off" ) then
			if( ENERGYWATCH_STATUS ~= 0 ) then
				ENERGYWATCH_STATUS = 0;
				EnergyWatch_Save[ENERGYWATCH_PROFILE].status = ENERGYWATCH_STATUS;
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch disabled");
				EnergyWatchBar:Hide();
			end
		elseif( command == "unlock" ) then
			if( ENERGYWATCH_STATUS ~= 2 ) then
				ENERGYWATCH_STATUS = 2;
				EnergyWatch_Save[ENERGYWATCH_PROFILE].status = ENERGYWATCH_STATUS;
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch unlocked");
			end
		elseif( command == "lock" ) then
			if( ENERGYWATCH_STATUS == 2 ) then
				ENERGYWATCH_STATUS = 1;
				EnergyWatch_Save[ENERGYWATCH_PROFILE].status = ENERGYWATCH_STATUS;
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch locked");
			end
		elseif( command == "clear" ) then
			local pn = UnitName("player");
			if(pn ~= nil and pn ~= UNKNOWNBEING and pn ~= UKNOWNBEING and pn ~= UNKNOWNOBJECT) then
				ENERGYWATCH_PROFILE = pn .. " of " .. GetCVar("RealmName");
				EnergyWatch_Save[ENERGYWATCH_PROFILE] = nil;
				ENERGYWATCH_VARIABLES_LOADED = false;
				EnergyWatch_LoadVariables(2);
			else
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch: World not yet loaded, please wait...")
			end

		elseif( string.sub(command,1,4) == "text" ) then
			if( string.len(command) > 5 ) then
				ENERGYWATCH_TEXT = string.sub(msg,6);
			else
				ENERGYWATCH_TEXT = "";
			end
			EnergyWatch_Save[ENERGYWATCH_PROFILE].text = ENERGYWATCH_TEXT;
			EnergyWatch_TextUpdate();
		elseif( string.sub(command,1,5) == "sound" ) then
			local args = string.sub(command, 7);
			if( string.len(args) > 0 ) then
				if( args == "on" ) then
					ENERGYWATCH_SOUND = ENERGYWATCH_DEFAULT_SOUND;
				elseif( args == "off" ) then
					ENERGYWATCH_SOUND = "";
				else
					ENERGYWATCH_SOUND = args;
				end
				EnergyWatch_Save[ENERGYWATCH_PROFILE].sound = ENERGYWATCH_SOUND;
			else
				if( ENERGYWATCH_SOUND == "" ) then
					DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch sound is off");
				elseif( ENERGYWATCH_SOUND == ENERGYWATCH_DEFAULT_SOUND ) then
					DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch sound is on");
				else
					DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch sound is "..ENERGYWATCH_SOUND);
				end
			end
		elseif( command == "invert" ) then
			ENERGYWATCH_INVERT = not ENERGYWATCH_INVERT;
			EnergyWatch_Save[ENERGYWATCH_PROFILE].invert = ENERGYWATCH_INVERT;
			if ENERGYWATCH_INVERT then
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch inversion on");
			else
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch inversion off");
			end
		elseif( command == "show always") then
			EnergyWatch_Save[ENERGYWATCH_PROFILE].show = 0;
			ENERGYWATCH_SHOW = EnergyWatch_Save[ENERGYWATCH_PROFILE].show
			if ENERGYWATCH_STATUS ~= 0 then
				EnergyWatchBar:Show()
			end
		elseif( command == "show combat") then
			EnergyWatch_Save[ENERGYWATCH_PROFILE].show = 1;
			ENERGYWATCH_SHOW = EnergyWatch_Save[ENERGYWATCH_PROFILE].show
			if ENERGYWATCH_STATUS ~= 0 then
				if UnitAffectingCombat("player") then
					EnerbyWatchBar:Show()
				else
					EnergyWatchBar:Hide()
				end
			end
		elseif( command == "show stealth" or command == "show stealthonly" ) then
      if ( command == "show stealth" ) then
			  EnergyWatch_Save[ENERGYWATCH_PROFILE].show = 2;
      else
  			EnergyWatch_Save[ENERGYWATCH_PROFILE].show = 3;
      end
			ENERGYWATCH_SHOW = EnergyWatch_Save[ENERGYWATCH_PROFILE].show
			local i = 0
			while GetPlayerBuffTexture(i) ~= nil do
				if GetPlayerBuffTexture(i) == "Interface\\Icons\\Ability_Stealth" then
					EnergyWatchBar:Show()
					return
				else
					i = i + 1
				end
			end
			if UnitAffectingCombat("player") then
				EnergyWatchBar:Show()
			else
				EnergyWatchBar:Hide()
			end
		elseif( string.sub(command, 1, 5) == "scale" ) then
			local scale = tonumber(string.sub(command, 7))
			if( scale <= 3.0 and scale >= 0.25 ) then
				EnergyWatch_Save[ENERGYWATCH_PROFILE].scale = scale;
				ENERGYWATCH_SCALE = scale;
				EnergyWatchBar:SetScale(ENERGYWATCH_SCALE * UIParent:GetScale());
				DEFAULT_CHAT_FRAME:AddMessage("EnergyWatch scale set to "..scale);
			else
				EnergyWatch_Help()
			end
		elseif( command == "help text" ) then
			EnergyWatch_HelpText();
		elseif( command == "help show" ) then
			EnergyWatch_HelpShow();
		else
			EnergyWatch_Help();
		end
	end
end

--function EnergyWatch_OnShow()
--	ENERGYWATCH_ENERGY = UnitMana("player");
--	ENERGYWATCH_TIMER_START = GetTime();
--	ENERGYWATCH_TIMER_END = ENERGYWATCH_TIMER_START + ENERGYWATCH_TICK_LENGTH;
--	EnergyWatchFrameStatusBar:SetMinMaxValues(ENERGYWATCH_TIMER_START, ENERGYWATCH_TIMER_END);
--	EnergyWatchFrameStatusBar:SetValue(ENERGYWATCH_TIMER_START);
--	EnergyWatchSpark:SetPoint("CENTER", "EnergyWatchFrameStatusBar", "LEFT", 0, 0);
--
--end

function EnergyWatch_OnUpdate()
	if( ENERGYWATCH_STATUS == 0 ) then
		return;
	end
	
	local Energy = UnitMana("player")
	local Status = GetTime()
	local sparkPosition = 1;
	
	
	if( Energy > ENERGYWATCH_ENERGY or Status >= ENERGYWATCH_TIMER_END) then		
		if( ENERGYWATCH_SOUND ~= "" ) then
			PlaySound(ENERGYWATCH_SOUND);
		end
		ENERGYWATCH_ENERGY = Energy;
		ENERGYWATCH_TIMER_START = Status;
		ENERGYWATCH_TIMER_END = Status + ENERGYWATCH_TICK_LENGTH;
	else
		if( ENERGYWATCH_ENERGY ~= Energy ) then
			ENERGYWATCH_ENERGY = Energy;
		end
		
		-- Edited by Mike Davis 09/22/05
		sparkPosition = ((Status - ENERGYWATCH_TIMER_START) / (ENERGYWATCH_TIMER_END - ENERGYWATCH_TIMER_START)) * ENERGYWATCH_SPARK_SIZE;
		if ENERGYWATCH_INVERT then
			sparkPosition = ENERGYWATCH_SPARK_SIZE - sparkPosition;
		end
		-- End of Edit
	end
	EnergyWatchFrameStatusBar:SetMinMaxValues(ENERGYWATCH_TIMER_START, ENERGYWATCH_TIMER_END);
	if ENERGYWATCH_INVERT then
		EnergyWatchFrameStatusBar:SetValue(ENERGYWATCH_TIMER_START + ENERGYWATCH_TIMER_END - Status);
	else
		EnergyWatchFrameStatusBar:SetValue(Status);
	end
	if( sparkPosition < 1 ) then
		sparkPosition = 1;
	end
	EnergyWatchSpark:SetPoint("CENTER", "EnergyWatchFrameStatusBar", "LEFT", sparkPosition, 0);
end

function EnergyWatch_LoadVariables(arg1)
	if ENERGYWATCH_VARIABLES_LOADED then
		return
	end

	ENERGYWATCH_VARIABLE_TIMER = ENERGYWATCH_VARIABLE_TIMER + arg1
	if ENERGYWATCH_VARIABLE_TIMER < 0.2 then
		return
	end
	ENERGYWATCH_VARIABLE_TIMER = 0;

	local playerName=UnitName("player")
	if playerName==nil or playerName==UNKNOWNBEING or playerName==UKNOWNBEING or playerName==UNKNOWNOBJECT then
		return
	end

	ENERGYWATCH_PROFILE = playerName.." of "..GetCVar("RealmName");

	if EnergyWatch_Save[ENERGYWATCH_PROFILE] == nil then
		EnergyWatch_Save[ENERGYWATCH_PROFILE] = { };
		if EW_Save ~= nil and EW_Save[ENERGYWATCH_PROFILE] ~= nil then
			if EW_Save[ENERGYWATCH_PROFILE].status ~= nil then
				EnergyWatch_Save[ENERGYWATCH_PROFILE].status = EW_Save[ENERGYWATCH_PROFILE].status;
				EW_Save[ENERGYWATCH_PROFILE].status = nil
			end
			if EW_Save[ENERGYWATCH_PROFILE].text ~= nil then
				EnergyWatch_Save[ENERGYWATCH_PROFILE].text = EW_Save[ENERGYWATCH_PROFILE].text;
				EW_Save[ENERGYWATCH_PROFILE].text = nil
			end
			if EW_Save[ENERGYWATCH_PROFILE].sound ~= nil then
				EnergyWatch_Save[ENERGYWATCH_PROFILE].sound = EW_Save[ENERGYWATCH_PROFILE].sound;
				EW_Save[ENERGYWATCH_PROFILE].sound = nil
			end
			if EW_Save[ENERGYWATCH_PROFILE] == { } then
				EW_Save[ENERGYWATCH_PROFILE] = nil;
			end
			if EW_Save == { } then
				EW_Save = nil;
			end
		end
	end

	if EnergyWatch_Save[ENERGYWATCH_PROFILE].status == nil then
		EnergyWatch_Save[ENERGYWATCH_PROFILE].status = 0;
	end
	if EnergyWatch_Save[ENERGYWATCH_PROFILE].text == nil then
		EnergyWatch_Save[ENERGYWATCH_PROFILE].text = "Energy";
	end
	if EnergyWatch_Save[ENERGYWATCH_PROFILE].sound == nil then
		EnergyWatch_Save[ENERGYWATCH_PROFILE].sound = "";
	end
	if EnergyWatch_Save[ENERGYWATCH_PROFILE].sound == nil then
		EnergyWatch_Save[ENERGYWATCH_PROFILE].invert = false;
	end
	if EnergyWatch_Save[ENERGYWATCH_PROFILE].show == nil then
		EnergyWatch_Save[ENERGYWATCH_PROFILE].show = 0;
	end
	if EnergyWatch_Save[ENERGYWATCH_PROFILE].scale == nil then
		EnergyWatch_Save[ENERGYWATCH_PROFILE].scale = 1;
	end

	ENERGYWATCH_SOUND = EnergyWatch_Save[ENERGYWATCH_PROFILE].sound;
	ENERGYWATCH_TEXT = EnergyWatch_Save[ENERGYWATCH_PROFILE].text;
	ENERGYWATCH_STATUS = EnergyWatch_Save[ENERGYWATCH_PROFILE].status;
	ENERGYWATCH_INVERT = EnergyWatch_Save[ENERGYWATCH_PROFILE].invert;
	ENERGYWATCH_SHOW = EnergyWatch_Save[ENERGYWATCH_PROFILE].show;
	ENERGYWATCH_SCALE = EnergyWatch_Save[ENERGYWATCH_PROFILE].scale;	

	EnergyWatchBar:SetScale(ENERGYWATCH_SCALE * UIParent:GetScale());

	if( ENERGYWATCH_STATUS ~= 0 ) then
		if ENERGYWATCH_SHOW == 0 then
			EnergyWatchBar:Show();
		end
	else
		EnergyWatchBar:Hide();
	end
	EnergyWatch_TextUpdate();

	ENERGYWATCH_VARIABLES_LOADED = true;
	EnergyWatch_Variable_Frame:Hide();

  checkStealth()
end

function EnergyWatch_TextUpdate()
	local ewtext = ENERGYWATCH_TEXT
	ewtext,_ = string.gsub(ewtext,"&em", UnitManaMax("player"))
	ewtext,_ = string.gsub(ewtext,"&e", UnitMana("player"))
	ewtext,_ = string.gsub(ewtext,"&c", ENERGYWATCH_COMBO)

	EnergyWatchText:SetText(ewtext);
end

function EnergyWatch_Help()
	DEFAULT_CHAT_FRAME:AddMessage(ENERGYWATCH_VERSION.." : Usage - /ew option");
	DEFAULT_CHAT_FRAME:AddMessage(" options:");
	DEFAULT_CHAT_FRAME:AddMessage("  on      : Enables EnergyWatch");
	DEFAULT_CHAT_FRAME:AddMessage("  off     : Disables EnergyWatch");
	DEFAULT_CHAT_FRAME:AddMessage("  unlock  : Allows you to move EnergyWatch");
	DEFAULT_CHAT_FRAME:AddMessage("  lock    : Locks EnergyWatch");
	DEFAULT_CHAT_FRAME:AddMessage("  sound _ : Sets Sound on/off or custom");
	DEFAULT_CHAT_FRAME:AddMessage("  invert  : Invert progress bar direction");
	DEFAULT_CHAT_FRAME:AddMessage("  scale _ : Scales EnergyWatch (0.25 - 3.0)");
	DEFAULT_CHAT_FRAME:AddMessage("  help _  : Prints help for certain options (below)");
	DEFAULT_CHAT_FRAME:AddMessage("  text _  : Sets the text on EnergyWatch");
	DEFAULT_CHAT_FRAME:AddMessage("  show _  : Set when EnergyWatch should be shown")
end

function EnergyWatch_HelpText()
	DEFAULT_CHAT_FRAME:AddMessage(ENERGYWATCH_VERSION.." : Usage - /ew text string");
	DEFAULT_CHAT_FRAME:AddMessage(" the string may contain a few special replacements:");
	DEFAULT_CHAT_FRAME:AddMessage("  &e  : Current Energy");
	DEFAULT_CHAT_FRAME:AddMessage("  &em : Maximum Energy");
	DEFAULT_CHAT_FRAME:AddMessage("  &c : Combo Points");
end

function EnergyWatch_HelpShow()
	DEFAULT_CHAT_FRAME:AddMessage(ENERGYWATCH_VERSION.." : Usage - /ew show option");
	DEFAULT_CHAT_FRAME:AddMessage(" options:");
	DEFAULT_CHAT_FRAME:AddMessage("  always  : Always shown");
	DEFAULT_CHAT_FRAME:AddMessage("  combat  : Shown in Combat");
	DEFAULT_CHAT_FRAME:AddMessage("  stealth : Shown in Combat and while Stealthed");
end
