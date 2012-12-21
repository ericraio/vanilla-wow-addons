--[[

	MonkeyQuest:
	Displays your quests for quick viewing.
	
	Website:	http://wow.visualization.ca/
	Author:		Trentin (monkeymods@gmail.com)
	
	
	Contributors:
	Celdor
		- Help with the Quest Log Freeze bug
		
	Diungo
		- Toggle grow direction
		
	Pkp
		- Color Quest Titles the same as the quest level
	
	wowpendium.de
		- German translation
		
	MarsMod
		- Valid player name before the VARIABLES_LOADED event bug
		- Settings resetting bug
        
	Dunewarrior
		- Tooltip update for WoW 1.7.0
		
	Global
		- PvP Quests

--]]

-- script variables not saved
MonkeyQuest = {};
MonkeyQuest.m_bLoaded = false;				-- true when the config variables are loaded
MonkeyQuest.m_bVariablesLoaded = false;
MonkeyQuest.m_iNumQuestButtons = 40;		-- 40 is the max possible entries in the quest log (20 quests and 20 different locations)
MonkeyQuest.m_iMaxTextWidth = 229;			-- wraps the text if it gets too long, mostly needed for objectives
MonkeyQuest.m_strPlayer = "";
MonkeyQuest.m_aQuestList = {};
MonkeyQuest.m_aQuestItemList = {};
MonkeyQuest.m_bGotQuestLogUpdate = false;
MonkeyQuest.m_bNeedRefresh = false;
MonkeyQuest.m_fTimeSinceRefresh = 0.0;
MonkeyQuest.m_bCleanQuestList = true;	-- used to clean up the hidden list on the first questlog update event

MonkeyQuest.m_colourBorder = { r = TOOLTIP_DEFAULT_COLOR.r, g = TOOLTIP_DEFAULT_COLOR.g, b = TOOLTIP_DEFAULT_COLOR.b };



function MonkeyQuest_OnLoad()
    
    -- register events
    this:RegisterEvent('VARIABLES_LOADED');
    this:RegisterEvent('QUEST_LOG_UPDATE');			-- used to know when to refresh the MonkeyQuest text
    this:RegisterEvent('UNIT_NAME_UPDATE');			-- this is the event I use to get per character config settings
    this:RegisterEvent('PLAYER_ENTERING_WORLD');	-- this event gives me a good character name in situations where 'UNIT_NAME_UPDATE' doesn't even trigger
    this:RegisterEvent('PLAYER_LEVEL_UP');			-- when you level up the difficulty of some quests may change

	-- events when zone changes to update the zone highlighting quests
    this:RegisterEvent('ZONE_CHANGED');
	this:RegisterEvent('ZONE_CHANGED_INDOORS');
	this:RegisterEvent('ZONE_CHANGED_NEW_AREA');
    
    
    -- initialize the border and backdrop of the main frame
    --this:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
    --this:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 0);
    
    -- setup the title of the main frame
    MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE);
    MonkeyQuestTitleText:SetTextColor(MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b);
    MonkeyQuestTitleText:Show();
    
    MonkeyQuestSlash_Init();

    -- overide af tooltip functions
	MonkeyQuest_OLD_aftt_setName = aftt_setName;
	aftt_setName = MonkeyQuest_NEW_aftt_setName;
    
    -- this will catch mobs needed for quests
	this:RegisterEvent('UPDATE_MOUSEOVER_UNIT');
    
    -- this should catch items when you're going to sell them
	MonkeyQuest_OLD_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
    ContainerFrameItemButton_OnEnter = MonkeyQuest_NEW_ContainerFrameItemButton_OnEnter;

end

function MonkeyQuest_OnUpdate(arg1)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	-- need to make sure we don't read from the quest list before a QUEST_LOG_UPDATE or we'll get the previous character's data
	if (MonkeyQuest.m_bGotQuestLogUpdate == false) then
		return;
	end

	-- update the timer
	MonkeyQuest.m_fTimeSinceRefresh = MonkeyQuest.m_fTimeSinceRefresh + arg1;
	
	-- if it's been more than MONKEYQUEST_DELAY seconds and we need to process a dropped QUEST_LOG_UPDATE
	if (MonkeyQuest.m_fTimeSinceRefresh > MONKEYQUEST_DELAY and MonkeyQuest.m_bNeedRefresh == true) then
		MonkeyQuest_Refresh();
	end
	
	if (MonkeyQuest.m_bCleanQuestList == true) then
		if (MonkeyQuest.m_fTimeSinceRefresh > 15.0) then
			MonkeyQuestInit_CleanQuestList();
			MonkeyQuest.m_bCleanQuestList = false;
		end
	end
end

function MonkeyQuest_OnQuestLogUpdate()
	
	-- if everything's been loaded, refresh the Quest Monkey Display
	if (MonkeyQuest.m_bLoaded == true) then
		if (MonkeyQuest.m_bNeedRefresh == true) then
			-- don't process, let the OnUpdate catch it, but reset the timer
			MonkeyQuest.m_fTimeSinceRefresh = 0.0;
		else
			MonkeyQuest.m_bNeedRefresh = true;
			MonkeyQuest.m_fTimeSinceRefresh = 0.0;
		end
	end
end

