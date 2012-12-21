UIPanelWindows["CT_CPFrame"] = { area = "left", pushable = 1 };

CT_CPMovable = nil;

local CT_CPTabs = {
	{ "General", "General", "Interface\\Icons\\Spell_Shadow_SoulGem" },
	{ "Hotbar Mods", "Hotbar Mods", "Interface\\Icons\\Ability_Rogue_SliceDice" },
	{ "Party Mods", "Party Mods", "Interface\\Icons\\Spell_Nature_Invisibilty" },
	{ "Player Mods", "Player Mods", "Interface\\Icons\\Ability_Warrior_Revenge" },
	{ "Misc. Mods", "Misc. Mods", "Interface\\Icons\\Spell_Frost_Stun" }
};

function CT_UnlockCP(movable)
	local show = CT_CPFrame:IsVisible();
	CT_CPMovable = movable;
	HideUIPanel(CT_CPFrame);
	if ( movable ) then
		tinsert(UISpecialFrames, "CT_CPFrame");
		UIPanelWindows["CT_CPFrame"] = nil;
		CT_CPMoveButton:Show();
	else
		CT_CPMoveButton:Hide();
		for key, val in UISpecialFrames do
			if ( val == "CT_CPFrame" ) then val = nil; end
		end
		UIPanelWindows["CT_CPFrame"] = { area = "left", pushable = 1 };
	end
	if ( show ) then
		ShowUIPanel(CT_CPFrame);
	end
end
local NUM_CP_TABS = getn(CT_CPTabs);
local MAX_CP_TABS = 8;
local MAX_CP_ICONS = 14;

function CT_CPSetTab(id)
	for i = 1, getn(CT_CPTabs), 1 do
		if ( CT_CPFrame_ShallDisplayTabFlash(i) ) then
			getglobal("CT_CPTab" .. i .. "Flash"):Show();
		else
			getglobal("CT_CPTab" .. i .. "Flash"):Hide();
		end
	end
	if ( CT_CPFrame.currTab == id and CT_CPFrame.currPage == 1 ) then
		getglobal("CT_CPTab" .. id):SetChecked(1);
		return;
	end
	CT_CPFrame.currPage = 1;
	if ( CT_CPFrame.currTab) then
		getglobal("CT_CPTab" .. CT_CPFrame.currTab):SetChecked(nil);
	end
	getglobal("CT_CPTab" .. id .. "Flash"):Hide();
	getglobal("CT_CPTab" .. id):SetChecked(1);
	if ( CT_CPFrame.currTab ~= id ) then
		CT_CPFrame_HideSlider();
	end
	CT_CPFrame.currTab = id;
	if ( id == 1 ) then
		CT_CPGeneralSlider:Show();
		CT_CPGeneralMoveText:Show();
		CT_CPGeneralMoveCB:Show();
		CT_CPPrevPage:Hide();
		CT_CPNextPage:Hide();
		CT_CPPageText:SetText("");
	else
		CT_CPPageText:SetText("Page 1/"..ceil(CT_CPFrame_GetNumMods()/14));
		CT_CPGeneralSlider:Hide();
		CT_CPGeneralMoveText:Hide();
		CT_CPGeneralMoveCB:Hide();
		CT_CPPrevPage:Show();
		CT_CPNextPage:Show();
	end
	CT_CPTabText:SetText(CT_CPTabs[id][1]);
	CT_CPFrame_UpdateButtons();
end

function CT_CPFrame_OnLoad()
	CT_CPFrame.currPage = 1;
	this:RegisterEvent("VARIABLES_LOADED");
	CT_CPTab_OnClick(1);
	for i = 1, NUM_CP_TABS, 1 do
		getglobal("CT_CPTab" .. i).tooltiptext = CT_CPTabs[i][2];
		getglobal("CT_CPTab" .. i):SetNormalTexture(CT_CPTabs[i][3]);
		getglobal("CT_CPTabButton" .. i).tooltiptext = CT_CPTabs[i][2];
	end
	CT_CPFrame_UpdateButtons();
	CT_CPWelcomeText:SetText(CT_MASTERMOD_CPWELCOMETEXT);
end

function CT_CPFrame_OnShow()
	PlaySound("igSpellBookOpen");
	CT_CPSetTab(CT_CPFrame.currTab or 1);
end

function CT_CPFrame_Update()
	for i = 1, MAX_CP_TABS, 1 do
		if ( i > NUM_CP_TABS ) then
			getglobal("CT_CPTab" .. i):Hide();
		else
			getglobal("CT_CPTab" .. i):Show();
		end
	end
end

function CT_CPFrame_OnHide()
	PlaySound("igSpellBookClose");
	CT_CPFrame_HideSlider();
end

