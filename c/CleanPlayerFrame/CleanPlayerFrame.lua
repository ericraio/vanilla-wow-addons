--
-- Clean Player Frame
--
-- by Bastian Pflieger <wb@illogical.de>
--
-- Last update: September 14, 2006
--
-- supports "myAddOns": http://www.curse-gaming.com/mod.php?addid=358
--

-- CleanPlayerFrameCombo Modes:
-- 1 - Disabled
-- 2 - Hide text
-- 3 - Show only current value

-- CleanPlayerPartyHealth Modes:
-- 1 - Disabled
-- 2 - Show numbersm
-- 3 - Show colorized numbers
-- 4 - Show colorized numbers and heal assist messages

local TextStatusBar_UpdateTextString_Org;

local FONTS = {
  { font = STANDARD_TEXT_FONT, height = 10, flags = "" },
  { font = STANDARD_TEXT_FONT, height = 10, flags = "OUTLINE" }
};

-- v = current value
-- p = percent
local TARGETFRAME_FORMAT = {
  "",
  "v",
  "p%",
  "v / p%"
}

local LowHealthWarnings = {
  ["player"] = false,
  ["party1"] = false,
  ["party2"] = false,
  ["party3"] = false,
  ["party4"] = false,
  ["target"] = false
};

local UNIT_MODELS = {
  ["player"] = "CleanPlayerFrame_PlayerModel",
  ["party1"] = "CleanPlayerFrame_Party1Model",
  ["party2"] = "CleanPlayerFrame_Party2Model",
  ["party3"] = "CleanPlayerFrame_Party3Model",
  ["party4"] = "CleanPlayerFrame_Party4Model",
  ["target"] = "CleanPlayerFrame_TargetModel"
}

local UNIT_PORTRAITS = {
  ["player"] = "PlayerPortrait",
  ["target"] = "TargetPortrait",
  ["party1"] = "PartyMemberFrame1Portrait",
  ["party2"] = "PartyMemberFrame2Portrait",
  ["party3"] = "PartyMemberFrame3Portrait",
  ["party4"] = "PartyMemberFrame4Portrait"
}


function CleanPlayerFrame_OnLoad()
  CleanPlayerFrame_Mode = 2; -- defaults to hide text
  CleanPlayerFrame_ShowPartyHealth = 2; -- defaults to show party health
  CleanPlayerFrame_ColorizeHealthBars = true;
  CleanPlayerFrame_ShowPartyPercent = false;
  CleanPlayerFrame_FontIndex = 2;
  CleanPlayerFrame_TargetFrameIndex = 4;
  CleanPlayerFrame_UseSmallFont = false;
  CleanPlayerFrame_Show3D = true;
  
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("PARTY_MEMBERS_CHANGED");
  this:RegisterEvent("PLAYER_TARGET_CHANGED");
  this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
  this:RegisterEvent("UNIT_HEALTH");
  
  TextStatusBar_UpdateTextString_Org = TextStatusBar_UpdateTextString;
  TextStatusBar_UpdateTextString = CleanPlayerFrame_TextStatusBar_UpdateTextString;

  SlashCmdList["CLEANPLAYERFRAME"] = function(msg)
    ShowUIPanel(CleanPlayerFrameOptionsFrame);
  end
  SLASH_CLEANPLAYERFRAME1 = "/cleanplayerframe";

  HealthBar_OnValueChanged_Org = HealthBar_OnValueChanged;
  HealthBar_OnValueChanged = CleanPlayerFrame_HealthBar_OnValueChanged;

  TargetFrameManaBar:SetScript("OnValueChanged", CleanPlayerFrame_TextStatusBar_UpdateTextString);
end


