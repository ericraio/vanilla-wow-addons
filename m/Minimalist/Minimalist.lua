Minimalist = AceAddon:new({
	name 			= "Minimalist",
	version			= "2.9.0",
	description 		= "Useful Tweaks and Automations for a Good Gameplay Experience",
	author			= "Grennon of Argent Dawn",
	email			= "jeramy.smith@gmail.com",
	releaseDate		= "07/18/06",
	aceCompatible		= "103",
	category		= "interface",
	db 			= AceDatabase:new("MinimalistDB"),
	defaults		= Minimalist_Defaults,
})

function Minimalist:Initialize()
  self.GetOpt = function(var) return self.db:get(self.profilePath,var) end
  self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val) end
end

function Minimalist:Enable()
  SlashCmdList["MINIMALIST"] = MinCmdHandler
  SLASH_MINIMALIST1 = "/minimalist"
  SLASH_MINIMALIST2 = "/min"
  local checkbox, func
  for _, checkbox in Minimalist_CheckButtons do
    if (self.GetOpt(checkbox.var)) then
      func = checkbox.func
      func(true)
    end
  end
  for i=1, 4 do
    local sf = getglobal("MinimalistSubFrame"..i)
    sf:SetBackdropBorderColor(0.4, 0.4, 0.4)
    sf:SetBackdropColor(0.15, 0.15, 0.15)
    getglobal("MinimalistSubFrame"..i.."Title"):SetText(getglobal("MinimalistFrameTab"..i):GetText())
  end
end

function MinCmdHandler()
  Minimalist:Show()
end

function Minimalist:Show()
  if (MinimalistFrame:IsVisible()) then return end
  local key, value, button, string, checked
  for key, value in Minimalist_CheckButtons do
    button = getglobal("MinimalistFrame_CheckButton"..value.index)
    string = getglobal("MinimalistFrame_CheckButton"..value.index.."Text")
    checked = nil
    button.disabled = nil
    if (value.var) then
      if (self.GetOpt(value.var)) then
        checked = 1
      else
        checked = 0
      end
    else
      checked = 0
    end
    OptionsFrame_EnableCheckBox(button)
    button:SetChecked(checked)
    string:SetText(key)
    button.tooltipText = value.tooltipText
  end
  MinimalistFrame:Show()
  self:TabHandler("MinimalistFrameTab1")
end

function Minimalist:CheckButton_OnClick()
  local key, value, button
  for key, value in Minimalist_CheckButtons do
    if (this:GetName() == "MinimalistFrame_CheckButton"..value.index) then
      button = getglobal("MinimalistFrame_CheckButton"..value.index)
      if (button:GetChecked()) then
        self.SetOpt(value.var, TRUE)
        if (value.func) then
          local func = value.func
          func(true)
        end
      else
        self.SetOpt(value.var, FALSE)
        if (value.func) then
          local func = value.func
          func(false)
        end
      end
    end
  end
end

function Minimalist:CheckButton_OnEnter()
  if (this.tooltipText ) then
    GameTooltip:SetOwner(this, "ANCHOR_LEFT")
    GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1)
  end
end

-- the following function is for ace hooking nils
function Minimalist:DummyFunc()
end

function Minimalist:TabHandler(tab)
  for i=1, 4 do
    if (tab == "MinimalistFrameTab"..i) then getglobal("MinimalistSubFrame"..i):Show()
    else getglobal("MinimalistSubFrame"..i):Hide() end
  end
end

-- merchant handlers
function Minimalist:MHOn()
  if (not Minimalist_Merchant_Show) then
    self:RegisterEvent("MERCHANT_SHOW", "MinMerchantHandler")
    Minimalist_Merchant_Show = true
  end
end

function Minimalist:MHOff()
  if (self.GetOpt("AUTOSELL") or self.GetOpt("AUTOREPAIR") or not Minimalist_Merchant_Show) then return end
  self:UnregisterEvent("MERCHANT_SHOW")
  Minimalist_Merchant_Show = false
end

function Minimalist:MinMerchantHandler()
  if (self.GetOpt("AUTOSELL")) then self:MinSellJunk() end
  if (CanMerchantRepair() and self.GetOpt("AUTOREPAIR")) then self:RepairHandler() end
end

-- gossip handlers
function Minimalist:GHOn()
  if (not Minimalist_Gossip_Show) then
    self:RegisterEvent("GOSSIP_SHOW", "MinGossipHandler")
    Minimalist_Gossip_Show = true
  end
end

