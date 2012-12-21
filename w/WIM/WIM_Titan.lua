--[ WIM Titan Panel Addon ]
WIM_TITAN_IS_LOADED = false;
WIM_CurMessageState = false;


function WIM_TitanButton_OnLoad()
	if (IsAddOnLoaded("Titan")) then
		WIM_TITAN_IS_LOADED = true;
		this.registry = {
			id = "WIM",
			version = WIM_VERSION,
			menuText = "WIM", 
			buttonTextFunction = "WIM_Titan_GetButtonText",
			tooltipTitle = "WIM", 
			tooltipTextFunction = "WIM_Titan_GetToolTipText",
			frequency = .5, 
			iconWidth = 20,
			savedVariables = {
				ShowIcon = 1,
				ShowLabelText = 1,
			}
		};

		TitanPanelButton_OnLoad();
	end
end


function WIM_Titan_GetButtonText()
	local msgColor = "|cffedc300";
	if(WIM_NewMessageFlag) then
		if( WIM_CurMessageState ~= WIM_NewMessageFlag) then
			local icon = getglobal("TitanPanelWIMButtonIcon");
			icon:SetTexture("Interface\\AddOns\\WIM\\Images\\miniEnabled");
			WIM_CurMessageState = WIM_NewMessageFlag;
		end
		if(WIM_Titan_NewMessageFlash:IsVisible()) then
			WIM_Titan_NewMessageFlash:Hide();
		else
			WIM_Titan_NewMessageFlash:Show();
			msgColor = "|cffffffff";
		end
	else
		if( WIM_CurMessageState ~= WIM_NewMessageFlag) then
			local icon = getglobal("TitanPanelWIMButtonIcon");
			icon:SetTexture("Interface\\AddOns\\WIM\\Images\\miniDisabled");
			WIM_Titan_NewMessageFlash:Hide();
			WIM_CurMessageState = WIM_NewMessageFlag;
		end
	end
	
	return msgColor.."Messages: ", "|cffffffff"..WIM_NewMessageCount;
end

function WIM_Titan_GetToolTipText()
	--[WIM shows its own tooltip
	return;
end

function WIM_Titan_ToggleDropDown()
	WIM_Titan_DropDown.point = "TOPLEFT";
	WIM_Titan_DropDown.relativePoint = "BOTTOMLEFT";
	ToggleDropDownMenu(1, nil, WIM_Titan_DropDown);
end


function WIM_TitanButton_OnShow()
	if(WIM_TITAN_IS_LOADED) then
		local icon = getglobal("TitanPanelWIMButtonIcon");
		icon:SetHeight(20);
		icon:SetWidth(20);
		icon:SetTexture("Interface\\AddOns\\WIM\\Images\\miniDisabled");
		TitanPanelButton_OnShow();
	end
end

function WIM_Titan_InitMenu()
	UIDropDownMenu_Initialize(this, WIM_Icon_DropDown_Init, "MENU");
end
