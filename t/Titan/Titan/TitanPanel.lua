TITAN_PANEL_FRAME_SPACEING = 20;
TITAN_PANEL_ICON_SPACEING = 4;
TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE = 10;
TITAN_AUTOHIDE_WAIT_TIME = 0.5;
TITAN_PANEL_INITIAL_PLUGINS = {"Coords", "XP", "LootType", "Clock", "Volume", "UIScale", "Trans", "AutoHide", "HonorPlus", "Bag", "Money", "AuxAutoHide", "Repair", "ItemBonuses"};
TITAN_PANEL_INITIAL_PLUGIN_LOCATION = {"Bar", "Bar", "Bar", "Bar", "Bar", "Bar", "Bar", "Bar", "AuxBar", "AuxBar", "AuxBar", "AuxBar", "AuxBar", "AuxBar"};

TITAN_PANEL_BUTTONS_PLUGIN_CATEGORY = {"General","Combat","Information","Interface","Profession"}
TITAN_PANEL_BUTTONS_ALIGN_LEFT = 1;
TITAN_PANEL_BUTTONS_ALIGN_CENTER = 2;
TITAN_PANEL_BUTTONS_ALIGN_RIGHT = 3;

TITAN_PANEL_BARS_SINGLE = 1;
TITAN_PANEL_BARS_DOUBLE = 2;

TITAN_PANEL_BUTTONS_INIT_FLAG = nil;
TITAN_PANEL_SELECTED = "Bar";

TITAN_PANEL_FROM_TOP = -25;
TITAN_PANEL_FROM_BOTTOM = 25;
TITAN_PANEL_FROM_BOTTOM_MAIN = 1;
TITAN_PANEL_FROM_TOP_MAIN = 1;

TITAN_PANEL_MOVE_ADDON = nil;
TITAN_PANEL_DROPOFF_ADDON = nil;
TITAN_PANEL_NEXT_ADDON = nil;
TITAN_PANEL_MOVING = 0;

TITAN_PANEL_SAVED_VARIABLES = {
	Buttons = TITAN_PANEL_INITIAL_PLUGINS,
	Location = TITAN_PANEL_INITIAL_PLUGIN_LOCATION,
	Transparency = 0.7,
	Scale = 1,
	FontScale = 1,
	ScreenAdjust = TITAN_NIL,
	AutoHide = TITAN_NIL,
	Position = TITAN_PANEL_PLACE_TOP,
	DoubleBar = TITAN_PANEL_BARS_SINGLE,
	ButtonAlign = TITAN_PANEL_BUTTONS_ALIGN_LEFT,
	BothBars = 1,
	AuxScreenAdjust = TITAN_NIL,
	AuxAutoHide = TITAN_NIL,
	AuxDoubleBar = TITAN_PANEL_BARS_SINGLE,
	AuxButtonAlign = TITAN_PANEL_BUTTONS_ALIGN_LEFT,
	VersionShown = 1,
	ToolTipsShown = 1,
	DisableFont = TITAN_NIL,
	CastingBar = 1
};

function TitanPanelBarButton_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("TIME_PLAYED_MSG");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("CVAR_UPDATE");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function TitanPanelBarButton_OnEvent(frame)
	if frame == "TitanPanelBarButton" then
		if (event == "VARIABLES_LOADED") then
			TitanVariables_InitTitanSettings();	
			
		elseif (event == "ADDON_LOADED") then
			TitanPanel_AddonLoaded(arg1);

		elseif (event == "UNIT_NAME_UPDATE") then
			TitanVariables_InitDetailedSettings();
			
		elseif (event == "PLAYER_ENTERING_WORLD") then
			TitanVariables_InitDetailedSettings();
			
			-- Initial session time 
			if (not this.sessionTime) then
				this.sessionTime = 0;
				RequestTimePlayed();
			end
					
			if ( not ServerTimeOffsets ) then
				ServerTimeOffsets = {};
			end

			local realmName = GetCVar("realmName");

			if ( ServerTimeOffsets[realmName] ) then
				TitanSetVar(TITAN_CLOCK_ID, "OffsetHour", ServerTimeOffsets[realmName]);
			end

		elseif ( event == "PLAYER_LEAVING_WORLD" ) then
			local realmName = GetCVar("realmName");
			ServerTimeOffsets[realmName] = TitanGetVar(TITAN_CLOCK_ID, "OffsetHour");
			
		elseif (event == "TIME_PLAYED_MSG") then
			-- Remember play time
			this.totalTime = arg1;
			this.levelTime = arg2;		
	
			-- Move frames
			TitanPanelFrame_ScreenAdjust();
		
			-- Init panel buttons
			TitanPanel_InitPanelBarButton();
			TitanPanel_InitPanelButtons();		
	
			-- Set initial Panel AutoHide
			if (TitanPanelGetVar("AutoHide")) then
				TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
			end
			if (TitanPanelGetVar("AuxAutoHide")) then
				TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
			end		
	
			TitanPanel_SetTransparent("TitanPanelBarButtonHider", TitanPanelGetVar("Position"));
			
		elseif (event == "PLAYER_LEVEL_UP") then
			-- Reset level time
			this.levelTime = 0;
			
		elseif (event == "CVAR_UPDATE") then
			if (arg1 == "USE_UISCALE" or arg1 == "WINDOWED_MODE") then
				if (TitanPlayerSettings and TitanPanelGetVar("Scale")) then
					TitanPanel_SetScale();
					TitanPanel_RefreshPanelButtons();
					-- Adjust frame positions
					TitanPanelFrame_ScreenAdjust();
				end
			end
		elseif (event == "ZONE_CHANGED_NEW_AREA") then
			-- Move frames
			TitanPanel_InitPanelButtons();
		end
	end
end

