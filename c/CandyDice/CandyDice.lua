CandyDice = AceLibrary("AceAddon-2.0"):new(
    "AceEvent-2.0","AceHook-2.0","AceDebug-2.0",
    "AceDB-2.0","AceConsole-2.0","CandyBar-2.0"
)

local cd = CandyDice
cd.revision = tonumber(string.sub("$Revision: 129 $", 12, -3))

cd.textures = {} -- they'll get registered in OnInitialize
cd.texturenames = {} -- instead of storing this I should just update the options table in RegisterTexture()

local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local function GetTable() return compost and compost:Acquire() or {} end
local function RecycleTable(t) if compost then compost:Reclaim(t) end end

cd:RegisterDB("CandyDiceDBPerChar")
cd.cmdtable = {type="group",handler=CandyDice,args = {
    timers = {
        type="group",
        name="Timers",
        desc="Commands for the ability timers",
        args = {
            show = {
                type="toggle",
                name="Show Anchor",
                desc="Show the timer anchor",
                get=function() return CandyDiceAnchorFrame:IsShown() end,
                set=function(show) if show then CandyDiceAnchorFrame:Show() else CandyDiceAnchorFrame:Hide() end end
            },
            center = {
                type="toggle",
                name="Center Timers",
                desc="Center the timer bars on the screen rather than anchoring them",
                get=function() return CandyDice.db.profile.options["center"] end,
                set="SetCentered"
            },
            enable = {
                type="toggle",
                name="Enabled",
                desc="Enable showing of ability timer bars",
                get=function() return CandyDice.db.profile.options["buffs"] end,
                set=function(v) if v then CandyDice:EnableBuffs() else CandyDice:DisableBuffs() end end
            },
            grow = {
                type="toggle",
                name="Grow Upward",
                desc="When enabled, the bars will grow upward from the anchor. Otherwise, they will grow down",
                get=function() return CandyDice.db.profile.options.grow end,
                set=function(v)
                        CandyDice:Debug(v)
                        CandyDice.db.profile.options.grow = v
                        CandyDice:UpdateGrowth()
                end
            },
            scale = {
                type="range",
                name="Scale",
                min=.1,
                max=10,
                desc="Scale factor for the timer bars",
                get=function() return CandyDice.db.profile.options.scale end,
                set=function(v)
                    CandyDice.db.profile.options.scale = v
                    CandyDice:Setup()
                end
            },
            icon = {
                type="toggle",
                name="Show Icon",
                desc="Toggle the showing of icons on timer bars",
                get=function()
                    return CandyDice.db.profile.options.icon
                end,
                set=function(v)
                    if v then 
                        CandyDice.db.profile.options.icon = true 
                    else 
                        CandyDice.db.profile.options.icon = false 
                    end
                    CandyDice:Setup()
                end,
            },
        },
    },
    cooldowns = {
        type="group",
        name="Cooldowns",
        desc="Commands for the cooldown timers",
        args = {
            show = {
                type="toggle",
                name="Show Anchor",
                desc="Show the cooldown anchor",
                get=function() return CandyDiceCooldownAnchorFrame:IsShown() end,
                set=function(show) if show then CandyDiceCooldownAnchorFrame:Show() else CandyDiceCooldownAnchorFrame:Hide() end end
            },
            enable = {
                type="toggle",
                name="Enabled",
                desc="Enable or disable cooldown scanning",
                get=function() return CandyDice.db.profile.options.cooldowns end,
                set=function(v) if v then CandyDice:EnableCooldowns() else CandyDice:DisableCooldowns() end end
            },
            grow = {
                type="toggle",
                name="Grow Upward",
                desc="When enabled, the bars will grow upward from the anchor. Otherwise, they will grow down",
                get=function() return CandyDice.db.profile.options.growcd end,
                set=function(v)
                        CandyDice:Debug(v)
                        CandyDice.db.profile.options.growcd = v;
                        CandyDice:UpdateGrowth();
                end
            },
            scale = {
                type="range",
                name="Scale",
                min=.1,
                max=10,
                desc="Scale factor for the cooldown bars",
                get=function() return CandyDice.db.profile.options.scalecd end,
                set=function(v)
                    CandyDice.db.profile.options.scalecd = v
                    CandyDice:Setup()
                end
            },
            reversed = {
                type="toggle",
                name="Reversed",
                desc="Controls whether the cooldown bars move from empty to filled or filled to empty",
                get=function()
                    return CandyDice.db.profile.options.reversecd
                end,
                set=function(v)
                    if (v) then 
                        CandyDice.db.profile.options.reversecd = true
                    else
                        CandyDice.db.profile.options.reversecd = false
                    end
                    CandyDice:Setup()
                end
            },
            icon = {
                type="toggle",
                name="Show Icon",
                desc="Toggle the showing of icons on cooldown bars",
                get=function()
                    return CandyDice.db.profile.options.iconcd
                end,
                set=function(v)
                    if v then 
                        CandyDice.db.profile.options.iconcd = true 
                    else 
                        CandyDice.db.profile.options.iconcd = false 
                    end
                    CandyDice:Setup()
                end,
            }
        },
    },
    reset = {
        type="execute",
        name="Reset Settings",
        desc="Resets all settings to the default",
        func=function() CandyDice:ResetDB("profile");CandyDice:Setup() end,
        order=5000
    },
    version = {
        type="execute",
        name="Report Version",
        desc="Prints the CandyDice version",
        func=function() CandyDice:Print(CandyDice.revision) end
    },
    texture = {
        type="text",
        name="Bar Texture",
        desc="The texture used for the Candy Bars",
        validate=CandyDice.texturenames,
        set=function(v)
            CandyDice.db.profile.options.texture = v
            CandyDice:Setup()
        end,
        get=function()
            return CandyDice.db.profile.options.texture
        end,
    }
}
}

