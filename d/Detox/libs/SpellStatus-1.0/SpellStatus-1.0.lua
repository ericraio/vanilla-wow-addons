--[[
Name: SpellStatus-1.0
Revision: $Rev: 14589 $
Author(s): Nightdew (denzsolnightdew@gmail.com)
Website: http://www.wowace.com/index.php/SpellStatus-1.0
Documentation: http://www.wowace.com/index.php/SpellStatus-1.0
SVN: http://svn.wowace.com/root/trunk/SpellStatusLib/SpellStatus-1.0
Description: Status library that simplifies retrieving spell status information from the player
Dependencies: AceLibrary, AceDebug-2.0, AceEvent-2.0, AceHook-2.1, Deformat-2.0, Gratuity-2.0, SpellCache-1.0, (optional) SpellStatus-AimedShot-1.0
]]

local MAJOR_VERSION = "SpellStatus-1.0"
local MINOR_VERSION = "$Revision: 14589 $"

if (not AceLibrary) then 
	error(MAJOR_VERSION .. " requires AceLibrary.") 
end

if (not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION)) then 
	return 
end

local function CheckDependency(dependencies)
	for index, value in ipairs(dependencies) do
		if (not AceLibrary:HasInstance(value)) then 
			error(format("%s requires %s to function properly", MAJOR_VERSION, value))
		end
	end
end

local dependencyLibraries = {
	"AceDebug-2.0", 
	"AceEvent-2.0", 
	"AceHook-2.1", 
	"Deformat-2.0", 
	"Gratuity-2.0", 
	"SpellCache-1.0"
}

CheckDependency(dependencyLibraries)

local deformat = AceLibrary("Deformat-2.0")
local gratuity = AceLibrary("Gratuity-2.0")
local spellcache = AceLibrary("SpellCache-1.0")

--Create Library Object
local SpellStatus = {}
 
--Embed all needed mixins into the Library Object SpellStatus
AceLibrary("AceDebug-2.0"):embed(SpellStatus)
AceLibrary("AceEvent-2.0"):embed(SpellStatus)
AceLibrary("AceHook-2.1"):embed(SpellStatus)

--
-- Local functions not to be called from outside
--

local function InitializeHooks(self)
	self:Hook("CastSpell")
	self:Hook("CastSpellByName")
	self:Hook("UseAction")
	self:Hook("CastShapeshiftForm")
	self:Hook("UseInventoryItem")
	self:Hook("UseContainerItem")
	self:Hook("ToggleGameMenu")
	self:Hook("SpellStopCasting")
end

local function InitializeEventRegisters(self)
	self:RegisterEvent("SPELLCAST_START")
	self:RegisterEvent("SPELLCAST_STOP")
	self:RegisterEvent("SPELLCAST_INTERRUPTED")
	self:RegisterEvent("SPELLCAST_FAILED")
	self:RegisterEvent("SPELLCAST_DELAYED")
	self:RegisterEvent("SPELLCAST_CHANNEL_START")
	self:RegisterEvent("SPELLCAST_CHANNEL_STOP")
	self:RegisterEvent("SPELLCAST_CHANNEL_UPDATE")
	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")

	self:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
	self:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
	
	self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	 
	--SPELLLOGSELFOTHER

	--Used to determine if we are wanding.
	self:RegisterEvent("START_AUTOREPEAT_SPELL")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL")
	
	self:RegisterEvent("PLAYER_ENTER_COMBAT")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT")

	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self:RegisterEvent("SpellCache_Updated")
end

local function ResetActiveVariables(self)
	self:LevelDebug(2, "ResetActiveVariables")
	--Active Spell
	self.vars.ActiveId = nil
	self.vars.ActiveName = nil
	self.vars.ActiveRank = nil
	self.vars.ActiveFullName = nil
	self.vars.ActiveCastStartTime = nil
	self.vars.ActiveCastStopTime = nil
	self.vars.ActiveCastDuration = nil

	--Casting
	self.vars.ActiveCastDelay = nil
	self.vars.ActiveCastDelayTotal = nil

	--Channeling
	self.vars.ActiveAction = nil
	self.vars.ActiveCastDisruption = nil
	self.vars.ActiveCastDisruptionTotal = nil
	
	--NextMelee
	self.vars.NextMeleeId = nil
	self.vars.NextMeleeName = nil
	self.vars.NextMeleeRank = nil
	self.vars.NextMeleeFullName = nil
end