function CT_CPButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if ( GameTooltip:SetText(this.tooltiptext) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end
end

function CT_CPButton_OnUpdate(elapsed)
	if ( not this.updateTooltip ) then
		return;
	end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		CT_CPButton_OnEnter();
	else
		this.updateTooltip = nil;
	end
end

function CT_CPButton_OnLoad()
	local buttonid = this:GetID();
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	CT_CPButton_UpdateButton();
end

function CT_CPButton_OnClick()
	local value = CT_Mods[this.id];
	if ( not value or not value["modStatus"] ) then return; end
	if ( value["modStatus"] == "switch" ) then
		value["modFunc"](this.id, getglobal("CT_CPButton" .. this:GetID() .. "Count"));
		CT_SaveInfoName(value["modName"]);
		this:SetChecked("false");
		CT_CPFrame_HideSlider();
		return;
	elseif ( value["modStatus"] == "slider" ) then
		value["modFunc"](this.id, this);
		this:SetChecked("false");
		return;
	end
	CT_CPFrame_HideSlider();
	if ( value["modStatus"] == "off" ) then
		CT_SetModStatus(value["modName"], "on");
		this:SetChecked("true");
	else
		this:SetChecked("false");
		CT_SetModStatus(value["modName"], "off");
	end
	if ( value["modFunc"] ) then
		value["modFunc"](this.id);
	end
end

function CT_CPButton_OnShow()
	CT_CPButton_UpdateButton();
end

function CT_CPButton_UpdateButton(btn)
	local button;
	if ( btn ) then
		button = btn;
	else
		button = this;
	end
	local i = button:GetID();
	local icon = getglobal("CT_CPButton"..i .. "NormalTexture");
	local iconTexture = getglobal("CT_CPButton"..i.."IconTexture");
	local iconName = getglobal("CT_CPButton"..i.."Name");
	local iconDescription = getglobal("CT_CPButton"..i.."SubName");
	local highlightTexture = getglobal("CT_CPButton"..i.."Highlight");
	local normalTexture = getglobal("CT_CPButton"..i.."NormalTexture");
	local iconCount = getglobal("CT_CPButton"..i.."Count");
	local flash = getglobal("CT_CPButton"..i.."Flash");
		
	local modString = getglobal("CT_CPButton"..i.."Name");
	local descriptString = getglobal("CT_CPButton"..i.."SubName");
	local modName, modDescript, modIcon, modValue;
	local modId = CT_CPFrame_GetModID(i);
	local val = CT_Mods[modId];
	if ( not val ) then
		button:Hide();
		if ( flash ) then
			flash:Hide();
		end
		return;
	else
		button:Show();
	end

	if ( icon ) then icon:Show(); end
	if ( iconTexture ) then iconTexture:Show(); iconTexture:SetVertexColor(1.0, 1.0, 1.0); end
	if ( highlightTexture ) then highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square"); end
	if ( modString ) then modString:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b); end
	modStatus = val["modStatus"];
	modName = val["modName"];
	modDescript = val["modDescript"];
	modIcon = val["modIcon"];
	modValue = val["modValue"];
	button.tooltiptext = val["modTooltip"];
	button.id = modId;

	if ( val["modOnDisplay"] and type(val["modOnDisplay"]) == "function" and this:IsVisible() ) then
		val["modOnDisplay"](modName, modStatus, modValue, iconCount);
	end
	
	if ( not val["hasBeenDisplayed"] and CT_CPFrame.currTab ~= 1 ) then
		if ( flash ) then
			flash:Show();
		end
		CT_Mods[modId]["hasBeenDisplayed"] = 1;
		CT_SaveInfoName(modId);
	elseif ( flash ) then
		flash:Hide();
	end
	if ( iconTexture ) then iconTexture:SetTexture(modIcon); end
	if ( modString ) then modString:SetText(modName); end
	if ( descriptString ) then descriptString:SetText(modDescript); end
	if ( iconCount and modStatus ~= "slider" ) then iconCount:SetText(modValue); elseif ( iconCount ) then iconCount:SetText(""); end
	if ( modString ) then modString:Show(); end
	if ( descriptString ) then descriptString:Show(); end
	if ( modStatus == "disabled" ) then
		if ( iconTexture ) then iconTexture:SetVertexColor(0.5, 0.5, 0.5); end
	end
	if ( btn ) then
		CT_CPButton_UpdateSelection(btn);
	else
		CT_CPButton_UpdateSelection();
	end
end

function CT_CPTab_OnClick(id)
	local update;
	if ( not id ) then
		id = this:GetID();
	end
	CT_CPSetTab(id);
	if ( id == 1 ) then
		-- Show Welcome Text
		CT_CPWelcomeText:Show();
	else
		-- Hide Welcome Text
		CT_CPWelcomeText:Hide();
	end

	CT_CPFrame_Update();
