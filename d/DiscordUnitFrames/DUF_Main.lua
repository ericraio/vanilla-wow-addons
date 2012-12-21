function DUF_ComboPoints_Update()
	local comboPoints = GetComboPoints();
	if (DUF_OPTIONS_VISIBLE) then
		if (UnitClass("player") == DUF_TEXT.Rogue or UnitClass("player") == DUF_TEXT.Druid) then
			comboPoints = 5;
		end
	end
	if (comboPoints < 1 or DUF_Settings[DUF_INDEX].target.ComboPoints.hide) then
		DUF_TargetFrame_ComboPoints:Hide();
		return;
	else
		DUF_TargetFrame_ComboPoints:Show();
	end
	local comboPoint;
	for i=1,5 do
		comboPoint = getglobal("DUF_TargetFrame_ComboPoints_"..i);
		if (i <= comboPoints) then
			comboPoint:Show();
		else
			comboPoint:Hide();
		end
	end
	if (comboPoints > 0) then
		local height, width;
		local size = DUF_Settings[DUF_INDEX].target.ComboPoints.size;
		local spacing = DUF_Settings[DUF_INDEX].target.ComboPoints.spacing;
		local padding = DUF_Settings[DUF_INDEX].target.ComboPoints.bgpadding * 2;
		if (DUF_Settings[DUF_INDEX].target.ComboPoints.vertical) then
			height = size * comboPoints + spacing * (comboPoints - 1);
			width = size;
		else
			height = size;
			width = size * comboPoints + spacing * (comboPoints - 1);
		end
		DUF_TargetFrame_ComboPoints:SetHeight(height);
		DUF_TargetFrame_ComboPoints:SetWidth(width);
		DUF_TargetFrame_ComboPoints_Background:SetHeight(height + padding);
		DUF_TargetFrame_ComboPoints_Background:SetWidth(width + padding);
	end
end

function DUF_Load_Options()
	if (DUF_Options) then return; end
	UIParentLoadAddOn("DiscordUnitFramesOptions");
	DL_Set_OptionsTitle("DUF_Options", "DiscordUnitFrames\\Icons\\title", DUF_VERSION);
	DUF_Initialize_VariablesFrame();
	DUF_FRAME_INDEX = "player";
	DUF_SelectFrame_OnClick("player", DUF_Options_Self);
	DUF_Options_SelectFrameOptions();
	DUF_OPTIONS_SELECTED = "DUF_ElementOptions_BaseSelect";
	DUF_ElementOptions_BaseSelect:SetTextColor(1, 0, 0);
	DUF_ElementOptions_BaseSelect:SetBackdropColor(1, 1, 0);
	DUF_ElementOptions_BaseSelect:SetBackdropBorderColor(1, 1, 1);
	DUF_Update_SavedSettings();
	DUF_Options_SetScale();
	DUF_Init_ContextColors();
	DUF_Init_MiscOptions();
end