local function ResetVariables(self)
	self:LevelDebug(2, "ResetVariables")

	--Spell Attempted to cast
	self.vars.AttemptId = nil
	self.vars.AttemptName = nil
	self.vars.AttemptRank = nil
	self.vars.AttemptFullName = nil

	ResetActiveVariables(self)

	--UI_ERROR_MESSAGE
	self.vars.UIEM_Message = nil
	--CHATMSGSPELLFAILEDLOCALPLAYER
	self.vars.CMSFLP_SpellName = nil
	self.vars.CMSFLP_Message = nil
	
end

local function InitializeVariables(self)
	self:LevelDebug(2, "InitializeVariables")

	self.vars = {}

	--True while data is assigned until fail or stop or start and no SpellId
	self.vars.Using = false
	--True while data is assigned until fail or stop or start and SpellId
	self.vars.Preparing = false
	--Only true for spell with a casting time
	self.vars.Casting = false
	--Only true for channeling spells 
	self.vars.Channeling = false
	--Only true for spells that are next melee
	self.vars.NextMeleeing = false	
	
	--Whether or not the character is auto repeating
	self.vars.AutoRepeating = false
	--Are we attacking currently
	self.vars.Attacking = false
	--Are we currently in combat
	self.vars.Combating = false
	
	self.vars.Targeting = false

	--True when hooked into ToggleGameMenu
	self.vars.CancelTargeting = false
	self.vars.CancelCasting = false
	self.vars.CancelChanneling = false
	
	ResetVariables(self)
end

--
-- Activate method
--

local function activate(self, oldLib, oldDeactivate)
	--self:SetDebugging(true)
	--self:SetDebugLevel(3)

	self:LevelDebug(2, "SpellStatus - activate")
	
	if (oldLib) then
		oldLib:UnregisterAllEvents()
		oldLib:UnhookAll()
	end
	
	--Default code to clean up the oldlib
	if (oldDeactivate) then
		oldDeactivate(oldLib)
	end

	InitializeVariables(self)
	InitializeHooks(self)
	InitializeEventRegisters(self)
end


function SpellStatus:Report()
	self:LevelDebug(3, 
		format("Using: %s", tostring(self.vars.Using)), 
		format("Preparing: %s", tostring(self.vars.Preparing)), 
		format("Casting: %s", tostring(self.vars.Casting)), 
		format("Channeling: %s", tostring(self.vars.Channeling)),
		format("SpellName: %s", tostring(self:GetActiveSpellName()))
	)
end

function SpellStatus:IsUsing()
	return self.vars.Using == true
end

function SpellStatus:IsPreparing()
	return self.vars.Preparing == true
end

function SpellStatus:IsCasting()
	return self.vars.Casting == true
end

function SpellStatus:IsChanneling()
	return self.vars.Channeling == true
end

function SpellStatus:IsNextMeleeing()
	return self.vars.NextMeleeing == true
end

function SpellStatus:IsCastingOrChanneling()
	return self:IsCasting() or self:IsChanneling()
end

function SpellStatus:IsPreparingOrCastingOrChanneling()
	return self:IsPreparing() or self:IsCasting() or self:IsChanneling()
end

function SpellStatus:IsAutoRepeating()
	return self.vars.AutoRepeating == true
end

function SpellStatus:IsWanding()
	return ((self.vars.AutoRepeating == true) and HasWandEquipped()) and true or false
end

function SpellStatus:IsAttacking()
	return self.vars.Attacking == true
end

function SpellStatus:IsCombating()
	return self.vars.Combating == true
end

function SpellStatus:IsActiveSpell(spellId, spellName)
	local sId, sName = self:GetActiveSpellData()
	self:LevelDebug(2, "IsActiveSpell", spellId, sId, spellName, sName)
	--sId and spellId might be nil
	return (sId == spellId) and (sName == spellName)
end

function SpellStatus:GetActiveSpellData()
	return self.vars.ActiveId, self.vars.ActiveName, self.vars.ActiveRank, self.vars.ActiveFullName,
					self.vars.ActiveCastStartTime, self.vars.ActiveCastStopTime, self.vars.ActiveCastDuration,
					self.vars.ActiveAction
end

function SpellStatus:GetActiveSpellName()
	local _, spellName = self:GetActiveSpellData()
	return spellName
end

function SpellStatus:GetNextMeleeSpellData()
	return self.vars.NextMeleeId, self.vars.NextMeleeName, self.vars.NextMeleeRank, self.vars.NextMeleeFullName
end

--
-- Function Hooking
--

function SpellStatus:SpellCache_Updated()
end