-- OnEvent Function
function MonkeyQuest_OnEvent(event)

    if (event == 'VARIABLES_LOADED') then
        -- this event gets called when the variables are loaded
        -- there's a possible situation where the other events might get a valid
        -- player name BEFORE this event, which resets your config settings :(
        
        MonkeyQuest.m_bVariablesLoaded = true;
        
        -- double check that the mod isn't already loaded
        if (not MonkeyQuest.m_bLoaded) then
        
            MonkeyQuest.m_strPlayer = UnitName('player');
            
            -- if MonkeyQuest.m_strPlayer is UNKNOWNOBJECT get out, need a real name
            if (MonkeyQuest.m_strPlayer ~= nil and MonkeyQuest.m_strPlayer ~= UNKNOWNOBJECT) then
                -- should have a valid player name here
                MonkeyQuestInit_LoadConfig();
            end
        end
        
        -- exit this event
        return;
    
    end -- VARIABLES_LOADED

    if (event == 'UNIT_NAME_UPDATE') then
        -- this event gets called whenever a unit's name changes (supposedly)
        -- Note: Sometimes it gets called when unit's name gets set to
        -- UNKNOWNOBJECT
        
        -- double check that the mod isn't already loaded
        if (not MonkeyQuest.m_bLoaded) then
            -- this is the first place I know that reliably gets the player name
            MonkeyQuest.m_strPlayer = UnitName('player');
            
            -- if MonkeyQuest.m_strPlayer is UNKNOWNOBJECT get out, need a real name
            if (MonkeyQuest.m_strPlayer ~= nil and MonkeyQuest.m_strPlayer ~= UNKNOWNOBJECT) then
                -- should have a valid player name here
                MonkeyQuestInit_LoadConfig();
            end
        end
        
        -- exit this event
        return;
    
    end -- UNIT_NAME_UPDATE

    if (event == 'PLAYER_ENTERING_WORLD') then
        -- this event gets called when the player enters the world
        -- Note: on initial login this event will not give a good player name
        
        -- double check that the mod isn't already loaded
        if (not MonkeyQuest.m_bLoaded) then
        
            MonkeyQuest.m_strPlayer = UnitName('player');

            -- if MonkeyQuest.m_strPlayer is UNKNOWNOBJECT get out, need a real name
            if (MonkeyQuest.m_strPlayer ~= nil and MonkeyQuest.m_strPlayer ~= UNKNOWNOBJECT) then
                -- should have a valid player name here
                MonkeyQuestInit_LoadConfig();
            end
        end
        
        -- exit this event
        return;
    
    end -- PLAYER_ENTERING_WORLD

    if (event == 'QUEST_LOG_UPDATE') then
        MonkeyQuest.m_bGotQuestLogUpdate = true;
        MonkeyQuest_OnQuestLogUpdate();
        return;
    end -- QUEST_LOG_UPDATE

	if (event == 'ZONE_CHANGED' or event == 'ZONE_CHANGED_INDOORS' or event == 'ZONE_CHANGED_NEW_AREA') then
		MonkeyQuest_Refresh();
	end -- ZONE_CHANGED
	
	if (event == 'PLAYER_LEVEL_UP') then
		MonkeyQuest_Refresh();
	end -- PLAYER_LEVEL_UP
    
    if (event == 'TOOLTIP_ANCHOR_DEFAULT') then
    
        if (MonkeyQuest_SearchTooltip() == true) then
            GameTooltip:AddLine(MONKEYQUEST_TOOLTIP_QUESTITEM, MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b, 1);
            GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
        end
    end -- TOOLTIP_ANCHOR_DEFAULT

    if (event == 'UPDATE_MOUSEOVER_UNIT') then
        -- check if this is a quest item
        MonkeyQuest_SearchTooltip();
    end -- UPDATE_MOUSEOVER_UNIT
end

-- this function is called when the frame should be dragged around
function MonkeyQuest_OnMouseDown(arg1)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end
	
	-- left button moves the frame around
	if (arg1 == "LeftButton" and MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLocked == false) then
		MonkeyQuestFrame:StartMoving();
	end
	
	-- right button on the title or frame opens up the MonkeyBuddy, if it's there
	if (arg1 == "RightButton" and MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bAllowRightClick == true) then
		if (MonkeyBuddyFrame ~= nil) then
			ShowUIPanel(MonkeyBuddyFrame);
			
			-- make MonkeyBuddy show the MonkeyQuest config
			MonkeyBuddyQuestTab_OnClick();
		end
	end
end

-- this function is called when the frame is stopped being dragged around
function MonkeyQuest_OnMouseUp(arg1)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end
	
	if (arg1 == "LeftButton") then
		MonkeyQuestFrame:StopMovingOrSizing();
		
		-- save the position
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft = MonkeyQuestFrame:GetLeft();
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameTop = MonkeyQuestFrame:GetTop();
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameBottom = MonkeyQuestFrame:GetBottom();
	end
end

function MonkeyQuest_OnEnter()

	-- BIB support
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB == true) then
		MonkeyQuestFrame:Show();
	end
end

function MonkeyQuest_OnLeave()
	
	-- BIB support
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB == true) then
		MonkeyQuest_Hide();
	end
end

function MonkeyQuestCloseButton_OnClick()

	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuest_Hide();
end

function MonkeyQuestCloseButton_OnEnter()
	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNoobTips == false) then
		return;
	end

	-- put the tool tip in the default position
	GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_CLOSE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_HELP_OPEN_MSG, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);


	GameTooltip:Show();
end

function MonkeyQuestMinimizeButton_OnClick()

	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bMinimized = not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bMinimized;
	
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bMinimized == true) then
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Down");
	else
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Up");
	end
	
	MonkeyQuest_Refresh();
end

function MonkeyQuestMinimizeButton_OnEnter()
	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNoobTips == false) then
		return;
	end

	-- put the tool tip in the default position
	GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bMinimized) then
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_RESTORE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	else
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_MINIMIZE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end

	GameTooltip:Show();
