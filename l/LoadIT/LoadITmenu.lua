--  Title:  LoadIT Menu
--  Author: Saur of Emerald Dream (EU)
--  Original author: Ru of Frostmane
--
--  This is a simple mod to provide a GUI for LoadIT
--
-- * Making a Custom GUI
-- *
-- * to make a custom GUI for LoadIT, set LoadITmenu to 1 in your mod.  This will enable
-- * support for the external UI from within LoadIT and offer the '/mods menu' command.
-- * Name the Frame for the menu, LoadITmenuFrame, and define the following function in your GUI to
-- * receive status updates from LoadIT:
-- *
-- * 		function LoadIT_UpdateMenu(func, param)
-- *
-- *			func = function being performed (see code in LoadIT)
-- *			param = parameter for function (see code in LoadIT)
-- *
-- * Be sure to declare LoadIT as a dependency in your .toc, so you can overwrite the value of
-- * LoadITmenu, by forcing your mod to load after LoadIT
-- *
LoadITmenu = 1;

local LO_RED      = '|cffff0000';
local LO_GREEN    = '|cff00ff00';
local LO_BLUE     = '|cff0000ff';
local LO_MAGENTA  = '|cffff00ff';
local LO_YELLOW   = '|cffffff00';
local LO_CYAN     = '|cff00ffff';
local LO_WHITE    = '|cffffffff';
local LO_GREY     = '|ccccccccc';
local LO_GREY_HI  = '|ceeeeeeee';
local LO_BLUE_LOW = '|cff5e9ae4';
local LO_BEIGE    = '|cffffffa0';

LOADIT_TAB_1 = 'Live';
LOADIT_TAB_2 = 'Profile';
LOADIT_TAB_3 = 'Options';
LOADIT_TAB_4 = 'Edit';
LOADIT_TAB_5 = 'Help';

LOADIT_NUM_TABS = 5;

LOADIT_SCROLL_LINES = 17;		-- number of lines to display in scrollbar
LOADIT_SCROLL_HEIGHT = 17;		-- height of each scrollbar line

local LoadITList = {};
local LoadITProfiles = {};
local LoadITEditList = {};
DDProfileList = {};

LoadITglo = {};

LOADITOPT_VERSION = LOADIT_VERSION .. ' by Saur (originally by Ru)';

BINDING_NAME_LOADITMENU = "Toggle Menu";
BINDING_HEADER_LOADITMENU = "LoadIT Menu";

LOADIT_SELECT_PROFILE = '(Select a profile to edit on the Profile tab)';
LOADIT_SELECTED_PROFILE = 'EDIT Profile: ';

-- * LoadIT_UpdateMenu()
-- * This function is called by LoadIT to notify the GUI of any changes
--
function LoadIT_UpdateMenu(func, param, norefresh)
-- * other valid func values = loadprofile

	-- * if module states change
	if ((func == "disable") or (func == "enable") or (func == "load") or (func == "defaults")) then
		local count = GetNumAddOns();
		LoadITList = {};
		if (count) then
			local i = 1;
			while (i <= count) do
				local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
				local loaded = IsAddOnLoaded(i);
				local loadondemand = IsAddOnLoadOnDemand(i);

				if (not title) then title = name; end
				if (not enabled) then enabled = 0; end
				if (not loaded) then loaded = 0; end
				if (not loadondemand) then loadondemand = 0; end

				table.insert(LoadITList, { name=name, title=title, enabled=enabled, loaded=loaded, LoD=loadondemand });
				i = i + 1;
			end
		end
		if (not norefresh) then
			LoadITLive_UpdateButtonData();
			FauxScrollFrame_Update(LoadITLiveScrollFrame,table.getn(LoadITList),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
		end
	end

	-- * if profile states change
	if ((func == "saveprofile") or (func == "deleteprofile") or (func == "defaults")) then
		local key,s;
		local count = 0;
		local tmplist;
		LoadITProfiles = {};

		local sel = UIDropDownMenu_GetSelectedID(DDProfiles);
		if ((sel > 1) and (sel <= table.getn(DDProfileList))) then
			tmplist = LoadITcf.Classes[DDProfileList[sel]];
		else
			tmplist = LoadITcf.Sets;
		end

		for key,_ in tmplist do
			table.insert(LoadITProfiles, { name=key });
		end
		table.sort(LoadITProfiles, function (a1, a2) return (string.lower(a1.name) < string.lower(a2.name)); end);
		LoadITLiveFrame.SelectedIndex = nil;
		LoadITLiveFrame.SelectedName = nil;
		LoadITProfileFrame.SelectedIndex = nil;
		LoadITProfileFrame.SelectedName = nil;
		if (not norefresh) then
			LoadITProfile_UpdateButtonData();
			FauxScrollFrame_Update(LoadITProfileScrollFrame,table.getn(LoadITProfiles),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
		end
		LoadITEdit_Reset();
		LoadITEdit_OnUpdate();
	end

	-- * if default settings were restored
	if (func == "defaults") then
		LoadIT_ResetMenu();
	end
end

function LoadITopt_OnLoad()
	this:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0.4);
	this:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 0.8);

	tinsert(UISpecialFrames,"LoadITmenuFrame"); 

	PanelTemplates_SetNumTabs(LoadITmenuFrame, LOADIT_NUM_TABS);
	PanelTemplates_SetTab(LoadITmenuFrame, 1);
	PanelTemplates_DisableTab(LoadITmenuFrame, 5);
