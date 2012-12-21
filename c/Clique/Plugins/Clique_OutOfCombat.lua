--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("oocclicks")
Plugin.fullname = "Out of Combat Clicks"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
local OOC_CLICKS = "Out-of-combat"

function Plugin:OnEnable()
    Clique.db.char[OOC_CLICKS] = Clique.db.char[OOC_CLICKS] or {}
end

function Plugin:_OnClick(button, unit)
    unit = unit or Clique.unit
    
    self:LevelDebug(3, "_OnClick hook being called")
    if not UnitAffectingCombat("player") and not UnitAffectingCombat(unit) and UnitHealth(unit) then 
        Clique.set = OOC_CLICKS
        return true
    end
end