end

function MonkeyQuestShowHiddenCheckButton_OnClick()

	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (this:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden = true;
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden = false;
	end

	MonkeyQuest_Refresh();
end

function MonkeyQuestShowHiddenCheckButton_OnEnter()

	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNoobTips == false) then
		return;
	end

	-- put the tool tip in the default position
	GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	if (this:GetChecked()) then
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	else
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	end

	GameTooltip:Show();
end

function MonkeyQuest_Show()

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bDisplay = true;
	MonkeyQuestFrame:Show();
	MonkeyQuest_Refresh();
end

function MonkeyQuest_Hide()

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bDisplay = false;
	MonkeyQuestFrame:Hide();
end

function MonkeyQuest_SetAlpha(iAlpha)

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iAlpha = iAlpha;
	MonkeyQuestFrame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, iAlpha);

	--MonkeyQuestFrame:SetAlpha(0.5);
end

function MonkeyQuest_SetFrameAlpha(iAlpha)

	MonkeyQuestFrame:SetAlpha(iAlpha);
end

function MonkeyQuest_Refresh()

	-- if not loaded yet, get outta here
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end
	
	-- BIB bad options check
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB == true) then
		if (BIB_MonkeyQuestButton ~= nil) then
			if (not BIB_MonkeyQuestButton:IsShown()) then
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB = false;
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_TOPLEFT";
				MonkeyQuest_Show();
			end
		else
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB = false;
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_TOPLEFT";
			MonkeyQuest_Show();
		end
	end
	
	-- set the check state of the MonkeyQuestShowHiddenCheckButton
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden == true) then
		MonkeyQuestShowHiddenCheckButton:SetChecked(1);
	else
		MonkeyQuestShowHiddenCheckButton:SetChecked(0);
	end
	
	-- make sure the minimize button has the right texture
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bMinimized == true) then
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Down");
	else
		MonkeyQuestMinimizeButton:SetNormalTexture("Interface\\AddOns\\MonkeyLibrary\\Textures\\MinimizeButton-Up");
	end
	
	local strMonkeyQuestBody = "";
	local colour;
	local strTitleColor;
	local iButtonId = 1;
	local bNextHeader = false;
	
	-- Remember the currently selected quest log entry
	local tmpQuestLogSelection = GetQuestLogSelection();

	local iNumEntries, iNumQuests = GetNumQuestLogEntries();

	MonkeyQuestTitleText:SetTextHeight(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFontHeight + 2);
	-- set the title, with or without the number of quests
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNumQuests == true) then
		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideTitle == false) then
			MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE .. " " .. iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS);
		else
			MonkeyQuestTitleText:SetText(iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS);
		end
	elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideTitle == false) then
		MonkeyQuestTitleText:SetText(MONKEYQUEST_TITLE);
	else
		MonkeyQuestTitleText:SetText("");
	end
	
	-- update the BIB text
	if (BIB_MonkeyQuestButton_GetButtonText) then
		BIB_MonkeyQuestButton_GetButtonText();
	end


	MonkeyQuest.m_iNumEntries = iNumEntries;

	-- hide all the text buttons
	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		getglobal("MonkeyQuestButton" .. i .. "Text"):SetText("");
		getglobal("MonkeyQuestButton" .. i .. "Text"):Hide();
		getglobal("MonkeyQuestButton" .. i):Hide();
		getglobal("MonkeyQuestHideButton" .. i):Hide();
		getglobal("MonkeyQuestButton" .. i .. "Text"):SetWidth(MonkeyQuestFrame:GetWidth() - MONKEYQUEST_PADDING - 8);
		getglobal("MonkeyQuestButton" .. i .. "Text"):SetTextHeight(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFontHeight);
	end


	MonkeyQuest_RefreshQuestItemList();


	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bMinimized == false) then

		for i = 1, iNumEntries, 1 do
			-- strQuestLogTitleText		the title text of the quest, may be a header (ex. Wetlands)
			-- strQuestLevel			the level of the quest
			-- strQuestTag				the tag on the quest (ex. COMPLETED)
			local strQuestLogTitleText, strQuestLevel, strQuestTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);

			-- are we looking for the next header?
			if (bNextHeader == true and isHeader) then
				-- no longer skipping quests
				bNextHeader = false;
			end
			
			if (bNextHeader == false) then
				-- no longer looking for the next header
				-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
				SelectQuestLogEntry(i);
				
				-- double check this quest is in the hidden list, if not, it's a new quest
				if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText] == nil) then
					MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText] = {};
					MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText].m_bChecked = true;
				end
					
				if (isHeader) then
					
					if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText].m_bChecked == true) then
						if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoHeaders == false or
							MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden == true or
							MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bAlwaysHeaders == true) then

							strMonkeyQuestBody = strMonkeyQuestBody .. 
								format(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strHeaderOpenColour .. "%s|r",
									"- " .. strQuestLogTitleText) .. "\n";
								
							getglobal("MonkeyQuestButton" .. iButtonId .. "Text"):SetText(strMonkeyQuestBody);
							getglobal("MonkeyQuestButton" .. iButtonId .. "Text"):Show();
							getglobal("MonkeyQuestButton" .. iButtonId):Show();

							-- set the bg colour
							getglobal("MonkeyQuestButton" .. iButtonId .. "Texture"):SetVertexColor(0.0, 0.0, 0.0, 0.0);
			
							getglobal("MonkeyQuestButton" .. iButtonId).m_iQuestIndex = i;
							getglobal("MonkeyQuestButton" .. iButtonId).id = iButtonId;
			
							getglobal("MonkeyQuestHideButton" .. iButtonId):Hide();
							getglobal("MonkeyQuestHideButton" .. iButtonId).m_strQuestLogTitleText = strQuestLogTitleText;
							
							iButtonId = iButtonId + 1;
			
							strMonkeyQuestBody = "";
						end
					else
						if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden == true or
							MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bAlwaysHeaders == true) then

							strMonkeyQuestBody = strMonkeyQuestBody .. 
								format(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strHeaderClosedColour .. "%s|r",
									"+ " .. strQuestLogTitleText) .. "\n";
								
							getglobal("MonkeyQuestButton" .. iButtonId .. "Text"):SetText(strMonkeyQuestBody);
							getglobal("MonkeyQuestButton" .. iButtonId .. "Text"):Show();
							getglobal("MonkeyQuestButton" .. iButtonId):Show();

							-- set the bg colour
							getglobal("MonkeyQuestButton" .. iButtonId .. "Texture"):SetVertexColor(0.0, 0.0, 0.0, 0.0);
			
							getglobal("MonkeyQuestButton" .. iButtonId).m_iQuestIndex = i;
							getglobal("MonkeyQuestButton" .. iButtonId).id = iButtonId;
							
							getglobal("MonkeyQuestHideButton" .. iButtonId):Hide();
							getglobal("MonkeyQuestHideButton" .. iButtonId).m_strQuestLogTitleText = strQuestLogTitleText;
			
							iButtonId = iButtonId + 1;
			
							strMonkeyQuestBody = "";
						end
						-- keep looping through the list until we find the next header
						bNextHeader = true;
					end
				else
					-- check if the user even wants this displayed
					if ((MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText].m_bChecked == true or 
						MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden) and 
						(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideCompletedQuests == false or
						(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideCompletedQuests == true and not isComplete) or
						MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden)) then
						
						-- the user has this quest checked off or he's showing all quests anyways, so we show it
						getglobal("MonkeyQuestHideButton" .. iButtonId):Show();
						
						-- update hide quests buttons
						if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[strQuestLogTitleText].m_bChecked == true) then
							getglobal("MonkeyQuestHideButton" .. iButtonId):SetChecked(1);
						else
							getglobal("MonkeyQuestHideButton" .. iButtonId):SetChecked(0);
						end
						
						getglobal("MonkeyQuestHideButton" .. iButtonId).m_strQuestLogTitleText = strQuestLogTitleText;
						


						colour = GetDifficultyColor(strQuestLevel);

						-- Begin Pkp Changes
						if(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bColourTitle) then
							strTitleColor = format("|c%02X%02X%02X%02X", 255, colour.r * 255, colour.g * 255, colour.b * 255);
						else
							strTitleColor = MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strQuestTitleColour;
						end
						
						-- padding
						strMonkeyQuestBody = strMonkeyQuestBody .. "  ";

						-- check if the user wants the quest levels
						if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowQuestLevel == true) then
	
							if (strQuestTag == ELITE) then
								strMonkeyQuestBody = strMonkeyQuestBody .. 
									format("|c%02X%02X%02X%02X%s|r", 255, colour.r * 255, colour.g * 255, colour.b * 255, 
										"[" .. strQuestLevel .. "+] ");

							elseif (strQuestTag == MONKEYQUEST_DUNGEON) then
								strMonkeyQuestBody = strMonkeyQuestBody ..
									format("|c%02X%02X%02X%02X%s|r", 255, colour.r * 255, colour.g * 255, colour.b * 255,
										"[" .. strQuestLevel .. "d] ");

							elseif (strQuestTag == RAID) then
								strMonkeyQuestBody = strMonkeyQuestBody ..
									format("|c%02X%02X%02X%02X%s|r", 255, colour.r * 255, colour.g * 255, colour.b * 255,
										"[" .. strQuestLevel .. "r] ");

							elseif (strQuestTag == MONKEYQUEST_PVP) then
								strMonkeyQuestBody = strMonkeyQuestBody ..
									format("|c%02X%02X%02X%02X%s|r", 255, colour.r * 255, colour.g * 255, colour.b * 255,
										"[" .. strQuestLevel .. "p] ");
							else
								strMonkeyQuestBody = strMonkeyQuestBody ..
									format("|c%02X%02X%02X%02X%s|r", 255, colour.r * 255, colour.g * 255, colour.b * 255,
										"[" .. strQuestLevel .. "] ");
							end
						end

						-- add the completed tag, if needed
						if (isComplete and isComplete < 0) then
							strMonkeyQuestBody = strMonkeyQuestBody .. 
								format(strTitleColor .. "%s|r", strQuestLogTitleText) ..
								" (" .. MONKEYQUEST_QUEST_FAILED .. ")\n";
						elseif (isComplete and isComplete > 0) then
							strMonkeyQuestBody = strMonkeyQuestBody ..
								format(strTitleColor .. "%s|r", strQuestLogTitleText) ..
								" (" .. MONKEYQUEST_QUEST_DONE .. ")\n";
						else
							strMonkeyQuestBody = strMonkeyQuestBody ..
								format(strTitleColor .. "%s|r", strQuestLogTitleText) .. "\n";
						end
						

						local strQuestDescription, strQuestObjectives = GetQuestLogQuestText();
		
						if (GetNumQuestLeaderBoards() > 0) then
							for ii=1, GetNumQuestLeaderBoards(), 1 do
								--local string = getglobal("QuestLogObjective"..ii);
								local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(ii);
								
								MonkeyQuest_AddQuestItemToList(strLeaderBoardText);
								
								if (strLeaderBoardText) then
									if (not iFinished) then
										strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. MonkeyQuest_GetLeaderboardColorStr(strLeaderBoardText) .. 
											strLeaderBoardText .. "\n";
									elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideCompletedObjectives == false
										or MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden) then
										strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. 
											MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strCompleteObjectiveColour .. 
											strLeaderBoardText .. "\n";
									end
								end
							end
						elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bObjectives) then
							-- this quest has no leaderboard so display the objective instead if the config is set
			
							strMonkeyQuestBody = strMonkeyQuestBody .. "    " .. 
								format(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strOverviewColour .. "%s|r",
									strQuestObjectives) .. "\n";
								--format("|c%02X%02X%02X%02X%s|r", 255, GRAY_FONT_COLOR.r * 255, GRAY_FONT_COLOR.g * 255, 
								--GRAY_FONT_COLOR.b * 255, strQuestObjectives) .. "\n";
						end
			
						-- finally set the text
						getglobal("MonkeyQuestButton" .. iButtonId .. "Text"):SetText(strMonkeyQuestBody);
						getglobal("MonkeyQuestButton" .. iButtonId .. "Text"):Show();
						getglobal("MonkeyQuestButton" .. iButtonId):Show();

						-- set the bg colour
						getglobal("MonkeyQuestButton" .. iButtonId .. "Texture"):SetVertexColor(0.0, 0.0, 0.0, 0.0);

						if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowZoneHighlight) then
							local strSubZoneText = string.lower(GetSubZoneText());
	
							if (strSubZoneText ~= "") then
								if (string.find(string.lower(strQuestDescription), strSubZoneText, 1, true) or 
									string.find(string.lower(strQuestObjectives), strSubZoneText, 1, true)) then
	
									local a, r, g, b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strZoneHighlightColour);
	
									getglobal("MonkeyQuestButton" .. iButtonId .. "Texture"):SetVertexColor(r, g, b, MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iAlpha);
								end
							end
						end

			
						getglobal("MonkeyQuestButton" .. iButtonId).m_iQuestIndex = i;
						getglobal("MonkeyQuestButton" .. iButtonId).m_strQuestObjectives = strQuestObjectives;
			
						iButtonId = iButtonId + 1;
			
						strMonkeyQuestBody = "";
					end
				end
			end
		end
	end

	
	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		getglobal("MonkeyQuestButton" .. i .. "Text"):SetWidth(MonkeyQuestFrame:GetWidth() - MONKEYQUEST_PADDING - 8);
	end
	
	-- Restore the current quest log selection
	SelectQuestLogEntry(tmpQuestLogSelection);
	
	MonkeyQuest_Resize();
	-- we don't have a dropped QUEST_LOG_UPDATE anymore
	MonkeyQuest.m_bNeedRefresh = false;
	MonkeyQuest.m_fTimeSinceRefresh = 0.0;
