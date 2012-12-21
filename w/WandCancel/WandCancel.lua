        WandCancel = AceAddon:new({
        name          = "WandCancel",
        description   = "Cancels wand casting upon trying to cast a spell.",
        version       = "1.4",
        releaseDate   = "10-02-2005",
        aceCompatible = 102,
        author        = "Thalinon",
        email         = "bunjiro@gmail.com",
        category      = "combat",     
        db            = AceDatabase:new("WandCancelDB"),
        defaults      = DEFAULT_OPTIONS,
        cmd           = AceChatCmd:new(WANDCANCEL.COMMANDS, WANDCANCEL.CMD_OPTIONS)
        })
    
    function WandCancel:Initialize()
        self.GetOpt = function(var) return self.db:get(self.profilePath,var) end
        self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val) end
        self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end
    end
    
    function WandCancel:Enable()        
    self:RegisterEvent("START_AUTOREPEAT_SPELL")
    self:RegisterEvent("STOP_AUTOREPEAT_SPELL")
    end
    
    WandCancel:RegisterForLoad()
    
    function WandCancel:START_AUTOREPEAT_SPELL()
        self:RegisterEvent("UI_ERROR_MESSAGE","CancelWand")
    end
    
    function WandCancel:STOP_AUTOREPEAT_SPELL()
        self:UnregisterEvent("UI_ERROR_MESSAGE")
    end
    
    function WandCancel:CancelWand()
        if(string.find(arg1, "Spell is not ready yet.") or string.find(arg1, "Item is not ready yet.")) then
            SpellStopCasting()
            UIErrorsFrame:AddMessage("Wand casting has been cancelled!", 1.0, 0.1, 0.1, 1.0, 1)
        end
    end