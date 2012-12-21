tinsert(UISpecialFrames, "CT_BarModOptionsFrame");
CT_BarModOptions_Options = { };

function CT_BarModOptions_Slider_OnShow(slider)
	if ( not slider ) then
		slider = this;
	end
	if ( not CT_BarModOptions_Options[UnitName("player")] or not CT_BarModOptions_Options[UnitName("player")][slider:GetID()] ) then
		return;
	end
	local names = {
		"Left Hotbar Scaling",
		"Right Hotbar Scaling",
		"Left Sidebar Scaling",
		"Right Sidebar Scaling",
		"Top Hotbar Scaling",
		"Main Bar Scaling"
	};
	getglobal(slider:GetName().."High"):SetText("150%");
	getglobal(slider:GetName().."Low"):SetText("50%")
	getglobal(slider:GetName() .. "Text"):SetText(names[slider:GetID()] .. " - " .. floor(CT_BarModOptions_Options[UnitName("player")][slider:GetID()]*100+0.5) .. "%");

	slider:SetMinMaxValues(0.5, 1.5);
	slider:SetValueStep(0.01);
	slider:SetValue(CT_BarModOptions_Options[UnitName("player")][slider:GetID()]);
	
	if ( slider:GetID() == 6 ) then
		slider.tooltipText = "Requires Main Bar's texture to be hidden using CT_BottomBar in order to take effect.";
	end
	
	local prefix = "CT"..slider:GetID() .. "_";
	if ( slider:GetID() == 1 ) then
		prefix = "CT_"; -- First bar is prefixed CT and not CT1
	elseif ( slider:GetID() == 6 ) then
		if ( not CT_BottomBar_HiddenFrames or not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] or not CT_BottomBar_Enabled[UnitName("player")] ) then
			return;
		end
		prefix = ""; -- Main bar has no prefix
	end
	
	for i = 1, 12, 1 do
		getglobal(prefix .. "ActionButton" .. i):SetScale(CT_BarModOptions_Options[UnitName("player")][slider:GetID()]);
		if ( prefix == "" ) then
			getglobal("BonusActionButton" .. i):SetScale(CT_BarModOptions_Options[UnitName("player")][slider:GetID()]);
		end
	end
end

function CT_BarModOptions_Slider_OnValueChanged()
	local names = {
		"Left Hotbar Scaling",
		"Right Hotbar Scaling",
		"Left Sidebar Scaling",
		"Right Sidebar Scaling",
		"Top Hotbar Scaling",
		"Main Bar Scaling"
	};
	
	CT_BarModOptions_Options[UnitName("player")][this:GetID()] = floor(this:GetValue()*100+0.5)/100;
	getglobal(this:GetName() .. "Text"):SetText(names[this:GetID()] .. " - " .. floor(this:GetValue()*100+0.5) .. "%");
	
	local prefix = "CT"..this:GetID() .. "_";
	if ( this:GetID() == 1 ) then
		prefix = "CT_"; -- First bar is prefixed CT and not CT1
	elseif ( this:GetID() == 6 ) then
		if ( not CT_BottomBar_HiddenFrames or not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] or not CT_BottomBar_Enabled[UnitName("player")] ) then
			return;
		end
		prefix = ""; -- Main bar has no prefix
	end
	
	for i = 1, 12, 1 do
		getglobal(prefix .. "ActionButton" .. i):SetScale(CT_BarModOptions_Options[UnitName("player")][this:GetID()]);
		if ( prefix == "" ) then
			getglobal("BonusActionButton" .. i):SetScale(CT_BarModOptions_Options[UnitName("player")][this:GetID()]);
		end
	end
end