end

function MonkeyQuest_RefreshQuestItemList()

	local strQuestLogTitleText, strQuestLevel, strQuestTag, isHeader, isCollapsed, isComplete;
	local i;
	local iNumEntries, iNumQuests = GetNumQuestLogEntries();


	MonkeyQuest.m_aQuestItemList = nil;
	MonkeyQuest.m_aQuestItemList = {};

	for i = 1, iNumEntries, 1 do
		-- strQuestLogTitleText		the title text of the quest, may be a header (ex. Wetlands)
		-- strQuestLevel			the level of the quest
		-- strQuestTag				the tag on the quest (ex. COMPLETED)
		strQuestLogTitleText, strQuestLevel, strQuestTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
		
		if (not isHeader) then
			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			SelectQuestLogEntry(i);

			if (GetNumQuestLeaderBoards() > 0) then
				for ii=1, GetNumQuestLeaderBoards(), 1 do
					--local string = getglobal("QuestLogObjective"..ii);
					local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(ii);
					
					MonkeyQuest_AddQuestItemToList(strLeaderBoardText);

				end
			end
		end
	end
end

-- does a decent job of figuring out if the quest objective is an item and if so adds it to the list
function MonkeyQuest_AddQuestItemToList(strLeaderBoardText)
	local i, j, strItemName, iNumItems, iNumNeeded = string.find(strLeaderBoardText, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$");
	
	if (iNumItems == nil) then
		-- not a quest item
		return;
	end

	i, j = string.find(strItemName, MONKEYQUEST_TOOLTIP_SLAIN);

	if (i ~= nil) then
		strItemName = string.sub(strItemName, 1, i - 2);
	end
	
	if (MonkeyQuest.m_aQuestItemList[strItemName] == nil) then
		MonkeyQuest.m_aQuestItemList[strItemName] = {};
	end
	
	MonkeyQuest.m_aQuestItemList[strItemName].m_iNumItems = iNumItems;
	MonkeyQuest.m_aQuestItemList[strItemName].m_iNumNeeded = iNumNeeded;
end

function MonkeyQuest_Resize()
	
	local iHeight = 0;
	local text;
	local button;
	local iTextWidth = 0;
	local iPadding = MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iQuestPadding;

	
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	--iTextWidth = MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameWidth - MONKEYQUEST_PADDING - 8;
	iTextWidth = MonkeyQuestFrame:GetWidth() - MONKEYQUEST_PADDING - 8;

	-- make sure the titlebutton is the right size for the title text
	MonkeyQuestTitleButton:SetWidth(MonkeyQuestTitleText:GetWidth());
	MonkeyQuestTitleButton:SetHeight(MonkeyQuestTitleText:GetHeight());

	for i = 1, MonkeyQuest.m_iNumQuestButtons, 1 do
		text = getglobal("MonkeyQuestButton" .. i .. "Text");
		button = getglobal("MonkeyQuestButton" .. i);
		
		if (text:IsVisible()) then
			text:SetWidth(iTextWidth);

			iHeight = iHeight + text:GetHeight() + iPadding;
			
			button:SetWidth(text:GetWidth());
			button:SetHeight(text:GetHeight());
		end
	end

	iHeight = iHeight + MonkeyQuestTitleText:GetHeight() + MONKEYQUEST_PADDING;
	
	--MonkeyQuestFrame:SetWidth(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameWidth);
	MonkeyQuestFrame:SetHeight(iHeight);
	
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft = 500;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameTop == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameTop = 500;
	end
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameBottom == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameBottom = 539;
	end
	


	-- Set the grow direction
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB == false) then
		-- Added by Diungo
		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bGrowUp == false) then
			MonkeyQuestFrame:ClearAllPoints();
			-- grow down
			MonkeyQuestFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft,
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameTop);
	
			-- check to see if it grew off the screen
			--if (MonkeyQuestFrame:GetBottom() < 0) then
			--	MonkeyQuestFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",
			--	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft,
			--	MonkeyQuestFrame:GetHeight() - 2);
			--end
		else
			MonkeyQuestFrame:ClearAllPoints();
			-- grow up
			MonkeyQuestFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT",
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft,
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameBottom);
	
			-- check to see if it grew off the screen
			--if (MonkeyQuestFrame:GetTop() > 1024) then
			--	MonkeyQuestFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT",
			--	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft,
			--	1024 - (MonkeyQuestFrame:GetHeight() - 2));
			--end
		end
	end

	-- save the position
	if (MonkeyQuestFrame:GetLeft() ~= nil) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft = MonkeyQuestFrame:GetLeft();
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameTop = MonkeyQuestFrame:GetTop();
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameBottom = MonkeyQuestFrame:GetBottom();
	end
