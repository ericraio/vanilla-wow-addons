--[[

	Range Color: Change the icon color when out of range, no mana, etc;
								also it shows the hotkeys for the extra Blizzard Bars.

	Made by: Edswor
	
	Commands: /rangecolor  or  /rc

]]

--------------------------------------------------------------------------------------------------
-- Other variables
--------------------------------------------------------------------------------------------------

local Old_ActionButton_OnUpdate;
local Old_ActionButton_UpdateUsable
local Old_ActionButton_UpdateHotkeys
local Old_FlexBarButton_OnUpdate;
local Old_FlexBarButton_UpdateUsable;
local Old_Gypsy_ActionButtonOnUpdate;
local Old_Gypsy_ActionButtonUpdateUsable;

--------------------------------------------------------------------------------------------------
-- OnLoad, Initialize
--------------------------------------------------------------------------------------------------

function RangeColor_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UPDATE_BINDINGS");
	this:RegisterEvent("ADDON_LOADED");

	SLASH_RANGECOLOR1 = "/rangecolor";
	SLASH_RANGECOLOR2 = "/rc";
	SlashCmdList["RANGECOLOR"] = RangeColor_ShowOptions;
	
	--Hook the ActionButton_OnUpdate function
	Old_ActionButton_OnUpdate = ActionButton_OnUpdate;
	ActionButton_OnUpdate = RangeColor_ActionButton_OnUpdate;

	--Hook the ActionButton_UpdateUsable function
	Old_ActionButton_UpdateUsable = ActionButton_UpdateUsable;
	ActionButton_UpdateUsable = RangeColor_ActionButton_UpdateUsable;

	--Hook the ActionButton_UpdateUsable function
	Old_ActionButton_UpdateHotkeys = ActionButton_UpdateHotkeys;
	ActionButton_UpdateHotkeys = RangeColor_ActionButton_UpdateHotkeys;

	--FlexBarButton_OnUpdate

	--Hook the FlexBarButton_OnUpdate and FlexBarButton_UpdateUsable function
	if (type(FlexBarButton_OnUpdate) == 'function') then
		Old_FlexBarButton_OnUpdate = FlexBarButton_OnUpdate;
		FlexBarButton_OnUpdate = RangeColor_FlexBarButton_OnUpdate;
	end
	if (type(FlexBarButton_UpdateUsable) == 'function') then
		Old_FlexBarButton_UpdateUsable = FlexBarButton_UpdateUsable;
		FlexBarButton_UpdateUsable = RangeColor_FlexBarButton_UpdateUsable;
	end
		
	--Hook the Gypsy_ActionButtonOnUpdate and Gypsy_ActionButtonOnUpdate function
	if (type(Gypsy_ActionButtonOnUpdate) == 'function') then
		Old_Gypsy_ActionButtonOnUpdate = Gypsy_ActionButtonOnUpdate;
		Gypsy_ActionButtonOnUpdate = RangeColor_Gypsy_ActionButtonOnUpdate;
	end
	if (type(Gypsy_ActionButtonUpdateUsable) == 'function') then
		Old_Gypsy_ActionButtonUpdateUsable = Gypsy_ActionButtonUpdateUsable;
		Gypsy_ActionButtonUpdateUsable = RangeColor_Gypsy_ActionButtonUpdateUsable;
	end

end

function RangeColor_Initialize()
	RangeColor_Save2 = {
		["Version"] = RANGECOLOR_VERSION,
		["Mode"] = 3,
		["Filter"] = 1,
		["Dash"] = 1,
		["Colors"] = {
			[1] =  {r = 1.0, g = 0.0, b = 0.0},
			[2] =  {r = 1.0, g = 0.0, b = 0.0},
			[3] =  {r = 1.0, g = 0.0, b = 0.0},
			[4] =  {r = 0.3, g = 0.3, b = 1.0},
			[5] =  {r = 0.3, g = 0.3, b = 1.0},
			[6] =  {r = 0.3, g = 0.3, b = 1.0},
			[7] =  {r = 0.4, g = 0.4, b = 0.4},
			[8] =  {r = 0.4, g = 0.4, b = 0.4},
			[9] =  {r = 0.6, g = 0.6, b = 0.6},
			[10] =  {r = 1.0, g = 1.0, b = 1.0},
			[11] =  {r = 1.0, g = 1.0, b = 1.0},
			[12] =  {r = 0.6, g = 0.6, b = 0.6}
		}
	};