local function AssignNextMeleeSpellData(self, spellId, spellName, spellRank, spellFullName)
	if (not spellId) then
		return false
	end
		
	gratuity:SetSpell(spellId, BOOKTYPE_SPELL)
	if (gratuity:Find(SPELL_ON_NEXT_SWING, 2, 3, false, true, true) == nil) then
		return false
	end
	
	self:LevelDebug(1, "AssignNextMeleeSpellData", spellId, spellName, spellRank, spellFullName)

	self.vars.NextMeleeing = true
	
	self.vars.NextMeleeId = spellId
	self.vars.NextMeleeName = spellName
	self.vars.NextMeleeRank = spellRank
	self.vars.NextMeleeFullName = spellFullName
	return true
end


local function AssignSpellData(self, spellId, spellName, spellRank, spellFullName)
	--self:LevelDebug(1, "AssignSpellData", spellId, spellName, spellRank, spellFullName)

	--If Next Melee spell stop dont continue
	if (AssignNextMeleeSpellData(self, spellId, spellName, spellRank, spellFullName)) then
		return
	end

	if (self.vars.Preparing or self.vars.Casting or self.vars.Channeling) then
		return
	end

	if (self.vars.Using and (spellName == self.vars.ActiveName)) then
		return
	end
	
	
	self:LevelDebug(1, "AssignSpellData", spellId, spellName, spellRank, spellFullName)

	ResetVariables(self)

	self.vars.ActiveId = spellId
	self.vars.ActiveName = spellName
	self.vars.ActiveRank = spellRank
	self.vars.ActiveFullName = spellFullName

	self.vars.Preparing = spellId ~= nil
	self.vars.Using = not self.vars.Preparing

	--Only preparing if you have a spellId
	if (self.vars.Preparing) then
		local aimedShot = AceLibrary:HasInstance("SpellStatus-AimedShot-1.0") and AceLibrary("SpellStatus-AimedShot-1.0") or nil
		if (aimedShot and aimedShot:Active()) then
			local aimedShotId, aimedShotDuration = aimedShot:MatchSpellId(spellId)
			if (aimedShotId) then
				self:SPELLCAST_START(spellName, aimedShotDuration)
			end
		end
	end
end

local function TriggerFailureEvent(self, overrideHasMessage)
	overrideHasMessage = overrideHasMessage == true
	--self:LevelDebug(2, "TriggerFailureEvent", overrideHasMessage)

	local hasMessage = self.vars.UIEM_Message or self.vars.CMSFLP_Message

	self:LevelDebug(2, "TriggerFailureEvent", hasMessage, overrideHasMessage)

	if (not (hasMessage or overrideHasMessage)) then
		return false
	end
	
	self:LevelDebug(2, "TriggerFailureEvent", overrideHasMessage)

	local isActiveSpell = false
	local sId, sName, sRank, sFullName
	
	if (self.vars.AttemptName) then
		sId = self.vars.AttemptId
		sName = self.vars.AttemptName
		sRank = self.vars.AttemptRank
		sFullName = self.vars.AttemptFullName
		self:LevelDebug(2, "TriggerFailureEvent Attempt", sId, sName, sRank, sFullName)
		self.vars.Using = false
		self.vars.Preparing = false
		self.vars.NextMeleeing = false
		--Necessary because the error might happen through multiple paths
		self.vars.AttemptCastFailure = true
	elseif (self.vars.CMSFLP_SpellName and (self.vars.CMSFLP_SpellName == self.vars.NextMeleeName)) then
		sId = self.vars.NextMeleeId
		sName = self.vars.NextMeleeName
		sRank = self.vars.NextMeleeRank
		sFullName = self.vars.NextMeleeFullName
		self:LevelDebug(2, "TriggerFailureEvent NextMelee", sId, sName, sRank, sFullName)
		self.vars.NextMeleeing = false
	elseif (overrideHasMessage or (self.vars.CMSFLP_SpellName and (self.vars.CMSFLP_SpellName == self.vars.ActiveName))) then
		isActiveSpell = true
		sId = self.vars.ActiveId
		sName = self.vars.ActiveName
		sRank = self.vars.ActiveRank
		sFullName = self.vars.ActiveFullName
		self:LevelDebug(2, "TriggerFailureEvent Active", sId, sName, sRank, sFullName)
		self.vars.Using = false
		self.vars.Preparing = false
		self.vars.Casting = false
		self.vars.Channeling = false
	else --must have been unrelated
		return false
	end
	
	self:TriggerEvent("SpellStatus_SpellCastFailure", 
		sId, sName, sRank, sFullName, isActiveSpell, 
		self.vars.UIEM_Message, self.vars.CMSFLP_SpellName, self.vars.CMSFLP_Message
	)
	
	self.vars.UIEM_Message = nil
	self.vars.CMSFLP_SpellName = nil
	self.vars.CMSFLP_Message = nil
	
	return true
