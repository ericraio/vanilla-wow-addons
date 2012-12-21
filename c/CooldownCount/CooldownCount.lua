--[[
	Cooldown Count

	By sarf

	This mod allows you to see the amount of time left until the cooldown expires on an action button.

	Thanks goes to Drex of the #cosmostesters channel for suggesting this!

	$Id$
	$Rev$
	$LastChangedBy$
	$Date$
	
	
   ]]

-- Constants
COOLDOWNCOUNT_CUTOFF_TIME = 2; -- how many seconds the cooldown has to be for CooldownCount to be displayed
COOLDOWNCOUNT_HOUR_MINUTES_FORMAT_LIMIT = 3600;
COOLDOWNCOUNT_MINUTES_SECONDS_FORMAT_LIMIT = 60;

COOLDOWNCOUNT_WIDTH = 64;
COOLDOWNCOUNT_HEIGHT = 32;

-- how many seconds between updates
COOLDOWNCOUNT_UPDATE_TIME = 0.25;

-- how many seconds the flashing will occur (maximum)
COOLDOWNCOUNT_MAXIMUM_FLASH_TIME = 10;

-- Variables
CooldownCount_NoSpaces = 0;
CooldownCount_Enabled = 0;
CooldownCount_UseLongTimerDescriptions = 0;
CooldownCount_UseLongTimerDescriptionsForSeconds = 0;
CooldownCount_TimeBetweenFlashes = 0.5;
CooldownCount_HideUntilTimeLeft = 0;
CooldownCount_RogueStealth = 0;

CooldownCount_Saved_CooldownFrame_SetTimer = nil;
CooldownCount_Cosmos_Registered = 0;

CooldownCount_LastUpdate = 0;

CooldownCount_UserScale = 2;

CooldownCount_FramesAndTheirButtonNames = {
};

CooldownCountColorDefaultNormal = { 1.0, 0.82, 0.0 };
CooldownCountColorDefaultFlash = { 1.0, 0.12, 0.12 };
CooldownCountAlpha = 1.0;

CooldownCountOptions = { 
	color = { 
		normal = { 1.0, 0.82, 0.0 }; 
		flash = { 1.0, 0.12, 0.12 };
	};
	alpha = 1.0;
};

CooldownCount_ButtonNames = {
	"ActionButton", "BonusActionButton", 
	"MultiBarBottomLeftButton", "MultiBarBottomRightButton", "MultiBarRightButton", "MultiBarLeftButton",
};





CooldownCount_DisplayValues_WithSpace = nil;
CooldownCount_DisplayValues_WithoutSpace = nil;

function CooldownCount_PrecalcDisplayValues()
	CooldownCount_DisplayValues_WithSpace = {};
	CooldownCount_DisplayValues_WithoutSpace = {};
	for i = 1, 60 do 
		CooldownCount_DisplayValues_WithSpace[i] = i.."";
		CooldownCount_DisplayValues_WithoutSpace[i] = i.."";
		CooldownCount_DisplayValues_WithSpace[i*60] = i.." m";
		CooldownCount_DisplayValues_WithoutSpace[i*60] = i.."m";
	end
	for i = 1, 96 do 
		CooldownCount_DisplayValues_WithSpace[i*60*60] = i.." h";
		CooldownCount_DisplayValues_WithoutSpace[i*60*60] = i.."h";
	end
end

-- executed on load, calls general set-up functions
function CooldownCount_OnLoad()
	CooldownCount_PrecalcDisplayValues();
	CooldownCount_Register();
	local f = CooldownCountFrame;
	f:RegisterEvent("VARIABLES_LOADED");
end

function CooldownCount_SetFlashSpeed(speed, quiet)
	if ( speed ) then
		if ( speed ~= CooldownCount_TimeBetweenFlashes ) then
			if ( not quiet ) then
				CooldownCount_Print(format(COOLDOWNCOUNT_CHAT_FLASHSPEED, speed));
			end
			CooldownCount_TimeBetweenFlashes = speed;
		end
	end
end

