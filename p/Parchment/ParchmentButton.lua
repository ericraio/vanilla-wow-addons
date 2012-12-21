function ParchmentButton_OnClick()
	ToggleParchment();
end

function ParchmentButton_Init()
	if(Parchment_Config.ButtonShow == false) then
		ParchmentButtonFrame:Hide();
	end
end

function ParchmentButton_UpdatePosition()
	ParchmentButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		52 - (80 * cos(Parchment_Config.ButtonPos)),
		(80 * sin(Parchment_Config.ButtonPos)) - 52
	);
end