function CleanPlayerFrame_Setup(mode, partyHealth, formatIndex, fontIndex, colorizeHealthBars, showPartyPercent, useSmallFont, show3D)

  CleanPlayerFrame_Mode = mode;
  if mode > 1 then
    ManaBarColor[0].prefix = "";
    ManaBarColor[1].prefix = "";
    ManaBarColor[2].prefix = "";
    ManaBarColor[3].prefix = "";
    SetTextStatusBarTextPrefix(PlayerFrameHealthBar, "");
  else
    ManaBarColor[0].prefix = MANA;
    ManaBarColor[1].prefix = RAGE_POINTS;
    ManaBarColor[2].prefix = FOCUS_POINTS;
    ManaBarColor[3].prefix = ENERGY_POINTS;
    SetTextStatusBarTextPrefix(PlayerFrameHealthBar, HEALTH);
  end
  SetTextStatusBarTextPrefix(PlayerFrameManaBar, ManaBarColor[UnitPowerType("player")].prefix);
  TextStatusBar_UpdateTextString(PlayerFrameHealthBar);
  TextStatusBar_UpdateTextString(PlayerFrameManaBar);
  TextStatusBar_UpdateTextString(PetFrameHealthBar);
  TextStatusBar_UpdateTextString(PetFrameManaBar);

  CleanPlayerFrame_Show3D = show3D;
  if show3D then
    --PlayerPortrait:Hide();
    CleanPlayerFrame_PlayerModel:Show();
    CleanPlayerFrame_Update3D("player");
    --TargetPortrait:Hide();
    CleanPlayerFrame_TargetModel:Show();
    CleanPlayerFrame_Update3D("target");
    if not PartyMemberFrame1:IsVisible() then
      CleanPlayerFrame_Party1Model:ClearModel();
    end
    if not PartyMemberFrame2:IsVisible() then
      CleanPlayerFrame_Party2Model:ClearModel();
    end
    if not PartyMemberFrame3:IsVisible() then
      CleanPlayerFrame_Party3Model:ClearModel();
    end
    if not PartyMemberFrame4:IsVisible() then
      CleanPlayerFrame_Party4Model:ClearModel();
    end
    --PartyMemberFrame1Portrait:Hide();
    CleanPlayerFrame_Party1Model:Show();
    CleanPlayerFrame_Update3D("party1");
    --PartyMemberFrame2Portrait:Hide();
    CleanPlayerFrame_Party2Model:Show();
    CleanPlayerFrame_Update3D("party2");
    --PartyMemberFrame3Portrait:Hide();
    CleanPlayerFrame_Party3Model:Show();
    CleanPlayerFrame_Update3D("party3");
    --PartyMemberFrame4Portrait:Hide();
    CleanPlayerFrame_Party4Model:Show();
    CleanPlayerFrame_Update3D("party4");    
    if GetNumPartyMembers() > 0 then
      CleanPlayerFramePartyChecker:Show();
    end
  else
    CleanPlayerFramePartyChecker:Hide();
    PlayerPortrait:Show();
    TargetPortrait:Show();  
    PartyMemberFrame1Portrait:Show();
    PartyMemberFrame2Portrait:Show();
    PartyMemberFrame3Portrait:Show();
    PartyMemberFrame4Portrait:Show();
    CleanPlayerFrame_PlayerModel:Hide();
    CleanPlayerFrame_TargetModel:Hide();
    CleanPlayerFrame_Party1Model:Hide();
    CleanPlayerFrame_Party2Model:Hide();
    CleanPlayerFrame_Party3Model:Hide();
    CleanPlayerFrame_Party4Model:Hide();
  end
  
  CleanPlayerFrame_ShowPartyHealth = partyHealth;
  if not (CleanPlayerFrame_ShowPartyHealth == 1) then
    PartyMemberFrame1HealthBar.TextString = CleanPlayerFrame_PartyMemberFrame1HealthBarText;
    PartyMemberFrame2HealthBar.TextString = CleanPlayerFrame_PartyMemberFrame2HealthBarText;
    PartyMemberFrame3HealthBar.TextString = CleanPlayerFrame_PartyMemberFrame3HealthBarText;
    PartyMemberFrame4HealthBar.TextString = CleanPlayerFrame_PartyMemberFrame4HealthBarText;
    PartyMemberFrame1HealthBar.lockShow = 1;
    PartyMemberFrame2HealthBar.lockShow = 1;
    PartyMemberFrame3HealthBar.lockShow = 1;
    PartyMemberFrame4HealthBar.lockShow = 1;
  else
    PartyMemberFrame1HealthBar.TextString = nil;
    PartyMemberFrame2HealthBar.TextString = nil;
    PartyMemberFrame3HealthBar.TextString = nil;
    PartyMemberFrame4HealthBar.TextString = nil;
    -- just to make sure
    CleanPlayerFrame_PartyMemberFrame1HealthBarText:Hide();
    CleanPlayerFrame_PartyMemberFrame2HealthBarText:Hide();
    CleanPlayerFrame_PartyMemberFrame3HealthBarText:Hide();
    CleanPlayerFrame_PartyMemberFrame4HealthBarText:Hide();
  end
  TextStatusBar_UpdateTextString(PartyMemberFrame1HealthBar);
  TextStatusBar_UpdateTextString(PartyMemberFrame2HealthBar);
  TextStatusBar_UpdateTextString(PartyMemberFrame3HealthBar);
  TextStatusBar_UpdateTextString(PartyMemberFrame4HealthBar);

  CleanPlayerFrame_ColorizeHealthBars = colorizeHealthBars;

  -- choose font
  CleanPlayerFrame_FontIndex = fontIndex;
  CleanPlayerFrame_PartyMember1HealthBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
  CleanPlayerFrame_PartyMember2HealthBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
  CleanPlayerFrame_PartyMember3HealthBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
  CleanPlayerFrame_PartyMember4HealthBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
  CleanPlayerFrame_TargetFrameHealthBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
  CleanPlayerFrame_TargetFrameManaBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
  -- use selected font for player frame
  CleanPlayerFrame_UseSmallFont = useSmallFont;
  if useSmallFont then
    PlayerFrameHealthBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
    PlayerFrameManaBarText:SetFont(FONTS[fontIndex].font, FONTS[fontIndex].height, FONTS[fontIndex].flags);
  else
    PlayerFrameHealthBarText:SetFont(TextStatusBarText:GetFont());
    PlayerFrameManaBarText:SetFont(TextStatusBarText:GetFont());
  end

  CleanPlayerFrame_TargetFrameIndex = formatIndex;
  if formatIndex > 1 then
    TargetFrameHealthBar.TextString = CleanPlayerFrame_TargetFrameHealthBarText;
    TargetFrameManaBar.TextString = CleanPlayerFrame_TargetFrameManaBarText;
    TargetFrameHealthBar.lockShow = 1;
    TargetFrameManaBar.lockShow = 1;
  else
    TargetFrameHealthBar.TextString = nil;
    TargetFrameManaBar.TextString = nil;
    CleanPlayerFrame_TargetFrameHealthBarText:Hide();
    CleanPlayerFrame_TargetFrameManaBarText:Hide();
  end
  TextStatusBar_UpdateTextString(TargetFrameHealthBar);
  TextStatusBar_UpdateTextString(TargetFrameManaBar);

  CleanPlayerFrame_ShowPartyPercent = showPartyPercent;
  if showPartyPercent then
    CleanPlayerFrame_PartyMember1HealthBarText:Show();
    CleanPlayerFrame_PartyMember2HealthBarText:Show();
    CleanPlayerFrame_PartyMember3HealthBarText:Show();
    CleanPlayerFrame_PartyMember4HealthBarText:Show();
  else
    CleanPlayerFrame_PartyMember1HealthBarText:Hide();
    CleanPlayerFrame_PartyMember2HealthBarText:Hide();
    CleanPlayerFrame_PartyMember3HealthBarText:Hide();
    CleanPlayerFrame_PartyMember4HealthBarText:Hide();
  end
  TextStatusBar_UpdateTextString(PartyMemberFrame1HealthBar);
  TextStatusBar_UpdateTextString(PartyMemberFrame2HealthBar);
  TextStatusBar_UpdateTextString(PartyMemberFrame3HealthBar);
  TextStatusBar_UpdateTextString(PartyMemberFrame4HealthBar);
