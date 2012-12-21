-- Thanks Flaye for teaching me how to use xml

UIPanelWindows["BGInviteUI"] = { area = "left", pushable = 3 };

function BGInviteUI_OnLoad()
	tinsert(UISpecialFrames,"BGInviteUI"); 
end

function BGInviteUI_OnShow()
	UIDropDownMenu_SetSelectedID(BGInviteOptionsFrameChannelDropDown, BGInvite_Config.MsgChannelId, BGINVITE_CHANNELS);	
	UIDropDownMenu_SetText(BGINVITE_CHANNELS[BGInvite_Config.MsgChannelId].name, BGInviteOptionsFrameChannelDropDown);
end

function BGInviteOptionsFrame_AutoInvite_CheckBt_Update(whatValue)
	if (whatValue == nil ) then
		whatValue = 0;
	end
	BGInvite_Config.AutoInvite = whatValue;
end
function BGInviteOptionsFrame_AutoPurge_CheckBt_Update(whatValue)
	if (whatValue == nil ) then
		whatValue = 0;
	end
	BGInvite_Config.AutoPurge = whatValue;
end
function BGInviteOptionsFrame_SendWhisper_CheckBt_Update(whatValue)
	if (whatValue == nil ) then
		whatValue = 0;
	end
	BGInvite_Config.SendWhisper = whatValue;
end
function BGInviteOptionsFrame_Disable_CheckBt_Update(whatValue)
	if (whatValue == nil ) then
		whatValue = 0;
	end
	BGInvite_Config.Disable = whatValue;
end

function BGInvite_CheckBoxCommand (command)
    if (command == nil) then
        return;
    end  
    if (command == "autoinvite") then
        if (BGvar_save.auto == "enabled") then
            BGvar_save.auto = "disabled"
			BGinvite_print(BGlocal_NOT_AUTO_INVITING)
        else
            BGvar_save.auto = "enabled"
			BGinvite_print(BGlocal_AUTO_INVITING)
        end
    elseif (command == "autopurge") then
        if (BGvar_save.purge == "enabled") then
            BGvar_save.purge = "disabled"
			BGinvite_print(BGlocal_NOT_PURGING)
        else
            BGvar_save.purge = "enabled"
			BGinvite_print(BGlocal_NOW_PURGING)
        end
    end
end

function BGInvite_GetNumber (boolean)
    if (boolean == "enabled") then
        return 1;
    else
        return 0;
    end
end

function BGinvite_CopyBlacklist()
	BGvar_CopiedBlacklist = {}
	table.foreach(BGvar_blacklist, BGinvite_CheckBlacklistNames)
end

function BGinvite_CheckBlacklistNames(name)
	if BGvar_blacklist[name] == 1 then
		table.insert(BGvar_CopiedBlacklist, name)
	end
end



function BGinviteScrollBar_Update()
	BGinvite_CopyBlacklist()
	local line; -- 1 through 5 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(BGInviteScrollBar,table.getn(BGvar_CopiedBlacklist),7,40);
	for line=1,7 do
		local lineplusoffset = line + FauxScrollFrame_GetOffset(BGInviteScrollBar);
		if lineplusoffset <= table.getn(BGvar_CopiedBlacklist) then
			getglobal("BGInviteEntry"..line.."Text"):SetText(BGvar_CopiedBlacklist[lineplusoffset])
			getglobal("BGInviteEntry"..line):Show()
		else
			getglobal("BGInviteEntry"..line):Hide()
		end
	end
end

function BGInvite_RetryCooldown_Slider_Update(value)
	BGInvite_Config.RetryTimeout = value;
end
function BGInvite_PurgeCooldown_Slider_Update(value)
	BGInvite_Config.PurgeTimeout = value;
end
function BGInvite_MaxInvites_Slider_Update(value)
	BGInvite_Config.MaxRetries = value;
end
function BGInvite_AutoInviteTimeout_Slider_Update(value)
	BGInvite_Config.AutoInviteTimeout = value;
end

--[[
=============================================================================
Callback methods for the DropDown Menu
=============================================================================
]]
local function BGInviteOptionsFrameChannelDropDown_Initialize()
	local info;
	for i = 1, getn(BGINVITE_CHANNELS), 1 do
		info = { };
		info.text = BGINVITE_CHANNELS[i].name;
		info.func = BGInvite_ChannelDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function BGInvite_ChannelDropDown_OnLoad()
	UIDropDownMenu_Initialize(BGInviteOptionsFrameChannelDropDown, BGInviteOptionsFrameChannelDropDown_Initialize);
	UIDropDownMenu_SetWidth(150);
	UIDropDownMenu_SetButtonWidth(48);
	UIDropDownMenu_JustifyText("RIGHT", BGInviteOptionsFrameChannelDropDown)
end

function BGInvite_ChannelDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(BGInviteOptionsFrameChannelDropDown, this:GetID());
	BGInvite_Config.MsgChannelId = UIDropDownMenu_GetSelectedID(BGInviteOptionsFrameChannelDropDown);
end