end

-- Get a colour for the leaderboard item depending on how "done" it is
function MonkeyQuest_GetLeaderboardColorStr(strText)
	local i, j, strItemName, iNumItems, iNumNeeded = string.find(strText, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$");
	local colour = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourInitial = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourMid = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourComplete = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};

	colourInitial.a, colourInitial.r, colourInitial.g, colourInitial.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strInitialObjectiveColour);
	colourMid.a, colourMid.r, colourMid.g, colourMid.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strMidObjectiveColour);
	colourComplete.a, colourComplete.r, colourComplete.g, colourComplete.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strCompleteObjectiveColour);

	local colourDelta1 = {
		a = (colourMid.a - colourInitial.a),
		r = (colourMid.r - colourInitial.r),
		g = (colourMid.g - colourInitial.g),
		b = (colourMid.b - colourInitial.b)
		};

	local colourDelta2 = {
		a = (colourComplete.a - colourMid.a),
		r = (colourComplete.r - colourMid.r),
		g = (colourComplete.g - colourMid.g),
		b = (colourComplete.b - colourMid.b)
		};

	if (iNumItems ~= nil) then
		-- standard x/y type objective

		if ((iNumItems / iNumNeeded) < 0.5) then
			colour.r = colourInitial.r + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.r);
			colour.g = colourInitial.g + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.g);
			colour.b = colourInitial.b + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.b);
		else
			colour.r = colourMid.r + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.r);
			colour.g = colourMid.g + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.g);
			colour.b = colourMid.b + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.b);
		end
	else
		-- it's a quest with no numerical objectives
		local i, j, strItemName, strItems, strNeeded = string.find(strText, "(.*):%s*([-%a]+)%s*/%s*([-%a]+)%s*$");

		-- is it a string/string type?
		if (strItems ~= nil) then
			if (strItems == strNeeded) then
				-- strings are equal, completed objective
				return MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strCompleteObjectiveColour;
			else
				-- strings are not equal, uncompleted objective
				return MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strInitialObjectiveColour;
			end
		else
			-- special objective
			return MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strSpecialObjectiveColour;
		end
	end

	-- just incase the numbers went slightly out of range
	if (colour.r > 1.0) then
		colour.r = 1.0;
	end
	if (colour.g > 1.0) then
		colour.g = 1.0;
	end
	if (colour.b > 1.0) then
		colour.b = 1.0;
	end
	if (colour.r < 0.0) then
		colour.r = 0.0;
	end
	if (colour.g < 0.0) then
		colour.g = 0.0;
	end
	if (colour.b < 0.0) then
		colour.b = 0.0;
	end

	return MonkeyLib_ARGBToColourStr(colour.a, colour.r, colour.g, colour.b);
