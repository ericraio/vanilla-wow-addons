-- Reposition stuff
function CT_BottomBar_Enable()
	CT_BottomBarFrame:Show();
	CT_BottomBar_Enabled[UnitName("player")] = 1;
	-- Bags
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("TOPRIGHT", "CT_BottomBarFrameBags", "TOPRIGHT", -6, -4);
	
	-- Mini Buttons
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("TOPLEFT", "CT_BottomBarFrameMiniButtons", "TOPLEFT", 12, 17);
	
	-- Up & Down buttons
	ActionBarUpButton:ClearAllPoints();
	ActionBarDownButton:ClearAllPoints();
	ActionBarUpButton:SetPoint("TOPLEFT", "CT_BottomBarFrameBarUpDown", "TOPLEFT", -6, 4);
	ActionBarDownButton:SetPoint("TOPLEFT", "CT_BottomBarFrameBarUpDown", "TOPLEFT", -6, -15);
	
	-- Action bar
	ActionButton1:ClearAllPoints();
	ActionButton1:SetPoint("TOPLEFT", "CT_BottomBarFrameBar", "TOPLEFT", 7, -4);
	
	-- Bonus Action Bar
	BonusActionButton1:ClearAllPoints();
	BonusActionButton1:SetPoint("TOPLEFT", "CT_BottomBarFrameBar", "TOPLEFT", 7, -4);
	
	-- Latency
	MainMenuBarPerformanceBar:ClearAllPoints();
	MainMenuBarPerformanceBar:SetPoint("TOPRIGHT", "MainMenuBarPerformanceBarFrame", "TOPRIGHT", 0, 8)
	MainMenuBarPerformanceBarFrame:ClearAllPoints();
	MainMenuBarPerformanceBarFrame:SetHeight(45);
	MainMenuBarPerformanceBarFrame:SetPoint("TOPLEFT", "CT_BottomBarFrameLatency", "TOPLEFT", 10, 3);
	
	-- Action Bar Number
	MainMenuBarPageNumber:ClearAllPoints();
	MainMenuBarPageNumber:SetPoint("TOPLEFT", "CT_BottomBarFrameBarNumber", "TOPLEFT", 4, -16)
	
	-- Experience Bar
	MainMenuExpBar:ClearAllPoints();
	MainMenuExpBar:SetPoint("TOPLEFT", "CT_BottomBarFrameXP", "TOPLEFT", 0, -1);
	
	-- Main bar (Hide it)
	MainMenuBar:ClearAllPoints();
	MainMenuBar:SetPoint("TOP", "UIParent", "BOTTOM");
	
	for k, v in CT_BottomBar_HiddenFrames[UnitName("player")] do
		this = getglobal("CT_BottomBarFrame" .. k);
		if ( getglobal("CT_BottomBarFrame" .. k).GetScript ) then
			getglobal("CT_BottomBarFrame" .. k):GetScript("OnHide")();
		end
		getglobal("CT_BottomBarFrame" .. k):Hide();
	end
	
	-- Left Gryphon
	CT_BottomBarFrameGryphonsFrameLeft:ClearAllPoints();
	CT_BottomBarFrameGryphonsFrameLeft:SetPoint("BOTTOMRIGHT", "ActionButton1", "BOTTOMLEFT", 25, -5);
	
	-- Right Gryphon
	CT_BottomBarFrameGryphonsFrameRight:ClearAllPoints();
	CT_BottomBarFrameGryphonsFrameRight:SetPoint("BOTTOMLEFT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -26, -2);
	
	if ( CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] ) then
		CT_BottomBar_RotateMiniButtons(1);
	end
	if ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] ) then
		CT_BottomBar_RotateBars(1);
	end
	if ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] ) then
		CT_BottomBar_RotateBags(1);
	end
	if ( CT_BottomBar_HiddenFrames[UnitName("player")]["Bags"] ) then
		MainMenuBarBackpackButton:ClearAllPoints();
		MainMenuBarBackpackButton:SetPoint("TOP", "UIParent", "BOTTOM", 0, -100)
	end
	CT_BottomBar_HideBars(CT_BottomBar_HiddenFrames[UnitName("player")]["Class"]);
	CT_BottomBar_CheckLeftGryphon();
	CT_BottomBar_CheckRightGryphon();
end

