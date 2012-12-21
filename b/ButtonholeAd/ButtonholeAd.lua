
-- Buttonhole Advanced: Swallows Minimap Buttons
-- Copyright (C) 2006  Aaron Griffith

-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

ButtonholeAd_Version = "0.1"; -- Buttonhole Advanced Version. Change at Release

ButtonholeAd_Branch = ""; -- Buttonhole Advanced Branch. Change this all you AddOn ripoff posers! <3

ButtonholeAd_Author = "|cffff0000Swatch|r of Stormrage"; -- Change this too ^^

-- This next block is the text for the help window.
ButtonholeAd_windowtext = [[Welcome to Buttonhole Advanced ]] .. ButtonholeAd_Version .. ButtonholeAd_Branch .. [[
(by ]] .. ButtonholeAd_Author .. [[)

When the original Buttonhole was killed, alot of
people were sent steaming into unknown depths
of anger. Seeing an oppurtunity, I pounced on it.
Hence, Buttonhole Advanced.

Completely rewritten and with more features to
use, it's the ultimate Buttonhole.

        Classic Mode:  |cffff8888(SemiWorking)|r

In classic mode, Buttonhole Advanced behaves
just like it's predicessor. It hides all the
buttons in one, allowing you to scroll through
them with the scrollwheel.

        Menu Mode:     |cffff0000(Not Working)|r

In menu mode, all of the buttons hidden in
the buttonhole are accessable through a menu,
shown when you left click the button.

        Expander Mode:

In expander mode, all of the buttons only
become visible when you toggle the button-
hole.

        Off Mode:

This is obvious. This mode disables button-
holing.]];

ButtonholeAdDetails = {
name = "Buttonhole Advanced",
version = ButtonholeAd_Version,
releaseDate = "June 25, 2006",
author = ButtonholeAd_Author,
email = "aargri@gmail.com",
--website = "fixme",
category = MYADDONS_CATEGORY_OTHERS,
optionsframe = "ButtonholeAdFrame" };

ButtonholeAd_Debug = 0;
ButtonholeAd_Method = 0;
ButtonholeAd_Pos = 97;

ButtonholeAd_SwallowButtons = {};

function BHA_Debug(msg)
	if (ButtonholeAd_Debug == 1) then
		DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Debug : " .. msg, 0.2, 0.8, 0.8);
	end
end

-- This is the /bh command
function ButtonholeAd_Command(cmd)
  if (cmd == "debug") then -- Handle a debug call real quick-like
    if (ButtonholeAd_Debug == 1) then
      ButtonholeAd_Debug=0;
      DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Debug Off", 0.2, 0.8, 0.8);
    else
      ButtonholeAd_Debug=1;
      DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Debug On", 0.2, 0.8, 0.8);
    end
    return nil;
  end
  if (cmd == "") then -- If there is no string, open help
  	BHA_Debug("Showing config frame");
    ButtonholeAdFrame:Show();
    return nil;
  end
end

function ButtonholeAd_UpdateMethodUI()
	ButtonholeAdFrameCheckButtonClassic:SetChecked(0);
	ButtonholeAdFrameCheckButtonMenu:SetChecked(0);
	ButtonholeAdFrameCheckButtonExpander:SetChecked(0);
	ButtonholeAdFrameCheckButtonOff:SetChecked(0);
	if (ButtonholeAd_Method == 0) then
		BHA_Debug("Method set to Classic");
		ButtonholeAdFrameCheckButtonClassic:SetChecked(1);
		ButtonholeAd_Off_Init();
		ButtonholeAd_Classic_Init();
		return nil;
	end
	if (ButtonholeAd_Method == 1) then
		BHA_Debug("Method set to Menu");
		ButtonholeAdFrameCheckButtonMenu:SetChecked(1);
		ButtonholeAd_Off_Init();
		ButtonholeAd_Menu_Init();
		return nil;
	end
	if (ButtonholeAd_Method == 2) then
		BHA_Debug("Method set to Expander");
		ButtonholeAdFrameCheckButtonExpander:SetChecked(1);
		ButtonholeAd_Off_Init();
		ButtonholeAd_Expander_Init();
		return nil;
	end
	if (ButtonholeAd_Method == 3) then
		BHA_Debug("Method set to Off");
		ButtonholeAdFrameCheckButtonOff:SetChecked(1);
		ButtonholeAd_Off_Init();
		return nil;
	end
end