function CooldownCount_SetHideUntilTimeLeft(value, quiet)
	if ( value ) then
		if ( CooldownCount_HideUntilTimeLeft ~= value ) then
			if ( not quiet ) then
				CooldownCount_Print(format(COOLDOWNCOUNT_CHAT_HIDEUNTILTIMELEFT, value));
			end
			CooldownCount_HideUntilTimeLeft = value;
			CooldownCount_DoUpdate(true);
		end
	end
end

function CooldownCount_SetUserScale(scale, quiet)
	if ( scale ) then
		if ( scale ~= CooldownCount_UserScale ) then
			if ( not quiet ) then
				CooldownCount_Print(format(COOLDOWNCOUNT_CHAT_USERSCALE, scale));
			end
			CooldownCount_UserScale = scale;
			CooldownCount_DoUpdate(true);
		end
	end
end

function CooldownCount_CooldownFrame_SetTimer(this, start, duration, enable)
	CooldownCount_Saved_CooldownFrame_SetTimer(this, start, duration, enable);
	CooldownCount_UpdateCooldownCount(this, start, duration, enable);
end

function CooldownCount_GenerateButtonUpdateList()
	local updateList = {};
	local name = nil;
	for k, v in CooldownCount_ButtonNames do
		for i = 1, 12 do
			name = v..i;
			if ( getglobal(name) ) then
				table.insert(updateList, name);
			end
		end
	end
	return updateList;
end

CooldownCount_ButtonUpdateList = nil;

function CooldownCount_RegenerateList()
	CooldownCount_ButtonUpdateList = CooldownCount_GenerateButtonUpdateList();
end

function CooldownCount_DoUpdate(force)
	local curTime = GetTime();
	if ( not CooldownCount_ButtonUpdateList ) then
		CooldownCount_RegenerateList();
	end
	for k, v in CooldownCount_ButtonUpdateList do
		CooldownCount_DoUpdateCooldownCount(v, force);
	end
	CooldownCount_LastUpdate = curTime;
end

function CooldownCount_OnUpdate(elapsed)
	local curTime = GetTime();
	if ( ( CooldownCount_LastUpdate ) and ( CooldownCount_LastUpdate > 0 ) ) then
		if ( ( CooldownCount_LastUpdate + COOLDOWNCOUNT_UPDATE_TIME) < curTime ) then
			CooldownCount_DoUpdate();
		end
	else
		CooldownCount_LastUpdate = curTime;
	end
end

function CooldownCount_GetFormattedNumber(number)
	if (strlen(number) < 2 ) then
		return "0"..number;
	else
		return number;
	end
end

function CooldownCount_GetFormattedTime(time)
	local newTime = math.floor(time);
	
	local formattedTime = "";
	
	local arr = CooldownCount_DisplayValues_WithSpace;
	if ( CooldownCount_NoSpaces == 1 ) then arr = CooldownCount_DisplayValues_WithoutSpace; end
	if ( newTime > COOLDOWNCOUNT_HOUR_MINUTES_FORMAT_LIMIT ) then
		local hours = 0;
		
		if ( CooldownCount_UseLongTimerDescriptions == 1 ) then
			hours = math.floor((newTime / 3600));
			local minutes = math.floor( (( newTime - ( 3600 * hours ) )  / 60) + 0.5 );
			formattedTime = format(COOLDOWNCOUNT_HOUR_MINUTES_FORMAT, hours, CooldownCount_GetFormattedNumber(minutes));
		else
			hours = math.floor((newTime / 3600)+0.5);
			--formattedTime = format(COOLDOWNCOUNT_HOURS_FORMAT, hours);
			formattedTime = arr[hours*3600];
		end
		
	elseif ( newTime > COOLDOWNCOUNT_MINUTES_SECONDS_FORMAT_LIMIT ) then
		local minutes = 0;
		if ( CooldownCount_UseLongTimerDescriptions == 1 ) then
			minutes = math.floor( ( newTime  / 60 ));
			local seconds = math.ceil( newTime - ( 60 * minutes ));
			formattedTime = format(COOLDOWNCOUNT_MINUTES_SECONDS_FORMAT, minutes, CooldownCount_GetFormattedNumber(seconds));
		else
			minutes = math.ceil( ( newTime  / 60 ));
			--formattedTime = format(COOLDOWNCOUNT_MINUTES_FORMAT, minutes);
			formattedTime = arr[minutes*60];
		end
	else
		--[[
		if ( CooldownCount_UseLongTimerDescriptionsForSeconds == 1 ) then
			formattedTime = format(COOLDOWNCOUNT_SECONDS_LONG_FORMAT, newTime);
		else
			--formattedTime = format(COOLDOWNCOUNT_SECONDS_FORMAT, newTime);
			formattedTime = arr[newTime];
		end
		]]--
		formattedTime = format(COOLDOWNCOUNT_SECONDS_FORMAT, newTime);
	end
	
	return formattedTime;
