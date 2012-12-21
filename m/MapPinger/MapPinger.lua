--[[

  MapPinger v0.1

  MapPinger display in chat window info about Minimap ping. Writed for control strange 
  players who **spaming** ping in raids or Battlegrounds.

  Usage:  just install addon and see to you main chat frame. When someone in you 
          group/raid except you, ping minimap, you will reñeive information message 
	  about it.
]]

function MapPinger_OnLoad()
  this:RegisterEvent("MINIMAP_PING"); 
end

function MapPinger_OnEvent()
  if (event == "MINIMAP_PING") then
    local userName = UnitName(arg1);
    if (userName ~= UnitName("player")) then
      DEFAULT_CHAT_FRAME:AddMessage((userName.." pinged minimap"), 1, 1, 0);
    end
  end
 
end