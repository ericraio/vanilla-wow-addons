--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("test")
Plugin.fullname = "Test Plugin for Clique"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
    return IsAddOnLoaded("PerfectRaid")
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    self:Debug("Enabling a module \"%s\" for %s", self.name, self.fullname)
    PerfectRaidCustomClick = self.OnClick
end

-- Plugin:OnDisable() is called if the mod is enabled and its being explicitly disabled.
-- This function is optional.  If it doesn't exist, Plugin:UnregisterAllEvents() and
-- Plugin:UnregisterAllHooks().
function Plugin:OnDisable()
    PerfectRaidCustomClick = nil
end

-- Below this line begins any custom code to make the plugin work
function Plugin.OnClick(button, unit)
    if not Clique:OnClick(button, unit) then
        if button == "LeftButton" then 
            TargetUnit(unit)
        elseif button == "RightButton" then 
            Clique:UnitMenu(unit)
        end
    end
end