function CT_BarModOptions_LoadOptions()
	if ( not CT_BarModOptions_Options[UnitName("player")] ) then
		CT_BarModOptions_Options[UnitName("player")] = { 1, 1, 1, 1, 1, 1 };
		if ( CT_BottomBar_RotatedFrames and not CT_BottomBar_RotatedFrames[UnitName("player")] ) then
			CT_BottomBar_RotatedFrames[UnitName("player")] = {};
		end
		if ( CT_BottomBar_HiddenFrames and not CT_BottomBar_HiddenFrames[UnitName("player")] ) then
			CT_BottomBar_HiddenFrames[UnitName("player")] = {};
		end
	elseif ( getn(CT_BarModOptions_Options[UnitName("player")]) < 6 ) then
		for i = getn(CT_BarModOptions_Options[UnitName("player")])+1, 6, 1 do
			tinsert(CT_BarModOptions_Options[UnitName("player")], 1);
		end
	end
	CT_BarModOptions_Slider_OnShow(CT_BarModOptionsFrameScalingSliderHotbarLeft);
	CT_BarModOptions_Slider_OnShow(CT_BarModOptionsFrameScalingSliderHotbarRight);
	CT_BarModOptions_Slider_OnShow(CT_BarModOptionsFrameScalingSliderSidebarLeft);
	CT_BarModOptions_Slider_OnShow(CT_BarModOptionsFrameScalingSliderSidebarRight);
	CT_BarModOptions_Slider_OnShow(CT_BarModOptionsFrameScalingSliderHotbarTop);
	CT_BarModOptions_Slider_OnShow(CT_BarModOptionsFrameScalingSliderMainBar);
	CT_BarModOptions_RemoveSpaceBars(CT_BarModOptions_Options[UnitName("player")]["removeBars"]);
	CT_BarModOptions_RemoveSpaceBags(CT_BarModOptions_Options[UnitName("player")]["removeBags"]);
	CT_BarModOptions_RemoveSpaceSpecial(CT_BarModOptions_Options[UnitName("player")]["removeSpecial"]);
	CT_BarModOptionsFrameScalingCheckButtonBars:SetChecked(CT_BarModOptions_Options[UnitName("player")]["removeBars"]);
	CT_BarModOptionsFrameScalingCheckButtonBags:SetChecked(CT_BarModOptions_Options[UnitName("player")]["removeBags"]);
	CT_BarModOptionsFrameScalingCheckButtonSpecial:SetChecked(CT_BarModOptions_Options[UnitName("player")]["removeSpecial"]);
	
	for i = 1, 5, 1 do
		CT_BarModOptions_EnableBar(i, CT_BarModOptions_Options[UnitName("player")]["bar" .. i], 1);
	end
	CT_BarModOptions_SetOption(1, CT_BarModOptions_Options[UnitName("player")]["hidegrid"]);
	CT_BarModOptions_SetOption(2, CT_BarModOptions_Options[UnitName("player")]["buttonlock"]);
	CT_BarModOptions_SetOption(3, CT_BarModOptions_Options[UnitName("player")]["pagelock"]);
	CT_BarModOptions_SetButtons(CT_BarModOptions_Options[UnitName("player")]["leftbarbuttons"] or 3);
	CT_BarModOptions_SetButtons(CT_BarModOptions_Options[UnitName("player")]["rightbarbuttons"] or 6);
end

function CT_BarModOptions_RemoveSpaceBars(checked)
	if ( not CT_BarModOptions_Options[UnitName("player")] ) then
		CT_BarModOptions_Options[UnitName("player")] = { 1, 1, 1, 1, 1, 1 };
	end

	if ( CT_BottomBar_RotatedFrames and not CT_BottomBar_RotatedFrames[UnitName("player")] ) then
		CT_BottomBar_RotatedFrames[UnitName("player")] = { };
	end
	if ( CT_BottomBar_HiddenFrames and not CT_BottomBar_HiddenFrames[UnitName("player")] ) then
			CT_BottomBar_HiddenFrames[UnitName("player")] = { };
	end
	CT_BarModOptions_Options[UnitName("player")]["removeBars"] = checked;
	if ( not CT_BottomBar_Enabled ) then
		return;
	end
	local offset, mainOffset = 6, 6;
	if ( checked ) then
		offset = 3;
	end
	if ( checked and CT_BottomBar_HiddenFrames and ( CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] or CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] ) and CT_BottomBar_Enabled[UnitName("player")] ) then
		mainOffset = 3;
	end
	for i = 2, 12, 1 do
		for y = 1, 5, 1 do
			local prefix = "CT" .. y;
			if ( y == 1 ) then
				prefix = "CT";
			end
			if ( ( not CT_SidebarAxis and ( y ~= 3 and y ~= 4 ) ) or CT_SidebarAxis[y] == 2 ) then
				getglobal(prefix .. "_ActionButton" .. i):ClearAllPoints();
				getglobal(prefix .. "_ActionButton" .. i):SetPoint("LEFT", prefix .. "_ActionButton" .. i-1, "RIGHT", offset, 0);
			else
				getglobal(prefix .. "_ActionButton" .. i):ClearAllPoints();
				getglobal(prefix .. "_ActionButton" .. i):SetPoint("TOP", prefix .. "_ActionButton" .. i-1, "BOTTOM", 0, -offset);
			end
		end
		getglobal("ActionButton" .. i):ClearAllPoints();
		getglobal("BonusActionButton" .. i):ClearAllPoints();
		if ( CT_BottomBar_RotatedFrames and CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] and CT_BottomBar_Enabled[UnitName("player")] ) then
			getglobal("ActionButton" .. i):SetPoint("TOP", "ActionButton" .. i-1, "BOTTOM", 0, -mainOffset);
			getglobal("BonusActionButton" .. i):SetPoint("TOP", "BonusActionButton" .. i-1, "BOTTOM", 0, -mainOffset);
		elseif ( CT_BottomBar_HiddenFrames and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] and CT_BottomBar_Enabled[UnitName("player")] ) then
			getglobal("ActionButton" .. i):SetPoint("LEFT", "ActionButton" .. i-1, "RIGHT", mainOffset, 0);
			getglobal("BonusActionButton" .. i):SetPoint("LEFT", "BonusActionButton" .. i-1, "RIGHT", mainOffset, 0);
		else
			getglobal("ActionButton" .. i):SetPoint("LEFT", "ActionButton" .. i-1, "RIGHT", 6, 0);
			getglobal("BonusActionButton" .. i):SetPoint("LEFT", "BonusActionButton" .. i-1, "RIGHT", 6, 0);
		end
	end