end

function ResetCastOriginal(self, sId, sName, sRank, sFullName)
	--setup variables if failing immediately
	self.vars.AttemptId = sId
	self.vars.AttemptName = sName
	self.vars.AttemptRank = sRank
	self.vars.AttemptFullName = sFullName
	
	--reset Error Message
	self.vars.UIEM_Message = nil
	self.vars.CMSFLP_SpellName = nil
	self.vars.CMSFLP_Message = nil

	self.vars.AttemptCastFailure = false
end

function CastOriginal(self, methodName, param1, param2, param3, sId, sName, sRank, sFullName)
	self:LevelDebug(1, ">>>> CastOriginal", 
		methodName, param1, param2, param3, 
		sId, sName, sRank, sFullName)

	ResetCastOriginal(self, sId, sName, sRank, sFullName)	

	self:LevelDebug(3, "-> CastOriginal")
	self.hooks[methodName](param1, param2, param3)
	self:LevelDebug(3, "<- CastOriginal")

	TriggerFailureEvent(self)
	if (not self.vars.AttemptCastFailure) then
		AssignSpellData(self, sId, sName, sRank, sFullName)
	end
	
	ResetCastOriginal(self, nil, nil, nil, nil)	

	self:LevelDebug(1, "<<<< CastOriginal", 
		methodName, param1, param2, param3, 
		sId, sName, sRank, sFullName)
end

function SpellStatus:CastSpellByName(spellName, onSelf)
	self:LevelDebug(2, ">>>> CastSpellByName", spellName, onSelf)

	local sName, sId, sRank, sFullName
	sName, sRank, sId, sFullName = spellcache:GetSpellData(spellName)

	CastOriginal(self, "CastSpellByName", spellName, onSelf, nil, sId, sName, sRank, sFullName)

	self:LevelDebug(2, "<<<< CastSpellByName2", spellName, onSelf)
end

function SpellStatus:CastSpell(spellId, spellbookType)
	self:LevelDebug(2, ">>>> CastSpell", spellId, spellbookType)

	local sId, sName, sRank, sFullName
	if (spellbookType == BOOKTYPE_SPELL) then
		sName, sRank, sId, sFullName = spellcache:GetSpellData(spellId)
	end
	
	CastOriginal(self, "CastSpell", spellId, spellbookType, nil, sId, sName, sRank, sFullName)

	self:LevelDebug(2, "<<<< CastSpell", spellId, spellbookType)
end

--When using UseAction through clicking an actiobar button, we need to get in
local function GetGratuitySpellData(self, slotId)
	local spellName = gratuity:GetLine(1)
	local spellRank = gratuity:GetLine(1, true)
	--empty slot?
	if (not spellName) then
		return
	end
	
	self:LevelDebug(3, "GetGratuitySpellData", spellName, spellRank)
	local sName, sRank, sId, sFullName = spellcache:GetSpellData(spellName, spellRank)
	if (sName) then
		return sId, sName, sRank, sFullName
	else
		return nil, spellName, nil, nil
	end
end

function SpellStatus:UseAction(slotId, checkCursor, onSelf)
	self:LevelDebug(1, ">>>> UseAction", slotId, checkCursor, onSelf)

	local actionText = GetActionText(slotId)
	local isMacro = actionText ~= nil
	--self:LevelDebug(2, "UseAction", actionText, tostring(isMacro))
	
	if (isMacro) then
		self.hooks["UseAction"](slotId, checkCursor, onSelf)
	else
		gratuity:SetAction(slotId)
		local sId, sName, sRank, sFullName = GetGratuitySpellData(self, slotId)
		if (sName) then
			CastOriginal(self, "UseAction", slotId, checkCursor, onSelf, sId, sName, sRank, sFullName)
		else
			self.hooks["UseAction"](slotId, checkCursor, onSelf)
		end
	end

	self:LevelDebug(1, "<<<< UseAction", slotId, checkCursor, onSelf)
end

function SpellStatus:CastShapeshiftForm(index)
	self:LevelDebug(2, ">>>> CastShapeshiftForm", index)

	gratuity:SetShapeshift(index)
	local sId, sName, sRank, sFullName = GetGratuitySpellData(self, slotId)
	if (sName) then
		CastOriginal(self, "CastShapeshiftForm", index, nil, nil, sId, sName, sRank, sFullName)
	else
		self.hooks["CastShapeshiftForm"](index)
	end
	
	self:LevelDebug(2, "<<<< CastShapeshiftForm", index)