function TitanPanelFrame_ScreenAdjust()
	TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
	TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"),  TitanPanelGetVar("ScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();

	TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
	TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("AuxScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
end

function TitanPanelBarButtonHider_OnUpdate(elapsed)
	local x, y = GetCursorPosition(UIParent);
	local scale = UIParent:GetEffectiveScale();

	if scale ~= 1.0 then
		y = y / (scale);
	end
	if (TitanPanelGetVar("AutoHide") or TitanPanelGetVar("AuxAutoHide")) then

		if not (TitanPanelRightClickMenu_IsVisible()) then
			TITAN_PANEL_SELECTED = TitanUtils_GetButtonID(this:GetName())
			TitanUtils_CheckAutoHideCounting(elapsed);
			if TITAN_PANEL_SELECTED == "Bar" and TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP then
				if y < TitanPanelBarButtonHider:GetBottom() and TitanPanelBarButtonHider.isCounting == nil then
					TitanUtils_StartAutoHideCounting("TitanPanelBarButtonHider");
				end
			elseif TITAN_PANEL_SELECTED == "Bar" and TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_BOTTOM then
				if y > TitanPanelBarButtonHider:GetTop() and TitanPanelBarButtonHider.isCounting == nil then
					TitanUtils_StartAutoHideCounting("TitanPanelBarButtonHider");
				end
			elseif TITAN_PANEL_SELECTED == "AuxBar" then
				if y > TitanPanelAuxBarButtonHider:GetTop() and TitanPanelAuxBarButtonHider.isCounting == nil then
					TitanUtils_StartAutoHideCounting("TitanPanelAuxBarButtonHider");
				end
			end
		end
	end

end

function TitanPanelBarButton_OnUpdate(elapsed)
	if TITAN_PANEL_MOVING == 2 and TITAN_PANEL_DROPOFF_ADDON ~= nil then
		TITAN_PANEL_MOVING = 3;
	end
	-- Update play time
	if (this.totalTime) then
		this.totalTime = this.totalTime + elapsed;
		this.sessionTime = this.sessionTime + elapsed;
		this.levelTime = this.levelTime + elapsed;
	end
	TitanPanelFrame_ScreenAdjust();
end

function TitanPanelBarButton_OnClick(button)
	if (button == "LeftButton") then
	
		TitanUtils_CloseAllControlFrames();
		TitanUtils_CloseRightClickMenu();	
	elseif (button == "RightButton") then
		TitanUtils_CloseAllControlFrames();			
		-- Show RightClickMenu anyway
		if (TitanPanelRightClickMenu_IsVisible()) then
			TitanPanelRightClickMenu_Close();
		end
		TitanPanelRightClickMenu_Toggle();		
	end
end

function TitanPanelBarButtonHider_OnEnter(frame)
	if (TitanPanelGetVar("AutoHide") or TitanPanelGetVar("AuxAutoHide")) then
		local frname = getglobal(frame)
		
		if frname.isCounting ~= nil then
			TitanUtils_StopAutoHideCounting(frame);
		end

		if (frame == "TitanPanelBarButtonHider" and TitanPanelBarButton.hide == 1) then
			if (TitanPanelBarButton.hide) then
				TitanPanelBarButton_Show("TitanPanelBarButton", TitanPanelGetVar("Position"));
			end
		else
			if (TitanPanelAuxBarButton.hide and TitanPanelAuxBarButton.hide == 1) then
				if TitanPanelGetVar("BothBars") then
					TitanPanelBarButton_Show("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
				end
			end
		end
	end
end

function TitanPanelBarButtonHider_OnLeave(frame)
  --Removed
end

function TitanPanelRightClickMenu_BarOnClick()
	if (UIDropDownMenuButton_GetChecked()) then
		TitanPanel_RemoveButton(this.value);
	else
		TitanPanel_AddButton(this.value);
	end
end

function TitanPanelBarButton_ToggleAlign()
	if ( TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
		TitanPanelSetVar("ButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_LEFT);
	else
		TitanPanelSetVar("ButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_CENTER);
	end
	
	-- Justify button position
	TitanPanelButton_Justify();
end

function TitanPanelBarButton_ToggleAuxAlign()
	if ( TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
		TitanPanelSetVar("AuxButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_LEFT);
	else
		TitanPanelSetVar("AuxButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_CENTER);
	end
	
	-- Justify button position
	TitanPanelButton_Justify();
end

function TitanPanelBarButton_ToggleDoubleBar()
	if ( TitanPanelGetVar("DoubleBar") == TITAN_PANEL_BARS_SINGLE ) then
		TitanPanelSetVar("DoubleBar", TITAN_PANEL_BARS_DOUBLE);
		TitanPanelBarButtonHider:SetHeight(48);
	else
		TitanPanelSetVar("DoubleBar", TITAN_PANEL_BARS_SINGLE);
		TitanPanelBarButtonHider:SetHeight(24);
	end
	
	TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
	TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("DoubleBar"));
	TitanMovableFrame_AdjustBlizzardFrames();
	TitanPanel_InitPanelBarButton();
	TitanPanel_InitPanelButtons();		
	TitanPanel_SetTransparent("TitanPanelBarButtonHider", TitanPanelGetVar("Position"));

	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	if (TitanPanelGetVar("AuxAutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	end		

end

function TitanPanelBarButton_ToggleAuxDoubleBar()
	if ( TitanPanelGetVar("AuxDoubleBar") == TITAN_PANEL_BARS_SINGLE ) then
		TitanPanelSetVar("AuxDoubleBar", TITAN_PANEL_BARS_DOUBLE);
		TitanPanelAuxBarButtonHider:SetHeight(48);
	else
		TitanPanelSetVar("AuxDoubleBar", TITAN_PANEL_BARS_SINGLE);
		TitanPanelAuxBarButtonHider:SetHeight(24);
	end
	TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
	TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, 1);
	TitanMovableFrame_AdjustBlizzardFrames();
	TitanPanel_InitPanelBarButton();
	TitanPanel_InitPanelButtons();		
	TitanPanel_SetTransparent("TitanPanelAuxBarButtonHider", TITAN_PANEL_PLACE_BOTTOM);

	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	if (TitanPanelGetVar("AuxAutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TitanPanelGetVar("Position"));
	end		

end

function TitanPanelBarButton_ToggleAutoHide()
	TitanPanelToggleVar("AutoHide");
	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	else
		TitanPanelBarButton_Show("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	TitanPanelAutoHideButton_SetIcon();
end

function TitanPanelBarButton_ToggleAuxAutoHide()
	TitanPanelToggleVar("AuxAutoHide");
	if (TitanPanelGetVar("AuxAutoHide")) then
		if TitanPanelGetVar("BothBars") then
			TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
		end
	else
		if TitanPanelGetVar("BothBars") then
			TitanPanelBarButton_Show("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
		end
	end
	--Needs changing!
	TitanPanelAuxAutoHideButton_SetIcon();
end

function TitanPanelBarButton_ToggleScreenAdjust()
	TitanPanelToggleVar("ScreenAdjust");
	TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
	TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
end

function TitanPanelBarButton_ToggleAuxScreenAdjust()
	TitanPanelToggleVar("AuxScreenAdjust");
	TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
	TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("AuxScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
end

function TitanPanelBarButton_TogglePosition()
	if (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP) then
		TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
		TitanPanelSetVar("Position", TITAN_PANEL_PLACE_BOTTOM);
		TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));
	else
		TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
		TitanPanelSetVar("Position", TITAN_PANEL_PLACE_TOP);
		TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));
	end
	
	-- Set panel position and texture
	TitanPanel_SetPosition("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_SetTexture("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_SetTransparent("TitanPanelBarButtonHider", TitanPanelGetVar("Position"));
	
	-- Adjust frame positions
	TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
	TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
	TitanPanelButton_Justify();

end

function TitanPanelBarButton_ToggleBarsShown()
	TitanPanelToggleVar("BothBars");
	TitanPanelBarButton_DisplayBarsWanted();
	TitanPanelRightClickMenu_Close();
end
	
function TitanPanelBarButton_ToggleVersionShown()
	TitanPanelToggleVar("VersionShown");
end
	
function TitanPanelBarButton_ToggleToolTipsShown()
	TitanPanelToggleVar("ToolTipsShown");
end
	
function TitanPanelBarButton_ToggleCastingBar()
	TitanPanelToggleVar("CastingBar");
end
	
function TitanPanelBarButton_ToggleDisableFont()
	TitanPanelToggleVar("DisableFont");
	if TitanPanelGetVar("DisableFont") then
		TitanPanelSetVar("FontScale", 1.0);
		GameTooltip:SetScale(1);
	end
end

function TitanPanelBarButton_DisplayBarsWanted()
	--Need to handle top & bottom
	if (TitanPanelGetVar("BothBars")) then
		if (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_BOTTOM) then
			TitanPanelBarButton_TogglePosition();
		end

		TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_TOP);
		TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_TOP, TitanPanelGetVar("ScreenAdjust"));

		-- Set panel position and texture
		TitanPanel_SetPosition("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
		TitanPanel_SetTexture("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	
		-- Adjust frame positions
		TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
		TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("AuxScreenAdjust"));
		TitanMovableFrame_AdjustBlizzardFrames();
		
	else
		TitanPanelBarButton_TogglePosition();
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM)
		TitanPanelBarButton_TogglePosition();
	end
end

function TitanPanelBarButton_Show(frame, position)
	local frName = getglobal(frame);
	local barnumber = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), position);

	if (position == TITAN_PANEL_PLACE_TOP) then
		frName:ClearAllPoints();	
		frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, 0);
		frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -24); 
	else
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24); 
	end
	
	frName.hide = nil;
end

function TitanPanelBarButton_Hide(frame, position)
	local frName = getglobal(frame);
	local barnumber = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), position);

	if frName ~= nil then

		if (position == TITAN_PANEL_PLACE_TOP) then
			frName:ClearAllPoints();
			frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, (35*barnumber)); 
			frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -3);
			
		elseif  (position == TITAN_PANEL_PLACE_BOTTOM) and frame == "TitanPanelBarButton" then
			frName:ClearAllPoints();
			frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, -35); 
			frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 3);
		
		else
			if TitanPanelGetVar("BothBars") == nil and frame == "TitanPanelAuxBarButton" then
				frName:ClearAllPoints();
				frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, (-35*barnumber)); 
				frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, -35);
			else
				frName:ClearAllPoints();
				frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, (-35*barnumber)); 
				frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, -35);
			end
		end
	
		frName.hide = 1;
	end