end

function LoadITopt_OnShow()
	LoadITLive_OnUpdate();
	LoadITProfile_OnUpdate();
  	PlaySound("igCharacterInfoOpen");
end

function LoadITopt_OnHide()
	LoadITEdit_Reset();
	LoadITEdit_OnUpdate();
	LoadITProfile_UpdateButtonData();
  	PlaySound("igCharacterInfoClose");
end

function LoadIToptTab_OnClick(id)
	PanelTemplates_Tab_OnClick(LoadITmenuFrame);
	PanelTemplates_SetTab(LoadITmenuFrame, id);
	if (id == 1) then
		LoadITLiveFrame:Show();
		LoadITProfileFrame:Hide();
		LoadITOptionsFrame:Hide();
		LoadITEditFrame:Hide();
		FauxScrollFrame_Update(LoadITLiveScrollFrame,table.getn(LoadITList),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
	elseif (id == 2) then
		LoadITLiveFrame:Hide();
		LoadITProfileFrame:Show();
		LoadITOptionsFrame:Hide();
		LoadITEditFrame:Hide();
		FauxScrollFrame_Update(LoadITProfileScrollFrame,table.getn(LoadITProfiles),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
	elseif (id == 3) then
		LoadITLiveFrame:Hide();
		LoadITProfileFrame:Hide();
		LoadITOptionsFrame:Show();
		LoadITEditFrame:Hide();
	elseif (id == 4) then
		LoadITLiveFrame:Hide();
		LoadITProfileFrame:Hide();
		LoadITOptionsFrame:Hide();
		LoadITEditFrame:Show();
		FauxScrollFrame_Update(LoadITEditScrollFrame,table.getn(LoadITEditList),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
	end

--	for i = 1, LOADIT_NUM_TABS do
--		if (i == 1) then
--			getglobal(LOADIT_FRAMES[i]):Show();
--		else
--			getglobal(LOADIT_FRAMES[i]):Hide();
--		end
--	end

	PlaySound("igCharacterInfoTab");
end

function LoadITopt_OnMouseDown(arg1)
	if (LoadITcf.LockMenu) then return; end
	if (arg1 == "LeftButton") then
		LoadITmenuFrame:StartMoving();
	end
end

function LoadITopt_OnMouseUp(arg1)
	if (LoadITcf.LockMenu) then return; end
	if (arg1 == "LeftButton") then
		LoadITmenuFrame:StopMovingOrSizing();
	end
end

function LoadITopt_ProfileLoad(id)
	local tmp = nil;
	local itemIndex = id + FauxScrollFrame_GetOffset(LoadITProfileScrollFrame);

	local sel = UIDropDownMenu_GetSelectedID(DDProfiles);
	if ((sel > 1) and (sel <= table.getn(DDProfileList))) then
		tmp = 'class';
	end
	LoadIT_LoadProfile(LoadITProfiles[itemIndex].name, tmp);
end

function LoadITopt_ProfileRemove(id)
	local tmp = nil;
	local itemIndex = id + FauxScrollFrame_GetOffset(LoadITProfileScrollFrame);

	local sel = UIDropDownMenu_GetSelectedID(DDProfiles);
	if ((sel > 1) and (sel <= table.getn(DDProfileList))) then
		tmp = 'class';
	end
	LoadIT_DeleteProfile(LoadITProfiles[itemIndex].name, tmp);
end

function LoadITEdit_Remove(id)
	local index = id + FauxScrollFrame_GetOffset(LoadITEditScrollFrame);
	table.remove(LoadITEditList, index);
	LoadITEdit_UpdateButtonData();
end

function LoadITLiveButton_OnClick()
	local i = this:GetID();
	local index = i + FauxScrollFrame_GetOffset(LoadITLiveScrollFrame);
	LoadITLiveFrame.SelectedIndex = index;
	LoadITLiveFrame.SelectedName = getglobal("LoadITLiveButton" .. i .."Name"):GetText();
	LoadITLive_UpdateButtonData();
end

function LoadITProfileButton_OnClick()
	local i = this:GetID();
	local index = i + FauxScrollFrame_GetOffset(LoadITProfileScrollFrame);

	-- * toggle highlighted selection since we clicked on it
	if (LoadITProfileFrame.SelectedIndex and (LoadITProfileFrame.SelectedIndex == index)) then
		LoadITEdit_Reset();
	else
		LoadITProfileFrame.SelectedIndex = index;
		LoadITProfileFrame.SelectedName = getglobal("LoadITProfileButton" .. i .."Name"):GetText();
		LoadITEdit_GetList();
	end
	LoadITProfile_UpdateButtonData();
	LoadITEdit_OnUpdate();
end

function LoadITEdit_Reset()
	LoadITProfileFrame.SelectedIndex = nil;
	LoadITProfileFrame.SelectedName = nil;
	LoadITEditFrame.SelectedIndex = nil;
	LoadITEditFrame.SelectedName = nil;
	EditProfileName:SetText('');
	EditProfileName:Hide();
	LoadITEditList = {};
	LoadITEditProfileNotSelectedText:SetText(LOADIT_SELECT_PROFILE);

	-- * hide buttons
	LoadITEditSaveButton:Hide();
	LoadITEditUndoButton:Hide();
	LoadITEditCheckAllButton:Hide();
	LoadITEditUnCheckAllButton:Hide();
	LoadITEditInfoButton:Hide();
end

function LoadITEditButton_OnClick()
	local i = this:GetID();
	local index = i + FauxScrollFrame_GetOffset(LoadITEditScrollFrame);

	-- * toggle highlighted selection since we clicked on it
	if (LoadITEditFrame.SelectedIndex and (LoadITEditFrame.SelectedIndex == index)) then
		LoadITEditFrame.SelectedIndex = nil;
		LoadITEditFrame.SelectedName = nil;
	else
		LoadITEditFrame.SelectedIndex = index;
		LoadITEditFrame.SelectedName = LoadITEditList[index].name;
	end
	LoadITEdit_UpdateButtonData();
end

function LoadITLive_SetSelection(id, checked)
	local index = id + FauxScrollFrame_GetOffset(LoadITLiveScrollFrame);
	LoadITopt_SetCheck(id, checked);
	if (id <= table.getn(LoadITList)) then
		LoadITList[index].enabled = checked;
		LoadITLiveFrame.SelectedIndex = index;
		LoadITLiveFrame.SelectedName = getglobal("LoadITLiveButton" .. id .. "Name"):GetText();
		LoadITProfile_UpdateButtonData();
	end
end

function LoadITEdit_SetCheck(id, checked)
	local index = id + FauxScrollFrame_GetOffset(LoadITEditScrollFrame);
	if (id <= table.getn(LoadITEditList)) then
		LoadITEditList[index].enabled = checked;
	end
	LoadITEditFrame.SelectedIndex = index;
	LoadITEditFrame.SelectedName = getglobal("LoadITEditButton" .. id .. "Name"):GetText();
	LoadITEdit_UpdateButtonData();
end

function LoadITLive_OnUpdate()
	LoadIT_UpdateMenu("load", 0, 1);
	LoadITLive_UpdateButtonData();
	FauxScrollFrame_Update(LoadITLiveScrollFrame,table.getn(LoadITList),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
end

function LoadITProfile_OnUpdate()
	LoadIT_UpdateMenu("saveprofile", 0, 1);
	LoadITProfile_UpdateButtonData();
	FauxScrollFrame_Update(LoadITProfileScrollFrame,table.getn(LoadITProfiles),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
end

function LoadITEdit_OnUpdate()
	LoadITEdit_UpdateButtonData();
	FauxScrollFrame_Update(LoadITEditScrollFrame,table.getn(LoadITEditList),LOADIT_SCROLL_LINES,LOADIT_SCROLL_HEIGHT);
end

function LoadITEdit_Undo()
	LoadITEdit_GetList();
	LoadITEdit_OnUpdate();
end

function LoadITEdit_Save()
	local tmplist = {};
	local p = LoadITProfileFrame.SelectedName;
	local sel = UIDropDownMenu_GetSelectedID(DDProfiles);

	local i;
	for i = 1, table.getn(LoadITEditList) do
		local tmp = LoadITEditList[i].enabled;
		if (tmp) then
			tmplist[LoadITEditList[i].name] = 1;
		else
			tmplist[LoadITEditList[i].name] = 0;
		end
	end

	if ((sel > 1) and (sel <= table.getn(DDProfileList))) then
		local class = DDProfileList[sel];
		if (LoadITcf.Classes[class][p]) then
			LoadITcf.Classes[class][p].Modules = tmplist;
			LoadIT_Print(LO_YELLOW .. 'Changes saved to ' .. class .. ' Profile: ' .. LO_CYAN .. p);
		end
	else
		if (LoadITcf.Sets[p]) then
			LoadITcf.Sets[p].Modules = tmplist;
			LoadIT_Print(LO_YELLOW .. 'Changes saved to Profile: ' .. LO_CYAN .. p);
		end
	end
end

function LoadITEdit_GetList()
	LoadITEditList = {};
	local tmplist = {};
	local p = LoadITProfileFrame.SelectedName;
	local sel = UIDropDownMenu_GetSelectedID(DDProfiles);
	local class = DDProfileList[sel];
	if ((sel > 1) and (sel <= table.getn(DDProfileList))) then
		if (LoadITcf.Classes[class][p]) then
			tmplist = LoadITcf.Classes[class][p].Modules;
		end
	else
		if (LoadITcf.Sets[p]) then
			tmplist = LoadITcf.Sets[p].Modules;
		end
	end
	local key, enabled;
	for key,enabled in tmplist do
		local name, title, notes, _, _, _, _ = GetAddOnInfo(key);
		local error = 0;
		if (not title) then
			name = key;
			error = 1;
		end
		if (not title) then title = name; end
		if (not notes) then notes = ''; end
		if (enabled == 0) then enabled = nil; end
		table.insert(LoadITEditList, { name=key, enabled=enabled, title=title, notes=notes, error=error });
	end
	table.sort(LoadITEditList, function (a1, a2) return (string.lower(a1.title) < string.lower(a2.title)); end);
	LoadITEditProfileNotSelectedText:SetText('');
	EditProfileName:SetText(LOADIT_SELECTED_PROFILE .. LoadITProfileFrame.SelectedName);
	EditProfileName:Show();

	-- * show buttons
	LoadITEditSaveButton:Show();
	LoadITEditUndoButton:Show();
	LoadITEditCheckAllButton:Show();
	LoadITEditUnCheckAllButton:Show();
	LoadITEditInfoButton:Show();
end

function LoadITLive_UpdateButtonData()
	local i;
	local index;

		for i = 1, LOADIT_SCROLL_LINES do
			index = i + FauxScrollFrame_GetOffset(LoadITLiveScrollFrame);
			if (index <= table.getn(LoadITList)) then
				if (LoadITList[index].loaded == 1) then
					getglobal("LoadITLiveButton" .. i .. "Name"):SetVertexColor(1.0, 0.82, 0.0);
				else
					getglobal("LoadITLiveButton" .. i .. "Name"):SetVertexColor(0.5, 0.5, 0.5);
				end
				getglobal("LoadITLiveButton" .. i .. "Name"):SetText(LoadITList[index].title);

				-- * load on demand
				if (LoadITList[index].LoD == 1) then
					getglobal("LoadITLiveButton" .. i .. "LoD"):SetText(LO_CYAN .. 'LD');
				else
					getglobal("LoadITLiveButton" .. i .. "LoD"):SetText('');
				end

				getglobal("LoadITLiveButton".. i .."Enabled"):SetChecked(LoadITList[index].enabled);
				getglobal("LoadITLiveButton" .. i):Show();
				if ( LoadITLiveFrame.SelectedIndex == index ) then
					getglobal("LoadITLiveButton" .. i):LockHighlight();
				else
					getglobal("LoadITLiveButton" .. i):UnlockHighlight();
				end
			else
				getglobal("LoadITLiveButton" .. i .. "Name"):SetText('');
				getglobal("LoadITLiveButton" .. i .. "LoD"):SetText('');
				getglobal("LoadITLiveButton" .. i):Hide();
				getglobal("LoadITLiveButton" .. i):UnlockHighlight();
			end
		end
end

function LoadITEdit_UpdateButtonData()
	local i;
	local index;

		for i = 1, LOADIT_SCROLL_LINES do
			index = i + FauxScrollFrame_GetOffset(LoadITEditScrollFrame);
			if (index <= table.getn(LoadITEditList)) then
				if (LoadITEditList[index].error == 0) then
					getglobal("LoadITEditButton" .. i .. "Name"):SetVertexColor(1.0, 0.82, 0.0);
				else
					getglobal("LoadITEditButton" .. i .. "Name"):SetVertexColor(1.0, 0.0, 0.0);
				end
				getglobal("LoadITEditButton" .. i .. "Name"):SetText(LoadITEditList[index].title);

				getglobal("LoadITEditButton".. i .."Enabled"):SetChecked(LoadITEditList[index].enabled);
				getglobal("LoadITEditButton" .. i):Show();
				if ( LoadITEditFrame.SelectedIndex == index ) then
					getglobal("LoadITEditButton" .. i):LockHighlight();
				else
					getglobal("LoadITEditButton" .. i):UnlockHighlight();
				end
			else
				getglobal("LoadITEditButton" .. i .. "Name"):SetText('');
				getglobal("LoadITEditButton" .. i):Hide();
				getglobal("LoadITEditButton" .. i):UnlockHighlight();
			end
		end
end

-- * LoadITLive_ToggleAll(arg )
-- * Toggles enabled/disabled state for all modules
--
-- * arg - value to set all states to
--
function LoadITLive_ToggleAll(arg)
	local i;
	for i = 1, table.getn(LoadITList) do
			if (arg == 1) then
				LoadITList[i].enabled = 1;
				LoadIT_Enable(LoadITList[i].name, LoadITcf.Verbose, 1);
			else
				LoadITList[i].enabled = 0;
				LoadIT_Disable(LoadITList[i].name, LoadITcf.Verbose, 1);
			end
			if (i <= LOADIT_SCROLL_LINES) then
				getglobal("LoadITLiveButton" .. i .. "Enabled"):SetChecked(LoadITList[i].enabled);
			end
	end
end

function LoadITEdit_ToggleAll(arg)
	local i;
	for i = 1, table.getn(LoadITEditList) do
			if (arg == 1) then
				LoadITEditList[i].enabled = 1;
			else
				LoadITEditList[i].enabled = nil;
			end
			if (i <= LOADIT_SCROLL_LINES) then
				getglobal("LoadITEditButton" .. i .. "Enabled"):SetChecked(LoadITEditList[i].enabled);
			end
	end
end

function LoadITProfile_UpdateButtonData()
	local i;
	local index;

		for i = 1, LOADIT_SCROLL_LINES do
			index = i + FauxScrollFrame_GetOffset(LoadITProfileScrollFrame);
			if (index <= table.getn(LoadITProfiles)) then
				getglobal("LoadITProfileButton" .. i .. "Name"):SetText(LoadITProfiles[index].name);
				getglobal("LoadITProfileButton" .. i .. "Name"):SetVertexColor(1.0, 0.82, 0.0);
				getglobal("LoadITProfileButton" .. i):Show();
				if ( LoadITProfileFrame.SelectedIndex == index ) then
					getglobal("LoadITProfileButton" .. i):LockHighlight();
				else
					getglobal("LoadITProfileButton" .. i):UnlockHighlight();
				end
			else
				getglobal("LoadITProfileButton" .. i .. "Name"):SetText('');
				getglobal("LoadITProfileButton" .. i):Hide();
				getglobal("LoadITProfileButton" .. i):UnlockHighlight();
			end
		end
end

function LoadITopt_SetCheck(id, checked)
	local index = id + FauxScrollFrame_GetOffset(LoadITLiveScrollFrame);
	if (checked) then
		LoadIT_Enable(LoadITList[index].name);
	else
		LoadIT_Disable(LoadITList[index].name);
	end
end

function LoadIT_FindAddonIndex(name)
	local i;
	for i = 1, table.getn(LoadITList) do
		if (LoadITList[i].name == name) then
			return i;
		end
	end
end

function LoadIT_AddonTooltip(idx)
	local s;
	local txt = LO_YELLOW;
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(LoadITList[idx].name);
	local loaded = IsAddOnLoaded(LoadITList[idx].name);
	if (title) then
		txt = txt .. title .. "|r\n";
	else
		txt = txt .. name .. "|r\n";
	end

	local tmp = "";
	if (notes) then
		for s in string.gfind(notes, "%a+") do
			if (string.len(tmp) > 30) then
				txt = txt .. s .. "\n";
				tmp = '';
			else
				txt = txt .. s .. ' ';
				tmp = tmp .. s .. ' ';
			end
		end 
	end
	if (string.byte(txt, string.len(txt)) ~= string.byte("\n", 1)) then
		txt = txt .. "\n";
	end
	GameTooltip:SetText(txt .. "\n", 0.5, 0.5, 0.5);

	if (enabled) then enabled = LO_GREEN .. "Yes"; else enabled = LO_RED .. "No"; end
	if (loadable) then loadable = LO_GREEN .. "Yes"; else loadable = LO_RED .. "No"; end
	if (loaded) then loaded = LO_GREEN .. "Yes"; else loaded = LO_RED .. "No"; end

	GameTooltip:AddDoubleLine(LO_BLUE_LOW .. 'Security:', security);
	GameTooltip:AddDoubleLine(LO_BLUE_LOW .. 'Loadable:', loadable);
	GameTooltip:AddDoubleLine(LO_BLUE_LOW .. 'Loaded:', loaded);
	GameTooltip:AddDoubleLine(LO_BLUE_LOW .. 'Enabled:', enabled);

	local loadondemand = IsAddOnLoadOnDemand(LoadITList[idx].name);
	if (loadondemand) then loadondemand = LO_GREEN .. "Yes"; else loadondemand = LO_RED .. "No"; end
	GameTooltip:AddDoubleLine(LO_BLUE_LOW .. 'Load On Demand:', loadondemand);

	local s = LoadIT_DependencyString(LoadITList[idx].name);
	if (s ~= '') then
		GameTooltip:AddDoubleLine(LO_BLUE_LOW .. "\nDependencies: ", "\n" .. s);
	end

end

function DDProfiles_OnLoad()

	DDProfileList = {};
	DDProfileList[1] = 'Global';

	-- * load this player's class
	DDProfileList[2] = UnitClass("player");

	-- * load profiles for all player classes (disabled for now)
--	local i = 2;
--	for key,_ in LoadITcf.Classes do
--		DDProfileList[i] = key;
--		i = i + 1;
--	end;

	if (not LoadITglo.View) then
		LoadITglo.View = 1;
	end

	UIDropDownMenu_Initialize(DDProfiles, DDProfiles_Initialize);
	UIDropDownMenu_SetSelectedID(DDProfiles, LoadITglo.View);
	UIDropDownMenu_SetText('View: ' .. DDProfileList[LoadITglo.View] .. ' Profiles', DDProfiles);

	UIDropDownMenu_SetWidth(190, DDProfiles);
	UIDropDownMenu_SetButtonWidth(190, DDProfiles);
end

function DDProfiles_OnShow()
	DDProfiles_OnLoad();
end

function DDProfiles_Initialize()
	local i;
	for i = 1, getn(DDProfileList), 1 do
		local info = { };
		info.text = DDProfileList[i] .. ' Profiles';
		info.value = DDProfileList[i];
		info.func = DDProfiles_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DDProfiles_OnClick()
	local id = this:GetID();
	UIDropDownMenu_SetSelectedID(DDProfiles, id);
	UIDropDownMenu_SetText('View: ' .. DDProfileList[id] .. ' Profiles', DDProfiles);

	LoadITEdit_Reset();
	LoadITProfile_OnUpdate();
	LoadITEdit_OnUpdate();

	-- * remember character's view preference
	LoadITglo.View = id;
end

function LoadITmenu_ToggleMenu()
	if (LoadITmenuFrame:IsVisible()) then
		HideUIPanel(LoadITmenuFrame);
	else
		if (LoadIT_OffScreen()) then
			LoadIT_ResetMenu();
		end
		ShowUIPanel(LoadITmenuFrame);
	end
end