function CT_BottomBar_Disable()
	CT_BottomBarFrame:Hide();
	
	CT_BottomBar_Enabled[UnitName("player")] = nil;
	
	-- Main bar (Show it)
	MainMenuBar:ClearAllPoints();
	MainMenuBar:SetPoint("BOTTOM", "UIParent", "BOTTOM");
	
	-- Bags
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
	
	-- Mini Buttons
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 552, 2);
	
	-- Up & Down buttons
	ActionBarUpButton:ClearAllPoints();
	ActionBarDownButton:ClearAllPoints();
	ActionBarUpButton:SetPoint("CENTER", "MainMenuBarArtFrame", "TOPLEFT", 522, -22);
	ActionBarDownButton:SetPoint("CENTER", "MainMenuBarArtFrame", "TOPLEFT", 522, -42);
	
	-- Action bar
	ActionButton1:ClearAllPoints();
	ActionButton1:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 8, 4);
	
	-- Bonus Action bar
	BonusActionButton1:ClearAllPoints();
	BonusActionButton1:SetPoint("BOTTOMLEFT", "BonusActionBarFrame", "BOTTOMLEFT", 5, 4);
	
	-- Experience Bar
	MainMenuExpBar:ClearAllPoints();
	MainMenuExpBar:SetPoint("TOP", "MainMenuBar", "TOP");
	
	-- Latency
	MainMenuBarPerformanceBarFrame:ClearAllPoints();
	MainMenuBarPerformanceBarFrame:SetPoint("BOTTOMRIGHT", "MainMenuExpBar", "BOTTOMRIGHT", -227, -50);
	MainMenuBarPerformanceBarFrame:SetHeight(64);
	MainMenuBarPerformanceBar:ClearAllPoints();
	MainMenuBarPerformanceBar:SetPoint("TOPRIGHT", "MainMenuBarPerformanceBarFrame", "TOPRIGHT");
	
	-- Action Bar Number
	MainMenuBarPageNumber:ClearAllPoints();
	MainMenuBarPageNumber:SetPoint("CENTER", "MainMenuBarArtFrame", "CENTER", 30, -5)

	-- Bonus Action Bar
	BonusActionBarFrame:ClearAllPoints();
	BonusActionBarFrame:SetPoint("TOPLEFT", "MainMenuBar", "BOTTOMLEFT", 40, 0);
	
	-- Left Gryphon
	MainMenuBarLeftEndCap:ClearAllPoints();
	MainMenuBarLeftEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", -544, 0);
	
	-- Right Gryphon
	MainMenuBarRightEndCap:ClearAllPoints();
	MainMenuBarRightEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", 544, 0);
	
	-- Shwo or hide pet texture
	if ( CT_BottomBar_HiddenFrames[UnitName("player")]["Class"] or CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"] ) then
		CT_BottomBar_HideTextures(1);
	else
		CT_BottomBar_HideTextures();
	end
	
	-- Show stuff that we might be hiding when it's enabled
	MainMenuBarBackpackButton:Show();
	CharacterBag0Slot:Show();
	CharacterBag1Slot:Show();
	CharacterBag2Slot:Show();
	CharacterBag3Slot:Show();
	
	CharacterMicroButton:Show();
	SpellbookMicroButton:Show();
	if ( UnitLevel("player") >= 10 ) then
		TalentMicroButton:Show();
	end
	QuestLogMicroButton:Show();
	SocialsMicroButton:Show();
	WorldMapMicroButton:Show();
	MainMenuMicroButton:Show();
	HelpMicroButton:Show();
	
	MainMenuBarPageNumber:Show();
	
	ActionBarUpButton:Show();
	ActionBarDownButton:Show();
	
	MainMenuBarPerformanceBarFrame:Show();
	MainMenuBarPerformanceBar:Show();
	
	MainMenuExpBar:Show();
	
	for i = 1, 12, 1 do
		getglobal("ActionButton" .. i):Show();
		getglobal("BonusActionButton" .. i):Show();
	end
	if ( GetBonusBarOffset() > 0 ) then
		BonusActionBarFrame.mode = "hide";
		BonusActionBarFrame.state = "bottom";
		ShowBonusActionBar();
	end
	for i = 2, 12, 1 do
		getglobal("ActionButton" .. i):ClearAllPoints();
		getglobal("ActionButton" .. i):SetPoint("LEFT", "ActionButton" .. i-1, "RIGHT", 6, 0);
		getglobal("BonusActionButton" .. i):ClearAllPoints();
		getglobal("BonusActionButton" .. i):SetPoint("LEFT", "BonusActionButton" .. i-1, "RIGHT", 6, 0);
	end
	tbl = {
		[0] = "CharacterMicroButton",
		"SpellbookMicroButton",
		"TalentMicroButton",
		"QuestLogMicroButton",
		"SocialsMicroButton",
		"WorldMapMicroButton",
		"MainMenuMicroButton",
		"HelpMicroButton"
	};
	for i = 1, 7, 1 do
		getglobal(tbl[i]):ClearAllPoints();
		getglobal(tbl[i]):SetPoint("LEFT", tbl[i-1], "RIGHT", -3, 0);
	end
	
	if ( CT_BottomBar_HiddenFrames[UnitName("player")]["Class"]  ) then
		CT_BottomBar_HideBars(1);
	else
		CT_BottomBar_HideBars();
	end
	
	CT_BottomBar_CheckLeftGryphon();
	CT_BottomBar_CheckRightGryphon();
	
end

CT_AddMovable("CT_BottomBarFrameXPDrag", "Experience Bar", "TOPLEFT", "TOPLEFT", "CT_BottomBarFrame", 14, 28, function(status)
	if ( status and ( not CT_BottomBar_HiddenFrames[UnitName("player")] or not CT_BottomBar_HiddenFrames[UnitName("player")]["XP"] ) ) then
		CT_BottomBarFrameXPDrag:Show()
	else
		CT_BottomBarFrameXPDrag:Hide();
	end
end);

CT_AddMovable("CT_BottomBarFrameBagsDrag", "Bags Bar", "TOPLEFT", "TOPLEFT", "CT_BottomBarFrame", 823, 18, function(status)
	if ( status and ( not CT_BottomBar_HiddenFrames[UnitName("player")] or not CT_BottomBar_HiddenFrames[UnitName("player")]["Bags"] ) ) then
		CT_BottomBarFrameBagsDrag:Show()
	else
		CT_BottomBarFrameBagsDrag:Hide();
	end
end, function()
	if ( CT_BottomBar_RotatedFrames[UnitName("player")] and CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] ) then
		CT_BottomBar_RotateBags();
	end
end);