end

local function GetItemLinkData(slotId, bagId)
	local itemLink = nil

	if (bagId == nil) then
		itemLink = GetInventoryItemLink("player", slotId)
	else
		itemLink = GetContainerItemLink(bagId, slotId)
	end

	if (itemLink) then
		local _, _, itemName = string.find(itemLink, "^.*%[(.*)%].*$")
		return itemName, itemLink
	end
end

function SpellStatus:UseInventoryItem(slotId)
	self:LevelDebug(2, ">>>> UseInventoryItem", slotId)
	
	local itemName, itemLink = GetItemLinkData(slotId)
	
	if (itemLink) then
		CastOriginal(self, "UseInventoryItem", slotId, nil, nil, nil, itemName, nil, itemLink)
	else
		self.hooks["UseInventoryItem"](slotId)
	end
	
	self:LevelDebug(2, "<<<< UseInventoryItem", slotId)
end

function SpellStatus:UseContainerItem(bagId, slotId)
	self:LevelDebug(2, ">>>> UseContainerItem", bagId, slotId)
	
	local itemName, itemLink = GetItemLinkData(slotId, bagId)
	
	if (itemLink) then
		CastOriginal(self, "UseContainerItem", bagId, slotId, nil, nil, itemName, nil, itemLink)
	else
		self.hooks["UseContainerItem"](bagId, slotId)
	end
	
	self:LevelDebug(2, "<<<< UseContainerItem", bagId, slotId)
end

function SpellStatus:ToggleGameMenu()
	--self:LevelDebug(3, "ToggleGameMenu1", SpellIsTargeting())

	--If these hook is called and targeting, targeting will always be killed first
	self.vars.CancelTargeting = SpellIsTargeting()
	self.vars.CancelCasting = self.vars.Casting
	self.vars.CancelChanneling = self.vars.Channeling

	self.hooks["ToggleGameMenu"]()

	self.vars.CancelTargeting = false
	self.vars.CancelCasting = false
	self.vars.CancelChanneling = false

	--self:LevelDebug(3, "ToggleGameMenu2", SpellIsTargeting())
end

function SpellStatus:SpellStopCasting()
	self:LevelDebug(2, ">>>> SpellStopCasting")
	if (self:IsCastingOrChanneling()) then
		self.vars.SpellStopCastingActiveName = self.vars.ActiveName
	end
	self.hooks["SpellStopCasting"]()
	self:LevelDebug(2, "<<<< SpellStopCasting")
end

function SpellStatus:SPELLCAST_START(spellName, duration)
	self:LevelDebug(1, "SPELLCAST_START", spellName, duration)

	self.vars.SpellStopCastingActiveName = nil
	self.vars.Using = false
	self.vars.Preparing = false
	self.vars.Casting = true

	if (self.vars.ActiveName ~= spellName) then
		ResetActiveVariables(self)
		self.vars.ActiveName = spellName
		self.vars.ActiveFullName = spellName
	end
			

	self.vars.ActiveCastStartTime = GetTime()
	self.vars.ActiveCastDuration = duration
	self.vars.ActiveCastStopTime = self.vars.ActiveCastStartTime + (self.vars.ActiveCastDuration/1000)

	self.vars.ActiveCastDelay = nil
	self.vars.ActiveCastDelayTotal = nil

	self:TriggerEvent(
		"SpellStatus_SpellCastCastingStart", 
		self.vars.ActiveId,
		self.vars.ActiveName, 
		self.vars.ActiveRank,
		self.vars.ActiveFullName,
		self.vars.ActiveCastStartTime,
		self.vars.ActiveCastStopTime,
		self.vars.ActiveCastDuration
	)
end

function SpellStatus:SPELLCAST_DELAYED(delay)
	self:LevelDebug(1, "SPELLCAST_DELAYED", delay)

	if (self.vars.ActiveCastStopTime == nil) then
		return
	end

	self.vars.ActiveCastDelay = delay/1000
	self.vars.ActiveCastDelayTotal = (self.vars.ActiveCastDelayTotal or 0) + self.vars.ActiveCastDelay
	self.vars.ActiveCastStopTime = self.vars.ActiveCastStopTime + self.vars.ActiveCastDelay

	self:TriggerEvent(
		"SpellStatus_SpellCastCastingChange", 
		self.vars.ActiveId,
		self.vars.ActiveName, 
		self.vars.ActiveRank,
		self.vars.ActiveFullName,
		self.vars.ActiveCastStartTime,
		self.vars.ActiveCastStopTime,
		self.vars.ActiveCastDuration,
		self.vars.ActiveCastDelay,
		self.vars.ActiveCastDelayTotal
	)