end

function TitanPanel_InitPanelBarButton()
	-- Set Titan Panel position/textures
	TitanPanel_SetPosition("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_SetTexture("TitanPanelBarButton", TitanPanelGetVar("Position"));

	-- Set initial Panel Scale
	TitanPanel_SetScale();		

	-- Set initial Panel Transparency
	TitanPanelBarButton:SetAlpha(TitanPanelGetVar("Transparency"));		
	TitanPanelAuxBarButton:SetAlpha(TitanPanelGetVar("Transparency"));		
end

function TitanPanel_SetPosition(frame, position)
	local frName = getglobal(frame);
	if (position == TITAN_PANEL_PLACE_TOP) then
		if frame == "TitanPanelBarButton" then
			TitanPanelBackground12:ClearAllPoints();
			TitanPanelBackground12:SetPoint("BOTTOMLEFT", "TitanPanelBackground0", "BOTTOMLEFT", 0, -25); 
		end
		frName:ClearAllPoints();
		frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, 0);
		frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -24);	
	else
		if frame == "TitanPanelBarButton" then
			TitanPanelBackground12:ClearAllPoints();
			TitanPanelBackground12:SetPoint("BOTTOMLEFT", "TitanPanelBackground0", "BOTTOMLEFT", 0, 25); 
		end
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24); 
	end
end

function TitanPanel_SetTransparent(frame, position)
	local frName = getglobal(frame);
	local topBars = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), TITAN_PANEL_PLACE_TOP);
	local bottomBars = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), TITAN_PANEL_PLACE_BOTTOM);
	
	if (position == TITAN_PANEL_PLACE_TOP) then
		frName:ClearAllPoints();
		frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, 0);
		frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -24 * topBars);
		TitanPanelAuxBarButtonHider:ClearAllPoints();
		TitanPanelAuxBarButtonHider:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		TitanPanelAuxBarButtonHider:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24 * bottomBars); 
	elseif position == TITAN_PANEL_PLACE_BOTTOM and frame == "TitanPanelBarButtonHider" then
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24 * bottomBars); 
		TitanPanelAuxBarButtonHider:ClearAllPoints();
		TitanPanelAuxBarButtonHider:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		TitanPanelAuxBarButtonHider:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 0); 
	else
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24 * bottomBars); 
	end
end