end	

--/script CooldownCount_CooldownFrame_SetTimer(getglobal("SecondActionButton3Cooldown"), 544630, 300, 1);
--/script getglobal("SecondActionButton3CooldownCount"):SetText("15"); getglobal("SecondActionButton3CooldownCount"):Show();
--/script Print(getglobal("SecondActionButton3CooldownCount"):GetText());

CooldownCount_OneLetterScale = 1.5;
CooldownCount_TwoLetterScale = 1;
CooldownCount_ThreeLetterScale = 0.66;
CooldownCount_FourLetterScale = 0.5;

CooldownCount_PrecalculatedSizes = {
	[1] = 1,
	[2] = 0.8,
	[3] = 0.7,
	[4] = 0.5,
	[5] = 0.4
};

function CooldownCount_GetAppropriateScale(newTime, noAutoScale)
	if ( not newTime ) then
		newTime = "";
	end
	local lenWithoutSpaces = strlen(string.gsub(newTime, " ", ""));
	local len = strlen(newTime);
	local lenSpaces = len-lenWithoutSpaces;
	local scale = (2 / (lenWithoutSpaces + floor(lenSpaces/2)));
	if ( noAutoScale ) then 
		scale = 1; 
	else
		if ( lenWithoutSpaces < len ) then
			scale = (2 / len);
		end
		if ( CooldownCount_PrecalculatedSizes[len] ) then
			scale = CooldownCount_PrecalculatedSizes[len];
		else
			for k, v in CooldownCount_PrecalculatedSizes do
				if ( k >= len ) then
					scale = v;
					break;
				end
			end
		end
	end
	if ( scale > 1 ) then scale = 1; end
	if ( CooldownCount_UserScale ) and ( CooldownCount_UserScale > 0 ) then 
		scale = scale * CooldownCount_UserScale;
	end
	if ( not noAutoScale ) then if ( scale > 2 ) then scale = 2; end end
	if ( noAutoScale ) then if ( scale > 2 ) then scale = 2; end end
	return scale;
end

CooldownCount_BasePosition = "CENTER";
CooldownCount_RelativeToPosition = "CENTER";

