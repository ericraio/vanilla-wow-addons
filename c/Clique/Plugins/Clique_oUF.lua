--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("ouf")
Plugin.fullname = "Otravi Unit Frames"
Plugin.url = "http://svn.wowace.com/root/branches/otravi_UnitFrames/otravi/"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
    return oUF
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    Clique:RegisterCustomFunction("oUF.dew:Open(oUF.frames[Clique.unit])", "oUF.dew:Open(oUF.frames[Clique.unit])", "Open the oUF Options menu.")
    oUFOnClick = self.OnClick
end

-- Plugin:OnDisable() is called if the mod is enabled and its being explicitly disabled.
-- This function is optional.  If it doesn't exist, Plugin:UnregisterAllEvents() and
-- Plugin:UnregisterAllHooks().
function Plugin:Disable()
    oUFOnClick= nil
end

function Plugin.OnClick(button)
    if not Clique:OnClick(button, this.unit) then
        if button == "LeftButton" then
            TargetUnit(this.unit)
        elseif button == "RightButton" then
            Clique:UnitMenu(this.unit)
        end
    end
end