function TitanPanel_SetTexture(frame, position)
	local frName = getglobal(frame);
	local barnumber = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), position);
	
	if frame == "TitanPanelBarButton" then
		local pos = TitanUtils_Ternary(position == TITAN_PANEL_PLACE_TOP, "Top", "Bottom");
		for i = 0, 11 do
			getglobal("TitanPanelBackground"..i):SetTexture(TITAN_ARTWORK_PATH.."TitanPanelBackground"..pos..math.mod(i, 2));
		end
		for i = 12, 22 do
			if barnumber == 2 then
				TitanPanelBarButtonHider:SetHeight(48);
				getglobal("TitanPanelBackground"..i):SetTexture(TITAN_ARTWORK_PATH.."TitanPanelBackground"..pos..math.mod(i, 2));
			else
				TitanPanelBarButtonHider:SetHeight(24);
				getglobal("TitanPanelBackground"..i):SetTexture();
			end
		end
	else
		local pos = TitanUtils_Ternary(position == TITAN_PANEL_PLACE_BOTTOM, "Top", "Bottom");
		for i = 0, 11 do
			getglobal("TitanPanelBackgroundAux"..i):SetTexture(TITAN_ARTWORK_PATH.."TitanPanelBackground".."Bottom"..math.mod(i, 2));
		end
		for i = 12, 22 do
			if barnumber == 2 then
				TitanPanelAuxBarButtonHider:SetHeight(48);
				getglobal("TitanPanelBackgroundAux"..i):SetTexture(TITAN_ARTWORK_PATH.."TitanPanelBackground".."Bottom"..math.mod(i, 2));
			else
				TitanPanelAuxBarButtonHider:SetHeight(24);
				getglobal("TitanPanelBackgroundAux"..i):SetTexture();
			end
		end
	end
end

function TitanPanel_InitPanelButtons()
	local button, leftButton, rightButton, leftAuxButton, rightAuxButton, leftDoubleButton, rightDoubleButton, leftAuxDoubleButton, rightAuxDoubleButton;
	local nextLeft, nextAuxLeft
	local newButtons = {};
	local scale = TitanPanelGetVar("Scale");
	local isClockOnRightSide;

	TitanPanelBarButton_DisplayBarsWanted();
	-- Position Clock first if it's displayed on the far right side
	if ( TitanUtils_TableContainsValue(TitanPanelSettings.Buttons, TITAN_CLOCK_ID) and TitanGetVar(TITAN_CLOCK_ID, "DisplayOnRightSide") ) then
		isClockOnRightSide = 1;
		button = TitanUtils_GetButton(TITAN_CLOCK_ID);
		local i = TitanPanel_GetButtonNumber(TITAN_CLOCK_ID)
		
		if TitanPanelSettings.Location[i] == nil then
			TitanPanelSettings.Location[i] = "Bar";
		end
		if TitanPanelSettings.Location[i] == "AuxBar" then
			button:ClearAllPoints();
			button:SetPoint("RIGHT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "RIGHT", -TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM_MAIN);
			rightAuxButton = button;
		else
			button:ClearAllPoints();
			button:SetPoint("RIGHT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "RIGHT", -TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_TOP_MAIN);
			rightButton = button;
		end
	end
	
	-- Position all the buttons 
	for index, id in TitanPanelSettings.Buttons do 
		if ( TitanUtils_IsPluginRegistered(id) ) then
			local i = TitanPanel_GetButtonNumber(id);
			if(TitanPanelSettings.Location[i] == nil) then
				if id ~= "AuxAutoHide" then
					TitanPanelSettings.Location[i] = "Bar";
				else
					TitanPanelSettings.Location[i] = "AuxBar";
				end
			end
		
			button = TitanUtils_GetButton(id);

			if ( id == TITAN_CLOCK_ID and isClockOnRightSide ) then
				-- Do nothing, since it's already positioned
			elseif ( TitanPanelButton_IsIcon(id) ) then	
			
				if ( rightAuxButton and TitanPanelSettings.Location[i] == "AuxBar" ) then
					button:ClearAllPoints();
					button:SetPoint("RIGHT", rightAuxButton:GetName(), "LEFT", -TITAN_PANEL_ICON_SPACEING * scale, 0); 
				elseif ( not rightButton ) then
					button:ClearAllPoints();
					button:SetPoint("RIGHT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "RIGHT", -TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_TOP_MAIN); 
				else
					if ( not rightAuxButton and TitanPanelSettings.Location[i] == "AuxBar") then
						button:ClearAllPoints();
						button:SetPoint("RIGHT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "RIGHT", -TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM_MAIN); 
					elseif TitanPanelSettings.Location[i] == "AuxBar" then
						button:ClearAllPoints();
						button:SetPoint("RIGHT", rightAuxButton:GetName(), "LEFT", -TITAN_PANEL_ICON_SPACEING * scale, 0); 
					else
						button:ClearAllPoints();
						button:SetPoint("RIGHT", rightButton:GetName(), "LEFT", -TITAN_PANEL_ICON_SPACEING * scale, 0); 
					end
				end

				if TitanPanelSettings.Location[i] == "AuxBar" then
					rightAuxButton = button;
				else
					rightButton = button;
				end
			else			
				if ( TitanPanelSettings.Location[i] == "AuxBar" ) then
					if (nextAuxLeft == "Double") then
					button:ClearAllPoints();
						button:SetPoint("LEFT", leftAuxDoubleButton:GetName(), "RIGHT", TITAN_PANEL_FRAME_SPACEING * scale, 0);
						nextAuxLeft = "Main"
						leftAuxDoubleButton = button;
					elseif (nextAuxLeft == "DoubleFirst") then
					button:ClearAllPoints();
						button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
						nextAuxLeft = "Main"
						leftAuxDoubleButton = button;
					elseif (nextAuxLeft == "Main") then
					button:ClearAllPoints();
						button:SetPoint("LEFT", leftAuxButton:GetName(), "RIGHT", TITAN_PANEL_FRAME_SPACEING * scale, 0);
						nextAuxLeft = TitanPanel_Nextbar("AuxDoubleBar");
						leftAuxButton = button;
					else
					button:ClearAllPoints();
						button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM_MAIN);
						nextAuxLeft = TitanPanel_Nextbar("AuxDoubleBar");
						if nextAuxLeft == "Double" then
							nextAuxLeft = "DoubleFirst";
						end
						leftAuxButton = button;
					end
				else
					if (nextLeft == "Double") then
						button:ClearAllPoints();
						button:SetPoint("LEFT", leftDoubleButton:GetName(), "RIGHT", TITAN_PANEL_FRAME_SPACEING * scale, 0);
						nextLeft = "Main"
						leftDoubleButton = button;
					elseif (nextLeft == "DoubleFirst") then
						button:ClearAllPoints();
						if TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP then
							button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_TOP);
						else
							button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
						end
						nextLeft = "Main"
						leftDoubleButton = button;
					elseif (nextLeft == "Main") then
						button:ClearAllPoints();
						button:SetPoint("LEFT", leftButton:GetName(), "RIGHT", TITAN_PANEL_FRAME_SPACEING * scale, 0);
						nextLeft = TitanPanel_Nextbar("DoubleBar");
						leftButton = button;
					else
						button:ClearAllPoints();
						button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_TOP_MAIN);
						nextLeft = TitanPanel_Nextbar("DoubleBar");
						if nextLeft == "Double" then
							nextLeft = "DoubleFirst";
						end
						leftButton = button;
					end
				end
			end
			
			table.insert(newButtons, id);
			button:Show();

		end
	end
	
	-- Set TitanPanelSettings.Buttons
	TitanPanelSettings.Buttons = newButtons;	
	
	-- Set panel button init flag
	TITAN_PANEL_BUTTONS_INIT_FLAG = 1;
	TitanPanelButton_Justify();
end

function TitanPanel_Nextbar(var)
	if TitanPanelGetVar(var) == TITAN_PANEL_BARS_DOUBLE then
		return "Double";
	else
		return "Main";
	end
end

function TitanPanel_RemoveButton(id)
	if ( not TitanPanelSettings ) then
		return;
	end 
	
	local i = TitanPanel_GetButtonNumber(id)
	local currentButton = TitanUtils_GetButton(id);
	currentButton:Hide();					

	TitanPanel_ReOrder(i);
	table.remove(TitanPanelSettings.Buttons, TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, id));
	TitanPanel_InitPanelButtons();