end

function SpellStatus:SPELLCAST_STOP()
	self:LevelDebug(1, "SPELLCAST_STOP")

	--If canceling targeting.. ignore stop!
	if (self.vars.CancelTargeting or self.vars.CancelCasting or self.vars.CancelChanneling) then
		return
	end

	--if (self.vars.ActiveId == nil) then
	if (self.vars.ActiveName == nil) then
		return
	end
	
	--Player probably moved initiating a client and server side SPELLCAST_STOP
	if (not(	self.vars.Using or 
				self.vars.Preparing or 
				self.vars.Casting or 
				self.vars.Channeling or
				self.vars.AutoRepeating )) then
		return
	end
	
	if (TriggerFailureEvent(self)) then
		return
	end
	
	self.vars.Using = false
	self.vars.Preparing = false

	--Second SPELLCAST_STOP received from server after SpellStopCasting was called
	if ((not self.vars.Casting) and 
		self.vars.SpellStopCastingActiveName and 
		(self.vars.ActiveName == self.vars.SpellStopCastingActiveName)) then
		self.vars.SpellStopCastingActiveName = nil
		return
	end

	local castingInstant = (not self.vars.Casting) and (not self.vars.Channeling)
	self.vars.Casting = false

	--Generate Finish Event if not channeling
	if (not self.vars.Channeling) then
		local sD = castingInstant and self or self.vars.ActiveCastingData

		self.vars.ActiveCastStartTime = self.vars.ActiveCastStartTime or GetTime()
		self.vars.ActiveCastStopTime = GetTime()
		
		self:TriggerEvent(
			castingInstant and "SpellStatus_SpellCastInstant" or "SpellStatus_SpellCastCastingFinish", 
			self.vars.ActiveId,
			self.vars.ActiveName, 
			self.vars.ActiveRank,
			self.vars.ActiveFullName,
			self.vars.ActiveCastStartTime,
			self.vars.ActiveCastStopTime,
			self.vars.ActiveCastDuration,
			self.vars.ActiveCastDelayTotal
		)
		--We cant reset because maybe we have a failure!!!
		--ResetActiveVariables(self)
	end
end

function SpellStatus:SPELLCAST_CHANNEL_START(duration, action)
	self:LevelDebug(2, "SPELLCAST_CHANNEL_START", duration, action)

	self.vars.SpellStopCastingActiveName = nil
	self.vars.Using = false
	self.vars.Preparing = false
	self.vars.Channeling = true
	
	local sD = self.vars.ActiveChannelingData

	self.vars.ActiveCastStartTime = GetTime()
	self.vars.ActiveCastDuration = duration / 1000
	self.vars.ActiveCastStopTime = self.vars.ActiveCastStartTime + self.vars.ActiveCastDuration
	self.vars.ActiveAction = action

	self.vars.ActiveId = self.vars.ActiveId
	self.vars.ActiveName = self.vars.ActiveName
	self.vars.ActiveRank = self.vars.ActiveRank
	self.vars.ActiveFullName = self.vars.ActiveFullName
	
	self.vars.ActiveCastDisruption = nil
	self.vars.ActiveCastDisruptionTotal = nil

	self:TriggerEvent(
		"SpellStatus_SpellCastChannelingStart", 
		self.vars.ActiveId,
		self.vars.ActiveName, 
		self.vars.ActiveRank,
		self.vars.ActiveFullName,
		self.vars.ActiveCastStartTime,
		self.vars.ActiveCastStopTime,
		self.vars.ActiveCastDuration,
		self.vars.ActiveAction
	)
end

