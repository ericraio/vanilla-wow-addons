--------------------------------------------------------------------------
-- MobileFrames.lua
--------------------------------------------------------------------------
--[[
Mobile Minimap Buttons

By: AnduinLothar    <KarlKFI@cosmosui.org>

Makes the Minimap Buttons draggable around the minimap with adjustable angle.
Control-Drag to change angle.
Control-Right-Click to bring up menu.
Menu: Reset, Reset All, Disable.

Possible ToDo: Shift-Ctrl-Drag to change radius.

Change Log:
v1.71
-Changed the radius calculation to make compatible with AddOns that allow changes to the radius setting of their buttons e.g. Gatherer, AlphaMap
-Updated the API.txt
v1.7
-Now automaticly makes mobile the following addon buttons: Soundtrack, Cirk's Blessings, CritLine, AlphaMap, and Natur EnemyCastBar.
v1.6
-Changed dragging and reset menu to control click to avoid conflict with battlegrounds button
-Fixed bug that wasn't saving posistions of icons unless you tapped them
v1.52
-Updated TOC to 11100
-Fixed Census button mask.
v1.51
-New Buttons are now Anchored when first made mobile. (Fixed OnLoad error with Atlas)
-Updated German Localization
v1.5 (1/15/06)
-Fixed Shift-OnClick option overridding to still work for clicks under half a second. (Fixes battleground minimap)
-Now automaticly makes mobile the following addon buttons: Atlas, CTRA, Wardrobe, Yatlas, Gatherer, Earth, IEF, CTA.
(Addon Buttons are only on English client until localized.)
v1.4 (1/4/06)
-Disabled OnDrag events of registered addon buttons (Wardrobe now correctly stops dragging)
-Fixed nil OnLoad bug by delaying frame loading until after PLAYER_ENTERING_WORLD on a fresh load
-Updated TOC to 10900
v1.3 (11/24/05)
-Dynamicly added buttons now save accross sessions
Demo additions:
/script MobileMinimapButtons_AddButton("AtlasButton","Atlas Button");
/script MobileMinimapButtons_AddButton("CT_RASets_Button","CT Raid Assist Button");
/script MobileMinimapButtons_AddButton("Wardrobe.IconFrame","Wardrobe Button");
/script MobileMinimapButtons_AddButton("TheYatlasButton","Yatlas Button");
/script MobileMinimapButtons_AddButton("GathererUI_IconFrame","Gatherer Button");
/script MobileMinimapButtons_AddButton("EarthMinimapButton","Earth Button");
/script MobileMinimapButtons_AddButton("IEFMinimapButton","Improved Error Frame Button");
/script MobileMinimapButtons_AddButton("CTA_MinimapIcon","Call To Arms Button");
v1.2 (10/27/05)
-Chnaged OnClick handling to allow for Casting via OnClick
-Implimented HasScript so that you no longer have to pass weather the frame is a button or not.
v1.11 (10/25/05)
-Fixed an obscure OnClick bug involving Khaos
v1.1 (10/18/05)
-Added dynamic button adding using MobileMinimapButtons_AddButton at any time.
-See API.txt for details on how to make your addon's button mobile.
v1.0 (9/30/05)
-Initial Release


	$Id: MobileMinimapButtons.lua 2025 2005-07-02 23:51:34Z KarlKFI $
	$Rev: 2025 $
	$LastChangedBy: KarlKFI $
	$Date: 2005-07-02 16:51:34 -0700 (Sat, 02 Jul 2005) $


]]--

--Update +1 if you change the list of frames in the localization!
local tempListVersion = MOBILE_MINIMAP_BUTTONS_LIST_VERSION;
local tempFrameList = MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS;

MobileMinimapButtons_Debug = false;
MobileMinimapButtons_Coords = {};
MobileMinimapButtons_Enabled = true;
MobileMinimapButtons_CurrentlyEnabled = {};
MobileMinimapButtons_NextClickDisabled = nil;

MobileMinimapButtons_FullSizeButtons = {
	--Fullsize buttons use the 1/2 width offset rather than the normal 1/4 width
	["MiniMapTrackingFrame"] = true,
};

