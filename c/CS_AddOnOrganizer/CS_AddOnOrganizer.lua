--## BY: Arina, 60 Warrior on Deathwing EU English.
--## Use With Caution! ;)

CS_ADDONORGANIZER_ADDONS_DISPLAYED = 22;
CS_ADDONORGANIZER_ADDONSLINE_HEIGHT = 16;
CS_AddOnOrganizer_Profiles = {};
CS_ADDONORGANIZER_VERSIONNUMBER = "1.1011";
BINDING_HEADER_CS_ADDONORGANIZER_SEP = "CS AddOnOrganizer";
BINDING_NAME_CS_ADDONORGANIZER_CONFIG = "Show / Hide";

local id;
local CS_AddOnOrganizer_AddOnList = {};

function CS_AddOnOrganizer_OnLoad()
	this:RegisterEvent("PLAYER_LOGIN"); 
	this:RegisterEvent("PLAYER_LOGOUT");
	
	tinsert(UISpecialFrames,"CS_AddOnOrganizer_List");
	
	
	SLASH_CS_ADDONORGANIZER1 = "/aoo";
	SlashCmdList["CS_ADDONORGANIZER"] = function(msg)
		CS_AddOnOrganizer_ListShowHide();
	end

end

function CS_AddOnOrganizer_OnEvent(event)
	if(event == "PLAYER_LOGIN")then
		DEFAULT_CHAT_FRAME:AddMessage("|CFFFFFFFFCS_AddOnOrganizer|r |CFF00FF00Loaded|r");
		--CS_AddOnOrganizer_Profiles = {[1] = {"Default (Only CS_AddOnOrganizer)","CS_AddOnOrganizer",},};
	end
end

function CS_AddOnOrganizer_ListShowHide()

	if (CS_AddOnOrganizer_List:IsVisible()) then
		HideUIPanel(CS_AddOnOrganizer_List_Profiles);
		HideUIPanel(CS_AddOnOrganizer_List);
	else
		CS_AddOnOrganizer_List_Title:SetText ("CS_AddOnOrganizer v."..CS_ADDONORGANIZER_VERSIONNUMBER);
		ShowUIPanel(CS_AddOnOrganizer_List);
		CS_AddOnOrganizer_GetList();
		CS_AddOnOrganizer_List_Update();
	end
end

function CS_AddOnOrganizer_GetList()
	local i;
	for i=1, GetNumAddOns(), 1 do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		CS_AddOnOrganizer_AddOnList[i] = enabled;
	end
end


function CS_AddOnOrganizer_List_Update()
	local numaddons = GetNumAddOns();
	local i;
	CS_AddOnOrganizer_List_AddOnCount:SetText("AddOns: |CFFFFFFFF"..numaddons.."|r");
	CS_AddOnOrganizer_List_CountMiddle:SetWidth(CS_AddOnOrganizer_List_AddOnCount:GetWidth());

	FauxScrollFrame_Update(CS_AddOnOrganizer_List_Scroll, numaddons, CS_ADDONORGANIZER_ADDONS_DISPLAYED, CS_ADDONORGANIZER_ADDONSLINE_HEIGHT, nil, nil, nil, CS_AddOnOrganizer_List_HighlightFrame, 293, 316 )
	
	for i=1, CS_ADDONORGANIZER_ADDONS_DISPLAYED, 1 do
		local addonIndex = i + FauxScrollFrame_GetOffset(CS_AddOnOrganizer_List_Scroll);
		
		if ( addonIndex <= numaddons ) then
			local addonLogTitle = getglobal("CS_AddOnOrganizer_List_Title"..i);
			local addonTitleTag = getglobal("CS_AddOnOrganizer_List_Title"..i.."Tag");
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonIndex);
			
			addonLogTitle:SetText(title);
			addonLogTitle:SetNormalTexture("");
			
			local color = {r=0.7,g=0.7,b=0.7};
			if(enabled and loadable)then
				color = {r=1.0,g=1.0,b=0.5};
			elseif(enabled and not loadable)then
				color = {r=1.0,g=0.0,b=0.0};
			end
			
			if(CS_AddOnOrganizer_AddOnList[addonIndex] == 1) then
				addonTitleTag:SetText("Enabled");
				if(enabled)then
					addonTitleTag:SetTextColor(1.0,0.7,0.0);
				else
					addonTitleTag:SetTextColor(0.0,1.0,0.0);
				end
			else
				addonTitleTag:SetText("Disabled");
				if(not enabled)then
					addonTitleTag:SetTextColor(1.0,0.7,0.0);
				else
					addonTitleTag:SetTextColor(1.0,0.0,0.0);
				end
			end
			
			addonLogTitle:SetTextColor(color.r, color.g, color.b);
			addonLogTitle.r = color.r;
			addonLogTitle.g = color.g;
			addonLogTitle.b = color.b;
			addonLogTitle:Show();
		end
	end
