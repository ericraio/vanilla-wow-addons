local IMBA_Active=true;
function IMBA_OptionButton_OnClick(button)
	if ( button == "RightButton" ) then
		if ( IMBA_SavedVariables.LockedWindows ) then
			IMBA_UnlockWindows();
			GameTooltip:SetText("IMBA Mod Options\nRight-click to lock frames");
		else
			IMBA_LockWindows()
			GameTooltip:SetText("IMBA Mod Options\nRight-click to unlock frames");
		end
	else
		if IsControlKeyDown()  then
			if IMBA_Active then
				IMBA_CloseAllWindows();
				IMBA_Main:Hide();
				IMBA_OptionButtonTexture:SetTexture("Interface\\AddOns\\IMBA\\textures\\icon_no");
				IMBA_Active=false;
				DEFAULT_CHAT_FRAME:AddMessage("IMBA is Deactivated", 1.0, 1.0, 0.0);
			else
				IMBA_Main:Show();
				IMBA_OptionButtonTexture:SetTexture("Interface\\AddOns\\IMBA\\textures\\icon");
				IMBA_Active=true;
				DEFAULT_CHAT_FRAME:AddMessage("IMBA is Activated", 1.0, 1.0, 0.0);
			end
		else
			if ( IMBA_Options:IsVisible() ) then
				IMBA_Options:Hide();
			else
				IMBA_Options:Show();
			end
		end
	end
end

IMBA_SavedVariables.ButtonPos = 300;

function IMBA_OptionButton_MoveButton()
	IMBA_OptionButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(IMBA_SavedVariables.ButtonPos)), (80 * sin(IMBA_SavedVariables.ButtonPos)) - 52);
end