end

-- Get a colour for the leaderboard item depending on how "done" it is
function MonkeyQuest_GetCompletenessColorStr(iNumItems, iNumNeeded)
	local colour = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourInitial = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourMid = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourComplete = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};

	colourInitial.a, colourInitial.r, colourInitial.g, colourInitial.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strInitialObjectiveColour);
	colourMid.a, colourMid.r, colourMid.g, colourMid.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strMidObjectiveColour);
	colourComplete.a, colourComplete.r, colourComplete.g, colourComplete.b = MonkeyLib_ColourStrToARGB(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strCompleteObjectiveColour);

	local colourDelta1 = {
		a = (colourMid.a - colourInitial.a),
		r = (colourMid.r - colourInitial.r),
		g = (colourMid.g - colourInitial.g),
		b = (colourMid.b - colourInitial.b)
		};

	local colourDelta2 = {
		a = (colourComplete.a - colourMid.a),
		r = (colourComplete.r - colourMid.r),
		g = (colourComplete.g - colourMid.g),
		b = (colourComplete.b - colourMid.b)
		};

	if (iNumItems ~= nil) then
		-- standard x/y type objective

		if ((iNumItems / iNumNeeded) < 0.5) then
			colour.r = colourInitial.r + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.r);
			colour.g = colourInitial.g + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.g);
			colour.b = colourInitial.b + ((iNumItems / (iNumNeeded / 2)) * colourDelta1.b);
		else
			colour.r = colourMid.r + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.r);
			colour.g = colourMid.g + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.g);
			colour.b = colourMid.b + (((iNumItems - (iNumNeeded / 2)) / (iNumNeeded / 2)) * colourDelta2.b);
		end
	else
		-- it's a quest with no numerical objectives
		local i, j, strItemName, strItems, strNeeded = string.find(strText, "(.*):%s*([-%a]+)%s*/%s*([-%a]+)%s*$");

		-- is it a string/string type?
		if (strItems ~= nil) then
			if (strItems == strNeeded) then
				-- strings are equal, completed objective
				return MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strCompleteObjectiveColour;
			else
				-- strings are not equal, uncompleted objective
				return MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strInitialObjectiveColour;
			end
		else
			-- special objective
			return MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strSpecialObjectiveColour;
		end
	end

	-- just incase the numbers went slightly out of range
	if (colour.r > 1.0) then
		colour.r = 1.0;
	end
	if (colour.g > 1.0) then
		colour.g = 1.0;
	end
	if (colour.b > 1.0) then
		colour.b = 1.0;
	end
	if (colour.r < 0.0) then
		colour.r = 0.0;
	end
	if (colour.g < 0.0) then
		colour.g = 0.0;
	end
	if (colour.b < 0.0) then
		colour.b = 0.0;
	end

	return colour.a, colour.r, colour.g, colour.b;