end

function TitanPanel_AddButton(id)
	if (not TitanPanelSettings) then
		return;
	end 

	local i = TitanPanel_GetButtonNumber(id)
	TitanPanelSettings.Location[i] = TITAN_PANEL_SELECTED;

	table.insert(TitanPanelSettings.Buttons, id);	

	TitanPanel_InitPanelButtons();
end

function TitanPanel_ReOrder(index)
	for i = index, table.getn(TitanPanelSettings.Buttons) do		
		TitanPanelSettings.Location[i] = TitanPanelSettings.Location[i+1]
	end
end

function TitanPanel_GetButtonNumber(id)
	if (TitanPanelSettings) then
		for i = 1, table.getn(TitanPanelSettings.Buttons) do		
			if(TitanPanelSettings.Buttons[i] == id) then
				return i;
			end	
		end
		return table.getn(TitanPanelSettings.Buttons)+1;
	else
		return 0;
	end
end

function TitanPanel_RefreshPanelButtons()
	if (TitanPanelSettings) then
		for i = 1, table.getn(TitanPanelSettings.Buttons) do		
			TitanPanelButton_UpdateButton(TitanPanelSettings.Buttons[i], 1);		
		end
	end
end

function TitanPanelButton_Justify()	
	if ( not TITAN_PANEL_BUTTONS_INIT_FLAG or not TitanPanelSettings ) then
		return;
	end

	-- Check if clock displayed on the far right side
	local isClockOnRightSide;
	if ( TitanUtils_TableContainsValue(TitanPanelSettings.Buttons, TITAN_CLOCK_ID) and TitanGetVar(TITAN_CLOCK_ID, "DisplayOnRightSide") ) then
		isClockOnRightSide = 1;
	end
	
	local firstLeftButton = TitanUtils_GetFirstButton(TitanPanelSettings.Buttons, 1, nil, isClockOnRightSide);
	local secondLeftButton;
	local scale = TitanPanelGetVar("Scale");
	local leftWidth = 0;
	local rightWidth = 0;
	local leftDoubleWidth = 0;
	local rightDoubleWidth = 0;
	local counter = 0;
	local triggered = 0;
	if ( firstLeftButton ) then
		if ( TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_LEFT ) then
			counter = 0;
			triggered = 0;
			for index, id in TitanPanelSettings.Buttons do
				local button = TitanUtils_GetButton(id);
				
				if ( not button:GetWidth() ) then 
					return; 
				end
				if TitanUtils_GetWhichBar(id) == "Bar" then
					if TitanPanelGetVar("DoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
						if triggered == 0 then
							secondLeftButton = button;
							triggered = 1;
						end
					end
					if ( TitanPanelButton_IsIcon(id) or (id == TITAN_CLOCK_ID and isClockOnRightSide) ) then
						-- Do nothing
					else
						counter = counter + 1;
					end
				end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_TOP_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				if TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP then
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_TOP);
				else
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
				end
			end

		elseif ( TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
			leftWidth = 0;
			rightWidth = 0;
			leftDoubleWidth = 0;
			rightDoubleWidth = 0;
			counter = 0;
			triggered = 0;
			for index, id in TitanPanelSettings.Buttons do
				local button = TitanUtils_GetButton(id);
				
				if ( not button:GetWidth() ) then 
					return; 
				end
				if TitanUtils_GetWhichBar(id) == "Bar" then
					if TitanPanelGetVar("DoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
						if triggered == 0 then
							secondLeftButton = button;
							triggered = 1;
						end
						if ( TitanPanelButton_IsIcon(id) or (id == TITAN_CLOCK_ID and isClockOnRightSide) ) then
							rightDoubleWidth = rightDoubleWidth + TITAN_PANEL_ICON_SPACEING + button:GetWidth();
						else
							counter = counter + 1;
							leftDoubleWidth = leftDoubleWidth + TITAN_PANEL_FRAME_SPACEING + button:GetWidth();
						end
					else
						if ( TitanPanelButton_IsIcon(id) or (id == TITAN_CLOCK_ID and isClockOnRightSide) ) then
							rightWidth = rightWidth + TITAN_PANEL_ICON_SPACEING + button:GetWidth();
						else
							counter = counter + 1;
							leftWidth = leftWidth + TITAN_PANEL_FRAME_SPACEING + button:GetWidth();
						end
					end
				end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "CENTER", 0 - leftWidth / 2, TITAN_PANEL_FROM_TOP_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				if TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP then
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "CENTER", 0 - leftDoubleWidth / 2, TITAN_PANEL_FROM_TOP);
				else
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "CENTER", 0 - leftDoubleWidth / 2, TITAN_PANEL_FROM_BOTTOM);
				end
			end
		end
	end

	local firstLeftButton = TitanUtils_GetFirstAuxButton(TitanPanelSettings.Buttons, 1, nil, isClockOnRightSide);
	secondLeftButton = nil;
	if ( firstLeftButton ) then
		if ( TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_LEFT ) then
			triggered = 0;
			counter = 0;
			for index, id in TitanPanelSettings.Buttons do
				local button = TitanUtils_GetButton(id);
				
				if ( not button:GetWidth() ) then 
					return; 
				end
				if TitanUtils_GetWhichBar(id) == "AuxBar" then
					if TitanPanelGetVar("AuxDoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
						if triggered == 0 then
							secondLeftButton = button;
							triggered = 1;
						end
					end
					if ( TitanPanelButton_IsIcon(id) or (id == TITAN_CLOCK_ID and isClockOnRightSide) ) then
						-- Do nothing
					else
						counter = counter + 1;
					end
				end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				secondLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "LEFT", TITAN_PANEL_FRAME_SPACEING / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
			end
		elseif ( TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
			leftWidth = 0;
			rightWidth = 0;
			leftDoubleWidth = 0;
			rightDoubleWidth = 0;
			counter = 0;
			triggered = 0;
			for index, id in TitanPanelSettings.Buttons do
				local button = TitanUtils_GetButton(id);
				
				if ( not button:GetWidth() ) then 
					return; 
				end
				if TitanUtils_GetWhichBar(id) == "AuxBar" then
					if TitanPanelGetVar("AuxDoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
						if triggered == 0 then
							secondLeftButton = button;
							triggered = 1;
						end
						if ( TitanPanelButton_IsIcon(id) or (id == TITAN_CLOCK_ID and isClockOnRightSide) ) then
							rightDoubleWidth = rightDoubleWidth + TITAN_PANEL_ICON_SPACEING + button:GetWidth();
						else
							counter = counter + 1;
							leftDoubleWidth = leftDoubleWidth + TITAN_PANEL_FRAME_SPACEING + button:GetWidth();
						end
					else
						if ( TitanPanelButton_IsIcon(id) or (id == TITAN_CLOCK_ID and isClockOnRightSide) ) then
							rightWidth = rightWidth + TITAN_PANEL_ICON_SPACEING + button:GetWidth();
						else
							counter = counter + 1;
							leftWidth = leftWidth + TITAN_PANEL_FRAME_SPACEING + button:GetWidth();
						end
					end
				end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "CENTER", 0 - leftWidth / 2, TITAN_PANEL_FROM_BOTTOM_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				secondLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "CENTER", 0 - leftDoubleWidth / 2, TITAN_PANEL_FROM_BOTTOM);
			end
		end
	end

end

function TitanPanel_SetScale()
	local scale = TitanPanelGetVar("Scale");
	local fontscale = TitanPanelGetVar("FontScale");
	TitanPanelBarButton:SetScale(scale);
	if not TitanPanelGetVar("DisableFont") then
		GameTooltip:SetScale(fontscale);
	end

	for index, value in TitanPlugins do
		if index ~= nil then
			TitanUtils_GetButton(index):SetScale(scale);
		end
	end
end

function TitanPanelRightClickMenu_Customize() 
	StaticPopupDialogs["CUSTOMIZATION_FEATURE_COMING_SOON"] = {
		text = TEXT(CUSTOMIZATION_FEATURE_COMING_SOON),
		button1 = TEXT(OKAY),
		showAlert = 1,
		timeout = 0,
	};
	StaticPopup_Show("CUSTOMIZATION_FEATURE_COMING_SOON");
end

function TitanPanel_LoadError(ErrorMsg) 
	StaticPopupDialogs["LOADING_ERROR"] = {
		text = ErrorMsg,
		button1 = TEXT(OKAY),
		showAlert = 1,
		timeout = 0,
	};
	StaticPopup_Show("LOADING_ERROR");
end

function TitanPanelRightClickMenu_PrepareBarMenu()
	-- Level 2
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		TitanPanel_BuildPluginsMenu();
		TitanPanel_BuildOtherPluginsMenu();
		TitanPanel_OptionsMenu();
		TitanPanel_LoadServerSettingsMenu();
		return;
	end
	
	-- Level 3
	if ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) then
		TitanPanel_LoadPlayerSettingsMenu();
		return;
	end

	-- Level 1
	TitanPanel_MainMenu()
end

function TitanPanel_MainMenu()
	local info = {};
	local checked;
	local plugin;
	local frame = this:GetName();
	local frname = getglobal(frame);

	TitanPanelRightClickMenu_AddTitle(TITAN_PANEL_MENU_TITLE);

	if frame == "TitanPanelBarButton" then
		info = {};
		info.text = TITAN_PANEL_MENU_BUILTINS;
		info.value = "Builtins";
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);
	else
		info = {};
		info.text = TITAN_PANEL_MENU_BUILTINS;
		info.value = "BuiltinsAux";
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);
	end

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
	TitanPanelRightClickMenu_AddTitle(TITAN_PANEL_MENU_PLUGINS);


	for index, id in TITAN_PANEL_MENU_CATEGORIES do
		info = {};
		info.text = TITAN_PANEL_MENU_CATEGORIES[index];
		info.value = "Addons_" .. TITAN_PANEL_BUTTONS_PLUGIN_CATEGORY[index];
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);
	end

	TitanPanelRightClickMenu_AddSpacer();	

	if frame == "TitanPanelBarButton" then
		info = {};
		info.text = TITAN_PANEL_MENU_OPTIONS;
		info.value = "Options";
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);
	else
		info = {};
		info.text = TITAN_PANEL_MENU_OPTIONS;
		info.value = "OptionsAux";
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);
	end
	
	info = {};
	info.text = TITAN_PANEL_MENU_LOAD_SETTINGS;
	info.value = "Settings";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