MobileMinimapButtons_MaskParentButtons = {
	--Parents that aren't attached hinder dragging, attach them.
	["AtlasButton"] = "AtlasButtonFrame",
	["CensusButton"] = "CensusButtonFrame",
	["CT_RASets_Button"] = "CT_RASetsFrame",
	["TheYatlasButton"] = "YatlasButtonFrame",
	["AM_MinimapButton"] = "AM_MinimapFrame",
};

function MobileMinimapButtons_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	if (Khaos) then
		MobileMinimapButtons_RegisterForKhaos();
	end
end

function MobileMinimapButtons_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		--Make sure list has new frames, but don't remove added ones
		if (MOBILE_MINIMAP_BUTTONS_LIST_VERSION) and (tempListVersion > MOBILE_MINIMAP_BUTTONS_LIST_VERSION) then
			for frameName, localizedFrameName in tempFrameList do
				if (not MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS[frameName]) then
					MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS[frameName] = localizedFrameName;
				end
			end
			MOBILE_MINIMAP_BUTTONS_LIST_VERSION = tempListVersion;
		end
		tempFrameList = nil;
		tempListVersion = nil
		MobileMinimapButtons_EnteringWorldFromFullLoad = true;

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (MobileMinimapButtons_EnteringWorldFromFullLoad) then
			--Loop Through Minimap Buttons
			for frameName, localizedFrameName in MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS do
				if (Sea.util.getValue(frameName)) then
					MobileMinimapButtons_MakeMobile(frameName, localizedFrameName);
				end
			end
			MobileMinimapButtons_EnteringWorldFromFullLoad = nil;
			MobileMinimapButtons_FramesLoaded = true;
		end
	end
end

function MobileMinimapButtons_AddButton(frameName, localizedFrameName)
	if (not frameName) or (not Sea.util.getValue(frameName)) then
		Sea.io.print("MobileMinimapButtons Error: Cannot add ", frameName, " (", localizedFrameName, ") called from ", this:GetName(), ". The button does not exist.");
		return;
	elseif (MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS[frameName]) then
		if (MobileMinimapButtons_FramesLoaded) then
			Sea.io.print("MobileMinimapButtons Error: Cannot add ", frameName, " (", localizedFrameName, ") called from ", this:GetName(), ". Duplicate already registered.");
		end
		return;
	end
	MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS[frameName] = localizedFrameName;
	if (MobileMinimapButtons_FramesLoaded) then
		MobileMinimapButtons_MakeMobile(frameName, localizedFrameName);
		if (not MobileMinimapButtons_Enabled) then
			--Override Disable to redisable
			MobileMinimapButtons_Enabled = true;
			MobileMinimapButtons_Disable();
		end
	end
end


function MobileMinimapButtons_MakeMobile(frameName, localizedFrameName)
	if (MobileMinimapButtons_CurrentlyEnabled[frameName]) then
		-- Already Mobile
		return;
	end

	local frame = Sea.util.getValue(frameName);

	--Store the current position as the reset coords
	MobileMinimapButtons_StoreResetPosition(frameName);

	--Load Frame Script Element Hooks
	Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnEvent", "replace", "OnEvent" );
	if (frame:HasScript("OnClick")) then
		--Enable Click events
		--frame:RegisterForClicks("LeftButton", "RightButton");
		Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnClick", "replace", "OnClick" );
	end
	Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnMouseDown", "replace", "OnMouseDown" );
	Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnMouseUp", "replace", "OnMouseUp" );
	Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnHide", "replace", "OnHide" );
	Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnUpdate", "replace", "OnUpdate" );

	--Make sure all the Buttons are Mobile
	if (not frame:IsMovable()) then
		frame:SetMovable(1);
	end

	--Disable OnDrag events by passing no arguments
	frame:RegisterForDrag();

	--Reposition Buttons to Saved Coords
	local coords = MobileMinimapButtons_Coords[frameName];
	frame:ClearAllPoints();
	if (coords) and (coords.x) and (coords.y) then
		frame:SetPoint("CENTER", "Minimap", "CENTER", coords.x, coords.y);
	else
		frame:SetPoint("CENTER", "Minimap", "CENTER", frame.resetX, frame.resetY);
	end

	--Set as enabled for this session
	MobileMinimapButtons_CurrentlyEnabled[frameName] = localizedFrameName;
	--Save for later
	MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS[frameName] = localizedFrameName;

	--Elevate Buttons Above the MiniMap
	frame:SetFrameLevel(frame:GetFrameLevel()+1);

	--Attach Parent Buttons
	local maskFrame = Sea.util.getValue(MobileMinimapButtons_MaskParentButtons[frameName])
	if (maskFrame) then
		maskFrame:SetAllPoints(frame);
	end
