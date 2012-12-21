--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("mg2-64pre")
Plugin.fullname = "Minigroup2-64Pre"
Plugin.url = "http://wow.jaslaughter.com/"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
    return MiniGroup2
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    self:Hook(MiniGroup2, "MemberOnClick")
end

local UnitFrames = {
	["MGplayer"] = "player",
	["MGpet"] = "pet",
	["MGtarget"] = "target",
	["MGraid1"] = "raid1",
	["MGtargettarget"] = "targettarget"
}

function Plugin:MemberOnClick(obj, button)
    local unit = UnitFrames[this:GetName()]
    if not Clique:OnClick(button, unit) then
        return self.hooks[obj].MemberOnClick.orig(obj, button)
    end
end