end

function TitanPanel_OptionsMenu()
	local info = {};

	if ( UIDROPDOWNMENU_MENU_VALUE == "OptionsAux" ) then
		info = {};
		info.text = TITAN_PANEL_MENU_AUTOHIDE;
		info.func = TitanPanelBarButton_ToggleAuxAutoHide;
		info.checked = TitanPanelGetVar("AuxAutoHide");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITAN_PANEL_MENU_CENTER_TEXT;
		info.func = TitanPanelBarButton_ToggleAuxAlign;
		info.checked = (TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER);
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
		info = {};
		info.text = TITAN_PANEL_MENU_DISABLE_PUSH;
		info.func = TitanPanelBarButton_ToggleAuxScreenAdjust;
		info.checked = TitanPanelGetVar("AuxScreenAdjust");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITAN_PANEL_MENU_DOUBLE_BAR;
		info.func = TitanPanelBarButton_ToggleAuxDoubleBar;
		info.checked = TitanPanelGetVar("AuxDoubleBar") == TITAN_PANEL_BARS_DOUBLE;
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	if ( UIDROPDOWNMENU_MENU_VALUE == "Options" ) then
		info = {};
		info.text = TITAN_PANEL_MENU_AUTOHIDE;
		info.func = TitanPanelBarButton_ToggleAutoHide;
		info.checked = TitanPanelGetVar("AutoHide");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
		info = {};
		info.text = TITAN_PANEL_MENU_CENTER_TEXT;
		info.func = TitanPanelBarButton_ToggleAlign;
		info.checked = (TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER);
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
		info = {};
		info.text = TITAN_PANEL_MENU_DISABLE_PUSH;
		info.func = TitanPanelBarButton_ToggleScreenAdjust;
		info.checked = TitanPanelGetVar("ScreenAdjust");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
		info = {};
		info.text = TITAN_PANEL_MENU_DOUBLE_BAR;
		info.func = TitanPanelBarButton_ToggleDoubleBar;
		info.checked = TitanPanelGetVar("DoubleBar") == TITAN_PANEL_BARS_DOUBLE;
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end

	if ( UIDROPDOWNMENU_MENU_VALUE == "Options" or UIDROPDOWNMENU_MENU_VALUE == "OptionsAux" ) then
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITAN_PANEL_MENU_DISPLAY_ONTOP;
		info.func = TitanPanelBarButton_TogglePosition;
		info.checked = (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP);
		info.disabled = TitanPanelGetVar("BothBars")
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
		info = {};
		info.text = TITAN_PANEL_MENU_DISPLAY_BOTH;
		info.func = TitanPanelBarButton_ToggleBarsShown;
		info.checked = TitanPanelGetVar("BothBars");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
		info = {};
		info.text = TITAN_PANEL_MENU_TOOLTIPS_SHOWN;
		info.func = TitanPanelBarButton_ToggleToolTipsShown;
		info.checked = TitanPanelGetVar("ToolTipsShown");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITAN_PANEL_MENU_VERSION_SHOWN;
		info.func = TitanPanelBarButton_ToggleVersionShown;
		info.checked = TitanPanelGetVar("VersionShown");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITAN_PANEL_MENU_DISBALE_FONT;
		info.func = TitanPanelBarButton_ToggleDisableFont;
		info.checked = TitanPanelGetVar("DisableFont");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITAN_PANEL_MENU_CASTINGBAR;
		info.func = TitanPanelBarButton_ToggleCastingBar;
		info.checked = TitanPanelGetVar("CastingBar");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITAN_PANEL_MENU_RESET;
		info.func = TitanPanel_ResetBar;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