end

function CT_CPButton_UpdateSelection(btn)
	local button;
	if ( btn ) then
		button = btn;
	else
		button = this;
	end
	local i = button.id;
	local status = CT_Mods[i];
	if ( not status ) then
		return;
	else
		status = status["modStatus"];
		if ( not status ) then
			return;
		end
	end
	if ( status == "on" ) then
		button:SetChecked("true");
	else
		button:SetChecked("false");
	end
end

function CT_CPFrame_UpdateButtons()
	local numMods = CT_CPFrame_GetNumMods();
	if ( numMods > CT_CPFrame.currPage*14 ) then
		CT_CPNextPage:Enable();
	else
		CT_CPNextPage:Disable();
	end
	if ( CT_CPFrame.currPage > 1 ) then
		CT_CPPrevPage:Enable();
	else
		CT_CPPrevPage:Disable();
	end
	for i = 1, 14, 1 do
		CT_CPButton_UpdateButton(getglobal("CT_CPButton" .. i));
	end
end

function CT_CPFrame_HideButton(btn)
	local name = btn:GetName();
	btn:Hide();
end

function CT_CPFrame_GetNumMods()
	local counter = 0;
	for key, val in CT_Mods do
		if ( key ~= "version" ) then
			if ( val["modType"] == CT_CPFrame.currTab ) then
				counter = counter + 1;
			end
		end
	end
	return counter;
end

function CT_CPFrame_ChangePage(offset)
	CT_CPFrame_HideSlider();
	CT_CPFrame.currPage = CT_CPFrame.currPage + offset;
	CT_CPPageText:SetText("Page " .. CT_CPFrame.currPage .. "/" .. ceil(CT_CPFrame_GetNumMods()/14));
	CT_CPFrame_UpdateButtons();
end

function CT_CPFrame_GetModID(num)
	local counter = 1;
	for key, val in CT_Mods do
		if ( key ~= "version" ) then
			if ( val["modType"] == CT_CPFrame.currTab and val["modOrder"] == (num+((CT_CPFrame.currPage-1)*14)) ) then
				return key;
			end
		end
	end
	return -1;
end

function CT_CPFrame_ShallDisplayTabFlash(tabId)
	if ( tabId == 1 ) then
		return false;
	end
	for key, val in CT_Mods do
		if ( key ~= "version" ) then
			if ( val["modType"] == tabId and not val["hasBeenDisplayed"] ) then
				return true;
			end
		end
	end
	return false;
end

function CT_CPFrame_ShowSlider(button, modId, value, onChangeFunc, minVal, maxVal, step, lowText, highText, title, tooltipText, showValueInTitle)
	CT_CPModSliderFrame:ClearAllPoints();
	CT_CPModSliderFrame:SetPoint("TOP", button:GetName(), "BOTTOM", 0, 10);
	CT_CPModSliderFrame:Show();
	
	CT_CPModSliderFrameSlider:SetMinMaxValues( ( minVal or 0), ( maxVal or 100 ) );
	CT_CPModSliderFrameSlider:SetValueStep(step or 1);
	CT_CPModSliderFrameSlider.onChangeFunc = onChangeFunc;
	CT_CPModSliderFrameSlider.id = modId;
	CT_CPModSliderFrameSlider.title = ( title or button.id );
	CT_CPModSliderFrameSlider:SetValue(value);
	
	CT_CPModSliderFrameSliderLow:SetText(( lowText or minVal ));
	CT_CPModSliderFrameSliderHigh:SetText(( highText or maxVal ));
	CT_CPModSliderFrameSliderText:SetText(title or button.id);
	CT_CPModSliderFrameSlider.tooltipText = tooltipText;
	CT_CPModSliderFrameSlider.showValueInTitle = showValueInTitle;

	if ( showValueInTitle ) then
		getglobal(CT_CPModSliderFrameSlider:GetName() .. "Text"):SetText(CT_CPModSliderFrameSlider.title .. " - " .. format(showValueInTitle, floor(value*100)/100));
	else
		getglobal(CT_CPModSliderFrameSlider:GetName() .. "Text"):SetText(CT_CPModSliderFrameSlider.title);
	end
end

function CT_CPFrame_HideSlider()
	if ( CT_CPModSliderFrame ) then
		CT_CPModSliderFrame:Hide();
	end
end

function CT_CPFrame_IsSliderVisible()
	return CT_CPModSliderFrame:IsVisible();
end

SlashCmdList["CTCP"] = function()
	if ( CT_CPFrame:IsVisible() ) then
		CT_CPFrame:Hide();
	else
		CT_CPFrame:Show();
	end
end

SLASH_CTCP1 = "/ctcp";