function CooldownCount_DoUpdateCooldownCount(name, force)
	local cooldownName = name.."Cooldown";
	local parent = getglobal(name);
	local icon = getglobal(name.."Icon");
	local buttonCooldown = getglobal(cooldownName);
	local cooldownCount = getglobal(cooldownName.."Count");
	local cooldownCountFrame = getglobal(cooldownName.."CountFrame");
	
	local debug = false;
	
	if ( ( ( not parent ) or ( not parent:IsVisible() ) ) or ( ( icon ) and ( not icon:IsVisible() ) ) ) then
		if ( cooldownCount ) then
			cooldownCount:Hide();
		end
		if ( cooldownCountFrame ) then
			cooldownCountFrame:Hide();
		end
		return;
	else
		local frameLevel = parent:GetFrameLevel();
		if ( cooldownCountFrame ) then
			cooldownCountFrame:SetFrameLevel(frameLevel+4);
		end
		if ( cooldownCount ) then
			cooldownCount:SetWidth(COOLDOWNCOUNT_WIDTH);
			cooldownCount:SetHeight(COOLDOWNCOUNT_HEIGHT);
		end
	end

	local cooldownCountValuesName = (cooldownName.."CountValues");
	local cooldownCountValues = getglobal(cooldownCountValuesName);
	if ( not cooldownCountValues ) then
		if ( cooldownCount ) then
			cooldownCount:Hide();
		end
		if ( cooldownCountFrame ) then
			cooldownCountFrame:Hide();
		end
		return;
	end
	local start = cooldownCountValues[1];
	local duration = cooldownCountValues[2];
	local enable = cooldownCountValues[3];
	if ( (CooldownCount_Enabled == 1) and ( start > 0 and duration > 0) ) then
		local remainingTimeCutOff = COOLDOWNCOUNT_CUTOFF_TIME;
		local remainingTime = -1;
		local flashTimeMax = COOLDOWNCOUNT_MAXIMUM_FLASH_TIME;
		local flashTime = duration / 4;
		if ( flashTime > flashTimeMax ) then
			flashTime = flashTimeMax;
		end
		
		if ( start <= 0 ) then
			remainingTime = -1;
		else
			remainingTime = ceil(( start + duration ) - GetTime());
		end
		
		if ( ( cooldownCount ) and ( cooldownCountFrame ) ) then
			--Print(format("Remaining time : %d", remainingTime));
			if ( ( not cooldownCount:IsVisible() ) and ( duration <= remainingTimeCutOff ) ) then
				--if ( debug ) then Print("cut off engaged lixom"); end
				return;
			end
			if ( ( remainingTime <= 0 ) ) then
				if ( cooldownCount:IsVisible() ) then
					cooldownCount:Hide();
				end
				if ( cooldownCountFrame:IsVisible() ) then
					cooldownCountFrame:Hide();
				end
			else
				if ( CooldownCount_HideUntilTimeLeft > 0 ) then
					if ( CooldownCount_HideUntilTimeLeft < remainingTime ) then
						cooldownCount:Hide();
						return;
					else
						cooldownCount:Show();
					end
				end
				local newTime = CooldownCount_GetFormattedTime(remainingTime)
				if ( ( cooldownCount.flashing ) ) then
					if ( ( not cooldownCount.flashTime ) or ( (cooldownCount.flashTime + CooldownCount_TimeBetweenFlashes) < GetTime() ) ) then
						if ( cooldownCount.flashingon ) then
							local r, g, b = unpack(CooldownCountOptions.color.normal);
							cooldownCount:SetVertexColor(r, g, b);
							cooldownCount.flashingon = false;
						else
							local r, g, b = unpack(CooldownCountOptions.color.flash);
							cooldownCount:SetVertexColor(r, g, b);
							cooldownCount.flashingon = true;
						end
						cooldownCount.flashTime = GetTime();
					end
				else
					local r, g, b = unpack(CooldownCountOptions.color.normal);
					cooldownCount:SetVertexColor(r, g, b);
					newTimeString = newTime;
				end
				--Print(format("NewTime : %s", newTime));
				cooldownCount:SetAlpha(CooldownCountOptions.alpha);
				
				local oldTime = cooldownCount:GetText();
				
				if ( newTime ~= oldTime ) or ( force ) then
					cooldownCount:SetText(newTime);
					local oldScale = getglobal(cooldownName.."CountFrameScale");
					if ( not oldScale ) then
						oldScale = cooldownCountFrame:GetScale();
						setglobal(cooldownName.."CountFrameScale", oldScale);
					end
					local noAutoScale = false;
					local newScale = oldScale * CooldownCount_GetAppropriateScale(newTime, noAutoScale);
					cooldownCountFrame:SetScale(newScale);
					local oldWidth = getglobal(cooldownName.."CountFrameWidth");
					if ( not oldWidth ) then
						oldWidth = cooldownCountFrame:GetWidth();
						setglobal(cooldownName.."CountFrameWidth", oldWidth);
					end
					local newWidth = newScale * oldWidth;
					if ( newWidth < 32 ) then newWidth = 32; end
					cooldownCountFrame:SetWidth(newWidth);
					cooldownCount:SetWidth(newWidth);
					local oldHeight = getglobal(cooldownName.."CountFrameHeight");
					if ( not oldHeight ) then
						oldHeight = cooldownCountFrame:GetHeight();
						setglobal(cooldownName.."CountFrameHeight", oldHeight);
					end
					local newHeight = newScale * oldHeight;
					if ( newHeight < 10 ) then newHeight = 10; end
					cooldownCountFrame:SetHeight(newHeight);
					cooldownCount:SetHeight(newHeight);
				end
				
				if ( remainingTime <= flashTime ) then
					cooldownCount.flashing = true;
				else
					cooldownCount.flashing = false;
				end
				
				if ( ( cooldownCount.flashingQWEQWE ) ) then
					if ( not cooldownCount:IsVisible() ) then
						cooldownCount:Show();
					else
						cooldownCount:Hide();
					end
					if ( not cooldownCountFrame:IsVisible() ) then
						cooldownCountFrame:Show();
					else
						cooldownCountFrame:Hide();
					end
				else
					if ( not cooldownCount:IsVisible() ) then
						cooldownCount:Show();
					end
					if ( not cooldownCountFrame:IsVisible() ) then
						cooldownCountFrame:Show();
					end
				end
			end
		end
	else
		if ( cooldownCount ) then
			cooldownCount:Hide();
		end
		if ( cooldownCountFrame ) then
			cooldownCountFrame:Hide();
		end
	end
