--[[ simpleMinimap ]]--

local smmVersion,smmSubversion = "14","b"
local smmInside = true
local smmSkins = {
  { square = false,
    texture = "Interface\\Minimap\\UI-Minimap-Border",
    mask = "textures\\MinimapMask",
  },
  { square = false,
    texture = nil,
    mask = "textures\\MinimapMask",
  },
  { square = true,
    texture = "Interface\\AddOns\\simpleMinimap\\skins\\SquareMinimapBorder",
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\SquareMinimapMask",
  },
  { square = true,
    texture = nil,
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\SquareMinimapMask",
  },
  { square = true,
    texture = "Interface\\AddOns\\simpleMinimap\\skins\\dLxBorder",
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\dLxMask",
  },
  { square = true,
    texture = nil,
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\dLxMask",
  },
}
local smmConst = {
  frames = {
    map = MinimapCluster,
    quest = QuestWatchFrame,
    doll = DurabilityFrame,
    timer = QuestTimerFrame,
  },
  frameDef = {
    map = { anchor = "UIParent", point = "TOPRIGHT", rpoint = "TOPRIGHT", x = 0, y = 0 },
    quest = { anchor = "MinimapCluster", point = "TOPRIGHT", rpoint = "BOTTOMRIGHT", x = 0, y = 10 },
    doll = { anchor = "MinimapCluster", point = "TOPRIGHT", rpoint = "BOTTOMRIGHT", x = 40, y = 15 },
    timer = { anchor = "MinimapCluster", point = "TOPRIGHT", rpoint = "BOTTOMRIGHT", x = 10, y = 0 },
  },
  buttons = {
    bgs = MiniMapBattlefieldFrame,
    meet = MiniMapMeetingStoneFrame,
    mail = MiniMapMailFrame,
    time = GameTimeFrame,
    track = MiniMapTrackingFrame,
    zoomin = MinimapZoomIn,
    zoomout = MinimapZoomOut,
  },
}

--[[ initialize ]]--
--
-- debug / info messages
function smm_debug(text)
  if(ChatFrame2) then ChatFrame2:AddMessage(text,0,0.8,1.0) end
end
--
-- default settings
local function smm_setDefaults()
  smmConf = nil
  smmConf = {
    version = smmVersion,
    alpha = 1,
    scale = 1,
    lock = false,
    skin = 1,
    showPings = true,
    framePos = {
      map = false,
      quest = false,
      doll = false,
      timer = false,
    },
    buttonPos = {
      bgs = 302,
      meet = 189,
      mail = 169,
      time = 137,
      track = 38,
      zoomin = 209,
      zoomout = 235,
    },
    hide = {
      location = false,
      time = false,
      zoom = false,
    },
  }
end
--
-- init & feedback for the XML load
function smm_onLoad()
  SLASH_SIMPMM1 = "/smm"
  SlashCmdList["SIMPMM"] = smm_slash
  this:RegisterEvent("PLAYER_ENTERING_WORLD")
  this:RegisterEvent("MINIMAP_PING")
  this:RegisterEvent("MINIMAP_UPDATE_ZOOM")
  smm_debug(":: simpleMinimap version "..smmVersion..smmSubversion.." loaded ::")
end
--
-- on event
function smm_onEvent()
  if(event=="MINIMAP_PING") then
    return(smm_minimapPing(arg1))
  elseif(event=="MINIMAP_UPDATE_ZOOM") then
    local z = Minimap:GetZoom()
    if (GetCVar("minimapZoom") == GetCVar("minimapInsideZoom")) then
      if (z < 3) then 
        Minimap:SetZoom(z + 1)
      else
        Minimap:SetZoom(z - 1)
      end
    else
      z = nil
    end
    if (tonumber(GetCVar("minimapInsideZoom")) == Minimap:GetZoom()) then
      smmInside = true
      MinimapCluster:SetAlpha(1)
    else
      smmInside = false
      MinimapCluster:SetAlpha(smmConf.alpha)
    end
    if(z) then Minimap:SetZoom(z) end
  elseif(event=="PLAYER_ENTERING_WORLD") then
    if(not smmConf or smmConf.version~=smmVersion) then
      smm_debug("smm :: configuration not present or outdated -- resetting")
      smm_setDefaults()
    end
    MinimapCluster:SetMovable(true)
    Minimap:RegisterForDrag("LeftButton")
    Minimap:SetScript("OnDragStart",function() smm_frameDrag(true,"map") end)
    Minimap:SetScript("OnDragStop",function() smm_frameDrag(false,"map") end)
    MinimapZoneTextButton:RegisterForDrag("LeftButton")
    MinimapZoneTextButton:SetScript("OnDragStart",function() smm_frameDrag(true,"map") end)
    MinimapZoneTextButton:SetScript("OnDragStop",function() smm_frameDrag(false,"map") end)
    for _,f in pairs(smmConst.buttons) do
      f:SetMovable(true)
      f:RegisterForDrag("LeftButton")
      f:SetScript("OnDragStart",function() smm_buttonDrag(true) end)
      f:SetScript("OnDragStop",function() smm_buttonDrag(false) end)
    end
    smm_update()
  end