end

--------------------------------------------------------------------------------------------------
-- ShowOptions, HideOptions, Toggle
--------------------------------------------------------------------------------------------------

function RangeColor_ShowOptions()
	ShowUIPanel(RangeColorOptionsFrame);
end

function RangeColor_HideOptions()
	HideUIPanel(RangeColorOptionsFrame);
end

function RangeColor_Toggle()
	if(RangeColorOptionsFrame:IsVisible()) then
		HideUIPanel(RangeColorOptionsFrame);
	else
		ShowUIPanel(RangeColorOptionsFrame);
	end
end

function RangeColor_ResetOptions()
	RangeColor_Initialize();
	RangeColor_HideOptions();
end

--------------------------------------------------------------------------------------------------
-- OnEvent, OnUpdate, UpdateUsable
--------------------------------------------------------------------------------------------------

function RangeColor_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		if ( RangeColor_Save2 == nil ) then
			RangeColor_Initialize();
		elseif( RangeColor_Save2["Version"] == nil or RangeColor_Save2["Version"] ~= RANGECOLOR_VERSION) then
			RangeColor_Initialize();
		end	
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Range Color|r, made by: |cffff3300Edswor|r, Version: |cffffff00"..RANGECOLOR_VERSION.."|r, loaded.");
		end
		return;
	elseif( event == "ADDON_LOADED") then
		if(myAddOnsFrame_Register) then
			RangeColorDetails = {
				name = "RangeColor",
				version = RANGECOLOR_VERSION,
				releaseDate = RANGECOLOR_RELEASE,
				author = "Edswor",
				email = "edsowr@hotmail.com",
				website = "http://edswor.iespana.es",
				category = MYADDONS_CATEGORY_BARS,
				optionsframe = "RangeColorOptionsFrame"
			};
			myAddOnsFrame_Register(RangeColorDetails, RangeColorHelp);
		end
		return;
	elseif( event == "UPDATE_BINDINGS" ) then
		RangeColor_UpdateHotkeys();
		return;
	end
end

function RangeColor_ActionButton_OnUpdate(elapsed)

	--This calls the old OnUpdate function
	Old_ActionButton_OnUpdate(elapsed);

	--This is to change the color if is out of range
	--Blizzard only change the color of the hotkey of the icon
	RangeColor_ActionButton(elapsed);

end

function RangeColor_ActionButton_UpdateUsable()

	--This calls the old UpdateUsable function
	--I dont make this calls, because I have rewritten all the Blizzard code
	--Uncomment to use it if needed with other addon
	--Old_ActionButton_UpdateUsable();
	
	RangeColor_ActionButton(0);

end