end

-- when the mouse goes over the main frame, this gets called
function MonkeyQuestTitle_OnEnter()
	-- noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNoobTips == true) then

		-- put the tool tip in the specified position
		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "DEFAULT") then
			GameTooltip_SetDefaultAnchor(GameTooltip, this);
		else
			GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor);
		end
	
		-- set the tool tip text
		GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_TITLE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	
		GameTooltip:Show();

		return;
	end

	-- put the tool tip in the default position
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	
	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_TITLE_VERSION, MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_DESCRIPTION, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1);
	GameTooltip:Show();

end

function MonkeyQuestButton_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function MonkeyQuestButton_OnClick(button)

	local strQuestLogTitleText, strQuestLevel, strQuestTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(this.m_iQuestIndex);
	
	
	if (isHeader) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[getglobal("MonkeyQuestHideButton" .. this.id).m_strQuestLogTitleText].m_bChecked = 
			not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[getglobal("MonkeyQuestHideButton" .. this.id).m_strQuestLogTitleText].m_bChecked;
		
		MonkeyQuest_Refresh();
		MonkeyQuestFrame:Show();
		MonkeyQuest_Refresh();

		return;
	end
	
	-- print text to the chat edit frame if shift is down and the 
	-- chat frame edit box is open and it's not a zone header
	if (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
		-- what button was it?
		if (button == "LeftButton") then
			if (strQuestTag == ELITE) then
				ChatFrameEditBox:Insert("[" .. strQuestLevel .. "+] " .. strQuestLogTitleText .. " ");
				
			elseif (strQuestTag == MONKEYQUEST_DUNGEON) then
				ChatFrameEditBox:Insert("[" .. strQuestLevel .. "d] " .. strQuestLogTitleText .. " ");
				
			elseif (strQuestTag == RAID) then
				ChatFrameEditBox:Insert("[" .. strQuestLevel .. "r] " .. strQuestLogTitleText .. " ");
			
			elseif (strQuestTag == MONKEYQUEST_PVP) then
				ChatFrameEditBox:Insert("[" .. strQuestLevel .. "p] " .. strQuestLogTitleText .. " ");
				
			else
				ChatFrameEditBox:Insert("[" .. strQuestLevel .. "] " .. strQuestLogTitleText .. " ");
				
			end
		else
			local strChatObjectives = "";

			-- Remember the currently selected quest log entry
			local tmpQuestLogSelection = GetQuestLogSelection();

			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			SelectQuestLogEntry(this.m_iQuestIndex);

			if (GetNumQuestLeaderBoards() > 0) then
				for i=1, GetNumQuestLeaderBoards(), 1 do
					--local string = getglobal("QuestLogObjective"..ii);
					local strLeaderBoardText, strType, iFinished = GetQuestLogLeaderBoard(i);
					
					if (strLeaderBoardText) then
						strChatObjectives = strChatObjectives .. "{" .. strLeaderBoardText .. "} ";
					end
				end
			elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bObjectives) then
				-- this quest has no leaderboard so display the objective instead if the config is set
				local strQuestDescription, strQuestObjectives = GetQuestLogQuestText();

				strChatObjectives = strChatObjectives .. "{" .. strQuestObjectives .. "} ";
			end

			ChatFrameEditBox:Insert(strChatObjectives);

			-- Restore the currently selected quest log entry
			SelectQuestLogEntry(tmpQuestLogSelection);

		end

		-- the user isn't trying to actually open the real quest log, so just exit here
		return;
	end

	if (IsControlKeyDown()) then
		-- what button was it?
		if (button == "LeftButton") then
			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			SelectQuestLogEntry(this.m_iQuestIndex);
			
			-- try and share this quest with party members
			if (GetQuestLogPushable() and GetNumPartyMembers() > 0) then
				QuestLogPushQuest();
			end
			
		else
			-- Remember the currently selected quest log entry
			--local tmpQuestLogSelection = GetQuestLogSelection();

			-- Select the quest log entry for other functions like GetNumQuestLeaderBoards()
			SelectQuestLogEntry(this.m_iQuestIndex);
			
			SetAbandonQuest();
			StaticPopup_Show("ABANDON_QUEST", GetAbandonQuestName());
			
			-- Restore the currently selected quest log entry
			--SelectQuestLogEntry(tmpQuestLogSelection);
		end

		-- the user isn't trying to actually open the real quest log, so just exit here
		return;
	end
	
	-- if MonkeyQuestLog is installed, open that instead
	if (MkQL_SetQuest ~= nil) then
		if (MkQL_Main_Frame:IsVisible()) then
			if (MkQL_global_iCurrQuest == this.m_iQuestIndex) then
				MkQL_Main_Frame:Hide();
				return;
			end
		end
		MkQL_SetQuest(this.m_iQuestIndex);
		return;
	end

	-- show the real questlog
	ShowUIPanel(QuestLogFrame);
	
	-- check if there's even a need to mess with the offset
	if (MonkeyQuest.m_iNumEntries > QUESTS_DISPLAYED) then
	
		-- move the real quest log list scrollbar to the correct place
		if (this.m_iQuestIndex < MonkeyQuest.m_iNumEntries - QUESTS_DISPLAYED) then
			FauxScrollFrame_SetOffset(QuestLogListScrollFrame, this.m_iQuestIndex - 1);
			QuestLogListScrollFrameScrollBar:SetValue((this.m_iQuestIndex - 1) * QUESTLOG_QUEST_HEIGHT);
		else
			FauxScrollFrame_SetOffset(QuestLogListScrollFrame, MonkeyQuest.m_iNumEntries - QUESTS_DISPLAYED);
			QuestLogListScrollFrameScrollBar:SetValue((MonkeyQuest.m_iNumEntries - QUESTS_DISPLAYED) * QUESTLOG_QUEST_HEIGHT);
		end
	end

	-- actually select the quest entry
	SelectQuestLogEntry(this.m_iQuestIndex);
	QuestLog_SetSelection(this.m_iQuestIndex);

	-- update the real quest log
	QuestLog_Update();
	
	
	-- if MonkeyQuestLog is installed, open that instead
