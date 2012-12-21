--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.0"):new("Clique")
    
-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("healselect")
Plugin.fullname = "Clique Heal Selection"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
	local _,class = UnitClass("player")
	return class == "SHAMAN" or class == "PALADIN" or class == "DRUID" or class == "PRIEST"
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    
    Clique:RegisterCustomFunction("Clique:EfficientHeal()", "Clique:EfficientHeal()", "Cast Efficient Heal the unit you clicked on.")
    Clique:RegisterCustomFunction("Clique:EmergencyHeal()", "Clique:EmergencyHeal()", "Cast Emergency Heal the unit you clicked on.")
    
    local spell_lookup = {
        [L"Lesser Heal"]            = "EFFICIENT",
        [L"Heal"]                   = "EFFICIENT",
        [L"Greater Heal"]           = "EFFICIENT",
        [L"Flash Heal"]             = "EMERGENCY",
        [L"Healing Touch"]          = "EFFICIENT",
        [L"Regrowth"]               = "EMERGENCY",
        [L"Healing Wave"]           = "EFFICIENT",
        [L"Lesser Healing Wave"]    = "EMERGENCY",
        [L"Holy Light"]             = "EFFICIENT",
        [L"Flash of Light"]         = "EMERGENCY",
    }
    
    self:LevelDebug(2, "Creating a tooltip for scanning purposes")
    if not Clique.tooltip then 
		local tt = CreateFrame("GameTooltip", "CliqueTooltip", nil, "GameTooltipTemplate")
		tt:SetOwner(tt, "ANCHOR_NONE")
		tt.name = CliqueTooltipTextLeft1
		Clique.tooltip = tt
	end
    
    self:LevelDebug(2, "Removing all old spell data")
    
    local spellbook = Clique.spellbook
    spellbook.EFFICIENT = Clique:ClearTable(spellbook.EFFICIENT)
    spellbook.EMERGENCY = Clique:ClearTable(spellbook.EMERGENCY)
    
    self:LevelDebug(2, "Scanning the spellbook for heal spells")
    
    local tabs = GetNumSpellTabs()
    local name,texture,start,offset = GetSpellTabInfo(tabs)
    local numspells = start + offset
    local RANK_PATTERN = L"RANK" .. " (%d+)"
	
    self:LevelDebug(3, "Scanning " .. tabs .. " tabs for spells.")
    for i=1,numspells do
        local name,rank = GetSpellName(i, BOOKTYPE_SPELL)
		self:LevelDebug(3, "** Scanning spell id: " .. i .. " found " .. name .. ".")
		local _,_,numrank = string.find(rank, RANK_PATTERN)
		numrank = tonumber(numrank)
        
        local type = spell_lookup[name]
        if type then          
            self:LevelDebug(3, "Build a tooltip with the spell information")
            Clique.tooltip:SetSpell(i, BOOKTYPE_SPELL)
            
            self:LevelDebug(3, "Scanning for mana cost")
            
            local _,mana,min,max
            
            _,_,mana = string.find(CliqueTooltipTextLeft2:GetText(), L"MANA_PATTERN")
            
            for i=1,10 do
                local t = getglobal("CliqueTooltipTextLeft"..i)
                if not t:IsVisible() then break end
                
                _,_,min,max = string.find(t:GetText(), L"HEALTH_PATTERN")
                if min and max then
                    break
                elseif min or max then
                    self:LevelDebug(3, "Found some funky error when scanning tooltip for %s", name)
                end
            end
            
            if not (mana and min and max) then
                error("Could not properly scan tooltips.  Try reloading")
                self:LevelDebug(1, "Could not properly scan tooltip for %s", name)
            end
            
            mana,min,max = tonumber(mana),tonumber(min),tonumber(max)
            
            local t = {
                ["name"]    = name,
                ["rank"]    = tonumber(numrank),
                ["mana"]    = mana,
                ["min"]     = min,
                ["max"]     = max,
                ["amt"]     = math.floor((max + min) / 2),
                ["cast"]    = string.format("%s(%s %d)", name, L"RANK", numrank),
            }
            
            table.insert(Clique.spellbook[type], t)
        end
        
        local sort_mana = function(a,b) return a.mana < b.mana end
        table.sort(Clique.spellbook.EFFICIENT, sort_mana)
        table.sort(Clique.spellbook.EMERGENCY, sort_mana)
    end
    
    self:LevelDebug(2, "Injecting Clique:EfficientHeal() and Clique:EmergencyHeal()")
 
    local health_lookup = {
        ["DRUID"]     = {[1] = 30, [60] = 3500},
        ["MAGE"]      = {[1] = 30, [60] = 2500},
        ["HUNTER"]    = {[1] = 30, [60] = 3500},
        ["PALADIN"]   = {[1] = 30, [60] = 4000},
        ["PRIEST"]    = {[1] = 30, [60] = 2500},
        ["ROGUE"]     = {[1] = 30, [60] = 3500},
        ["SHAMAN"]    = {[1] = 30, [60] = 3800},
        ["WARLOCK"]   = {[1] = 30, [60] = 3500},
        ["WARRIOR"]   = {[1] = 30, [60] = 5000},
    }
    
    -- Returns a quick guess as to how much health a unit has, along with their predicted max health
    Clique.GuessHealth = function(self, unit)
        -- Friendly will be nil if this isn't a friendly unit
        local friendly = Clique:GetFriendlyUnit(unit)
        
        if not friendly then 

        -- This means we don't have a friendly unit id for this unit
            local _,class = UnitClass(unit)
            local slope      = (health_lookup[class][60] - health_lookup[class][1]) / 60
            local health_max = UnitLevel(unit) * slope + health_lookup[class][1]
            local health     = health_max * (UnitHealth(unit)/UnitHealthMax(unit))
            return health, health_max
        else
            -- We can get at the numbers natively
            return UnitHealth(friendly), UnitHealthMax(friendly)
        end
    end

    local SelectHeal = function(type, unit, modifier)
        self:LevelDebug(3, "SelectHeal(%s, %s, %s)", tostring(type), tostring(unit), tostring(modifier))
        if not unit then 
            self:LevelDebug(3, "Setting unit to %s", tostring(Clique.unit))
            unit = Clique.unit 
        end
        if not unit or not UnitExists(unit) then 
            error("Bad argument #2 passed to Clique:EfficientHeal, must supply a valid unitid.") 
        end
        if table.getn(Clique.spellbook[type]) == 0 then 
            self:LevelDebug(1, "No spells of type \"%s\"", type)
            return 
        end
        
        local cur_mana = UnitMana("player")
        local hp,hpmax = Clique:GuessHealth(unit)
        local deficit = hpmax - hp
        
        if modifier then
            deficit = deficit + modifier
        end
        
        if Clique.plusHealing and deficit > Clique.plusHealing then
            self:LevelDebug(3, "The deficit is larger than our plusHealing setting (current deficit is %d)", deficit)
            deficit = deficit - Clique.plusHealing
        end
                
        self:LevelDebug(3, "Got health for %s [Cur: %d, Max: %d, deficit: %d]", unit, hp, hpmax, deficit)
        
        if deficit == 0 then
            self:LevelDebug(2, "Not casting and spells.  %s is at full health.", UnitName(unit))
            return true
        end
        local num = table.getn(Clique.spellbook[type])
        
        -- Look for the first spell that will heal the unit fully
        for i,entry in Clique.spellbook[type] do
            local isbuff = Clique:IsBuff(entry.name)
            local validBuff = Clique:BuffTest(entry.name, entry.rank, unit)
            local freemana = Clique:IsBuffActive(L"FREE_INNER_FIRE")
            
            self:LevelDebug(3, "Testing rank %d with level %d", entry.rank, UnitLevel(unit))
            
            local valid = true
            if isbuff and not validBuff then
                valid = false
            end
            
            if (entry.amt >= deficit or i == num) and valid then                   
                -- We have a candidate for this spell
                if entry.mana <= cur_mana or freemana then
                    Clique:CastSpell(entry.cast)
                    self:LevelDebug(1, "Casting %s on %s for min %d", entry.cast, UnitName(unit), entry.min)
                    return true
                else
                    for k=i,1,-1 do
                        local e = Clique.spellbook[type][k]
                        if e.mana <= cur_mana then
                            Clique:CastSpell(e.cast)
                            self:LevelDebug(1, "Casting (low mana) %s on %s for avg %s", e.cast, UnitName(unit), tostring(e.amt))
                            return true
                        end
                    end
                end
            end
        end
        self:LevelDebug(2, "Could not find a suitable spell to cast for %s", type)
    end
    
    Clique.EfficientHeal = function(self, unit, modifier)
        return SelectHeal("EFFICIENT", unit, modifier)
    end
    
    Clique.EmergencyHeal = function(self, unit, modifier)
        if Clique.plusHealing then
            if not modifier then modifier = 0 end
            local plus = math.floor(Clique.plusHealing * .58)
            -- modifier makes the deficit larger, so we need to ADD
            -- the amount we're MISSING in plusHealing to modifier
            modifier = modifier + plus
        end
        return SelectHeal("EMERGENCY", unit, modifier)
    end
end