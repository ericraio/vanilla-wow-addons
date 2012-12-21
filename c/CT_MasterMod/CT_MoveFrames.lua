local parts = { "Head", "Shoulders", "Chest", "Wrists", "Hands", "Waist", "Legs", "Feet", "Weapon", "Shield", "OffWeapon", "Ranged" };

function CT_DurabilityVisible()
	for key, val in parts do
		if ( getglobal("Durability" .. val):IsVisible() ) then
			return 1;
		end
	end
	return nil;
end

function CT_CastBarFrame_OnLoad()
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_DELAYED");
	CT_CastBarFrame_Update();
end

function CT_CastBarFrame_OnEvent(event)
	if ( event == "SPELLCAST_CHANNEL_START" ) then
		CT_CastBarFrame.spellName = arg2;
	elseif ( event == "SPELLCAST_START" ) then
		CT_CastBarFrame.spellName = arg1;
	end
	if ( event == "SPELLCAST_CHANNEL_START" or event == "SPELLCAST_CHANNEL_UPDATE" or event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" or event == "SPELLCAST_START" or event == "SPELLCAST_INTERUPTED" or event == "SPELLCAST_DELAYED" ) then
		CT_CastBarFrame_Update();
	end
end

CT_CastBarFrame_oldCastingBarFrame_OnUpdate = CastingBarFrame_OnUpdate;
function CT_CastBarFrame_newCastingBarFrame_OnUpdate(elapsed)
	CT_CastBarFrame_oldCastingBarFrame_OnUpdate(elapsed);
	local doDisplay;
	if ( CT_Mods[CT_MASTERMOD_MODNAME_CASTTIME] and CT_Mods[CT_MASTERMOD_MODNAME_CASTTIME]["modStatus"] == "on" ) then
		doDisplay = 1;
	end
	if ( CastingBarFrame.casting ) then
		if ( doDisplay ) then
			CastingBarText:SetText(CT_CastBarFrame.spellName .. string.format(" (%.1fs)", CastingBarFrame.maxValue - GetTime() ) );
		else
			CastingBarText:SetText(CT_CastBarFrame.spellName);
		end
	elseif ( CastingBarFrame.channeling ) then
		if ( doDisplay ) then
			CastingBarText:SetText(CT_CastBarFrame.spellName .. string.format(" (%.1fs)", CastingBarFrame.endTime - GetTime() ) );
		else
			CastingBarText:SetText(CT_CastBarFrame.spellName);
		end
	end
end
CastingBarFrame_OnUpdate = CT_CastBarFrame_newCastingBarFrame_OnUpdate;

local function castingtimefunc(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_Print(CT_MASTERMOD_CASTTIMEON, 1, 1, 0);
	else
		CT_Print(CT_MASTERMOD_CASTTIMEOFF, 1, 1, 0);
	end
end
CT_RegisterMod(CT_MASTERMOD_MODNAME_CASTTIME, CT_MASTERMOD_SUBNAME_CASTTIME, 4, "Interface\\Icons\\INV_Misc_PocketWatch_03", CT_MASTERMOD_TOOLTIP_CASTTIME, "off", nil, castingtimefunc);

CT_AddMovable("CT_CastBarFrame", CT_MASTERMOD_MOVABLE_CASTBAR, "BOTTOM", "BOTTOM", "UIParent", 0, 135, function(status)
	if ( status and CastingBarFrameStatusBar:IsVisible() ) then
		CT_CastBarFrame:Show();
	else
		CT_CastBarFrame:Hide();
	end
end, CT_CastBarFrame_Update);


CT_AddMovable("CT_QuestWatch_Drag", CT_MASTERMOD_MOVABLE_QUESTTRACKER, "TOPRIGHT", "TOPRIGHT", "UIParent", -200, -425, function(status)
	if ( status ) then
		CT_QuestWatch_Drag:Show()
	else
		CT_QuestWatch_Drag:Hide();
	end
end);
CT_AddMovable("CT_Durability_Drag", CT_MASTERMOD_MOVABLE_DURABILITYDOLL, "TOP", "TOP", "UIParent", 0, 0, function(status)
	if ( status ) then
		CT_Durability_Drag:Show()
	else
		CT_Durability_Drag:Hide();
	end
end);

function CT_CastBarFrame_Update()
	if ( CastingBarFrameStatusBar:IsVisible() ) then
		if ( not CT_CastBarFrame:IsVisible() ) then
			CastingBarFlash:ClearAllPoints();
			CastingBarFlash:SetPoint("TOP", "CT_CastBarFrame", "TOP", 0, 20);
			CastingBarText:ClearAllPoints();
			CastingBarText:SetPoint("TOP", "CT_CastBarFrame", "TOP", 0, -3);
			CastingBarFrameStatusBar:ClearAllPoints();
			CastingBarFrameStatusBar:SetPoint("CENTER", "CT_CastBarFrame", "CENTER", 0, -3);

			CastingBarFrame:ClearAllPoints();
			CastingBarFrame:SetPoint("TOP", "CT_CastBarFrame", "TOP", 0, -8);
			if ( CT_MF_ShowFrames ) then
				CT_CastBarFrame:Show();
			end
		end
	else
		CT_CastBarFrame:Hide();
	end
end