end


--[[ frame events ]]--
--
-- minimap zoom
function smm_minimapZoom(x)
  if(IsShiftKeyDown()) then
    if(not smmInside) then
      local z=MinimapCluster:GetAlpha()
      if(x > 0) then
        if(z < 1) then smmConf.alpha = z + 0.05 else return end
      else
        if(z > 0) then smmConf.alpha = z - 0.05 else return end
      end
      MinimapCluster:SetAlpha(smmConf.alpha)
    end
  else
    local z=Minimap:GetZoom()
    if(x > 0) then
      if(z < Minimap:GetZoomLevels()) then z = z + 1 end
    else
     if(z > 0) then z = z - 1 end
    end
    Minimap:SetZoom(z)
  end
end
--
-- minimap ping
function smm_minimapPing(x)
  if(smmConf.showPings) then
    if(UnitName(x)==UnitName("player")) then
      MiniMapPing:EnableMouse(false)
    else
      MiniMapPing:EnableMouse(true)
      MiniMapPing:SetScript("OnEnter",function() GameTooltip:SetOwner(this,"ANCHOR_CURSOR") GameTooltip:SetText("ping by |cFFFFFFCC"..UnitName(x)) GameTooltip:Show() end)
      MiniMapPing:SetScript("OnLeave",function() GameTooltip:Hide() end)
    end
  end
end
--
-- frame drag
function smm_frameDrag(x,y)
  if(not y) then y = "map" end
  local z = smmConst.frames[y]
  if(x and not smmConf.lock) then
    z.moving = true
    z:StartMoving()
  elseif(z.moving) then
    z.moving = false
    z:StopMovingOrSizing()
    smmConf.framePos[y] = {}
    smmConf.framePos[y].x,smmConf.framePos[y].y = z:GetCenter()
    smm_update()
  end
end
--
-- button drag
function smm_buttonDrag(x)
  local function getPos()
    local cx,cy = GetCursorPosition("UIParent")
    local mx,my = Minimap:GetLeft(),Minimap:GetBottom()
    local z = Minimap:GetEffectiveScale()
    return(math.deg(math.atan2(cy/z-my-70,mx-cx/z+70)))
  end
  if(x and not smmConf.lock) then
    this.moving = true
    this:SetScript("OnUpdate",function()
      local x,y,z = 0,0,getPos()
      this:ClearAllPoints()
      if(smmSkins[smmConf.skin]["square"]) then
        x = math.max(-81,math.min(110*cos(z),81))
        y = math.max(-81,math.min(110*sin(z),81))
      else
        x = 81*cos(z)
        y = 81*sin(z)
      end
      this:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-x,y-54)
    end)
    this:StartMoving()
  elseif(this.moving) then
    this.moving = false
    this:StopMovingOrSizing()
    this:SetScript("OnUpdate",nil)
    for n,f in pairs(smmConst.buttons) do
      if(f==this) then smmConf.buttonPos[n] = getPos() end
    end
  end
