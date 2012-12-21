CT_RA_SpellSpell = nil;
CT_RA_SpellCast = nil;

CT_RA_oldCastSpell = CastSpell;
function CT_RA_newCastSpell(spellId, spellbookTabNum)
   -- Call the original function so there's no delay while we process
   CT_RA_oldCastSpell(spellId, spellbookTabNum);
       
   -- Load the tooltip with the spell information
   CT_RADST:SetSpell(spellId, spellbookTabNum);
   
   local spellName = CT_RADSTTextLeft1:GetText();
       
   if ( SpellIsTargeting() ) then 
       -- Spell is waiting for a target
       CT_RA_SpellSpell = spellName;
   elseif ( UnitExists("target") ) then
       -- Spell is being cast on the current target.  
       -- If ClearTarget() had been called, we'd be waiting target
	   CT_RA_ProcessSpellCast(spellName, UnitName("target"));
   end
end
CastSpell = CT_RA_newCastSpell;

CT_RA_oldCastSpellByName = CastSpellByName;
function CT_RA_newCastSpellByName(spellName, onSelf)
	-- Call the original function
	CT_RA_oldCastSpellByName(spellName, onSelf)
	local _, _, spellName = string.find(spellName, "^([^%(]+)");
	if ( spellName ) then
		if ( SpellIsTargeting() ) then
			CT_RA_SpellSpell = spellName;
		else
			CT_RA_ProcessSpellCast(spellName, UnitName("target"));
		end
	end
end
CastSpellByName = CT_RA_newCastSpellByName;

CT_RA_oldWorldFrameOnMouseDown = WorldFrame:GetScript("OnMouseDown");
WorldFrame:SetScript("OnMouseDown", function()
	-- If we're waiting to target
	local targetName;
	
	if ( CT_RA_SpellSpell and UnitName("mouseover") ) then
		targetName = UnitName("mouseover");
	elseif ( CT_RA_SpellSpell and GameTooltipTextLeft1:IsVisible() ) then
		local _, _, name = string.find(GameTooltipTextLeft1:GetText(), "^Corpse of (.+)$");
		if ( name ) then
			targetName = name;
		end
	end
	if ( CT_RA_oldWorldFrameOnMouseDown ) then
		CT_RA_oldWorldFrameOnMouseDown();
	end
	if ( CT_RA_SpellSpell and targetName ) then
		CT_RA_ProcessSpellCast(CT_RA_SpellSpell, targetName);
	end
end);

CT_RA_oldUseAction = UseAction;
function CT_RA_newUseAction(a1, a2, a3)
	
	CT_RADST:SetAction(a1);
	local spellName = CT_RADSTTextLeft1:GetText();
	CT_RA_SpellSpell = spellName;
	
	-- Call the original function
	CT_RA_oldUseAction(a1, a2, a3);
	
	-- Test to see if this is a macro
	if ( GetActionText(a1) or not CT_RA_SpellSpell ) then
		return;
	end
	
	if ( SpellIsTargeting() ) then
		-- Spell is waiting for a target
		return;
	elseif ( a3 ) then
		-- Spell is being cast on the player
		CT_RA_ProcessSpellCast(spellName, UnitName("player"));
	elseif ( UnitExists("target") ) then
		-- Spell is being cast on the current target
		CT_RA_ProcessSpellCast(spellName, UnitName("target"));
	end
end
UseAction = CT_RA_newUseAction;

CT_RA_oldSpellTargetUnit = SpellTargetUnit;
function CT_RA_newSpellTargetUnit(unit)
	-- Call the original function
	local shallTargetUnit;
	if ( SpellIsTargeting() ) then
		shallTargetUnit = true;
	end
	CT_RA_oldSpellTargetUnit(unit);
	if ( shallTargetUnit and CT_RA_SpellSpell and not SpellIsTargeting() ) then
		CT_RA_ProcessSpellCast(CT_RA_SpellSpell, UnitName(unit));
		CT_RA_SpellSpell = nil;
	end
end
SpellTargetUnit = CT_RA_newSpellTargetUnit;

CT_RA_oldSpellStopTargeting = SpellStopTargeting;
function CT_RA_newSpellStopTargeting()
	CT_RA_oldSpellStopTargeting();
	CT_RA_SpellSpell = nil;
end
SpellStopTargeting = CT_RA_newSpellStopTargeting;

CT_RA_oldTargetUnit = TargetUnit;
function CT_RA_newTargetUnit(unit)
	-- Call the original function
	CT_RA_oldTargetUnit(unit);
	
	-- Look to see if we're currently waiting for a target internally
	-- If we are, then well glean the target info here.
	
	if ( CT_RA_SpellSpell and UnitExists(unit) ) then
		CT_RA_ProcessSpellCast(CT_RA_SpellSpell, UnitName(unit));
	end
end
TargetUnit = CT_RA_newTargetUnit;

function CT_RA_ProcessSpellCast(spellName, targetName)
	if ( spellName and targetName ) then
		CT_RA_SpellCast = { spellName, targetName };
	end
end

function CT_RADetectSpells_OnLoad()
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
end

function CT_RADetectSpells_OnEvent(event)
	if ( event == "SPELLCAST_START" ) then
		if ( CT_RA_SpellCast and CT_RA_SpellCast[1] == arg1 ) then
			CT_RA_SpellStartCast(CT_RA_SpellCast);
		end
	elseif ( event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" ) then
		CT_RA_SpellEndCast();
		CT_RA_SpellCast =  nil;
		CT_RA_SpellSpell =  nil;
	end
end