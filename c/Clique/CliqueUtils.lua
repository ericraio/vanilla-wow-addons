--[[---------------------------------------------------------------------------------
  This is a table of ranks, which rank of which buff spell has a required level
----------------------------------------------------------------------------------]]

local L = AceLibrary:GetInstance("AceLocale-2.0"):new("Clique")

local buff_lookup = {
    -- Buff lookups
	[L"BUFF_PWF"]            	= {1,12,24,36,48,60},
	[L"BUFF_PWS"]            	= {6,12,18,24,30,36,42,48,54,60},
	[L"BUFF_SP"]             	= {30,42,56},
	[L"BUFF_DS"]             	= {30,40,50,60},
	[L"BUFF_RENEW"]          	= {8,14,20,26,32,38,44,50,56,60},   
	[L"BUFF_MOTW"]           	= {1,10,20,30,40,50,60},
	[L"BUFF_THORNS"]         	= {6,14,24,34,44,54},
	[L"BUFF_REJUVENATION"]   	= {4,10,16,22,28,34,40,46,52,58,60},
	[L"BUFF_REGROWTH"]       	= {12,18,24,30,36,42,48,54,60},
	[L"BUFF_AI"]             	= {1,14,28,42,56},
	[L"BUFF_DM"]             	= {12,24,34,48,60},
	[L"BUFF_AM"]             	= {18,30,42,54},
	[L"BUFF_BOM"]            	= {4,12,22,32,42,52,60},
	[L"BUFF_BOP"]            	= {10,24,38},
	[L"BUFF_BOW"]            	= {14,24,34,44,54,60},
	[L"BUFF_BOS"]            	= {20,30,40,50,60},
	[L"BUFF_BOL"]            	= {40,50,60},
	[L"BUFF_BOSFC"]          	= {46,54},
}

local cure_lookup = {
    -- Cure lookups
	[L"CURE_CURE_DISEASE"]          = {"Disease"},
	[L"CURE_ABOLISH_DISEASE"]       = {"Disease"},
	[L"CURE_PURIFY"]                = {"Disease", "Poison"},
	[L"CURE_CLEANSE"]               = {"Disease", "Poison", "Magic"},
	[L"CURE_DISPEL_MAGIC"]          = {"Magic"},
	[L"CURE_CURE_POISON"]           = {"Poison"},
	[L"CURE_ABOLISH_POISON"]        = {"Poison"},
	[L"CURE_REMOVE_LESSER_CURSE"]   = {"Curse"},
	[L"CURE_REMOVE_CURSE"]          = {"Curse"},
	["Disease"] = {
		L"CURE_ABOLISH_DISEASE",
		L"CURE_CURE_DISEASE",
		L"CURE_CLEANSE",
		L"CURE_PURIFY",
	},
	["Poison"] = {
		L"CURE_ABOLISH_POISON",
		L"CURE_CURE_POISON",
		L"CURE_CLEANSE",
		L"CURE_PURIFY",
	},
	["Magic"] = {
		L"CURE_DISPEL_MAGIC",
		L"CURE_CLEANSE",
	},
	["Curse"] = {
		L"CURE_REMOVE_LESSER_CURSE",
		L"CURE_REMOVE_CURSE",
	},
}

local dual_lookup = {
    -- Any spell that can be cast on friendly or hostile units
    [L"DUAL_HOLY_SHOCK"]     = true,
    [L"DUAL_MIND_VISION"]    = true,
    [L"CURE_DISPEL_MAGIC"]   = true,
}

--[[---------------------------------------------------------------------------------
  Register all of our utility functions
----------------------------------------------------------------------------------]]

function Clique:RegUtilFuncs()
    self:RegisterCustomFunction("Clique:CastSpell(\"spell\")", "Clique:CastSpell(\"spell\")", "Casts a spell on Clique.unit without changing targets")
    self:RegisterCustomFunction("Clique:IsBuffActive(\"buff\")", "Clique:IsBuffActive(\"buff\")", "Checks whether a buff or debuff is active on Clique.unit")
    self:RegisterCustomFunction("Clique:UnitMenu()", "Clique:UnitMenu()", "Pops up the unit menu for Clique.unit")
    self:RegisterCustomFunction("Clique:CureAny()", "Clique:CureAny()", "Attempts to cure any ailments on Clique.unit")
    self:RegisterCustomFunction("Clique:NewSpell(\"spell\", \"buff\")", "Clique:NewSpell(\"spell\", \"buff\")", "Casts a spell if a given buff is NOT on a target")
    self:RegisterCustomFunction("Clique:TargetUnit()", "Clique:TargetUnit()", "Targets the unit you clicked on.")
    self:RegisterCustomFunction("Clique:AssistUnit()", "Clique:AssistUnit()", "Assists the unit you clicked on.")