function DUF_Main_OnEvent(event)
	if (not DUF_INITIALIZED) then return; end
	if (event == "PARTY_MEMBERS_CHANGED") then
		DUF_Main_UpdatePartyMembers();
	elseif (event == "PLAYER_COMBO_POINTS") then
		DUF_ComboPoints_Update();
	elseif (event == "PLAYER_PVP_KILLS_CHANGED" or event == "PLAYER_PVP_RANK_CHANGED") then
		DUF_HonorBar_Update();
	elseif (event == "PLAYER_TARGET_CHANGED") then
		if (UnitName("target")) then
			if (not DUF_Settings[DUF_INDEX].target.hide) then
				DUF_TargetFrame:Show();
				DUF_Set_EliteTexture();
			end
			if (DL_UnitName("targettarget")) then
				if (not DUF_Settings[DUF_INDEX].targettarget.hide) then
					if (DUF_Settings[DUF_INDEX].hidetargettarget) then
						if (GetNumRaidMembers() + GetNumPartyMembers() > 0) then
							DUF_TargetOfTargetFrame:Show();
						end
					else
						DUF_TargetOfTargetFrame:Show();
					end
				end
			end
		else
			DUF_TargetFrame:Hide();
			DUF_TargetOfTargetFrame:Hide();
		end
		DUF_ComboPoints_Update();
		if (not DUF_Settings[DUF_INDEX].target.showDefault) then
			if (MI2_MobHealthFrame) then
				MI2_MobHealthFrame:Hide();
			end
			if (MobHealthFrame) then
				MobHealthFrame:Hide();
			end
		end
	elseif (event == "PLAYER_XP_UPDATE" or event == "PLAYER_UPDATE_RESTING") then
		if (not DUF_Settings[DUF_INDEX].player.StatusBar[3].trackRep) then
			DUF_XPBar_Update();
		end
	elseif (event == "UPDATE_FACTION") then
		if (DUF_Settings[DUF_INDEX].player.StatusBar[3].trackRep) then
			DUF_XPBar_Update();
		end
		if (DUF_Settings[DUF_INDEX].player.StatusBar[6].trackRep) then
			DUF_HonorBar_Update();
		end
	elseif (event == "PLAYER_LEVEL_UP") then
		DUF_XPBar_Update();
	elseif (event == "RAID_ROSTER_UPDATE") then
		DUF_Main_UpdatePartyMembers();
	elseif (event == "UNIT_HAPPINESS") then
		DUF_HappinessIcon_Update();
	elseif (event == "UNIT_PET") then
		if (UnitExists("pet") and (not DUF_Settings[DUF_INDEX].pet.hide)) then
			DUF_PetFrame:Show();
			DUF_HappinessIcon_Update();
		else
			DUF_PetFrame:Hide();
		end
		for i=1,4 do
			getglobal("DUF_PartyPetFrame"..i):Hide();
		end
		if (DUF_Settings[DUF_INDEX].hidepartyinraid) then
			if (GetNumRaidMembers() > 0) then
				return;
			end
		end
		for i=1,GetNumPartyMembers() do
			if (UnitName("partypet"..i) and UnitExists("partypet"..i) and (not DUF_Settings[DUF_INDEX].partypet.hide)) then
				getglobal("DUF_PartyPetFrame"..i):Show();
			end
		end
	elseif (event == "UNIT_PET_EXPERIENCE") then
		DUF_PetXPBar_Update();
	end
end

function DUF_Main_OnLoad()
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("PLAYER_FLAGS_CHANGED");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("PLAYER_PVP_KILLS_CHANGED");
	this:RegisterEvent("PLAYER_PVP_RANK_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_UPDATE_RESTING");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("UNIT_HAPPINESS");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("UNIT_PET_EXPERIENCE");
	this:RegisterEvent("UPDATE_EXHAUSTION");
	this:RegisterEvent("UPDATE_FACTION");

	DiscordLib_RegisterInitFunc(DUF_Initialize);

	SlashCmdList["DUF"] = DUF_Slash_Handler;
	SLASH_DUF1 = "/duf";
	SLASH_DUF2 = "/discordunitframes";
end

function DUF_Main_OnUpdate(elapsed)
	if (not DUF_INITIALIZED) then return; end
	if (DL_UnitName("targettarget") and (not DUF_TargetOfTargetFrame:IsVisible())) then
		if (not DUF_Settings[DUF_INDEX].targettarget.hide) then
			if (DUF_Settings[DUF_INDEX].hidetargettarget) then
				if (GetNumRaidMembers() + GetNumPartyMembers() > 0) then
					DUF_TargetOfTargetFrame:Show();
				end
			else
				DUF_TargetOfTargetFrame:Show();
			end
		end
	elseif ((not DL_UnitName("targettarget")) and (not DUF_OPTIONS_VISIBLE)) then
		this.targettarget = nil;
		DUF_TargetOfTargetFrame:Hide();
	elseif (this.targettarget ~= DL_UnitName("targettarget")) then
		this.targettarget = DL_UnitName("targettarget");
		if (not DUF_Settings[DUF_INDEX].targettarget.hide) then
			DUF_TargetOfTargetFrame:Hide();
			if (DUF_Settings[DUF_INDEX].hidetargettarget) then
				if (GetNumRaidMembers() + GetNumPartyMembers() > 0) then
					DUF_TargetOfTargetFrame:Show();
				end
			else
				DUF_TargetOfTargetFrame:Show();
			end
		end
	end
	local min,max = GetPetExperience();
	if (min ~= this.minpetxp or max ~= this.maxpetxp) then
		this.minpetxp = min;
		this.maxpetxp = max;
		DUF_PetXPBar_Update();
	end
end