end

function MonkeyQuestButton_OnEnter()
	
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "NONE") then
		return;
	end

	local strQuestLogTitleText, strQuestLevel, strQuestTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(this.m_iQuestIndex);

	if (strQuestLogTitleText == nil) then
		return;
	end

	if (isHeader) then
		-- no noob tip?
		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNoobTips == false) then
			return;
		end
		
		-- put the tool tip in the specified position
		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "DEFAULT") then
			GameTooltip_SetDefaultAnchor(GameTooltip, this);
		else
			GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor);
		end
	
		-- set the tool tip text
		GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
		GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_QUESTHEADER, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	
		GameTooltip:Show();
		return;
	end
	
	-- put the tool tip in the specified position
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "DEFAULT") then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
	else
		GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor);
	end

	-- set the tool tip text
	GameTooltip:SetText(strQuestLogTitleText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	GameTooltip:AddLine(this.m_strQuestObjectives, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1);
	GameTooltip:AddLine(strQuestTag, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	
	
	-- see if any nearby group mates are on this quest
	local iNumPartyMembers = GetNumPartyMembers();
	local isOnQuest, i;
	
	for i = 1, iNumPartyMembers do
		isOnQuest = IsUnitOnQuest(this.m_iQuestIndex, "party" .. i);
		
		if (isOnQuest and isOnQuest == 1) then
			-- this member is on the quest
			GameTooltip:AddLine(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strCompleteObjectiveColour .. UnitName("party" .. i));
		else
			-- this member isn't on the quest
			GameTooltip:AddLine(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strInitialObjectiveColour .. UnitName("party" .. i));
		end
	end
	
	GameTooltip:Show();
end

function MonkeyQuestHideButton_OnLoad()

end

function MonkeyQuestHideButton_OnEnter()
	-- no noob tip?
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNoobTips == false) then
		return;
	end
	
	-- put the tool tip in the specified position
	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "DEFAULT") then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
	else
		GameTooltip:SetOwner(MonkeyQuestFrame, MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor);
	end

	-- set the tool tip text
	GameTooltip:SetText(MONKEYQUEST_NOOBTIP_HEADER, TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1);
	GameTooltip:AddLine(MONKEYQUEST_NOOBTIP_HIDEBUTTON, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);

	GameTooltip:Show();

end

function MonkeyQuestHideButton_OnClick()
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (this:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
		
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[this.m_strQuestLogTitleText].m_bChecked = true;
		
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_aQuestList[this.m_strQuestLogTitleText].m_bChecked = false;
	end

	MonkeyQuest_Refresh();
	MonkeyQuestFrame:Show();
	MonkeyQuest_Refresh();
end

function MonkeyQuest_PrintPoints()
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Left: "..MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameLeft);
		DEFAULT_CHAT_FRAME:AddMessage("Top: "..MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameTop);
		DEFAULT_CHAT_FRAME:AddMessage("Bottom: "..MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameBottom);
	end
end
