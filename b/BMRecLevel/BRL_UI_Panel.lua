--[[

	Bhaldie Recommended Level UI Panel:
	Helps you configure your Mod.
	
	Website:	http://wow.kingofnothin.net/
	Author:		Bhaldie (bhaldiemoveIT@kingofnothin.net)
	
	
	Contributors:
	Pkp
		- Some initial xml work.
		
	Trentin and Grayhoof
		- I "borrowed" a lot of the techniques and some code used in the options
		frame of MonkeyBuddy and ScrollingCombatText. It was such an excellent implementation
		that I just had to use it.

--]]

-- define the dialog box for reseting config
StaticPopupDialogs["BRL_RESET_ALL"] = {
	text = TEXT(BRL_RESET_ALL_TEXT),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		BRL_Reset_Everything();
		BRL_UI_Panel_Refresh();
	end,
	timeout = 0,
	exclusive = 1
};
-- this array is used to init the check buttons
local BRL_CheckButtons = { };
BRL_CheckButtons[BRL_ZONE_INFO_ENABLE] = {
	id = 1,
	strVar = "zone_info_enable",
	pSlashCommand = BRL_Zone_Info_Enable
};
BRL_CheckButtons[BRL_TOOLTIP_ENABLE] = {
	id = 2, 
	strVar = "tooltip_enable",
	pSlashCommand = BRL_Tooltip_Enable
};
BRL_CheckButtons[BRL_MAP_TEXT_ENABLE] = {
	id = 3, 
	strVar = "map_text_enable",
	pSlashCommand = BRL_Map_Text_Enable
};
BRL_CheckButtons[BRL_TOOLTIP_OFFSET_LEFT] = {
	id = 4, 
	strVar = "tooltip_offset_left",
	pSlashCommand = BRL_Tooltip_Offset_Left
};
BRL_CheckButtons[BRL_TOOLTIP_OFFSET_BOTTOM] = {
	id = 5, 
	strVar = "tooltip_offset_bottom",
	pSlashCommand = BRL_Tooltip_Offset_Bottom
};
BRL_CheckButtons[BRL_SHOW_TOOLTIP_FACTION] = {
	id = 6, 
	strVar = "show_tooltip_faction",
	pSlashCommand = BRL_Show_Tooltip_Faction
};
BRL_CheckButtons[BRL_SHOW_TOOLTIP_INSTANCE] = {
	id = 7, 
	strVar = "show_tooltip_instance",
	pSlashCommand = BRL_Show_Tooltip_Instance
};
BRL_CheckButtons[BRL_SHOW_TOOLTIP_CONTINENT] = {
	id = 8, 
	strVar = "show_tooltip_continent",
	pSlashCommand = BRL_Show_Tooltip_Continent
};


local BRL_Sliders = { };
BRL_Sliders[BRL_BORDER_ALPHASLIDER] = {
	id = 1,
	strVar = "border_alpha",
	pSlashCommand = BRL_Border_Alpha,
	minValue = 0.0,
	maxValue = 1.0,
	valueStep = .01,
	minText="0%",
	maxText="100%",
};

function BRL_UI_Panel_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	-- Add BRL_Frame to the UIPanelWindows list
	UIPanelWindows["BRL_Frame"] = {area = "center", pushable = 0};
	BRL_Frame_TitleText:SetTextColor(1.0, 0.8, 0.0);
	
	-- Slash commands for UI Window open.
	SlashCmdList["BRL_UI_PANEL"] = BRL_UI_Panel_SlashHandler;
	SLASH_BRL_UI_PANEL1 = "/brlconfig";
end

function BRL_UI_Panel_SlashHandler()
	ShowUIPanel(BRL_Frame);
	BRL_Main_Frame:Show();
	BRL_UI_Panel_Refresh();
end

function BRL_OnEvent()
	if (event == "VARIABLES_LOADED") then
		-- Add Recommended Level to myAddOns
		if (myAddOnsFrame_Register) then
			myAddOnsFrame_Register ( {name = 'BMRecLevel', version = BMRECLEVEL_VERSION, optionsframe = 'BRL_Frame', category = MYADDONS_CATEGORY_OTHERS } );
		end
	end
end

function BRL_Frame_OnClick()
	ShowUIPanel(BRL_Frame);
	BRL_Main_Frame:Show();
	BRL_UI_Panel_Refresh();
end

function BRL_OnShow()
	ShowUIPanel(BRL_Frame);
	BRL_Main_Frame:Show();
	BRL_UI_Panel_Refresh();
end

--Called when option page loads
function BRL_UI_Panel_Refresh()
	-- Initial Values
	local button, string, checked;
	BRL_STARTUP.m_strPlayer = GetCVar("realmName") .. "|" .. UnitName("player");
	-- Setup check buttons
	for key, value in BRL_CheckButtons do
		button = getglobal("BRL_Check" .. value.id);
		string = getglobal("BRL_Check" .. value.id .. "Text");
		checked = nil;
		button.disabled = nil;
		
		--Check Box
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer][value.strVar] == true) then
			checked = 1;
		else
			checked = 0;
		end
		--DEFAULT_CHAT_FRAME:AddMessage("Item Checked: " .. button);
		button:SetChecked(checked);
		string:SetText(key);
		button.pSlashCommand = value.pSlashCommand;
	end
		
	local slider, string, low, high;

	-- Setup Sliders
	for key, value in BRL_Sliders do
		slider = getglobal("BRL_Slider"..value.id);
		string = getglobal("BRL_Slider"..value.id.."Text");
		low = getglobal("BRL_Slider"..value.id.."Low");
		high = getglobal("BRL_Slider"..value.id.."High");
		
		slider.id = value.id;
		slider.strVar = value.strVar;
		slider.pSlashCommand = value.pSlashCommand;
		
		--OptionsFrame_EnableSlider(slider);
		slider:SetMinMaxValues(value.minValue, value.maxValue);
		slider:SetValueStep(value.valueStep);
		slider:SetValue(BRL_CONFIG[BRL_STARTUP.m_strPlayer][value.strVar]);
		string:SetText(key);
		low:SetText(value.minText);
		high:SetText(value.maxText);
	end
end

function BRL_CheckButton_OnClick()
	local	bChecked;
	if (this:GetChecked()) then
		bChecked = true;
	else
		bChecked = false;
	end
	this.pSlashCommand(bChecked,this:GetID());
end

function BRL_Slider_OnValueChanged()

	BRL_CONFIG[BRL_STARTUP.m_strPlayer][this.strVar] = this:GetValue();
	
	this.pSlashCommand(this:GetValue());
	
	-- set the tool tip text
	if (this:GetValue() == floor(this:GetValue())) then
		GameTooltip:SetText(format("%d", this:GetValue()));
	else
		GameTooltip:SetText(format("%.2f", this:GetValue()));
	end
end

function BRL_Slider_OnEnter()
	-- put the tool tip in the default position
	GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
	
	-- set the tool tip text
	if (this:GetValue() == floor(this:GetValue())) then
		GameTooltip:SetText(format("%d", this:GetValue()));
	else
		GameTooltip:SetText(format("%.2f", this:GetValue()));
	end
	
	GameTooltip:Show();
end

function BRL_Slider_OnLeave()
	GameTooltip:Hide();
end