function DUF_Main_UpdatePartyMembers()
	for i=1,4 do
		getglobal("DUF_PartyFrame"..i):Hide();
		getglobal("DUF_PartyPetFrame"..i):Hide();
	end
	if (not DUF_Settings[DUF_INDEX].party.hide) then
		if (DUF_Settings[DUF_INDEX].hidepartyinraid) then
			if (GetNumRaidMembers() > 0) then
				return;
			end
		end
		for i=1, GetNumPartyMembers() do
			getglobal("DUF_PartyFrame"..i):Show();
			if (DL_UnitName("partypet"..i) and UnitExists("partypet"..i) and (not DUF_Settings[DUF_INDEX].partypet.hide)) then
				getglobal("DUF_PartyPetFrame"..i):Show();
			end
		end
	end
end

function DUF_Options_LoadDefaultSettings(toggle)
	if (not DUF_DEFAULT_SETTINGS) then
		DL_Feedback(DUF_TEXT.NoDefaultSettings);
		return;
	end
	DUF_Settings[DUF_INDEX] = {nil};
	DL_Copy_Table(DUF_DEFAULT_SETTINGS, DUF_Settings[DUF_INDEX]);
	DUF_Settings[DUF_PLAYER_INDEX] = DUF_INDEX;
	if (not toggle) then
		DUF_Initialize_NewSettings();
		DUF_Initialize_AllFrames();
		DL_Feedback(DUF_TEXT.DefaultSettingsLoaded);
	end
end

function DUF_Options_LoadSettings(index, safe)
	if (not index) then
		index = DUF_LOADINDEX;
	end
	if (index == "" or (not index)) then
		return;
	end
	if (not DUF_Settings[index]) then
		DL_Feedback(DUF_TEXT.NoSettingsFound);
		return;
	end
	if (index == DUF_INDEX) then return; end
	DUF_Settings[DUF_PLAYER_INDEX] = index;
	DUF_INDEX = index;
	DUF_Initialize_NewSettings();
	if (safe) then
		ReloadUI();
	else
		DUF_Initialize_AllFrames();
		DL_Feedback(DUF_TEXT.SettingsLoaded);
	end
	if (DUF_Options) then
		DUF_MiscOptions_CurrentProfile:SetText(DUF_TEXT.CurrentProfile..":  "..DUF_INDEX);
		DUF_MiscOptions_LoadSettings_Setting:SetText("");
	end
end

function DUF_Options_SetUpdateSpeed()
	DUF_Settings[DUF_INDEX].updatespeed = 1 / DUF_Settings[DUF_INDEX].updatespeedbase;
end

function DUF_Slash_Handler(msg)
	local command, param;
	local index = string.find(msg, " ");
	if( index) then
		command = string.sub(msg, 1, (index - 1));
		param = string.sub(msg, (index + 1)  );
	else
		command = msg;
	end
	
	if (not DUF_Options) then
		DUF_Load_Options();
	end
	if (DUF_Options:IsVisible()) then
		DUF_Options:Hide();
	else
		DUF_Options:Show();
	end
end

function DUF_Init_DropDown(dropDown, unitFrame, unit)
	dropDown:SetParent(unitFrame);
	dropDown.unit = unit;
	dropDown.point = "TOPLEFT";
	dropDown.relativePoint = "TOPLEFT";
--	local right = unitFrame:GetRight() + dropDown:GetRight();
--	if (right > UIParent:GetRight()) then
--		DUF_FRAME_DATA[unit].upx = -dropDown:GetWidth();
--	else
		DUF_FRAME_DATA[unit].upx = unitFrame:GetWidth();
--	end
end

function DUF_Uninit_DropDown(dropDown, unitFrame)
	dropDown:SetParent(unitFrame);
	dropDown.point = nil;
	dropDown.relativePoint = nil;
end

