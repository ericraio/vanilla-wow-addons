-- Function hooks
CT_RA_oldCastSpell = CastSpell;
function CT_RA_newCastSpell(spellId,spellbookTabNum)
	CT_RA_oldCastSpell(spellId,spellbookTabNum);
	CT_RADetectSpells_ParseSpellTooltip(spellId,spellbookTabNum);
end
CastSpell = CT_RA_newCastSpell;

function CT_RADetectSpells_ParseSpellTooltip(spellId,spellbookTabNum)
	CT_RA_CastSpell = nil;
	CT_RADST:SetSpell(spellId,spellbookTabNum);
	CT_RA_SpellBeingCast = CT_RADSTTextLeft1:GetText();
end

CT_RA_oldSpellTargetUnit = SpellTargetUnit;
function CT_RA_newSpellTargetUnit(unit)
	CT_RA_oldSpellTargetUnit(unit);
	if ( CT_RA_SpellBeingCast ) then
		CT_RA_SpellTarget = unit;
		CT_RA_CastSpell = { CT_RA_SpellBeingCast, UnitName(unit), unit };
		CT_RA_SpellStartCast(CT_RA_CastSpell);
		CT_RA_SpellBeingCast = nil;
	end
end
SpellTargetUnit = CT_RA_newSpellTargetUnit;

CT_RA_oldUseAction = UseAction;
function CT_RA_newUseAction(a1, a2, a3)
	CT_RA_oldUseAction(a1, a2, a3);
	CT_RADetectSpells_ParseSpellActionTooltip(a1);
	if ( a3 and a3 == 1 ) then
		CT_RA_SpellTarget = "player";
		CT_RA_CastSpell = { CT_RA_SpellBeingCast, UnitName("player"), "player" };
		CT_RA_SpellStartCast(CT_RA_CastSpell);
		CT_RA_SpellBeingCast = nil;
	end
end
UseAction = CT_RA_newUseAction;

CT_RA_oldTargetUnit = TargetUnit;
function CT_RA_newTargetUnit(unit)
	if ( SpellIsTargeting() and SpellCanTargetUnit(unit) ) then
		CT_RA_SpellTarget = unit;
		CT_RA_CastSpell = { CT_RA_SpellBeingCast, UnitName(unit), unit };
		CT_RA_SpellStartCast(CT_RA_CastSpell);
		CT_RA_SpellBeingCast = nil;
	end
	CT_RA_oldTargetUnit(unit);
end
TargetUnit = CT_RA_newTargetUnit;

function CT_RADetectSpells_OnLoad()
	this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
end

function CT_RADetectSpells_OnEvent(event)
	if ( event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		if ( CT_RA_SpellBeingCast ) then
			if ( not CT_RA_CastSpell ) then
				CT_RA_CanTarget = SpellCanTargetUnit("target");
				CT_RADetectSpellFrame.update = 0.05;
			end
		end
	elseif ( event == "SPELLCAST_START" ) then
		if ( CT_RA_SpellBeingCast ) then
			if ( UnitExists("target") ) then
				CT_RA_CastSpell = { CT_RA_SpellBeingCast, UnitName("target"), "target" };
				CT_RA_SpellStartCast(CT_RA_CastSpell);
				CT_RA_SpellBeingCast = nil;
			else
				CT_RA_CastSpell = { CT_RA_SpellBeingCast, UnitName("player"), "player" };
				CT_RA_SpellStartCast(CT_RA_CastSpell);
				CT_RA_SpellBeingCast = nil;
			end
		end
	elseif ( event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" ) then
		CT_RA_SpellEndCast();
		CT_RA_CastSpell = nil;
		CT_RA_SpellBeingCast = nil;
	end
end

function CT_RADetectSpells_OnUpdate(elapsed)
	if ( this.update ) then
		this.update = this.update - elapsed;
		if ( this.update <= 0 ) then
			if ( not CT_RA_CastSpell and UnitExists("target") and CT_RA_SpellBeingCast and CT_RA_CanTarget ) then
				CT_RA_CastSpell = { CT_RA_SpellBeingCast, UnitName("target"), "target" };
				CT_RA_SpellStartCast(CT_RA_CastSpell);
			elseif ( not CT_RA_CastSpell and UnitExists("mouseover") and CT_RA_SpellBeingCast and not SpellIsTargeting() ) then
				CT_RA_CastSpell = { CT_RA_SpellBeingCast, UnitName("mouseover"), "mouseover" };
				CT_RA_SpellStartCast(CT_RA_CastSpell);
			elseif ( GameTooltip:IsVisible() and CT_RA_SpellBeingCast and not SpellIsTargeting() and GameTooltipTextLeft1:GetText() ) then
				local _, _, player = string.find(GameTooltipTextLeft1:GetText(), "^Corpse of (.+)$");
				if ( player ) then
					CT_RA_CastSpell = { CT_RA_SpellBeingCast, player, nil };
					CT_RA_SpellStartCast(CT_RA_CastSpell);
				end
			end
			CT_RA_SpellBeingCast = nil;
			CT_RA_CanTarget = nil;
			this.update = nil;
		end
	end
end

function CT_RADetectSpells_ParseSpellActionTooltip(action)
	CT_RA_CastSpell = nil;
	CT_RADST:SetAction(action);
	CT_RA_SpellBeingCast = CT_RADSTTextLeft1:GetText();
end