end
--
-- minimap update
function smm_update()
  MinimapBorder:SetTexture(smmSkins[smmConf.skin]["texture"])
  Minimap:SetMaskTexture(smmSkins[smmConf.skin]["mask"])
  for n,f in pairs(smmConst.frames) do
    if(smmConf.framePos[n]) then
      if(not f.smmTouched) then
        f.smm_ClearAllPoints = f.ClearAllPoints
        f.smm_SetAllPoints = f.SetAllPoints
        f.smm_SetPoint = f.SetPoint
        f.ClearAllPoints = function() end
        f.SetAllPoints = function() end
        f.SetPoint = function() end
        f.smmTouched = true
      end
      f:smm_ClearAllPoints()
      f:smm_SetPoint("CENTER","UIParent","BOTTOMLEFT",smmConf.framePos[n].x,smmConf.framePos[n].y)
    else
      if(f.smmTouched) then
        f.ClearAllPoints = f.smm_ClearAllPoints
        f.SetAllPoints = f.smm_SetAllPoints
        f.SetPoint = f.smm_SetPoint
        f.smm_ClearAllPoints = nil
        f.smm_SetAllPoints = nil
        f.smm_SetPoint = nil
        f.smmTouched = nil
      end
      f:ClearAllPoints()
      f:SetPoint(smmConst.frameDef[n].point,smmConst.frameDef[n].anchor,smmConst.frameDef[n].rpoint,smmConst.frameDef[n].x,smmConst.frameDef[n].y)
    end
  end
  for n,f in pairs(smmConst.buttons) do
    if(smmConf.buttonPos[n]) then
      local x,y = 0,0
      if(smmSkins[smmConf.skin]["square"]) then
        x = math.max(-81,math.min(110*cos(smmConf.buttonPos[n]),81))
        y = math.max(-81,math.min(110*sin(smmConf.buttonPos[n]),81))
      else
        x = 81*cos(smmConf.buttonPos[n])
        y = 81*sin(smmConf.buttonPos[n])
      end
      f:ClearAllPoints()
      f:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-x,y-54)
    end
  end
  MinimapCluster:SetScale(smmConf.scale)
  if(smmConf.hide.location) then
    MinimapZoneTextButton:Disable()
    MinimapToggleButton:Disable()
    MinimapZoneTextButton:Hide()
    MinimapToggleButton:Hide()
    MinimapBorderTop:Hide()
  else
    MinimapZoneTextButton:Show()
    MinimapToggleButton:Show()
    MinimapBorderTop:Show()
    MinimapZoneTextButton:Enable()
    MinimapToggleButton:Enable()
  end
  if(smmConf.hide.time) then
    GameTimeFrame:Hide()
  else
    GameTimeFrame:Show()
  end
  if(smmConf.hide.zoom) then
    MinimapZoomIn:Disable()
    MinimapZoomOut:Disable()
    MinimapZoomIn:Hide()
    MinimapZoomOut:Hide()
  else
    MinimapZoomIn:Show()
    MinimapZoomOut:Show()
    MinimapZoomIn:Enable()
    MinimapZoomOut:Enable()
  end
  if(smmInside) then
    MinimapCluster:SetAlpha(1)
  else
    MinimapCluster:SetAlpha(smmConf.alpha)
  end
  if(smmConf.lock) then
    smm_questMover:Hide()
    smm_dollMover:Hide()
    smm_timerMover:Hide()
  else
    smm_questMover:Show()
    smm_dollMover:Show()
    smm_timerMover:Show()
  end
end


--[[ slash command handler ]]--
--
function smm_slash(x)
  local _,_,y,z = string.find(x,"(%w+)%s*(.*)")
  if(y=="hide" and smmConf.hide[z]==false) then
    smmConf.hide[z]=true
    smm_debug("smm :: hiding minimap "..z)
  elseif(y=="show" and smmConf.hide[z]) then
    smmConf.hide[z]=false
    smm_debug("smm :: showing minimap "..z)
  elseif(y=="alpha" and tonumber(z)) then
    z=tonumber(z)
    if (z<0) then z=0 elseif(z>1) then z=1 end
    smmConf.alpha = z
    smm_debug("smm :: setting minimap alpha ("..z..")")
  elseif(y=="scale" and tonumber(z)>0) then
    z=tonumber(z)
    if(smmConf.framePos.map) then
      smmConf.framePos.map.x = (smmConf.scale / z) * smmConf.framePos.map.x
      smmConf.framePos.map.y = (smmConf.scale / z) * smmConf.framePos.map.y
    end
    smmConf.scale = z
    smm_debug("smm :: setting minimap scale ("..z..")")
  elseif(y=="lock") then
    if(smmConf.lock) then
      smmConf.lock = false
      smm_debug("smm :: unlocking minimap")
    else
      smmConf.lock = true
      smm_debug("smm :: locking minimap")
    end
  elseif(y=="skin") then
    smmConf.skin = smmConf.skin + 1
    if(not smmSkins[smmConf.skin]) then smmConf.skin = 1 end
    smm_debug("smm :: changing the minimap skin ("..smmConf.skin..")")
  elseif(y=="ping") then
    if(smmConf.showPings) then
      smmConf.showPings = false
      smm_debug("smm :: turning ping tooltips off")
    else
      smmConf.showPings = true
      smm_debug("smm :: turning ping tooltips on")
    end
  elseif(y=="reset") then
    smm_setDefaults()
    smm_debug("smm :: resetting minimap")
  else
    for _,t in pairs(sm_HELP) do
      DEFAULT_CHAT_FRAME:AddMessage(t,0.9,0.8,0)
    end
    return
  end
  smm_update()
end
