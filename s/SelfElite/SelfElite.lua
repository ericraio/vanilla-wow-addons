--
-- base unitframe handler
--
function SelfEliteFrameHandler(unittype)
	if( unittype == "elite" ) then
		PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
	elseif( unittype == "rare" ) then
		PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
	elseif( unittype == "raremob" ) then
		PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-RareMob");
	elseif( unittype == "normal" ) then
		PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
	else
		PlayerFrameTexture:SetTexture(nil);
	end
end

function SelfEliteChangeFrameType(checked,value)
	if (value == 1) then
		SelfEliteFrameHandler("normal");
	elseif (value == 2) then
		SelfEliteFrameHandler("rare");
	elseif (value == 3) then
		SelfEliteFrameHandler("elite");
	elseif (value == 4) then
		SelfEliteFrameHandler("raremob");
	elseif (value == 5) then
		SelfEliteFrameHandler();
	end
end

function SelfElite_Onload()
	if (UltimateUI_RegisterConfiguration) then
		-- Example of Section
		-- ========================
		UltimateUI_RegisterConfiguration(
			"UUI_SELFELITE", -- prefix that all options that should go in this section have to start with
			"SECTION",    -- Type
			"Self Elite",  -- Section Label
			"Change your player frame!" -- Mouseover
		);
		-- Example of Separator
		-- ========================
		UltimateUI_RegisterConfiguration(
			"UUI_SELFELITE_SEPARATOR", 	-- Keyword
			"SEPARATOR",    	-- Type
			"SelfElite Options",  	-- Separator Label
			"Options for SelfElite" -- Mouseover
		);
		UltimateUI_RegisterConfiguration(
			"UUI_SELFELITE_TYPE",		-- CVar
			"SLIDER",					-- Type
			"Set your frame type",		-- Short description
			"This slider sets the frame type you want.",	-- Long description
			SelfEliteChangeFrameType,	-- Callback
			1,						-- Default Checked/Unchecked
			1,		-- Default slider value
			1,		-- Minimum slider value
			5, 		-- max value
			"Frame number type", 	-- slider "header" text
			1,						-- Slider steps
			1,						-- Text on slider?
			"",						-- slider text append
			1						-- slider multiplier
		);
	end
end