cd.defaults = {}
cd:RegisterDefaults(
    'profile',
    {
        tracked = nil,
        options = {
            center = true, -- center the timer bars
            cooldowns = true, -- scan for cooldowns
            buffs = true, -- scan for buffs
            grow = true, -- timer bars grow vertically
            growcd = true, -- cd bars grow vertically
            scale=1,    -- timer bar scale
            scalecd=1,  -- cd bar scale
            reversecd = true, -- cooldowns count up instead of down
            iconcd = true, -- show icons in cooldowns
            icon = true, -- show icons on timers
            texture= 'Default'
        }
    }
)


local gratuity = AceLibrary("Gratuity-2.0")
local cb = CandyDice
local pc = AceLibrary("PaintChips-2.0")

cd:RegisterChatCommand({"/cd", "/cdice", "/candydice"}, CandyDice.cmdtable)

function CandyDice:OnInitialize()
    --- erase all the class/race specific defaults
    --- except the ones in the players race/class
    local _,class = UnitClass("player")
    local _,race = UnitRace("Player")
    for category, buffs in self.defaults do
        if category ~= race and category ~= class then
            self.defaults[category] = nil
        end
    end
    self:RegisterTexture('Default','Interface\\Addons\\CandyDice\\Textures\\bar.tga')
--~     self:SetDebugging(true)
    self.debugFrame = ChatFrame3
end

function CandyDice:OnEnable()
    -- CandyBar setup
    self:RegisterCandyBarGroup("CandyDice")
    self:RegisterCandyBarGroup("CandyDiceCooldowns")
    
    -- Load the class specific defaults into the profile
    local _,class = UnitClass("player")
    local _,race = UnitRace("Player")
    if not self.db.profile.tracked then
        self.db.profile.tracked = {}
        self:Print("No tracking data found, loading defaults for %s/%s", race, class)
        local classbuffs = self.defaults[class]
        if classbuffs then
            for buff, info in pairs(classbuffs) do
                self.db.profile.tracked[buff] = info
            end
        end
        local racebuffs = self.defaults[race]
        if racebuffs then
            for buff, info in pairs(self.defaults[race]) do
                self.db.profile.tracked[buff] = info
            end
        end
    end

    self:UpdateGrowth()
    
    -- Make PaintChip not suck
    self:RegisterColors()
    
    -- Scan the spellbook and create a index/icon cache
    self:RegisterEvent("SPELLS_CHANGED", "ScanSpellbook")
    self:RegisterEvent("PLAYER_PET_CHANGED", "ScanSpellbook")
    self:ScanSpellbook()
   
    -- Push the tracked buffs into the options table so they can be manipulated from the command line  
    self:PushTrackedToOptions()
    
    if self.db.profile.options.cooldowns then
        self:EnableCooldowns() -- turn on the cooldown scanning
    end
    if self.db.profile.options.buffs then
        self:EnableBuffs() -- turn on the buff scanning
    end
