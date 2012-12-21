local version = "6"

local topEnable = true			-- move edit bar to top of chatframe?
local stickyEnable = true		-- enable sticky channel list?
local mouseEnable = true			-- enable the mousewheel to scroll?
local timeStamp = true			-- timestamp the incoming messages?

-- channel list...
-- SAY, YELL, EMOTE, PARTY, RAID, GUILD, OFFICER, WHISPER, CHANNEL, SYSTEM
-- CHANNEL refers to all numbered channels
local stickyList = {"OFFICER","CHANNEL"}
local unstickyList = {"YELL","EMOTE"}

local mouseScrollNum = 2			-- how many lines do you wanna scroll?


-- keep your mitts off below... =)

function tc_AddMessage(self,text,red,green,blue,alpha,hold)
  if(text) then
    tc_OldAddMessage(self,"["..date("%H:%M").."] "..text,red,green,blue,alpha,hold)
  else
    tc_OldAddMessage(self,text,red,green,blue,alpha,hold)
  end
end
function tc_ChatScroll(x)
  if(x) then
    if(x > 0) then
      for i=1,mouseScrollNum do this:ScrollUp() end
    else
      for i=1,mouseScrollNum do this:ScrollDown() end
    end
  end
end

if(topEnable) then
  ChatFrameEditBox:ClearAllPoints()
  ChatFrameEditBox:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT")
  ChatFrameEditBox:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT")
end
if(stickyEnable) then
  local z=0
  for z in stickyList do
    ChatTypeInfo[stickyList[z]].sticky = 1
  end
  for z in unstickyList do
    ChatTypeInfo[unstickyList[z]].sticky = nil
  end
end
if(mouseEnable) then
  for i=1,9 do
    if(getglobal("ChatFrame"..i)) then
      getglobal("ChatFrame"..i):EnableMouseWheel(true)
      getglobal("ChatFrame"..i):SetScript("OnMouseWheel", function() tc_ChatScroll(arg1) end)
    end
  end
end
if(timeStamp) then
  if(DEFAULT_CHAT_FRAME) then
    tc_OldAddMessage = DEFAULT_CHAT_FRAME.AddMessage
    DEFAULT_CHAT_FRAME.AddMessage = tc_AddMessage
  end
end

if(ChatFrame2) then ChatFrame2:AddMessage(":: topChat version "..version.." loaded ::",0,0.8,1.0) end
