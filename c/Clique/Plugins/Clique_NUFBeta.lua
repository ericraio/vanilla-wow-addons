--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("nuf")
Plugin.fullname = "Nurfed Unit Frames"
Plugin.url = "http://www.nurfedui.net/"

-- This plugin currently does not allow any clicks other than Left and Right 
-- on the main frames.  This is waiting for Tivoli to fix.

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
    return Nurfed_Unit_OnClick
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    self:Hook("Nurfed_Unit_OnClick", "OnClick")
end

function Plugin:OnClick(button)
    if not Clique:OnClick(button, this.unit) then
        return self.hooks.Nurfed_Unit_OnClick.orig(button)
    end
end