CT_AddMovable("CT_BottomBarFrameMiniButtonsDrag", "Menu Buttons", "TOPLEFT", "TOPLEFT", "CT_BottomBarFrame", 566, 18, function(status)
	if ( status and ( not CT_BottomBar_HiddenFrames[UnitName("player")] or not CT_BottomBar_HiddenFrames[UnitName("player")]["MiniButtons"] ) ) then
		CT_BottomBarFrameMiniButtonsDrag:Show();
	else
		CT_BottomBarFrameMiniButtonsDrag:Hide();
	end
end, function()
	if ( CT_BottomBar_RotatedFrames[UnitName("player")] and CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] ) then
		CT_BottomBar_RotateMiniButtons();
	end
end);

CT_AddMovable("CT_BottomBarFrameLatencyDrag", "Latency Meter", "TOPLEFT", "TOPLEFT", "CT_BottomBarFrame", 784, 18, function(status)
	if ( status and ( not CT_BottomBar_HiddenFrames[UnitName("player")] or not CT_BottomBar_HiddenFrames[UnitName("player")]["Latency"] ) ) then
		CT_BottomBarFrameLatencyDrag:Show()
	else
		CT_BottomBarFrameLatencyDrag:Hide();
	end
end);

CT_AddMovable("CT_BottomBarFrameBarDrag", "Main Hotbar", "TOPLEFT", "TOPLEFT", "CT_BottomBarFrame", 23, 18, function(status)
	if ( status and ( not CT_BottomBar_HiddenFrames[UnitName("player")] or not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbar"] ) ) then
		CT_BottomBarFrameBarDrag:Show()
	else
		CT_BottomBarFrameBarDrag:Hide();
	end
end, function()
	if ( CT_BottomBar_RotatedFrames[UnitName("player")] and CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] ) then
		CT_BottomBar_RotateBars();
	end
end);

-- Globals
CT_BottomBar_EnableCBs = { };
CT_BottomBar_HiddenFrames = { };
CT_BottomBar_Enabled = { };
CT_BottomBar_RotatedFrames = { };

tinsert(UISpecialFrames, "CT_BottomBar_OptionsFrame");

function CT_BottomBar_RotateBags(force)
	if ( ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] and not force ) or ( force or 0 ) == -1 ) then
		CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] = nil;
		if ( not CT_BottomBar_HiddenFrames[UnitName("player")]["BagsBackground"] ) then
			CT_BottomBarFrameBagsBackground:Show();
		else
			CT_BottomBarFrameBagsBackground:Hide();
		end
		MainMenuBarBackpackButton:ClearAllPoints();
		MainMenuBarBackpackButton:SetPoint("TOPRIGHT", "CT_BottomBarFrameBags", "TOPRIGHT", -8, -4);
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
	else
		CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] = 1;
		CT_BottomBarFrameBagsBackground:Hide();
		MainMenuBarBackpackButton:ClearAllPoints();
		MainMenuBarBackpackButton:SetPoint("TOPLEFT", "CT_BottomBarFrameBags", "TOPLEFT", 7, -4);
		local tbl = {
			[0] = "MainMenuBarBackpackButton",
			"CharacterBag0Slot",
			"CharacterBag1Slot",
			"CharacterBag2Slot",
			"CharacterBag3Slot"
		};
		for i = 1, 4, 1 do
			getglobal(tbl[i]):ClearAllPoints();
			getglobal(tbl[i]):SetPoint("TOP", tbl[i-1], "BOTTOM", 0, -5);
		end
	end
	if ( CT_BarModOptions_RemoveSpaceBags ) then
		CT_BarModOptions_RemoveSpaceBags(CT_BarModOptions_Options[UnitName("player")]["removeBags"]);
	end
	CT_BottomBar_CheckLeftGryphon();
	CT_BottomBar_CheckRightGryphon();