end

function CS_AddOnOrganizer_TitleButton_OnClick()
	local AddOnID = this:GetID() + FauxScrollFrame_GetOffset(CS_AddOnOrganizer_List_Scroll);
	local buttonID = this:GetID();
	local addonTitleTag = getglobal("CS_AddOnOrganizer_List_Title"..buttonID.."Tag");
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(AddOnID);
	
	if(CS_AddOnOrganizer_AddOnList[AddOnID] == 1) then
		addonTitleTag:SetText("Disabled");
		if(not enabled)then
			addonTitleTag:SetTextColor(1.0,0.7,0.0);
		else
			addonTitleTag:SetTextColor(1.0,0.0,0.0);
		end
		CS_AddOnOrganizer_AddOnList[AddOnID] = 0;
	else
		addonTitleTag:SetText("Enabled");
		if(enabled)then
			addonTitleTag:SetTextColor(1.0,0.7,0.0);
		else
			addonTitleTag:SetTextColor(0.0,1.0,0.0);
		end
		CS_AddOnOrganizer_AddOnList[AddOnID] = 1;
	end
end

function CS_AddOnOrganizer_TitleButton_OnEnter()
	local buttonID = this:GetID() + FauxScrollFrame_GetOffset(CS_AddOnOrganizer_List_Scroll);
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(buttonID);
	local dependencies = GetAddOnDependencies(buttonID);
	local loadondemand = IsAddOnLoadOnDemand(buttonID);
	
	--DEFAULT_CHAT_FRAME:AddMessage(buttonID);
	if (title == nil) then
		title = "No Title";
	end
	if (dependencies == nil) then
		dependencies = "No Dependencies";
	end
	if(notes == nil) then
		notes = "No Notes";
	end
	if(loadondemand) then
		loadondemand = "|CFF00FF00True|r";
	else
		loadondemand = "|CFFFF0000False|r";
	end
	
	if(loadable ~= nil)then
		GameTooltip_AddNewbieTip(name, 1.0, 1.0, 1.0, title.."\n"..notes.."\n|CFFFFFFFFAddon is Loadable:|r|CFF00FF00True|r\n".."|CFFFFFFFFLoadOnDemand:|r "..loadondemand.."\n|CFFFFFFFFDependencies:|r "..dependencies, 1);
	elseif(reason == "DISABLED") then
		GameTooltip_AddNewbieTip(name, 1.0, 1.0, 1.0, title.."\n"..notes.."\n|CFFFFFFFFAddon is Loadable:|r |CFFFF0000False|r\n|CFFFFFFFFReason:|r |CFFFF0000"..reason.."|r\n|CFFFFFFFFYou might still enable this addon.|r\n".."|CFFFFFFFFLoadOnDemand:|r "..loadondemand.."\n|CFFFFFFFFDependencies:|r "..dependencies, 1);
	else
		GameTooltip_AddNewbieTip(name, 1.0, 1.0, 1.0, title.."\n"..notes.."\n|CFFFFFFFFAddon is Loadable:|r|CFFFF0000 False|r\n|CFFFFFFFFReason:|r |CFFFF0000"..reason.."|r\n".."|CFFFFFFFFLoadOnDemand:|r "..loadondemand.."\n|CFFFFFFFFDependencies:|r "..dependencies, 1);
	end
end

function CS_AddOnOrganizer_AcceptButton_OnClick()
	local i;
	local numaddons = GetNumAddOns();
	local IsChanges = 0;
	local SaveIndex = 1;
	for i=1, numaddons, 1 do	
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		if(CS_AddOnOrganizer_AddOnList[i] ~= enabled) then
			if (CS_AddOnOrganizer_AddOnList[i] == 1) then
				EnableAddOn(i);
			else
				DisableAddOn(i);
			end
			IsChanges = 1;
		end
	end
	CS_AddOnOrganizer_ListShowHide();
	if(IsChanges == 1)then
		ReloadUI();
	end
end

function CS_AddOnOrganizer_ReloadUIButton()
	ReloadUI();
end

function CS_AddOnOrganizer_EnableAll()
	local i;
	local numaddons = GetNumAddOns();
	for i=1, numaddons, 1 do
		CS_AddOnOrganizer_AddOnList[i] = 1;
		if( i <= CS_ADDONORGANIZER_ADDONS_DISPLAYED)then
			local addonTitleTag = getglobal("CS_AddOnOrganizer_List_Title"..i.."Tag");
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
			addonTitleTag:SetText("Enabled");
			if(enabled)then
				addonTitleTag:SetTextColor(1.0,0.7,0.0);
			else
				addonTitleTag:SetTextColor(0.0,1.0,0.0);
			end
		end
	end
end