end

function CooldownCount_OldUpdateCooldownCount(this, start, duration, enable)
	local cooldownCount = getglobal(this:GetName().."Count");
	local cooldownCountFrame = getglobal(this:GetName().."CountFrame");
	local cooldownCountValuesName = (this:GetName().."CountValues");
	local cooldownCountValues = { start, duration, enable };
	if ( cooldownCount ) then
		setglobal(cooldownCountValuesName, cooldownCountValues);
	end
	--CooldownCount_DoUpdateCooldownCount(this:GetName());
end

function CooldownCount_UpdateCooldownCount(this, start, duration, enable)
 	local cooldownCount = getglobal(this:GetName().."Count");
	local cooldownCountFrame = getglobal(this:GetName().."CountFrame");
	local cooldownCountValuesName = (this:GetName().."CountValues");
	if (not getglobal(cooldownCountValuesName)) then
		setglobal(cooldownCountValuesName, {});
	end
	if ( cooldownCount ) then
		getglobal(cooldownCountValuesName)[1] = start;
		getglobal(cooldownCountValuesName)[2] = duration;
		getglobal(cooldownCountValuesName)[3] = enable;
	end
end


-- Hooks/unhooks functions. If toggle is 1, hooks functions, otherwise it unhooks functions.
--  Hooking functions mean that you replace them with your own functions and then call the 
--  original function at your leisure.
function CooldownCount_Setup_Hooks(toggle)
	if ( toggle == 1 ) then
		if ( ( CooldownFrame_SetTimer ~= CooldownCount_CooldownFrame_SetTimer ) and (CooldownCount_Saved_CooldownFrame_SetTimer == nil) ) then
			CooldownCount_Saved_CooldownFrame_SetTimer = CooldownFrame_SetTimer;
			CooldownFrame_SetTimer = CooldownCount_CooldownFrame_SetTimer;
		end
	else
		if ( CooldownFrame_SetTimer == CooldownCount_CooldownFrame_SetTimer) then
			CooldownFrame_SetTimer = CooldownCount_Saved_CooldownFrame_SetTimer;
			CooldownCount_Saved_CooldownFrame_SetTimer = nil;
		end
	end
end

-- Handles events
function CooldownCount_OnEvent(event)
	if ( event == "ACTIONBAR_PAGE_CHANGED" ) then
		CooldownCount_DoUpdate();
		return;
	end
	if ( event == "VARIABLES_LOADED" ) then
		if ( CooldownCount_Cosmos_Registered == 0 ) then
			CooldownCount_LoadOptions();
		end
		if ( CooldownCount_RogueStealth == 1 ) or ( UnitClass("player") ~= COOLDOWNCOUNT_CLASS_ROGUE ) then
			table.insert(CooldownCount_ButtonNames, "ShapeshiftButton");
			CooldownCount_RegenerateList();
		end
		return;
	end
end