end

function CleanPlayerFrame_TextStatusBar_UpdateTextString(textStatusBar)
  TextStatusBar_UpdateTextString_Org(textStatusBar);

  if not textStatusBar then
    textStatusBar = this;
  end

  if textStatusBar.TextString == nil then
    return;
  end

  local value = textStatusBar:GetValue();
  local min, max = textStatusBar:GetMinMaxValues();
  local percent = CleanPlayerFrame_Percent(value, max);

  if CleanPlayerFrame_Mode == 3 then
    -- handle player / pet frame
    if textStatusBar == PlayerFrameHealthBar or textStatusBar == PlayerFrameManaBar
       or textStatusBar == PetFrameHealthBar or textStatusBar == PetFrameManaBar
    then
      textStatusBar.TextString:SetText(value);
    end
    -- handle party frames
    if ( textStatusBar == PartyMemberFrame1HealthBar
         or textStatusBar == PartyMemberFrame2HealthBar
         or textStatusBar == PartyMemberFrame3HealthBar
         or textStatusBar == PartyMemberFrame4HealthBar )
    then
      textStatusBar.TextString:SetText(value);
    end
  end

  --textStatusBar.TextString:GetText()
  if ( textStatusBar == PartyMemberFrame1HealthBar
       or textStatusBar == PartyMemberFrame2HealthBar
       or textStatusBar == PartyMemberFrame3HealthBar
       or textStatusBar == PartyMemberFrame4HealthBar )
  then
    -- who r we?
    local id = textStatusBar:GetParent():GetID();
    local unit = "party" .. id;
    -- show percent if necessary
    if CleanPlayerFrame_ShowPartyPercent then
      getglobal("CleanPlayerFrame_PartyMember" .. id .. "HealthBarText"):SetText(percent .. "%");
    end

    -- colorize text if required
    if CleanPlayerFrame_ShowPartyHealth >= 3 then
      textStatusBar.TextString:SetTextColor(CleanPlayerFrame_Colorize(percent));
    else
      textStatusBar.TextString:SetTextColor(1, 1, 1);
    end  
   
    -- add assist messages
    if CleanPlayerFrame_ShowPartyHealth == 4 and (not UnitIsDead(unit)) and (not UnitIsGhost(unit)) and UnitIsConnected(unit) then
      local _, class = UnitClass("player");
      if percent < CLEANPLAYERFRAME_MESSAGES[class].percentDanger then
        textStatusBar.TextString:SetText(textStatusBar.TextString:GetText() .. CLEANPLAYERFRAME_MESSAGES[class].danger);
      elseif percent < CLEANPLAYERFRAME_MESSAGES[class].percentWarn then
        textStatusBar.TextString:SetText(textStatusBar.TextString:GetText() .. CLEANPLAYERFRAME_MESSAGES[class].warn);
      end
    end

    --  
    if (not UnitIsConnected(unit)) or UnitIsGhost(unit) then
      textStatusBar.TextString:SetTextColor(0.5, 0.5, 0.5);
    elseif UnitIsDead(unit) then
      textStatusBar.TextString:SetTextColor(1, 0.3, 0.3);
    end
  end

  -- handle target frame
  if textStatusBar == TargetFrameHealthBar then
    -- automatically decide to show percent on target frame
    if max == 100 then -- not so good
      textStatusBar.TextString:SetText(value .. "%");
    else
      textStatusBar.TextString:SetText(CleanPlayerFrame_FormatOutput(CleanPlayerFrame_TargetFrameIndex, value, percent));
    end
    -- Hide when wow shows "dead" over the target health bar
    if UnitIsDead("target") then
      textStatusBar.TextString:Hide();
    else
      textStatusBar.TextString:Show();
    end
  end

  if textStatusBar == TargetFrameManaBar then
    if value > 0 then
      if UnitPowerType("target") == 0  then
        textStatusBar.TextString:SetText(CleanPlayerFrame_FormatOutput(CleanPlayerFrame_TargetFrameIndex, value, percent));
      else
        textStatusBar.TextString:SetText(value);
      end
    else
      textStatusBar.TextString:SetText("");
    end
  end
