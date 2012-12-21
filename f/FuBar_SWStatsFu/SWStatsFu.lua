local tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.0"):new("SWStatsFu")

SWStatsFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0")

local optionsTable = {
	type = 'group',
	args = {
		showConsole = {
			order = 1,
			type = "execute",
			name = L["Show Console"],
			desc = L["Shows the console"],
			func = "ToggleConsole",
		},
		showGeneral = {
			order = 2,
			type = "execute",
			name = L["Show General Settings"],
			desc = L["Shows the general settings"],
			func = "ToggleGeneralSettings",
		},		
		showSync = {
			order = 3,
			type = "execute",
			name = L["Show Sync Settings"],
			desc = L["Shows the sync settings"],
			func = "ToggleSync",
		},				
		showTimeline = {
			order = 4,
			type = "execute",
			name = L["Show Timeline"],
			desc = L["Shows the timeline"],
			func = "ToggleTimeline",
		},
		["-blank-"] = {
			order = 5,
			type = 'header',
		},		
		resetData = {
			order = 6,
			type = "execute",
			name = L["Reset Data"],
			desc = L["Reset the stored data"],
			func = "ResetCheck",
		},						
		["-blank2-"] = {
			order = 7,
			type = 'header',
		},				
		updateFriends = {
			order = 8,
			type = "execute",
			name = L["Update GroupInfo"],
			desc = L["Rebuilds friends list"],
			func = "RebuildFriendList",
		},						
		["-blank3-"] = {
			order = 9,
			type = 'header',
		},				
		hideIcon = {
			order = 10,
			type = 'toggle',
			name = L["HIDE_LABEL"],
			desc = L["HIDE_LABEL"],
			set = "ToggleHideIcon",
			get = "IsHideIcon",
		},		
	}	
}

SWStatsFu.OnMenuRequest = optionsTable
SWStatsFu:RegisterChatCommand( { "/SWStatsFu" }, optionsTable )
SWStatsFu.hasIcon = true

SWStatsFu:RegisterDB("Fubar_SWStatsDB")
SWStatsFu:RegisterDefaults('profile', {
	enabled =0,
	hideIcon = true,		
})

function SWStatsFu:IsHideIcon()
	return self.db.profile.hideIcon;
end

function SWStatsFu:ToggleConsole()
	SW_ToggleConsole();
end

function SWStatsFu:ToggleGeneralSettings()
	SW_ToggleGeneralSettings();
end

function SWStatsFu:ToggleSync()
	SW_ToggleSync();
end

function SWStatsFu:ToggleTimeline()
	SW_ToggleTL();
end

function SWStatsFu:ResetCheck()
	SW_ResetCheck();
end

function SWStatsFu:RebuildFriendList()
	SW_RebuildFriendList();
end

	
function SWStatsFu:ToggleHideIcon()
	self.db.profile.hideIcon = not self.db.profile.hideIcon;
	if (SW_IconFrame) then
		if self.db.profile.hideIcon == true then
			SW_IconFrame:Hide();
		else
			SW_IconFrame:Show();
		end
	end	
end

function SWStatsFu:OnInitialize()
end

function SWStatsFu:OnEnable()
	--self:ScheduleRepeatingEvent("SWStatsFu_Update",self.Update, 1, self);		
	--self:RegisterEvent("UNIT_AURA");
	if (SW_IconFrame) then
		if self.db.profile.hideIcon == true then
			SW_IconFrame:Hide();
		else
			SW_IconFrame:Show();
		end
	end		
end

function SWStatsFu:OnDisable()
	--self:CancelScheduledEvent("SWStatsFu_Update")
	SW_IconFrame:Show();
end

function SWStatsFu:OnTextUpdate()
	self:SetText("SWStats")
end

function SWStatsFu:OnClick()
	--DEFAULT_CHAT_FRAME:AddMessage("click "..self.db.profile.enabled);
--	if ( self.db.profile.enabled == 1) then
		--self.db.profile.enabled = 0;
--	else
	--	self.db.profile.enabled = 1;
	--end
	SW_ToggleBarFrame();	
end

function SWStatsFu:OnTooltipUpdate()

	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	cat:AddLine(
		'text', "",
		'text2', ""
	)	
	
	cat:AddLine(
		'text', "",
		'text2', ""
	)			
end