function CooldownCount_Toggle_UseLongTimers(toggle)
	local oldvalue = CooldownCount_UseLongTimerDescriptions;
	local newvalue = toggle;
	if ( ( toggle ~= 1 ) and ( toggle ~= 0 ) ) then
		if (oldvalue == 1) then
			newvalue = 0;
		elseif ( oldvalue == 0 ) then
			newvalue = 1;
		else
			newvalue = 0;
		end
	end
	CooldownCount_UseLongTimerDescriptions = newvalue;
	if ( newvalue ~= oldvalue ) then
		if ( newvalue == 1 ) then
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_USELONGTIMERS_ENABLED);
		else
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_USELONGTIMERS_DISABLED);
		end
	end
	CooldownCount_Register_Cosmos();
end

-- Toggles the enabled/disabled state of the CooldownCount
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function CooldownCount_Toggle_Enabled(toggle)
	local oldvalue = CooldownCount_Enabled;
	local newvalue = toggle;
	if ( ( toggle ~= 1 ) and ( toggle ~= 0 ) ) then
		if (oldvalue == 1) then
			newvalue = 0;
		elseif ( oldvalue == 0 ) then
			newvalue = 1;
		else
			newvalue = 0;
		end
	end
	CooldownCount_Enabled = newvalue;
	CooldownCount_Setup_Hooks(newvalue);
	if ( newvalue ~= oldvalue ) then
		if ( newvalue == 1 ) then
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_ENABLED);
		else
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_DISABLED);
		end
	end
	CooldownCount_Register_Cosmos();
end

function CooldownCount_Toggle_RogueStealth(toggle)
	local oldvalue = CooldownCount_RogueStealth;
	local newvalue = toggle;
	if ( ( toggle ~= 1 ) and ( toggle ~= 0 ) ) then
		if (oldvalue == 1) then
			newvalue = 0;
		elseif ( oldvalue == 0 ) then
			newvalue = 1;
		else
			newvalue = 0;
		end
	end
	CooldownCount_RogueStealth = newvalue;
	if ( newvalue ~= oldvalue ) then
		if ( newvalue == 1 ) then
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_ROGUE_STEALTH_ENABLED);
		else
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_ROGUE_STEALTH_DISABLED);
		end
	end
	local index = nil;
	local value = "ShapeshiftButton";
	for k, v in CooldownCount_ButtonNames do
		if ( v == value ) then
			index = k;
			break;
		end
	end
	if ( CooldownCount_RogueStealth == 1 ) then
		if ( not index ) then
			table.insert(CooldownCount_ButtonNames, value);
			CooldownCount_RegenerateList();
		end
	else
		if ( index ) then
			table.remove(CooldownCount_ButtonNames, index);
			CooldownCount_RegenerateList();
		end
	end
	CooldownCount_Register_Cosmos();
end

function CooldownCount_Toggle_NoSpaces(toggle)
	local oldvalue = CooldownCount_NoSpaces;
	local newvalue = toggle;
	if ( ( toggle ~= 1 ) and ( toggle ~= 0 ) ) then
		if (oldvalue == 1) then
			newvalue = 0;
		elseif ( oldvalue == 0 ) then
			newvalue = 1;
		else
			newvalue = 0;
		end
	end
	CooldownCount_NoSpaces = newvalue;
	if ( newvalue ~= oldvalue ) then
		if ( newvalue == 1 ) then
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_NOSPACES_ENABLED);
		else
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_NOSPACES_DISABLED);
		end
		CooldownCount_DoUpdate();
	end
	CooldownCount_Register_Cosmos();
end

function CooldownCount_Set_Alpha(value, quiet)
	local oldvalue = CooldownCountOptions.alpha;
	local newvalue = value;
	CooldownCountOptions.alpha = newvalue;
	if ( newvalue ~= oldvalue ) then
		if ( not quiet ) then
			CooldownCount_Print(string.format(COOLDOWNCOUNT_CHAT_ALPHA_FORMAT), newvalue);
		end
		CooldownCount_DoUpdate(true);
	end
	CooldownCount_Register_Cosmos();
end

