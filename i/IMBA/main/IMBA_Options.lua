function IMBA_Options_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);
	IMBA_Options_Update();
	this:RegisterEvent("VARIABLES_LOADED");

	IMBA_Options_Title:SetText("IMBA Options "..IMBA_Version);
	this:SetScale(0.9);
end

--Taken from CTRA
function IMBA_SortTable(t1, t2)
	local locs = { };
	for k, v in IMBA_Locations do
		locs[v[1]] = k;
	end
	if ( t1[2] and t2[2] ) then
		return locs[t1[1]] < locs[t2[1]];
	else
		local loc1, loc2;
		if ( t1[2] ) then
			loc1 = locs[t1[1]];
		else
			loc1 = locs[t1[4]];
		end
		if ( t2[2] ) then
			loc2 = locs[t2[1]];
		else
			loc2 = locs[t2[4]];
		end
		if ( loc1 == loc2 ) then
			if ( t1[2] or t2[2] ) then
				return (t1[2]);
			else
				return t1[1] < t2[1];
			end
		else
			return loc1 < loc2;
		end
	end
end

function IMBA_CalculateEntries()
	local locIndexes = { };
	local tbl = { };
	local numPerLoc = { };
	
	-- Calculate number of mods per location
	for k, v in IMBA_Addons do
		local loc = v.Location;
		if ( not loc ) then
			loc = "Other";
		end
		if ( not numPerLoc[loc] ) then
			numPerLoc[loc] = 1;
		else
			numPerLoc[loc] = numPerLoc[loc] + 1;
		end
	end
	-- Populate the locIndexes table with the locations we have
	for k, v in IMBA_Locations do
		-- Only add if there are mods for it
		if ( numPerLoc[v[1]] ) then
			locIndexes[v[1]] = v[2];
			tinsert(tbl, { v[1], 1, v[2] });
		end
	end
	
	-- Calculate which records to add
	for k, v in IMBA_Addons do
		if ( not v.Location ) then
			v.Location = "Other";
		end
		if ( locIndexes[v.Location] and locIndexes[v.Location] == 1 ) then
			tinsert(tbl, { k, nil, v, v.Location });
		end
	end
	
	-- Sort the table
	table.sort(tbl, IMBA_SortTable);
	
	return tbl, numPerLoc;
end


function IMBA_Options_Update()
	local tbl, numPerLoc = IMBA_CalculateEntries();
	local numEntries = getn(tbl);
	-- ScrollFrame update
	FauxScrollFrame_Update(IMBA_Options_BossFrame_ScrollFrame, numEntries, 8, 25 );
	
	for i=1, 8, 1 do
		local obj = getglobal("IMBA_Options_BossFrame_BossMod" .. i);
		local nameText = getglobal("IMBA_Options_BossFrame_BossMod" .. i .. "Name");
		local descriptText = getglobal("IMBA_Options_BossFrame_BossMod" .. i .. "Descript");
		local statusText = getglobal("IMBA_Options_BossFrame_BossMod" .. i .. "Status");
		local line = getglobal("IMBA_Options_BossFrame_BossMod" .. i .. "Line");
		local dropdown = getglobal("IMBA_Options_BossFrame_BossMod" .. i .. "Menu");
		local plusMinus = getglobal("IMBA_Options_BossFrame_BossMod" .. i .. "ShowHide");
		local prevLine = getglobal("IMBA_Options_BossFrame_BossMod" .. i-1 .. "Line");
		
		local index = i + FauxScrollFrame_GetOffset(IMBA_Options_BossFrame_ScrollFrame); 

		if ( index <= numEntries ) then
			obj:Show();
			line:Hide();
			if ( not tbl[index][2] ) then
				-- Not a header
				obj.header = nil;
				nameText:SetText(tbl[index][1]);
				nameText:SetTextColor(0.5, 0.5, 0.5);
				nameText:ClearAllPoints();
				nameText:SetPoint("TOPLEFT", obj:GetName(), "TOPLEFT", 45, 0);
				plusMinus:Hide();
				if ( tbl[index][3].Active ) then
					statusText:SetText("On");
					statusText:SetTextColor(0, 1, 0);
				else					
					statusText:SetText("Off");
					statusText:SetTextColor(1, 0, 0);
				end

				if IMBA_CheckIfCanActivate(tbl[index][1]) then
					statusText:Show();
				else
					statusText:Hide();
				end

				if ( tbl[index][3].Description ) then
					descriptText:SetText(tbl[index][3].Description);
				else
					descriptText:SetText("");
				end
				obj.index = tbl[index][1];
				if ( not obj.hasBeenInitialized ) then
					UIDropDownMenu_Initialize(dropdown,  IMBA_InitDropDown, "MENU");
					obj.hasBeenInitialized = 1;
				end
			else
				if ( prevLine ) then
					prevLine:Show();
				end
				-- Header
				obj.header = 1;
				obj.headername = tbl[index][1];
				local num = numPerLoc[tbl[index][1]];
				if ( not num ) then
					num = 0;
				end
				plusMinus:Show();
				if ( tbl[index][3] == 1 ) then
					if ( obj.mouseIsOver ) then
						GameTooltip:SetText("Click to contract");
					end
					plusMinus:SetText("-");
					obj.expanded = 1;
				else
					if ( obj.mouseIsOver ) then
						GameTooltip:SetText("Click to expand");
					end
					plusMinus:SetText("+");
					obj.expanded = nil;
				end
				nameText:SetText(tbl[index][1] .. " (" .. num .. ")");
				nameText:SetTextColor(1, 1, 1);
				nameText:ClearAllPoints();
				nameText:SetPoint("LEFT", obj:GetName(), "LEFT", 12, 0);
				statusText:SetText("");
				descriptText:SetText("");
			end
		else
			obj:Hide();
		end
	end
