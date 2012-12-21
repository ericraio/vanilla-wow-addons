--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("blizzraid")
Plugin.fullname = "Blizzard Raid Frames"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
	return RaidPullout_Update and not IsAddOnLoaded("EasyRaid")
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    self:Hook("RaidPullout_Update", "SetClicks")
    self:Hook("RaidPulloutButton_OnClick", "OnClick")
end

function Plugin:SetClicks(frame)
    self.hooks.RaidPullout_Update.orig(frame)

    if not frame then frame = this end
    for i=1,NUM_RAID_PULLOUT_FRAMES	do
        --ChatFrame1:AddMessage(string.format("Setting clicks on %d frames within %s", frame.numPulloutButtons, frame:GetName()))
        
        for j=1, frame.numPulloutButtons do
            local button = getglobal(frame:GetName().."Button"..j.."ClearButton");
            --ChatFrame1:AddMessage(string.format("Registering clicks on %s", button:GetName())) 
            button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
        end
    end
end

function Plugin:OnClick()
    local button = arg1
    local unit = this.unit
    if not Clique:OnClick(button, unit) then
        self.hooks.RaidPulloutButton_OnClick.orig(this)
   end
end