function CooldownCount_Set_NormalColor(r, g, b, quiet)
	local arr = nil;
	if ( type(r) == "table" ) then
		arr = r;
		quiet = g;
	else
		arr = { r, g, b };
	end
	local changed = false;
	for k, v in CooldownCountOptions.color.normal do
		if ( arr[k] ~= v ) then
			changed = true;
			break;
		end
	end
	if ( changed ) then
		CooldownCountOptions.color.normal = arr;
		if ( not quiet ) then
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_NORMAL_COLOR_SET);
		end
		CooldownCount_DoUpdate(true);
	end
	CooldownCount_Register_Cosmos();
end

function CooldownCount_Set_FlashColor(r, g, b, quiet)
	local arr = nil;
	if ( type(r) == "table" ) then
		arr = r;
		quiet = g;
	else
		arr = { r, g, b };
	end
	local changed = false;
	for k, v in CooldownCountOptions.color.flash do
		if ( arr[k] ~= v ) then
			changed = true;
			break;
		end
	end
	if ( changed ) then
		CooldownCountOptions.color.flash = arr;
		if ( not quiet ) then
			CooldownCount_Print(COOLDOWNCOUNT_CHAT_FLASH_COLOR_SET);
		end
		CooldownCount_DoUpdate(true);
	end
	CooldownCount_Register_Cosmos();
end

-- Prints out text to a chat box.
function CooldownCount_Print(msg,r,g,b,frame,id,unknown4th)
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end
				
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b,id,unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id,unknown4th);
		end
	end
end


function CooldownCount_CosmosColorNilFunc(u,b,c)
	if ( CosmosMasterFrame ) then
		CosmosMasterFrame:Show();
	end
end

function CooldownCount_CosmosOpacity()
	local alpha = OpacitySliderFrame:GetValue();
	CooldownCount_Set_Alpha(alpha);
end

function CooldownCount_NormalColorSetButton(notCosmos)
	ColorPickerFrame.func = CooldownCount_CosmosNormalColorSet;
	ColorPickerFrame.cancelFunc = CooldownCount_CosmosColorNilFunc;
	ColorPickerFrame.hasOpacity = false;
	--ColorPickerFrame.opacityFunc = CooldownCount_CosmosOpacity;
	local red, green, blue = unpack(CooldownCountOptions.color.normal);
	ColorPickerFrame:SetColorRGB(red, green, blue);
	ColorPickerFrame.previousValues = {r = red, g = green, b = blue, opacity = 1};
	if ( CosmosMasterFrame ) then
		CosmosMasterFrame:Hide();
	end
	ColorPickerFrame:Show();
end
function CooldownCount_NormalColorResetButton()
	local r, g, b = unpack(CooldownCountColorDefaultNormal);
	CooldownCountOptions.color.normal = { r, g, b};
end

function CooldownCount_NormalColorSet()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	CooldownCountOptions.color.normal = { r, g, b};
end

function CooldownCount_CosmosNormalColorSet()
	CooldownCount_NormalColorSet();
	if(not ColorPickerFrame:IsVisible()) then
		if ( CosmosMasterFrame ) then
			CosmosMasterFrame:Show();
		end
	end
end

function CooldownCount_FlashColorSetButton()
	ColorPickerFrame.func = CooldownCount_CosmosFlashColorSet;
	ColorPickerFrame.cancelFunc = CooldownCount_CosmosColorNilFunc;
	ColorPickerFrame.hasOpacity = false;
	local red, green, blue = unpack(CooldownCountOptions.color.flash);
	ColorPickerFrame:SetColorRGB(red, green, blue);
	ColorPickerFrame.previousValues = {r = red, g = green, b = blue, opacity = 1};
	if ( CosmosMasterFrame ) then
		CosmosMasterFrame:Hide();
	end
	ColorPickerFrame:Show();
end

function CooldownCount_FlashColorResetButton()
	local r, g, b = unpack(CooldownCountColorDefaultFlash);
	CooldownCountOptions.color.flash = { r, g, b};
end

function CooldownCount_FlashColorSet()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	CooldownCountOptions.color.flash = { r, g, b};
end

function CooldownCount_CosmosFlashColorSet()
	CooldownCount_FlashColorSet();
	if(not ColorPickerFrame:IsVisible()) then
		if ( CosmosMasterFrame ) then
			CosmosMasterFrame:Show();
		end
	end
end