end

function IMBA_AddonVarClicked()
	if IMBA_SavedVariables.Mods[this.value[1]]==nil then
		IMBA_SavedVariables.Mods[this.value[1]]={};
	end
	if IMBA_SavedVariables.Mods[this.value[1]].Var==nil then
		IMBA_SavedVariables.Mods[this.value[1]].Var={};
	end
	if IMBA_SavedVariables.Mods[this.value[1]].Var[this.value[2]] then
		IMBA_SavedVariables.Mods[this.value[1]].Var[this.value[2]]=false;
	else
		IMBA_SavedVariables.Mods[this.value[1]].Var[this.value[2]]=true;
	end
end

function IMBA_InitDropDown()
	local modName = getglobal(UIDROPDOWNMENU_INIT_MENU):GetParent().index;
	local info = {};
	
	info.text = modName;
	info.isTitle = 1;
	info.justifyH = "CENTER";
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	if IMBA_CheckIfCanActivate(modName) then
		info = { };
		info.text = "Enable mod";
		info.tooltipTitle = "Enable mod";
		info.tooltipText = "Enables the mod, turning on all enabled options.";
		info.checked = IMBA_Addons[modName].Active;
		info.func = IMBA_EnableMod;
		info.keepShownOnClick = 1;
		info.value = modName;
		UIDropDownMenu_AddButton(info);	
	end

	if IMBA_Addons[modName].MainFrame then
		info = { };
		info.text = "Visible";
		info.tooltipTitle = "Visible";
		info.tooltipText = "Toggles Visibility on the Addon. (If the addon is enabled it will auto become visible at the beginning of the boss fight)";
		info.checked = IMBA_SavedVariables.Mods[modName].Visible;
		info.func = IMBA_ToggleModVisibility;
		info.keepShownOnClick = 1;
		info.value = modName;
		UIDropDownMenu_AddButton(info);	
	end

	--if IMBA_CheckIfCanActivate(modName) then
	--	info = { };
	--	info.text = "Test mod";
	--	info.tooltipTitle = "Test mod";
	--	info.tooltipText = "Tests the mod, initializing it";
	--	info.keepShownOnClick = 1;
	--	info.checked = 0;
	--	info.func = IMBA_TestMod;
	--	info.value = modName;
	--	UIDropDownMenu_AddButton(info);	
	--end

	if IMBA_Addons[modName].Options then
		for k, v in IMBA_Addons[modName].OptionsOrder do
			option=IMBA_Addons[modName].Options[v];
			info = { };
			info.text = option.text;
			info.keepShownOnClick = 1;
			info.checked = option.valuefunc();
			info.func = option.func;
			UIDropDownMenu_AddButton(info);	
		end
	end
	if IMBA_Addons[modName].VarText then
		for k, option in IMBA_Addons[modName].OptionsOrder2 do
			info = { };
			info.text = IMBA_Addons[modName].VarText[option];
			info.keepShownOnClick = 1;
			if IMBA_SavedVariables.Mods[modName].Var==nil then
				IMBA_SavedVariables.Mods[modName].Var={};
			end
			info.checked = IMBA_SavedVariables.Mods[modName].Var[option];
						
			info.func = IMBA_AddonVarClicked;
			info.value = {modName,option};
			UIDropDownMenu_AddButton(info);	
		end
	end