function Minimalist:GHOff()
  if (self.GetOpt("GOSSIPSKIP") or self.GetOpt("QUESTLEVEL") or not Minimalist_Gossip_Show) then return end
  self:UnregisterEvent("GOSSIP_SHOW")
  Minimalist_Gossip_Show = false
end

function Minimalist:MinGossipHandler()
  if (self.GetOpt("QUESTLEVEL")) then self:GossipQuestLevelShow() end
  if (self.GetOpt("GOSSIPSKIP")) then self:SkipGossip() end
end

function Minimalist:SkipGossip()
  local bwl = "The orb's markings match the brand on your hand."
  local mc = "You see large cavernous tunnels"
  local t = GetGossipText()
  if (t == bwl or (strsub(t,1,31) == mc)) then
    SelectGossipOption(1)
    return
  end 
  local list = {GetGossipOptions()}
  for i = 2,getn(list),2 do
    if(list[i]=="taxi" or list[i]=="battlemaster" or list[i]=="banker") then SelectGossipOption(i/2) return end
  end
end

-- smart taxi functions 
function Minimalist:SmartTaxiOn()
  self:RegisterEvent("TAXIMAP_OPENED", "MinDisMount")
end

function Minimalist:SmartTaxiOff()
  self:UnregisterEvent("TAXIMAP_OPENED")
end

function Minimalist:MinDisMount()
  for i=0,15 do
    if GetPlayerBuffTexture(i) then
      if string.find(GetPlayerBuffTexture(i),"Mount") then CancelPlayerBuff(i) end
    end
  end
end

-- hide/unhide default UI toolbar gryphons
function Minimalist:GryphOn()
  MainMenuBarLeftEndCap:Hide()
  MainMenuBarRightEndCap:Hide()
end

function Minimalist:GryphOff()
  MainMenuBarLeftEndCap:Show()
  MainMenuBarRightEndCap:Show()
end

-- functions to display quest level
function Minimalist:MinQLOn()
  self:Hook("GetQuestLogTitle", "MinGetQuestLogTitle")
  self:RegisterEvent("QUEST_GREETING", "MinCheckQuestDetail")
  self:GHOn()
end

function Minimalist:MinQLOff()
  self:Unhook("GetQuestLogTitle")
  self:UnregisterEvent("QUEST_GREETING")
  self:GHOff()
end

-- the following MinGetQuestLogTitle is based on the method ct_questlevels uses
function Minimalist:MinGetQuestLogTitle(questIndex)
   local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = self:CallHook("GetQuestLogTitle", questIndex)
    if ( not isHeader and level ) then
        if ( questLogTitleText ) then
            questLogTitleText = "[" .. level .. "] " .. questLogTitleText
        end
    end
    return questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete
end

-- display quest level in a gossip window, inspired by AutoSelect
function Minimalist:GossipQuestLevelShow()
  local buttonindex = 1
  local list, button
  if (GetGossipAvailableQuests()) then
    list,button = {GetGossipAvailableQuests()}
    for i = 2,getn(list),2 do
      button = getglobal("GossipTitleButton"..(buttonindex))
      button:SetText(format('[%d] %s',list[i],list[i-1]))
      buttonindex = buttonindex + 1
    end
    buttonindex = buttonindex + 1
  end
  if (GetGossipActiveQuests()) then
    list,button = {GetGossipActiveQuests()}
    for i = 2,getn(list),2 do
      button = getglobal("GossipTitleButton"..(buttonindex))
      button:SetText(format('[%d] %s',list[i],list[i-1]))
      buttonindex = buttonindex + 1
    end
  end
end

-- display quest level in a quest detail window, based on AutoSelect
function Minimalist:MinCheckQuestDetail()
    local nact,navl = GetNumActiveQuests(), GetNumAvailableQuests()
    local title,level,button
    local o,GetTitle,GetLevel = 0,GetActiveTitle,GetActiveLevel
    for i = 1,nact+navl do
      if(i==nact+1) then
        o,GetTitle,GetLevel = nact,GetAvailableTitle,GetAvailableLevel
      end
      title,level = GetTitle(i-o), GetLevel(i-o)
      button = getglobal("QuestTitleButton"..i)
      button:SetText(format('[%d] %s',level,title))
    end
end


-- honor progress bar override this is my own and not based on the other mods out there
function Minimalist:MinHonorFrame_Update(updateAll)
  self:CallHook("HonorFrame_Update", updateALL)
  local RankProgress = GetPVPRankProgress()*100
  local RankProgress = string.format("%.2f", RankProgress)
  local RankProgress = " - "..RankProgress.."%"
  local oldranktext = HonorFrameCurrentPVPRank:GetText()
  HonorFrameCurrentPVPRank:SetText("("..oldranktext.." "..RankProgress..")")
  HonorFrameCurrentPVPTitle:SetPoint("TOP", "HonorFrame", "TOP", - HonorFrameCurrentPVPRank:GetWidth()/2, -83)