end

function CT_BottomBar_RotateBars(force)
	if ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] and not force ) then
		CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] = nil;
		if ( not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] ) then
			CT_BottomBarFrameBarHotbarBackgroundLeft:Show();
			CT_BottomBarFrameBarHotbarBackgroundRight:Show();
			if ( CT_BarModOptions_Options ) then
				for i = 1, 12, 1 do
					getglobal("ActionButton" .. i):SetScale(UIParent:GetScale());
					getglobal("BonusActionButton" .. i):SetScale(UIParent:GetScale());
				end
			end
		end
		for i = 2, 12, 1 do
			getglobal("ActionButton" .. i):ClearAllPoints();
			getglobal("BonusActionButton" .. i):ClearAllPoints();
			if ( CT_BarModOptions_Options and CT_BarModOptions_Options[UnitName("player")]["removeBars"] and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"]  ) then
				getglobal("ActionButton" .. i):SetPoint("LEFT", "ActionButton" .. i-1, "RIGHT", 3, 0);
				getglobal("BonusActionButton" .. i):SetPoint("LEFT", "BonusActionButton" .. i-1, "RIGHT", 3, 0);
			else
				getglobal("ActionButton" .. i):SetPoint("LEFT", "ActionButton" .. i-1, "RIGHT", 6, 0);
				getglobal("BonusActionButton" .. i):SetPoint("LEFT", "BonusActionButton" .. i-1, "RIGHT", 6, 0);
			end
		end
	else
		CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] = 1;
		CT_BottomBarFrameBarHotbarBackgroundLeft:Hide();
		CT_BottomBarFrameBarHotbarBackgroundRight:Hide();
		for i = 2, 12, 1 do
			getglobal("ActionButton" .. i):ClearAllPoints();
			getglobal("BonusActionButton" .. i):ClearAllPoints();
			if ( CT_BarModOptions_Options and CT_BarModOptions_Options[UnitName("player")]["removeBars"] ) then
				getglobal("ActionButton" .. i):SetPoint("TOP", "ActionButton" .. i-1, "BOTTOM", 0, -3);
				getglobal("BonusActionButton" .. i):SetPoint("TOP", "BonusActionButton" .. i-1, "BOTTOM", 0, -3);
			else
				getglobal("ActionButton" .. i):SetPoint("TOP", "ActionButton" .. i-1, "BOTTOM", 0, -6);
				getglobal("BonusActionButton" .. i):SetPoint("TOP", "BonusActionButton" .. i-1, "BOTTOM", 0, -6);
			end
		end
		if ( CT_BarModOptions_Options ) then
			for i = 1, 12, 1 do
				getglobal("ActionButton" .. i):SetScale(CT_BarModOptions_Options[UnitName("player")][6]*UIParent:GetScale());
				getglobal("BonusActionButton" .. i):SetScale(CT_BarModOptions_Options[UnitName("player")][6]*UIParent:GetScale());
			end
		end
	end
	CT_updateActionButtons();
	CT_BottomBar_CheckLeftGryphon();
	CT_BottomBar_CheckRightGryphon();
end