function DUF_Toggle_DefaultFrames()
	if (not DUF_INITIALIZED) then return; end
	if (not DUF_Settings[DUF_INDEX].player.showDefault) then
		PlayerFrame:Hide();
		DUF_Init_DropDown(PlayerFrameDropDown, DUF_PlayerFrame, "player");
	else
		PlayerFrame:Show();
		DUF_Uninit_DropDown(PlayerFrameDropDown, PlayerFrame);
	end
	if (DUF_Settings[DUF_INDEX].pet.showDefault) then
		if (DL_UnitName("pet")) then
			PetFrame:Show();
		end
		DUF_Uninit_DropDown(PetFrameDropDown, PetFrame);
	else
		PetFrame:Hide();
		DUF_Init_DropDown(PetFrameDropDown, DUF_PetFrame, "pet");
	end
	if (not DUF_Settings[DUF_INDEX].party.showDefault) then
		local partyframe;
		for i=1,4 do
			partyframe = getglobal("PartyMemberFrame"..i);
			partyframe:Hide();
			DUF_Init_DropDown(getglobal("PartyMemberFrame"..i.."DropDown"), getglobal("DUF_PartyFrame"..i), "party"..i);
		end
	else
		for i = 1, GetNumPartyMembers() do
			getglobal("PartyMemberFrame"..i):Show();
		end
		for i=1,4 do
			DUF_Uninit_DropDown(getglobal("PartyMemberFrame"..i.."DropDown"), "PartyMemberFrame"..i);
		end
	end
	if (not DUF_Settings[DUF_INDEX].partypet.showDefault) then
		local partyframe;
		for i=1,4 do
			partyframe = getglobal("PartyMemberFrame"..i.."PetFrame");
			partyframe:Hide();
		end
	else
		for i = 1, GetNumPartyMembers() do
			if (DL_UnitName("partypet"..i)) then
				getglobal("PartyMemberFrame"..i.."PetFrame"):Show();
			end
		end
	end	
	if (not DUF_Settings[DUF_INDEX].target.showDefault) then
		TargetFrame:Hide();	
		DUF_Init_DropDown(TargetFrameDropDown, DUF_TargetFrame, "target");
	else
		if (DL_UnitName("target")) then
			TargetFrame:Show();
		end
		DUF_Uninit_DropDown(TargetFrameDropDown, TargetFrame);
	end
end

function DUF_Toggle_ElementsLock()
	if (DUF_ELEMENTS_UNLOCKED) then
		DUF_ELEMENTS_UNLOCKED = nil;
		if (DUF_Options) then
			DUF_Options_ToggleElements:SetText(DUF_TEXT.UnlockElements);
		end
		if (not DUF_FRAMES_UNLOCKED) then
			if (GB_PlayerBar) then
				DUF_HIDING_CLICKBOXES = nil;
				if (not GB_Settings[GB_INDEX].hideClickboxes) then
					GB_PlayerClickbox:Show();
					if (DL_UnitName("pet")) then
						GB_Pet0Clickbox:Show();
					end
					for i=1, GetNumPartyMembers() do
						getglobal("GB_Party"..i.."Clickbox"):Show();
						if (DL_UnitName("partypet"..i)) then
							getglobal("GB_Pet"..i.."Clickbox"):Show();
						end
					end
					if (DL_UnitName("target")) then
						GB_TargetClickbox:Show();
					end
				end
			end
		end
	else
		DUF_ELEMENTS_UNLOCKED = 1;
		if (DUF_Options) then
			DUF_Options_ToggleElements:SetText(DUF_TEXT.LockElements);
		end
		if (GB_PlayerBar) then
			DUF_HIDING_CLICKBOXES = true;
			for _, frame in GB_CLICKBOXES do
				getglobal(frame):Hide();
			end
		end
	end
end

function DUF_Toggle_FramesLock()
	if (DUF_FRAMES_UNLOCKED) then
		DUF_FRAMES_UNLOCKED = nil;
		if (DUF_Options) then
			DUF_Options_ToggleFrames:SetText(DUF_TEXT.UnlockFrames);
		end
		if (not DUF_ELEMENTS_UNLOCKED) then
			if (GB_PlayerBar) then
				DUF_HIDING_CLICKBOXES = nil;
				if (not GB_Settings[GB_INDEX].hideClickboxes) then
					GB_PlayerClickbox:Show();
					if (DL_UnitName("pet")) then
						GB_Pet0Clickbox:Show();
					end
					for i=1, GetNumPartyMembers() do
						getglobal("GB_Party"..i.."Clickbox"):Show();
						if (DL_UnitName("partypet"..i)) then
							getglobal("GB_Pet"..i.."Clickbox"):Show();
						end
					end
					if (DL_UnitName("target")) then
						GB_TargetClickbox:Show();
					end
				end
			end
		end
	else
		DUF_FRAMES_UNLOCKED = 1;
		if (DUF_Options) then
			DUF_Options_ToggleFrames:SetText(DUF_TEXT.LockFrames);
		end
		if (GB_PlayerBar) then
			DUF_HIDING_CLICKBOXES = true;
			for _, frame in GB_CLICKBOXES do
				getglobal(frame):Hide();
			end
		end
	end
end