end

-- autorepair functions based on KC_AutoRepair by Kaelten
function Minimalist:setAmountString(amt)
    local str = ""
    local sep = " "
    local copper = mod(floor(amt + .5),      100)
    local silver = mod(floor(amt/100),       100)
    local gold   = mod(floor(amt/(100*100)), 100)
    if ( gold   > 0 ) then str = gold .. " Gold" end
    if ( silver > 0 ) then
        if ( str ~= "" ) then str = str .. sep end
        str = str .. silver .. " Silver"
    end
    if ( copper > 0 ) then
        if ( str ~= "" ) then str = str .. sep end
        str = str .. copper .. " Copper"
    end
    return str
end

function Minimalist:RepairHandler()
  local STATUS_COLOR = "|c00FFFF66"
  local equipcost = GetRepairAllCost()
  local funds = GetMoney()
  if (funds < equipcost) then Minimalist_ChatFrame:AddMessage(STATUS_COLOR.."Insufficient Funds to Repair") end
  if (funds > equipcost and equipcost > 0) then
    Minimalist_ChatFrame:AddMessage(STATUS_COLOR.."Total Repair Costs: "..self:setAmountString(equipcost))
    if (equipcost > 0) then RepairAllItems() end
  end
end

-- autosell grey junk, adapted from AutoProfit
function Minimalist:MinSellJunk()
  local bag, slot
  for bag = 0, 4 do
    if GetContainerNumSlots(bag) > 0 then
      for slot = 0, GetContainerNumSlots(bag) do
        local _, _, _, quality = GetContainerItemInfo(bag, slot)
        if (quality == 0 or quality == -1) then
          if (self:ProcessLink(GetContainerItemLink(bag, slot))) then
            PickupContainerItem(bag, slot)
            MerchantItemButton_OnClick("LeftButton")
	  end
        end
      end
    end
  end
end

function Minimalist:ProcessLink(link)
  local color
  local name
  for color, _, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
    if (color == "ff9d9d9d") then
      for i=1,table.getn(Minimalist_AutoSell_Blacklist) do
        if (name == Minimalist_AutoSell_Blacklist[i]) then return false end
      end
      return true
    end
    return false
  end
end

-- Improved Repututation Handlers and Functions
function Minimalist:MinRepOn()
  -- the next three lines display the faction text/numbers on the Rep Bar (1.10 replacement for the xpbar)
  self:RepBarSet()
  self:RegisterEvent("PLAYER_ENTERING_WORLD", "RepBarSet")
  self:RegisterEvent("UPDATE_FACTION", "RepChat_Update")
  for i=1, 15 do
    self:HookScript(getglobal("ReputationBar"..i), "OnEnter", "DummyFunc")
    self:HookScript(getglobal("ReputationBar"..i), "OnLeave", "DummyFunc")
  end 	
  self:Hook("ReputationFrame_Update", "RepFrame_Update")
end

function Minimalist:MinRepOff()
  ReputationWatchBar.cvarLocked = nil
  ReputationWatchBar.textLocked = nil
  ReputationWatchStatusBarText:Hide()
  self:UnregisterEvent("UPDATE_FACTION")
  for i=1, 15 do
    self:UnhookScript(getglobal("ReputationBar"..i), "OnEnter")
    self:UnhookScript(getglobal("ReputationBar"..i), "OnLeave")
  end 
  self:Unhook("ReputationFrame_Update")
  self:UnregisterEvent("PLAYER_ENTERING_WORLD")
  ReputationFrame_Update()
end

function Minimalist:RepBarSet()
  ReputationWatchBar.cvarLocked = 1
  ReputationWatchBar.textLocked = 1
  ReputationWatchStatusBarText:Show()
end

--based on Reputation Mod, displays the raw honor numbers on the reputation frame
function Minimalist:RepFrame_Update()
  self:CallHook("ReputationFrame_Update")
  local numFactions = GetNumFactions()
  local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
  local factionIndex, factionStanding, standingID, barValue, isHeader
  for i=1, NUM_FACTIONS_DISPLAYED, 1 do
    factionIndex = factionOffset + i
    if ( factionIndex <= numFactions ) then
      _, _, standingID, barMin, barMax, barValue, _, _, isHeader = GetFactionInfo(factionIndex)
      if ( not isHeader ) then
        factionStanding = getglobal("FACTION_STANDING_LABEL"..standingID)
        getglobal("ReputationBar"..i.."FactionStanding"):SetText( factionStanding.." - "..barValue-barMin.."/"..barMax-barMin)
      end
    end
  end
