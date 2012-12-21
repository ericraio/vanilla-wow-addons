---------------------------------------------------------------------------------------------------
-- From TimeStamp
----------------------------------------------------------------------------------------------------

-- C O L O R   P I C K E R   F U N C T I O N S --
-- Opens a color picker for the timestamp color
function ChatBox_TimeStamp_ColorPicker()
	-- Get the current color
	local color = ChatBox.TimeStamp_Settings.color;
	local r, g, b;

	-- Set the current red, green, blue values
	if (color and string.find(color, "%x%x%x%x%x%x")) then
		-- Convert the hexadecimal number into seperate floats for each color channel
		r = tonumber(string.sub(color, 1, 2), 16) / 255.0;
		g = tonumber(string.sub(color, 3, 4), 16) / 255.0;
		b = tonumber(string.sub(color, 5, 6), 16) / 255.0;
	else
		-- There was no color specified, so fall back to white
		r = 1.0;
		g = 1.0;
		b = 1.0;
	end

	-- Set up color picker values and events
	ColorPickerFrame.previousValue  =  color;
	ColorPickerFrame.func           =  ChatBox_TimeStamp_ColorPicker_Update;
	ColorPickerFrame.cancelFunc     =  ChatBox_TimeStamp_ColorPicker_Cancel;
	ColorPickerFrame.hasOpacity     =  false;
	ColorPickerFrame:SetColorRGB(r, g, b);

	-- Show the color picker
	ShowUIPanel(ColorPickerFrame);
end

-- Event triggered when the color in the color picker is changed
function ChatBox_TimeStamp_ColorPicker_Update()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	ChatBox.TimeStamp_Settings.color = ChatBox_TimeStamp_FloatColorsToHex(r, g, b);
end

-- Event triggered when cancel button on the color picker is clicked
function ChatBox_TimeStamp_ColorPicker_Cancel()
	ChatBox.TimeStamp_Settings.color = ColorPickerFrame.previousValue;
end

-- Converts a color in the format of 3 floats in the range 0.0 - 1.0 into
-- one hexadecimal number with a fixed size of 6 digits (2 per float)
function ChatBox_TimeStamp_FloatColorsToHex(r, g, b)
	return string.format("%02X%02X%02X", r * 255.0, g * 255.0, b * 255.0);
end