end

function CT_BarModOptions_RemoveSpaceBags(checked)
	CT_BarModOptions_Options[UnitName("player")]["removeBags"] = checked;
	if ( not CT_BottomBar_Enabled or CT_BottomBar_HiddenFrames[UnitName("player")]["Bags"] ) then
		return;
	end
	local enabled;
	if ( ( CT_BottomBar_HiddenFrames[UnitName("player")]["BagsBackground"] or CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] ) and CT_BottomBar_Enabled[UnitName("player")] ) then
		enabled = 1;
		local offset = 5;
		if ( checked ) then
			offset = 2;
		end
		local tbl = {
			[0] = "MainMenuBarBackpackButton",
			"CharacterBag0Slot",
			"CharacterBag1Slot",
			"CharacterBag2Slot",
			"CharacterBag3Slot"
		};
		for i = 1, 4, 1 do
			getglobal(tbl[i]):ClearAllPoints();
			if ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] ) then
				getglobal(tbl[i]):SetPoint("TOP", tbl[i-1], "BOTTOM", 0, -offset);
			else
				getglobal(tbl[i]):SetPoint("RIGHT", tbl[i-1], "LEFT", -offset, 0);
			end
		end
	end
	if ( CT_BottomBar_Enabled[UnitName("player")] ) then
		if ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"]) then
			MainMenuBarBackpackButton:ClearAllPoints();
			MainMenuBarBackpackButton:SetPoint("TOPLEFT", "CT_BottomBarFrameBags", "TOPLEFT", 7, -4);
		elseif ( checked and enabled ) then
			MainMenuBarBackpackButton:ClearAllPoints();
			MainMenuBarBackpackButton:SetPoint("TOPRIGHT", "CT_BottomBarFrameBags", "TOPRIGHT", -24, -4);
		else
			MainMenuBarBackpackButton:ClearAllPoints();
			MainMenuBarBackpackButton:SetPoint("TOPRIGHT", "CT_BottomBarFrameBags", "TOPRIGHT", -8, -4);
		end
	else
		MainMenuBarBackpackButton:ClearAllPoints();
		MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", "MainMenuBarArtFrame", "BOTTOMRIGHT", -6, 2);
		local tbl = {
			[0] = "MainMenuBarBackpackButton",
			"CharacterBag0Slot",
			"CharacterBag1Slot",
			"CharacterBag2Slot",
			"CharacterBag3Slot"
		};
		for i = 1, 4, 1 do
			getglobal(tbl[i]):ClearAllPoints();
			getglobal(tbl[i]):SetPoint("RIGHT", tbl[i-1], "LEFT", -5, 0);
		end
	end
end

