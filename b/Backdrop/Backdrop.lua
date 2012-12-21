--[[ random notes

	Frame:SetBackdrop([backdropTable]) - Set the backdrop of the frame according to the specification provided - New in 1700. 
	Frame:SetBackdropBorderColor(r,g,b)
	Frame:SetBackdropColor(r,g,b) 
	
	Frame:StartSizing("RIGHT");
	Frame:SetBackdrop({bgFile = "Interface\Tooltips\UI-Tooltip-Background", edgeFile = "Interface\Tooltips\UI-Tooltip-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
   
   handlerFunction = Frame:GetScript("handler") - (for handlers like "OnShow", "OnEnter", etc) which returns the current event handler for a frame.
   Frame:SetScript("handler", function) - sets the action/event handler for a frame (or removes it with a nil function)
   
   UltimateUI_UpdateValue("UUI_VAR_NAME",CSM_CHECKONOFF,1);
   UltimateUIMaster_Save();
]]

-- defaults
EnableBackdrops = 0;
LockAllBackdrops = 0;

BackdropRed = 0;
BackdropGreen = 0;
BackdropBlue = 0;
BackdropAlpha = 0;

function UUIBackdrop_OnEvent(event)
--	if (event == "VARIABLES_LOADED") then
		if (UltimateUI_RegisterConfiguration) then
			Backdrop_RegisterUltimateUI();
		end
--	end
end

function ForceBackdropEnable()
	UltimateUI_UpdateValue("UUI_BACKDROP_ENABLE",CSM_CHECKONOFF,1);
	UltimateUIMaster_Save();
end

function ForceBackdropLock()
	UltimateUI_UpdateValue("UUI_BACKDROP_LOCKALL",CSM_CHECKONOFF,1);
	UltimateUIMaster_Save();
end

function ShowAllBackdrops()
	UUIBackdropFrame1:Show();
	UUIBackdropFrame2:Show();
	UUIBackdropFrame3:Show();
	UUIBackdropFrame4:Show();
	UUIBackdropFrame5:Show();
	UUIBackdropFrame6:Show();
	UUIBackdropFrame7:Show();
end

function HideAllBackdrops()
	UUIBackdropFrame1:Hide();
	UUIBackdropFrame2:Hide();
	UUIBackdropFrame3:Hide();
	UUIBackdropFrame4:Hide();
	UUIBackdropFrame5:Hide();
	UUIBackdropFrame6:Hide();
	UUIBackdropFrame7:Hide();
end

function Backdrop_ToggleLock(toggle)
	if (toggle) then
		LockAllBackdrops = toggle;
		if (LockAllBackdrops == 1) then
			LockAllBackdrops = 0;
		elseif (LockAllBackdrops == 0) then
			LockAllBackdrops = 1;
		else
			LockAllBackdrops = 1;
			ChatFrame1:AddMessage("All Backdrops locked. (returned other than 1 or 0)",info.r, info.g, info.b);
		end
		toggle = nil;
	end
end

function ToggleEnableBackdrops(toggle)
	if (toggle) then
		EnableBackdrops  = toggle;
		if (EnableBackdrops == 0) then
			EnableBackdrops = 1;
			ShowAllBackdrops();
		elseif (EnableBackdrops == 1) then
			EnableBackdrops = 0;
			HideAllBackdrops();
		end
	end
end

function UUIBackdropAllColorSlider_ChangeRed(checked,value)
	if (value) then
		BackdropRed = value;
		UUIBackdropFrame1:SetBackdropColor(value,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame2:SetBackdropColor(value,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame3:SetBackdropColor(value,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame4:SetBackdropColor(value,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame5:SetBackdropColor(value,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame6:SetBackdropColor(value,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame7:SetBackdropColor(value,BackdropGreen,BackdropBlue,BackdropAlpha);
	else
		ChatFrame1:AddMessage("value returned nil",info.r, info.g, info.b);
	end
end

function UUIBackdropAllColorSlider_ChangeGreen(checked,value)
	if (value) then
		BackdropGreen = value;
		UUIBackdropFrame1:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame2:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame3:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame4:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame5:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame6:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame7:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
	else
		ChatFrame1:AddMessage("value returned nil",info.r, info.g, info.b);
	end
end

function UUIBackdropAllColorSlider_ChangeBlue(checked,value)
	if (value) then
		BackdropBlue = value;
		UUIBackdropFrame1:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame2:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame3:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame4:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame5:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame6:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame7:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
	else
		ChatFrame1:AddMessage("value returned nil",info.r, info.g, info.b);
	end
end

function UUIBackdropAllColorSlider_ChangeAlpha(checked,value)
	if (value) then
		BackdropAlpha = value;
		UUIBackdropFrame1:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame2:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame3:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame4:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame5:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame6:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
		UUIBackdropFrame7:SetBackdropColor(BackdropRed,BackdropGreen,BackdropBlue,BackdropAlpha);
	end
end

--[[
function UUIBackdropAllBorderType(checked,value)
	if (value == 1) then
		UUIBackdropFrame1:SetBackdrop({bgFile = "Interface\Tooltips\UI-Tooltip-Background", edgeFile = "Interface\Tooltips\UI-Tooltip-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	elseif (value == 2) then
		UUIBackdropFrame1:SetBackdrop({bgFile = "Interface\DialogFrame\UI-DialogBox-Background", edgeFile = "Interface\DialogFrame\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	else
		ChatFrame1:AddMessage("this shouldn't happen");
	end
end
]]

function UUIBackdropChangeNumber(checked,value)
	if (value) then
		if (value == 0) then
			UUIBackdropFrame1:Hide();
			UUIBackdropFrame2:Hide();
			UUIBackdropFrame3:Hide();
			UUIBackdropFrame4:Hide();
			UUIBackdropFrame5:Hide();
			UUIBackdropFrame6:Hide();
			UUIBackdropFrame7:Hide();
		elseif (value == 1) then
			UUIBackdropFrame1:Show();
			UUIBackdropFrame2:Hide();
			UUIBackdropFrame3:Hide();
			UUIBackdropFrame4:Hide();
			UUIBackdropFrame5:Hide();
			UUIBackdropFrame6:Hide();
			UUIBackdropFrame7:Hide();
		elseif (value == 2) then
			UUIBackdropFrame2:Show();
			UUIBackdropFrame3:Hide();
			UUIBackdropFrame4:Hide();
			UUIBackdropFrame5:Hide();
			UUIBackdropFrame6:Hide();
			UUIBackdropFrame7:Hide();
		elseif (value == 3) then
			UUIBackdropFrame3:Show();
			UUIBackdropFrame4:Hide();
			UUIBackdropFrame5:Hide();
			UUIBackdropFrame6:Hide();
			UUIBackdropFrame7:Hide();
		elseif (value == 4) then
			UUIBackdropFrame4:Show();
			UUIBackdropFrame5:Hide();
			UUIBackdropFrame6:Hide();
			UUIBackdropFrame7:Hide();
		elseif (value == 5) then
			UUIBackdropFrame5:Show();
			UUIBackdropFrame6:Hide();
			UUIBackdropFrame7:Hide();
		elseif (value == 6) then
			UUIBackdropFrame6:Show();
			UUIBackdropFrame7:Hide();
		elseif (value == 7) then
			UUIBackdropFrame7:Show();
		else
			ChatFrame1:AddMessage("This shouldn't happen.",r,g,b);		
		end
	end
end

function Backdrop_RegisterUltimateUI()
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP", -- prefix that all options that should go in this section have to start with
			"SECTION",    -- Type
			"Backdrops",  -- Section Label
			"Add Backdrops anywhere on the screen!" -- Mouseover
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_SEPARATOR", 	-- Keyword
			"SEPARATOR",    	-- Type
			"Backdrop Options",  	-- Separator Label
			"Options for all backdrops" -- Mouseover
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_ENABLE",		-- CVar
			"CHECKBOX",				-- Type
			"Disable All Backdrops",		-- Short description
			"Disables the use of Backdrops that can be shaped to any size and placed anywhere on the screen",	-- Long description
			ToggleEnableBackdrops,			-- Callback
			1					-- Default Checked/Unchecked
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_LOCKALL",		-- CVar
			"CHECKBOX",				-- Type
			"Unlock All Backdrops",		-- Short description
			"Unlocks all Backdrops so they can be moved and resized",	-- Long description
			Backdrop_ToggleLock,			-- Callback
			1					-- Default Checked/Unchecked
		);
		--[[
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_BORDERTYPE",		-- CVar
			"SLIDER",					-- Type
			"Set the bordertype",		-- Short description
			"This sliders sets the type of border you want for all backdrops",	-- Long description
			UUIBackdropAllBorderType,	-- Callback
			1,						-- Default Checked/Unchecked
			1,		-- Default slider value
			1,		-- Minimum slider value
			2, 		-- max value
			"Border Type", 	-- slider "header" text
			1,						-- Slider steps
			1,						-- Text on slider?
			"",						-- slider text append
			1						-- slider multiplier
		);
		]]
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_SEPARATORCOLOR", 	-- Keyword
			"SEPARATOR",    	-- Type
			"Backdrop Colors",  	-- Separator Label
			"Coloring for all backdrops" -- Mouseover
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_COLORALL_RED",		-- CVar
			"SLIDER",					-- Type
			"Color all backdrops: [R]",		-- Short description
			"This sliders sets the R value for the color of all the backdrops at the same time.",	-- Long description
			UUIBackdropAllColorSlider_ChangeRed,	-- Callback
			1,						-- Default Checked/Unchecked
			0,		-- Default slider value
			0,		-- Minimum slider value
			1, 		-- max value
			"R Value", 	-- slider "header" text
			.01,						-- Slider steps
			1,						-- Text on slider?
			"",						-- slider text append
			1						-- slider multiplier
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_COLORALL_GREEN",		-- CVar
			"SLIDER",					-- Type
			"Color all backdrops: [G]",		-- Short description
			"This sliders sets the G value for the color of all the backdrops at the same time.",	-- Long description
			UUIBackdropAllColorSlider_ChangeGreen,	-- Callback
			1,						-- Default Checked/Unchecked
			0,		-- Default slider value
			0,		-- Minimum slider value
			1, 		-- max value
			"G Value", 	-- slider "header" text
			.01,						-- Slider steps
			1,						-- Text on slider?
			"",						-- slider text append
			1						-- slider multiplier
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_COLORALL_BLUE",		-- CVar
			"SLIDER",					-- Type
			"Color all backdrops: [B]",		-- Short description
			"This sliders sets the B value for the color of all the backdrops at the same time.",	-- Long description
			UUIBackdropAllColorSlider_ChangeBlue,	-- Callback
			1,						-- Default Checked/Unchecked
			0,		-- Default slider value
			0,		-- Minimum slider value
			1, 		-- max value
			"B Value", 	-- slider "header" text
			.01,						-- Slider steps
			1,						-- Text on slider?
			"",						-- slider text append
			1						-- slider multiplier
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_COLORALL_ALPHA",		-- CVar
			"SLIDER",					-- Type
			"Color all backdrops: [A]",		-- Short description
			"This sliders sets the ALPHA value for the color of all the backdrops at the same time.",	-- Long description
			UUIBackdropAllColorSlider_ChangeAlpha,	-- Callback
			1,						-- Default Checked/Unchecked
			0,		-- Default slider value
			0,		-- Minimum slider value
			1, 		-- max value
			"Alpha Value", 	-- slider "header" text
			.01,						-- Slider steps
			1,						-- Text on slider?
			"",						-- slider text append
			1						-- slider multiplier
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_SEPARATORHIDE", 	-- Keyword
			"SEPARATOR",    	-- Type
			"Backdrop Toggling",  	-- Separator Label
			"Toggling for each individual backdrop" -- Mouseover
		);
		UltimateUI_RegisterConfiguration(
			"UUI_BACKDROP_HIDEBACKDROPS",		-- CVar
			"SLIDER",					-- Type
			"Number of backdrops to use:",		-- Short description
			"This sliders sets the number of backdrops which should be shown on the screen.",	-- Long description
			UUIBackdropChangeNumber,	-- Callback
			1,						-- Default Checked/Unchecked
			0,		-- Default slider value
			0,		-- Minimum slider value
			7, 		-- max value
			"Backdrops Used:", 	-- slider "header" text
			1,						-- Slider steps
			1,						-- Text on slider?
			"",						-- slider text append
			1						-- slider multiplier
		);
end


function UUIBackdrop_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:SetBackdropBorderColor(1,1,1,1);
	this:SetBackdropColor(1,0,0,.7);
end

function Backdrop_OnMouseUp(arg1)
	this:StopMovingOrSizing();
end

function Backdrop_OnMouseDown(arg1)
	if (LockAllBackdrops == 0) then
		if (IsShiftKeyDown()) then
			if(arg1 == "LeftButton") then
				this:StartSizing("TOP");
			elseif(arg1 == "RightButton") then
				this:StartSizing("BOTTOM");
			else
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage("arg1 returned: "..arg1);
				end
			end
		elseif (IsControlKeyDown()) then
			if(arg1 == "LeftButton") then
				this:StartSizing("LEFT");
			elseif(arg1 == "RightButton") then
				this:StartSizing("RIGHT");
			else
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage("arg1 returned: "..arg1);
				end
			end
		else
			this:StartMoving();
		end
	end
end