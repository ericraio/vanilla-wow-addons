
local gratuity = AceLibrary("Gratuity-2.0")
local spellcache = AceLibrary("SpellCache-1.0")

-- from SpellStatus-1.0 thanks :)
local function GetGratuitySpellData()
	local spellName = gratuity:GetLine(1)
	local spellRank = gratuity:GetLine(1, true)
	--empty slot?
	if (not spellName) then
		return
	end
	
	local sName = spellcache:GetSpellData(spellName, spellRank)
	if (sName) then
		return sName
	else
		return spellName
	end
end


function HotCandy:DoHooking()
	self:Hook("CastSpell")
	self:Hook("CastSpellByName")
	self:Hook("UseAction")
	self:Hook("SpellTargetUnit")
	self:Hook("TargetUnit")
	self:Hook("SpellStopTargeting")
	self:HookScript(WorldFrame, "OnMouseDown", "WFMouseDown")
end

function HotCandy:CastSpell(spellId, spellbookTabNum)
	self.hooks["CastSpell"](spellId, spellbookTabNum)
	if (spellbookType == BOOKTYPE_SPELL) then
		local sName = spellcache:GetSpellData(spellId)
		if SpellIsTargeting() then 
			self.spell.Casting = sName
			self:LevelDebug(3, "CastSpell", "Targeting", self.spell.Casting)
		else
			self.spell.EndCast = sName
			self.spell.Target = UnitName("target")
			self:LevelDebug(3, "CastSpell", "~Targeting", self.spell.EndCast, self.spell.Target)
		end
	end
end

function HotCandy:CastSpellByName(spellName, onSelf)
	self.hooks["CastSpellByName"](spellName, onSelf)
	local sName = spellcache:GetSpellData(spellName)
	if SpellIsTargeting() then 
		self.spell.Casting = sName
		self:LevelDebug(3, "CastSpellByName", "Targeting", self.spell.Casting)
	else
		self.spell.EndCast = sName
		if onSelf then
			self.spell.Target = UnitName("player")
		else
			self.spell.Target = UnitName("target")
		end
		self:LevelDebug(3, "CastSpellByName", "~Targeting", self.spell.EndCast, self.spell.Target)
	end
end

function HotCandy:UseAction(slotId, checkCursor, onSelf)
	self.hooks["UseAction"](slotId, checkCursor, onSelf)
	if not GetActionText(slotId) then
		gratuity:SetAction(slotId)
		local sName = GetGratuitySpellData()
		if SpellIsTargeting() then 
			self.spell.Casting = sName
			self:LevelDebug(3, "UseAction", "Targeting", self.spell.Casting)
		else
			self.spell.EndCast = sName
			if onSelf then
				self.spell.Target = UnitName("player")
			else
				self.spell.Target = UnitName("target")
			end
			self:LevelDebug(3, "UseAction", "~Targeting", self.spell.EndCast, self.spell.Target)
		end
	end
end

function HotCandy:TargetUnit(unit)
	self.hooks["TargetUnit"](unit)
	if self.spell.Casting then
		self.spell.EndCast = self.spell.Casting
		self.spell.Target = UnitName(unit)
		self.spell.Casting = nil
	end
	self:LevelDebug(3, "TargetUnit", "EC:", self.spell.EndCast, "T: ", self.spell.Target, "C: ", self.spell.Casting)
end

function HotCandy:SpellTargetUnit(unit)
	self.hooks["SpellTargetUnit"](unit)
	if self.spell.Casting then
		self.spell.EndCast = self.spell.Casting
		self.spell.Target = UnitName(unit)
		self.spell.Casting = nil
	end
	self:LevelDebug(3, "SpellTargetUnit", "EC:", self.spell.EndCast, "T: ", self.spell.Target, "C: ", self.spell.Casting)
end

function HotCandy:SpellStopTargeting()
	self.hooks["SpellStopTargeting"]()
	if self.spell.Casting then
		self.spell.Casting = nil
		self.spell.Target = nil
		self.spell.EndCast = nil
	end
	self:LevelDebug(3, "SpellStopTargeting")
end

function HotCandy:WFMouseDown(object)
	self.hooks[object]["OnMouseDown"]()
	if arg1 == "LeftButton" then
		local targetName
		
		if self.spell.Casting and UnitExists("mouseover") then
			targetName = UnitName("mouseover")
		end
		
		if self.spell.Casting and targetName then
			self.spell.EndCast = self.spell.Casting
			self.spell.Target = targetName
			self.spell.Casting = nil
			self:LevelDebug(3, "WorldFrameMouseDown", self.spell.EndCast, self.spell.Target)
		end
	end
end