end

-- based on Rep Mod, displays faction until next standing in the combat or main chat window
local MinReps = { }
function Minimalist:RepChat_Update()
  self:RepBarSet()
  local RepRemains
  for factionIndex=1, GetNumFactions(), 1 do
    local name, _, standingID, barMin, barMax, barValue, _, _, isHeader, _ = GetFactionInfo(factionIndex)
    if ( not isHeader ) then
    if (MinReps[name]) then
      local difference = barValue - MinReps[name].Value
      if (difference > 0 and standingID ~= 8) then
        RepRemains = barMax-barValue
        Minimalist_ChatFrame:AddMessage(format("%d faction needed until %s with %s.",RepRemains,getglobal("FACTION_STANDING_LABEL"..standingID+1),name), 1.0, 1.0, 0.0)
      elseif (difference < 0 and standingID ~= 1) then
        difference=abs(difference)
        RepRemains = barValue-barMin
        Minimalist_ChatFrame:AddMessage(format("%d faction left until %s with %s.",RepRemains,getglobal("FACTION_STANDING_LABEL"..standingID-1),name), 1.0, 1.0, 0.0)
      end
      MinReps[name].Value = barValue
    else
      MinReps[name] = { }
      MinReps[name].Value = barValue
    end
    end
  end
end

--autorez function based on work from AutoRez mod, pretty simple, huh?
function Minimalist:MinAutoRez()
  if (arg1 == "Chained Spirit") then return end
  if (GetCorpseRecoveryDelay() ~= 0) then return end
  HideUIPanel(StaticPopup1)
  AcceptResurrect()
end

-- ignore duel function
function Minimalist:MinAutoDuel()
  HideUIPanel(StaticPopup1)
  CancelDuel()
end

--minimap functions based on idminimap
function Minimalist:MapLocOn()
  MinMapFrame:Show()
  MinMapFrame:SetScript("OnUpdate", MinMapLoc)
  self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "Fix_Zone")
end

function Minimalist:Fix_Zone()
local x, y = GetPlayerMapPosition("player")
if x == 0 and y == 0 then
  SetMapToCurrentZone()
end
end

function Minimalist:MapLocOff()
  MinMapLocText:SetText('')
  MinMapFrame:SetScript("OnUpdate", nil)  
  self:UnregisterEvent(" ZONE_CHANGED_NEW_AREA")
  if (not self.GetOpt("MAPSCROLL")) then MinMapFrame:Hide() end
end

function MinMapLoc()
  local x, y = GetPlayerMapPosition("player")
  if x == 0 and y == 0 then
    MinMapLocText:SetText('')
  else
    MinMapLocText:SetText(string.format('%s,%s', floor(x*100), floor(y*100)))
  end
end

function Minimalist:MapScrollOn()
  MinMapFrame:Show()
  MinMapFrame:SetScript("OnMouseWheel", MinMapZoom)
  MinMapFrame:EnableMouseWheel(1)
end

function Minimalist:MapScrollOff()
  MinMapFrame:SetScript("OnMouseWheel", nil) 
  MinMapFrame:EnableMouseWheel(FALSE)
  if (not self.GetOpt("MAPLOC")) then MinMapFrame:Hide() end
end

function MinMapZoom()
  if arg1 < 0 then
    if Minimap:GetZoom() ~= 0 then Minimap:SetZoom(Minimap:GetZoom() - 1) end
  else 
    if Minimap:GetZoom() ~= 5 then Minimap:SetZoom(Minimap:GetZoom() + 1) end
  end  
end

function Minimalist:MinMapHide()
  MinimapZoomIn:Hide()
  MinimapZoomOut:Hide()
  GameTimeFrame:Hide()
  MinimapToggleButton:Hide()
  MinimapZoneTextButton:Hide()
  MinimapBorderTop:Hide()
end

function Minimalist:MinMapShow()
  MinimapZoomIn:Show()
  MinimapZoomOut:Show()
  GameTimeFrame:Show()
  MinimapToggleButton:Show()
  MinimapZoneTextButton:Show()
  MinimapBorderTop:Show()
end

-- chat mods based on Industrial's idChat and Random's ChatScroll
function Minimalist:ChatScrollOn()
  for i = 1, 7 do
    local cf = getglobal('ChatFrame'..i)
    self:HookScript(cf, 'OnMouseWheel', 'ChatScroll')
    cf:EnableMouseWheel(1)
  end
end