function ButtonholeAd_UpdatePosUI()
	ButtonholeAdFramePosSlider:SetValue(ButtonholeAd_Pos);
	
	x = cos(ButtonholeAd_Pos);
	y = sin(ButtonholeAd_Pos);
	x = -x;
	y = -y;
	x = x * 81;
	y = y * 81;
	x = x + 53;
	y = y - 54;
	
	ButtonholeAd_Minimap:SetPoint("TOPLEFT", x, y);
	
	-- BHA_Debug("Setting button position to " .. ButtonholeAd_Pos);
end

function ButtonholeAd_Minimap_OnClick(arg1)
	if (arg1 == "RightButton") then
		if (ButtonholeAdFrame:IsShown()) then
			BHA_Debug("Hiding config frame");
    		ButtonholeAdFrame:Hide();
    		return nil;
    	end
		BHA_Debug("Showing config frame");
    	ButtonholeAdFrame:Show();
    	return nil;
    end
    ButtonholeAd_Menu_Click();
    ButtonholeAd_Expander_Click();
end

-- Does this on load (duh)
function ButtonholeAd_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED"); -- Registers for Loaded Variables (standard)
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("ADDON_LOADED");
	SLASH_BUTTONHOLEAD1 = "/buttonhole"; -- Long Command
	SLASH_BUTTONHOLEAD2 = "/bh"; -- Short Command
	SLASH_BUTTONHOLEAD3 = "/buttonholead"; -- Semi-Long Command
	SLASH_BUTTONHOLEAD4 = "/buttonholeadvanced"; -- Really Long Command
	SLASH_BUTTONHOLEAD5 = "/bha"; -- Semi-Short Command
	SlashCmdList["BUTTONHOLEAD"] = ButtonholeAd_Command;
	ButtonholeAdFrameText:SetText(ButtonholeAd_windowtext); -- Sets the Help Text
end


---------------------------------------------------------------------------

function ButtonholeAd_WheelWrapper()
	ButtonholeAd_Classic_Wheel(arg1);
end

function ButtonholeAd_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		-- ButtonholeAd_UpdateMethodUI();
		-- ButtonholeAd_UpdatePosUI();
		DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Ready for Work!", 0.2, 0.8, 0.8); -- Something need doing?
	end
	if (event == "ADDON_LOADED") and (myAddOnsFrame_Register) then
		myAddOnsFrame_Register(ButtonholeAdDetails);
	end
	if (event == "PLAYER_LOGIN") then
		local kids = { Minimap:GetChildren() };
		for _,child in ipairs(kids) do
			if (child:GetName() == nil) then
				-- skip, unamed freaks!
			else
				local name = child:GetName();
				local first = string.find(strlower(name), "minimap");
				local second = string.find(strlower(name), "gathernote");
				if (second == 1) then
					-- Gatherer Wierdness
				elseif (first == 1) then
					-- skip, original frames
				else
					if not (name == "ButtonholeAd_Minimap") then -- Skip ourselves...
						local tmp = {
							ModName = name,
							ModFrame = child,
							ModOriginalX = child:GetLeft(),
							ModOriginalY = child:GetBottom(),
							ModOriginalS = child:GetScale();
							ModOriginalSetPoint = child.SetPoint };
						if (name == "CT_OptionBarFrame") then tmp.ModOriginalX = nil; end
						if (name == "GathererUI_IconFrame") then
							if (Chronos) then
								Chronos.schedule(1, child.Hide, child); -- Hides teh
							end                                         -- Annoying Icon!
						end
						child:EnableMouseWheel(1);
						child:SetScript("OnMouseWheel", ButtonholeAd_WheelWrapper);
						tinsert(ButtonholeAd_SwallowButtons, tmp);
						-- DEFAULT_CHAT_FRAME:AddMessage("The new is " .. name);
					end
				end
			end
		end 
		for _, v in ipairs(ButtonholeAd_SwallowButtons) do
			-- v.ModFrame.RegisterForClicks = function() end;
		end
		ButtonholeAd_UpdateMethodUI();
		ButtonholeAd_UpdatePosUI();
	end
end


--------------------------------------------------------------------------


ButtonholeAd_Classic_Num = 0;