function CT_BarModOptions_RemoveSpaceSpecial(checked)
	CT_BarModOptions_Options[UnitName("player")]["removeSpecial"] = checked;
	if ( not CT_BottomBar_Enabled ) then
		return;
	end
	local offset, offsetss = 8, 6;
	if ( checked and CT_BottomBar_Enabled and CT_BottomBar_Enabled[UnitName("player")] ) then
		if ( CT_BABar_DragFrame_Orientation == "V" or CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"] ) then
			offsetss = 3;
		end
		if ( CT_PetBar_DragFrame_Orientation == "V" or CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"] ) then
			offset = 3;
		end
	end
	for i = 2, 10, 1 do
		getglobal("ShapeshiftButton" .. i):ClearAllPoints();
		if ( CT_BABar_DragFrame_Orientation and CT_BABar_DragFrame_Orientation == "V" ) then
			getglobal("ShapeshiftButton" .. i):SetPoint("TOP", "ShapeshiftButton" .. i-1, "BOTTOM", 0, -offsetss);
		else
			getglobal("ShapeshiftButton" .. i):SetPoint("LEFT", "ShapeshiftButton" .. i-1, "RIGHT", offsetss, 0);
		end
		getglobal("PetActionButton" .. i):ClearAllPoints();
		if ( CT_PetBar_DragFrame_Orientation and CT_PetBar_DragFrame_Orientation == "V" ) then
			getglobal("PetActionButton" .. i):SetPoint("TOP", "PetActionButton" .. i-1, "BOTTOM", 0, -offset);
		else
			getglobal("PetActionButton" .. i):SetPoint("LEFT", "PetActionButton" .. i-1, "RIGHT", offset, 0);
		end
	end
end

function CT_BarModOptions_OpenFrame()
	if ( CT_BarModOptionsFrame:IsVisible() ) then
		CT_BarModOptionsFrame:Hide();
	else
		CT_BarModOptionsFrame:Show();
	end
end
CT_RegisterMod("Bar Options", "Display Dialog", 2, "Interface\\Icons\\Ability_Rogue_Ambush", "Opens the Bar Options dialogs, where you\ncan modify various hotbar properties.", "switch", nil, CT_BarModOptions_OpenFrame);

function CT_BarModOptions_LoadButton()
	if ( this:GetID() <= 3 ) then
		getglobal(this:GetName() .. "Name"):SetText(3+(this:GetID()*3));
	else
		getglobal(this:GetName() .. "Name"):SetText(3+((this:GetID()-3)*3));
	end
end

function CT_BarModOptions_EnableBar(id, checked, isLoading)
	CT_BarModOptions_Options[UnitName("player")]["bar" .. id] = checked;
	local objs = { "LHBCB", "RHBCB", "LSBCB", "RSBCB", "THBCB" };
	local names = { "CT_HotbarLeft", "CT_HotbarRight", "CT_SidebarFrame", "CT_SidebarFrame2", "CT_HotbarTop" };
	local dragnames = { "CT_HotbarLeft_Drag", "CT_HotbarRight_Drag", "CT_SidebarLeft_Drag", "CT_SidebarRight_Drag", "CT_HotbarTop_Drag" };
	getglobal("CT_BarModOptionsFrameOptionsDisplay" .. objs[id]):SetChecked(checked);
	if ( checked ) then
		getglobal(names[id]):Show();
		if ( CT_MF_ShowFrames ) then
			getglobal(dragnames[id]):Show();
		end
		if ( id == 1 and isLoading ) then
			if ( not CT_BABar_Drag:IsUserPlaced() ) then
				CT_BABar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", -461, 128);
			end
			if ( not CT_PetBar_Drag:IsUserPlaced() ) then
				CT_PetBar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", -453, 122);
			end
		end
	else
		if ( id == 1 and not isLoading ) then
			CT_LeftHotbar_OnHide();
		end
		getglobal(names[id]):Hide();
	end
	if ( id == 1 and not isLoading and checked ) then
		local x = CT_PetBar_Drag:GetLeft()-(UIParent:GetRight()/2);
		local y = CT_PetBar_Drag:GetBottom()+40;
		CT_PetBar_Drag:ClearAllPoints();
		CT_PetBar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);
		x = CT_BABar_Drag:GetLeft()-(UIParent:GetRight()/2);
		y = CT_BABar_Drag:GetBottom()+40;
		CT_BABar_Drag:ClearAllPoints();
		CT_BABar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);
	elseif ( id == 1 and isLoading and not checked ) then
	elseif ( id == 4 ) then
		CT_Bag_Update();
	end
end

function CT_BarModOptions_SetButtons(id)
	if ( id <= 3 ) then
		for i = 1, 3, 1 do
			if ( i ~= id ) then
				getglobal("CT_BarModOptionsFrameOptionsLSB" .. i):SetChecked(false);
			else
				getglobal("CT_BarModOptionsFrameOptionsLSB" .. i):SetChecked(true);
			end
		end
		CT_LSidebar_Buttons = 3+(id*3); 
		for i=1, 12, 1 do
			if ( i > CT_LSidebar_Buttons ) then
				getglobal("CT3_ActionButton" .. i):Hide();
			else
				getglobal("CT3_ActionButton" .. i):Show();
			end
		end
		-- Left Sidebar
		CT_BarModOptions_Options[UnitName("player")]["leftbarbuttons"] = id;
	else
		for i = 1, 3, 1 do
			if ( i ~= (id-3) ) then
				getglobal("CT_BarModOptionsFrameOptionsRSB" .. i):SetChecked(false);
			else
				getglobal("CT_BarModOptionsFrameOptionsRSB" .. i):SetChecked(true);
			end
		end
		CT_RSidebar_Buttons = 3+((id-3)*3); 
		for i=1, 12, 1 do
			if ( i > CT_RSidebar_Buttons ) then
				getglobal("CT4_ActionButton" .. i):Hide();
			else
				getglobal("CT4_ActionButton" .. i):Show();
			end
		end
		-- Right Sidebar
		CT_BarModOptions_Options[UnitName("player")]["rightbarbuttons"] = id;
	end
