--[[

Titan Panel [Parchment]

Titan Panel support for Parchment
	
Author: Valnar (AKA: Thor)
Website: www.destroyersofhope.com
Email: thor@destroyersofhope.com
Patch Notes: Located in the PatchNotes.txt file

--]]

TITAN_PARCHMENT_ID = "Parchment";
TITAN_PARCHMENT_MENU_TEXT = "Parchment";
TITAN_PARCHMENT_BUTTON_LABEL = "Parchment";
TITAN_PARCHMENT_TOOLTIP = "Tacked Chapters";
TITAN_PARCHMENT_MENU_TACK = "Show Tack Window";
TITAN_PARCHMENT_MENU_LABEL = "Show Label";
TITAN_PARCHMENT_MENU_ICON = "Show Icon";
TITAN_PARCHMENT_MENU_REALMS = "View All Realms";

function TitanPanelParchmentButton_OnLoad()
	this.registry = { 
		id = TITAN_PARCHMENT_ID,
		menuText = TITAN_PARCHMENT_MENU_TEXT,
		buttonTextFunction = "TitanPanelParchmentButton_GetButtonText",
		tooltipTitle = TITAN_PARCHMENT_TOOLTIP,
		tooltipTextFunction = "TitanPanelParchmentButton_GetTooltipText",
		frequency = 1,	
		icon = "Interface\\AddOns\\Parchment\\ParchmentButton",	
		iconWidth = 16,
		savedVariables = {
			ShowLabelText = 1,
			ShowIcon = 1,
			ShowTack = TITAN_NIL,
			ShowAllRealms = false,
		}
	};
end

function TitanPanelParchmentButton_GetButtonText(id)
	local id = TitanUtils_GetButton(id, true);

	if(TitanGetVar(TITAN_PARCHMENT_ID, "ShowLabelText")) then
		return TITAN_PARCHMENT_BUTTON_LABEL;
	elseif(not(TitanGetVar(TITAN_PARCHMENT_ID, "ShowLabelText")) and not TitanGetVar(TITAN_PARCHMENT_ID, "ShowIcon")) then
		return TITAN_PARCHMENT_BUTTON_LABEL;
	end
end

function TitanPanelParchmentButton_GetTooltipText()
	if(TitanGetVar(TITAN_PARCHMENT_ID, "ShowTack")) then
		local temp_string = "";
		local thisRealm = nil;
		local character = nil;

		for key, value in Parchment_Data do
			character = nil;

			if(Parchment_Data[key].tacked) then
				thisRealm = Parchment_Split(key, "|")[2];

				if(thisRealm) then
					if(TitanGetVar(TITAN_PARCHMENT_ID, "ShowAllRealms")) then
						character = Parchment_Split(key,"|")[1].." of "..Parchment_Split(key,"|")[2];
					else
						if(thisRealm == GetCVar("realmName")) then
							character = Parchment_Split(key,"|")[1];
						end
					end
				else
					character = key;
				end

				if(character ~= nil) then
					temp_string = "|c00FFFFFF- "..character.."|r\n"..Parchment_Data[key].text.."\n\n".. temp_string;
				end
			end
		end
		
		return temp_string;
	end
end

function TitalPanelParchmentButton_OnClick(button)
	if(button == "LeftButton") then
		ParchmentButton_OnClick();
	end
end

function TitanPanelRightClickMenu_PrepareParchmentMenu()
	local info;

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_PARCHMENT_ID].menuText);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_PARCHMENT_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_PARCHMENT_ID);
	
	info = {};
	info.text = TITAN_PARCHMENT_MENU_TACK;
	info.func = TitanParchment_Tack;
	info.checked = TitanGetVar(TITAN_PARCHMENT_ID, "ShowTack");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_PARCHMENT_MENU_REALMS;
	info.func = TitanParchment_Realms;
	info.checked = TitanGetVar(TITAN_PARCHMENT_ID, "ShowAllRealms");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_PARCHMENT_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanParchment_Tack()
	TitanToggleVar(TITAN_PARCHMENT_ID, "ShowTack");
end

function TitanParchment_Realms()
	TitanToggleVar(TITAN_PARCHMENT_ID, "ShowAllRealms");
end