end

function CleanPlayerFrame_HealthBar_OnValueChanged(value, smooth)
  if CleanPlayerFrame_ColorizeHealthBars then
    HealthBar_OnValueChanged_Org(value, true);
  else
    HealthBar_OnValueChanged_Org(value, smooth);
  end
end

function CleanPlayerFrame_FormatOutput(index, value, percent)
  local formatString = TARGETFRAME_FORMAT[index];
  formatString = string.gsub(formatString, "v", value);
  formatString = string.gsub(formatString, "p", percent);
  return formatString;
end

function CleanPlayerFrame_Percent(value, maxValue)
  if maxValue == 0 then
    return 0;
  else
    return math.floor(value * 100 / maxValue);
  end
end

function CleanPlayerFrame_Colorize(percent)
  local r = 0;
  local g = 0;

  if percent >= 50 then
    -- red must get up to 255
    g = 1;
    r = (100 - percent) / 50;
  else
    -- green must get down to 0
    r = 1;
    g = percent / 50;
  end

  return r, g, 0;
end

function CleanPlayerFrame_Update3D(unit)
  getglobal(UNIT_MODELS[unit]):ClearModel();
  getglobal(UNIT_MODELS[unit]):SetUnit(unit);    
  getglobal(UNIT_MODELS[unit]):SetCamera(0);
  CleanPlayerFrame_SetLights3D(unit);
  if CleanPlayerFrame_IsMeshLoaded(unit) then
    getglobal(UNIT_PORTRAITS[unit]):Hide();
  else
    getglobal(UNIT_PORTRAITS[unit]):Show();
  end