--Any changes while channeling will come through this event
function SpellStatus:SPELLCAST_CHANNEL_UPDATE(duration)
	self:LevelDebug(2, "SPELLCAST_CHANNEL_UPDATE", duration)

	local sD = self.vars.ActiveChannelingData

	local timeStamp = GetTime()
	
	--New Duration
	local spellCastDuration = duration / 1000
	self:LevelDebug(3, "spellCastDuration", spellCastDuration)
	--Store old stop time
	local spellCastStopTime = self.vars.ActiveCastStopTime
	--Time Passed since Channeling
	local spellCastTimePassed = timeStamp - self.vars.ActiveCastStartTime
	self:LevelDebug(3, "spellCastTimePassed", spellCastTimePassed)
	--What channel time did we loose
	self.vars.ActiveCastDisruption = self.vars.ActiveCastDuration - spellCastDuration - spellCastTimePassed
	self.vars.ActiveCastDisruptionTotal = (self.vars.ActiveCastDisruptionTotal or 0) + self.vars.ActiveCastDisruption
	self.vars.ActiveCastStopTime = timeStamp + spellCastDuration

	self:TriggerEvent(
		"SpellStatus_SpellCastChannelingChange", 
		self.vars.ActiveId,
		self.vars.ActiveName, 
		self.vars.ActiveRank,
		self.vars.ActiveFullName,
		self.vars.ActiveCastStartTime,
		self.vars.ActiveCastStopTime,
		self.vars.ActiveCastDuration,
		self.vars.ActiveAction,
		self.vars.ActiveCastDisruption,
		self.vars.ActiveCastDisruptionTotal
	)
end

function SpellStatus:SPELLCAST_CHANNEL_STOP()
	self:LevelDebug(2, "SPELLCAST_CHANNEL_STOP")

	self.vars.Using = false
	self.vars.Preparing = false
	self.vars.Channeling = false

	self.vars.ActiveCastStopTime = GetTime()

	self:TriggerEvent(
		"SpellStatus_SpellCastChannelingFinish", 
		self.vars.ActiveId,
		self.vars.ActiveName, 
		self.vars.ActiveRank,
		self.vars.ActiveFullName,
		self.vars.ActiveCastStartTime,
		self.vars.ActiveCastStopTime,
		self.vars.ActiveCastDuration,
		self.vars.ActiveAction,
		self.vars.ActiveCastDisruptionTotal
	)
end

--Always thrown before CHAT_MSG_SPELL_FAILED_LOCALPLAYER which might be thrown
function SpellStatus:UI_ERROR_MESSAGE(message)
	self:LevelDebug(2, "UI_ERROR_MESSAGE", message)

	self.vars.UIEM_Message = message
end

local FAILUREMESSAGE = {
	SPELLFAILCASTSELF,
	SPELLFAILPERFORMSELF
}

function SpellStatus:CHAT_MSG_SPELL_FAILED_LOCALPLAYER(message)
	self:LevelDebug(2, "CHAT_MSG_SPELL_FAILED_LOCALPLAYER", message)

	table.foreach(FAILUREMESSAGE, 
		function(key, value)
			local spellName, spellFailureMessage = deformat:Deformat(message, value)
			if (spellName) then
				self.vars.CMSFLP_SpellName = spellName
				self.vars.CMSFLP_Message = spellFailureMessage
			end
			--if returning ~= nil the foreach will stop.
			return spellName
		end
	)
end

local CHAT_MSG_SPELL_SELF_DAMAGEMESSAGES = {
	IMMUNESPELLSELFOTHER,
	SIMPLECASTSELFOTHER,
	SIMPLEPERFORMSELFOTHER,
	SPELLBLOCKEDSELFOTHER,
	SPELLDODGEDSELFOTHER,
	SPELLEVADEDSELFOTHER,
	SPELLIMMUNESELFOTHER,
	SPELLINTERRUPTSELFOTHER,
	SPELLLOGABSORBSELFOTHER,
	SPELLLOGABSORBSELFSELF,
	SPELLLOGCRITSCHOOLSELFOTHER,
	SPELLLOGCRITSCHOOLSELFSELF,
	SPELLLOGCRITSELFOTHER,
	SPELLLOGSCHOOLSELFOTHER,
	SPELLLOGSCHOOLSELFSELF,
	SPELLLOGSELFOTHER,
	SPELLMISSSELFOTHER,
	SPELLPARRIEDSELFOTHER,
	SPELLREFLECTSELFOTHER,
	SPELLRESISTSELFOTHER,
	SPELLRESISTSELFSELF,
	SPELLTERSEPERFORM_SELF,
	SPELLTERSE_SELF
}

local CHAT_MSG_SPELL_SELF_DAMAGEMESSAGETRAILERS = {
	"",
	ABSORB_TRAILER,
	BLOCK_TRAILER,
	CRUSHING_TRAILER,
	GLANCING_TRAILER,
	RESIST_TRAILER,
	VULNERABLE_TRAILER
}

