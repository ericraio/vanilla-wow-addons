--
-- MI2_Config.lua
--
-- Configuration dialog related module of the MobInfo2 AddOn
--

-----------------------------------------------------------------------------
-- MI2_OptionsFrameOnLoad()
--
-- This "OnLoad" event handler for the options dialog installs the
-- ESC key handler.
-----------------------------------------------------------------------------
function MI2_OptionsFrameOnLoad()
	tinsert(UISpecialFrames, "frmMIConfig") -- Esc Closes Options Frame
	UIPanelWindows["frmMIConfig"] = {area = "center", pushable = 0}

	PanelTemplates_SetNumTabs( MI2_MainOptionsFrame, 4 )
	MI2_MainOptionsFrame.selectedTab = 1
	PanelTemplates_UpdateTabs( MI2_MainOptionsFrame )
	PanelTemplates_SetNumTabs( MI2_SearchResultFrame, 2 )
	MI2_SearchResultFrame.selectedTab = 1
	PanelTemplates_UpdateTabs( MI2_SearchResultFrame )
	
	MI2_OptDisableMobInfoText:SetTextColor( 1.0, 1.0, 1.0 )

	MI2_OptHealthPosX:SetMinMaxValues( -50, 50 )
	MI2_OptHealthPosY:SetMinMaxValues( -40, 80 )
	MI2_OptManaPosX:SetMinMaxValues( -50, 50 )
	MI2_OptManaPosY:SetMinMaxValues( -40, 80 )
	MI2_OptTargetFontSize:SetMinMaxValues( 6, 20 )
end  -- MI2_OptionsFrameOnLoad()


-----------------------------------------------------------------------------
-- MI2_SetHealthOptionsState()
--
-- Set the state of health options in health options dialog to either
-- enabled or disabled, as indicated by "MobInfoConfig.DisableHealth".
-----------------------------------------------------------------------------
function MI2_SetHealthOptionsState()
	local r,g,b

	if  MobInfoConfig.DisableHealth == 2  then
		MI2_MobHealthFrame:Hide()
	end
end  -- of MI2_SetHealthOptionsState()


-----------------------------------------------------------------------------
-- MI2_UpdateOptions()
--
-- Update state of all options in options dialog with correct values from
-- data structure "MobInfoConfig".
-----------------------------------------------------------------------------
function MI2_UpdateOptions()
	for index, value in MI2_OPTIONS do
		local option = string.sub( index, 8 )
		--DEFAULT_CHAT_FRAME:AddMessage( "MI_DBG: index="..index..", cmnd="..value.cmnd..", opt="..option )
		if  MobInfoConfig[option]  then
			if value.dd then
				-- do nothing for dropdowns
			elseif value.val then
				getglobal(index):SetValue( MobInfoConfig[option] )
			elseif value.txt then
				getglobal(index):SetText( MobInfoConfig[option] )
			else
				getglobal(index):SetChecked( MobInfoConfig[option] )
			end
		end
	end
end  -- MI2_UpdateOptions()


-----------------------------------------------------------------------------
-- MI2_ShowOptionHelpTooltip()
--
-- Show help text for current hovered option in options dialog
-- in the game tooltip window.
-----------------------------------------------------------------------------
function MI2_ShowOptionHelpTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
	GameTooltip:SetText( mifontWhite..MI2_OPTIONS[this:GetName()].text )
	  
	GameTooltip:AddLine(mifontGold..MI2_OPTIONS[this:GetName()].help)
	if MI2_OPTIONS[this:GetName()].info then
		GameTooltip:AddLine(mifontGold..MI2_OPTIONS[this:GetName()].info)
	end
	GameTooltip:Show()
end -- of MI2_ShowOptionHelpTooltip()


-----------------------------------------------------------------------------
-- MI2_OptionsFrameOnShow()
--
-- Show help text for current hovered option in options dialog
-- in the game tooltip window.
-----------------------------------------------------------------------------
function MI2_OptionsFrameOnShow()
	txtMIConfigTitle:SetText( MI_TXT_CONFIG_TITLE )
	MI2_UpdateOptions()
end  -- MI2_OptionsFrameOnShow()


function miConfig_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		frmMIConfig:StartMoving()
	end
end


function miConfig_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		frmMIConfig:StopMovingOrSizing()
	end
end


function miConfig_btnMIDone_OnClick()
	HideUIPanel(frmMIConfig)
	if MYADDONS_ACTIVE_OPTIONSFRAME then
		if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
			ShowUIPanel(myAddOnsFrame)
		end
	end
end

-----------------------------------------------------------------------------
-- MI2_TabButton_OnClick()
--
-- Event handler: one of the options dialog TABs has been clicked.
-- Show the corresponding options frame and hide all other option frames.
-----------------------------------------------------------------------------
function MI2_TabButton_OnClick( )
	PanelTemplates_Tab_OnClick( MI2_MainOptionsFrame )
	local selected = MI2_MainOptionsFrame.selectedTab
	  
	-- choose special information frame if mob health has been disabled
	local healthFrame = MI2_FrmHealthOptions
	if  MobInfoConfig.DisableHealth ~= 0  then
		healthFrame = MI2_FrmHealthDisabledInfo
	end

	if  selected == 1  then
		MI2_FrmTooltipOptions:Show()
	else
		MI2_FrmTooltipOptions:Hide()
	end

	if  selected == 2  then
		healthFrame:Show()
	else
		healthFrame:Hide()
	end

	if  selected == 3  then
		MI2_FrmDatabaseOptions:Show()
	else
		MI2_FrmDatabaseOptions:Hide()
	end

	if  selected == 4  then
		MI2_FrmSearchOptions:Show()
	else
		MI2_FrmSearchOptions:Hide()
	end
