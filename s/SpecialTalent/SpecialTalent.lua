function SpecialTalentFrame_LoadUI()
	UIParentLoadAddOn("SpecialTalentUI");
end

function ToggleTalentFrame()
	SpecialTalentFrame_LoadUI();
	if ( SpecialTalentFrame_Toggle ) then
		SpecialTalentFrame_Toggle();
	else
		TalentFrame_LoadUI();
		if ( TalentFrame_Toggle ) then
			TalentFrame_Toggle();
		end
	end
end

function UpdateTalentButton()
--[[ Always show talent button
	if ( UnitLevel("player") < 10 ) then
		TalentMicroButton:Hide();
		QuestLogMicroButton:SetPoint("BOTTOMLEFT", "TalentMicroButton", "BOTTOMLEFT", 0, 0);
	else	
		TalentMicroButton:Show();
		QuestLogMicroButton:SetPoint("BOTTOMLEFT", "TalentMicroButton", "BOTTOMRIGHT", -2, 0);
	end
--]]
end

local oldUpdateMicroButtons = UpdateMicroButtons;
function UpdateMicroButtons()
	oldUpdateMicroButtons();
	if ( (SpecialTalentFrame and SpecialTalentFrame:IsVisible()) or (TalentFrame and TalentFrame:IsVisible()) ) then
		TalentMicroButton:SetButtonState("PUSHED", 1);
	else
		TalentMicroButton:SetButtonState("NORMAL");
	end
end