function RangeColor_ActionButton(elapsed)

	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(ActionButton_GetPagedID(this));
	local hotkey = getglobal(this:GetName().."HotKey");
		
	if ( (RangeColor_Get("Mode")==3) or (RangeColor_Get("Mode")==2 and hotkey:GetText()==nil)) then
		hotkey:SetVertexColor(0.6, 0.6, 0.6);
		if ( this.rangeTimer ) then
			if ( this.rangeTimer <= elapsed ) then
				if ( IsActionInRange(ActionButton_GetPagedID(this)) == 0 ) then
					icon:SetVertexColor(RangeColor_Save2["Colors"][1].r, RangeColor_Save2["Colors"][1].g, RangeColor_Save2["Colors"][1].b);
					normalTexture:SetVertexColor(RangeColor_Save2["Colors"][2].r, RangeColor_Save2["Colors"][2].g, RangeColor_Save2["Colors"][2].b);
				else
					if ( isUsable ) then
						icon:SetVertexColor(RangeColor_Save2["Colors"][10].r, RangeColor_Save2["Colors"][10].g, RangeColor_Save2["Colors"][10].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][11].r, RangeColor_Save2["Colors"][11].g, RangeColor_Save2["Colors"][11].b);
					elseif ( notEnoughMana ) then
						icon:SetVertexColor(RangeColor_Save2["Colors"][4].r, RangeColor_Save2["Colors"][4].g, RangeColor_Save2["Colors"][4].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][5].r, RangeColor_Save2["Colors"][5].g, RangeColor_Save2["Colors"][5].b);
					else
						icon:SetVertexColor(RangeColor_Save2["Colors"][7].r, RangeColor_Save2["Colors"][7].g, RangeColor_Save2["Colors"][7].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][8].r, RangeColor_Save2["Colors"][8].g, RangeColor_Save2["Colors"][8].b);
					end
				end
			end
		end
	else
		if ( this.rangeTimer ) then
			if ( this.rangeTimer <= elapsed ) then
				if ( IsActionInRange(ActionButton_GetPagedID(this)) == 0 ) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				end
			end
		end
		if ( IsActionInRange(ActionButton_GetPagedID(this)) == 0 ) then
			hotkey:SetVertexColor(RangeColor_Save2["Colors"][3].r, RangeColor_Save2["Colors"][3].g, RangeColor_Save2["Colors"][3].b);
		else
			if ( isUsable ) then
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][12].r, RangeColor_Save2["Colors"][12].g, RangeColor_Save2["Colors"][12].b);
			elseif ( notEnoughMana ) then
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][6].r, RangeColor_Save2["Colors"][6].g, RangeColor_Save2["Colors"][6].b);
			else
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][9].r, RangeColor_Save2["Colors"][9].g, RangeColor_Save2["Colors"][9].b);
			end
		end
	end
end

--------------------------------------------------------------------------------------------------
-- ActionButton_UpdateHotkeys, UpdateHotkeys, UpdateHotkeysBar, TransformText
--------------------------------------------------------------------------------------------------

--Overwrittes the Blizzard one to be able to use our filter for the text
function RangeColor_ActionButton_UpdateHotkeys(actionButtonType)
	if ( not actionButtonType ) then
		actionButtonType = "ACTIONBUTTON";
	end
	local hotkey = getglobal(this:GetName().."HotKey");
	local action = actionButtonType..this:GetID();
	local text = GetBindingText(GetBindingKey(action), "KEY_");
	if ( string.len(text)==0 ) then
		hotkey:Hide();
	else
		hotkey:SetText(RangeColor_TransformText(text));
		hotkey:Show();
	end
end

function RangeColor_UpdateHotkeys()
	RangeColor_UpdateHotkeysBar("MultiBarBottomLeft", 1);
  RangeColor_UpdateHotkeysBar("MultiBarBottomRight", 2);
  RangeColor_UpdateHotkeysBar("MultiBarRight", 3);
  RangeColor_UpdateHotkeysBar("MultiBarLeft", 4);
end

--Change the text of hotkeys of this multibar
function RangeColor_UpdateHotkeysBar(bar, id)
	local hotkey, action, text;
  for i = 1, 12 do
  	hotkey = getglobal(bar.."Button"..i.."HotKey");
    action = "MULTIACTIONBAR"..id.."BUTTON"..i;
    text = GetBindingText(GetBindingKey(action),"KEY_");
		if ( string.len(text)==0 ) then
			hotkey:Hide();
		else
			hotkey:SetText(RangeColor_TransformText(text));
			hotkey:Show();
		end
  end
end

function RangeColor_TransformText(text)

	--The fisrt time that WoW loads, it calls this function before any addon loads,
	--so I have put a default option if the addon is not loaded.
	--If you want to change to your options, make a change in the key binding menu
	--so this function is called again
	
	if (RangeColor_Save2 ~= nil) then
		if( RangeColor_Get("Filter")==1 ) then
			text = string.gsub(text, "CTRL", "C");
			text = string.gsub(text, "ALT", "A");
			text = string.gsub(text, "SHIFT", "S");
			if( RangeColor_Get("Dash")==1 ) then
				text = string.gsub(text, "-", "");
			end
		end
	else
		text = string.gsub(text, "CTRL", "C");
		text = string.gsub(text, "ALT", "A");
		text = string.gsub(text, "SHIFT", "S");
		text = string.gsub(text, "-", "");
	end
	
	return text;
end

--------------------------------------------------------------------------------------------------
-- Set, Get, GetColor, SetColor
--------------------------------------------------------------------------------------------------