end

-- Enable/Disable mod
function IMBA_EnableMod()
	IMBA_Addons[this.value].Active = not IMBA_Addons[this.value].Active;
	IMBA_SavedVariables.Mods[this.value].Active = IMBA_Addons[this.value].Active;
	IMBA_Options_Update();
end

-- Tests the Mod
function IMBA_TestMod()
	if IMBA_Addons[this.value].RegenActivator then
		getglobal(IMBA_Addons[this.value].RegenActivator)();
	elseif IMBA_Addons[this.value].YellActivator then
		getglobal(IMBA_Addons[this.value].YellActivator)(IMBA_Addons[this.value].TestYell);
	end
end

function IMBA_ToggleModVisibility()
	IMBA_SavedVariables.Mods[this.value].Visible = not IMBA_SavedVariables.Mods[this.value].Visible;
	if IMBA_SavedVariables.Mods[this.value].Visible then
		getglobal(IMBA_Addons[this.value].MainFrame):Show();
	else
		getglobal(IMBA_Addons[this.value].MainFrame):Hide();
	end
end


function IMBA_ToggleHeader(name)
	for k, v in IMBA_Locations do
		if ( v[1] == name ) then
			if ( v[2] == 1 ) then
				IMBA_Locations[k][2] = 0;
			else
				IMBA_Locations[k][2] = 1;
			end
			break;
		end
	end
	IMBA_Options_Update();
end

function IMBA_Options_OnEvent(event)
	if event=="VARIABLES_LOADED" then
		IMBA_Options_Update();
	end
end

function IMBA_FrameSettingsDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, IMBA_FrameSettingsDropDown_Initialize);
end

function IMBA_FrameSettingsDropDown_Initialize()	

	for i=1,2,1 do
		info = {};
		info.text = IMBA_BG[i].name;
		info.value = i;
		info.func = IMBA_FrameSettingsDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end

	if IMBA_SavedVariables.FrameType==nil then
		IMBA_SavedVariables.FrameType=1;
	end
	
	UIDropDownMenu_SetSelectedID(IMBA_Options_GraphicsFrame_FrameSettings_DropDown,IMBA_SavedVariables.FrameType);
end

function IMBA_FrameSettingsDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(IMBA_Options_GraphicsFrame_FrameSettings_DropDown, this.value);
	IMBA_SavedVariables.FrameType=this.value;
	IMBA_SetBackdrops(this.value);
end

function IMBA_BarSettingsDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, IMBA_BarSettingsDropDown_Initialize);
end


function IMBA_BarSettingsDropDown_Initialize()	

	for i=1,5,1 do
		info = {};
		info.text = IMBA_BarTextures[i].name;
		info.value = i;
		info.func = IMBA_BarSettingsDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
	
	if IMBA_SavedVariables.BarTextureNum==nil then
		IMBA_SavedVariables.BarTextureNum=1;
	end

	UIDropDownMenu_SetSelectedID(IMBA_Options_GraphicsFrame_BarSettings_DropDown,IMBA_SavedVariables.BarTextureNum);
end

function IMBA_BarSettingsDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(IMBA_Options_GraphicsFrame_BarSettings_DropDown, this.value);
	IMBA_SavedVariables.BarTextureNum=this.value;
end

function IMBA_ShowModOptions()
	IMBA_Options_BossFrame:Show();
	IMBA_Options_GraphicsFrame:Hide();
end

function IMBA_ShowGraphicsOptions()
	IMBA_SetupOptionColors();
	IMBA_Options_BossFrame:Hide();
	IMBA_Options_GraphicsFrame:Show();
end

