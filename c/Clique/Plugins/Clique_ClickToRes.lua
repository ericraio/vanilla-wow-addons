--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("resurrection")
Plugin.fullname = "Click-to-resurrect"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
local DEAD_UNIT = "Click on Dead Unit"

function Plugin:Test()
	local _,class = UnitClass("player")
	return class == "SHAMAN" or class == "PALADIN" or class == "DRUID" or class == "PRIEST"
end

function Plugin:OnEnable()
    Clique.db.char[DEAD_UNIT] = Clique.db.char[DEAD_UNIT] or {}
end

function Plugin:_OnClick(button, unit)
    self:LevelDebug(3, "_OnClick hook being called")
    if UnitIsDead(unit) then
        self:LevelDebug(3, "Found that unit %s is dead.", unit)
        Clique.set = DEAD_UNIT
        return true
    end
end