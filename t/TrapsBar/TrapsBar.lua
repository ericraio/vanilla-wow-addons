--[[

  TrapsBar for WoW (World of Warcraft)
    Desc:  A row of buttons for your Hunter's Traps

  LIST OF AUTHORS and FIXERS
  Author 1:  Permetheus with the TrapBar add-on
  Author 2:  CRiSPyToWN
   
]]--

TrapsBarData = { };

--START  
TRAP_IMMOLATION = "Immolation Trap";
TRAP_FREEZE = "Freezing Trap";
TRAP_FROST = "Frost Trap";
TRAP_EXPLO = "Explosive Trap";

if (GetLocale() == "frFR") then
  TrapsBarData = { };
	TRAP_IMMOLATION = "Pi\195\168ge d'Immolation";
	TRAP_FREEZE = "Pi\195\168ge givrant";
	TRAP_FROST = "Pi\195\168ge de givre";
	TRAP_EXPLO = "Pi\195\168ge explosif";
end
if (GetLocale() == "deDE") then
  TrapsBarData = { };
	TRAP_IMMOLATION = "Feuerbrandfalle";
	TRAP_FREEZE = "Eisk\195\164ltefalle";
	TRAP_FROST = "Frostfalle";
	TRAP_EXPLO = "Sprengfalle";
end


local Traps = {
	TRAP_IMMOLATION,
	TRAP_FREEZE,
	TRAP_FROST,
	TRAP_EXPLO,
	};

local ver = 125;

TrapsBar_ENABLED = true;

local playerName, vMounted, button;

function TrapsBar_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");

  SLASH_TRAPSBAR1 = "/trapsbar";
	SlashCmdList["TRAPSBAR"] = function(msg)
		TrapsBar_SlashHandler(string.lower(msg));
	end
end

function TrapsBar_SlashHandler(msg)
	if (string.find(msg, "config")) then
		TrapsBarConfig:Show();
	elseif (string.find(msg, "help")) then
		DEFAULT_CHAT_FRAME:AddMessage("To configure bar type '/trapsbar config'");
		DEFAULT_CHAT_FRAME:AddMessage("To move the bar: Hold down the control key and right click the TrapsBar");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Type '/trapsbar help' for help");
	end
--tinsert(UISpecialFrames,"TrapsBarConfig"); 
end

function StartTrapsBar()
	if (not TrapsBarData) then
		TrapsBarData[playerName] = {
			["hidebar"] = "false",
			["horizontal"] = "true",
			["order"] = "az",
			["scale"] = 1,
			["version"] = ver,
			["AlphaInCombat"] = 0,
			["AlphaOutCombat"] = 1,
		};
	end
	if (not TrapsBarData[playerName]) then
		TrapsBarData[playerName] = {
			["hidebar"] = "false",
			["horizontal"] = "true",
			["order"] = "az",
			["scale"] = 1,
			["version"] = ver,
			["AlphaInCombat"] = 0,
			["AlphaOutCombat"] = 1,
		};
	end
	if (TrapsBarData[playerName]["version"] ~= ver) then
		TrapsBarData[playerName]["version"] = ver;
	end
	TrapsBar_Update();
	TrapsBar_Scale();
end

function FindPattern(text,pattern)
	return string.sub(text, string.find(text, pattern))
end

function TrapsBar_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		if (UnitName("player") ~= UNKNOWNBEING and UnitName("player") ~= UNKNOWNOBJECT and UnitName("player") and not playerName) then
			playerName = UnitName("player").." of "..GetCVar("realmName");
		end
		StartTrapsBar();
	end
	if (event == "SPELLS_CHANGED" or event == "PLAYER_AURAS_CHANGED") then
		TrapsBar_Update();
	elseif (event == "SPELL_UPDATE_COOLDOWN") then
		TrapsBar_UpdateCooldowns();
	elseif (event == "PLAYER_REGEN_ENABLED") then
		TrapsBar_setAlpha();
	elseif (event == "PLAYER_REGEN_DISABLED") then
		TrapsBar_setAlpha();
  end
end

function TrapsBar_Scale()
	for i = 1, 4 do
		button = getglobal("TrapsBarButton"..i);
		button:SetScale(TrapsBarData[playerName]["scale"]);
	end
end

