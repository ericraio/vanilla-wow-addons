--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("xraid")
Plugin.fullname = "XRaid Frames"
Plugin.url = "http://www.wowinterface.com/downloads/fileinfo.php?id=4663"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
    return XRaid
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    self:Hook(XRaid, "OnClick")
    self:Hook(XRaid, "MouseUp")
end

function Plugin:OnClick(obj, button)
	local unit = "raid"..this:GetID()
	if not Clique:OnClick(button, unit) then
		if button == "LeftButton" then
			TargetUnit(unit)
		elseif button == "RightButton" then
			Clique:UnitMenu(unit)
		end
    end
end

function Plugin:MouseUp(obj, button)
    if button == "LeftButton" and IsControlKeyDown() then
        return self.hooks[obj].MouseUp.orig(obj, button)
    elseif button == "RightButton" and IsControlKeyDown() then
        return self.hooks[obj].MouseUp.orig(obj, button)
    end
end