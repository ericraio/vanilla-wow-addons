--[[---------------------------------------------------------------------------------
  Clique by Cladhaire <cladhaire@gmail.com>
  GUI concept/code by Gello 
  
  TODO:
  
----------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
  Create the AddOn object and create a local binding for AceLocale
----------------------------------------------------------------------------------]]

Clique = AceLibrary("AceAddon-2.0"):new(
    "AceHook-2.0", 
    "AceConsole-2.0", 
    "AceDB-2.0", 
    "AceEvent-2.0",
    "AceModuleCore-2.0",
    "AceDebug-2.0"
)

Clique:RegisterDB("CliqueDB")
local L = AceLibrary:GetInstance("AceLocale-2.0"):new("Clique")

-- Expoxe AceHook and AceEvent to our modules
Clique:SetModuleMixins("AceHook-2.0", "AceEvent-2.0", "AceDebug-2.0")

--[[---------------------------------------------------------------------------------
  This is the actual addon object
----------------------------------------------------------------------------------]]

function Clique:OnInitialize()
    self:LevelDebug(2, "Clique:OnInitialize()")
    self:CheckProfile()
    
    self:LevelDebug(3, "Setting all modules to inactive.")
    for name,module in self:IterateModules() do
        self:ToggleModuleActive(name, false)
    end
end