function IMBA_SetupOptionColors()
	if IMBA_SavedVariables.Colors["FrameBG"]==nil then
		IMBA_SavedVariables.Colors["FrameBG"]={r=0,g=0,b=0,a=0.6};
	end
	if IMBA_SavedVariables.Colors["FrameBorder"]==nil then
		IMBA_SavedVariables.Colors["FrameBorder"]={r=1,g=1,b=1,a=1};
	end
	if IMBA_SavedVariables.Colors["BarStart"]==nil then
		IMBA_SavedVariables.Colors["BarStart"]={r=1,g=1,b=1};
	end
	if IMBA_SavedVariables.Colors["BarEnd"]==nil then
		IMBA_SavedVariables.Colors["BarEnd"]={r=1,g=1,b=1};
	end
	IMBA_Options_GraphicsFrame_FrameSettings_BGColor.color=IMBA_SavedVariables.Colors["FrameBG"];
	IMBA_Options_GraphicsFrame_FrameSettings_BGColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b);
	IMBA_Options_GraphicsFrame_FrameSettings_BorderColor.color=IMBA_SavedVariables.Colors["FrameBorder"];
	IMBA_Options_GraphicsFrame_FrameSettings_BorderColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b);
	IMBA_Options_GraphicsFrame_BarSettings_StartColor.color=IMBA_SavedVariables.Colors["BarStart"];
	IMBA_Options_GraphicsFrame_BarSettings_StartColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarStart"].r,IMBA_SavedVariables.Colors["BarStart"].g,IMBA_SavedVariables.Colors["BarStart"].b);
	IMBA_Options_GraphicsFrame_BarSettings_EndColor.color=IMBA_SavedVariables.Colors["BarEnd"]
	IMBA_Options_GraphicsFrame_BarSettings_EndColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarEnd"].r,IMBA_SavedVariables.Colors["BarEnd"].g,IMBA_SavedVariables.Colors["BarEnd"].b);
	IMBA_Options_GraphicsFrame_BarSettings_InnerColor.color=IMBA_SavedVariables.Colors["BarInner"];
	IMBA_Options_GraphicsFrame_BarSettings_InnerColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarInner"].r,IMBA_SavedVariables.Colors["BarInner"].g,IMBA_SavedVariables.Colors["BarInner"].b);
	IMBA_Options_GraphicsFrame_BarSettings_BorderColor.color=IMBA_SavedVariables.Colors["BarBorder"]
	IMBA_Options_GraphicsFrame_BarSettings_BorderColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarBorder"].r,IMBA_SavedVariables.Colors["BarBorder"].g,IMBA_SavedVariables.Colors["BarBorder"].b);

	IMBA_Options_GraphicsFrame_BarSettings_CustomColors:SetChecked(IMBA_SavedVariables.CustomBarColors)
	IMBA_Options_GraphicsFrame_FrameSettings_CloseButtons:SetChecked(IMBA_SavedVariables.HideClose)
	IMBA_Options_GraphicsFrame_HideMinimapIcon:SetChecked(IMBA_SavedVariables.HideMinimapIcon)
	IMBA_Options_GraphicsFrame_ShowAlertWindow:SetChecked(IMBA_SavedVariables.ShowAlertWindow)
end

function IMBA_LoadDefault_FrameSettings()
	IMBA_SavedVariables.FrameType=1;
	IMBA_SavedVariables.Colors["FrameBG"]={r=0,g=0,b=0,a=0.6};
	IMBA_SavedVariables.Colors["FrameBorder"]={r=1,g=1,b=1,a=1};
	IMBA_Options_GraphicsFrame_FrameSettings_BGColor.color=IMBA_SavedVariables.Colors["FrameBG"];
	IMBA_Options_GraphicsFrame_FrameSettings_BGColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b);
	IMBA_Options_GraphicsFrame_FrameSettings_BorderColor.color=IMBA_SavedVariables.Colors["FrameBorder"];
	IMBA_Options_GraphicsFrame_FrameSettings_BorderColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b);
	IMBA_SetBackdrops(IMBA_SavedVariables.FrameType);
	IMBA_SavedVariables.HideClose=false;
	IMBA_ShowCloseButtons();
	IMBA_Options_GraphicsFrame_FrameSettings_CloseButtons:SetChecked(false)
end

function IMBA_FrameColorsChanged()
	IMBA_SetBackdrops(IMBA_SavedVariables.FrameType);
end

function IMBA_BarColorsChanged()
	IMBA_SavedVariables.Colors["BarStart"]=IMBA_Options_GraphicsFrame_BarSettings_StartColor.color;
	IMBA_SavedVariables.Colors["BarEnd"]=IMBA_Options_GraphicsFrame_BarSettings_EndColor.color;
end

function IMBA_BarColors2Changed()
	IMBA_SavedVariables.Colors["BarInner"]=IMBA_Options_GraphicsFrame_BarSettings_InnerColor.color;
	IMBA_SavedVariables.Colors["BarBorder"]=IMBA_Options_GraphicsFrame_BarSettings_BorderColor.color;
	IMBA_BarColorNumber=IMBA_BarColorNumber+1;
end

function IMBA_CustomColors_Clicked()
	IMBA_SavedVariables.CustomBarColors=IMBA_Options_GraphicsFrame_BarSettings_CustomColors:GetChecked()
	IMBA_BarColorNumber=IMBA_BarColorNumber+1;