end    

--[[---------------------------------------------------------------------------------
  Scans the spellbook to determine which buffs/cures we know
----------------------------------------------------------------------------------]]

function Clique:ScanSpellbook()
    self:LevelDebug(2, "Clique:ScanSpellbok()")
    
    local tabs = GetNumSpellTabs()
    local name,texture,start,offset = GetSpellTabInfo(tabs)
    local numspells = start + offset
    
    self.spellbook = self:ClearTable(self.spellbook)
	self.spellbook.buffs = buff_lookup
    
    -- ace:print("Scanning " .. tabs .. " tabs for spells.")
    for i=1,numspells do
        local name,rank = GetSpellName(i, BOOKTYPE_SPELL)
		-- ace:print("** Scanning spell id: " .. i .. " found " .. name .. ".")
		local _,_,numrank = string.find(rank, L"RANK" .. " (%d+)")
		numrank = tonumber(numrank)
		
        if buff_lookup[name] or cure_lookup[name] then
            if numrank then
                self.spellbook[name] = numrank
            else
                self.spellbook[name] = true
            end
        end
        
        if dual_lookup[name] and numrank then
            local spell = string.format("%s(%s %d)", name, L"RANK", numrank)
            dual_lookup[spell] = true
        end
    end
end

function Clique:IsDualSpell(spell)
    return dual_lookup[spell]
end

--[[---------------------------------------------------------------------------------
  IsBuffActive() - Simple enough
----------------------------------------------------------------------------------]]

function Clique:IsBuffActive(spell, unit)
	if not unit then unit = Clique.unit end
	if not UnitExists(unit) then return end
	
	if string.find(spell, "Interface\\Icons\\") then
		for i=1,32 do
			local texture = UnitBuff(unit, i)
			if texture == spell then return true end
		end
		
		for i=1,16 do
			local texture = UnitDebuff(unit, i)
			if texture == spell then return true end
		end
		
		return false
	end
	
	
	if not self.tooltip then 
		local tt = CreateFrame("GameTooltip", "CliqueTooltip", nil, "GameTooltipTemplate")
		tt:SetOwner(tt, "ANCHOR_NONE")
		tt.name = CliqueTooltipTextLeft1
		self.tooltip = tt
	end

	-- Check buffs
	for i=1,32 do
		if not UnitBuff(unit, i) then return nil end

		self.tooltip:ClearLines()		
		self.tooltip:SetUnitBuff(unit, i)
		if string.find(self.tooltip.name:GetText(), spell) then
			return i
		end
	end

	-- Check debuffs
	for i=1,32 do
		if not UnitDebuff(unit, i) then return nil end

		self.tooltip:ClearLines()		
		self.tooltip:SetUnitDebuff(unit, i)
		if string.find(self.tooltip.name:GetText(), spell) then
			return i
		end
	end
	return false
end	

function Clique:IsBuff(name)
    return buff_lookup[name]
end

function Clique:BuffTest(name, rank, unit)
    if not self:IsBuff(name) then return end

    local level = UnitLevel(unit)
    return (buff_lookup[name][rank] - 10) <= level
end

--[[---------------------------------------------------------------------------------
  Handles the "smart buff" casting, determining which rank of a specified
  spell to cast on the given unit (based on level restrictions)
----------------------------------------------------------------------------------]]

function Clique:BestRank(name, unit)
    -- If we don't know the spell
	if not unit then unit = Clique.unit end
    if not self.spellbook[name] or not buff_lookup[name] or not UnitExists(unit) then return end
    
    local level = UnitLevel(unit)
    local maxrank = self.spellbook[name]
    local castrank = nil
    
    -- Make sure we don't go beyond the rank we currently know

    for i=1,maxrank do
        if self:BuffTest(name, i, unit) then
            castrank = i
        end
    end
    
    if castrank then
		self:LevelDebug(3, "Trying to cast: %s(%s %d)", name, L"RANK", castrank)
        Clique:CastSpell(string.format("%s(%s %d)", name, L"RANK", castrank), unit)
        return castrank
    end
    return true
end

