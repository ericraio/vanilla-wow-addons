function DUF_SetDefaultUIHooks()
	DUF_Old_UnitFrameHealthBar_Update = UnitFrameHealthBar_Update;
	UnitFrameHealthBar_Update = DUF_UnitFrameHealthBar_Update;
	DUF_Old_UnitFrameManaBar_Update = UnitFrameManaBar_Update;
	UnitFrameManaBar_Update = DUF_UnitFrameManaBar_Update;
	DUF_Old_PlayerFrame_OnEvent = PlayerFrame_OnEvent;
	PlayerFrame_OnEvent = DUF_PlayerFrame_OnEvent;
	DUF_Old_PetFrame_OnEvent = PetFrame_OnEvent;
	PetFrame_OnEvent = DUF_PetFrame_OnEvent;
	DUF_Old_UnitFrame_OnEvent = UnitFrame_OnEvent;
	UnitFrame_OnEvent = DUF_UnitFrame_OnEvent;
	DUF_Old_PartyMemberFrame_OnEvent = PartyMemberFrame_OnEvent;
	PartyMemberFrame_OnEvent = DUF_PartyMemberFrame_OnEvent;
	DUF_Old_ShowPartyFrame = ShowPartyFrame;
	ShowPartyFrame = DUF_ShowPartyFrame;
	DUF_Old_TargetFrame_OnEvent = TargetFrame_OnEvent;
	TargetFrame_OnEvent = DUF_TargetFrame_OnEvent;
	DUF_Old_ComboPointsFrame_OnEvent = ComboPointsFrame_OnEvent;
	ComboPointsFrame_OnEvent = DUF_ComboPointsFrame_OnEvent;
end

function DUF_CheckByUnit(unit)
	if (unit == "player") then
		if (not DUF_Settings[DUF_INDEX].player.showDefault) then return; end
	elseif (string.find(unit, "partypet")) then
		if (not DUF_Settings[DUF_INDEX].partypet.showDefault) then return; end
	elseif (string.find(unit, "party")) then
		if (not DUF_Settings[DUF_INDEX].party.showDefault) then return; end
	elseif (unit == "pet") then
		if (not DUF_Settings[DUF_INDEX].pet.showDefault) then return; end
	elseif (unit == "target") then
		if (not DUF_Settings[DUF_INDEX].target.showDefault) then return; end
	end
	return true;
end

function DUF_UnitFrameHealthBar_Update(frame, unit)
	if (DUF_CheckByUnit(unit)) then
		DUF_Old_UnitFrameHealthBar_Update(frame, unit);
	end
end

function DUF_UnitFrameManaBar_Update(frame, unit)
	if (DUF_CheckByUnit(unit)) then
		DUF_Old_UnitFrameManaBar_Update(frame, unit);
	end
end

function DUF_PlayerFrame_OnEvent(event)
	if (DUF_Settings[DUF_INDEX].player.showDefault) then
		DUF_Old_PlayerFrame_OnEvent(event);
	end
end

function DUF_PetFrame_OnEvent(event)
	if (DUF_Settings[DUF_INDEX].pet.showDefault) then
		DUF_Old_PetFrame_OnEvent(event);
	end
end

function DUF_UnitFrame_OnEvent(event)
	if (DUF_CheckByUnit(this.unit)) then
		DUF_Old_UnitFrame_OnEvent(event);
	end
end

function DUF_PartyMemberFrame_OnEvent(event)
	if (DUF_Settings[DUF_INDEX].party.showDefault) then
		DUF_Old_PartyMemberFrame_OnEvent(event);
	end
end

function DUF_ShowPartyFrame()
	if (DUF_Settings[DUF_INDEX].party.showDefault) then
		DUF_Old_ShowPartyFrame();
	end
end

function DUF_TargetFrame_OnEvent(event)
	if (DUF_Settings[DUF_INDEX].target.showDefault) then
		DUF_Old_TargetFrame_OnEvent(event);
	end
end

function DUF_ComboPointsFrame_OnEvent()
	if (DUF_Settings[DUF_INDEX].target.showDefault) then
		DUF_Old_ComboPointsFrame_OnEvent(event);
	end
end