end


-----------------------------------------------------------------------------
-- MI2_OptTargetFont_OnClick()
--
-- Event handler: one of the choices in the font selection box has been
-- clicked. Store it as a config option.
-----------------------------------------------------------------------------
function MI2_OptTargetFont_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID( MI2_OptTargetFont )
	UIDropDownMenu_SetSelectedID( MI2_OptTargetFont, this:GetID())
	if  oldID ~= this:GetID()  then
		MobInfoConfig.TargetFont = this:GetID()
		MI2_MobHealth_SetPos()
	end
end  -- MI2_OptTargetFont_OnClick()


-----------------------------------------------------------------------------
-- MI2_OptItemsQuality_OnClick()
--
-- Event handler: one of the choices in the font selection box has been
-- clicked. Store it as a config option.
-----------------------------------------------------------------------------
function MI2_OptItemsQuality_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID( MI2_OptItemsQuality )
	UIDropDownMenu_SetSelectedID( MI2_OptItemsQuality, this:GetID())
	if  oldID ~= this:GetID()  then
		MobInfoConfig.ItemsQuality = this:GetID()
	end
end  -- MI2_OptItemsQuality_OnClick()


-----------------------------------------------------------------------------
-- MI2_DropDown_Initialize()
--
-- Initialize a dropdown list with entries that are retrieved from the
-- localization info.
-----------------------------------------------------------------------------
function MI2_DropDown_Initialize()
	if string.sub(this:GetName(),-6) ~= "Button" then return end
	
	local dropDownName = string.sub(this:GetName(),1,-7)
	local choice = MI2_OPTIONS[dropDownName].choice1
	local count = 1

	while choice do
		local info = { text = choice, value = count, func = getglobal(dropDownName.."_OnClick") }
		UIDropDownMenu_AddButton( info )
		count = count + 1
		choice = MI2_OPTIONS[dropDownName]["choice"..count] 
	end
end  -- MI2_DropDown_Initialize()


-----------------------------------------------------------------------------
-- MI2_OptItemsQuality_OnShow()
--
-- Event handler: show a drop down list
-- Ensure that current selection is shown correctly.
-----------------------------------------------------------------------------
function MI2_DropDown_OnShow()
	local frameName = this:GetName()
	local itemName = string.sub(frameName, 8)
	local text = MI2_OPTIONS[frameName]["choice"..MobInfoConfig[itemName]]

	UIDropDownMenu_SetSelectedID( this, MobInfoConfig[itemName] )
	UIDropDownMenu_SetText( text, this ) 
end  -- MI2_OptItemsQuality_OnShow()


-----------------------------------------------------------------------------
-- MI2_DbOptionsFrameOnShow()
--
-----------------------------------------------------------------------------
function MI2_DbOptionsFrameOnShow()
	local mobDbSize, healthDbSize, playerDbSize, itemDbSize = 0, 0, 0, 0

	-- count and diplay size of MobInfo database
	for index in MobInfoDB do  mobDbSize = mobDbSize + 1  end
	MI2_TxtMobDbSize:SetText( MI_TXT_MOB_DB_SIZE..mifontWhite..(mobDbSize-1) )

	-- count and diplay size of MobHealth database
	for index in MobHealthDB do  healthDbSize = healthDbSize + 1  end
	MI2_TxtHealthDbSize:SetText( MI_TXT_HEALTH_DB_SIZE..mifontWhite..healthDbSize )

	-- count and diplay size of MobHealthPlayer database
	for index in MobHealthPlayerDB do  playerDbSize = playerDbSize + 1  end
	MI2_TxtPlayerDbSize:SetText( MI_TXT_PLAYER_DB_SIZE..mifontWhite..playerDbSize )

	-- count and diplay size of MI2_ItemNameTable database
--	for  index in MI2_ItemNameTable  do  itemDbSize = itemDbSize + 1  end
--	MI2_TxtItemDbSize:SetText( MI_TXT_ITEM_DB_SIZE..mifontWhite..itemDbSize )

	-- update mob index display and state of "clear mob" button
	if MI2_Target.mobIndex and MobInfoDB[MI2_Target.mobIndex] then
		MI2_OptClearTarget:Enable()
		MI2_TxtTargetIndex:SetText( MI_TXT_CUR_TARGET..mifontWhite..MI2_Target.mobIndex )
	else
		MI2_OptClearTarget:Disable()
		MI2_TxtTargetIndex:SetText( MI_TXT_CUR_TARGET..mifontWhite.."---" )
	end

	-- update import status
	if MI2_Import_Status then
		if MobInfoConfig.ImportSignature == MI2_Import_Signature then
			MI2_OptImportMobData:Disable()
			MI2_TxtImportStatus:SetText( "Status: <data already imported ("..MI2_Import_Status..")>" )
		elseif MI2_Import_Status == "BADVER" then
			MI2_OptImportMobData:Disable()
			MI2_TxtImportStatus:SetText( "Status: <import database too old>" )
		else
			MI2_OptImportMobData:Enable()
			MI2_TxtImportStatus:SetText( "Status: "..MI2_Import_Status.." available for import" )
		end
	else
		MI2_OptImportMobData:Disable()
		MI2_TxtImportStatus:SetText( "Status: <no import data>" )
	end
end  -- MI2_DbOptionsFrameOnShow()