CT_BottomBar_oldUpdateTalentButton = UpdateTalentButton;
function CT_BottomBar_newUpdateTalentButton()
	CT_BottomBar_oldUpdateTalentButton();
	if ( not CT_BottomBar_Enabled[UnitName("player")] ) then
		local tbl = {
			[0] = "CharacterMicroButton",
			"SpellbookMicroButton",
			"TalentMicroButton",
			"QuestLogMicroButton",
			"SocialsMicroButton",
			"WorldMapMicroButton",
			"MainMenuMicroButton",
			"HelpMicroButton"
		};
						
		for i = 1, 7, 1 do
			getglobal(tbl[i]):ClearAllPoints();
			getglobal(tbl[i]):SetPoint("LEFT", tbl[i-1], "RIGHT", -3, 0);
		end
	else
		if ( ( CT_BottomBar_Enabled[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")]["MiniButtons"] ) or UnitLevel("player") <= 10 ) then
			TalentMicroButton:Hide();
		end
		if ( CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] ) then
			CT_BottomBar_RotateMiniButtons(1);
		else
			CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] = 1;
			CT_BottomBar_RotateMiniButtons();
		end
	end
end
UpdateTalentButton = CT_BottomBar_newUpdateTalentButton;

function CT_BottomBar_RotateMiniButtons(force)
	if ( CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] and not force ) then
		CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] = nil;
		if ( not CT_BottomBar_HiddenFrames[UnitName("player")]["MiniButtonsBackgroundLeft"] ) then
			CT_BottomBarFrameMiniButtonsBackgroundLeft:Show();
			CT_BottomBarFrameMiniButtonsBackgroundRight:Show();
		end
		local tbl = {
			[0] = "CharacterMicroButton",
			"SpellbookMicroButton",
			"TalentMicroButton",
			"QuestLogMicroButton",
			"SocialsMicroButton",
			"WorldMapMicroButton",
			"MainMenuMicroButton",
			"HelpMicroButton"
		};
						
		for i = 1, 7, 1 do
			getglobal(tbl[i]):ClearAllPoints();
			getglobal(tbl[i]):SetPoint("LEFT", tbl[i-1], "RIGHT", -3, 0);
		end
	else
		CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] = 1;
		CT_BottomBarFrameMiniButtonsBackgroundLeft:Hide();
		CT_BottomBarFrameMiniButtonsBackgroundRight:Hide();
		local tbl = {
			[0] = "CharacterMicroButton",
			"SpellbookMicroButton",
			"TalentMicroButton",
			"QuestLogMicroButton",
			"SocialsMicroButton",
			"WorldMapMicroButton",
			"MainMenuMicroButton",
			"HelpMicroButton"
		};
						
		for i = 1, 7, 1 do
			getglobal(tbl[i]):ClearAllPoints();
			getglobal(tbl[i]):SetPoint("TOP", tbl[i-1], "BOTTOM", 0, 24);
		end
	end
	CT_BottomBar_CheckLeftGryphon();
	CT_BottomBar_CheckRightGryphon();
end

function CT_BottomBar_OptionsFrame_Hide(...)
	for i = 1, arg.n, 1 do
		-- Pretty big hack, but meh
		local oldThis = this;
		if ( this:GetChecked() ) then
			CT_BottomBar_HiddenFrames[UnitName("player")][arg[i]] = this:GetName();
			this = getglobal("CT_BottomBarFrame" .. arg[i]);
			if ( getglobal("CT_BottomBarFrame" .. arg[i]).GetScript ) then
				getglobal("CT_BottomBarFrame" .. arg[i]):GetScript("OnHide")();
			end
			getglobal("CT_BottomBarFrame" .. arg[i]):Hide();
		else
			CT_BottomBar_HiddenFrames[UnitName("player")][arg[i]] = nil;
			this = getglobal("CT_BottomBarFrame" .. arg[i]);
			if ( getglobal("CT_BottomBarFrame" .. arg[i]).GetScript ) then
				getglobal("CT_BottomBarFrame" .. arg[i]):GetScript("OnShow")();
			end
			getglobal("CT_BottomBarFrame" .. arg[i]):Show();
		end
		this = oldThis;
		if ( arg[i] == "BarHotbarBackgroundLeft" ) then
			for i = 1, 12, 1 do
				if ( this:GetChecked() and CT_BarModOptions_Options and CT_BarModOptions_Options[UnitName("player")] ) then
					getglobal("ActionButton" .. i):SetScale(( CT_BarModOptions_Options[UnitName("player")][6] or 1 )*UIParent:GetScale());
					getglobal("BonusActionButton" .. i):SetScale(( CT_BarModOptions_Options[UnitName("player")][6] or 1)*UIParent:GetScale());
				elseif ( not this:GetChecked() ) then
					getglobal("ActionButton" .. i):SetScale(UIParent:GetScale());
					getglobal("BonusActionButton" .. i):SetScale(UIParent:GetScale());
				end
				if ( i > 1 and CT_BarModOptions_Options and CT_BarModOptions_Options[UnitName("player")] ) then
					getglobal("ActionButton" .. i):ClearAllPoints();
					getglobal("BonusActionButton" .. i):ClearAllPoints();
					local offset = 6;
					if ( CT_BarModOptions_Options and CT_BarModOptions_Options[UnitName("player")]["removeBars"] ) then
						offset = 3;
					end
					if ( CT_BottomBar_RotatedFrames and CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] and CT_BottomBar_Enabled[UnitName("player")] ) then
						getglobal("ActionButton" .. i):SetPoint("TOP", "ActionButton" .. i-1, "BOTTOM", 0, -offset);
						getglobal("BonusActionButton" .. i):SetPoint("TOP", "BonusActionButton" .. i-1, "BOTTOM", 0, -offset);
					elseif ( CT_BottomBar_HiddenFrames and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] and CT_BottomBar_Enabled[UnitName("player")] ) then
						getglobal("ActionButton" .. i):SetPoint("LEFT", "ActionButton" .. i-1, "RIGHT", offset, 0);
						getglobal("BonusActionButton" .. i):SetPoint("LEFT", "BonusActionButton" .. i-1, "RIGHT", offset, 0);
					else
						getglobal("ActionButton" .. i):SetPoint("LEFT", "ActionButton" .. i-1, "RIGHT", 6, 0);
						getglobal("BonusActionButton" .. i):SetPoint("LEFT", "BonusActionButton" .. i-1, "RIGHT", 6, 0);
					end
				end
			end
		elseif ( arg[i] == "BarHotbarBackgroundRight" ) then
			CT_updateActionButtons();
			if ( not this:GetChecked() and CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] ) then
				getglobal("CT_BottomBarFrameBarHotbarBackgroundRight"):Hide();
				getglobal("CT_BottomBarFrameBarHotbarBackgroundLeft"):Hide();
			end
		elseif ( arg[i] == "BagsBackground" ) then
			if ( not this:GetChecked() and CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] ) then
				getglobal("CT_BottomBarFrame" .. arg[i]):Hide();
			end
			if ( CT_BarModOptions_RemoveSpaceBags ) then
				CT_BarModOptions_RemoveSpaceBags(CT_BarModOptions_Options[UnitName("player")]["removeBags"]);
			end
		elseif ( arg[i] == "MiniButtonsBackgroundRight" ) then
			if ( not this:GetChecked() and CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] ) then
				getglobal("CT_BottomBarFrameMiniButtonsBackgroundRight"):Hide();
				getglobal("CT_BottomBarFrameMiniButtonsBackgroundLeft"):Hide();
			end
		end
	end
	CT_BottomBar_CheckLeftGryphon();
	CT_BottomBar_CheckRightGryphon();