function RangeColor_Get(option)
	if (RangeColor_Save2[option] ~= nil) then
		return RangeColor_Save2[option];
	end
end

function RangeColor_Set(option, val)
	if (RangeColor_Save2 ~= nil) then
		if ( option ) then
			RangeColor_Save2[option] = val;
		end
	end
end

function RangeColor_GetColor(key)
	local color = {r = 1.0, g = 1.0, b = 1.0};
	
	if (RangeColor_Save2["Colors"][key] ~= nil) then
		color.r = RangeColor_Save2["Colors"][key].r;
		color.g = RangeColor_Save2["Colors"][key].g;
		color.b = RangeColor_Save2["Colors"][key].b;
		return color;
	end
end

function RangeColor_SetColor(key, r, g, b)
	if (RangeColor_Save2["Colors"][key] ~= nil) then
		RangeColor_Save2["Colors"][key].r = r;
		RangeColor_Save2["Colors"][key].g = g;
		RangeColor_Save2["Colors"][key].b = b;
	end
end

--------------------------------------------------------------------------------------------------
-- Flexbar
--------------------------------------------------------------------------------------------------
-- OnUpdate, UpdateUsable
--------------------------------------------------------------------------------------------------

function RangeColor_FlexBarButton_OnUpdate(elapsed, button)

	--This calls the old OnUpdate function
	Old_FlexBarButton_OnUpdate(elapsed, button);

	--This is to change the color if is out of range
	RangeColor_FlexBarButton_UpdateUsable(button);

end

function RangeColor_FlexBarButton_UpdateUsable(button)
	
	--This calls the old UpdateUsable function
	Old_FlexBarButton_UpdateUsable(button);

	local icon = getglobal(button:GetName().."Icon");
	local normalTexture = getglobal(button:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(FlexBarButton_GetID(button));
	local hotkey = getglobal(button:GetName().."HotKey");
	
	if ( (RangeColor_Get("Mode")==3) or (RangeColor_Get("Mode")==2 and hotkey:GetText()==nil)) then
		hotkey:SetVertexColor(0.6, 0.6, 0.6);
		if ( button.rangeTimer ) then
			if ( button.rangeTimer < 0 ) then
				if ( IsActionInRange(FlexBarButton_GetID(button)) == 0 ) then
					icon:SetVertexColor(RangeColor_Save2["Colors"][1].r, RangeColor_Save2["Colors"][1].g, RangeColor_Save2["Colors"][1].b);
					normalTexture:SetVertexColor(RangeColor_Save2["Colors"][2].r, RangeColor_Save2["Colors"][2].g, RangeColor_Save2["Colors"][2].b);
				else
					if ( isUsable ) then
						icon:SetVertexColor(RangeColor_Save2["Colors"][10].r, RangeColor_Save2["Colors"][10].g, RangeColor_Save2["Colors"][10].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][11].r, RangeColor_Save2["Colors"][11].g, RangeColor_Save2["Colors"][11].b);
					elseif ( notEnoughMana ) then
						icon:SetVertexColor(RangeColor_Save2["Colors"][4].r, RangeColor_Save2["Colors"][4].g, RangeColor_Save2["Colors"][4].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][5].r, RangeColor_Save2["Colors"][5].g, RangeColor_Save2["Colors"][5].b);
					else
						icon:SetVertexColor(RangeColor_Save2["Colors"][7].r, RangeColor_Save2["Colors"][7].g, RangeColor_Save2["Colors"][7].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][8].r, RangeColor_Save2["Colors"][8].g, RangeColor_Save2["Colors"][8].b);
					end
				end
			end
		end
	else
		if ( button.rangeTimer ) then
			if ( button.rangeTimer < 0 ) then
				if ( IsActionInRange(FlexBarButton_GetID(button)) == 0 ) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				end
			end
		end
		if ( IsActionInRange(FlexBarButton_GetID(button)) == 0 ) then
			hotkey:SetVertexColor(RangeColor_Save2["Colors"][3].r, RangeColor_Save2["Colors"][3].g, RangeColor_Save2["Colors"][3].b);
		else
			if ( isUsable ) then
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][12].r, RangeColor_Save2["Colors"][12].g, RangeColor_Save2["Colors"][12].b);
			elseif ( notEnoughMana ) then
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][6].r, RangeColor_Save2["Colors"][6].g, RangeColor_Save2["Colors"][6].b);
			else
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][9].r, RangeColor_Save2["Colors"][9].g, RangeColor_Save2["Colors"][9].b);
			end
		end
	end