end

function CT_BarModOptions_SetOption(id, checked)
	local objs = { "HideGridCB", "ButtonLockCB", "PageLockCB" };
	getglobal("CT_BarModOptionsFrameOptions" .. objs[id]):SetChecked(checked);
	if ( id == 1 ) then
		-- Hide Button Grid
		CT_BarModOptions_Options[UnitName("player")]["hidegrid"] = checked;
		CT_ShowGrid = not checked;
		if ( not checked ) then
			local bar1, bar2, bar3, bar4, bar5, bar6, bar7, bar8, bar9, bar10, bar11;
			for i=1, 12, 1 do
				bar1, bar2, bar3, bar4 = getglobal("MultiBarBottomLeftButton" .. i), getglobal("MultiBarBottomRightButton" .. i), getglobal("MultiBarLeftButton" .. i), getglobal("MultiBarRightButton" .. i);
				bar5, bar6, bar7, bar8 = getglobal("CT_ActionButton" .. i), getglobal("CT2_ActionButton" .. i), getglobal("CT5_ActionButton" .. i), getglobal("CT3_ActionButton" .. i);
				bar9, bar10, bar11 = getglobal("CT3_ActionButton" .. i), getglobal("ActionButton" .. i), getglobal("BonusActionButton" .. i);
				
				-- Set the showgrid variable
				bar1.showgrid = 3;
				bar2.showgrid = 3;
				bar3.showgrid = 3;
				bar4.showgrid = 3;
				bar5.showgrid = 3;
				bar6.showgrid = 3;
				bar7.showgrid = 3;
				bar8.showgrid = 3;
				bar9.showgrid = 3;
				bar10.showgrid = 3;
				bar11.showgrid = 3;
				
				-- Show the bars
				bar1:Show();
				bar2:Show();
				bar3:Show();
				bar4:Show();
				bar5:Show();
				bar6:Show();
				bar7:Show();
					-- Show these only if they're in use
				if ( CT_Sidebar_ButtonInUse(getglobal("CT3_ActionButton" .. i)) ) then
					bar8:Show();
				end
				if ( CT_Sidebar_ButtonInUse(getglobal("CT4_ActionButton" .. i)) ) then
					bar9:Show();
				end
				
				-- Show the appropriate main/bonus bar
				if ( not CT_BottomBar_Enabled or not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbar"] or not CT_BottomBar_Enabled[UnitName("player")] ) then
					if ( GetBonusBarOffset() > 0 ) then
						bar10:Hide();
						bar11:Show();
					else
						bar10:Show();
						bar11:Hide();
					end
				end
			end
		else
			for i=1, 12, 1 do
				CT_ActionButton_HideGrid(getglobal("ActionButton" .. i));
				CT_ActionButton_HideGrid(getglobal("BonusActionButton" .. i));
				CT_ActionButton_HideGrid(getglobal("MultiBarLeftButton" .. i));
				CT_ActionButton_HideGrid(getglobal("MultiBarRightButton" .. i));
				CT_ActionButton_HideGrid(getglobal("MultiBarBottomLeftButton" .. i));
				CT_ActionButton_HideGrid(getglobal("MultiBarBottomRightButton" .. i));
				CT_ActionButton_HideGrid(getglobal("CT_ActionButton" .. i));
				CT_ActionButton_HideGrid(getglobal("CT2_ActionButton" .. i));
				CT_ActionButton_HideGrid(getglobal("CT3_ActionButton" .. i));
				CT_ActionButton_HideGrid(getglobal("CT4_ActionButton" .. i));
				CT_ActionButton_HideGrid(getglobal("CT5_ActionButton" .. i));
			end
		end
	elseif ( id == 2 ) then
		-- Button Lock
		CT_HotbarButtons_Locked = checked;
		CT_BarModOptions_Options[UnitName("player")]["buttonlock"] = checked;
	elseif ( id == 3 ) then
		-- Page Lock
		CT_Hotbars_Locked = checked;
		CT_BarModOptions_Options[UnitName("player")]["pagelock"] = checked;
	end
end