end

function CandyDice:OnDisable()
    -- I'm sure theres something I should do here.
end

function CandyDice:GetFuncsForBuff(buff)
    --- Creates closures that we can feed to the option table to get/set the various buff options
    local ftable = {}
    if not self.db.profile.tracked[buff] then return end
    ftable["GetFGColor"] = function()
        local c = unpack(CandyDice.db.profile.tracked[buff].colors)
        local r,g,b=unpack(pc:GetRGB(c))
        return r/255,g/255,b/255
    end
    ftable["SetFGColor"]=function(r,g,b)
        local hex = string.format("%02x%02x%02x", r*255, g*255, b*255)
        -- Stupid paintchips
        pc:RegisterHex(hex)
        CandyDice.db.profile.tracked[buff].colors[1] = hex
        self:SetCandyBarColor(buff, hex)
        self:SetCandyBarColor(buff.."CD", hex)
        
    end
    ftable["GetBGColor"]=function()
        local fg,bg= unpack(CandyDice.db.profile.tracked[buff].colors)
        local c = bg or fg
        local r,g,b=unpack(pc:GetRGB(c))
        return r/255,g/255,b/255
    end
    ftable["SetBGColor"]=function(r,g,b)
        CandyDice:Debug("R:"..tostring(r).."G:"..tostring(g).."B:"..tostring(b))
        local hex = string.format("%02x%02x%02x", r*255, g*255, b*255)
        CandyDice:Debug(hex)
        -- Stupid paintchips
        pc:RegisterHex(hex)
        CandyDice.db.profile.tracked[buff].colors[2] = hex
        cb:SetCandyBarBackgroundColor(buff, hex)
        cb:SetCandyBarBackgroundColor(buff.."CD", hex)
    end
    ftable["GetScanBuff"]= function() return CandyDice.db.profile.tracked[buff]["buff"] end
    ftable["SetScanBuff"]= function(v) 
        if (v) then CandyDice.db.profile.tracked[buff]["buff"] = true else CandyDice.db.profile.tracked[buff]["buff"]=false end
        CandyDice:StopCandyBar(buff)
    end
    ftable["GetScanCD"]= function() return CandyDice.db.profile.tracked[buff]["cooldown"] end
    ftable["SetScanCD"]= function(v) 
        if (v) then 
            CandyDice.db.profile.tracked[buff]["cooldown"] = true 
        else 
            CandyDice.db.profile.tracked[buff]["cooldown"]=false 
        end 
        CandyDice:StopCandyBar(buff.."CD")
    end
    ftable["delete"] = function()
        CandyDice.db.profile.tracked[buff] = nil
        CandyDice:UnregisterCandyBar(buff)
        CandyDice:UnregisterCandyBar(buff.."CD")
        CandyDice:PushTrackedToOptions()
    end
    return ftable
end

function CandyDice:PushTrackedToOptions()
    local header = {
        name="Abilities",
        desc="Abilities and buffs scanned",
        type="group",
        args = {
            addnew={
                type="text",
                name="Add New",
                usage="/cdice abilities addnew <ability name>",
                order=1,
                desc="Add a new ability to be tracked",
                get=false,
                set=function(v)
                    CandyDice:AddNewAbility(v)
                end,
                message="[%s]: %s has been added to tracked abilities."
            },
            spacer={
                type="header",
                order=2,
            },
        }
    }
    for buff in self.db.profile.tracked do
        if self.db.profile.tracked[buff] then
            local ftable = self:GetFuncsForBuff(buff)
            local btable = {
                name=buff,
                type="group",
                desc=buff,
                args = {
                    fgcolor= {
                        type="color",
                        name="Foreground color",
                        desc="Foreground color",
                        get=ftable["GetFGColor"],
                        set=ftable["SetFGColor"]
                    },
                    bgcolor= {
                        type="color",
                        name="Background color",
                        desc="Background color",
                        get=ftable["GetBGColor"],
                        set=ftable["SetBGColor"]  
                    },
                    scanbuff={
                        type="toggle",
                        name="Scan Buffs",
                        desc="Scan your buffs for this ability",
                        get=ftable.GetScanBuff,
                        set=ftable.SetScanBuff,
                    },
                    scancd={
                        type="toggle",
                        name="Scan Cooldowns",
                        desc="Scan for an ability cooldown",
                        get=ftable.GetScanCD,
                        set=ftable.SetScanCD,
                    },
                    delete={
                        type="execute",
                        name="Delete",
                        desc="Remove the ability from the list of tracked abilities",
                        func=ftable.delete
                    }
                }
            }
            local key = string.lower(buff)
            key = string.gsub(key, ' ', '_')
            header.args[key] = btable
        end --if self.db.profile.tracked[buff] then
    end --for buff in self.db.profile.tracked
    self.cmdtable.args["abilities"] = header