end

function CT_BottomBar_OptionsFrame_AddToEnableList()
	tinsert(CT_BottomBar_EnableCBs, this:GetName());
	this:Disable();
	getglobal(this:GetName() .. "Text"):SetTextColor(0.3, 0.3, 0.3);
end

function CT_BottomBar_OptionsFrame_EnableMod(enable)
	CT_BottomBar_OptionsFrameAllChecked:SetChecked(enable);
	for k, v in CT_BottomBar_EnableCBs do
		if ( enable ) then
			getglobal(v):Enable();
			getglobal(v .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal(v):Disable();
			getglobal(v .. "Text"):SetTextColor(0.3, 0.3, 0.3);
		end
	end
	
	if ( enable ) then
		CT_BottomBar_Enable();
	else
		CT_BottomBar_Disable();
	end
end

function CT_BottomBar_InitMod()
	if ( not CT_BottomBar_HiddenFrames[UnitName("player")] ) then
		CT_BottomBar_HiddenFrames[UnitName("player")] = { };
	else
		for k, v in CT_BottomBar_HiddenFrames[UnitName("player")] do
			getglobal(v):SetChecked(1);
		end
	end
	if ( not CT_BottomBar_RotatedFrames[UnitName("player")] ) then
		CT_BottomBar_RotatedFrames[UnitName("player")] = { };
	end
	
	if ( not CT_BottomBar_RotatedFrames[UnitName("player")] ) then
		CT_BottomBar_RotatedFrames[UnitName("player")] = { };
	else
		if ( CT_BottomBar_RotatedFrames[UnitName("player")]["MiniButtons"] ) then
			CT_BottomBar_RotateMiniButtons(1);
		end
		if ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] ) then
			CT_BottomBar_RotateBars(1);
		end
		if ( CT_BottomBar_RotatedFrames[UnitName("player")]["Bags"] ) then
			CT_BottomBar_RotateBags(1);
		end
	end
	CT_BottomBar_OptionsFrame_EnableMod(CT_BottomBar_Enabled[UnitName("player")]);
end
function CT_BottomBar_DisplayWindow()
	if ( CT_BottomBar_OptionsFrame:IsVisible() ) then
		HideUIPanel(CT_BottomBar_OptionsFrame);
	else
		ShowUIPanel(CT_BottomBar_OptionsFrame);
	end
end