end

function TitanPanel_LoadServerSettingsMenu()
	local info = {};
	local servers = {};
	local server = nil;
	local s, e, ident;


	if ( UIDROPDOWNMENU_MENU_VALUE == "Settings" ) then
		for index, id in TitanSettings.Players do
			s, e, ident = string.find(index, "@");
			if s ~= nil then
				server = string.sub(index, s+1);
			else
				server = "Unknown";
			end
			
			if TitanUtils_GetCurrentIndex(servers, server) == nil then
				table.insert(servers, server);	
				info = {};
				info.text = server;
				info.value = server;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
end

function TitanPanel_LoadPlayerSettingsMenu()
	local info = {};
	local player = nil;
	local server = nil;
	local s, e, ident;


	for index, id in TitanSettings.Players do
		s, e, ident = string.find(index, "@");
		if s ~= nil then
			server = string.sub(index, s+1);
			player = string.sub(index, 1, s-1);
		else
			server = "Unknown";
			player = "Unknown";
		end
		
		if server == UIDROPDOWNMENU_MENU_VALUE then
			info = {};
			info.text = player;
			info.value = index;
			info.func = TitanVariables_UseSettings;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
	end
end

function TitanPanel_BuildOtherPluginsMenu()
	local info = {};
	local checked;
	local plugin;
	local frame = this:GetName();
	local frname = getglobal(frame);

	for index, id in TitanPluginsIndex do
		plugin = TitanUtils_GetPlugin(id);
		if not plugin.category then
			plugin.category = "General";
		end
			
		if ( UIDROPDOWNMENU_MENU_VALUE == "Addons_" .. plugin.category ) then
			if (not plugin.builtIn) then
				checked = nil;
				if ( TitanPanel_IsPluginShown(id) ) then
					checked = 1;
				end
				
				info = {};
				if plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
					info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
				else
					info.text = plugin.menuText;
				end
				info.value = id;
				info.func = TitanPanelRightClickMenu_BarOnClick;
				info.checked = checked;
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
end