end

function CandyDice:RegisterColors()
    for buff, info in pairs(self.db.profile.tracked) do
        if info then
            local fgcolor, bgcolor = unpack(info.colors)
            if fgcolor then pc:RegisterHex(fgcolor) end
            if bgcolor then pc:RegisterHex(bgcolor) end
        end
    end
end

function CandyDice:GetTrackedIcon(name)
    --- Returns the icon to use for a tracked buff/cooldown
    local t = self.db.profile.tracked
    if t[name] and t.texture then return t.texture end
    if self.spellcache[name] then return self.spellcache[name].texture end
    return nil
end



function CandyDice:ScanSpellbook()
    -- returns a table formated with
    -- spellname - {spellIndex, texture}
    -- Only need to scan the cooldowns
    local cache = {}
    self.shoot = nil
    local p = self.db.profile
    for ii =1,MAX_SPELLS do
        local name = GetSpellName(ii, BOOKTYPE_SPELL)
        if name == BabbleSpell["Shoot"] then
            self.shoot = ii
        end
        if name and p.tracked[name] then
            local texture = GetSpellTexture(ii, BOOKTYPE_SPELL)
            cache[name] = {["id"]=ii, ["texture"]=texture, ["type"] = BOOKTYPE_SPELL}
        end
    end
    local pspellcount = HasPetSpells()
    if pspellcount then
        for ii = 1, pspellcount do
            local name = GetSpellName(ii, BOOKTYPE_PET)
            if name and p.tracked[name] then
                local texture = GetSpellTexture(ii, BOOKTYPE_PET)
                cache[name] = {["id"]=ii, ["texture"]=texture, ["type"] = BOOKTYPE_PET}
            end
        end
    end
    self.spellcache = cache
end


--~ memtrack = {
--~     calls = 0,
--~     memory = 0,
--~     time = 0,
--~ }

function CandyDice:ScanBuffs()
--~     local time = GetTime()
--~     local mem = gcinfo()
    local tracked = self.db.profile.tracked
    local cbuffs = GetTable()
    
    if self.db.profile.options.buffs then
        for ii = 0,15 do
            local bidx = GetPlayerBuff(ii, "HELPFUL")
            gratuity:SetPlayerBuff(bidx)
            local buff = gratuity:GetLine(1)
            if buff and tracked[buff] and tracked[buff].buff then
                cbuffs[buff] = buff
                self:UpdateBuff(buff, bidx, GetPlayerBuffTimeLeft(bidx))
            end
        end
    end
    for buff, info in pairs(tracked) do
        if not cbuffs[buff] then
            local registered,bartime,elapsed,running = cb:CandyBarStatus(buff)
            if running then
                cd:StopCandyBar(buff)
            end
        end
    end
    RecycleTable(cbuffs)
    
--~     memtrack.calls = memtrack.calls + 1
--~     memtrack.time = memtrack.time + (GetTime()-time)
--~     local mem2 = gcinfo()
--~     memtrack.memory = memtrack.memory + (mem2 - mem)
--~     if math.mod(memtrack.calls, 10) == 0 then
--~         self:PrintComma(memtrack.calls, memtrack.time, memtrack.memory)
--~     end
end

function CandyDice:ScanCooldowns()
    local tracked = self.db.profile.tracked
    self:Debug("Scanning Cooldowns")
    if self.db.profile.options.cooldowns then
        for buff, info in pairs(tracked) do
            if info.cooldown then
                self:UpdateCooldown(buff, info)
            end
        end
    end