function ButtonholeAd_Classic_Init()
	if not (ButtonholeAd_Method == 0) then
		return nil;
	end
	ButtonholeAd_Classic_Num = 0;
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		if (v.ModOriginalX == nil) or (v.ModOriginalY == nil) then
			v.ModFrame:Hide();
			if (i == ButtonholeAd_Classic_Num) then v.ModFrame:Show(); end
		else
			BHA_Debug("Classic : Jiggering frame " .. v.ModName);
			
			v.ModFrame.SetPoint = function() end;
			
			v.ModFrame:ClearAllPoints();
			
			-- BHA_Debug("Off : X: " .. v.ModOriginalX .. " Y: " .. v.ModOriginalY);
			v.ModFrame:SetParent(ButtonholeAd_Minimap);
			v.ModOriginalSetPoint(v.ModFrame, "TOPLEFT", 0, 0);
			v.ModFrame:SetParent(Minimap);
			v.ModFrame:Hide();
			if (i == ButtonholeAd_Classic_Num) then v.ModFrame:Show(); ButtonholeAd_Minimap:Hide(); end
		end
	end
end

function ButtonholeAd_Classic_Wheel(arg1)
	if not (ButtonholeAd_Method == 0) then
		return nil;
	end
	ButtonholeAd_Classic_Num = ButtonholeAd_Classic_Num + arg1;
	if (ButtonholeAd_Classic_Num == -1) then ButtonholeAd_Classic_Num = table.getn(ButtonholeAd_SwallowButtons); end
	if (ButtonholeAd_Classic_Num == table.getn(ButtonholeAd_SwallowButtons)+1) then ButtonholeAd_Classic_Num = 0; end
	if (ButtonholeAd_Classic_Num == 0) then
		BHA_Debug("Classic : Setting frame to Buttonhole");
	else
		BHA_Debug("Classic : Setting frame to " .. ButtonholeAd_SwallowButtons[ButtonholeAd_Classic_Num].ModFrame:GetName() );
	end
	
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		v.ModFrame:Hide();
		if (i == ButtonholeAd_Classic_Num) then v.ModFrame:Show(); end
	end
	
	if (ButtonholeAd_Classic_Num == 0) then
		ButtonholeAd_Minimap:Show();
	else
		local tmp = ButtonholeAd_SwallowButtons[ButtonholeAd_Classic_Num];
		if (tmp.ModOriginalX == nil) or (tmp.ModOriginalY == nil) then
			ButtonholeAd_Minimap:Show();
		else
			ButtonholeAd_Minimap:Hide();
		end
	end
end


--------------------------------------------------------------------------


function ButtonholeAd_Menu_Init()
	if not (ButtonholeAd_Method == 1) then
		return nil;
	end
end

function ButtonholeAd_Menu_Click()
	if not (ButtonholeAd_Method == 1) then
		return nil;
	end
	BHA_Debug("Menu : Clicked");
end


--------------------------------------------------------------------------


ButtonholeAd_Expander_State = 0;

function ButtonholeAd_Expander_Init()
	if not (ButtonholeAd_Method == 2) then
		return nil;
	end
	ButtonholeAd_Expander_State = 0;
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		BHA_Debug("Expander : Hiding frame " .. v.ModName);
		v.ModFrame:Hide();
	end
end

function ButtonholeAd_Expander_Click()
	if not (ButtonholeAd_Method == 2) then
		return nil;
	end
	
	if (ButtonholeAd_Expander_State == 0) then
		for i,v in ipairs(ButtonholeAd_SwallowButtons) do
			BHA_Debug("Expander : Showing frame " .. v.ModName);
			v.ModFrame:Show();
		end
		ButtonholeAd_Expander_State = 1;
	else
		for i,v in ipairs(ButtonholeAd_SwallowButtons) do
			BHA_Debug("Expander : Hiding frame " .. v.ModName);
			v.ModFrame:Hide();
		end
		ButtonholeAd_Expander_State = 0;
	end
	
	BHA_Debug("Expander : Toggled");
end


--------------------------------------------------------------------------


function ButtonholeAd_Off_Init()
	-- if not (ButtonholeAd_Method == 3) then
	--	return nil;
	-- end
	ButtonholeAd_Minimap:Show();
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		BHA_Debug("Off : Reshowing frame " .. v.ModName);
		
		v.ModFrame.SetPoint = v.ModOriginalSetPoint;
		
		if (v.ModOriginalX == nil) or (v.ModOriginalY == nil) then
			v.ModFrame:Show();
		else
			BHA_Debug("Off : X: " .. v.ModOriginalX .. " Y: " .. v.ModOriginalY .. " S: " .. v.ModOriginalS);
			v.ModFrame:ClearAllPoints();
			v.ModFrame:SetParent(UIParent);
			v.ModFrame:SetPoint("BOTTOMLEFT", "UIParent", v.ModOriginalX, v.ModOriginalY);
			v.ModFrame:SetParent(Minimap);
			v.ModFrame:Show();
		end
	end
end