end

function IMBA_LoadDefault_BarSettings()
	IMBA_SavedVariables.Colors["BarStart"]={r=1,g=1,b=1};
	IMBA_SavedVariables.Colors["BarEnd"]={r=1,g=1,b=1};
	IMBA_SavedVariables.Colors["BarInner"]={r=0.4,g=0.4,b=0.4,a=0.6};
	IMBA_SavedVariables.Colors["BarBorder"]={r=0.9,g=0.9,b=0.9,a=0.6};
	IMBA_SavedVariables.CustomBarColors=nil;
	IMBA_BarColorNumber=IMBA_BarColorNumber+1;

	
	IMBA_Options_GraphicsFrame_BarSettings_StartColor.color=IMBA_SavedVariables.Colors["BarStart"]
	IMBA_Options_GraphicsFrame_BarSettings_StartColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarStart"].r,IMBA_SavedVariables.Colors["BarStart"].g,IMBA_SavedVariables.Colors["BarStart"].b);
	IMBA_Options_GraphicsFrame_BarSettings_EndColor.color=IMBA_SavedVariables.Colors["BarEnd"]
	IMBA_Options_GraphicsFrame_BarSettings_EndColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarEnd"].r,IMBA_SavedVariables.Colors["BarEnd"].g,IMBA_SavedVariables.Colors["BarEnd"].b);
	IMBA_Options_GraphicsFrame_BarSettings_InnerColor.color=IMBA_SavedVariables.Colors["BarInner"];
	IMBA_Options_GraphicsFrame_BarSettings_InnerColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarInner"].r,IMBA_SavedVariables.Colors["BarInner"].g,IMBA_SavedVariables.Colors["BarInner"].b);
	IMBA_Options_GraphicsFrame_BarSettings_BorderColor.color=IMBA_SavedVariables.Colors["BarBorder"]
	IMBA_Options_GraphicsFrame_BarSettings_BorderColor_BG:SetVertexColor(IMBA_SavedVariables.Colors["BarBorder"].r,IMBA_SavedVariables.Colors["BarBorder"].g,IMBA_SavedVariables.Colors["BarBorder"].b);

	IMBA_Options_GraphicsFrame_BarSettings_CustomColors:SetChecked(IMBA_SavedVariables.CustomBarColors)
	
end

function IMBA_HideCloseButtons_Clicked()
	IMBA_SavedVariables.HideClose=IMBA_Options_GraphicsFrame_FrameSettings_CloseButtons:GetChecked()
	if IMBA_SavedVariables.HideClose then
		IMBA_HideCloseButtons()
	else
		IMBA_ShowCloseButtons()
	end
end

function IMBA_HideMinimapIcon_Clicked()
	IMBA_SavedVariables.HideMinimapIcon=IMBA_Options_GraphicsFrame_HideMinimapIcon:GetChecked()
	if IMBA_SavedVariables.HideMinimapIcon then
		IMBA_OptionsButton:Hide();
	else
		IMBA_OptionsButton:Show();
	end
end

function IMBA_ShowAlertWindow_Clicked()
	IMBA_SavedVariables.ShowAlertWindow=IMBA_Options_GraphicsFrame_ShowAlertWindow:GetChecked()
	if IMBA_SavedVariables.ShowAlertWindow then
		IMBA_Alerts.isLocked=false;	
		IMBA_Alerts:EnableMouse(true);
		IMBA_Alerts:SetMovable(true);
		IMBA_Alerts:SetBackdropBorderColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,IMBA_SavedVariables.Colors["FrameBorder"].a);	
		IMBA_Alerts:SetBackdropColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b,IMBA_SavedVariables.Colors["FrameBG"].a);	
	else
		IMBA_Alerts.isLocked=true;
		IMBA_Alerts:EnableMouse(false);
		IMBA_Alerts:SetMovable(false);
		IMBA_Alerts:SetBackdropBorderColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,0);	
		IMBA_Alerts:SetBackdropColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b,0);	
	end
end

function IMBA_DontRaidBroadcast_Clicked()
	IMBA_SavedVariables.DontRaidBroadcast=IMBA_Options_GraphicsFrame_DontRaidBroadcast:GetChecked()
end


function IMBA_UseSCTForAlerts_Clicked()
	IMBA_SavedVariables.UseSCTForAlerts=IMBA_Options_GraphicsFrame_UseSCTForAlerts:GetChecked()
end