--[[---------------------------------------------------------------------------------
  This is a small unitID cache on unit names which returns the friendly unitID
  of a specified unit.  This helps to convert raid2targettarget into the more
  friendly (and usable) raid14 allowing us to click-cast without changing 
  targets.
----------------------------------------------------------------------------------]]

local unitCache = {}
local RAID_IDS = {}
local PARTY_IDS = {}
for i=1,MAX_RAID_MEMBERS do RAID_IDS[i] = "raid"..i end
for i=1,MAX_PARTY_MEMBERS do PARTY_IDS[i] = "party"..i end

function Clique:GetFriendlyUnit(unit)
    local name = UnitName(unit)
    local cache = unitCache[name]

	--ace:print("Unit: " .. unit .. " Cache: " .. tostring(cache))
	
    if cache then
        if UnitName(cache) == name then
            return cache
        end
    end
    
    local unitID = nil
    local num = GetNumRaidMembers()
    
    local tbl
    if not UnitIsUnit("player", unit) then
        if num > 0 then
            tbl = RAID_IDS
        else
            num = GetNumPartyMembers()
            tbl = PARTY_IDS
        end
        
        for i=1,num do
            local u = tbl[i]
            if UnitIsUnit(u, unit) then
                unitID = u
                break
            end
        end
    else
        unitID = "player"
    end
    
    unitCache[name] = unitID

	--ace:print("UnitID: " .. (tostring(unitID or unit)))

	return unitID
end

--[[---------------------------------------------------------------------------------
  Simple table re-use function.  Prevents memory churn
----------------------------------------------------------------------------------]]

function Clique:ClearTable(tbl)
    if not tbl then tbl = {} end
    for k in pairs(tbl) do tbl[k] = nil end
    table.setn(tbl, 0)
    return tbl
end

--[[---------------------------------------------------------------------------------
  Sets the tooltip OnEnter
----------------------------------------------------------------------------------]]

function Clique:SetTooltip(frame, text)
    local func = function()
        GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
		GameTooltip:SetText(text)
        GameTooltip:Show()
    end
    
    frame:SetScript("OnEnter", func)
    frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

--[[---------------------------------------------------------------------------------
  Pops up the user menu
----------------------------------------------------------------------------------]]

function Clique:UnitMenu(unit)
    local type,x = nil,nil
	unit = unit or Clique.unit
    
    if unit == "player" then
        type = PlayerFrameDropDown
    elseif unit == "target" then
        type = TargetFrameDropDown
    elseif unit == "pet" then
        type = PetFrameDropDown
    elseif string.find(unit, "party") then
        _,_,x = string.find(unit, "(%d+)")
        type = getglobal("PartyMemberFrame"..x.."DropDown")
    elseif string.find(unit, "raid") then
        _,_,x = string.find(unit, "(%d+)")
        type = FriendsDropDown
        this.unit = unit
        this.name = UnitName(unit)
        this.id = this:GetID()
        FriendsDropDown.displayMode = "MENU"
        FriendsDropDown.initialize = RaidFrameDropDown_Initialize
    end
    
    if x then this:SetID(x) end
    
    if type then
        type.unit = unit
        type.name = UnitName(unit)
        ToggleDropDownMenu(1, nil, type,"cursor")
        return true
    end
    return true
end	

--[[---------------------------------------------------------------------------------
  Dispels the unit of any ailments you can cure
----------------------------------------------------------------------------------]]

function Clique:CureAny(unit)
	unit = unit or Clique.unit
	local ailments = Clique:ClearTable(self.work)
	
	for i=1,16 do
		local texture,stack,type = UnitDebuff(unit, i)
		if not texture then break end
		if type then 
			ailments[type] = true
		end
	end
	if next(ailments) then
		self:Debug("Checking ailments")
		for type in pairs(ailments) do
			self:Debug("Checking for type: " .. type)
			for i,cure in pairs(cure_lookup[type]) do
				self:Debug("Checking spell: " .. cure)		
				if self.spellbook[cure] then
					self:Debug(cure)
					Clique:CastSpell(cure, unit)
					return cure
				end
			end
		end
	end
    return true
end

function Clique:NewSpell(spell, buff)
    if not Clique:IsBuffActive(buff or spell) then
        if Clique:IsBuff(spell) then
            Clique:BestRank(spell)
        else
            Clique:CastSpell(spell)
        end
    end
    return true
end

function Clique:TargetUnit(unit)
    if not unit then unit = Clique.unit end
    TargetUnit(unit)
    return true
end

function Clique:AssistUnit(unit)
    if not unit then unit = Clique.unit end
    AssistUnit(unit)
    return true
end