function ParseCHAT_MSG_SPELL_SELF_DAMAGE(self, message, damageMessage, damageMessageTrailer)
	local spellName = deformat:Deformat(message, damageMessage..damageMessageTrailer)
	--self:LevelDebug(2, "ParseCHAT_MSG_SPELL_SELF_DAMAGE", self.vars.NextMeleeing, self.vars.NextMeleeName, spellName)
	if (spellName and (spellName == self.vars.NextMeleeName)) then
		self.vars.NextMeleeing = false

		self:TriggerEvent(
			"SpellStatus_SpellCastInstant", 
			self.vars.NextMeleeId,
			self.vars.NextMeleeName, 
			self.vars.NextMeleeRank,
			self.vars.NextMeleeFullName
		)
	end
end

function SpellStatus:CHAT_MSG_SPELL_SELF_DAMAGE(message)
	self:LevelDebug(2, "CHAT_MSG_SPELL_SELF_DAMAGE", message)

	if (not self.vars.NextMeleeing) then
		return
	end

	table.foreach(
		CHAT_MSG_SPELL_SELF_DAMAGEMESSAGES, 
		function(_, damageMessage)
			table.foreach(
				CHAT_MSG_SPELL_SELF_DAMAGEMESSAGETRAILERS, 
				function(_, damageMessageTrailer)
					ParseCHAT_MSG_SPELL_SELF_DAMAGE(self, message, damageMessage, damageMessageTrailer)
					if (not self.vars.NextMeleeing) then
						return true
					end
				end
			)
			if (not self.vars.NextMeleeing) then
				return true
			end
		end
	)
end

function SpellStatus:CHAT_MSG_SPELL_AURA_GONE_SELF(message)
	self:LevelDebug(2, "CHAT_MSG_SPELL_AURA_GONE_SELF", message)

	if (not(self.vars.Using or self.vars.Preparing or self.vars.Casting or self.vars.Channeling)) then
		return
	end

	local spellName = deformat:Deformat(message, AURAREMOVEDSELF)
	if ((not spellName) or (spellName ~= self.vars.ActiveName)) then
		return
	end

	self.vars.Using = false
	self.vars.Preparing = false
	self.vars.Casting = false
	self.vars.Channeling = false
	
	self:TriggerEvent(
		"SpellStatus_SpellCastCancelAura", 
		self.vars.ActiveId, self.vars.ActiveName,  self.vars.ActiveRank, 
		self.vars.ActiveFullName or self.vars.ActiveName, GetTime()
	)
end

--Failed is called only when it was semi possible to cast the spell
function SpellStatus:SPELLCAST_INTERRUPTED()
	self:LevelDebug(2, "SPELLCAST_INTERRUPTED")

	TriggerFailureEvent(self, true) 
end

function SpellStatus:SPELLCAST_FAILED()
	self:LevelDebug(2, "SPELLCAST_FAILED")

	TriggerFailureEvent(self, true) 
end

function SpellStatus:START_AUTOREPEAT_SPELL()
	self:LevelDebug(2, "START_AUTOREPEAT_SPELL")

	self.vars.AutoRepeating = true
end

function SpellStatus:STOP_AUTOREPEAT_SPELL()
	self:LevelDebug(2, "STOP_AUTOREPEAT_SPELL")

	self.vars.AutoRepeating = false
end

function SpellStatus:PLAYER_ENTER_COMBAT()
	self:LevelDebug(2, "PLAYER_ENTER_COMBAT")

	self.vars.Attacking = true
end

function SpellStatus:PLAYER_LEAVE_COMBAT()
	self:LevelDebug(2, "PLAYER_LEAVE_COMBAT")

	self.vars.Attacking = false
end

function SpellStatus:PLAYER_REGEN_DISABLED()
	self:LevelDebug(2, "PLAYER_REGEN_DISABLED")

	self.vars.Combating = true
end

function SpellStatus:PLAYER_REGEN_ENABLED()
	self:LevelDebug(2, "PLAYER_REGEN_ENABLED")

	self.vars.Combating = false
end

function SpellStatus:CHAT_MSG_COMBAT_SELF_HITS(chatMessage)
	self:LevelDebug(2, "CHAT_MSG_COMBAT_SELF_HITS", chatMessage)
end

function SpellStatus:CHAT_MSG_COMBAT_SELF_MISSES(chatMessage)
	self:LevelDebug(2, "CHAT_MSG_COMBAT_SELF_MISSES", chatMessage)
end


--
-- Final Registration of the library.
--
AceLibrary:Register(SpellStatus, MAJOR_VERSION, MINOR_VERSION, activate)
SpellStatus = AceLibrary(MAJOR_VERSION)


