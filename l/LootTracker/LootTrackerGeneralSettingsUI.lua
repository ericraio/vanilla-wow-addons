--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerGeneralSettingsUI.lua
--
-- Code behind the general settings UI
--===========================================================================--


------------------------------------------------------------------------------
-- ShowChatColorPicker
------------------------------------------------------------------------------

function LT_ShowChatColorPicker()

    local color = LT_White;
	
	-- Get our current chat color
	local settings = LT_GetSettings();
	if (settings ~= nil) then
	    color = settings.ChatColor;
	end

	-- Initialize the color picker
	ColorPickerFrame.func           =  LT_ColorPickerUpdate;
	ColorPickerFrame.cancelFunc     =  LT_ColorPickerCancel;
	ColorPickerFrame.hasOpacity     =  false;
	ColorPickerFrame.previousValue  =  color;
	ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
	
	-- Show the color picker
	ColorPickerFrame:Show();

end


------------------------------------------------------------------------------
-- ColorPickerUpdate
------------------------------------------------------------------------------

function LT_ColorPickerUpdate()
    local color = {}
	color.r, color.g, color.b = ColorPickerFrame:GetColorRGB();
	
	-- Set the new chat color
	local settings = LT_GetSettings();
	if (settings ~= nil) then
	    settings.ChatColor = color;
	end
end


------------------------------------------------------------------------------
-- ColorPickerCancel
------------------------------------------------------------------------------

function LT_ColorPickerCancel()
    -- Reset the value
	local settings = LT_GetSettings();
	if (settings ~= nil) then
	    settings.ChatColor = ColorPickerFrame.previousValue;
	end
end