end

function MobileMinimapButtons_StoreResetPosition(frameName)
	local frame = Sea.util.getValue(frameName);
	local centerX, centerY = Minimap:GetCenter();
	local thisX, thisY = frame:GetCenter();
	local radius;

	local diffX = centerX - thisX;
	local diffY = centerY - thisY;
	local dist = (diffX * diffX) + (diffY * diffY);
	radius = math.sqrt(dist);

	local x = math.abs(thisX - centerX);
	local y = math.abs(thisY - centerY);
	local xSign = 1;
	local ySign = 1;
	if not (thisX >= centerX) then
		xSign = -1;
	end
	if not (thisY >= centerY) then
		ySign = -1;
	end
	--Sea.io.print(xSign*x,", ",ySign*y);
	local angle = math.atan(x/y);
	x = math.sin(angle)*radius;
	y = math.cos(angle)*radius;
	frame.resetX = xSign*x;
	frame.resetY = ySign*y;
end

function MobileMinimapButtons_Reset(frame)
	if (frame) then
		frame.isMoving = false;
		frame:ClearAllPoints();
		frame:SetPoint("CENTER", "Minimap", "CENTER", frame.resetX, frame.resetY);
		frame:SetUserPlaced(false);
		MobileMinimapButtons_Coords[frame:GetName()] = nil;
	end
end

function MobileMinimapButtons_ResetAll()
	for frameName, localizedFrameName in MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS do
		local frame = Sea.util.getValue(frameName);
		MobileMinimapButtons_Reset(frame);
	end
end

function MobileMinimapButtons_Disable()
	if (not MobileMinimapButtons_Enabled) then
		return;
	end
	for frameName, localizedFrameName in MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS do
		--Reset Location without forgetting coords
		local frame = Sea.util.getValue(frameName);
		if (frame) then
			frame.isMoving = false;
			frame:ClearAllPoints();
			frame:SetPoint("CENTER", "Minimap", "CENTER", frame.resetX, frame.resetY);
			frame:SetUserPlaced(false);

			--Unload Frame Script Element Hooks
			Sea.util.unhook( frameName, "MobileMinimapButtons_Master_OnEvent", "replace", "OnEvent" );
			if (frame:HasScript("OnClick")) then
				Sea.util.unhook( frameName, "MobileMinimapButtons_Master_OnClick", "replace", "OnClick" );
			end
			Sea.util.unhook( frameName, "MobileMinimapButtons_Master_OnMouseDown", "replace", "OnMouseDown" );
			Sea.util.unhook( frameName, "MobileMinimapButtons_Master_OnMouseUp", "replace", "OnMouseUp" );
			Sea.util.unhook( frameName, "MobileMinimapButtons_Master_OnHide", "replace", "OnHide" );
			Sea.util.unhook( frameName, "MobileMinimapButtons_Master_OnUpdate", "replace", "OnUpdate" );
		end
	end
	MobileMinimapButtons_Enabled = nil;
end

function MobileMinimapButtons_ReEnable()
	if (MobileMinimapButtons_Enabled) then
		return;
	end
	for frameName, localizedFrameName in MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS do
		--Load Frame Script Element Hooks
		local frame = Sea.util.getValue(frameName);
		if (frame) then
			Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnEvent", "replace", "OnEvent" );
			if (frame:HasScript("OnClick")) then
				Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnClick", "replace", "OnClick" );
			end
			Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnMouseDown", "replace", "OnMouseDown" );
			Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnMouseUp", "replace", "OnMouseUp" );
			Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnHide", "replace", "OnHide" );
			Sea.util.hook( frameName, "MobileMinimapButtons_Master_OnUpdate", "replace", "OnUpdate" );

			--Reposition Buttons to Saved Coords
			local coords = MobileMinimapButtons_Coords[frameName];
			if (coords) and (coords.x) and (coords.y) then
				local frame = Sea.util.getValue(frameName);
				frame:ClearAllPoints();
				frame:SetPoint("CENTER", "Minimap", "CENTER", coords.x, coords.y);
			end
		end
	end
	MobileMinimapButtons_Enabled = true;
end