end

function CleanPlayerFrame_SetLights3D(unit)
  LowHealthWarnings[unit] = false;
  if (not UnitIsConnected(unit)) or UnitIsGhost(unit) then
    getglobal(UNIT_MODELS[unit]):SetLight(1, 0, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
  elseif UnitIsDead(unit) then
    getglobal(UNIT_MODELS[unit]):SetLight(1, 0, 0, 0, 0, 1.0, 1, 0.3, 0.3);
  else
    if CleanPlayerFrame_Percent(UnitHealth(unit), UnitHealthMax(unit)) < 20 then
      LowHealthWarnings[unit] = true;      
      CleanPlayerFrameFrame:Show();
    else
      getglobal(UNIT_MODELS[unit]):SetLight(1, 0, 0, 0, 0, 1.0, 1, 1, 1);
    end
  end
end

function CleanPlayerFrame_IsMeshLoaded(unit)
  return type(getglobal(UNIT_MODELS[unit]):GetModel()) == "string";
end

function CleanPlayerFrame_LoadPartyMesh(unit)
  if not CleanPlayerFrame_IsMeshLoaded(unit) then
    CleanPlayerFrame_Update3D(unit);  
  end
end

function CleanPlayerFrame_OnEvent(event)
  if CleanPlayerFrame_Show3D then    
    if event == "PLAYER_TARGET_CHANGED" then
      CleanPlayerFrame_Update3D("target");
    elseif event == "UNIT_PORTRAIT_UPDATE" and UNIT_MODELS[arg1] then
      CleanPlayerFrame_Update3D(arg1);   
    elseif event == "UNIT_HEALTH" and UNIT_MODELS[arg1] then
      CleanPlayerFrame_SetLights3D(arg1);
    end
  end
  
  if event == "PARTY_MEMBERS_CHANGED" or event == "VARIABLES_LOADED" then
    -- party members changed && variables loaded
    if CleanPlayerFrame_Show3D and GetNumPartyMembers() > 0 then
      CleanPlayerFramePartyChecker:Show();
    else
      CleanPlayerFramePartyChecker:Hide();
    end
    CleanPlayerFrame_Setup(CleanPlayerFrame_Mode,
                          CleanPlayerFrame_ShowPartyHealth,
                          CleanPlayerFrame_TargetFrameIndex,
                          CleanPlayerFrame_FontIndex,
                          CleanPlayerFrame_ColorizeHealthBars,
                          CleanPlayerFrame_ShowPartyPercent,
                          CleanPlayerFrame_UseSmallFont,
                          CleanPlayerFrame_Show3D);
  end
end

local timer = 0;
local sign = 1;
function CleanPlayerFrame_OnUpdate(elapsed)
  -- blink if party / player is low on health and 3D is on
  timer = timer + elapsed;
  if timer > 0.5 then
    sign = -sign;
	end
	timer = mod(timer, 0.5);

  local redIntensity = 0;
	if sign == 1 then
    redIntensity = 0.7 - timer;
	else
		redIntensity = timer + 0.2;
	end  
  
  local hide = true;  
  for unit, warn in pairs(LowHealthWarnings) do
    if warn and getglobal(UNIT_MODELS[unit]):IsVisible() then
      getglobal(UNIT_MODELS[unit]):SetLight(1, 0, 0, 0, 0, 1.0, 1, redIntensity, redIntensity);
      hide = false;
    end
  end
  if hide then
    CleanPlayerFrameFrame:Hide();
  end
end

--[[
function CleanPlayerFrame_DebugParty()
  PartyMemberFrame1:Show();
  PartyMemberFrame1Disconnect:Show();
  CleanPlayerFrame_Party1Model:SetUnit("party1");
  CleanPlayerFrame_Party1Model:SetCamera(0);
  CleanPlayerFrame_Party1Model:Show()
  CleanPlayerFrame_Party1Model:SetLight(1, 0, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);

  PartyMemberFrame2:Show();
  PartyMemberFrame2Disconnect:Hide();
  CleanPlayerFrame_Party2Model:SetUnit("target");
  CleanPlayerFrame_Party2Model:SetCamera(0);
  CleanPlayerFrame_Party2Model:Show()
  CleanPlayerFrame_Party2Model:SetLight(1, 0, 0, 0, 0, 1.0, 1, 0.3, 0.3);


  PartyMemberFrame3:Show();
  PartyMemberFrame3Disconnect:Hide();
  CleanPlayerFrame_Party3Model:SetUnit("player");
  CleanPlayerFrame_Party3Model:SetCamera(0);
  CleanPlayerFrame_Party3Model:Show()


  PartyMemberFrame4:Show();
  PartyMemberFrame4Disconnect:Hide();
  CleanPlayerFrame_Party4Model:SetUnit("party1");
  CleanPlayerFrame_Party4Model:SetCamera(0);
  CleanPlayerFrame_Party4Model:Show()
  
  LowHealthWarnings["player"] = true;
  LowHealthWarnings["party1"] = true;
  LowHealthWarnings["party2"] = true;
  LowHealthWarnings["party3"] = true;
  LowHealthWarnings["party4"] = true;
  CleanPlayerFrameFrame:Show();
end

function CleanPlayerFrame_Debug2()
  if CleanPlayerFrame_IsMeshLoaded("party1") then
    ChatFrame1:AddMessage("model ist LOADED" .. CleanPlayerFrame_Party1Model:GetModel() );
  else 
    ChatFrame1:AddMessage("model ist not loaded!");
  end
end

--]]
