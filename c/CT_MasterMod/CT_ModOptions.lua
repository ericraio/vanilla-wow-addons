function CT_OptionButton_OnClick(button)
	if ( button == "RightButton" ) then
		if ( CT_MF_ShowFrames ) then
			CT_SetModStatus(CT_MASTERMOD_MODNAME_UNLOCK, "off");
			CT_MF_ShowFrames = nil;
		else
			CT_SetModStatus(CT_MASTERMOD_MODNAME_UNLOCK, "on");
			CT_MF_ShowFrames = 1;
		end
		CT_LockMovables(CT_MF_ShowFrames);
	else
		if ( CT_CPFrame:IsVisible() ) then
			HideUIPanel(CT_CPFrame);
		else
			ShowUIPanel(CT_CPFrame);
		end
	end
end

CT_CPBPosition = 256;

function CT_OptionBar_MoveButton()
	CT_OptionButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(CT_CPBPosition)), (80 * sin(CT_CPBPosition)) - 52);
end

CT_oldToggleMinimap = ToggleMinimap;
function CT_newToggleMinimap()
	CT_oldToggleMinimap();
	if ( Minimap:IsVisible() ) then
		CT_OptionButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(CT_CPBPosition)), (80 * sin(CT_CPBPosition)) - 52);
	else
		CT_OptionButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 130, -31);
	end
end
ToggleMinimap = CT_newToggleMinimap;