function TrapsBar_O()
	if (TrapsBarData[playerName]) then
		if (not TrapsBarData[playerName]["horizontal"]) then
			TrapsBarData[playerName]["horizontal"] = "true"
			TrapsBarData[playerName]["order"] = "az"			
		end
		if (TrapsBarData[playerName]["horizontal"] == "false" and TrapsBarData[playerName]["order"] == "az") then
			for i = 2, 4 do
				local button = getglobal("TrapsBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("TOP", "TrapsBarButton"..i - 1, "BOTTOM", 0, 1);
			end
		elseif (TrapsBarData[playerName]["horizontal"] == "false" and TrapsBarData[playerName]["order"] == "za") then
			for i = 2, 4 do
				local button = getglobal("TrapsBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("BOTTOM", "TrapsBarButton"..i - 1, "TOP", 0, 1);
			end
		elseif (TrapsBarData[playerName]["horizontal"] == "true" and TrapsBarData[playerName]["order"] == "az") then
			for i = 2, 4 do
				local button = getglobal("TrapsBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("LEFT", "TrapsBarButton"..i - 1, "RIGHT", 1, 0);
			end
		elseif (TrapsBarData[playerName]["horizontal"] == "true" and TrapsBarData[playerName]["order"] == "za") then
			for i = 2, 4 do
				local button = getglobal("TrapsBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("RIGHT", "TrapsBarButton"..i - 1, "LEFT", 1, 0);
			end
		else
			for i = 2, 4 do
				local button = getglobal("TrapsBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("LEFT", "TrapsBarButton"..i - 1, "RIGHT", 1, 0);
			end
		end
	end
end

function TrapsBar_Hide()
   local frame = getglobal("TrapsBar");
   if (frame) then
     if(  frame:IsVisible() ) then
       frame:Hide();
     else
       frame:Show();
     end
   end
end

function TrapsBar_Update()
	if (TrapsBarData[playerName]) then
    if (TrapsBarData[playerName]["hidebar"] == "false") then
  		TrapsBar_O();
  		i = 0;
  		for key in Traps do
  			getglobal("TrapsBarButton"..key):Hide();
  		end
  		TrapsBar:Show();
  		for key, value in Traps do
  			local id = TrapsBar_GetSpellID(value);
  			if (id) then
  			  i = i + 1;
    			button = getglobal("TrapsBarButton"..i);
    			local texture = GetSpellTexture(id, BOOKTYPE_SPELL);
    			getglobal("TrapsBarButton"..i.."Icon"):SetTexture(texture);
    			button.id = id;
    			button.texture = texture;
    			button:Show();
  			end
  		end
  		if (i == 0) then
  			TrapsBar:Hide();
  		end
    end
  end
end

function TrapsBar_UpdateCooldowns()
	for i = 1, 4 do
		button = getglobal("TrapsBarButton"..i);
		if (button.id) then
			local cooldown = getglobal(button:GetName().."Cooldown");
			local start, duration, enable = GetSpellCooldown(button.id, SpellBookFrame.bookType);
			if (start > 0 and duration > 0) then
				CooldownFrame_SetTimer(cooldown, start, duration, enable);
			end
		end
	end
end

function TrapsBar_GetSpellID(spell, rank, debug)
	local i = 1;
	local spellID;
	local highestRank;

	while true do
		local spellName, spellRank = GetSpellName(i, SpellBookFrame.bookType);
		if (not spellName) then
			break;
		end
		if (spellName == spell) then
			if (rank) then
				if (spellRank == rank) then
					if (debug) then
						DEFAULT_CHAT_FRAME:AddMessage("Found |cffffffff'"..spell.." ("..rank..")'|r at slot |cffffffff'"..i.."'", 0.1, 1.0, 0.0);
					end
					return i;
				end
			else
				spellID = i;
				highestRank = spellRank;
			end
		end
		i = i + 1;
		if (i > 400) then
			break;
		end
	end			
	if (debug) then
		DEFAULT_CHAT_FRAME:AddMessage("Could not find |cffffffff'"..spell.." ("..rank..")'", 1.0, 0.1, 0.0);
	end
	return spellID, highestRank;
end

function TrapsBar_SetTooltip()
	if (this.id) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetSpell(this.id, SpellBookFrame.bookType);
		GameTooltip:Show();
	end
end

function TrapsBar_OnClick()
	if (this.id and arg1 == "LeftButton") then
				CastSpell(this.id, BOOKTYPE_SPELL);
	end
end

function TrapsBar_OnBind(that_spell)
  local spellID = TrapsBar_GetSpellID(that_spell);
	CastSpell(spellID, BOOKTYPE_SPELL);
end

function TrapsBarGetPoint()
	local vLeft = TrapsBar:GetLeft();
	local vTop = TrapsBar:GetTop();
	TrapsBarData[playerName]["left"] = vLeft;
	TrapsBarData[playerName]["top"] = vTop;
	-- DEFAULT_CHAT_FRAME:AddMessage(vLeft.." "..vTop);
end

function TrapsBar_setAlpha()
  local frame = getglobal("TrapsBar");
  if (event == "PLAYER_REGEN_DISABLED") then
       frame:SetAlpha(TrapsBarData[playerName]["AlphaInCombat"]);
  else
       frame:SetAlpha(TrapsBarData[playerName]["AlphaOutCombat"]);
	end
end

-- CONFIG

-- OnShow
function TrapsBarConfig_OnShow()
	if (not TrapsBarData) then
		this:Hide();
		return;
	end
	if (not TrapsBarData[playerName]) then
		this:Hide();
		return;
	end
	TrapsBarConfigCheckButton1:SetChecked( TrapsBarData[playerName]["horizontal"] );
	TrapsBarConfigCheckButton2:SetChecked( TrapsBarData[playerName]["hidebar"] );	
	TrapsBarConfigSliderScale:SetValue( TrapsBarData[playerName]["scale"] );
end

function TrapsBarConfigScale_OnClick()
	TrapsBarData[playerName]["scale"] = this:GetValue();
	TrapsBar_Scale();
end

function TrapsBarConfigCheckBoxHide_OnClick()
	if (TrapsBarData[playerName]["hidebar"] == "true") then
		TrapsBarData[playerName]["hidebar"] = "false";
	else
		TrapsBarData[playerName]["hidebar"] = "true";
	end
	TrapsBar_Hide();
	TrapsBar_Update();
end

function TrapsBarConfigCheckBoxOrder_OnClick()
	if (TrapsBarData[playerName]["order"] == "az") then
		TrapsBarData[playerName]["order"] = "za";
	else
		TrapsBarData[playerName]["order"] = "az"
	end
	TrapsBar_O();
end

function TrapsBarConfigCheckBox_OnClick()
	if (TrapsBarData[playerName]["horizontal"] == "true") then
		TrapsBarData[playerName]["horizontal"] = "false";
	else
		TrapsBarData[playerName]["horizontal"] = "true"
	end
	TrapsBar_O();
end