SlashCmdList["BOTTOMBAR"] = CT_BottomBar_DisplayWindow;
SLASH_BOTTOMBAR1 = "/bottombar";
SLASH_BOTTOMBAR2 = "/bb";
CT_RegisterMod("Breakable Bottom Bar", "Open Options", 2, "Interface\\Icons\\Ability_Warrior_Sunder", "Displays the Breakable Bottom Bar options window.", "switch", "", CT_BottomBar_DisplayWindow);

function CT_BottomBar_CheckRightGryphon()
	if ( CT_BottomBar_HiddenFrames[UnitName("player")]["GryphonsFrameRight"] ) then
		CT_BottomBarFrameGryphonsFrameRight:Hide();
		MainMenuBarRightEndCap:Hide();
	else
		CT_BottomBarFrameGryphonsFrameRight:Show();
		if ( CT_BottomBar_Enabled[UnitName("player")] ) then
			MainMenuBarRightEndCap:Hide();
		else
			MainMenuBarRightEndCap:Show();
		end
	end
end

function CT_BottomBar_CheckLeftGryphon()
	if ( CT_BottomBar_HiddenFrames[UnitName("player")]["GryphonsFrameLeft"] ) then
		CT_BottomBarFrameGryphonsFrameLeft:Hide();
		MainMenuBarLeftEndCap:Hide();
	else
		CT_BottomBarFrameGryphonsFrameLeft:Show();
		if ( CT_BottomBar_Enabled[UnitName("player")] ) then
			MainMenuBarLeftEndCap:Hide();
		else
			MainMenuBarLeftEndCap:Show();
		end
	end
end

-- Hide pet/shapeshift/stance texture