function TitanPanel_BuildPluginsMenu()
	local info = {};
	local checked;
	local plugin;

	if ( UIDROPDOWNMENU_MENU_VALUE == "Builtins" ) then
		TitanPanelRightClickMenu_AddTitle(TITAN_PANEL_MENU_LEFT_SIDE, UIDROPDOWNMENU_MENU_LEVEL);
		
		for index, id in TitanPluginsIndex do
			plugin = TitanUtils_GetPlugin(id);
			if ( plugin.builtIn and ( TitanPanel_GetPluginSide(id) == "Left") ) then
				checked = nil;
				if ( TitanPanel_IsPluginShown(id) ) then
					checked = 1;
				end
		
				info = {};
				if plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
					info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
				else
					info.text = plugin.menuText;
				end
				info.value = id;
				info.func = TitanPanelRightClickMenu_BarOnClick;
				info.checked = checked;
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
		
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
		TitanPanelRightClickMenu_AddTitle(TITAN_PANEL_MENU_RIGHT_SIDE, UIDROPDOWNMENU_MENU_LEVEL);
	
		for index, id in TitanPluginsIndex do
			plugin = TitanUtils_GetPlugin(id);
			if ( plugin.builtIn and ( TitanPanel_GetPluginSide(id) == "Right") ) then
				checked = nil;
				if ( TitanPanel_IsPluginShown(id) ) then
					checked = 1;
				end
		
				if id ~= "AuxAutoHide" then
					info = {};
					if plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
						info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
					else
						info.text = plugin.menuText;
					end
					info.value = id;
					info.func = TitanPanelRightClickMenu_BarOnClick;
					info.checked = checked;
					info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
	end		
	if ( UIDROPDOWNMENU_MENU_VALUE == "BuiltinsAux" ) then
		TitanPanelRightClickMenu_AddTitle(TITAN_PANEL_MENU_LEFT_SIDE, UIDROPDOWNMENU_MENU_LEVEL);
		
		for index, id in TitanPluginsIndex do
			plugin = TitanUtils_GetPlugin(id);
			if ( plugin.builtIn and ( TitanPanel_GetPluginSide(id) == "Left") ) then
				checked = nil;
				if ( TitanPanel_IsPluginShown(id) ) then
					checked = 1;
				end
		
				info = {};
				if plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
					info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
				else
					info.text = plugin.menuText;
				end
				info.value = id;
				info.func = TitanPanelRightClickMenu_BarOnClick;
				info.checked = checked;
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
		
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);	
		TitanPanelRightClickMenu_AddTitle(TITAN_PANEL_MENU_RIGHT_SIDE, UIDROPDOWNMENU_MENU_LEVEL);
	
		for index, id in TitanPluginsIndex do
			plugin = TitanUtils_GetPlugin(id);
			if ( plugin.builtIn and ( TitanPanel_GetPluginSide(id) == "Right") ) then
				checked = nil;
				if ( TitanPanel_IsPluginShown(id) ) then
					checked = 1;
				end
		
				if id ~= "AutoHide" then
					info = {};
					if plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
						info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
					else
						info.text = plugin.menuText;
					end
					info.value = id;
					info.func = TitanPanelRightClickMenu_BarOnClick;
					info.checked = checked;
					info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
	end
end

function TitanPanel_IsPluginShown(id)
	if ( id and TitanPanelSettings ) then
		return TitanUtils_TableContainsValue(TitanPanelSettings.Buttons, id);
	end
end

function TitanPanel_GetPluginSide(id)
	if ( id == TITAN_CLOCK_ID and TitanGetVar(TITAN_CLOCK_ID, "DisplayOnRightSide") ) then
		return "Right";
	elseif ( TitanPanelButton_IsIcon(id) ) then
		return "Right";
	else
		return "Left";
	end
end

function TitanPanel_ResetBar()
	local playerName = UnitName("player");
	local serverName = GetCVar("realmName");

	TitanCopyPlayerSettings = TitanSettings.Players[playerName.."@"..serverName];
	TitanCopyPluginSettings = TitanCopyPlayerSettings["Plugins"];

	for index, id in TitanPanelSettings["Buttons"] do
		local currentButton = TitanUtils_GetButton(TitanPanelSettings["Buttons"][index]);
		currentButton:Hide();					
	end

	TitanSettings.Players[playerName.."@"..serverName] = {};
	TitanSettings.Players[playerName.."@"..serverName].Plugins = {};
	TitanSettings.Players[playerName.."@"..serverName].Panel = {}
	TitanSettings.Players[playerName.."@"..serverName].Panel.Buttons = TITAN_PANEL_INITIAL_PLUGINS;
	TitanSettings.Players[playerName.."@"..serverName].Panel.Locations = TITAN_PANEL_INITIAL_PLUGIN_LOCATION;
	
	TITAN_FIRST_LOAD = 1;		

	-- Set global variables
	TitanPlayerSettings = TitanSettings.Players[playerName.."@"..serverName];
	TitanPluginSettings = TitanPlayerSettings["Plugins"];
	TitanPanelSettings = TitanPlayerSettings["Panel"];	

	ReloadUI()
end

TitanPanelDetails = {
	name = "Titan Panel (Multibar)",
	description = "Adds a control panel/info box at the top and bottom of the screen.",
	version = TITAN_VERSION,
	releaseDate = TITAN_LAST_UPDATED,
	author = "TitanMod/Adsertor",
	email = "",
	website = "http://ui.worldofwar.net/ui.php?id=1442",
	category = MYADDONS_CATEGORY_BARS,
	frame = "TitanPanel",
	optionsframe = "",
};

TitanPanelHelp = {};
TitanPanelHelp[1] = "Titan Panel adds a control panel/info box at the top and bottom of the screen.\n\nFeatures include:\n1. Ammo/Thrown counter\n2. Bag\n3. Experience (XP)\n4. FPS\n5. Latency\n6. Location\n7. Loot Type\n8. Memory\n9. Money\n10. PvP Honor\n11. Clock\n\nAlso build-in controls allow you to:\n1. Adjust master sound volume\n2. Adjust UI Scale\n3. Adjust panel transparency\n4. Toggle auto-hide on/off\n\nFully support plug-ins system. All modules on the panel are plug-n-play. Allows other developers to create plugins to import the new features.\n\n\nThanks go to\n- Sotakone, for providing a bug fix for German clients\n- Kilan, for submitting code which makes Titan Panel save per-realm-per-character";

function TitanPanelFrame_OnLoad()
	-- Register the events that need to be watched
	this:RegisterEvent("VARIABLES_LOADED");
end

function TitanPanelFrame_OnEvent()
	if(event == "VARIABLES_LOADED") then
		-- Check if myAddOns is loaded
		if(myAddOnsFrame_Register) then
			-- Register the addon in myAddOns
			myAddOnsFrame_Register(TitanPanelDetails, TitanPanelHelp);
		end
	end
end

function TitanPanel_AddonLoaded(addonname)
	if addonname == "Blizzard_BattlefieldMinimap" then
		if ( not BattlefieldMinimapOptions ) then
			BattlefieldMinimapOptions = BattlefieldMinimapDefaults;
		end

		if not ( BattlefieldMinimapOptions.position ) then
			BattlefieldMinimapTab:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", 845, 443);
			BattlefieldMinimapTab:SetUserPlaced(true);
			BattlefieldMinimapTab:Show();
			BattlefieldMinimapOptions["locked"] = false
			BattlefieldMinimapOptions.position = {};
			BattlefieldMinimapOptions.position.x, BattlefieldMinimapOptions.position.y = BattlefieldMinimapTab:GetCenter();
			local loaded, reason = LoadAddOn("Blizzard_BattlefieldMinimap");
		end
	end
end