function MobileMinimapButtons_Master_OnMouseDown()
	Sea.io.dprint("MobileMinimapButtons_Debug", "MobileMinimapButtons_Master_OnMouseDown(", arg1, ")");
	if (IsControlKeyDown()) then
		if (arg1 == "LeftButton") then
			this.isMoving = 0;
			local centerX, centerY = Minimap:GetCenter();
			local thisX, thisY = this:GetCenter();				
			local diffX = centerX - thisX;
			local diffY = centerY - thisY;
			local dist = (diffX * diffX) + (diffY * diffY);
			this.radius = math.sqrt(dist);
		end
	else
		return true;
	end
end

function MobileMinimapButtons_Master_OnMouseUp()
	Sea.io.dprint("MobileMinimapButtons_Debug", "MobileMinimapButtons_Master_OnMouseUp(", arg1, ")");
	local frameName = this:GetName();
	if (this.isMoving) then
		if (MouseIsOver(this)) and (this.isMoving > GetFramerate()) then
			--Only disable OnClick if it was dragging longer than 1 second (accounts for shift-OnClicking)
			MobileMinimapButtons_NextClickDisabled = true;
		end
		if (not MobileMinimapButtons_Coords[frameName]) then
			MobileMinimapButtons_Coords[frameName] = {};
		end
		MobileMinimapButtons_Coords[frameName].x = this.currentX;
		MobileMinimapButtons_Coords[frameName].y = this.currentY;
		this.isMoving = false;
		this.radius = nil;
	elseif (MouseIsOver(this)) then
		if (IsControlKeyDown()) and (arg1 == "RightButton") then
			--MobileMinimapButtons_Reset(this);
			MobileMinimapButtonsDropDown.displayMode = "MENU";
			ToggleDropDownMenu(1, frameName, MobileMinimapButtonsDropDown, frameName);
			--MobileMinimapButtonsDropDown_Reposition(frameName);
			MobileMinimapButtons_NextClickDisabled = true;
		else
			--MobileMinimapButtons_NextClickDisabled = nil;
			return true;
		end
	else
		return true;
	end
end

function MobileMinimapButtons_Master_OnClick()
	if (not MobileMinimapButtons_NextClickDisabled) then
		Sea.io.dprint("MobileMinimapButtons_Debug", "MobileMinimapButtons_Master_OnClick(", arg1, ") Orig Called.");
		return true;
	else
		Sea.io.dprint("MobileMinimapButtons_Debug", "MobileMinimapButtons_Master_OnClick(", arg1, ") Orig Not Called.");
		MobileMinimapButtons_NextClickDisabled = nil;
	end
end

function MobileMinimapButtons_Master_OnHide()
	this.isMoving = false;
	return true;
end

function MobileMinimapButtons_Master_OnUpdate()
	if (this.isMoving) then
		this.isMoving = this.isMoving+1;
		local mouseX, mouseY = GetCursorPosition();
		local centerX, centerY = Minimap:GetCenter();
		local scale = Minimap:GetEffectiveScale();
		mouseX = mouseX / scale;
		mouseY = mouseY / scale;
		local radius;

		if ( not this.radius ) then
			if (MobileMinimapButtons_FullSizeButtons[this:GetName()]) then
				radius = ((Minimap:GetRight()-Minimap:GetLeft())/2) + ((this:GetRight()-this:GetLeft())/2);
			else
				radius = ((Minimap:GetRight()-Minimap:GetLeft())/2) + ((this:GetRight()-this:GetLeft())/4);
			end
		else
			radius = this.radius;
		end

		local x = math.abs(mouseX - centerX);
		local y = math.abs(mouseY - centerY);
		local xSign = 1;
		local ySign = 1;
		if not (mouseX >= centerX) then
			xSign = -1;
		end
		if not (mouseY >= centerY) then
			ySign = -1;
		end
		--Sea.io.print(xSign*x,", ",ySign*y);
		local angle = math.atan(x/y);
		x = math.sin(angle)*radius;
		y = math.cos(angle)*radius;
		this.currentX = xSign*x;
		this.currentY = ySign*y;
		this:ClearAllPoints();
		this:SetPoint("CENTER", "Minimap", "CENTER", this.currentX, this.currentY);
	else
		return true;
	end
end

-- <= == == == == == == == == == == == == =>
-- => Menu
-- <= == == == == == == == == == == == == =>