CT_oldPetActionBar_UpdatePosition = PetActionBar_UpdatePosition;
function CT_newPetActionBar_UpdatePosition()
	CT_oldPetActionBar_UpdatePosition();
	CT_LinkFrameDrag(PetActionButton1, CT_PetBar_Drag, "TOPLEFT", "BOTTOMRIGHT", 2, 2);
	if ( CT_BottomBar_HiddenFrames[UnitName("player")]["Class"] or CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"] ) then
		CT_BottomBar_HideTextures(1);
	else
		CT_BottomBar_HideTextures();
	end
end
PetActionBar_UpdatePosition = CT_newPetActionBar_UpdatePosition;

CT_BarMod_HidePetBarTextures = 1;

function CT_BottomBar_HideTextures(hide)
	if ( hide ) then
		ShapeshiftBarLeft:ClearAllPoints();
		SlidingActionBarTexture0:ClearAllPoints();
		ShapeshiftBarLeft:SetPoint("TOPRIGHT", "UIParent", "TOPLEFT", -500, 0);
		SlidingActionBarTexture0:SetPoint("TOPRIGHT", "UIParent", "TOPLEFT", -500, 0); -- Hide
	else
		SlidingActionBarTexture0:ClearAllPoints();
		if ( CT_PetBar_DragFrame_Orientation == "H" ) then
			SlidingActionBarTexture0:SetPoint("BOTTOMLEFT", "PetActionButton1", "BOTTOMLEFT", -36, -3);
		else
			SlidingActionBarTexture0:SetPoint("TOPRIGHT", "UIParent", "TOPLEFT", -500, 0); -- Hide
		end
		ShapeshiftBarLeft:ClearAllPoints();
		if ( CT_BABar_DragFrame_Orientation == "H" ) then
			ShapeshiftBarLeft:SetPoint("BOTTOMLEFT", "ShapeshiftButton1", "BOTTOMLEFT", -14, -4);
		else
			ShapeshiftBarLeft:SetPoint("TOPRIGHT", "UIParent", "TOPLEFT", -500, 0);
		end
	end
end

CT_BottomBar_oldShapeshiftBar_Update = ShapeshiftBar_Update;
function CT_BottomBar_newShapeshiftBar_Update(hide)
	if ( hide ) then
		ShapeshiftBarFrame:Hide();
		CT_BABar_Drag:Hide();
	else
		CT_BottomBar_oldShapeshiftBar_Update();
	end
end
ShapeshiftBar_Update = CT_BottomBar_newShapeshiftBar_Update;

CT_BottomBar_oldShapeshiftBar_UpdatePosition = ShapeshiftBar_UpdatePosition;
function CT_BottomBar_newShapeshiftBar_UpdatePosition()
	if ( CT_BottomBar_Enabled[UnitName("player")] ) then
		BonusActionButton1:ClearAllPoints();
		BonusActionButton1:SetPoint("TOPLEFT", "CT_BottomBarFrameBar", "TOPLEFT", 7, -4);
		CT_BarModOptions_RemoveSpaceSpecial(CT_BarModOptions_Options[UnitName("player")]["removeSpecial"]);
	end
	if ( CT_BottomBar_HiddenFrames[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")]["Class"] ) then
		CT_BottomBar_HideTextures(1);
		if ( CT_BottomBar_HiddenFrames[UnitName("player")]["Class"] ) then
			CT_BABar_Drag:Hide();
			ShapeshiftBarFrame:Hide();
			CT_PetBar_Drag:Hide();
			PetActionBarFrame:Hide();
		end
	else
		if ( not CT_BottomBar_HiddenFrames[UnitName("player")] or not CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"] ) then
			CT_BottomBar_HideTextures(nil);
		else
			CT_BottomBar_HideTextures(1);
		end
		if ( CT_BottomBar_HiddenFrames[UnitName("player")]["Class"] ) then
			CT_BABar_Drag:Show();
			ShapeshiftBarFrame:Show();
			CT_PetBar_Drag:Show();
			PetActionBarFrame:Show();
		end
	end
end
ShapeshiftBar_UpdatePosition = CT_BottomBar_newShapeshiftBar_UpdatePosition;

function CT_BottomBar_HideBars(hide)
	if ( hide ) then
		CT_BABar_Drag:Hide();
		ShapeshiftBarFrame:Hide();
		CT_PetBar_Drag:Hide();
		PetActionBarFrame:Hide();
	else
		ShapeshiftBar_Update();
		if ( ShapeshiftBarFrame:IsVisible() and CT_MF_ShowFrames ) then
			CT_BABar_Drag:Show();
		else
			CT_BABar_Drag:Hide();
		end
		if ( PetHasActionBar() ) then
			PetActionBarFrame:Show();
			if ( CT_MF_ShowFrames ) then
				CT_PetBar_Drag:Show();
			else
				CT_PetBar_Drag:Hide();
			end
		else
			CT_PetBar_Drag:Hide();
		end
	end
end

CT_BottomBar_oldPetActionBar_Update = PetActionBar_Update;
function CT_BottomBar_newPetActionBar_Update()
	CT_BottomBar_oldPetActionBar_Update();
	if (  CT_BottomBar_HiddenFrames[UnitName("player")]["Class"] or CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"] ) then
		CT_BottomBar_HideTextures(1);
	else
		CT_BottomBar_HideTextures();
	end
	CT_BottomBar_HideBars(CT_BottomBar_HiddenFrames[UnitName("player")]["Class"]);
end
PetActionBar_Update = CT_BottomBar_newPetActionBar_Update;

CT_BottomBar_oldShowPetActionBar = ShowPetActionBar;
function CT_BottomBar_newShowPetActionBar()
	CT_BottomBar_oldShowPetActionBar();
	if (  CT_BottomBar_HiddenFrames[UnitName("player")]["Class"] or CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"] ) then
		CT_BottomBar_HideTextures(1);
	else
		CT_BottomBar_HideTextures();
	end
	CT_BottomBar_HideBars(CT_BottomBar_HiddenFrames[UnitName("player")]["Class"]);
end
ShowPetActionBar = CT_BottomBar_newShowPetActionBar;

CT_BottomBar_oldActionButton_Update = ActionButton_Update;
function CT_BottomBar_newActionButton_Update()
	CT_BottomBar_oldActionButton_Update();
	if ( CT_BottomBar_Enabled[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbar"] )then
		this:Hide();
	end
end
ActionButton_Update = CT_BottomBar_newActionButton_Update;

CT_BottomBar_oldReputationWatchBar_Update = ReputationWatchBar_Update;
function CT_BottomBar_newReputationWatchBar_Update(newLevel)
	if ( not CT_BottomBarFrameXP:IsShown() ) then
		ReputationWatchBar:Hide();
		return;
	elseif ( not newLevel ) then
		newLevel = UnitLevel("player");
	end
	CT_BottomBar_oldReputationWatchBar_Update(newLevel);
	ReputationWatchBar:ClearAllPoints();
	if ( newLevel < MAX_PLAYER_LEVEL ) then
		-- Display it above the main menu bar.
		ReputationWatchBar:SetPoint("TOP", "MainMenuExpBar", "TOP", 0, 10);
	else
		if ( ReputationWatchBar:IsShown() ) then
			CT_BottomBarFrameXPTextureFrame:Hide();
		else
			CT_BottomBarFrameXPTextureFrame:Show();
		end
		-- Display it on top of the main menu bar.
		ReputationWatchBar:SetPoint("TOP", "MainMenuExpBar", "TOP", 0, -1);
	end
end
ReputationWatchBar_Update = CT_BottomBar_newReputationWatchBar_Update;