function Clique:OnEnable()
    self:LevelDebug(2, "Clique:OnEnable()")
    IndentationLib.addSmartCode(CliqueEditBox)

    if GetCVar("AutoSelfCast") == "1" then
        StaticPopup_Show("CLIQUE_AUTO_SELF_CAST")
        return
    end
    
    -- Register for ADDON_LOADED so we can load plugins for LOD addons
    self:RegisterEvent("ADDON_LOADED", "LoadModules")
    
    -- Build the action table, so we have precompiled functions
	self:ScanSpellbook()
    self:BuildActionTable()

	-- Enable tooltips in the GUI
	self:EnableTooltips()
    self:RegUtilFuncs()
    
    -- Create the hook tables
    self._OnClick = {}
    
    -- Load any valid modules
    self:LoadModules()

    -- Hook the SpellBookFrame so we can hide/show as needed
    self:HookScript(SpellBookFrame, "OnShow", "SpellBookFrame_OnShow")
    for i=1,12 do
        local button = getglobal("SpellButton"..i)
        button:RegisterForClicks("LeftButtonUp","RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
        self:HookScript(button, "OnClick", "SpellButton_OnClick")
    end
end

function Clique:LoadModules()
    for name,module in self:IterateModules() do
        if not self:IsModuleActive(name) and not module.disabled then
            -- Try to enable the module
            
            local loadModule = nil
                        
            if module.Test and type(module.Test) == "function" then
                if module:Test() then
                    loadModule = true
                end
            else
                loadModule = true
            end
            
            if loadModule and not Clique:IsModuleActive(name) then
                self:LevelDebug(1, "Enabling module \"%s\" for %s.", name, module.fullname)
                Clique:ToggleModuleActive(name,true)
 
                if module._OnClick then
                    self:LevelDebug(2, "Grabbing _OnClick from %s", name)
                    self._OnClick[name] = module
                end
            end
        end
    end
end

function Clique:CheckProfile()
    self:LevelDebug(2, "Clique:CheckProfile()")

    local profile = self.db.char
    profile[L"DEFAULT_FRIENDLY"] = profile[L"DEFAULT_FRIENDLY"] or {}
    profile[L"DEFAULT_HOSTILE"] = profile[L"DEFAULT_HOSTILE"] or {}
end

function Clique:BuildActionTable()
    self:LevelDebug(2, "Clique:BuildActionTable()")
    
    local actions = self:ClearTable(self.Actions)
    self.Actions = actions
    
    for k,v in pairs(self.db.char) do
        actions[k] = {}
        
        for i,entry in ipairs(v) do
            local a = bit.band(entry.modifiers, 1)
            local c = bit.band(entry.modifiers, 2)
            local s = bit.band(entry.modifiers, 4)
            
            -- Skip any non-bound entries
            if entry.button ~= L"BINDING_NOT_DEFINED" then 
                local key = string.format("%s%d", entry.button, entry.modifiers)
                local action = entry.action
                if not action and not entry.custom then
                    local buff = self.spellbook[entry.name]
                    if buff then buff = tonumber(buff) end
                    if self:IsBuff(entry.name) and not entry.rank then
                        action = string.format("Clique:BestRank(\"%s\", Clique.unit)", entry.name)
                    elseif entry.rank then
                        action = string.format("Clique:CastSpell(\"%s(%s %d)\")", entry.name, L"RANK", entry.rank)
                    else
                        action = string.format("Clique:CastSpell(\"%s\")", entry.name)
                    end
                end
                
                --self:Print(action)
                
                local func,errString = loadstring(action)
                if func then 
                    actions[k][key] = func
                else
                    DEFAULT_CHAT_FRAME:AddMessage(string.format(L"ERROR_SCRIPT", errString))
                end
            end
        end
    end
end

function Clique:OnClick(button, unit)
    unit = unit or this.unit 
    button = button or arg1
    local a,c,s = IsAltKeyDown() or 0, IsControlKeyDown() or 0, IsShiftKeyDown() or 0 

    local targettarget = nil

    if not unit then
        unit = this:GetParent().unit
        if not unit then
            error(string.format(L"NO_UNIT_FRAME", tostring(this:GetName())))
        end
    end
	
	if not UnitExists(unit) then
		return
	end

    Clique.unit = unit
	-- DEFAULT_CHAT_FRAME:AddMessage("Clique:OnClick("..tostring(button)..", "..tostring(unit)..")")
    if not UnitExists(unit) then return end

    -- If the casting hand is up on the screen, cast the waiting spell on
    -- this unit
    if SpellIsTargeting() then
        if button == "LeftButton" then SpellTargetUnit(unit)
        elseif button == "RightButton" then SpellStopTargeting() end
        return true
    end

    -- If the cursor has an item and we're clicking on another player,
    -- attempt to trade with them (or feed your pet, etc).  If we
    -- LeftButton drop it on ourselves, then equip the item.  If we click
    -- anything else, then put the item back in the backpack
    if CursorHasItem() then
        if button == "LeftButton" then
            if unit == "player" then AutoEquipCursorItem()
            else DropItemOnUnit(unit) end
        else PutItemInBackpack() end
        return
    end

    -- We need to determine which cast set we're coming from
	local default = L"DEFAULT_FRIENDLY"
    local restore = nil

	if UnitCanAttack("player", unit) then
		default = L"DEFAULT_HOSTILE"
	end
    
    Clique.set = default
    
    -- Iterate the hooks here
    for name,module in pairs(Clique._OnClick) do
        if module:_OnClick(button, Clique.unit) then 
            self:LevelDebug(3, "Module %s has changed the clique set.", name)
            break 
        end
    end
	
	if not Clique.set or not Clique.Actions[Clique.set] then
		Clique.set = default
	end

    local modifiers = 0
    modifiers = bit.bor(modifiers, a * 1)
    modifiers = bit.bor(modifiers, c * 2)
    modifiers = bit.bor(modifiers, s * 4)
	
    local key = string.format("%s%d", button, modifiers)
    local func = Clique.Actions[Clique.set][key]
    local entry = Clique.db.char[Clique.set][key]
	
    self:LevelDebug(2, "Clique:OnClick("..button..", " .. modifiers..")")
    
	if not func then
        self:LevelDebug(3, "Casting from the default set instead.")
		func = Clique.Actions[default][key]
		entry = Clique.db.char[default][key]
	end

    if func then
        func()
		
		-- In case spell failed to apply
		if SpellIsTargeting() then SpellStopTargeting() end

        return true
    else
        --error("Could not find an action for key " .. key)
    end
end

function Clique:CastSpell(spell, unit)
	local restore = nil
	unit = unit or Clique.unit
    
    -- IMPORTANT: If the unit is targettarget or more, then we need to try
    -- to convert it to a friendly unit (to make click-casting work
    -- properly). If this isn't successful, set it up so we restore our 
    -- target
	
	self:LevelDebug(2, "Clique:CastSpell("..tostring(spell)..", "..tostring(unit) .. ")")

    if string.find(unit, "target") and string.len(unit) > 6 then
        local friendly = Clique:GetFriendlyUnit(unit)

        if friendly then
            unit = friendly
        else
			self:LevelDebug(2, "Setting targettarget flag.")
            targettarget = true
        end
    end
    
    -- Lets resolve the targeting.  If this is a hostile target and its
    -- not currently our target, then we will need to target the unit
    if UnitCanAttack("player", unit) then
        if not UnitIsUnit(unit, "target") then
            self:LevelDebug(2, "Changing to hostile target.")
            TargetUnit(unit)
        end

	-- If we're looking at someone else's target, we have to change targets since
    -- ClearTarget() will get rid of the blahtarget unitID entirely.  We only do
	-- this if this is a friendly target (since they will consume the spell)
	elseif targettarget and not UnitCanAttack("player", "target") then
		self:LevelDebug(2, "Changing target due to friendly target.")
		TargetUnit(unit)
    
    -- If the target is a friendly unit, and its not the unit we're casting on
    elseif UnitExists("target") and not UnitCanAttack("player", "target") and not UnitIsUnit(unit, "target") then
        self:LevelDebug(3, "Clearing the target")
        ClearTarget()
        restore = true
	
    elseif UnitExists("target") and self:IsDualSpell(spell) and not UnitIsUnit(unit, "target") then
        self:LevelDebug(3, "Clearing target for this dual spell")
        ClearTarget()
        restore = true
    end

    --self:Print("Clique:CastSpell(%s, %s)", spell, unit)
    --self:Print("Dual Spell: %s, %s", spell, tostring(self:IsDualSpell(spell)))
    
	CastSpellByName(spell)
	
	if SpellIsTargeting() then
        self:LevelDebug(3, "SpellTargetingUnit")
        SpellTargetUnit(unit)
	end
    
    if SpellIsTargeting() then SpellStopTargeting() end
	
	if restore then
        self:LevelDebug(3, "Restoring with TargetLastTarget")
		TargetLastTarget()
	end
end