function Minimalist:ChatScrollOff()
  for i = 1, 7 do
    local cf = getglobal('ChatFrame'..i)
    self:UnhookScript(cf, 'OnMouseWheel')
    cf:EnableMouseWheel(FALSE)
  end
end

function Minimalist:ChatScroll()
  self:CallScript(this, 'OnMouseWheel')
  if arg1 > 0 then
    if IsShiftKeyDown() then this:ScrollToTop() else this:ScrollUp() end
  elseif arg1 < 0 then
    if IsShiftKeyDown() then this:ScrollToBottom() else this:ScrollDown() end
  end
end

function Minimalist:ChatButtonsOn()
  if (ChatFrameMenuButton:IsVisible()) then return end
  local cf
  ChatFrameMenuButton:Show()
  for i = 1, 7 do
    cf=getglobal('ChatFrame'..i..'UpButton')
    self:UnhookScript(cf, 'OnShow')
    cf:Show()
    cf=getglobal('ChatFrame'..i..'DownButton')
    self:UnhookScript(cf, 'OnShow')
    cf:Show()
    cf=getglobal('ChatFrame'..i..'BottomButton')
    self:UnhookScript(cf, 'OnShow')
    cf:Show()
  end
end

function Minimalist:ChatButtonsOff()
  if (not ChatFrameMenuButton:IsVisible()) then return end
  local cf
  ChatFrameMenuButton:Hide()
  for i = 1, 7 do
    cf=getglobal('ChatFrame'..i..'UpButton')
    cf:Hide()
    self:HookScript(cf, 'OnShow', function() this:Hide() end)
    cf=getglobal('ChatFrame'..i..'DownButton')
    cf:Hide()
    self:HookScript(cf, 'OnShow', function() this:Hide() end)
    cf=getglobal('ChatFrame'..i..'BottomButton')
    cf:Hide()
    self:HookScript(cf, 'OnShow', function() this:Hide() end)
  end
end

function Minimalist:ChatMoveEditBox()
  local eb = VisorEditBox or ChatFrameEditBox
  eb:ClearAllPoints()
  eb:SetPoint('BOTTOMLEFT',  'ChatFrame1', 'TOPLEFT',  -5, 0)
  eb:SetPoint('BOTTOMRIGHT', 'ChatFrame1', 'TOPRIGHT', 5, 0)
end

function Minimalist:ChatRestoreEditBox()
  local eb = VisorEditBox or ChatFrameEditBox
  eb:ClearAllPoints()
  eb:SetPoint('TOPLEFT',  'ChatFrame1', 'BOTTOMLEFT',  -5, 0)
  eb:SetPoint('TOPRIGHT', 'ChatFrame1', 'BOTTOMRIGHT', 5, 0)
end

function Minimalist:ChatArrowsOn()
  local eb = VisorEditBox or ChatFrameEditBox
  eb:SetAltArrowKeyMode(false)
end

function Minimalist:ChatArrowsOff()
  local eb = VisorEditBox or ChatFrameEditBox
  eb:SetAltArrowKeyMode(enabled)
end

function Minimalist:ChatParseOn()
  if Minimalist_Chat_Parse then return end
  for i = 1, 7 do
    local cf = getglobal("ChatFrame"..i)
    self:Hook(cf, "AddMessage", function(cf, msg, r, g, b, id)
      msg = msg or ''
      r = r or ''
      g = g or ''
      b = b or ''
      id = id or nil
      if (self.GetOpt("CHATTIME")) then msg = date("%H:%M:%S").."| "..msg end
      if (self.GetOpt("CHATCLEAN")) then
        msg = string.gsub(msg, '%[Guild%]', '(G)')
        msg = string.gsub(msg, '%[Party%]', '(P)')
        msg = string.gsub(msg, '%[Raid%]', '(R)')
        msg = string.gsub(msg, '%[Raid Leader%]', '(R)')
        msg = string.gsub(msg, '%[Raid Warning%]', '(!)')
        msg = string.gsub(msg, '%[Officer%]', '(O)')
        msg = string.gsub(msg, '%[(%d)%..-%]', '(%1)')
      end
      self:CallHook(cf, "AddMessage", msg, r, g, b, id)
    end)
  end
  Minimalist_Chat_Parse = true
end

function Minimalist:ChatParseOff()
  if (self.GetOpt("CHATCLEAN") or self.GetOpt("CHATTIME") or not Minimalist_Chat_Parse) then return end
  for i=1,7 do self:Unhook(getglobal('ChatFrame'..i), 'AddMessage') end
  Minimalist_Chat_Parse = false
end

Minimalist:RegisterForLoad()