function MobileMinimapButtons_LoadDropDownMenu()
	--Title
	local info = {};
	info.text = MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS[UIDROPDOWNMENU_MENU_VALUE];
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, 1);

	--Reset
	local info = {};
	info.text = RESET;
	info.value = "Reset";
	info.func = function() MobileMinimapButtons_Reset(Sea.util.getValue(UIDROPDOWNMENU_MENU_VALUE)) end;
	--info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, 1);

	--Reset All
	local info = {};
	info.text = RESET_ALL;
	info.value = "ResetAll";
	info.func = MobileMinimapButtons_ResetAll;
	--info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, 1);

	MobileMinimapButtonsDropDown_Reposition(UIDROPDOWNMENU_MENU_VALUE);
end

function MobileMinimapButtonsDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, MobileMinimapButtons_LoadDropDownMenu, "MENU");
end

function MobileMinimapButtonsDropDown_Reposition(anchorName)
	local customPoint = "TOPLEFT";   --Default Anchor
	local offscreenY, offscreenX, anchorPoint, relativePoint, offsetX, offsetY;
	local listFrame = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL);
	-- Determine whether the menu is off the screen or not
	local offscreenY, offscreenX;
	--Hack for built in bug
	if ( not listFrame:GetRight() ) then
		return;
	end

	if ( listFrame:GetBottom() < WorldFrame:GetBottom() ) then
		offscreenY = 1;
	end
	if ( listFrame:GetRight() > WorldFrame:GetRight() ) then
		offscreenX = 1;
	end

	local anchorPoint, relativePoint, offsetX, offsetY;
	if ( offscreenY == 1 ) then
		if ( offscreenX == 1 ) then
			anchorPoint = string.gsub(customPoint, "TOP(.*)", "BOTTOM%1");
			anchorPoint = string.gsub(anchorPoint, "(.*)LEFT", "%1RIGHT");
			relativePoint = "TOPRIGHT";
			offsetX = 0;
			offsetY = 14;
		else
			anchorPoint = string.gsub(customPoint, "TOP(.*)", "BOTTOM%1");
			relativePoint = "TOPLEFT";
			offsetX = 0;
			offsetY = 14;
		end
	else
		if ( offscreenX == 1 ) then
			anchorPoint = string.gsub(customPoint, "(.*)LEFT", "%1RIGHT");
			relativePoint = "BOTTOMRIGHT";
			offsetX = 0;
			offsetY = -14;
		else
			anchorPoint = customPoint;
			relativePoint = "BOTTOMLEFT";
			offsetX = 0;
			offsetY = -14;
		end
	end
	listFrame:ClearAllPoints();
	listFrame:SetPoint(anchorPoint, anchorName, relativePoint, offsetX, offsetY);

	-- Reshow the "MENU" border
	getglobal(listFrame:GetName().."Backdrop"):Hide();
	getglobal(listFrame:GetName().."MenuBackdrop"):Show();
	--getglobal(listFrame:GetName().."Backdrop"):Show();
	--getglobal(listFrame:GetName().."MenuBackdrop"):Hide();
end

-- <= == == == == == == == == == == == == =>
-- => Khaos Registration
-- <= == == == == == == == == == == == == =>

function MobileMinimapButtons_RegisterForKhaos()
	local optionSet = {
		id="MobileMinimapButtons";
		text=MOBILE_MINIMAP_BUTTONS_HEADER;
		helptext=MOBILE_MINIMAP_BUTTONS_HEADER_INFO;
		difficulty=1;
		default = {checked = true};
		callback = function(checked)
			if (checked) then
				MobileMinimapButtons_ReEnable();
			else
				MobileMinimapButtons_Disable();
			end
		end;
		options={
			{
				id="Header";
				text=MOBILE_MINIMAP_BUTTONS_HEADER;
				helptext=MOBILE_MINIMAP_BUTTONS_HEADER_INFO;
				type=K_HEADER;
			};
			{
				id="ResetAll";
				type=K_BUTTON;
				text=MOBILE_MINIMAP_BUTTONS_RESET_ALL_TEXT;
				helptext=MOBILE_MINIMAP_BUTTONS_RESET_ALL_TEXT_INFO;
				callback=MobileMinimapButtons_ResetAll;
				setup={buttonText=RESET_ALL};
			};
		};
	};
	Khaos.registerOptionSet(
		"frames",
		optionSet
	);
end