end

function CandyDice:UpdateBuff(buff, bidx, bufftime)
    -- Updates a buff bar to match the state of the buff. Be prepared for bidx/bufftime to be null
    --self:Debug("Updating buff"..tostring(buff))
    local info  = self.db.profile.tracked[buff]
    if not info and info.buff then return end
    local registered,bartime,elapsed,running = cb:CandyBarStatus(buff)
    if running then
        if (not (bufftime or bidx)) or bufftime == 0 then
            cd:StopCandyBar(buff)
        else
            cd:SetCandyBarTimeLeft(buff, bufftime)
        end
    elseif bufftime and bufftime > 0 then-- bar not running, but with bufftime,so start the bar
        if not registered then
            self:Debug("Registering bar for "..buff)
            local fgcolor, bgcolor = unpack(info.colors)
            local icon = CandyDice.db.profile.options.icon and (GetPlayerBuffTexture(bidx) or GetPlayerBuffTexture(ii)) or ''
            self:RegisterTimerBar(buff, fgcolor, bgcolor, icon)
            
        end
        cb:SetCandyBarTime(buff, bufftime)
        cb:StartCandyBar(buff)
    else
        -- This would be a buff with no time, and a bar that isn't running
    end
end

function CandyDice:UpdateCooldown(ability, info, doublecheck)
    local cache = self.spellcache[ability]
    if not (cache and cache.id and cache.type) then return end --- not in the spellcache
    if not info and info.cooldown then return end -- not set for cooldown scanning, probably redundant
    local cbn = ability..'CD'
    local now = GetTime()
    local start, duration = GetSpellCooldown(cache.id, cache.type)
    local registered,bartime,elapsed,running = cb:CandyBarStatus(cbn)
    if now == start then
        --- Stealth, natures swiftness, or something else that doesn't actually start its CD until it's buff is gone.
        --- Remotely possible this could misdetect a regular cooldown.
        --- To catch any regular CDs we miss, we schedule one (just one) check 1/10th of a second from now
--~         self:Print("Skipping CD check for "..ability)
        if not doublecheck then
--~             self:Print("Doublecheck scheduled")
            self:ScheduleEvent(self.UpdateCooldown, 0.1, self, ability, info, true)
        end
        return
    end
    if not running then
        local skipdur = 1.5
        if self.shoot then
            local speed, lowDmg, hiDmg, posBuff, negBuff, percent = UnitRangedDamage("player")
            if speed > skipdur then skipdur = speed end
        end
        if duration <= skipdur then return end -- ignore global CD
        if not registered then
            self:Debug("Registering bar for "..cbn)
            local fgcolor, bgcolor = unpack(info.colors)
            self:RegisterCooldownBar(ability, fgcolor, bgcolor, cache.texture)
        end
        local left = duration - (now - start)
        self:SetCandyBarTime(cbn, duration)
        self:StartCandyBar(cbn)
        cb:SetCandyBarTimeLeft(cbn, left)
    else -- currently running, stop if CD is gone or update time if not
        if start == 0 or duration == 0 then
            self:StopCandyBar(cbn)
            return
        end
        local left = duration - (now - start)
        cb:SetCandyBarTimeLeft(cbn, left)
    end
end

-- command handlers
function CandyDice:SetCentered(v) 
    self.db.profile.options["center"] = v
    self:UpdateGrowth()
end

function CandyDice:EnableCooldowns()
    self.db.profile.options.cooldowns = true
    self:RegisterEvent("SPELL_UPDATE_COOLDOWN", "ScanCooldowns")
    self:ScanCooldowns() -- pick up any current ones
end

function CandyDice:DisableCooldowns()
    self.db.profile.options.cooldowns = false
    for cd, info in pairs(self.db.profile.tracked) do
        -- Stop all our bars.
        if info.cooldown then
            cb:UnregisterCandyBar(cd.."CD")
        end
    end
    self:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
end

function CandyDice:EnableBuffs()
    self.db.profile.options.buffs = true
    --  PLAYER_ARUAS_CHANGED only fires when you actually gain or lose a debuff,
    --  not when you re-apply one
    self:RegisterEvent("PLAYER_AURAS_CHANGED", "ScanBuffs")
    
    -- To keep the durations accurate if you re-apply a buff
    self:ScheduleRepeatingEvent("CandyDice", self.ScanBuffs, 0.3, self)