function CS_AddOnOrganizer_DisableAll()
	local i;
	local numaddons = GetNumAddOns();
	for i=1, numaddons, 1 do
		CS_AddOnOrganizer_AddOnList[i] = 0;
		if( i <= CS_ADDONORGANIZER_ADDONS_DISPLAYED)then
			local addonTitleTag = getglobal("CS_AddOnOrganizer_List_Title"..i.."Tag");
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
			
			addonTitleTag:SetText("Disabled");
			if(not enabled)then
				addonTitleTag:SetTextColor(1.0,0.7,0.0);
			else
				addonTitleTag:SetTextColor(1.0,0.0,0.0);
			end
		end
	end
end

function CS_AddOnOrganizer_ProfilesShowHide()
	if (CS_AddOnOrganizer_List_Profiles:IsVisible()) then
		HideUIPanel(CS_AddOnOrganizer_List_Profiles);
	else
		ShowUIPanel(CS_AddOnOrganizer_List_Profiles);
	end
end

function CS_AddOnOrganizer_Profiles_ProfilesDropDown_OnLoad()
	UIDropDownMenu_SetWidth(220);
	UIDropDownMenu_Initialize(this,CS_AddOnOrganizer_InitializeDropDown);
	--DEFAULT_CHAT_FRAME:AddMessage(table.getn(CS_AddOnOrganizer_Profiles));

end

function CS_AddOnOrganizer_InitializeDropDown()
	local info;
	for i=1,table.getn(CS_AddOnOrganizer_Profiles) do	
		info = {};
		info.text = CS_AddOnOrganizer_Profiles[i][1];
		info.func = CS_AddOnOrganizer_LoadProfile;
		UIDropDownMenu_AddButton(info);
	end
end

function CS_AddOnOrganizer_LoadProfile()
	UIDropDownMenu_SetSelectedID(ProfilesDropDown, this:GetID());
	CS_AddOnOrganizer_DisableAll();
	local i;
	local numaddons = GetNumAddOns();
	id = this:GetID();
	for j=2,table.getn(CS_AddOnOrganizer_Profiles[this:GetID()]) do
		local loadname = CS_AddOnOrganizer_Profiles[this:GetID()][j];
		for i=1, numaddons, 1 do
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
			local addonTitleTag = getglobal("CS_AddOnOrganizer_List_Title"..i.."Tag");
			if (name == loadname) then
				CS_AddOnOrganizer_AddOnList[i] = 1;
			end
		end
	end
	CS_AddOnOrganizer_List_Update();
	SaveProfileEditBox:SetText(CS_AddOnOrganizer_Profiles[this:GetID()][1]);
end

function CS_AddOnOrganizer_SaveProfile()
	local i,j;
	local ProfileText = SaveProfileEditBox:GetText();
	local newKey;
	local found = false;
	
	if(not(ProfileText == "")) then
		
		newKey = table.getn(CS_AddOnOrganizer_Profiles) + 1;
		
		for i=1, table.getn(CS_AddOnOrganizer_Profiles) do
			if (CS_AddOnOrganizer_Profiles[i][1] == ProfileText) then
				newKey = i;				
				found = true;
			end
		end
		
		if(not(found))then
			CS_AddOnOrganizer_Profiles[newKey] = {[1] = SaveProfileEditBox:GetText()};
			DEFAULT_CHAT_FRAME:AddMessage("|CFF00FF00CS_AddOnOrganizer|r - |CFFFFFFFF"..SaveProfileEditBox:GetText().."|r has been |CFF00FF00ADDED|r to profiles list!");
		else
			DEFAULT_CHAT_FRAME:AddMessage("|CFF00FF00CS_AddOnOrganizer|r - |CFFFFFFFF"..SaveProfileEditBox:GetText().."|r has been |CFF00FF00MODIFIED|r in the profiles list!");
		end
		
		local numaddons = GetNumAddOns();
		j=2;
		for i=1, numaddons, 1 do
			if(CS_AddOnOrganizer_AddOnList[i] == 1) then
				CS_AddOnOrganizer_Profiles[newKey][j] = GetAddOnInfo(i);
				j = j+1;
			end		
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("|CFF00FF00CS_AddOnOrganizer|r - |CFFFF0000You have to write a name for the profile!|r");
	end
end

function CS_AddOnOrganizer_DeleteProfile()
	if (not(id == nil)) then
		
		DEFAULT_CHAT_FRAME:AddMessage("|CFF00FF00CS_AddOnOrganizer|r - |CFFFF0000DELETED ID#"..id.."!|r");
		table.remove(CS_AddOnOrganizer_Profiles,id);
		
		if(table.getn(CS_AddOnOrganizer_Profiles) == 0) then
			CS_AddOnOrganizer_Profiles = {};
			id=nil;
		end
	end
end