end


--------------------------------------------------------------------------------------------------
-- Other Action Bars
--------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------
-- Gypsy
--------------------------------------------------------------------------------------------------
-- OnUpdate, UpdateUsable
--------------------------------------------------------------------------------------------------

function RangeColor_Gypsy_ActionButtonOnUpdate(elapsed)

	--This calls the old OnUpdate function
	Old_Gypsy_ActionButtonOnUpdate(elapsed);

	--This is to change the color if is out of range
	RangeColor_Gypsy_ActionButtonUpdateUsable();

end

function RangeColor_Gypsy_ActionButtonUpdateUsable()
	
	--This calls the old UpdateUsable function
	--I dont make this calls, because I have rewritten all the code
	--Uncomment to use it if needed with other addon or some errors occurs
	--Old_Gypsy_ActionButtonUpdateUsable();

	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(Gypsy_ActionButtonGetPagedID(this));
	local hotkey = getglobal(this:GetName().."HotKey");
	
	if ( (RangeColor_Get("Mode")==3) or (RangeColor_Get("Mode")==2 and hotkey:GetText()==nil)) then
		hotkey:SetVertexColor(0.6, 0.6, 0.6);
		if ( this.rangeTimer ) then
			if ( this.rangeTimer < 0 ) then
				if ( IsActionInRange(Gypsy_ActionButtonGetPagedID(this)) == 0 ) then
					icon:SetVertexColor(RangeColor_Save2["Colors"][1].r, RangeColor_Save2["Colors"][1].g, RangeColor_Save2["Colors"][1].b);
					normalTexture:SetVertexColor(RangeColor_Save2["Colors"][2].r, RangeColor_Save2["Colors"][2].g, RangeColor_Save2["Colors"][2].b);
				else
					if ( isUsable ) then
						icon:SetVertexColor(RangeColor_Save2["Colors"][10].r, RangeColor_Save2["Colors"][10].g, RangeColor_Save2["Colors"][10].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][11].r, RangeColor_Save2["Colors"][11].g, RangeColor_Save2["Colors"][11].b);
					elseif ( notEnoughMana ) then
						icon:SetVertexColor(RangeColor_Save2["Colors"][4].r, RangeColor_Save2["Colors"][4].g, RangeColor_Save2["Colors"][4].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][5].r, RangeColor_Save2["Colors"][5].g, RangeColor_Save2["Colors"][5].b);
					else
						icon:SetVertexColor(RangeColor_Save2["Colors"][7].r, RangeColor_Save2["Colors"][7].g, RangeColor_Save2["Colors"][7].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][8].r, RangeColor_Save2["Colors"][8].g, RangeColor_Save2["Colors"][8].b);
					end
				end
			end
		end
	else
		if ( this.rangeTimer ) then
			if ( this.rangeTimer < 0 ) then
				if ( IsActionInRange(Gypsy_ActionButtonGetPagedID(this)) == 0 ) then
					icon:SetVertexColor(1.0, 1.0, 1.0);
					normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				end
			end
		end
		if ( IsActionInRange(Gypsy_ActionButtonGetPagedID(this)) == 0 ) then
			hotkey:SetVertexColor(RangeColor_Save2["Colors"][3].r, RangeColor_Save2["Colors"][3].g, RangeColor_Save2["Colors"][3].b);
		else
			if ( isUsable ) then
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][12].r, RangeColor_Save2["Colors"][12].g, RangeColor_Save2["Colors"][12].b);
			elseif ( notEnoughMana ) then
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][6].r, RangeColor_Save2["Colors"][6].g, RangeColor_Save2["Colors"][6].b);
			else
				hotkey:SetVertexColor(RangeColor_Save2["Colors"][9].r, RangeColor_Save2["Colors"][9].g, RangeColor_Save2["Colors"][9].b);
			end
		end
	end
end