end

function CandyDice:DisableBuffs()
    self.db.profile.options.buffs = false
    for cd, info in pairs(self.db.profile.tracked) do
        -- Stop all our bars.
        if info.buff then
            cb:UnregisterCandyBar(cd)
        end
    end
    self:UnregisterEvent("PLAYER_AURAS_CHANGED")
    self:CancelScheduledEvent("CandyDice")
end

function CandyDice:UpdateGrowth()
    local o = self.db.profile.options
    if o.center then
        cb:SetCandyBarGroupPoint("CandyDice", "CENTER", "UIParent", "CENTER", 0, 0)
    else
        if (o.grow) then
            cb:SetCandyBarGroupPoint("CandyDice", "BOTTOM", "CandyDiceAnchorFrame", "TOP", 0, 0)
            cb:SetCandyBarGroupGrowth("CandyDice", true)
        else
            cb:SetCandyBarGroupPoint("CandyDice", "TOP", "CandyDiceAnchorFrame", "BOTTOM", 0, 0)
            cb:SetCandyBarGroupGrowth("CandyDice", false)
        end
    end
    if (o.growcd) then
        cb:SetCandyBarGroupPoint("CandyDiceCooldowns", "BOTTOM", "CandyDiceCooldownAnchorFrame", "TOP", 0, 0)
        cb:SetCandyBarGroupGrowth("CandyDiceCooldowns", true)
    else
        cb:SetCandyBarGroupPoint("CandyDiceCooldowns", "TOP", "CandyDiceCooldownAnchorFrame", "BOTTOM", 0, 0)
        cb:SetCandyBarGroupGrowth("CandyDiceCooldowns", false)
    end
end


function CandyDice:AddNewAbility(name)
    local info = {
        colors = {"FFFFFF"},
        buff = true,
        cooldown = true
    }
    local p = self.db.profile
    p.tracked[name] = info
    self:ScanSpellbook()
    self:UpdateCooldown(name, info)
    self:PushTrackedToOptions()
end


function CandyDice:Setup()
    -- Cheat for right now & just enable/disable
    if CandyDice:IsActive() then
        self:ToggleActive()
        self:ToggleActive()
    end
end


function CandyDice:RegisterTexture(name, file)
    self.textures[name] = file
    table.insert(self.texturenames, name)
end

function CandyDice:RegisterCooldownBar(ability, fgcolor, bgcolor, icon)
    --- register a CandyBar respecting all the CandyDice settings like show icon, texture, scaling, etc
    --- Returns the name of the bar
    local cbn = ability.."CD"
    local icon = CandyDice.db.profile.options.iconcd and icon or ''
    local o = self.db.profile.options
    local texture = self.textures[o.texture]
    -- register bar
    cb:RegisterCandyBar(cbn, 1, ability, icon)
    if fgcolor then
        cb:SetCandyBarColor(cbn, fgcolor, 0.5)
        cb:SetCandyBarBackgroundColor(cbn, bgcolor or fgcolor, 0.2)
    end
    cb:RegisterCandyBarWithGroup(cbn,"CandyDiceCooldowns")
    cb:SetCandyBarScale(cbn, o.scalecd)
    if texture then cb:SetCandyBarTexture(cbn, texture) end
    if CandyDice.db.profile.options.reversecd then
        cb:SetCandyBarReversed(cbn, true)
    end
    return cbn
end

function CandyDice:RegisterTimerBar(buff, fgcolor, bgcolor, icon)
    -- register a CandyBar respecting all the CandyDice settings for timers
    -- Returns the name of the bar
    local o = self.db.profile.options
    local icon = o.icon and icon or ''
    local texture = self.textures[o.texture]
    -- register bar
    cb:RegisterCandyBar(buff, 1, buff, icon)
    if fgcolor then 
        cb:SetCandyBarColor(buff, fgcolor, 0.5)
        cb:SetCandyBarBackgroundColor(buff, bgcolor or fgcolor, 0.2)
    end
    cb:RegisterCandyBarWithGroup(buff,"CandyDice")
    cb:SetCandyBarScale(buff, o.scale)
    if texture then cb:SetCandyBarTexture(buff, texture) end
    return buff
end
